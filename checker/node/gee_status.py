"""Checks for gee:status validity.

gee:status specifies whether a dataset is not completely active.

Requirements and specification:
- If the node is a catalog, it cannot have the field.
- If the field is set, its value must be one of several enum values.
"""
import functools
import json
import os
import subprocess
from typing import Iterator

from absl import logging

from checker import stac


@functools.lru_cache(maxsize=1)
def get_added_jsonnet_files():
  """Returns the list of newly added .jsonnet files in the PR."""

  # Only run in GitHub Actions events
  if os.environ.get('GITHUB_ACTIONS') != 'true':
    return []

  event_name = os.environ.get('GITHUB_EVENT_NAME')
  if event_name not in ['pull_request', 'push']:
    logging.info('Skipping event %s', event_name)
    return []

  if 'copybara' in os.environ.get('GITHUB_ACTOR'):
    return []

  if event_name == 'push':
    result = subprocess.run(
        [
            'git',
            'show',
            '--name-only',
            '--diff-filter=A',
            '--pretty=format:',
            'HEAD',
        ],
        capture_output=True,
        text=True,
        check=True,
    )

    if result.returncode != 0:
      logging.error('Failed to get PR files: %s', result)
      return []
    files = result.stdout.strip().split('\n') if result.stdout.strip() else []
    return [f for f in files if f.endswith('.jsonnet')]
  elif event_name == 'pull_request':
    github_ref = os.environ.get('GITHUB_REF', '')
    if not github_ref.startswith('refs/pull/'):
      return []

    pr_number = github_ref.split('/')[2]
    repo = os.environ.get('GITHUB_REPOSITORY')

    env = os.environ.copy()
    # Requires the token var to be set in ci.yml
    env['GH_TOKEN'] = os.environ.get('GITHUB_TOKEN', '')

    result = subprocess.run(
        ['gh', 'api', f'repos/{repo}/pulls/{pr_number}/files'],
        capture_output=True,
        check=True,
        text=True,
        env=env,
    )

    if result.returncode != 0:
      logging.error('Failed to get PR files: %s', result)
      return []

    files = json.loads(result.stdout)
    return [
        f['filename']
        for f in files
        if f['status'] == 'added' and f['filename'].endswith('.jsonnet')
    ]
  else:
    logging.info('Unsupported event type: %s', event_name)
    return []


class Check(stac.NodeCheck):
  """Checks for gee:status."""
  name = 'gee_status'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.type == stac.StacType.CATALOG:
      if stac.GEE_STATUS in node.stac:
        yield cls.new_issue(
            node, f'Catalogs may not have a {stac.GEE_STATUS} field'
        )
    elif node.type == stac.StacType.COLLECTION:
      field_value = node.stac.get(stac.GEE_STATUS, stac.Status.READY)
      if field_value not in stac.Status.allowed_statuses():
        yield cls.new_issue(
            node,
            f'{stac.GEE_STATUS}, if set, must be one of'
            f' {sorted(stac.Status.allowed_statuses())}',
        )
      elif field_value in [stac.Status.READY, stac.Status.DEPRECATED]:
        jsonnet_basename = node.id.replace('/', '_') + '.jsonnet'
        if any(
            x.endswith('/' + jsonnet_basename)
            for x in get_added_jsonnet_files()
        ):
          yield cls.new_issue(
              node, 'For new datasets, set "gee:status" to "beta"'
          )

"""Checks for gee:status validity.

gee:status specifies whether a dataset is not completely active.

Requirements and specification:
- If the node is a catalog, it cannot have the field.
- If the field is set, its value must be one of several enum values.
"""

import os
import subprocess
import json
from typing import Iterator

from absl import logging
from checker import stac

def get_added_jsonnet_files():
    """Returns list of newly added .jsonnet files in the PR, empty list otherwise."""
    
    # Only works in GitHub Actions pull_request events
    if os.environ.get('GITHUB_ACTIONS') != 'true':
        return []
    
    if os.environ.get('GITHUB_EVENT_NAME') != 'pull_request':
        return []  # Not a PR, skip
    
    # Skip for copybara sync PRs
    if os.environ.get('GITHUB_ACTOR') == 'copybara-service[bot]':
        return []  # Skip internal Google syncs
    
    # Extract PR number from GITHUB_REF (format: refs/pull/123/merge)
    github_ref = os.environ.get('GITHUB_REF', '')
    if not github_ref.startswith('refs/pull/'):
        return []
    
    pr_number = github_ref.split('/')[2]
    repo = os.environ.get('GITHUB_REPOSITORY')  # e.g., 'google/earthengine-catalog'
    
    # Call GitHub API using gh CLI
    env = os.environ.copy()
    env['GH_TOKEN'] = os.environ.get('GITHUB_TOKEN', '')
    
    result = subprocess.run(
        ['gh', 'api', f'repos/{repo}/pulls/{pr_number}/files'],
        capture_output=True, 
        text=True,
        env=env
    )
    
    if result.returncode != 0:
        logging.error(f"Failed to get PR files: {result.stderr}")
        return []
    
    files = json.loads(result.stdout)
    
    # Filter for only ADDED .jsonnet files
    added_jsonnet_files = [
        f['filename'] 
        for f in files 
        if f['status'] == 'added' and f['filename'].endswith('.jsonnet')
    ]
    
    return added_jsonnet_files

class Check(stac.NodeCheck):
  """Checks for gee:status."""
  name = 'gee_status'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    logging.info('Added files: %s', get_added_jsonnet_files())
    if os.environ.get('GITHUB_ACTIONS') == 'true':
      logging.info('Running in GitHub Actions')
    else:
      logging.info('Running outside of GitHub Actions')
    event_path = os.environ.get('GITHUB_EVENT_PATH')
    if event_path:
      logging.info('GITHUB_EVENT_PATH: %s', event_path)
    else:
      logging.info('No GITHUB_EVENT_PATH')

    if stac.GEE_STATUS in node.stac:
      if node.type == stac.StacType.CATALOG:
        yield cls.new_issue(
            node, f'Catalogs may not have a {stac.GEE_STATUS} field'
        )
      elif node.type == stac.StacType.COLLECTION:
        field_value = node.stac.get(stac.GEE_STATUS)
        if field_value not in stac.Status.allowed_statuses():
          yield cls.new_issue(
              node,
              f'{stac.GEE_STATUS}, if set, must be one of'
              f' {sorted(stac.Status.allowed_statuses())}',
          )

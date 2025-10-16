"""Checks for gee:status validity.

gee:status specifies whether a dataset is not completely active.

Requirements and specification:
- If the node is a catalog, it cannot have the field.
- If the field is set, its value must be one of several enum values.
"""

import os
from typing import Iterator

from absl import logging
from checker import stac


class Check(stac.NodeCheck):
  """Checks for gee:status."""
  name = 'gee_status'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    # TODO(simonf): add a github-only check that new datasets
    # must have status 'incompete' or 'beta'
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

"""Check for the stac version.

Every STAC node must have a top level "stac_version" field that is set to 1.0.0.

https://github.com/radiantearth/stac-spec/blob/master/package.json

https://github.com/radiantearth/stac-spec/blob/master/best-practices.md#how-to-differentiate-stac-files
https://github.com/radiantearth/stac-spec/blob/master/catalog-spec/catalog-spec.md#stac_version
https://github.com/radiantearth/stac-spec/blob/master/collection-spec/collection-spec.md#stac_version
"""
from typing import Iterator

from checker import stac

STAC_VERSION = '1.0.0'
STAC_VERSION_FIELD = 'stac_version'


class Check(stac.NodeCheck):
  """Checks the stac_version field."""
  name = 'stac_version'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if STAC_VERSION_FIELD not in node.stac:
      yield cls.new_issue(node, f'Missing: {STAC_VERSION_FIELD}')
      return  # Cannot proceed.

    stac_version = node.stac[STAC_VERSION_FIELD]
    if stac_version != STAC_VERSION:
      yield cls.new_issue(
          node, f'Unexpected stac_version: {stac_version} != {STAC_VERSION}')

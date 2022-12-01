"""Checks for gee_provider_ids.

This is an experimental field for storing provider-specified dataset
ids (currently only NASA CMR ids).

These provider ids are used for downloading data from
NASA's [Common Metadata Repository (CMR)](https://cmr.earthdata.nasa.gov).
The ids are also referred to as 'concept ids'.

Requirements:
- top-level field
- a list of one or more strings
- can only be for one of the allowed prefixes such as 'MODIS'

Example of using a provider id:

https://cmr.earthdata.nasa.gov/search/concepts/C1000000240-LPDAAC_ECS.html

See also:

- https://cmr.earthdata.nasa.gov/stac
- https://radiantearth.github.io/stac-browser/#/external/cmr.earthdata.nasa.gov/stac
"""

import re
from typing import Iterator

from checker import stac

GEE_PROVIDER_IDS = 'gee:provider_ids'


class Check(stac.NodeCheck):
  """Checks the gee:provider_ids field."""
  name = 'gee_provider_ids'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.type == stac.StacType.CATALOG:
      if GEE_PROVIDER_IDS in node.stac:
        yield cls.new_issue(
            node, f'{stac.StacType.CATALOG} cannot have {GEE_PROVIDER_IDS}')
      return

    if GEE_PROVIDER_IDS not in node.stac:
      return

    provider_ids = node.stac[GEE_PROVIDER_IDS]
    if not isinstance(provider_ids, list):
      yield cls.new_issue(node, f'{GEE_PROVIDER_IDS} must be a list')
      return

    if not provider_ids:
      yield cls.new_issue(node, f'{GEE_PROVIDER_IDS} cannot be empty')
      return

    for provider_id in provider_ids:
      if not isinstance(provider_id, str):
        yield cls.new_issue(node, 'provider_id must be a str')
        continue
      if not re.fullmatch(r'[A-Z0-9]+-[A-Z0-9][A-Z0-9_]+', provider_id):
        yield cls.new_issue(node, f'provider_id not valid: "{provider_id}"')

    if sorted(provider_ids) != provider_ids:
      yield cls.new_issue(node, f'{GEE_PROVIDER_IDS} must be sorted')

    if len(provider_ids) != len(set(provider_ids)):
      yield cls.new_issue(node, f'{GEE_PROVIDER_IDS} cannot have duplicates')

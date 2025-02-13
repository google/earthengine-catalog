"""Checks for non_commercial datasets.

non_commercial_datasets.jsonnet contains a list of dataset IDs for
datasets that cannot be used for commercial purposes.

Requirements and specification:
- STAC Catalogs cannot be in the list
- If the license is one of the licenses known to restrict commercial use,
  then then dataset must be in the list
- If the license is not one of the known restrictive licenses, then the dataset
  cannot be in the list
"""

from typing import Iterator

from checker import stac

LICENSE = 'license'
NON_COMMERCIAL_LICENSES = frozenset({
    'CC-BY-NC-4.0',
    'CC-BY-NC-SA-4.0',
    'proprietary_non_commercial'
})


class Check(stac.NodeCheck):
  """Checks for non_commercial."""
  name = 'non_commercial'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    non_commercial = stac.is_in_non_commercial(node.id)
    if node.type == stac.StacType.CATALOG:
      if non_commercial:
        yield cls.new_issue(
            node, f'{node.type} cannot be in non-commercial dataset list'
        )
      return

    if LICENSE not in node.stac:
      return
    license_field = node.stac[LICENSE]
    if not isinstance(license_field, str):
      return

    if license_field in NON_COMMERCIAL_LICENSES:
      if not non_commercial:
        yield cls.new_issue(
            node,
            'Dataset with non-commercial license must be listed in '
            'non_commercial_datasets.jsonnet',
        )
    else:
      if non_commercial:
        # Special cases for WCMC/WDOECM, which we did not fully configure as
        # non-commercial but left in the list.
        # TODO: b/363257841 - Remove this special case once new WCMC datasets
        # are added with the correct license.
        if node.id in [
            'WCMC/WDOECM/current/polygons',
            'WCMC/WDOECM/current/points',
        ]:
          return
        yield cls.new_issue(node, 'Cannot be in non-commercial dataset list')

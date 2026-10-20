"""Checks for share_alike datasets.

share_alike_datasets.jsonnet contains a list of dataset ID prefixes for
datasets that have share-alike license requirements.

Requirements and specification:
- STAC Catalogs cannot be in the list
- If the license is one of the licenses known to require share-alike,
  then the dataset must be in the list
- If the license is not one of the known share-alike licenses, then the dataset
  cannot be in the list
"""

from typing import Iterator

from checker import stac

LICENSE = 'license'
SHARE_ALIKE_LICENSES = frozenset({
    'CC-BY-SA-4.0',
    'CC-BY-NC-SA-4.0',
    'ODbL-1.0',
})


class Check(stac.NodeCheck):
  """Checks for share_alike."""

  name = 'share_alike'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    share_alike = stac.is_in_share_alike(node.id)
    if node.type == stac.StacType.CATALOG:
      if share_alike:
        yield cls.new_issue(
            node, f'{node.type} cannot be in share-alike dataset list'
        )
      return

    if LICENSE not in node.stac:
      return
    license_field = node.stac[LICENSE]
    if not isinstance(license_field, str):
      return

    if license_field in SHARE_ALIKE_LICENSES:
      if not share_alike:
        yield cls.new_issue(
            node,
            'Dataset with share-alike license must be listed in '
            'share_alike_datasets.jsonnet',
        )
    else:
      if share_alike:
        yield cls.new_issue(node, 'Cannot be in share-alike dataset list')

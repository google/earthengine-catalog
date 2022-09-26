"""Checks that the license field is valid.

The license field must be a string from spdx.license id values.

We do not currently have an effective way to handle these cases:
- Multiple licenses applying to a dataset
- The option to use one of several licenses to a dataset.

https://github.com/radiantearth/stac-spec/blob/master/collection-spec/collection-spec.md#license
https://github.com/radiantearth/stac-spec/issues/1174
https://github.com/radiantearth/stac-spec/issues/1178
https://github.com/google/earthengine-catalog/blob/main/catalog/spdx.libsonnet
"""

from typing import Iterator

from google3.third_party.earthengine_catalog.checker import stac


LICENSE = 'license'
KNOWN_LICENSES = frozenset({
    'etalab-2.0',
    'proprietary',
    'CC-BY-4.0',
    'CC-BY-NC-4.0',
    'CC-BY-NC-SA-4.0',
    'CC-BY-SA-4.0',
    'CC-PDDC',
    'CC0-1.0',
    'ODbL-1.0',
    'OGL-Canada-2.0',
    'PDDL-1.0',
})


class Check(stac.NodeCheck):
  """Checks the license field."""
  name = 'license'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.type == stac.StacType.CATALOG:
      if LICENSE in node.stac:
        yield cls.new_issue(node, f'Catalogs cannot have "{LICENSE}"')
      return

    if LICENSE not in node.stac:
      yield cls.new_issue(node, f'Collections must have "{LICENSE}"')
      return

    license_field = node.stac[LICENSE]
    if not isinstance(license_field, str):
      yield cls.new_issue(node, f'"{LICENSE}" must be a str')
      return

    if license_field not in KNOWN_LICENSES:
      yield cls.new_issue(node, f'Unknown {LICENSE}: "{license_field}"')

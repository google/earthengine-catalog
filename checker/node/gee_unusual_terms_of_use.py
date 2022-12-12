"""Checks for gee:unusual_terms_of_use.

gee:unusual_terms_of_use is set for licenses that have surprising properties
that might make using the data difficult or now allow for some use cases
or users.

Requirements and specification:
- The field cannot be present in STAC Catalogs
- gee:unusual_terms_of_use is a boolean flag
- gee:unusual_terms_of_use is never present for the false case
- Datasets with licenses that are in the MUST_BE_UNUSUAL will always have
  the flag set to true
- 'proprietary' datasets are those that do not strictly follow an entry in
  https://spdx.org/licenses/.  These datasets might have unusual terms, but
  many do not. For example, public domain datasets are marked 'proprietary',
  but do not have restrictions.
"""

from typing import Iterator

from checker import stac

GEE_UNUSUAL_TERMS_OF_USE = 'gee:unusual_terms_of_use'
LICENSE = 'license'

MUST_BE_UNUSUAL = frozenset({
    'CC-BY-NC-4.0',
    'CC-BY-NC-SA-4.0',
    'CC-BY-SA-4.0',
    'ODbL-1.0',
})
POSSIBLY_UNUSUAL = MUST_BE_UNUSUAL.union({'proprietary'})


class Check(stac.NodeCheck):
  """Checks for gee:unusual_terms_of_use."""
  name = 'gee_unusual_terms_of_use'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    license_field = node.stac.get(LICENSE)

    if GEE_UNUSUAL_TERMS_OF_USE not in node.stac:
      if LICENSE in node.stac:
        if isinstance(license_field, str) and license_field in MUST_BE_UNUSUAL:
          yield cls.new_issue(
              node,
              'dataset has license that is unusual, but missing ' +
              GEE_UNUSUAL_TERMS_OF_USE)
      return

    if node.type == stac.StacType.CATALOG:
      yield cls.new_issue(
          node,
          f'{GEE_UNUSUAL_TERMS_OF_USE} not allowed in {stac.StacType.CATALOG}')
      return

    unusual = node.stac[GEE_UNUSUAL_TERMS_OF_USE]
    if not isinstance(unusual, bool):
      yield cls.new_issue(
          node, f'{GEE_UNUSUAL_TERMS_OF_USE} must be of type bool')

    if not unusual:
      yield cls.new_issue(
          node, f'{GEE_UNUSUAL_TERMS_OF_USE} not allowed when false')
      return

    if not isinstance(license_field, str): return

    if license_field not in POSSIBLY_UNUSUAL:
      yield cls.new_issue(
          node, f'{GEE_UNUSUAL_TERMS_OF_USE} not allowed for {license_field}')

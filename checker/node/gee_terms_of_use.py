"""Checks for gee:terms_of_use.

- For standard SPDX licenses, it should contain the link to the SPDX entry:
  - '[' + license.id + '](' + license.reference + ')'
  - that results in a string like:
    '[CC-BY-4.0](https://spdx.org/licenses/CC-BY-4.0.html)'
- The gee:terms_of_use field is primarily used for STAC Collections that have a
  license field of 'proprietary'.  It should then contain the key text of the
  provider's terms.
- The field must be at least 5 characters long
- The field must be no longer than 2400 characters
- Best practice is to include a link to the the term(s) on the provider's site
"""

from typing import Iterator

from checker import stac

GEE_TERMS_OF_USE = 'gee:terms_of_use'
LICENSE = 'license'


class Check(stac.NodeCheck):
  """Checks the stac_version field."""
  name = 'gee_terms_of_use'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.type == stac.StacType.CATALOG:
      if GEE_TERMS_OF_USE in node.stac:
        yield cls.new_issue(
            node, f'{stac.StacType.CATALOG} cannot have {GEE_TERMS_OF_USE}')
      return

    if GEE_TERMS_OF_USE not in node.stac:
      yield cls.new_issue(
          node, f'{stac.StacType.COLLECTION} must have {GEE_TERMS_OF_USE}')
      return

    terms = node.stac[GEE_TERMS_OF_USE]
    if not isinstance(terms, str):
      yield cls.new_issue(node, f'{GEE_TERMS_OF_USE} must be a str')
      return

    size = len(terms)
    if size < 10:
      yield cls.new_issue(node, f'{GEE_TERMS_OF_USE} is too short: {size}')
    if size > 2400:
      yield cls.new_issue(node, f'{GEE_TERMS_OF_USE} is too long: {size}')

    # TODO(schwehr): if license is not proprietary, then check this text to
    # match the expected results of:
    #   'gee:terms_of_use':  '[' + license.id + '](' + license.reference + ')'

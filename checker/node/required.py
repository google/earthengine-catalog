"""Checks that the required fields are present.

Makes no assertions about what is in these, just that they are present
for every node of that particular type.  The goal is to quickly catch
missing fields when starting on a new STAC Catalog or Collection.
"""

from typing import Iterator

from checker import stac

DESCRIPTION = 'description'
EXTENT = 'extent'
GEE_TERMS_OF_USE = 'gee:terms_of_use'
GEE_TYPE = 'gee:type'
ID = 'id'
KEYWORDS = 'keywords'
LICENSE = 'license'
LINKS = 'links'
PROVIDERS = 'providers'
STAC_VERSION = 'stac_version'
SUMMARIES = 'summaries'
TITLE = 'title'
TYPE = 'type'

CATALOG_FIELDS = frozenset({
    DESCRIPTION, ID, LINKS, STAC_VERSION, TITLE, TYPE})

COLLECTION_FIELDS = frozenset({
    DESCRIPTION, EXTENT, GEE_TERMS_OF_USE, GEE_TYPE, ID, KEYWORDS, LICENSE,
    LINKS, PROVIDERS, STAC_VERSION, SUMMARIES, TITLE, TYPE})


class Check(stac.NodeCheck):
  """Checks the presence of required fields."""
  name = 'required'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    keys = set(node.stac)
    if node.type == stac.StacType.CATALOG:
      diff = sorted(CATALOG_FIELDS.difference(keys))
      if diff:
        yield cls.new_issue(
            node, f'Catalog missing required fields: {", ".join(diff)}')
    else:
      diff = sorted(COLLECTION_FIELDS.difference(keys))
      if diff:
        yield cls.new_issue(
            node, f'Collection missing required fields: {", ".join(diff)}')

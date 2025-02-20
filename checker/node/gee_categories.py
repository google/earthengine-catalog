"""Checks that the "gee:categories" field is valid."""

from typing import Iterator

from checker import stac

# Use dashes, not underscores, as the HTML catalog converts
# underscores to dashes anyway.
CATEGORIES = frozenset([
    'agriculture',
    'atmosphere',
    'climate',
    'cryosphere',
    'ecosystems',
    'elevation-topography',
    'fire',
    'forest-biomass',
    'hydrology',
    'infrastructure-boundaries',
    'landuse-landcover',
    'oceanography',
    'orthophotos',
    'plant-productivity',
    'population',
    'precipitation',
    'satellite-imagery',
    'soil',
    'vegetation-indices',
])

GEE_CATEGORIES = 'gee:categories'


class Check(stac.NodeCheck):
  """Checks the gee:categories field."""

  name = 'gee_categories'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.type == stac.StacType.CATALOG:
      return

    if GEE_CATEGORIES not in node.stac:
      # TODO(b/397988701): require categories when all datasets have them
      # yield cls.new_issue(node, f'Missing {GEE_CATEGORIES}')
      return

    categories = node.stac[GEE_CATEGORIES]
    if not categories:
      yield cls.new_issue(node, f'"{GEE_CATEGORIES}" must not be empty')
      return

    if not isinstance(categories, list):
      yield cls.new_issue(node, f'"{GEE_CATEGORIES}" must be a list of strings')
      return

    extra_categories = set(categories) - CATEGORIES
    for extra in extra_categories:
      yield cls.new_issue(
          node, f'Found unknown category "{extra}" in "{GEE_CATEGORIES}"'
      )

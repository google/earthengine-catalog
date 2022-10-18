"""Check top-level fields.

This check blocks unexpected fields from being placed at the top-level of
a STAC Catalog or STAC Collection.

See also: required.
"""

from typing import Iterator

from checker import stac

CATALOG_ALLOWED_FIELDS = [
    'description', 'gee:skip_indexing', 'id', 'links', 'stac_version',
    'title', 'type']

COLLECTION_ALLOWED_FIELDS = [
    'deprecated', 'description', 'extent', 'gee:extra_dois', 'gee:interval',
    'gee:is_derived', 'gee:min_zoom_level', 'gee:provider_ids',
    'gee:skip_featureview_generation', 'gee:skip_indexing', 'gee:terms_of_use',
    'gee:type', 'gee:unusual_terms_of_use', 'gee:user_owned',
    'gee:user_uploaded', 'id', 'keywords', 'license', 'links', 'providers',
    'sci:citation', 'sci:doi', 'sci:publications', 'stac_extensions',
    'stac_version', 'summaries', 'title', 'type', 'version']


class Check(stac.NodeCheck):
  """Checks top-level fields."""
  name = 'top_level'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.type == stac.StacType.CATALOG:
      for field in node.stac:
        if field not in CATALOG_ALLOWED_FIELDS:
          yield cls.new_issue(node, f'Invalid top-level catalog field: {field}')
    else:
      for field in node.stac:
        if field not in COLLECTION_ALLOWED_FIELDS:
          yield cls.new_issue(
              node, f'Invalid top-level collection field: {field}')

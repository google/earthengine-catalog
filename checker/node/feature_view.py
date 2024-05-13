"""Checks for gee feature_views.

gee:feature_view_ingestion_params triggers generation of a FeatureView for
an EarthEngine table dataset.

The requirements and specification are:

- gee:skip_featureview_generation can only be present as true in the top-level
- gee:feature_view_ingestion_params does not apply to raster datasets (images
  and image collections)
- table collections do not currently have gee:feature_view_ingestion_params
- max_features_per_tile is an integer defining the maximum number of features
  displayed in a map tile at a given zoom level. It should be between
  150 and 16000 inclusive
- thinning_strategy controls whether feature thinning for a given tile and zoom
  level should be optimized for higher density or consistency in density across
  tiles. If present, it is one of: 'GLOBALLY_CONSISTENT', 'HIGHER_DENSITY'
- thinning_ranking defines feature thinning priority. It is a list of one or
  more string with two values: property_name and order
- z_order_ranking defines the z-order (stack order) of features displayed on the
  map. It is a list of one or more strings with two values: property name and
  order
- prerender_tiles is a bool value that can only be present when true

Orders are:
- ASC: ascending
- DESC: descending

Note that thinning_ranking and z_order_ranking can be a csv string with one
or more entries within the single string. This is excluded from the EE STAC
Jsonnet files to keep the catalog more uniform.

See:
- https://developers.google.com/earth-engine/guides/featureview_overview
- https://developers.google.com/earth-engine/guides/featureview_optimization

Jsonnet examples:

  'gee:skip_featureview_generation': True,
  'gee:feature_view_ingestion_params': {
    max_features_per_tile: 2000,
    thinning_strategy: 'HIGHER_DENSITY',
    thinning_ranking: ['BurnBndAc DESC'],
    z_order_ranking: ['BurnBndAc DESC'],
    prerender_tiles: true,
  },

  'gee:feature_view_ingestion_params': {
    max_features_per_tile: 250,
    thinning_strategy: 'HIGHER_DENSITY',
    thinning_ranking: ['shape_area DESC'],
  },

  'gee:feature_view_ingestion_params': {
    max_features_per_tile: 12000,
    thinning_strategy: 'HIGHER_DENSITY',
    thinning_ranking: ['.minZoomLevel DESC'],
    z_order_ranking: ['.minZoomLevel DESC'],
    prerender_tiles: true,
  },

  'gee:feature_view_ingestion_params': {
    thinning_ranking: ['property1 DESC', 'property2 ASC'],
    z_order_ranking: ['a-prop DESC', '.geometryType ASC', '.minZoomLevel ASC'],
  },
"""

# TODO(schwehr): Check gee:visualizations visualize_as

import re
from typing import Iterator

from checker import stac

SUMMARIES = 'summaries'

GEE_FEATURE_VIEW_INGESTION_PARAMS = 'gee:feature_view_ingestion_params'
MAX_FEATURES_PER_TILE = 'max_features_per_tile'
THINNING_STRATEGY = 'thinning_strategy'
THINNING_RANKING = 'thinning_ranking'
Z_ORDER_RANKING = 'z_order_ranking'
PRERENDER_TILES = 'prerender_tiles'

MAX_FEATURES_RANGE = [150, 16000]

THINNING_STRATEGIES = frozenset({'GLOBALLY_CONSISTENT', 'HIGHER_DENSITY'})
DIRECTIONS = frozenset({'ASC', 'DESC'})


class Check(stac.NodeCheck):
  """Checks the feature view fields."""
  name = 'feature_view'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.gee_type in (
        stac.GeeType.IMAGE,
        stac.GeeType.IMAGE_COLLECTION,
        stac.GeeType.TABLE_COLLECTION):
      if stac.SKIP_FEATUREVIEW_GENERATION in node.stac:
        yield cls.new_issue(
            node,
            f'{stac.SKIP_FEATUREVIEW_GENERATION} not allowed in '
            f'{node.gee_type}')

    if SUMMARIES not in node.stac: return
    summaries = node.stac[SUMMARIES]
    if not isinstance(summaries, dict): return

    # Note: table collections may have ingestion params in the future.
    if node.gee_type in (
        stac.GeeType.IMAGE,
        stac.GeeType.IMAGE_COLLECTION,
        stac.GeeType.TABLE_COLLECTION):
      if GEE_FEATURE_VIEW_INGESTION_PARAMS in summaries:
        yield cls.new_issue(
            node,
            f'{GEE_FEATURE_VIEW_INGESTION_PARAMS} not allowed '
            f'in {node.gee_type}')
      return

    if stac.SKIP_FEATUREVIEW_GENERATION in node.stac:
      skip = node.stac[stac.SKIP_FEATUREVIEW_GENERATION]
      if not isinstance(skip, bool):
        yield cls.new_issue(
            node, f'{stac.SKIP_FEATUREVIEW_GENERATION} must be a bool')
      elif not skip:
        yield cls.new_issue(
            node, f'{stac.SKIP_FEATUREVIEW_GENERATION} cannot be false')
      return

    if GEE_FEATURE_VIEW_INGESTION_PARAMS not in summaries:
      yield cls.new_issue(
          node,
          f'{GEE_FEATURE_VIEW_INGESTION_PARAMS} must be present '
          f'in {node.gee_type}',
      )
      return

    params = summaries[GEE_FEATURE_VIEW_INGESTION_PARAMS]
    if not isinstance(params, dict):
      yield cls.new_issue(
          node, f'{GEE_FEATURE_VIEW_INGESTION_PARAMS} must be a dict')
      return
    if not params:
      yield cls.new_issue(
          node, f'{GEE_FEATURE_VIEW_INGESTION_PARAMS} must not be empty')

    if MAX_FEATURES_PER_TILE in params:
      max_features = params[MAX_FEATURES_PER_TILE]
      if not isinstance(max_features, int):
        yield cls.new_issue(node, f'{MAX_FEATURES_PER_TILE} must be an int')
      else:
        if max_features < MAX_FEATURES_RANGE[0]:
          yield cls.new_issue(
              node,
              f'{MAX_FEATURES_PER_TILE} must be >= {MAX_FEATURES_RANGE[0]}')
        if max_features > MAX_FEATURES_RANGE[1]:
          yield cls.new_issue(
              node,
              f'{MAX_FEATURES_PER_TILE} must be <= {MAX_FEATURES_RANGE[1]}')

    if THINNING_STRATEGY in params:
      strategy = params[THINNING_STRATEGY]
      if not isinstance(strategy, str):
        yield cls.new_issue(node, f'{THINNING_STRATEGY} must be a str')
      elif strategy not in THINNING_STRATEGIES:
        yield cls.new_issue(
            node,
            f'{THINNING_STRATEGY} must be one of ' +
            ', '.join(sorted(THINNING_STRATEGIES)))

    if THINNING_RANKING in params:
      rankings = params[THINNING_RANKING]
      if not isinstance(rankings, list):
        yield cls.new_issue(
            node, f'{THINNING_RANKING} must be a list')
      elif not rankings:
        yield cls.new_issue(
            node, f'{THINNING_RANKING} list must have at least one str')
      else:
        for ranking in rankings:
          if not isinstance(ranking, str):
            yield cls.new_issue(
                node, f'Each {THINNING_RANKING} element must be a str')
            continue

          fields = ranking.split()
          if len(fields) != 2:
            yield cls.new_issue(
                node, f'{THINNING_RANKING} must be "<field> ASC|DESC')
          else:
            property_name, direction = fields
            if not re.fullmatch('[.a-zA-Z][_a-zA-Z0-9]{1,49}', property_name):
              yield cls.new_issue(
                  node, f'Invalid property_name: "{property_name}"')
            if direction not in DIRECTIONS:
              yield cls.new_issue(
                  node,
                  f'{THINNING_RANKING} direction must be one of ' +
                  ', '.join(sorted(DIRECTIONS)))
            # TODO(schwehr): Make sure the property_name is in the schema.

    if Z_ORDER_RANKING in params:
      rankings = params[Z_ORDER_RANKING]
      if not isinstance(rankings, list):
        yield cls.new_issue(
            node, f'{Z_ORDER_RANKING} must be a list')
      elif not rankings:
        yield cls.new_issue(
            node, f'{Z_ORDER_RANKING} list must have at least one str')
      else:
        for ranking in rankings:
          if not isinstance(ranking, str):
            yield cls.new_issue(
                node, f'Each {Z_ORDER_RANKING} element must be a str')
            continue

          fields = ranking.split()
          if len(fields) != 2:
            yield cls.new_issue(
                node, f'{Z_ORDER_RANKING} must be "<field> ASC|DESC')
          else:
            property_name, direction = fields
            # Can start with a fullstop: .minZoomLevel
            if not re.fullmatch('[.a-zA-Z][_a-zA-Z0-9]{1,49}', property_name):
              yield cls.new_issue(
                  node, f'Invalid property_name: "{property_name}"')
            if direction not in DIRECTIONS:
              yield cls.new_issue(
                  node,
                  f'{Z_ORDER_RANKING} direction must be one of ' +
                  ', '.join(sorted(DIRECTIONS)))
            # TODO(schwehr): Make sure the property_name is in the schema.

    if PRERENDER_TILES in params:
      prerender = params[PRERENDER_TILES]
      if not isinstance(prerender, bool):
        yield cls.new_issue(node, f'{PRERENDER_TILES} must be a bool')
      else:
        if not prerender:
          yield cls.new_issue(
              node, f'{PRERENDER_TILES} can only be present when true')

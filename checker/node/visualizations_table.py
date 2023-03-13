"""Check visualizations for tables.

STAC Catalog entries for ee.FeatureCollection assets must have
a polygon_visualization or table_visualization section.  This checker only
handles the table_visualization.

The table_visualization is used to render the collection in the Earth Engine
Explorer and to create dataset example scripts.

The requirements and components for table_visualization:

- For STAC Collections of GeeType Table or TableCollection, each visualization
  must have one of polygon_visualization, table_visualization, or visualize_as
- The table_visualization has a number of styling fields that can be combined:
  - color is an rrggbb or rrggbbaa hex color code or CSS color name of point
    shapes. aa is the transparency (alpha)
  - fill_color is the same format as color, but for filling polygons and point
    shapes
  - point_size is the size in pixels of point shapes
  - point_shape defines the shape of points.  It can either be the name or the
    corresponding MATLAB code.
    o, s, d, x, +, p, h, ^, v, <, >
    circle, cross, diamond, hexagon, hexagram, pentagon, pentagram, plus,
    square, star5, star6, triangle, triangle_down, triangle_left,
    triangle_right, triangle_up
  - width defines the width for lines and outlines for point shapes

Jsonnet examples:

table_visualization: {},
table_visualization: {color: '489734'},
table_visualization: {color: '4f9734', point_size: 3},
table_visualization: {color: 'red', width: 1.0},
table_visualization: {color: '00909F', width: 3.0, fill_color: 'b5ffb4'},
"""

import re
from typing import Iterator

from checker import stac
from checker.node import gee_classes

COLOR_NAMES = gee_classes.COLOR_NAMES

SUMMARIES = 'summaries'
VISUALIZATIONS = 'gee:visualizations'
POLYGON_VISUALIZATION = 'polygon_visualization'
TABLE_VISUALIZATION = 'table_visualization'
VISUALIZE_AS = 'visualize_as'

TABLE_TYPES = (stac.GeeType.TABLE, stac.GeeType.TABLE_COLLECTION)

COLOR = 'color'
FILL_COLOR = 'fill_color'
POINT_SIZE = 'point_size'
MIN_POINT_SIZE = 1
MAX_POINT_SIZE = 10
POINT_SHAPE = 'point_shape'
WIDTH = 'width'
MIN_WIDTH = 0.1
MAX_WIDTH = 3.0

# TODO(schwehr): Add matlab markers
SHAPES = frozenset({
    'circle',
    'cross',
    'diamond',
    'hexagon',
    'hexagram',
    'pentagon',
    'pentagram',
    'plus',
    'square',
    'star5',
    'star6',
    'triangle',
    'triangle_down',
    'triangle_left',
    'triangle_right',
    'triangle_up',
})

TABLE_KEYS = frozenset({
    COLOR, FILL_COLOR, POINT_SHAPE, POINT_SIZE, WIDTH})


class Check(stac.NodeCheck):
  """Checks visualizations for tables."""
  name = 'visualizations_table'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if SUMMARIES not in node.stac: return
    summaries = node.stac[SUMMARIES]
    if not isinstance(summaries, dict): return

    if VISUALIZATIONS not in summaries: return
    visualizations = summaries[VISUALIZATIONS]
    if not isinstance(visualizations, list): return

    for visualization in visualizations:
      if not isinstance(visualization, dict):
        continue

      if not visualization:
        continue

      if TABLE_VISUALIZATION not in visualization:
        if (POLYGON_VISUALIZATION not in visualization and
            VISUALIZE_AS not in visualization):
          if node.gee_type in TABLE_TYPES:
            yield cls.new_issue(
                node, f'{node.gee_type} must have a {TABLE_VISUALIZATION}')
        continue

      table_visualization = visualization[TABLE_VISUALIZATION]
      if not isinstance(table_visualization, dict):
        yield cls.new_issue(node, f'{TABLE_VISUALIZATION} must be a dict')
        continue

      if COLOR in table_visualization:
        color = table_visualization[COLOR]
        if not isinstance(color, str):
          yield cls.new_issue(node, f'{COLOR} must be a str')
        else:
          if not re.fullmatch(r'[0-9a-fA-F]{6}([0-9a-fA-F]{2})?', color):
            if color not in COLOR_NAMES:
              yield cls.new_issue(
                  node,
                  f'{COLOR} must be a 6 (or 8) character hex or color name - ' +
                  f'found "{color}"')

      if FILL_COLOR in table_visualization:
        fill_color = table_visualization[FILL_COLOR]
        if not isinstance(fill_color, str):
          yield cls.new_issue(node, f'{FILL_COLOR} must be a str')
        else:
          if not re.fullmatch(r'[0-9a-fA-F]{6}([0-9a-fA-F]{2})?', fill_color):
            if fill_color not in COLOR_NAMES:
              yield cls.new_issue(
                  node, f'{FILL_COLOR} ' +
                  'must be a 6 (or 8) character hex or color name - ' +
                  f'found "{fill_color}"')

      if POINT_SIZE in table_visualization:
        point_size = table_visualization[POINT_SIZE]
        if not isinstance(point_size, int):
          yield cls.new_issue(node, f'{POINT_SIZE} must be an int')
        else:
          if not MIN_POINT_SIZE <= point_size <= MAX_POINT_SIZE:
            yield cls.new_issue(
                node, f'{POINT_SIZE} must be in the range of ' +
                f'[{MIN_POINT_SIZE}:{MAX_POINT_SIZE}]')

      if POINT_SHAPE in table_visualization:
        point_shape = table_visualization[POINT_SHAPE]
        if not isinstance(point_shape, str):
          yield cls.new_issue(node, f'{POINT_SHAPE} must be a str')
        elif (point_shape not in SHAPES and
              not re.fullmatch(r'[dhopsv+^<>]', point_shape)):
          yield cls.new_issue(
              node,
              f'{POINT_SHAPE} must be one of {sorted(SHAPES)} or ' +
              'a character in "dhopsv+^<>"'
          )

      if WIDTH in table_visualization:
        width = table_visualization[WIDTH]
        if not isinstance(width, (int, float)):
          yield cls.new_issue(node, f'{WIDTH} must be an number')
        else:
          if not MIN_WIDTH <= width <= MAX_WIDTH:
            yield cls.new_issue(
                node, f'{WIDTH} must be in the range of ' +
                f'[{MIN_WIDTH}:{MAX_WIDTH}]')

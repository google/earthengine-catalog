"""Check visualizations.

Only STAC Collections have gee:visualizations.

The visualization section of Earth Engine STAC Collections currently has three
primary purposes:

1. Provide a source that can be used to generate dataset example scripts
  - The code to generate the example scripts has yet to be open sourced and
2. Enable the "Explorer" web tool to display datasets.
  - https://explorer.earthengine.google.com/
3. Assist FeatureView in creating representations of FeatureCollections
  - https://developers.google.com/earth-engine/guides/featureview_overview

The checks in this file cover only common core of checks for visualizations.
visualization.py delegates to other checker files for parts of visualizations:

- feature_view.py for visualize_as FeatureView.
- visualizations_image.py for image_visualization
- visualizations_table.py for polygon_visualization, and table_visualization

The rules covered here in visualizations.py:
- Each collection can have 1 to 4 visualizations.  If there is a need to have
  more, let us know the use case and we
- Each visualization must have
  - a display_name 3 to 65 characters long. 4 < len < 30 is better
  - one of:
    - image_visualization
    - polygon_visualization
    - table_visualization
    - visualize_as
- If the visualization is not a visualize_as:
  - it must have a lookat that is within the dataset extent
    - the lookat point must be with +/-180 degrees longitude and +/-90 degrees
      latitude
    - the point must be inside of the bounding box declared by the collection's
      bounding box inside of the extent field
    - the Zoom must be an integer greater than 0 and less than 20.
      However, zoom levels 0 and 20 are not useful starting points.

Notes:
- There is no STAC extension for gee:visualizations and the checker is currently
  the only documentation for it.  We plan to add more documentation.
- Some older datasets do not have gee:visualizations.  All new datasets
  must have this section.
"""

import re
from typing import Any, Iterator, Optional

from checker import stac

SUMMARIES = 'summaries'
VISUALIZATIONS = 'gee:visualizations'
LOOKAT = 'lookat'
LON = 'lon'
LAT = 'lat'
ZOOM = 'zoom'
EXTENT = 'extent'
SPATIAL = 'spatial'
BBOX = 'bbox'

DISPLAY_NAME = 'display_name'
VISUALIZE_AS = 'visualize_as'

IMAGE_VISUALIZATION = 'image_visualization'
POLYGON_VISUALIZATION = 'polygon_visualization'
TABLE_VISUALIZATION = 'table_visualization'
OTHER_FIELDS = frozenset(
    {IMAGE_VISUALIZATION, POLYGON_VISUALIZATION, TABLE_VISUALIZATION})

MISSING_LOOKAT = frozenset({
    # TODO(schwehr): These should be fixed
    'NASA_USDA/HSL/SMAP_soil_moisture',
    'NASA_USDA/HSL/soil_moisture'
})

# Do not allow zoom levels of 0 and 20.
_ZOOM_RANGE = [1, 19]

def get_bbox(
    stac_data: dict[str, Any]) -> Optional[tuple[float, float, float, float]]:
  """Returns the bounding box from a STAC JSON data structure."""
  if EXTENT not in stac_data:
    return None
  extent = stac_data[EXTENT]
  if not isinstance(extent, dict):
    return None
  if SPATIAL not in extent:
    return None
  spatial = extent[SPATIAL]
  if not isinstance(spatial, dict):
    return None
  if BBOX not in spatial:
    return None
  bbox = spatial[BBOX]
  if not isinstance(spatial, dict):
    return None
  if len(bbox) != 1:
    return None
  coords = bbox[0]
  if not isinstance(coords, list):
    return None
  if len(coords) != 4:
    return None
  # Order: lower left lon, lower left lat, upper right lon, upper right lat
  x1, y1, x2, y2 = coords
  return x1, y1, x2, y2


class Check(stac.NodeCheck):
  """Checks visualizations."""
  name = 'visualizations'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if SUMMARIES not in node.stac: return
    summaries = node.stac[SUMMARIES]
    if not isinstance(summaries, dict): return

    if VISUALIZATIONS not in summaries:
      yield cls.new_issue(node, f'Missing {VISUALIZATIONS} field')
      return

    visualizations = summaries[VISUALIZATIONS]
    if not isinstance(visualizations, list):
      yield cls.new_issue(node, f'{VISUALIZATIONS} must be a list')
      return

    if len(visualizations) < 1:
      yield cls.new_issue(node, f'{VISUALIZATIONS} must have at least 1 entry')
      return

    if len(visualizations) > 50:
      yield cls.new_issue(
          node, f'{VISUALIZATIONS} has too many entries: {len(visualizations)}')

    for visualization in visualizations:
      if not isinstance(visualization, dict):
        yield cls.new_issue(node, 'Visualization must be a dict')
        continue

      display_name = 'Unknown'
      if DISPLAY_NAME not in visualization:
        yield cls.new_issue(node, f'Visualization must have a {DISPLAY_NAME}')
      else:
        display_name = visualization[DISPLAY_NAME]
        if not isinstance(display_name, str):
          yield cls.new_issue(node, f'{DISPLAY_NAME} must be a str')
        elif not re.fullmatch(r'[a-zA-Z][-_a-zA-Z0-9 .,:()%"/\[\]²<^]{2,70}',
                              display_name):
          yield cls.new_issue(node, f'Invalid {DISPLAY_NAME}: "{display_name}"')

      if VISUALIZE_AS not in visualization:
        if LOOKAT not in visualization:
          if node.id not in MISSING_LOOKAT:
            yield cls.new_issue(node, f'"{display_name}" missing {LOOKAT}')
        else:
          lookat = visualization[LOOKAT]
          if not isinstance(lookat, dict):
            yield cls.new_issue(node, f'"{display_name}" {LOOKAT} not a dict')
          else:
            if LON not in lookat or LAT not in lookat or ZOOM not in lookat:
              yield cls.new_issue(
                  node, f'{LOOKAT} must have {LON}, {LAT}, and {ZOOM}')
            else:
              lon = lookat[LON]
              lat = lookat[LAT]
              zoom = lookat[ZOOM]  # Can technically be a float.
              if (not isinstance(lon, (int, float)) or
                  not isinstance(lat, (int, float)) or
                  not isinstance(zoom, int)):
                yield cls.new_issue(
                    node,
                    f'{LON} and {LAT} must be floats and {ZOOM} must be ' +
                    f'an int: {lon}, {lat}, {zoom}')
              else:
                if not -180 <= lon <= 180:
                  yield cls.new_issue(node, f'{LON} must be in [-180, 180]')
                if not -90 <= lat <= 90:
                  yield cls.new_issue(node, f'{LAT} must be in [-90, 90]')
                if not _ZOOM_RANGE[0] <= zoom <= _ZOOM_RANGE[1]:
                  yield cls.new_issue(
                      node, f'{ZOOM} must be in {_ZOOM_RANGE}; found: {zoom}')

                bbox = get_bbox(node.stac)
                if bbox:
                  x1, y1, x2, y2 = bbox
                  if not x1 < lon < x2:
                    yield cls.new_issue(node, f'{LON} must be in ({x1}..{x2})')
                  if not y1 < lat < y2:
                    yield cls.new_issue(node, f'{LAT} must be in ({y1}..{y2})')

        other_fields = [
            f for f in visualization if f not in (DISPLAY_NAME, LOOKAT)
        ]
        if 'GOOGLE/Research/open-buildings' in node.id:
          pass  # TODO(b/254522101): Fix the catalog entries.
        elif len(other_fields) != 1:
          yield cls.new_issue(
              node, f'Other fields must be one of {sorted(OTHER_FIELDS)} - ' +
              f'found: {sorted(other_fields)}', stac.IssueLevel.ERROR)
        else:
          field = other_fields[0]

          if (node.gee_type
              in (stac.GeeType.IMAGE, stac.GeeType.IMAGE_COLLECTION) and
              field != IMAGE_VISUALIZATION):
            yield cls.new_issue(
                node, f'{node.gee_type} must have an {IMAGE_VISUALIZATION}')
          elif (node.gee_type
                in (stac.GeeType.TABLE, stac.GeeType.TABLE_COLLECTION) and
                field not in (POLYGON_VISUALIZATION, TABLE_VISUALIZATION)):
            yield cls.new_issue(
                node, f'{node.gee_type} must have one of ' +
                f'{POLYGON_VISUALIZATION} or {TABLE_VISUALIZATION}')

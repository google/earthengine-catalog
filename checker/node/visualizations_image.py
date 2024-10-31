"""Check visualizations for images and image_collections.

STAC Catalog entries for ee.Image and ee.ImageCollection assets must have
an image_visualization section.  The section is used to render the collection
in the Earth Engine Explorer and to create dataset example scripts.

The requirement and components for this section:

- It must contain one band_vis and nothing else
- The band_viz has the detail on how to render images as rrggbb pixels:
  - It must have a list of bands that is either length 1 or 3 with band name
    strings. Band names may be reused
  - The following fields that modify how the values in the image are used. They
    must be specified as a list of values even if there is only one value
    - min: The value to map to 0 for the color channel
    - max: The value to map to 255 for the color channel
    - gamma: The gamma correction (power law) to apply to the values
      https://en.wikipedia.org/wiki/Gamma_correction
    - gain: Number by which to multiply each pixel value
    - bias: Number to add to each value (after multiplying by gain)
    - palette: A list of CSS style strings. There may be from 1 to 250 colors.
      CSS 'rgb' colors are not allowed, e.g. '0f0'.  A leading '#' is not
      allowed. Each color entry is one of:
      - 'rrggbb': 6 character hex
      - 'rrggbbaa': 8 character hex with transparency (alpha)
      - 'color': A supported color name, e.g. 'red'

For min, max, and gain, they can be specified with a list of one number that
applies to all band. Alternatively for 3-band visualizations, they can be
specified explicitly for each band to allow for different values. For min
and max, these lists must be the same size.

visualizations_image.py delegates to visualization.py for all the checks that
lead up to the image_visualization section.

Jsonnet examples:

image_visualization: {band_vis: {bands: ['BPS']},

image_visualization: {band_vis: {bands: ['B2', 'B1', 'B7']},

image_visualization: {
  band_vis: {
    min: [1.2, 5.8, -9],
    max: [1000, 500, 30]]
    bands: ['B1', 'B2', 'B3']}}

image_visualization: {
  band_vis: {
    gamma: [1.2],
    gain: [600.0],
    bands: ['B3', 'B2', 'B1']}}

image_visualization: {
  band_vis: {
    gain: [0.1],
    bias: [-1400.0],
    bands: ['LST_Day_1km']}},

image_visualization: {
  band_vis: {
    palette: ['000088', 'ffffff'],
    bands: ['NDSI']}},

image_visualization: {
  band_vis: {
    min: [1.0],
    max: [60.0],
    palette: ['red', 'orange', 'green'],
    bands: ['rh98']}},

See also:
- https://developers.google.com/earth-engine/guides/image_visualization
"""

import re
from typing import Iterator

from checker import stac
from checker.node import gee_classes

COLOR_NAMES = gee_classes.COLOR_NAMES

SUMMARIES = 'summaries'
VISUALIZATIONS = 'gee:visualizations'
BANDS = 'eo:bands'
DISPLAY_NAME = 'display_name'
IMAGE_VISUALIZATION = 'image_visualization'
NAME = 'name'

BAND_VIS = 'band_vis'

VIS_BANDS = 'bands'
MIN = 'min'
MAX = 'max'

BIAS = 'bias'
GAMMA = 'gamma'
GAIN = 'gain'
PALETTE = 'palette'

GAMMA_MIN = 1
GAMMA_MAX = 5

GAIN_MIN = 0.0001
GAIN_MAX = 1000

BIAS_MIN = -100000
BIAS_MAX = 100000

# TODO(schwehr): This should be much smaller for non-categorical data.  Maybe 40
MAX_PALETTE_SIZE = 250


class Check(stac.NodeCheck):
  """Checks visualizations for images and image_collections."""
  name = 'visualizations_image'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if SUMMARIES not in node.stac: return
    summaries = node.stac[SUMMARIES]
    if not isinstance(summaries, dict): return

    if BANDS not in summaries: return
    eo_bands = summaries[BANDS]
    if not isinstance(eo_bands, list): return
    for eo_band in eo_bands:
      if not isinstance(eo_band, dict): return
      if NAME not in eo_band: return
      if not isinstance(eo_band[NAME], str): return
    valid_names = [eo_band[NAME] for eo_band in eo_bands]

    if VISUALIZATIONS not in summaries: return
    visualizations = summaries[VISUALIZATIONS]
    if not isinstance(visualizations, list): return

    for visualization in visualizations:
      if not isinstance(visualization, dict):
        continue

      if not visualization:
        continue

      if IMAGE_VISUALIZATION not in visualization:
        if (node.gee_type == stac.GeeType.IMAGE or
            node.gee_type == stac.GeeType.IMAGE_COLLECTION):
          yield cls.new_issue(
              node, f'{node.gee_type} must have a {IMAGE_VISUALIZATION}')
        continue

      image_visualization = visualization[IMAGE_VISUALIZATION]
      if not isinstance(image_visualization, dict):
        yield cls.new_issue(node, f'{IMAGE_VISUALIZATION} must be a dict')
        continue

      display_name = visualization.get(DISPLAY_NAME, 'Unknown')

      if BAND_VIS not in image_visualization:
        yield cls.new_issue(node, f'Missing {BAND_VIS} in {display_name}')
        continue

      band_viz = image_visualization[BAND_VIS]
      if not isinstance(band_viz, dict):
        yield cls.new_issue(node, f'{display_name} {BAND_VIS} must be a dict')
        continue

      if VIS_BANDS not in band_viz:
        yield cls.new_issue(
            node, f'{display_name} {BAND_VIS} must have {VIS_BANDS}')
        continue

      bands = band_viz[VIS_BANDS]
      if not isinstance(bands, list):
        yield cls.new_issue(node, f'{display_name} {VIS_BANDS} must be a list')
        continue

      num_bands = len(bands)
      if num_bands not in (1, 3):
        yield cls.new_issue(node, 'There must be 1 or 3 bands')
        continue

      for band_name in bands:
        if not isinstance(band_name, str):
          yield cls.new_issue(node, 'band not a str')
        elif band_name not in valid_names:
          yield cls.new_issue(node, f'band {band_name} not in {BANDS}')

      min_list = band_viz.get(MIN, [])
      min_list_size = len(min_list)
      min_list_ok = bool(min_list)
      if MIN in band_viz:
        if not isinstance(band_viz[MIN], list):
          yield cls.new_issue(node, f'{VIS_BANDS} must be a list')
          min_list_ok = False
        else:
          if min_list_size != 1 and min_list_size != 3:
            if num_bands == 1:
              yield cls.new_issue(node, f'{MIN} must be length 1')
            else:
              yield cls.new_issue(node, f'{MIN} must be length 1 or 3')
          else:
            for value in min_list:
              if not isinstance(value, (int, float)):
                min_list_ok = False
                yield cls.new_issue(node, f'{MIN} values must be numbers')
                break

      max_list = band_viz.get(MAX, [])
      max_list_size = len(max_list)
      max_list_ok = bool(max_list)
      if MAX in band_viz:
        if not isinstance(band_viz[MAX], list):
          yield cls.new_issue(node, f'{VIS_BANDS} must be a list')
          max_list_ok = False
        else:
          if max_list_size != 1 and max_list_size != 3:
            if num_bands == 1:
              yield cls.new_issue(node, f'{MAX} must be length 1')
            else:
              yield cls.new_issue(node, f'{MAX} must be length 1 or 3')
          else:
            for value in max_list:
              if not isinstance(value, (int, float)):
                max_list_ok = False
                yield cls.new_issue(node, f'{MAX} values must be numbers')
                break

      if min_list_ok and max_list_ok:
        if min_list_size != max_list_size:
          yield cls.new_issue(node, 'min and max lists must be the same size')
        else:
          for i in range(min_list_size):
            min_val = min_list[i]
            max_val = max_list[i]
            if min_val > max_val:
              yield cls.new_issue(node, f'min > max: {min_val} > {max_val}')

      if GAMMA in band_viz:
        gamma_list = band_viz[GAMMA]
        gamma_list_size = len(gamma_list)
        if not isinstance(gamma_list, list):
          yield cls.new_issue(node, f'{GAMMA} must be a list')
        else:
          if gamma_list_size != 1:
            yield cls.new_issue(node, f'{GAMMA} must be length 1')
          else:
            gamma = gamma_list[0]
            if not isinstance(gamma, (int, float)):
              yield cls.new_issue(node, f'{GAMMA} value must be a number')
              break

            if not GAMMA_MIN <= gamma <= GAMMA_MAX:
              yield cls.new_issue(
                  node,
                  f'{GAMMA} must be in the range of [{GAMMA_MIN}..{GAMMA_MAX}]')

      if GAIN in band_viz:
        gain_list = band_viz[GAIN]
        # Length 1 or 3
        gain_list_size = len(gain_list)
        if not isinstance(gain_list, list):
          yield cls.new_issue(node, f'{GAIN} must be a list')
        else:
          if gain_list_size not in (1, 3):
            yield cls.new_issue(node, f'{GAIN} must be length 1 or 3')
          else:
            if gain_list_size == 3 and num_bands != 3:
              yield cls.new_issue(node, f'{GAIN} must be length 1 for 1 band')
            for gain in gain_list:
              if not isinstance(gain, (int, float)):
                yield cls.new_issue(node, f'{GAIN} value must be a number')
                break

              # TODO(schwehr): Consider refactoring this type of check.
              if not GAIN_MIN <= gain <= GAIN_MAX:
                yield cls.new_issue(
                    node,
                    f'{GAIN} must be in the range of [{GAIN_MIN}..{GAIN_MAX}]')

      if BIAS in band_viz:
        bias_list = band_viz[BIAS]
        # TODO(schwehr): Evaluate adding the option to have 3 bias values
        bias_list_size = len(bias_list)
        if not isinstance(bias_list, list):
          yield cls.new_issue(node, f'{BIAS} must be a list')
        else:
          if bias_list_size != 1:
            yield cls.new_issue(node, f'{BIAS} must be length 1')
          else:
            bias = bias_list[0]
            if not isinstance(bias, (int, float)):
              yield cls.new_issue(node, f'{BIAS} value must be a number')

      # TODO(schwehr): Warn if more than 20 colors for non-categorical data
      if PALETTE in band_viz:
        if num_bands != 1:
          yield cls.new_issue(node, f'{PALETTE} can only have one band')
        palette_list = band_viz[PALETTE]
        palette_list_size = len(palette_list)
        if palette_list_size > MAX_PALETTE_SIZE:
          yield cls.new_issue(
              node, f'{PALETTE} size should be <= {MAX_PALETTE_SIZE}')
        else:
          have_name = False
          have_hex = False
          for color in palette_list:
            if color in COLOR_NAMES:
              have_name = True
            elif re.fullmatch(r'[0-9a-fA-F]{6}', color):
              have_hex = True
            else:
              yield cls.new_issue(
                  node,
                  'color must be a 6 character hex or ' +
                  f'color name - found "{color}"')
          if have_name and have_hex:
            yield cls.new_issue(
                node,
                'colors must be all hex or all color names. '
                'Found a mix of both')

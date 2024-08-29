"""Check gee:classes.

The gee:classes field is a list of dictionaries. There can be between 2 and 255
classes in a gee:classes field.

Each dictionary consists of:

  Field Name  | Type       | Description
  ------------|------------|------------
  value       | integer    | REQUIRED. Value of the class
  description | string     | REQUIRED. What the class is.  1 to 1000 characters
  color       | string     | Optional color to render the class

The color can be a hex string with rrggbb or rrggbbaa, where r = red, g = green,
b = blue, and a = alpha (1 - transparency).  Alternatively, the color can be
the all lower case color string from web colors.  See `COLOR_NAMES` below for
the allowed color names.

Not allowed:
- rgb short color names, e.g. f0a
- leanding '#' characters for hex

For each of the three fields, the value of the field cannot be repeated.

See also:
- eo_extension.py
- gee_bitmask.py

JSON format example:

"summaries": {
      "eo:bands": [
         {
            "description": "Water classification",
            "gee:classes": [
               {
                  "color": "fafafa",
                  "description": "Land",
                  "value": 1
               },
               {
                  "color": "00c5ff",
                  "description": "Water",
                  "value": 2
               },
            ],
            "name": "water"
         }
      ],

Earth Engine does not currently use the classification extension.  EE will may
switch to this in the future.

https://github.com/stac-extensions/classification
classification:classes
  Field Name  | Type       | Description
  ------------|------------|------------
  value       | integer    | REQUIRED. Value of the class
  description | string     | Description of the class
  name        | string     | REQUIRED. Short name of the class
  color_hint  | RGB string | Color for rendering (Hex RGB code in upper w/o #)
  nodata      | boolean    | Set to true if a no-data value, defaults to false
"""

import re
from typing import Iterator

from checker import stac

SUMMARIES = 'summaries'
EO_BANDS = 'eo:bands'

CLASSES = 'gee:classes'

VALUE = 'value'
DESCRIPTION = 'description'
COLOR = 'color'

REQUIRED = frozenset({DESCRIPTION, VALUE})
FIELDS = frozenset({COLOR, DESCRIPTION, VALUE})

# TODO(schwehr): Factor out a complete list of the colors.  It's needed
# for visualizations too.
# color names allowed by the CSS Level 2 and SVG 1.0 specifications.
# https://www.w3.org/wiki/CSS/Properties/color/keywords
# https://www.w3.org/TR/CSS21/syndata.html#color-units
# https://en.wikipedia.org/wiki/Web_colors
COLOR_NAMES = frozenset({
    'aliceblue',
    'antiquewhite',
    'aqua',
    'aquamarine',
    'azure',
    'beige',
    'bisque',
    'black',
    'blanchedalmond',
    'blue',
    'blueviolet',
    'brown',
    'burlywood',
    'cadetblue',
    'chartreuse',
    'chocolate',
    'coral',
    'cornflowerblue',
    'cornsilk',
    'crimson',
    'cyan',
    'darkblue',
    'darkcyan',
    'darkgoldenrod',
    'darkgray',
    'darkgreen',
    'darkgrey',
    'darkkhaki',
    'darkmagenta',
    'darkolivegreen',
    'darkorange',
    'darkorchid',
    'darkred',
    'darksalmon',
    'darkseagreen',
    'darkslateblue',
    'darkslategray',
    'darkslategrey',
    'darkturquoise',
    'darkviolet',
    'deeppink',
    'deepskyblue',
    'dimgray',
    'dimgrey',
    'dodgerblue',
    'firebrick',
    'floralwhite',
    'forestgreen',
    'fuchsia',
    'gainsboro',
    'ghostwhite',
    'gold',
    'goldenrod',
    'gray',
    'green',
    'greenyellow',
    'grey',
    'honeydew',
    'hotpink',
    'indianred',
    'indigo',
    'ivory',
    'khaki',
    'lavender',
    'lavenderblush',
    'lawngreen',
    'lemonchiffon',
    'lightblue',
    'lightcoral',
    'lightcyan',
    'lightgoldenrodyellow',
    'lightgray',
    'lightgreen',
    'lightgrey',
    'lightpink',
    'lightsalmon',
    'lightseagreen',
    'lightskyblue',
    'lightslategray',
    'lightslategrey',
    'lightsteelblue',
    'lightyellow',
    'lime',
    'limegreen',
    'linen',
    'magenta',
    'maroon',
    'mediumaquamarine',
    'mediumblue',
    'mediumorchid',
    'mediumpurple',
    'mediumseagreen',
    'mediumslateblue',
    'mediumspringgreen',
    'mediumturquoise',
    'mediumvioletred',
    'midnightblue',
    'mintcream',
    'mistyrose',
    'moccasin',
    'navajowhite',
    'navy',
    'oldlace',
    'olive',
    'olivedrab',
    'orange',
    'orangered',
    'orchid',
    'palegoldenrod',
    'palegreen',
    'paleturquoise',
    'palevioletred',
    'papayawhip',
    'peachpuff',
    'peru',
    'pink',
    'plum',
    'powderblue',
    'purple',
    'red',
    'rosybrown',
    'royalblue',
    'saddlebrown',
    'salmon',
    'sandybrown',
    'seagreen',
    'seashell',
    'sienna',
    'silver',
    'skyblue',
    'slateblue',
    'slategray',
    'slategrey',
    'snow',
    'springgreen',
    'steelblue',
    'tan',
    'teal',
    'thistle',
    'tomato',
    'turquoise',
    'violet',
    'wheat',
    'white',
    'whitesmoke',
    'yellow',
    'yellowgreen',
})

# Exceptions for things that have duplicate descriptions.
DUPLICATE_DESCRIPTIONS = frozenset({
    'LANDFIRE/Vegetation/BPS/v1_4_0',
    'LANDFIRE/Vegetation/ESP/v1_2_0/AK',
    'LANDFIRE/Vegetation/ESP/v1_2_0/HI',
    'LANDFIRE/Vegetation/EVC/v1_4_0',
    'LANDFIRE/Vegetation/EVT/v1_4_0',
    'USDA/NASS/CDL'
})


class Check(stac.NodeCheck):
  """Checks gee:classes."""
  name = 'gee_classes'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if SUMMARIES not in node.stac: return
    summaries = node.stac[SUMMARIES]
    if not isinstance(summaries, dict): return
    if EO_BANDS not in summaries: return
    bands = summaries[EO_BANDS]
    if not isinstance(bands, list): return

    for band in bands:
      if not isinstance(band, dict): continue
      if CLASSES not in band: continue
      classes = band[CLASSES]
      if not isinstance(classes, list):
        yield cls.new_issue(node, f'"{CLASSES}" must be a list')
        continue
      if len(classes) < 1:
        yield cls.new_issue(node, f'"{CLASSES}" must have at least 1 class')
        continue

      values = []
      descriptions = []
      colors = []
      have_name = False
      have_hex = False
      for a_class in classes:
        if not isinstance(a_class, dict):
          yield cls.new_issue(node, f'"{CLASSES}" item must be a dict')
          continue

        keys = set(a_class)
        if not REQUIRED.issubset(keys):
          missing = list(REQUIRED.difference(keys))
          yield cls.new_issue(
              node, f'A {CLASSES} entry missing {missing})')

        extra_keys = list(keys.difference(FIELDS))
        if len(extra_keys) == 1:
          yield cls.new_issue(node, f'Unexpected key: "{extra_keys[0]}"')
        elif len(extra_keys) > 1:
          yield cls.new_issue(node, f'Unexpected keys: {sorted(extra_keys)}')

        if VALUE in a_class:
          value = a_class[VALUE]
          if not isinstance(value, int):
            yield cls.new_issue(node, f'{VALUE} must be an integer: "{value}"')
          else:
            values.append(value)
            # TODO(schwehr): Is there a way to constrain the value?

        if DESCRIPTION in a_class:
          description = a_class[DESCRIPTION]
          if not isinstance(description, str):
            yield cls.new_issue(
                node, f'{DESCRIPTION} must be a str: {description}')
          else:
            descriptions.append(description)
            # TODO(schwehr): Validate description with `if not re.fullmatch`
            size = len(description)
            if size < 1:
              yield cls.new_issue(node, f'{DESCRIPTION} too short: "{size}"')
            elif size > 1000:
              yield cls.new_issue(node, f'{DESCRIPTION} too long: {size}')

        if COLOR in a_class:
          color = a_class[COLOR]
          if not isinstance(color, str):
            yield cls.new_issue(
                node, f'{COLOR} must be a str: {color}')
          else:
            colors.append(color)
            if color in COLOR_NAMES:
              have_name = True
            elif re.fullmatch(
                r'[0-9a-f]{6}([0-9a-f]{2})?', color, re.IGNORECASE):
              have_hex = True
            else:
              yield cls.new_issue(
                  node,
                  f'{COLOR} must be a 6 (or 8) character hex or ' +
                  f'color name - found "{color}"')

      if len(values) != len(set(values)):
        # TODO(schwehr): List duplicates
        yield cls.new_issue(node, f'{VALUE}s have duplicates')

      if values != sorted(values):
        yield cls.new_issue(node, f'{VALUE}s must be sorted')

      if len(descriptions) != len(set(descriptions)):
        if node.id not in DUPLICATE_DESCRIPTIONS:
          # TODO(schwehr): List duplicates
          yield cls.new_issue(node, f'{DESCRIPTION}s have duplicates')

      if have_name and have_hex:
        yield cls.new_issue(
            node,
            'colors must be all hex or all color names. '
            'Found a mix of both')

"""Check for gee:interval.

gee:interval is optional.

TODO(schwehr): Describe what it can be.
TODO(schwehr): Describe where is it used.

Example in Jsonnet:

  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
"""

from typing import Iterator

from checker import stac
from stac import stac_lib

CUSTOM_TIME_UNIT = 'custom_time_unit'
DESCRIPTION = 'description'
GEE_INTERVAL = 'gee:interval'
GEE_TYPE = 'gee:type'
INTERVAL = 'interval'
NAME = 'name'
TYPE = 'type'
UNIT = 'unit'

FIELDS = frozenset({DESCRIPTION, INTERVAL, NAME, TYPE, UNIT})

TYPES = frozenset({'cadence', 'climatological_interval', 'revisit_interval'})

UNITS = frozenset(
    {CUSTOM_TIME_UNIT, 'day', 'hour', 'minute', 'month', 'year'})


class Check(stac.NodeCheck):
  """Checks the gee:interval field."""
  name = GEE_INTERVAL

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if GEE_INTERVAL not in node.stac:
      return

    if node.type == stac.StacType.CATALOG:
      yield cls.new_issue(node, f'Catalogs cannot have "{GEE_INTERVAL}"')
      return

    if GEE_TYPE in node.stac.keys() and node.gee_type in (
        stac_lib.GeeType.IMAGE,
        stac_lib.GeeType.TABLE,
    ):
      yield cls.new_issue(
          node, f'Image/Table datasets cannot have "{GEE_INTERVAL}"'
      )
      return

    gee_interval = node.stac[GEE_INTERVAL]

    if not isinstance(gee_interval, dict):
      yield cls.new_issue(node, f'{GEE_INTERVAL} must be a dict')
      return

    keys = set(gee_interval)
    extra_keys = list(keys.difference(FIELDS))
    if len(extra_keys) == 1:
      yield cls.new_issue(node, f'Unexpected key: "{extra_keys[0]}"')
    elif len(extra_keys) > 1:
      yield cls.new_issue(node, f'Unexpected keys: {sorted(extra_keys)}')

    if TYPE not in gee_interval:
      yield cls.new_issue(node, f'Missing {TYPE}')
    else:
      interval_type = gee_interval[TYPE]
      if interval_type not in TYPES:
        yield cls.new_issue(node, f'Unknown {TYPE}: {interval_type}')

    if UNIT not in gee_interval:
      yield cls.new_issue(node, f'Missing {UNIT}')
    else:
      unit = gee_interval[UNIT]
      if unit not in UNITS:
        yield cls.new_issue(node, f'Unknown {UNIT}: {unit}')

      if unit == CUSTOM_TIME_UNIT:
        if DESCRIPTION not in gee_interval:
          yield cls.new_issue(
              node, f'Having {UNIT} of {unit} must have a {DESCRIPTION}')
        if NAME not in gee_interval:
          yield cls.new_issue(
              node, f'Having {UNIT} of {unit} must have a {NAME}')

    if INTERVAL not in gee_interval:
      yield cls.new_issue(node, f'Missing {INTERVAL}')
    else:
      interval = gee_interval[INTERVAL]
      if not isinstance(interval, int):
        yield cls.new_issue(node, f'{INTERVAL} must be an integer')
      else:
        if interval <= 0:
          yield cls.new_issue(node, f'{INTERVAL} must be a positive integer')
        if interval > 32:
          if node.id != 'EO1/HYPERION':
            yield cls.new_issue(node, f'{INTERVAL} too large: {interval}')

    if DESCRIPTION in gee_interval:
      description = gee_interval[DESCRIPTION]
      if not isinstance(description, str):
        yield cls.new_issue(node, f'{DESCRIPTION} must be a str')
      else:
        # TODO(schwehr): See if there is a clean way to factor out these checks
        size = len(description)
        if size < 10:
          yield cls.new_issue(node, f'{DESCRIPTION} too short')
        if size > 200:
          yield cls.new_issue(node, f'{DESCRIPTION} too long: {size}')

    if NAME in gee_interval:
      name = gee_interval[NAME]
      if not isinstance(name, str):
        yield cls.new_issue(node, f'{NAME} must be a str')
      else:
        size = len(name)
        if size < 2:
          yield cls.new_issue(node, f'{NAME} too short')
        if size > 200:
          yield cls.new_issue(node, f'{NAME} too long: {size}')

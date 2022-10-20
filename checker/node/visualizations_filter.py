"""Check filters in visualizations.

Only STAC Collections have gee:visualizations. A visualization in a
gee:visualizations can optionally have a filter. These filters can be helpful
to improve the quality of a visualization and/or reduce the load on Earth
Engine. Filters are not currently known to be used by any system.

There are 4 types of filters:
1. DATE_RANGE constrains the visualization to be between two dates. All times
   are assumed to be UTC. The time_start and time_end strings are in one of
   these forms:
   - YYYY-MM-DD
   - YYYY-MM-DDTHH:MM
   - YYYY-MM-DDTHH:MM:SS
2. EQUALS keeps only assets where the property_name matches the string in
   the property_value
3. LAST_N_DAYS constrains the results to only be a last few days specified by
   property_value, where property_value is a number of days as a quoted string
4. LIST_CONTAINS constrains the result to assets where a property_name has a
   string value specified by property_value.

Jsonnet examples:

DATE_RANGE:

  filter: {
    filter_name: 'DATE_RANGE',
    time_start: '2012-02-01',
    time_end: '2012-03-01',
  },

EQUALS:

  filter: {
    filter_name: 'EQUALS',
    property_name: 'a_property',
    property_value: 'String value',
  },

LAST_N_DAYS:

  filter: {
    filter_name: 'LAST_N_DAYS',
    property_value: '14',
  },

LIST_CONTAINS:

  filter: {
    filter_name: 'LIST_CONTAINS',
    property_name: 'transmitterReceiverPolarisation',
    property_value: 'VV',
  },
"""

import datetime
from typing import Iterator

from checker import stac

SUMMARIES = 'summaries'
VISUALIZATIONS = 'gee:visualizations'

DISPLAY_NAME = 'display_name'
VISUALIZE_AS = 'visualize_as'

FILTER = 'filter'

FILTER_NAME = 'filter_name'
DATE_RANGE = 'DATE_RANGE'
EQUALS = 'EQUALS'
LAST_N_DAYS = 'LAST_N_DAYS'
LIST_CONTAINS = 'LIST_CONTAINS'
FILTER_NAMES = frozenset({
    'DATE_RANGE', 'EQUALS', 'LAST_N_DAYS', 'LIST_CONTAINS'})

PROPERTY_NAME = 'property_name'
PROPERTY_VALUE = 'property_value'
TIME_START = 'time_start'  # ISO 8601 string
TIME_END = 'time_end'


def parse_filter_time(time_str: str) -> datetime.datetime:
  """Returns a datetime.datetime for a time string."""
  try:
    return datetime.datetime.strptime(time_str, '%Y-%m-%d')
  except ValueError:
    pass
  try:
    return datetime.datetime.strptime(time_str, '%Y-%m-%dT%H:%M')
  except ValueError:
    pass

  # Let the exception go up to the caller.
  return datetime.datetime.strptime(time_str, '%Y-%m-%dT%H:%M:%S')


class Check(stac.NodeCheck):
  """Checks visualizations."""
  name = 'visualizations_filter'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if SUMMARIES not in node.stac:
      return

    summaries = node.stac[SUMMARIES]
    if VISUALIZATIONS not in summaries:
      return

    visualizations = summaries[VISUALIZATIONS]
    if not isinstance(visualizations, list):
      return

    for visualization in visualizations:
      if not isinstance(visualization, dict):
        continue

      display_name = visualization.get(DISPLAY_NAME, 'Unknown')

      if VISUALIZE_AS in visualization: continue
      if FILTER not in visualization: continue

      # Everything before here will issue errors via visualizations.py.

      filter_name = None
      filter_field = visualization[FILTER]
      if not isinstance(filter_field, dict):
        yield cls.new_issue(node, f'"{display_name}" {FILTER} not a dict')
      else:
        if FILTER_NAME not in filter_field:
          yield cls.new_issue(
              node, f'"{display_name}" {FILTER} missing {FILTER_NAME}')
        else:
          filter_name = filter_field[FILTER_NAME]
          if not isinstance(filter_name, str):
            yield cls.new_issue(
                node, f'"{display_name}" {FILTER_NAME} not a str')
            filter_name = None
          else:
            if filter_name not in FILTER_NAMES:
              yield cls.new_issue(
                  node,
                  f'"{display_name}:" Unknown {FILTER_NAME}: "{filter_name}"')
              filter_name = None

      # We do not know which filter type is in play, so give up.
      if filter_name is None:
        return

      if filter_name == DATE_RANGE:
        if TIME_START not in filter_field or TIME_END not in filter_field:
          yield cls.new_issue(
              node, f'"{display_name}" must have {TIME_START} and {TIME_END}')
        else:
          start = filter_field[TIME_START]
          end = filter_field[TIME_END]
          if not isinstance(start, str) or not isinstance(end, str):
            yield cls.new_issue(
                node,
                f'"{display_name}" {FILTER_NAME} '
                f'{TIME_START} and {TIME_END} must be str: {start} {end}')
          else:
            start_datetime = None
            end_datetime = None
            try:
              start_datetime = parse_filter_time(start)
            except ValueError:
              yield cls.new_issue(
                  node, f'unable to parse {TIME_START}: {start}')

            try:
              end_datetime = parse_filter_time(end)
            except ValueError:
              yield cls.new_issue(
                  node, f'unable to parse {TIME_END}: {end}')

            if start_datetime and end_datetime:
              if start_datetime >= end_datetime:
                yield cls.new_issue(
                    node,
                    f'{TIME_START} must be before {TIME_END}: '
                    f'{start_datetime} .. {end_datetime}')
        return

      # The rest all must have property_value.
      if PROPERTY_VALUE not in filter_field:
        yield cls.new_issue(node, f'{filter_name} requires {PROPERTY_VALUE}')
        return

      value = filter_field[PROPERTY_VALUE]
      if not isinstance(value, str):
        yield cls.new_issue(
            node, f'{filter_name} {PROPERTY_VALUE} must be an string')

      if filter_name == LAST_N_DAYS:
        try:
          value = int(value)
        except ValueError:
          yield cls.new_issue(
              node, f'{filter_name} {PROPERTY_VALUE} must be a quoted integer')
        return

      # EQUALS and LIST_CONTAINS require a property_name,
      # but no specific constraints on the value string.
      if PROPERTY_NAME not in filter_field:
        yield cls.new_issue(node, f'{filter_name} requires {PROPERTY_NAME}')
      else:
        property_name = filter_field[PROPERTY_NAME]
        if not isinstance(property_name, str):
          yield cls.new_issue(
              node, f'{filter_name} {PROPERTY_NAME} must be a str')

        # TODO(schwehr): Make sure the property is in the schema.

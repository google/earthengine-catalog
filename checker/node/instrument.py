"""Check for instrument fields.

All instrument fields are a list of one or more strings.

- platforms - Unique name of the specific platform to which the instrument
  is attached. This might mean the satellite name (e.g., ISS for GEDI or
  Suomi NPP for VIIRS)
- instruments - Name of instrument or sensor used (e.g., MODIS, ASTER, OLI,
  Canon F-1)
- constellation - Name of the constellation to which the platform belongs.
- mission - Name of the mission for which data is collected. Not currently
  allowed for Earth Engine datasets
- gsd number - Not covered in this check. Ground Sample Distance at the sensor,
  in meters (m), must be greater than 0

https://github.com/radiantearth/stac-spec/blob/master/item-spec/common-metadata.md#instrument

See also:
- eo_extension.py for ground sample distance (GSD) of pixels in meters (m)
"""

import collections
import re
from typing import Any, Iterator

from checker import stac

SUMMARIES = 'summaries'

PLATFORM = 'platform'
INSTRUMENTS = 'instruments'
CONSTELLATION = 'constellation'
MISSION = 'mission'

STR_RE = r'[A-Z][-_\+\(\) a-zA-Z0-9]{1,64}'
MAX_ENTRIES = 7


class Check(stac.NodeCheck):
  """Checks the instrument fields."""
  name = 'instrument'

  # TODO(schwehr): Consider moving this classmethod to stac.NodeCheck.
  @classmethod
  def check_sorted_list_of_str(
      cls, node: stac.Node, name: str, values: Any, max_entries: int, regex: str
      ) -> Iterator[stac.Issue]:
    if not isinstance(values, list):
      yield cls.new_issue(node, f'{name} must be a list')
    elif not values:
      yield cls.new_issue(node, f'{name} must have at least 1 entry')
    else:
      for value in values:
        if not isinstance(value, str):
          yield cls.new_issue(node, f'values of {name} must be a str')
        elif not re.fullmatch(STR_RE, value):
          yield cls.new_issue(node, f'"{value}" not valid')
      num_values = len(values)
      if num_values > max_entries:
        yield cls.new_issue(
            node, f'Too many values for {name}: {num_values} > {max_entries}')
      if sorted(values) != values:
        yield cls.new_issue(
            node, f'{name} entries must be sorted')
      counts = collections.Counter(values)
      duplicates = ', '.join(sorted(
          [name for name, count in counts.items() if count > 1]))
      if duplicates:
        yield cls.new_issue(node, f'{name} duplicates: {duplicates}')

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if SUMMARIES not in node.stac: return
    summaries = node.stac[SUMMARIES]
    if not isinstance(summaries, dict): return

    if PLATFORM in summaries:
      platforms = summaries[PLATFORM]
      yield from cls.check_sorted_list_of_str(
          node, PLATFORM, platforms, MAX_ENTRIES, STR_RE)

    if INSTRUMENTS in summaries:
      instruments = summaries[INSTRUMENTS]
      yield from cls.check_sorted_list_of_str(
          node, INSTRUMENTS, instruments, MAX_ENTRIES, STR_RE)

    if CONSTELLATION in summaries:
      constellations = summaries[CONSTELLATION]
      yield from cls.check_sorted_list_of_str(
          node, CONSTELLATION, constellations, MAX_ENTRIES, STR_RE)

    if MISSION in summaries:
      yield cls.new_issue(node, f'{MISSION} not currently allowed')

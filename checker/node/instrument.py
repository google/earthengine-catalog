"""Check for instrument fields.

All instrument fields are a list of one or more strings.

- platforms - Unique name of the specific platform to which the instrument
  is attached.
- instruments - Name of instrument or sensor used (e.g., MODIS, ASTER, OLI,
  Canon F-1).
- constellation - Name of the constellation to which the platform belongs.
- mission - Name of the mission for which data is collected. Not currently
  allowed for Earth Engine datasets
- gsd number - Not covered in this check. Ground Sample Distance at the sensor,
  in meters (m), must be greater than 0

https://github.com/radiantearth/stac-spec/blob/master/item-spec/common-metadata.md#instrument

See also:
- eo_extension.py for GSD ground separation distance of pixels in meters (m)
"""

# TODO(schwehr): Should have definitions for known platforms, instruments,
# constellations, and missions.

import collections
import re
from typing import Iterator

from checker import stac

SUMMARIES = 'summaries'

PLATFORM = 'platform'
INSTRUMENTS = 'instruments'
CONSTELLATION = 'constellation'
MISSION = 'mission'

STR_RE = r'[A-Z][-_\+\(\) a-zA-Z0-9]{1,64}'
MAX_ENTRIES = 7


class Check(stac.NodeCheck):
  """Checks the intrument fields."""
  name = 'instrument'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if SUMMARIES not in node.stac: return
    summaries = node.stac[SUMMARIES]
    if not isinstance(summaries, dict): return

    if PLATFORM in summaries:
      platforms = summaries[PLATFORM]
      if not isinstance(platforms, list):
        yield cls.new_issue(node, f'{PLATFORM} must be a list')
      elif not platforms:
        yield cls.new_issue(node, f'{PLATFORM} must have at least 1 entry')
      else:
        for platform in platforms:
          if not isinstance(platform, str):
            yield cls.new_issue(node, f'{PLATFORM}s must be a str')
          elif not re.fullmatch(STR_RE, platform):
            yield cls.new_issue(node, f'"{platform}" not valid')
        num_platforms = len(platforms)
        if num_platforms > MAX_ENTRIES:
          yield cls.new_issue(
              node, f'Too many {PLATFORM}s: {num_platforms} > {MAX_ENTRIES}')
        if sorted(platforms) != platforms:
          yield cls.new_issue(
              node, f'{PLATFORM} entries must be sorted')
        counts = collections.Counter(platforms)
        duplicates = ', '.join(sorted(
            [name for name, count in counts.items() if count > 1]))
        if duplicates:
          yield cls.new_issue(node, f'{PLATFORM} duplicates: {duplicates}')

    if INSTRUMENTS in summaries:
      instruments = summaries[INSTRUMENTS]
      if not isinstance(instruments, list):
        yield cls.new_issue(node, f'{INSTRUMENTS} must be a list')
      elif not instruments:
        yield cls.new_issue(node, f'{INSTRUMENTS} must have at least 1 entry')
      else:
        for instrument in instruments:
          if not isinstance(instrument, str):
            yield cls.new_issue(node, f'{INSTRUMENTS} must be a str')
          elif not re.fullmatch(STR_RE, instrument):
            yield cls.new_issue(node, f'"{instrument}" not valid')
        num_instruments = len(instruments)
        if num_instruments > MAX_ENTRIES:
          yield cls.new_issue(
              node,
              f'Too many {INSTRUMENTS}: {num_instruments} > {MAX_ENTRIES}')
        if sorted(instruments) != instruments:
          yield cls.new_issue(
              node, f'{INSTRUMENTS} entries must be sorted')
        counts = collections.Counter(instruments)
        duplicates = ', '.join(sorted(
            [name for name, count in counts.items() if count > 1]))
        if duplicates:
          yield cls.new_issue(node, f'{INSTRUMENTS} duplicates: {duplicates}')

    if CONSTELLATION in summaries:
      constellations = summaries[CONSTELLATION]
      if not isinstance(constellations, list):
        yield cls.new_issue(node, f'{CONSTELLATION} must be a list')
      elif not constellations:
        yield cls.new_issue(node, f'{CONSTELLATION} must have at least 1 entry')
      else:
        for constellation in constellations:
          if not isinstance(constellation, str):
            yield cls.new_issue(node, f'{CONSTELLATION}s must be a str')
          elif not re.fullmatch(STR_RE, constellation):
            yield cls.new_issue(node, f'"{constellation}" not valid')
        num_constellations = len(constellations)
        if num_constellations > MAX_ENTRIES:
          yield cls.new_issue(
              node,
              f'Too many {CONSTELLATION}s: '
              f'{num_constellations} > {MAX_ENTRIES}')
        if sorted(constellations) != constellations:
          yield cls.new_issue(
              node, f'{CONSTELLATION} entries must be sorted')
        counts = collections.Counter(constellations)
        duplicates = ', '.join(sorted(
            [name for name, count in counts.items() if count > 1]))
        if duplicates:
          yield cls.new_issue(node, f'{CONSTELLATION} duplicates: {duplicates}')

    if MISSION in summaries:
      yield cls.new_issue(node, f'{MISSION} not currently allowed')

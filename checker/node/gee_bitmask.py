"""Check gee:bitmask.

gee:bitmask lives inside of eo:bands, which is a part of the
Electro-Optical (eo) extension.

The rules for gee:bitmasks:

- 'gee:bitmask' is a field within an 'eo:band'
- There cannot be a 'gee:bitmask' if there is a 'gee:class' in an 'eo:band'.
  These are also exclusive with respect to gee:offset and gee:scale
- A 'gee:bitmask' is a dict that must have two fields:
  - 'total_bit_count' is the sum of all the bits in each of the mask parts. It
    must be 64 bits or less. The count must fit within the available bits for
    the band, but that is not currently checked
  - 'bitmask_parts' is a list of 1 or more parts specifying how each groups of
    bits should be interpreted. Each part contains:
      - 'description' is a string of 2 to 220 characters
      - 'bit_count' is the number of bits for this group
      - 'first_bit' is the index of the first bit of this part. The first_bits
        must come in a sorted order
      - 'values' is an optional list of descriptions for the possible values
        for this part.  Each value entry contains:
        - 'value' is an integer being described. They must be sorted
        - 'description' is a string is 2 to 260 characters

See also:
- eo_extension.py
- https://spatialthoughts.com/2021/08/19/qa-bands-bitmasks-gee/

Jsonnet Example:

summaries: {
  'eo:bands': [{
      name: 'cloud_shadow_mask',
      'gee:bitmask': {
        bitmask_parts: [{
            description: 'Cloud/shadow mask',
            bit_count: 1,
            values: [
              {value: 0, description: 'No clouds or cloud shadow'},
              {value: 1, description: 'Clouds'},
              {value: 2, description: 'Shadow'},
              {value: 3, description: 'Unused'}],
            first_bit: 0}],
        total_bit_count: 2,
      }}],
"""

from typing import Iterator

from checker import stac

SUMMARIES = 'summaries'
EO_BANDS = 'eo:bands'
NAME = 'name'
BITMASK = 'gee:bitmask'
TOTAL_BIT_COUNTS = 'total_bit_count'
PARTS = 'bitmask_parts'

BIT_COUNT = 'bit_count'
DESCRIPTION = 'description'
FIRST_BIT = 'first_bit'
VALUES = 'values'
VALUE = 'value'


class Check(stac.NodeCheck):
  """Checks gee:bitmask."""
  name = 'gee_bitmask'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if SUMMARIES not in node.stac: return
    summaries = node.stac[SUMMARIES]
    if not isinstance(summaries, dict): return
    if EO_BANDS not in summaries: return
    bands = summaries[EO_BANDS]

    for band in bands:
      if BITMASK not in band: continue
      name = band.get(NAME, 'unknown')
      bitmask = band[BITMASK]
      if not isinstance(bitmask, dict):
        yield cls.new_issue(node, f'{name} {BITMASK} must be a dict')
        continue
      if PARTS not in bitmask:
        yield cls.new_issue(node, f'{name} {BITMASK} must have {PARTS}')
        continue
      parts = bitmask[PARTS]
      if not isinstance(parts, list):
        yield cls.new_issue(node, f'{name} {PARTS} must be a list')
        continue

      expected_first_bit = 0
      # Do not warn about the first_bit if there are other troubles.
      found_bit_troubles = False

      for part in parts:
        description = part.get(DESCRIPTION)
        if DESCRIPTION not in part:
          yield cls.new_issue(node, f'{name} part missing {DESCRIPTION}')
        elif not isinstance(description, str):
          yield cls.new_issue(
              node, f'{name} part {DESCRIPTION} must be a str')
        else:
          size = len(description)
          if len(description) < 2:
            yield cls.new_issue(
                node, f'{name} part {DESCRIPTION} too short: {size}')
          if len(description) > 220:
            yield cls.new_issue(
                node, f'{name} part {DESCRIPTION} too long: {size}')

        bit_count = part.get(BIT_COUNT)
        if BIT_COUNT not in part:
          yield cls.new_issue(node, f'{name} part missing {BIT_COUNT}')
        elif not isinstance(bit_count, int):
          yield cls.new_issue(
              node, f'{name} part {BIT_COUNT} must be an int')
          found_bit_troubles = True
        else:
          if bit_count < 1:
            found_bit_troubles = True
            yield cls.new_issue(
                node, f'{name} part {BIT_COUNT} too small: {bit_count}')
          # The maximum can be increased if there is a good reason.
          # TODO(schwehr): Use 8 for bands that are uint_8
          if bit_count > 16:
            found_bit_troubles = True
            yield cls.new_issue(
                node, f'{name} part {BIT_COUNT} too large: {bit_count}')

        first_bit = part.get(FIRST_BIT)
        if FIRST_BIT not in part:
          found_bit_troubles = True
          yield cls.new_issue(node, f'{name} part missing {FIRST_BIT}')
        elif not isinstance(first_bit, int):
          found_bit_troubles = True
          yield cls.new_issue(
              node, f'{name} part {FIRST_BIT} must be an int')
        else:
          if first_bit < 0:
            found_bit_troubles = True
            yield cls.new_issue(
                node, f'{name} part {FIRST_BIT} too small: {first_bit}')
          # The maximum can be increased if there is a good reason.
          # TODO(schwehr): Use a maximum based on the band's data type
          elif first_bit > 63:
            found_bit_troubles = True
            yield cls.new_issue(
                node, f'{name} part {FIRST_BIT} too large: {first_bit}')
          elif first_bit != expected_first_bit:
            if not found_bit_troubles:
              found_bit_troubles = True
              yield cls.new_issue(
                  node,
                  f'{name} {FIRST_BIT} should be {expected_first_bit}, '
                  f'but found {first_bit}')
          elif not found_bit_troubles:
            expected_first_bit += bit_count

        values = part.get(VALUES)
        last_value = -1
        if VALUES not in part:
          # TODO(schwehr): Is there a way to tell if values must be present?
          pass
        elif not isinstance(values, list):
          yield cls.new_issue(node, f'{name} part {VALUES} must be a list')
        else:
          if not values:
            yield cls.new_issue(
                node, f'{name} part {VALUES} must have at least 1 entry')
          for value_entry in values:
            if not isinstance(value_entry, dict):
              yield cls.new_issue(
                  node, f'{name} part {VALUES} entry must be a dict')
            else:
              max_value = 2**bit_count - 1
              value = value_entry.get(VALUE)
              if VALUE not in value_entry:
                yield cls.new_issue(
                    node, f'{name} part {VALUES} entry must have {VALUE}')
              elif not isinstance(value, int):
                yield cls.new_issue(node, f'{name} part {VALUE} must be an int')
              elif value < 0:
                yield cls.new_issue(
                    node, f'{name} part {VALUE} too small: {value}')
              elif value > max_value:
                yield cls.new_issue(
                    node,
                    f'{name} part {VALUE} too large: {value} > {max_value}')
              else:
                if value <= last_value:
                  yield cls.new_issue(
                      node,
                      f'{name} part {VALUE} values must be sorted: '
                      f'{value} <= {last_value}')
                else:
                  last_value = value

              description = value_entry.get(DESCRIPTION)
              if DESCRIPTION not in value_entry:
                yield cls.new_issue(
                    node, f'{name} part {VALUE} missing {DESCRIPTION}')
              elif not isinstance(description, str):
                yield cls.new_issue(
                    node, f'{name} part {VALUE} {DESCRIPTION} must be a str')
              else:
                size = len(description)
                if len(description) < 2:
                  yield cls.new_issue(
                      node,
                      f'{name} part {VALUE} {DESCRIPTION} too short: {size}')
                if len(description) > 260:
                  yield cls.new_issue(
                      node,
                      f'{name} part {VALUE} {DESCRIPTION} too long: {size}')

      try:
        bit_counts = [int(part[BIT_COUNT]) for part in parts]
      except ValueError:
        bit_counts = []

      total_bit_counts = bitmask.get(TOTAL_BIT_COUNTS)
      if found_bit_troubles:
        # Do not bother checking if there were other troubles.
        pass
      elif TOTAL_BIT_COUNTS not in bitmask:
        yield cls.new_issue(
            node, f'{name} {BITMASK} missing {TOTAL_BIT_COUNTS}')
      elif not isinstance(total_bit_counts, int):
        yield cls.new_issue(
            node, f'{name} {BITMASK} {TOTAL_BIT_COUNTS} must be an int')
      else:
        if total_bit_counts < 1:
          yield cls.new_issue(
              node,
              f'{name} {BITMASK} {TOTAL_BIT_COUNTS} too small:'
              f' {total_bit_counts}')
        elif total_bit_counts > 63:
          # TODO(schwehr): Maybe add the max bit count and make a const.
          # The max may change if we can detect the bit size of the band.
          # The max is the bit size of the band - 1.  If the size is the bit
          # size of the band, there is no need for a gee:bitmask.
          yield cls.new_issue(
              node, f'{name} {BITMASK} {TOTAL_BIT_COUNTS} too large: '
              f'{total_bit_counts}')
        else:
          found_sum = sum(bit_counts)
          if found_sum != total_bit_counts:
            yield cls.new_issue(
                node,
                f'{name} {BITMASK} {TOTAL_BIT_COUNTS} does not match the sum: '
                f'{total_bit_counts} != {found_sum}')

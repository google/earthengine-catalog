"""Checks for schemas.

A gee:schema defines properties on ee.Image(s) for an ee.Image or
ee.ImageCollection dataset.  For a Table or TableCollection, a gee:schema
defines the columns in the table(s).

The rules for schemas:

- The gee:schema field is a list with 1 to 300 property entries that are each
  a dict
- Each entry must have 3 fields: description, name, type
- Each entry can optionally have a units field
- The type is any one of the SchemaType values except PROPERTY_TYPE_UNSPECIFIED
  and UNKNOWN
- The name starts with a letter and can be from 2 to 110 letters, numbers,
  dashes, or underscores.
- Names cannot be repeated within a particular schema
- The description is a string from 3 to 1800 characters
- It is best practice, but not required, to not repeat description strings

Example schema in Jsonnet:

  summaries: {
    'gee:schema': [
      {
        name: 'area_in_meters',
        description: 'Area in square meters of the polygon.',
        type: ee_const.var_type.double,
        units: 'm^2',
      },
"""

import enum
import re
from typing import Iterator

from checker import stac
from checker import units

GEE_SCHEMA = 'gee:schema'
SUMMARIES = 'summaries'

DESCRIPTION = 'description'
NAME = 'name'
TYPE = 'type'
UNITS = 'units'

REQUIRED_KEYS = frozenset({DESCRIPTION, NAME, TYPE})
OPTIONAL_KEYS = frozenset({UNITS})
ALL_KEYS = REQUIRED_KEYS.union(OPTIONAL_KEYS)

MAX_SCHEMA_SIZE = 300
MIN_NAME_SIZE = 2
MAX_NAME_SIZE = 110
MIN_DESCRIPTION_SIZE = 3
MAX_DESCRIPTION_SIZE = 4000
MIN_UNIT_SIZE = 1
MAX_UNIT_SIZE = 20


class SchemaType(str, enum.Enum):
  DOUBLE = 'DOUBLE'
  GEOMETRY = 'GEOMETRY'
  INT = 'INT'
  STRING = 'STRING'
  INT_LIST = 'INT_LIST'
  STRING_LIST = 'STRING_LIST'
  DOUBLE_LIST = 'DOUBLE_LIST'
  PROPERTY_TYPE_UNSPECIFIED = 'PROPERTY_TYPE_UNSPECIFIED'  # No longer allowed
  UNKNOWN = 'not a valid schema'  # For bad values.


class Check(stac.NodeCheck):
  """Checks for schemas."""
  name = 'schema'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if SUMMARIES not in node.stac: return
    summaries = node.stac[SUMMARIES]
    if not isinstance(summaries, dict): return

    if GEE_SCHEMA not in summaries: return
    schema = summaries[GEE_SCHEMA]

    if not isinstance(schema, list):
      yield cls.new_issue(node, 'Schema must be a list')
      return

    if len(schema) > MAX_SCHEMA_SIZE:
      yield cls.new_issue(node, f'Too many schema entries: {len(schema)}')

    names = set()

    for entry in schema:
      if not isinstance(entry, dict):
        yield cls.new_issue(node, 'Schema entries must be a dict')
        return

      keys = frozenset(entry)
      if not REQUIRED_KEYS.issubset(keys):
        diff = ', '.join(sorted(REQUIRED_KEYS.difference(keys)))
        yield cls.new_issue(node, f'Schema entry missing field(s): {diff}')

      if not keys.issubset(ALL_KEYS):
        diff = ', '.join(sorted(keys.difference(ALL_KEYS)))
        yield cls.new_issue(node, f'Unexpected field(s): {diff}')

      if TYPE in entry:
        entry_type = entry[TYPE]
        try:
          schema_type = SchemaType(entry_type)
        except ValueError:
          schema_type = SchemaType.UNKNOWN

        if schema_type == SchemaType.UNKNOWN:
          yield cls.new_issue(node, f'Schema type unknown: "{entry_type}"')

        if schema_type == SchemaType.STRING and UNITS in entry:
          yield cls.new_issue(node, 'Units not allowed for a string type')

      if NAME in entry:
        name = entry[NAME]
        if not isinstance(name, str):
          yield cls.new_issue(node, f'"{NAME}" must be a str')
        else:
          if name in names:
            yield cls.new_issue(node, f'"{NAME}" is a duplicate: "{name}"')
          else:
            names.add(name)
          if schema_type == SchemaType.PROPERTY_TYPE_UNSPECIFIED:
            yield cls.new_issue(
                node, f'Cannot be PROPERTY_TYPE_UNSPECIFIED: {name}')

          size = len(name)
          if size < MIN_NAME_SIZE:
            yield cls.new_issue(
                node,
                f'{NAME} "{name}" too short: {size} is below limit'
                f' {MIN_NAME_SIZE}',
            )
          elif size > MAX_NAME_SIZE:
            yield cls.new_issue(
                node,
                f'{NAME} "{name}" too long: {size} exceeds limit'
                f' {MAX_NAME_SIZE}',
            )
          # gee:schema key names refer either to table (FeatureCollection)
          # column names or to asset properties.
          for i, c in enumerate(name):
            if i == 0 and not (c.isascii() and c.isalpha()):
              yield cls.new_issue(
                  node, f'{NAME} "{name}" does not start with an ascii letter'
              )
            elif not (c.isascii() and (c.isalnum() or c in '_-')):
              yield cls.new_issue(
                  node,
                  f'{NAME} "{name}" contains character "{c}" not in'
                  ' [a-zA-Z0-9_-]',
              )
      if DESCRIPTION in entry:
        description = entry[DESCRIPTION]
        if not isinstance(description, str):
          yield cls.new_issue(node, f'"{DESCRIPTION}" must be a str')
        else:
          # TODO(schwehr): Do a better check of the description.
          size = len(description)
          if size < MIN_DESCRIPTION_SIZE:
            yield cls.new_issue(
                node,
                f'{DESCRIPTION} too short: {size} is below limit'
                f' {MIN_DESCRIPTION_SIZE}',
            )
          elif size > MAX_DESCRIPTION_SIZE:
            yield cls.new_issue(
                node,
                f'{DESCRIPTION} too long: {size} exceeds limit'
                f' {MAX_DESCRIPTION_SIZE}',
            )

      if UNITS in entry:
        schema_units = entry[UNITS]
        if not isinstance(schema_units, str):
          yield cls.new_issue(node, 'Units must be a str')
        else:
          size = len(schema_units)
          if size < MIN_UNIT_SIZE:
            yield cls.new_issue(
                node,
                f'{UNITS} "{schema_units}" too short: {size} is below limit'
                f' {MIN_UNIT_SIZE}',
            )
          elif size > MAX_UNIT_SIZE:
            yield cls.new_issue(
                node,
                f'{UNITS} "{schema_units}" too long: {size} exceeds limit'
                f' {MAX_UNIT_SIZE}',
            )
          if schema_units not in units.UNITS:
            yield cls.new_issue(node, f'Schema units unknown: {schema_units}')

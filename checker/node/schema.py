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
- The name starts with a letter and can be from 2 to 50 letters or numbers
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


class SchemaType(str, enum.Enum):
  DOUBLE = 'DOUBLE'
  GEOMETRY = 'GEOMETRY'
  INT = 'INT'
  STRING = 'STRING'
  INT_LIST = 'INT_LIST'
  STRING_LIST = 'STRING_LIST'
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

          if not re.fullmatch('[a-zA-Z][_a-zA-Z0-9]{1,49}', name):
            yield cls.new_issue(node, f'Invalid name: "{name}"')

      if DESCRIPTION in entry:
        description = entry[DESCRIPTION]
        if not isinstance(description, str):
          yield cls.new_issue(node, f'"{DESCRIPTION}" must be a str')
        else:
          # TODO(schwehr): Do a better check of the description.
          size = len(description)
          if size < 3:
            yield cls.new_issue(node, f'{DESCRIPTION} too short: {size}')
          elif size > 1800:
            yield cls.new_issue(node, f'{DESCRIPTION} too long: {size}')

      if UNITS in entry:
        schema_units = entry[UNITS]
        if not isinstance(schema_units, str):
          yield cls.new_issue(node, 'Units must be a str')
        else:
          size = len(schema_units)
          if size < 1:
            yield cls.new_issue(node, f'{UNITS} too short: {size}')
          elif size > 20:
            yield cls.new_issue(node, f'{UNITS} too long: {size}')

          if schema_units not in units.UNITS:
            yield cls.new_issue(node, f'Schema units unknown: {schema_units}')

"""Checks for schemas.

There are two types of properties field on Earth Engine datasets:
gee:properties and gee:schema.  They have the same structure within the fields.

For an Image:

1. gee:properties - the properties on the ee.Image.

For an ImageCollection:

1. gee:schema - properties on individual assets within a collection
2. gee:properties - properties on the collection asset as a whole

For a Table:

1. gee:schema - Describes the column in the ee.FeatureCollection
2. gee:properties - TODO(simonf): Describe

For a TableCollection:

1. gee:schema - Describes the column in the constituent ee.FeatureCollections

The rules for schemas:

- The gee:properties and gee:schema fields are a list with 1 to 300 schema
  entries that are each a dict
- Each entry must have 3 fields: description, name, type
- Each entry can optionally have a units field
- The type is any one of the SchemaType values except PROPERTY_TYPE_UNSPECIFIED
  and UNKNOWN
- The name starts with a letter and can be from 2 to 50 letters or numbers
- Names cannot be repeated within a particular schema
- The description is a string from 3 to 1800 characters
- It is best practice, but not required, to not repeat description strings

- TODO(schwehr):
  The units field is a string from the ALL_UNITS list.  In the future, it is
  likely that this list will be merged with the band units and there needs to be
  a glossary for units.

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

GEE_SCHEMA = 'gee:schema'
GEE_PROPERTIES = 'gee:properties'
SUMMARIES = 'summaries'

DESCRIPTION = 'description'
NAME = 'name'
TYPE = 'type'
UNITS = 'units'

REQUIRED_KEYS = frozenset({DESCRIPTION, NAME, TYPE})
OPTIONAL_KEYS = frozenset({UNITS})
ALL_KEYS = REQUIRED_KEYS.union(OPTIONAL_KEYS)

# TODO(schwehr): The entire catalog needs a master table of units.
# ALL_UNITS = ['cm', 'knots', 'm', 'm^2', 'millibars', 'nautical miles']

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
    if node.type == stac.StacType.CATALOG:
      # Schemas are under summaries, which should not be present in a catalog
      return

    if SUMMARIES not in node.stac:
      return
    summaries = node.stac[SUMMARIES]

    schema_field = summaries.get(GEE_SCHEMA, [])
    properties_field = summaries.get(GEE_PROPERTIES, [])

    if not schema_field and not properties_field:
      return

    if node.gee_type == stac.GeeType.IMAGE:
      if schema_field:
        yield cls.new_issue(
            node, f'{stac.GeeType.IMAGE} cannot have {GEE_SCHEMA}')

    schemas = [x for x in [schema_field, properties_field] if x]
    for schema_num in range(len(schemas)):
      schema = schemas[schema_num]

      if not isinstance(schema, list):
        yield cls.new_issue(node, 'Schema must be a dict')
        continue

      if len(schema) > MAX_SCHEMA_SIZE:
        yield cls.new_issue(node, f'Too many schema entries: {len(schema)}')

      names = set()

      for entry in schema:
        if not isinstance(entry, dict):
          yield cls.new_issue(node, 'Schema entries must be a dict')
          continue

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
            if len(description) < 3:
              yield cls.new_issue(
                  node, f'Description too short: {len(description)}')
            elif len(description) > 1800:
              yield cls.new_issue(
                  node, f'Description too long: {len(description)}')

        if UNITS in entry:
          units = entry[UNITS]
          if not isinstance(units, str):
            yield cls.new_issue(node, 'Units must be a str')
          else:
            pass
            # TODO(schwehr): turn on a more stringent units check later.
            # if units not in ALL_UNITS:
            #   yield cls.new_issue(node, f'Units unknown: {units}')

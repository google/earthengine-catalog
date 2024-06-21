"""Tests for schema."""

from checker import stac
from checker import test_utils
from checker.node import schema
from absl.testing import absltest

IMAGE_COLLECTION = stac.GeeType.IMAGE_COLLECTION


class ValidSchemaTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = schema.Check

  def test_catalog_without(self):
    self.assert_catalog({})

  def test_missing_summaries(self):
    self.assert_collection({}, gee_type=IMAGE_COLLECTION)

  def test_summaries_not_dict(self):
    self.assert_collection(
        {'summaries': 'not a dict'}, gee_type=IMAGE_COLLECTION)

  def test_smallest_valid_schema(self):
    self.assert_collection(
        {'summaries': {'gee:schema': [{
            'description': 'A thing', 'name': 'ab', 'type': 'INT'}]}},
        gee_type=IMAGE_COLLECTION)

  def test_valid_schema(self):
    self.assert_collection(
        {'summaries': {'gee:schema': [{
            'description': 'A thing', 'name': 'ab-_',
            'type': 'INT', 'units': 'm'}]}},
        gee_type=IMAGE_COLLECTION)

  def test_valid_image_collection(self):
    self.assert_collection(
        {'summaries': {
            'gee:schema': [
                {'description': 'A thing', 'name': 'ab', 'type': 'INT'},
                {'description': 'C thing', 'name': 'cd', 'type': 'STRING'}]}},
        gee_type=IMAGE_COLLECTION)


class ErrorSchemaTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = schema.Check

  def test_bad_schema_not_dict(self):
    self.assert_collection(
        {'summaries': {'gee:schema': 'not a dict'}},
        'Schema must be a list',
        gee_type=IMAGE_COLLECTION)

  def test_bad_too_many_entries(self):
    entries = [
        {'description': f'A thing {i}', 'name': f'a{i}', 'type': 'INT'}
        for i in range(301)]
    self.assert_collection(
        {'summaries': {'gee:schema': entries}},
        'Too many schema entries: 301',
        gee_type=IMAGE_COLLECTION)

  def test_bad_entry_not_a_dict(self):
    self.assert_collection(
        {'summaries': {'gee:schema': ['not a dict']}},
        'Schema entries must be a dict',
        gee_type=IMAGE_COLLECTION)

  def test_bad_missing_description_field(self):
    self.assert_collection(
        {'summaries': {'gee:schema': [{'name': 'ab', 'type': 'INT'}]}},
        'Schema entry missing field(s): description',
        gee_type=IMAGE_COLLECTION)

  def test_bad_missing_all_field(self):
    self.assert_collection(
        {'summaries': {'gee:schema': [{}]}},
        'Schema entry missing field(s): description, name, type',
        gee_type=IMAGE_COLLECTION)

  def test_bad_extra_field(self):
    self.assert_collection(
        {'summaries': {'gee:schema': [{
            'bogus': 1, 'description': 'A thing',
            'name': 'ab', 'type': 'INT'}]}},
        'Unexpected field(s): bogus',
        gee_type=IMAGE_COLLECTION)

  def test_bad_type_property_type_unspecified(self):
    self.assert_collection(
        {'summaries': {'gee:schema': [{
            'description': 'A thing', 'name': 'ab',
            'type': 'PROPERTY_TYPE_UNSPECIFIED'}]}},
        'Cannot be PROPERTY_TYPE_UNSPECIFIED: ab',
        gee_type=IMAGE_COLLECTION)

  def test_bad_type(self):
    self.assert_collection(
        {'summaries': {'gee:schema': [{
            'description': 'A thing', 'name': 'ab', 'type': 123}]}},
        'Schema type unknown: "123"',
        gee_type=IMAGE_COLLECTION)

  def test_bad_type_string_with_units(self):
    self.assert_collection(
        {'summaries': {'gee:schema': [{
            'description': 'A thing', 'name': 'ab', 'type': 'STRING',
            'units': 'm'}]}},
        'Units not allowed for a string type',
        gee_type=IMAGE_COLLECTION)

  def test_bad_name_not_str(self):
    self.assert_collection(
        {'summaries': {'gee:schema': [
            {'description': 'A thing', 'name': 2, 'type': 'INT'}]}},
        '"name" must be a str',
        gee_type=IMAGE_COLLECTION)

  def test_bad_duplicate_name(self):
    self.assert_collection(
        {'summaries': {'gee:schema': [
            {'description': 'A thing', 'name': 'ab', 'type': 'INT'},
            {'description': 'B thing', 'name': 'ab', 'type': 'INT'}]}},
        '"name" is a duplicate: "ab"',
        gee_type=IMAGE_COLLECTION)

  def test_bad_name_too_short(self):
    name = 'a'
    self.assert_collection(
        {
            'summaries': {
                'gee:schema': [{
                    'description': 'A thing',
                    'name': name,
                    'type': 'INT',
                }]
            }
        },
        f'name "{name}" too short: 1 is below limit 2',
        gee_type=IMAGE_COLLECTION,
    )

  def test_bad_name_too_long(self):
    name = 'a' * 111
    self.assert_collection(
        {
            'summaries': {
                'gee:schema': [{
                    'description': 'A thing',
                    'name': name,
                    'type': 'INT',
                }]
            }
        },
        f'name "{name}" too long: 111 exceeds limit 110',
        gee_type=IMAGE_COLLECTION,
    )

  def test_bad_name_characters(self):
    name = 'Bad name*'
    self.assert_collection(
        {
            'summaries': {
                'gee:schema': [{
                    'description': 'A thing',
                    'name': name,
                    'type': 'INT',
                }]
            }
        },
        [
            f'name "{name}" contains character "{c}" not in [a-zA-Z0-9_-]'
            for c in ' *'
        ],
        gee_type=IMAGE_COLLECTION,
    )

  def test_bad_name_start_character(self):
    name = '1BadName'
    self.assert_collection(
        {
            'summaries': {
                'gee:schema': [{
                    'description': 'A thing',
                    'name': name,
                    'type': 'INT',
                }]
            }
        },
        f'name "{name}" does not start with an ascii letter',
        gee_type=IMAGE_COLLECTION,
    )

  def test_bad_description_not_str(self):
    self.assert_collection(
        {'summaries': {'gee:schema': [
            {'description': 123, 'name': 'ab', 'type': 'INT'}]}},
        '"description" must be a str',
        gee_type=IMAGE_COLLECTION)

  def test_bad_description_too_short(self):
    description = 'a'
    self.assert_collection(
        {
            'summaries': {
                'gee:schema': [{
                    'description': description,
                    'name': 'ab',
                    'type': 'INT',
                }]
            }
        },
        'description too short: 1 is below limit 3',
        gee_type=IMAGE_COLLECTION,
    )

  def test_bad_description_too_long(self):
    description = 'a' * 4001
    self.assert_collection(
        {
            'summaries': {
                'gee:schema': [{
                    'description': description,
                    'name': 'ab',
                    'type': 'INT',
                }]
            }
        },
        'description too long: 4001 exceeds limit 4000',
        gee_type=IMAGE_COLLECTION,
    )

  def test_bad_units_not_str(self):
    self.assert_collection(
        {'summaries': {'gee:schema': [
            {'description': 'A name', 'name': 'ab',
             'type': 'INT', 'units': 9}]}},
        'Units must be a str',
        gee_type=IMAGE_COLLECTION)

  def test_bad_units_too_short(self):
    self.assert_collection(
        {
            'summaries': {
                'gee:schema': [{
                    'units': '',
                    'description': 'A thing',
                    'name': 'ab',
                    'type': 'INT',
                }]
            }
        },
        ['units "" too short: 0 is below limit 1', 'Schema units unknown: '],
    )

  def test_bad_units_too_long(self):
    size = 21
    units = 'a' * size
    self.assert_collection(
        {
            'summaries': {
                'gee:schema': [{
                    'units': units,
                    'description': 'A thing',
                    'name': 'ab',
                    'type': 'INT',
                }]
            }
        },
        [
            f'units "{units}" too long: 21 exceeds limit 20',
            'Schema units unknown: ' + units,
        ],
    )

  def test_bad_units_unknown(self):
    self.assert_collection(
        {'summaries': {'gee:schema': [
            {'description': 'A name', 'name': 'ab', 'type': 'INT',
             'units': 'bogus'}]}},
        'Schema units unknown: bogus')


if __name__ == '__main__':
  absltest.main()

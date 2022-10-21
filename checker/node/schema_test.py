"""Tests for schema."""

import pathlib

from checker import stac
from checker.node import schema
import unittest

Check = schema.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
IMAGE_COLLECTION = stac.GeeType.IMAGE_COLLECTION
NONE = stac.GeeType.NONE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class SchemaTest(unittest.TestCase):

  def test_catalog_with_neither(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_smallest_valid_schema(self):
    stac_data = {'summaries': {'gee:schema': [{
        'description': 'A thing', 'name': 'ab', 'type': 'INT'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_schema(self):
    stac_data = {'summaries': {'gee:schema': [{
        'description': 'A thing', 'name': 'ab', 'type': 'INT', 'units': 'm'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_smallest_valid_properties(self):
    stac_data = {'summaries': {'gee:properties': [{
        'description': 'A thing', 'name': 'ab', 'type': 'INT'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_properties(self):
    stac_data = {'summaries': {'gee:properties': [{
        'description': 'A thing', 'name': 'ab', 'type': 'INT', 'units': 'cm'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_image_collection_with_both(self):
    stac_data = {'summaries': {
        'gee:properties': [{
            'description': 'A thing', 'name': 'ab', 'type': 'INT'}],
        'gee:schema': [{
            'description': 'C thing', 'name': 'cd', 'type': 'STRING'}],
    }}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_bad_image_cannot_have_properties(self):
    entries = [{'description': 'A thing', 'name': 'ab', 'type': 'INT'}]
    stac_data = {'summaries': {
        'gee:schema': entries, 'gee:properties': entries}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'image cannot have gee:schema')]
    self.assertEqual(expect, issues)

  def test_bad_schema_not_dict(self):
    stac_data = {'summaries': {'gee:schema': 'not a dict'}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Schema must be a dict')]
    self.assertEqual(expect, issues)

  def test_bad_too_many_entries(self):
    entries = [
        {'description': f'A thing {i}', 'name': f'a{i}', 'type': 'INT'}
        for i in range(301)]
    stac_data = {'summaries': {'gee:schema': entries}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Too many schema entries: 301')]
    self.assertEqual(expect, issues)

  def test_bad_entry_not_a_dict(self):
    stac_data = {'summaries': {'gee:schema': ['not a dict']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Schema entries must be a dict')]
    self.assertEqual(expect, issues)

  def test_bad_missing_description_field(self):
    stac_data = {'summaries': {'gee:schema': [{'name': 'ab', 'type': 'INT'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Schema entry missing field(s): description')]
    self.assertEqual(expect, issues)

  def test_bad_missing_all_field(self):
    stac_data = {'summaries': {'gee:schema': [{}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Schema entry missing field(s): description, name, type')]
    self.assertEqual(expect, issues)

  def test_bad_extra_field(self):
    stac_data = {'summaries': {'gee:schema': [{
        'bogus': 1, 'description': 'A thing', 'name': 'ab', 'type': 'INT'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Unexpected field(s): bogus')]
    self.assertEqual(expect, issues)

  def test_bad_type_property_type_unspecified(self):
    stac_data = {'summaries': {'gee:schema': [{
        'description': 'A thing', 'name': 'ab',
        'type': 'PROPERTY_TYPE_UNSPECIFIED'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Cannot be PROPERTY_TYPE_UNSPECIFIED: ab')]
    self.assertEqual(expect, issues)

  def test_bad_type(self):
    stac_data = {'summaries': {'gee:schema': [{
        'description': 'A thing', 'name': 'ab', 'type': 123}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Schema type unknown: "123"')]
    self.assertEqual(expect, issues)

  def test_bad_type_string_with_units(self):
    stac_data = {'summaries': {'gee:schema': [{
        'description': 'A thing', 'name': 'ab', 'type': 'STRING',
        'units': 'm'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Units not allowed for a string type')]
    self.assertEqual(expect, issues)

  def test_bad_name_not_str(self):
    stac_data = {'summaries': {'gee:schema': [
        {'description': 'A thing', 'name': 2, 'type': 'INT'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, '"name" must be a str')]
    self.assertEqual(expect, issues)

  def test_bad_duplicate_name(self):
    stac_data = {'summaries': {'gee:schema': [
        {'description': 'A thing', 'name': 'ab', 'type': 'INT'},
        {'description': 'B thing', 'name': 'ab', 'type': 'INT'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, '"name" is a duplicate: "ab"')]
    self.assertEqual(expect, issues)

  def test_bad_name_too_short(self):
    name = 'a'
    stac_data = {'summaries': {'gee:schema': [
        {'description': 'A thing', 'name': name, 'type': 'INT'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, f'Invalid name: "{name}"')]
    self.assertEqual(expect, issues)

  def test_bad_name_too_long(self):
    name = 'a' * 51
    stac_data = {'summaries': {'gee:schema': [
        {'description': 'A thing', 'name': name, 'type': 'INT'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, f'Invalid name: "{name}"')]
    self.assertEqual(expect, issues)

  def test_bad_name_regex(self):
    name = 'Bad name*'
    stac_data = {'summaries': {'gee:schema': [
        {'description': 'A thing', 'name': name, 'type': 'INT'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, f'Invalid name: "{name}"')]
    self.assertEqual(expect, issues)

  def test_bad_description_not_str(self):
    stac_data = {'summaries': {'gee:schema': [
        {'description': 123, 'name': 'ab', 'type': 'INT'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, '"description" must be a str')]
    self.assertEqual(expect, issues)

  def test_bad_description_too_short(self):
    description = 'a'
    stac_data = {'summaries': {'gee:schema': [
        {'description': description, 'name': 'ab', 'type': 'INT'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Description too short: 1')]
    self.assertEqual(expect, issues)

  def test_bad_description_too_long(self):
    description = 'a' * 1801
    stac_data = {'summaries': {'gee:schema': [
        {'description': description, 'name': 'ab', 'type': 'INT'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Description too long: 1801')]
    self.assertEqual(expect, issues)

  def test_bad_units_not_str(self):
    stac_data = {'summaries': {'gee:schema': [
        {'description': 'A name', 'name': 'ab', 'type': 'INT', 'units': 9}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Units must be a str')]
    self.assertEqual(expect, issues)

  # TODO(schwehr): turn on stricter units check.
  # def test_bad_units_unknown(self):
  #   stac_data = {'summaries': {'gee:schema': [
  #       {'description': 'A name', 'name': 'ab', 'type': 'INT',
  #        'units': 'bogus'}]}}
  #   node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
  #   issues = list(Check.run(node))
  #   expect = [Check.new_issue(node, 'Units unknown: bogus')]
  #   self.assertEqual(expect, issues)

if __name__ == '__main__':
  unittest.main()

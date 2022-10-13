"""Tests for interval."""

import pathlib

from checker import stac
from checker.node import interval
import unittest

Check = interval.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class IntervalTest(unittest.TestCase):

  def test_no_interval(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_cadence(self):
    stac_data = {
        'gee:interval': {'type': 'cadence', 'unit': 'year', 'interval': 1}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_revisit_interval(self):
    stac_data = {'gee:interval': {
        'type': 'revisit_interval', 'unit': 'day', 'interval': 16}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_climatological_interval(self):
    stac_data = {'gee:interval': {
        'type': 'climatological_interval', 'unit': 'month', 'interval': 32}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  # See: UCSB-CHG/UCSB-CHG_CHIRPS_PENTAD.jsonnet
  def test_valid_custom_time_unit(self):
    stac_data = {'gee:interval': {
        'type': 'cadence', 'unit': 'custom_time_unit', 'interval': 2,
        'name': 'A thing', 'description': 'A description'}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_bad_catalog(self):
    stac_data = {'gee:interval': {}}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalogs cannot have "gee:interval"')]
    self.assertEqual(expect, issues)

  def test_bad_not_a_dict(self):
    stac_data = {'gee:interval': 'not a dict'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gee:interval must be a dict')]
    self.assertEqual(expect, issues)

  def test_bad_extra_field(self):
    stac_data = {'gee:interval': {
        'extra': 'field', 'type': 'cadence', 'unit': 'hour', 'interval': 2}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Unexpected key: "extra"')]
    self.assertEqual(expect, issues)

  def test_bad_extra_fields(self):
    stac_data = {'gee:interval': {
        'extra1': 'a', 'extra2': 'b',
        'type': 'cadence', 'unit': 'hour', 'interval': 2}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Unexpected keys: [\'extra1\', \'extra2\']')]
    self.assertEqual(expect, issues)

  def test_bad_missing_type(self):
    stac_data = {'gee:interval': {'unit': 'hour', 'interval': 2}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Missing type')]
    self.assertEqual(expect, issues)

  def test_bad_type(self):
    stac_data = {'gee:interval': {'type': 'bad', 'unit': 'hour', 'interval': 3}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Unknown type: bad')]
    self.assertEqual(expect, issues)

  def test_bad_missing_unit(self):
    stac_data = {'gee:interval': {'type': 'cadence', 'interval': 4}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Missing unit')]
    self.assertEqual(expect, issues)

  def test_bad_unit(self):
    stac_data = {'gee:interval': {
        'type': 'cadence', 'unit': 'second', 'interval': 5}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Unknown unit: second')]
    self.assertEqual(expect, issues)

  def test_bad_custom_time_unit_missing_name_and_description(self):
    stac_data = {'gee:interval': {
        'type': 'cadence', 'unit': 'custom_time_unit', 'interval': 2}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [
        Check.new_issue(
            node, 'Having unit of custom_time_unit must have a description'),
        Check.new_issue(
            node, 'Having unit of custom_time_unit must have a name')]
    self.assertEqual(expect, issues)

  def test_bad_name_not_str(self):
    stac_data = {'gee:interval': {
        'name': 5, 'type': 'cadence', 'unit': 'hour', 'interval': 5}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'name must be a str')]
    self.assertEqual(expect, issues)

  def test_bad_name_to_short(self):
    stac_data = {'gee:interval': {
        'name': 'a', 'type': 'cadence', 'unit': 'hour', 'interval': 5}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'name too short')]
    self.assertEqual(expect, issues)

  def test_bad_name_to_long(self):
    stac_data = {'gee:interval': {
        'name': 'b' * 201, 'type': 'cadence', 'unit': 'hour', 'interval': 5}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'name too long: 201')]
    self.assertEqual(expect, issues)

  def test_bad_missing_interval(self):
    stac_data = {
        'gee:interval': {'type': 'cadence', 'unit': 'year'}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Missing interval')]
    self.assertEqual(expect, issues)

  def test_bad_interval_is_str(self):
    stac_data = {
        'gee:interval': {'type': 'cadence', 'unit': 'year', 'interval': 'a'}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'interval must be an integer')]
    self.assertEqual(expect, issues)

  def test_bad_interval_is_float(self):
    stac_data = {
        'gee:interval': {'type': 'cadence', 'unit': 'year', 'interval': 1.2}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'interval must be an integer')]
    self.assertEqual(expect, issues)

  def test_bad_interval_too_small(self):
    stac_data = {
        'gee:interval': {'type': 'cadence', 'unit': 'year', 'interval': 0}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'interval must be a positive integer')]
    self.assertEqual(expect, issues)

  def test_bad_interval_too_big(self):
    stac_data = {
        'gee:interval': {'type': 'cadence', 'unit': 'year', 'interval': 33}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'interval too large: 33')]
    self.assertEqual(expect, issues)

  def test_bad_description_not_str(self):
    stac_data = {'gee:interval': {
        'description': 1, 'type': 'cadence', 'unit': 'year', 'interval': 9}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'description must be a str')]
    self.assertEqual(expect, issues)

  def test_bad_description_too_short(self):
    stac_data = {'gee:interval': {
        'description': 'a', 'type': 'cadence', 'unit': 'year', 'interval': 9}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'description too short')]
    self.assertEqual(expect, issues)

  def test_bad_description_too_long(self):
    stac_data = {'gee:interval': {
        'description': 'b' * 201,
        'type': 'cadence', 'unit': 'year', 'interval': 9}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'description too long: 201')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

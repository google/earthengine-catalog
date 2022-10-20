"""Tests for visualizations_filter."""

import pathlib

from checker import stac
from checker.node import visualizations_filter
import unittest

Check = visualizations_filter.Check

COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')

# DO NOT SUBMIT - Make the display name match the tests


class VisualizationsFilterTest(unittest.TestCase):

  def test_valid_no_summaries(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_summary_without_visualization(self):
    stac_data = {'summaries': {}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_visualization_not_a_list(self):
    stac_data = {'summaries': {'gee:visualizations': 'not a list'}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_visualization_empty_list(self):
    stac_data = {'summaries': {'gee:visualizations': []}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_visualization_not_a_dict(self):
    stac_data = {'summaries': {'gee:visualizations': ['not a dict']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_visualization_missing_display_name(self):
    stac_data = {'summaries': {'gee:visualizations': [{}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_filter_not_a_dict(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'filter': 'not a dict'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, '"Display name" filter not a dict')]
    self.assertEqual(expect, issues)

  def test_field_name_missing(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'filter': {}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, '"Display name" filter missing filter_name')]
    self.assertEqual(expect, issues)

  def test_field_name_unknown(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'filter': {'filter_name': 'bogus'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, '"Display name:" Unknown filter_name: "bogus"')]
    self.assertEqual(expect, issues)

  def test_field_name_not_str(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'filter': {'filter_name': 765}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, '"Display name" filter_name not a str')]
    self.assertEqual(expect, issues)


class FilterDateRangeTest(unittest.TestCase):

  def test_valid(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'filter': {
            'filter_name': 'DATE_RANGE',
            'time_start': '1980-05-18',
            'time_end': '2018-04-02'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_missing_start(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Missing start',
        'filter': {
            'filter_name': 'DATE_RANGE',
            # 'time_start': '1980-05-18',
            'time_end': '2018-04-24'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, '"Missing start" must have time_start and time_end')]
    self.assertEqual(expect, issues)

  def test_missing_end(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Missing end',
        'filter': {
            'filter_name': 'DATE_RANGE',
            'time_start': '2014-08-14'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, '"Missing end" must have time_start and time_end')]
    self.assertEqual(expect, issues)

  def test_reversed_date(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'filter': {
            'filter_name': 'DATE_RANGE',
            'time_start': '2022-10-20',
            'time_end': '1989-10-17'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'time_start must be before time_end: '
        '2022-10-20 00:00:00 .. 1989-10-17 00:00:00')]
    self.assertEqual(expect, issues)

  def test_start_not_str(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'filter': {
            'filter_name': 'DATE_RANGE',
            'time_start': 111,
            'time_end': '1989-10-17'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        '"Display name" filter_name time_start and time_end must be str: '
        '111 1989-10-17')]
    self.assertEqual(expect, issues)

  def test_end_not_str(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'filter': {
            'filter_name': 'DATE_RANGE',
            'time_start': '1990-10-17',
            'time_end': 222}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        '"Display name" filter_name time_start and time_end must be str: '
        '1990-10-17 222')]
    self.assertEqual(expect, issues)

  def test_unable_to_parse_start(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'filter': {
            'filter_name': 'DATE_RANGE',
            'time_start': 'whoops',
            'time_end': '1991-02-03'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'unable to parse time_start: whoops')]
    self.assertEqual(expect, issues)

  def test_unable_to_parse_end(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'filter': {
            'filter_name': 'DATE_RANGE',
            'time_start': '1992-04-25',
            'time_end': 'blarg'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'unable to parse time_end: blarg')]
    self.assertEqual(expect, issues)


class FilterEqualsTest(unittest.TestCase):

  def test_valid_equals(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'filter': {
            'filter_name': 'EQUALS',
            'property_name': 'a_property_name',
            'property_value': 'property string'},
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_missing_property_name(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'filter': {
            'filter_name': 'EQUALS',
            'property_value': 'property string'},
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'EQUALS requires property_name')]
    self.assertEqual(expect, issues)

  def test_property_name_not_str(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'filter': {
            'filter_name': 'EQUALS',
            'property_name': 333,
            'property_value': 'property string'},
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'EQUALS property_name must be a str')]
    self.assertEqual(expect, issues)

  def test_missing_property_value(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'filter': {'filter_name': 'EQUALS', 'property_name': 'a_property_name'},
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'EQUALS requires property_value')]
    self.assertEqual(expect, issues)

  def test_property_value_not_str(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'filter': {
            'filter_name': 'EQUALS',
            'property_name': 'a_property_name',
            'property_value': 4444},
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'EQUALS property_value must be an string')]
    self.assertEqual(expect, issues)


class FilterLastNDaysTest(unittest.TestCase):

  def test_valid(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'filter': {
            'filter_name': 'LAST_N_DAYS',
            'property_value': '42'},
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_property_value_not_str(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'filter': {
            'filter_name': 'LAST_N_DAYS',
            'property_value': 24},
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'LAST_N_DAYS property_value must be an string')]
    self.assertEqual(expect, issues)

  def test_property_value_not_int_in_str(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'filter': {
            'filter_name': 'LAST_N_DAYS',
            'property_value': '3.1415'},
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'LAST_N_DAYS property_value must be a quoted integer')]
    self.assertEqual(expect, issues)


class FilterListContainsTest(unittest.TestCase):

  def test_valid(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'filter': {
            'filter_name': 'LIST_CONTAINS',
            'property_name': 'a_property_name',
            'property_value': 'A property string'},
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_property_name_not_str(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'filter': {
            'filter_name': 'LIST_CONTAINS',
            'property_name': [],
            'property_value': 'A property string'},
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'LIST_CONTAINS property_name must be a str')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

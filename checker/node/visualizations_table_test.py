"""Tests for visualizations_table."""

import pathlib

from checker import stac
from checker.node import visualizations_table
import unittest

Check = visualizations_table.Check

COLLECTION = stac.StacType.COLLECTION
# IMAGE = stac.GeeType.IMAGE
TABLE = stac.GeeType.TABLE
TABLE_COLLECTION = stac.GeeType.TABLE_COLLECTION

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')

POINT_SHAPE_MESSAGE = (
    'point_shape must be one of [\'circle\', \'cross\', \'diamond\', '
    '\'hexagon\', \'hexagram\', \'pentagon\', \'pentagram\', \'plus\', '
    '\'square\', \'star5\', \'star6\', \'triangle\', \'triangle_down\', '
    '\'triangle_left\', \'triangle_right\', \'triangle_up\'] '
    'or a character in "dhopsv+^<>"')


class ValidVisualizationsTableTest(unittest.TestCase):

  def test_empty(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'table_visualization': {}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_color_hex(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'table_visualization': {'color': '489734'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_fill_color(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'table_visualization': {'fill_color': 'red'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_point_shape(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'table_visualization': {'point_shape': 'triangle_left'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_point_size(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'table_visualization': {'point_size': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_width(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'table_visualization': {'width': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_everything(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'table_visualization': {
            'color': 'blueviolet',
            'fill_color': 'rosybrown',
            'point_size': 7,
            'point_shape': 'star6',
            'width': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))


class ValidEmptyTest(unittest.TestCase):

  def test_empty(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_summaries_not_a_dict(self):
    stac_data = {'summaries': 'not a dict'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_summaries_empty(self):
    stac_data = {'summaries': {}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_visualizations_not_list(self):
    stac_data = {'summaries': {'gee:visualizations': 234}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_visualizations_empty_list(self):
    stac_data = {'summaries': {'gee:visualizations': []}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_visualization_not_dict(self):
    stac_data = {'summaries': {'gee:visualizations': [1, 2]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_visualization_empty_dict(self):
    stac_data = {'summaries': {'gee:visualizations': [{}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))


class ErrorVisualizationsTableTest(unittest.TestCase):

  def test_visualization_missing_table_visualization(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{1: 2}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'table must have a table_visualization')]
    self.assertEqual(expect, issues)

  def test_missing_table_visualization_table_collection(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{1: 2}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'table_collection must have a table_visualization')]
    self.assertEqual(expect, issues)

  def test_visualization_table_not_dict(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'table_visualization': 'not a dict'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'table_visualization must be a dict')]
    self.assertEqual(expect, issues)

  def test_color_not_str(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'table_visualization': {'color': [1, 2, 3]}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'color must be a str')]
    self.assertEqual(expect, issues)

  def test_color_bad(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'table_visualization': {'color': 'fff'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'color must be a 6 (or 8) character hex or color name - found "fff"')]
    self.assertEqual(expect, issues)

  def test_fill_color_not_str(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'table_visualization': {'fill_color': 831}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'fill_color must be a str')]
    self.assertEqual(expect, issues)

  def test_fill_color_bad(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'table_visualization': {'fill_color': 'not a color'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'fill_color must be a 6 (or 8) character hex or color name - '
        'found "not a color"')]
    self.assertEqual(expect, issues)

  def test_point_size_not_int(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'table_visualization': {'point_size': 'not an int'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'point_size must be an int')]
    self.assertEqual(expect, issues)

  def test_point_size_too_small(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'table_visualization': {'point_size': 0}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'point_size must be in the range of [1:10]')]
    self.assertEqual(expect, issues)

  def test_point_size_too_large(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'table_visualization': {'point_size': 11}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'point_size must be in the range of [1:10]')]
    self.assertEqual(expect, issues)

  def test_point_shape_not_str(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'table_visualization': {'point_shape': 12}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'point_shape must be a str')]
    self.assertEqual(expect, issues)

  def test_point_shape_not_valid_char(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'table_visualization': {'point_shape': '`'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, POINT_SHAPE_MESSAGE)]
    self.assertEqual(expect, issues)

  def test_width_not_number(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'table_visualization': {'width': 'not a number'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'width must be an number')]
    self.assertEqual(expect, issues)

  def test_width_too_small(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'table_visualization': {'width': 0.01}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'width must be in the range of [0.1:3.0]')]
    self.assertEqual(expect, issues)

  def test_width_too_large(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'table_visualization': {'width': 3.01}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'width must be in the range of [0.1:3.0]')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

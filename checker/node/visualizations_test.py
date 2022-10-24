"""Tests for visualizations."""

import pathlib

from checker import stac
from checker.node import visualizations
import unittest

Check = visualizations.Check

COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
TABLE = stac.GeeType.TABLE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class BboxTest(unittest.TestCase):

  def test_valid(self):
    stac_data = {
        'extent': {'spatial': {'bbox': [[-1, -2, 3, 4]]}}}
    self.assertEqual((-1, -2, 3, 4), visualizations.get_bbox(stac_data))

  def test_empty(self):
    self.assertIsNone(visualizations.get_bbox({}))

  def test_extent_empty(self):
    self.assertIsNone(visualizations.get_bbox({'extent': {}}))

  def test_extent_not_a_dict(self):
    self.assertIsNone(visualizations.get_bbox({'extent': 'not a dict'}))

  def test_spatial_empty(self):
    self.assertIsNone(visualizations.get_bbox({'extent': {'spatial': {}}}))

  def test_spatial_not_a_dict(self):
    self.assertIsNone(visualizations.get_bbox(
        {'extent': {'spatial': 'not a dict'}}))

  def test_bbox_empty(self):
    self.assertIsNone(visualizations.get_bbox(
        {'extent': {'spatial': {'bbox': []}}}))

  def test_bbox_not_a_list(self):
    self.assertIsNone(visualizations.get_bbox(
        {'extent': {'spatial': {'bbox': 'not a list'}}}))

  def test_bbox_empty2(self):
    self.assertIsNone(visualizations.get_bbox(
        {'extent': {'spatial': {'bbox': [[]]}}}))

  def test_bbox_not_a_list2(self):
    self.assertIsNone(visualizations.get_bbox(
        {'extent': {'spatial': {'bbox': ['not a list']}}}))

  def test_wrong_number_coords(self):
    self.assertIsNone(visualizations.get_bbox(
        {'extent': {'spatial': {'bbox': [[-1, -2]]}}}))


class VisualizationsTest(unittest.TestCase):

  def test_valid_no_summaries(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_image_visualization(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_filter_date_range(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'filter': {
            'filter_name': 'DATE_RANGE',
            'time_end': '1999-06-01',
            'time_start': '2018-04-02'},
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_table_visualization(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'table_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_polygon_visualization(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'polygon_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_missing_lookat_exception(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'image_visualization': {},
        }]}}
    node = stac.Node('LANDSAT/LC8', FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_bad_missing_visualizations(self):
    stac_data = {'summaries': {}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Missing gee:visualizations field')]
    self.assertEqual(expect, issues)

  def test_bad_visualizations_not_list(self):
    stac_data = {'summaries': {'gee:visualizations': 'not a list'}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gee:visualizations must be a list')]
    self.assertEqual(expect, issues)

  def test_bad_visualizations_empty_list(self):
    stac_data = {'summaries': {'gee:visualizations': []}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:visualizations must have at least 1 entry')]
    self.assertEqual(expect, issues)

  def test_bad_visualizations_too_many(self):
    vis = {
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}
    stac_data = {'summaries': {'gee:visualizations': [vis, vis, vis, vis, vis]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:visualizations has too many entries: 5')]
    self.assertEqual(expect, issues)

  def test_bad_visualization_not_dict(self):
    stac_data = {'summaries': {'gee:visualizations': ['not a dict']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Visualization must be a dict')]
    self.assertEqual(expect, issues)

  def test_bad_missing_display_name(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Visualization must have a display_name')]
    self.assertEqual(expect, issues)

  def test_bad_display_name_not_str(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 123,
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'display_name must be a str')]
    self.assertEqual(expect, issues)

  def test_bad_display_name_invalid_character(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': '++++',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Invalid display_name: "++++"')]
    self.assertEqual(expect, issues)

  def test_bad_display_name_too_short(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'a',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Invalid display_name: "a"')]
    self.assertEqual(expect, issues)

  def test_bad_display_name_too_long(self):
    display_name = 'b' * 72
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': display_name,
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, f'Invalid display_name: "{display_name}"')]
    self.assertEqual(expect, issues)

  def test_bad_missing_lookat(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'abc',
        'image_visualization': {}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, '"abc" missing lookat')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_not_dict(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'bcd',
        'image_visualization': {},
        'lookat': 'not a dict'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, '"bcd" lookat not a dict')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_missing_lat(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'bcd',
        'image_visualization': {},
        'lookat': {'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'lookat must have lon, lat, and zoom')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_missing_lon(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'bcd',
        'image_visualization': {},
        'lookat': {'lat': 1, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'lookat must have lon, lat, and zoom')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_missing_zoom(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'bcd',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'lookat must have lon, lat, and zoom')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_missing_lat_not_number(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'bcd',
        'image_visualization': {},
        'lookat': {'lat': '9', 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'lon and lat must be floats and zoom must be an int: 2, 9, 3')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_lon_not_number(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'bcd',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': '8', 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'lon and lat must be floats and zoom must be an int: 8, 1, 3')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_zoom_not_number(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'bcd',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': '4'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'lon and lat must be floats and zoom must be an int: 2, 1, 4')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_missing_lat_too_low(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'bcd',
        'image_visualization': {},
        'lookat': {'lat': -90.01, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'lat must be in [-90, 90]')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_missing_lat_too_high(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'bcd',
        'image_visualization': {},
        'lookat': {'lat': 90.01, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'lat must be in [-90, 90]')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_missing_lon_too_low(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'bcd',
        'image_visualization': {},
        'lookat': {'lat': 3, 'lon': -180.1, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'lon must be in [-180, 180]')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_missing_lon_too_high(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'bcd',
        'image_visualization': {},
        'lookat': {'lat': 3, 'lon': 180.1, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'lon must be in [-180, 180]')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_missing_zoom_too_small(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'bcd',
        'image_visualization': {},
        'lookat': {'lat': 3, 'lon': -4, 'zoom': -1}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'zoom must be in [0, 20]')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_bbox_zoom_outside_lat_below(self):
    stac_data = {
        'extent': {'spatial': {'bbox': [[-120, -45, 130, 45]]}},
        'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': -50, 'lon': -4, 'zoom': 1}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'lat must be in extent')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_bbox_zoom_outside_lat_above(self):
    stac_data = {
        'extent': {'spatial': {'bbox': [[-120, -45, 130, 45]]}},
        'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': 62, 'lon': -4, 'zoom': 1}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'lat must be in extent')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_bbox_zoom_outside_lon_below(self):
    stac_data = {
        'extent': {'spatial': {'bbox': [[-120, -45, 130, 45]]}},
        'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': 2, 'lon': -167, 'zoom': 1}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'lon must be in extent')]
    self.assertEqual(expect, issues)

  def test_bad_lookat_bbox_zoom_outside_lon_above(self):
    stac_data = {
        'extent': {'spatial': {'bbox': [[-120, -45, 130, 45]]}},
        'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': 2, 'lon': 158, 'zoom': 1}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'lon must be in extent')]
    self.assertEqual(expect, issues)

  def test_bad_image_with_polygon_visualization(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'polygon_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'image must have an image_visualization')]
    self.assertEqual(expect, issues)

  def test_bad_image_with_table_visualization(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'table_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'image must have an image_visualization')]
    self.assertEqual(expect, issues)

  def test_bad_table_with_image_visualization(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'table must have one of polygon_visualization or table_visualization')]
    self.assertEqual(expect, issues)

  def test_bad_table_with_both_polygon_and_table_visualization(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'polygon_visualization': {},
        'table_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    message = (
        'Other fields must be one of [\'image_visualization\', '
        '\'polygon_visualization\', \'table_visualization\'] - '
        'found: [\'polygon_visualization\', \'table_visualization\']')
    expect = [Check.new_issue(node, message)]
    self.assertEqual(expect, issues)

  def test_bad_extra_field(self):
    stac_data = {'summaries': {'gee:visualizations': [{
        'display_name': 'Display name',
        'table_visualization': {},
        'bogus': True,
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    message = (
        'Other fields must be one of [\'image_visualization\', '
        '\'polygon_visualization\', \'table_visualization\'] - '
        'found: [\'bogus\', \'table_visualization\']')
    expect = [Check.new_issue(node, message)]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

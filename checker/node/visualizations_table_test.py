"""Tests for visualizations_table."""

from checker import stac
from checker import test_utils
from checker.node import visualizations_table
from absl.testing import absltest

TABLE = stac.GeeType.TABLE
TABLE_COLLECTION = stac.GeeType.TABLE_COLLECTION

POINT_SHAPE_MESSAGE = (
    'point_shape must be one of [\'circle\', \'cross\', \'diamond\', '
    '\'hexagon\', \'hexagram\', \'pentagon\', \'pentagram\', \'plus\', '
    '\'square\', \'star5\', \'star6\', \'triangle\', \'triangle_down\', '
    '\'triangle_left\', \'triangle_right\', \'triangle_up\'] '
    'or a character in "dhopsv+^<>"')


class ValidVisualizationsTableTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = visualizations_table.Check

  def test_empty(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{'table_visualization': {}}]}},
        gee_type=TABLE)

  def test_color_hex(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'table_visualization': {'color': '489734'}}]}},
        gee_type=TABLE)

  def test_fill_color(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'table_visualization': {'fill_color': 'red'}}]}},
        gee_type=TABLE)

  def test_point_shape(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'table_visualization': {'point_shape': 'triangle_left'}}]}},
        gee_type=TABLE)

  def test_point_size(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'table_visualization': {'point_size': 3}}]}},
        gee_type=TABLE)

  def test_width(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'table_visualization': {'width': 3}}]}},
        gee_type=TABLE)

  def test_everything(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'table_visualization': {
                'color': 'blueviolet',
                'fill_color': 'rosybrown',
                'point_size': 7,
                'point_shape': 'star6',
                'width': 3}}]}},
        gee_type=TABLE)


class ValidEmptyTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = visualizations_table.Check

  def test_empty(self):
    self.assert_collection({})

  def test_summaries_not_a_dict(self):
    self.assert_collection({'summaries': 'not a dict'}, gee_type=TABLE)

  def test_summaries_empty(self):
    self.assert_collection({'summaries': {}}, gee_type=TABLE)

  def test_visualizations_not_list(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': 234}}, gee_type=TABLE)

  def test_visualizations_empty_list(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': []}}, gee_type=TABLE)

  def test_visualization_not_dict(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [1, 2]}}, gee_type=TABLE)

  def test_visualization_empty_dict(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{}]}}, gee_type=TABLE)


class ErrorVisualizationsTableTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = visualizations_table.Check

  def test_visualization_missing_table_visualization(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{1: 2}]}},
        'table must have a table_visualization',
        gee_type=TABLE)

  def test_missing_table_visualization_table_collection(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{1: 2}]}},
        'table_collection must have a table_visualization',
        gee_type=TABLE_COLLECTION)

  def test_visualization_table_not_dict(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'table_visualization': 'not a dict'}]}},
        'table_visualization must be a dict',
        gee_type=TABLE)

  def test_color_not_str(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'table_visualization': {'color': [1, 2, 3]}}]}},
        'color must be a str',
        gee_type=TABLE)

  def test_color_bad(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'table_visualization': {'color': 'fff'}}]}},
        'color must be a 6 (or 8) character hex or color name - found "fff"',
        gee_type=TABLE)

  def test_fill_color_not_str(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'table_visualization': {'fill_color': 831}}]}},
        'fill_color must be a str',
        gee_type=TABLE)

  def test_fill_color_bad(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'table_visualization': {'fill_color': 'not a color'}}]}},
        'fill_color must be a 6 (or 8) character hex or color name - '
        'found "not a color"',
        gee_type=TABLE)

  def test_point_size_not_int(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'table_visualization': {'point_size': 'not an int'}}]}},
        'point_size must be an int',
        gee_type=TABLE)

  def test_point_size_too_small(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'table_visualization': {'point_size': 0}}]}},
        'point_size must be in the range of [1:10]',
        gee_type=TABLE)

  def test_point_size_too_large(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'table_visualization': {'point_size': 11}}]}},
        'point_size must be in the range of [1:10]',
        gee_type=TABLE)

  def test_point_shape_not_str(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'table_visualization': {'point_shape': 12}}]}},
        'point_shape must be a str',
        gee_type=TABLE)

  def test_point_shape_not_valid_char(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'table_visualization': {'point_shape': '`'}}]}},
        POINT_SHAPE_MESSAGE,
        gee_type=TABLE)

  def test_width_not_number(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'table_visualization': {'width': 'not a number'}}]}},
        'width must be an number',
        gee_type=TABLE)

  def test_width_too_small(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'table_visualization': {'width': 0.01}}]}},
        'width must be in the range of [0.1:3.0]',
        gee_type=TABLE)

  def test_width_too_large(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'table_visualization': {'width': 3.01}}]}},
        'width must be in the range of [0.1:3.0]',
        gee_type=TABLE)


if __name__ == '__main__':
  absltest.main()

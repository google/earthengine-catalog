"""Tests for gee_classes."""

from typing import Any

from checker import test_utils
from checker.node import gee_classes
from absl.testing import absltest


def make_stac(classes: list[dict[str, Any]]) -> dict[str, Any]:
  return {
      'summaries': {
          'eo:bands': [{
              'name': 'band_name',
              'description': 'a descr',
              'gee:classes': classes}]}}


class GeeClassesTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_classes.Check

  def test_valid_hex(self):
    classes = [{'color': 'fafafa', 'description': 'A', 'value': 1},
               {'color': '00FF11', 'description': 'B', 'value': 2}]
    self.assert_collection(make_stac(classes))

  def test_valid_hex_with_alpha(self):
    classes = [{'color': 'aabbccdd', 'description': 'A', 'value': -1},
               {'color': '00aaff', 'description': 'B', 'value': 0}]
    self.assert_collection(make_stac(classes))

  def test_valid_color_names(self):
    classes = [{'color': 'blue', 'description': 'A', 'value': 1},
               {'color': 'silver', 'description': 'B', 'value': 2}]
    self.assert_collection(make_stac(classes))

  def test_skip_bands_not_list(self):
    self.assert_collection({'summaries': {'eo:bands': 'not a list'}})

  def test_skip_band_not_dict(self):
    self.assert_collection({'summaries': {'eo:bands': ['not a dict']}})

  def test_bad_classes_must_be_a_list(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{
                'name': 'band_name',
                'description': 'a descr',
                'gee:classes': 'not a list'}]}},
        '"gee:classes" must be a list')

  def test_bad_empty_list(self):
    classes = []
    self.assert_collection(
        make_stac(classes), '"gee:classes" must have at least 1 class')

  def test_bad_classes_item_must_be_a_dict(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{
                'name': 'band_name',
                'description': 'a descr',
                'gee:classes': [
                    'not a dict',
                    {'color': 'violet', 'description': 'B', 'value': 2}]}]}},
        '"gee:classes" item must be a dict')

  def test_bad_missing_required_value(self):
    stac_data = make_stac([
        {'color': 'red', 'description': 'A'},
        {'color': 'blue', 'description': 'B', 'value': 2}])
    self.assert_collection(
        stac_data, 'A gee:classes entry missing [\'value\'])')

  def test_bad_missing_required_description(self):
    stac_data = make_stac([
        {'color': 'red', 'value': 1},
        {'color': 'blue', 'description': 'B', 'value': 2}])
    self.assert_collection(
        stac_data, 'A gee:classes entry missing [\'description\'])')

  def test_bad_extra_key(self):
    stac_data = make_stac([
        {'color': 'red', 'description': 'A', 'value': 1, 'bad': 3},
        {'color': 'blue', 'description': 'B', 'value': 2}])
    self.assert_collection(stac_data, 'Unexpected key: "bad"')

  def test_bad_extra_keys(self):
    stac_data = make_stac([
        {'color': 'red', 'description': 'A', 'value': 1, 'bad1': 3, 'bad2': 4},
        {'color': 'blue', 'description': 'B', 'value': 2}])
    self.assert_collection(stac_data, 'Unexpected keys: [\'bad1\', \'bad2\']')

  def test_bad_value_is_str(self):
    stac_data = make_stac([
        {'color': 'red', 'description': 'A', 'value': 1},
        {'color': 'blue', 'description': 'B', 'value': 'a str'}])
    self.assert_collection(stac_data, 'value must be an integer: "a str"')

  def test_bad_value_is_float(self):
    stac_data = make_stac([
        {'color': 'red', 'description': 'A', 'value': 1},
        {'color': 'blue', 'description': 'B', 'value': 3.14}])
    self.assert_collection(stac_data, 'value must be an integer: "3.14"')

  def test_bad_description_not_str(self):
    stac_data = make_stac([
        {'color': 'red', 'description': 3, 'value': 1},
        {'color': 'blue', 'description': 'B', 'value': 2}])
    self.assert_collection(stac_data, 'description must be a str: 3')

  def test_bad_description_empty_str(self):
    stac_data = make_stac([
        {'color': 'red', 'description': '', 'value': 1},
        {'color': 'blue', 'description': 'B', 'value': 2}])
    self.assert_collection(stac_data, 'description too short: "0"')

  def test_bad_description_too_long(self):
    stac_data = make_stac([
        {'color': 'red', 'description': 'A' * 1001, 'value': 1},
        {'color': 'blue', 'description': 'B', 'value': 2}])
    self.assert_collection(stac_data, 'description too long: 1001')

  def test_bad_color_is_number(self):
    stac_data = make_stac([
        {'color': 1, 'description': 'A', 'value': 1},
        {'color': 'blue', 'description': 'B', 'value': 2}])
    self.assert_collection(stac_data, 'color must be a str: 1')

  def test_bad_color_is_nonsense(self):
    stac_data = make_stac([
        {'color': 'nonsense', 'description': 'A', 'value': 1},
        {'color': 'blue', 'description': 'B', 'value': 2}])
    self.assert_collection(
        stac_data,
        'color must be a 6 (or 8) character hex or color name - '
        'found "nonsense"')

  def test_bad_duplicate_values(self):
    stac_data = make_stac([
        {'color': 'red', 'description': 'A', 'value': 3},
        {'color': 'blue', 'description': 'B', 'value': 3}])
    self.assert_collection(stac_data, 'values have duplicates')

  def test_bad_unsorted_values(self):
    stac_data = make_stac([
        {'color': 'red', 'description': 'A', 'value': 5},
        {'color': 'blue', 'description': 'B', 'value': 4}])
    self.assert_collection(stac_data, 'values must be sorted')

  def test_bad_duplicate_descriptions(self):
    stac_data = make_stac([
        {'color': 'red', 'description': 'C', 'value': 1},
        {'color': 'blue', 'description': 'C', 'value': 2}])
    self.assert_collection(stac_data, 'descriptions have duplicates')

  def test_bad_names_and_hex(self):
    stac_data = make_stac([
        {'color': 'aabbcc', 'description': 'A', 'value': -1},
        {'color': 'violet', 'description': 'B', 'value': 0}])
    self.assert_collection(
        stac_data,
        'colors must be all hex or all color names. Found a mix of both')


if __name__ == '__main__':
  absltest.main()

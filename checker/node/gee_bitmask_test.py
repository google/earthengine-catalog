"""Tests for gee_bitmask."""

from checker import test_utils
from checker.node import gee_bitmask
import unittest


class ValidGeeBitmaskTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_bitmask.Check

  def test_one_part(self):
    self.assert_collection({'summaries': {'eo:bands': [{
        'name': 'datamask',
        'gee:bitmask': {
            'bitmask_parts': [{
                'bit_count': 1,
                'description': 'Data mask',
                'first_bit': 0,
                'values': [
                    {'description': 'No data', 'value': 0},
                    {'description': 'Classified area', 'value': 1}]}],
            'total_bit_count': 1}}]}})

  def test_two_parts(self):
    self.assert_collection({'summaries': {'eo:bands': [{
        'name': 'datamask',
        'gee:bitmask': {
            'bitmask_parts': [{
                'bit_count': 3,
                'description': 'Part one',
                'first_bit': 0,
                'values': [
                    {'description': 'No data', 'value': 0},
                    {'description': 'Classified area', 'value': 1}]
            }, {
                'bit_count': 2,
                'description': 'Part one',
                'first_bit': 3,
                'values': [
                    {'description': 'No data', 'value': 0},
                    {'description': 'Classified area', 'value': 1}]}],
            'total_bit_count': 5}}]}})

  def test_two_bands(self):
    self.assert_collection({'summaries': {'eo:bands': [{
        'name': 'band_1',
        'gee:bitmask': {
            'bitmask_parts': [{
                'bit_count': 16,
                'description': 'A description',
                'first_bit': 0}],
            'total_bit_count': 16}
    }, {
        'name': 'band_2',
        'gee:bitmask': {
            'bitmask_parts': [{
                'bit_count': 8,
                'description': 'A description',
                'first_bit': 0}],
            'total_bit_count': 8}}]}})

  def test_empty(self):
    self.assert_collection({})

  def test_empty_summary(self):
    self.assert_collection({'summaries': {}})

  def test_empty_bands(self):
    self.assert_collection({'summaries': {'eo:bands': []}})

  def test_bands_without_bitmask(self):
    self.assert_collection({'summaries': {'eo:bands': []}})


class ErrorGeeBitmaskTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_bitmask.Check

  def test_bitmask_dict(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name', 'gee:bitmask': 'not a dict'}]}},
        'band_name gee:bitmask must be a dict')

  def test_bitmask_missing_parts(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name', 'gee:bitmask': {}}]}},
        'band_name gee:bitmask must have bitmask_parts')

  def test_parts_not_list(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1, 'bitmask_parts': 'not a list'}}]}},
        'band_name bitmask_parts must be a list')

  def test_part_description_missing(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 3,
                'bitmask_parts': [{'bit_count': 3, 'first_bit': 0}]}}]}},
        'band_name part missing description')

  def test_part_description_not_str(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 3,
                'bitmask_parts': [{
                    'description': 858, 'bit_count': 3, 'first_bit': 0}]}}]}},
        'band_name part description must be a str')

  def test_part_description_too_short(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 3,
                'bitmask_parts': [{
                    'description': 'a', 'bit_count': 3, 'first_bit': 0}]}}]}},
        'band_name part description too short: 1')

  def test_part_description_too_long(self):
    description = 'a' * 221
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 3,
                'bitmask_parts': [{
                    'description': description,
                    'bit_count': 3, 'first_bit': 0}]}}]}},
        'band_name part description too long: 221')

  def test_bit_count_not_int(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1,
                'bitmask_parts': [{
                    'bit_count': 'not an int',
                    'description': 'a description', 'first_bit': 0}]}}]}},
        'band_name part bit_count must be an int')

  def test_bit_count_too_small(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1,
                'bitmask_parts': [{
                    'bit_count': 0,
                    'description': 'a description', 'first_bit': 0}]}}]}},
        'band_name part bit_count too small: 0')

  def test_bit_count_too_large(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 17,
                'bitmask_parts': [{
                    'bit_count': 17,
                    'description': 'a description', 'first_bit': 0}]}}]}},
        'band_name part bit_count too large: 17')

  def test_first_bit_not_int(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1,
                'bitmask_parts': [{
                    'first_bit': 'not an int',
                    'description': 'a description', 'bit_count': 1}]}}]}},
        'band_name part first_bit must be an int')

  def test_first_bit_too_small(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1,
                'bitmask_parts': [{
                    'first_bit': -1,
                    'description': 'a description', 'bit_count': 1}]}}]}},
        'band_name part first_bit too small: -1')

  def test_first_bit_too_large(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 16,
                'bitmask_parts': [{
                    'first_bit': 64,
                    'description': 'a description', 'bit_count': 16}]}}]}},
        'band_name part first_bit too large: 64')

  def test_values_not_list(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1,
                'bitmask_parts': [{
                    'values': 'not a list',
                    'first_bit': 0,
                    'description': 'a description', 'bit_count': 1}]}}]}},
        'band_name part values must be a list')

  def test_values_empty_list(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1,
                'bitmask_parts': [{
                    'values': [],
                    'first_bit': 0,
                    'description': 'a description', 'bit_count': 1}]}}]}},
        'band_name part values must have at least 1 entry')

  def test_values_entry_not_dict(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1,
                'bitmask_parts': [{
                    'values': ['not a dict'],
                    'first_bit': 0,
                    'description': 'a description', 'bit_count': 1}]}}]}},
        'band_name part values entry must be a dict')

  def test_values_entry_missing_value(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1,
                'bitmask_parts': [{
                    'values': [{'description': 'No data'}],
                    'first_bit': 0,
                    'description': 'a description', 'bit_count': 1}]}}]}},
        'band_name part values entry must have value')

  def test_values_entry_value_not_int(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
        'name': 'band_name',
        'gee:bitmask': {
            'total_bit_count': 1,
            'bitmask_parts': [{
                'values': [{'description': 'No data', 'value': 'not an int'}],
                'first_bit': 0,
                'description': 'a description', 'bit_count': 1}]}}]}},
        'band_name part value must be an int')

  def test_values_entry_value_too_small(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1,
                'bitmask_parts': [{
                    'values': [{'description': 'No data', 'value': -1}],
                    'first_bit': 0,
                    'description': 'a description', 'bit_count': 1}]}}]}},
        'band_name part value too small: -1')

  def test_values_entry_value_too_large(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1,
                'bitmask_parts': [{
                    'values': [{'description': 'No data', 'value': 2}],
                    'first_bit': 0,
                    'description': 'a description', 'bit_count': 1}]}}]}},
        'band_name part value too large: 2 > 1')

  def test_values_entry_value_too_large_3_bit(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 3,
                'bitmask_parts': [{
                    'values': [{'description': 'No data', 'value': 8}],
                    'first_bit': 0,
                    'description': 'a description', 'bit_count': 3}]}}]}},
        'band_name part value too large: 8 > 7')

  def test_values_entry_value_bad_order(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 3,
                'bitmask_parts': [{
                    'values': [
                        {'description': 'v4', 'value': 4},
                        {'description': 'v3', 'value': 3}],
                    'first_bit': 0,
                    'description': 'a description', 'bit_count': 3}]}}]}},
        'band_name part value values must be sorted: 3 <= 4')

  def test_values_entry_description_missing(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1,
                'bitmask_parts': [{
                    'values': [{'value': 0}],
                    'first_bit': 0,
                    'description': 'a description', 'bit_count': 1}]}}]}},
        'band_name part value missing description')

  def test_values_entry_description_not_int(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1,
                'bitmask_parts': [{
                    'values': [{'description': 9876, 'value': 0}],
                    'first_bit': 0,
                    'description': 'a description', 'bit_count': 1}]}}]}},
        'band_name part value description must be a str')

  def test_values_entry_description_too_small(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1,
                'bitmask_parts': [{
                    'values': [{'description': 'a', 'value': 0}],
                    'first_bit': 0,
                    'description': 'a description', 'bit_count': 1}]}}]}},
        'band_name part value description too short: 1')

  def test_values_entry_description_too_large(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 1,
                'bitmask_parts': [{
                    'values': [{'description': 'a' * 261, 'value': 0}],
                    'first_bit': 0,
                    'description': 'a description', 'bit_count': 1}]}}]}},
        'band_name part value description too long: 261')

  def test_total_bit_counts_not_int(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 'not an int',
                'bitmask_parts': [{
                    'bit_count': 1,
                    'first_bit': 0, 'description': 'a description'}]}}]}},
        'band_name gee:bitmask total_bit_count must be an int')

  def test_total_bit_counts_too_small(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 0,
                'bitmask_parts': [{
                    'bit_count': 1,
                    'first_bit': 0, 'description': 'a description'}]}}]}},
        'band_name gee:bitmask total_bit_count too small: 0')

  def test_total_bit_counts_too_large(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 64,
                'bitmask_parts': [{
                    'bit_count': 1,
                    'first_bit': 0, 'description': 'a description'}]}}]}},
        'band_name gee:bitmask total_bit_count too large: 64')

  def test_total_bit_counts_does_not_match_bit_counts(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 'band_name',
            'gee:bitmask': {
                'total_bit_count': 2,
                'bitmask_parts': [{
                    'bit_count': 1,
                    'first_bit': 0, 'description': 'a description'}]}}]}},
        'band_name gee:bitmask total_bit_count does not match the sum: 2 != 1')


if __name__ == '__main__':
  unittest.main()

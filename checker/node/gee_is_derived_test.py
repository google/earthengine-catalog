"""Tests for gee_is_derived."""

from checker import test_utils
from checker.node import gee_is_derived
from absl.testing import absltest


class GeeIsDerivedTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_is_derived.Check

  def test_valid_landsat(self):
    self.assert_collection(
        {'gee:is_derived': True}, dataset_id='LANDSAT/LT4_L1T_32DAY_NBRT')

  def test_valid_modis(self):
    self.assert_collection(
        {'gee:is_derived': True}, dataset_id='MODIS/MCD43A4_BAI')

  def test_valid_whbu(self):
    self.assert_collection(
        {'gee:is_derived': True}, dataset_id='WHBU/NBAR_1YEAR')

  def test_catalog(self):
    self.assert_catalog(
        {'gee:is_derived': True}, 'Catalog cannot have gee:is_derived')

  def test_not_bool(self):
    self.assert_collection(
        {'gee:is_derived': 'not a bool'}, 'gee:is_derived must be a bool')

  def test_not_allowed(self):
    self.assert_collection(
        {'gee:is_derived': False}, 'gee:is_derived not allowed in dataset')

  def test_not_true(self):
    self.assert_collection(
        {'gee:is_derived': False},
        'gee:is_derived can only be present as true',
        dataset_id='WHBU/NBAR_1YEAR')


if __name__ == '__main__':
  absltest.main()

"""Tests for non_commercial."""

from unittest import mock

from checker import stac
from checker import test_utils
from checker.node import non_commercial
import unittest


class NonCommercialTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = non_commercial.Check

  def test_valid_real_member(self):
    self.assert_collection(
        {'license': 'CC-BY-NC-4.0'},
        dataset_id='GLOBAL_FLOOD_DB/MODIS_EVENTS/V1')

  def test_valid_not_member_proprietary(self):
    self.assert_collection({'license': 'proprietary'})

  def test_valid_catalog(self):
    self.assert_catalog({})

  @mock.patch.object(stac, 'is_in_non_commercial', return_value=False)
  def test_not_in_list(self, mock_is_in_non_commercial):
    del mock_is_in_non_commercial  # not used
    self.assert_collection(
        {'license': 'CC-BY-NC-SA-4.0'},
        'Dataset with non-commercial license must be listed in '
        'non_commercial_datasets.jsonnet')

  @mock.patch.object(stac, 'is_in_non_commercial', return_value=True)
  def test_in_list_but_should_not_be(self, mock_is_in_non_commercial):
    del mock_is_in_non_commercial  # not used
    self.assert_collection(
        {'license': 'CC-BY-4.0'}, 'Cannot be in non-commercial dataset list')

  @mock.patch.object(stac, 'is_in_non_commercial', return_value=True)
  def test_catalog_in_list(self, mock_is_in_non_commercial):
    del mock_is_in_non_commercial  # not used
    self.assert_catalog(
        {}, 'Catalog cannot be in non-commercial dataset list')

if __name__ == '__main__':
  unittest.main()

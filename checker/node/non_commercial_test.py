"""Tests for non_commercial."""

import pathlib
from unittest import mock

from checker import stac
from checker.node import non_commercial
import unittest

Check = non_commercial.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class NonCommercialTest(unittest.TestCase):

  def test_valid_real_member(self):
    dataset_id = 'GLOBAL_FLOOD_DB/MODIS_EVENTS/V1'
    stac_data = {'license': 'CC-BY-NC-4.0'}
    node = stac.Node(dataset_id, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_not_member_proprietary(self):
    stac_data = {'license': 'proprietary'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_catalog(self):
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, {})
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  @mock.patch.object(stac, 'is_in_non_commercial', return_value=False)
  def test_not_in_list(self, mock_is_in_non_commercial):
    del mock_is_in_non_commercial  # not used
    stac_data = {'license': 'CC-BY-NC-SA-4.0'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'Dataset with non-commercial license must be listed in '
        'non_commercial_datasets.jsonnet')]
    self.assertEqual(expect, issues)

  @mock.patch.object(stac, 'is_in_non_commercial', return_value=True)
  def test_in_list_but_should_not_be(self, mock_is_in_non_commercial):
    del mock_is_in_non_commercial  # not used
    stac_data = {'license': 'CC-BY-4.0'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Cannot be in non-commercial dataset list')]
    self.assertEqual(expect, issues)

  @mock.patch.object(stac, 'is_in_non_commercial', return_value=True)
  def test_catalog_in_list(self, mock_is_in_non_commercial):
    del mock_is_in_non_commercial  # not used
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, CATALOG, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Catalog cannot be in non-commercial dataset list')]
    self.assertEqual(expect, issues)

if __name__ == '__main__':
  unittest.main()

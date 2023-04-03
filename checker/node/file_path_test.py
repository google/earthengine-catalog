"""Tests for file_path."""

from checker import test_utils
from checker.node import file_path
from absl.testing import absltest


class ValidFilePathTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = file_path.Check

  def test_root_catalog(self):
    self.assert_catalog({}, dataset_id='GEE_catalog', file_path='catalog.json')

  def test_catalog(self):
    self.assert_catalog({}, dataset_id='A', file_path='A/catalog.json')

  def test_collection(self):
    self.assert_collection({}, dataset_id='A/B', file_path='A/A_B.json')


class SkipFilePathTestgoogletest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = file_path.Check

  def test_node_id_empty(self):
    self.assert_catalog({}, dataset_id='', file_path='catalog.json')

  def test_node_id_not_str(self):
    # pytype: disable=wrong-arg-types
    self.assert_catalog({}, dataset_id=415, file_path='catalog.json')
    # pytype: enable=wrong-arg-types


class ErrorFilePathTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = file_path.Check

  def test_root_catalog_bad_name(self):
    self.assert_catalog(
        {}, 'Root must have an id of GEE_catalog',
        dataset_id='wrong_name', file_path='catalog.json')

  def test_non_root_catalog_used_root_id(self):
    self.assert_catalog(
        {}, '"GEE_catalog" in the wrong place',
        dataset_id='GEE_catalog', file_path='A/catalog.json')

  def test_bad_catalog_name(self):
    self.assert_catalog(
        {}, 'Catalog file must be catalog.json',
        dataset_id='A', file_path='A/bad_name.json')

  def test_bad_catalog_too_deep(self):
    self.assert_catalog(
        {}, 'Catalog too deep',
        dataset_id='A/B/C', file_path='A/B/C/catalog.json')

  def test_bad_catalog_unexpected_2_level(self):
    message = 'Catalog too deep'
    self.assert_catalog(
        {}, message, dataset_id='USGS/B', file_path='USGS/C/catalog.json')

  def test_bad_catalog_invalid_2_level(self):
    message = 'Catalog too deep'
    self.assert_catalog(
        {}, message, dataset_id='A/B', file_path='A/B/catalog.json')

  def test_bad_catalog_mismatch(self):
    self.assert_catalog(
        {}, 'expected path: A/catalog.json found: B/catalog.json',
        dataset_id='A', file_path='B/catalog.json')

  # COLLECTIONS
  def test_bad_2_level_collection(self):
    message = (
        'Collection: expected 1-level path: A/A_B_C.json found: A/B/A_B_C.json')
    self.assert_collection(
        {}, message,
        dataset_id='A/B/C', file_path='A/B/A_B_C.json')

  def test_bad_collection(self):
    self.assert_collection(
        {}, 'Collection: expected 1-level path: A/A_B.json found: A/B.json',
        dataset_id='A/B', file_path='A/B.json')


if __name__ == '__main__':
  absltest.main()

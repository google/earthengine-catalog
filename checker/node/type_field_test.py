"""Tests for type_field."""

from checker import test_utils
from checker.node import type_field
from absl.testing import absltest


class CatalogTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = type_field.Check

  def test_valid(self):
    self.assert_catalog({'type': 'Catalog'}, file_path='catalog.json')

  def test_misssing(self):
    self.assert_catalog({}, 'Missing: type')

  def test_not_a_str(self):
    self.assert_catalog({'type': 555}, 'type must be a str')

  def test_invalid_str(self):
    self.assert_catalog(
        {'type': 'bogus string'},
        'type must be one of [\'Catalog\', \'Collection\']')

  def test_path_not_catalog_json(self):
    self.assert_catalog(
        {'type': 'Catalog'},
        'Catalog path must end with catalog.json. Found: not_catalog.json',
        file_path='not_catalog.json')


class CollectionTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = type_field.Check

  def test_valid(self):
    self.assert_collection({'type': 'Collection'})

  def test_misssing(self):
    self.assert_collection({}, 'Missing: type')

  def test_not_a_str(self):
    self.assert_collection({'type': 555}, 'type must be a str')

  def test_invalid_str(self):
    self.assert_collection(
        {'type': 'bogus string'},
        'type must be one of [\'Catalog\', \'Collection\']')

  def test_path_catalog_json(self):
    self.assert_collection(
        {'type': 'Collection'},
        'catalog.json cannot have type Collection',
        file_path='catalog.json')


if __name__ == '__main__':
  absltest.main()

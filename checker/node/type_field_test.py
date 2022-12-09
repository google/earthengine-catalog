"""Tests for type_field."""

from checker import test_utils
from checker.node import type_field
from absl.testing import absltest


class CatalogTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = type_field.Check

  def test_valid(self):
    self.assert_catalog({'type': 'Catalog'})

  def test_misssing(self):
    self.assert_catalog({}, 'Missing: type')

  def test_not_a_str(self):
    self.assert_catalog({'type': 555}, 'type must be a str')

  def test_invalid_str(self):
    self.assert_catalog(
        {'type': 'bogus string'},
        'type must be one of [\'Catalog\', \'Collection\']')


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


if __name__ == '__main__':
  absltest.main()

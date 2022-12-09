"""Tests for required."""

from checker import test_utils
from checker.node import required
from absl.testing import absltest

TYPE = required.TYPE

CATALOG_FIELDS = required.CATALOG_FIELDS
COLLECTION_FIELDS = required.COLLECTION_FIELDS

DOES_NOT_MATTER = 'does not matter'


class CatalogTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = required.Check

  def test_valid(self):
    self.assert_catalog({key: DOES_NOT_MATTER for key in CATALOG_FIELDS})

  def test_missing_one(self):
    fields = [key for key in sorted(CATALOG_FIELDS) if key != TYPE]
    self.assert_catalog(
        {key: DOES_NOT_MATTER for key in fields},
        'Catalog missing required fields: type')

  def test_missing_all(self):
    fields = ', '.join(sorted(CATALOG_FIELDS))
    message = 'Catalog missing required fields: ' + fields
    self.assert_catalog({}, message)


class CollectionTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = required.Check

  def test_valid(self):
    self.assert_collection({key: DOES_NOT_MATTER for key in COLLECTION_FIELDS})

  def test_missing_one(self):
    fields = [key for key in sorted(COLLECTION_FIELDS) if key != TYPE]
    self.assert_collection(
        {key: DOES_NOT_MATTER for key in fields},
        'Collection missing required fields: type')

  def test_missing_all(self):
    fields = ', '.join(sorted(COLLECTION_FIELDS))
    message = 'Collection missing required fields: ' + fields
    self.assert_collection({}, message)


if __name__ == '__main__':
  absltest.main()

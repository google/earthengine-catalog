"""Tests for required."""

import pathlib

from google3.third_party.earthengine_catalog.checker import stac
from google3.third_party.earthengine_catalog.checker.node import required
from google3.testing.pybase import googletest

Check = required.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE
TYPE = required.TYPE

CATALOG_FIELDS = required.CATALOG_FIELDS
COLLECTION_FIELDS = required.COLLECTION_FIELDS

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')
DOES_NOT_MATTER = 'does not matter'


class CatalogTest(googletest.TestCase):

  def setUp(self):
    super().setUp()
    self.node = stac.Node(ID, FILE_PATH, CATALOG, NONE, {})

  def test_valid(self):
    self.node.stac = {key: DOES_NOT_MATTER for key in CATALOG_FIELDS}
    issues = list(Check.run(self.node))
    self.assertEmpty(issues)

  def test_missing_one(self):
    fields = [key for key in sorted(CATALOG_FIELDS) if key != TYPE]
    self.node.stac = {key: DOES_NOT_MATTER for key in fields}
    issues = list(Check.run(self.node))
    expect = [
        Check.new_issue(self.node, 'Catalog missing required fields: type')]
    self.assertEqual(expect, issues)

  def test_missing_all(self):
    self.node.stac = {}
    issues = list(Check.run(self.node))
    fields = ', '.join(sorted(CATALOG_FIELDS))
    message = 'Catalog missing required fields: ' + fields
    expect = [Check.new_issue(self.node, message)]
    self.assertEqual(expect, issues)


class CollectionTest(googletest.TestCase):

  def setUp(self):
    super().setUp()
    self.node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, {})

  def test_valid(self):
    self.node.stac = {key: DOES_NOT_MATTER for key in COLLECTION_FIELDS}
    issues = list(Check.run(self.node))
    self.assertEmpty(issues)

  def test_missing_one(self):
    fields = [key for key in sorted(COLLECTION_FIELDS) if key != TYPE]
    self.node.stac = {key: DOES_NOT_MATTER for key in fields}
    issues = list(Check.run(self.node))
    expect = [
        Check.new_issue(self.node, 'Collection missing required fields: type')]
    self.assertEqual(expect, issues)

  def test_missing_all(self):
    self.node.stac = {}
    issues = list(Check.run(self.node))
    fields = ', '.join(sorted(COLLECTION_FIELDS))
    message = 'Collection missing required fields: ' + fields
    expect = [Check.new_issue(self.node, message)]
    self.assertEqual(expect, issues)

if __name__ == '__main__':
  googletest.main()

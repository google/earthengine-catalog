"""Tests for gee_type."""

import pathlib

from checker import stac
from checker.node import gee_type
import unittest

Check = gee_type.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
IMAGE_COLLECTION = stac.GeeType.IMAGE_COLLECTION
NONE = stac.GeeType.NONE
TABLE = stac.GeeType.TABLE
TABLE_COLLECTION = stac.GeeType.TABLE_COLLECTION

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class GeeTypeTest(unittest.TestCase):

  def test_catalog(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_image(self):
    stac_data = {'gee:type': 'image'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_image_collection(self):
    stac_data = {'gee:type': 'image_collection'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_table(self):
    stac_data = {'gee:type': 'table'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_table_collection(self):
    stac_data = {'gee:type': 'table_collection'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_not_a_str(self):
    stac_data = {'gee:type': 77}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gee:type must be a str')]
    self.assertEqual(expect, issues)

  def test_bogus(self):
    stac_data = {'gee:type': 'bogus'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:type must be one of '
        '[\'image\', \'image_collection\', \'table\', \'table_collection\']')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

"""Tests for type_field."""

import pathlib

from checker import stac
from checker.node import type_field
import unittest

Check = type_field.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class CatalogTest(unittest.TestCase):

  def test_valid(self):
    stac_data = {'type': 'Catalog'}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_misssing(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Missing: type')]
    self.assertEqual(expect, issues)

  def test_not_a_str(self):
    stac_data = {'type': 555}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'type must be a str')]
    self.assertEqual(expect, issues)

  def test_invalid_str(self):
    stac_data = {'type': 'bogus string'}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'type must be one of [\'Catalog\', \'Collection\']')]
    self.assertEqual(expect, issues)


class CollectionTest(unittest.TestCase):

  def test_valid(self):
    stac_data = {'type': 'Collection'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_misssing(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Missing: type')]
    self.assertEqual(expect, issues)

  def test_not_a_str(self):
    stac_data = {'type': 555}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'type must be a str')]
    self.assertEqual(expect, issues)

  def test_invalid_str(self):
    stac_data = {'type': 'bogus string'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'type must be one of [\'Catalog\', \'Collection\']')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

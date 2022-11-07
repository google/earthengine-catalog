"""Tests for gee_unusual_terms_of_use."""

import pathlib

from checker import stac
from checker.node import gee_unusual_terms_of_use
import unittest

Check = gee_unusual_terms_of_use.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class GeeTypeTest(unittest.TestCase):

  def test_catalog(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_cc_nc(self):
    stac_data = {'license': 'CC-BY-NC-4.0', 'gee:unusual_terms_of_use': True}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_cc_nc_sa(self):
    stac_data = {'license': 'CC-BY-NC-SA-4.0', 'gee:unusual_terms_of_use': True}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_proprietary(self):
    stac_data = {'license': 'proprietary', 'gee:unusual_terms_of_use': True}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_catalog_with_unusual(self):
    stac_data = {'gee:unusual_terms_of_use': True}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:unusual_terms_of_use not allowed in Catalog')]
    self.assertEqual(expect, issues)

  def test_valid_cc_nc_without_unusual(self):
    stac_data = {'license': 'CC-BY-NC-4.0'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'dataset has license that is unusual, '
        'but missing gee:unusual_terms_of_use')]
    self.assertEqual(expect, issues)

  def test_not_a_bool(self):
    stac_data = {
        'license': 'proprietary', 'gee:unusual_terms_of_use': 'not a bool'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:unusual_terms_of_use must be of type bool')]
    self.assertEqual(expect, issues)

  def test_false(self):
    stac_data = {'license': 'proprietary', 'gee:unusual_terms_of_use': False}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:unusual_terms_of_use not allowed when false')]
    self.assertEqual(expect, issues)

  def test_cc_by_is_not_unusual(self):
    stac_data = {'license': 'CC-BY-4.0', 'gee:unusual_terms_of_use': True}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:unusual_terms_of_use not allowed for CC-BY-4.0')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

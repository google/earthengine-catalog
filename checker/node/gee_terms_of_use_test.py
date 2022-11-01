"""Tests for gee_terms_of_use."""

import pathlib

from checker import stac
from checker.node import gee_terms_of_use
import unittest

Check = gee_terms_of_use.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE

ID = 'a/test/id'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class GeeTermsOfUseTest(unittest.TestCase):

  def test_valid(self):
    stac_data = {'gee:terms_of_use': 'Yada yada yada'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_catalog(self):
    stac_data = {'gee:terms_of_use': 'Yada'}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalog cannot have gee:terms_of_use')]
    self.assertEqual(expect, issues)

  def test_missing(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Collection must have gee:terms_of_use')]
    self.assertEqual(expect, issues)

  def test_not_str(self):
    stac_data = {'gee:terms_of_use': True}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gee:terms_of_use must be a str')]
    self.assertEqual(expect, issues)

  def test_too_short(self):
    stac_data = {'gee:terms_of_use': 'a'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gee:terms_of_use is too short: 1')]
    self.assertEqual(expect, issues)

  def test_too_long(self):
    stac_data = {'gee:terms_of_use': 'a' * 2401}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gee:terms_of_use is too long: 2401')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

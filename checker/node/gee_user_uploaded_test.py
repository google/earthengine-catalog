"""Tests for gee_user_owned."""

import pathlib

from checker import stac
from checker.node import gee_user_uploaded
import unittest

Check = gee_user_uploaded.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class GeeUserUploadedTest(unittest.TestCase):

  def test_valid_catalog(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_collection(self):
    stac_data = {'gee:user_uploaded': True}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_catalog(self):
    stac_data = {'gee:user_uploaded': True}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalog cannot have gee:user_uploaded')]
    self.assertEqual(expect, issues)

  def test_not_bool(self):
    stac_data = {'gee:user_uploaded': 'not a bool'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gee:user_uploaded must be a bool')]
    self.assertEqual(expect, issues)

  def test_false(self):
    stac_data = {'gee:user_uploaded': False}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:user_uploaded can only be present as true')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

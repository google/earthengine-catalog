"""Tests for gee_is_derived."""

import pathlib

from checker import stac
from checker.node import gee_is_derived
import unittest

Check = gee_is_derived.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE

ID = 'a/test/id'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class GeeIsDerivedTest(unittest.TestCase):

  def test_valid_landsat(self):
    stac_data = {'gee:is_derived': True}
    node = stac.Node(
        'LANDSAT/LT4_L1T_32DAY_NBRT', FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_modis(self):
    stac_data = {'gee:is_derived': True}
    node = stac.Node(
        'MODIS/MCD43A4_BAI', FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_whbu(self):
    stac_data = {'gee:is_derived': True}
    node = stac.Node('WHBU/NBAR_1YEAR', FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_catalog(self):
    stac_data = {'gee:is_derived': True}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalog cannot have gee:is_derived')]
    self.assertEqual(expect, issues)

  def test_not_bool(self):
    stac_data = {'gee:is_derived': 'not a bool'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gee:is_derived must be a bool')]
    self.assertEqual(expect, issues)

  def test_not_allowed(self):
    stac_data = {'gee:is_derived': False}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gee:is_derived not allowed in dataset')]
    self.assertEqual(expect, issues)

  def test_not_true(self):
    stac_data = {'gee:is_derived': False}
    node = stac.Node('WHBU/NBAR_1YEAR', FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:is_derived can only be present as true')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

"""Tests for file_path."""

import pathlib

from checker import stac
from checker.node import file_path
import unittest

Check = file_path.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE


class FilePathTest(unittest.TestCase):

  def test_valid_root_catalog(self):
    node = stac.Node(
        'GEE_catalog', pathlib.Path('catalog.json'), CATALOG, NONE, {})
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_catalog(self):
    node = stac.Node('A', pathlib.Path('A/catalog.json'), CATALOG, NONE, {})
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_2_level_catalog(self):
    node = stac.Node(
        'NASA/A', pathlib.Path('NASA/A/catalog.json'), CATALOG, NONE, {})
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_collection(self):
    node = stac.Node('A/B', pathlib.Path('A/A_B.json'), COLLECTION, IMAGE, {})
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_2_level_collection(self):
    node = stac.Node(
        'USGS/B/C', pathlib.Path('USGS/B/USGS_B_C.json'), COLLECTION, IMAGE, {})
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_2_level_collection_exception_gfsad1000(self):
    path = pathlib.Path('USGS/GFSAD1000/USGS_GFSAD1000_V1.json')
    node = stac.Node('USGS/GFSAD1000_V1', path, COLLECTION, IMAGE, {})
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_root_catalog_bad_name(self):
    node = stac.Node(
        'wrong name', pathlib.Path('catalog.json'), CATALOG, NONE, {})
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Root must have an id of GEE_catalog')]
    self.assertEqual(expect, issues)

  def test_non_root_catalog_used_root_id(self):
    node = stac.Node(
        'GEE_catalog', pathlib.Path('A/catalog.json'), CATALOG, NONE, {})
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, '"GEE_catalog" in the wrong place')]
    self.assertEqual(expect, issues)

  def test_bad_catalog_name(self):
    node = stac.Node('A', pathlib.Path('A/bad_name.json'), CATALOG, NONE, {})
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalog file must be catalog.json')]
    self.assertEqual(expect, issues)

  def test_bad_catalog_too_deep(self):
    node = stac.Node(
        'A/B/C', pathlib.Path('A/B/C/catalog.json'), CATALOG, NONE, {})
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalog too deep')]
    self.assertEqual(expect, issues)

  def test_bad_catalog_unexpected_2_level(self):
    node = stac.Node(
        'USGS/B', pathlib.Path('USGS/C/catalog.json'), CATALOG, NONE, {})
    issues = list(Check.run(node))
    message = (
        '2-level expected path: USGS/B/catalog.json found: USGS/C/catalog.json')
    expect = [Check.new_issue(node, message)]
    self.assertEqual(expect, issues)

  def test_bad_catalog_invalid_2_level(self):
    node = stac.Node(
        'A/B', pathlib.Path('A/B/catalog.json'), CATALOG, NONE, {})
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Found 2-level path, but expected 1-level path: [\'A\', \'B\']')]
    self.assertEqual(expect, issues)

  def test_bad_catalog_mismatch(self):
    node = stac.Node(
        'A', pathlib.Path('B/catalog.json'), CATALOG, NONE, {})
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'expected path: A/catalog.json found: B/catalog.json')]
    self.assertEqual(expect, issues)

  # COLLECTIONS
  def test_bad_2_level_collection_exception_gfsad1000(self):
    path = pathlib.Path('USGS/USGS_GFSAD1000_V1.json')
    node = stac.Node('USGS/GFSAD1000_V1', path, COLLECTION, IMAGE, {})
    issues = list(Check.run(node))
    message = (
        'Collection USGS/GFSAD1000: expected path: '
        'USGS/GFSAD1000/USGS_GFSAD1000_V1.json '
        'found: USGS/USGS_GFSAD1000_V1.json')
    expect = [Check.new_issue(node, message)]
    self.assertEqual(expect, issues)

  def test_bad_2_level_collection(self):
    node = stac.Node(
        'A/B/C', pathlib.Path('A/B/A_B_C.json'), COLLECTION, IMAGE, {})
    issues = list(Check.run(node))
    message = (
        'Collection: expected 1-level path: A/A_B_C.json '
        'found: A/B/A_B_C.json')
    expect = [Check.new_issue(node, message)]
    self.assertEqual(expect, issues)

  def test_bad_collection(self):
    node = stac.Node('A/B', pathlib.Path('A/B.json'), COLLECTION, IMAGE, {})
    issues = list(Check.run(node))
    message = 'Collection: expected 1-level path: A/A_B.json found: A/B.json'
    expect = [Check.new_issue(node, message)]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

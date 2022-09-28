"""Tests for extensions."""

import pathlib

from checker import stac
from checker.node import extensions
import unittest

Check = extensions.Check

CATALOG = stac.StacType.CATALOG
CHECK_NAME = Check.name
COLLECTION = stac.StacType.COLLECTION
EXTENSIONS = extensions.EXTENSIONS
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE
STAC_EXTENSIONS = extensions.STAC_EXTENSIONS

FILE_PATH = pathlib.Path('test/path/should/be/ignored')
ID = 'a/collection'


class ExtensionsTest(unittest.TestCase):

  def test_has_all_the_extensions(self):
    stac_json = {STAC_EXTENSIONS: EXTENSIONS}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_json)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_catalogs_cannot_have_extensions(self):
    dataset_id = 'a_catalog'
    stac_json = {STAC_EXTENSIONS: EXTENSIONS}
    node = stac.Node(dataset_id, FILE_PATH, CATALOG, NONE, stac_json)
    issues = list(Check.run(node))
    message = 'Catalogs cannot have extensions'
    expect = [stac.Issue(dataset_id, FILE_PATH, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_unknown_extension(self):
    extension = 'some extension'
    stac_json = {STAC_EXTENSIONS: [extension]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_json)
    issues = list(Check.run(node))
    message = f'Extension not allowed: "{extension}"'
    expect = [stac.Issue(ID, FILE_PATH, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_unsorted(self):
    unsorted = [EXTENSIONS[1], EXTENSIONS[0]]
    stac_json = {STAC_EXTENSIONS: unsorted}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_json)
    issues = list(Check.run(node))
    message = 'Extensions must be sorted'
    expect = [stac.Issue(ID, FILE_PATH, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_duplicate(self):
    duplicate = [EXTENSIONS[0], EXTENSIONS[0]]
    stac_json = {STAC_EXTENSIONS: duplicate}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_json)
    issues = list(Check.run(node))
    message = 'Duplicate extensions not allowed'
    expect = [stac.Issue(ID, FILE_PATH, CHECK_NAME, message)]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

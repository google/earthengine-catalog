"""Tests for gee_skip_indexing."""

import pathlib

from checker import stac
from checker.node import gee_skip_indexing
import unittest

Check = gee_skip_indexing.Check

CATALOG = stac.StacType.CATALOG
CHECK_NAME = Check.name
COLLECTION = stac.StacType.COLLECTION
FILE_PATH = pathlib.Path('test/path/should/be/ignored')
IMAGE = stac.GeeType.IMAGE
UNKNOWN_ID = stac.UNKNOWN_ID


class GeeSkipIndexingTest(unittest.TestCase):

  def test_gee_skip_indexing_not_bool(self):
    bad_val = 603
    node = stac.Node(UNKNOWN_ID, FILE_PATH, COLLECTION, IMAGE,
                     {'gee:skip_indexing': bad_val})
    issues = list(Check.run(node))
    expect = stac.Issue(UNKNOWN_ID, FILE_PATH, CHECK_NAME,
                        'gee:skip_indexing must be a bool')
    self.assertEqual([expect], issues)

  def test_gee_skip_indexing_true_on_catalog(self):
    node = stac.Node(UNKNOWN_ID, FILE_PATH, CATALOG, IMAGE,
                     {'gee:skip_indexing': True})
    issues = list(Check.run(node))
    expect = stac.Issue(UNKNOWN_ID, FILE_PATH, CHECK_NAME,
                        'Catalogs may not have a gee:skip_indexing field')
    self.assertEqual([expect], issues)

  def test_gee_skip_indexing_false_on_catalog(self):
    node = stac.Node(UNKNOWN_ID, FILE_PATH, CATALOG, IMAGE,
                     {'gee:skip_indexing': False})
    issues = list(Check.run(node))
    expect = stac.Issue(UNKNOWN_ID, FILE_PATH, CHECK_NAME,
                        'Catalogs may not have a gee:skip_indexing field')
    self.assertEqual([expect], issues)

  def test_gee_skip_indexing_happy(self):
    node = stac.Node(UNKNOWN_ID, FILE_PATH, COLLECTION, IMAGE,
                     {'gee:skip_indexing': True})
    issues = list(Check.run(node))
    self.assertEqual([], issues)


if __name__ == '__main__':
  unittest.main()

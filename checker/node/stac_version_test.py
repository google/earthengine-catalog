"""Tests for stac_version."""

import pathlib

from checker import stac
from checker.node import stac_version
import unittest

Check = stac_version.Check

CHECK_NAME = Check.name
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE

ID = 'a/test/id'
CURRENT_STAC_VERSION = '1.0.0'
STAC_VERSION = 'stac_version'

FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class StacVersionTest(unittest.TestCase):

  def test_version(self):
    stac_node = {STAC_VERSION: CURRENT_STAC_VERSION}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_node)
    issues = list(Check.run(node))
    self.assertEmpty(issues)

  def test_missing_version(self):
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, {})
    issues = list(Check.run(node))
    self.assertLen(issues, 1)

    message = 'Missing: stac_version'
    expect = stac.Issue(ID, FILE_PATH, CHECK_NAME, message)
    self.assertEqual(issues[0], expect)

  def test_wong_version(self):
    stac_node = {STAC_VERSION: CURRENT_STAC_VERSION + '-bad'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_node)
    issues = list(Check.run(node))
    self.assertLen(issues, 1)

    message = 'Unexpected stac_version: 1.0.0-bad != 1.0.0'
    expect = stac.Issue(ID, FILE_PATH, CHECK_NAME, message)
    self.assertEqual(issues[0], expect)


if __name__ == '__main__':
  unittest.main()

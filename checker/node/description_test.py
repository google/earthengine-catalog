"""Tests for description."""

import pathlib

from checker import stac
from checker.node import description
import unittest

Check = description.Check

COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')
NOT_A_STR = ['not a str']


class DescriptionTest(unittest.TestCase):

  def test_valid_collection(self):
    stac_data = {'description': 'z' * 40}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_missing(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Missing: description')]
    self.assertEqual(expect, issues)

  def test_not_a_str(self):
    stac_data = {'description': NOT_A_STR}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Description must be a str')]
    self.assertEqual(expect, issues)

  def test_too_short(self):
    stac_data = {'description': 'Too short'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Description too short: 9')]
    self.assertEqual(expect, issues)

  def test_too_long(self):
    stac_data = {'description': 'a' * 9000}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Description too long: 9000')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

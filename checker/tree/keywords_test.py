"""Tests for keywords."""

import pathlib
from unittest import mock

from checker import stac
from checker.tree import keywords
import unittest

Check = keywords.Check

COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')
SINGLE_USE_KEYWORD = 'single_use_keyword'


def mock_is_single_use_exception(keyword: str) -> bool:
  return keyword == SINGLE_USE_KEYWORD


class KeywordsTest(unittest.TestCase):

  def test_valid(self):
    stac_data = {'keywords': ['a_keyword']}
    nodes = [
        stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data),
        stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)]
    issues = list(Check.run(nodes))
    self.assertEqual(0, len(issues))

  @mock.patch.object(
      keywords, 'is_single_use_exception', mock_is_single_use_exception)
  def test_single_use_exception(self):
    stac_data = {'keywords': [SINGLE_USE_KEYWORD]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run([node]))
    for issue in issues:
      print(issue)
    self.assertEqual(0, len(issues))

  def test_bad_single_use(self):
    stac_data = {'keywords': ['a_keyword']}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run([node]))
    for issue in issues:
      print(issue)
    expect = [Check.new_issue(node, 'Only one instance of "a_keyword"')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

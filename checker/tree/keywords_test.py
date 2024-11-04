"""Tests for keywords."""

import copy
import pathlib
from unittest import mock

from absl.testing import absltest
from checker import stac
from checker.tree import keywords

Check = keywords.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')
SINGLE_USE_KEYWORD = 'single_use_keyword'


def mock_is_single_use_exception(keyword: str) -> bool:
  return keyword == SINGLE_USE_KEYWORD


class KeywordsTest(absltest.TestCase):

  def test_valid(self):
    stac_data = {'keywords': ['a_keyword']}
    collection_node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    nodes = [
        stac.Node('A', pathlib.Path('A/catalog.json'), CATALOG, NONE, {}),
        collection_node, collection_node]
    issues = list(Check.run(nodes))
    self.assertEqual(0, len(issues))

  @mock.patch.object(
      keywords, 'is_single_use_exception', mock_is_single_use_exception)
  def test_single_use_exception(self):
    stac_data = {'keywords': [SINGLE_USE_KEYWORD]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run([node]))
    self.assertEqual(0, len(issues))

  def test_bad_single_use(self):
    stac_data = {'keywords': ['a_keyword']}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run([node]))
    expect = [Check.new_issue(
        node, 'Only one instance of "a_keyword"')]
    self.assertEqual(expect, issues)

  def test_no_longer_single_use(self):
    single_use_keyword = 'vnp09ga'
    node = stac.Node(
        '> UNKNOWN ID: ', pathlib.Path('> UNKNOWN PATH'), COLLECTION, IMAGE,
        {'keywords': [single_use_keyword]})
    issues = list(Check.run([node, node]))
    expect = [Check.new_issue(
        node, '"vnp09ga" should be removed from exceptions')]
    self.assertEqual(expect, issues)

  def test_effectively_single_use(self):
    single_use_keyword = 'a_keyword'
    node = stac.Node(
        '> UNKNOWN ID: ',
        pathlib.Path('> UNKNOWN PATH'),
        COLLECTION,
        IMAGE,
        {'keywords': [single_use_keyword]},
    )
    node2 = copy.deepcopy(node)
    node2.stac['gee:status'] = 'deprecated'
    issues = list(Check.run([node, node2]))
    expect = [Check.new_issue(node, 'Only one instance of "a_keyword"')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  absltest.main()

"""Tests for stac."""

import pathlib

from checker import stac
import unittest

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE

ID = 'id'
EMPTY_PATH = pathlib.Path('')


class NodeTest(unittest.TestCase):

  def test_two_level_catalog(self):
    node = stac.Node(ID, EMPTY_PATH, CATALOG, IMAGE, {})

    for dataset_id in ('', 'a', 'a/b', 'a/b/c'):
      node.id = dataset_id
      self.assertFalse(node.is_two_level())

    for dataset_id in ('NASA', 'NOAA', 'USGS'):
      node.id = dataset_id
      self.assertFalse(
          node.is_two_level(), f'id should not be two level: {dataset_id}')

    for dataset_id in ('NASA/b', 'NOAA/b', 'USGS/b'):
      node.id = dataset_id
      self.assertTrue(
          node.is_two_level(), f'id should be two level: {dataset_id}')

  def test_two_level_collection(self):
    node = stac.Node(ID, EMPTY_PATH, COLLECTION, IMAGE, {})

    for dataset_id in ('a', 'a/b', 'a/b/c'):
      node.id = dataset_id
      self.assertFalse(node.is_two_level())

    for dataset_id in ('NASA', 'NOAA', 'USGS', 'NASA/b', 'NOAA/b', 'USGS/b'):
      node.id = dataset_id
      self.assertFalse(
          node.is_two_level(), f'id should not be two level: {dataset_id}')

    for dataset_id in ('NASA/b/c', 'NOAA/b/d', 'USGS/b/d', 'NASA/b/c/d'):
      node.id = dataset_id
      self.assertTrue(
          node.is_two_level(), f'id should be two level: {dataset_id}')


class IssueTest(unittest.TestCase):

  def test_str(self):
    issue = stac.Issue('an id', pathlib.Path('a path'), 'a name', 'a message')
    expect = (
        """Issue('an id', 'a path', 'a name', 'a message', IssueLevel.error)""")
    self.assertEqual(expect, str(issue))

  def test_str_warning(self):
    issue = stac.Issue(
        id='a', path=pathlib.Path('b'), check_name='c', message='d',
        level=stac.IssueLevel.WARNING)
    expect = (
        """Issue('a', 'b', 'c', 'd', IssueLevel.warning)""")
    self.assertEqual(expect, str(issue))


class CheckTest(unittest.TestCase):

  def test_new_issue(self):
    dataset_id = 'an id'
    path = pathlib.Path('a/path')
    stac_type = stac.StacType.COLLECTION
    gee_type = stac.GeeType.TABLE
    stac_data = {'field': 'value'}
    node = stac.Node(dataset_id, path, stac_type, gee_type, stac_data)

    message = 'a message'
    issue = stac.Check.new_issue(node, message)

    self.assertEqual(dataset_id, issue.id)
    self.assertEqual(path, issue.path)
    self.assertEqual('unknown', issue.check_name)
    self.assertEqual(message, issue.message)
    self.assertEqual(stac.IssueLevel.ERROR, issue.level)

  def test_new_issue_with_warning(self):
    dataset_id = 'id2'
    path = pathlib.Path('another/path')
    stac_type = stac.StacType.COLLECTION
    gee_type = stac.GeeType.TABLE
    stac_data = {'field2': 'value2'}
    node = stac.Node(dataset_id, path, stac_type, gee_type, stac_data)

    message = 'a message'
    issue = stac.Check.new_issue(node, message, stac.IssueLevel.WARNING)

    expect = stac.Issue(
        dataset_id, path, 'unknown', message, stac.IssueLevel.WARNING)

    self.assertEqual(expect, issue)

  def test_not_implemented(self):
    node = stac.Node(
        ID, EMPTY_PATH, stac.StacType.COLLECTION, stac.GeeType.TABLE, {})

    with self.assertRaises(NotImplementedError):
      stac.NodeCheck.run(node)
    with self.assertRaises(NotImplementedError):
      stac.TreeCheck.run([node])


if __name__ == '__main__':
  unittest.main()

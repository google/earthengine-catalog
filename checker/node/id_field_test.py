"""Tests for id_field.

TODO(schwehr): Write a detailed description of what makes a valid dataset id.
"""

import pathlib

from google3.third_party.earthengine_catalog.checker import stac
from google3.third_party.earthengine_catalog.checker.node import id_field
from google3.testing.pybase import googletest

Check = id_field.Check

CATALOG = stac.StacType.CATALOG
CHECK_NAME = Check.name
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
UNKNOWN_ID = stac.UNKNOWN_ID

FILE_PATH = pathlib.Path('test/path/should/be/ignored')
ID = 'id'


def node_from_catalog_id(dataset_id: str) -> stac.Node:
  return stac.Node(dataset_id, FILE_PATH, CATALOG, IMAGE, {ID: dataset_id})


class IdFieldCatalogTest(googletest.TestCase):

  def test_valid_id(self):
    id_list = ['A', 'b', 'c_d', 'd-f', 'g' * 50, 'FIRMS', 'NASA', 'NASA/b']
    for dataset_id in id_list:
      issues = list(Check.run(node_from_catalog_id(dataset_id)))
      self.assertEmpty(issues)

  def test_no_id(self):
    node = stac.Node(UNKNOWN_ID, FILE_PATH, CATALOG, IMAGE, {})
    issues = list(Check.run(node))
    expect = stac.Issue(UNKNOWN_ID, FILE_PATH, CHECK_NAME, 'Missing: id')
    self.assertEqual([expect], issues)

  def test_empty_id(self):
    node = stac.Node(UNKNOWN_ID, FILE_PATH, CATALOG, IMAGE, {ID: ''})
    issues = list(Check.run(node))
    expect = stac.Issue(UNKNOWN_ID, FILE_PATH, CHECK_NAME, 'Empty id')
    self.assertEqual([expect], issues)

  def test_cannot_start_with_slash(self):
    # pathlib is tripped up by a leading slash, so we catch it early.
    dataset_id = '/'
    issues = list(Check.run(node_from_catalog_id(dataset_id)))
    message = 'id cannot start with "/"'
    expect = stac.Issue(dataset_id, FILE_PATH, CHECK_NAME, message)
    self.assertEqual([expect], issues)

  def test_bad_start_character(self):
    dataset_id = '^bad_start_character'
    issues = list(Check.run(node_from_catalog_id(dataset_id)))
    message = 'id part not valid: "^bad_start_character"'
    expect = stac.Issue(dataset_id, FILE_PATH, CHECK_NAME, message)
    self.assertEqual([expect], issues)

  def test_bad_middle_character(self):
    dataset_id = 'bad$character'
    issues = list(Check.run(node_from_catalog_id(dataset_id)))
    message = 'id part not valid: "bad$character"'
    expect = stac.Issue(dataset_id, FILE_PATH, CHECK_NAME, message)
    self.assertEqual([expect], issues)

  def test_bad_two_level(self):
    dataset_id = 'NOT_NASA/something'
    issues = list(Check.run(node_from_catalog_id(dataset_id)))
    message = 'id length must be 1 for catalogs: "NOT_NASA/something": 2'
    expect = stac.Issue(dataset_id, FILE_PATH, CHECK_NAME, message)
    self.assertEqual([expect], issues)

  def test_bad_two_level_starts_with_two_level(self):
    dataset_id = 'NASA/b/c'
    issues = list(Check.run(node_from_catalog_id(dataset_id)))
    message = 'id length must be 1 for catalogs: "NASA/b/c": 3'
    expect = stac.Issue(dataset_id, FILE_PATH, CHECK_NAME, message)
    self.assertEqual([expect], issues)


def node_from_collection_id(dataset_id: str) -> stac.Node:
  return stac.Node(dataset_id, FILE_PATH, COLLECTION, IMAGE, {ID: dataset_id})


class IdFieldCollectionTest(googletest.TestCase):

  def test_valid_id(self):
    # TODO(schwehr): The top level of catalogs
    id_list = [
        'a/b', 'a/b/c', '0/1/2', 'A/B_C/V2', 'A/B-C', 'a/' + 'b' * 50,
        '1/2/3/4/5/6/7', 'USGS/a', 'USGS/b/c', 'FIRMS']
    for dataset_id in id_list:
      issues = list(Check.run(node_from_collection_id(dataset_id)))
      self.assertEmpty(issues)

  def test_no_top_level(self):
    # 'FIRMS' is the only exception.
    dataset_id = 'ab'
    issues = list(Check.run(node_from_collection_id(dataset_id)))
    message = f'id length less than 2 for collection: {dataset_id}: 1'
    expect = stac.Issue(dataset_id, FILE_PATH, CHECK_NAME, message)
    self.assertEqual([expect], issues)

  def test_bad_first_character(self):
    dataset_id = 'a/_'
    issues = list(Check.run(node_from_collection_id(dataset_id)))
    message = 'id part not valid: "_"'
    expect = stac.Issue(dataset_id, FILE_PATH, CHECK_NAME, message)
    self.assertEqual([expect], issues)

  def test_bad_middleharacter(self):
    dataset_id = 'a/b.c'
    issues = list(Check.run(node_from_collection_id(dataset_id)))
    message = 'id part not valid: "b.c"'
    expect = stac.Issue(dataset_id, FILE_PATH, CHECK_NAME, message)
    self.assertEqual([expect], issues)

  def test_part_too_long(self):
    part2 = 'b' * 52
    dataset_id = 'a/' + part2
    issues = list(Check.run(node_from_collection_id(dataset_id)))
    message = f'id part not valid: "{part2}"'
    expect = stac.Issue(dataset_id, FILE_PATH, CHECK_NAME, message)
    self.assertEqual([expect], issues)

  def test_too_deep(self):
    dataset_id = '1/2/3/4/5/6/7/8'
    issues = list(Check.run(node_from_collection_id(dataset_id)))
    message = 'id length greater than 7 for collection: 1/2/3/4/5/6/7/8: 8'
    expect = stac.Issue(dataset_id, FILE_PATH, CHECK_NAME, message)
    self.assertEqual([expect], issues)

  def test_multiple_issues(self):
    dataset_id = '1/2/3/4/5/6/7/8/$'
    issues = list(Check.run(node_from_collection_id(dataset_id)))
    message1 = 'id part not valid: "$"'
    message2 = 'id length greater than 7 for collection: 1/2/3/4/5/6/7/8/$: 9'
    issue1 = stac.Issue(dataset_id, FILE_PATH, CHECK_NAME, message1)
    issue2 = stac.Issue(dataset_id, FILE_PATH, CHECK_NAME, message2)
    expect = [issue1, issue2]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  googletest.main()

"""Tests for title."""

import pathlib

from checker import stac
from checker.node import title
import unittest

Check = title.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
DEPRECATED = title.DEPRECATED
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE
TITLE = title.TITLE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')
NOT_A_STR = ['not a str']


class CatalogTest(unittest.TestCase):

  def setUp(self):
    super().setUp()
    self.node = stac.Node(ID, FILE_PATH, CATALOG, NONE, {})

  def test_valid(self):
    dataset_id = 'ValidCatalogTitle'
    self.node.id = dataset_id
    self.node.stac = {TITLE: dataset_id}
    issues = list(Check.run(self.node))
    self.assertEmpty(issues)

  def test_exception(self):
    self.node.id = 'USGS/3DEP'
    self.node.stac = {TITLE: '3DEP'}
    issues = list(Check.run(self.node))
    self.assertEmpty(issues)

  def test_required(self):
    self.node.stac = {}
    issues = list(Check.run(self.node))
    expect = [Check.new_issue(self.node, 'Missing title')]
    self.assertEqual(expect, issues)

  def test_is_str(self):
    self.node.stac = {TITLE: NOT_A_STR}
    issues = list(Check.run(self.node))
    expect = [Check.new_issue(self.node, '"title" must be a str')]
    self.assertEqual(expect, issues)

  def test_invalid(self):
    dataset_id = 'not a valid title'
    self.node.id = dataset_id
    self.node.stac = {TITLE: dataset_id}
    issues = list(Check.run(self.node))
    message = 'Catalog title not valid: "not a valid title"'
    expect = [Check.new_issue(self.node, message)]
    self.assertEqual(expect, issues)

  def test_warning_for_title_not_being_last_id_component(self):
    self.node.id = 'A_catalog'
    self.node.stac = {TITLE: 'A_title'}
    issues = list(Check.run(self.node))
    message = (
        'Catalog title is usually the dataset id: "A_catalog" != "A_title"')
    expect = Check.new_issue(self.node, message, stac.IssueLevel.WARNING)
    self.assertEqual([expect], issues)


class CollectionTest(unittest.TestCase):

  def setUp(self):
    super().setUp()
    self.node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, {})

  def test_valid(self):
    self.node.stac = {TITLE: 'A collection title'}
    issues = list(Check.run(self.node))
    self.assertEmpty(issues)

  def test_deprecated(self):
    # Over size limit with deprecation str
    self.node.stac = {TITLE: 'A' * 140 + DEPRECATED}
    issues = list(Check.run(self.node))
    self.assertEmpty(issues)

  def test_exception(self):
    dataset_id = 'ISDASOIL/Africa/v1/ph'
    self.node.id = dataset_id
    self.node.stac = {TITLE: dataset_id}
    issues = list(Check.run(self.node))
    self.assertEmpty(issues)

  def test_invalid(self):
    self.node.stac = {TITLE: '% not a valid title'}
    issues = list(Check.run(self.node))
    message = 'Collection title not valid: "% not a valid title"'
    expect = [Check.new_issue(self.node, message)]
    self.assertEqual(expect, issues)

  def test_invalid_too_long(self):
    extra = 'Z' * 140
    self.node.stac = {TITLE: 'Too long ' + extra}
    issues = list(Check.run(self.node))
    message = f'Collection title not valid: "Too long {extra}"'
    expect = [Check.new_issue(self.node, message)]
    self.assertEqual(expect, issues)

if __name__ == '__main__':
  unittest.main()

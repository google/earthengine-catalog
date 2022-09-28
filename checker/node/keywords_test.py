"""Tests for keywords."""

import pathlib

from checker import stac
from checker.node import keywords
import unittest

Check = keywords.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
KEYWORDS = keywords.KEYWORDS

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')
NOT_A_LIST = 'not a list'


class KeywordsTest(unittest.TestCase):

  def setUp(self):
    super().setUp()
    self.node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, {})

  def test_valid(self):
    self.node.stac = {KEYWORDS: ['ab', 'c_d', 'e9']}
    issues = list(Check.run(self.node))
    self.assertEqual(0, len(issues))

  def test_catalog_cannot_have_keywords(self):
    node = stac.Node(ID, FILE_PATH, CATALOG, IMAGE, {KEYWORDS: ['ab']})
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalogs cannot have "keywords"')]
    self.assertEqual(expect, issues)

  def test_collection_must_have_keywords(self):
    issues = list(Check.run(self.node))
    expect = [Check.new_issue(self.node, 'Collections must have "keywords"')]
    self.assertEqual(expect, issues)

  def test_keywords_is_list(self):
    self.node.stac = {KEYWORDS: NOT_A_LIST}
    issues = list(Check.run(self.node))
    expect = [Check.new_issue(self.node, '"keywords" must be a list')]
    self.assertEqual(expect, issues)

  def test_at_least_one_keyword(self):
    self.node.stac = {KEYWORDS: []}
    issues = list(Check.run(self.node))
    expect = [
        Check.new_issue(self.node, '"keywords" must have at least one keyword')]
    self.assertEqual(expect, issues)

  def test_keywords_must_be_str(self):
    self.node.stac = {KEYWORDS: [999]}
    issues = list(Check.run(self.node))
    expect = [Check.new_issue(self.node, 'keyword must be a string: "999"')]
    self.assertEqual(expect, issues)

  def test_keyword_not_valid(self):
    self.node.stac = {KEYWORDS: [
        '1b',  # Must start with a letter
        'Ab',  # Must be lower case
        'a',  # Too short
        'cD',  # Must be lower case
        'e-f',  # No dashes
        'g h',  # No spaces
    ]}
    issues = list(Check.run(self.node))
    expect = []
    for keyword in self.node.stac[KEYWORDS]:
      expect.append(Check.new_issue(
          self.node,
          f'keyword must contain only letters, digits, and underscores and be '
          f'at most 49 characters long: "{keyword}"'))
    self.assertEqual(expect, issues)

  def test_sorted(self):
    self.node.stac = {KEYWORDS: ['bb', 'aa']}
    issues = list(Check.run(self.node))
    expect = [Check.new_issue(self.node, '"keywords" must be sorted')]
    self.assertEqual(expect, issues)

  def test_duplicate(self):
    self.node.stac = {KEYWORDS: ['aa', 'aa']}
    issues = list(Check.run(self.node))
    expect = [Check.new_issue(self.node, 'duplicate keyword found')]
    self.assertEqual(expect, issues)

if __name__ == '__main__':
  unittest.main()

"""Tests for links."""

import pathlib

from checker import stac
from checker.node import links
import unittest

Check = links.Check
JSON = 'application/json'

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')

BASE_URL = 'https://storage.googleapis.com/earthengine-stac/catalog/'
DEV_URL = 'https://developers.google.com/earth-engine/datasets/'
EXAMPLES_URL = (
    'https://code.earthengine.google.com/?scriptPath=Examples:Datasets/')


class CatalogLinkTest(unittest.TestCase):
  CHILD_LINK = {
      'title': 'thing', 'href': 'https://a/thing.json', 'rel': 'child',
      'type': JSON}
  PARENT_LINK = {'href': 'https://url 1', 'rel': 'parent', 'type': JSON}
  ROOT_LINK = {'href': 'https://url 2', 'rel': 'root', 'type': JSON}
  SELF_LINK = {'href': 'https://url 3', 'rel': 'self', 'type': JSON}

  def test_valid(self):
    stac_data = {
        'links': [
            {
                'href': BASE_URL + 'catalog.json',
                'rel': 'root',
                'type': JSON
            }, {
                'href': BASE_URL + 'catalog.json',
                'rel': 'parent',
                'type': JSON
            }, {
                'href': BASE_URL + 'USDOS/catalog.json',
                'rel': 'self',
                'type': JSON
            }, {
                'href': BASE_URL + 'USDOS/USDOS_LSIB_2013.json',
                'rel': 'child',
                'title': 'USDOS_LSIB_2013',
                'type': JSON
            },
        ],
    }
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_2_level(self):
    stac_data = {'links': [
        {
            'href': BASE_URL + 'catalog.json',
            'rel': 'root',
            'type': 'application/json'
        }, {
            'href': BASE_URL + 'catalog.json',
            'rel': 'parent',
            'type': 'application/json'
        }, {
            'href': BASE_URL + 'USGS/catalog.json',
            'rel': 'self',
            'type': 'application/json'
        }, {
            'href': BASE_URL + 'USGS/3DEP/catalog.json',
            'rel': 'child',
            'title': '3DEP',
            'type': 'application/json'}]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_empty(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Missing links')]
    self.assertEqual(expect, issues)

  def test_links_not_list(self):
    stac_data = {'links': 'not a list'}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'links must be a list')]
    self.assertEqual(expect, issues)

  def test_links_empty(self):
    stac_data = {'links': []}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'links cannot be empty')]
    self.assertEqual(expect, issues)

  def test_link_not_dict(self):
    stac_data = {'links': ['not a dict']}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'link must be a dict')]
    self.assertEqual(expect, issues)

  def test_link_key_not_str(self):
    stac_data = {'links': [{1: 'value'}]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'link key must be a str')]
    self.assertEqual(expect, issues)

  def test_link_value_not_str(self):
    stac_data = {'links': [{'key': 2}]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'link value must be a str')]
    self.assertEqual(expect, issues)

  def test_link_missing_required_href(self):
    stac_data = {'links': [{'rel': 'some value'}]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'link missing required key(s): href')]
    self.assertEqual(expect, issues)

  def test_link_missing_required_rel(self):
    stac_data = {'links': [{'href': 'some value'}]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'link missing required key(s): rel')]
    self.assertEqual(expect, issues)

  def test_link_missing_required_keys(self):
    stac_data = {'links': [{'whatever': 'some value'}]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'link missing required key(s): href, rel')]
    self.assertEqual(expect, issues)

  def test_link_href_wrong_prefix(self):
    stac_data = {'links': [
        {'href': 'gopher://1', 'rel': 'self', 'type': JSON},
        self.CHILD_LINK, self.PARENT_LINK, self.ROOT_LINK]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'href must start with ftp://, http://, https://, s3://: '
        'found: gopher://1')]
    self.assertEqual(expect, issues)

  def test_link_extra_key(self):
    stac_data = {'links': [
        {'href': 'https://1', 'rel': 'self', 'fluf': '3'},
        self.CHILD_LINK, self.PARENT_LINK, self.ROOT_LINK]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'unexpected link key(s): fluf')]
    self.assertEqual(expect, issues)

  def test_missing_root(self):
    stac_data = {'links': [
        self.CHILD_LINK, self.PARENT_LINK, self.SELF_LINK]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'missing required rel(s): root')]
    self.assertEqual(expect, issues)

  def test_missing_parent_self(self):
    stac_data = {'links': [self.CHILD_LINK, self.ROOT_LINK]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'missing required rel(s): parent, self')]
    self.assertEqual(expect, issues)

  def test_extra_parent(self):
    stac_data = {'links': [
        self.PARENT_LINK,
        self.CHILD_LINK, self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'link must have only one parent')]
    self.assertEqual(expect, issues)

  def test_extra_root(self):
    stac_data = {'links': [
        self.ROOT_LINK,
        self.CHILD_LINK, self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'link must have only one root')]
    self.assertEqual(expect, issues)

  def test_extra_self(self):
    stac_data = {'links': [
        self.SELF_LINK,
        self.CHILD_LINK, self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'link must have only one self')]
    self.assertEqual(expect, issues)

  def test_missing_media_type(self):
    stac_data = {'links': [
        {'href': 'https://url 1', 'rel': 'parent'},
        self.CHILD_LINK, self.ROOT_LINK, self.SELF_LINK]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'link parent must have a type')]
    self.assertEqual(expect, issues)

  def test_wrong_media_type(self):
    stac_data = {'links': [
        {'href': 'https://url 1', 'rel': 'parent', 'type': 'image/png'},
        self.CHILD_LINK, self.ROOT_LINK, self.SELF_LINK]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'link parent must have type of application/json')]
    self.assertEqual(expect, issues)

  def test_missing_child(self):
    stac_data = {'links': [self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalog must at least one child link')]
    self.assertEqual(expect, issues)

  def test_extra_rel(self):
    bogus_link = {'href': 'https://url 0', 'rel': 'bogon', 'type': JSON}
    stac_data = {'links': [
        bogus_link,
        self.CHILD_LINK, self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'unexpected link rel(s): bogon')]
    self.assertEqual(expect, issues)

  def test_child_mising_title(self):
    child_link = {'href': 'http://url', 'rel': 'child', 'type': JSON}
    stac_data = {'links': [
        child_link, self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'child must have a title')]
    self.assertEqual(expect, issues)

  def test_child_bad_title(self):
    child_link = {
        'title': 'bogus', 'href': 'http://a/thing.json', 'rel': 'child',
        'type': JSON}
    stac_data = {'links': [
        child_link, self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'child title must be "thing"')]
    self.assertEqual(expect, issues)

  def test_children_with_same_url(self):
    stac_data = {'links': [
        self.CHILD_LINK, self.CHILD_LINK,
        self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'child url repeated: https://a/thing.json')]
    self.assertEqual(expect, issues)


class CollectionLinkTest(unittest.TestCase):

  pass  # TODO(schwehr): Add tests specific to STAC Collections


if __name__ == '__main__':
  unittest.main()

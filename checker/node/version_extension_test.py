"""Tests for version_extension."""

import pathlib

from checker import stac
from checker.node import version_extension
import unittest

Check = version_extension.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE

CATALOG_BASE_URL = 'https://developers.google.com/earth-engine/datasets/catalog'
CATALOG_URL = CATALOG_BASE_URL + '/A_B'
ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')

VERSION_URL = 'https://stac-extensions.github.io/version/v1.0.0/schema.json'
JSON = 'application/json'


class VersionExtensionCatalogTest(unittest.TestCase):

  def test_valid_empty(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_bad_has_extension(self):
    stac_data = {'stac_extensions': [VERSION_URL]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Catalog must not have the version extension')]
    self.assertEqual(expect, issues)

  def test_bad_has_version_field(self):
    stac_data = {'version': '1'}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalog must not have "version"')]
    self.assertEqual(expect, issues)

  def test_bad_has_link_latest(self):
    stac_data = {'links': [{'rel': 'latest-version'}]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalog must not have version links')]
    self.assertEqual(expect, issues)

  def test_bad_has_link_predecessor(self):
    stac_data = {'links': [{'rel': 'predecessor-version'}]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalog must not have version links')]
    self.assertEqual(expect, issues)

  def test_bad_has_link_successor(self):
    stac_data = {'links': [{'rel': 'successor-version'}]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalog must not have version links')]
    self.assertEqual(expect, issues)

  def test_bad_has_deprecated(self):
    stac_data = {'deprecated': False}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalog must not have "deprecated"')]
    self.assertEqual(expect, issues)


class VersionExtensionCollectionTest(unittest.TestCase):

  def test_valid_empty(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_everything(self):
    stac_data = {
        'stac_extensions': [VERSION_URL],
        'version': '2.0bis',
        'deprecated': True,
        'title': 'A title [deprecated]',
        'links': [
            {'rel': 'latest-version', 'title': 'Latest', 'type': JSON},
            {'rel': 'predecessor-version', 'title': 'Older', 'type': JSON},
            {'rel': 'successor-version', 'title': 'Newer', 'type': JSON}]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_links_not_list_ignored(self):
    stac_data = {
        'stac_extensions': [VERSION_URL],
        'version': '2.0bis',
        'title': 'A title',
        'links': 'not a list'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_link_not_dict_ignored(self):
    stac_data = {
        'stac_extensions': [VERSION_URL],
        'version': '2.0bis',
        'title': 'A title',
        'links': ['not a dict']}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_link_no_rel_ignored(self):
    stac_data = {
        'stac_extensions': [VERSION_URL],
        'version': '2.0bis',
        'title': 'A title',
        'links': [{}]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_extension_version_not_str(self):
    stac_data = {'version': '1', 'stac_extensions': [123]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Extensions must be a url str')]
    self.assertEqual(expect, issues)

  def test_wrong_extension_version(self):
    stac_data = {'version': '1', 'stac_extensions': [
        'https://stac-extensions.github.io/version/v0.9.0/schema.json']}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Extension\'s version must be: "1.0.0"')]
    self.assertEqual(expect, issues)

  def test_missing_version_field(self):
    stac_data = {'stac_extensions': [VERSION_URL]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Must have "version" with the version ext')]
    self.assertEqual(expect, issues)

  def test_version_field_without_extension(self):
    stac_data = {'version': 'abc123'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Version extension not found, but has version field')]
    self.assertEqual(expect, issues)

  def test_deprecated_field_without_extension(self):
    stac_data = {'deprecated': False}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Version extension not found, but has deprecated field')]
    self.assertEqual(expect, issues)

  def test_version_field_not_str(self):
    stac_data = {'stac_extensions': [VERSION_URL], 'version': 321}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, '"version" must be a str')]
    self.assertEqual(expect, issues)

  def test_deprecated_field_not_bool(self):
    stac_data = {
        'stac_extensions': [VERSION_URL], 'version': '1',
        'deprecated': 'Not a bool'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, '"deprecated" must be a bool')]
    self.assertEqual(expect, issues)

  def test_missing_extension_with_link(self):
    stac_data = {'links': [
        {'rel': 'predecessor-version', 'title': 'Older', 'type': JSON}]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Version extension not found, but have version links')]
    self.assertEqual(expect, issues)

  def test_title_not_set_for_deprecated(self):
    stac_data = {
        'stac_extensions': [VERSION_URL],
        'version': '3.1.45',
        'deprecated': True,
        'title': 'A title'}
        # 'title': 'A title [deprecated]'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'The title for deprecated assets must end with " [deprecated]"')]
    self.assertEqual(expect, issues)

  def test_title_deprecated_for_deprecated_false(self):
    stac_data = {
        'stac_extensions': [VERSION_URL],
        'version': '3.1.45',
        'deprecated': False,
        'title': 'A title [deprecated]'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'The title for non-deprecated assets must not end with "[deprecated]"')]
    self.assertEqual(expect, issues)

  def test_title_deprecated_for_non_deprecated(self):
    stac_data = {
        'stac_extensions': [VERSION_URL], 'version': '3.1.45',
        'title': 'A title [deprecated]'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'The title for non-deprecated assets must not end with "[deprecated]"')]
    self.assertEqual(expect, issues)

  def test_link_json(self):
    stac_data = {
        'stac_extensions': [VERSION_URL],
        'version': '2.0bis',
        'title': 'A title',
        'links': [
            {'rel': 'predecessor-version', 'title': 'Older'}]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Link must be of type "application/json"')]
    self.assertEqual(expect, issues)

  def test_link_title(self):
    stac_data = {
        'stac_extensions': [VERSION_URL],
        'version': '2.0bis',
        'title': 'A title',
        'links': [
            {'rel': 'predecessor-version', 'type': JSON}]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Link must have a "title"')]
    self.assertEqual(expect, issues)

  def test_links_only_latest(self):
    stac_data = {
        'stac_extensions': [VERSION_URL], 'version': '4',
        'links': [{'rel': 'latest-version', 'title': 'Latest', 'type': JSON}]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Must have one of "predecessor-version" or "successor-version"')]
    self.assertEqual(expect, issues)

  def test_deprecated_without_latest_or_successor(self):
    stac_data = {
        'stac_extensions': [VERSION_URL],
        'version': '5',
        'deprecated': True,
        'title': 'A title [deprecated]',
        'links': [
            {'rel': 'predecessor-version', 'title': 'Older', 'type': JSON}]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'Deprecated assets must have one or both of '
        'latest-version or successor-version links')]
    self.assertEqual(expect, issues)

  def test_successor_but_not_deprecated(self):
    stac_data = {
        'stac_extensions': [VERSION_URL],
        'version': '6',
        'deprecated': False,
        'links': [
            {'rel': 'successor-version', 'title': 'Newer', 'type': JSON}]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Missing deprecated with successor-version link')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

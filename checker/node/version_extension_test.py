"""Tests for version_extension."""

from checker import test_utils
from checker.node import version_extension
from absl.testing import absltest

CATALOG_BASE_URL = 'https://developers.google.com/earth-engine/datasets/catalog'
CATALOG_URL = CATALOG_BASE_URL + '/A_B'

VERSION_URL = 'https://stac-extensions.github.io/version/v1.0.0/schema.json'
JSON = 'application/json'


class VersionExtensionCatalogTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = version_extension.Check

  def test_valid_empty(self):
    self.assert_catalog({})

  def test_bad_has_extension(self):
    self.assert_catalog(
        {'stac_extensions': [VERSION_URL]},
        'Catalog must not have the version extension')

  def test_bad_has_version_field(self):
    self.assert_catalog({'version': '1'}, 'Catalog must not have "version"')

  def test_bad_has_link_latest(self):
    self.assert_catalog(
        {'links': [{'rel': 'latest-version'}]},
        'Catalog must not have version links')

  def test_bad_has_link_predecessor(self):
    self.assert_catalog(
        {'links': [{'rel': 'predecessor-version'}]},
        'Catalog must not have version links')

  def test_bad_has_link_successor(self):
    self.assert_catalog(
        {'links': [{'rel': 'successor-version'}]},
        'Catalog must not have version links')

  def test_bad_has_deprecated(self):
    self.assert_catalog(
        {'deprecated': False}, 'Catalog must not have "deprecated"')


class VersionExtensionCollectionTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = version_extension.Check

  def test_valid_empty(self):
    self.assert_collection({})

  def test_valid_everything(self):
    self.assert_collection({
        'stac_extensions': [VERSION_URL],
        'version': '2.0bis',
        'deprecated': True,
        'title': 'A title [deprecated]',
        'links': [
            {'rel': 'latest-version', 'title': 'Latest', 'type': JSON},
            {'rel': 'predecessor-version', 'title': 'Older', 'type': JSON},
            {'rel': 'successor-version', 'title': 'Newer', 'type': JSON}]})

  def test_links_not_list_ignored(self):
    self.assert_collection({
        'stac_extensions': [VERSION_URL],
        'version': '2.0bis',
        'title': 'A title',
        'links': 'not a list'})

  def test_link_not_dict_ignored(self):
    self.assert_collection({
        'stac_extensions': [VERSION_URL],
        'version': '2.0bis',
        'title': 'A title',
        'links': ['not a dict']})

  def test_link_no_rel_ignored(self):
    self.assert_collection({
        'stac_extensions': [VERSION_URL],
        'version': '2.0bis',
        'title': 'A title',
        'links': [{}]})

  def test_extension_version_not_str(self):
    self.assert_collection(
        {'version': '1', 'stac_extensions': [123]},
        'Extensions must be a url str')

  def test_wrong_extension_version(self):
    self.assert_collection(
        {'version': '1', 'stac_extensions': [
            'https://stac-extensions.github.io/version/v0.9.0/schema.json']},
        'Extension\'s version must be: "1.0.0"')

  def test_missing_version_field(self):
    self.assert_collection(
        {'stac_extensions': [VERSION_URL]},
        'Must have "version" with the version ext')

  def test_version_field_without_extension(self):
    self.assert_collection(
        {'version': 'abc123'},
        'Version extension not found, but has version field')

  def test_deprecated_field_without_extension(self):
    self.assert_collection(
        {'deprecated': False},
        'Version extension not found, but has deprecated field')

  def test_version_field_not_str(self):
    self.assert_collection(
        {'stac_extensions': [VERSION_URL], 'version': 321},
        '"version" must be a str')

  def test_deprecated_field_not_bool(self):
    self.assert_collection(
        {'stac_extensions': [VERSION_URL], 'version': '1',
         'deprecated': 'Not a bool'},
        '"deprecated" must be a bool')

  def test_missing_extension_with_link(self):
    self.assert_collection(
        {'links': [
            {'rel': 'predecessor-version', 'title': 'Older', 'type': JSON}]},
        'Version extension not found, but have version links')

  def test_title_not_set_for_deprecated(self):
    self.assert_collection(
        {'stac_extensions': [VERSION_URL],
         'version': '3.1.45',
         'deprecated': True,
         'title': 'A title'},
        'The title for deprecated assets must end with " [deprecated]"')

  def test_title_deprecated_for_deprecated_false(self):
    self.assert_collection(
        {'stac_extensions': [VERSION_URL],
         'version': '3.1.45',
         'deprecated': False,
         'title': 'A title [deprecated]'},
        'The title for non-deprecated assets must not end with "[deprecated]"')

  def test_title_deprecated_for_non_deprecated(self):
    self.assert_collection(
        {'stac_extensions': [VERSION_URL], 'version': '3.1.45',
         'title': 'A title [deprecated]'},
        'The title for non-deprecated assets must not end with "[deprecated]"')

  def test_link_json(self):
    self.assert_collection(
        {'stac_extensions': [VERSION_URL],
         'version': '2.0bis',
         'title': 'A title',
         'links': [{'rel': 'predecessor-version', 'title': 'Older'}]},
        'Link must be of type "application/json"')

  def test_link_title(self):
    self.assert_collection(
        {'stac_extensions': [VERSION_URL],
         'version': '2.0bis',
         'title': 'A title',
         'links': [{'rel': 'predecessor-version', 'type': JSON}]},
        'Link must have a "title"')

  def test_links_only_latest(self):
    self.assert_collection(
        {'stac_extensions': [VERSION_URL], 'version': '4',
         'links': [{'rel': 'latest-version', 'title': 'Latest', 'type': JSON}]},
        'Must have one of "predecessor-version" or "successor-version"')

  def test_deprecated_without_latest_or_successor(self):
    self.assert_collection(
        {'stac_extensions': [VERSION_URL],
         'version': '5',
         'deprecated': True,
         'title': 'A title [deprecated]',
         'links': [
             {'rel': 'predecessor-version', 'title': 'Older', 'type': JSON}]},
        'Deprecated assets must have one or both of '
        'latest-version or successor-version links')

  def test_successor_but_not_deprecated(self):
    self.assert_collection(
        {'stac_extensions': [VERSION_URL],
         'version': '6',
         'deprecated': False,
         'links': [
             {'rel': 'successor-version', 'title': 'Newer', 'type': JSON}]},
        'Missing deprecated with successor-version link')


if __name__ == '__main__':
  absltest.main()

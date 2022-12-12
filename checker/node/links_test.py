"""Tests for links."""

from checker import test_utils
from checker.node import links
from absl.testing import absltest

BASE_URL = 'https://storage.googleapis.com/earthengine-stac/catalog/'
DEV_URL = 'https://developers.google.com/earth-engine/datasets/'
EXAMPLES_URL = (
    'https://code.earthengine.google.com/?scriptPath=Examples:Datasets/')
JSON = 'application/json'


class CatalogLinkTest(test_utils.NodeTest):
  CHILD_LINK = {
      'title': 'thing', 'href': 'https://a/thing.json', 'rel': 'child',
      'type': JSON}
  PARENT_LINK = {'href': 'https://url 1', 'rel': 'parent', 'type': JSON}
  ROOT_LINK = {'href': 'https://url 2', 'rel': 'root', 'type': JSON}
  SELF_LINK = {'href': 'https://url 3', 'rel': 'self', 'type': JSON}

  def setUp(self):
    super().setUp()
    self.check = links.Check

  def test_valid(self):
    self.assert_catalog({
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
            }]})

  def test_2_level(self):
    self.assert_catalog({'links': [
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
            'type': 'application/json'}]})

  def test_empty(self):
    self.assert_catalog({}, 'Missing links')

  def test_links_not_list(self):
    self.assert_catalog({'links': 'not a list'}, 'links must be a list')

  def test_links_empty(self):
    self.assert_catalog({'links': []}, 'links cannot be empty')

  def test_link_not_dict(self):
    self.assert_catalog({'links': ['not a dict']}, 'link must be a dict')

  def test_link_key_not_str(self):
    self.assert_catalog({'links': [{1: 'value'}]}, 'link key must be a str')

  def test_link_value_not_str(self):
    self.assert_catalog({'links': [{'key': 2}]}, 'link value must be a str')

  def test_link_missing_required_href(self):
    self.assert_catalog(
        {'links': [{'rel': 'some value'}]},
        'link missing required key(s): href')

  def test_link_missing_required_rel(self):
    self.assert_catalog(
        {'links': [{'href': 'some value'}]},
        'link missing required key(s): rel')

  def test_link_missing_required_keys(self):
    self.assert_catalog(
        {'links': [{'whatever': 'some value'}]},
        'link missing required key(s): href, rel')

  def test_link_href_wrong_prefix(self):
    self.assert_catalog(
        {'links': [
            {'href': 'gopher://1', 'rel': 'self', 'type': JSON},
            self.CHILD_LINK, self.PARENT_LINK, self.ROOT_LINK]},
        'href must start with ftp://, http://, https://, s3://: '
        'found: gopher://1')

  def test_link_extra_key(self):
    self.assert_catalog(
        {'links': [
            {'href': 'https://1', 'rel': 'self', 'fluf': '3', 'type': JSON},
            self.CHILD_LINK, self.PARENT_LINK, self.ROOT_LINK]},
        'unexpected link key(s): fluf')

  def test_link_disallowed_media_type(self):
    bad_type = 'application/bogus'
    self_link = {
        'href': BASE_URL + 'USGS/catalog.json',
        'rel': 'self',
        'type': bad_type}
    media_types = '\', \''.join([
        'application/json', 'application/pdf', 'image/png', 'text/html'])
    media_types = '\'' + media_types + '\''
    self.assert_catalog(
        {'links': [
            self_link, self.CHILD_LINK, self.PARENT_LINK, self.ROOT_LINK]},
        [f'type must be one of [{media_types}]: {bad_type}',
         'link self must have type of application/json'])

  def test_missing_root(self):
    self.assert_catalog(
        {'links': [self.CHILD_LINK, self.PARENT_LINK, self.SELF_LINK]},
        'missing required rel(s): root')

  def test_missing_parent_self(self):
    self.assert_catalog(
        {'links': [self.CHILD_LINK, self.ROOT_LINK]},
        'missing required rel(s): parent, self')

  def test_extra_parent(self):
    self.assert_catalog({
        'links': [
            self.PARENT_LINK,
            self.CHILD_LINK, self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]},
                        'link must have only one parent')

  def test_extra_root(self):
    self.assert_catalog(
        {'links': [
            self.ROOT_LINK,
            self.CHILD_LINK, self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]},
        'link must have only one root')

  def test_extra_self(self):
    self.assert_catalog(
        {'links': [
            self.SELF_LINK,
            self.CHILD_LINK, self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]},
        'link must have only one self')

  def test_missing_media_type(self):
    self.assert_catalog({'links': [
        {'href': 'https://url 1', 'rel': 'parent'},
        self.CHILD_LINK, self.ROOT_LINK, self.SELF_LINK]},
                        'link parent must have a type')

  def test_wrong_media_type(self):
    self.assert_catalog(
        {'links': [
            {'href': 'https://url 1', 'rel': 'parent', 'type': 'image/png'},
            self.CHILD_LINK, self.ROOT_LINK, self.SELF_LINK]},
        'link parent must have type of application/json')

  def test_missing_child(self):
    self.assert_catalog(
        {'links': [self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]},
        'Catalog must at least one child link')

  def test_extra_rel(self):
    bogus_link = {'href': 'https://url 0', 'rel': 'bogon', 'type': JSON}
    self.assert_catalog(
        {'links': [
            bogus_link,
            self.CHILD_LINK, self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]},
        'unexpected link rel(s): bogon')

  def test_child_mising_title(self):
    child_link = {'href': 'http://url', 'rel': 'child', 'type': JSON}
    self.assert_catalog(
        {'links': [
            child_link, self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]},
        'child must have a title')

  def test_child_bad_title(self):
    child_link = {
        'title': 'bogus', 'href': 'http://a/thing.json', 'rel': 'child',
        'type': JSON}
    self.assert_catalog(
        {'links': [
            child_link, self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]},
        'child title must be "thing"')

  def test_children_with_same_url(self):
    self.assert_catalog(
        {'links': [
            self.CHILD_LINK, self.CHILD_LINK,
            self.PARENT_LINK, self.ROOT_LINK, self.SELF_LINK]},
        'child url repeated: https://a/thing.json')


class CollectionLinkTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = links.Check

  # TODO(schwehr): Add tests specific to STAC Collections


if __name__ == '__main__':
  absltest.main()

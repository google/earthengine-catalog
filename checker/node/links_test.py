"""Tests for links."""

import pathlib
from unittest import mock

from checker import stac
from checker import test_utils
from checker.node import links
from absl.testing import absltest

TABLE = stac.GeeType.TABLE

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
        'href must start with ftp://, gs://, http://, https://, s3://: '
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
        'catalog: unexpected link rel(s): bogon')

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

  node_id = 'AHN/AHN2_05M_RUW'
  node_path = pathlib.Path('AHN/AHN_AHN2_05M_RUW.json')

  preview = {
      'href': DEV_URL + 'images/AHN/AHN_AHN2_05M_RUW_sample.png',
      'rel': 'preview',
      'type': 'image/png'
  }

  terms_of_use = {
      'href': DEV_URL + 'catalog/AHN_AHN2_05M_RUW#terms-of-use',
      'rel': 'license',
      'type': 'text/html',
  }

  example = {
      'code': 'JavaScript',
      'href': EXAMPLES_URL + 'AHN_AHN2_05M_RUW',
      'rel': 'related',
      'title': ('Run the example for AHN/AHN2_05M_RUW in the '
                'Earth Engine Code Editor'),
      'type': 'text/html'
  }
  feature_view = {
      'code': 'JavaScript',
      'href': EXAMPLES_URL + 'AHN_AHN2_05M_RUW_FeatureView',
      'rel': 'related',
      'title': ('Run the example for AHN/AHN2_05M_RUW in the '
                'Earth Engine Code Editor'),
      'type': 'text/html'
  }

  required_links = [{
      'href': BASE_URL + 'AHN/AHN_AHN2_05M_RUW.json',
      'rel': 'self',
      'type': 'application/json'
  }, {
      'href': BASE_URL + 'AHN/catalog.json',
      'rel': 'parent',
      'type': 'application/json'
  }, {
      'href': BASE_URL + 'catalog.json',
      'rel': 'root',
      'type': 'application/json'
  }, example, preview, terms_of_use]

  def setUp(self):
    super().setUp()
    self.check = links.Check

  def test_valid_has_everything(self):
    stac_data = {'links': self.required_links + [self.feature_view, {
        'href': 'https://example.test/license.html',
        'rel': 'license',
        'type': 'text/html'
    }, {
        'href': 'https://doi.org/10.5281/zenodo.3518026',
        'rel': 'cite-as'
    }, {
        'href': 'https://lcviewer.vito.be/download',
        'rel': 'source'
    }, {
        'href': BASE_URL + 'THING/THING_latest.json',
        'rel': 'latest-version',
        'title': 'THING/THING_latest',
        'type': 'application/json'
    }, {
        'href': BASE_URL + 'THING/THING_predecessor.json',
        'rel': 'predecessor-version',
        'title': 'THING/THING_predecessor',
        'type': 'application/json'
    }, {
        'href': BASE_URL + 'THING/THING_successor.json',
        'rel': 'successor-version',
        'title': 'THING/THING_successor',
        'type': 'application/json'
    }]}
    self.assert_collection(
        stac_data,
        dataset_id=self.node_id,
        file_path=self.node_path,
        gee_type=stac.GeeType.TABLE)

  def test_missing_required(self):
    stac_links = [l for l in self.required_links if l['rel'] != 'license']
    self.assert_collection(
        {'links': stac_links}, 'collection: missing required rel(s): license')

  def test_missing_all_required(self):
    stac_links = [
        l for l in self.required_links
        if l['rel'] not in {'license', 'preview', 'related'}]
    self.assert_collection(
        {'links': stac_links},
        'collection: missing required rel(s): license, preview, related')

  def test_extra_relation(self):
    stac_data = {'links': self.required_links + [
        {'href': 'https://example.test', 'rel': 'bogus2'},
        {'href': 'https://example.test', 'rel': 'bogus1'},
    ]}
    self.assert_collection(
        stac_data, 'collection: unexpected link rel(s): bogus1, bogus2')

  def test_extra_preview(self):
    stac_data = {'links': self.required_links + [self.preview]}
    self.assert_collection(
        stac_data, 'more than one preview found: 2',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_preview_missing(self):
    stac_links = [l for l in self.required_links if l['rel'] != 'preview']
    stac_links.append({
        'href': DEV_URL + 'images/AHN/AHN_AHN2_05M_RUW_sample.png',
        'rel': 'preview'})
    self.assert_collection(
        {'links': stac_links}, 'preview missing type',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_preview_wrong_type(self):
    stac_links = [l for l in self.required_links if l['rel'] != 'preview']
    stac_links.append({
        'href': DEV_URL + 'images/AHN/AHN_AHN2_05M_RUW_sample.png',
        'rel': 'preview', 'type': JSON})
    self.assert_collection(
        {'links': stac_links},
        'preview type not image/png: application/json',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_preview_bad_url(self):
    stac_links = [l for l in self.required_links if l['rel'] != 'preview']
    stac_links.append(
        {'href': 'https://example.test', 'rel': 'preview', 'type': 'image/png'})
    message = (
        'preview href must be https://developers.google.com/earth-engine/'
        'datasets/images/AHN/AHN_AHN2_05M_RUW_sample.png. '
        'Found: https://example.test')
    self.assert_collection(
        {'links': stac_links}, message,
        dataset_id=self.node_id, file_path=self.node_path)

  def test_preview_extra_key(self):
    preview = self.preview | {'title': 'should not have a title'}
    stac_links = [l for l in self.required_links if l['rel'] != 'preview']
    stac_links.append(preview)
    self.assert_collection(
        {'links': stac_links}, 'unexpected preview key(s): title',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_terms_missing(self):
    stac_links = [l for l in self.required_links if l['rel'] != 'license']
    # There has to be at least one license entry to avoid triggering an
    # earlier check.
    stac_links.append({'href': 'https://example.test', 'rel': 'license'})
    self.assert_collection(
        {'links': stac_links},
        'cannot find terms license ending in #terms-of-use',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_terms_too_many(self):
    self.assert_collection(
        {'links': self.required_links + [self.terms_of_use]},
        'Only one terms license link allowed',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_terms_bad_url(self):
    stac_links = [l for l in self.required_links if l['rel'] != 'license']
    stac_links.append(
        {'href': 'https://example.test#terms-of-use', 'rel': 'license',
         'type': 'text/html'})
    self.assert_collection(
        {'links': stac_links},
        'terms license href must be https://developers.google.com/earth-engine/'
        'datasets/catalog/AHN_AHN2_05M_RUW#terms-of-use. '
        'Found: https://example.test#terms-of-use',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_terms_missing_type(self):
    stac_links = [l for l in self.required_links if l['rel'] != 'license']
    stac_links.append({
        'href': DEV_URL + 'catalog/AHN_AHN2_05M_RUW#terms-of-use',
        'rel': 'license'})
    self.assert_collection(
        {'links': stac_links}, 'terms license missing type',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_terms_wrong_type(self):
    stac_links = [l for l in self.required_links if l['rel'] != 'license']
    stac_links.append({
        'href': DEV_URL + 'catalog/AHN_AHN2_05M_RUW#terms-of-use',
        'rel': 'license', 'type': 'application/json'})
    self.assert_collection(
        {'links': stac_links},
        'terms license type not text/html: application/json',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_terms_extra_key(self):
    stac_links = [l for l in self.required_links if l['rel'] != 'license']
    stac_links.append({
        'code': 'bogus',
        'href': DEV_URL + 'catalog/AHN_AHN2_05M_RUW#terms-of-use',
        'rel': 'license', 'type': 'text/html'})
    self.assert_collection(
        {'links': stac_links}, 'unexpected terms key(s): code',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_example_missing(self):
    stac_links = [l for l in self.required_links if l['rel'] != 'related']
    stac_links.append({'href': 'https://example.test', 'rel': 'related'})
    self.assert_collection(
        {'links': stac_links}, 'Missing example related link',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_example_double(self):
    stac_links = self.required_links + [self.example]
    self.assert_collection(
        {'links': stac_links}, 'More than 1 example related link: 2',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_example_bad_url(self):
    example = dict(self.example)
    example['href'] = 'https://example.test'
    stac_links = [l for l in self.required_links if l['rel'] != 'related']
    stac_links.append(example)
    self.assert_collection(
        {'links': stac_links},
        'code href must be https://code.earthengine.google.com/?scriptPath='
        'Examples:Datasets/AHN_AHN2_05M_RUW. Found: https://example.test',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_example_title_missing(self):
    example = dict(self.example)
    example.pop('title')
    stac_links = [l for l in self.required_links if l['rel'] != 'related']
    stac_links.append(example)
    self.assert_collection(
        {'links': stac_links}, 'Missing example title',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_example_title_bad(self):
    example = dict(self.example)
    example['title'] = 'bogus'
    stac_links = [l for l in self.required_links if l['rel'] != 'related']
    stac_links.append(example)
    self.assert_collection(
        {'links': stac_links},
        'title must be Run the example for AHN/AHN2_05M_RUW in the '
        'Earth Engine Code Editor. Found: bogus',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_example_type_missing(self):
    example = dict(self.example)
    example.pop('type')
    stac_links = [l for l in self.required_links if l['rel'] != 'related']
    stac_links.append(example)
    self.assert_collection(
        {'links': stac_links}, 'example missing type',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_example_type_bad(self):
    example = dict(self.example)
    example['type'] = 'application/json'
    stac_links = [l for l in self.required_links if l['rel'] != 'related']
    stac_links.append(example)
    self.assert_collection(
        {'links': stac_links}, 'example type not text/html: text/html',
        dataset_id=self.node_id, file_path=self.node_path)

  def test_feature_view_missing(self):
    self.assert_collection(
        {'links': self.required_links},
        'Missing example related FeatureView link',
        dataset_id=self.node_id, file_path=self.node_path, gee_type=TABLE)

  def test_feature_view_double(self):
    stac_links = self.required_links + [self.feature_view, self.feature_view]
    self.assert_collection(
        {'links': stac_links},
        'More than 1 example related FeatureView link: 2',
        dataset_id=self.node_id, file_path=self.node_path, gee_type=TABLE)

  def test_feature_view_bad_url(self):
    feature_view = dict(self.feature_view)
    feature_view['href'] = 'https://example.test/foo_FeatureView'
    self.assert_collection(
        {'links': self.required_links + [feature_view]},
        'code href must be https://code.earthengine.google.com/?scriptPath='
        'Examples:Datasets/AHN_AHN2_05M_RUW_FeatureView. '
        'Found: https://example.test/foo_FeatureView',
        dataset_id=self.node_id, file_path=self.node_path, gee_type=TABLE)

  def test_feature_view_title_missing(self):
    feature_view = dict(self.feature_view)
    feature_view.pop('title')
    self.assert_collection(
        {'links': self.required_links + [feature_view]},
        'Missing example related FeatureView title',
        dataset_id=self.node_id, file_path=self.node_path, gee_type=TABLE)

  def test_feature_view_title_bad(self):
    feature_view = dict(self.feature_view)
    feature_view['title'] = 'bogus'
    self.assert_collection(
        {'links': self.required_links + [feature_view]},
        'title must be Run the example for AHN/AHN2_05M_RUW in the '
        'Earth Engine Code Editor. Found: bogus',
        dataset_id=self.node_id, file_path=self.node_path, gee_type=TABLE)

  def test_feature_view_type_missing(self):
    feature_view = dict(self.feature_view)
    feature_view.pop('type')
    self.assert_collection(
        {'links': self.required_links + [feature_view]}, 'example missing type',
        dataset_id=self.node_id, file_path=self.node_path, gee_type=TABLE)

  def test_feature_view_type_bad(self):
    feature_view = dict(self.feature_view)
    feature_view['type'] = 'application/json'
    self.assert_collection(
        {'links': self.required_links + [feature_view]},
        'example type not text/html: text/html',
        dataset_id=self.node_id, file_path=self.node_path, gee_type=TABLE)

  def test_feature_view_not_for_image_datasets(self):
    stac_links = self.required_links + [self.feature_view]
    self.assert_collection(
        {'links': stac_links},
        'image cannot have example related a FeatureView link',
        dataset_id=self.node_id, file_path=self.node_path)

  @mock.patch.object(links, 'feature_view_exception', return_value=True)
  def test_feature_view_exception_with_fv(self, mock_feature_view_exp):
    del mock_feature_view_exp  # Unused
    stac_links = self.required_links + [self.feature_view]
    self.assert_collection(
        {'links': stac_links},
        'Remove node from feature view exceptions',
        dataset_id=self.node_id, file_path=self.node_path, gee_type=TABLE)


if __name__ == '__main__':
  absltest.main()

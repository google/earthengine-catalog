"""Tests for feature_view."""

from checker import stac
from checker import test_utils
from checker.node import feature_view
from absl.testing import absltest

IMAGE_COLLECTION = stac.GeeType.IMAGE_COLLECTION
TABLE = stac.GeeType.TABLE
TABLE_COLLECTION = stac.GeeType.TABLE_COLLECTION


class ValidFeatureViewTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = feature_view.Check

  def test_valid_density_desc(self):
    self.assert_collection(
        {'summaries': {'gee:feature_view_ingestion_params': {
            'max_features_per_tile': 150,
            'thinning_strategy': 'HIGHER_DENSITY',
            'thinning_ranking': ['BurnBndAc DESC'],
            'z_order_ranking': ['BurnBndAc DESC'],
            'prerender_tiles': True}}},
        gee_type=TABLE)

  def test_valid_global_asc(self):
    self.assert_collection(
        {'summaries': {'gee:feature_view_ingestion_params': {
            'max_features_per_tile': 16000,
            'thinning_strategy': 'GLOBALLY_CONSISTENT',
            'thinning_ranking': ['rttyp ASC'],
            'z_order_ranking': ['rttyp ASC']}}},
        gee_type=TABLE)

  def test_valid_dot_field(self):
    self.assert_collection(
        {'summaries': {'gee:feature_view_ingestion_params': {
            'max_features_per_tile': 12000,
            'thinning_ranking': ['.geometryType DESC'],
            'z_order_ranking': ['.minZoomLevel DESC']}}},
        gee_type=TABLE)

  def test_valid_list_len_2(self):
    self.assert_collection(
        {'summaries': {'gee:feature_view_ingestion_params': {
            'thinning_ranking': ['prop1 DESC', 'prop2 ASC'],
            'z_order_ranking': ['prop3 ASC', 'prop4 DESC']}}},
        gee_type=TABLE)

  def test_no_summaries(self):
    self.assert_collection({}, gee_type=TABLE)

  def test_summaries_not_dict(self):
    self.assert_collection({'summaries': 'not a dict'}, gee_type=TABLE)

  def test_table_collection(self):
    self.assert_collection({'summaries': {}}, gee_type=TABLE_COLLECTION)

  def test_skip_featureview_generation(self):
    self.assert_collection(
        {'gee:skip_featureview_generation': True,
         'summaries': {'gee:feature_view_ingestion_params': {
             'max_features_per_tile': 16000}}},
        gee_type=TABLE)


class ErrorFeatureViewTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = feature_view.Check

  def test_image_with_params(self):
    self.assert_collection(
        {'summaries': {'gee:feature_view_ingestion_params': 'yada'}},
        'gee:feature_view_ingestion_params not allowed in image')

  def test_image_collection_with_params(self):
    self.assert_collection(
        {'summaries': {'gee:feature_view_ingestion_params': 'yada'}},
        'gee:feature_view_ingestion_params not allowed in image_collection',
        gee_type=IMAGE_COLLECTION)

  def test_table_collection_with_params(self):
    self.assert_collection(
        {'summaries': {'gee:feature_view_ingestion_params': 'yada'}},
        'gee:feature_view_ingestion_params not allowed in table_collection',
        gee_type=TABLE_COLLECTION)

  def test_table_without_params(self):
    self.assert_collection(
        {'summaries': {}},
        'gee:feature_view_ingestion_params must be present in table',
        gee_type=TABLE)

  def test_params_not_dict(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': 'not a dict'}},
        'gee:feature_view_ingestion_params must be a dict',
        gee_type=TABLE)

  def test_params_empty(self):
    self.assert_collection(
        {'summaries': {'gee:feature_view_ingestion_params': {}}},
        'gee:feature_view_ingestion_params must not be empty',
        gee_type=TABLE)

  def test_max_features_not_int(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {
                'max_features_per_tile': 99.99}}},
        'max_features_per_tile must be an int',
        gee_type=TABLE)

  def test_max_features_too_small(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {
                'max_features_per_tile': 149}}},
        'max_features_per_tile must be >= 150',
        gee_type=TABLE)

  def test_max_features_too_large(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {
                'max_features_per_tile': 20001}}},
        'max_features_per_tile must be <= 16000',
        gee_type=TABLE)

  def test_thinning_strategy_not_str(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {'thinning_strategy': 12}}},
        'thinning_strategy must be a str',
        gee_type=TABLE)

  def test_thinning_strategy_invalid_str(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {
                'thinning_strategy': 'bogus'}}},
        'thinning_strategy must be one of GLOBALLY_CONSISTENT, HIGHER_DENSITY',
        gee_type=TABLE)

  def test_thinning_ranking_not_list(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {
                'thinning_ranking': 'not a list'}}},
        'thinning_ranking must be a list',
        gee_type=TABLE)

  def test_thinning_ranking_empty_list(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {'thinning_ranking': []}}},
        'thinning_ranking list must have at least one str',
        gee_type=TABLE)

  def test_thinning_ranking_list_not_str(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {'thinning_ranking': [22]}}},
        'Each thinning_ranking element must be a str',
        gee_type=TABLE)

  def test_thinning_ranking_too_few(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {
                'thinning_ranking': ['ASC']}}},
        'thinning_ranking must be "<field> ASC|DESC',
        gee_type=TABLE)

  def test_thinning_ranking_too_many(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {
                'thinning_ranking': ['id DESC extra']}}},
        'thinning_ranking must be "<field> ASC|DESC',
        gee_type=TABLE)

  def test_thinning_ranking_name(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {
                'thinning_ranking': ['i DESC']}}},
        'Invalid property_name: "i"',
        gee_type=TABLE)

  def test_thinning_ranking_direction(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {
                'thinning_ranking': ['id ASCENDING']}}},
        'thinning_ranking direction must be one of ASC, DESC',
        gee_type=TABLE)

  def test_z_order_ranking_not_list(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {
                'z_order_ranking': 'not a list'}}},
        'z_order_ranking must be a list',
        gee_type=TABLE)

  def test_z_order_ranking_empty_list(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {'z_order_ranking': []}}},
        'z_order_ranking list must have at least one str',
        gee_type=TABLE)

  def test_z_order_ranking_entry_not_str(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {'z_order_ranking': [21]}}},
        'Each z_order_ranking element must be a str',
        gee_type=TABLE)

  def test_z_order_ranking_too_few(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {'z_order_ranking': ['ABC']}}},
        'z_order_ranking must be "<field> ASC|DESC',
        gee_type=TABLE)

  def test_z_order_ranking_too_many(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {
                'z_order_ranking': ['id DESC extra']}}},
        'z_order_ranking must be "<field> ASC|DESC',
        gee_type=TABLE)

  def test_z_order_ranking_name(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {
                'z_order_ranking': ['i DESC']}}},
        'Invalid property_name: "i"',
        gee_type=TABLE)

  def test_z_order_ranking_direction(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {
                'z_order_ranking': ['id DESCENDING']}}},
        'z_order_ranking direction must be one of ASC, DESC',
        gee_type=TABLE)

  def test_prerender_tiles_not_str(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {
                'prerender_tiles': 'not a bool'}}},
        'prerender_tiles must be a bool',
        gee_type=TABLE)

  def test_prerender_tiles_false(self):
    self.assert_collection(
        {'summaries': {
            'gee:feature_view_ingestion_params': {'prerender_tiles': False}}},
        'prerender_tiles can only be present when true',
        gee_type=TABLE)

  def test_skip_featureview_generation_cannot_be_false(self):
    self.assert_collection(
        {'gee:skip_featureview_generation': False,
         'summaries': {'gee:feature_view_ingestion_params': {
             'max_features_per_tile': 16000}}},
        'gee:skip_featureview_generation cannot be false',
        gee_type=TABLE)

  def test_skip_featureview_generation_cannot_be_in_an_image(self):
    self.assert_collection(
        {'gee:skip_featureview_generation': 'does not matter'},
        'gee:skip_featureview_generation not allowed in image')

  def test_skip_featureview_generation_cannot_be_in_an_image_collection(self):
    self.assert_collection(
        {'gee:skip_featureview_generation': 'does not matter'},
        'gee:skip_featureview_generation not allowed in image_collection',
        gee_type=IMAGE_COLLECTION)

  def test_skip_featureview_generation_cannot_be_in_an_table_collection(self):
    self.assert_collection(
        {'gee:skip_featureview_generation': 'does not matter'},
        'gee:skip_featureview_generation not allowed in table_collection',
        gee_type=TABLE_COLLECTION)

  def test_skip_featureview_generation_without_params_ok(self):
    self.assert_collection(
        {'gee:skip_featureview_generation': True, 'summaries': {}},
        gee_type=TABLE,
    )

  def test_skip_featureview_generation_must_be_bool(self):
    self.assert_collection(
        {'gee:skip_featureview_generation': 'not a bool',
         'summaries': {'gee:feature_view_ingestion_params': {
             'max_features_per_tile': 16000}}},
        'gee:skip_featureview_generation must be a bool',
        gee_type=TABLE)


if __name__ == '__main__':
  absltest.main()

"""Tests for summaries."""

from checker import stac
from checker import test_utils
from checker.node import summaries
from absl.testing import absltest

IMAGE_COLLECTION = stac.GeeType.IMAGE_COLLECTION
TABLE = stac.GeeType.TABLE
TABLE_COLLECTION = stac.GeeType.TABLE_COLLECTION


class ValidSummariesTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = summaries.Check

  def test_catalog(self):
    self.assert_catalog({})

  def test_image(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': 'does not matter',
            'gee:visualizations': 'does not matter'}})

  def test_image_collection(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': 'does not matter',
            'gee:visualizations': 'does not matter'}},
        gee_type=IMAGE_COLLECTION)

  def test_table(self):
    self.assert_collection(
        {'summaries': {
            'gee:schema': 'does not matter',
            'gee:visualizations': 'does not matter'}},
        gee_type=TABLE)

  def test_table_collection(self):
    self.assert_collection(
        {'summaries': {
            'gee:schema': 'does not matter',
            'gee:visualizations': 'does not matter'}},
        gee_type=TABLE_COLLECTION)

  def test_with_band(self):
    self.assert_collection(
        {'summaries': {
            'band_name': 'does not matter',
            'eo:bands': [{'name': 'band_name'}],
            'gee:visualizations': 'does not matter'}})

  def test_image_all_optional_fields(self):
    self.assert_collection(
        {'summaries': {
            # Required
            'eo:bands': 'does not matter',
            'gee:visualizations': 'does not matter',
            # Optional
            'constellation': 'does not matter',
            'gee:feature_view_ingestion_params': 'does not matter',
            'gee:schema': 'does not matter',
            'gsd': 'does not matter',
            'instruments': 'does not matter',
            'platform': 'does not matter',
            'sar:center_frequency': 'does not matter',
            'sar:frequency_band': 'does not matter',
            'sar:instrument_mode': 'does not matter',
            'sar:polarizations': 'does not matter',
            'sar:product_type': 'does not matter',
            'sar:resolution_azimuth': 'does not matter',
            'sar:resolution_range': 'does not matter'}})

  def test_table_all_optional_fields(self):
    self.assert_collection(
        {'summaries': {
            # Required
            'gee:visualizations': 'does not matter',
            # Optional
            'constellation': 'does not matter',
            'gee:feature_view_ingestion_params': 'does not matter',
            'gee:schema': 'does not matter',
            'gsd': 'does not matter',
            'instruments': 'does not matter',
            'platform': 'does not matter',
            'sar:center_frequency': 'does not matter',
            'sar:frequency_band': 'does not matter',
            'sar:instrument_mode': 'does not matter',
            'sar:polarizations': 'does not matter',
            'sar:product_type': 'does not matter',
            'sar:resolution_azimuth': 'does not matter',
            'sar:resolution_range': 'does not matter'}},
        gee_type=TABLE)


class ErrorSummariesTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = summaries.Check

  def test_catalog_with_summaries(self):
    self.assert_catalog(
        {'summaries': 'does not matter'},
        'summaries not allowed in Catalog')

  def test_missing_summaries(self):
    self.assert_collection(
        {},
        'Missing: summaries')

  def test_summaries_dict(self):
    self.assert_collection(
        {'summaries': 'not a dict'},
        'summaries must be a dict')

  def test_summaries_missing_required(self):
    self.assert_collection(
        {'summaries': {'eo:bands': 'does not matter'}},
        'summaries missing required keys: gee:visualizations')

  def test_image_eo_bands(self):
    self.assert_collection(
        {'summaries': {
            'gee:visualizations': 'does not matter'}},
        'image must have eo:bands in summaries')

  def test_image_collection_eo_bands(self):
    self.assert_collection(
        {'summaries': {
            'gee:visualizations': 'does not matter'}},
        'image_collection must have eo:bands in summaries',
        gee_type=IMAGE_COLLECTION)

  def test_table_schema(self):
    self.assert_collection(
        {'summaries': {
            'gee:visualizations': 'does not matter'}},
        'table must have gee:schema in summaries',
        gee_type=TABLE)

  def test_table_collection_properties(self):
    self.assert_collection(
        {'summaries': {
            'gee:visualizations': 'does not matter'}},
        'table_collection must have gee:schema in summaries',
        gee_type=TABLE_COLLECTION)

  def test_extra_key(self):
    self.assert_collection(
        {
            'summaries': {
                'bogus': 'does not matter',
                'eo:bands': 'does not matter',
                'gee:visualizations': 'does not matter',
            }
        },
        'summaries has unexpected keys: bogus. Each key must be a band name.',
    )

  def test_band_summary_with_dash(self):
    self.assert_collection(
        {
            'summaries': {
                'eo:bands': [{
                    'name': 'My-Band',
                    'description': 'Band with a dash in the name',
                }],
                'gee:visualizations': 'does not matter',
                'My_Band': 'does not matter',
            }
        }
    )

  def test_table_eo_bands(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': 'does not matter',
            'gee:schema': 'does not matter',
            'gee:visualizations': 'does not matter'}},
        'table cannot have eo:bands in summaries',
        gee_type=TABLE)

  def test_table_collection_eo_bands(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': 'does not matter',
            'gee:schema': 'does not matter',
            'gee:visualizations': 'does not matter'}},
        'table_collection cannot have eo:bands in summaries',
        gee_type=TABLE_COLLECTION)

if __name__ == '__main__':
  absltest.main()

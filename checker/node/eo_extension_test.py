"""Tests for eo_extension."""

from checker import stac
from checker import test_utils
from checker.node import eo_extension
from absl.testing import absltest

TABLE = stac.GeeType.TABLE
TABLE_COLLECTION = stac.GeeType.TABLE_COLLECTION

EO_URL = 'https://stac-extensions.github.io/eo/v1.0.0/schema.json'

MINIMUM_BANDS = [{'description': 'Burn Area Index', 'name': 'BAI'}]


class ValidEoExtensionTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = eo_extension.Check

  def test_catalog(self):
    self.assert_catalog({})

  def test_empty_image(self):
    self.assert_collection({})

  def test_empty_table(self):
    self.assert_collection({}, gee_type=TABLE)

  def test_empty_table_collection(self):
    self.assert_collection({}, gee_type=TABLE_COLLECTION)

  def test_image_summaries_not_dict(self):
    self.assert_collection({'summaries': 'not a dict'})

  def test_minimal_image(self):
    self.assert_collection({
        'stac_extensions': [EO_URL], 'summaries': {'eo:bands': MINIMUM_BANDS}})

  def test_image_without_bands_exceptions(self):
    self.assert_collection(
        {'stac_extensions': [EO_URL], 'summaries': {}},
        dataset_id='MODIS/MCD43A1')


class ErrorEoExtensionTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = eo_extension.Check

  def test_catalog_with_eo(self):
    self.assert_catalog(
        {'stac_extensions': [EO_URL]}, 'Catalog must not have the eo extension')

  def test_version(self):
    self.assert_collection(
        {'stac_extensions': [
            'https://stac-extensions.github.io/eo/v0.9.9/schema.json']},
        'Extension\'s version must be: "1.0.0"')

  def test_version_not_str(self):
    self.assert_collection(
        {'stac_extensions': [123]}, 'Extensions must be a url str')

  def test_table_with_eo(self):
    self.assert_collection(
        {'stac_extensions': [EO_URL]}, 'table must not have the eo extension',
        gee_type=TABLE)

  def test_table_collection_with_eo(self):
    self.assert_collection(
        {'stac_extensions': [EO_URL]},
        'table_collection must not have the eo extension',
        gee_type=TABLE_COLLECTION)

  def test_image_empty_summaries(self):
    self.assert_collection({'summaries': {}}, 'Missing eo:bands')

  def test_cloud_cover(self):
    self.assert_collection(
        {'stac_extensions': [EO_URL], 'summaries': {
            'eo:cloud_cover': 'yada', 'eo:bands': MINIMUM_BANDS}},
        'eo:cloud_cover not allowed')

  def test_table_with_bands(self):
    self.assert_collection(
        {'summaries': {'eo:bands': MINIMUM_BANDS}},
        'eo:bands cannot be in table',
        gee_type=TABLE)

  def test_table_collections_with_bands(self):
    self.assert_collection(
        {'summaries': {'eo:bands': MINIMUM_BANDS}},
        'eo:bands cannot be in table_collection',
        gee_type=TABLE_COLLECTION)

  def test_bands_not_list(self):
    self.assert_collection(
        {'summaries': {'eo:bands': 'not a list'}}, 'eo:bands must be a list')

  def test_bands_not_dict(self):
    self.assert_collection(
        {'summaries': {'eo:bands': ['not a dict']}}, 'band must be a dict')

  def test_bands_empty(self):
    self.assert_collection(
        {'summaries': {'eo:bands': []}}, 'eo:bands must have at least one band')

  def test_band_too_many(self):
    num_bands = 201
    bands = [
        {'name': 'ab%d' % x, 'description': 'descr'} for x in range(num_bands)]
    self.assert_collection(
        {'summaries': {'eo:bands': bands}}, 'eo:bands has more than 200 bands')

  def test_missing_name(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{'description': 'a description'}]}},
        'band "unknown" missing required key(s): name')

  def test_duplicate_name(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [
            {'name': 'duplicate2', 'description': 'a description'},
            {'name': 'duplicate2', 'description': 'a description'},
            {'name': 'duplicate1', 'description': 'a description'},
            {'name': 'duplicate1', 'description': 'a description'}]}},
        'Multiple bands with the same name(s): duplicate1, duplicate2')

  def test_name_not_str(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 4321, 'description': 'a description'}]}},
        'name must be a str')

  def test_disallowed_field(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'bogus': 'junk', 'name': 'a_name', 'description': 'a descr'}]}},
        'a_name unexpected key(s): bogus')

  def test_name_empty_str(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': '', 'description': 'a description'}]}},
        'Bad name: "". Must be 1-80 letters, numbers, and underscores')

  def test_name_too_long(self):
    name = 'a' * 81
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': name, 'description': 'a description'}]}},
        f'Bad name: "{name}". Must be 1-80 letters, numbers, and underscores')

  def test_description_not_str(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{'description': 99887, 'name': 'a_name'}]}},
        'a_name description must be a str')

  def test_description_too_short(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{'description': 'ab', 'name': 'a_name'}]}},
        'a_name description too short: 2')

  def test_description_too_long(self):
    size = 1601
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'description': 'a' * size, 'name': 'a_name'}]}},
        f'a_name description too long: {size}')

  def test_center_wavelength_not_number(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'center_wavelength': 'not a number',
            'description': 'abc', 'name': 'a_name'}]}},
        'a_name center_wavelength must be a number')

  def test_center_wavelength_too_small(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'center_wavelength': -0.01,
            'description': 'abc', 'name': 'a_name'}]}},
        'a_name center_wavelength must in (0, 15) μm')

  def test_center_wavelength_too_large(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'center_wavelength': 15.02,
            'description': 'abc', 'name': 'a_name'}]}},
        'a_name center_wavelength must in (0, 15) μm')

  def test_full_width_half_max_not_number(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'full_width_half_max': 'not a number',
            'description': 'abc', 'name': 'a_name'}]}},
        'a_name full_width_half_max must be a number')

  def test_full_width_half_max_too_small(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'full_width_half_max': -0.01,
            'description': 'abc', 'name': 'a_name'}]}},
        'a_name full_width_half_max must in (0, 0.15) μm')

  def test_full_width_half_max_too_large(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'full_width_half_max': 0.152,
            'description': 'abc', 'name': 'a_name'}]}},
        'a_name full_width_half_max must in (0, 0.15) μm')

  def test_bitmask_and_classes_not_in_same_band(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:bitmask': 'does not matter',
            'gee:classes': 'does not matter',
            'description': 'abc', 'name': 'a_name'}]}},
        'a_name cannot have both gee:bitmask and gee:classes')

  def test_offset_not_number(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:offset': 'not a number',
            'description': 'abc', 'name': 'a_name'}]}},
        'a_name gee:offset must be a number')

  def test_offset_too_negative(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:offset': -10001,
            'description': 'abc', 'name': 'a_name'}]}},
        'a_name gee:offset large negative offset: -10001')

  def test_offset_too_large(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:offset': 10001.1, 'description': 'abc', 'name': 'a_name'}]}},
        'a_name gee:offset large offset: 10001.1')

  def test_offset_zero(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:offset': 0, 'description': 'abc', 'name': 'a_name'}]}},
        'a_name zero gee:offset is redundant')

  def test_polarization_not_str(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:polarization': 987, 'description': 'abc', 'name': 'a_name'}]}},
        'a_name gee:polarization must be a str')

  def test_polarization_invalid(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:polarization': 'bogus',
            'description': 'abc', 'name': 'a_name'}]}},
        'a_name gee:polarization must be one of HH, HV, VH, VV')

  def test_scale_not_number(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:scale': 'not a number',
            'description': 'abc', 'name': 'a_name'}]}},
        'a_name gee:scale must be a number')

  def test_scale_too_small(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:scale': 1e-7, 'description': 'abc', 'name': 'a_name'}]}},
        'a_name gee:scale too small: 1e-07')

  def test_scale_too_large(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:scale': 2e5, 'description': 'abc', 'name': 'a_name'}]}},
        'a_name unreasonably large gee:scale: 200000.0')

  def test_scale_one(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:scale': 1, 'description': 'abc', 'name': 'a_name'}]}},
        'a_name gee:scale of one is redundant')

  def test_units_not_str(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:units': 603, 'description': 'abc', 'name': 'a_name'}]}},
        'a_name gee:units must be a str')

  def test_gee_wavelength_not_str(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:wavelength': 415, 'description': 'abc', 'name': 'a_name'}]}},
        'a_name gee:wavelength must be a str')

  def test_gsd_not_number(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gsd': 'not a number', 'description': 'abc', 'name': 'a_name'}]}},
        'a_name gsd must be a number')

  def test_gsd_too_small(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gsd': 0, 'description': 'abc', 'name': 'a_name'}]}},
        'a_name gsd too small: 0 m')

  def test_gsd_too_large(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gsd': 1.1e5, 'description': 'abc', 'name': 'a_name'}]}},
        'a_name unreasonably large gsd: 110000.0 m')


if __name__ == '__main__':
  absltest.main()

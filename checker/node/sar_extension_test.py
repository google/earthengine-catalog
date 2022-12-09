"""Tests for sar_extension."""

from checker import stac
from checker import test_utils
from checker.node import sar_extension
from absl.testing import absltest

TABLE = stac.GeeType.TABLE
TABLE_COLLECTION = stac.GeeType.TABLE_COLLECTION

SAR_URL = 'https://stac-extensions.github.io/sar/v1.0.0/schema.json'


class ValidSarExtensionTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = sar_extension.Check

  def test_catalog(self):
    self.assert_catalog({})

  def test_empty(self):
    self.assert_collection({})

  def test_summaries_not_dict(self):
    self.assert_collection({'summaries': 'not a dict'})

  # TODO(schwehr): table and table_collection without sar extension

  def test_minimum(self):
    self.assert_collection({'stac_extensions': [SAR_URL], 'summaries': {
        'sar:product_type': ['GRD'],
        'sar:polarizations': ['HH', 'HV', 'VH', 'VV']}})

  def test_valid_s1(self):
    self.assert_collection({'stac_extensions': [SAR_URL], 'summaries': {
        'sar:frequency_band': ['C'],
        'sar:center_frequency': [5.405],
        'sar:resolution_range': [10],
        'sar:resolution_azimuth': [10],
        'sar:instrument_mode': ['EW', 'IW', 'SM'],
        'sar:product_type': ['GRD'],
        'sar:polarizations': ['HH', 'HV', 'VH', 'VV']}})

  def test_valid_scansar(self):
    self.assert_collection({'stac_extensions': [SAR_URL], 'summaries': {
        'sar:instrument_mode': ['ScanSAR'],
        'sar:frequency_band': ['L'],
        'sar:center_frequency': [1.27],
        'sar:polarizations': ['HH', 'HV', 'VH', 'VV'],
        'sar:product_type': ['Normalised Radar Backscatter'],
        'sar:resolution_range': [25],
        'sar:resolution_azimuth': [25]}})


class ErrorSarExtensionTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = sar_extension.Check

  def test_catalog_with_extension(self):
    self.assert_catalog(
        {'stac_extensions': [SAR_URL]},
        'Catalog must not have the sar extension')

  def test_table_with_sar(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL]},
        'table cannot have sar extension',
        gee_type=TABLE)

  def test_table_collection_with_sar(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL]},
        'table_collection cannot have sar extension',
        gee_type=TABLE_COLLECTION)

  def test_bad_extension_version(self):
    self.assert_collection(
        {'stac_extensions': [
            'https://stac-extensions.github.io/sar/v0.9.1/schema.json']},
        'Extension\'s version must be: "1.0.0"')

  def test_sar_fields_without_extension(self):
    self.assert_collection(
        {'summaries': {'sar:product_type': 'does not matter'}},
        'Found sar: entries, but no sar extension')

  def test_no_sar_fields(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {}},
        'summaries missing field(s): sar:polarizations, sar:product_type')

  def test_unknown_field(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:bogus': 0, 'sar:polarizations': 1, 'sar:product_type': 2}},
        'Unexpected field(s): sar:bogus')

  def test_polarizations_not_list(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:polarizations': 'not a list', 'sar:product_type': ['GRD']}},
        'sar:polarizations must be a list')

  def test_polarizations_empty(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:polarizations': [], 'sar:product_type': ['GRD']}},
        'sar:polarizations cannot be empty')

  def test_polarizations_entry_not_str(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:polarizations': [831], 'sar:product_type': ['GRD']}},
        'sar:polarizations entries must be str')

  def test_polarizations_bogus(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:polarizations': ['VV', 'bogus'], 'sar:product_type': ['GRD']}},
        'Invalid polarization(s): bogus')

  def test_polarizations_not_sorted(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:polarizations': ['VV', 'HH'], 'sar:product_type': ['GRD']}},
        'sar:polarizations must be sorted')

  def test_product_type_not_list(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:polarizations': ['HH'], 'sar:product_type': 'not a list'}},
        'sar:product_type must be a list')

  def test_product_type_empty_list(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:polarizations': ['HH'], 'sar:product_type': []}},
        'sar:product_type cannot be empty')

  def test_product_type_not_str(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:polarizations': ['HH'], 'sar:product_type': [123]}},
        'sar:product_type entries must be str')

  def test_product_type_invalid(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:polarizations': ['HH'], 'sar:product_type': ['BOGUS']}},
        'Invalid product_type(s): BOGUS')

  def test_product_type_sorted(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:polarizations': ['HH'], 'sar:product_type': ['RTC', 'GRD']}},
        'sar:product_type must be sorted')

  def test_center_frequency_not_list(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:center_frequency': 'not a list',
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:center_frequency must be a list')

  def test_center_frequency_empty_list(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:center_frequency': [],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:center_frequency cannot be empty')

  def test_center_frequency_not_a_number(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:center_frequency': ['not a number'],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:center_frequency entries must be a number')

  def test_center_frequency_too_small(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:center_frequency': [0.2],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:center_frequency value too small')

  def test_center_frequency_too_large(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:center_frequency': [50],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:center_frequency value too large')

  def test_frequency_band_not_list(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:frequency_band': 'not a list',
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:frequency_band must be a list')

  def test_frequency_band_empty_list(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:frequency_band': [],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:frequency_band cannot be empty')

  def test_frequency_band_not_a_str(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:frequency_band': [123],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:frequency_band entries must be a str')

  def test_frequency_band_invalid(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:frequency_band': ['bogus'],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:frequency_band not valid')

  def test_instrument_mode_not_list(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:instrument_mode': 'not a list',
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:instrument_mode must be a list')

  def test_instrument_mode_empty_list(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:instrument_mode': [],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:instrument_mode cannot be empty')

  def test_instrument_mode_not_str(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:instrument_mode': [123],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:instrument_mode entries must be a str')

  def test_instrument_mode_invalid(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:instrument_mode': ['nope'],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:instrument_mode not valid: nope')

  def test_instrument_mode_sorted(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:instrument_mode': ['IW', 'EW'],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:instrument_mode must be sorted')

  def test_resolution_range_not_list(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:resolution_range': 'not a list',
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:resolution_range must be a list')

  def test_resolution_range_empty_list(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:resolution_range': [],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:resolution_range cannot be empty')

  def test_resolution_range_not_a_number(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:resolution_range': ['not a number'],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:resolution_range entries must be a number')

  def test_resolution_range_too_small(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:resolution_range': [0.2],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:resolution_range value too small')

  def test_resolution_range_too_large(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:resolution_range': [100.1],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:resolution_range value too large')

  def test_resolution_azimuth_not_list(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:resolution_azimuth': 'not a list',
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:resolution_azimuth must be a list')

  def test_resolution_azimuth_empty_list(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:resolution_azimuth': [],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:resolution_azimuth cannot be empty')

  def test_resolution_azimuth_not_a_number(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:resolution_azimuth': ['not a number'],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:resolution_azimuth entries must be a number')

  def test_resolution_azimuth_too_small(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:resolution_azimuth': [0.21],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:resolution_azimuth value too small')

  def test_resolution_azimuth_too_large(self):
    self.assert_collection(
        {'stac_extensions': [SAR_URL], 'summaries': {
            'sar:resolution_azimuth': [100.01],
            'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}},
        'sar:resolution_azimuth value too large')


if __name__ == '__main__':
  absltest.main()

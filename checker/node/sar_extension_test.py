"""Tests for sar_extension."""

import pathlib

from checker import stac
from checker.node import sar_extension
import unittest

Check = sar_extension.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE
TABLE = stac.GeeType.TABLE
TABLE_COLLECTION = stac.GeeType.TABLE_COLLECTION

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')

SAR_URL = 'https://stac-extensions.github.io/sar/v1.0.0/schema.json'


class ValidSarExtensionTest(unittest.TestCase):

  def test_catalog(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_empty(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_summaries_not_dict(self):
    stac_data = {'summaries': 'not a dict'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  # table and table_collection without sar extension

  def test_minimum(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:product_type': ['GRD'],
        'sar:polarizations': ['HH', 'HV', 'VH', 'VV']}}

    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_s1(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:frequency_band': ['C'],
        'sar:center_frequency': [5.405],
        'sar:resolution_range': [10],
        'sar:resolution_azimuth': [10],
        'sar:instrument_mode': ['EW', 'IW', 'SM'],
        'sar:product_type': ['GRD'],
        'sar:polarizations': ['HH', 'HV', 'VH', 'VV']}}

    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_scansar(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:instrument_mode': ['ScanSAR'],
        'sar:frequency_band': ['L'],
        'sar:center_frequency': [1.27],
        'sar:polarizations': ['HH', 'HV', 'VH', 'VV'],
        'sar:product_type': ['Normalised Radar Backscatter'],
        'sar:resolution_range': [25],
        'sar:resolution_azimuth': [25]}}

    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))


class ErrorSarExtensionTest(unittest.TestCase):

  def test_catalog_with_extension(self):
    stac_data = {'stac_extensions': [SAR_URL]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalog must not have the sar extension')]
    self.assertEqual(expect, issues)

  def test_table_with_sar(self):
    stac_data = {'stac_extensions': [SAR_URL]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'table cannot have sar extension')]
    self.assertEqual(expect, issues)

  def test_table_collection_with_sar(self):
    stac_data = {'stac_extensions': [SAR_URL]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'table_collection cannot have sar extension')]
    self.assertEqual(expect, issues)

  def test_bad_extension_version(self):
    stac_data = {'stac_extensions': [
        'https://stac-extensions.github.io/sar/v0.9.1/schema.json']}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Extension\'s version must be: "1.0.0"')]
    self.assertEqual(expect, issues)

  def test_sar_fields_without_extension(self):
    stac_data = {'summaries': {'sar:product_type': 'does not matter'}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Found sar: entries, but no sar extension')]
    self.assertEqual(expect, issues)

  def test_no_sar_fields(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'summaries missing field(s): sar:polarizations, sar:product_type')]
    self.assertEqual(expect, issues)

  def test_unknown_field(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:bogus': 0, 'sar:polarizations': 1, 'sar:product_type': 2}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Unexpected field(s): sar:bogus')]
    self.assertEqual(expect, issues)

  def test_polarizations_not_list(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:polarizations': 'not a list', 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:polarizations must be a list')]
    self.assertEqual(expect, issues)

  def test_polarizations_empty(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:polarizations': [], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:polarizations cannot be empty')]
    self.assertEqual(expect, issues)

  def test_polarizations_entry_not_str(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:polarizations': [831], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:polarizations entries must be str')]
    self.assertEqual(expect, issues)

  def test_polarizations_bogus(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:polarizations': ['VV', 'bogus'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Invalid polarization(s): bogus')]
    self.assertEqual(expect, issues)

  def test_polarizations_not_sorted(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:polarizations': ['VV', 'HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:polarizations must be sorted')]
    self.assertEqual(expect, issues)

  def test_product_type_not_list(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:polarizations': ['HH'], 'sar:product_type': 'not a list'}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:product_type must be a list')]
    self.assertEqual(expect, issues)

  def test_product_type_empty_list(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:polarizations': ['HH'], 'sar:product_type': []}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:product_type cannot be empty')]
    self.assertEqual(expect, issues)

  def test_product_type_not_str(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:polarizations': ['HH'], 'sar:product_type': [123]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:product_type entries must be str')]
    self.assertEqual(expect, issues)

  def test_product_type_invalid(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:polarizations': ['HH'], 'sar:product_type': ['BOGUS']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Invalid product_type(s): BOGUS')]
    self.assertEqual(expect, issues)

  def test_product_type_sorted(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:polarizations': ['HH'], 'sar:product_type': ['RTC', 'GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:product_type must be sorted')]
    self.assertEqual(expect, issues)

  def test_center_frequency_not_list(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:center_frequency': 'not a list',
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:center_frequency must be a list')]
    self.assertEqual(expect, issues)

  def test_center_frequency_empty_list(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:center_frequency': [],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:center_frequency cannot be empty')]
    self.assertEqual(expect, issues)

  def test_center_frequency_not_a_number(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:center_frequency': ['not a number'],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sar:center_frequency entries must be a number')]
    self.assertEqual(expect, issues)

  def test_center_frequency_too_small(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:center_frequency': [0.2],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sar:center_frequency value too small')]
    self.assertEqual(expect, issues)

  def test_center_frequency_too_large(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:center_frequency': [50],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sar:center_frequency value too large')]
    self.assertEqual(expect, issues)

  def test_frequency_band_not_list(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:frequency_band': 'not a list',
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:frequency_band must be a list')]
    self.assertEqual(expect, issues)

  def test_frequency_band_empty_list(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:frequency_band': [],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:frequency_band cannot be empty')]
    self.assertEqual(expect, issues)

  def test_frequency_band_not_a_str(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:frequency_band': [123],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sar:frequency_band entries must be a str')]
    self.assertEqual(expect, issues)

  def test_frequency_band_invalid(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:frequency_band': ['bogus'],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:frequency_band not valid')]
    self.assertEqual(expect, issues)

  def test_instrument_mode_not_list(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:instrument_mode': 'not a list',
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:instrument_mode must be a list')]
    self.assertEqual(expect, issues)

  def test_instrument_mode_empty_list(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:instrument_mode': [],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:instrument_mode cannot be empty')]
    self.assertEqual(expect, issues)

  def test_instrument_mode_not_str(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:instrument_mode': [123],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sar:instrument_mode entries must be a str')]
    self.assertEqual(expect, issues)

  def test_instrument_mode_invalid(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:instrument_mode': ['nope'],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:instrument_mode not valid: nope')]
    self.assertEqual(expect, issues)

  def test_instrument_mode_sorted(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:instrument_mode': ['IW', 'EW'],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:instrument_mode must be sorted')]
    self.assertEqual(expect, issues)

  def test_resolution_range_not_list(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:resolution_range': 'not a list',
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:resolution_range must be a list')]
    self.assertEqual(expect, issues)

  def test_resolution_range_empty_list(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:resolution_range': [],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:resolution_range cannot be empty')]
    self.assertEqual(expect, issues)

  def test_resolution_range_not_a_number(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:resolution_range': ['not a number'],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sar:resolution_range entries must be a number')]
    self.assertEqual(expect, issues)

  def test_resolution_range_too_small(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:resolution_range': [0.2],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sar:resolution_range value too small')]
    self.assertEqual(expect, issues)

  def test_resolution_range_too_large(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:resolution_range': [100.1],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sar:resolution_range value too large')]
    self.assertEqual(expect, issues)

  def test_resolution_azimuth_not_list(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:resolution_azimuth': 'not a list',
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:resolution_azimuth must be a list')]
    self.assertEqual(expect, issues)

  def test_resolution_azimuth_empty_list(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:resolution_azimuth': [],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sar:resolution_azimuth cannot be empty')]
    self.assertEqual(expect, issues)

  def test_resolution_azimuth_not_a_number(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:resolution_azimuth': ['not a number'],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sar:resolution_azimuth entries must be a number')]
    self.assertEqual(expect, issues)

  def test_resolution_azimuth_too_small(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:resolution_azimuth': [0.21],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sar:resolution_azimuth value too small')]
    self.assertEqual(expect, issues)

  def test_resolution_azimuth_too_large(self):
    stac_data = {'stac_extensions': [SAR_URL], 'summaries': {
        'sar:resolution_azimuth': [100.01],
        'sar:polarizations': ['HH'], 'sar:product_type': ['GRD']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sar:resolution_azimuth value too large')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

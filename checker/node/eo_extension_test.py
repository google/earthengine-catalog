"""Tests for eo_extension."""

import pathlib

from checker import stac
from checker.node import eo_extension
import unittest

Check = eo_extension.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE
TABLE = stac.GeeType.TABLE
TABLE_COLLECTION = stac.GeeType.TABLE_COLLECTION


ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')

EO_URL = 'https://stac-extensions.github.io/eo/v1.0.0/schema.json'
# JSON = 'application/json'

MINIMUM_BANDS = [{'description': 'Burn Area Index', 'name': 'BAI'}]


class ValidEoExtensionTest(unittest.TestCase):

  def test_catalog(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_empty_image(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_empty_table(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_empty_table_collection(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_image_summaries_not_dict(self):
    stac_data = {'summaries': 'not a dict'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_minimal_image(self):
    stac_data = {
        'stac_extensions': [EO_URL], 'summaries': {'eo:bands': MINIMUM_BANDS}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_image_without_bands_exceptions(self):
    stac_data = {
        'stac_extensions': [EO_URL], 'summaries': {}}
    node = stac.Node('MODIS/MCD43A1', FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))


class ErrorEoExtensionTest(unittest.TestCase):

  def test_catalog_with_eo(self):
    stac_data = {'stac_extensions': [EO_URL]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalog must not have the eo extension')]
    self.assertEqual(expect, issues)

  def test_version(self):
    stac_data = {'stac_extensions': [
        'https://stac-extensions.github.io/eo/v0.9.9/schema.json']}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Extension\'s version must be: "1.0.0"')]
    self.assertEqual(expect, issues)

  def test_version_not_str(self):
    stac_data = {'stac_extensions': [123]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Extensions must be a url str')]
    self.assertEqual(expect, issues)

  def test_table_with_eo(self):
    stac_data = {'stac_extensions': [EO_URL]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'table must not have the eo extension')]
    self.assertEqual(expect, issues)

  def test_table_collection_with_eo(self):
    stac_data = {'stac_extensions': [EO_URL]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'table_collection must not have the eo extension')]
    self.assertEqual(expect, issues)

  def test_image_empty_summaries(self):
    stac_data = {'summaries': {}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Missing eo:bands')]
    self.assertEqual(expect, issues)

  def test_cloud_cover(self):
    stac_data = {
        'stac_extensions': [EO_URL], 'summaries': {
            'eo:cloud_cover': 'yada', 'eo:bands': MINIMUM_BANDS}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'eo:cloud_cover not allowed')]
    self.assertEqual(expect, issues)

  def test_table_with_bands(self):
    stac_data = {'summaries': {'eo:bands': MINIMUM_BANDS}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'eo:bands cannot be in table')]
    self.assertEqual(expect, issues)

  def test_table_collections_with_bands(self):
    stac_data = {'summaries': {'eo:bands': MINIMUM_BANDS}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'eo:bands cannot be in table_collection')]
    self.assertEqual(expect, issues)

  def test_bands_not_list(self):
    stac_data = {'summaries': {'eo:bands': 'not a list'}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'eo:bands must be a list')]
    self.assertEqual(expect, issues)

  def test_bands_not_dict(self):
    stac_data = {'summaries': {'eo:bands': ['not a dict']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'band must be a dict')]
    self.assertEqual(expect, issues)

  def test_bands_empty(self):
    stac_data = {'summaries': {'eo:bands': []}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'eo:bands must have at least one band')]
    self.assertEqual(expect, issues)

  def test_band_too_many(self):
    num_bands = 201
    bands = [
        {'name': 'ab%d' % x, 'description': 'descr'} for x in range(num_bands)]
    stac_data = {'summaries': {'eo:bands': bands}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'eo:bands has more than 200 bands')]
    self.assertEqual(expect, issues)

  def test_missing_name(self):
    stac_data = {'summaries': {'eo:bands': [{'description': 'a description'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'band "unknown" missing required key(s): name')]
    self.assertEqual(expect, issues)

  def test_duplicate_name(self):
    stac_data = {'summaries': {'eo:bands': [
        {'name': 'duplicate2', 'description': 'a description'},
        {'name': 'duplicate2', 'description': 'a description'},
        {'name': 'duplicate1', 'description': 'a description'},
        {'name': 'duplicate1', 'description': 'a description'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Multiple bands with the same name(s): duplicate1, duplicate2')]
    self.assertEqual(expect, issues)

  def test_name_not_str(self):
    stac_data = {'summaries': {'eo:bands': [{
        'name': 4321, 'description': 'a description'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'name must be a str')]
    self.assertEqual(expect, issues)

  def test_disallowed_field(self):
    stac_data = {'summaries': {'eo:bands': [{
        'bogus': 'junk', 'name': 'a_name', 'description': 'a description'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name unexpected key(s): bogus')]
    self.assertEqual(expect, issues)

  def test_name_empty_str(self):
    stac_data = {'summaries': {'eo:bands': [{
        'name': '', 'description': 'a description'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Bad name: "". Must be 1-80 letters, numbers, and underscores')]
    self.assertEqual(expect, issues)

  def test_name_too_long(self):
    name = 'a' * 81
    stac_data = {'summaries': {'eo:bands': [{
        'name': name, 'description': 'a description'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, f'Bad name: "{name}". '
        'Must be 1-80 letters, numbers, and underscores')]
    self.assertEqual(expect, issues)

  def test_description_not_str(self):
    stac_data = {'summaries': {'eo:bands': [{
        'description': 998877, 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name description must be a str')]
    self.assertEqual(expect, issues)

  def test_description_too_short(self):
    stac_data = {'summaries': {'eo:bands': [{
        'description': 'ab', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name description too short: 2')]
    self.assertEqual(expect, issues)

  def test_description_too_long(self):
    size = 1601
    stac_data = {'summaries': {'eo:bands': [{
        'description': 'a' * size, 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, f'a_name description too long: {size}')]
    self.assertEqual(expect, issues)

  def test_center_wavelength_not_number(self):
    stac_data = {'summaries': {'eo:bands': [{
        'center_wavelength': 'not a number',
        'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'a_name center_wavelength must be a number')]
    self.assertEqual(expect, issues)

  def test_center_wavelength_too_small(self):
    stac_data = {'summaries': {'eo:bands': [{
        'center_wavelength': -0.01,
        'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'a_name center_wavelength must in (0, 15) μm')]
    self.assertEqual(expect, issues)

  def test_center_wavelength_too_large(self):
    stac_data = {'summaries': {'eo:bands': [{
        'center_wavelength': 15.02,
        'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'a_name center_wavelength must in (0, 15) μm')]
    self.assertEqual(expect, issues)

  def test_full_width_half_max_not_number(self):
    stac_data = {'summaries': {'eo:bands': [{
        'full_width_half_max': 'not a number',
        'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'a_name full_width_half_max must be a number')]
    self.assertEqual(expect, issues)

  def test_full_width_half_max_too_small(self):
    stac_data = {'summaries': {'eo:bands': [{
        'full_width_half_max': -0.01,
        'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'a_name full_width_half_max must in (0, 0.15) μm')]
    self.assertEqual(expect, issues)

  def test_full_width_half_max_too_large(self):
    stac_data = {'summaries': {'eo:bands': [{
        'full_width_half_max': 0.152,
        'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'a_name full_width_half_max must in (0, 0.15) μm')]
    self.assertEqual(expect, issues)

  def test_offset_not_number(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gee:offset': 'not a number',
        'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name gee:offset must be a number')]
    self.assertEqual(expect, issues)

  def test_offset_too_negative(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gee:offset': -10001,
        'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'a_name gee:offset large negative offset: -10001')]
    self.assertEqual(expect, issues)

  def test_offset_too_large(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gee:offset': 10001.1, 'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name gee:offset large offset: 10001.1')]
    self.assertEqual(expect, issues)

  def test_offset_zero(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gee:offset': 0, 'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name zero gee:offset is redundant')]
    self.assertEqual(expect, issues)

  def test_polarization_not_str(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gee:polarization': 987, 'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name gee:polarization must be a str')]
    self.assertEqual(expect, issues)

  def test_polarization_invalid(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gee:polarization': 'bogus', 'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'a_name gee:polarization must be one of HH, HV, VH, VV')]
    self.assertEqual(expect, issues)

  def test_scale_not_number(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gee:scale': 'not a number', 'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name gee:scale must be a number')]
    self.assertEqual(expect, issues)

  def test_scale_too_small(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gee:scale': 1e-7, 'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name gee:scale too small: 1e-07')]
    self.assertEqual(expect, issues)

  def test_scale_too_large(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gee:scale': 2e5, 'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'a_name unreasonably large gee:scale: 200000.0')]
    self.assertEqual(expect, issues)

  def test_scale_one(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gee:scale': 1, 'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name gee:scale of one is redundant')]
    self.assertEqual(expect, issues)

  def test_units_not_str(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gee:units': 603, 'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name gee:units must be a str')]
    self.assertEqual(expect, issues)

  def test_gee_wavelength_not_str(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gee:wavelength': 415, 'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name gee:wavelength must be a str')]
    self.assertEqual(expect, issues)

  def test_gsd_not_number(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gsd': 'not a number', 'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name gsd must be a number')]
    self.assertEqual(expect, issues)

  def test_gsd_too_small(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gsd': 0, 'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name gsd too small: 0 m')]
    self.assertEqual(expect, issues)

  def test_gsd_too_large(self):
    stac_data = {'summaries': {'eo:bands': [{
        'gsd': 1.1e5, 'description': 'abc', 'name': 'a_name'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'a_name unreasonably large gsd: 110000.0 m')]
    self.assertEqual(expect, issues)

if __name__ == '__main__':
  unittest.main()

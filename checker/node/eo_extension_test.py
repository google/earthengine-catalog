"""Tests for eo_extension."""

from checker import stac
from checker import test_utils
from checker.node import eo_extension
from absl.testing import absltest

TABLE = stac.GeeType.TABLE
TABLE_COLLECTION = stac.GeeType.TABLE_COLLECTION

EO_URL = 'https://stac-extensions.github.io/eo/v1.0.0/schema.json'

MINIMUM_BANDS_NO_GSD = [{'description': 'Burn Area Index', 'name': 'BAI'}]
MINIMUM_BANDS = [MINIMUM_BANDS_NO_GSD[0] | {'gsd': 3.1415}]


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

  def test_minimum_image_summaries_gsd(self):
    self.assert_collection({
        'stac_extensions': [EO_URL], 'summaries': {
            'gsd': [1.2], 'eo:bands': MINIMUM_BANDS_NO_GSD}})

  def test_minimum_image_summaries_gsd_2(self):
    self.assert_collection({
        'stac_extensions': [EO_URL], 'summaries': {
            'gsd': [3, 4], 'eo:bands': MINIMUM_BANDS_NO_GSD}})

  def test_minimal_image(self):
    self.assert_collection({
        'stac_extensions': [EO_URL], 'summaries': {'eo:bands': MINIMUM_BANDS}})

  def test_image_without_bands_exceptions(self):
    self.assert_collection(
        {'stac_extensions': [EO_URL], 'summaries': {}},
        dataset_id='MODIS/MCD43A1')

  def test_range_object(self):
    self.assert_collection({
        'stac_extensions': [EO_URL], 'summaries': {
            'BAI': {'minimum': -1, 'maximum': 2, 'gee:estimated_range': False},
            'eo:bands': MINIMUM_BANDS}})

  def test_range_object_estimated(self):
    self.assert_collection({
        'stac_extensions': [EO_URL], 'summaries': {
            'BAI': {'minimum': 3, 'maximum': 3, 'gee:estimated_range': True},
            'eo:bands': MINIMUM_BANDS}})


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

  def test_band_not_dict(self):
    self.assert_collection(
        {'summaries': {'eo:bands': ['not a dict']}}, 'band must be a dict')

  def test_bands_not_dict_and_duplicate(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [None, None]}},
        ['band must be a dict', 'band must be a dict'])

  def test_bands_empty(self):
    self.assert_collection(
        {'summaries': {'eo:bands': []}}, 'eo:bands must have at least one band')

  def test_band_too_many(self):
    num_bands = 2001
    bands = [
        {'name': 'ab%d' % x, 'description': 'descr', 'gsd': x + 1}
        for x in range(num_bands)]
    self.assert_collection(
        {'summaries': {'eo:bands': bands}},
        f'eo:bands has more than {eo_extension.MAX_BANDS} bands')

  def test_missing_name(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{'description': 'a description'}]}},
        'band "unknown" missing required key(s): name')

  def test_duplicate_name(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [
            {'name': 'duplicate2', 'description': 'a description', 'gsd': 1},
            {'name': 'duplicate2', 'description': 'a description', 'gsd': 2},
            {'name': 'duplicate1', 'description': 'a description', 'gsd': 3},
            {'name': 'duplicate1', 'description': 'a description', 'gsd': 4}]}},
        'Multiple bands with the same name(s): duplicate1, duplicate2')

  def test_name_not_str(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': 4321, 'description': 'a description', 'gsd': 24}]}},
        'name must be a str')

  def test_disallowed_field(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'bogus': 'junk', 'name': 'a_name', 'description': 'a descr',
            'gsd': 23}]}},
        'a_name unexpected key(s): bogus')

  def test_name_empty_str(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': '', 'description': 'a description', 'gsd': 22}]}},
        'Bad name: "". Must be 1-80 letters, numbers, and underscores')

  def test_name_too_long(self):
    name = 'a' * 81
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'name': name, 'description': 'a description', 'gsd': 25}]}},
        f'Bad name: "{name}". Must be 1-80 letters, numbers, and underscores')

  def test_description_not_str(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'description': 99887, 'name': 'a_name', 'gsd': 8}]}},
        'a_name description must be a str')

  def test_description_too_short(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'description': 'ab', 'name': 'a_name', 'gsd': 9}]}},
        'a_name description too short: 2')

  def test_description_too_long(self):
    size = 1601
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'description': 'a' * size, 'name': 'a_name', 'gsd': 9.1}]}},
        f'a_name description too long: {size}')

  def test_center_wavelength_not_number(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'center_wavelength': 'not a number',
            'description': 'abc', 'name': 'a_name', 'gsd': 4}]}},
        'a_name center_wavelength must be a number')

  def test_center_wavelength_too_small(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'center_wavelength': -0.01,
            'description': 'abc', 'name': 'a_name', 'gsd': 5}]}},
        'a_name center_wavelength must in (0, 15) μm')

  def test_center_wavelength_too_large(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'center_wavelength': 15.02,
            'description': 'abc', 'name': 'a_name', 'gsd': 6}]}},
        'a_name center_wavelength must in (0, 15) μm')

  def test_full_width_half_max_not_number(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'full_width_half_max': 'not a number',
            'description': 'abc', 'name': 'a_name', 'gsd': 7}]}},
        'a_name full_width_half_max must be a number')

  def test_full_width_half_max_too_small(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'full_width_half_max': -0.01,
            'description': 'abc', 'name': 'a_name', 'gsd': 19}]}},
        'a_name full_width_half_max must in (0, 0.15) μm')

  def test_full_width_half_max_too_large(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'full_width_half_max': 0.152,
            'description': 'abc', 'name': 'a_name', 'gsd': 20}]}},
        'a_name full_width_half_max must in (0, 0.15) μm')

  def test_bitmask_and_classes_not_in_same_band(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:bitmask': 'does not matter',
            'gee:classes': 'does not matter',
            'description': 'abc', 'name': 'a_name', 'gsd': 3}]}},
        'a_name cannot have both gee:bitmask and gee:classes')

  def test_offset_not_number(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:offset': 'not a number',
            'description': 'abc', 'name': 'a_name', 'gsd': 26}]}},
        'a_name gee:offset must be a number')

  def test_offset_too_negative(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:offset': -10001,
            'description': 'abc', 'name': 'a_name', 'gsd': 27}]}},
        'a_name gee:offset large negative offset: -10001')

  def test_offset_too_large(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:offset': 10001.1, 'description': 'abc', 'name': 'a_name',
            'gsd': 28}]}},
        'a_name gee:offset large offset: 10001.1')

  def test_offset_zero(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:offset': 0, 'description': 'abc', 'name': 'a_name',
            'gsd': 30}]}},
        'a_name zero gee:offset is redundant')

  def test_polarization_not_str(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:polarization': 987, 'description': 'abc', 'name': 'a_name',
            'gsd': 31}]}},
        'a_name gee:polarization must be a str')

  def test_polarization_invalid(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:polarization': 'bogus',
            'description': 'abc', 'name': 'a_name', 'gsd': 32}]}},
        'a_name gee:polarization must be one of HH, HV, VH, VV')

  def test_scale_not_number(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:scale': 'not a number',
            'description': 'abc', 'name': 'a_name', 'gsd': 33}]}},
        'a_name gee:scale must be a number')

  def test_scale_too_small(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:scale': 1e-7, 'description': 'abc', 'name': 'a_name',
            'gsd': 34}]}},
        'a_name gee:scale too small: 1e-07')

  def test_scale_too_large(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:scale': 2e5, 'description': 'abc', 'name': 'a_name',
            'gsd': 35}]}},
        'a_name unreasonably large gee:scale: 200000.0')

  def test_scale_one(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:scale': 1, 'description': 'abc', 'name': 'a_name',
            'gsd': 36}]}},
        'a_name gee:scale of one is redundant')

  def test_units_not_str(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:units': 603, 'description': 'abc', 'name': 'a_name',
            'gsd': 37}]}},
        'a_name gee:units must be a str')

  def test_units_unknown(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:units': 'bogus', 'description': 'abc', 'name': 'a_name',
            'gsd': 37}]}},
        'a_name gee:units not known: bogus')

  def test_gee_wavelength_not_str(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{
            'gee:wavelength': 415, 'description': 'abc', 'name': 'a_name',
            'gsd': 21}]}},
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
            'gsd': 3.1e5, 'description': 'abc', 'name': 'a_name'}]}},
        'a_name unreasonably large gsd: 310000.0 m')

  def test_gsd_missing(self):
    self.assert_collection(
        {'summaries': {'eo:bands': [{'description': 'abc', 'name': 'a_name'}]}},
        'Must set either summaries or eo:bands a_name gsd')

  def test_summaries_gsd_not_list(self):
    self.assert_collection(
        {'summaries': {
            'gsd': 'not a list',
            'eo:bands': [{'description': 'abc', 'name': 'a_name'}]}},
        'summaries gsd must be a list')

  def test_summaries_gsd_empty_list(self):
    self.assert_collection(
        {'summaries': {
            'gsd': [],
            'eo:bands': [{'description': 'abc', 'name': 'a_name'}]}},
        'summaries gsd length not 1 or 2: 0')

  def test_summaries_gsd_not_number(self):
    self.assert_collection(
        {'summaries': {
            'gsd': ['not a number'],
            'eo:bands': [{'description': 'abc', 'name': 'a_name'}]}},
        'summaries gsd must be a number')

  def test_summaries_gsd_too_small(self):
    self.assert_collection(
        {'summaries': {
            'gsd': [0],
            'eo:bands': [{'description': 'abc', 'name': 'a_name'}]}},
        'summaries gsd too small: 0 m')

  def test_summaries_gsd_too_large(self):
    self.assert_collection(
        {'summaries': {
            'gsd': [3.1e5],
            'eo:bands': [{'description': 'abc', 'name': 'a_name'}]}},
        'unreasonably large summaries gsd: 310000.0 m')

  def test_summaries_gsd_too_many(self):
    self.assert_collection(
        {'summaries': {
            'gsd': [90, 91, 92],
            'eo:bands': [{'description': 'abc', 'name': 'a_name'}]}},
        'summaries gsd length not 1 or 2: 3')

  def test_summaries_gsd_and_band_gsd(self):
    self.assert_collection(
        {'summaries': {
            'gsd': [93],
            'eo:bands': [{'description': 'abc', 'name': 'a_name', 'gsd': 94}]}},
        'summaries and a_name gsd both set')

  def test_bands_with_some_having_gsd(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [
                {'description': 'abc', 'name': 'a_name'},
                {'description': 'xyz', 'name': 'b_name', 'gsd': 94}]}},
        'Must set either summaries or eo:bands a_name gsd')

  def test_bands_with_the_same_gsd(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [
                {'description': 'abc', 'name': 'a_name', 'gsd': 95},
                {'description': 'xyz', 'name': 'b_name', 'gsd': 95}]}},
        'Must use the summaries gsd field: gsd values are the same')

  def test_range_object_minimum_missing(self):
    self.assert_collection(
        {'summaries': {
            'a_name': {'maximum': 4, 'gee:estimated_range': False},
            'eo:bands': [
                {'name': 'a_name', 'description': 'abc', 'gsd': 1}]}},
        'a_name range object must have minimum')

  def test_range_object_minimum_not_a_number(self):
    self.assert_collection(
        {'summaries': {
            'a_name': {
                'minimum': 'not a number',
                'maximum': 4, 'gee:estimated_range': False},
            'eo:bands': [
                {'name': 'a_name', 'description': 'abc', 'gsd': 1}]}},
        'a_name range object minimum must be a number')

  def test_range_object_maximum_missing(self):
    self.assert_collection(
        {'summaries': {
            'a_name': {'minimum': 5, 'gee:estimated_range': False},
            'eo:bands': [
                {'name': 'a_name', 'description': 'abc', 'gsd': 1}]}},
        'a_name range object must have maximum')

  def test_range_object_maximum_not_a_number(self):
    self.assert_collection(
        {'summaries': {
            'a_name': {
                'minimum': 6,
                'maximum': 'not a number', 'gee:estimated_range': False},
            'eo:bands': [
                {'name': 'a_name', 'description': 'abc', 'gsd': 1}]}},
        'a_name range object maximum must be a number')

  def test_range_object_maximum_less_than_minimum(self):
    self.assert_collection(
        {'summaries': {
            'a_name': {
                'minimum': 8, 'maximum': 7, 'gee:estimated_range': False},
            'eo:bands': [
                {'name': 'a_name', 'description': 'abc', 'gsd': 1}]}},
        'a_name range object minimum > maximum: 8 > 7')

  def test_range_object_estimated_missing(self):
    self.assert_collection(
        {'summaries': {
            'a_name': {'minimum': 9, 'maximum': 10},
            'eo:bands': [
                {'name': 'a_name', 'description': 'abc', 'gsd': 1}]}},
        'a_name range object must have gee:estimated_range')

  def test_range_object_estimated_not_bool(self):
    self.assert_collection(
        {'summaries': {
            'a_name': {
                'minimum': 11, 'maximum': 12,
                'gee:estimated_range': 'not a bool'},
            'eo:bands': [
                {'name': 'a_name', 'description': 'abc', 'gsd': 1}]}},
        'a_name range object gee:estimated_range must be a bool')


if __name__ == '__main__':
  absltest.main()

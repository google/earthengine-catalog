"""Tests for interval."""

from checker import test_utils
from checker.node import interval
from absl.testing import absltest


class IntervalTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = interval.Check

  def test_no_interval(self):
    self.assert_collection({})

  def test_no_interval_for_image_table(self):
    self.assert_collection(
        {
            'gee:type': 'image',
            'gee:interval': {
                'type': 'revisit_interval',
                'unit': 'day',
                'interval': 16,
            },
        },
        'Image/Table datasets cannot have "gee:interval"',
    )

  def test_valid_cadence(self):
    self.assert_collection(
        {'gee:interval': {'type': 'cadence', 'unit': 'year', 'interval': 1}})

  def test_valid_revisit_interval(self):
    self.assert_collection(
        {'gee:interval': {
            'type': 'revisit_interval', 'unit': 'day', 'interval': 16}})

  def test_valid_climatological_interval(self):
    self.assert_collection(
        {'gee:interval': {
            'type': 'climatological_interval',
            'unit': 'month', 'interval': 32}})

  # See: UCSB-CHG/UCSB-CHG_CHIRPS_PENTAD.jsonnet
  def test_valid_custom_time_unit(self):
    self.assert_collection(
        {'gee:interval': {
            'type': 'cadence', 'unit': 'custom_time_unit', 'interval': 2,
            'name': 'A thing', 'description': 'A description'}})

  def test_bad_catalog(self):
    self.assert_catalog(
        {'gee:interval': {}}, 'Catalogs cannot have "gee:interval"')

  def test_bad_not_a_dict(self):
    self.assert_collection(
        {'gee:interval': 'not a dict'}, 'gee:interval must be a dict')

  def test_bad_extra_field(self):
    self.assert_collection(
        {'gee:interval': {
            'extra': 'field', 'type': 'cadence',
            'unit': 'hour', 'interval': 2}},
        'Unexpected key: "extra"')

  def test_bad_extra_fields(self):
    self.assert_collection(
        {'gee:interval': {
            'extra1': 'a', 'extra2': 'b',
            'type': 'cadence', 'unit': 'hour', 'interval': 2}},
        'Unexpected keys: [\'extra1\', \'extra2\']')

  def test_bad_missing_type(self):
    self.assert_collection(
        {'gee:interval': {'unit': 'hour', 'interval': 2}}, 'Missing type')

  def test_bad_type(self):
    self.assert_collection(
        {'gee:interval': {'type': 'bad', 'unit': 'hour', 'interval': 3}},
        'Unknown type: bad')

  def test_bad_missing_unit(self):
    self.assert_collection(
        {'gee:interval': {'type': 'cadence', 'interval': 4}}, 'Missing unit')

  def test_bad_unit(self):
    self.assert_collection(
        {'gee:interval': {'type': 'cadence', 'unit': 'second', 'interval': 5}},
        'Unknown unit: second')

  def test_bad_custom_time_unit_missing_name_and_description(self):
    self.assert_collection(
        {'gee:interval': {
            'type': 'cadence', 'unit': 'custom_time_unit', 'interval': 2}},
        ['Having unit of custom_time_unit must have a description',
         'Having unit of custom_time_unit must have a name'])

  def test_bad_name_not_str(self):
    self.assert_collection(
        {'gee:interval': {
            'name': 5, 'type': 'cadence', 'unit': 'hour', 'interval': 5}},
        'name must be a str')

  def test_bad_name_to_short(self):
    self.assert_collection(
        {'gee:interval': {
            'name': 'a', 'type': 'cadence', 'unit': 'hour', 'interval': 5}},
        'name too short')

  def test_bad_name_to_long(self):
    self.assert_collection(
        {'gee:interval': {
            'name': 'b' * 201, 'type': 'cadence',
            'unit': 'hour', 'interval': 5}},
        'name too long: 201')

  def test_bad_missing_interval(self):
    self.assert_collection(
        {'gee:interval': {'type': 'cadence', 'unit': 'year'}},
        'Missing interval')

  def test_bad_interval_is_str(self):
    self.assert_collection(
        {'gee:interval': {'type': 'cadence', 'unit': 'year', 'interval': 'a'}},
        'interval must be an integer')

  def test_bad_interval_is_float(self):
    self.assert_collection(
        {'gee:interval': {'type': 'cadence', 'unit': 'year', 'interval': 1.2}},
        'interval must be an integer')

  def test_bad_interval_too_small(self):
    self.assert_collection(
        {'gee:interval': {'type': 'cadence', 'unit': 'year', 'interval': 0}},
        'interval must be a positive integer')

  def test_bad_interval_too_big(self):
    self.assert_collection(
        {'gee:interval': {'type': 'cadence', 'unit': 'year', 'interval': 33}},
        'interval too large: 33')

  def test_bad_description_not_str(self):
    self.assert_collection(
        {'gee:interval': {
            'description': 1, 'type': 'cadence',
            'unit': 'year', 'interval': 9}},
        'description must be a str')

  def test_bad_description_too_short(self):
    self.assert_collection(
        {'gee:interval': {
            'description': 'a', 'type': 'cadence',
            'unit': 'year', 'interval': 9}},
        'description too short')

  def test_bad_description_too_long(self):
    self.assert_collection(
        {'gee:interval': {
            'description': 'b' * 201,
            'type': 'cadence', 'unit': 'year', 'interval': 9}},
        'description too long: 201')


if __name__ == '__main__':
  absltest.main()

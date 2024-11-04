"""Tests for extent."""

import pathlib

from checker import stac
from checker import test_utils
from checker.node import extent
from absl.testing import absltest

Check = extent.Check
check_spatial = Check.check_spatial
check_temporal = Check.check_temporal

BBOX = extent.BBOX
CHECK_NAME = 'https://github.com/google/earthengine-catalog/blob/main/checker/node/extent.py'
COLLECTION = stac.StacType.COLLECTION
EXTENT = extent.EXTENT
IMAGE = stac.GeeType.IMAGE
INTERVAL = extent.INTERVAL
NONE = stac.GeeType.NONE
SPATIAL = extent.SPATIAL
TEMPORAL = extent.TEMPORAL

FILE_PATH = pathlib.Path('test/path/should/be/ignored.json')
FILE_PATH_OUT = pathlib.Path('test/path/should/be/ignored.jsonnet')
ID = 'a/collection'
NOT_A_DATE = 'not a date'
NOT_A_DICT = 'not a dict'
NOT_A_LIST = 'not a list'


def make_node(collection_stac) -> stac.Node:
  return stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, collection_stac)


class SpatialTest(absltest.TestCase):

  def setUp(self):
    super().setUp()
    # Components used to build up inputs.
    self.coord = [-1.2, 7.8, 2.3, 8.9]
    self.spatial = {'bbox': [self.coord]}
    self.extent = {SPATIAL: self.spatial}

    self.node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, {})

  def test_valid(self):
    issues = list(check_spatial(self.node, self.extent))
    self.assertEqual(0, len(issues))

  def test_extent_must_have_spatial(self):
    an_extent = {}
    issues = list(check_spatial(self.node, an_extent))
    message = 'Extent must have "spatial"'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_spatial_must_be_dict(self):
    an_extent = {SPATIAL: NOT_A_DICT}
    issues = list(check_spatial(self.node, an_extent))
    message = '"spatial" must be a dict'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_spatial_has_bbox(self):
    an_extent = {SPATIAL: {}}
    issues = list(check_spatial(self.node, an_extent))
    message = '"spatial" must have: "bbox"'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_spatial_only_has_bbox(self):
    self.spatial['not a bbox'] = 'junk'
    issues = list(check_spatial(self.node, self.extent))
    message = '"spatial" must only have one key: "bbox"'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_bbox_is_a_list(self):
    self.spatial[BBOX] = NOT_A_LIST  # pytype: disable=container-type-mismatch
    issues = list(check_spatial(self.node, self.extent))
    message = '"bbox" must be a list'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_bbox_is_len1(self):
    self.spatial[BBOX].append([1, 2, 3])  # pytype: disable=attribute-error
    issues = list(check_spatial(self.node, self.extent))
    message = '"bbox" must be a list of length 1'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_coord_is_list(self):
    self.spatial[BBOX] = [NOT_A_LIST]
    issues = list(check_spatial(self.node, self.extent))
    message = 'coord must be a list'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_coord_length(self):
    self.coord.append(999)
    issues = list(check_spatial(self.node, self.extent))
    message = 'coord length must be 4.  Found 5'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_coord_vals_are_number(self):
    self.coord[2] = 'A'
    issues = list(check_spatial(self.node, self.extent))
    message = 'coord must be a number.  Found <class \'str\'>'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_coord_in_range(self):
    over = [-1000, -2000, 3000, 4000]
    self.spatial[BBOX][0] = over  # pytype: disable=unsupported-operands
    issues = list(check_spatial(self.node, self.extent))
    expect = [
        stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, 'x1: -1000 < -180'),
        stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, 'x2: 3000 > 180'),
        stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, 'y1: -2000 < -90'),
        stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, 'y2: 4000 > 90'),
    ]
    self.assertEqual(expect, issues)

  def test_coord_order(self):
    order = [1000, 2000, -3000, -4000]
    self.spatial[BBOX][0] = order  # pytype: disable=unsupported-operands
    issues = list(check_spatial(self.node, self.extent))
    expect = [
        stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, 'x1 >= x2: 1000 >= -3000'),
        stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, 'y1 >= y2: 2000 >= -4000'),
    ]
    self.assertEqual(expect, issues)


class TemporalTest(absltest.TestCase):

  def setUp(self):
    super().setUp()
    # Components used to build up inputs.
    self.start = '2009-01-01T00:00:00Z'
    self.end = '2055-01-01T00:00:00Z'
    self.first_interval = [self.start, self.end]
    self.temporal = {INTERVAL: [self.first_interval]}
    self.extent = {TEMPORAL: self.temporal}

    self.node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, {})

  def test_valid(self):
    issues = list(check_temporal(self.node, self.extent))
    self.assertEqual(0, len(issues))

  def test_extent_must_have_temporal(self):
    an_extent = {}
    issues = list(check_temporal(self.node, an_extent))
    message = 'Extent must have "temporal"'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_temporal_must_be_dict(self):
    an_extent = {TEMPORAL: NOT_A_DICT}
    issues = list(check_temporal(self.node, an_extent))
    message = '"temporal" must be a dict'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_temporal_missing_interval(self):
    collection_extent = {TEMPORAL: {}}
    issues = list(
        check_temporal(make_node(collection_extent), collection_extent))
    message = '"temporal" have an "interval"'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_temporal_only_has_interval(self):
    self.temporal['not temporal'] = 'junk'
    issues = list(check_temporal(self.node, self.extent))
    message = '"temporal" must only have one key: "interval"'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_interval_is_list(self):
    self.temporal[INTERVAL] = NOT_A_LIST
    issues = list(check_temporal(self.node, self.extent))
    message = '"interval" must be a list'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_interval_is_len1(self):
    self.temporal[INTERVAL].append([self.start, self.end])
    issues = list(check_temporal(self.node, self.extent))
    message = '"interval" must be a list of len 1'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_interval_is_list_of_list(self):
    # pytype: disable=unsupported-operands
    self.temporal[INTERVAL][0] = NOT_A_LIST
    # pytype: enable=unsupported-operands
    issues = list(check_temporal(self.node, self.extent))
    message = 'First interval must be a list of list'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_first_interval_is_len2(self):
    # pytype: disable=unsupported-operands
    self.temporal[INTERVAL][0].append('junk')
    # pytype: enable=unsupported-operands
    issues = list(check_temporal(self.node, self.extent))
    message = 'First interval must have 2 elements: start and end'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_start_not_str(self):
    self.first_interval[0] = 222
    issues = list(check_temporal(self.node, self.extent))
    message = 'start must be a string'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_bad_start(self):
    self.first_interval[0] = NOT_A_DATE
    issues = list(check_temporal(self.node, self.extent))
    message = f'Unable to parse start date "{NOT_A_DATE}"'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_start_too_old(self):
    self.first_interval[0] = '1599-01-01T00:00:00Z'
    issues = list(check_temporal(self.node, self.extent))
    message = '1599-01-01 00:00:00+00:00 is before 1600-01-01 00:00:00+00:00'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_end_not_str(self):
    self.first_interval[1] = 333
    issues = list(check_temporal(self.node, self.extent))
    message = 'end must be a string'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_end_does_not_parse(self):
    self.first_interval[1] = '2600-01-01T00:00:00'  # Missing Z at the end.
    issues = list(check_temporal(self.node, self.extent))
    message = 'Unable to parse end date "2600-01-01T00:00:00"'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_end_too_far_in_future(self):
    self.first_interval[1] = '2600-01-01T00:00:00Z'
    issues = list(check_temporal(self.node, self.extent))
    message = '2600-01-01 00:00:00+00:00 is after 2500-01-01 00:00:00+00:00'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_start_end_swapped(self):
    a, b = self.first_interval
    self.first_interval[1] = a
    self.first_interval[0] = b
    issues = list(check_temporal(self.node, self.extent))
    message = (
        'start is after end: '
        '2055-01-01 00:00:00+00:00 > 2009-01-01 00:00:00+00:00')
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_table_must_have_end_date(self):
    self.first_interval[1] = None
    self.node.gee_type = stac.GeeType.TABLE
    issues = list(check_temporal(self.node, self.extent))
    message = 'table must have an end date'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)

  def test_table_collection_must_have_end_date(self):
    self.first_interval[1] = None
    self.node.gee_type = stac.GeeType.TABLE_COLLECTION
    issues = list(check_temporal(self.node, self.extent))
    message = 'table_collection must have an end date'
    expect = [stac.Issue(ID, FILE_PATH_OUT, CHECK_NAME, message)]
    self.assertEqual(expect, issues)


class ExtentTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = extent.Check

    # Components used to build up inputs.
    spatial = {'bbox': [[-1.2, 7.8, 2.3, 8.9]]}
    start = '2009-01-01T00:00:00Z'
    end = '2055-01-01T00:00:00Z'
    temporal = {INTERVAL: [[start, end]]}
    self.stac_json = {
        EXTENT: {
            SPATIAL: spatial,
            TEMPORAL: temporal}}

  def test_valid(self):
    self.assert_collection(self.stac_json)

  def test_valid_without_end_date(self):
    self.stac_json[EXTENT][TEMPORAL][INTERVAL][0][1] = None
    self.assert_collection(self.stac_json)

  def test_catalog_cannot_have_extent(self):
    self.assert_catalog({EXTENT: {}}, 'Catalogs cannot have extent')

  def test_collection_must_have_extent(self):
    self.assert_collection({}, 'Collections must have extent')

  def test_extent_is_dict(self):
    self.assert_collection({EXTENT: 'not a dict'}, '"extent" must be a dict')

if __name__ == '__main__':
  absltest.main()

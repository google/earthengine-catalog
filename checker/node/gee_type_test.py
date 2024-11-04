"""Tests for gee_type."""

from checker import stac
from checker import test_utils
from checker.node import gee_type
from absl.testing import absltest

IMAGE_COLLECTION = stac.GeeType.IMAGE_COLLECTION
TABLE = stac.GeeType.TABLE
TABLE_COLLECTION = stac.GeeType.TABLE_COLLECTION


class GeeTypeTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_type.Check

  def test_catalog(self):
    self.assert_catalog({})

  def test_image(self):
    self.assert_collection({'gee:type': 'image'})

  def test_image_collection(self):
    self.assert_collection(
        {'gee:type': 'image_collection'}, gee_type=IMAGE_COLLECTION)

  def test_table(self):
    self.assert_collection({'gee:type': 'table'}, gee_type=TABLE)

  def test_table_collection(self):
    self.assert_collection(
        {'gee:type': 'table_collection'}, gee_type=TABLE_COLLECTION)

  def test_not_a_str(self):
    self.assert_collection({'gee:type': 77}, 'gee:type must be a str')

  def test_bogus(self):
    self.assert_collection(
        {'gee:type': 'bogus'},
         'gee:type must be one of '
        '[\'image\', \'image_collection\', \'table\', \'table_collection\']')


if __name__ == '__main__':
  absltest.main()

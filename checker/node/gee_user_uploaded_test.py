"""Tests for gee_user_owned."""

from checker import test_utils
from checker.node import gee_user_uploaded
from absl.testing import absltest


class GeeUserUploadedTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_user_uploaded.Check

  def test_valid_catalog(self):
    self.assert_catalog({})

  def test_valid_collection(self):
    self.assert_collection({'gee:user_uploaded': True})

  def test_catalog(self):
    self.assert_catalog(
        {'gee:user_uploaded': True}, 'Catalog cannot have gee:user_uploaded')

  def test_not_bool(self):
    self.assert_collection(
        {'gee:user_uploaded': 'not a bool'}, 'gee:user_uploaded must be a bool')

  def test_false(self):
    self.assert_collection(
        {'gee:user_uploaded': False},
        'gee:user_uploaded can only be present as true')


if __name__ == '__main__':
  absltest.main()

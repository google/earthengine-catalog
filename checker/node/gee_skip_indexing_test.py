"""Tests for gee_skip_indexing."""

from checker import test_utils
from checker.node import gee_skip_indexing
from absl.testing import absltest


class GeeSkipIndexingTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_skip_indexing.Check

  def test_gee_skip_indexing_not_bool(self):
    bad_val = 603
    self.assert_collection(
        {'gee:skip_indexing': bad_val}, 'gee:skip_indexing must be a bool')

  def test_gee_skip_indexing_true_on_catalog(self):
    self.assert_catalog(
        {'gee:skip_indexing': True},
        'Catalogs may not have a gee:skip_indexing field')

  def test_gee_skip_indexing_false_on_catalog(self):
    self.assert_catalog(
        {'gee:skip_indexing': False},
        'Catalogs may not have a gee:skip_indexing field')

  def test_gee_skip_indexing_happy(self):
    self.assert_collection(
        {'gee:skip_indexing': True})


if __name__ == '__main__':
  absltest.main()

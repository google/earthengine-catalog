"""Tests for gee:incomplete_entry."""

from absl.testing import absltest
from checker import test_utils
from checker.node import gee_incomplete_entry


class GeeIncompleteEntryTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_incomplete_entry.Check

  def test_gee_incomplete_entry_not_bool(self):
    bad_val = 603
    self.assert_collection(
        {'gee:incomplete_entry': bad_val},
        'gee:incomplete_entry must be a boolean',
    )

  def test_gee_incomplete_entry_true_on_catalog(self):
    self.assert_catalog(
        {'gee:incomplete_entry': True},
        'Catalogs may not have a gee:incomplete_entry field',
    )

  def test_gee_incomplete_entry_false_on_catalog(self):
    self.assert_catalog(
        {'gee:incomplete_entry': False},
        'Catalogs may not have a gee:incomplete_entry field',
    )

  def test_gee_incomplete_entry_happy(self):
    self.assert_collection({'gee:incomplete_entry': True})


if __name__ == '__main__':
  absltest.main()

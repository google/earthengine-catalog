"""Tests for gee:status."""

from absl.testing import absltest
from checker import test_utils
from checker.node import gee_status


class GeeIncompleteEntryTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_status.Check

  def test_gee_status_bad_values(self):
    bad_val = 603
    self.assert_collection(
        {'gee:status': bad_val},
        "gee:status, if set, must be one of ['beta', 'deprecated',"
        " 'incomplete']",
    )

  def test_gee_status_on_catalog(self):
    self.assert_catalog(
        {'gee:status': 'incomplete'},
        'Catalogs may not have a gee:status field',
    )

  def test_gee_status_valid(self):
    # TODO(simonf): add other valid statuses
    self.assert_collection({'gee:status': 'incomplete'})


if __name__ == '__main__':
  absltest.main()

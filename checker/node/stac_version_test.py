"""Tests for stac_version."""

from checker import test_utils
from checker.node import stac_version
from absl.testing import absltest

CURRENT_STAC_VERSION = '1.0.0'
STAC_VERSION = 'stac_version'


class StacVersionTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = stac_version.Check

  def test_version(self):
    self.assert_collection({STAC_VERSION: CURRENT_STAC_VERSION})

  def test_missing_version(self):
    self.assert_collection({}, 'Missing: stac_version')

  def test_wrong_version(self):
    self.assert_collection(
        {STAC_VERSION: CURRENT_STAC_VERSION + '-bad'},
        'Unexpected stac_version: 1.0.0-bad != 1.0.0')

  def test_catalog_missing_version(self):
    self.assert_catalog({}, 'Missing: stac_version')

  def test_catalog_wrong_version(self):
    self.assert_catalog(
        {STAC_VERSION: CURRENT_STAC_VERSION + '-bad'},
        'Unexpected stac_version: 1.0.0-bad != 1.0.0')

if __name__ == '__main__':
  absltest.main()

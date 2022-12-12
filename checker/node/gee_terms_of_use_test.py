"""Tests for gee_terms_of_use."""

from checker import test_utils
from checker.node import gee_terms_of_use
from absl.testing import absltest


class GeeTermsOfUseTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_terms_of_use.Check

  def test_valid(self):
    self.assert_collection({'gee:terms_of_use': 'Yada yada yada'})

  def test_catalog(self):
    self.assert_catalog(
        {'gee:terms_of_use': 'Yada'}, 'Catalog cannot have gee:terms_of_use')

  def test_missing(self):
    self.assert_collection({}, 'Collection must have gee:terms_of_use')

  def test_not_str(self):
    self.assert_collection(
        {'gee:terms_of_use': True}, 'gee:terms_of_use must be a str')

  def test_too_short(self):
    self.assert_collection(
        {'gee:terms_of_use': 'a'}, 'gee:terms_of_use is too short: 1')

  def test_too_long(self):
    self.assert_collection(
        {'gee:terms_of_use': 'a' * 2401}, 'gee:terms_of_use is too long: 2401')


if __name__ == '__main__':
  absltest.main()

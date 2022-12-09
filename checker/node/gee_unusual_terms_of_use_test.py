"""Tests for gee_unusual_terms_of_use."""

from checker import test_utils
from checker.node import gee_unusual_terms_of_use
from absl.testing import absltest


class GeeTypeTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_unusual_terms_of_use.Check

  def test_catalog(self):
    self.assert_catalog({})

  def test_valid_cc_nc(self):
    self.assert_collection(
        {'license': 'CC-BY-NC-4.0', 'gee:unusual_terms_of_use': True})

  def test_valid_cc_nc_sa(self):
    self.assert_collection(
        {'license': 'CC-BY-NC-SA-4.0', 'gee:unusual_terms_of_use': True})

  def test_valid_proprietary(self):
    self.assert_collection(
        {'license': 'proprietary', 'gee:unusual_terms_of_use': True})

  def test_catalog_with_unusual(self):
    self.assert_catalog(
        {'gee:unusual_terms_of_use': True},
        'gee:unusual_terms_of_use not allowed in Catalog')

  def test_valid_cc_nc_without_unusual(self):
    self.assert_collection(
        {'license': 'CC-BY-NC-4.0'},
        'dataset has license that is unusual, '
        'but missing gee:unusual_terms_of_use')

  def test_not_a_bool(self):
    self.assert_collection(
        {'license': 'proprietary', 'gee:unusual_terms_of_use': 'not a bool'},
        'gee:unusual_terms_of_use must be of type bool')

  def test_false(self):
    self.assert_collection(
        {'license': 'proprietary', 'gee:unusual_terms_of_use': False},
        'gee:unusual_terms_of_use not allowed when false')

  def test_cc_by_is_not_unusual(self):
    self.assert_collection(
        {'license': 'CC-BY-4.0', 'gee:unusual_terms_of_use': True},
        'gee:unusual_terms_of_use not allowed for CC-BY-4.0')


if __name__ == '__main__':
  absltest.main()

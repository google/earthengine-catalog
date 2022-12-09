"""Tests for description."""

from checker import test_utils
from checker.node import description
from absl.testing import absltest


class DescriptionTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = description.Check

  def test_valid_catalog(self):
    self.assert_catalog({'description': 'x' * 40})

  def test_valid_collection(self):
    self.assert_collection({'description': 'y' * 40})

  def test_missing(self):
    self.assert_collection({}, 'Missing: description')

  def test_not_a_str(self):
    self.assert_collection(
        {'description': ['not a str']}, 'Description must be a str')

  def test_too_short(self):
    self.assert_collection(
        {'description': 'Too short'}, 'description too short: 9')

  def test_too_long(self):
    self.assert_collection(
        {'description': 'a' * 9000}, 'description too long: 9000')


if __name__ == '__main__':
  absltest.main()

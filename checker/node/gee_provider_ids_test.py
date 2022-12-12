"""Tests for gee_is_derived."""

from checker import test_utils
from checker.node import gee_provider_ids
from absl.testing import absltest

PROVIDER_ID_1 = 'ONE23-ID4_5'
PROVIDER_ID_2 = 'WX-YZ'


class ValidGeeProviderIdsTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_provider_ids.Check

  def test_catalog(self):
    self.assert_catalog({})

  def test_one(self):
    self.assert_collection({'gee:provider_ids': [PROVIDER_ID_1]})

  def test_more_than_one(self):
    self.assert_collection({'gee:provider_ids': [PROVIDER_ID_1, PROVIDER_ID_2]})

  def test_empty(self):
    self.assert_collection({})


class ErrorGeeProviderIdsTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_provider_ids.Check

  def test_catalog(self):
    self.assert_catalog(
        {'gee:provider_ids': 'stuff'}, 'Catalog cannot have gee:provider_ids')

  def test_provider_ids_not_list(self):
    self.assert_collection(
        {'gee:provider_ids': 'not a list'}, 'gee:provider_ids must be a list')

  def test_provider_ids_empty(self):
    self.assert_collection(
        {'gee:provider_ids': []}, 'gee:provider_ids cannot be empty')

  def test_provider_not_str(self):
    self.assert_collection(
        {'gee:provider_ids': [3425]}, 'provider_id must be a str')

  def test_provider_bad_str(self):
    self.assert_collection(
        {'gee:provider_ids': ['!@#$']}, 'provider_id not valid: "!@#$"')

  def test_provider_ids_not_sorted(self):
    self.assert_collection(
        {'gee:provider_ids': [PROVIDER_ID_2, PROVIDER_ID_1]},
        'gee:provider_ids must be sorted')

  def test_provider_ids_duplicated(self):
    self.assert_collection(
        {'gee:provider_ids': [PROVIDER_ID_1, PROVIDER_ID_1]},
        'gee:provider_ids cannot have duplicates')


if __name__ == '__main__':
  absltest.main()

"""Tests for id_field."""

from checker import test_utils
from checker.node import id_field
from absl.testing import absltest

ID = 'id'
UNKNOWN_ID = '> UNKNOWN ID: '


class IdFieldCatalogTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = id_field.Check

  def test_valid_id(self):
    id_list = ['A', 'b', 'c_d', 'd-f', 'g' * 50, 'FIRMS', 'NASA', 'NASA/b']
    for dataset_id in id_list:
      self.assert_catalog({ID: dataset_id}, dataset_id=dataset_id)

  def test_no_id(self):
    self.assert_catalog({}, 'Missing: id', dataset_id=UNKNOWN_ID)

  def test_id_not_str(self):
    self.assert_catalog({ID: 603}, 'id must be a str', dataset_id=UNKNOWN_ID)

  def test_empty_id(self):
    self.assert_catalog({ID: ''}, 'Empty id', dataset_id=UNKNOWN_ID)

  def test_cannot_start_with_slash(self):
    # pathlib is tripped up by a leading slash, so we catch it early.
    dataset_id = '/'
    message = f'id cannot start with "{dataset_id}"'
    self.assert_catalog({ID: dataset_id}, message, dataset_id=dataset_id)

  def test_bad_start_character(self):
    dataset_id = '^bad_start_character'
    message = 'id part not valid: "^bad_start_character"'
    self.assert_catalog({ID: dataset_id}, message, dataset_id=dataset_id)

  def test_bad_middle_character(self):
    dataset_id = 'bad$character'
    message = 'id part not valid: "bad$character"'
    self.assert_catalog({ID: dataset_id}, message, dataset_id=dataset_id)

  def test_bad_two_level(self):
    dataset_id = 'NOT_NASA/something'
    message = 'id length must be 1 for catalogs: "NOT_NASA/something": 2'
    self.assert_catalog({ID: dataset_id}, message, dataset_id=dataset_id)

  def test_bad_two_level_starts_with_two_level(self):
    dataset_id = 'NASA/b/c'
    message = 'id length must be 1 for catalogs: "NASA/b/c": 3'
    self.assert_catalog({ID: dataset_id}, message, dataset_id=dataset_id)


class IdFieldCollectionTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = id_field.Check

  def test_valid_id(self):
    # TODO(schwehr): The top level of catalogs
    id_list = [
        'a/b', 'a/b/c', '0/1/2', 'A/B_C/V2', 'A/B-C', 'a/' + 'b' * 50,
        '1/2/3/4/5/6/7', 'USGS/a', 'USGS/b/c', 'FIRMS']
    for dataset_id in id_list:
      self.assert_collection({ID: dataset_id}, dataset_id=dataset_id)

  def test_no_top_level(self):
    # 'FIRMS' is the only exception.
    dataset_id = 'ab'
    message = f'id length less than 2 for collection: {dataset_id}: 1'
    self.assert_collection({ID: dataset_id}, message, dataset_id=dataset_id)

  def test_bad_first_character(self):
    dataset_id = 'a/_'
    message = 'id part not valid: "_"'
    self.assert_collection({ID: dataset_id}, message, dataset_id=dataset_id)

  def test_bad_middleharacter(self):
    dataset_id = 'a/b.c'
    message = 'id part not valid: "b.c"'
    self.assert_collection({ID: dataset_id}, message, dataset_id=dataset_id)

  def test_part_too_long(self):
    part2 = 'b' * 52
    dataset_id = 'a/' + part2
    message = f'id part not valid: "{part2}"'
    self.assert_collection({ID: dataset_id}, message, dataset_id=dataset_id)

  def test_too_deep(self):
    dataset_id = '1/2/3/4/5/6/7/8'
    message = 'id length greater than 7 for collection: 1/2/3/4/5/6/7/8: 8'
    self.assert_collection({ID: dataset_id}, message, dataset_id=dataset_id)

  def test_multiple_issues(self):
    dataset_id = '1/2/3/4/5/6/7/8/$'
    messages = [
        'id part not valid: "$"',
        'id length greater than 7 for collection: 1/2/3/4/5/6/7/8/$: 9']
    self.assert_collection({ID: dataset_id}, messages, dataset_id=dataset_id)


if __name__ == '__main__':
  absltest.main()

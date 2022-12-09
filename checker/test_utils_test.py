"""Tests for test_utils."""

from typing import Iterator

from checker import stac
from checker import test_utils
from absl.testing import absltest


class Check(stac.NodeCheck):
  """A check just for use in testing."""
  name = 'check_name_used_in_issues'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.id == 'zero':
      pass
    if node.id == 'one':
      yield cls.new_issue(node, f'{node.type} 0')
    if node.id == 'two':
      yield cls.new_issue(node, f'{node.type} 1')
      yield cls.new_issue(node, f'{node.type} 2')
    if str(node.path) == 'bad path':
      yield cls.new_issue(node, 'bad path')


class TestUtilsTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = Check

  def test_catalog_dataset_id_zero_messages(self):
    self.assert_catalog({}, dataset_id='zero')

  def test_catalog_dataset_id_one_message(self):
    with self.assertRaisesRegex(AssertionError, 'Catalog 0'):
      self.assert_catalog({}, dataset_id='one')
    self .assert_catalog({}, 'Catalog 0', dataset_id='one')

  def test_catalog_dataset_id_two_messages(self):
    dataset_id = 'two'
    with self.assertRaisesRegex(AssertionError, 'Catalog 1.*\n.*Catalog 2'):
      self.assert_catalog({}, dataset_id=dataset_id)
    self .assert_catalog({}, ['Catalog 1', 'Catalog 2'], dataset_id=dataset_id)

  def test_catalog_expect_errors_but_get_none(self):
    dataset_id = 'zero'
    raises_message = r'Expected:\n.*Issue.*\n\nFound:\n *$'
    with self.assertRaisesRegex(AssertionError, raises_message):
      self.assert_catalog({}, 'message', dataset_id=dataset_id)

  def test_catalog_file_path(self):
    self.assert_catalog({}, 'bad path', file_path='bad path')

  def test_collection_dataset_id_zero_messages(self):
    self.assert_collection({}, dataset_id='zero')

  def test_collection_dataset_id_one_message(self):
    with self.assertRaisesRegex(AssertionError, 'Collection 0'):
      self.assert_collection({}, dataset_id='one')
    self .assert_collection({}, 'Collection 0', dataset_id='one')

  def test_collection_dataset_id_two_messages(self):
    dataset_id = 'two'
    with self.assertRaisesRegex(
        AssertionError, 'Collection 1.*\n.*Collection 2'):
      self.assert_collection({}, dataset_id=dataset_id)
    self .assert_collection(
        {}, ['Collection 1', 'Collection 2'], dataset_id=dataset_id)

  def test_collection_expect_errors_but_get_none(self):
    dataset_id = 'zero'
    raises_message = r'Expected:\n.*Issue.*\n\nFound:\n *$'
    with self.assertRaisesRegex(AssertionError, raises_message):
      self.assert_collection({}, 'message', dataset_id=dataset_id)

  def test_collection_file_path(self):
    self.assert_collection({}, 'bad path', file_path='bad path')


if __name__ == '__main__':
  absltest.main()

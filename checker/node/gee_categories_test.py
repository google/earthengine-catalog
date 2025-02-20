from absl.testing import absltest
from checker import test_utils
from checker.node import gee_categories


class GeeCategoiresTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_categories.Check

  def test_catalog(self):
    self.assert_catalog({})

  def test_not_a_list(self):
    self.assert_collection(
        {'gee:categories': 77}, '"gee:categories" must be a list of strings'
    )

  def test_missing_ok(self):
    self.assert_collection({})

  # TODO(b/397988701): require categories when all datasets have them
  # def test_empty_categories_is_bad(self):
  #   self.assert_collection({'gee:categories': []}, 'must not be empty')

  def test_valid_category(self):
    self.assert_collection({'gee:categories': ['soil']})

  def test_bad_category(self):
    self.assert_collection(
        {'gee:categories': ['bogus']},
        'Found unknown category "bogus" in "gee:categories"',
    )


if __name__ == '__main__':
  absltest.main()

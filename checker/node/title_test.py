"""Tests for title."""

from checker import stac
from checker import test_utils
from checker.node import title
from absl.testing import absltest

DEPRECATED = title.DEPRECATED
TITLE = title.TITLE


class CatalogTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = title.Check

  def test_valid(self):
    dataset_id = 'ValidCatalogTitle'
    self.assert_catalog({TITLE: dataset_id}, dataset_id=dataset_id)

  def test_exception(self):
    self.assert_catalog({TITLE: '3DEP'}, dataset_id='USGS/3DEP')

  def test_required(self):
    self.assert_catalog({}, 'Missing title')

  def test_is_str(self):
    self.assert_catalog({TITLE: ['not a str']}, '"title" must be a str')

  def test_invalid(self):
    dataset_id = 'not a valid title'
    self.assert_catalog(
        {TITLE: dataset_id},
        'Catalog title not valid: "not a valid title"',
        dataset_id=dataset_id)

  def test_warning_for_title_not_being_last_id_component(self):
    a_title = 'A_title'
    dataset_id = 'A_catalog'
    self.assert_catalog(
        {TITLE: a_title},
        'Catalog title is usually the dataset id: '
        f'"{dataset_id}" != "{a_title}"',
        dataset_id=dataset_id,
        issue_level=stac.IssueLevel.WARNING)


class CollectionTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = title.Check

  def test_valid(self):
    self.assert_collection({TITLE: 'A collection title'})

  def test_deprecated(self):
    # Over size limit with deprecation str
    self.assert_collection({TITLE: 'A' * 140 + DEPRECATED})

  def test_exception(self):
    dataset_id = 'ISDASOIL/Africa/v1/ph'
    self.assert_collection({TITLE: dataset_id}, dataset_id=dataset_id)

  def test_invalid(self):
    self.assert_collection(
        {TITLE: '% not a valid title'},
        'Collection title not valid: "% not a valid title"')

  def test_invalid_too_long(self):
    extra = 'Z' * 140
    self.assert_collection(
        {TITLE: 'Too long ' + extra},
        f'Collection title not valid: "Too long {extra}"')


if __name__ == '__main__':
  absltest.main()

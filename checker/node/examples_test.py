"""Tests for examples."""

import pathlib
from unittest import mock

from checker import stac
from checker import test_utils
from checker.node import examples
import unittest

TABLE = stac.GeeType.TABLE
TABLE_COLLECTION = stac.GeeType.TABLE_COLLECTION

IMAGE_ID = 'A/B'
IMAGE_JS = 'A_B.js'

TABLE_ID = 'C/D'
TABLE_JS = 'C_D.js'
TABLE_FEATUREVIEW_JS = 'C_D_FeatureView.js'

TABLE_WITHOUT_FEATUREVIEW_ID = 'A/B'

TABLE_WITHOUT_JS = 'E/F'
TABLE_WITHOUT_JS_FEATUREVIEW_JS = 'E_F_FeatureView.js'

FEATUREVIEW_EXCEPTION_ID = 'TIGER/2010/BG'
FEATUREVIEW_EXCEPTION_JS = 'TIGER_2010_BG.js'


def mock_load(examples_root: pathlib.Path) -> set[str]:
  return {
      IMAGE_JS,
      TABLE_JS,
      TABLE_FEATUREVIEW_JS,
      TABLE_WITHOUT_JS_FEATUREVIEW_JS,
      FEATUREVIEW_EXCEPTION_JS}


class ValidExamplesTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = examples.Check
    self.check.scripts = set()
    self.enter_context(mock.patch.object(examples, 'load', mock_load))

  def test_catalog(self):
    self.assert_catalog({})

  def test_exists(self):
    self.assert_collection({}, dataset_id=IMAGE_ID)

  def test_skip_indexing(self):
    self.assert_collection({'gee:skip_indexing': True})

  def test_exists_table(self):
    self.assert_collection({}, dataset_id=TABLE_ID, gee_type=TABLE)

  def test_skip_featureview_generation(self):
    self.assert_collection(
        {'gee:skip_featureview_generation': True},
        dataset_id=TABLE_WITHOUT_FEATUREVIEW_ID,
        gee_type=TABLE)

  def test_table_missing_featureview_exception(self):
    self.assert_collection(
        {}, dataset_id=FEATUREVIEW_EXCEPTION_ID, gee_type=TABLE)


class ErrorExamplesTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = examples.Check
    self.check.scripts = set()
    self.enter_context(mock.patch.object(examples, 'load', mock_load))

  def test_does_not_exist(self):
    self.assert_collection({}, 'Missing script: a_collection.js')

  def test_table_missing_featureview(self):
    self.assert_collection(
        {},
        'Missing FeatureView script: A_B_FeatureView.js',
        dataset_id=TABLE_WITHOUT_FEATUREVIEW_ID,
        gee_type=TABLE)

  def test_table_missing_table_script(self):
    self.assert_collection(
        {},
        'Missing script: E_F.js',
        dataset_id=TABLE_WITHOUT_JS,
        gee_type=TABLE)

  def test_image_cannot_have_featureview(self):
    self.assert_collection(
        {},
        'Only a table can have a FeatureView script: C_D_FeatureView.js',
        dataset_id=TABLE_ID)


if __name__ == '__main__':
  unittest.main()

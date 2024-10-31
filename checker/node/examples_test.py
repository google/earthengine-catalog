"""Tests for examples."""

import pathlib
from unittest import mock

from checker import stac
from checker import test_utils
from checker.node import examples
from absl.testing import absltest

TABLE = stac.GeeType.TABLE
TABLE_COLLECTION = stac.GeeType.TABLE_COLLECTION

IMAGE_ID = 'A/B'
IMAGE_JS = 'A/A_B.js'
IMAGE_PREVIEW_JS = 'A/A_B_preview.js'

PROJECTS_IMAGE_ID = 'projects/G/H'
PROJECTS_IMAGE_JS = 'G/projects_G_H.js'
PROJECTS_IMAGE_PREVIEW_JS = 'G/projects_G_H_preview.js'

TABLE_ID = 'C/D'
TABLE_JS = 'C/C_D.js'
TABLE_FEATUREVIEW_JS = 'C/C_D_FeatureView.js'
TABLE_PREVIEW_JS = 'C/C_D_preview.js'

TABLE_WITHOUT_FEATUREVIEW_ID = 'A/B'

TABLE_WITHOUT_JS = 'E/F'
TABLE_WITHOUT_JS_FEATUREVIEW_JS = 'E/E_F_FeatureView.js'
TABLE_WITHOUT_JS_PREVIEW_JS = 'E/E_F_preview.js'

FEATUREVIEW_EXCEPTION_ID = 'TIGER/2010/BG'
FEATUREVIEW_EXCEPTION_JS = 'TIGER/TIGER_2010_BG.js'
FEATUREVIEW_EXCEPTION_PREVIEW_JS = 'TIGER/TIGER_2010_BG_preview.js'


def mock_load(examples_root: pathlib.Path) -> set[str]:
  return {
      IMAGE_JS,
      PROJECTS_IMAGE_JS,
      TABLE_JS,
      TABLE_FEATUREVIEW_JS,
      TABLE_WITHOUT_JS_FEATUREVIEW_JS,
      FEATUREVIEW_EXCEPTION_JS}


def mock_load_previews(examples_root: pathlib.Path) -> set[str]:
  return {
      IMAGE_PREVIEW_JS,
      PROJECTS_IMAGE_PREVIEW_JS,
      TABLE_PREVIEW_JS,
      TABLE_WITHOUT_JS_PREVIEW_JS,
      FEATUREVIEW_EXCEPTION_PREVIEW_JS}


class ValidExamplesTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = examples.Check
    self.check.scripts = set()
    self.enter_context(mock.patch.object(examples, 'load', mock_load))
    self.enter_context(
        mock.patch.object(examples, 'load_previews', mock_load_previews))

  def test_catalog(self):
    self.assert_catalog({})

  def test_exists(self):
    self.assert_collection({}, dataset_id=IMAGE_ID)

  def test_exists_projects(self):
    self.assert_collection({}, dataset_id=PROJECTS_IMAGE_ID)

  def test_exists_ccdc(self):
    # There are scripts for CCDC in the mock output above, yet
    # the test passes.
    self.assert_collection({}, dataset_id='GOOGLE/GLOBAL_CCDC/V1')

  def test_exists_table(self):
    self.assert_collection({}, dataset_id=TABLE_ID, gee_type=TABLE)

  def test_skip_featureview_generation(self):
    self.assert_collection(
        {'gee:skip_featureview_generation': True},
        dataset_id=TABLE_WITHOUT_FEATUREVIEW_ID,
        gee_type=TABLE)

  def test_table_missing_featureview_exception(self):
    self.assert_collection(
        {},
        'Remove preview script from _PREVIEW_EXCEPTIONS: ' +
        'TIGER/TIGER_2010_BG_preview.js',
        dataset_id=FEATUREVIEW_EXCEPTION_ID, gee_type=TABLE)


class ErrorExamplesTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = examples.Check
    self.check.scripts = set()
    self.enter_context(mock.patch.object(examples, 'load', mock_load))
    self.enter_context(
        mock.patch.object(examples, 'load_previews', mock_load_previews))

  def test_does_not_exist(self):
    self.assert_collection(
        {},
        ['Missing script: a/a_collection.js',
         'Missing preview script: a/a_collection_preview.js'])

  def test_table_missing_featureview(self):
    self.assert_collection(
        {},
        'Missing FeatureView script: A/A_B_FeatureView.js',
        dataset_id=TABLE_WITHOUT_FEATUREVIEW_ID,
        gee_type=TABLE)

  def test_table_missing_table_script(self):
    self.assert_collection(
        {},
        'Missing script: E/E_F.js',
        dataset_id=TABLE_WITHOUT_JS,
        gee_type=TABLE)

  def test_image_cannot_have_featureview(self):
    self.assert_collection(
        {},
        'Only a table can have a FeatureView script: C/C_D_FeatureView.js',
        dataset_id=TABLE_ID)


if __name__ == '__main__':
  absltest.main()

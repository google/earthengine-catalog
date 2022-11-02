"""Tests for feature_view."""

import pathlib
from unittest import mock

from checker import stac
from checker.node import feature_view
import unittest

Check = feature_view.Check

COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
IMAGE_COLLECTION = stac.GeeType.IMAGE_COLLECTION
TABLE = stac.GeeType.TABLE
TABLE_COLLECTION = stac.GeeType.TABLE_COLLECTION

ID = 'a/test/id'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')

FEATUREVIEW_EXCEPTION_ID = 'AN/EXCEPTION'


def mock_table_without_featureview_exception(dataset_id: str) -> bool:
  return dataset_id == FEATUREVIEW_EXCEPTION_ID


class ValidFeatureViewTest(unittest.TestCase):

  def test_valid_density_desc(self):
    stac_data = {'summaries': {'gee:feature_view_ingestion_params': {
        'max_features_per_tile': 150,
        'thinning_strategy': 'HIGHER_DENSITY',
        'thinning_ranking': 'BurnBndAc DESC',
        'z_order_ranking': 'BurnBndAc DESC',
        'prerender_tiles': True}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_global_asc(self):
    stac_data = {'summaries': {'gee:feature_view_ingestion_params': {
        'max_features_per_tile': 16000,
        'thinning_strategy': 'GLOBALLY_CONSISTENT',
        'thinning_ranking': 'rttyp ASC',
        'z_order_ranking': 'rttyp ASC'}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_dot_field(self):
    stac_data = {'summaries': {'gee:feature_view_ingestion_params': {
        'max_features_per_tile': 12000,
        'thinning_strategy': 'HIGHER_DENSITY',
        'z_order_ranking': '.minZoomLevel DESC'}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_no_summaries(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_summaries_not_dict(self):
    stac_data = {'summaries': 'not a dict'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_table_collection(self):
    stac_data = {'summaries': {}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))


class ErrorFeatureViewTest(unittest.TestCase):

  def test_image_with_params(self):
    stac_data = {'summaries': {'gee:feature_view_ingestion_params': 'yada'}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:feature_view_ingestion_params not allowed in image')]
    self.assertEqual(expect, issues)

  def test_image_collection_with_params(self):
    stac_data = {'summaries': {'gee:feature_view_ingestion_params': 'yada'}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'gee:feature_view_ingestion_params not allowed in image_collection')]
    self.assertEqual(expect, issues)

  def test_table_collection_with_params(self):
    stac_data = {'summaries': {'gee:feature_view_ingestion_params': 'yada'}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'gee:feature_view_ingestion_params not allowed in table_collection')]
    self.assertEqual(expect, issues)

  def test_table_without_params(self):
    stac_data = {'summaries': {}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:feature_view_ingestion_params must be present in table')]
    self.assertEqual(expect, issues)

  @mock.patch.object(
      feature_view, 'table_without_featureview_exception',
      mock_table_without_featureview_exception)
  def test_in_tables_without_featureview_but_has_featureview_params(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {'prerender_tiles': True}}}
    node = stac.Node(
        FEATUREVIEW_EXCEPTION_ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'AN/EXCEPTION is in the list of tables without feature views, '
        'but gee:feature_view_ingestion_params is present')]
    self.assertEqual(expect, issues)

  def test_params_not_dict(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': 'not a dict'}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:feature_view_ingestion_params must be a dict')]
    self.assertEqual(expect, issues)

  def test_params_empty(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:feature_view_ingestion_params must not be empty')]
    self.assertEqual(expect, issues)

  def test_max_features_not_int(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {'max_features_per_tile': 99.99}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'max_features_per_tile must be an int')]
    self.assertEqual(expect, issues)

  def test_max_features_too_small(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {'max_features_per_tile': 149}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'max_features_per_tile must be >= 150')]
    self.assertEqual(expect, issues)

  def test_max_features_too_large(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {'max_features_per_tile': 20001}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'max_features_per_tile must be <= 16000')]
    self.assertEqual(expect, issues)

  def test_thinning_strategy_not_str(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {'thinning_strategy': 12}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'thinning_strategy must be a str')]
    self.assertEqual(expect, issues)

  def test_thinning_strategy_invalid_str(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {'thinning_strategy': 'bogus'}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'thinning_strategy must be one of '
        'GLOBALLY_CONSISTENT, HIGHER_DENSITY')]
    self.assertEqual(expect, issues)

  def test_thinning_ranking_not_str(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {'thinning_ranking': 13}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'thinning_ranking must be a str')]
    self.assertEqual(expect, issues)

  def test_thinning_ranking_too_few(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {'thinning_ranking': 'ASC'}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'thinning_ranking must be "<field> ASC|DESC')]
    self.assertEqual(expect, issues)

  def test_thinning_ranking_too_many(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {
            'thinning_ranking': 'id DESC extra'}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'thinning_ranking must be "<field> ASC|DESC')]
    self.assertEqual(expect, issues)

  def test_thinning_ranking_name(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {
            'thinning_ranking': 'i DESC'}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Invalid property_name: "i"')]
    self.assertEqual(expect, issues)

  def test_thinning_ranking_direction(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {
            'thinning_ranking': 'id ASCENDING'}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'thinning_ranking direction must be one of ASC, DESC')]
    self.assertEqual(expect, issues)

  def test_z_order_ranking_not_str(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {'z_order_ranking': 14}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'z_order_ranking must be a str')]
    self.assertEqual(expect, issues)

  def test_z_order_ranking_too_few(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {'z_order_ranking': 'ABC'}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'z_order_ranking must be "<field> ASC|DESC')]
    self.assertEqual(expect, issues)

  def test_z_order_ranking_too_many(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {
            'z_order_ranking': 'id DESC extra'}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'z_order_ranking must be "<field> ASC|DESC')]
    self.assertEqual(expect, issues)

  def test_z_order_ranking_name(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {
            'z_order_ranking': 'i DESC'}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Invalid property_name: "i"')]
    self.assertEqual(expect, issues)

  def test_z_order_ranking_direction(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {
            'z_order_ranking': 'id DESCENDING'}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'z_order_ranking direction must be one of ASC, DESC')]
    self.assertEqual(expect, issues)

  def test_prerender_tiles_not_str(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {'prerender_tiles': 'not a bool'}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'prerender_tiles must be a bool')]
    self.assertEqual(expect, issues)

  def test_prerender_tiles_false(self):
    stac_data = {'summaries': {
        'gee:feature_view_ingestion_params': {'prerender_tiles': False}}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, TABLE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'prerender_tiles can only be present when true')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

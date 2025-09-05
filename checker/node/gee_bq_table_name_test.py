"""Tests for gee_bq_table_name."""

from absl.testing import absltest
from checker import stac
from checker import test_utils
from checker.node import gee_bq_table_name


class GeeBqTableNameTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_bq_table_name.Check

  def test_valid_bq_table_name(self):
    self.assert_collection(
        {
            'gee:type': stac.GeeType.BIGQUERY_TABLE,
            'gee:bq_table_name': 'project.dataset.table',
        },
        gee_type=stac.GeeType.BIGQUERY_TABLE,
    )

  def test_not_bigquery_table(self):
    self.assert_collection(
        {
            'gee:type': stac.GeeType.IMAGE,
            'gee:bq_table_name': 'project.dataset.table',
        },
        'gee:bq_table_name only allowed for bigquery_table',
    )

  def test_missing_bq_table_name(self):
    self.assert_collection(
        {'gee:type': stac.GeeType.BIGQUERY_TABLE},
        'gee:bq_table_name is required',
        gee_type=stac.GeeType.BIGQUERY_TABLE,
    )

  def test_bq_table_name_not_str(self):
    self.assert_collection(
        {'gee:type': stac.GeeType.BIGQUERY_TABLE, 'gee:bq_table_name': 123},
        'gee:bq_table_name must be a str',
        gee_type=stac.GeeType.BIGQUERY_TABLE,
    )

  def test_invalid_bq_table_name_format(self):
    invalid_names = [
        'project',
        'project.dataset',
        'project.dataset.',
        '.dataset.table',
        'project..table',
        'prj-dset.tbl',  # Project ID can have hyphens, but not dataset/table
    ]
    for name in invalid_names:
      self.assert_collection(
          {'gee:type': stac.GeeType.BIGQUERY_TABLE, 'gee:bq_table_name': name},
          f'gee:bq_table_name format is invalid: "{name}". '
          'Expected format: project_id.dataset_id.table_id',
          gee_type=stac.GeeType.BIGQUERY_TABLE,
      )


if __name__ == '__main__':
  absltest.main()

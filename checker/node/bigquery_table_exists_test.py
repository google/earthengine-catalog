import pathlib
from unittest import mock

from absl.testing import absltest
from google.cloud import exceptions
from googleapiclient import errors as apiclient_errors

from checker import stac
from checker.node import bigquery_table_exists

TABLE_NAME = 'project:dataset.table'
TABLE_FOR_CLIENT = 'project.dataset.table'


class BigqueryTableExistsTest(absltest.TestCase):

  def setUp(self):
    super().setUp()
    self.stac_node = mock.Mock(spec=stac.Node)
    self.stac_node.id = 'a/dataset'
    self.stac_node.path = pathlib.Path('a/dataset/path')

  @mock.patch('google.cloud.bigquery.Client')
  def test_run_success(self, mock_client):
    self.stac_node.stac = {
        'gee:type': 'bigquery_table',
        'gee:bq_table_name': TABLE_NAME,
    }
    issues = list(bigquery_table_exists.Check.run(self.stac_node))
    self.assertEqual(0, len(issues))
    mock_client.return_value.get_table.assert_called_once_with(
        TABLE_FOR_CLIENT
    )

  @mock.patch('google.cloud.bigquery.Client')
  def test_run_table_not_found(self, mock_client):
    self.stac_node.stac = {
        'gee:type': 'bigquery_table',
        'gee:bq_table_name': TABLE_NAME,
    }
    mock_client.return_value.get_table.side_effect = exceptions.NotFound(
        'Table not found'
    )
    issues = list(bigquery_table_exists.Check.run(self.stac_node))
    self.assertLen(issues, 1)
    self.assertIn('could not be found', issues[0].message)

  @mock.patch('google.cloud.bigquery.Client')
  def test_run_api_error(self, mock_client):
    self.stac_node.stac = {
        'gee:type': 'bigquery_table',
        'gee:bq_table_name': TABLE_NAME,
    }
    mock_client.return_value.get_table.side_effect = (
        apiclient_errors.HttpError(mock.Mock(status=403), 'Permission denied')
    )
    issues = list(bigquery_table_exists.Check.run(self.stac_node))
    self.assertLen(issues, 1)
    self.assertIn('Failed to verify', issues[0].message)
    self.assertIn('Permission denied', issues[0].message)

  def test_run_not_bigquery_table(self):
    self.stac_node.stac = {'gee:type': 'image_collection'}
    issues = list(bigquery_table_exists.Check.run(self.stac_node))
    self.assertEqual(0, len(issues))

  def test_run_missing_table_name(self):
    self.stac_node.stac = {'gee:type': 'bigquery_table'}
    issues = list(bigquery_table_exists.Check.run(self.stac_node))
    self.assertLen(issues, 1)
    self.assertIn(
        'missing the "gee:bq_table_name" field', issues[0].message
    )


if __name__ == '__main__':
  absltest.main()

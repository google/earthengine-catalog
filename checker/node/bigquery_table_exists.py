"""Checks that a BigQuery table exists."""

from typing import Callable, Iterator

from google.cloud import bigquery
from google.cloud import exceptions
from googleapiclient import errors as apiclient_errors

from checker import stac
from checker.stac import Issue


class Check(stac.NodeCheck):
  """Checks that the BigQuery table specified in a STAC file exists."""
  name = 'bigquery_table_exists'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[Issue]:
    if node.stac.get('gee:type') == 'bigquery_table':
      table_name = node.stac.get('gee:bq_table_name')
      if not table_name:
        yield cls.new_issue(
            node,
            'Dataset has gee:type=bigquery_table but is '
            'missing the "gee:bq_table_name" field.')
        return

      try:
        bigquery_client = bigquery.Client()
        # The BigQuery client expects `project.dataset.table`.
        # The catalog sometimes uses `project:dataset.table`.
        table_for_client = table_name.replace(':', '.', 1)
        bigquery_client.get_table(table_for_client)
      except exceptions.NotFound:
        yield cls.new_issue(
            node,
            f'The BigQuery table "{table_name}" could not be found. '
            'Please ensure the table is created before submitting this '
            'dataset definition.')
      except apiclient_errors.HttpError as e:
        yield cls.new_issue(
            node, f'Failed to verify BigQuery table "{table_name}": {e}')

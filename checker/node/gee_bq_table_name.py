"""Checks for gee:bq_table_name.

- gee:bq_table_name cannot be in STAC Catalogs
  - This is enforced in top_level.py
- bq_table_name is a string that is bigquery table name in the format of
  project_id.dataset_id.table_id
"""

import re
from typing import Iterator

from checker import stac

GEE_BQ_TABLE_NAME = 'gee:bq_table_name'
GEE_TYPE = 'gee:type'

# Regular expression to validate the BigQuery table name format
# project_id.dataset_id.table_id
BQ_TABLE_NAME_RE = re.compile(
    r'^[a-z0-9\-]+[\.][a-zA-Z0-9_]+[\.][a-zA-Z0-9_]+$'
)


class Check(stac.NodeCheck):
  """Checks for gee:bq_table_name."""
  name = 'gee_bq_table_name'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    gee_type = node.stac.get(GEE_TYPE)

    if gee_type != stac.GeeType.BIGQUERY_TABLE:
      if GEE_BQ_TABLE_NAME in node.stac:
        yield cls.new_issue(
            node,
            f'{GEE_BQ_TABLE_NAME} only allowed for'
            f' {stac.GeeType.BIGQUERY_TABLE}',
        )
      return

    if GEE_BQ_TABLE_NAME not in node.stac:
      yield cls.new_issue(node, f'{GEE_BQ_TABLE_NAME} is required')
      return

    bq_table_name = node.stac[GEE_BQ_TABLE_NAME]

    if not isinstance(bq_table_name, str):
      yield cls.new_issue(node, f'{GEE_BQ_TABLE_NAME} must be a str')
      return

    if not BQ_TABLE_NAME_RE.fullmatch(bq_table_name):
      yield cls.new_issue(
          node,
          f'{GEE_BQ_TABLE_NAME} format is invalid: "{bq_table_name}". '
          'Expected format: project_id.dataset_id.table_id',
      )

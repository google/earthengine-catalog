"""Tests for stac."""

import pathlib

from checker import stac
from absl.testing import absltest

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE

ID = 'id'
DUMMY_PATH = pathlib.Path('a/path.json')


class IssueTest(absltest.TestCase):

  def test_str(self):
    issue = stac.Issue('an id', pathlib.Path('a path'), 'a name', 'a message')
    expect = (
        """Issue('an id', 'a path', 'a name', 'a message', IssueLevel.error)""")
    self.assertEqual(expect, str(issue))

  def test_str_warning(self):
    issue = stac.Issue(
        id='a', path=pathlib.Path('b'), check_name='c', message='d',
        level=stac.IssueLevel.WARNING)
    expect = (
        """Issue('a', 'b', 'c', 'd', IssueLevel.warning)""")
    self.assertEqual(expect, str(issue))


class CheckTest(absltest.TestCase):

  def test_new_issue(self):
    dataset_id = 'an id'
    path = pathlib.Path('a/path.json')
    expected_path = pathlib.Path('a/path.jsonnet')
    stac_type = stac.StacType.COLLECTION
    gee_type = stac.GeeType.TABLE
    stac_data = {'field': 'value'}
    node = stac.Node(dataset_id, path, stac_type, gee_type, stac_data)

    message = 'a message'
    issue = stac.Check.new_issue(node, message)

    self.assertEqual(dataset_id, issue.id)
    self.assertEqual(expected_path, issue.path)
    self.assertEqual(
        'https://github.com/google/earthengine-catalog/blob/main/checker/stac.py',
        issue.check_name,
    )
    self.assertEqual(message, issue.message)
    self.assertEqual(stac.IssueLevel.ERROR, issue.level)

  def test_new_issue_with_warning(self):
    dataset_id = 'id2'
    path = pathlib.Path('another/path.json')
    stac_type = stac.StacType.COLLECTION
    gee_type = stac.GeeType.TABLE
    stac_data = {'field2': 'value2'}
    node = stac.Node(dataset_id, path, stac_type, gee_type, stac_data)

    message = 'a message'
    issue = stac.Check.new_issue(node, message, stac.IssueLevel.WARNING)

    expect = stac.Issue(
        dataset_id,
        pathlib.Path('another/path.jsonnet'),
        'https://github.com/google/earthengine-catalog/blob/main/checker/stac.py',
        message,
        stac.IssueLevel.WARNING,
    )

    self.assertEqual(expect, issue)

  def test_not_implemented(self):
    node = stac.Node(
        ID, DUMMY_PATH, stac.StacType.COLLECTION, stac.GeeType.TABLE, {})

    with self.assertRaises(NotImplementedError):
      stac.NodeCheck.run(node)
    with self.assertRaises(NotImplementedError):
      stac.TreeCheck.run([node])


class LoadTest(absltest.TestCase):

  def test_found_collections(self):
    stac_root = stac.stac_root()
    nodes = stac.load(stac_root)
    self.assertGreater(len(nodes), 200)


class BqTableCheckTest(absltest.TestCase):

  def test_missing_summaries(self):
    node = stac.Node(
        ID,
        DUMMY_PATH,
        COLLECTION,
        stac.GeeType.BIGQUERY_TABLE,
        {'gee:bq_table_name': 'a'},
    )
    issues = list(stac.BqTableCheck.run(node))
    self.assertLen(issues, 1)
    self.assertEqual(issues[0].message, '"summaries" is required')

  def test_summaries_not_dict(self):
    node = stac.Node(
        ID,
        DUMMY_PATH,
        COLLECTION,
        stac.GeeType.BIGQUERY_TABLE,
        {'gee:bq_table_name': 'a', 'summaries': 'b'},
    )
    issues = list(stac.BqTableCheck.run(node))
    self.assertLen(issues, 1)
    self.assertEqual(issues[0].message, '"summaries" must be a dictionary')

  def test_missing_gee_schema(self):
    node = stac.Node(
        ID,
        DUMMY_PATH,
        COLLECTION,
        stac.GeeType.BIGQUERY_TABLE,
        {'gee:bq_table_name': 'a', 'summaries': {}},
    )
    issues = list(stac.BqTableCheck.run(node))
    self.assertLen(issues, 1)
    self.assertEqual(
        issues[0].message, '"gee:schema" is missing from "summaries"'
    )
    self.assertEqual(issues[0].level, stac.IssueLevel.WARNING)

  def test_valid_bq_table(self):
    node = stac.Node(
        ID,
        DUMMY_PATH,
        COLLECTION,
        stac.GeeType.BIGQUERY_TABLE,
        {
            'gee:bq_table_name': 'a',
            'summaries': {'gee:schema': []},
        },
    )
    issues = list(stac.BqTableCheck.run(node))
    self.assertEqual(0, len(issues))


class NoncommercialTest(absltest.TestCase):
  def test_is_in_noncommercial_evaluates_prefix(self):
    # 'WRI/SBTN/naturalLands/v1' is in the noncommercial prefix list, so
    # 'WRI/SBTN/naturalLands/v1/2020' should be considered noncommercial.
    full_asset_id = 'WRI/SBTN/naturalLands/v1/2020'
    self.assertTrue(stac.is_in_non_commercial(full_asset_id))
if __name__ == '__main__':
  absltest.main()

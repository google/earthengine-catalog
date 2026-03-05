"""Tests for gee:status."""

import json
import os
from unittest import mock

from absl.testing import absltest
from checker import test_utils
from checker.node import gee_status


class GeeStatusUtilsTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_status.Check

  def tearDown(self):
    super().tearDown()
    gee_status.get_added_jsonnet_files.cache_clear()

  @mock.patch.dict(os.environ, {}, clear=True)
  def test_added_files_no_env(self):
    self.assertEqual(gee_status.get_added_jsonnet_files(), [])

  @mock.patch.dict(
      os.environ,
      {
          'GITHUB_ACTIONS': 'true',
          'GITHUB_EVENT_NAME': 'push',
          'GITHUB_ACTOR': 'some-user',
      },
      clear=True,
  )
  @mock.patch('subprocess.run')
  def test_added_files_push(self, mock_run):
    mock_run.return_value.returncode = 0
    mock_run.return_value.stdout = 'catalog/subdir/file.jsonnet\nother/file.txt'

    files = gee_status.get_added_jsonnet_files()
    self.assertEqual(files, ['catalog/subdir/file.jsonnet'])
    mock_run.assert_called_once()
    args = mock_run.call_args[0][0]
    self.assertEqual(args[0], 'git')

  @mock.patch.dict(
      os.environ,
      {
          'GITHUB_ACTIONS': 'true',
          'GITHUB_EVENT_NAME': 'pull_request',
          'GITHUB_REF': 'refs/pull/123/merge',
          'GITHUB_REPOSITORY': 'org/repo',
          'GITHUB_TOKEN': 'token',
          'GITHUB_ACTOR': 'Sancho Panza',
      },
      clear=True,
  )
  @mock.patch('subprocess.run')
  def test_added_files_pr(self, mock_run):
    mock_run.return_value.returncode = 0
    response = [
        {'filename': 'catalog/subdir/file.jsonnet', 'status': 'added'},
        {'filename': 'catalog/subdir/other.jsonnet', 'status': 'modified'},
        {'filename': 'catalog/subdir/ignored.txt', 'status': 'added'},
    ]
    mock_run.return_value.stdout = json.dumps(response)

    files = gee_status.get_added_jsonnet_files()
    self.assertEqual(files, ['catalog/subdir/file.jsonnet'])
    mock_run.assert_called_once()
    args = mock_run.call_args[0][0]
    self.assertEqual(args[0], 'gh')

  @mock.patch.dict(
      os.environ,
      {
          'GITHUB_ACTIONS': 'true',
          'GITHUB_EVENT_NAME': 'push',
          'GITHUB_ACTOR': 'copybara-service[bot]',
      },
      clear=True,
  )
  def test_added_files_copybara(self):
    self.assertEqual(gee_status.get_added_jsonnet_files(), [])

  @mock.patch.dict(
      os.environ,
      {
          'GITHUB_ACTIONS': 'true',
          'GITHUB_EVENT_NAME': 'schedule',
          'GITHUB_ACTOR': 'some-user',
      },
      clear=True,
  )
  def test_added_files_unsupported_event(self):
    self.assertEqual(gee_status.get_added_jsonnet_files(), [])

  @mock.patch.dict(
      os.environ,
      {
          'GITHUB_ACTIONS': 'true',
          'GITHUB_EVENT_NAME': 'push',
          'GITHUB_ACTOR': 'some-user',
      },
      clear=True,
  )
  @mock.patch('subprocess.run')
  def test_added_files_push_failure(self, mock_run):
    mock_run.return_value.returncode = 1
    self.assertEqual(gee_status.get_added_jsonnet_files(), [])

  @mock.patch.dict(
      os.environ,
      {
          'GITHUB_ACTIONS': 'true',
          'GITHUB_EVENT_NAME': 'pull_request',
          'GITHUB_REF': 'refs/heads/main',
          'GITHUB_ACTOR': 'some-user',
      },
      clear=True,
  )
  def test_added_files_pr_bad_ref(self):
    self.assertEqual(gee_status.get_added_jsonnet_files(), [])

  @mock.patch.dict(
      os.environ,
      {
          'GITHUB_ACTIONS': 'true',
          'GITHUB_EVENT_NAME': 'pull_request',
          'GITHUB_REF': 'refs/pull/123/merge',
          'GITHUB_ACTOR': 'some-user',
          'GITHUB_REPOSITORY': 'org/repo',
      },
      clear=True,
  )
  @mock.patch('subprocess.run')
  def test_added_files_pr_failure(self, mock_run):
    mock_run.return_value.returncode = 1
    self.assertEqual(gee_status.get_added_jsonnet_files(), [])

  def test_gee_status_bad_values(self):
    bad_val = 603
    self.assert_collection(
        {'gee:status': bad_val},
        "gee:status, if set, must be one of ['beta', 'deprecated',"
        " 'incomplete', 'ready']",
    )

  def test_gee_status_on_catalog(self):
    self.assert_catalog(
        {'gee:status': 'incomplete'},
        'Catalogs may not have a gee:status field',
    )

  def test_gee_status_valid(self):
    self.assert_collection({'gee:status': 'incomplete'})

  @mock.patch.object(gee_status, 'get_added_jsonnet_files')
  def test_new_dataset_ready(self, mock_get_files):
    # Dataset ID 'a/collection' corresponds to 'a_collection.jsonnet'
    # The code checks for '/a_collection.jsonnet' suffix
    mock_get_files.return_value = ['catalog/a_collection.jsonnet']

    self.assert_collection(
        {'gee:status': 'ready'},
        'For new datasets, set "gee:status" to "beta"',
        dataset_id='a/collection',
    )

  @mock.patch.object(gee_status, 'get_added_jsonnet_files')
  def test_new_dataset_beta(self, mock_get_files):
    mock_get_files.return_value = ['catalog/a_collection.jsonnet']

    self.assert_collection(
        {'gee:status': 'beta'},
        None,  # No issues expected
        dataset_id='a/collection',
    )

  @mock.patch.object(gee_status, 'get_added_jsonnet_files')
  def test_existing_dataset_ready(self, mock_get_files):
    mock_get_files.return_value = ['other/file.jsonnet']

    self.assert_collection(
        {'gee:status': 'ready'},
        None,  # No issues expected
        dataset_id='a/collection',
    )


if __name__ == '__main__':
  absltest.main()

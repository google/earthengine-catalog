"""Tests for gee:status."""

import json
import os
import tempfile
from unittest import mock

from absl.testing import absltest
from checker import test_utils
from checker.node import gee_status


class GeeIncompleteEntryTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_status.Check

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
    # TODO(simonf): add other valid statuses
    self.assert_collection({'gee:status': 'incomplete'})


class GeeStatusInPrTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = gee_status.Check

    self.tmpfile = tempfile.NamedTemporaryFile(mode='w', delete=False)
    self.addCleanup(os.unlink, self.tmpfile.name)
    pr_event = {'action': 'opened', 'pull_request': {}}
    json.dump(pr_event, self.tmpfile)
    self.tmpfile.close()

    # Patch the environment variables
    self.env_patcher = mock.patch.dict(
        os.environ,
        {'GITHUB_ACTIONS': 'true', 'GITHUB_EVENT_PATH': self.tmpfile.name},
    )
    self.env_patcher.start()
    self.addCleanup(self.env_patcher.stop)

  # TODO(simonf): actually check something beyond loading the file
  def test_check_pr_status(self):
    # This just checks we do not crash reading the PR status
    self.assert_collection({'gee:status': 'incomplete'})

  def test_read_bad_pr_file(self):
    with open(self.tmpfile.name, 'w') as fh:
      print('Not JSON', file=fh)

    # This just checks we do not crash reading a bad PR file
    self.assert_collection({'gee:status': 'incomplete'})


if __name__ == '__main__':
  absltest.main()

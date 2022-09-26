"""Tests for ee_stac_checker.

GOOGLE3 ONLY: This test is not for distribution.
"""

from absl import logging

from google3.third_party.earthengine_catalog.checker import ee_stac_check
from google3.testing.pybase import googletest


class EeStacCheckerTest(googletest.TestCase):

  def test_public_data_catalog(self):
    issues = []

    for issue in ee_stac_check.find_issues([]):
      logging.error('%s', issue)
      issues.append(issue)

    num_issues = len(issues)
    issues_str = '\n  '.join([str(issue) for issue in issues])
    self.assertEqual(0, num_issues, 'Issues:\n  ' + issues_str)


if __name__ == '__main__':
  googletest.main()

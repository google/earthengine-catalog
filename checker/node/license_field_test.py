"""Tests for license_field."""

from checker import test_utils
from checker.node import license_field
import unittest

LICENSE = license_field.LICENSE


class LicenseFieldTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = license_field.Check

  def test_valid(self):
    self.assert_collection({LICENSE: list(license_field.KNOWN_LICENSES)[0]})

  def test_catalog_cannot_have_license(self):
    self.assert_catalog(
        {LICENSE: 'a_license'}, 'Catalogs cannot have "license"')

  def test_missing(self):
    self.assert_collection({}, 'Collections must have "license"')

  def test_not_a_string(self):
    self.assert_collection({LICENSE: ['not a str']}, '"license" must be a str')

  def test_empty_string(self):
    self.assert_collection({LICENSE: ''}, '"license" cannot be an empty str')

  def test_invalid(self):
    invalid_license = 'invalid license'
    self.assert_collection(
        {LICENSE: invalid_license}, f'Unknown license: "{invalid_license}"')


if __name__ == '__main__':
  unittest.main()

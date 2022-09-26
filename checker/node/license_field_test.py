"""Tests for license_field."""

import pathlib

from google3.third_party.earthengine_catalog.checker import stac
from google3.third_party.earthengine_catalog.checker.node import license_field
from google3.testing.pybase import googletest

Check = license_field.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
LICENSE = license_field.LICENSE
NONE = stac.GeeType.NONE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')
NOT_A_STR = ['not a str']


class LicenseFieldTest(googletest.TestCase):

  def setUp(self):
    super().setUp()
    self.node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, {})

  def test_valid(self):
    self.node.stac = {LICENSE: list(license_field.KNOWN_LICENSES)[0]}
    issues = list(Check.run(self.node))
    self.assertEmpty(issues)

  def test_catalog_cannot_have_license(self):
    node = stac.Node(
        'a_catalog', FILE_PATH, CATALOG, NONE, {LICENSE: 'a_license'})
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalogs cannot have "license"')]
    self.assertEqual(expect, issues)

  def test_missing(self):
    self.node.stac = {}
    issues = list(Check.run(self.node))
    expect = [Check.new_issue(self.node, 'Collections must have "license"')]
    self.assertEqual(expect, issues)

  def test_not_a_string(self):
    self.node.stac = {LICENSE: NOT_A_STR}
    issues = list(Check.run(self.node))
    expect = [Check.new_issue(self.node, '"license" must be a str')]
    self.assertEqual(expect, issues)

  def test_invalid(self):
    invalid_license = 'invalid license'
    self.node.stac = {LICENSE: invalid_license}
    issues = list(Check.run(self.node))
    expect = [
        Check.new_issue(self.node, f'Unknown license: "{invalid_license}"')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  googletest.main()

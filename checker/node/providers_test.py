"""Tests for providers."""

import pathlib

from checker import stac
from checker.node import providers
import unittest

Check = providers.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE

CATALOG_BASE_URL = 'https://developers.google.com/earth-engine/datasets/catalog'
CATALOG_URL = CATALOG_BASE_URL + '/A_B'
ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')
GEE = 'Google Earth Engine'


def provider(name='A name', roles=None, url='https://example.com'):
  if not roles:
    roles = list(['licensor', 'producer'])
  return {'name': name, 'roles': roles, 'url': url}


def google_host():
  roles = list(['host'])
  return {
      'name': GEE,
      'roles': roles,
      'url': CATALOG_URL}


class ProvidersTest(unittest.TestCase):

  def test_valid_most_common(self):
    stac_data = {'providers': [
        provider(roles=['licensor', 'producer']), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_valid_provider_with_all(self):
    stac_data = {'providers': [
        provider(roles=['licensor', 'processor', 'producer']), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_bad_catalog_with_provider(self):
    stac_data = {'providers': [provider(), google_host()]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Catalogs cannot have "providers"')]
    self.assertEqual(expect, issues)

  def test_bad_missing_provider(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Collections must have "providers"')]
    self.assertEqual(expect, issues)

  def test_bad_not_a_list(self):
    stac_data = {'providers': 'Not a list'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, '"providers" must be a list')]
    self.assertEqual(expect, issues)

  def test_bad_only_host(self):
    stac_data = {'providers': [google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, '"providers" must have at least 2 entries')]
    self.assertEqual(expect, issues)

  def test_bad_last_role_not_host(self):
    stac_data = {'providers': [provider(), provider(GEE)]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'The last provider must be a "host"')]
    self.assertEqual(expect, issues)

  def test_bad_last_name_not_gee(self):
    stac_data = {'providers': [
        provider(), provider(roles=['host'], url=CATALOG_URL)]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'The last provider must be "Google Earth Engine"')]
    self.assertEqual(expect, issues)

  def test_bad_provider_not_a_dict(self):
    stac_data = {'providers': ['not a dict', google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'A provider must be a dict')]
    self.assertEqual(expect, issues)

  def test_bad_name_not_a_str(self):
    stac_data = {'providers': [provider(123), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, '"name" must be a str')]
    self.assertEqual(expect, issues)

  def test_bad_missing_name(self):
    bad_provider = {'roles': ['licensor', 'producer'], 'url': CATALOG_URL}
    stac_data = {'providers': [bad_provider, google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'A provider must have a "name"')]
    self.assertEqual(expect, issues)

  def test_bad_name_too_short(self):
    stac_data = {'providers': [provider('A'), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Invalid name: "A"')]
    self.assertEqual(expect, issues)

  def test_bad_name_too_long(self):
    name = 'A' * 191
    stac_data = {'providers': [provider(name), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, f'Invalid name: "{name}"')]
    self.assertEqual(expect, issues)

  def test_bad_name_does_not_start_with_upper_case(self):
    stac_data = {'providers': [provider('banana'), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Invalid name: "banana"')]
    self.assertEqual(expect, issues)

  def test_bad_name_has_invalid_character(self):
    name = 'Dollar sign not allowed $'
    stac_data = {'providers': [provider(name), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, f'Invalid name: "{name}"')]
    self.assertEqual(expect, issues)

  def test_bad_missing_roles(self):
    bad_provider = {'name': 'A name', 'url': CATALOG_URL}
    stac_data = {'providers': [bad_provider, google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'A provider must have a "roles" list')]
    self.assertEqual(expect, issues)

  def test_bad_roles_not_a_list(self):
    stac_data = {'providers': [provider(roles='not a list'), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'roles must be a list')]
    self.assertEqual(expect, issues)

  def test_bad_roles_empty_list(self):
    bad_provider = {'name': 'A name', 'roles': [], 'url': CATALOG_URL}
    stac_data = {'providers': [bad_provider, google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'roles list must have at least 1 entry')]
    self.assertEqual(expect, issues)

  def test_bad_duplicate_roles(self):
    stac_data = {'providers': [
        provider(roles=['licensor', 'licensor']), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'roles list must not have duplicates')]
    self.assertEqual(expect, issues)

  def test_bad_roles_missing_licensor(self):
    stac_data = {'providers': [
        provider(roles=['producer']), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Missing the required role(s): licensor')]
    self.assertEqual(expect, issues)

  def test_bad_roles_missing_producer(self):
    stac_data = {'providers': [
        provider(roles=['licensor']), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Missing the required role(s): producer')]
    self.assertEqual(expect, issues)

  def test_bad_unknown_role(self):
    stac_data = {'providers': [
        provider(roles=['bogus', 'licensor']), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Unknown role: "bogus"')]
    self.assertEqual(expect, issues)

  def test_bad_unsorted_role(self):
    stac_data = {'providers': [
        provider(roles=['processor', 'licensor']), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Roles must be sorted')]
    self.assertEqual(expect, issues)

  def test_bad_missing_url(self):
    bad_provider = {'name': 'A name', 'roles': ['licensor', 'producer']}
    stac_data = {'providers': [bad_provider, google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'A provider must have a "url"')]
    self.assertEqual(expect, issues)

  def test_bad_url_not_a_str(self):
    stac_data = {'providers': [provider(url=1337), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'url must be a str')]
    self.assertEqual(expect, issues)

  def test_bad_url_not_http(self):
    stac_data = {'providers': [
        provider(url='gopher://example.com'), google_host()]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'url must start with https or http')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

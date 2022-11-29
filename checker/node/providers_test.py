"""Tests for providers."""

from checker import stac
from checker import test_utils
from checker.node import providers
import unittest

CATALOG_BASE_URL = 'https://developers.google.com/earth-engine/datasets/catalog'
CATALOG_URL = CATALOG_BASE_URL + '/A_B'
GEE = 'Google Earth Engine'


def provider(name='A name', roles=None, url='https://example.com'):
  if not roles:
    roles = list(['licensor', 'producer'])
  return {'name': name, 'roles': roles, 'url': url}


def google_host():
  roles = list(['host'])
  return {'name': GEE, 'roles': roles, 'url': CATALOG_URL}


class ProvidersTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = providers.Check

  def test_valid_most_common(self):
    self.assert_collection(
        {'providers': [
            provider(roles=['licensor', 'producer']), google_host()]})

  def test_valid_provider_with_all(self):
    self.assert_collection(
        {'providers': [
            provider(roles=['licensor', 'processor', 'producer']),
            google_host()]})

  def test_bad_catalog_with_provider(self):
    self.assert_catalog(
        {'providers': [provider(), google_host()]},
        'Catalogs cannot have "providers"')

  def test_bad_missing_provider(self):
    self.assert_collection(
        {}, 'Collections must have "providers"')

  def test_bad_not_a_list(self):
    self.assert_collection(
        {'providers': 'Not a list'},
        '"providers" must be a list')

  def test_bad_only_host(self):
    self.assert_collection(
        {'providers': [google_host()]},
        '"providers" must have at least 2 entries')

  def test_bad_last_role_not_host(self):
    self.assert_collection(
        {'providers': [provider(), provider(GEE)]},
        'The last provider must be a "host"')

  def test_bad_last_name_not_gee(self):
    self.assert_collection(
        {'providers': [provider(), provider(roles=['host'], url=CATALOG_URL)]},
        'The last provider must be "Google Earth Engine"')

  def test_bad_provider_not_a_dict(self):
    self.assert_collection(
        {'providers': ['not a dict', google_host()]},
        'A provider must be a dict')

  def test_bad_name_not_a_str(self):
    self.assert_collection(
        {'providers': [provider(123), google_host()]},
        '"name" must be a str')

  def test_bad_missing_name(self):
    bad_provider = {'roles': ['licensor', 'producer'], 'url': CATALOG_URL}
    self.assert_collection(
        {'providers': [bad_provider, google_host()]},
        'A provider must have a "name"')

  def test_bad_name_too_short(self):
    self.assert_collection(
        {'providers': [provider('A'), google_host()]},
        'Invalid name: "A"')

  def test_bad_name_too_long(self):
    name = 'A' * 191
    self.assert_collection(
        {'providers': [provider(name), google_host()]},
        f'Invalid name: "{name}"')

  def test_bad_name_does_not_start_with_upper_case(self):
    self.assert_collection(
        {'providers': [provider('banana'), google_host()]},
        'Invalid name: "banana"')

  def test_bad_name_has_invalid_character(self):
    name = 'Dollar sign not allowed $'
    self.assert_collection(
        {'providers': [provider(name), google_host()]},
        f'Invalid name: "{name}"')

  def test_bad_missing_roles(self):
    bad_provider = {'name': 'A name', 'url': CATALOG_URL}
    self.assert_collection(
        {'providers': [bad_provider, google_host()]},
        'A provider must have a "roles" list')

  def test_bad_roles_not_a_list(self):
    self.assert_collection(
        {'providers': [provider(roles='not a list'), google_host()]},
        'roles must be a list')

  def test_bad_roles_empty_list(self):
    bad_provider = {'name': 'A name', 'roles': [], 'url': CATALOG_URL}
    self.assert_collection(
        {'providers': [bad_provider, google_host()]},
        'roles list must have at least 1 entry')

  def test_bad_duplicate_roles(self):
    self.assert_collection(
        {'providers': [
            provider(roles=['licensor', 'licensor']), google_host()]},
        'roles list must not have duplicates')

  def test_bad_roles_missing_licensor(self):
    self.assert_collection(
        {'providers': [
            provider(roles=['producer']), google_host()]},
        'Missing the required role(s): licensor')

  def test_bad_roles_missing_producer(self):
    self.assert_collection(
        {'providers': [
            provider(roles=['licensor']), google_host()]},
        'Missing the required role(s): producer')

  def test_bad_unknown_role(self):
    self.assert_collection(
        {'providers': [
            provider(roles=['bogus', 'licensor']), google_host()]},
        'Unknown role: "bogus"')

  def test_bad_unsorted_role(self):
    self.assert_collection(
        {'providers': [
            provider(roles=['processor', 'licensor']), google_host()]},
        'Roles must be sorted')

  def test_bad_missing_url(self):
    bad_provider = {'name': 'A name', 'roles': ['licensor', 'producer']}
    self.assert_collection(
        {'providers': [bad_provider, google_host()]},
        'A provider must have a "url"')

  def test_bad_url_not_a_str(self):
    self.assert_collection(
        {'providers': [provider(url=1337), google_host()]},
        'url must be a str')

  def test_bad_url_not_http(self):
    self.assert_collection(
        {'providers': [
            provider(url='gopher://example.com'), google_host()]},
        'url must start with https or http')


if __name__ == '__main__':
  unittest.main()

"""Tests for sci_extension."""

import pathlib

from checker import stac
from checker.node import sci_extension
import unittest

Check = sci_extension.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
IMAGE_COLLECTION = stac.GeeType.IMAGE_COLLECTION
NONE = stac.GeeType.NONE

ID = 'a/collection'
ID_FOR_EXTRA_DOI = 'CSIRO/SLGA'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')

EXTENSION_URL = (
    'https://stac-extensions.github.io/scientific/v1.0.0/schema.json')


class ValidSciExtTest(unittest.TestCase):

  def test_catalog_with_nothing(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_nothing(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_everything(self):
    stac_data = {
        'stac_extensions': [EXTENSION_URL],
        'sci:citation': 'A citation',
        'sci:doi': '10.5067/an/example',
        'sci:publications': [{'citation': 'B cite', 'doi': 'a/doi/str'}],
        'gee:extra_dois': ['10.4225/example/1', '10.4225/example/2'],
    }
    node = stac.Node(ID_FOR_EXTRA_DOI, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_only_gee_extra_dois(self):
    stac_data = {'gee:extra_dois': ['a', 'b']}
    node = stac.Node(ID_FOR_EXTRA_DOI, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))


class ErrorSciExtTest(unittest.TestCase):

  def test_catalog_with_sci_ext(self):
    stac_data = {'stac_extensions': [EXTENSION_URL]}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Catalog must not have the scientific extension')]
    self.assertEqual(expect, issues)

  def test_extension_url_not_str(self):
    stac_data = {'stac_extensions': [414]}
    node = stac.Node(ID_FOR_EXTRA_DOI, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Extensions must be a url str')]
    self.assertEqual(expect, issues)

  def test_extension_version(self):
    stac_data = {'stac_extensions': [
        'https://stac-extensions.github.io/scientific/v0.9.1/schema.json']}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Extension\'s version must be: "1.0.0"')]
    self.assertEqual(expect, issues)

  def test_missing_extension_url_doi(self):
    stac_data = {'sci:doi': '10.5067/an/example'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'scientific extension not found, but has "sci:doi"')]
    self.assertEqual(expect, issues)

  def test_missing_extension_url_citation(self):
    stac_data = {'sci:citation': 'A citation'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'scientific extension not found, but has "sci:citation"')]
    self.assertEqual(expect, issues)

  def test_extension_url_but_missing_fields(self):
    stac_data = {'stac_extensions': [EXTENSION_URL]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'scientific extension, but no sci fields found')]
    self.assertEqual(expect, issues)

  def test_missing_extension_url_publications(self):
    stac_data = {'sci:publications': []}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'scientific extension not found, but has "sci:publications"')]
    self.assertEqual(expect, issues)

  def test_extra_doi_not_list(self):
    stac_data = {'gee:extra_dois': 'not a list'}
    node = stac.Node(ID_FOR_EXTRA_DOI, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gee:extra_dois must be a list')]
    self.assertEqual(expect, issues)

  def test_extra_doi_empty_list(self):
    stac_data = {'gee:extra_dois': []}
    node = stac.Node(ID_FOR_EXTRA_DOI, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Empty gee:extra_dois not allowed')]
    self.assertEqual(expect, issues)

  def test_extra_doi_not_str(self):
    stac_data = {'gee:extra_dois': [123]}
    node = stac.Node(ID_FOR_EXTRA_DOI, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gee:extra_dois doi must be a str')]
    self.assertEqual(expect, issues)

  def test_extra_doi_not_in_new_ids(self):
    stac_data = {'gee:extra_dois': ['10.5065/D6513W89']}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'No new uses of gee:extra_dois allowed')]
    self.assertEqual(expect, issues)

  def test_extra_doi_starts_with_ftp(self):
    stac_data = {'gee:extra_dois': ['ftps://example.com']}
    node = stac.Node(ID_FOR_EXTRA_DOI, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:extra_dois doi not valid: ftps://example.com')]
    self.assertEqual(expect, issues)

  def test_extra_doi_starts_with_http(self):
    stac_data = {'gee:extra_dois': ['https://example.com']}
    node = stac.Node(ID_FOR_EXTRA_DOI, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:extra_dois doi not valid: https://example.com')]
    self.assertEqual(expect, issues)

  def test_extra_doi_ends_with_html(self):
    stac_data = {'gee:extra_dois': ['example.com/thing.html']}
    node = stac.Node(ID_FOR_EXTRA_DOI, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:extra_dois doi not valid: example.com/thing.html')]
    self.assertEqual(expect, issues)

  def test_extra_doi_ends_with_pdf(self):
    stac_data = {'gee:extra_dois': ['example.com/thing.pdf']}
    node = stac.Node(ID_FOR_EXTRA_DOI, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gee:extra_dois doi not valid: example.com/thing.pdf')]
    self.assertEqual(expect, issues)

  def test_extra_doi_duplicates(self):
    stac_data = {'gee:extra_dois': ['a', 'a']}
    node = stac.Node(ID_FOR_EXTRA_DOI, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gee:extra_dois has duplicates')]
    self.assertEqual(expect, issues)

  def test_extra_doi_unsorted(self):
    stac_data = {'gee:extra_dois': ['b', 'a']}
    node = stac.Node(ID_FOR_EXTRA_DOI, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gee:extra_dois not sorted')]
    self.assertEqual(expect, issues)

  def test_doi_not_str(self):
    stac_data = {'stac_extensions': [EXTENSION_URL], 'sci:doi': 456}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sci:doi must be a str')]
    self.assertEqual(expect, issues)

  def test_doi_starts_with_ftp(self):
    stac_data = {
        'stac_extensions': [EXTENSION_URL], 'sci:doi': 'ftp://example.com'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sci:doi not valid: ftp://example.com')]
    self.assertEqual(expect, issues)

  def test_doi_starts_with_http(self):
    stac_data = {
        'stac_extensions': [EXTENSION_URL], 'sci:doi': 'http://example.com'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sci:doi not valid: http://example.com')]
    self.assertEqual(expect, issues)

  def test_doi_ends_with_html(self):
    stac_data = {
        'stac_extensions': [EXTENSION_URL], 'sci:doi': 'example.com/an.html'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sci:doi not valid: example.com/an.html')]
    self.assertEqual(expect, issues)

  def test_publications_not_list(self):
    stac_data = {
        'stac_extensions': [EXTENSION_URL], 'sci:publications': 'not a list'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sci:publications must be a list')]
    self.assertEqual(expect, issues)

  def test_publications_empty_list(self):
    stac_data = {
        'stac_extensions': [EXTENSION_URL], 'sci:publications': []}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sci:publications must have at least one entry')]
    self.assertEqual(expect, issues)

  def test_publications_entry_not_dict(self):
    stac_data = {
        'stac_extensions': [EXTENSION_URL], 'sci:publications': ['not a dict']}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sci:publications entry must be a dict')]
    self.assertEqual(expect, issues)

  def test_publications_doi_not_str(self):
    stac_data = {
        'stac_extensions': [EXTENSION_URL],
        'sci:publications': [{'citation': 'A cite', 'doi': 1}]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'sci:publications entry doi must be a str')]
    self.assertEqual(expect, issues)

  def test_publications_bad_doi(self):
    stac_data = {
        'stac_extensions': [EXTENSION_URL],
        'sci:publications': [{'citation': 'A cite', 'doi': 'not_a_doi.html'}]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sci:publications entry doi not valid: not_a_doi.html')]
    self.assertEqual(expect, issues)

  def test_publications_bad_citation_not_str(self):
    stac_data = {
        'stac_extensions': [EXTENSION_URL],
        'sci:publications': [{'citation': 2}]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sci:publications entry citation must be a str')]
    self.assertEqual(expect, issues)

  def test_publications_missing_citation(self):
    stac_data = {
        'stac_extensions': [EXTENSION_URL],
        'sci:publications': [{'doi': '10.5281/zenodo.6551240'}]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'sci:publications entry must have a citation')]
    self.assertEqual(expect, issues)

  def test_publications_bad_citation_too_short(self):
    stac_data = {
        'stac_extensions': [EXTENSION_URL],
        'sci:publications': [{'citation': 'shrt'}]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'citation too short: 4 - "shrt"')]
    self.assertEqual(expect, issues)

  def test_publications_bad_citation_too_long(self):
    cite = 'c' * 601
    stac_data = {
        'stac_extensions': [EXTENSION_URL],
        'sci:publications': [{'citation': cite}]}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, f'citation too long: 601 - "{cite[:50]}..."')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

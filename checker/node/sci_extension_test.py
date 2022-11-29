"""Tests for sci_extension."""

from checker import test_utils
from checker.node import sci_extension
import unittest

ID_FOR_EXTRA_DOI = 'CSIRO/SLGA'
EXTENSION_URL = (
    'https://stac-extensions.github.io/scientific/v1.0.0/schema.json')


class ValidSciExtTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = sci_extension.Check

  def test_catalog_with_nothing(self):
    self.assert_catalog({})

  def test_nothing(self):
    self.assert_collection({})

  def test_everything(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL],
         'sci:citation': 'A citation',
         'sci:doi': '10.123456/an/example',
         'sci:publications': [{
             'citation': 'B cite', 'doi': '10.01234/doi/str'}],
         'gee:extra_dois': ['10.4225/example/1', '10.4225/example/2']},
        dataset_id=ID_FOR_EXTRA_DOI)

  def test_only_gee_extra_dois(self):
    self.assert_collection(
        {'gee:extra_dois': ['10.4225/example/1', '10.4225/example/2']},
        dataset_id=ID_FOR_EXTRA_DOI)


class ErrorSciExtTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = sci_extension.Check

  def test_catalog_with_sci_ext(self):
    self.assert_catalog(
        {'stac_extensions': [EXTENSION_URL]},
        'Catalog must not have the scientific extension')

  def test_extension_url_not_str(self):
    self.assert_collection(
        {'stac_extensions': [414]},
        'Extensions must be a url str',
        dataset_id=ID_FOR_EXTRA_DOI)

  def test_extension_version(self):
    self.assert_collection(
        {'stac_extensions': [
            'https://stac-extensions.github.io/scientific/v0.9.1/schema.json']},
        'Extension\'s version must be: "1.0.0"')

  def test_missing_extension_url_doi(self):
    self.assert_collection(
        {'sci:doi': '10.5067/an/example'},
        'scientific extension not found, but has "sci:doi"')

  def test_missing_extension_url_citation(self):
    self.assert_collection(
        {'sci:citation': 'A citation'},
        'scientific extension not found, but has "sci:citation"')

  def test_extension_url_but_missing_fields(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL]},
        'scientific extension, but no sci fields found')

  def test_missing_extension_url_publications(self):
    self.assert_collection(
        {'sci:publications': []},
        'scientific extension not found, but has "sci:publications"')

  def test_extra_doi_not_list(self):
    self.assert_collection(
        {'gee:extra_dois': 'not a list'},
        'gee:extra_dois must be a list',
        dataset_id=ID_FOR_EXTRA_DOI)

  def test_extra_doi_empty_list(self):
    self.assert_collection(
        {'gee:extra_dois': []},
        'Empty gee:extra_dois not allowed',
        dataset_id=ID_FOR_EXTRA_DOI)

  def test_extra_doi_not_str(self):
    self.assert_collection(
        {'gee:extra_dois': [123]},
        'gee:extra_dois doi must be a str',
        dataset_id=ID_FOR_EXTRA_DOI)

  def test_extra_doi_not_in_new_ids(self):
    self.assert_collection(
        {'gee:extra_dois': ['10.5065/D6513W89']},
        'No new uses of gee:extra_dois allowed')

  def test_extra_doi_starts_with_ftp(self):
    self.assert_collection(
        {'gee:extra_dois': ['ftps://example.com']},
        'gee:extra_dois doi not valid: ftps://example.com',
        dataset_id=ID_FOR_EXTRA_DOI)

  def test_extra_doi_starts_with_http(self):
    self.assert_collection(
        {'gee:extra_dois': ['https://example.com']},
        'gee:extra_dois doi not valid: https://example.com',
        dataset_id=ID_FOR_EXTRA_DOI)

  def test_extra_doi_ends_with_html(self):
    self.assert_collection(
        {'gee:extra_dois': ['example.com/thing.html']},
        'gee:extra_dois doi not valid: example.com/thing.html',
        dataset_id=ID_FOR_EXTRA_DOI)

  def test_extra_doi_ends_with_pdf(self):
    self.assert_collection(
        {'gee:extra_dois': ['example.com/thing.pdf']},
        'gee:extra_dois doi not valid: example.com/thing.pdf',
        dataset_id=ID_FOR_EXTRA_DOI)

  def test_extra_doi_duplicates(self):
    self.assert_collection(
        {'gee:extra_dois': ['10.0000/a', '10.0000/a']},
        'gee:extra_dois has duplicates',
        dataset_id=ID_FOR_EXTRA_DOI)

  def test_extra_doi_unsorted(self):
    self.assert_collection(
        {'gee:extra_dois': ['10.1016/b', '10.1016/a']},
        'gee:extra_dois not sorted',
        dataset_id=ID_FOR_EXTRA_DOI)

  def test_doi_not_str(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL], 'sci:doi': 456},
        'sci:doi must be a str')

  def test_doi_starts_with_ftp(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL], 'sci:doi': 'ftp://example.com'},
        'sci:doi not valid: ftp://example.com')

  def test_doi_starts_with_http(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL], 'sci:doi': 'http://example.com'},
        'sci:doi not valid: http://example.com')

  def test_doi_ends_with_html(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL], 'sci:doi': 'example.com/an.html'},
        'sci:doi not valid: example.com/an.html')

  def test_doi_directory_code(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL],
         'sci:doi': '11.4225/directory_not_10'},
        'sci:doi not valid: 11.4225/directory_not_10')

  def test_doi_short_registrant(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL], 'sci:doi': '10.34/rh7v-hg80l'},
        'sci:doi not valid: 10.34/rh7v-hg80l')

  def test_publications_not_list(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL], 'sci:publications': 'not a list'},
        'sci:publications must be a list')

  def test_publications_empty_list(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL], 'sci:publications': []},
        'sci:publications must have at least one entry')

  def test_publications_entry_not_dict(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL],
         'sci:publications': ['not a dict']},
        'sci:publications entry must be a dict')

  def test_publications_doi_not_str(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL],
         'sci:publications': [{'citation': 'A cite', 'doi': 1}]},
        'sci:publications entry doi must be a str')

  def test_publications_bad_doi(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL],
         'sci:publications': [{'citation': 'A cite', 'doi': 'not_a_doi.html'}]},
        'sci:publications entry doi not valid: not_a_doi.html')

  def test_publications_bad_citation_not_str(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL],
         'sci:publications': [{'citation': 2}]},
        'sci:publications entry citation must be a str')

  def test_publications_missing_citation(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL],
         'sci:publications': [{'doi': '10.5281/zenodo.6551240'}]},
        'sci:publications entry must have a citation')

  def test_publications_bad_citation_too_short(self):
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL],
         'sci:publications': [{'citation': 'shrt'}]},
        'citation too short: 4 - "shrt"')

  def test_publications_bad_citation_too_long(self):
    cite = 'c' * 601
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL],
         'sci:publications': [{'citation': cite}]},
        f'citation too long: 601 - "{cite[:50]}..."')


if __name__ == '__main__':
  unittest.main()

"""Tests for sci_extension."""

from checker import test_utils
from checker.node import sci_extension
from absl.testing import absltest

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
        })


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
        {'stac_extensions': [414]}, 'Extensions must be a url str')

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
    cite = 'c' * 2001
    self.assert_collection(
        {'stac_extensions': [EXTENSION_URL],
         'sci:publications': [{'citation': cite}]},
        f'citation too long: 2001 - "{cite[:50]}..."')


if __name__ == '__main__':
  absltest.main()

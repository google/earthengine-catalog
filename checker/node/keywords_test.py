"""Tests for keywords."""

from checker import test_utils
from checker.node import keywords
from absl.testing import absltest

Check = keywords.Check
KEYWORDS = keywords.KEYWORDS


class KeywordsTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = Check

  def test_valid(self):
    self.assert_collection({KEYWORDS: ['ab', 'c_d', 'e9']})

  def test_catalog_cannot_have_keywords(self):
    self.assert_catalog({KEYWORDS: ['ab']}, 'Catalogs cannot have "keywords"')

  def test_collection_must_have_keywords(self):
    self.assert_collection({}, 'Collections must have "keywords"')

  def test_keywords_is_list(self):
    self.assert_collection(
        {KEYWORDS: 'not a list'}, '"keywords" must be a list')

  def test_at_least_one_keyword(self):
    self.assert_collection(
        {KEYWORDS: []}, '"keywords" must have at least one keyword')

  def test_keywords_must_be_str(self):
    self.assert_collection({KEYWORDS: [999]}, 'keyword must be a string: "999"')

  def test_keyword_not_valid(self):
    stac_data = {KEYWORDS: [
        '1b',  # Must start with a letter
        'Ab',  # Must be lower case
        'a',  # Too short
        'cD',  # Must be lower case
        'e-f',  # No dashes
        'g h',  # No spaces
    ]}
    issues = [
        f'keyword must contain only lowercase letters, digits, and '
        f'underscores and be at most 49 characters long: "{keyword}"'
        for keyword in stac_data[KEYWORDS]]
    self.assert_collection(stac_data, issues)

  def test_duplicate(self):
    self.assert_collection({KEYWORDS: ['aa', 'aa']}, 'duplicate keyword found')


if __name__ == '__main__':
  absltest.main()

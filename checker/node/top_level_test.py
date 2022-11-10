"""Tests for top_level."""

import pathlib

from checker import stac
from checker.node import top_level
import unittest

Check = top_level.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class TopLevelTest(unittest.TestCase):

  def test_all_catalog_fields(self):
    fields = [
        'description', 'id', 'links', 'stac_version',
        'title', 'type'
    ]
    stac_data = {x: None for x in fields}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_bad_catalog_field(self):
    stac_data = {'bogus': None}
    node = stac.Node(ID, FILE_PATH, CATALOG, NONE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Invalid top-level catalog field: bogus')]
    self.assertEqual(expect, issues)

  def test_all_collections_fields(self):
    fields = [
        'deprecated', 'description', 'extent', 'gee:extra_dois', 'gee:interval',
        'gee:is_derived', 'gee:min_zoom_level', 'gee:provider_ids',
        'gee:skip_featureview_generation', 'gee:skip_indexing',
        'gee:terms_of_use', 'gee:type', 'gee:unusual_terms_of_use',
        'gee:user_owned', 'gee:user_uploaded', 'id', 'keywords', 'license',
        'links', 'providers', 'sci:citation', 'sci:doi', 'sci:publications',
        'stac_extensions', 'stac_version', 'summaries', 'title', 'type',
        'version'
    ]
    stac_data = {x: None for x in fields}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_bad_collection_field(self):
    stac_data = {'bogus_collection_field': None}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'Invalid top-level collection field: bogus_collection_field')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()

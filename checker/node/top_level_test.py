"""Tests for top_level."""

from checker import test_utils
from checker.node import top_level
from absl.testing import absltest


class TopLevelTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = top_level.Check

  def test_all_catalog_fields(self):
    fields = ['description', 'id', 'links', 'stac_version', 'title', 'type']
    self.assert_catalog({x: None for x in fields})

  def test_bad_catalog_field(self):
    self.assert_catalog(
        {'bogus': None}, 'Invalid top-level catalog field: bogus')

  def test_all_collections_fields(self):
    fields = [
        'description',
        'extent',
        'gee:interval',
        'gee:is_derived',
        'gee:min_zoom_level',
        'gee:provider_ids',
        'gee:skip_featureview_generation',
        'gee:status',
        'gee:terms_of_use',
        'gee:type',
        'gee:unusual_terms_of_use',
        'gee:user_owned',
        'gee:user_uploaded',
        'id',
        'keywords',
        'license',
        'links',
        'providers',
        'sci:citation',
        'sci:doi',
        'sci:publications',
        'stac_extensions',
        'stac_version',
        'summaries',
        'title',
        'type',
        'version',
    ]
    self.assert_collection({x: None for x in fields})

  def test_bad_collection_field(self):
    self.assert_collection(
        {'bogus_collection_field': None},
        'Invalid top-level collection field: bogus_collection_field')


if __name__ == '__main__':
  absltest.main()

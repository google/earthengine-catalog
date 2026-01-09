"""Tests for stac_lib.py."""

import copy
import pathlib
import unittest

from absl.testing import absltest
import iso8601

from stac import bboxes
from stac import errors
from stac import stac_lib as stac


LICENSE_LINK: str = 'https://developers.google.com/license'


STAC_FILENAME = pathlib.Path('WHBU_NBAR_1YEAR.json')

# LINT.IfChange
VALID_STAC = {
    'id': 'my_id',
    'version': '1',
    'title': 'A Title',
    'description': 'The description',
    'gee:type': 'image_collection',
    'gee:terms_of_use': 'The terms',
    'gee:user_uploaded': True,
    'license': 'CC-BY-4.0',
    'gee:unusual_terms_of_use': True,
    'keywords': ['tag1', 'tag2'],
    'links': [
        {'href': 'https://example.com/a_sample.png', 'rel': 'preview'},
        {'href': 'https://example.com/license', 'rel': 'license'},
        {'href': 'https://doi.org/a/b', 'rel': 'cite-as'},
        {'href': 'https://doi.org/a/c', 'rel': 'cite-as'},
        {'href': 'https://example.com/foo.png', 'rel': 'preview'},
        {'href': 'https://example.com/a.tar.xz', 'rel': 'source'},
        {'href': 'https://example.com/b.zip', 'rel': 'source'},
    ],
    'providers': [
        {'name': 'provider 1', 'roles': ['producer'], 'url': 'url 1'},
        {'name': 'processor', 'roles': ['processor'], 'url': 'url 2'},
        {'name': 'Google Earth Engine', 'roles': ['host']},
        {'name': 'provider 3', 'roles': ['licensor'], 'url': 'url 3'},
    ],
    'gee:provider_ids': ['p1', 'p2'],
    'sci:citation': 'citation 1',
    'sci:publications': [
        {'citation': 'citation 2'},
        {'citation': 'citation 3'},
    ],
    'extent': {
        'spatial': {'bbox': [[-1, -2, 3, 4]]},
        'temporal': {
            'interval': [['2006-01-01T00:00:00Z', '3006-01-01T00:00:00Z']]
        },
    },
    'summaries': {
        'gee:visualizations': [{
            'display_name': 'a name',
            'lookat': {'lat': 1, 'lon': 2, 'zoom': 3},
        }],
        'platform': ['p1', 'p2'],
        'instruments': ['i1', 'i2'],
    },
}
# LINT.ThenChange(//depot/google3/geo/gestalt/data/catalog/stac_test.py)


def _valid_stac():
  return copy.deepcopy(VALID_STAC)


class CollectionTest(absltest.TestCase):

  def test_get_attribute(self):
    collection_id = 'a/b/c'
    stac_json = _valid_stac()
    stac_json.update({'id': collection_id})
    collection = stac.Collection(stac_json)
    self.assertEqual(collection_id, collection['id'])

    with self.assertRaises(KeyError):
      collection['does not exist']  # pylint: disable=pointless-statement

  def test_get_title(self):
    stac_json = _valid_stac()
    collection = stac.Collection(stac_json)
    self.assertEqual('A Title', collection.title())

  def test_get_terms_of_use(self):
    stac_json = _valid_stac()
    collection = stac.Collection(stac_json)
    self.assertEqual('The terms', collection.terms_of_use())

  def test_no_terms_of_use(self):
    stac_json = _valid_stac()
    del stac_json['gee:terms_of_use']
    collection = stac.Collection(stac_json)
    self.assertEmpty(collection.terms_of_use())

  def test_bbox(self):
    stac_json = _valid_stac()
    stac_json['extent']['spatial'].update({'bbox': [[-1, -2, 3, 4]]})
    collection = stac.Collection(stac_json)
    bbox = collection.bbox()
    expect = bboxes.BBox(west=-1, south=-2, east=3, north=4)
    self.assertEqual(expect, bbox)
    self.assertFalse(bbox.is_global())

  def test_bbox_global(self):
    stac_json = _valid_stac()
    stac_json['extent']['spatial'].update({'bbox': [[-180, -90, 180, 90]]})
    collection = stac.Collection(stac_json)
    bbox = collection.bbox()
    expect = bboxes.BBox(west=-180, south=-90, east=180, north=90)
    self.assertEqual(expect, bbox)
    self.assertTrue(bbox.is_global())

  def test_temporal_no_start(self):
    start = None
    end = '9999-02-03T04:05:06Z'
    stac_json = _valid_stac()
    stac_json['extent']['temporal'].update({'interval': [[start, end]]})
    print(stac_json)
    with self.assertRaisesRegex(
        ValueError, 'Expected a non-empty temporal interval start'
    ):
      collection = stac.Collection(stac_json)
      collection.datetime_interval_list()

  def test_temporal_no_end_in_sight(self):
    start = '2006-01-01T00:00:00Z'
    end = None
    stac_json = _valid_stac()
    stac_json['extent']['temporal'].update({'interval': [[start, end]]})
    collection = stac.Collection(stac_json)
    self.assertEqual(iso8601.parse_date(start), collection.start())
    self.assertIsNone(collection.end())

  def test_get_catalog_url_empty(self):
    stac_json = _valid_stac()
    collection = stac.Collection(stac_json)
    self.assertEqual(collection.catalog_url(), '')

  def test_get_catalog_url(self):
    stac_json = _valid_stac()

    # Add a catalog link to the STAC.
    expected_url = (
        'https://developers.google.com/earth-engine/datasets/catalog/foo'
    )
    stac_json['links'].append({'href': expected_url, 'rel': 'catalog'})
    collection = stac.Collection(stac_json)
    self.assertEqual(collection.catalog_url(), expected_url)

  def test_get_catalog_url_without_catalog_ref(self):
    stac_json = _valid_stac()
    original_url = 'https://developers.google.com/earth-engine/datasets/catalog/foo#ignore_this'
    expected_url = (
        'https://developers.google.com/earth-engine/datasets/catalog/foo'
    )
    stac_json['links'].append({'href': original_url, 'rel': 'random_rel'})
    collection = stac.Collection(stac_json)
    self.assertEqual(collection.catalog_url(), expected_url)

  def test_link_from_stac(self):
    result = stac.Link.from_stac({'rel': 'child'})
    expect = stac.Link(stac.Rel.CHILD)
    self.assertEqual(expect, result)

  def test_link_from_stac_versions(self):
    self.assertEqual(
        stac.Link(stac.Rel.LATEST),
        stac.Link.from_stac({'rel': 'latest-version'}),
    )
    self.assertEqual(
        stac.Link(stac.Rel.PREDECESSOR),
        stac.Link.from_stac({'rel': 'predecessor-version'}),
    )
    self.assertEqual(
        stac.Link(stac.Rel.SUCCESSOR),
        stac.Link.from_stac({'rel': 'successor-version'}),
    )

  def test_link_from_stac_full(self):
    href = 'an href'
    code = 'a code'
    media_type = 'a type'
    title = 'A Title'
    result = stac.Link.from_stac({
        'rel': 'child',
        'href': href,
        'code': code,
        'type': media_type,
        'title': title,
    })
    expect = stac.Link(stac.Rel.CHILD, href, code, media_type, title)
    self.assertEqual(expect, result)

  def test_get_links(self):
    image_url = 'https://example.com/a_sample.png'

    code = 'JavaScript'
    code_url = 'https://example.com/scripts/A_B_V2'
    code_title = 'code title'
    code_type = 'text/html'

    stac_json = _valid_stac()
    stac_json.update({
        'links': [
            {'href': image_url, 'rel': 'preview'},
            {'rel': 'successor-version', 'title': 'A/B_V2'},
            {'href': 'https://doi.org/a/b', 'rel': 'cite-as'},
            {'href': 'https://doi.org/a/c', 'rel': 'cite-as'},
            {
                'code': code,
                'href': code_url,
                'rel': 'related',
                'title': code_title,
                'type': code_type,
            },
            {'href': LICENSE_LINK, 'rel': 'license'},
        ]
    })

    collection = stac.Collection(stac_json)
    links = list(collection.links())
    self.assertLen(links, len(stac_json['links']))

    links = list(collection.links(stac.Rel.PARENT))
    self.assertEmpty(links)

    links = list(collection.links(stac.Rel.PREVIEW))
    self.assertLen(links, 1)
    self.assertEqual(stac.Link(stac.Rel.PREVIEW, image_url), links[0])

    links = list(collection.links(stac.Rel.CITE))
    self.assertLen(links, 2)

    links = list(collection.links(stac.Rel.RELATED))
    self.assertLen(links, 1)
    expect = stac.Link(stac.Rel.RELATED, code_url, code, code_type, code_title)
    self.assertEqual(expect, links[0])

    self.assertEqual('A/B_V2', collection.successor())

  def test_latest_successor(self):
    stac_json = _valid_stac()
    stac_json.update({
        'links': [
            {'rel': 'latest-version', 'title': 'L'},
            {'rel': 'successor-version', 'title': 'S'},
        ]
    })
    collection = stac.Collection(stac_json)
    self.assertEqual('L', collection.latest_successor())

    stac_json = _valid_stac()
    stac_json.update(
        {
            'links': [
                {'rel': 'successor-version', 'title': 'S'},
            ]
        }
    )

    collection = stac.Collection(stac_json)
    self.assertEqual('S', collection.latest_successor())

    stac_json = _valid_stac()
    stac_json.update(
        {
            'links': [
                {'rel': 'latest-version', 'title': 'L'},
            ]
        }
    )
    collection = stac.Collection(stac_json)
    self.assertEqual('L', collection.latest_successor())

    stac_json = _valid_stac()
    stac_json.update(
        {
            'links': [
                {'rel': 'latest-version', 'title': 'my_id'},
            ]
        }
    )
    collection = stac.Collection(stac_json)
    self.assertIsNone(collection.latest_successor())

  def test_bad_successor_link(self):
    stac_json = _valid_stac()
    stac_json.update(
        {'id': 'bad_id', 'links': [{'rel': 'successor-version', 'title': ''}]}
    )

    with self.assertRaisesRegex(
        errors.InputError,
        'successor-version link has no title in dataset bad_id',
    ):
      stac.Collection(stac_json).successor()

  def test_bad_latest_link(self):
    stac_json = _valid_stac()
    stac_json.update(
        {'id': 'bad_id', 'links': [{'rel': 'latest-version', 'title': ''}]}
    )

    with self.assertRaisesRegex(
        errors.InputError,
        'latest-version link has no title in dataset bad_id',
    ):
      stac.Collection(stac_json).latest_successor_link()

  def test_get_dois(self):
    stac_json = _valid_stac()
    stac_json.update({
        'links': [{'href': 'https://doi.org/a/b', 'rel': 'cite-as'}],
        'sci:doi': 'c/d',
        'sci:publications': [
            {'doi': 'e/f', 'citation': 'citation 1'},
            {'doi': 'g/h', 'citation': 'citation 2'},
        ],
    })
    collection = stac.Collection(stac_json)
    dois = collection.dois()
    expect = ['a/b', 'c/d', 'e/f', 'g/h']
    self.assertEqual(expect, dois)

  def test_get_citations(self):
    stac_json = _valid_stac()
    stac_json.update({
        'sci:citation': 'citation 1',
        'sci:publications': [
            {'citation': 'citation 2'},
            {'citation': 'citation 3'},
        ],
    })
    collection = stac.Collection(stac_json)
    citations = list(collection.citations())
    self.assertEqual(['citation 1', 'citation 2', 'citation 3'], citations)

  def test_interval_cadence_year1(self):
    unit = 'year'
    interval = 1
    stac_json = _valid_stac()
    stac_json.update({
        'gee:interval': {
            'type': 'cadence',
            'unit': unit,
            'interval': interval,
        }
    })
    collection = stac.Collection(stac_json)
    gee_interval = collection.interval()
    assert gee_interval is not None

    expect = stac.Interval(stac.IntervalType.CADENCE, unit, interval)
    self.assertEqual(expect, gee_interval)
    self.assertEqual(365, gee_interval.period())

  def test_interval_cadence_year_not1(self):
    unit = 'year'
    interval = 3
    stac_json = _valid_stac()
    stac_json.update({
        'gee:interval': {
            'type': 'cadence',
            'unit': unit,
            'interval': interval,
        }
    })
    collection = stac.Collection(stac_json)
    gee_interval = collection.interval()
    assert gee_interval is not None

    expect = stac.Interval(stac.IntervalType.CADENCE, unit, interval)
    self.assertEqual(expect, gee_interval)
    self.assertEqual(0, gee_interval.period())

  def test_interval_cadence_day1(self):
    unit = 'day'
    interval = 1
    stac_json = _valid_stac()
    stac_json.update({
        'gee:interval': {
            'type': 'cadence',
            'unit': unit,
            'interval': interval,
        }
    })
    collection = stac.Collection(stac_json)
    gee_interval = collection.interval()
    assert gee_interval is not None

    expect = stac.Interval(stac.IntervalType.CADENCE, unit, interval)
    self.assertEqual(expect, gee_interval)
    self.assertEqual(interval, gee_interval.period())

  def test_interval_cadence_day8(self):
    unit = 'day'
    interval = 8
    stac_json = _valid_stac()
    stac_json.update({
        'gee:interval': {
            'type': 'cadence',
            'unit': unit,
            'interval': interval,
        }
    })
    collection = stac.Collection(stac_json)
    gee_interval = collection.interval()
    assert gee_interval is not None

    expect = stac.Interval(stac.IntervalType.CADENCE, unit, interval)
    self.assertEqual(expect, gee_interval)
    self.assertEqual(interval, gee_interval.period())

  def test_interval_cadence_day_other(self):
    unit = 'day'
    interval = 2
    stac_json = _valid_stac()
    stac_json.update({
        'gee:interval': {
            'type': 'cadence',
            'unit': unit,
            'interval': interval,
        }
    })
    collection = stac.Collection(stac_json)
    gee_interval = collection.interval()
    assert gee_interval is not None

    expect = stac.Interval(stac.IntervalType.CADENCE, unit, interval)
    self.assertEqual(expect, gee_interval)
    self.assertEqual(0, gee_interval.period())

  def test_gee_feature_view_ingestion_params(self):
    stac_json = _valid_stac()
    stac_json.update({
        'summaries': {
            'gee:feature_view_ingestion_params': {
                'max_features_per_tile': 750,
                'thinning_strategy': 'GLOBALLY_CONSISTENT',
                'thinning_ranking': ['.minZoomLevel DESC'],
                'z_order_ranking': ['.minZoomLevel ASC'],
                'prerender_tiles': True,
                'min_vertices_per_tile': 23,
            }
        }
    })
    collection = stac.Collection(stac_json)

    gee_params = collection.feature_view_ingestion_params()
    self.assertIsNotNone(gee_params)
    self.assertEqual(gee_params.max_features_per_tile, 750)
    self.assertEqual(gee_params.thinning_strategy, 'GLOBALLY_CONSISTENT')
    self.assertEqual(gee_params.thinning_ranking, ['.minZoomLevel DESC'])
    self.assertEqual(gee_params.z_order_ranking, ['.minZoomLevel ASC'])
    self.assertEqual(
        gee_params.to_dict(),
        {
            'maxFeaturesPerTile': 750,
            'thinningStrategy': 'GLOBALLY_CONSISTENT',
            'thinningRanking': ['.minZoomLevel DESC'],
            'zOrderRanking': ['.minZoomLevel ASC'],
            'prerenderTiles': True,
            'minVerticesPerTile': 23,
        },
    )

  def test_gee_feature_view_ingestion_params_single(self):
    stac_json = _valid_stac()
    stac_json.update({
        'summaries': {
            'gee:feature_view_ingestion_params': {
                'thinning_ranking': '.minZoomLevel DESC',
                'z_order_ranking': '.minZoomLevel ASC',
            }
        }
    })
    collection = stac.Collection(stac_json)

    gee_params = collection.feature_view_ingestion_params()
    self.assertIsNotNone(gee_params)
    self.assertEqual(
        gee_params.to_dict(),
        {
            'thinningRanking': '.minZoomLevel DESC',
            'zOrderRanking': '.minZoomLevel ASC',
        },
    )

  def test_gee_feature_view_ingestion_params_single_str_multiple_values(self):
    # There is no special handling of a string containing commas in this module
    stac_json = _valid_stac()
    stac_json.update({
        'summaries': {
            'gee:feature_view_ingestion_params': {
                'thinning_ranking': 'property1 ASC, .minZoomLevel DESC',
                'z_order_ranking': 'property2 DESC, .minZoomLevel ASC',
            }
        }
    })
    collection = stac.Collection(stac_json)

    gee_params = collection.feature_view_ingestion_params()
    self.assertIsNotNone(gee_params)
    self.assertEqual(
        gee_params.to_dict(),
        {
            'thinningRanking': 'property1 ASC, .minZoomLevel DESC',
            'zOrderRanking': 'property2 DESC, .minZoomLevel ASC',
        },
    )

  def test_gee_feature_view_ingestion_params_no_params(self):
    stac_json = _valid_stac()
    stac_json.update({'summaries': {}})
    collection = stac.Collection(stac_json)

    gee_params = collection.feature_view_ingestion_params()
    self.assertIsNone(gee_params)

  def test_gee_feature_view_ingestion_params_some_params(self):
    stac_json = _valid_stac()
    stac_json.update({
        'summaries': {
            'gee:feature_view_ingestion_params': {
                'max_features_per_tile': 750,
            }
        }
    })
    collection = stac.Collection(stac_json)

    gee_params = collection.feature_view_ingestion_params()
    self.assertIsNotNone(gee_params)
    self.assertEqual(gee_params.max_features_per_tile, 750)
    self.assertIsNone(gee_params.thinning_strategy)
    self.assertIsNone(gee_params.thinning_ranking)
    self.assertIsNone(gee_params.z_order_ranking)
    self.assertEqual(gee_params.to_dict(), {'maxFeaturesPerTile': 750})

  def test_providers(self):
    stac_json = _valid_stac()
    collection = stac.Collection(stac_json)
    providers = list(collection.providers())
    expected_providers = [
        stac.Provider(
            name='provider 1',
            description=None,
            roles=[stac.Role.PRODUCER],
            url='url 1',
            instruments=['i1', 'i2'],
            platforms=['p1', 'p2'],
            file_links=[
                'https://example.com/a.tar.xz',
                'https://example.com/b.zip',
            ],
        ),
        stac.Provider(
            name='processor',
            description=None,
            roles=[stac.Role.PROCESSOR],
            url='url 2',
            instruments=[],
            platforms=[],
            file_links=[],
        ),
        stac.Provider(
            name='provider 3',
            description=None,
            roles=[stac.Role.LICENSOR],
            url='url 3',
            instruments=[],
            platforms=[],
            file_links=[],
        ),
    ]

    self.assertEqual(providers, expected_providers)

  def test_providers_empty_providers_list(self):
    stac_json = _valid_stac()
    stac_json.update({'providers': []})
    collection = stac.Collection(stac_json)
    providers = list(collection.providers())
    self.assertEqual(providers, [])

  def test_google_producer_provider(self):
    stac_json = _valid_stac()
    stac_json['providers'] = [
        {'name': 'Google Earth Engine', 'roles': ['producer'], 'url': 'url 1'},
        {'name': 'Google Earth Engine', 'roles': ['host']},
    ]
    collection = stac.Collection(stac_json)
    providers = list(collection.providers())
    expected_providers = [
        stac.Provider(
            name='Google Earth Engine',
            description=None,
            roles=[stac.Role.PRODUCER],
            url='url 1',
            instruments=['i1', 'i2'],
            platforms=['p1', 'p2'],
            file_links=[
                'https://example.com/a.tar.xz',
                'https://example.com/b.zip',
            ],
        ),
    ]
    self.assertEqual(providers, expected_providers)


class CatalogTest(unittest.TestCase):

  def test_catalog(self):
    url = 'https://example.com/cat/catalog.json'
    cat_id = 'GEE_catalog'
    catalog_json = {'id': cat_id, 'links': [{'href': url, 'rel': 'root'}]}
    catalog = stac.Catalog(catalog_json)
    self.assertEqual('GEE_catalog', catalog[stac.ID])
    self.assertEqual('https://example.com/cat/catalog.json', catalog.root_url())


if __name__ == '__main__':
  unittest.main()

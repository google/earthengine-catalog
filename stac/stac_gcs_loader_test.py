import copy
import json
import unittest
from unittest import mock

from absl.testing import absltest
import iso8601

from stac import bboxes
from stac import stac_gcs_loader
from stac import stac_lib as stac


def valid_stac():
  return copy.deepcopy({
      'id': 'A/B',
      'title': 'Title',
      'description': 'descr',
      'extent': {
          'spatial': {'bbox': [[-180, -90, 180, 90]]},
          'temporal': {
              'interval': [['2009-01-01T00:00:00Z', '2009-02-03T04:05:06Z']]
          },
      },
      'providers': [
          {
              'name': 'provider 1',
              'roles': ['producer', 'licensor'],
              'url': 'url 1',
          },
      ],
      'keywords': ['key1', 'key_2'],
      'gee:type': 'image',
      'links': [{'href': 'https://example.com', 'rel': 'license'}],
      'summaries': {
          'eo:bands': [{
              'name': 'B1',
              'description': 'band desc1',
              'gee:classes': [
                  # Normally we only have either hex or color names, not both.
                  # Have both here to cover both cases of rendering.
                  {'value': 0, 'color': '000000', 'description': 'First'},
                  {'value': 1, 'color': 'green', 'description': 'Middle'},
                  {'value': 2, 'color': 'ffffff', 'description': 'Last'},
              ],
          }],
      },
  })


class TestFilterFunctions(absltest.TestCase):

  def setUp(self):
    super().setUp()
    collection1 = valid_stac()
    collection1.update({
        'id': 'collection1',
        'extent': {
            'temporal': {
                'interval': [['2022-01-01T00:00:00Z', '2022-12-31T23:59:59Z']]
            },
            'spatial': {'bbox': [[-180, -90, 180, 90]]},
        },
    })

    # Same as collection 1, but only the second interval and the second bbox
    # should match queries.
    collection11 = valid_stac()
    collection11.update({
        'id': 'collection11',
        'extent': {
            'temporal': {
                'interval': [
                    ['1022-01-01T00:00:00Z', '1023-12-31T23:59:59Z'],
                    ['2022-01-01T00:00:00Z', '2022-12-31T23:59:59Z'],
                ]
            },
            'spatial': {
                'bbox': [[-1000, -1000, -999, -999], [-180, -90, 180, 90]]
            },
        },
    })

    collection2 = valid_stac()
    collection2.update({
        'id': 'collection2',
        'extent': {
            'temporal': {
                'interval': [['2023-01-01T00:00:00Z', '2023-12-31T23:59:59Z']]
            },
            'spatial': {'bbox': [[-90, -45, 90, 45]]},
        },
    })

    collection3 = valid_stac()
    collection3.update({
        'id': 'collection3',
        'extent': {
            'temporal': {
                'interval': [
                    # End time of None means now
                    ['2024-01-01T00:00:00Z', None]
                ]
            },
            'spatial': {'bbox': [[170, 80, 180, 90]]},
        },
    })

    collection_list = [
        collection1,
        collection11,
        collection2,
        collection3,
    ]
    self.enter_context(
        mock.patch.object(
            stac_gcs_loader.Catalog,
            '_load_collections',
            return_value=[stac.Collection(c) for c in collection_list],
        )
    )
    self.catalog = stac_gcs_loader.Catalog(mock.Mock())
    self.collections = self.catalog.collections

  def test_filter_by_ids(self):
    filtered = self.collections.filter_by_ids(('collection1',))
    self.assertEqual(['collection1'], [x['id'] for x in filtered])

    filtered2 = filtered.filter_by_ids(('no such id',))
    self.assertEmpty(filtered2)

  def test_filter_by_time_interval(self):
    filtered = self.collections.filter_by_datetime(
        iso8601.parse_date('2022-06-01T00:00:00Z')
    )
    self.assertEqual(
        ['collection1', 'collection11'], [x['id'] for x in filtered]
    )

    filtered = self.collections.filter_by_interval((
        iso8601.parse_date('2022-06-01T00:00:00Z'),
        iso8601.parse_date('2022-08-31T23:59:59Z'),
    ))
    self.assertEqual(
        ['collection1', 'collection11'], [x['id'] for x in filtered]
    )

    filtered = self.collections.filter_by_interval((
        iso8601.parse_date('2023-01-01T00:00:00Z'),
        iso8601.parse_date('2023-12-31T23:59:59Z'),
    ))
    self.assertEqual(['collection2'], [x['id'] for x in filtered])

    filtered = self.collections.filter_by_interval((
        iso8601.parse_date('2024-01-01T00:00:00Z'),
        iso8601.parse_date('2024-08-31T23:59:59Z'),
    ))
    self.assertEqual(['collection3'], [x['id'] for x in filtered])

    filtered = self.collections.filter_by_interval((
        iso8601.parse_date('3025-01-01T00:00:00Z'),
        iso8601.parse_date('3025-12-31T23:59:59Z'),
    ))
    self.assertEmpty(filtered)

  def test_filter_by_bounding_box(self):
    filtered = self.collections.filter_by_bounding_box(
        bboxes.BBox.from_list([-180, -90, 180, 90])
    )
    self.assertEqual(
        ['collection1', 'collection11', 'collection2', 'collection3'],
        [x['id'] for x in filtered],
    )

    filtered = self.collections.filter_by_bounding_box(
        bboxes.BBox.from_list([-90, -45, 90, 45])
    )
    self.assertEqual(
        ['collection1', 'collection11', 'collection2'],
        [x['id'] for x in filtered],
    )

    filtered = self.collections.filter_by_bounding_box(
        bboxes.BBox.from_list([180, 90, 360, 180])
    )
    self.assertEmpty(filtered)

  def test_matches_datetime(self):
    self.assertTrue(
        stac_gcs_loader.matches_interval(
            (
                iso8601.parse_date('2022-01-01T00:00:00Z'),
                iso8601.parse_date('2022-12-31T23:59:59Z'),
            ),
            (
                iso8601.parse_date('2022-06-01T00:00:00Z'),
                iso8601.parse_date('2022-08-31T23:59:59Z'),
            ),
        )
    )
    self.assertTrue(
        stac_gcs_loader.matches_interval(
            (
                iso8601.parse_date('2022-01-01T00:00:00Z'),
                iso8601.parse_date('2025-01-01T00:00:00Z'),
            ),
            (
                iso8601.parse_date('2024-06-01T00:00:00Z'),
                iso8601.parse_date('2024-08-31T23:59:59Z'),
            ),
        )
    )
    self.assertFalse(
        stac_gcs_loader.matches_datetime(
            (
                iso8601.parse_date('2022-01-01T00:00:00Z'),
                iso8601.parse_date('2022-12-31T23:59:59Z'),
            ),
            iso8601.parse_date('2023-01-01T00:00:00Z'),
        )
    )


class TestLoadCollections(absltest.TestCase):

  def test_load_collections(self):
    mock_client = mock.MagicMock()
    mock_bucket = mock.MagicMock()

    mock_blob1 = mock.MagicMock()
    mock_blob1.name = 'catalog/collection1.json'
    collection1 = valid_stac()
    collection1.update({'id': 'collection1'})
    mock_blob1.download_as_string.return_value = json.dumps(
        collection1
    ).encode()

    mock_blob2 = mock.MagicMock()
    mock_blob2.name = 'catalog/collection2.json'
    collection2 = valid_stac()
    collection2.update({'id': 'collection2', 'deprecated': True})
    mock_blob2.download_as_string.return_value = json.dumps(
        collection2
    ).encode()

    mock_blob3 = mock.MagicMock()
    mock_blob3.name = 'catalog/collection3.json'
    collection3 = valid_stac()
    collection3.update({'id': 'collection3'})
    collection3['links'].append({'rel': 'successor-version', 'title': 'Title'})
    mock_blob3.download_as_string.return_value = json.dumps(
        collection3
    ).encode()

    mock_blob4 = mock.MagicMock()
    # Should be ignored, not a .json file
    mock_blob4.name = 'catalog/autoexec.bat'
    mock_blob4.download_as_string.return_value = (
        b'@ECHO OFF\nPROMPT $P$G\nPATH C:\\DOS;C:\\WINDOWS'
    )

    mock_blob5 = mock.MagicMock()
    # Should be ignored, type != Collection
    mock_blob5.name = 'catalog/catalog.json'
    collection5 = valid_stac()
    collection5.update({'id': 'collection5', 'type': 'Catalog'})
    mock_blob5.download_as_string.return_value = json.dumps(
        collection5
    ).encode()

    mock_bucket.list_blobs.return_value = [
        mock_blob1,
        mock_blob2,
        mock_blob3,
        mock_blob4,
        mock_blob5,
    ]
    mock_client.get_bucket.return_value = mock_bucket

    # Only one file is loaded.
    collections = stac_gcs_loader.Catalog(mock_client).collections
    self.assertLen(collections, 1)
    self.assertEqual(collections[0]['id'], 'collection1')


if __name__ == '__main__':
  unittest.main()

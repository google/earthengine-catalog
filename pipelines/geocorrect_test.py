"""Unit tests for the geocorrect module."""

import unittest

import numpy

from google3.third_party.earthengine_catalog.pipelines import geocorrect
from stac import bboxes


class S1IntervalTest(unittest.TestCase):
  """Tests the S1Interval dataclass."""

  def test_add_latitudes_around_prime_meridian(self):
    interval = geocorrect.S1Interval.empty()
    for lat in (1, -1, 2, -2, 0.5, -0.5):
      interval = interval.add_longitude(lat)

    self.assertLess(interval.low, interval.high)
    self.assertEqual(interval.low, -2)
    self.assertEqual(interval.high, 2)

  def test_add_latitudes_around_antimeridian(self):
    interval = geocorrect.S1Interval.empty()
    for lat in (179, -179, 178, -178, 179.5, -179.5):
      interval = interval.add_longitude(lat)

    self.assertGreater(interval.low, interval.high)
    self.assertEqual(interval.low, 178)
    self.assertEqual(interval.high, -178)


class CoordinateIndexTest(unittest.TestCase):
  """Tests the geocorrect.CoordinateIndex dataclass."""

  def test_lat_lon_diff_size(self):
    lat = numpy.array([[1, 2, 3], [2, 3, 4]])
    lon = numpy.array([[1, 2], [2, 3]])
    self.assertRaisesRegex(
        geocorrect.InputError,
        r'Latitude .* and longitude .* rasters',
        geocorrect.CoordinateIndex.from_arrays,
        lat,
        lon,
    )

  def test_lat_lon_mask_diff_size(self):
    lat = numpy.array([[1, 2, 3], [2, 3, 4]])
    lon = numpy.array([[2, 3, 4], [3, 4, 5]])
    mask = numpy.array([[1, 1], [1, 0]])
    self.assertRaisesRegex(
        geocorrect.InputError,
        r'Latitude .* and mask .* rasters',
        geocorrect.CoordinateIndex.from_arrays,
        lat,
        lon,
        mask=mask,
    )

  def test_lat_lon_all_fill_value(self):
    for fill_value in (numpy.nan, -999):
      with self.subTest(fill_value=fill_value):
        lat = numpy.array([[fill_value] * 3 for _ in range(0, 3)])
        lon = numpy.array([[fill_value] * 3 for _ in range(0, 3)])
        self.assertRaisesRegex(
            geocorrect.EmptyInputError,
            'The input grid was empty',
            geocorrect.CoordinateIndex.from_arrays,
            lat,
            lon,
            lat_fill_value=fill_value,
            lon_fill_value=fill_value,
        )

  def test_lat_lon_all_masked(self):
    lat = numpy.array([[1, 2, 3], [2, 3, 4], [3, 4, 5]])
    lon = numpy.array([[20, 21, 22], [21, 22, 23], [22, 23, 24]])
    mask = numpy.array([[0] * 3 for _ in range(0, 3)])
    self.assertRaisesRegex(
        geocorrect.EmptyInputError,
        'No points mapped by CoordinateIndex',
        geocorrect.CoordinateIndex.from_arrays,
        lat,
        lon,
        mask=mask,
    )

  def test_single_hemisphere(self):
    hemispheres = {
        'east': {
            'lat': [[1, 2, 3], [2, 3, 4], [3, 4, 5]],
            'lon': [[20, 21, 22], [21, 22, 23], [22, 23, 24]],
            'bbox': bboxes.BBox(20, 1, 24, 5),
        },
        'west': {
            'lat': [[-1, -2, -3], [-2, -3, -4], [-3, -4, -5]],
            'lon': [[-20, -21, -22], [-21, -22, -23], [-22, -23, -24]],
            'bbox': bboxes.BBox(-24, -5, -20, -1),
        },
    }

    for name, params in hemispheres.items():
      with self.subTest(hemisphere=name):
        lat = numpy.array(params['lat'])
        lon = numpy.array(params['lon'])
        index = geocorrect.CoordinateIndex.from_arrays(lat, lon)
        self.assertEqual([params['bbox']], index.bbox_list)

  def test_cross_prime_meridian(self):
    lat = numpy.array([[1, 2, 3], [2, 3, 4], [3, 4, 5]])
    lon = numpy.array([[-2, -1, 0], [-1, 0, 1], [0, 1, 2]])
    index = geocorrect.CoordinateIndex.from_arrays(lat, lon)

    self.assertEqual([bboxes.BBox(-2, 1, 2, 5)], index.bbox_list)

  def test_cross_anti_meridian(self):
    points = {
        'eastwest': {
            'lat': [[1, 2, 3], [2, 3, 4], [3, 4, 5]],
            'lon': [[178, 179, 180], [179, 180, -179], [-180, -179, -178]],
        },
        'westeast': {
            'lat': [[5, 4, 3], [4, 3, 2], [3, 2, 1]],
            'lon': [[-178, -179, -180], [-179, 180, 179], [180, 179, 178]],
        },
    }
    for direction, raw_rasters in points.items():
      with self.subTest(direction=direction):
        lat = numpy.array(raw_rasters['lat'])
        lon = numpy.array(raw_rasters['lon'])
        index = geocorrect.CoordinateIndex.from_arrays(lat, lon)

        self.assertCountEqual(
            (bboxes.BBox(178, 1, 180, 3), bboxes.BBox(-180, 3, -178, 5)),
            index.bbox_list,
        )

  def test_ignore_fill_value(self):
    for fill_value in (numpy.nan, 999):
      with self.subTest(fill_value=fill_value):
        lat = numpy.array([[1, 2, 3], [fill_value, fill_value, 4], [3, 4, 5]])
        lon = numpy.array([[1, 2, 3], [2, fill_value, fill_value], [3, 4, 5]])
        index = geocorrect.CoordinateIndex.from_arrays(
            lat, lon, lat_fill_value=fill_value, lon_fill_value=fill_value
        )

        # Because all pairs in the second column have at least one fill value,
        # the point_index shouldn't have anything pointing there.
        self.assertNotIn(1, set(pt[0] for pt in index.point_index.values()))

  def test_ignore_mask_position(self):
    lat = numpy.array([[1, 2, 3], [2, 3, 4], [3, 4, 5]])
    lon = numpy.array([[1, 2, 3], [2, 3, 4], [3, 4, 5]])
    mask = numpy.array([[1, 1, 1], [0, 0, 0], [1, 1, 1]])
    index = geocorrect.CoordinateIndex.from_arrays(lat, lon, mask=mask)

    # Because all pairs in the second column are masked out, the point_index
    # shouldn't have anything pointing there.
    self.assertNotIn(1, set(pt[0] for pt in index.point_index.values()))


class GeoLookupTableTest(unittest.TestCase):
  """Tests the geocorrect.GeoLookupTableTest dataclass."""

  def generate_test_index(self) -> geocorrect.CoordinateIndex:
    """Returns a CoordinateIndex for testing.

    The test index looks something like

       - - o o
       - o o o
       o o o -
       - o - -

    with (0, 0) at the bottom left corner. And each pixel covering 1x1 degree.

    Returns:
      geocorrect.CoordinateIndex
    """
    return geocorrect.CoordinateIndex(
        [
            (0, 1),
            (1, 0),
            (1, 1),
            (1, 2),
            (2, 1),
            (2, 2),
            (2, 3),
            (3, 2),
            (3, 3),
        ],
        {
            (1, 0): (0, 0),
            (2, 1): (0, 1),
            (3, 2): (0, 2),
            (1, 1): (1, 0),
            (2, 2): (1, 1),
            (3, 3): (1, 2),
            (0, 1): (2, 0),
            (1, 2): (2, 1),
            (2, 3): (2, 2),
        },
        [bboxes.BBox(0, 0, 3, 3)],
    )

  def test_geotransform(self):
    index = self.generate_test_index()
    scale_lat = -1
    scale_lon = 1

    # The geotransform we calculate depends on whether the bounding boxes
    # calculated by the index need to be buffered because the points represent
    # pixel centers.
    transforms = {
        True: [-0.5, 1, 0, 3.5, 0, -1],
        False: [0, 1, 0, 3, 0, -1],
    }
    for buffer_bbox, expected in transforms.items():
      with self.subTest(buffer_bbox=buffer_bbox):
        glts = geocorrect.GeoLookupTable.from_index(
            index, scale_lat, scale_lon, buffer_bbox=buffer_bbox
        )
        self.assertEqual(len(glts), 1)

        geotransform = glts[0].geotransform()
        self.assertEqual(expected, geotransform)

  def test_bad_scale_factors(self):
    index = self.generate_test_index()

    # The same error is raised for each argument.
    self.assertRaisesRegex(
        geocorrect.InputError,
        'Expected negative scale_lat',
        geocorrect.GeoLookupTable.from_index,
        index,
        0.5,
        0.5,
    )
    self.assertRaisesRegex(
        geocorrect.InputError,
        'Expected negative scale_lat',
        geocorrect.GeoLookupTable.from_index,
        index,
        -0.5,
        -0.5,
    )

  def test_apply_glt(self):
    index = self.generate_test_index()
    raster = numpy.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    scale_lat = -0.5
    scale_lon = 0.5

    # The expected projection depends on how far away the nearest neighbor is
    # allowed to be. When we allow gaps to be filled from farther away, there
    # are fewer "NO DATA" pixels in the result.
    projections = {
        1: [
            [-1, -1, -1, 3, 3, 3, 6],
            [-1, 2, 2, 3, 5, 3, 9],
            [-1, 2, 2, 5, 5, 5, 9],
            [1, 2, 2, 5, 5, 5, 9],
            [1, 1, 4, 8, 8, 8, -1],
            [1, 1, 7, 8, 8, 8, -1],
            [-1, 7, 7, 7, -1, -1, -1],
        ],
        2: [
            [2, 2, 3, 3, 3, 3, 6],
            [2, 2, 2, 3, 5, 3, 9],
            [2, 2, 2, 5, 5, 5, 9],
            [1, 2, 2, 5, 5, 5, 9],
            [1, 1, 4, 8, 8, 8, 8],
            [1, 1, 7, 8, 8, 8, 8],
            [7, 7, 7, 7, 7, 8, 8],
        ],
    }
    for max_nn_distance, expected in projections.items():
      with self.subTest(max_nn_distance=max_nn_distance):
        glts = geocorrect.GeoLookupTable.from_index(
            index, scale_lat, scale_lon, max_nn_distance=max_nn_distance
        )
        self.assertEqual(len(glts), 1)

        projected = glts[0].apply_to(raster, -1, numpy.int64)
        self.assertTrue(numpy.all(numpy.array(expected) == projected))


if __name__ == '__main__':
  unittest.main()

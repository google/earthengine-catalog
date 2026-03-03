from shapely import wkt

from absl.testing import absltest
from google3.third_party.earthengine_catalog.pipelines import polygon_utils


class PolygonUtilsTest(absltest.TestCase):

  def test_repair_geometry(self):
    # CASE 1: Valid polygon with hole.
    # Expectation: Hole removed, orientation enforced (CCW).
    p1 = wkt.loads(
        'POLYGON ((0 0, 0 1, 1 1, 1 0, 0 0), (0.1 0.1, 0.9 0.1, 0.9 0.9, 0.1'
        ' 0.9, 0.1 0.1))'
    )
    self.assertFalse(p1.exterior.is_ccw)  # Input polygon is CW
    normalized_p1 = polygon_utils.repair_geometry(p1)
    self.assertIsNotNone(normalized_p1)
    self.assertTrue(normalized_p1.is_valid)
    self.assertEqual(normalized_p1.geom_type, 'Polygon')
    self.assertEmpty(normalized_p1.interiors)
    # The exterior ring is now CCW.
    self.assertTrue(normalized_p1.exterior.is_ccw)

    # CASE 2: Invalid polygon (bowtie).
    # Expectation: Becomes valid Polygon, with CCW orientation.
    p2_invalid = wkt.loads('POLYGON ((0 0, 1 1, 0 1, 1 0, 0 0))')
    self.assertFalse(p2_invalid.is_valid)
    normalized_p2 = polygon_utils.repair_geometry(p2_invalid)
    self.assertIsNotNone(normalized_p2)
    self.assertTrue(normalized_p2.is_valid)
    self.assertEqual(normalized_p2.geom_type, 'Polygon')
    self.assertTrue(normalized_p2.exterior.is_ccw)

    # CASE 3: None geometry
    # Expectation: Returns None.
    self.assertIsNone(polygon_utils.repair_geometry(None))

    # CASE 4: Empty polygon
    # Expectation: Returns None.
    p_empty = wkt.loads('POLYGON EMPTY')
    self.assertIsNone(polygon_utils.repair_geometry(p_empty))

    # CASE 5: MultiPolygon with a hole.
    # Expectation: Hole is removed, result is MultiPolygon with 1 geometry,
    # with CCW orientation.
    mp1 = wkt.loads(
        'MULTIPOLYGON (((0 0, 0 1, 1 1, 1 0, 0 0), (0.1 0.1, 0.9 0.1, 0.9 0.9,'
        ' 0.1 0.9, 0.1 0.1)))'
    )
    normalized_mp1 = polygon_utils.repair_geometry(mp1)
    self.assertIsNotNone(normalized_mp1)
    self.assertTrue(normalized_mp1.is_valid)
    self.assertEqual(normalized_mp1.geom_type, 'Polygon')
    self.assertEmpty(normalized_mp1.interiors)
    self.assertTrue(normalized_mp1.exterior.is_ccw)

    # CASE 6: MultiPolygon with holes and overlaps.
    # Two polygons: one with a hole, and one overlapping square.
    # unary_union will merge overlapping parts.
    # Expectation: Holes removed, overlaps merged, orientation enforced.
    mp2 = wkt.loads(
        'MULTIPOLYGON (((10 10, 10 11, 11 11, 11 10, 10 10), (10.1 10.1, 10.9'
        ' 10.1, 10.9 10.9, 10.1 10.9, 10.1 10.1)),((20 20, 20 21, 21 21, 21 20,'
        ' 20 20)),((20.5 20.5, 20.5 21.5, 21.5 21.5, 21.5 20.5, 20.5 20.5)))'
    )
    normalized_mp2 = polygon_utils.repair_geometry(mp2)
    self.assertIsNotNone(normalized_mp2)
    self.assertTrue(normalized_mp2.is_valid)
    self.assertEqual(normalized_mp2.geom_type, 'MultiPolygon')
    for p in normalized_mp2.geoms:
      self.assertEmpty(p.interiors)
      self.assertTrue(p.exterior.is_ccw)

    # CASE 7: Empty MultiPolygon
    # Expectation: Returns None.
    mp_empty = wkt.loads('MULTIPOLYGON EMPTY')
    self.assertIsNone(polygon_utils.repair_geometry(mp_empty))


if __name__ == '__main__':
  absltest.main()

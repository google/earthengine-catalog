"""Unit tests for bboxes.py."""
import unittest
from stac import bboxes


class BboxeslTest(unittest.TestCase):

  def test_intersects_bbox(self):
    self.assertTrue(
        bboxes.BBox.from_list([-180, -90, 180, 90]).intersects(
            bboxes.BBox.from_list([-180, -90, 180, 90])
        )
    )
    self.assertTrue(
        bboxes.BBox.from_list([-180, -90, 180, 90]).intersects(
            bboxes.BBox.from_list([-90, -45, 90, 45])
        )
    )
    self.assertFalse(
        bboxes.BBox.from_list([-180, -90, 180, 90]).intersects(
            bboxes.BBox.from_list([180, 90, 360, 180])
        )
    )

  def test_bbox_creation(self):
    self.assertEqual(
        bboxes.BBox(west=10, south=20, east=30, north=40),
        bboxes.BBox.from_list([10, 20, 30, 40]),
    )
    with self.assertRaisesRegex(
        ValueError, r'The smaller \(west\) coordinate must be listed first'
    ):
      bboxes.BBox.from_list([180, 0, 100, 0])
    with self.assertRaisesRegex(
        ValueError, r'The smaller \(south\) coordinate must be listed first'
    ):
      bboxes.BBox.from_list([0, 90, 0, -45])


if __name__ == '__main__':
  unittest.main()

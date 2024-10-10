"""Bounding Box dataclass with named properties for clarity."""

import dataclasses
from typing_extensions import Self

@dataclasses.dataclass
class BBox:
  """Class representing a lat/lon bounding box."""
  west: float
  south: float
  east: float
  north: float

  def is_global(self) -> bool:
    return (
        self.west == -180 and self.south == -90 and
        self.east == 180 and self.north == 90)

  @classmethod
  def from_list(cls, bbox_list: list[float]) -> Self:
    """Constructs a BBox from a list of four numbers [west,south,east,north]."""
    if bbox_list[0] > bbox_list[2]:
      raise ValueError(
          'The smaller (west) coordinate must be listed first in a bounding box'
          f' corner list. Found {bbox_list}'
      )
    if bbox_list[1] > bbox_list[3]:
      raise ValueError(
          'The smaller (south) coordinate must be listed first in a bounding'
          f' box corner list. Found {bbox_list}'
      )
    return cls(bbox_list[0], bbox_list[1], bbox_list[2], bbox_list[3])

  def intersects(self, query_bbox: Self) -> bool:
    """Checks if this bbox intersects with the query bbox.

    Doesn't handle bboxes extending past the antimeridaian.

    Args:
      query_bbox: Bounding box from the query.

    Returns:
      True if the two bounding boxes intersect
    """
    return (
        query_bbox.west < self.east
        and query_bbox.east > self.west
        and query_bbox.south < self.north
        and query_bbox.north > self.south
    )


@dataclasses.dataclass
class Tile:
  i: int
  j: int

  def bbox_for(self, tiles: int) -> BBox:
    """Returns a degree bbox for a square tile. Tiles start at the UL corner."""
    step_x = 360 / tiles
    step_y = 180 / tiles
    tile_x = -180 + self.i * step_x
    tile_y = 90 - self.j * step_y
    return BBox(
        west=tile_x, south=tile_y - step_y, east=tile_x + step_x, north=tile_y
    )

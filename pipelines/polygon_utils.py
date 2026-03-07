"""Utils for repairing shapely polygons."""

from shapely import geometry
from shapely import ops
from shapely.geometry import polygon

GEOMETRY_TYPES = geometry.Polygon | geometry.MultiPolygon


def repair_geometry(
    geom: GEOMETRY_TYPES | None,
) -> GEOMETRY_TYPES | None:
  """Repairs a shapely geometry.

  Removes holes, retains only exterior shells, fixes invalid geometries
  such as overlaps or self-touching parts, and ensures correct polygon
  orientation. Returns None if the input geometry is None or empty, or if
  normalization fails for any reason.

  This function should be used when preparing geometries for BigQuery
  ingestion, as BigQuery has strict requirements for polygon validity
  and does not support holes.

  Args:
    geom: The input shapely geometry.

  Returns:
    A normalized shapely geometry, or None if normalization is not possible.
  """
  try:
    if geom is None or geom.is_empty:
      return None

    # 1. Drop holes immediately (BigQuery safety).
    # Create a new geometry of the same type, containing only exteriors.
    if isinstance(geom, geometry.Polygon):
      geom_no_holes = geometry.Polygon(geom.exterior)
    elif isinstance(geom, geometry.MultiPolygon):
      geom_no_holes = geometry.MultiPolygon(
          [geometry.Polygon(p.exterior) for p in geom.geoms]
      )
    else:
      return None

    # 2. Make valid if it's not, then normalize shells using ops.unary_union.
    if not geom_no_holes.is_valid:
      geom_no_holes = geom_no_holes.buffer(0)
    if geom_no_holes.is_empty:
      return None
    union_result = ops.unary_union(geom_no_holes)

    # 3. Enforce orientation. The orientation is applied conditionally
    # based on the type of the result from ops.unary_union.
    if isinstance(union_result, geometry.Polygon):
      return polygon.orient(union_result, sign=1.0)
    elif isinstance(union_result, geometry.MultiPolygon):
      return geometry.MultiPolygon(
          [polygon.orient(p, sign=1.0) for p in union_result.geoms]
      )
    else:
      return None

  except Exception:  # pylint: disable=broad-exception-caught
    return None

"""Computed dataset expressions for Landsat."""

import ee


class C2SRExpressions:
  """Computations for the merged, masked Landsat C2 SR collection."""

  # A set of band indices corresponding to the renaming used in this collection.
  # Note: No NDSI; snow is already masked in Level 2 products.
  ALGORITHMS = {
      'NDVI': 'clamp((b("nir") - b("red")) / (b("nir") + b("red")), -1, 1)',
      'EVI': (
          'clamp(2.5 * ((b("nir") - b("red")) / '
          '     clamp(b("nir") + 6 * b("red") - 7.5 * b("blue") + 1, 0, 10)), '
          '   -1.0, 1.0)'
      ),
      'NBR': 'clamp((b("nir") - b("swir2")) / (b("nir") + b("swir2")), -1, 1)',
      'NDWI': 'clamp((b("green") - b("nir")) / (b("green") + b("nir")), -1, 1)',
      'BAI': '1.0 / (pow(0.1 - b("red"), 2) + pow(0.06 - b("nir"), 2))',
  }

  def _expression(self) -> ee.ImageCollection:
    """Prepare the merged Landsat C2 SR collection."""
    l4 = (
        ee.ImageCollection('LANDSAT/LT04/C02/T1_L2')
        .filter('WRS_ROW < 122')  # Remove night-time images.
        .map(prep_c2sr_l4l5l7)
    )

    l5 = (
        ee.ImageCollection('LANDSAT/LT05/C02/T1_L2')
        .filter('WRS_ROW < 122')  # Remove night-time images.
        .map(prep_c2sr_l4l5l7)
    )

    l7 = (
        ee.ImageCollection('LANDSAT/LE07/C02/T1_L2')
        .filterDate('1984-01-01', '2017-01-01')  # Orbital drift after 2017.
        .filter('WRS_ROW < 122')  # Remove night-time images.
        .map(prep_c2sr_l4l5l7)
    )

    l8 = (
        ee.ImageCollection('LANDSAT/LC08/C02/T1_L2')
        # Images before May 1 had some pointing issues.
        .filterDate('2013-05-01', '2099-01-01')
        .filter(ee.Filter.neq('NADIR_OFFNADIR', 'OFFNADIR'))
        .filter('WRS_ROW < 122')  # Remove night-time images.
        .map(prepare_c2sr_l8l9)
    )

    l9 = (
        ee.ImageCollection('LANDSAT/LC09/C02/T1_L2')
        .filter(ee.Filter.neq('NADIR_OFFNADIR', 'OFFNADIR'))
        .filter('WRS_ROW < 122')  # Remove night-time images.
        .map(prepare_c2sr_l8l9)
    )

    sr = l4.merge(l5).merge(l7).merge(l8).merge(l9)
    return sr


def prep_c2sr_l4l5l7(image: ee.Image) -> ee.ImageCollection:
  """Scale and mask L5-L7 C2 SR."""
  optical_bands = image.select('SR_B.').multiply(0.0000275).add(-0.2)
  thermal_band = image.select('ST_B6').multiply(0.00341802).add(149.0)

  scaled = optical_bands.addBands(thermal_band).select(
      ['SR_B1', 'SR_B2', 'SR_B3', 'SR_B4', 'SR_B5', 'SR_B7', 'ST_B6'],
      ['blue', 'green', 'red', 'nir', 'swir1', 'swir2', 'thermal']
  )

  # Select cloud free land and water pixels.
  qa = image.select(['QA_PIXEL'])
  # Clear if bits 0-5 are zero.
  mask1 = qa.bitwiseAnd(int('111111', 2)).eq(0)
  # Good snow/shadow/cloud confidence if bits 8-13 are equal to 010101.
  mask2 = qa.rightShift(8).bitwiseAnd(int('111111', 2)).eq(int('010101', 2))

  # Remove pixels marked as saturated or out of range.
  mask3 = image.select('QA_RADSAT').eq(0)
  mask4 = optical_bands.reduce(ee.Reducer.min()).gt(0)
  mask5 = optical_bands.reduce(ee.Reducer.max()).lt(1)
  # Mark hazy pixels using empirical AOD threshold.
  mask6 = image.select('SR_ATMOS_OPACITY').unmask(-1).lt(300)

  # Put the new bands back into the original image container and mask them.
  return (
      image.select()
      .addBands(scaled)
      .updateMask(mask1.And(mask2).And(mask3).And(mask4).And(mask5).And(mask6))
  )


def prepare_c2sr_l8l9(image: ee.Image) -> ee.ImageCollection:
  """Scale and mask L8-L9 C2 SR."""
  optical_bands = image.select('SR_B.').multiply(0.0000275).add(-0.2)
  thermal_band = image.select('ST_B10').multiply(0.00341802).add(149.0)

  # Insert the scaled bands back into the original image container.
  scaled = optical_bands.addBands(thermal_band).select(
      ['SR_B2', 'SR_B3', 'SR_B4', 'SR_B5', 'SR_B6', 'SR_B7', 'ST_B10'],
      ['blue', 'green', 'red', 'nir', 'swir1', 'swir2', 'thermal'],
  )

  # Select cloud free land and water pixels.
  qa = image.select(['QA_PIXEL'])
  # Clear if bits 0-5 are zero.
  mask1 = qa.bitwiseAnd(int('111111', 2)).eq(0)
  # Good snow/shadow/cloud/cirrus confidence if bit pairs 8-15 are each 01.
  mask2 = qa.rightShift(8).bitwiseAnd(int('11111111', 2)).eq(int('01010101', 2))

  # Remove pixels marked as saturated or out of range.
  mask3 = image.select('QA_RADSAT').eq(0)
  mask4 = optical_bands.reduce(ee.Reducer.min()).gt(0)
  mask5 = optical_bands.reduce(ee.Reducer.max()).lt(1)

  # Remove high aerosol pixels (bits 6-7 == 11).
  mask6 = (image.select(['SR_QA_AEROSOL'])
           .rightShift(6)
           .neq(int('11', 2)))

  # Put the new bands back into the original image container and mask them.
  return (
      image.select()
      .addBands(scaled)
      .updateMask(mask1.And(mask2).And(mask3).And(mask4).And(mask5).And(mask6))
  )

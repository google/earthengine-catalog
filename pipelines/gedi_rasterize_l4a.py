# Copyright 2020 The Google Earth Engine Community Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import datetime
import itertools
from typing import Any

from absl import app

import ee
from google3.third_party.earthengine_catalog.pipelines import gedi_extract_l4a
import gedi_lib


def export_wrapper(table_asset_ids: list[str], raster_asset_id: str,
                   grid_cell_feature: Any, grill_month: datetime.datetime,
                   overwrite: bool) -> gedi_lib.ExportParameters:
  """Creates an EE export job definition.

  Args:
    table_asset_ids: list of strings, table asset ids to rasterize
    raster_asset_id: string, raster asset id to create
    grid_cell_feature: ee.Feature
    grill_month: grilled month
    overwrite: bool, if any of the assets can be replaced if they already exist

  Returns:
    an ExportParameters object containing arguments for an export job.
  """
  numeric_vars = []
  int_vars = []
  for gedi_vars in [gedi_extract_l4a.gedi_vars] + list(
      gedi_extract_l4a.group_vars.values()
  ):
    numeric_vars.extend(gedi_vars.numeric_vars())
    int_vars.extend(gedi_vars.integer_variables)

  return gedi_lib.create_export(
      table_asset_ids=table_asset_ids,
      raster_asset_id=raster_asset_id,
      raster_bands=numeric_vars,
      int_bands=int_vars,
      grid_cell_feature=grid_cell_feature,
      grill_month=grill_month,
      overwrite=overwrite,
  )


def main(argv):
  start_id = 1  # First UTM grid cell id
  ee.Initialize()
  raster_collection = 'LARSE/GEDI/GEDI04_A_002_MONTHLY'
  for grid_cell_id in range(start_id,
                            start_id + gedi_lib.NUM_UTM_GRID_CELLS.value):
    grid_cell_feature = ee.Feature(
        ee.FeatureCollection(
            'users/yang/GEETables/GEDI/GEDI_UTM_GRIDS_LandOnly').filterMetadata(
                'grid_id', 'equals', grid_cell_id).first())
    with open(argv[1]) as fh:
      gedi_lib.rasterize_gedi_by_utm_zone(
          [x.strip() for x in fh],
          raster_collection + '/' + '%03d' % grid_cell_id,
          grid_cell_feature,
          argv[2],
          export_wrapper,
          overwrite=gedi_lib.ALLOW_GEDI_RASTERIZE_OVERWRITE.value)


if __name__ == '__main__':
  app.run(main)

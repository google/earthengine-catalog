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

from collections.abc import Callable, Sequence
import os
from typing import BinaryIO

from absl import app
from absl import logging
import h5py
import pandas as pd
import pyarrow
import pyarrow.csv

import gedi_lib


numeric_variables = (
    'beam',
    'degrade_flag',
    'delta_time',
    'digital_elevation_model',
    'digital_elevation_model_srtm',
    'elev_highestreturn',
    'elev_lowestmode',
    'elevation_bias_flag',
    'energy_total',

    'land_cover_data/landsat_treecover',
    'land_cover_data/landsat_water_persistence',
    'land_cover_data/leaf_off_doy',
    'land_cover_data/leaf_off_flag',
    'land_cover_data/leaf_on_cycle',
    'land_cover_data/leaf_on_doy',
    'land_cover_data/modis_nonvegetated',
    'land_cover_data/modis_nonvegetated_sd',
    'land_cover_data/modis_treecover',
    'land_cover_data/modis_treecover_sd',
    'land_cover_data/pft_class',
    'land_cover_data/region_class',
    'land_cover_data/urban_focal_window_size',
    'land_cover_data/urban_proportion',

    'lat_highestreturn',
    'lat_lowestmode',
    'lon_highestreturn',
    'lon_lowestmode',

    'num_detectedmodes',
    'quality_flag',

    'selected_algorithm',
    'selected_mode',
    'selected_mode_flag',

    'sensitivity',
    'solar_azimuth',
    'solar_elevation',
    'surface_flag'
)

integer_variables = frozenset((
    'beam',
    'degrade_flag',
    'elevation_bias_flag',
    'num_detectedmodes',
    'quality_flag',
    'selected_algorithm',
    'selected_mode',
    'selected_mode_flag',
    'surface_flag',
    'land_cover_data/landsat_water_persistence',
    'land_cover_data/leaf_off_flag',
    'land_cover_data/pft_class',
    'land_cover_data/region_class',
    'land_cover_data/urban_focal_window_size',
    'land_cover_data/urban_proportion',
))


# Integer-valued columns that contained fill values instead of NA prior to
# Pandas updates past version 1.5.
integer_fill_variables = {
    'leaf_off_doy': 32767,
    'leaf_on_cycle': 255,
    'leaf_on_doy': 32767,
}

string_variables = ('shot_number',)

# Describes how to transform variable names from different GEDI versions
# into the schema defined for V002. A value of None indicates that the
# variable is not present at all.
NUMERIC_TRANSFORMS = {
    gedi_lib.VERSION_002: {},
    gedi_lib.VERSION_003: {
        'land_cover_data/leaf_off_doy': None,
        'land_cover_data/leaf_on_cycle': None,
        'land_cover_data/leaf_on_doy': None,
        'quality_flag': 'l2a_quality_flag_rel3',
    },
}
STRING_TRANSFORMS = {
    gedi_lib.VERSION_002: {},
    gedi_lib.VERSION_003: {},
}


def get_inactive_variables(version: str) -> set[str]:
  """Returns the leaf names of variables that are inactive in this version."""
  inactive_vars = set()
  for v in numeric_variables:
    h5_path = NUMERIC_TRANSFORMS[version].get(v, v)
    if h5_path is None:
      inactive_vars.add(v.split('/')[-1])
  return inactive_vars


rh_names = tuple([f'rh{d}' for d in range(101)])


def extract_values(
    input_paths: Sequence[str],
    output_path: str,
    use_all_algorithms: bool = False,
    include_header: bool = True,
    post_process_df_fn: Callable[[pd.DataFrame], pd.DataFrame] | None = None,
) -> None:
  """Extracts all rh (relative heights) and some qa flags to CSV.

  The columns in the output CSV are, in order:
  * numeric variables
  * string variables
  * rh variables (rh0 to rh100)
  * gedi_lib.shot_breakdown_variables
  * gedi_lib.l2b_variables_for_l2a

  Args:
     input_paths: GEDI L2A and GEDI L2B file paths
     output_path: csv output file path
     use_all_algorithms: whether to read rh data from all algorithms
     include_header: whether to write a header row in the output CSV
     post_process_df_fn: optional function to transform DataFrame before writing
  """
  del use_all_algorithms  # unused for now
  l2a_path = input_paths[0]
  l2b_path = input_paths[1]

  basename = os.path.basename(l2a_path)
  if not basename.startswith('GEDI') or not basename.endswith('.h5'):
    logging.error('Input path is not a GEDI filename: %s', l2a_path)
    return
  try:
    version = gedi_lib.extract_version(basename)
  except ValueError:
    logging.exception('Unable to extract version from %s', basename)
    return

  with h5py.File(l2a_path, 'r') as l2a_hdf_fh:
    with h5py.File(l2b_path, 'r') as l2b_hdf_fh:
      with open(output_path, 'wb') as csv_fh:
        write_csv(
            l2a_hdf_fh,
            l2b_hdf_fh,
            csv_fh,
            version,
            include_header=include_header,
            post_process_df_fn=post_process_df_fn,
        )


def write_csv(
    l2a_hdf_fh: h5py.File,
    l2b_hdf_fh: h5py.File,
    csv_file: BinaryIO,
    version: str = gedi_lib.VERSION_002,
    include_header: bool = True,
    post_process_df_fn: Callable[[pd.DataFrame], pd.DataFrame] | None = None,
) -> None:
  """Writes a single CSV file based on the contents of HDF file.

  Args:
    l2a_hdf_fh: L2A HDF5 file handle.
    l2b_hdf_fh: L2B HDF5 file handle.
    csv_file: Output CSV file object.
    version: GEDI version.
    include_header: Whether to include CSV column header row.
    post_process_df_fn: Optional function to transform DataFrame before writing.
  """
  is_first = include_header

  # Build list of active variables and their H5 paths for this version.
  # List of tuples: (output_column_name, h5_variable_path)
  vars_to_extract = []
  for v in numeric_variables:
    h5_path = NUMERIC_TRANSFORMS[version].get(v, v)
    if h5_path is not None:
      vars_to_extract.append((v.split('/')[-1], h5_path))
  for v in string_variables:
    h5_path = STRING_TRANSFORMS[version].get(v, v)
    if h5_path is not None:
      vars_to_extract.append((v.split('/')[-1], h5_path))

  # Iterating over relative height percentage values from 0 to 100
  for k in l2a_hdf_fh.keys():
    if not k.startswith('BEAM'):
      continue
    print('\t', k)

    data = {}

    for df_key, h5_path in vars_to_extract:
      gedi_lib.hdf_to_df(l2a_hdf_fh, k, h5_path, data, df_key)

    rh_ds = l2a_hdf_fh[f'{k}/rh'][:]
    for idx, rh_name in enumerate(rh_names):
      data[rh_name] = rh_ds[:, idx]

    df = pd.DataFrame(data)
    gedi_lib.add_shot_number_breakdown(df)

    # Add the incidence angle variables from the corresponding L2B file.
    for l2b_var in gedi_lib.l2b_variables_for_l2a:
      gedi_lib.hdf_to_df(l2b_hdf_fh, k, 'geolocation/' + l2b_var, df)

    # Filter our rows with nan values for lat_lowestmode or lon_lowestmode.
    # Such rows are not ingestable into EE.
    df = df[df.lat_lowestmode.notnull()]
    df = df[df.lon_lowestmode.notnull()]

    # Correct fill replacements.
    for df_key, fill_value in integer_fill_variables.items():
      if df_key in df.columns:
        df[df_key] = df[df_key].fillna(fill_value)

    if post_process_df_fn is not None:
      df = post_process_df_fn(df)

    # PyArrow writes CSV files an order of magnitude faster than pandas.
    table = pyarrow.Table.from_pandas(df, preserve_index=False)
    pyarrow.csv.write_csv(
        table,
        csv_file,
        write_options=pyarrow.csv.WriteOptions(include_header=is_first),
    )
    is_first = False


def main(argv):
  extract_values(argv[1], argv[2])

if __name__ == '__main__':
  app.run(main)

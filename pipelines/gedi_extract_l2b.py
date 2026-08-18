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

import os
from typing import Any

from absl import app
from absl import logging
import h5py
import numpy as np
import pandas as pd

import gedi_lib

numeric_variables = (
    'cover',
    'pai',
    'fhd_normal',
    'pgap_theta',
    'beam',
    'l2b_quality_flag',
    'algorithmrun_flag',
    'selected_rg_algorithm',
    'selected_l2a_algorithm',
    'sensitivity',
    'geolocation/degrade_flag',
    'geolocation/delta_time',
    'geolocation/lat_lowestmode',
    'geolocation/lon_lowestmode',
    'geolocation/local_beam_azimuth',
    'geolocation/local_beam_elevation',
    'geolocation/solar_azimuth',
    'geolocation/solar_elevation',
)

integer_variables = frozenset((
    'beam',
    'l2b_quality_flag',
    'algorithmrun_flag',
    'selected_rg_algorithm',
    'selected_l2a_algorithm',
    'geolocation/degrade_flag',
))


string_variables = ('shot_number',)

# Describes how to transform variable names from different GEDI versions
# into the schema defined for V002. A value of None indicates that the
# variable is not present at all.
NUMERIC_TRANSFORMS = {
    gedi_lib.VERSION_002: {},
    gedi_lib.VERSION_003: {
        'geolocation/lat_lowestmode': 'lat_lowestmode',
        'geolocation/lon_lowestmode': 'lon_lowestmode',
        'l2b_quality_flag': 'l2b_quality_flag_rel3',
        'algorithmrun_flag': 'l2_algrunflag',
    },
}
STRING_TRANSFORMS = {
    gedi_lib.VERSION_002: {},
    gedi_lib.VERSION_003: {},
}

cover_names = [f'cover_z{d}' for d in range(30)]
pai_names = [f'pai_z{d}' for d in range(30)]
pavd_names = [f'pavd_z{d}' for d in range(30)]


# pylint:disable=line-too-long
def extract_values(input_paths: list[str], output_path: str) -> None:
  """Extracts GEDI L2B values to CSV.

  The columns in the output CSV are, in order:
  * numeric variables
  * string variables
  * cover_z variables (30 slices)
  * pai_z variables (30 slices)
  * pavd_z variables (30 slices)
  * gedi_lib.shot_breakdown_variables

  Args:
     input_paths: GEDI L2B file path in a single-element list
     output_path: csv output file path
  """
  assert len(input_paths) == 1
  input_path = input_paths[0]
  basename = os.path.basename(input_path)
  if not basename.startswith('GEDI') or not basename.endswith('.h5'):
    logging.error('Input path is not a GEDI filename: %s', input_path)
    return
  try:
    version = gedi_lib.extract_version(basename)
  except ValueError:
    logging.exception('Unable to extract version from %s', basename)
    return

  with h5py.File(input_path, 'r') as hdf_fh:
    with open(output_path, 'w') as csv_fh:
      write_csv(hdf_fh, csv_fh, version)


def write_csv(
    hdf_fh: h5py.File,
    csv_file: Any,
    version: str = gedi_lib.VERSION_002,
) -> None:
  """Writes a single CSV file based on the contents of HDF file.

  Args:
    hdf_fh: HDF5 file handle.
    csv_file: Output CSV file object.
    version: GEDI version.
  """
  is_first = True

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

  # Iterating over metrics using a height profile defined for 30 slices.
  for k in hdf_fh.keys():
    if not k.startswith('BEAM'):
      continue
    print('\t', k)

    df = pd.DataFrame()

    for df_key, h5_path in vars_to_extract:
      gedi_lib.hdf_to_df(hdf_fh, k, h5_path, df, df_key)

    ds = hdf_fh[f'{k}/cover_z']
    cover_z = pd.DataFrame(ds, columns=cover_names)
    # pytype: disable=wrong-arg-count  # pandas-drop-duplicates-overloads
    cover_z.replace(ds.attrs.get('_FillValue'), np.nan, inplace=True)

    ds = hdf_fh[f'{k}/pai_z']
    pai_z = pd.DataFrame(ds, columns=pai_names)
    pai_z.replace(ds.attrs.get('_FillValue'), np.nan, inplace=True)

    ds = hdf_fh[f'{k}/pavd_z']
    pavd_z = pd.DataFrame(ds, columns=pavd_names)
    pavd_z.replace(ds.attrs.get('_FillValue'), np.nan, inplace=True)
    # pytype: enable=wrong-arg-count  # pandas-drop-duplicates-overloads

    df = pd.concat((df, cover_z), axis=1)
    df = pd.concat((df, pai_z), axis=1)
    df = pd.concat((df, pavd_z), axis=1)

    # Filter our rows with nan values for lat_lowestmode or lon_lowestmode.
    # Such rows are not ingestable into EE.
    df = df[df.lat_lowestmode.notnull()]
    df = df[df.lon_lowestmode.notnull()]

    gedi_lib.add_shot_number_breakdown(df)

    df.to_csv(
        csv_file,
        float_format='%3.6f',
        index=False,
        header=is_first,
        mode='a',
        lineterminator='\n',
    )
    is_first = False


def main(argv):
  extract_values(argv[1], argv[2])


if __name__ == '__main__':
  app.run(main)

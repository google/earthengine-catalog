"""Units used throughout the Earth Engine catalog.

Reads from the units listed here:

https://github.com/google/earthengine-catalog/blob/main/catalog/units.libsonnet
"""

import json
import os

from google3.pyglib import resources

path = os.path.join(
    resources.GetARootDirWithAllResources(),
    'google3/third_party/earthengine_catalog/catalog/units.json',
)
with open(path, 'r') as f:
  data_dict = json.load(f)


UNITS = frozenset(data_dict.values())
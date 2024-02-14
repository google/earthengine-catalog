local id_prefix = 'USGS/NLCD_RELEASES';
local subdir = 'USGS';

local ee_const = import 'earthengine_const.libsonnet';

{
  id(year)::
    local prefix = id_prefix + '/' + year + '_REL';
    if year == 2016 then prefix else prefix + '/NLCD',

  provider_url(id)::
    local basename = std.strReplace(id, '/', '_');
    ee_const.ee_catalog_url + basename,

  link_url(id)::
    local basename = std.strReplace(id, '/', '_');
    local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
    catalog_subdir_url + basename + '.json',
}
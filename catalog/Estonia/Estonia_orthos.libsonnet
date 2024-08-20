local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local license = spdx.proprietary;

{
  description: |||
    Orthophotos are an aerial photo dataset covering Estonia.

    An orthophoto is a processed aerial photo from which distortions caused
    by terrain relief, camera tilt relative to the ground at the moment of
    exposure and camera central projection are removed. A digital orthophoto
    has a certain pixel size or resolution which shows the smallest
    indivisible exposed area on the ground (Ground Sampling Distance, GSD).

    Orthophotos have a nationwide coverage and correspond to the scale of
    1:5000-1:10000 (pixel size 20-40 cm). Orthophotos for densely-populated
    areas are produced with the pixel size of 10-16 cm.

  |||,
  providers(name, catalog_url): [
    ee.producer_provider(
    'Estonia orthophotos',
    'https://geoportaal.maaamet.ee/eng/Spatial-Data/Orthophotos-p309.html'
    ),
    ee.host_provider(catalog_url),
  ],
  license: license.id,
  extent: ee.extent(57.3, 21.5, 59.5, 28.1,
                    '1993-01-01T00:00:00Z', '2021-06-16T00:00:00Z'),
  citation: 'Map data: Estonian Land Board',
  terms_of_use: |||
    The data is free to use for commercial and non-commercial purposes for a
    non-specified term, provided that proper attribution is given to the
    licensor (e.g. Estonian Land Board) along with the title and age of the
    data.

    For more details please see the
    [Terms of use](https://geoportaal.maaamet.ee/docs/Avaandmed/Licence-of-open-data-of-Estonian-Land-Board.pdf)
  |||,
}

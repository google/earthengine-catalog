local subdir = 'ESA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

{
  v100: '100',

  // Returns a related link to the catalog entry for the given worldcereal ID.
  link(id):: {
    rel: ee_const.rel.related,
    title: id,
    href: ee_const.ee_catalog_url + std.strReplace(id, '/', '_'),
    type: ee_const.media_type.stac,
  },

  doi_v100: '10.5194/essd-2023-184',
  citation_v100: |||
    Van Tricht, K., Degerickx, J., Gilliams, S., Zanaga, D., Battude, M., Grosu,
    A., Brombacher, J., Lesiv, M., Bayas, J. C. L., Karanam, S., Fritz, S.,
    Becker-Reshef, I., Franch, B., Mollà-Bononad, B., Boogaard, H., Pratihast,
    A. K., and Szantoi, Z.: WorldCereal: a dynamic open-source system for
    global-scale, seasonal, and reproducible crop and irrigation mapping, Earth
    Syst. Sci. Data Discuss. [preprint],
    [doi:10.5194/essd-2023-184](https://doi.org/10.5194/essd-2023-184), in
    review, 2023.,
  |||,
}
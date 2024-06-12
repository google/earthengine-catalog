local id = 'NOAA/IBTrACS/v4';
local subdir = 'NOAA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_ver,
  ],
  id: id,
  title: 'International Best Track Archive for Climate Stewardship Project',
  version: '4.0',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The International Best Track Archive for Climate Stewardship (IBTrACS)
    provides location and intensity for global tropical cyclones. The data span
    from the 1840s to present, generally providing data at 3-hour intervals.
    While the best track data is focused on position and intensity
    (maximum sustained wind speed or minimum central pressure), other parameters
    are provided by some agencies (e.g., radius of maximum winds, environmental
    pressure, radius of hurricane force winds, etc.) and are likewise provided
    in IBTrACS. Files are available subset by Basin or time period, where basins
    include: East Pacific, North Atlantic, North Indian, South Atlantic,
    South Indian, South Pacific, and the West Pacific.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
    {
      rel: ee_const.rel.source,
      href: 'https://www.ncei.noaa.gov/data/international-best-track-archive-for-climate-stewardship-ibtracs/v04r00/access/csv/ibtracs.ALL.list.v04r00.csv',
    },
  ],
  keywords: [
    'hurricane',
    'noaa',
    'weather',
  ],
  providers: [
    ee.producer_provider('NOAA NCEI', 'https://www.ncei.noaa.gov/products/international-best-track-archive'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, 0.4, 180.0, 63.1,
                    '1842-10-25T00:00:00Z', '2024-05-19T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'SID',
        description: 'Storm Identifier',
        type: ee_const.var_type.string,
      },
      {
        name: 'SEASON',
        description: 'Year in which the storm occurred',
        type: ee_const.var_type.double,
      },
      {
        name: 'NUMBER',
        description: |||
          The cardinal number of the system for that season.
          The count includes all basins, so this will not be continuous for
          basin files.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'BASIN',
        description: |||
          Basins include:

          * NA: North Atlantic
          * EP: Eastern North Pacific
          * WP: Western North Pacific
          * NI: North Indian
          * SI: South Indian
          * SP: Southern Pacific
          * SA: South Atlantic
          * MM: Missing - should not appear in final IBTrACS product
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SUBBASIN',
        description: |||
          Subbasins include:

          * MM: missing - no sub basin for this basin
            (no subbasins provided for WP, SI)
          * CS: Caribbean Sea
          * GM: Gulf of Mexico
          * CP: Central Pacific
          * BB: Bay of Bengal
          * AS: Arabian Sea
          * WA: Western Australia
          * EA: Eastern Australia
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'NAME',
        description: 'Name provided by the agency',
        type: ee_const.var_type.string,
      },
      {
        name: 'ISO_TIME',
        description: |||
          ISO Time provided in Universal Time Coordinates (UTC).
          Format is YYYY-MM-DD HH:mm:ss
          Most points are provided at 6 hour intervals.
          Some agencies provided 3 hour points (e.g., New Delhi) or times at
          important observations (e.g.,landfall times in the North Atlantic,etc)
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'NATURE',
        description: |||
          Combined storm type.
          This is assigned based on all available storm types.
          Values:

          * DS: Disturbance
          * TS: Tropical
          * ET: Extratropical
          * SS: Subtropical
          * NR: Not reported
          * MX: Mixture (contradicting nature reports from different agencies)
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'WMO_WIND',
        description: |||
          Maximum sustained wind speed from the WMO agency for the current
          location.
          NO adjustment is made for differences in wind speed averaging periods.
          hurdat/atcf = North Atlantic - U.S. Miami (NOAA NHC) - 1-minute winds
          tokyo = RSMC Tokyo (JMA) - 10-minute
          newdelhi = RSMC New Delhi (IMD) - 3-minute
          reunion = RSMC La Reunion (MFLR) - 10 minute
          bom = Australian TCWCs (TCWC Perth, Darwin, Brisbane) - 10-minute
          nadi = RSMC Nadi (FMS) - 10 minute
          wellington = TCWC Wellington (NZMS) - 10-minute
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'WMO_PRES',
        description: |||
          Minimum central pressure assigned by the responsible WMO agnecy
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'WMO_AGENCY',
        description: |||
          This is the reporting agency responsible for the basin as currently
          listed.It should be noted that many of the agencies did not accept
          official WMO responsibility until relatively recently,
          e.g., La Reunion in 1993 or IMD in 1990. Therefore the WMO agency is
          used loosely to describe the currently responsible agency.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'TRACK_TYPE',
        description: |||
          Track type
          Tropical storms can interact.
          Values:

          * PROVISIONAL: Real time data used to populate the position and other
            parameters of this system.This is a provisional track that will be
            replaced when reanalysis of the storm is performed. (Usually within
            2 years of the storm's occurence)
          * PROVISIONAL_spur: Real time data (see provisional description above)
            but due to differences in positions between various inputs,
            algorithm can not identify accurate position. When counting storms,
            these should not likely be counted. These should be rare for
            PROVISIONAL data.
          * MAIN: primary track associated with a storm system.
            This is a track that has had some reanalysis and is higher quality
            than provisional data.
          * spur: usually short lived tracks associated with a main track and
            often represents alternate positions at the beginning of a system.
            Can also represent actual system interactions (e.g., Fujiwhara
            interactions).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'DIST2LAND',
        description: |||
          Distance to land from the current position.
          The land dataset includes all continents and any islands larger than
          1400 km^2. The distance is the nearest at the present time in any
          direction.
        |||,
        type: ee_const.var_type.double,
        units: units.kilometer,
      },
      {
        name: 'LANDFALL',
        description: |||
          Nearest location to land within next 6 hours.
          This can be thought of a landfall flag:
          =0 -- Landfall within 6 hours.
          >0 -- No landfall within next 6 hours.
          Calculations are based on storm center (columns 9,10).
          Values less than 60 nmile likely are impacted by the system even
          though the center of the system is not over land.
          The uses the same land mask as DIST2LAND.
        |||,
        type: ee_const.var_type.double,
        units: units.kilometer,
      },
      {
        name: 'IFLAG',
        description: |||
          Interpolation Flag
          A 14 character flag string which denotes the source of each agency's
          report.
          Values:

          * _: missing reports. No information provided.
          * O: original report as provided by the agency.
          * P: position was interpolated (all variables were
            interpolated/filled, including intensity)
          * I: Position was provided, but Intensity variables
            (and likely other variables) were interpolated/filled
          * V: Position and intensity variables are original but
            some variables were interpolated/filled.

          The order of the 14 characters refers to the following 14 datasets:

          * 1: USA Agency (see column 18)
          * 2: Tokyo
          * 3: CMA
          * 4: HKO
          * 5: NewDelhi
          * 6: Reunion
          * 7: BoM
          * 8: Nadi
          * 9: Wellington
          * 10: ds824
          * 11: TD9636
          * 12: TD9635
          * 13: Neumann Southern Hemisphere data set
          * 14: M.L. Chenoweth N Atlantic Historic dataset
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'USA_AGENCY',
        description: |||
          The agency file providing the information:
          The representative US agency data is derived from a hierarchical
          selection: the first dataset in the following list to provide
          information at the given time is used as the USA_agency.
          Values:

          * HURDAT_ATL
          * HURSAT_EPA
          * ATCF (for NA and EP basins only)
          * JTWC_WP
          * JTWC_IO
          * JTWC_EP
          * JTWC_CP
          * JTWC_SH
          * CPHC [separate file provided by CPHC for years 1966-2003, 2008]
          * tcvitals - THIS INDICATES THAT THE DATA ARE PRELIMINARY

          While these agencies are generally orthogonal, there are cases where
          a system is provided in more than one source.
          In this case, the report from the highest source is used.
          ATCF format info from: https://www.nrlmry.navy.mil/atcf_web/docs/database/new/abdeck.txt
          HURDAT2 info from:
          http://www.nhc.noaa.gov/data/hurdat/hurdat2-format-atlantic.pdf
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'USA_ATCF_ID',
        description: |||
          The ATCF ID is assigned by US agencies and can be used to comparethe
          storm with other US cyclone-related datasets.
          If two (or more) ATCF tracks make up one storm, then the IDs are
          separated by a colon.
          The format of the ATCF ID is B<bb><nn><yyyy> where bb is the basin ID,
          nn is the number of the
          storm in that basin and yyyy is the year.
          Possible basin values are:

          * AL: North Atlantic
          * SL: South Atlantic
          * EP: East Pacific
          * WP: West Pacific
          * SH: Southern Hemisphere
          * IO: North Indian

          For the provisional data, other basin identifiers were provided that
          include:

          * CP: Central Pacific
          * SP: South Pacific
          * SI: South Indian
          * AS: Arabian Sea (North Indian)
          * BB: Bay of Bengal (North Indian)
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'USA_LAT',
        description: |||
          USA Latitude
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'USA_LON',
        description: |||
          USA Longitude
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'USA_RECORD',
        description: |||
          Record identifier.
          Values:

          * C: Closest approach to a coast, not followed by a landfall
          * G: Genesis
          * I: An intensity peak in terms of both pressure and wind
          * L: Landfall (center of system crossing a coastline)
          * P: Minimum in central pressure
          * R: Provides additional detail on the intensity of the cyclone when
               rapid changes are underway
          * S: Change of status of the system
          * T: Provides additional detail on the track (position) of the cyclone
          * W: Maximum sustained wind speed
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'USA_STATUS',
        description: |||
          Status of system.
          Values:

          * DB: disturbance
          * TD: tropical depression
          * TS: tropical storm
          * TY: typhoon
          * ST: super typhoon
          * TC: tropical cyclone
          * HU,HR: hurricane
          * SD: subtropical depression
          * SS: subtropical storm
          * EX: extratropical systems
          * PT: post tropical
          * IN: inland
          * DS: dissipating
          * LO: low
          * WV: tropical wave
          * ET: extrapolated
          * MD: monsoon depression
          * XX: unknown
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'USA_WIND',
        description: |||
          Maximum sustained wind speed in knots: 0 - 300 kts
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'USA_PRES',
        description: |||
          Minimum sea level pressure, 850 - 1050 mb.
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'USA_SSHS',
        description: |||
          Saffir-Simpson Hurricane Scale information based on the wind speed
          provided by the US agency wind speed (US agencies provide
          1-minute wind speeds)
          Values:

          * -5: Unknown [XX]
          * -4: Post-tropical [EX, ET, PT]
          * -3: Miscellaneous disturbances [WV, LO, DB, DS, IN, MD]
          * -2: Subtropical [SS, SD]

          Tropical systems classified based on wind speeds
          [TD, TS, HU, TY,, TC, ST, HR]
          Values:

          * -1: Tropical depression (W<34)
          * 0: Tropical storm [34<W<64]
          * 1: Category 1 [64<=W<83]
          * 2: Category 2 [83<=W<96]
          * 3: Category 3 [96<=W<113]
          * 4: Category 4 [113<=W<137]
          * 5: Category 5 [W >= 137]
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'USA_R34_NE',
        description: |||
          34 kt wind radii maximum extent in northeastern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_R34_SE',
        description: |||
          34 kt wind radii maximum extent in southeastern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_R34_SW',
        description: |||
          34 kt wind radii maximum extent in southwestern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_R34_NW',
        description: |||
          34 kt wind radii maximum extent in northwestern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_R50_NE',
        description: |||
          50 kt wind radii maximum extent in northeastern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_R50_SE',
        description: |||
          50 kt wind radii maximum extent in southeastern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_R50_SW',
        description: |||
          50 kt wind radii maximum extent in southwestern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_R50_NW',
        description: |||
          50 kt wind radii maximum extent in northwestern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_R64_NE',
        description: |||
          64 kt wind radii maximum extent in northeastern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_R64_SE',
        description: |||
          64 kt wind radii maximum extent in southeastern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_R64_SW',
        description: |||
          64 kt wind radii maximum extent in southwestern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_R64_NW',
        description: |||
          64 kt wind radii maximum extent in northwestern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_POCI',
        description: |||
          pressure in millibars of the last closed isobar, 900 - 1050 mb
          NOT BEST-TRACKED (not reanalyzed)
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'USA_ROCI',
        description: |||
          radius of the last closed isobar, 0 - 999 n mi.
          NOT BEST TRACKED (not reanalyzed)
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_RMW',
        description: |||
          radius of max winds, 0 - 999 n mi.
          NOT BEST TRACKED (not reanalyzed)
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_EYE',
        description: |||
          eye diameter, 0 - 120 n mi.
          NOT BEST TRACKED (not reanalyzed)
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'TOKYO_LAT',
        description: |||
          Tokyo Latitude
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'TOKYO_LON',
        description: |||
          Tokyo Longitude
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'TOKYO_GRADE',
        description: |||
          Grade
          Values:

          * 1: Not used
          * 2: Tropical Depression (TD)
          * 3: Tropical Storm (TS)
          * 4: Severe Tropical Storm (STS)
          * 5: Typhoon (TY)
          * 6: Extratropical Cyclone (L)
          * 7: Just entering into the responsible area of
            Japan Meteorological Agency (JMA)
          * 8: Not used
          * 9 : Tropical Cyclone of TS intensity or higher

        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'TOKYO_WIND',
        description: |||
          Maximum sustained wind speed [10-min averaging period]
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'TOKYO_PRES',
        description: |||
          Central pressure
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'TOKYO_R50_DIR',
        description: |||
          Values:

          * 1: Northeast (NE)
          * 2: East (E)
          * 3: Southeast (SE)
          * 4: South (S)
          * 5: Southwest (SW)
          * 6: West (W)
          * 7: Northwest (NW)
          * 8: North (N)
          * 9: (symmetric circle)

        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'TOKYO_R50_LONG',
        description: |||
          The longest radius of 50kt winds or greater
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'TOKYO_R50_SHORT',
        description: |||
          The shortest radius of 50kt winds or greater
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'TOKYO_R30_DIR',
        description: |||
          Values:

          * 1: Northeast (NE)
          * 2: East (E)
          * 3: Southeast (SE)
          * 4: South (S)
          * 5: Southwest (SW)
          * 6: West (W)
          * 7: Northwest (NW)
          * 8: North (N)
          * 9: (symmetric circle)

        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'TOKYO_R30_LONG',
        description: |||
          The longest radius of 30kt winds or greater
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'TOKYO_R30_SHORT',
        description: |||
          The shortest radius of 30kt winds or greater
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'TOKYO_LAND',
        description: |||
          Landfall or passage over the Japanese islands occurred within
          one hour after the time of the analysis with this indicator.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'CMA_LAT',
        description: |||
          CMA Latitude
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'CMA_LON',
        description: |||
          CMA Longitude
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'CMA_CAT',
        description: |||
          Intensity category according to the Chinese National Standard for
          Grade of Tropical Cyclones (which has been used since 15 June 2006).
          Values:

          * 0: Weaker than Tropical Depression or unknown intensity
          * 1: Tropical Depression (TD: 10.8-17.1 m/s)
          * 2: Tropical Storm (TS:17.2-24.4 m/s)
          * 3: Severe Tropical Storm (STS: 24.5-32.6 m/s)
          * 4: Typhoon (TY: 32.7-41.4 m/s)
          * 5: Severe Typhoon (STY: 41.5-50.9 m/s)
          * 6: Super Typhoon (SuperTY: ≥51.0 m/s)
          * 9: Extratropical Cyclone (ET) stage
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'CMA_WIND',
        description: |||
          Two-minute mean maximum sustained wind (MSW; m/s) near the TC center.
          WND = 9 indicates MSW < 10 m/s, WND = 0 indicates unknown intensity.
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'HKO_LAT',
        description: |||
          HKO Latitude
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'HKO_LON',
        description: |||
          USA Longitude
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'HKO_CAT',
        description: |||
          After 2009, we further classified two more storm types above typhoon,
          so there are in total 7 storm types
          LW (Low) <22 kt
          TD (Tropical Depression) 22 - 33 kt
          TS (Tropical Storm) 34 - 47 kt
          STS (Severe Tropical Storm) 48 - 63 kt
          T (Typhoon) 64 - 80 kt
          ST (Severe Typhoon) 81 - 99 kt
          SuperT (Super Typhoon) >= 100 kt
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'HKO_WIND',
        description: |||
          Maximum sustained wind speed
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'HKO_PRES',
        description: |||
          Minimum sea level pressure
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'NEWDELHI_LAT',
        description: |||
          NewDelhi Latitude
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'NEWDELHI_LON',
        description: |||
          NewDelhi Longitude
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'NEWDELHI_GRADE',
        description: |||
          Types of disturbances:

          * Low pressure area: W<17 knots
          * D: Depression 17<=W<28
          * DD: Deep Depression 28<=W<34
          * CS: Cyclonic Storm 34<=W<48
          * SCS: Severe Cyclonic Storm 48<=W<64
          * VSCS: Very Severe Cyclonic Storm 64<=W<120
          * SCS: Super Cyclonic Storm W>=120 knots
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'NEWDELHI_WIND',
        description: |||
          Maximum sustained wind speed
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'NEWDELHI_PRES',
        description: |||
          Minimum sea level pressure
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'NEWDELHI_CI',
        description: |||
          Dvorak CI-number
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'NEWDELHI_DP',
        description: |||
          New Delhi DP
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'NEWDELHI_POCI',
        description: |||
          Environmental pressure in which the cyclone is embedded
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'REUNION_LAT',
        description: |||
          Reunion Latitude
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'REUNION_LON',
        description: |||
          Reunion Longitude
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'REUNION_TYPE',
        description: |||
          Values:

          * 01: tropics; disturbance ( no closed isobars)
          * 02: <34 knot winds, <17m/s winds and at least one closed isobar
          * 03: 34-63 knots, 17-32m/s
          * 04: >63 knots, >32m/s
          * 05: extratropical
          * 06: dissipating
          * 07: subtropical cyclone (nonfrontal, low pressure system that
                comprises initially baroclinic circulation developing over
                subtropical water)
          * 08: overland
          * 09: unknown
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'REUNION_WIND',
        description: |||
          Maximum average wind speed
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'REUNION_PRES',
        description: |||
          Central pressure
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'REUNION_TNUM',
        description: |||
          Dvorak T-number
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'REUINION_CI',
        description: |||
          Dvorak CI-number
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'REUNION_RMW',
        description: |||
          Radius of maximum winds 
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'REUNION_R34_NE',
        description: |||
          34 kt wind radii maximum extent in northeastern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'REUNION_R34_SE',
        description: |||
          34 kt wind radii maximum extent in southeastern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'REUNION_R34_SW',
        description: |||
          34 kt wind radii maximum extent in southwestern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'REUNION_R34_NW',
        description: |||
          34 kt wind radii maximum extent in northwestern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'REUNION_R50_NE',
        description: |||
          50 kt wind radii maximum extent in northeastern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'REUNION_R50_SE',
        description: |||
          50 kt wind radii maximum extent in southeastern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'REUNION_R50_SW',
        description: |||
          50 kt wind radii maximum extent in southwestern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'REUNION_R50_NW',
        description: |||
          50 kt wind radii maximum extent in northwestern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'REUNION_R64_NE',
        description: |||
          64 kt wind radii maximum extent in northeastern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'REUNION_R64_SE',
        description: |||
          64 kt wind radii maximum extent in southeastern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'REUNION_R64_SW',
        description: |||
          64 kt wind radii maximum extent in southwestern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'REUNION_R64_NW',
        description: |||
          64 kt wind radii maximum extent in northwestern quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_LAT',
        description: |||
          BOM Latitude
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'BOM_LON',
        description: |||
          BOM Longitude
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'BOM_TYPE',
        description: |||
          This indicates the type of system that this cyclone was at the time of
          the observation. Note that cyclones can evolve during their lifetimes
          and hence change type mid-stream (e.g. Extratropical transition (ETT))

          | ADAM Code | Type of Cyclone                                                                                                                                             | WMO Code |
          | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
          | NULL      | Default - unknown                                                                                                                                           | 09       |
          | 10        | Tropics; disturbance ( no closed isobars)                                                                                                                   | 01       |
          | 20        | <34 knot (17m/s) winds, and at least one closed isobar                                                                                                      | 02       |
          | 21        | 34-63 knots (17-32m/s) two or less quadrants                                                                                                                | 02       |
          | 30        | 34-63 knots (17-32m/s) more than two quadrants                                                                                                              | 03       |
          | 40        | >63 knots (>32m/s)                                                                                                                                          | 04       |
          | 50        | Extra-tropical (no gales)                                                                                                                                   | 05       |
          | 51        | Extra-tropical (with gales)                                                                                                                                 | 05       |
          | 52        | Extra-tropical (max wind unknown)                                                                                                                           | 05       |
          | 60        | Dissipating (no gales)                                                                                                                                      | 06       |
          | 70        | Subtropical cyclone (non-frontal, low pressure system that comprises initially baroclinic circulation developing over subtropical water) (no gales)         | 07       |
          | 71        | Subtropical cyclone (non-frontal, low pressure system that comprises initially baroclinic circulation developing over subtropical water) (with gales)       | 07       |
          | 72        | Subtropical cyclone (non-frontal, low pressure system that comprises initially baroclinic circulation developing over subtropical water) (max wind unknown) | 07       |
          | 80        | Overland (no gales)                                                                                                                                         | 08       |
          | 81        | Overland (gales)                                                                                                                                            | 08       |
          | 91        | Tropical Cold-cored - Monsoon Low (with surrounding gales away from centre)                                                                                 | 09       |

        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'BOM_WIND',
        description: |||
          This is the estimated maximum mean wind around the cyclone - that is
          in the vicinity of the centre
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'BOM_PRES',
        description: |||
          Central pressure of the cyclone
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'BOM_TNUM',
        description: |||
          Dvorak T-number
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'BOM_CI',
        description: |||
          Dvorak CI-number
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'BOM_RMW',
        description: |||
          This is the mean radius (from the system centre) of the maximum mean
          wind
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_R34_NE',
        description: |||
          This is the mean radius (from the system centre) of the extent of
          winds; gale-force (17m/s) or above. The four sectors show the mean
          extent in the respective quadrant centred on the cardinal point.
          Northeast quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_R34_SE',
        description: |||
          This is the mean radius (from the system centre) of the extent of
          winds; gale-force (17m/s) or above. The four sectors show the mean
          extent in the respective quadrant centred on the cardinal point.
          Southeast quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_R34_SW',
        description: |||
          This is the mean radius (from the system centre) of the extent of
          winds; gale-force (17m/s) or above. The four sectors show the mean
          extent in the respective quadrant centred on the cardinal point.
          Southwest quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_R34_NW',
        description: |||
          This is the mean radius (from the system centre) of the extent of
          winds; gale-force (17m/s) or above. The four sectors show the mean
          extent in the respective quadrant centred on the cardinal point.
          Northwest quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_R50_NE',
        description: |||
          This is the mean radius (from the system centre) of the extent of
          winds; gale-force (25m/s) or above. The four sectors show the mean
          extent in the respective quadrant centred on the cardinal point.
          Northeast quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_R50_SE',
        description: |||
          This is the mean radius (from the system centre) of the extent of
          winds; gale-force (25m/s) or above. The four sectors show the mean
          extent in the respective quadrant centred on the cardinal point.
          Southeast quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_R50_SW',
        description: |||
          This is the mean radius (from the system centre) of the extent of
          winds; gale-force (25m/s) or above. The four sectors show the mean
          extent in the respective quadrant centred on the cardinal point.
          Southwest quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_R50_NW',
        description: |||
          This is the mean radius (from the system centre) of the extent of
          winds; gale-force (25m/s) or above. The four sectors show the mean
          extent in the respective quadrant centred on the cardinal point.
          Northwest quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_R64_NE',
        description: |||
          This is the mean radius (from the system centre) of the extent of
          winds; gale-force (33m/s) or above. The four sectors show the mean
          extent in the respective quadrant centred on the cardinal point.
          Northeast quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_R64_SE',
        description: |||
          This is the mean radius (from the system centre) of the extent of
          winds; gale-force (33m/s) or above. The four sectors show the mean
          extent in the respective quadrant centred on the cardinal point.
          Southeast quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_R64_SW',
        description: |||
          This is the mean radius (from the system centre) of the extent of
          winds; gale-force (33m/s) or above. The four sectors show the mean
          extent in the respective quadrant centred on the cardinal point.
          Southwest quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_R64_NW',
        description: |||
          This is the mean radius (from the system centre) of the extent of
          winds; gale-force (33m/s) or above. The four sectors show the mean
          extent in the respective quadrant centred on the cardinal point.
          Northwest quadrant
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_ROCI',
        description: |||
          The estimated mean radius of the outermost closed isobar
          (1-hPa spacing).
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_POCI',
        description: |||
          Environmental pressure in which the cyclone is embedded
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'BOM_EYE',
        description: |||
          Mean radius of the cyclone eye.
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'BOM_POS_METHOD',
        description: |||
          This indicates the tools that were used to derive the centre location
          of the system.
          Values:

          * NULL: Default - unknown
          * 1: no sat, no rad, no obs
          * 2: no sat, no rad, obs only
          * 3: Sat IR/Vis; no clear eye
          * 4: Sat IR/Vis; clearly defined eye
          * 5: aircraft radar report
          * 6: land-based radar report
          * 7: Sat IR/Vis & rad & obs
          * 8: report inside eye
          * 10: Sat- Scatterometer
          * 11: Sat- Microwave
          * 12: Manned Aircraft Reconnaissance
          * 13: UAV Aircraft Reconnaissance
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'BOM_PRES_METHOD',
        description: |||
          This code may need to be expanded to handle new systems in the future,
          and also to differentiate between pressure-wind relationships used to
          derive the central pressure.

          | ADAM Code | Method                               | WMO Code |
          | --------- | ------------------------------------ | -------- |
          | NULL      | Unknown or N/A                       |          |
          | 1         | Aircraft or Dropsonde observation    | 1        |
          | 2         | Over water observation (e.g. buoy)   | 2        |
          | 3         | Over land observation                | 3        |
          | 4         | Instrument - unknown type            | 5        |
          | 5         | Derived Directly from DVORAK         | 4        |
          | 6         | Derived from wind via a P-W equation | 5        |
          | 7         | Estimate from surrounding obs        | 5        |
          | 8         | Extrapolation from radar             | 5        |
          | 9         | Other                                | 5        |
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'NADI_LAT',
        description: |||
          Cyclone latitude from RSMC Nadi, Fiji
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'NADI_LON',
        description: |||
          Cyclone longitude from RSMC Nadi, Fiji
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'NADI_CAT',
        description: |||
          Nadi assigned category
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'NADI_WIND',
        description: |||
          Nadi assigned wind speed
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      }
      {
        name: 'NADI_PRES',
        description: |||
          Nadi assigned central pressure
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      }
      {
        name: 'WELLINGTON_LAT',
        description: |||
          Cyclone latitude from TCWC Wellington
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'WELLINGTON_LON',
        description: |||
          Cyclone longitude from TCWC Wellington
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'WELLINGTON_WIND',
        description: |||
          Wellington assigned wind speed
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'WELLINGTON_PRES',
        description: |||
          Wellington assigned central pressure
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'DS824_LAT',
        description: |||
          Cyclone latitude from dataset 824
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'DS824_LON',
        description: |||
          Cyclone longitude from dataset 824
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'DS824_STAGE',
        description: |||
          TC - Tropical cyclone
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'DS824_WIND',
        description: |||
          Maximum wind speed
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'DS824_PRES',
        description: |||
          Central pressure
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'TD9636_LAT',
        description: |||
          Cyclone latitude from NCEI dataset TD9636
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'TD9636_LON',
        description: |||
          Cyclone longitude from NCEI dataset TD9636
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'TD9636_STAGE',
        description: |||
          This field gives an estimate of the highest winds occurring in the
          storm at the time and location
          indicated. The entire storm was coded as to the highest stage reached
          for some of the earlier years.
          Values:

          * 0: Tropical disturbance (1969 onward)
          * 1: depression < 34 [some variation in definition for S Indian]
          * 2: Storm 34-63 [with some variation in definition for S Indian]
          * 3: point where wind reached 64 knots [except N Indian where it is
              wind 43-47 knots]
          * 4: Hurricane > 64 [except in N Indian, Wind > 48]
          * 5: Extratropical
          * 6: Dissipating
          * 7: Unknown Intensity or doubtful track
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'TD9636_WIND',
        description: |||
          Estimated highest wind speed at the time indicated. These estimates
          are subjective and must be interpreted with caution.
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'TD9636_PRES',
        description: |||
          Minimum sea level pressure
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'TD9635_ROCI',
        description: |||
          Size. (Radius of system)
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'NEUMANN_LAT',
        description: |||
          Cyclone latitude from C. Neumann Souther Hemisphere dataset
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'NEUMANN_LON',
        description: |||
          Cyclone longitude from C. Neumann Souther Hemisphere dataset
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'NEUMANN_CLASS',
        description: |||
          Values:

          * EX: Extratropical
          * TC: Tropical
          * MM: Missing
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'NEUMANN_WIND',
        description: |||
          Maximum wind speed
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'NEUMANN_PRES',
        description: |||
          Central pressure
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'MLC_LAT',
        description: |||
          Cyclone latitude from M. Chenoweth dataset
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'MLC_LON',
        description: |||
          Cyclone longitude from M. Chenoweth dataset
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
      {
        name: 'MLC_CLASS',
        description: |||
          Storm classification
          Values:

          * EX: Extratropical
          * HU: Hurricane
          * LO: Low
          * MH:
          * SD: Subtropical depression
          * SS: Subtropical storm
          * TD: Tropical Depression
          * TS: Tropical Storm
          * TW:
          * WV: Open Wave
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'MLC_WIND',
        description: |||
          Maximum wind speed
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'MLC_PRES',
        description: |||
          Central pressure
        |||,
        type: ee_const.var_type.double,
        units: units.millibar,
      },
      {
        name: 'USA_GUST',
        description: |||
          Gust reportd by the USA_AGENCY.
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'BOM_GUST',
        description: |||
          This is the estimated maximum wind gust around the cyclone - that is
          in the vicinity of the centre based on open terrain estimate
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'BOM_GUST_PER',
        description: |||
          This is the period of the gust used when measuring max wind gusts.
          This parameter will only be used when receiving data in WMO format
          that is not based on 3-sec gusts. All Australian based data should be
          based on 3-sec gusts.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'REUNION_GUST',
        description: |||
          Maximum Wind Gust
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'REUNION_GUST_PER',
        description: |||
          Gust Period
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'USA_SEAHGT',
        description: |||
          Wave height for radii defined in SEARAD
        |||,
        type: ee_const.var_type.double,
        units: units.foot,
      },
      {
        name: 'USA_SEARAD_NE',
        description: |||
          Radial extent of seas (as defined in SEAHGT) extending from storm
          center to the Northeast.
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_SEARAD_SE',
        description: |||
          Radial extent of seas (as defined in SEAHGT) extending from storm
          center to the Southeast.
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_SEARAD_SW',
        description: |||
          Radial extent of seas (as defined in SEAHGT) extending from storm
          center to the Southwest.
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'USA_SEARAD_NW',
        description: |||
          Radial extent of seas (as defined in SEAHGT) extending from storm
          center to the Northwest.
        |||,
        type: ee_const.var_type.double,
        units: units.nautical_mile,
      },
      {
        name: 'STORM_SPEED',
        description: |||
          Translation speed of the system as calculated from the positions in
          LAT and LON
        |||,
        type: ee_const.var_type.double,
        units: units.knot,
      },
      {
        name: 'STORM_DIR',
        description: |||
          Translation direction of the system as calculated from the positions
          in LAT and LON. Direction is moving toward the vector pointing in
          degrees east of north [range = 0-360 deg]
        |||,
        type: ee_const.var_type.double,
        units: units.degree,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Hurricane locations',
        lookat: {
          lat: 30.0,
          lon: -150.0,
          zoom: 3,
        },
        table_visualization: {
          color: 'black',
          point_size: 1,
        },
      },
      {
        display_name: 'Hurricane locations',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 30.0,
          lon: -150.0,
          zoom: 3,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 6000,
      thinning_strategy: 'GLOBALLY_CONSISTENT',
      thinning_ranking: ['id DESC'],
      z_order_ranking: ['seq ASC'],
      prerender_tiles: true,
    },
  },
  'gee:terms_of_use': |||
    NOAA data, information, and products, regardless of the method of delivery,
    are not subject to copyright and carry no restrictions on their subsequent
    use by the public. Once obtained, they may be put to any lawful use.
  |||,
}

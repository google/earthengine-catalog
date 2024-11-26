local id = 'projects/gcp-public-data-weathernext/assets/59572747_4_0';
local subdir = 'gcp-public-data-weathernext';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

local license = spdx.proprietary;

{
  // TODO(samier): Remove when the dataset is ready.
  'gee:status': 'beta',
  'gee:user_uploaded': true,
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'WeatherNext Graph Forecasts',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    WeatherNext Graph is an experimental dataset of global medium-range weather
    forecasts produced by Google DeepMind's graphical neural network weather
    model.

    The dataset includes real-time and historical forecasts. This includes major
    atmospheric and surface fields including temperature, wind, precipitation,
    humidity, geopotential, vertical velocity and pressure. The spatial
    resolution is 0.25 degrees and temporal resolution is 6 hours.
    Initialisation times are 00z, 06z, 12z, 18z. The data are 6 hour forecasts
    up to a max lead time of 10 days.

    This dataset is not public. To access this data, please fill out this
    [request form](https://forms.gle/q8GATt5yr3rLJNrw5).

    More information on the model is in "[Learning skillful
    medium-range global weather forecasting](https://www.science.org/stoken/author-tokens/ST-1550/full)"
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'weather',
    'weathernext',
    'forecast',
    'temperature',
    'precipitation',
    'wind',
  ],
  providers: [
    ee.producer_provider('Google', 'https://deepmind.google/discover/blog/graphcast-ai-model-for-faster-and-more-accurate-global-weather-forecasting/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2020-01-01T00:00:00Z', null),
  summaries: {
    gsd: [27750],
    'gee:schema': [
      {
        name: 'start_time',
        description: |||
          The initialization time of the forecast. This is the same for all
          forecast hours within a single model run.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'end_time',
        description: |||
          The valid time for this specific forecast. Calculated as
          start_time + forecast_hour
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'forecast_hour',
        description: |||
          The forecast lead time in hours. Represents the number of hours from
          the start_time.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'ingestion_time',
        description: |||
          The time when this forecast data became available in Earth Engine.
        |||,
        type: ee_const.var_type.double,
      },
    ],
    'eo:bands': [
      {
        name: 'total_precipitation_6hr',
        description: |||
          Total precipitation over a 6-hour period
        |||,
        'gee:units': units.millimeter,
      },
      {
        name: '10m_u_component_of_wind',
        description: |||
          10 meter U wind component
        |||,
        'gee:units': units.velocity_si,
      },
      {
        name: '10m_v_component_of_wind',
        description: |||
          10 meter V wind component
        |||,
        'gee:units': units.velocity_si,
      },
      {
        name: '2m_temperature',
        description: |||
         2 meter temperature
        |||,
        'gee:units': units.kelvin,
      },
      {
        name: 'mean_sea_level_pressure',
        description: |||
          Mean sea level pressure
        |||,
        'gee:units': units.pascal,
      },
      {
        name: '50_geopotential',
        description: 'Geopotential at 50 hPa',
        // TODO(samier): Add this to the units file.
        'gee:units': 'm^2/s^2'
      },
      {
        name: '100_geopotential',
        description: 'Geopotential at 100 hPa',
        'gee:units': 'm^2/s^2'
      },
      {
        name: '150_geopotential',
        description: 'Geopotential at 150 hPa',
        'gee:units': 'm^2/s^2'
      },
      {
        name: '200_geopotential',
        description: 'Geopotential at 200 hPa',
        'gee:units': 'm^2/s^2'
      },
      {
        name: '250_geopotential',
        description: 'Geopotential at 250 hPa',
        'gee:units': 'm^2/s^2'
      },
      {
        name: '300_geopotential',
        description: 'Geopotential at 300 hPa',
        'gee:units': 'm^2/s^2'
      },
      {
        name: '400_geopotential',
        description: 'Geopotential at 400 hPa',
        'gee:units': 'm^2/s^2'
      },
      {
        name: '500_geopotential',
        description: 'Geopotential at 500 hPa',
        'gee:units': 'm^2/s^2'
      },
      {
        name: '600_geopotential',
        description: 'Geopotential at 600 hPa',
        'gee:units': 'm^2/s^2'
      },
      {
        name: '700_geopotential',
        description: 'Geopotential at 700 hPa',
        'gee:units': 'm^2/s^2'
      },
      {
        name: '850_geopotential',
        description: 'Geopotential at 850 hPa',
        'gee:units': 'm^2/s^2'
      },
      {
        name: '925_geopotential',
        description: 'Geopotential at 925 hPa',
        'gee:units': 'm^2/s^2'
      },
      {
        name: '1000_geopotential',
        description: 'Geopotential at 1000 hPa',
        'gee:units': 'm^2/s^2'
      },
      {
        name: '50_specific_humidity',
        description: 'Specific humidity at 50 hPa',
        'gee:units': 'kg/kg'
      },
      {
        name: '100_specific_humidity',
        description: 'Specific humidity at 100 hPa',
        'gee:units': 'kg/kg'
      },
      {
        name: '150_specific_humidity',
        description: 'Specific humidity at 150 hPa',
        'gee:units': 'kg/kg'
      },
      {
        name: '200_specific_humidity',
        description: 'Specific humidity at 200 hPa',
        'gee:units': 'kg/kg'
      },
      {
        name: '250_specific_humidity',
        description: 'Specific humidity at 250 hPa',
        'gee:units': 'kg/kg'
      },
      {
        name: '300_specific_humidity',
        description: 'Specific humidity at 300 hPa',
        'gee:units': 'kg/kg'
      },
      {
        name: '400_specific_humidity',
        description: 'Specific humidity at 400 hPa',
        'gee:units': 'kg/kg'
      },
      {
        name: '500_specific_humidity',
        description: 'Specific humidity at 500 hPa',
        'gee:units': 'kg/kg'
      },
      {
        name: '600_specific_humidity',
        description: 'Specific humidity at 600 hPa',
        'gee:units': 'kg/kg'
      },
      {
        name: '700_specific_humidity',
        description: 'Specific humidity at 700 hPa',
        'gee:units': 'kg/kg'
      },
      {
        name: '850_specific_humidity',
        description: 'Specific humidity at 850 hPa',
        'gee:units': 'kg/kg'
      },
      {
        name: '925_specific_humidity',
        description: 'Specific humidity at 925 hPa',
        'gee:units': 'kg/kg'
      },
      {
        name: '1000_specific_humidity',
        description: 'Specific humidity at 1000 hPa',
        'gee:units': 'kg/kg'
      },
      {
        name: '50_temperature',
        description: 'Temperature at 50 hPa',
        'gee:units': units.kelvin
      },
      {
        name: '100_temperature',
        description: 'Temperature at 100 hPa',
        'gee:units': units.kelvin
      },
      {
        name: '150_temperature',
        description: 'Temperature at 150 hPa',
        'gee:units': units.kelvin
      },
      {
        name: '200_temperature',
        description: 'Temperature at 200 hPa',
        'gee:units': units.kelvin
      },
      {
        name: '250_temperature',
        description: 'Temperature at 250 hPa',
        'gee:units': units.kelvin
      },
      {
        name: '300_temperature',
        description: 'Temperature at 300 hPa',
        'gee:units': units.kelvin
      },
      {
        name: '400_temperature',
        description: 'Temperature at 400 hPa',
        'gee:units': units.kelvin
      },
      {
        name: '500_temperature',
        description: 'Temperature at 500 hPa',
        'gee:units': units.kelvin
      },
      {
        name: '600_temperature',
        description: 'Temperature at 600 hPa',
        'gee:units': units.kelvin
      },
      {
        name: '700_temperature',
        description: 'Temperature at 700 hPa',
        'gee:units': units.kelvin
      },
      {
        name: '850_temperature',
        description: 'Temperature at 850 hPa',
        'gee:units': units.kelvin
      },
      {
        name: '925_temperature',
        description: 'Temperature at 925 hPa',
        'gee:units': units.kelvin
      },
      {
        name: '1000_temperature',
        description: 'Temperature at 1000 hPa',
        'gee:units': units.kelvin
      },
      {
        name: '50_u_component_of_wind',
        description: 'U wind component at 50 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '100_u_component_of_wind',
        description: 'U wind component at 100 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '150_u_component_of_wind',
        description: 'U wind component at 150 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '200_u_component_of_wind',
        description: 'U wind component at 200 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '250_u_component_of_wind',
        description: 'U wind component at 250 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '300_u_component_of_wind',
        description: 'U wind component at 300 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '400_u_component_of_wind',
        description: 'U wind component at 400 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '500_u_component_of_wind',
        description: 'U wind component at 500 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '600_u_component_of_wind',
        description: 'U wind component at 600 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '700_u_component_of_wind',
        description: 'U wind component at 700 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '850_u_component_of_wind',
        description: 'U wind component at 850 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '925_u_component_of_wind',
        description: 'U wind component at 925 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '1000_u_component_of_wind',
        description: 'U wind component at 1000 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '50_v_component_of_wind',
        description: 'V wind component at 50 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '100_v_component_of_wind',
        description: 'V wind component at 100 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '150_v_component_of_wind',
        description: 'V wind component at 150 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '200_v_component_of_wind',
        description: 'V wind component at 200 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '250_v_component_of_wind',
        description: 'V wind component at 250 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '300_v_component_of_wind',
        description: 'V wind component at 300 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '400_v_component_of_wind',
        description: 'V wind component at 400 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '500_v_component_of_wind',
        description: 'V wind component at 500 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '600_v_component_of_wind',
        description: 'V wind component at 600 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '700_v_component_of_wind',
        description: 'V wind component at 700 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '850_v_component_of_wind',
        description: 'V wind component at 850 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '925_v_component_of_wind',
        description: 'V wind component at 925 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '1000_v_component_of_wind',
        description: 'V wind component at 1000 hPa',
        'gee:units': units.velocity_si
      },
      {
        name: '50_vertical_velocity',
        description: 'Vertical velocity at 50 hPa',
        'gee:units': 'Pa/s'
      },
      {
        name: '100_vertical_velocity',
        description: 'Vertical velocity at 100 hPa',
        'gee:units': 'Pa/s'
      },
      {
        name: '150_vertical_velocity',
        description: 'Vertical velocity at 150 hPa',
        'gee:units': 'Pa/s'
      },
      {
        name: '200_vertical_velocity',
        description: 'Vertical velocity at 200 hPa',
        'gee:units': 'Pa/s'
      },
      {
        name: '250_vertical_velocity',
        description: 'Vertical velocity at 250 hPa',
        'gee:units': 'Pa/s'
      },
      {
        name: '300_vertical_velocity',
        description: 'Vertical velocity at 300 hPa',
        'gee:units': 'Pa/s'
      },
      {
        name: '400_vertical_velocity',
        description: 'Vertical velocity at 400 hPa',
        'gee:units': 'Pa/s'
      },
      {
        name: '500_vertical_velocity',
        description: 'Vertical velocity at 500 hPa',
        'gee:units': 'Pa/s'
      },
      {
        name: '600_vertical_velocity',
        description: 'Vertical velocity at 600 hPa',
        'gee:units': 'Pa/s'
      },
      {
        name: '700_vertical_velocity',
        description: 'Vertical velocity at 700 hPa',
        'gee:units': 'Pa/s'
      },
      {
        name: '850_vertical_velocity',
        description: 'Vertical velocity at 850 hPa',
        'gee:units': 'Pa/s'
      },
      {
        name: '925_vertical_velocity',
        description: 'Vertical velocity at 925 hPa',
        'gee:units': 'Pa/s'
      },
      {
        name: '1000_vertical_velocity',
        description: 'Vertical velocity at 1000 hPa',
        'gee:units': 'Pa/s'
      }
    ],
    'gee:visualizations': [
      {
        display_name: 'Temperature 2m',
        lookat: {
          lat: 52.48,
          lon: 71.72,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              220
            ],
            max: [
              350,
            ],
            palette: ['darkblue', 'blue', 'cyan', 'green', 'yellow', 'orange', 'red', 'darkred'],
            bands: [
              '2m_temperature',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Lam, R., Sanchez-Gonzalez, A., Willson, M., Wirnsberger, P., Fortunato, M., Pritzel, A., Ravuri, S., Ewalds, T., Alet, F., Eaton-Rosen, Z., Hu, W., Merose, A., Hoyer, S., Holland, G., Stott, J., Vinyals, O., Mohamed, S., & Battaglia, P. (2022). GraphCast: Learning skillful medium-range global weather forecasting
  |||,
  'gee:unusual_terms_of_use': true,
  'gee:terms_of_use': |||
    This repository contains weather forecasting research data produced by Google DeepMind's machine learning models.

    Any data that relates to a time that is:

    *   no more than 48 hours in the past is made available under the [link - GDM's Real-Time Weather Forecasting Research Data Terms of Use]

    *   more than 48 hours ago is licensed under the [link - Creative Commons Attribution-Non-Commercial ShareAlike International License, Version 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en) (CC-BY-NC-SA 4.0).


    If you have any questions on using this weather forecasting research data, or would like to use it for purposes not currently permitted under these terms, please contact gencast-contact@google.com.

    GDM REAL-TIME WEATHER FORECASTING RESEARCH DATA TERMS OF USE

    **Last modified: 26 November 2024**

    By using, reproducing, modifying, performing, distributing or displaying all or any portion of the Real-Time Research Data (as defined below), or otherwise accepting these Terms, you agree to be bound by (1) these terms of use;

    and (2) [Google's Generative AI Prohibited Use Policy](https://policies.google.com/terms/generative-ai/use-policy) which is incorporated herein by reference (together, the " Terms "), in each case (a) as modified from time to time in accordance with the Terms, and (b) between you and (i) if you are from a country in the European Economic Area or Switzerland, Google Ireland Limited, or (ii) otherwise, Google LLC.

    If you are accessing or using the Real-Time Research Data for or on behalf of a legal entity you represent and warrant that you have the authority to act on behalf of and bind that entity to these Terms.

    Please read these Terms carefully. They establish what you can expect from us as you access and use the Real-Time Research Data, and what Google expects from you.

    When we say " you"  or  "your" , we mean the individual or legal entity using the Real-Time Research Data.

    When we say " we ", " us " or " Google ", we mean the entities that belong to the Google group of companies, which means Google LLC and its affiliates.

    **Section 1: Definitions and Interpretation**

    In these Terms, unless the context indicates otherwise:

    (a)  Contractor  means a person or entity that enters a contract with you to provide services to you which require access to the Real-Time Research Data.

    (b)  Distribute  means controlled transmission or supply to clearly identified and known third party or third parties, including (for the avoidance of doubt) Contractors and Subsidiaries.

    (c)  Disseminate  means any act of making materials available publicly, or otherwise to any unknown third party or third parties, including any transmission, broadcast, supply, reproduction, publication or sharing.

    (d)   Educational Use  means any use (including controlled display or reproduction) of the Real-Time Research Data solely for educational non-commercial purposes, without Distribution, Dissemination or otherwise sharing to or by any third party, or use to generate VAS.

    (d)  End User  means clearly identified and known users who use the VAS for their own internal purposes, and do not further Distribute, Disseminate or otherwise share them or use them to generate VAS.

    (e)  including  means "including without limitation".

    (f)  Non-Retrievable VAS  means any VAS from which the Real-Time Research Data cannot be retrieved or reverse engineered without significant technical effort and/or expense.

    (g)   Real-Time   Research   Data  means the meteorological research information generated by Google and made available at [link] that relates to a time that is no more than 48 hours in the past.

    (h)  Restricted Country  means Japan, South Korea, Indonesia, Cuba, Iran, North Korea, Syria, Crimea and the so-called Donetsk People's Republic and Luhansk People's Republic.

    (i)  Retrievable VAS  means any VAS from which the Real-Time Research Data can be retrieved or reverse engineered without significant technical effort and/or expense.

    (j)  Subsidiary  means any of your subsidiaries which are directly controlled by you by means of you holding the majority of the voting rights.

    (k)   Value Added Service or VAS  means:

    (i)  any product, service, graphic, visualisation or other material that is derived from or based upon the Real-Time Research Data ( Service );

    and

    (ii)  created for a specific purpose or use case that cannot be achieved by utilising the Real-Time Research Data separate from the Service.

    For the avoidance of doubt, the following do not constitute VAS:

    (i)   a product or service that merely allows for the access to, or download or retrieval of, unmodified Real-Time Research Data such as web, file or peer-to-peer sharing or hosting, or sharing via email, VPN, social media or API;

    or

    (ii)   material resulting from the colouring, formatting, compressing, fixed or arbitrary percentage adjustment, geometric transformation, sub-setting of areas, or custom combinations of time-steps, parameters or model runs of Real-Time Research Data.

    Such material is considered unmodified Real-Time Research Data for the purposes of these Terms.

    **Section 2: Accessing and using the Real-Time Research Data**

    2.1  Eligibility

    You represent and warrant that: (a) you have the legal capacity to enter into these Terms (including being of sufficient age of consent);

    (b) entering into or performing your rights or obligations under these Terms will not violate any agreement you have with a third party or any third-party rights;

    (c) any information provided by you to Google in relation to these Terms, including in order to request access to the Real-Time Research Data, is correct and current;

    and (d) you are not (i) resident of a Restricted Country, (ii) ordinarily resident in a Restricted Country, or (iii) otherwise prohibited by applicable export controls, sanctions programs or legal restrictions from accessing, using, or modifying the Real-Time Research Data.

    2.2   Use

    (a)  Subject to your compliance with these Terms, you may access, use and modify the Real-Time Research Data for any purpose, and Distribute and Disseminate this as set out in Section 3. We grant you a non-exclusive, royalty-free, revocable, non-transferable and non-sublicensable (except as expressly permitted in these Terms) license to any intellectual property rights we have in the Real-Time Research Data to the extent necessary for these purposes.

    In order to verify your access and use of the Real-Time Research Data, we may from time-to-time ask for additional information from you, including verification of your name, legal entity, and other identifying information.

    **Section 3: Distribution, Dissemination and Use Restrictions**

    3.1   Distribution and Dissemination

    (a)  You may only Distribute:

    (i)  (and Disseminate) Non-Retrievable VAS;

    (ii)   Retrievable VAS to End-Users, along with any element or portion of the Real-Time Research Data strictly required for the Retrievable VAS to work or be correctly interpreted by such End-Users;

    or

    (iii)  Real-Time Data for:

    (I) Educational Use; and

    (II) your Contractors and Subsidiaries to use in accordance with these Terms.

    (b)  In addition to complying with Section 3.1(a), any Distribution of Real-Time Research Data or Retrievable VAS must be accompanied by:

    (i)  a copy of these Terms;

    (ii)   a " Legally Binding Terms of Use"  text file that contains the following notice: " By using this information, you agree to the Terms of Use found at [link] ";

    (iii)  a prominent copyright notice:  "Copyright 2024 DeepMind Technologies Limited";  and

    (iv)   notice of any modifications that you make.

    (c)  You must not provide any additional or different provisions relating to use of Real-Time Research Data or Retrievable VAS that conflict with these Terms.

    3.2   Use Restrictions

    (a)  You must not use the Real-Time Research Data or VAS:

    (i)  in a manner that contravenes or contradicts these Terms, including for any restricted uses set out in [Google's Generative AI Prohibited Use Policy](https://policies.google.com/terms/generative-ai/use-policy);

    (ii)   in a Restricted Country, including: (I) if you are currently or ordinarily resident in a Restricted Country;

    or (II) by otherwise making these available in a Restricted Country; or

    (iii)  in violation of applicable laws and regulations.

    (b)  To the maximum extent permitted by law and without limiting any of our other rights, Google reserves the right to restrict usage of the Real-Time Research Data or VAS that Google reasonably believes are in violation of these Terms.

    3.3   Citation

    If you disclose findings arising from the Real-Time Research Data or Distribute Non-Retrievable VAS, you must cite " © 2024 DeepMind Technologies Limited's machine learning models used to create the research data made available at [link] under the following licence terms [link].

    This data is intended for research modelling only and is not intended, validated, or approved for real world use .

    "

    3.4  VAS

    Subject to any intellectual property rights Google has in the Real-Time Research Data, Google will not claim ownership of any VAS.

    However, you acknowledge that Google may develop its own VAS and it reserves all rights to do so.

    **Section 4: Changes to the Real-Time Research Data or these Terms**

    4.1  Google reserves its right to add or remove functionalities or features of, discontinue or limit the availability of, or otherwise update the Real-Time Research Data at its sole discretion.

    Google will endeavour to give you reasonable notice prior to any such changes.

    4.2  Google may update these Terms and the access mechanism for the Real-Time Research Data at any time.

    We will post any modifications to these Terms [on this page - link].

    Changes will generally become effective 14 days after they are posted.

    However, changes addressing functionality or made for legal reasons will be effective immediately.

    4.3  Google does not currently levy a charge for your access to the Real-Time Research Data.

    However, Google reserves the right to charge reasonable fees for access to the Real-Time Research Data on providing you with at least one month's prior written notice and publishing the applicable fees at [insert link].

    Where Google introduces fees, your use of the Real-Time Research Data will be subject to payment of the applicable fees.

    If you do not wish to pay the fees, you must stop using the Real-Time Research Data immediately.

    4.4   You should review these Terms whenever we update them or whenever you use the Real-Time Research Data.

    If you do not agree to any modified provisions in these Terms, you must stop using the Real-Time Research Data immediately.

    4.5   If, in accordance with this Section 4, Google discontinues or limits the availability of the Real-Time Research Data, changes these Terms or charges fees for access, you may continue to provide VAS based on or derived from the Real-Time Research Data accessed prior to this change in accordance with the version of the Terms that applied at the time of access and utilise copies of the Real-Time Research Data accessed prior to this change for this purpose, subject in all cases to the provisions in Section 5.  Section 5: Suspending or terminating your right to use the

    **Real-Time Research Data**

    5.1  Google may at any time suspend or terminate your right to use and, as applicable, your access to the Real-Time Research Data because of (among other serious grounds) your failure to comply with these Terms.

    5.2  If Google terminates your rights to use the Real-Time Research Data in accordance with Section 5.1 above, you:

    (a)  must delete and cease any use (including Distribution and Dissemination) of Real-Time Research Data and VAS in your possession or control;

    (b)   must notify all third party recipients of VAS that you no longer have the right to provide VAS to them and that they must cease use of VAS;

    and

    (c)  are prohibited from submitting another application to use the Real-Time Research Data.

    5.3  You are free to stop using the Real-Time Research Data at any time.

    If you do stop using the Real-Time Research Data, we'd appreciate knowing why (via [add alias]) so that we can continue to improve our technologies.

    **Section 6: Disclaimers and Liability**

    6.1  Disclaimers

    (a)  Nothing in these Terms restricts any rights that cannot be restricted under applicable law or limits Google's responsibilities except as allowed by applicable law.

    (b)   The Real-Time Research Data is provided on an "as is" basis, without warranties or conditions of any kind, either express or implied, including any warranties or conditions of title, non-infringement, merchantability, or fitness for a particular purpose.

    You are solely responsible for determining the appropriateness of accessing, using or modifying the Real-Time Research Data, or accessing, using, creating, Distributing or Disseminating any VAS and assume any and all risks associated with such use or distribution and your exercise of rights and obligations under these Terms.

    You and anyone you share VAS with are solely responsible for these and their subsequent uses.

    (c)  The Real-Time Research Data contains predictions generated using Google's machine learning models as part of an experimental research project.

    The Real-Time Research Data (i) is not based on data published by; (ii) has not been produced in collaboration with;

    and (iii) has not been endorsed by any government meteorological agency or department and in no way replaces official alerts, warnings or notices published by such agencies or departments.

    (d)  You will not make any representation to any third party concerning the Real-Time Data (including as to its accuracy) which are components of the Value-Added Services that are incompatible with these Terms.

    (e)  Nothing in these Terms constitutes or may be construed as permission to assert or imply that you or your Value-Added Services, or that your use of the Real-Time Research Data, are in any way sponsored, endorsed, or granted official status by Google or any meteorological agency or department and you will not claim or imply the same to any third party.

    6.2  Liabilities

    (a)  If you are a legal entity, to the extent allowed by applicable law, you'll indemnify Google and its directors, officers, employees, affiliates and contractors for any third-party legal proceedings (including actions by government authorities) arising out of or relating to your unlawful use of the Real-Time Research Data or VAS or violation of these Terms.

    This indemnity covers any liability or expense arising from claims, losses, damages, judgments, fines, litigation costs, and legal fees, except to the extent a liability or expense is caused by Google's or its affiliates' breach, negligence, or willful misconduct.

    If you're legally exempt from certain responsibilities, including indemnification, then those responsibilities don't apply to you under these Terms.

    (b)   In no event will Google or its affiliates be liable to you for any losses, costs, expenses or damages, including any direct, indirect, consequential, exemplary, or punitive damages or loss of profits of any kind arising out of or in relation to these Terms or use of the Real-Time Research Data or Distribution of any VAS, regardless of whether Google or its affiliates have been advised of the possibility of such damages, and regardless of whether such damages arise under contract, tort (including negligence), product liability, or otherwise.

    Google's and its affiliates' total, aggregate liability for all claims arising out of or in connection with these Terms, the Real-Time Research Data or any VAS, including for its own negligence, is limited to USD 500.

    **Section 7: Additional Provisions**

    7.1   Feedback

    If you choose to give Google feedback, such as suggestions to improve the Real-Time Research Data or Google's machine learning models used to generate the Real-Time Research Data, you undertake any such information is non-confidential and non-proprietary, and Google may act on your feedback without obligation to you.

    You grant Google a non-exclusive, transferable, sub-licensable, perpetual, irrevocable, royalty-free licence to use any intellectual property rights in the feedback for any purpose.

    7.2  Trademarks

    Nothing in these Terms grants you any rights to use Google's trade marks, trade names, logos or to otherwise suggest endorsement or misrepresent the relationship between you and Google.

    7.3  Governing Law and Jurisdiction

    California law will govern all disputes arising out of or relating to these Terms, regardless of any conflict of laws rules and each party agrees to the exclusive jurisdiction of Santa Clara County, California, USA.

    To the extent that applicable local law prevents certain disputes from being resolved in a California court, you and Google can file those disputes in your local courts.

    If applicable local law prevents your local court from applying California law to resolve these disputes, then these disputes will be governed by the applicable local laws of your country, state, or other place of residence.

    7.4  Severability

    If any provision of these Terms is held to be invalid, illegal or unenforceable, the remaining provisions shall be unaffected thereby and remain valid as if such provision had not been set forth herein.

    7.5  Entire Agreement

    (a)  These Terms state all the terms agreed between you and Google and supersede all other agreements relating to their subject matter as of the date of acceptance of these Terms.

    (b)  Google will not be bound by any additional terms or conditions communicated by you, unless expressly agreed in writing.

    7.6  No Waiver

    Google will not be treated as having waived any rights by not exercising (or delaying the exercise of) any rights under these Terms.

    7.7  Reservation of Rights

    (a)  Nothing in these Terms affects any rights that Google may have as a matter of law.

    Nothing in these Terms will prevent Google from seeking any injunctive or equitable relief with respect to a breach (or anticipated breach) of these Terms.

    (b)  Nothing in these Terms will prevent you from exercising a right in relation to the Real-Time Research Data or VAS which cannot be excluded or limited as a matter of applicable law.
  |||,
}

{
  description: |||

    Notes:

    * The code used to create the composites
      [can be seen here](https://github.com/google/earthengine-catalog/blob/main/pipelines/landsat.py).

    * Only daytime images with WRS_ROW < 122 are included.

    * For Landsat 7 , images after 2017-01-01 are excluded due to orbital drift.

    * For Landsat 8, images before 2013-05-01 are excluded due to pointing issues.

    **Caution:**  These composites are computed on the fly and count towards
    the requesting project's
    [EECU](https://developers.google.com/earth-engine/guides/computation_overview#eecus)
    usage.
  |||
}

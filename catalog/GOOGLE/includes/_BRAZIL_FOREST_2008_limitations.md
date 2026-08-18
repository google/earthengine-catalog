

### Limitations and known issues

* **Spatial completeness:** Gaps exist where no imagery met the project’s strict 2008-era temporal window (2007–2009), cloud-cover thresholds, or quality standards.
* **Variable native resolution:**Boundaries between different nominal resolutions of source imagery may be visible because nearest neighbor resampling was used during processing..
* **Residual misregistration:** Spatial shifts may persist in some areas, particularly in regions with extreme terrain relief or dense, homogeneous forest areas.
* **Atmospheric and cloud artifacts:** Manual cloud masking is not exhaustive; users may encounter occasional residual artifacts like thin cirrus haze or small cloud shadows.
* **Radiometric inconsistency:** Residual spectral variation remains between adjacent images, which may increase spectral variance and reduce the precision of class separation during machine learning inference.
* **Spectral saturation:** In areas of extreme brightness, pixels may reach the sensor’s maximum detectable limit, resulting in a loss of texture and detail.

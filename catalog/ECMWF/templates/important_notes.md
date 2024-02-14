
Precipitation and other flow (accumulated) bands might occasionally have
negative values, which doesn't make physical sense. At other times their values
might be excessively high.

This problem is due to how the GRIB format saves data: it simplifies or "packs"
the data into smaller, less precise numbers, which can introduce errors. These
errors get worse when the data varies a lot.

Because of this, when we look at the data for a whole day to compute daily
totals, sometimes the highest amount of rainfall recorded at one time can seem
larger than the total rainfall measured for the entire day.

To learn more, Please see:
["Why are there sometimes small negative precipitation accumulations"](https://confluence.ecmwf.int/display/UDOC/Why+are+there+sometimes+small+negative+precipitation+accumulations+-+ecCodes+GRIB+FAQ)
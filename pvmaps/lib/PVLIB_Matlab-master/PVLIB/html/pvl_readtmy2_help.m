%% pvl_readtmy2 
% Read a Typical Meteological Year 2 (TMY2) file to a MATLAB struct.
%
%% Syntax
% |TMYData = pvl_readtmy2()|
%
% |TMYData = pvl_readtmy2(FileName)|
%
%% Description
% Read a TMY2 file and make a struct of the data. Note that values
% contained in the struct are unchanged from the TMY2 file (i.e. units 
% are retained). Time/Date and Location data imported from the TMY2 file
% have been modified to conform to the following conventions:
%
% * N latitude is postive;
% * E longitude is positive;
% * the 24th hour of any day is the 0th hour of the next day.
%
% In the case of any discrepencies between this documentation and the 
% TMY2 User's Manual ([1]), the TMY2 User's Manual takes precedence.
%
%
%% Inputs
%%
% * *|FileName|* - an optional argument which allows the user to select which
%     TMY2 format file should be read. A file path may also be necessary if
%     the desired TMY2 file is not in the MATLAB working path. If
%     |FileName| is not provided, the user will be prompted to browse to an
%     appropriate TMY2 file.
%
%% Outputs
%%
% * *|TMYData|* - A struct with the following components. For more detailed 
%     descriptions of each component, please consult
%     the TMY2 User's Manual ([1]), especially tables 3-1 through 3-6, and 
%     Appendix B. Unless otherwise stated, each field is a column 
%     vector of type double (float).
%%
% * *|TMYData.SiteID|* - Site identifier code (WBAN number), scalar
% unsigned integer.
% * *|TMYData.StationName|* - Station name, 1x1 cell string.
% * *|TMYData.StationState|* - Station state 2 letter designator, 1x1 cell
% string.
% * *|TMYData.SiteTimeZone|* - Hours from Greenwich Mean Time, scalar double.
% * *|TMYData.SiteLatitude|* - Latitude in decimal degrees, scalar double.
% * *|TMYData.SiteLongitude|* - Longitude in decimal degrees, scalar
% double.
% * *|TMYData.SiteElevation|* - Site elevation in meters, scalar double.
% * *|TMYData.DateString|* - Date string in mm/dd/yy format, 8760x1 cell
% string.
% * *|TMYData.TimeString|* - Time string in HH:MM format, local standard
% time, 8760x1 cell string.
% * *|TMYData.DateNumber|* - Combination of date/time in MATLAB serial date
% (datenum) format, 8760x1 double.
% * *|TMYData.ETR|* - Extraterrestrial horizontal radiation receivedd during
% 60 minutes prior to timestamp, Wh/m^2.
% * *|TMYData.ETRN|* - Extraterrestrial normal radiation received during 60
% minutes prior to timestamp, Wh/m^2.
% * *|TMYData.GHI|* - Direct and diffuse horizontal radiation received
% during 60 minutes prior to timestamp, Wh/m^2.
% * *|TMYData.GHISource|* - See [1], Table 3-3.
% * *|TMYData.GHIUncertainty|* - See [1], Table 3-4.
% * *|TMYData.DNI|* - Amount of direct normal radiation (modeled) received
% during 60 mintues prior to timestamp, Wh/m^2.
% * *|TMYData.DNISource|* - See [1], Table 3-3.
% * *|TMYData.DNIUncertainty|* - See [1], Table 3-4.
% * *|TMYData.DHI|* - Amount of diffuse horizontal radiation received during
% 60 minutes prior to timestamp, Wh/m^2.
% * *|TMYData.DHISource|* - See [1], Table 3-3.
% * *|TMYData.DHIUncertainty|* - See [1], Table 3-4.
% * *|TMYData.GHillum|* - Average total horizontal illuminance received during
%         the 60 minutes prior to timestamp, units of 100 lux (e.g. value
%         of 50 = 5000 lux).
% * *|TMYData.GHillumSource|* - See [1], Table 3-3.
% * *|TMYData.GHillumUncertainty|* - See [1], Table 3-4.
% * *|TMYData.DNillum|* - Average direct normal illuminance received during the
%         60 minutes prior to timestamp, units of 100 lux.
% * *|TMYData.DNillumSource|* - See [1], Table 3-3.
% * *|TMYData.DNillumUncertainty|* - See [1], Table 3-4.
% * *|TMYData.DHillum|* - Average horizontal diffuse illuminance received during
%         the 60 minutes prior to timestamp, units of 100 lux.
% * *|TMYData.DHillumSource|* - See [1], Table 3-3.
% * *|TMYData.DHillumUncertainty|* - See [1], Table 3-4.
% * *|TMYData.Zenithlum|* - Average luminance at the sky's zenith during the
%         60 minutes prior to timestamp, units of 10 Cd/m^2 (e.g. value of
%         700 = 7,000 Cd/m^2).
% * *|TMYData.ZenithlumSource|* - See [1], Table 3-3.
% * *|TMYData.ZenithlumUncertainty|* - See [1], Table 3-4.
% * *|TMYData.TotCld|* - Amount of sky dome covered by clouds or obscuring
% phenonema at time stamp, tenths of sky.
% * *|TMYData.TotCldSource|* - See [1], Table 3-5, 8760x1 cell array of
% strings.
% * *|TMYData.TotCldUnertainty|* - See [1], Table 3-6.
% * *|TMYData.OpqCld|* - Amount of sky dome covered by clouds or obscuring phenonema that prevent observing the 
%         sky at time stamp, tenths of sky.
% * *|TMYData.OpqCldSource|* - See [1], Table 3-5, 8760x1 cell array of
% strings.
% * *|TMYData.OpqCldUncertainty|* - See [1], Table 3-6.
% * *|TMYData.DryBulb|* - Dry bulb temperature at the time indicated, in
%         tenths of degree C (e.g. 352 = 35.2 C).
% * *|TMYData.DryBulbSource|* - See [1], Table 3-5, 8760x1 cell array of
% strings.
% * *|TMYData.DryBulbUncertainty|* - See [1], Table 3-6.
% * *|TMYData.DewPoint|* - Dew-point temperature at the time indicated, in
%         tenths of degree C (e.g. 76 = 7.6 C).
% * *|TMYData.DewPointSource|* - See [1], Table 3-5, 8760x1 cell array of strings
% * *|TMYData.DewPointUncertainty|* - See [1], Table 3-6.
% * *|TMYData.RHum|* - Relative humidity at the time indicated, percent.
% * *|TMYData.RHumSource|* - See [1], Table 3-5, 8760x1 cell array of
% strings.
% * *|TMYData.RHumUncertainty|* - See [1], Table 3-6.
% * *|TMYData.Pressure|* - Station pressure at the time indicated, 1 mbar.
% * *|TMYData.PressureSource|* - See [1], Table 3-5, 8760x1 cell array of
% strings.
% * *|TMYData.PressureUncertainty|* - See [1], Table 3-6.
% * *|TMYData.Wdir|* - Wind direction at time indicated, degrees from east
%         of north (360 = 0 = north; 90 = East; 0 = undefined,calm).
% * *|TMYData.WdirSource|* - See [1], Table 3-5, 8760x1 cell array of
% strings.
% * *|TMYData.WdirUncertainty|* - See [1], Table 3-6.
% * *|TMYData.Wspd|* - Wind speed at the time indicated, in tenths of
%         meters/second (e.g. 212 = 21.2 m/s).
% * *|TMYData.WspdSource|* - See [1], Table 3-5, 8760x1 cell array of
% strings.
% * *|TMYData.WspdUncertainty|* - See [1], Table 3-6.
% * *|TMYData.Hvis|* - Distance to discernable remote objects at time 
%         indicated (7777=unlimited, 9999=missing data), in tenths of
%         kilometers (e.g. 341 = 34.1 km).
% * *|TMYData.HvisSource|* - See [1], Table 3-5, 8760x1 cell array of strings
% * *|TMYData.HvisUncertainty|* - See [1], Table 3-6.
% * *|TMYData.CeilHgt|* - Height of cloud base above local terrain
%         (7777=unlimited, 88888=cirroform, 99999=missing data), in meters.
% * *|TMYData.CeilHgtSource|* - See [1], Table 3-5, 8760x1 cell array of
% strings.
% * *|TMYData.CeilHgtUncertainty|* - See [1], Table 3-6.
% * *|TMYData.Pwat|* - Total precipitable water contained in a column of unit cross section from 
%         Earth to top of atmosphere, in millimeters.
% * *|TMYData.PwatSource|* - See [1], Table 3-5, 8760x1 cell array of strings
% * *|TMYData.PwatUncertainty|* - See [1], Table 3-6.
% * *|TMYData.AOD|* - The broadband aerosol optical depth (broadband
%         turbidity) in thousandths on the day indicated (e.g. 114 =
%         0.114).
% * *|TMYData.AODSource|* - See [1], Table 3-5, 8760x1 cell array of strings
% * *|TMYData.AODUncertainty|* - See [1], Table 3-6.
% * *|TMYData.SnowDepth|* - Snow depth in centimeters on the day indicated,
%         (999 = missing data).
% * *|TMYData.SnowDepthSource|* - See [1], Table 3-5, 8760x1 cell array of
% strings.
% * *|TMYData.SnowDepthUncertainty|* - See [1], Table 3-6.
% * *|TMYData.LastSnowfall|* - Number of days since last snowfall (maximum 
%         value of 88, where 88 = 88 or greater days; 99 = missing data).
% * *|TMYData.LastSnowfallSource|* - See [1], Table 3-5, 8760x1 cell array
% of strings.
% * *|TMYData.LastSnowfallUncertainty|* - See [1], Table 3-6.
% * *|TMYData.PresentWeather|* - See [1], Appendix B, an 8760x1 cell array
%         of strings. Each string contains 10 numeric values. The string
%         can be parsed to determine each of 10 observed weather metrics.
%
%% Example
%
pvl_readtmy2('23050.tm2')
%% References
%
% [1] Marion, W., and Urban, K., 1995. User's Manual
% for TMY2s, National Renewable Energy Laboratory. Available online at
% <http://rredc.nrel.gov/solar/pubs/tmy2/titlepg.html>.
%
%% See Also
% <pvl_makelocationstruct_help.html |pvl_makelocationstruct|> ,
% <pvl_readtmy3_help.html |pvl_readtmy3|>,
% <pvl_maketimestruct_help.html.html |pvl_maketimestruct|> 
%%
% Copyright 2014 Sandia National Laboratories

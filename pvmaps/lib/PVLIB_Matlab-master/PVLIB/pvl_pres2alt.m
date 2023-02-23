function Alt=pvl_pres2alt(pressure)
% PVL_PRES2ALT Determine altitude from site pressure
%
% Syntax
%   Alt = pvl_pres2alt(pressure)
% 
% Description
%   PVL_PRES2ALT determines the altitude (in meters above sea level) of a 
%   site on Earth's surface given its atmospheric pressure (in Pascals). 
%   Output "Alt" is given in meters above sea level. Alt is of the same size 
%   as pressure.
%
% Assumptions include:
%   Base pressure = 101325 Pa
%   Temperature at zero altitude = 288.15 K
%   Gravitational acceleration = 9.80665 m/s^2
%   Lapse rate = -6.5E-3 K/m
%   Gas constant for air = 287.053 J/(kg*K)
%   Relative Humidity = 0%
% 
% References:
%   "A Quick Derivation relating altitude to air pressure" from Portland
%   State Aerospace Society, Version 1.03, 12/22/2004.
%
% See also PVL_ALT2PRES PVL_MAKELOCATIONSTRUCT

p = inputParser;
p.addRequired('pressure',@(x) all(isnumeric(x) & x>=0));
p.parse(pressure);

Alt=44331.5-4946.62*pressure.^(0.190263);
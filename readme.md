Collecting and analyzing weather is a crucial part of all meteorological departments; this mainly includes collecting data such as Temperature, wind speed, and wind direction. One of the easiest ways to visualize these three is by plotting polar plots. These take wind direction and windspeed, plot them in a polar plot, and then colour-code the bin according to the Temperature.
<br>
<br>
To achieve these colour-coded polar plots, the Openair package is used; this package is usually used to visualize the concentration of pollutants in the air. However, switching the pollutant with Temperature can achieve the same result for temperature-coded plots. The polar plots are divided further based on the season as the data is from the Antarctica region. The graph shown below shows that the temperature in winter is higher. 
<br>
<br>
Along with polar plots, code for simple mean temperatures and percentage changes in temperatures and wind speed is included.
<br>
<br>
The data is stored in an NCD file, so an NCDF reader is also installed, which can be skipped. The data consists of wind speed, wind direction, temperature, and time(yyyy-mm-dd hh:ss).
<br>
<br>
the end plots look like this.
<br><br>
Polar Plot
![Rplot015](https://github.com/bhargav-nvns/Polar-plots/assets/148454572/d390e775-8c39-406d-97b8-8a9d9bc486e8)
<br><br>
%change in temperature
![percentage change in varience per month](https://github.com/bhargav-nvns/Polar-plots/assets/148454572/9dd4950c-f6d8-4e89-824b-3f81535e7c88)
<br><br>
avg temperatures
<br>
![temp_day_avg](https://github.com/bhargav-nvns/Polar-plots/assets/148454572/c8b3c82c-cacd-4308-abc6-60a431e726ee)




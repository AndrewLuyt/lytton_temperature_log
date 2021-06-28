lytton_temperature_log
=======================

The script just blindly grabs the XML data off the web every 60 seconds.
The sensors record a lot of data, but we only extract the time and temperatures.
There are apparently three temperature readouts, and one value which appears at
first glance to be the maximum of the three.
The data isn't updated at **exactly** 60 second intervals as sometimes
observations are repeated - fix that in the data processing step.  Real-world data is dirty :)


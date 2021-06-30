Lytton Temperature Log
=======================

British Columbia and much of the Pacific Northwest is undergoing an unprecedented
(in recorded history) heat wave.  The village of Lytton B.C. broke Canada's all-time
high temperature record on June 27, 2021, reaching 46.6 Celsius, and eventually
maxed out at 49.6 on June 30. Out of curiosity I wanted
to keep a real-time record of how hot Lytton was.  Data was recorded from
2021-06-28 09:50:00 to 2021-06-30 11:34:00, local time.  The final .csv has
been included in this repo.

There is an automated weather station in
Lytton which publicly reports minute-by-minute sensor data as XML.
This Python script just blindly grabs the XML data off the web every 60 seconds, extracts
temperature and time readings, and appends it to a .CSV file.
There are apparently three temperature sensors on this device, and one value which 
is the "official" temperature.  This script saves them all.
The data recorded here is not a complete minute-to-minute record as there are synchronization
issues and occasional malformed XML responses which I made no attempt to deal with - 
the observations thus skip some minutes and repeat others.

There is some R code to plot two graphs:

1. Minute-by-minute temperatures over the entire dataset
2. The *distribution* of temperature *differences* between June 29 and 28. The temperatures on the two
   days are joined on the hour & minute. Any non-matching times (from incomplete data) are discarded.


Lytton Temperature Log
=======================

British Columbia and much of the Pacific Northwest is undergoing an unprecedented
(in recorded history) heat wave.  The village of Lytton B.C. broke Canada's all-time
high temperature record on June 27, 2021, reaching 46.6 Celsius.  It is likely that
today on June 28 the record will be broken again.  Out of curiosity I just wanted
to keep a real-time record of how hot Lytton was.  

There is an automated weather station in
Lytton which publicly reports minute-by-minute sensor data as XML.
This script just blindly grabs the XML data off the web every 60 seconds, extracts
temperature and time readings, and appends it to a .CSV file.
There are apparently three temperature sensors on this device, and one value which 
is the "official" temperature.  This script saves them all.
The data isn't updated at **exactly** 60 second intervals as sometimes
observations are repeated - fix that in the data processing step.  Real-world data is dirty :)


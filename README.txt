The script just blindly grabs the XML data off the web every 60 seconds.
Seemingly the data isn't updated at exactly 60 second intervals as sometimes
observations are repeated.
Fix that in the data processing step.  Real-world data is dirty :)

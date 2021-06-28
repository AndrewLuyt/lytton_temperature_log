# Rough and ready script to download data from the Lytton weather station
# every minute, during this unprecedented British Columbia heat wave.
# June 28, 2021
# Andrew Luyt

import urllib3
import xmltodict
import time

loops_completed = 0
while(True):
    # The web resource for the Lytton weather station
    URL = "https://dd.weather.gc.ca/observations/swob-ml/latest/CVLY-AUTO-minute-swob.xml"
    http = urllib3.PoolManager()
    response = http.request('GET', URL)
    data = xmltodict.parse(response.data)

    # dig down the XML tree to find the temperature - updated by the minute
    observations = data['om:ObservationCollection']['om:member']['om:Observation']['om:result']['elements']['element']

    # This particular weather station has three temperature sensors.
    # I found a French PDF online about this model and an auto-translation
    # states the three readings are sent to the "Data Management System" which
    # processes them and records an official temperature.
    # In the XML these are the properties air_temp and air_temp_{1,2,3}
    three_temps = []
    for o in observations:
        if o['@name'] == 'air_temp': current_temp = o['@value']
        if o['@name'].startswith('air_temp_'): three_temps.append(o['@value'])
        #l.append((o['@name'], o['@uom'], o['@value']))

    # datetime at the station is in the metadata
    meta = data['om:ObservationCollection']['om:member']['om:Observation']['om:metadata']['set']['identification-elements']['element']
    for m in meta:
        if m['@name'] == 'date_tm':
            current_dt = m['@value']

    with open("lytton_log.csv", mode='a' ) as outfile:
        outfile.write(f'{current_temp},{three_temps[0]},{three_temps[1]},{three_temps[2]},{current_dt}\n')

    # keep track of time on the console
    loops_completed += 1
    if loops_completed % 60 == 0:
        print(f'{loops_completed} minutes elapsed')
    time.sleep(60)

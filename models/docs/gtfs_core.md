{% docs feed_id_desc %}
Identifier for this GTFS feed version
{% enddocs %}

{% docs routes_route_id %}
Identifies a route. Must be unique within the dataset.
{% enddocs %}

{% docs routes_agency_id %}
Agency for the specified route. This field is required when the dataset contains data for multiple agencies, otherwise it is optional.
{% enddocs %}

{% docs routes_route_short_name %}
Short name of a route. This will often be a short, abstract identifier like "32", "100X", or "Green" that riders use to identify a route, but which doesn't give any indication of what places the route serves. Either route_short_name or route_long_name must be specified, or potentially both if appropriate.
{% enddocs %}

{% docs routes_route_long_name %}
Full name of a route. This name is generally more descriptive than the route_short_name and often includes the route's destination or stop. Either route_short_name or route_long_name must be specified, or potentially both if appropriate.
{% enddocs %}

{% docs routes_route_desc %}
Description of a route that provides useful, quality information. Do not simply duplicate the name of the route.
{% enddocs %}

{% docs routes_route_type %}
Indicates the type of transportation used on a route. Valid options are:
0 - Tram, Streetcar, Light rail. Any light rail or street level system within a metropolitan area.
1 - Subway, Metro. Any underground rail system within a metropolitan area.
2 - Rail. Used for intercity or long-distance travel.
3 - Bus. Used for short- and long-distance bus routes.
4 - Ferry. Used for short- and long-distance boat service.
5 - Cable tram. Used for street-level rail cars where the cable runs beneath the vehicle (e.g., cable car in San Francisco).
6 - Aerial lift, suspended cable car (e.g., gondola lift, aerial tramway). Cable transport where cabins, cars, gondolas or open chairs are suspended by means of one or more cables.
7 - Funicular. Any rail system designed for steep inclines.
11 - Trolleybus. Electric buses that draw power from overhead wires using poles.
12 - Monorail. Railway in which the track consists of a single rail or a beam.
{% enddocs %}

{% docs routes_route_url %}
URL of a web page about the particular route. Should be different from the agency.agency_url value.
{% enddocs %}

{% docs routes_route_color %}
Route color designation that matches public facing material. Defaults to white (FFFFFF) when omitted or left empty. The color difference between route_color and route_text_color should provide sufficient contrast when viewed on a black and white screen.
{% enddocs %}

{% docs routes_route_text_color %}
Legible color to use for text drawn against a background of route_color. Defaults to black (000000) when omitted or left empty. The color difference between route_color and route_text_color should provide sufficient contrast when viewed on a black and white screen.
{% enddocs %}

{% docs routes_route_sort_order %}
Orders the routes in a way which is ideal for presentation to customers. Routes with smaller route_sort_order values should be displayed first.
{% enddocs %}

{% docs routes_continuous_pickup %}
Indicates whether a rider can board the transit vehicle at any point along the vehicle's travel path. Valid options are:
0 - Continuous stopping pickup.
1 - No continuous stopping pickup.
2 - Must phone agency to arrange continuous stopping pickup.
3 - Must coordinate with driver to arrange continuous stopping pickup.
{% enddocs %}

{% docs routes_continuous_drop_off %}
Indicates whether a rider can alight from the transit vehicle at any point along the vehicle's travel path. Valid options are:
0 - Continuous stopping drop off.
1 - No continuous stopping drop off.
2 - Must phone agency to arrange continuous stopping drop off.
3 - Must coordinate with driver to arrange continuous stopping drop off.
{% enddocs %}

{% docs routes_network_id %}
Identifies a group of routes that are shown to riders together as a single service to help riders better understand the transit network. Routes with the same network_id should be shown together on maps, schedules, and other rider materials.
{% enddocs %}

{% docs trips_route_id %}
Identifies a route.
{% enddocs %}

{% docs trips_service_id %}
Identifies a set of dates when service is available for one or more routes.
{% enddocs %}

{% docs trips_trip_id %}
Identifies a trip.
{% enddocs %}

{% docs trips_trip_headsign %}
Text that appears on signage identifying the trip's destination to riders. This field is recommended for all services with headsign text displayed on the vehicle which may be used to distinguish amongst trips in a route. If the headsign changes during a trip, values for trip_headsign may be overridden by defining values in stop_times.stop_headsign for specific stop_times along the trip.
{% enddocs %}

{% docs trips_trip_short_name %}
Public facing text used to identify the trip to riders, for instance, to identify train numbers for commuter rail trips. If riders do not commonly rely on trip names, trip_short_name should be empty. A trip_short_name value, if provided, should uniquely identify a trip within a service day; it should not be used for destination names or limited/express designations.
{% enddocs %}

{% docs trips_direction_id %}
Indicates the direction of travel for a trip. This field should not be used in routing; it provides a way to separate trips by direction when publishing time tables. Valid options are:
0 - Travel in one direction (e.g. outbound travel).
1 - Travel in the opposite direction (e.g. inbound travel).
{% enddocs %}

{% docs trips_block_id %}
Identifies the block to which the trip belongs. A block consists of a single trip or many sequential trips made using the same vehicle, defined by shared service days and block_id. A block_id may have trips with different service days, making distinct blocks.
{% enddocs %}

{% docs trips_shape_id %}
Identifies a geospatial shape describing the vehicle travel path for a trip. Required if the trip has continuous pickup or drop-off behavior defined either in routes.txt or in stop_times.txt.
{% enddocs %}

{% docs trips_wheelchair_accessible %}
Indicates wheelchair accessibility. Valid options are:
0 or empty - No accessibility information for the trip.
1 - Vehicle being used on this particular trip can accommodate at least one rider in a wheelchair.
2 - No riders in wheelchairs can be accommodated on this trip.
{% enddocs %}

{% docs trips_bikes_allowed %}
Indicates whether bikes are allowed. Valid options are:
0 or empty - No bike information for the trip.
1 - Vehicle being used on this particular trip can accommodate at least one bicycle.
2 - No bicycles are allowed on this trip.
{% enddocs %}

{% docs calendar_service_id %}
Identifies a set of dates when service is available for one or more routes.
{% enddocs %}

{% docs calendar_monday %}
Indicates whether the service operates on all Mondays in the date range specified by the start_date and end_date fields. Note that exceptions for particular dates may be listed in calendar_dates.txt. Valid options are:
1 - Service is available for all Mondays in the date range.
0 - Service is not available for Mondays in the date range.
{% enddocs %}

{% docs calendar_tuesday %}
Functions in the same way as monday except applies to Tuesdays
{% enddocs %}

{% docs calendar_wednesday %}
Functions in the same way as monday except applies to Wednesdays
{% enddocs %}

{% docs calendar_thursday %}
Functions in the same way as monday except applies to Thursdays
{% enddocs %}

{% docs calendar_friday %}
Functions in the same way as monday except applies to Fridays
{% enddocs %}

{% docs calendar_saturday %}
Functions in the same way as monday except applies to Saturdays.
{% enddocs %}

{% docs calendar_sunday %}
Functions in the same way as monday except applies to Sundays.
{% enddocs %}

{% docs calendar_start_date %}
Start service day for the service interval.
{% enddocs %}

{% docs calendar_end_date %}
End service day for the service interval. This service day is included in the interval.
{% enddocs %}

{% docs calendar_dates_service_id %}
Identifies a set of dates when a service exception occurs for one or more routes. Each (service_id, date) pair may only appear once in calendar_dates.txt if using calendar.txt and calendar_dates.txt in conjunction. If a service_id value appears in both calendar.txt and calendar_dates.txt, the information in calendar_dates.txt modifies the service information specified in calendar.txt.
{% enddocs %}

{% docs calendar_dates_date %}
Date when service exception occurs.
{% enddocs %}

{% docs calendar_dates_exception_type %}
Indicates whether service is available on the date specified in the date field. Valid options are:
1 - Service has been added for the specified date.
2 - Service has been removed for the specified date.
{% enddocs %}

{% docs stops_stop_id %}
Identifies a location: stop/platform, station, entrance/exit, generic node or boarding area. ID must be unique across all stops.stop_id, locations.geojson id, and location_groups.location_group_id values. Multiple routes may use the same stop_id.
{% enddocs %}

{% docs stops_stop_code %}
Short text or a number that identifies the location for riders. These codes are often used in phone-based transit information systems or printed on signage to make it easier for riders to get information for a particular location. The stop_code may be the same as stop_id if it is public facing. This field should be left empty for locations without a code presented to riders.
{% enddocs %}

{% docs stops_stop_name %}
Name of the location. The stop_name should match the agency's rider-facing name for the location as printed on a timetable, published online, or represented on signage. For translations into other languages, use translations.txt. When the location is a boarding area (location_type=4), the stop_name should contains the name of the boarding area as displayed by the agency. It could be just one letter (like on some European intercity railway stations), or text like "Wheelchair boarding area" (NYC's Subway) or "Head of short trains" (Paris' RER).
{% enddocs %}

{% docs stops_tts_stop_name %}
Readable version of the stop_name. See "Text-to-speech field" in the GTFS Term Definitions for more information.
{% enddocs %}

{% docs stops_stop_desc %}
Description of the location that provides useful, quality information. Should not be a duplicate of stop_name.
{% enddocs %}

{% docs stops_stop_lat %}
Latitude of the location. For stops/platforms (location_type=0) and boarding area (location_type=4), the coordinates must be the ones of the bus pole — if exists — and otherwise of where the travelers are boarding the vehicle (on the sidewalk or the platform, and not on the roadway or the track where the vehicle stops).
{% enddocs %}

{% docs stops_stop_lon %}
Longitude of the location. For stops/platforms (location_type=0) and boarding area (location_type=4), the coordinates must be the ones of the bus pole — if exists — and otherwise of where the travelers are boarding the vehicle (on the sidewalk or the platform, and not on the roadway or the track where the vehicle stops).
{% enddocs %}

{% docs stops_zone_id %}
Identifies the fare zone for a stop. If this record represents a station or station entrance, the zone_id is ignored.
{% enddocs %}

{% docs stops_stop_url %}
URL of a web page about the location. This should be different from the agency.agency_url and the routes.route_url field values.
{% enddocs %}

{% docs stops_location_type %}
Location type. Valid options are:
0 (or empty) - Stop (or Platform). A location where passengers board or disembark from a transit vehicle. Is called a platform when defined within a parent_station.
1 - Station. A physical structure or area that contains one or more platform.
2 - Entrance/Exit. A location where passengers can enter or exit a station from the street. If an entrance/exit belongs to multiple stations, it may be linked by pathways to both, but the data provider must pick one of them as parent.
3 - Generic Node. A location within a station, not matching any other location_type, that may be used to link together pathways define in pathways.txt.
4 - Boarding Area. A specific location on a platform, where passengers can board and/or alight vehicles.
{% enddocs %}

{% docs stops_parent_station %}
Defines hierarchy between the different locations defined in stops.txt. It contains the ID of the parent location, as followed:
- Stop/platform (location_type=0): the parent_station field contains the ID of a station.
- Station (location_type=1): this field must be empty.
- Entrance/exit (location_type=2) or generic node (location_type=3): the parent_station field contains the ID of a station (location_type=1)
- Boarding Area (location_type=4): the parent_station field contains ID of a platform.
{% enddocs %}

{% docs stops_wheelchair_boarding %}
Indicates whether wheelchair boardings are possible from the location. Valid options are:
For parentless stops:
0 or empty - No accessibility information for the stop.
1 - Some vehicles at this stop can be boarded by a rider in a wheelchair.
2 - Wheelchair boarding is not possible at this stop.
For child stops:
0 or empty - Stop will inherit its wheelchair_boarding behavior from the parent station, if specified in the parent.
1 - There exists some accessible path from outside the station to the specific stop/platform.
2 - There exists no accessible path from outside the station to the specific stop/platform.
For station entrances/exits:
0 or empty - Station entrance will inherit its wheelchair_boarding behavior from the parent station, if specified for the parent.
1 - Station entrance is wheelchair accessible.
2 - No accessible path from station entrance to stops/platforms.
{% enddocs %}

{% docs stops_stop_timezone %}
Timezone of the location. If the location has a parent station, it inherits the parent station's timezone instead of applying its own. Stations and parentless stops with empty stop_timezone inherit the timezone specified by agency.agency_timezone. The times provided in stop_times.txt are in the timezone specified by agency.agency_timezone, not stop_timezone. This ensures that the time values in a trip always increase over the course of a trip, regardless of which timezones the trip crosses.
{% enddocs %}

{% docs stops_level_id %}
Level of the location. The same level may be used by multiple unlinked stations.
{% enddocs %}

{% docs stops_platform_code %}
Platform identifier for a platform stop (a stop belonging to a station). This should be just the platform identifier (eg. "G" or "3"). Words like "platform" or "track" (or the feed's language-specific equivalent) should not be included. This allows feed consumers to more easily internationalize and localize the platform identifier into other languages.
{% enddocs %}

{% docs stop_times_trip_id %}
Identifies a trip.
{% enddocs %}

{% docs stop_times_arrival_time %}
Arrival time at the stop (defined by stop_times.stop_id) for a specific trip (defined by stop_times.trip_id) in the time zone specified by agency.agency_timezone, not stops.stop_timezone. If there are not separate times for arrival and departure at a stop, arrival_time and departure_time should be the same. For times occurring after midnight on the service day, enter the time as a value greater than 24:00:00 in HH:MM:SS. If exact arrival and departure times (timepoint=1) are not available, estimated or interpolated arrival and departure times (timepoint=0) should be provided. Required for the first and last stop in a trip, required for timepoint=1, forbidden when start_pickup_drop_off_window or end_pickup_drop_off_window are defined, optional otherwise.
{% enddocs %}

{% docs stop_times_departure_time %}
Departure time from the stop (defined by stop_times.stop_id) for a specific trip (defined by stop_times.trip_id) in the time zone specified by agency.agency_timezone, not stops.stop_timezone. If there are not separate times for arrival and departure at a stop, arrival_time and departure_time should be the same. For times occurring after midnight on the service day, enter the time as a value greater than 24:00:00 in HH:MM:SS. If exact arrival and departure times (timepoint=1) are not available, estimated or interpolated arrival and departure times (timepoint=0) should be provided. Required for timepoint=1, forbidden when start_pickup_drop_off_window or end_pickup_drop_off_window are defined, optional otherwise.
{% enddocs %}

{% docs stop_times_stop_id %}
Identifies the serviced stop. All stops serviced during a trip must have a record in stop_times.txt. Referenced locations must be stops/platforms, i.e. their stops.location_type value must be 0 or empty. A stop may be serviced multiple times in the same trip, and multiple trips and routes may service the same stop. Required if location_group_id AND location_id are NOT defined. Forbidden if location_group_id or location_id are defined.
{% enddocs %}

{% docs stop_times_stop_sequence %}
Order of stops for a particular trip. The values must increase along the trip but do not need to be consecutive.
{% enddocs %}

{% docs stop_times_stop_headsign %}
Text that appears on signage identifying the trip's destination to riders. This field overrides the default trips.trip_headsign when the headsign changes between stops. If the headsign is displayed for an entire trip, trips.trip_headsign should be used instead. A stop_headsign value specified for one stop_time does not apply to subsequent stop_times in the same trip. If you want to override the trip_headsign for multiple stop_times in the same trip, the stop_headsign value must be repeated in each stop_time row.
{% enddocs %}

{% docs stop_times_pickup_type %}
Indicates pickup method. Valid options are:
0 or empty - Regularly scheduled pickup.
1 - No pickup available.
2 - Must phone agency to arrange pickup.
3 - Must coordinate with driver to arrange pickup.
{% enddocs %}

{% docs stop_times_drop_off_type %}
Indicates drop off method. Valid options are:
0 or empty - Regularly scheduled drop off.
1 - No drop off available.
2 - Must phone agency to arrange drop off.
3 - Must coordinate with driver to arrange drop off.
{% enddocs %}

{% docs stop_times_shape_dist_traveled %}
Actual distance traveled along the associated shape, from the first stop to the stop specified in this record. This field specifies how much of the shape to draw between any two stops during a trip. Must be in the same units used in shapes.txt. Values used for shape_dist_traveled must increase along with stop_sequence; they must not be used to show reverse travel along a route.
{% enddocs %}

{% docs stop_times_timepoint %}
Indicates if arrival and departure times for a stop are strictly adhered to by the vehicle or if they are instead approximate and/or interpolated times. This field allows a GTFS producer to provide interpolated stop-times, while indicating that the times are approximate. Valid options are:
0 - Times are considered approximate.
1 - Times are considered exact.
{% enddocs %}

{% docs stop_times_start_pickup_drop_off_window %}
Time that on-demand service becomes available in a GeoJSON location, location group, or stop. Required if location_group_id or location_id is defined, required if end_pickup_drop_off_window is defined, forbidden if arrival_time or departure_time is defined, optional otherwise.
{% enddocs %}

{% docs stop_times_end_pickup_drop_off_window %}
Time that on-demand service ends in a GeoJSON location, location group, or stop. Required if location_group_id or location_id is defined, required if start_pickup_drop_off_window is defined, forbidden if arrival_time or departure_time is defined, optional otherwise.
{% enddocs %}

{% docs stop_times_continuous_pickup %}
Indicates that the rider can board the transit vehicle at any point along the vehicle's travel path as described by shapes.txt, from this stop_time to the next stop_time in the trip's stop_sequence. Valid options are:
0 - Continuous stopping pickup.
1 or empty - No continuous stopping pickup.
2 - Must phone agency to arrange continuous stopping pickup.
3 - Must coordinate with driver to arrange continuous stopping pickup.
If this field is populated, it overrides any continuous pickup behavior defined in routes.txt. If this field is empty, the stop_time inherits any continuous pickup behavior defined in routes.txt. Forbidden if start_pickup_drop_off_window or end_pickup_drop_off_window are defined.
{% enddocs %}

{% docs stop_times_continuous_drop_off %}
Indicates that the rider can alight from the transit vehicle at any point along the vehicle's travel path as described by shapes.txt, from this stop_time to the next stop_time in the trip's stop_sequence. Valid options are:
0 - Continuous stopping drop off.
1 or empty - No continuous stopping drop off.
2 - Must phone agency to arrange continuous stopping drop off.
3 - Must coordinate with driver to arrange continuous stopping drop off.
If this field is populated, it overrides any continuous drop-off behavior defined in routes.txt. If this field is empty, the stop_time inherits any continuous drop-off behavior defined in routes.txt. Forbidden if start_pickup_drop_off_window or end_pickup_drop_off_window are defined.
{% enddocs %}

{% docs stop_times_pickup_booking_rule_id %}
Identifies the boarding booking rule at this stop time. Recommended when pickup_type=2.
{% enddocs %}

{% docs stop_times_drop_off_booking_rule_id %}
Identifies the alighting booking rule at this stop time. Recommended when drop_off_type=2.
{% enddocs %}

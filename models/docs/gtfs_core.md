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

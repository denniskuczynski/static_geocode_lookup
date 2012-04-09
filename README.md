static_geocode_lookup
===============
Simple wrapper for an AWK Script to lookup US Geocodes from a static spreadsheet.

The Geocode data was pulled from: http://www.sujee.net/tech/articles/geocoded/
Geocode CSV files from populardata.com with updates by Sujee Maniyam.

``` ruby
gem static_geocode_lookup
```

Examples:
---------------
``` ruby
puts StaticGeocodeLookup.lookup_by_zipcode(1001).inspect  
# nil, not enough digits

puts StaticGeocodeLookup.lookup_by_zipcode(10012).inspect 
# {:latitude=>"40.729124", :longitude=>"-73.991582", :city=>"NEW YORK", :state=>"NY"}

puts StaticGeocodeLookup.lookup_by_city("New York, NY").inspect 
# {:latitude=>"40.729124", :longitude=>"-73.991582", :city=>"NEW YORK", :state=>"NY"}

puts StaticGeocodeLookup.lookup_by_city("New York, New York").inspect
# {:city=>"NEW YORK", :state=>"NY", :latitude=>"40.757929", :longitude=>"-73.985506"}

puts StaticGeocodeLookup.lookup_by_city("New York").inspect
# {:city=>"NEW YORK", :state=>"NY", :latitude=>"40.757929", :longitude=>"-73.985506"}

puts StaticGeocodeLookup.lookup_by_city("Atlantis").inspect 
#nil, mythical city
```

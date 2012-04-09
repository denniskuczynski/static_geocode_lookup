require "static_geocode_lookup/version"

module StaticGeocodeLookup
  
  ZIPCODE_FILE = File.dirname(__FILE__)+"/data/zips_v2.csv"
  CITIES_FILE = File.dirname(__FILE__)+"/data/cities.csv"
  
  def self.lookup_by_zipcode(zipcode)
    # awk search against the zipcode column
    awk_script = "awk -F, -v zip=\"\\\"#{zipcode}\\\"\" 'zip==$1 {print $0}' #{ZIPCODE_FILE}"
    script_result = `#{awk_script}`
    lines = script_result.strip.split(/\r?\n/)
    if lines.size == 0
      nil
    else
      values = lines[0].split(",")
      geo_hash = Hash.new
      geo_hash[:latitude] = strip_quotes(values[1])
      geo_hash[:longitude] = strip_quotes(values[2])
      geo_hash[:city] = strip_quotes(values[3])
      geo_hash[:state] = strip_quotes(values[4])
      geo_hash
    end
  end
  
  def self.lookup_by_city(input_city)
    city = ""
    state = ""
    # Check if input_city is in the format CITY, STATE
    city_split = input_city.split(",")
    if city_split.size == 2
      city = city_split[0].upcase.strip
      state = city_split[1].upcase.strip
      if state.size != 2
        state = get_two_character_code(state)
      end
    else
      city = input_city.upcase.strip
    end
    # awk search against the city column (and state if not empty string quotes)
    awk_script = "awk -F, -v city=\"\\\"#{city}\\\"\" -v state=\"\\\"#{state}\\\"\" 'city==$1 && (length(state) == 2 || state==$2) {print $0}' #{CITIES_FILE}"
    script_result = `#{awk_script}`
    lines = script_result.strip.split(/\r?\n/)
    if lines.size == 0
      nil
    else
      values = lines[0].split(",")
      geo_hash = Hash.new
      geo_hash[:city] = strip_quotes(values[0])
      geo_hash[:state] = strip_quotes(values[1])
      geo_hash[:latitude] = strip_quotes(values[2])
      geo_hash[:longitude] = strip_quotes(values[3])
      geo_hash
    end
  end
  
  def self.strip_quotes(string)
    if string.nil?
      nil
    else
      string[1,string.length-2]
    end
  end
  
  def self.get_two_character_code(state)
    case state
    when "ALASKA"
      "AK"
    when "MONTANA"
      "MT"
    when "ALABAMA"
      "AL"
    when "NEBRASKA"
    	"NE"
    when "ARKANSAS"
      "AR"
    when "NORTH CAROLINA"
      "NC"
    when "ARIZONA"
      "AZ"
    when "NORTH DAKOTA"
    	"ND"
    when "CALIFORNIA"
      "CA"
    when "NEW HAMPSHIRE"
    	"NH"
    when "COLORADO"
      "CO"
    when "NEW JERSEY"
      "NJ"
    when "CONNECTICUT"
      "CT"
    when "NEW MEXICO"
      "NM"
    when "NEW YORK"
      "NY"
    when "DISTRICT OF COLUMBIA"
      "DC"
    when "NEVADA"
      "NV"
    when "DELAWARE"
      "DE"
    when "OHIO"
      "OH"
    when "FLORIDA"
      "FL"
    when "OKLAHOMA"
      "OK"
    when "GEORGIA"
      "GA"
    when "OREGON"
      "OR"
    when "HAWAII"
      "HI"
    when "PENNSYLVANIA"
      "PA"
    when "IOWA"
      "IA"
    when "IDAHO"
      "ID"
    when "RHODE ISLAND"
      "RI"
    when "ILLINOIS"
      "IL"
    when "SOUTH CAROLINA"
      "SC"
    when "INDIANA"
      "IN"
    when "SOUTH DAKOTA"
      "SD"
    when "KANSAS"
      "KS"
    when "TENNESSEE"
      "TN"
    when "KENTUCKY"
      "KY"
    when "TEXAS"
      "TX"
    when "LOUISIANA"
      "LA"
    when "UTAH"
      "UT"
    when "MASSACHUSETTS"
      "MA"
    when "VIRGINIA"
      "VA"
    when "MARYLAND"
      "MD"
    when "MAINE"
      "ME"
    when "VERMONT"
      "VT"
    when "MICHIGAN"
      "MI"
    when "WASHINGTON"
      "WA"
    when "MINNESOTA"
      "MN"
    when "WISCONSIN"
      "WI"
    when "MISSOURI"
      "MO"
    when "WEST VIRGINIA"
      "WV"
    when "MISSISSIPPI"
      "MS"
    when "WYOMING"
      "WY"
    else
      raise RuntimeError, "Unable to find code for US State \"#{state}\""
    end
  end
end

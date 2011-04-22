module Burn

  # According to [1], there is a no-burn day advisory when either the high 
  # pollution advisory or health watch flags are set to true
  #
  # For further details, please examine [2]
  #
  # [1] http://www.cleanairmakemore.com/embed-widget-thin.html
  # [2] http://www.cleanairmakemore.com/widget_json.cfm
  class Phx

    attr_accessor :air_quality_index,
                  :high_pollution_advisory,
                  :health_watch,
                  :allow_ohvehicles,
                  :allow_leafblowers,
                  :allow_woodburning,
                  :date

    def initialize
      data = fetch_data
      self.air_quality_index = data["aqi"]
      self.high_pollution_advisory = data["hpa"]
      self.health_watch = data["hw"]
      self.allow_ohvehicles = data["ohvehicles"]
      self.allow_leafblowers = data["leafblowers"]
      self.allow_woodburning = data["woodburning"]
      self.date = Time.new.strftime("%b %d, %Y")
    end

    def is_no_burn_day?
      self.high_pollution_advisory || self.health_watch
    end

    def fetch_data
      json = fetch_json
      data = JSON.parse(json)
      data
    end

    # Fetches JSON from our third party. Also, fixes bad JSON by
    # removing everything after "facts" 
    #
    # Returns the follow JSON
    def fetch_json
      res = open("http://www.cleanairmakemore.com/widget_json.cfm").read

      # Documented in views/burn/phx/data.json.
      s = res.index("facts")
      json = res[0, s-4] + "}"

      # json = File.read("views/burn/phx/data.json")
      json
    end

    # def fetch_json_from_cache
    #   json = $cache.get("clean_air_make_more_json")
    #   if json.nil?
    #     json = fetch_json
    #     $cache.set("clean_air_make_more_json", json, 60)
    #   end
    #   json
    # end
  end

end
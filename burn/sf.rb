require "nokogiri"

module Burn

  class Sf

    attr_accessor :message,
                  :offsite_link,
                  :date

    def initialize
      data = fetch_data
      self.message = data["message"]
      self.offsite_link = data["offsite_link"]
      self.date = data["date"]
    end

    def is_spare_the_air_day?
      self.message != "No Spare the Air Alert in Effect"
    end

    def fetch_data
      fetch_html
    end

    # Fetches HTML from http://www.baaqmd.gov/
    #
    def fetch_html
      res = open("http://www.baaqmd.gov/Feeds/BurnStatusIframe.aspx").read
      # res = File.read("views/burn/sf/burnstatus_iframe.html")

      html_doc = Nokogiri::HTML(res)
      data = {}
      data["date"] = html_doc.css("div.sta-day/div.aq12").text
      data["message"] = html_doc.css("div.sta-day/div.aq10/a").text
      data["offsite_link"] = html_doc.css("div.sta-day/div.aq10/a").attribute("href").text

      data
    end
  end

end
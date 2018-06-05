# The [RFC 3339](https://tools.ietf.org/html/rfc3339) datetime format ([ISO 8601](http://xml.coverpages.org/ISO-FDIS-8601.pdf) profile).
struct Time::Format
  module RFC_3339
    # Parses a string into a `Time`.
    def self.parse(string, location = Time::Location::UTC) : Time
      parser = Parser.new(string)
      parser.rfc_3339
      parser.time(location)
    end

    # Formats a `Time` into the given *io*.
    def self.format(time : Time, io : IO)
      formatter = Formatter.new(time, io)
      formatter.rfc_3339
      io
    end

    # Formats a `Time` into a `String`.
    def self.format(time : Time)
      String.build do |io|
        format(time, io)
      end
    end
  end

  module Pattern
    def rfc_3339
      year_month_day
      char 'T', 't', ' '
      twenty_four_hour_time_with_seconds
      second_fraction?
      time_zone_z_or_offset(force_colon: true)
    end
  end
end
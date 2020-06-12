# frozen_string_literal: true

module Lightspeed
  class RequestThrottler
    attr_accessor :bucket_level, :bucket_max, :units_per_second

    def initialize
      @units_per_second = 0.5
      @bucket_max = Float::INFINITY
      @bucket_level = 0
    end

    def perform_request request
      u = units request
      sleep(u / @units_per_second) if @bucket_level + u > @bucket_max
      response = request.perform
      extract_rate_limits request
      response
    end

    private

    def units request
      if request.raw_request.is_a? Net::HTTP::Get then 1 else 10 end
    end

    def extract_rate_limits request
      @bucket_max, @bucket_level = request.bucket_max, request.bucket_level
      @units_per_second = @bucket_max/60.0
    end

  end
end

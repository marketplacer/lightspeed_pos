# frozen_string_literal: true

module Lightspeed
  class Error < Exception
    class BadRequest < Lightspeed::Error; end # 400
    class Unauthorized < Lightspeed::Error; end # 401
    class NotAuthorized < Lightspeed::Error; end # 403
    class NotFound < Lightspeed::Error; end # 404
    class InternalServerError < Lightspeed::Error; end # 500
    class Throttled < Lightspeed::Error; end # 503
  end
end

module Lightspeed
  class Error < Exception
    class BadRequest < Exception; end # 400
    class Unauthorized < Exception; end # 401
    class NotFound < Exception; end # 404
    class InternalServerError < Exception; end # 500
    class Throttled < Exception; end #503
  end
end

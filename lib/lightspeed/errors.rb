module Lightspeed
  module Errors
    class BadRequest < Exception; end # 400
    class Unauthorized < Exception; end # 401
    class NotFound < Exception; end # 404
  end
end

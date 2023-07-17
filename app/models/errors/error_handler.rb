module Errors
  module ErrorHandler
    class ApiValidationError < StandardError
      def initialize(message = nil)
        super(message)
      end
    end
  end
end
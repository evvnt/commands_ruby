require 'commands/base_response'

module Commands
  module Response
    # Err contains the error of a failed operation.
    class Err < Commands::BaseResponse
      def initialize(error, status: 0, messages: {})
        super(data: error, status: status, messages: messages)
      end

      def succeeded?
        false
      end

      def unwrap!
        raise Commands::UnwrapError, 'Called unwrap! on an Err value'
      end

      def unwrap_err!
        data
      end

      def and(result)
        self
      end

      def and_then
        self
      end

      def map
        self
      end

      def map_or(default)
        default
      end

      def map_or_else(default, fn)
        default.call(data)
      end

      def map_err
        new(yield data)
      end

      def or(result)
        result
      end

      def or_else
        yield data
      end

      def unwrap_or(default)
        default
      end

      def unwrap_or_else
        yield data
      end
    end
  end
end

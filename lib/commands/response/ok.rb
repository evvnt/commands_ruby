require 'commands/base_response'

module Commands
  module Response
    # Ok contains the result of a successful operation.
    class Ok < Commands::BaseResponse
      def initialize(value, status: 0, messages: {})
        super(data: value, status: status, messages: messages)
      end

      def succeeded?
        true
      end

      def unwrap!
        data
      end

      def unwrap_err!
        raise Commands::UnwrapError, 'Called unwrap_err! on an Ok value'
      end

      def and(result)
        result
      end

      def and_then
        yield data
      end

      def map
        Ok(yield data)
      end

      def map_or(default)
        yield data
      end

      def map_or_else(default, fn)
        fn.call(data)
      end

      def map_err
        self
      end

      def or(result)
        self
      end

      def or_else
        self
      end

      def unwrap_or(default)
        data
      end

      def unwrap_or_else
        data
      end
    end
  end
end

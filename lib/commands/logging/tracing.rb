module Commands
  module Logging
    module Tracing
      include Commands::Logging::Logger

      # Use a regex on your classes to enable debug logging
      # For example:
      # In your .env
      # export TRACE_LOG_REGEX="^.*TicketVouchers.*$"
      # In your code
      # debug {"WTF went wrong!" }
      def trace(&block)
        return unless ENV['TRACE_LOG_REGEX'].present?
        logger.info {"T:#{self.class}:#{block&.call}"} if /#{ENV['TRACE_LOG_REGEX']}/.match(self.class.name)
      end
    end
  end
end

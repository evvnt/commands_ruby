require 'honeybadger'

module Commands
  module Logging
    module Logger
      def logger
        if defined?(Rails)
          Rails.logger
        else
          @logger ||= ::Logger.new(STDOUT)
        end
      end

      # log_exception logs an exception to the current logger as a newline-
      # delimited text or JSON error depending on the value of the
      # +DISABLE_JSON_LOGGING+ environment variable.
      def log_exception(exception, context: nil)
        message = "#{exception.class.name} (#{exception.message})"
        message << " during #{context}" if context

        if ENV['DISABLE_JSON_LOGGING']
          logger.error { [message, *exception.backtrace].join($INPUT_RECORD_SEPARATOR) }
        else
          logger.error { "#{message}: #{exception.backtrace.first}" }
          logger.error { JSON.dump(message: message, backtrace: exception.backtrace) }
        end
      end

      def report_exception(exception, reporter: Honeybadger.method(:notify), **options)
        reporter.call(exception, **options)
      end
    end
  end
end

module Commands
  module RescueLogicalErrors
    include Commands::SuccessAndFail
    include Commands::ExtractErrors
    include Logging::Logger

    # A logical error is one that we can notify the user about and they can use that information to fix their request
    # ParameterValidation is a logical error
    # UnableToFind or AR::RecordNotFound is a logical error
    # Foreign key violations - might be logical so we handle them as such
    # Anything else is logged, honey badger is notified and a 500 is returned.
    def rescue_logical_errors(error: true, &block)
      begin
        block.call
      rescue Errors::LogicalError => e
        fail(errors: extract_errors(e, error: error), status: 422)
      rescue ActiveRecord::RecordNotFound => e
        fail(errors: extract_errors(e, error: error), status: 404)
      rescue ActiveRecord::InvalidForeignKey => e
        fail(errors: extract_fk_errors(e, error: error), status: 422)
      rescue Errors::NotAuthorizedException => e
        report_and_log_exception(e, 403)
      rescue StandardError => e
        report_and_log_exception(e, 500)
      end
    end

    private

    def report_and_log_exception(e, status)
      report_exception(e)
      log_exception(e)

      fail(errors: e.message, status: status)
    end
  end
end

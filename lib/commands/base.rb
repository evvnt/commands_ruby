module Commands
  class Base
    class << self
      # This should ONLY be called at the controller or top level. It eats exceptions!
      # When this is called you should check the response object for success/failure
      def call(**params)
        rescue_logical_errors {new(params).call}
      end

      # convenience method for new(params).call
      def call!(**params)
        new(params).call
      end

      include Commands::ExtractErrors
      include Commands::RescueLogicalErrors
    end
    # @depreciated
    attr_reader :dependencies

    def initialize(**params)
      @dependencies = default_dependencies.merge(params[:dependencies]||{})
    end

    # @depreciated
    def call_workflow(_name_, **params)
      @dependencies[_name_].new(params).call
    end

    private

    include Helpers
    include Logging::Tracing
    include Commands::AggregateValidations
    include Commands::Namespace
    include Commands::SuccessAndFail

    def transaction
      ActiveRecord::Base.transaction do
        yield
      end
    end

    # @depreciated
    def default_dependencies
      {}
    end
  end
end


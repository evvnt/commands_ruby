module Commands
  module Errors
    # Error thrown when a invalid state is being applied
    class InvalidState < Errors::LogicalError
    end
  end
end

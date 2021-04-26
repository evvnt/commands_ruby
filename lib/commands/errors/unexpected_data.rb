module Commands
  module Errors
    # Raised when a data is in an inconsistent state
    class UnexpectedData < StandardError; end
  end
end
module Commands
  module Errors
    # Error thrown when invalid argument is passed
    # Example use: thrown from a helper to indicate the developer did not use the helper correctly.
    # It is a standard error meaning it won't be handled as a logical error and will fail and report to honeybadger
    class InvalidArgument < StandardError
    end
  end
end

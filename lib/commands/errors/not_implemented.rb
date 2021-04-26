module Commands
  module Errors
    # Raised when a method needs to be implemented in a derived class
    class NotImplemented < StandardError; end
  end
end
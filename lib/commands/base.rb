require 'commands/responses'

module Commands
  # TODO: rename me
  module Base
    def self.extended(base)
      base.include Commands::Responses
    end

    # call the command, rescuing from raised errors and instead returning +Commands::Response::Err+.
    def call(params)
      new(params).call
    rescue StandardError => e
      Commands::Response::Err.new(e)
    end

    # call! runs the command, raising on failure instead of wrapping the result in a
    # +Commands::Response::Err+.
    def call!(params)
      call(params).or_else { |error| raise error }
    end
  end
end

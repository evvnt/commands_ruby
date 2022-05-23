require 'commands/response/ok'
require 'commands/response/err'

module Commands
  module Responses
    # success returns +Ok+ containing +data+ with the provided +status+, +warnings+, and +info+.
    def success(data: nil, status: 0, warnings: nil, info: nil)
      Commands::Response::Ok.new(data, status: status, messages: { warnings: warnings, info: info })
    end

    # fail returns +Err+ containing +error+ with the provided +status, +warnings+, and +info+.
    def fail(error: nil, status: 1, warnings: nil, info: nil)
      Commands::Response::Err.new(error, status: status, messages: { warnings: warnings, info: info })
    end

    # ok returns +Ok+ containing +data+.
    # +ok+ is the short form for the common case +success(data: ...)+.
    def ok(data = nil)
      success(data: data)
    end

    # err returns +Err+ containing +error+.
    # +err+ is the short form for the common case +fail(error: ...)+.
    def err(error = nil)
      fail(error: error)
    end
  end
end

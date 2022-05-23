require 'commands/alias'
require 'commands/messages'

module Commands
  # BaseResponse wraps the result of an operation which may fail.
  # Responses contain a single datum, a status code, and metadata (warnings and info).
  class BaseResponse
    extend Commands::Alias
    attr_reader :data, :status, :warnings, :info

    def initialize(data: nil, status: 0, messages: {})
      @data = data
      @status = status
      @messages = Messages.new(**messages)
      @warnings = @messages.warnings
      @info = @messages.info
    end

    # succeeded? indicates if the wrapped operation was successful.
    def succeeded?
      raise NotImplementedError
    end
    inheritable_alias :success?, :succeeded?
    inheritable_alias :has_succeeded?, :succeeded?
    inheritable_alias :ok?, :succeeded?

    # failed? indicates if the wrapped operation did not succeed.
    def failed?
      !succeeded?
    end
    inheritable_alias :fail?, :failed?
    inheritable_alias :failure?, :failed?
    inheritable_alias :has_failed?, :failed?
    inheritable_alias :err?, :failed?

    def to_h
      { data: data, status: status, messages: messages.to_h }
    end

    # Return the contained value of +Ok+, or raising if +Err+.
    def unwrap!
      raise NotImplementedError
    end

    # Return the contained errors of +Err+, or raising if +Ok+.
    def unwrap_err!
      raise NotImplementedError
    end

    # Return +result+ if +Ok+, or +self+ otherwise.
    # +and+ is the eagerly-evaluated equivalent of +and_then+ and the inverse operation of +or+.
    def and(result)
      raise NotImplementedError
    end

    # If +Ok+, call the provided block, returning its +Result+ value. Otherwise, returns +self+.
    # +and_then+ is the lazily-evaluated equivalent of +and+ and the inverse operation of +or_else+.
    def and_then
      raise NotImplementedError
    end

    # If +Ok+, map the contained value into a new +Ok+ via the provided block. Otherwise, returns
    # +self+.
    def map
      raise NotImplementedError
    end

    # Return the provided +default+ value if +Err+, or applies the provided block to the contained
    # value if +Ok+.
    def map_or(default)
      raise NotImplementedError
    end

    # Return the value of the +default+ block/proc/lambda if +Err+, or applies
    # the provided +fn+ to the contained value if +Ok+.
    def map_or_else(default, fn)
      raise NotImplementedError
    end

    # Map an +Err+ to a +Response+ via the provided block, leaving an +Ok+ value untouched.
    def map_err
      raise NotImplementedError
    end

    # Return +result+ if +Err+, otherwise +self+.
    # +or+ is the eagerly-evaluated equivalent of +or_else+ and the inverse operation of +and+.
    def or(result)
      raise NotImplementedError
    end

    # Return the value of the provided block if +Err+, otherwise returning +self+ if +Ok+.
    # +or_else+ is the lazily-evaluated equivalent of +or+ and the inverse operation of +and_then+.
    def or_else
      raise NotImplementedError
    end

    # Return the contained value if +Ok+, or +default+ if +Err+.
    # +unwrap_or+ is the eagerly-evaluated equivalent of +unwrap_or_else+.
    def unwrap_or(default)
      raise NotImplementedError
    end

    # Return the contained value if +Ok+ or compute it via calling the provided block.
    # +unwrap_or_else+ is the lazy-evaluated equivalent of +unwrap_or+.
    def unwrap_or_else
      raise NotImplementedError
    end
  end
end

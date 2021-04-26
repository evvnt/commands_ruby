module Commands
  class Messages
    attr_reader :warnings, :errors, :snackbar

    def initialize(errors: {}, warnings: {}, snackbar: [])
      @errors = errors
      @warnings = warnings
      @snackbar = Array(snackbar)
    end

    def to_h
      {
          errors: errors,
          warnings: warnings,
          snackbar: snackbar
      }
    end
  end
end
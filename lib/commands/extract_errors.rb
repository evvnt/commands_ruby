require 'active_support/core_ext/string/inflections'

module Commands
  module ExtractErrors
    def extract_fk_errors(e, error: false)
      errmsg = e.message
      table, _foreign_key, foreign_table = e.message.match(/PG::ForeignKeyViolation: ERROR:.*\"(.*)\".*\"(.*)\"[\n].*\"(.*)\"/)&.captures
      if table && _foreign_key && foreign_table
        errmsg = "Unable to delete or update #{table.singularize.humanize.titleize}. "\
                                "It is referred to from one or more #{foreign_table.humanize.titleize}. "\
                                "You will need to update or remove any #{foreign_table.humanize.titleize} that refer to this "\
                                "#{table.singularize.humanize.titleize} first."
      end
      {error_key(error) => errmsg}
    end

    def extract_errors(e, error: false)
      return e.form_errors if e.respond_to?(:form_errors) && e.form_errors.present?
      {error_key(error) => e.message.gsub('ActiveRecord::','').titleize}
    end

    def error_key(error)
      # backward compatiblity - may be able to remove when ember admin goes away admin
      # Newer api (including public ) uses error and not exception as a key
      error_key = error ? :error : :exception
    end
  end
end

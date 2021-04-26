module Commands
  module ValidateParams
    def schema
      raise 'You must implement schema!'
    end

    def validate_params(**params_)
      validate_params_using(schema, **params_)
    end

    def validate_params_using(schema, **params_)
      result = schema.call(params_.deep_symbolize_keys)

      trace { result.inspect }

      if result.failure?
        messages = humanize(result.messages(full: true))

        raise Errors::ParameterValidation.new("Form validation failed: #{messages}", messages)
      end

      result.to_h
    end

    private

    def humanize(messages)
      messages.map do |k, v|
        result = v.is_a?(Array) ? v.map(&:humanize) : humanize(v)

        [k, result]
      end.to_h
    end
  end
end

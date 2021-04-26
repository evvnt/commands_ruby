module Commands
  module ControllerResponse
    def handle_response(response, fail_code_map: {}, &block)
      if response.success?
        redirect_url = redirect_url(response, &block)
        if redirect_url
          redirect_to redirect_url, status: :see_other
        else
          render json: response.to_h, status: 200
        end
      else
        status = fail_code_map[response.status] || response.status
        render json: response.messages.to_h, status: status
      end
    end

    # If you pass a block then return a hash for any parameters you want to add to the redirect
    # If you want to forward some parameters from the response, pass the parameter names in pluck
    def redirect_url(response = nil, pluck: [], &block)
      redirect_url = params.fetch(:redirect) {nil}
      return unless redirect_url

      data = response ? response.data : {}
      data = block.call(data) if block

      data = data.to_hash if data.respond_to?(:to_hash)
      data = data.attributes if data.respond_to?(:attributes)
      data = data.deep_symbolize_keys if data.respond_to?(:deep_symbolize_keys)
      trace {"Data: #{data.inspect}"}

      data = pluck_response(params.fetch(:pluck){[]}, data)

      data[:snackbar] = response.messages.snackbar if response&.messages&.snackbar

      query = data.to_query
      trace {"Query: #{query.inspect}"}

      redirect_url = "#{redirect_url}#{url_separator(redirect_url)}#{query}" unless query.empty?
      "#{redirect_url}#{url_separator(redirect_url)}accepts_html=true"
    end

    private

    def pluck_response(pluck, data)
      if pluck.respond_to?(:has_key?)
        pluck_hash(pluck, data)
      else
        pluck_array(pluck, data)
      end
    end

    def pluck_hash(pluck, data)
      pluck.to_unsafe_h.map do |key,new_key|
        [new_key.to_sym, data.fetch(key.to_sym) {params[key.to_sym]}]
      end.to_h
    end

    def pluck_array(pluck, data)
      pluck = Array(pluck).map(&:to_sym)
      pluck.map do |key|
        [key, data.fetch(key) {params[key]}]
      end.to_h
    end

    def url_separator(redirect_url)
      redirect_url.include?('?') ? '&' : '?'
    end
  end
end

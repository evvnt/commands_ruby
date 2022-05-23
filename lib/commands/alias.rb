# from https://theinternate.com/2014/02/14/inheritable-aliases-in-ruby.html

module Commands
  # When extended, Alias allows for defining method aliases that will be inherited by subclasses.
  module Alias
    def self.extended(base)
      require 'forwardable'
      base.extend Forwardable
    end

    # Define a method alias that will be inherited by subclasses.
    def inheritable_alias(new_method, original_method)
      def_delegator :self, original_method, new_method
    end
  end
end

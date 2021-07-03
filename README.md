# command_ruby

A command pattern implementation in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'commands_ruby'
```

## Usage

### Basic usage

Write your service object class, which must inherit from `Commands::Base` and must define
a `call` instance method.

```ruby
module Users
  class Create < Commands::Base
    def initialize(params:)
      @params = validate_params(params)
    end

    def call
      persist_user
      send_verification_email
    end

    private

    def schema
      # ...
    end
    
    def persist_user
      # ...
    end

    def send_verification_email
      # ...
    end
  end
end
```

To run your command, simply use:

```ruby
  Users::Create.call(params: params) # arguments are passed to your class '#initialize' method
  
  # Call should ONLY be called at the controller or top level. It eats exceptions!
  # When this is called you should check the response object for success/failure
```

or 

```ruby
  Users::Create.call!(params: params) # arguments are passed to your class '#initialize' method
  
  # This will raise an error in case of failure
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

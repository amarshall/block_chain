# BlockChain

[![Build Status](https://secure.travis-ci.org/amarshall/block_chain.png?branch=master)](http://travis-ci.org/amarshall/block_chain)

Makes it easy to chain nested blocks together without creating a ton of nesting.

## Installation

Install as usual: `gem install block_chain` or add `gem 'block_chain'` to your Gemfile.

## Usage

Turn this:

```ruby
foo do
  bar do
    baz do
      qux do
        yield
      end
    end
  end
end
```

into this:

```ruby
require 'block_chain'
BlockChain.new(method(:foo), method(:bar), method(:baz), method(:qux)).call { yield }
```

or:

```ruby
require 'block_chain'
methods = [:foo, :bar, :baz, :qux].map { |name| method name }
BlockChain.new(*methods).call { yield }
```

or even this:

```ruby
require 'block_chain'
BlockChain.new(:foo, :bar, :baz, :qux).call(self) { yield }
```

With the last form, the argument given to `call` is the receiver of the methods (since the receiver cannot be implicit, it must be explicitly specified). Also note that this form does not work in JRuby or Rubinius due to a bug. A gap in RubySpec was found as a result of this feature, see [RubySpec #174](https://github.com/rubyspec/rubyspec/pull/174).

This can make deeply-nested block wrappings a bit more digestable. For more details, read the specs, they’re short and descriptive.

## Contributing

Contributions are welcome. Please be sure that your pull requests are atomic so they can be considered and accepted separately.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits & License

Copyright © 2013 J. Andrew Marshall. License is available in the LICENSE file.

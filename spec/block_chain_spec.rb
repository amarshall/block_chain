require 'block_chain'

describe BlockChain do
  it "chains multiple methods together by wrapping each in a block" do
    def f; "f(#{yield})"; end
    def g; "g(#{yield})"; end
    def h; "h(#{yield})"; end

    block_chain = BlockChain.new method(:f), method(:g), method(:h)

    block_chain.call { 'x' }.should == 'f(g(h(x)))'
  end

  it "passes along arguments to the methods" do
    def f(arg); "f(#{arg}#{yield})"; end
    def g(arg); "g(#{arg}#{yield})"; end
    def h(arg); "h(#{arg}#{yield})"; end

    block_chain = BlockChain.new method(:f), method(:g), method(:h)

    block_chain.call(42) { 'x' }.should == 'f(42g(42h(42x)))'
  end

  it "accepts methods passed as a symbol, calling them on the object passed to call" do
    def f; "f(#{yield})"; end
    def g; "g(#{yield})"; end
    def h; "h(#{yield})"; end

    block_chain = BlockChain.new :f, :g, :h

    block_chain.call(self) { 'x' }.should == 'f(g(h(x)))'
  end

  it "cannot call private methods when passing a symbol" do
    klass = Class.new do
      def f; "f(#{yield})"; end
      def g; "g(#{yield})"; end
      def h; "h(#{yield})"; end
      private :f, :g, :h
    end
    block_chain = BlockChain.new :f, :g, :h

    -> do
      block_chain.call(klass.new) { 'x' }
    end.should raise_error(NoMethodError, /private method/)
  end

  it "can call private methods when passing a method" do
    klass = Class.new do
      def f; "f(#{yield})"; end
      def g; "g(#{yield})"; end
      def h; "h(#{yield})"; end
      private :f, :g, :h
    end
    instance = klass.new
    block_chain = BlockChain.new instance.method(:f), instance.method(:g), instance.method(:h)

    -> do
      block_chain.call { 'x' }
    end.should_not raise_error(NoMethodError, /private method/)
  end

  it "just yields when no methods are given" do
    BlockChain.new.call { 'x' }.should == 'x'
  end
end

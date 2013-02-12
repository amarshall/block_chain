require 'block_chain'

describe BlockChain do
  it "chains multiple methods together by wrapping each in a block" do
    def f; "f(#{yield})"; end
    def g; "g(#{yield})"; end
    def h; "h(#{yield})"; end

    block_chain = BlockChain.new method(:f), method(:g), method(:h)

    block_chain.call { 'x' }.should == 'f(g(h(x)))'
  end

  it "just yields when no methods are given" do
    BlockChain.new.call { 'x' }.should == 'x'
  end
end

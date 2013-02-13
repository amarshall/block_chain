require 'block_chain/version'

class BlockChain
  def initialize *methods
    @procs = methods.map(&:to_proc)
  end

  def call *args
    if @procs.none?
      yield
    elsif @procs.one?
      @procs.first.call(*args) { yield }
    else
      current = @procs.first
      nexts = self.class.new(*@procs.slice(1..-1))
      current.call(*args) do
        nexts.call(*args) { yield }
      end
    end
  end
end

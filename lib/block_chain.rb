require 'block_chain/version'

class BlockChain
  def initialize *methods
    @procs = methods.map(&:to_proc)
  end

  def call
    if @procs.none?
      yield
    elsif @procs.one?
      @procs.first.call { yield }
    else
      current = @procs.first
      nexts = self.class.new(*@procs.slice(1..-1))
      current.call do
        nexts.call { yield }
      end
    end
  end
end

class Parallel

  require 'concurrent'

  def initialize
    @results = []
    @tasks_count = 0
    @p = Concurrent::Promise.new{true}
    super
  end

  def run(array_of_blocks = [])
    @tasks_count = array_of_blocks.count
    array_of_blocks.each{|block|
      @p.then{block.call}.then{|result| @results.push result }
    }
    @p.execute
    @p
  end

  def results
    while (@tasks_count > @results.count) do end
    @results
  end

end

parallel = Parallel.new
parallel.run([ lambda{2+2}, lambda{3+3} ])
#p run.value
#sleep 1
p parallel.results


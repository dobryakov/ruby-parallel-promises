class Parallel

  require 'concurrent'

  def initialize
    @results = []
    super
  end

  def run(array_of_blocks = [])
    p = Concurrent::Promise.new{true}
    array_of_blocks.each{|block|
      p.then{block.call}.then{|result| @results.push result }
    }
    p.execute
    p
  end

  def results
    @results
  end

end

parallel = Parallel.new
run = parallel.run([ lambda{2+2}, lambda{3+3} ]) #.then{p parallel.results}
#p run.value
#sleep 1
#p parallel.results


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

  def async_results
    @results
  end

  def results
    while (@tasks_count > @results.count) do end
    @results
  end

end

# example:

# instance initialization
parallel = Parallel.new

# start time
p Time.now

# put some tasks
parallel.run([ lambda{2+2}, lambda{3+3}, lambda{sleep 5}, lambda{sleep 5}, lambda{sleep 5}, lambda{sleep 5}, lambda{sleep 5} ])

# sync waiting for the results
p parallel.results

# end time (must be smaller than sum of the sleeps above)
p Time.now

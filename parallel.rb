class Parallel

  require 'concurrent'

  def initialize
    @results = {}
    @tasks_count = 0
    @executed_count = 0
    @p = Concurrent::Promise.new{true}
    super
  end

  def run(hash_of_blocks = {})
    @tasks_count = hash_of_blocks.keys.count
    hash_of_blocks.each{|task_name, block|
      @p.then{block.call}.then{|result|
        @results[task_name]=result
        @executed_count=@executed_count+1
      }
    }
    @p.execute
    @p
  end

  def async_results
    @results
  end

  def results
    while (@tasks_count > @executed_count) do end
    @results
  end

end

# example:

# instance initialization
parallel = Parallel.new

# start time
p Time.now

# put some tasks
task1     = lambda{2+2}
task2     = lambda{2+2}
sleeptask = lambda{sleep 5}
another   = lambda{sleep 2; 1+1; sleep 2}

parallel.run( { :task1 => task1,
                :task2 => task2,
                :task3 => sleeptask,
                :task4 => sleeptask,
                :task5 => sleeptask,
                :task6 => another } )

# sync waiting for the results
p parallel.results

# end time (must be smaller than sum of the sleeps above)
p Time.now

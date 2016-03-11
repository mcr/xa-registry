module Randomness
  def rand_one(a)
    a[rand(a.length)].dup
  end
    
  def rand_times(i = 10)
    (1 + rand(i)).times
  end
  
  def rand_partition(a, n)
    i = rand(a.length / 3) + 1
    n == 1 ? [a] : [a.take(i).map(&:dup)] + rand_partition(a.drop(i), n - 1)
  end

  def rand_array(n)
    rand_times(n).map { yield }
  end

  def rand_array_of_words(n)
    rand_array(n) do
      Faker::Hipster.word
    end
  end
end

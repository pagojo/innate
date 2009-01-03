require 'spec/helper'

Innate.options.cache do |cache|
  cache.names = [:one, :two]
  cache.one = $common_cache_class
  cache.two = $common_cache_class
end

Innate.setup_dependencies

describe $common_cache_class do
  cache = Innate::Cache.one

  hello = 'Hello, World!'

  should 'store without ttl' do
    cache.store(:hello, hello).should == hello
  end

  should 'fetch' do
    cache.fetch(:hello).should == hello
  end

  should 'delete' do
    cache.delete(:hello).should == hello
    cache.fetch(:hello).should == nil
  end

  should 'store with ttl' do
    cache.store(:hello, hello, :ttl => 0.2)
    cache.fetch(:hello).should == hello
    sleep 0.3
    cache.fetch(:hello).should == nil
  end

  should 'clear' do
    cache.store(:hello, hello)
    cache.fetch(:hello).should == hello
    cache.clear
    cache.fetch(:hello).should == nil
  end
end
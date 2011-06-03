require 'minitest/autorun' # from minitest
require 'purdytest'

Purdytest.configure do |io|
  io.pass = :blue
  io.fail = :green
end

describe 'my amazing test' do
  # generate many green dots!
  50.times do |i|
    it "must #{i}" do
      100.must_equal 100
    end
  end

  # generate some red Fs!
  2.times do |i|
    it "compares #{i} to #{i + 1}" do
      i.must_equal i + 1
    end
  end

  it 'does stuff and shows a diff' do
    [1,2,3,4,5].must_equal %w{ a quick brown fox jumped over something! }
  end

  it 'does stuff and shows yellow' do
    skip "don't care!"
  end
end

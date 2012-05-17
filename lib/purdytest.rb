require 'minitest/unit'

module Purdytest
  class IO
    attr_reader :io
    attr_accessor :pass, :fail, :skip, :error

      # Colors stolen from /System/Library/Perl/5.10.0/Term/ANSIColor.pm
      COLORS = {
      :black      => 30,   :on_black   => 40,
      :red        => 31,   :on_red     => 41,
      :green      => 32,   :on_green   => 42,
      :yellow     => 33,   :on_yellow  => 43,
      :blue       => 34,   :on_blue    => 44,
      :magenta    => 35,   :on_magenta => 45,
      :cyan       => 36,   :on_cyan    => 46,
      :white      => 37,   :on_white   => 47
    }

    def initialize io
      @io    = io
      @pass  = :green
      @fail  = :red
      @error = :red
      @skip  = :yellow
    end

    def print o
      case o
      when '.' then io.print "\e[#{COLORS[pass]}m.\e[0m"
      when 'E' then io.print "\e[#{COLORS[error]}mE\e[0m"
      when 'F' then io.print "\e[#{COLORS[self.fail]}mF\e[0m"
      when 'S' then io.print "\e[#{COLORS[skip]}mS\e[0m"
      else
        io.print o
      end
    end

    def method_missing msg, *args
      return super unless io.respond_to?(msg)
      io.send(msg, *args)
    end
  end

  ###
  # Yields the current minitest output, which *should* be an instance
  # of Purdytest::IO (hopefully).
  def self.configure
    yield MiniTest::Unit.output
  end
end

MiniTest::Unit.output = Purdytest::IO.new(MiniTest::Unit.output)

if system("colordiff", __FILE__, __FILE__)
  MiniTest::Assertions.diff = 'colordiff -u'
end

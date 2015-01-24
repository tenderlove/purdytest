module Purdytest
  VERSION = '2.0.0'

  CONFIG = Struct.new(:pass, :fail, :error, :skip)
    .new(:green, :red, :red, :yellow)

  class IO < Struct.new :io
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

    CONFIG.members.each { |m| define_method(m) { CONFIG[m] } }

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
  # Yields the current color configuration
  def self.configure
    yield CONFIG
  end
end

module MiniTest
  def self.plugin_purdytest_init(options)
    composite = Minitest.reporter
    r = composite.reporters.find { |x| Minitest::ProgressReporter === x }
    r.io = Purdytest::IO.new r.io
  end
  extensions << "purdytest"
end

if system("colordiff", __FILE__, __FILE__)
  MiniTest::Assertions.diff = 'colordiff -u'
end

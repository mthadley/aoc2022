class Point
  attr_reader :x, :y

  def self.[](x, y) = new(x, y)
  def self.origin = self[0, 0]

  CARDINALS = [[0, 1], [1, 0], [0, -1], [-1, 0]].freeze
  private_constant :CARDINALS

  ORDINALS = [[1, 1], [-1, 1], [1, -1], [-1, -1]].freeze
  private_constant :ORDINALS

  def self.cardinals = CARDINALS.map { new(*_1) }
  def self.ordinals = ORDINALS.map { new(*_1) }
  def self.principals = cardinals + ordinals

  def initialize(x, y)
    @x, @y = x, y
    freeze
  end

  %w[+ - * /].each do |op|
    # `eval` used over `define_method` for speed
    eval <<~RUBY
      def #{op}(other)
        other = other.to_point
        self.class[x #{op} other.x, y #{op} other.y]
      end
    RUBY
  end

  def cardinals = self.class.cardinals.map { _1 + self }
  def ordinals = self.class.ordinals.map { _1 + self }
  def principals = cardinals + ordinals


  def ==(other)
    return false unless other.is_a?(self.class)

    x == other.x && y == other.y
  end
  alias_method :eql?, :==

  def hash = [x, y].hash

  def inspect = "(#{x.inspect}, #{y.inspect})"

  def to_point = self
end

class Numeric
  def to_point = Point[self, self]
end

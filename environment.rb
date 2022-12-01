require "rubygems"
require "bundler/setup"

require_relative "lib/advent_of_code"

def part1(...) = AdventOfCode.instance.add_part(1, ...)
def part2(...) = AdventOfCode.instance.add_part(2, ...)
def input = AdventOfCode.instance.input

at_exit { AdventOfCode.instance.play }

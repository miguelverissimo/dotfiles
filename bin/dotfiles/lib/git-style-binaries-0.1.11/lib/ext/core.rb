# frozen_string_literal: true

class Object
  unless Object.respond_to?(:returning)
    def returning(value)
      yield(value)
      value
    end
  end
end

class Symbol
  def to_proc
    proc { |*args| args.shift.__send__(self, *args) }
  end
end

class IO
  attr_accessor :use_color
end

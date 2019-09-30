# frozen_string_literal: true

class Test::Unit::TestCase
  def output_should_match(regexp)
    assert_match regexp, @stdout + @stderr
  end
  alias output_matches output_should_match

  def stdout_should_match(regexp)
    assert_match regexp, @stdout
  end

  def stderr_should_match(regexp)
    assert_match regexp, @stderr
  end
end

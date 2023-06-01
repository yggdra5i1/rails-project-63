# frozen_string_literal: true

require "test_helper"

User = Struct.new(:name, :job, keyword_init: true)

class TestHexletCode < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_form_for
    user = User.new name: 'rob'
    res = HexletCode.form_for user do |f|
    end
    expected_res = '<form action="#" method="post"></form>'
    assert_equal res, expected_res
  end
end

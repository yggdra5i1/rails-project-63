# frozen_string_literal: true

require "test_helper"

User = Struct.new(:name, :job, :gender, keyword_init: true)

class TestHexletCode < Minitest::Test
  def test_form_for
    user = User.new name: "rob"
    res = HexletCode.form_for user do |f|
    end
    expected_res = '<form action="#" method="post"></form>'
    assert_equal res, expected_res
  end

  def test_form_for_with_options
    user = User.new name: "rob"
    res = HexletCode.form_for user, url: "/users" do |f|
    end
    expected_res = '<form action="/users" method="post"></form>'
    assert_equal res, expected_res
  end

  def test_form_for_with_inputs
    user = User.new name: "rob", job: "hexlet", gender: "m"

    HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
    end
  end
end

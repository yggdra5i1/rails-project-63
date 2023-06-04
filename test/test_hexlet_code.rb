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

    res = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
    end

    expected_res = '<form action="#" method="post"><input name="name" type="text" value="rob">'\
                   '<textarea name="job" cols="20" rows="40">hexlet</textarea></form>'
    assert_equal res, expected_res
  end

  def test_form_for_with_options_of_inputs
    user = User.new name: "rob", job: "", gender: "m"

    res = HexletCode.form_for user, url: "#" do |f|
      f.input :name, class: "user-input"
      f.input :job
    end

    expected_res = '<form action="#" method="post">'\
                   '<input name="name" type="text" value="rob" class="user-input">'\
                   '<input name="job" type="text" value=""></form>'

    assert_equal res, expected_res
  end

  def test_form_for_text_area
    user = User.new name: "rob", job: "hexlet", gender: "m"
    res = HexletCode.form_for user do |f|
      f.input :job, as: :text
    end
    expected_res = '<form action="#" method="post"><textarea name="job" cols="20" rows="40">'\
                   "hexlet</textarea></form>"

    assert_equal res, expected_res
  end

  def test_form_for_text_area_with_options
    user = User.new name: "rob", job: "hexlet", gender: "m"
    res = HexletCode.form_for user, url: "#" do |f|
      f.input :job, as: :text, rows: 50, cols: 50
    end
    expected_res = '<form action="#" method="post">'\
                   '<textarea name="job" rows="50" cols="50">hexlet</textarea></form>'

    assert_equal res, expected_res
  end

  def test_form_for_raise_errors
    user = User.new name: "rob", job: "hexlet", gender: "m"

    assert_raises(NoMethodError) do
      HexletCode.form_for user, url: "/users" do |f|
        f.input :name
        f.input :job, as: :text
        f.input :age
      end
    end
  end
end

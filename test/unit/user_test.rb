require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user name must be composed of numerics and alphabets" do
    user01 = User.new(name: "*?", password: "hogehoge",
                    password_confirmation: "hogehoge")
    assert user01.invalid?
    assert user01.errors[:name].any?

    user02 = User.new(name: "aa*/34", password: "hogehoge",
                      password_confirmation: "hogehoge")
    assert user02.invalid?
    assert user02.errors[:name].any?

    user03 = User.new(name: "123abAB", password: "hogehoge",
                    password_confirmation: "hogehoge")
    assert user03.valid?
  end

  test "password must be at least 8 characters" do
    user01 = User.new(name: "hoge", password: "hoge",
                    password_confirmation: "hoge")
    assert user01.invalid?
    assert user01.errors[:password].any?

    user02 = User.new(name: "hogehoge", password: "hogehoge",
                    password_confirmation: "hogehoge")
    assert user02.valid?
  end
end

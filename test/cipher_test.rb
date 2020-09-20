require './test/test_helper'
require './lib/cipher'

class CipherTest < Minitest::Test
  def setup
    @cipher = Cipher.new
  end
  #
  def test_it_has_attributes
    @cipher = Cipher.new

    assert_nil @cipher.a_shift
    assert_nil @cipher.b_shift
    assert_nil @cipher.c_shift
    assert_nil @cipher.d_shift
  end
  #
  # def test_it_can_generate_character_set
  #   expected = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
  #     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ']
  #
  #   assert_equal expected, @cipher.characters
  # end
  #
  # def test_it_can_generate_shifted_character_set
  #   expected = ['d', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
  #     'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ', 'a', 'b', 'c']
  #
  #   assert_equal expected, @cipher.shifted_characters
  # end
  #
  # def test_it_can_encrypt_a_letter
  #   assert_equal 'd', @cipher.encrypt('a')
  #   assert_equal 'b', @cipher.encrypt('z')
  #
  #   cipher2 = Cipher.new(36)
  #
  #   assert_equal 'j', cipher2.encrypt('a')
  #   assert_equal 'h', cipher2.encrypt('z')
  # end
  #
  # def test_it_can_set_a_new_shift_value
  #   assert_equal 3, @cipher.shift
  #
  #   @cipher.set_shift(100)
  #
  #   assert_equal 100, @cipher.shift
  # end
end

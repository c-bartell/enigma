require './test/test_helper'
require './lib/cipher'

class CipherTest < Minitest::Test
  def setup
    @cipher = Cipher.new(3)
  end

  def test_it_has_attributes
    assert_equal 3, @cipher.shift
  end

  def test_it_can_generate_character_set
    expected = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
      'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ']
    assert_equal expected, @cipher.characters
  end

  def test_it_can_generate_shifted_character_set
    expected = ['d', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
      'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ', 'a', 'b', 'c']
    assert_equal expected, @cipher.shifted_characters
  end

  def test_it_can_encrypt_a_letter
    assert_equal 'd', @cipher.encrypt('a')
    assert_equal 'b', @cipher.encrypt('z')
    cipher2 = Cipher.new(36)
    assert_equal 'j', cipher2.encrypt('a')
    assert_equal 'h', cipher2.encrypt('z')
  end
end

require './test/test_helper'
require './lib/cipher'

class CipherTest < Minitest::Test
  def test_it_has_attributes
    cipher = Cipher.new(3)
    assert_equal 3, cipher.shift
  end

  def test_it_can_generate_character_set
    expected = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
       'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ']
    assert_equal expected, cipher.characters
  end
end

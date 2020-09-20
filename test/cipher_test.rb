require './test/test_helper'
require './lib/cipher'

class CipherTest < Minitest::Test
  def test_it_has_attributes
    cipher = Cipher.new(3)
    chars = ('a..z').to_a << ' '

    assert_equal 3, cipher.shift
    assert_equal chars, cipher.characters
  end
end

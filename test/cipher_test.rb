require './test/test_helper'
require './lib/cipher'

class CipherTest < Minitest::Test
  def test_it_has_attributes
    cipher = Cipher.new(3)

    assert_equal 3, cipher.shift
  end
end

require './test/test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def test_it_has_attributes
    encryptor = mock('Encryptor object')
    Encryptor.stubs(:new).returns(encryptor)
    enigma = Enigma.new

    assert_equal
  end
end

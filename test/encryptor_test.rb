require './test/test_helper'
require './lib/encryptor'

class EncryptorTest < Minitest::Test
  def test_it_can_generate_cipher
    assert_instance_of Cipher, Encryptor.generate_cipher
  end

  # def test_it_has_attributes
  #   enigma = mock('Enigma object')
  #   shift_generator = mock('shift_generator')
  #   encryptor = Encryptor.new(enigma, shift_generator)
  #
  #   assert_equal
  # end
end

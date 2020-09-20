require './test/test_helper'
require './lib/encryptor'

class EncryptorTest < Minitest::Test
  def test_it_has_attributes
    enigma = mock('Enigma object')
    cipher = mock('Cipher object')
    Cipher.stubs(:new).returns(cipher)
    encryptor = Encryptor.new(enigma)

    assert_equal enigma, encryptor.enigma
    assert_equal cipher, encryptor.cipher
  end

  def test_it_can_generate_a_cipher
    enigma = mock('Enigma object')
    encryptor = Encryptor.new(enigma)

    assert_instance_of Cipher, encryptor.cipher
  end

  def test_it_can_format_message_string
    enigma = mock('Enigma object')
    cipher = mock('Cipher object')
    Cipher.stubs(:new).returns(cipher)
    encryptor = Encryptor.new(enigma)
    message = "HeLLo WOrlD\n"
    expected = ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']

    assert_equal expected, encryptor.format(message)
  end

  def test_it_can_request_shifts
    enigma = mock('Enigma object')
    cipher = mock('Cipher object')
    Cipher.stubs(:new).returns(cipher)
    encryptor = Encryptor.new(enigma)
    shifts = { A: 3, B: 27, C: 73, D: 20 }
    enigma.stubs(:request_shifts).returns(shifts)

    assert_equal shifts, encryptor.request_shifts(['Key date data'])
  end
end

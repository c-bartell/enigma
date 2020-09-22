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

  def test_it_can_package_results
    enigma = mock('Enigma object')
    cipher = mock('Cipher object')
    Cipher.stubs(:new).returns(cipher)
    encryptor = Encryptor.new(enigma)
    encrypted = ['k', 'e', 'd', 'e', 'r', ' ', 'o', 'h', 'u', 'l', 'w']
    key_date = ['02715', '040895']
    expected = { encryption: 'keder ohulw', key: '02715', date: '040895' }

    assert_equal expected, encryptor.package(encrypted, key_date)
  end

  def test_it_can_encrypt_a_message
    enigma = mock('Enigma object')
    cipher = mock('Cipher object')
    Cipher.stubs(:new).returns(cipher)
    encryptor = Encryptor.new(enigma)
    message = ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']
    encrypted = ['k', 'e', 'd', 'e', 'r', ' ', 'o', 'h', 'u', 'l', 'w']
    cipher.stubs(:encrypt).returns(encrypted)
    encryptor.stubs(:format).returns(message)
    expected = { encryption: 'keder ohulw', key: '02715', date: '040895' }

    assert_equal expected, encryptor.encrypt("HeLLo WOrlD\n", ['02715',
                                                               '040895'])
  end
end

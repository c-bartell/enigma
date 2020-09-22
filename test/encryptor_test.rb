require './test/test_helper'
require './lib/encryptor'

class EncryptorTest < Minitest::Test
  def setup
    @enigma = mock('Enigma object')
    @cipher = mock('Cipher object')
    Cipher.stubs(:new).returns(@cipher)
    @encryptor = Encryptor.new(@enigma)
  end

  def test_it_has_attributes
    assert_equal @enigma, @encryptor.enigma
    assert_equal @cipher, @encryptor.cipher
  end

  def test_it_can_format_message_string
    message = "HeLLo WOrlD\n"
    expected = ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']

    assert_equal expected, @encryptor.format(message)
  end

  def test_it_can_request_shifts
    shifts = { A: 3, B: 27, C: 73, D: 20 }
    @enigma.stubs(:request_shifts).returns(shifts)

    assert_equal shifts, @encryptor.request_shifts(['Key date data'])
  end

  def test_it_can_package_results
    encrypted = ['k', 'e', 'd', 'e', 'r', ' ', 'o', 'h', 'u', 'l', 'w']
    key_date = ['02715', '040895']
    expected = { encryption: 'keder ohulw', key: '02715', date: '040895' }

    assert_equal expected, @encryptor.package(encrypted, key_date)
  end

  def test_it_can_encrypt_a_message
    message = ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']
    encrypted = ['k', 'e', 'd', 'e', 'r', ' ', 'o', 'h', 'u', 'l', 'w']
    @cipher.stubs(:encrypt).returns(encrypted)
    @encryptor.stubs(:format).returns(message)

    assert_equal encrypted, @encryptor.encrypt_message("HeLLo WOrlD\n",
                                                       ['02715', '040895'])
  end

  def test_it_can_encrypt_a_message_and_format_output
    encrypted = ['k', 'e', 'd', 'e', 'r', ' ', 'o', 'h', 'u', 'l', 'w']
    @encryptor.stubs(:encrypt_message).returns(encrypted)
    expected = { encryption: 'keder ohulw', key: '02715', date: '040895' }

    assert_equal expected, @encryptor.encrypt("HeLLo WOrlD\n", ['02715',
                                                                '040895'])
  end
end

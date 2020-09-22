require './test/test_helper'
require './lib/crypt_manager'

class CryptManagerTest < Minitest::Test
  def setup
    @enigma = mock('Enigma object')
    @cipher = mock('Cipher object')
    Cipher.stubs(:new).returns(@cipher)
    @crypt_manager = CryptManager.new(@enigma)
  end

  def test_it_has_attributes
    assert_equal @enigma, @crypt_manager.enigma
    assert_equal @cipher, @crypt_manager.cipher
  end

  def test_it_can_format_message_string
    message = "HeLLo WOrlD\n"
    expected = ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']

    assert_equal expected, @crypt_manager.format(message)
  end

  def test_it_can_request_shifts
    shifts = { A: 3, B: 27, C: 73, D: 20 }
    @enigma.stubs(:request_shifts).returns(shifts)

    assert_equal shifts, @crypt_manager.request_shifts(['Key date data'])
  end

  def test_it_can_package_encoded_results
    encrypted = ['k', 'e', 'd', 'e', 'r', ' ', 'o', 'h', 'u', 'l', 'w']
    key_date = ['02715', '040895']
    expected = { encryption: 'keder ohulw', key: '02715', date: '040895' }

    assert_equal expected, @crypt_manager.encoded_package(encrypted, key_date)
  end

  def test_it_can_encrypt_a_message
    message = ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']
    encrypted = ['k', 'e', 'd', 'e', 'r', ' ', 'o', 'h', 'u', 'l', 'w']
    @cipher.stubs(:encrypt).returns(encrypted)
    @crypt_manager.stubs(:format).returns(message)

    assert_equal encrypted, @crypt_manager.encrypt_message("HeLLo WOrlD\n",
                                                           ['02715', '040895'])
  end

  def test_it_can_decrypt_a_message
    ciphertext = ['k', 'e', 'd', 'e', 'r', ' ', 'o', 'h', 'u', 'l', 'w']
    decrypted = ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']
    @cipher.stubs(:decrypt).returns(decrypted)
    @crypt_manager.stubs(:format).returns(ciphertext)

    assert_equal decrypted, @crypt_manager.decrypt_message('keder ohulw',
                                                           ['02715', '040895'])
  end

  def test_it_can_encrypt_a_message_and_format_output
    encrypted = ['k', 'e', 'd', 'e', 'r', ' ', 'o', 'h', 'u', 'l', 'w']
    @crypt_manager.stubs(:encrypt_message).returns(encrypted)
    expected = { encryption: 'keder ohulw', key: '02715', date: '040895' }

    assert_equal expected, @crypt_manager.encrypt("HeLLo WOrlD\n", ['02715',
                                                                    '040895'])
  end

  def test_it_can_decrypt_a_message_and_format_output
    decrypted = ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']
    @crypt_manager.stubs(:decrypt_message).returns(decrypted)
    expected = { decryption: 'hello world', key: '02715', date: '040895' }

    assert_equal expected, @crypt_manager.decrypt('keder ohulw', ['02715',
                                                                  '040895'])
  end
end

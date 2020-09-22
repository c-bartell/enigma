require './test/test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def enigmock
    @crypt_manager = mock('CryptManager object')
    CryptManager.stubs(:new).returns(@crypt_manager)
    @shift_generator = mock('ShiftGenerator object')
    ShiftGenerator.stubs(:new).returns(@shift_generator)
    @io_manager.mock('IOManager object')
    IOManager.stubs(:new).returns(@io_manager)
    @enigma = Enigma.new
  end

  def test_it_exists
    enigmock
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    enigmock

    assert_equal @crypt_manager, @enigma.crypt_manager
    assert_equal @shift_generator, @enigma.shift_generator
    assert_equal @io_manager, @enigma.io_manager
  end

  def test_it_can_validate_key_date_data
    enigmock
    @shift_generator.stubs(:key_date).returns(['02715', '040895'])

    assert_equal ['02715', '040895'], @enigma.key_date([])
  end

  def test_it_can_request_shifts
    enigmock
    shifts = { A: 3, B: 27, C: 73, D: 20 }
    @shift_generator.stubs(:convert_to_shifts).returns(shifts)

    assert_equal shifts, @enigma.request_shifts(['02715', '040895'])
  end

  def test_it_can_encrypt_a_message
    enigma = Enigma.new
    key = '02715'
    date = '040895'
    message = 'Hello World'
    expected = { encryption: 'keder ohulw', key: '02715', date: '040895' }

    assert_equal expected, enigma.encrypt(message, key, date)
  end

  def test_it_can_decrypt_a_message
    enigma = Enigma.new
    key = '02715'
    date = '040895'
    ciphertext = 'keder ohulw'
    expected = { decryption: 'hello world', key: '02715', date: '040895' }

    assert_equal expected, enigma.decrypt(ciphertext, key, date)
  end
end

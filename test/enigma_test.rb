require './test/test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def enigmock
    @crypt_manager = mock('CryptManager object')
    CryptManager.stubs(:new).returns(@crypt_manager)
    @shift_generator = mock('ShiftGenerator object')
    ShiftGenerator.stubs(:new).returns(@shift_generator)
    @io_manager = mock('IOManager object')
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

  def test_it_can_read_file
    enigmock
    @io_manager.stubs(:get_text).returns('Success')

    assert_equal 'Success', @enigma.read_file
  end

  def test_it_can_get_input_text
    enigmock
    @io_manager.stubs(:input_text).returns('hello world')

    assert_equal 'hello world', @enigma.input_text
  end

  def test_it_can_get_key_input
    enigmock
    @io_manager.stubs(:key_input).returns('02715')

    assert_equal '02715', @enigma.key_input
  end

  def test_it_can_get_date_input
    enigmock
    @io_manager.stubs(:date_input).returns('040895')

    assert_equal '040895', @enigma.date_input
  end

  def test_it_can_finish_results
    enigmock
    @io_manager.stubs(:finish).returns('Success')
    results = { decryption: 'hello world', key: '02715', date: '040895' }

    assert_equal 'Success', @enigma.finish(results, :decryption)
  end

  def write_to_fixture(path, content)
    File.open(path, 'w') do |file|
      file.write(content)
    end
  end

  def test_it_can_encrypt_a_file
    path_in = './test/message_fixture.txt'
    path_out = './test/encrypted_fixture.txt'
    ARGV.replace([path_in, path_out])
    enigma = Enigma.new
    io_manager = enigma.io_manager
    enigma.stubs(:key_date).returns(['02715', '040895'])
    write_to_fixture(path_in, 'hello world')
    $stdout.stubs(:puts).returns('It called puts.')
    enigma.encrypt_file
    io_manager.stubs(:input_path).returns(path_out)
    expected = 'keder ohulw'
    actual = io_manager.get_text
    write_to_fixture(path_in, '')
    write_to_fixture(path_out, '')

    assert_equal expected, actual
  end

  def test_it_can_decrypt_a_file
    path_out = './test/message_fixture.txt'
    path_in = './test/encrypted_fixture.txt'
    ARGV.replace([path_in, path_out, '02715', '040895'])
    enigma = Enigma.new
    io_manager = enigma.io_manager
    write_to_fixture(path_in, 'keder ohulw')
    $stdout.stubs(:puts).returns('It called puts.')
    enigma.decrypt_file
    io_manager.stubs(:input_path).returns(path_out)
    expected = 'hello world'
    actual = io_manager.get_text
    write_to_fixture(path_in, '')
    write_to_fixture(path_out, '')

    assert_equal expected, actual
  end
end

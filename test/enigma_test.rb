require './test/test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def test_it_has_attributes
    encryptor = mock('Encryptor object')
    Encryptor.stubs(:new).returns(encryptor)
    shift_generator = mock('ShiftGenerator object')
    ShiftGenerator.stubs(:new).returns(shift_generator)
    enigma = Enigma.new

    assert_equal encryptor, enigma.encryptor
    assert_equal shift_generator, enigma.shift_generator
  end

  def test_it_can_validate_key_date_data
    encryptor = mock('Encryptor object')
    Encryptor.stubs(:new).returns(encryptor)
    shift_generator = mock('ShiftGenerator object')
    ShiftGenerator.stubs(:new).returns(shift_generator)
    enigma = Enigma.new
    shift_generator.stubs(:key_date).returns(['02715', '040895'])

    assert_equal ['02715', '040895'], enigma.key_date([])
  end
end

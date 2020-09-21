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

  def test_it_can_request_shifts
    encryptor = mock('Encryptor object')
    Encryptor.stubs(:new).returns(encryptor)
    shift_generator = mock('ShiftGenerator object')
    ShiftGenerator.stubs(:new).returns(shift_generator)
    enigma = Enigma.new
    shifts = { A: 3, B: 27, C: 73, D: 20 }
    shift_generator.stubs(:convert_to_shifts).returns(shifts)

      assert_equal shifts, enigma.request_shifts(['02715', '040895'])
  end
end

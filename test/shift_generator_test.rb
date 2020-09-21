require './test/test_helper'
require './lib/shift_generator'

class ShiftGeneratorTest < Minitest::Test
  def test_it_has_attributes
    enigma = mock('Enigma object')
    shift_generator = ShiftGenerator.new(enigma)

    assert_equal enigma, shift_generator.enigma
  end

  def test_it_can_calculate_combined_str_length_of_elements
    enigma = mock('Enigma object')
    shift_generator = ShiftGenerator.new(enigma)

    assert_equal 11, shift_generator.combi_length(['02715', '040895'])
    assert_equal 6, shift_generator.combi_length(['02715', '040895'])
    assert_equal 5, shift_generator.combi_length(['02715', '040895'])
    assert_equal 0, shift_generator.combi_length(['02715', '040895'])
  end

  # def test_it_can_evaluate_incoming_key_date_data
  #   skip
  #   enigma = mock('Enigma object')
  #   shift_generator = ShiftGenerator.new(enigma)
  #
  #
  # end

  def test_it_can_validate_key_date_data
    skip
    enigma = mock('Enigma object')
    shift_generator = ShiftGenerator.new(enigma)
    shift_generator.stubs(:rand).returns(2715)
    today = Date.new(1995,8,4)
    Date.stubs(:today).returns(today)
    expected = ['02715', '040895']

    assert_equal expected, shift_generator.key_date(['02715',
      '040895'])
    assert_equal expected, shift_generator.key_date(['040895'])
    assert_equal expected, shift_generator.key_date(['02715'])
    assert_equal expected, shift_generator.key_date([])
  end
end

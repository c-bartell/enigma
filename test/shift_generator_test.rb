require './test/test_helper'
require './lib/shift_generator'

class ShiftGeneratorTest < Minitest::Test
  def test_it_has_attributes
    enigma = mock('Enigma object')
    shift_generator = ShiftGenerator.new(enigma)

    assert_equal enigma, shift_generator.enigma
  end
end

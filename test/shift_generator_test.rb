require './test/test_helper'
require './lib/shift_generator'

class ShiftGeneratorTest < Minitest::Test
  def setup
    @enigma = mock('Enigma object')
    @shift_generator = ShiftGenerator.new(@enigma)
  end

  def test_it_has_attributes
    assert_equal @enigma, @shift_generator.enigma
  end

  def test_it_can_calculate_combined_str_length_of_elements
    assert_equal 11, @shift_generator.combi_length(['02715', '040895'])
    assert_equal 6, @shift_generator.combi_length(['040895'])
    assert_equal 5, @shift_generator.combi_length(['02715'])
    assert_equal 0, @shift_generator.combi_length([])
  end

  def test_it_can_pad_strings
    assert_equal '02715', @shift_generator.pad('2715', 5)
    assert_equal '00001', @shift_generator.pad('1', 5)
    assert_equal '01', @shift_generator.pad('1', 2)
    assert_equal '12715', @shift_generator.pad('12715', 5)
  end

  def test_it_can_generate_key
    @shift_generator.stubs(:rand).returns(27150)

    assert_equal '27150', @shift_generator.generate_key

    @shift_generator.stubs(:rand).returns(2715)

    assert_equal '02715', @shift_generator.generate_key
  end

  def test_it_can_generate_dates
    today = Date.new(1995, 8, 4)
    Date.stubs(:today).returns(today)

    assert_equal '040895', @shift_generator.generate_date

    today = Date.new(1995, 12, 14)
    Date.stubs(:today).returns(today)

    assert_equal '141295', @shift_generator.generate_date
  end

  def test_quality_check_1
    @shift_generator.stubs(:quality_check2).returns('next method')

    assert_equal ['02715', '040895'],
                 @shift_generator.quality_check1(['02715', '040895'])
    assert_equal 'next method', @shift_generator.quality_check1(['040895'])
    assert_equal 'next method', @shift_generator.quality_check1([])
  end

  def test_quality_check_2
    @shift_generator.stubs(:generate_key).returns('02715')
    @shift_generator.stubs(:quality_check3).returns('next method')

    assert_equal ['02715', '040895'], @shift_generator.quality_check2(['040895'])
    assert_equal 'next method', @shift_generator.quality_check2(['02715'])
    assert_equal 'next method', @shift_generator.quality_check2([])
  end

  def test_quality_check_3
    @shift_generator.stubs(:generate_key).returns('02715')
    @shift_generator.stubs(:generate_date).returns('040895')

    assert_equal ['02715', '040895'], @shift_generator.quality_check3(['02715'])
    assert_equal ['02715', '040895'], @shift_generator.quality_check3([])
  end

  def test_it_can_validate_key_date_data
    @shift_generator.stubs(:quality_check1).returns(['02715', '040895'])

    assert_equal ['02715', '040895'], @shift_generator.key_date([])
  end

  def test_it_can_frameshift_key
    assert_equal ['02', '27', '71', '15'], @shift_generator.frameshift('02715')
    assert_equal ['12', '23', '34', '45'], @shift_generator.frameshift('12345')
  end

  def test_it_can_convert_key_to_shifts
    @shift_generator.stubs(:frameshift).returns(['02', '27', '71', '15'])
    expected = { A: 2, B: 27, C: 71, D: 15 }

    assert_equal expected, @shift_generator.key_to_shifts('02715')
  end

  def test_it_can_process_date

    assert_equal '1025', @shift_generator.process('040895')
  end

  def test_it_can_convert_date_to_offsets
    expected = { A: 1, B: 0, C: 2, D: 5 }

    assert_equal expected, @shift_generator.offsets('040895')
  end

  def test_it_can_generate_total_shifts
    @shift_generator.stubs(:key_to_shifts).returns({ A: 2, B: 27, C: 71,
                                                     D: 15 })
    @shift_generator.stubs(:offsets).returns({ A: 1, B: 0, C: 2, D: 5 })
    expected = { A: 3, B: 27, C: 73, D: 20 }

    assert_equal expected, @shift_generator.total_shifts('02715', '040895')
  end

  def test_it_can_convert_key_date_data_to_shifts
    @shift_generator.stubs(:total_shifts).returns({ A: 3, B: 27, C: 73, D: 20 })
    expected = { A: 3, B: 27, C: 73, D: 20 }

    assert_equal expected, @shift_generator.convert_to_shifts(['02715',
                                                               '040895'])
  end
end

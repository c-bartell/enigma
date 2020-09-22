require './test/test_helper'
require './lib/io_manager'
class IOManagerTest < Minitest::Test
  def setup
    @enigma = mock('Enigma object')
    @io_manager = IOManager.new(@enigma)
  end

  def test_it_exists
    assert_instance_of IOManager, @io_manager
  end

  def test_it_has_attributes
    assert_equal @enigma, @io_manager.enigma
  end

  def test_it_can_read_input_path
    ARGV.replace(['message.txt', 'encrypted.txt'])

    assert_equal 'message.txt', @io_manager.input_path
  end

  def test_it_can_read_output_path
    ARGV.replace(['message.txt', 'encrypted.txt'])

    assert_equal 'encrypted.txt', @io_manager.output_path    
  end
end

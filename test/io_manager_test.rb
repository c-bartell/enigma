require './test/test_helper'
require './lib/io_manager'

class IOManagerTest < Minitest::Test
  def setup
    @enigma = mock('Enigma object')
    @io_manager = IOManager.new(@enigma)
  end

  def write_to_fixture(path, content)
    File.open(path, 'w') do |file|
      file.write(content)
    end
  end

  def test_it_exists
    assert_instance_of IOManager, @io_manager
  end

  def test_it_has_attributes
    assert_equal @enigma, @io_manager.enigma
    assert_equal '', @io_manager.input_text
    assert_equal '', @io_manager.output_text
  end

  def test_it_can_read_input_path
    ARGV.replace(['message.txt', 'encrypted.txt'])

    assert_equal 'message.txt', @io_manager.input_path
  end

  def test_it_can_read_output_path
    ARGV.replace(['message.txt', 'encrypted.txt'])

    assert_equal 'encrypted.txt', @io_manager.output_path
  end

  def test_it_can_generate_input_text
    path = './test/message_fixture.txt'
    write_to_fixture(path, 'hello world')
    @io_manager.stubs(:input_path).returns(path)
    @io_manager.get_text
    write_to_fixture(path, '')

    assert_equal 'hello world', @io_manager.input_text
  end

  def test_it_can_write_to_a_file
    path = './test/encrypted_fixture.txt'
    @io_manager.stubs(:output_path).returns(path)
    @io_manager.stubs(:output_text).returns('keder ohulw')
    @io_manager.write_out
    write_to_fixture(path, '')

    assert_equal 'keder ohulw', @io_manager.input_text

    write_to_fixture(path, '')
  end
end

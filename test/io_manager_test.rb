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

  def test_it_can_stage_output_text
    @io_manager.stage_output('keder ohulw')

    assert_equal 'keder ohulw', @io_manager.output_text
  end

  def test_it_can_write_to_a_file
    path = './test/encrypted_fixture.txt'
    @io_manager.stubs(:input_path).returns(path)
    @io_manager.stubs(:output_path).returns(path)
    @io_manager.stage_output('keder ohulw')
    @io_manager.write_out
    @io_manager.get_text
    write_to_fixture(path, '')

    assert_equal 'keder ohulw', @io_manager.input_text
  end

  def test_it_can_generate_a_summary_message
    results = { key: '02715', date: '040895' }
    expected = "Created 'encrypted.txt' with the key 02715 and date 040895"
    @io_manager.stubs(:output_path).returns('encrypted.txt')

    assert_equal expected, @io_manager.summary(results)
  end

  def test_it_can_puts_summary_to_terminal
    results = mock('Results hash')
    $stdout.stubs(:puts).returns('It called puts.')
    @io_manager.stubs(:summary).returns(nil)

    assert_equal 'It called puts.', @io_manager.show_summary(results)
  end
end

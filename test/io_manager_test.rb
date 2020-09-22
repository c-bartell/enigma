require './test/test_helper'
require './lib/io_manager'
class IOManagerTest < Minitest::Test
  def test_it_exists
    enigma = mock('Enigma object')
    io_manager = IOManager.new(enigma)
    assert_instance_of IOManager, io_manager
  end
end

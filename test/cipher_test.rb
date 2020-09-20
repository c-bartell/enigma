require './test/test_helper'
require './lib/cipher'
require 'mocha/minitest'

class CipherTest < Minitest::Test
  def setup
    @encryptor = mock('Encryptor Object')
    @cipher = Cipher.new(@encryptor)
  end

  def test_it_has_attributes
    assert_equal @encryptor, @cipher.encryptor
    assert_nil @cipher.a_shift
    assert_nil @cipher.b_shift
    assert_nil @cipher.c_shift
    assert_nil @cipher.d_shift
  end

  def test_it_can_generate_character_set
    expected = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
      'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ']

    assert_equal expected, @cipher.characters
  end

  def test_it_can_generate_shifted_character_set
    expected = ['d', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
      'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ', 'a', 'b', 'c']

    assert_equal expected, @cipher.shifted_characters(3)
  end

  def test_it_can_encrypt_a_letter
    assert_equal 'd', @cipher.encrypt_letter('a', 3)
    assert_equal 'b', @cipher.encrypt_letter('z', 3)
    assert_equal 'j', @cipher.encrypt_letter('a', 36)
    assert_equal 'h', @cipher.encrypt_letter('z', 36)
  end

  def test_it_can_set_new_shift_values
    shifts = { A: 5, B: 12, C: 14, D: 74 }
    @cipher.set_shifts(shifts)

    assert_equal 5, @cipher.a_shift
    assert_equal 12, @cipher.b_shift
    assert_equal 14, @cipher.c_shift
    assert_equal 74, @cipher.d_shift
  end

  def test_it_can_request_shifts
    shifts = { A: 5, B: 12, C: 14, D: 74 }
    @encryptor.stubs(:request_shifts).returns(shifts)

    assert_equal shifts, @cipher.request_shifts(['nothing or key and or date'])
  end
  # def test_it_can_encrypt_a_message
  #
  # end
end

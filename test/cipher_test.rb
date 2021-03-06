require './test/test_helper'
require './lib/cipher'

class CipherTest < Minitest::Test
  def setup
    @crypt_manager = mock('CryptManager Object')
    @cipher = Cipher.new(@crypt_manager)
  end

  def test_it_exists
    assert_instance_of Cipher, @cipher
  end

  def test_it_has_attributes
    assert_equal @crypt_manager, @cipher.crypt_manager
    assert_nil @cipher.a_shift
    assert_nil @cipher.b_shift
    assert_nil @cipher.c_shift
    assert_nil @cipher.d_shift
  end

  def test_it_can_request_shifts
    shifts = { A: 5, B: 12, C: 14, D: 74 }
    @crypt_manager.stubs(:request_shifts).returns(shifts)

    assert_equal shifts, @cipher.request_shifts(['nothing or key and or date'])
  end

  def test_it_can_set_new_shift_values
    @cipher.assign_shifts({ A: 5, B: 12, C: 14, D: 74 })

    assert_equal 5, @cipher.a_shift
    assert_equal 12, @cipher.b_shift
    assert_equal 14, @cipher.c_shift
    assert_equal 74, @cipher.d_shift
  end

  def test_it_can_update_shift_values
    shifts = { A: 5, B: 12, C: 14, D: 74 }
    @crypt_manager.stubs(:request_shifts).returns(shifts)
    @cipher.update_shifts(['nothing or key and or date'])

    assert_equal 5, @cipher.a_shift
    assert_equal 12, @cipher.b_shift
    assert_equal 14, @cipher.c_shift
    assert_equal 74, @cipher.d_shift
  end

  def test_it_can_clear_shifts
    @cipher.assign_shifts({ A: 5, B: 12, C: 14, D: 74 })
    @cipher.clear_shifts

    assert_nil @cipher.a_shift
    assert_nil @cipher.b_shift
    assert_nil @cipher.c_shift
    assert_nil @cipher.d_shift
  end

  def test_it_can_generate_character_set
    expected = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
                'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
                ' ']

    assert_equal expected, @cipher.characters
  end

  def test_it_can_generate_shifted_character_set
    expected = ['d', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
                'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ', 'a', 'b',
                'c']

    assert_equal expected, @cipher.shifted_characters(3)
  end

  def test_it_can_encrypt_a_letter
    assert_equal 'd', @cipher.encrypt_letter('a', 3)
    assert_equal 'b', @cipher.encrypt_letter('z', 3)
    assert_equal 'j', @cipher.encrypt_letter('a', 36)
    assert_equal 'h', @cipher.encrypt_letter('z', 36)
  end

  def test_it_can_decrypt_a_letter
    assert_equal 'a', @cipher.decrypt_letter('d', 3)
    assert_equal 'z', @cipher.decrypt_letter('b', 3)
    assert_equal 'a', @cipher.decrypt_letter('j', 36)
    assert_equal 'z', @cipher.decrypt_letter('h', 36)
  end

  def test_it_can_choose_the_correct_shift
    @cipher.assign_shifts({ A: 5, B: 12, C: 14, D: 74 })

    assert_equal 5, @cipher.shift_at_index(0)
    assert_equal 74, @cipher.shift_at_index(99)
    assert_equal 12, @cipher.shift_at_index(12345)
    assert_equal 14, @cipher.shift_at_index(666)
  end

  def test_it_can_encrypterate_over_a_message_array
    shifts = { A: 3, B: 27, C: 73, D: 20 }
    @cipher.assign_shifts(shifts)
    message = ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']
    expected = ['k', 'e', 'd', 'e', 'r', ' ', 'o', 'h', 'u', 'l', 'w']

    assert_equal expected, @cipher.encrypterate(message)
  end

  def test_it_can_decrypterate_over_a_message_array
    shifts = { A: 3, B: 27, C: 73, D: 20 }
    @cipher.assign_shifts(shifts)
    message = ['k', 'e', 'd', 'e', 'r', ' ', 'o', 'h', 'u', 'l', 'w']
    expected = ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']

    assert_equal expected, @cipher.decrypterate(message)
  end

  def test_it_can_return_and_reset
    shifts = { A: 3, B: 27, C: 73, D: 20 }
    @cipher.assign_shifts(shifts)

    assert_equal 'input', @cipher.return_reset('input')
    assert_nil @cipher.a_shift
    assert_nil @cipher.b_shift
    assert_nil @cipher.c_shift
    assert_nil @cipher.d_shift
  end

  def test_it_can_encrypt_a_message_and_reset
    shifts = { A: 3, B: 27, C: 73, D: 20 }
    @crypt_manager.stubs(:request_shifts).returns(shifts)
    message = ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']
    expected = ['k', 'e', 'd', 'e', 'r', ' ', 'o', 'h', 'u', 'l', 'w']

    assert_equal expected, @cipher.encrypt(message, ['02715', '040895'])
  end

  def test_it_can_decrypt_a_message_and_reset
    shifts = { A: 3, B: 27, C: 73, D: 20 }
    @crypt_manager.stubs(:request_shifts).returns(shifts)
    message = ['k', 'e', 'd', 'e', 'r', ' ', 'o', 'h', 'u', 'l', 'w']
    expected = ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']

    assert_equal expected, @cipher.decrypt(message, ['02715', '040895'])
  end
end

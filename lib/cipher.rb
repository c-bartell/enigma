class Cipher
  attr_reader :a_shift, :b_shift, :c_shift, :d_shift, :crypt_manager

  def initialize(crypt_manager)
    @crypt_manager = crypt_manager
    @a_shift = nil
    @b_shift = nil
    @c_shift = nil
    @d_shift = nil
  end

  def request_shifts(key_date_data)
    crypt_manager.request_shifts(key_date_data)
  end

  def assign_shifts(shifts)
    @a_shift = shifts[:A]
    @b_shift = shifts[:B]
    @c_shift = shifts[:C]
    @d_shift = shifts[:D]
  end

  def update_shifts(key_date_data)
    assign_shifts(request_shifts(key_date_data))
  end

  def clear_shifts
    @a_shift = nil
    @b_shift = nil
    @c_shift = nil
    @d_shift = nil
  end

  def characters
    ('a'..'z').to_a << ' '
  end

  def shifted_characters(shift)
    characters.rotate(shift)
  end

  def encrypt_letter(letter, shift)
    shifted_characters(shift)[characters.index(letter)]
  end

  def shift_at_index(index)
    return a_shift if ((index + 1) % 4) == 1
    return b_shift if ((index + 1) % 4) == 2
    return c_shift if ((index + 1) % 4) == 3
    return d_shift if ((index + 1) % 4) == 0
  end

  def encrypterate(message)
    message.each_with_index.map do |letter, index|
      encrypt_letter(letter, shift_at_index(index))
    end
  end

  def encrypt(message, key_date_data)
    update_shifts(key_date_data)
    encrypted = encrypterate(message)
    clear_shifts

    encrypted
  end
end

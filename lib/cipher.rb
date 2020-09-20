class Cipher
  attr_reader :a_shift, :b_shift, :c_shift, :d_shift, :encryptor

  def initialize(encryptor)
    @encryptor = encryptor
    @a_shift = nil
    @b_shift = nil
    @c_shift = nil
    @d_shift = nil
  end

  def request_shifts(key_date_data)
    encryptor.request_shifts(key_date_data)
  end

  def set_shifts(shifts)
    @a_shift = shifts[:A]
    @b_shift = shifts[:B]
    @c_shift = shifts[:C]
    @d_shift = shifts[:D]
  end

  def update_shifts(key_date_data)
    set_shifts(request_shifts(key_date_data))
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
end

require './lib/cipher'
require './lib/shift_generator'

class CryptManager
  attr_reader :enigma, :cipher

  def initialize(enigma)
    @enigma = enigma
    @cipher = Cipher.new(self)
  end

  def format(message)
    message.downcase.chomp.split('')
  end

  def request_shifts(key_date_data)
    enigma.request_shifts(key_date_data)
  end

  def encoded_package(encrypted, key_date_data)
    {
      key: key_date_data[0],
      date: key_date_data[1],
      encryption: encrypted.join
    }
  end

  def decoded_package(encrypted, key_date_data)
    {
      key: key_date_data[0],
      date: key_date_data[1],
      decryption: encrypted.join
    }
  end

  def encrypt_message(message, key_date_data)
    cipher.encrypt(format(message), key_date_data)
  end

  def decrypt_message(ciphertext, key_date_data)
    cipher.decrypt(format(ciphertext), key_date_data)
  end

  def encrypt(message, key_date_data)
    encoded_package(encrypt_message(message, key_date_data), key_date_data)
  end

  def decrypt(ciphertext, key_date_data)
    decoded_package(decrypt_message(ciphertext, key_date_data), key_date_data)
  end
end

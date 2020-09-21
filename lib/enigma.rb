class Enigma
  attr_reader :encryptor

  def initialize
    @encryptor = Encryptor.new(self)
  end
end

class IOManager
  attr_reader :enigma

  def initialize(enigma)
    @enigma = enigma
  end

  def input_path
    ARGV[0]
  end

  def output_path
    ARGV[1]
  end
end

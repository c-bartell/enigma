class IOManager
  attr_reader :enigma, :input_text, :output_text

  def initialize(enigma)
    @enigma = enigma
    @input_text = ''
    @output_text = ''
  end

  def input_path
    ARGV[0]
  end

  def output_path
    ARGV[1]
  end

  def key_input
    ARGV[2]
  end

  def date_input
    ARGV[3]
  end

  def get_text
    @input_text = File.open(input_path, 'r') do |file|
      file.read
    end
  end

  def stage_output(text)
    @output_text = text
  end

  def write_out
    File.open(output_path, 'w') do |file|
      file.write(output_text)
    end
  end

  def summary(results)
    "Created '#{output_path}' with the key #{results[:key]} and date " +
    "#{results[:date]}"
  end

  def show_summary(results)
    puts(summary(results))
  end

  def finish(results, symbol)
    stage_output(results[symbol])
    write_out
    show_summary(results)
  end
end

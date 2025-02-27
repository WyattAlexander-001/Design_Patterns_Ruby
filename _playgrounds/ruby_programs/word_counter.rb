#################################################
# word_counter.rb
#
# A simple Tk-based application that allows you
# to select a text file, then displays:
#  1. The total number of words
#  2. The top word frequencies (e.g., the 10 most frequent words)
#  3. Letter frequencies (a to z)
#  4. Word length distribution
#  5. Other stuff
# This is a learning example to illustrate how to
# create GUI apps with Ruby/Tk.
#################################################

require 'tk'

class WordCounterGUI
  def initialize
    @root = TkRoot.new do
      title "Ruby Word Counter"
      minsize(500, 500)
    end

    main_frame = TkFrame.new(@root)
    main_frame.pack(padx: 10, pady: 10, fill: 'both', expand: true)

    # This makes the title of the app and
    TkLabel.new(main_frame) do
      text "Word Analyzer Tool"
      font TkFont.new('Arial 16 bold')
      foreground 'blue'
      pack(pady: 5)
    end

    TkButton.new(main_frame,
      text: "Select Your Text File",
      command: proc { select_file }
    ).pack(pady: 5)

    @results_text = TkText.new(main_frame)
    @results_text.height = 15
    @results_text.width  = 60
    @results_text.wrap   = 'word'

    scrollbar = TkScrollbar.new(main_frame)
    scrollbar.orient 'vertical'
    scrollbar.command(proc { |*args| @results_text.yview(*args) })
    @results_text.yscrollcommand(proc { |first, last| scrollbar.set(first, last) }) 

    @results_text.pack(side: 'left', fill: 'both', expand: true)
    scrollbar.pack(side: 'right', fill: 'y')

    Tk.mainloop
  end


  # ===== Private Methods =====

  private  # Used to define private methods, which are not accessible outside the class

  def select_file
    path = Tk.getOpenFile('filetypes' => [["Text Files", "*.txt"], ["All Files", "*"]]) # This defaults to documents folder
    return if path.nil? || path.empty?
    process_file(path)
  end

  def process_file(path)
    text = File.read(path)
    words = tokenize(text)
    word_counts = count_words(words)
    letter_counts = count_letters(text)
    length_counts = count_word_lengths(words)
    tone = detect_tone(words)

    @results_text.delete('1.0', 'end')
    @results_text.insert('end', "File: #{path}\n")
    @results_text.insert('end', "Total words: #{words.size}\n\n")
    @results_text.insert('end', "=== Detected Tone ===\n#{tone}\n\n")

    display_top_words(word_counts)
    display_letter_freq(letter_counts)
    display_word_lengths(length_counts)
  end

  def tokenize(text) = text.scan(/\w+/) # This is a method that uses a regular expression to split the text into word
  def count_words(words) = words.each_with_object(Hash.new(0)) { |w, h| h[w.downcase] += 1 } # This is a method that counts the number of times each word appears e.g the, and, or etc, and stores it in a hash which is like a dictionary
  def count_letters(text) = text.each_char.with_object(Hash.new(0)) { |c, h| h[c.downcase] += 1 if c =~ /[a-zA-Z]/ } # This is a method that counts the number of times each letter e.g a, b, c etc appears
  def count_word_lengths(words) = words.each_with_object(Hash.new(0)) { |w, h| h[w.size] += 1 } # This is a method that counts the number of words of each length e.g 3 letter words, 4 letter words etc

  def detect_tone(words)
    angry = %w[hate damn shit fuck fucking pissed angry kill rage can't]
    happy = %w[happy love wonderful great awesome fantastic amazing joy like yes cool]
    down = words.map(&:downcase)
    a_count = down.count { |w| angry.include?(w) }
    h_count = down.count { |w| happy.include?(w) }
    return "Angry / Negative" if a_count > h_count
    return "Positive"        if h_count > a_count
    "Neutral or Mixed"
  end

  def display_top_words(counts)
    @results_text.insert('end', "=== Top Word Frequencies ===\n")
    counts.sort_by { |_, c| -c }.first(10).each { |w, c| @results_text.insert('end', "#{w}: #{c}\n") }
    @results_text.insert('end', "\n")
  end

  def display_letter_freq(counts)
    @results_text.insert('end', "=== Letter Frequencies ===\n")
    counts.keys.sort.each do |letter|
      @results_text.insert('end', "#{letter}: #{counts[letter]}\n")
    end
    @results_text.insert('end', "\n")
  end

  def display_word_lengths(lengths)
    @results_text.insert('end', "=== Word Length Distribution ===\n")
    lengths.keys.sort.each do |len|
      @results_text.insert('end', "#{len} letters: #{lengths[len]}\n")
    end
    @results_text.insert('end', "\n")
  end
end

WordCounterGUI.new # This is the entry point of the program


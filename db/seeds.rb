files_path = "db/import_files/done/*.txt"

Dir.glob(files_path) do |file_path|
  FileUtils.mv(file_path, "db/import_files/")
end

files_path = "db/import_files/*.txt" # Update with the actual path to your text files

Dir.glob(files_path) do |file_path|
  puts file_path
  current_book = Book.create!(title: File.basename(file_path, ".txt"))

  current_chapter = nil
  current_section = nil
  current_text_number = nil
  current_paragraph_number = 0

  File.open(file_path, "r") do |file|
    file.each_line do |line|
      line.chomp!

      if line.start_with?("#Chapter ")
        chapter_title = line.sub("#Chapter ", "")
        current_chapter = Chapter.create!(title: chapter_title, book: current_book)
      elsif line.start_with?("##")
        section_title = line.sub("##", "")
        current_section = Section.create!(title: section_title, chapter: current_chapter)
      elsif line.start_with?("[")
        # Skip lines starting with "[" as they contain additional references or footnotes
        next
      elsif line.match?(/^\d+\.\s(.+)/)
        current_text_number = line.split(".")[0].to_i
        current_paragraph_number = 1
        text = line.match(/^\d+\.\s(.+)/)[1].strip

        TextItem.create!(
          text_number: current_text_number,
          paragraph: current_paragraph_number,
          section: current_section,
          chapter: current_chapter,
          book: current_book,
          text: text
        )
      elsif line.strip.empty?
        current_paragraph_number += 1
      else
        text = line.strip.gsub('##','')

        TextItem.create!(
          text_number: current_text_number,
          paragraph: current_paragraph_number,
          section: current_section,
          chapter: current_chapter,
          book: current_book,
          text: text
        )
      end
    end
  end

  FileUtils.mv(file_path, "db/import_files/done/") # Move processed file to the "done" folder
end

puts "Text parsing and database population completed!"
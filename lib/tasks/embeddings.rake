namespace :embeddings do
  desc 'Calculate and save embeddings for TextItems'
  task calculate: :environment do
    openai_client = OpenAI::Client.new
    text_items = TextItem.where(embedding: nil)
    total_text_items = text_items.size

    text_items.each_with_index do |text_item, index|
      text = text_item.text

      response = openai_client.embeddings(
        parameters: {
          model: 'text-embedding-ada-002',
          input: text
        }
      )

      embedding = response.dig('data', 0, 'embedding')
      text_item.update(embedding: embedding)

      if index % 10 == 0 || index == total_text_items - 1
        progress = ((index + 1) / total_text_items.to_f * 100).round
        progress_output = "Progress: #{index + 1} / #{total_text_items} (#{progress}%)"

        print progress_output
        print "\r"
        $stdout.flush
      end
    end

    puts 'Embeddings calculation completed.'
  end
end

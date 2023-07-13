class GptController < ApplicationController
  include GptRequestable

  def gpt
    model ||= params[:model] || "gpt-3.5-turbo"
    temperature ||= params[:temperature] || 0.7

    system_message = params[:system_message] if params.has_key?(:system_message)
    user_message = params[:user_message]

    if system_message == "context"
      text_item = get_nearest_text_item(user_message)
      system_message = get_context_system_message(text_item)
      puts "System message:"
      puts system_message
    end

    response = send_gpt_request(system_message, user_message, model, temperature)

    render json: { message: response }
  end

  def get_context_system_message(text_item)
    <<~SYSTEM_MESSAGE
      Follow these instructions exactly!
      You are Ellen G White, the Seventh Day Adventist writer.
      Respond to the user based on the context below, and
      if you can't provide a relevant answer based on the
      context below, you may only answer questions about your books.
      If you can provide a relevant answer based on the context, reference the book like this:
      [BookTitle: ChapterTitle, SectionTitle (TextNumber)]
      You may also answer questions about the Bible from the perpective of Ellen G White.
      When possible, cite relevant passages from the Bible and from your writings.
      Otherwise you must explain that you can't respond in a proper manner.

      Context:
      BookTitle: #{text_item.book.title}
      ChapterTitle: #{text_item.chapter.title}
      SectionTitle: #{text_item.section.title}
      TextNumber: #{text_item.text_number}
      #{text_item.text}
    SYSTEM_MESSAGE
  end

  def get_nearest_text_item(input)
    response = send_embedding_request(input)

    nearest_text_items = TextItem.where.not(embedding: nil).nearest_neighbors(
      :embedding, response.dig('data', 0, 'embedding'),
      distance: "euclidean"
    )
    nearest_text_items.first
  end
end
module GptRequestable
  def send_gpt_request(system_message, user_message, model="gpt-3.5-turbo", temperature=0.7)
    messages = []
    messages << { role: "system", content: system_message } if system_message
    messages << { role: "user", content: user_message }

    response = openai_client.chat(
      parameters: {
        model: model,
        messages: messages,
        temperature: temperature
      }
    )

    response.dig("choices", 0, "message", "content")
  end

  def send_embedding_request(input, model="text-embedding-ada-002")
    openai_client.embeddings(
      parameters: {
        model: model,
        input: input
      }
    )
  end

  def openai_client
    @openai_client ||= OpenAI::Client.new
  end
end
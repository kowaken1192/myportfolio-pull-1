class ChatbotsController < ApplicationController
  def create
    input = params[:input]
    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
    
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", 
        messages: [{ role: "user", content: input }], 
        max_tokens: 100
      }
    )
    
    response.dig("choices", 0, "message", "content").truncate(200)
    render json: { response: response.dig("choices", 0, "message", "content") } 
  end
end

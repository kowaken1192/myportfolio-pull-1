class ChatbotsController < ApplicationController
  def create
    input = params[:input] # ユーザーからの入力テキストです
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"]) # OpenAI APIを利用するためのインスタンスを生成します
    
    response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # 利用するModelを指定しています
        messages: [{ role: "user", content: input}], # OpenAIへ送信する内容を指定しています
        max_tokens: 150
    })
    
    trimmed_response = response.dig("choices", 0, "message", "content").truncate(200)
    render json: { response: response.dig("choices", 0, "message", "content") } # レスポンスをViewへ返却しています
  end
end

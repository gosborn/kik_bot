class ApiController < ApplicationController

  def index
  end

  def incoming
    return unless request.headers["X-Kik-Username"]
    user = params[:messages][0]["from"]
    chatId = params[:messages][0]["chatId"]
    send_reply(user, chatId)
  end

  private

  def send_reply(person, chatId)
    RestClient::Request.new(
      :method => :post,
      :url => 'https://api.kik.com/v1/message',
      :data => message(person, chatId).to_json,
      :user => ENV['bot_secret'],
      :password => ENV['api_secret'],
      :headers => {
      :content_type => :json }
    ).execute
  end

  def message(person, chatId)
    {
      messages: [
        {
          body: 'hello!',
          to: person,
          type: 'text',
          chatId: chatId
        }
      ]
    }
  end
end

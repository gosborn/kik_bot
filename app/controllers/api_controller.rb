class ApiController < ApplicationController

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
      :user => 'gregtestbot',
      :password => '874144d0-b25e-49fc-875e-8cbff858ccf9',
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

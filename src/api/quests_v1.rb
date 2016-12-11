class API::QuestsV1 < Grape::API
  desc 'Obtain all quests'
  get '/quests' do
    Quest.all.map(&:to_hash)
  end
end

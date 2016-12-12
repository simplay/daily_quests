class API::QuestsV1 < Grape::API

  desc 'Fetch all quests'
  get '/quests' do
    Quest.all.map(&:to_hash)
  end

  desc 'Fetch a quest by an id.'
  params do
    requires :id, type: Integer, desc: 'Id of target quest'
  end
  get '/quests/:id' do
    quest = Quest.find_by_id(params[:id])
    if quest
      quest.to_hash
    else
      error!("404 quest with id #{params[:id]} not found", 404)
    end
  end

  # create a new quest record.
  # Every quest requires a title and a due date.
  # 
  # @info: The due date time argument is '-' separated,
  #   YYYY-MM-DD-hh-mm
  #   where hour (h) and minute (m) are optional inputs
  #
  # @example
  #   params = {
  #     :title => "dummy_title",
  #     :description => "dummy_description",
  #     :due => "2014-08-04-10-23"
  #   }
  #   post "/api/quests", params
  #
  desc 'Create a new quest.'
  params do
    requires :title, type: String, desc: 'Title of the new quest. '
    requires :due, type: String, desc: 'Due date and time till this quest should be done. Format: Y-M-D-h-m'
    optional :description, type: String, desc: 'Detailed description of this quest, listing the required steps'
    optional :finished, type: Integer, desc: 'State of this task. A one corresponds to finished, a zero to unfinished.'
  end
  default_error_status 400
  post '/quests/' do
    begin
      error! if params[:due].nil?

      # parse date and time input, which is '-' separated.
      date_arguments = params[:due].split('-')
      params[:due] = Time.new(*date_arguments)

      quest = Quest.new(declared_params)
      if quest.valid?
        quest.save
        quest.to_hash
      else
        error! quest.errors
      end
    rescue => e
      error! e.message
    end
  end

  # Update a target quest record
  #
  # @example
  #   params = {
  #     :title => "dummy_title",
  #     :description => "dummy_description",
  #     :due => "2014-08-04-10-23"
  #   }
  #   put "/api/quests", params
  #
  desc 'Update an quest'
  params do
    requires :id, type: Integer, desc: 'Id of target quest'
    optional :title, type: String, desc: 'Title of the new quest. '
    optional :due, type: String, desc: 'Due date and time till this quest should be done. Format: Y-M-D-h-m'
    optional :description, type: String, desc: 'Detailed description of this quest, listing the required steps'
    optional :finished, type: Integer, desc: 'State of this task. A one corresponds to finished, a zero to unfinished.'
  end
  default_error_status 400
  put '/quests/:id' do
    quest = Quest.find_by_id(params[:id])
    if quest
      begin
        # parse date and time input, which is '-' separated.
        unless params[:due].nil?
          date_arguments = params[:due].split('-')
          error!("400 Unknown date format #{params[:due]}. Please use YYYY-MM-DD-hh-mm", 400) if date_arguments.count == 1
          params[:due] = Time.new(*date_arguments)
        end

        if quest.update_attributes(declared_params)
          quest.to_hash
        else
          error! quest.errors
        end
      rescue => e
        error! e.message
      end
    else
      error!("404 quest with id #{params[:id]} not found", 404)
    end
  end


  # Destroy an existing quest.
  desc 'Delete an quest.'
  params do
    requires :id, type: Integer, desc: 'Id of target quest'
  end
  delete '/quests/:id' do
    quest = Quest.find_by_id(params[:id])
    if quest
      quest.destroy
      quest.to_hash
    else
      error!("404 quest with id #{params[:id]} not found", 404)
    end
  end

end

class EventEntriesController < ApplicationController
	def index
		response = nil
		@user = User.find(params[:user_id])
		if @user && !@user.errors.any?
			response = { event_entries: @user.event_entries}
		else
			ResponseGeneratorController.generate_response(false, 0, "Could not list events. #{@user.errors.full_messages}")
		end
		respond_to do |format|
			format.json {render json: response}
		end
	end

	def create
		response = nil
		begin
			@user = User.find(params[:user_id])
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json {render json: ResponseGeneratorController.generate_response(false, 0, "User doesn't exist")}
			end
			return
		end

		if @user && !@user.errors.any?
			event_entry = @user.event_entries.create(event_params)
			if event_entry && !event_entry.errors.any?
				respnse = {event_entry: event_entry}
			else
				response = ResponseGeneratorController.generate_response(false, 0, "Creating event failed")
			end
		else
			response = ResponseGeneratorController.generate_response(false, 0, "Problem occurred retrieving user")
			
		end

		respond_to do |format|
			render {json: response}
		end
		
	end

	def show

		response = nil
		begin
			@user = User.find(params[:user_id])
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json {render json: ResponseGeneratorController.generate_response(false, 0, "User doesn't exist")}
			end
			return
		end

		begin
			@event_entry = @user.event_entries.find(params[:id])
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json {render json: ResponseGeneratorController.generate_response(false, 0, "This event is not recorded")}
			end
			return
		end

		if @event_entry && @event_entry.errors.any?
			response = {event_entry: @event_entry}
		else
			response = ResponseGeneratorController.generate_response(false, 0, "Problem occurred retrieving event")}
		end

		respond_to do |format|
			format.json {render json: response}
		end
	end

	def update
	end

	def destroy
	end

	def event_params
		params.require(:event_entry).permit(:event_timestamp, :event_description, :event_rating)
	end

end

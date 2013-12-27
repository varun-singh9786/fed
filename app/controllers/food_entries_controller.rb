class FoodEntriesController < ApplicationController
	def index
		response = nil
		begin
			@user = User.find(params[:user_id])
		rescue ActiveRecord::RecordNotFound
			respond_to do |format|
				format.json {render json: ResponseGeneratorController.generate_response(false, 0, "User doesn't exist")}
			end
			return
		end

		if @user && !@user.errors.any?
			food_entries = []
			@user.food_entries.each do |food_entry|
				food_entries << food_entry.to_hash
			end
			response = {food_entries: food_entries}
		else
			response = ResponseGeneratorController.generate_response(false, 0, "Could not list foods. #{@user.errors.full_messages if !@user.nil?}")
		end
		respond_to do |format|
			format.json {render json: response}
		end
	end

	def create
		response = nil
		begin
			@user = User.find(params[:user_id])
		rescue ActiveRecord::RecordNotFound
			respond_to do |format|
				format.json {render json: ResponseGeneratorController.generate_response(false, 0, "User doesn't exist")}
			end
			return
		end

		if @user && !@user.errors.any?
			if params[:food_entry][:foods].length > 0
				food_entry = @user.food_entries.build(food_entry_params)
				if food_entry && !food_entry.errors.any?
					foods = params[:food_entry][:foods]
					foods.each do |food|
						new_food = Food.find_by(food_name: food[:food_name])
						if new_food.nil?
							new_food = Food.create(food_name: food[:food_name], cooked_description: food[:cooked_description])
						end
						if new_food && !new_food.errors.any?
							if food_entry.save
								# TODO (food_entry.foods << new_food) Need a better way to do it
								food_entry.foods << new_food
							else
								response = ResponseGeneratorController.generate_response(false, 0, "Creating an entry for food failed")
							end

						else
							response = ResponseGeneratorController.generate_response(false, 0, "Creating an entry for food failed")
						end
					end
					response = {food_entry: food_entry.to_hash}
				else
					response = ResponseGeneratorController.generate_response(false, 0, "Creating an entry for food failed")
				end
			else
				response = ResponseGeneratorController.generate_response(false, 0, "No foods found")
			end

		end

		respond_to do |format|
			format.json {render json: response}
		end

	end

	def show

		response = nil
		begin
			@user = User.find(params[:user_id])
		rescue ActiveRecord::RecordNotFound
			respond_to do |format|
				format.json {render json: ResponseGeneratorController.generate_response(false, 0, "User doesn't exist")}
			end
			return
		end

		begin
			@food_entry = @user.food_entries.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			respond_to do |format|
				format.json {render json: ResponseGeneratorController.generate_response(false, 0, "This event is not recorded")}
			end
			return
		end

		if @food_entry && !@food_entry.errors.any?
			response = {food_entry: FoodEntry.to_hash}
		else
			response = ResponseGeneratorController.generate_response(false, 0, "Problem occurred retrieving event. #{@event_entry.errors.full_messages if !@event_entry.nil?}")
		end

		respond_to do |format|
			format.json {render json: response}
		end
	end

	def update
		response = nil
		response = ResponseGeneratorController.generate_response(false, 0, "This action is not supported yet")

		respond_to do |format|
			format.json { render json: response}
		end
	end

	def destroy
		begin
			@user = User.find(params[:user_id])
		rescue ActiveRecord::RecordNotFound
			respond_to do |format|
				format.json {render json: ResponseGeneratorController.generate_response(false, 0, "User doesn't exist")}
			end
			return
		end

		begin
			@food_entry = @user.food_entries.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			respond_to do |format|
				format.json {render json: ResponseGeneratorController.generate_response(false, 0, "This event is not recorded")}
			end
			return
		end

		if @food_entry && !@food_entry.errors.any?
			if @food_entry.destroy
				response = ResponseGeneratorController.generate_response(true, 0, "Food entry deleted successfully")
			else
				response = ResponseGeneratorController.generate_response(false, 0, "Food entry could not be deleted. #{@food_entry.errors.full_messages}")
			end
		end

		respond_to do |format|
			format.json {render json: response}
		end
	end

	def food_entry_params
		params.require(:food_entry).permit(:timestamp)
	end

	def food_params
		params.permit(:food_name, :cooked_description)
	end
end

class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
    #rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_response

    def index
        campers = Camper.all
        render json: campers
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, include: :activities
    end

    def create
        camper = Camper.create(camper_params)
        if camper.valid?
            render json: camper, status: :created
        else
            render json: {errors: camper.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private 

    def record_not_found_response
        render json: {error: "Camper not found"}, status: :not_found
    end

    def camper_params
        params.permit(:name, :age)
    end
end

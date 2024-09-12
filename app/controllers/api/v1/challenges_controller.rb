module Api
  module V1
    class ChallengesController < ApplicationController
      # GET /api/v1/challenges
      def index
        @challenges = Challenge.all
        render json: @challenges
      end
      # POST  /api/v1/challenges
      def create
        challenge = Challenge.new(challenge_params)
        if challenge.save
          render json: { message: "Challenge added successfully", data: challenge }
        else
            render status: :bad_request, json: { message: "Challenge not added", data: challenge.errors }
        end
      end
      # GET /api/v1/challenges/:id
      def show
        challenge =Challenge.find(params[:id])
        if challenge
          render json: { message: "Challenge fond", data: challenge }
        else
          render status: :not_found, json: { message: "Challenge not found" }
        end
      end
      # PATCH | PUT /api/v1/challenges/:id
      def update
        challenge = Challenge.find(params[:id])
        if challenge.update(challenge_params)
          render json: { message: "Challenge updated successfully", data: challenge }
        else
            render status: :unprocessable_entity, json: { message: "Challenge not updated" }
        end
      end
      # DELETE /api/v1/challenges/:id
      def destroy
        challenge = Challenge.find(params[:id])
        challenge.destroy
        head :no_content
      end

      private
      def challenge_params
        params.require(:challenge).permit(:title, :description, :start_date, :end_date)
      end
    end
  end
end

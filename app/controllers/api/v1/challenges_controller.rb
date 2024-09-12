module Api
  module V1
    class ChallengesController < ApplicationController
      before_action :set_challenge, only: %i[show update destroy]
      # GET /api/v1/challenges
      def index
        @challenges = Challenge.all
        render json: @challenges
      end
      # POST  /api/v1/challenges
      def create
        @NewChallenge = Challenge.new(challenge_params)
        if @NewChallenge.save
          render json: { message: "Challenge added successfully", data: @NewChallenge }
        else
            render status: :bad_request, json: { message: "Challenge not added", data: @challenge.errors }
        end
      end
      # GET /api/v1/challenges/:id
      def show
        if @challenge
          render json: { message: "Challenge fond", data: @challenge }
        else
          render status: :not_found, json: { message: @challenge.errors }
        end
      end
      # PATCH | PUT /api/v1/challenges/:id
      def update
        if @challenge.update(challenge_params)
          render json: { message: "Challenge updated successfully", data: @challenge }
        else
            render status: :unprocessable_entity, json: { message: @challenge.errors }
        end
      end
      # DELETE /api/v1/challenges/:id
      def destroy
        @challenge.destroy
        head :no_content
      end

      private
      def set_challenge
        @challenge = Challenge.find(params[:id])
      end
      def challenge_params
        params.require(:challenge).permit(:title, :description, :start_date, :end_date)
      end
    end
  end
end

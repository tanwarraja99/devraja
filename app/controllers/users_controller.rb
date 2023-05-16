class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]
    def index
        @users = User.all
        render json: @users, status: :ok
      end
      def show
        render json: @user, status: :ok
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: { errors: @user.errors.full_messages },
                 status: :unprocessable_entity
        end
      end
      def find_user
        @user = User.find_by_full_name!(params[:full_name])
        rescue ActiveRecord::RecordNotFound
          render json: { errors: 'User not found' }, status: :not_found
      end

      private
      def user_params
        params.permit(:full_name, :email, :password)
      end
end

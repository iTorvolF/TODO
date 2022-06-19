# frozen_string_literal: true

module Admin
  class UsersController < Admin::ApplicationController
    before_action :set_admin_user, only: %i[show edit update destroy toggle]

    def toggle
      authorize [:admin, @admin_user]
      @admin_user.update_column(:active, !@admin_user.active)

      respond_to do |format|
        format.html do
          redirect_to admin_users_path, notice: 'User activity was successfully changed.'
        end
        format.json { head :no_content }
      end
    end

    # GET /admin/users
    def index
      authorize [:admin, User]
      @admin_users = policy_scope(User,
                                  policy_scope_class: Admin::UserPolicy::Scope)
                     .includes(:role).page(params[:page]).per(5)
    end

    # GET /admin/users/1
    def show
      authorize [:admin, @admin_user]
    end

    # GET /admin/users/new
    def new
      @admin_user = User.new
      authorize [:admin, User]
    end

    # GET /admin/users/1/edit
    def edit
      authorize [:admin, @admin_user]
    end

    # POST /admin/users
    def create
      @admin_user = User.new(admin_user_params)
      authorize [:admin, @admin_user]

      respond_to do |format|
        if @admin_user.save
          format.html { redirect_to admin_users_path, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: admin_users_path }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @admin_user.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/users/1
    def update
      if @admin_user.update(admin_user_params)
        redirect_to [:admin, @admin_user], notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /admin/users/1
    def destroy
      authorize [:admin, @admin_user]
      @admin_user.destroy
      redirect_to admin_users_url, notice: 'User was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_id)
    end
  end
end

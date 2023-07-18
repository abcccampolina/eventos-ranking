class ManageUsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_manage_user, only: [:show, :edit, :update, :destroy]
  before_action :new_manage_user, only: [:new]
  before_action :set_new_manage_user, only: [:create]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /manage_users
  # GET /manage_users.json
  def index
    @manage_users = User.all
  end

  # GET /manage_users/1
  # GET /manage_users/1.json
  def show; end

  # GET /manage_users/new
  def new
    @manage_user = User.new
  end
  
  # GET /manage_users/1/edit
  def edit; end
  
  # POST /manage_users
  # POST /manage_users.json
  def create
    @manage_user = User.new(manage_user_params)

    respond_to do |format|
      if @manage_user.save
        format.html { redirect_to manage_users_path, notice: 'Usuário criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @manage_user }
      else
        format.html { render action: 'new' }
        format.json { render json: @manage_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manage_users/1
  # PATCH/PUT /manage_users/1.json
  def update
    respond_to do |format|
      if @manage_user.update(manage_user_params_update)
        format.html { redirect_to manage_users_path, notice: 'Usuário atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @manage_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manage_users/1
  # DELETE /manage_users/1.json
  def destroy
    @manage_user.destroy
    render json: { ok: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manage_user
      @manage_user = User.find(params[:id])
    end

    def new_manage_user
      @manage_user = User.new
    end

    def set_new_manage_user
      @manage_user = User.new(manage_user_params)
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def manage_user_params
      params.require(:user).permit(:name, :email, :tipo_usuario).merge(password: "123456")
    end

    def manage_user_params_update
      params.require(:user).permit(:name, :email, :tipo_usuario)
    end

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end

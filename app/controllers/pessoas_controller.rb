class PessoasController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_pessoa, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  skip_before_action :authenticate_user!
  
  # GET /pessoas
  # GET /pessoas.json
  def index
    @pessoas = Pessoa.all
  end

  # GET /pessoas/1
  # GET /pessoas/1.json
  def show; end

  # GET /pessoas/new
  def new
    @pessoa = Pessoa.new
  end

  # GET /pessoas/1/edit
  def edit; end

  # POST /pessoas
  # POST /pessoas.json
  def create
    @pessoa = Pessoa.new(pessoa_params)

    respond_to do |format|
      if @pessoa.save
        format.html { redirect_to @pessoa, notice: "Pessoa was successfully created." }
        format.json { render action: "show", status: :created, location: @pessoa }
      else
        format.html { render action: "new" }
        format.json { render json: @pessoa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pessoas/1
  # PATCH/PUT /pessoas/1.json
  def update
    respond_to do |format|
      if @pessoa.update(pessoa_params)
        format.html { redirect_to @pessoa, notice: "Pessoa was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pessoa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pessoas/1
  # DELETE /pessoas/1.json
  def destroy
    @pessoa.destroy
    render json: { ok: true }
  end

  # GET /procurar_expositor
  def procurar_expositor
    @pessoas = SrgPessoa.select(:id, :nome, :cpf, :cnpj, :email, :associado_nome_fazenda, :associado_cidade_fazenda)
    .where("nome LIKE ?", "#{params[:q]}%").order(nome: :asc).limit(5)
    render json: @pessoas
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pessoa
    @pessoa = Pessoa.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pessoa_params
    params.require(:pessoa).permit(:nome, :email, :status, :cpf, :cep, :endereco, :numero, :bairro, :cidade, :uf)
  end

  def sort_column
    Pessoa.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end

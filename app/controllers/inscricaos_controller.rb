class InscricaosController < ApplicationController
  include ApplicationHelper
  helper_method :sort_column, :sort_direction
  before_action :set_inscricao, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!

  #load_and_authorize_resource
  
  # GET /inscricaos
  # GET /inscricaos.json
  def index

    if current_user&.tipo_usuario&.eql?('Administrador') || current_user&.tipo_usuario&.eql?('Organizador') 
      @inscricaos = Inscricao.includes(:criador, :expositor, :srg_animal).where(evento_id: $evento)
      @criador = Pessoa.all
      @expositor = Pessoa.all
    else
      pessoa = Pessoa.find_by(nome: $cpf_pessoa&.nome)
      if pessoa.present?
        @inscricaos = Inscricao.includes(:criador, :expositor, :srg_animal).where(evento_id: params[:evento_id], expositor_id: pessoa.id)
      else
        @inscricaos = Inscricao.includes(:criador, :expositor, :srg_animal).where(evento_id: params[:evento_id], expositor_id: nil)
      end
      @criador = Pessoa.all
      @expositor = Pessoa.all
    end
  end

  # GET /inscricaos/1
  # GET /inscricaos/1.json
  def show; end

  def buscarSrg
    @animal = SrgAnimal.where(nome_completo: params[:nome_animal])
    .where.not(pai: nil, data_nascimento: nil).order("ID DESC").first

    if @animal != nil
      @srg_criador = SrgPessoa.find(@animal.criador)
      @srg_proprietario = SrgPessoa.find(@animal.proprietario)
      @inscricao = Inscricao.new
      @criador = Pessoa.new
      @expositor = Pessoa.new
    else
      @animal = []
    end

    if params[:evento].present?
      $evento = Evento.find(params[:evento])
    end

    etaria, etaria_dia = distance_months_and_days(@animal&.data_nascimento, $evento&.data_avaliacao)
    if $evento&.aceitar_inadiplentes != "Ativo"
      if etaria >= 36 && (@animal&.sexo == "macho" || @animal&.sexo == "femea")
        registro = SrgRegistro.where(animal: @animal&.id, tipo: "D")
        if !registro.present?
          @animal = []
          @message_erro = "O animal #{params[:nome_animal]} não possui registro definitivo. Favor entrar em contato com o proprietário #{@srg_proprietario&.nome} através do telefone #{@srg_proprietario&.telefone} ou email #{@srg_proprietario&.email} para regularizar."
        end
      end
    end


    #validações da nacional
    if $evento.nome.include?("Nacional") && @animal.present?
      apto = false
      eventos_do_ano = Evento.where(anoHipico: $evento.anoHipico)
      inscricaos_animal_do_ano = Inscricao.where(srg_nome_animal: @animal.nome_completo, evento_id: eventos_do_ano.ids)

      eventos_nacional = Evento.where("nome like '%Nacional%'").order("ID DESC").limit(3)
      inscricaos_animal_nacional = Inscricao.where(srg_nome_animal: @animal.nome_completo, evento_id: eventos_nacional.ids)
      
      if etaria >= 12 && etaria <= 18 
        apto = true
      end

      if etaria >= 36 && etaria <= 42 
        apto = true
      end


      if inscricaos_animal_nacional.present?
        #validação 1 (Ser campeão ou reservado nas últimas duas edições da Nacional)
        if (Premio.where("inscricao_id in (#{inscricaos_animal_nacional&.ids.to_s.gsub('[', '').gsub(']','')}) and (posto like 'campeão grande da raça' or posto like 'reservado grande da raça' or posto like 'campeão convencional' or posto like 'reservado convencional')").present?)
          apto = true
        end
      end
      if inscricaos_animal_do_ano.present?
        #validação 2 (Ser Grande Campeão ou Grande Reservado pelo menos uma vez no ano hípico currente)
        if (Premio.where("inscricao_id in (#{inscricaos_animal_do_ano&.ids.to_s.gsub('[', '').gsub(']','')}) and (posto like 'campeão grande da raça' or posto like 'reservado grande da raça')").present?)
          apto = true
        end

        #validação 3 (ter obtido pelo menos 20 pontos no ano hípico currente)
        if (Premio.where("inscricao_id in (#{inscricaos_animal_do_ano&.ids.to_s.gsub('[', '').gsub(']','')})").sum(:pontuacao) >= 20)
          apto = true
        end

        #validação 4 (ter sido julgado em duas exposições no ano)
        if inscricaos_animal_do_ano.count >= 2
          apto = true
        end
      end

      if apto == false
        @animal = []
        @message_erro = "O animal #{params[:nome_animal]} não está apto a particiar da Nacional. Favor conferir o regulamento ou entrar em contato com a Associação."
      end
    end

    render action: "new"
  end


  def buscarAnimalPorCPF
      if params[:buscar_animal_cpf].length > 11
        $cpf_pessoa = SrgPessoa.find_by(cnpj: params[:buscar_animal_cpf])
      else
        $cpf_pessoa = SrgPessoa.find_by(cpf: params[:buscar_animal_cpf])
      end

      pessoa = Pessoa.find_by(nome: $cpf_pessoa&.nome)
      if pessoa.present?
        @inscricaos = Inscricao.includes(:criador, :expositor, :srg_animal).where(evento_id: params[:evento_id], expositor_id: pessoa.id)
      else
        @inscricaos = Inscricao.includes(:criador, :expositor, :srg_animal).where(evento_id: params[:evento_id], expositor_id: nil)
      end
      @criador = Pessoa.all
      @expositor = Pessoa.all
      render action: "index"
  end

  def encerrar_secao_cpf

    $cpf_pessoa = nil
    render action: "new"

  end

  # GET /inscricaos/new
  def new
    if params[:evento].present?
      $evento = Evento.find(params[:evento])
    end
    
    @inscricao = Inscricao.new
    @criador = Pessoa.new
    @expositor = Pessoa.new

  end

  # GET /inscricaos/1/edit
  def edit
    # @animal = SrgAnimal.all
    # @inscricao = Inscricao.new
    # @criador = Pessoa.new
    # @expositor = Pessoa.new
  end

  def ajustar_faixa_etaria
    inscritos = Inscricao.all
    inscritos.each do |inscrito|
      animal = SrgAnimal.find(inscrito.srg_animal_id)
      etaria, etaria_dia = distance_months_and_days(animal.data_nascimento, $evento.data_avaliacao)
      inscrito.update faixa_etaria: etaria, faixa_etaria_dia: etaria_dia
    end
    redirect_to inscricaos_path(notice: "Ajustado com sucesso!")
  end

  # GET /confirmacao_inscricao_mailer
  def confirmacao_inscricao_mailer
    Thread.new do
      $evento.inscricaos.includes(:expositor).sort_by {|i| i.expositor_id }.group_by {|i| i.expositor.nome.parameterize }.each do |_expositor, inscricoes| 
        AnimaisExpositorMailer.animais_expositor(inscricoes).deliver! if inscricoes.first.expositor.email.present?
      end 
    end 
    redirect_to relatorio_index_path, notice: "Em breve os destinatários receberão os e-mails"
  end

  # GET /confirmar_presenca
  def confirmar_presenca
    @expositor = Pessoa.find_by_id(params[:id])
  end
  
  # GET /lista_confirmacao/:id
  def lista_confirmacao
    @expositor = Pessoa.find_by_id(params[:id])
    @inscricao = Inscricao.where(expositor_id: params[:id], evento_id: $evento.id)
  end
  
  # POST /presenca_confirmada/:id
  def presenca_confirmada
    inscricao = Inscricao.where(expositor_id: params[:id])
    permitted = params.require(:inscricao).permit(:presenca_evento)
    @inscricao = Inscricao.where(expositor_id: params[:id]).update(permitted)
    
    redirect_to confirmar_presenca_path, notice: "Presença confirmada com sucesso" 
  end  

  # POST /inscricaos
  # POST /inscricaos.json
  def create
    check_insc = Inscricao.find_by(srg_animal_id: params.dig(:inscricao, :srg_animal_id), evento_id: params.dig(:inscricao, :evento_id))

    if !check_insc.present?
      criador = Pessoa.find_by(nome: criador_params[:nome]) || Pessoa.new(criador_params)
      expositor = Pessoa.find_by(nome: expositor_params[:nome]) || Pessoa.new(expositor_params)

      expositor.update(expositor_params)

      @inscricao = Inscricao.new(inscricao_params(criador: criador, expositor: expositor))

      # Pessoa.all.group_by(&:cpf).map {|k,v| po = v.first; Inscricao.where(expositor_id: v[1..-1].map(&:id)).update_all(expositor_id: po.id); (v[1..-1].map(&:destroy) rescue "Não Deletado") }.uniq
      # Pessoa.all.group_by(&:cpf).map {|k,v| po = v.first; Inscricao.where(criador_id: v[1..-1].map(&:id)).update_all(criador_id: po.id); (v[1..-1].map(&:destroy) rescue "Não Deletado") }
      respond_to do |format|
        if @inscricao.save
          format.html { redirect_to controller: "inscricaos_competicaos", action: "new", inscricao: @inscricao, evento: @inscricao.evento_id, notice: "Inscricao was successfully created." }
          format.json { render action: "show", status: :created, location: @inscricao }
        else
          format.html { render action: "new" }
          format.json { render json: @inscricao.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_inscricao_path(inscricao: check_insc)
    end
  end

  # PATCH/PUT /inscricaos/1
  # PATCH/PUT /inscricaos/1.json
  def update
    respond_to do |format|
      if @inscricao.update(inscricao_params)
        format.html { redirect_to inscricaos_path, notice: "Inscricao was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inscricao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inscricaos/1
  # DELETE /inscricaos/1.json
  def destroy
    @inscricao.destroy
    render json: { ok: true }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_inscricao
    @inscricao = Inscricao.find(params[:id])
  end

  def sort_column
    Inscricao.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def inscricao_params(**args)
    params.require(:inscricao).permit(:srg_animal_id, :evento_id, :srg_nome_animal, :nome_animal,
      :srg_registro_animal, :srg_registro_animal, :pelagem, :marcha, :so_marcha, 
      :presenca_evento, :pai_animal_id, :mae_animal_id, :sexo
    ).merge(**args)
  end

  def criador_params
    params.require(:criador).permit(:cpf, :nome, :email, :cep, :endereco, :numero, :bairro, :cidade, :uf, :fazenda)
  end

  def expositor_params
    params.require(:expositor).permit(:cpf, :nome, :email, :cep, :endereco, :numero, :bairro, :cidade, :uf, :fazenda)
  end

  def inscricao_params_update
    params.require(:inscricao).permit(:presenca_evento)
  end
end

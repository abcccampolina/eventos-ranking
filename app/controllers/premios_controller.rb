class PremiosController < ApplicationController
        helper_method :sort_column, :sort_direction
        before_action :set_premio, only: [:edit, :update, :destroy]
        load_and_authorize_resource
        
        # GET /premios
        # GET /premios.json
        def index
          inscricaos = Inscricao.where(evento_id: $evento.id)
          @premios = Premio.where(inscricao_id: inscricaos.ids)
        end
      
        # GET /premios/1
        # GET /premios/1.json
        def show; end
      
        # GET /premios/new
        def new
          @premio = Premio.new
        end
      
        # GET /premios/1/edit
        def edit; end
      
        # POST /premios
        # POST /premios.json
        def create
          @premio = Premio.new(premio_params)
          @premio.inscricao_id = params[:inscricao_id]
          @premio.criador = @premio.inscricao.criador.nome
          @premio.expositor = @premio.inscricao.expositor.nome
          respond_to do |format|
            if @premio.save
              format.html { redirect_to premios_path, notice: 'Catalogo nome was successfully created.' }
              format.json { render action: 'index', status: :created }
            else
              format.html { render action: 'new' }
              format.json { render json: @premio.errors, status: :unprocessable_entity }
            end
          end
        end
      
        # PATCH/PUT /premios/1
        # PATCH/PUT /premios/1.json
        def update
          respond_to do |format|
            if @premio.update(premio_params)
              format.html { redirect_to edit_competicaos_evento_path(params[:premio][:competicaos_evento_id]), notice: "Inscrições e Catálogo gerados com Sucesso !" }
              format.json { head :no_content }
            else
              format.html { render action: 'edit' }
              format.json { render json: @premio.errors, status: :unprocessable_entity }
            end
          end
        end
      
        # DELETE /premios/1
        # DELETE /premios/1.json
        def destroy
          @premio.destroy
          render json: { ok: true }
        end
      
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_premio
            @premio = Premio.find(params[:id])
          end
      
          # Never trust parameters from the scary internet, only allow the white list through.
          def premio_params
            params.require(:premio).permit(:posto, :inscricao_id, :pontuacao, :pontuacao_expositor, :pontuacao_criador, :nome_catalogo)
          end
      
          def sort_column
            Premios.column_names.include?(params[:sort]) ? params[:sort] : "id"
          end
          
          def sort_direction
            %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
          end
      
end

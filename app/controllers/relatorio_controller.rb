class RelatorioController < ApplicationController
  # load_and_authorize_resource

  def index
  end

  # GET /relatorio/animais_expositor
  def animais_expositor

    respond_to do |format|
      format.html do 
        render 'relatorio/animais_expositor.pdf.erb', template: 'relatorio/animais_expositor', layout: "layouts/catalogo"
      end
      format.json
      format.pdf do 
        # render template: 'relatorio/catalogo', pdf: 'catalogo', page_size: 'A3'
        render template: 'relatorio/animais_expositor',
        layout: "layouts/catalogo",
        pdf: 'catalogo',
        page_size: 'A3',
        footer: { right: 'Página [page] de [topage]' }
      end
    end
  end

  # GET /relatorio/animais_expositor
  def mapa_campeoes

    
    comps_evet  = CompeticaosEvento.where(evento_id: $evento.id).order('ordem')
    ordem = 
    # @competicao_premios = Premio.includes_data.joins(:competicaos_evento)
    # .where(posto: ["campeão convencional", "reservado convencional", "campeão marcha categoria", "reservado marcha categoria", "campeão morfologia categoria","reservado morfologia categoria"])
    # .where(competicaos_evento_id: comps_evet.ids )
    # .group_by(&:competicao_nome)
    # group_by { |c|c&.nome_catalogo&.parameterize }
    

    @competicao_premios = Premio.where(posto: ["campeão convencional", "reservado convencional", "campeão marcha categoria", "reservado marcha categoria", "campeão morfologia categoria","reservado morfologia categoria"])
    .where(competicaos_evento_id: comps_evet.ids )
    .group_by{ |c|c&.competicaos_evento_id }

    respond_to do |format|
      format.html do 
        render 'relatorio/mapa_campeoes.pdf.erb', template: 'relatorio/mapa_campeoes', layout: "layouts/catalogo"
      end
      format.json
      format.pdf do 
        render template: 'relatorio/mapa_campeoes',
        layout: "layouts/catalogo",
        pdf: 'catalogo',
        page_size: 'A3',
        footer: { right: 'Página [page] de [topage]' }
      end
    end
  end


    # GET /relatorio/animais_expositor
    def animais_competicoes

      @comps_evet  = InscricaosCompeticao.where(evento_id: $evento.id)

      respond_to do |format|
        format.html do 
          render 'relatorio/animais_competicoes.pdf.erb', template: 'relatorio/animais_competicoes', layout: "layouts/catalogo"
        end
        format.json
        format.pdf do 
          # render template: 'relatorio/catalogo', pdf: 'catalogo', page_size: 'A3'
          render template: 'relatorio/animais_competicoes',
          layout: "layouts/catalogo",
          pdf: 'catalogo',
          page_size: 'A3',
          footer: { right: 'Página [page] de [topage]' }
        end
      end
    end



    # GET /relatorio/animais_expositor
    def sugestao_progenie

      @inscritos_evento  = Inscricao.where(evento_id: $evento.id)

      respond_to do |format|
        format.html do 
          render 'relatorio/sugestao_progenie.pdf.erb', template: 'relatorio/sugestao_progenie', layout: "layouts/catalogo"
        end
        format.json
        format.pdf do 
          # render template: 'relatorio/catalogo', pdf: 'catalogo', page_size: 'A3'
          render template: 'relatorio/sugestao_progenie',
          layout: "layouts/catalogo",
          pdf: 'catalogo',
          page_size: 'A3',
          footer: { right: 'Página [page] de [topage]' }
        end
      end
    end

    def gerar_campolina_completo
          
      grandes_campeoes = Premio.where(inscricao: Inscricao.where(evento_id: $evento.id)).where('posto ILIKE ?', "campeão grande da raça")
      campolinas = CompeticaoAvalicao.where(inscricao_id: grandes_campeoes.map{|i| i.inscricao_id}).group(:inscricao_id)
      campolinas_sum = campolinas.sum(:nota)
      campolinas_sum.merge!(campolinas.sum('tempo_final')) { |key, important, default| [important, default].flatten }
      campolinas_sum = campolinas_sum.sort_by{| k, v | v}[0..1]

      @campeao_campolina_completo = Inscricao.find(campolinas_sum[0][0])
      @reservado_campolina_completo = Inscricao.find(campolinas_sum[1][0])

      inscritos = Inscricao.where(evento_id: $evento.id)
      Premio.where(inscricao_id: inscritos.ids, nome_catalogo: 'Campolina Completo').delete_all rescue nil
      Premio.create posto: 'Campeão Campolina Completo', nome_catalogo: 'Campolina Completo' , nome_animal: @campeao_campolina_completo.nome_animal, inscricao_id: @campeao_campolina_completo.id , expositor: @campeao_campolina_completo.expositor.nome, pontuacao_expositor: 40 , criador: @campeao_campolina_completo.criador.nome, pontuacao_criador: 40, pontuacao: 40 
      Premio.create posto: 'Reservado Campolina Completo', nome_catalogo: 'Campolina Completo' , nome_animal: @reservado_campolina_completo.nome_animal, inscricao_id: @reservado_campolina_completo.id , expositor: @reservado_campolina_completo.expositor.nome, pontuacao_expositor: 30 , criador: @reservado_campolina_completo.criador.nome, pontuacao_criador: 30, pontuacao: 30 

      respond_to do |format|
        format.html do 
          render 'relatorio/campolina_completo.pdf.erb', template: 'relatorio/campolina_completo', layout: "layouts/catalogo"
        end
        format.json
        format.pdf do 
          render template: 'relatorio/campolina_completo',
          layout: "layouts/catalogo",
          pdf: 'camp_completo',
          page_size: 'A3',
          footer: { right: 'Página [page] de [topage]' }
        end
      end

    end



    def animais_uf
          
      @inscritos = Inscricao.where(evento_id: $evento.id)

      respond_to do |format|
        format.html do 
          render 'relatorio/animais_uf.pdf.erb', template: 'relatorio/animais_uf', layout: "layouts/catalogo"
        end
        format.json
        format.pdf do 
          render template: 'relatorio/animais_uf',
          layout: "layouts/catalogo",
          pdf: 'camp_completo',
          page_size: 'A3',
          footer: { right: 'Página [page] de [topage]' }
        end
      end

    end


end

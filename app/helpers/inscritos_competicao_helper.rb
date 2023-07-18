module InscritosCompeticaoHelper
  def data_item_comp(evento_id, competicao_id)
    competicaojuris = CompeticaoJuri.joins(:competicaos_evento).where(
      competicaos_eventos: {
        evento_id: evento_id,
        competicao_id: competicao_id
      }
    )
    # @competicao_avalicaos = competicaojuris&.map {|juri| juri.competicao_avalicaos.present? ? juri.competicao_avalicaos : CompeticaoAvalicao.new}.flatten

    clusters = ClusterCriteriosAvaliacao.joins(criterios_avaliacaos: :criterios_competicaos).where(criterios_avaliacaos: {criterios_competicaos: {competicao_id: competicao_id}}).uniq
    return competicaojuris, clusters
  end

  def mount_competidores(competidores, competicaojuris, catalogo, competicao_id)
    comps = @competidores.map do |competidor|
			catalogo = @catalogo.find_by(inscricao_id: competidor.inscricao_id)

			competicaojuris.map do |juri|
				CompeticaoAvalicao.find_by(
					inscricao_id: competidor.inscricao.id,
					catalogo_id: catalogo.id,
					competicao_juri_id: juri.id
				) ||
				CompeticaoAvalicao.new(
					inscricao_id: competidor.inscricao_id,
					catalogo_id: catalogo.id,
					evento_id: $evento.id,
					competicao_id: competicao_id,
					competicao_juri_id: juri.id
				)
			end
    end.flatten
    comps.map { |comp| comp.competicao_id = competicao_id; comp }
  end

  def tempo_formatado(tempo_executado)
    tempo_executado ? Time.at(tempo_executado).strftime("%M:%S.%N")[0..9] : nil
  end


end
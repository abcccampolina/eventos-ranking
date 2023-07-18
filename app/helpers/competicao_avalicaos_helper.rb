module CompeticaoAvalicaosHelper
    def filter_competicao_avaliacao(competicao_avalicaos, juri)
        competicao_avalicaos&.select do |ca|
            avaliacao_nome = ca.competicao_juri.cluster_criterios_avaliacao.nome
            ca.competicao_juri_id == juri.id &&
            (avaliacao_nome.eql?('Morfologia') ? !ca.inscricao.so_marcha : true)
        end
        &.sort {|i| i.catalogo&.numero_colete } || []
    end
end
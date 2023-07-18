class Evento < ApplicationRecord
  has_many :inscricaos, dependent: :destroy
  has_many :competicaos_eventos, dependent: :destroy

  has_and_belongs_to_many :users
  belongs_to :user, required: false

  has_many :cluster_criterios_avaliacaos, through: :competicaos_eventos
  has_many :competicao_juris, through: :competicaos_eventos

  REJECTED_ATTRIBUTES = %W[id created_at updated_at evento_id]

  after_create :create_by_template
  after_save :create_juri_template #, if: -> { self.competicao_juris.blank? }

  attr_accessor :template, :juris_templates, :organizadores_templates

  private
    def create_juri_template
      competicaos_eventos.each do |competicao_evento|
        select_juri_templates(competicao_evento).each do |user_id, fields|
          juri = CompeticaoJuri.where(competicaos_evento_id: competicao_evento.id).where(user_id: user_id)
          fields_cluster = fields.map { |cltr| cltr['cluster_id'].to_i }
          if juri.exists?
            juri.each do |jex|
              confront = jex.store_cluster_criterio_avaliacao_id - fields_cluster
              if confront != fields_cluster
                add_cluster = jex.store_cluster_criterio_avaliacao_id << fields_cluster.first
                juri.update(store_cluster_criterio_avaliacao_id: add_cluster)
              end
            end
          else
            CompeticaoJuri.create(
              competicaos_evento_id: competicao_evento.id,
              store_cluster_criterio_avaliacao_id: fields.map { |cltr| cltr['cluster_id'].to_i },
              user_id: user_id
            )
          end
        end
      end
    end

    def select_juri_templates(competicao_evento)
      clusters = competicao_evento.cluster_criterios_avaliacaos.uniq.pluck(:id)
      juris_templates
      .select { |i| clusters.include? i['cluster_id'].to_i }
      .group_by { |jt| jt['user_id'] }
    end

    def create_by_template
      evento = Evento.find self.template
      _competicaos_eventos = evento.competicaos_eventos.map do |comp_evento|

        # Atributos válidos da competição evento
        attribs = comp_evento.attributes.reject do |k,v|
          REJECTED_ATTRIBUTES.include? k
        end

        attribs.merge(
          evento_id: self.id,
          catalogo_nomes_attributes: acert_catalogo_nomes_attributes(comp_evento.catalogo_nomes)
        )
      end
      CompeticaosEvento.create(_competicaos_eventos)
    end

    def acert_catalogo_nomes_attributes(catalogo_nomes)
      rejected_attribs = REJECTED_ATTRIBUTES.append('competicaos_evento_id')
      catalogo_nomes.map do |catalogo|
        catalogo.attributes.reject do |k,v|
          rejected_attribs.include? k
        end
      end
    end
end

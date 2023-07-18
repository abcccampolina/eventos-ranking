class SrgAnimalsController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index

    #@srg_animals = SrgAnimal.where("nome_completo LIKE ?", "%#{params[:q]}%").where.not(pai: nil, data_nascimento: nil).limit(5)
    if current_user&.tipo_usuario&.eql?('Administrador') || current_user&.tipo_usuario&.eql?('Organizador') 
      @srg_animals = SrgAnimal.where("nome_completo LIKE ?", "%#{params[:q]}%").where.not(pai: nil, data_nascimento: nil).limit(10)
    else
      @srg_animals = SrgAnimal.where("nome_completo LIKE '%#{params[:q]}%' and proprietario = #{$cpf_pessoa.id}").where.not(pai: nil, data_nascimento: nil).limit(10)
    end
  end
end
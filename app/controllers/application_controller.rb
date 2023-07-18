class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  before_action :set_current_evento
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, :only => [:inscricaos]

  def set_current_evento
    session[:evento] = Evento.where("id = #{session[:evento]&.id} and ativo = 'Ativo'").first rescue nil if session[:evento]
    
    $evento = session[:evento] || Evento.where(id: current_user.eventos).first rescue 5 if current_user&.present?

    if params.dig(:eventos).present?
      session[:evento] = Evento.find(params.dig(:eventos))
      redirect_to root_path
    else
      session[:evento] = $evento
    end
  end

  def encrypt text
    text = text.to_s unless text.is_a? String
  
    len   = ActiveSupport::MessageEncryptor.key_len
    salt  = SecureRandom.hex len
    key   = ActiveSupport::KeyGenerator.new(Rails.application.secrets.secret_key_base).generate_key salt, len
    crypt = ActiveSupport::MessageEncryptor.new key
    encrypted_data = crypt.encrypt_and_sign text
    "#{salt}$$#{encrypted_data}"
  end
  
  def decrypt text
    salt, data = text.split "$$"
  
    len   = ActiveSupport::MessageEncryptor.key_len
    key   = ActiveSupport::KeyGenerator.new(Rails.application.secrets.secret_key_base).generate_key salt, len
    crypt = ActiveSupport::MessageEncryptor.new key
    crypt.decrypt_and_verify data
  end
  
end

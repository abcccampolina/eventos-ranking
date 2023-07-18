# Preview all emails at http://localhost:3000/rails/mailers/animais_expositor_mailer
class AnimaisExpositorMailerPreview < ActionMailer::Preview
    def animais_expositor
        AnimaisExpositorMailer.animais_expositor(Inscricao.where( expositor_id: 177 ))
    end
end

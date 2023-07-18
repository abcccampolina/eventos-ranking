# Preview all emails at http://localhost:3000/rails/mailers/organization_mailer
class OrganizationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/organization_mailer/send_bank_slip
  def send_bank_slip
    OrganizationMailer.send_bank_slip
  end

end

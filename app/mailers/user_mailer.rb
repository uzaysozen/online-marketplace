class UserMailer < ApplicationMailer
  default from: 'Sheffield University Marketplace <no-reply@sheffield.ac.uk>'

  def contact_email(email, name, message)
    mail(from: email, to: 'client-mail@sheffield.ac.uk', subject: 'Contact From ' + name, body: message)
  end

  def send_bulk_email(users, message)
    mail(bcc: users, subject: 'General Announcement', body: message)
  end

end

class UserMailer < ApplicationMailer
    def contact_email(data)
        @data = data
        mail(to: 'harshilp@uw.edu',
         from: @data[:email],
         subject: 'Contact from your portfolio',
         template_path: 'user_mailer',
         template_name: 'contact_email')
    end
end

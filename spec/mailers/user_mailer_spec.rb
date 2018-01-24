require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'send' do
    let(:mail) {UserMailer.contact_email({'name':'test','email':'test@test.com', 'message':'YO testing testing'})}
    it 'renders headers' do 
      expect(mail.subject).to eq('Contact from your portfolio')
      expect(mail.to).to eq(['harshilp@uw.edu'])
    end
    it 'renders body' do 
      expect(mail.body.encoded).to match('YO testing testing')
    end
  end
end

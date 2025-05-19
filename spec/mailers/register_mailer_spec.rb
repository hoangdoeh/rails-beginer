require "rails_helper"

RSpec.describe RegisterMailer, type: :mailer do
  describe "registered_mail" do
    let(:user) { create(:user, username: "hoang123") }
    let(:mail) { described_class.with(user: user).registered_mail }

    it "renders the subject" do
      expect(mail.subject).to eq("Welcome to us")
    end

    it "renders the from email" do
      expect(mail.from).to eq([ "hoang.do@employmenthero.com" ]) # sửa nếu bạn cấu hình khác
    end

    it "contains username in body" do
      expect(mail.body.encoded).to include(user.username)
    end
  end
end
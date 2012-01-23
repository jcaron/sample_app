require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    before(:each) do
      @user = Factory(:user)
      @user.password_reset_token = "whocares"
    end

    it "should render successfully" do
      lambda { UserMailer.password_reset(@user) }.should_not raise_error
    end

    describe "rendered without error" do
      before(:each) do
        @mail = UserMailer.password_reset(@user)
      end

      it "renders the headers" do
        @mail.subject.should eq("Password reset")
        @mail.to.should eq([@user.email])
        @mail.from.should eq(["from@example.com"])
      end

      it "renders the body" do
        @mail.body.encoded.should match("To reset")
      end
    end
  end

end

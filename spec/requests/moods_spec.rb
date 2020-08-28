 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/moods", type: :request do
  # Mood. As you add validations to Mood, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Mood.create! valid_attributes
      get moods_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      mood = Mood.create! valid_attributes
      get mood_url(mood)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_mood_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      mood = Mood.create! valid_attributes
      get edit_mood_url(mood)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Mood" do
        expect {
          post moods_url, params: { mood: valid_attributes }
        }.to change(Mood, :count).by(1)
      end

      it "redirects to the created mood" do
        post moods_url, params: { mood: valid_attributes }
        expect(response).to redirect_to(mood_url(Mood.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Mood" do
        expect {
          post moods_url, params: { mood: invalid_attributes }
        }.to change(Mood, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post moods_url, params: { mood: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested mood" do
        mood = Mood.create! valid_attributes
        patch mood_url(mood), params: { mood: new_attributes }
        mood.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the mood" do
        mood = Mood.create! valid_attributes
        patch mood_url(mood), params: { mood: new_attributes }
        mood.reload
        expect(response).to redirect_to(mood_url(mood))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        mood = Mood.create! valid_attributes
        patch mood_url(mood), params: { mood: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested mood" do
      mood = Mood.create! valid_attributes
      expect {
        delete mood_url(mood)
      }.to change(Mood, :count).by(-1)
    end

    it "redirects to the moods list" do
      mood = Mood.create! valid_attributes
      delete mood_url(mood)
      expect(response).to redirect_to(moods_url)
    end
  end
end

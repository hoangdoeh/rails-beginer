require 'rails_helper'

RSpec.describe TodoSerializer, type: :serializer do
  let(:user) { create(:user, username: "testuser") }
  let(:todo) { create(:todo, name: "My Todo", deadline: Time.zone.local(2025, 5, 20, 14, 30), user_id: user.id) }

  subject { described_class.new(todo) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(subject) }
  let(:serialized_json) { JSON.parse(serialization.to_json) }

  it "includes the expected attributes" do
    expect(serialized_json["id"]).to eq(todo.id)
    expect(serialized_json["name"]).to eq("My Todo")
    expect(serialized_json["thedeadline"]).to eq("2025-05-20 14:30")
  end

  it "includes the user relationship" do
    expect(serialized_json["user"]["id"]).to eq(user.id)
    expect(serialized_json["user"]["username"]).to eq("testuser")
  end
end

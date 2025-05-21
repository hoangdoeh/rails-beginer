require 'rails_helper'

RSpec.describe Todo, type: :model do
  let!(:user) { FactoryBot.create(:user) }

  describe '#validations' do
    context 'when missing required attributes' do
      it 'is invalid without name and deadline' do
        todo = described_class.new
        expect(todo).not_to be_valid
        expect(todo.errors[:name]).to be_present
        expect(todo.errors[:deadline]).to be_present
      end

      it 'is invalid without deadline' do
        todo = described_class.new(name: "Test case")
        expect(todo).not_to be_valid
        expect(todo.errors[:deadline]).to be_present
      end

      it 'is invalid without name' do
        todo = described_class.new(deadline: Date.today)
        expect(todo).not_to be_valid
        expect(todo.errors[:name]).to be_present
      end
    end

    context 'when all required attributes are present' do
      it 'is valid with name, deadline, status, and user' do
        todo = described_class.new(
          name: "Test case 2",
          deadline: Date.today,
          status: 0,
          user: user
        )
        expect(todo).to be_valid
      end
    end
  end
end

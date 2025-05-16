class TodoSerializer < ActiveModel::Serializer
  attributes :id, :name, :thedeadline
  belongs_to :user
  def thedeadline
    object.deadline.strftime("%Y-%m-%d %H:%M")
  end
end

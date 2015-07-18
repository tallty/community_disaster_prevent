class AddNickNameToSubscriber < ActiveRecord::Migration
  def change
    add_column :subscribers, :nick_name, :string
  end
end

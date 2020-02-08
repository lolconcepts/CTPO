class AddPronounToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :pronoun, foreign_key: true
  end
end

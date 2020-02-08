class CreatePronouns < ActiveRecord::Migration[5.2]
  def up
    create_table :pronouns do |t|
      t.string :description

      t.timestamps
    end
    Pronoun.create(description: "Prefer Not To Use")
    Pronoun.create(description: "She/her/hers")
    Pronoun.create(description: "He/his")
    Pronoun.create(description: "They/them")
  end
  def down
  	drop_table :pronouns
  end
end

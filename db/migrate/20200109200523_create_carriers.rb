class CreateCarriers < ActiveRecord::Migration[5.2]
  def up
    create_table :carriers do |t|
      t.string :name
      t.string :suffix

      t.timestamps
    end
    Carrier.create(:name => 'AT&T',
    			   :suffix => '@txt.att.net')
    Carrier.create(:name => 'Sprint',
    			   :suffix => '@messaging.sprintpcs.com')
    Carrier.create(:name => 'T-Mobile',
    			   :suffix => '@tmomail.net')
    Carrier.create(:name => 'Metro PCS',
    			   :suffix => '@mymetropcs.com')
    Carrier.create(:name => 'Verizon',
    			   :suffix => '@vtext.com')
    Carrier.create(:name => 'Comcast/XFinity',
             :suffix => '@vtext.com')
    Carrier.create(:name => 'Consumer Cellular',
             :suffix => '@mailmymobile.net')
  end

  def down
  	drop_table :carriers
  end
end

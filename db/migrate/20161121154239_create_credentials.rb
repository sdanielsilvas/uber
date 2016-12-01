class CreateCredentials < ActiveRecord::Migration[5.0]
  def change
    create_table :credentials do |t|

      t.timestamps
    end
  end
end

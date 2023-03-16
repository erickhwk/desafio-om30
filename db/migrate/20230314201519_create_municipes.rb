class CreateMunicipes < ActiveRecord::Migration[6.1]
  def change
    create_table :municipes do |t|
      t.string :name, null: false
      t.string :cpf, null: false
      t.string :cns, null: false
      t.string :email, null: false
      t.date :birth_date, null: false
      t.string :phone, null: false
      t.string :photo, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end

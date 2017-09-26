class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table(:people) do |t|
     t.column(:first_name, :string)
     t.column(:last_name, :string)
     t.column(:phone, :string)
     t.column(:email, :varchar)
     t.column(:note, :string)

     t.timestamps()
   end
  end
end

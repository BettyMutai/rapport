class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table(:companies) do |t|
     t.column(:name, :string)
     t.column(:phone, :string)
     t.column(:email, :varchar)
     t.column(:note, :string)

     t.timestamps()
   end
  end
end

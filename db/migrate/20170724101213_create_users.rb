class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table(:users) do |t|
      t.column(:username,:string)
      t.column(:password_digest,:string)
      t.column(:image, :varchar)
      t.column(:first_name, :string)
      t.column(:last_name, :string)
      t.column(:position, :string)
      t.column(:department, :string)
      t.column(:email, :varchar)

      t.timestamps()
    end
  end
end

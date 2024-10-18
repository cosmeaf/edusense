Sequel.migration do
  up do
    add_column :lessons, :city, String, text: true
  end

  down do
    drop_column :lessons, :city
  end
end

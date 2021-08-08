class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.uuid :api_key, default: 'gen_random_uuid()', null: false

      t.timestamps
    end
  end
end

class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :session_token, null: false, index: { unique: true }
      t.integer :user_id, null: false, index: true
      t.string :browser_name
      t.string :platform_name
      t.string :platform_version
      
      t.timestamps
    end
  end
end

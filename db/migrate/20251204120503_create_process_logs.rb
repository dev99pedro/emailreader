class CreateProcessLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :process_logs do |t|
      t.timestamps
      t.string :status
      t.string :filename
      t.string :error
      t.json :extracteddata

    end
  end
end

class CreateTutors < ActiveRecord::Migration[6.1]
  def change
    create_table :tutors do |t|
      t.string :name
      t.integer :experience
      t.references :course
      t.string :skills

      t.timestamps
    end
  end
end

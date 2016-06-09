class CreateMathclasses < ActiveRecord::Migration
  def change
    create_table :mathclasses do |t|
      t.string :name
      t.integer :students
      t.belongs_to :highschool

      t.timestamps null: false
    end
  end
end

class CreateBugFixes < ActiveRecord::Migration
  def change
    create_table :bug_fixes do |t|
      t.decimal :big, precision: 32, scale: 0
    end
  end
end

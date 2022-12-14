class CreateSectionEdits < ActiveRecord::Migration[5.2]
  def up
    create_table :section_edits do |t|
      # this is a join table
      # following are 2 foreign keys
      t.integer :"admin_user_id"
      t.integer :"section_id"

      t.text :"summary"
      t.timestamps
    end
    add_index("section_edits", ["admin_user_id", "section_id"])
  end

  def down
    drop_table :section_edits
  end

end

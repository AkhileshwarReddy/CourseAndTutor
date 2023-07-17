class CreateCourses < ActiveRecord::Migration[7.0]
  TABLE_NAME = :courses
  INDEX_COLUMNS = %[title].freeze

  def up
    return if table_exists?(TABLE_NAME)

    create_table TABLE_NAME do |t|
      t.string :title, null: false, unique: true
      t.text :description

      t.timestamps
    end

    add_index(TABLE_NAME, INDEX_COLUMNS) unless index_exists?(TABLE_NAME, INDEX_COLUMNS)
  end

  def down
    return unless table_exists?(TABLE_NAME)

    remove_index(TABLE_NAME, INDEX_COLUMNS) if index_exists?(TABLE_NAME, INDEX_COLUMNS)
    drop_table(TABLE_NAME)
  end
end

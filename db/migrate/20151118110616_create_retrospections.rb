class CreateRetrospections < ActiveRecord::Migration
  def change
    create_table :retrospections do |t|
      t.string :ip_address
      t.string :name
      t.integer :age
      t.integer :episodes_attended
      t.integer :episodes_watched
      t.integer :best_cast
      t.string :best_guest
      t.integer :nationality
      t.integer :humour
      t.integer :karaoke
      t.integer :music
      t.integer :introspection
      t.integer :segment_1_culture
      t.integer :segment_2_dance
      t.integer :segment_3_distribution
      t.integer :segment_4_mailbag
      t.integer :segment_5_mjtrivia
      t.integer :segment_6_showtell
      t.integer :segment_7_siivous
      t.integer :segment_8_trivia
      t.integer :segment_9_visitortasks
      t.integer :segment_10_justin
      t.integer :segment_11_sigame
      t.text :additional_comments
      t.string :email

      t.timestamps null: false
    end
  end
end

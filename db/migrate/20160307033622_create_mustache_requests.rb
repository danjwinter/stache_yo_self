class CreateMustacheRequests < ActiveRecord::Migration
  def change
    create_table :mustache_requests do |t|
      t.string :uid
      t.string :channel
    end
  end
end

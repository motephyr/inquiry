class AddCaresCountToWork < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :cares_count, :integer, default: 0

    # Work.reset_column_information
       # Work.all.each do |p|
       #    Work.update_counters p.id, :cares_count => p.cares.length
       #  end
  end
end

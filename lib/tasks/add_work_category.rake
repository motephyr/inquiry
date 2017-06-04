namespace :add_work_category do
    desc "add_work_category"
    task :task => :environment do
        Work.find_each do |x|
            x.update_attribute('category_id', x.user.user_info.category_id)
        end
    end
end

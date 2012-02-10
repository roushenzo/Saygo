namespace :photo do
  desc "Recreate versions for all instances model Photo"
  task :recreate_versions => :environment do
    Photo.all.map(&:file).each do |f|
      begin
        puts "Recompiling: #{f}"
        f.recreate_versions!
      rescue => e
        puts e.message
      end
    end
    puts "Recompiling finished!"
  end
end

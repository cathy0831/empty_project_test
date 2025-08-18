namespace :backup_func do
  path = "log/tmp"

  task log_rotate: :environment do
    yesterday = 1.day.ago.strftime("%Y%m%d")
    system "mv log/whenever.log log/whenever.log.#{yesterday}"
    system "mv log/whenever_error.log log/whenever_error.log.#{yesterday}"

    # 修改日期小於7天前，移動到log底下tmp資料夾
    Dir.mkdir path unless File.directory?(path)
    Rails.root.glob("log/*.log.*")
         .select { |f| File.mtime(f) < 2.days.ago }
         .each do |f|
      puts "moving #{f}"
      FileUtils.mv f, path
    end
  end

  task remove_files: :environment do
    # 修改日期小於365天前，刪除
    Rails.root.glob("log/tmp/*.log.*")
         .select { |f| File.mtime(f) < 365.days.ago }
         .each do |f|
      puts "remove #{f}"
      FileUtils.rm f
    end
  end
end

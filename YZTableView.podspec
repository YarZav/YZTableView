Pod::Spec.new do |s|

  s.name         = "YZTableView"
  s.version      = "1.0.0"
  s.summary      = "This is a simple UITableView which contains laoder, refresh and view for no content"

  s.description  = "This is a simple UITableView which contains laoder, refresh and view for no content"

  s.homepage     = "https://github.com/YarZav/YZTableView"

  s.license      = "MIT"

  s.author             = { "Yaroslav Zavyalov" => "yaroslavzavyalov1@gmail.com" }

  s.platform     = :ios, "11.0"

  s.source       = { :git => "https://github.com/YarZav/YZTableView.git", :tag => "1.0.0" }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.swift_version = "4.2"

end

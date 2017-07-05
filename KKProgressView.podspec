

Pod::Spec.new do |s|

  s.name         = "KKProgressView"

  s.version      = "1.0.0"

  s.summary      = "KKProgressView -> custom progress view (rectangle or circle)"

  s.description  = <<-DESC
 a custom progress view, (rectangle or circle). All kinds of custom properties
                   DESC

  s.homepage     = "https://github.com/TieShanWang/KKProgressView"

  s.license      = "MIT"

  s.author             = { "wangtieshan" => "15003836653@163.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/TieShanWang/KKProgressView.git", :tag => s.version }

  s.framework  = "UIKit"

  s.source_files  = "KKProgressView/KKProgressView/**/*.{swift}"

end

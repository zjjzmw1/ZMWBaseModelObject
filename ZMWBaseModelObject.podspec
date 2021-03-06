Pod::Spec.new do |s|

s.name             = "ZMWBaseModelObject"

s.version          = "1.0.2"

s.summary          = "利用Runtime给Model赋值、归档、解档"

s.description      = <<-DESC
 "利用Runtime给Model赋值、归档、解档"
DESC

s.homepage         = "https://github.com/zjjzmw1/ZMWBaseModelObject"
s.license          = "MIT"
s.author           = { "张明炜" => "zjjzmw1@163.com" }

s.source           = { :git => "https://github.com/zjjzmw1/ZMWBaseModelObject.git", :tag => s.version.to_s }
s.platform     = :ios, "7.0"

s.requires_arc = true

s.source_files = "Classes/*"

s.frameworks = "Foundation", "CoreGraphics", "UIKit"

end


Pod::Spec.new do |s|
  s.name         = "GomoreFramework"
  s.version      = "1.0.0"
  s.summary      = "上海勾芒科技有限公司"
  s.description  = <<-DESC
                   上海勾芒科技有限公司 All rights reserved
                   DESC
  s.homepage     = "https://github.com/gomoretech/GomoreFramework"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Matej gomoretech' => '3179793140@qq.com' }
  s.source       = { :git => "https://github.com/gomoretech/GomoreFramework.git", :tag => "1.0.0" }
  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.source_files = "GomoreFramework/**/*.{h,m}"
  s.requires_arc = true
end
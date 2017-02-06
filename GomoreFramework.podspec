
Pod::Spec.new do |s|
  s.name         = "GomoreFramework"
  s.version      = "0.0.3"
  s.summary      = "上海勾芒科技有限公司"
  s.description  = <<-DESC
                   上海勾芒科技有限公司 All rights reserved
                   DESC
  s.homepage     = "https://github.com/caoyunxiao/GomoreFramework"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Matej gomoretech' => '3179793140@qq.com' }
  s.source       = { :git => "https://github.com/caoyunxiao/GomoreFramework.git", :tag => "0.0.3" }
  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.source_files = "**/*.{h,m}"
end
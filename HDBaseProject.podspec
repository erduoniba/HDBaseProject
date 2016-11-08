Pod::Spec.new do |s|
s.name             = "HDBaseProject"
s.version          = "1.1.6"
s.summary          = "快速搭建项目:添加UILabel的Category"
s.description      = "新建项目中常用的基础类，项目有一定量的时候，都是代码的复制和粘贴，但是在后台的粘贴中或许有好的代码更正，这个时候我们往往没有时间去维护以前的老代码，不经意间会出现代码不同步的问题"

s.homepage         = "https://github.com/erduoniba/HDBaseProject"
s.license          = 'MIT'
s.author           = { "Harry" => "328418417@qq.com" }
s.source           = { :git => "https://github.com/erduoniba/HDBaseProject.git", :tag => "1.1.6" }

s.platform     = :ios, '8.0'
s.requires_arc = true

#s.source_files = 'Pod/Classes/**/*'
s.public_header_files = 'Pod/Classes/HDBaseProject.h'
s.source_files = 'Pod/Classes/HDBaseProject.h'
#s.resource_bundles = {
#'HDBaseProject' => ['Pod/Assets/*.png']
#}

#按照不同的模块对文件目录进行整理
s.subspec 'Catogorys' do |catogory|
catogory.source_files = 'Pod/Classes/Catogorys/*'
catogory.public_header_files = 'Pod/Classes/Catogorys/*.h'
end

s.subspec 'HDBaseViewControllers' do |vc|
vc.source_files = 'Pod/Classes/HDBaseViewControllers/*'
vc.public_header_files = 'Pod/Classes/HDBaseViewControllers/*.h'
vc.ios.dependency 'HDBaseProject/HDGlobalMethods'
vc.ios.dependency 'HDBaseProject/ThirdPartyLibs'
vc.ios.dependency 'HDBaseProject/Catogorys'
#vc.dependency 'HDBaseProject/Catogorys'  错误
#vc.ios.dependency 'Pod/Classes/Catogorys' 错误
end

s.subspec 'HDGlobalMethods' do |method|
method.source_files = 'Pod/Classes/HDGlobalMethods/*'
method.public_header_files = 'Pod/Classes/HDGlobalMethods/*.h'
method.ios.dependency 'HDBaseProject/Catogorys'
end

s.subspec 'HDHTTPManager' do |http|
http.source_files = 'Pod/Classes/HDHTTPManager/*'
#http.public_header_files = 'Pod/Classes/HDHTTPManager/*.h'
end

s.subspec 'ThirdPartyLibs' do |lib|
lib.source_files = 'Pod/Classes/ThirdPartyLibs/**/*'
lib.public_header_files = 'Pod/Classes/ThirdPartyLibs/**/*.h'
end

s.dependency 'AFNetworking' 		    #依赖关系，该项目所依赖的其他库，如果有多个需要填写多个s.dependency
s.dependency 'SDWebImage'               #依赖关系，该项目所依赖的其他库，如果有多个需要填写多个s.dependency
s.dependency 'MJRefresh'                #依赖关系，该项目所依赖的其他库，如果有多个需要填写多个s.dependency
end

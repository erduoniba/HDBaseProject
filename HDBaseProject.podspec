Pod::Spec.new do |s|
s.name             = "HDBaseProject"
s.version          = "1.0.8"
s.summary          = "快速搭建项目"
s.description      = "新建项目中常用的基础类，项目有一定量的时候，都是代码的复制和粘贴，但是在后台的粘贴中或许有好的代码更正，这个时候我们往往没有时间去维护以前的老代码，不经意间会出现代码不同步的问题"

s.homepage         = "https://github.com/erduoniba/HDBaseProject"
s.license          = 'MIT'
s.author           = { "Harry" => "328418417@qq.com" }
s.source           = { :git => "https://github.com/erduoniba/HDBaseProject.git", :tag => "1.0.8" }

s.platform     = :ios, '7.0'
s.requires_arc = true


#别人pod该代码的时候，需要比较清晰的目录结构，代码如下：
s.subspec 'Catogorys' do |ss|
ss.source_files = 'Pod/Classes/Catogorys/*.{h,m}'
end

s.subspec 'HDBaseViewControllers' do |ss|
ss.source_files = 'Pod/Classes/HDBaseViewControllers/*.{h,m}'
end

s.subspec 'HDBaseViewControllers' do |ss|
ss.source_files = 'Pod/Classes/HDBaseViewControllers/*.{h,m}'
end

s.subspec 'HDGlobalMethods' do |ss|
ss.source_files = 'Pod/Classes/HDGlobalMethods/*.{h,m}'
end

s.subspec 'HDHTTPManager' do |ss|
ss.source_files = 'Pod/Classes/HDHTTPManager/*.{h,m}'
end

s.subspec 'ThirdPartyLibs' do |ss|
ss.source_files = 'Pod/Classes/ThirdPartyLibs/*.{h,m}'
end

s.public_header_files = 'HDBaseProject/HDBaseProject.h'
s.source_files = 'HDBaseProject/HDBaseProject.h'

s.resource_bundles = {
'HDBaseProject' => ['Pod/Assets/*.png']
}

s.dependency 'AFNetworking'  #依赖关系，该项目所依赖的其他库，如果有多个需要填写多个s.dependency
s.dependency 'SDWebImage'    #依赖关系，该项目所依赖的其他库，如果有多个需要填写多个s.dependency
s.dependency 'MJRefresh'     #依赖关系，该项目所依赖的其他库，如果有多个需要填写多个s.dependency
end

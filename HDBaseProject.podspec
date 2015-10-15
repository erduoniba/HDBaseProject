Pod::Spec.new do |s|
s.name             = "HDBaseProject"
s.version          = "1.0.2"
s.summary          = "快速搭建项目"
s.description      = "新建项目中常用的基础类，项目有一定量的时候，都是代码的复制和粘贴，但是在后台的粘贴中或许有好的代码更正，这个时候我们往往没有时间去维护以前的老代码，不经意间会出现代码不同步的问题"

s.homepage         = "https://github.com/erduoniba/HDBaseProject"
s.license          = 'MIT'
s.author           = { "Harry" => "328418417@qq.com" }
s.source           = { :git => "https://github.com/erduoniba/HDBaseProject.git", :tag => "1.0.2" }

s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files = 'Pod/Classes/**/*'
s.resource_bundles = {
'HDBaseProject' => ['Pod/Assets/*.png']
}

s.dependency 'AFNetworking'  #依赖关系，该项目所依赖的其他库，如果有多个需要填写多个s.dependency
s.dependency 'SDWebImage'    #依赖关系，该项目所依赖的其他库，如果有多个需要填写多个s.dependency
end

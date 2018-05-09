Pod::Spec.new do |s|
    s.name             = "HDBaseProject"
    s.version          = "1.3.1"
    s.summary          = "快速搭建项目:支持AFNetworking3.1.0请求，支持自定义下拉gif动画，开源请求类"
    s.description      = <<-DESC
    '新建项目中常用的基础类，项目有一定量的时候，都是代码的复制和粘贴，但是在后台的粘贴中或许有好的代码更正，这个时候我们往往没有时间去维护以前的老代码，不经意间会出现代码不同步的问题'
    1.3.1：项目结构使用MVP模式，添加网络请求子模块
    1.3.0：项目结构使用MVP模式，添加网络请求子模块
    1.2.2：整理pod结构
    1.2.1：优化代码，细微的调整；
    1.2.0：添加了常用的Category，提高项目开发速度；
    1.1.9：兼容SDWebImage4.0；
    DESC
    s.homepage         = "https://github.com/erduoniba/HDBaseProject"
    s.license          = 'MIT'
    s.author           = { "Harry" => "328418417@qq.com" }
    s.source           = { :git => "https://github.com/erduoniba/HDBaseProject.git", :tag => s.version }
    s.platform     = :ios, '8.0'
    s.requires_arc = true

    s.public_header_files = 'HDBaseProject/HDBaseProject.h'
    s.source_files = 'HDBaseProject/HDBaseProject.h'

    #按照不同的模块对文件目录进行整理
    s.subspec 'HDCatogorys' do |catogory|
        catogory.public_header_files = 'HDBaseProject/HDCatogorys/*.h'
        catogory.source_files = 'HDBaseProject/HDCatogorys/*.{h,m}'
        
        catogory.dependency 'SDWebImage'
    end

    s.subspec 'HDGlobalMethods' do |method|
        method.public_header_files = 'HDBaseProject/HDGlobalMethods/*.h'
        method.source_files = 'HDBaseProject/HDGlobalMethods/*.{h,m}'

        method.dependency 'HDBaseProject/HDCatogorys'
    end

    s.subspec 'HDNetworking' do |http|
        http.source_files = 'HDBaseProject/HDNetworking/*.{h,m}'
        http.public_header_files = 'HDBaseProject/HDNetworking/*.h'

        http.dependency 'AFNetworking'
        http.dependency 'PINCache'
    end

    s.subspec 'ThirdPartyLibs' do |lib|
        lib.public_header_files = 'HDBaseProject/ThirdPartyLibs/**/*.h'
        lib.source_files = 'HDBaseProject/ThirdPartyLibs/**/*.{h,m}'
    end

    s.subspec 'HDBaseViewControllers' do |base|
        base.public_header_files = 'HDBaseProject/HDBaseViewControllers/*.h'
        base.source_files = 'HDBaseProject/HDBaseViewControllers/*.{h,m}'
        base.resource = 'HDBaseProject/HDBaseViewControllers/HDBaseProject.bundle'

        base.dependency 'HDBaseProject/HDGlobalMethods'
        base.dependency 'HDBaseProject/ThirdPartyLibs'
        base.dependency 'HDBaseProject/HDCatogorys'
        base.dependency 'HDBaseProject/HDNetworking'

        base.dependency 'SDWebImage'
        base.dependency 'MJRefresh'
    end
end


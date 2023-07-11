require 'fileutils'
require 'pathname'

$current_dir = Dir.pwd
$dir_name = File.basename($current_dir)
# 追加监听路径
$current_path = Pathname.new(File.dirname(__FILE__)).realpath

# 状态展示
fileContent = File.read("#{$current_dir}/#{$dir_name}.podspec")
regex = /#currentDebugMode = (.*)/
match_data = fileContent.match(regex)
unless match_data.nil? 
  modeTip = match_data[1].chomp.to_i == 1 ? "normal模式" : "热重载模式"
  puts "当前Mode为：#{modeTip}"
end

# 切换指令
puts "\n请选择要切换的Mode：\n1、normal模式 \n2、热重载模式 \n\n注：热重载模式会改变当前的pod工作区间的源码路径为当前的主工程目录，主要原因是injectioniii的文件目录监听限制\n"
chooseMode = gets.chomp.to_i

# 移动默认目录到主工程目录
def dirMoveChange(fromPath, toPath)
  FileUtils.mkdir_p(toPath)
  # 移动当前默认的目录为主工程项目Example下的目录
  Dir.glob(fromPath) do |folder|
    next unless File.directory?(folder)
    FileUtils.mv(folder, toPath)
  end
end

# 修改podspec内容，更改源码路径
def source_file_change_mode(path, file, mode)
  content = File.read(path)
  clearRegx = /#currentDebugMode = (.*)/
  content = content.gsub(clearRegx,'')
  # 正常模式
  if mode == 1
    regex = /[,]?"Example\/#{$dir_name}\/#{$dir_name}\/\*\*\/\*\.\{h,m,swift\}"[,]?/m
    replaceConent = content.gsub(regex, '')
    replaceConent << "#currentDebugMode = 1"
    File.open(path, "w") { |file| file.puts replaceConent }
  end

  # 热重载模式
  if mode == 2 
    unless content.include?(file) 
      content.gsub!(/^(\s*s\.source_files\s*=\s*)(.+)$/m) do
        "#{$1}\"#{file}\",#{$2}\n"
      end
      content << "#currentDebugMode = 2"
      File.open(path, "w") { |file| file.puts content }
    end
  end
end

podspec_path = "#{$dir_name}.podspec" 
new_file = "Example/#{$dir_name}/#{$dir_name}/**/*.{h,m,swift}"

case chooseMode
when 1 # 正常模式
  puts "转换正常模式..."
  fromPath = "Example/#{$dir_name}/#{$dir_name}"
  toPath = "#{$current_dir}"
  dirMoveChange(fromPath, toPath)
  source_file_change_mode(podspec_path, new_file, chooseMode)
when 2 # injectioniii模式
  puts "转换热重载模式..."
  source_file_change_mode(podspec_path, new_file, chooseMode)
  fromPath = "#{$current_dir}/#{$dir_name}"
  toPath = "Example/#{$dir_name}"
  dirMoveChange(fromPath, toPath)
else
  puts "Hey,bro~ 你输入的是什么玩意儿？从1和2中选一个..."
end

# iBiu组件依赖安装
if chooseMode == 1 || chooseMode == 2
  ibiuExec = `bash -c 'pod install #{$current_dir}/Example;'`
  puts "***************请稍后，ibiu 更新中...************"
  puts ibiuExec
  puts "***********************************************"
  puts "success🍻!!🎉🎊🎈"
  changeRes = chooseMode == 1 ? "已切换为normal模式" : "已切换为热重载模式"
  puts "🎉🎉🎉#{changeRes}🍻🍻🍻"
end

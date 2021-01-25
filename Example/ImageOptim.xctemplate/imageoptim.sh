if which /Applications/ImageOptim.app/Contents/MacOS/ImageOptim >/dev/null; then
  echo "start ImageOptim"
else
  echo "需要安装ImageOptim https://imageoptim.com/mac"
fi


cd ..

projectName=""
function findProjectName2 {
	projectName=`find . -iname "*.$1"`
	projectName=${projectName#*./}
	projectName=${projectName%%.$1}
}

findProjectName2 "podspec"
if [[ $projectName != "" ]]; then
 echo  "找到格式为 podspec格式的 文件名: ${projectName}"
else
 echo  "未能找到格式为 podspec格式的 文件名"
fi

cd $projectName/Assets
echo $PWD
find $PWD | egrep '\.(png|jpg|gif)$' | xargs /Applications/ImageOptim.app/Contents/MacOS/ImageOptim
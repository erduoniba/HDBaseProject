pod lib lint \
# --sources=https://github.com/CocoaPods/Specs.git, http://172.16.10.165/midea-common/midea-specs.git \
--use-libraries --no-clean --allow-warnings

if [ $? -eq 0 ]; then
	echo "congratulation,pod verifys success! 💐 💐 💐 💐"

	pod repo push midea-specs \
	# --sources=https://github.com/CocoaPods/Specs.git,http://172.16.10.165/midea-common/midea-specs.git \
	--use-libraries --allow-warnings

	if [ $? -eq 0 ]; then
		echo "congratulation,pod push to midea-specs success! 💐 💐 💐 💐"
	else
		echo "pod push to midea-specs fail!"
	fi
else
	echo "pod verifys fail!"
fi
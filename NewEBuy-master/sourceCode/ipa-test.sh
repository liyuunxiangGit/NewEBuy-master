#!/bin/bash

#--------------------------------------------
# 功能：为SuningEBuy打测试包
# 作者：liukun
# 创建日期：2014/03/11
#--------------------------------------------

###########################################常量设置###########################################

#测试下载环境上配置的suningEBuy_iphone的配置
appId="26"	#苏宁易购iPhone
versionId="30"	#2.4.5 
uploadUrl="http://10.24.64.230/app/SNUploadPackageAction.php"

#bundleIdentifier
bundle_id="SuningEMall"

#appName
app_name="苏宁易购"

#workspace
work_space="SuningEBuy.xcworkspace"

#scheme
scheme="SuningEBuy"

#xocdebuild pre
xcode_build="xcodebuild -workspace ${work_space} -scheme ${scheme} -configuration Release"

#工程绝对路径
project_path=$(pwd)
echo "======工程路径：${project_path}======"

#创建保存打包结果的目录
result_path=${project_path}/build/build_test_$(date +%Y-%m-%d_%H_%M)
mkdir -p "${result_path}"
echo "======最终打包路径：${result_path}======"

#工程配置文件路径
project_name=$(ls | grep xcodeproj | awk -F.xcodeproj '{print $1}')
echo "======工程文件名称：${project_name}======"
target_name=${project_name}
echo "======target名称：${target_name}======"
project_infoplist_path=${project_path}/${project_name}/${project_name}-Info.plist
echo "======Info.plist路径：${project_infoplist_path}======"

#取版本号
bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${project_infoplist_path})
echo "======版本号：${bundleShortVersion}======"

#配置文件路径
buildConfig=${project_path}/${project_name}/Constant/SuningEBuyConfig.h

#定义配置函数
###########################################定义函数###########################################

function config()
{
	#修改环境配置
	#pre
	preConfigLine=$(grep -n "kPreTest" "${buildConfig}" | tail -1 | cut  -d  ":"  -f  1)
	if [ $preConfigLine ]; then
		if [[ $1 = "-pre" ]]; then
			sed -i '' -e "${preConfigLine}s/^.*$/#define kPreTest        1/" ${buildConfig}
		else
			sed -i '' -e "${preConfigLine}s/^.*$/\/\/#define kPreTest        1/" ${buildConfig}
		fi
	else
		echo -e "\033[31m 未找到配置： kPreTest \033[0m"
	fi

	#sit
	sitConfigLine=$(grep -n "kSitTest" "${buildConfig}" | tail -1 | cut  -d  ":"  -f  1)
	if [ $sitConfigLine ]; then
		if [[ $1 = "-sit" ]]; then
			sed -i '' -e "${sitConfigLine}s/^.*$/#define kSitTest        1/" ${buildConfig}
		else
			sed -i '' -e "${sitConfigLine}s/^.*$/\/\/#define kSitTest        1/" ${buildConfig}
		fi
	else
		echo -e "\033[31m 未找到配置： kSitTest \033[0m"
	fi

	#release
	releaseConfigLine=$(grep -n "kReleaseH" "${buildConfig}" | tail -1 | cut  -d  ":"  -f  1)
	if [ $releaseConfigLine ]; then
		if [[ $1 = "-prd" ]]; then
			sed -i '' -e "${releaseConfigLine}s/^.*$/#define kReleaseH        1/" ${buildConfig}
		else
			sed -i '' -e "${releaseConfigLine}s/^.*$/\/\/#define kReleaseH        1/" ${buildConfig}
		fi
	else
		echo -e "\033[31m 未找到配置： kReleaseH \033[0m"
	fi

	#2.2 检查推送、签到服务器等配置

	#mobile dev 一直是关闭
	mDevConfigLine=$(grep -n "kMobileDevTest" "${buildConfig}" | tail -1 | cut  -d  ":"  -f  1)
	if [ $mDevConfigLine ]; then
		sed -i '' -e "${mDevConfigLine}s/^.*$/\/\/#define kMobileDevTest        1/" ${buildConfig}
	else
		echo -e "\033[31m 未找到配置： kMobileDevTest \033[0m"
	fi

	#mobile sit
	mSitConfigLine=$(grep -n "kMobileSitTest" "${buildConfig}" | tail -1 | cut  -d  ":"  -f  1)
	if [ $mSitConfigLine ]; then
		if [[ $1 = "-prd" ]]; then
			sed -i '' -e "${mSitConfigLine}s/^.*$/\/\/#define kMobileSitTest        1/" ${buildConfig}
		else
			sed -i '' -e "${mSitConfigLine}s/^.*$/#define kMobileSitTest        1/" ${buildConfig}
		fi
	else
		echo -e "\033[31m 未找到配置： kMobileSitTest \033[0m"
	fi

	#mobile release
	mReleaseConfigLine=$(grep -n "kMobileReleaseH" "${buildConfig}" | tail -1 | cut  -d  ":"  -f  1)
	if [ $mReleaseConfigLine ]; then
		if [[ $1 = "-prd" ]]; then
			sed -i '' -e "${mReleaseConfigLine}s/^.*$/#define kMobileReleaseH        1/" ${buildConfig}
		else
			sed -i '' -e "${mReleaseConfigLine}s/^.*$/\/\/#define kMobileReleaseH        1/" ${buildConfig}
		fi
	else
		echo -e "\033[31m 未找到配置： kMobileReleaseH \033[0m"
	fi

	#2.3 检查信息搜集服务器
	#snclick pre
	tPreConfigLine=$(grep -n "kPreInfoTest" "${buildConfig}" | tail -1 | cut  -d  ":"  -f  1)
	if [ $tPreConfigLine ]; then
		sed -i '' -e "${tPreConfigLine}s/^.*$/\/\/#define kPreInfoTest        1/" ${buildConfig}
	else
		echo -e "\033[31m 未找到配置： kPreInfoTest \033[0m"
	fi

	#snclick sit
	tSitConfigLine=$(grep -n "kSitInfoTest" "${buildConfig}" | tail -1 | cut  -d  ":"  -f  1)
	if [ $tSitConfigLine ]; then
		if [[ $2 = "-publish" ]]; then
			sed -i '' -e "${tSitConfigLine}s/^.*$/\/\/#define kSitInfoTest        1/" ${buildConfig}
		else
			sed -i '' -e "${tSitConfigLine}s/^.*$/#define kSitInfoTest        1/" ${buildConfig}
		fi
	else
		echo -e "\033[31m 未找到配置： kSitInfoTest \033[0m"
	fi

	#snclick release
	tReleaseConfigLine=$(grep -n "kReleaseInfoH" "${buildConfig}" | tail -1 | cut  -d  ":"  -f  1)
	if [ $tReleaseConfigLine ]; then
		if [[ $2 = "-publish" ]]; then
			sed -i '' -e "${tReleaseConfigLine}s/^.*$/#define kReleaseInfoH        1/" ${buildConfig}
		else
			sed -i '' -e "${tReleaseConfigLine}s/^.*$/\/\/#define kReleaseInfoH        1/" ${buildConfig}
		fi
	else
		echo -e "\033[31m 未找到配置： kReleaseInfoH \033[0m"
	fi

	#2.4 检查打印开关
	logLine=$(grep -n "define\ DEBUGLOG" "${buildConfig}" | tail -1 | cut  -d  ":"  -f  1)
	if [ $logLine ]; then
		sed -i '' -e "${logLine}s/^.*$/\/\/#define DEBUGLOG 1/" ${buildConfig}
	else
		echo -e "\033[31m 未找到配置： DEBUGLOG \033[0m"
	fi

	#如果是发布，再检查下bundleIdentifier 和 国际化名称
	if [[ $2 = "-publish" ]]; then
		#修改bundleIdentifier
		bundleIdNew="${bundle_id}${versionShort}prd"
		/usr/libexec/PlistBuddy -c "set CFBundleIdentifier ${bundle_id}" ${project_infoplist_path}
		#国际化名称
		infoString=${project_path}/${project_name}/zh-Hans.lproj/InfoPlist.strings
		sed -i '' -e "4s/^.*$/CFBundleDisplayName = \"${app_name}\";/" ${infoString}
		#发布时要打开https证书信任验证
		validatesSecureFile=${project_path}/${project_name}/Common/Http/HttpMsgCtrl.mm
		validatesSecureLine=$(grep -n "request.validatesSecureCertificate" "${validatesSecureFile}" | tail -1 | cut -d ":" -f 1)
		if [ $validatesSecureLine ]; then
		    sed -i '' -e "${validatesSecureLine}s/NO/YES/g" ${validatesSecureFile}
		else
		    echo -e "\033[31m 未找到：validatesSecureCertificate \033[0m"
		fi
	fi
}

##检验参数
#检查是否含-u参数，包含即上传
needUpload=false
#检查打什么包 -pre -sit -prd 如果三者都没有，默认都打
prd_should=false
pre_should=false
sit_should=false

#只修改配置
just_config=false
#忽略证书检查
ignore_check_codesign=true

if [[ $1 = "config" ]]; then
	config $2 $3
	exit
fi

if [[ $# -gt 0 ]]; then
	for arg in "$@"
	do
		if [[ $arg = "-u" ]]; then
			needUpload=true
		elif [[ $arg = "-pre" ]]; then
			pre_should=true
		elif [[ $arg = "-prd" ]]; then
			prd_should=true
		elif [[ $arg = "-sit" ]]; then
			sit_should=true
		elif [[ $arg = "-all" ]]; then
			pre_should=true
			prd_should=true
			sit_should=true
		elif [[ $arg = "-ignore-codesign" ]]; then
			ignore_check_codesign=true
		fi
	done
fi

#如果没有设置，默认都为yes
if ! $prd_should && ! $pre_should && ! $sit_should; then
	pre_should=true
	prd_should=true
	sit_should=true
fi

#检查xcodebuild版本
#echo "======检查是否支持iphoneos7.0======"
#isSupport7=$(xcodebuild -showsdks | grep "iphoneos7")
#isSupport8=$(xcodebuild -showsdks | grep "iphoneos8.0")
#if [ "${isSupport7}" == "" ] -a [ "${isSupport8}" == "" ]; then
#	echo -e "\033[31m 请升级你的命令行版本，使其支持ios7.0以上 \033[0m"
#	exit
#fi

#编译配置打印到文件中
setting_out=${result_path}/build_setting.txt
${xcode_build}  -showBuildSettings > ${setting_out}

#编译路径
build_dir=$(grep "CONFIGURATION_BUILD_DIR" "${setting_out}" | cut  -d  "="  -f  2 | grep -o "[^ ]\+\( \+[^ ]\+\)*")
echo "编译路径：${build_dir}"

#打包完的程序目录
appDir=${build_dir}/${target_name}.app;
#dSYM的路径
dsymDir=${build_dir}/${target_name}.app.dSYM;

if ! $ignore_check_codesign; then
	#检查工程中证书的选择
	echo "======检查是否选择了正确的发布证书======"
	
	codeSign=$(grep "CODE_SIGN_IDENTITY" "${setting_out}" | cut  -d  "="  -f  2 | grep -o "[^ ]\+\( \+[^ ]\+\)*")
	rightDistributionSign="iPhone Distribution: Suning Appliance Co., Ltd."
	if [ "${codeSign}" != "${rightDistributionSign}" ]; then
		echo -e "\033[31m 错误的证书:${codeSign}，请进入xcode选择证书为:${rightDistributionSign} \033[0m"
		exit
	fi
	#检查授权文件
	echo "======检查是否选择了正确的签名文件======"
	provisionProfile=$(grep "PROVISIONING_PROFILE[^_]" "${setting_out}" | cut  -d  "="  -f  2 | grep -o "[^ ]\+\( \+[^ ]\+\)*")
	rightProvision="c59f649f-edb5-4a18-a4fe-870eb7b52d8d"   #这个是企业证书的id
	if [ "${provisionProfile}" != "${rightProvision}" ]; then
		echo -e ${provisionProfile}
		echo -e "\033[31m 错误的签名，请进入xcode重新选择授权文件 \033[0m"
		exit
	fi
fi

versionShort=$(echo ${bundleShortVersion} | sed "s/\.//g")

#############################################PRD#############################################

if $prd_should; then
	#打生产环境测试包
	echo "======打生产环境的测试包======"
	echo "======修改配置中======"
	#修改bundleIdentifier
	bundleIdNew="${bundle_id}${versionShort}prd"
	/usr/libexec/PlistBuddy -c "set CFBundleIdentifier ${bundleIdNew}" ${project_infoplist_path}
	#修改环境配置
	config -prd;
	#国际化名称
	infoString=${project_path}/${project_name}/zh-Hans.lproj/InfoPlist.strings
	sed -i '' -e "4s/^.*$/CFBundleDisplayName = \"PRD${versionShort}.$(date +%m%d)\";/" ${infoString}

	#编译工程
	${xcode_build} -sdk iphoneos build || exit
	
	#ipa名称
	ipa_name="${result_path}/${bundleIdNew}.ipa"
	#先打第一个appStore渠道的包
	xcrun -sdk iphoneos PackageApplication -v "${appDir}" -o "${ipa_name}"
	#xcrun -sdk iphoneos PackageApplication -v "${appDir}" -o "${ipa_name}" --sign "${enterpriseSign}" --embed "${enterpriseEmbed}"
	#拷贝过来.app和.app.dSYM放在子目录
	mkdir -p "${result_path}/prd"
	cp -R "${appDir}" "${result_path}/prd/${target_name}.app"
	cp -R "${dsymDir}" "${result_path}/prd/${target_name}.app.dSYM"

	#上传测试包prd
	if $needUpload; then
		curl -F "app=${appId}" -F "version=${versionId}" -F "bundleIdentifier=${bundleIdNew}" -F "desc=${bundleIdNew}" -F "file=@${ipa_name}" ${uploadUrl}
	fi
fi

#############################################PRE#############################################

if $pre_should; then
	#打PRE环境测试包
	echo "======打PRE环境的测试包======"
	echo "======修改配置中======"
	#修改bundleIdentifier
	bundleIdNew="${bundle_id}${versionShort}pre"
	/usr/libexec/PlistBuddy -c "set CFBundleIdentifier ${bundleIdNew}" ${project_infoplist_path}

	#修改环境配置
	config -pre

	#国际化名称
	infoString=${project_path}/${project_name}/zh-Hans.lproj/InfoPlist.strings
	sed -i '' -e "4s/^.*$/CFBundleDisplayName = \"PRE${versionShort}.$(date +%m%d)\";/" ${infoString}

	#编译工程
	${xcode_build} -sdk iphoneos build || exit
	
	#ipa名称
	ipa_name="${result_path}/${bundleIdNew}.ipa"
	#先打第一个appStore渠道的包
	xcrun -sdk iphoneos PackageApplication -v "${appDir}" -o "${ipa_name}"
	#xcrun -sdk iphoneos PackageApplication -v "${appDir}" -o "${ipa_name}" --sign "${enterpriseSign}" --embed "${enterpriseEmbed}"
	#拷贝过来.app和.app.dSYM放在子目录
	mkdir -p "${result_path}/pre"
	cp -R "${appDir}" "${result_path}/pre/${target_name}.app"
	cp -R "${dsymDir}" "${result_path}/pre/${target_name}.app.dSYM"

	#上传测试包pre
	if $needUpload; then
		curl -F "app=${appId}" -F "version=${versionId}" -F "bundleIdentifier=${bundleIdNew}" -F "desc=${bundleIdNew}" -F "file=@${ipa_name}" ${uploadUrl}
	fi
fi

#############################################SIT#############################################

if $sit_should; then
	#打PRE环境测试包
	echo "======打SIT环境的测试包======"
	echo "======修改配置中======"
	#修改bundleIdentifier
	bundleIdNew="${bundle_id}${versionShort}sit"
	/usr/libexec/PlistBuddy -c "set CFBundleIdentifier ${bundleIdNew}" ${project_infoplist_path}
	#修改环境配置
	config -sit
	#国际化名称
	infoString=${project_path}/${project_name}/zh-Hans.lproj/InfoPlist.strings
	sed -i '' -e "4s/^.*$/CFBundleDisplayName = \"SIT${versionShort}.$(date +%m%d)\";/" ${infoString}

	#编译工程
	${xcode_build} -sdk iphoneos build || exit
	
	#ipa名称
	ipa_name="${result_path}/${bundleIdNew}.ipa"
	#先打第一个appStore渠道的包
	xcrun -sdk iphoneos PackageApplication -v "${appDir}" -o "${ipa_name}"
	#xcrun -sdk iphoneos PackageApplication -v "${appDir}" -o "${ipa_name}" --sign "${enterpriseSign}" --embed "${enterpriseEmbed}"
	#拷贝过来.app和.app.dSYM放在子目录
	mkdir -p "${result_path}/sit"
	cp -R "${appDir}" "${result_path}/sit/${target_name}.app"
	cp -R "${dsymDir}" "${result_path}/sit/${target_name}.app.dSYM"

	#上传测试包sit
	if $needUpload; then
		curl -F "app=${appId}" -F "version=${versionId}" -F "bundleIdentifier=${bundleIdNew}" -F "desc=${bundleIdNew}" -F "file=@${ipa_name}" ${uploadUrl}
	fi
fi

#############################################还原配置#############################################
/usr/libexec/PlistBuddy -c "set CFBundleIdentifier ${bundle_id}" ${project_infoplist_path}
sed -i '' -e "4s/^.*$/CFBundleDisplayName = \"${app_name}\";/" ${infoString}


#!/bin/bash

#--------------------------------------------
# 功能：为SuningEBuy打包，并发布appStore和打渠道包
# 作者：liukun
# 创建日期：2014/03/10
#--------------------------------------------

#bundleIdentifier
bundle_id="SuningEMall"

#appName
app_name="苏宁易购"

#workspace
work_space="SuningEBuy.xcworkspace"

#scheme
scheme="SuningEBuy"

#xocdebuild pre
xcode_build_appstore="xcodebuild -workspace ${work_space} -scheme ${scheme} -configuration Distribution-AppStore"
xcode_build_jailbroken="xcodebuild -workspace ${work_space} -scheme ${scheme} -configuration Distribution-JailBroken"


#证书名称
rightDistributionSign="iPhone Distribution: Suning Appliance Co., Ltd. (76M3JYH4P2)"

#provision名称
rightProvision="da8e37dd-04d9-4ea8-92e8-68f8bafd9a5a"

#工程绝对路径
project_path=$(pwd)
echo "======工程路径：${project_path}======"
#build文件夹路径
build_path=${project_path}/build
echo "======编译路径：${build_path}======"

#工程配置文件路径
project_name=$(ls | grep xcodeproj | awk -F.xcodeproj '{print $1}')
echo "======工程文件名称：${project_name}======"
target_name=${project_name}
echo "======target名称：${target_name}======"
#创建保存打包结果的目录
result_path=${build_path}/build_release_$(date +%Y-%m-%d_%H_%M)
mkdir -p "${result_path}"
echo "======最终打包路径：${result_path}======"

project_infoplist_path=${project_path}/${project_name}/${project_name}-Info.plist
echo "======Info.plist路径：${project_infoplist_path}======"

#取版本号
bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${project_infoplist_path})
echo "======版本号：${bundleShortVersion}======"

#检查xcodebuild版本
#echo "======检查xcode版本======"
#isSupport7=$(xcodebuild -version | grep "Xcode\ 5.1.1")
#if [ "${isSupport7}" == "" ]; then
#    echo -e "\033[31m 请升级你的xcode版本到5.1.1 \033[0m"
#    exit
#fi

#检查工程中证书的选择
echo "======检查是否选择了正确的发布证书======"
setting_out=${result_path}/build_setting.txt
${xcode_build_appstore} -showBuildSettings > ${setting_out}
codeSign=$(grep "CODE_SIGN_IDENTITY" "${setting_out}" | cut  -d  "="  -f  2 | grep -o "[^ ]\+\( \+[^ ]\+\)*")
if [ "${codeSign}" != "${rightDistributionSign}" ]; then
    echo -e "\033[31m 错误的证书:${codeSign}，请进入xcode选择证书为:${rightDistributionSign} \033[0m"
    exit
fi
#检查授权文件
echo "======检查是否选择了正确的签名文件======"
provisionProfile=$(grep "PROVISIONING_PROFILE[^_]" "${setting_out}" | cut  -d  "="  -f  2 | grep -o "[^ ]\+\( \+[^ ]\+\)*")
if [ "${provisionProfile}" != "${rightProvision}" ]; then
    echo -e "\033[31m 错误的签名，请进入xcode重新选择授权文件 \033[0m"
    exit
fi

#编译路径
build_dir=$(grep "CONFIGURATION_BUILD_DIR" "${setting_out}" | cut  -d  "="  -f  2 | grep -o "[^ ]\+\( \+[^ ]\+\)*")
echo "编译路径：${build_dir}"

#打包完的程序目录
appDir=${build_dir}/${target_name}.app;
#dSYM的路径
dsymDir=${build_dir}/${target_name}.app.dSYM;

#检查工程配置
#1、检查bundleIdentifier
bundleIdentifier=$(/usr/libexec/PlistBuddy -c "print CFBundleIdentifier" ${project_infoplist_path})
if [ $bundleIdentifier != "${bundle_id}" ]; then
    echo -e "\033[31m 发布的bundleIdentifier必须是${bundle_id} \033[0m"
    #修改
    /usr/libexec/PlistBuddy -c "set CFBundleIdentifier ${bundle_id}" ${project_infoplist_path}
    echo "======已修改bundleIdentifier为${bundle_id}======"
fi;

#1.1检查国际化名称
infoString_cn=${project_path}/${project_name}/zh-Hans.lproj/InfoPlist.strings
infoString_en=${project_path}/${project_name}/en.lproj/InfoPlist.strings
sed -i '' -e "4s/^.*$/CFBundleDisplayName = \"${app_name}\";/" ${infoString_cn}
sed -i '' -e "4s/^.*$/CFBundleDisplayName = \"${app_name}\";/" ${infoString_en}

echo "======开始clean工程,打appStore渠道包======"
${xcode_build_appstore} clean

#编译工程
${xcode_build_appstore}  -sdk iphoneos build || exit

#ipa名称
ipa_name="${result_path}/${target_name}_${bundleShortVersion}_appStore.ipa"
#先打第一个appStore渠道的包
xcrun -sdk iphoneos PackageApplication -v "${appDir}" -o "${ipa_name}"
#xcrun -sdk iphoneos PackageApplication -v "${appDir}" -o "${ipa_name}" --sign "${enterpriseSign}" --embed "${enterpriseEmbed}"
#拷贝过来.app和.app.dSYM放在子目录
mkdir -p "${result_path}/dsym"
cp -R "${appDir}" "${result_path}/dsym/${target_name}.app"
cp -R "${dsymDir}" "${result_path}/dsym/${target_name}.app.dSYM"

echo "======开始clean工程,打越狱渠道包======"
${xcode_build_jailbroken} clean

#编译工程
${xcode_build_jailbroken}  -sdk iphoneos build || exit

#ipa名称
ipa_name="${result_path}/${target_name}_${bundleShortVersion}_jailbroken.ipa"
#打越狱渠道包
xcrun -sdk iphoneos PackageApplication -v "${appDir}" -o "${ipa_name}"
#拷贝过来.app和.app.dSYM放在子目录
mkdir -p "${result_path}/dsym_jailbroken"
cp -R "${appDir}" "${result_path}/dsym_jailbroken/${target_name}.app"
cp -R "${dsymDir}" "${result_path}/dsym_jailbroken/${target_name}.app.dSYM"

#zip的路径
zipPath=${result_path}/${target_name}_jailbroken.zip

#拷贝为zip
cp ${ipa_name} ${zipPath}

#解压缩
unzip ${zipPath} -d ${result_path}

#payload目录
cd ${result_path}
payload="Payload"

bundle_path="${payload}/${target_name}.app"

#读取渠道包列表
dcfilePath=${bundle_path}/DC.plist
downloadChannelCount=$(/usr/libexec/PlistBuddy -c "print list" "${dcfilePath}" | grep "Dict" | wc -l)
echo "======渠道包数量：${downloadChannelCount}======"
let downloadChannelCount--

#遍历包列表并开始打包
for i in `seq 1 ${downloadChannelCount}`;do
    # echo "the index is: $idx."
    dcName=$(/usr/libexec/PlistBuddy -c "print list:${i}:name" ${dcfilePath})
    dcId=$(/usr/libexec/PlistBuddy -c "print list:${i}:id" ${dcfilePath})

    if [[ $dcId == "20003" ]]; then
        dcName="91Helper"
    fi
    #修改版本号
    /usr/libexec/PlistBuddy -c "set itemIndex ${i}" "${dcfilePath}"

    #删除以前的签名
    rm -r "${bundle_path}/_CodeSignature" "${bundle_path}/CodeResources" 2> /dev/null | true

    #替换provision
    cp "${project_path}/SuningEMallDistribution.mobileprovision" "${bundle_path}/embedded.mobileprovision"

    #重新签名
    /usr/bin/codesign -f -s "${rightDistributionSign}" --resource-rules "${bundle_path}/ResourceRules.plist" "${bundle_path}"

    #ipa名称
    ipa_name_p="${result_path}/${target_name}_${bundleShortVersion}_${dcName}_${dcId}.ipa"

    #压缩zip
    zip -r "${ipa_name_p}" "${payload}"
done



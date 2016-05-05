//
//  FileStreame.h
//  TCWeiBoSDKDemo
//
//  Created by 北京市海淀区 guosong on 12-8-30.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileStreame : NSObject {
    
}


// 创建 路径
+ (NSString *)createDirectory:(NSString *)strPath;

// 删除 路径
+ (BOOL)deleteDirectory:(NSString *)strPath;

// 创建 文件 
+ (NSString *)createFile:(NSString *)strPath;


// 获取用户路径
+ (NSString *)getUserDirectory:(NSString *)userName;


// 获取 Head 路径
+ (NSString *)getHeadDirectory:(NSString *)userName;

// 获取 Head 文件名
+ (NSString *)getHeadName:(NSString *)strHeadURL;

// 获取 Head path
+ (NSString *)getHeadPath:(NSString *)userName headURL:(NSString *)headURL;

// 存储 Head 到文件
+ (BOOL)saveHeadToFile:(UIImage *)image filePath:(NSString*)strFilePath;



// 获取 互听好友 Path  
+ (NSString *)getMutualFriendPath:(NSString *)userName;

// 获取 最近联系人 path
+ (NSString *)getIntimateFriendPath:(NSString *)userName;

// 获取 话题 path
+ (NSString *)getTopicPath:(NSString *)userName;


@end

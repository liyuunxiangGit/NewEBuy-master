//
//  FileStreame.m
//  TCWeiBoSDKDemo
//
//  Created by 北京市海淀区 guosong on 12-8-30.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import "FileStreame.h"

@implementation FileStreame


// 获取用户路径
+ (NSString *)getUserDirectory:(NSString *)userName {
    
    if (userName == nil || [userName length] <= 0) {
        
        return nil;
    }
    
    NSArray *arrPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [arrPath objectAtIndex:0];
    NSString *userDirectory = [NSString stringWithFormat:@"%@/%@/%@",documentsDirectory,@"TecentMicroBlogSdk",userName];
    
    userDirectory = [FileStreame createDirectory:userDirectory];
    
    return userDirectory;
}


// 创建文件
+ (NSString *)createFile:(NSString *)strPath {
    
    if (strPath == nil || [strPath length] <= 0) {
        
        return nil;
    }
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:strPath]) {
        
        return strPath;
    }
    else {
        
        @try {
            
            NSMutableArray *arrMutualFriend = [NSMutableArray array];
            [arrMutualFriend writeToFile:strPath atomically:YES];
        }
        @catch (NSException * e) {
            
            return nil;
        }
    }
    
    return strPath;
}


// 创建路径
+ (NSString *)createDirectory:(NSString *)strPath {
    
    if (strPath == nil || [strPath length] <= 0) {
        
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:strPath]) {
        
        return strPath;
    }
    else {
        
        @try {
            [[NSFileManager defaultManager]createDirectoryAtPath:strPath 
                                     withIntermediateDirectories:YES 
                                                      attributes:nil 
                                                           error:nil];
        }
        @catch (NSException * e){
            return nil;
        }
    }
    
    return strPath;
}



// 创建文件路径
+ (BOOL) createDirectoryWithPath:(NSString *)strPath {
    
	if (strPath == nil || [strPath length] <= 0) {
		return NO;
	}
	
	@try {
		[[NSFileManager defaultManager]createDirectoryAtPath:strPath 
								 withIntermediateDirectories:YES 
												  attributes:nil 
													   error:nil];
	}
	@catch (NSException * e){
		return NO;
	}
	
	return YES;
}


// 删除文件
+ (BOOL)deleteDirectory:(NSString *)strPath {
    
    if (strPath == nil || [strPath length] <= 0) {
        
        return NO;
    }
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:strPath]) {
        
        return NO;
    }
    
    NSError *error = nil;
    [manager removeItemAtPath:strPath error:&error];
    
    if (error) {
        
        return NO;
    }
    
    
    return YES;
}


#pragma mark 头像 方法

+ (NSString *)getHeadDirectory:(NSString *)userName {
    
    if (userName == nil || [userName length] <= 0) {
        
        return nil;
    }
    
    NSString *userDirectory = [FileStreame getUserDirectory:userName];
    NSString *headDirectory = [NSString stringWithFormat:@"%@/head",userDirectory];
    
    headDirectory = [FileStreame createDirectory:headDirectory];
    
    return headDirectory;
}


// 获取 Head 文件名
+ (NSString *)getHeadName:(NSString *)strHeadURL {
    
	if (strHeadURL == nil || [strHeadURL length] <= 0) {
        
		return nil;	
	}
	
    NSRange range = [strHeadURL rangeOfString:@"/" options:NSBackwardsSearch];
    
	return [NSString stringWithFormat:@"%@",[strHeadURL substringFromIndex:range.location + 1]];
}


// 获取 Head 文件夹 路径
+ (NSString *)getHeadDirectory {
    
	return [NSString stringWithFormat:@"%@/Documents/TecentMicroBlogSdk/Head",NSHomeDirectory()];
}



// 获取 Head path 
+ (NSString *)getHeadPath:(NSString *)userName headURL:(NSString *)headURL {
    
	if (userName == nil || [userName length] <= 0) {
		return nil;
	}	
    
	if (headURL == nil || [headURL length] <= 0) {
		return nil;
	}
	
    NSString *strHeadDirectory = [FileStreame getHeadDirectory:userName];
    NSString *strHeadName = [FileStreame getHeadName:headURL];
    NSString *strHeadFile = [NSString stringWithFormat:@"%@/%@",strHeadDirectory,strHeadName];
    
	return strHeadFile;
}

// 存储 Head 到文件
+ (BOOL)saveHeadToFile:(UIImage *)image filePath:(NSString*)strFilePath {
    
	if (image == nil) {
		return NO;
	}
	
	if (strFilePath == nil || [strFilePath length] <= 0) {
		return NO;
	}
    
	@try {
		NSFileManager *filemanage = [NSFileManager defaultManager];
		
		if ([filemanage fileExistsAtPath:strFilePath]) {
			[filemanage removeItemAtPath:strFilePath error:nil];
		}
		[filemanage createDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/TecentMicroBlogSdk/Head/cache/", NSHomeDirectory()]
			  withIntermediateDirectories:YES 
							   attributes:nil 
									error:nil];
		NSString *strImageTemp = [NSString stringWithFormat:@"%@temp.jpg", 
								  [NSString stringWithFormat:@"%@/Documents/TecentMicroBlogSdk/Head/cache/", NSHomeDirectory()]];
		
		if ([filemanage fileExistsAtPath:strImageTemp]) {
			[filemanage removeItemAtPath:strImageTemp error:nil];
		}
		
		NSData *imageData = nil;
		NSString *strExt = [strFilePath pathExtension];
		if (strExt == nil) {
			strExt = @"";
		}
		if ([strExt isEqualToString:@"png"]){
			imageData = UIImagePNGRepresentation(image);
		}
		else{
			imageData = UIImageJPEGRepresentation(image, 0); 
			
		}
		
		if ((imageData == nil) || ([imageData length] <= 0)){
			return NO;
		}
		
		if(![imageData writeToFile:strImageTemp atomically:YES]){
			[filemanage removeItemAtPath:strImageTemp error:nil];
			return NO;
		}
		
		if ([filemanage fileExistsAtPath:strImageTemp]){
			[filemanage moveItemAtPath:strImageTemp toPath:strFilePath error:nil];
			return YES;
		}
		
	}
	@catch (NSException * e) {
		return NO;
	}
	return NO;
	
}



#pragma mark 互听好友 方法

+ (NSString *)getMutualFriendPath:(NSString *)userName {
    
    if (userName == nil || [userName length] <= 0) {
        
        return nil;
    }
    
    NSString *userDirectory = [FileStreame getUserDirectory:userName];
    NSString *strPath = [NSString stringWithFormat:@"%@/mutualFriend.plist",userDirectory];
    
    strPath = [FileStreame createFile:strPath];
    
    
    return strPath;
}


#pragma mark 最近联系人 方法

+ (NSString *)getIntimateFriendPath:(NSString *)userName {
    
    if (userName == nil || [userName length] <= 0) {
        
        return nil;
    }
    
    NSString *userDirectory = [FileStreame getUserDirectory:userName];
    NSString *strPath = [NSString stringWithFormat:@"%@/intimateFriend.plist",userDirectory];
    
    strPath = [FileStreame createFile:strPath];
    
    return strPath;

}


#pragma mark 话题

// 获取 话题 path
+ (NSString *)getTopicPath:(NSString *)userName {
    
    if (userName == nil || [userName length] <= 0) {
        
        return nil;
    }
    
    NSString *userDirectory = [FileStreame getUserDirectory:userName];
    NSString *strPath = [NSString stringWithFormat:@"%@/topic.plist",userDirectory];
    
    strPath = [FileStreame createFile:strPath];
    
    return strPath;
    
}


@end

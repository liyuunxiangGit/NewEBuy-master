//
//  PathConstant.h
//  reader4iphone
//
//  Created by 刘坤 on 12-7-3.
//  Copyright (c) 2012年 suning. All rights reserved.
//

static NSString *_DatabaseDirectory;

static inline NSString* DatabaseDirectory() {
	if(!_DatabaseDirectory) {
		NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		_DatabaseDirectory = [[[cachesDirectory stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:@"Database"] copy];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = YES;
        BOOL isExist = [fileManager fileExistsAtPath:_DatabaseDirectory isDirectory:&isDir];
        if (!isExist) 
        {
            [fileManager createDirectoryAtPath:_DatabaseDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
        }
	}
	
	return _DatabaseDirectory;
}


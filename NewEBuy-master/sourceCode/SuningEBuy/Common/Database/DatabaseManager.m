//
//  DatabaseManager.m
//  SuningFutureStore
//
//  Created by Wang Jia on 10-10-31.
//  Copyright 2010 IBM. All rights reserved.
//

#import "DatabaseManager.h"
#include <sqlite3.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

@interface DatabaseManager ()


@end

/*********************************************************************/

@implementation DatabaseManager

@synthesize writablePath = _writablePath;

@synthesize  databaseQueue = _databaseQueue;

static DatabaseManager *manager = nil;

- (id)init{
	if(self = [super init]){
        
		_isDataBaseOpened = NO;
        
        [self setWritablePath:[DatabaseDirectory() stringByAppendingPathComponent:kDatabaseFileName]];
        
		[self openDataBase];
	}
	return self;
}

- (BOOL)isDatabaseOpened
{
    return _isDataBaseOpened;
}

- (void)openDataBase{
    
	_databaseQueue = [FMDatabaseQueue databaseQueueWithPath:self.writablePath];
    
    if (_databaseQueue == 0x00) {
        _isDataBaseOpened = NO;
        return;
    }
    
    _isDataBaseOpened = YES;
    DLog(@"Open Database OK!");
    [_databaseQueue inDatabase:^(FMDatabase *db){
        [db setShouldCacheStatements:YES];
    }];
}

- (void)closeDataBase{
	if(!_isDataBaseOpened){
		DLog(@"数据库已打开，或打开失败。请求关闭数据库失败。");
		return;
	}
	
	[_databaseQueue close];
	_isDataBaseOpened = NO;
	DLog(@"关闭数据库成功。");
}

+ (DatabaseManager*)currentManager {
    
	@synchronized(self) {
        
		if(!manager) {
            
			manager = [[DatabaseManager alloc] init];
			
		}
	}
	
	return manager;
}

+ (void)releaseManager{
    
    if(manager){
        
        manager = nil;
    }
}


-(void)dealloc{
	
	[self closeDataBase];
}

@end

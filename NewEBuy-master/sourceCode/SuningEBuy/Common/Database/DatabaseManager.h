//
//  DatabaseManager.h
//  SuningFutureStore
//
//  Created by Wang Jia on 10-10-31.
//  Copyright 2010 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabaseQueue;
@interface DatabaseManager : NSObject 
{
	BOOL _isInitializeSuccess;
    
	BOOL _isDataBaseOpened;
	
	NSString *_writablePath;
    
    FMDatabaseQueue *_databaseQueue;
}

@property (nonatomic, copy) NSString *writablePath;

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

+ (DatabaseManager*)currentManager;

- (BOOL)isDatabaseOpened;

- (void)openDataBase;

- (void)closeDataBase;


+ (void)releaseManager;


@end

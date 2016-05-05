//
//  DAO.h
//  SuningEBuy
//
//  Created by liukun on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"

@interface DAO : NSObject {
@protected
    FMDatabaseQueue	*_databaseQueue;
}
       
@end

@interface DAO()

@property (nonatomic,strong) FMDatabaseQueue *databaseQueue;

+ (void)createTablesNeeded;

@end


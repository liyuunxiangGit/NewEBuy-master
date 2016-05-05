//
//  SNABContact.h
//  SuningEBuy
//
//  Created by snping on 14-9-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface SNABContact : NSObject

{
	ABRecordRef record;
}

@property (nonatomic, readonly) NSString *compositeName; //姓名
@property (nonatomic, readonly) NSArray  *phoneArray;//所有的电话 @[@"13402911111",@"13402922222"]
@property (nonatomic, readonly) NSString *phonenumbers;//@"13402911111#13402922222"

+ (id) contactWithRecord: (ABRecordRef) record;

@end

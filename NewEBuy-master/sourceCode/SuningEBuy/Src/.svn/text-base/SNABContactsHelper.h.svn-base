//
//  SNABContactsHelper.h
//  SuningEBuy
//
//  Created by snping on 14-9-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface SNABContactsHelper : NSObject

+ (ABAddressBookRef) addressBook;

+ (NSArray *) contacts;//array of instances of SNABContact

+ (NSArray *) contactsPhoneNumbers;//array of such as @"13402911111#13402922222"

+ (NSArray *) contactsMatchingPhone: (NSString *) number;//array of instance of SNABContact that contains the number

+ (NSArray *) namesMatchingPhone: (NSString *) number;//array of string that representatives compositeName of instance of SNABContact

@end

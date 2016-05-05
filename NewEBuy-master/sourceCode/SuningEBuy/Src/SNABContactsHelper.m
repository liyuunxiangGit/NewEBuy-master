//
//  SNABContactsHelper.m
//  SuningEBuy
//
//  Created by snping on 14-9-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNABContactsHelper.h"
#import "SNABContact.h"


@implementation SNABContactsHelper

+ (ABAddressBookRef) addressBook
{
	ABAddressBookRef addressBook = nil;
    if (IOS6_OR_LATER)
    {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_semaphore_signal(sema);
                                                 });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    else
    {
        addressBook = ABAddressBookCreate();
    }
	return  addressBook;
}

+ (NSArray *) contacts
{
	ABAddressBookRef addressBook = [self addressBook];
	NSArray *thePeople = (NSArray *)CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
    //CFRelease(addressBook);
    
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:thePeople.count];
	for (id person in thePeople)
		[array addObject:[SNABContact contactWithRecord:(ABRecordRef)person]];
	return array;
}

+ (NSArray *) contactsPhoneNumbers
{
    NSArray * contacts =[ self contacts];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:contacts.count];
    for (SNABContact *contact in contacts) {
        [array addObject:contact.phonenumbers];
      }
    return array;
}

+ (NSArray *) contactsMatchingPhone: (NSString *) number
{
	NSPredicate *pred;
	NSArray *contacts = [SNABContactsHelper contacts];
	pred = [NSPredicate predicateWithFormat:@"phonenumbers contains[cd] %@", number];
	return [contacts filteredArrayUsingPredicate:pred];
}

+ (NSArray *) namesMatchingPhone: (NSString *) number
{
    NSArray *contacts = [self contactsMatchingPhone:number];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:contacts.count];
    for (SNABContact *contact in contacts) {
        [array addObject:contact.compositeName];
    }
    return array;
}

@end


//
//  SaveSuningUUID.m
//  SuningOfficeBI
//
//  Created by xy ma on 11-12-19.
//  Copyright (c) 2011年 sn. All rights reserved.
//

#import "SaveSuningUUID.h"

@implementation SaveSuningUUID


@synthesize uuid =_uuid;

- (id)init {
    
	self = [super init];
	if (self) {
		_uuid = NULL;
		//return self;
	}
    
	return self;
}
- (void)dealloc 
{
	
    TT_RELEASE_SAFELY(_uuid);
    
    [super dealloc];
	
}

+ (id)shareInstance {
	static id obj = nil;
	if( nil == obj ) {
		obj = [[self alloc] init];
	}
    
    
    
	return obj;
}

- (NSString *)saveIdentifier:(NSString *)appName {
    
    
    //从userdefaults中读取uuid
	//NSUserDefaults *handler = [NSUserDefaults standardUserDefaults];
    //	NSString *uuidValue =  [handler objectForKey:appName];
    
    
    //从keychain中读取uuid
    NSString *uuidValue = [self getSecureValueForKey:appName];
    
    self.uuid = [NSString stringWithFormat:@"%@", uuidValue];
    
    //DLog(@"uuid is %@\n",_uuid);
    
    //DLog(@"uuid length is %d\n",[_uuid length]);
    
	if (NULL == self.uuid || 48 > [self.uuid length]) {
        
		CFUUIDRef cfuuid = CFUUIDCreate(NULL);
		CFStringRef uuidStr = CFUUIDCreateString(NULL, cfuuid);
        
		NSString *result = [NSString stringWithFormat:@"%@-%@", @"Suning-uuid", uuidStr];
        
        DLog(@"result is %@\n",result);
        
		CFRelease(uuidStr);
		CFRelease(cfuuid);
        
        self.uuid = result;
        
        //存储到keychain中，
        [self storeSecureValue:result forKey:appName];
        //存储到userdefaults中
		//[handler setObject:self.uuid forKey:appName];
		//[handler synchronize];
	}
    
	return _uuid;
}

// -------------------------------------------------------------------------
-(NSString *)getSecureValueForKey:(NSString *)key {
    /*
     
     Return a value from the keychain
     
     */
    
    // Retrieve a value from the keychain
    NSDictionary *result;
    NSArray *keys = [[[NSArray alloc] initWithObjects: (NSString *) kSecClass, kSecAttrAccount, kSecReturnAttributes, nil] autorelease];
    NSArray *objects = [[[NSArray alloc] initWithObjects: (NSString *) kSecClassGenericPassword, key, kCFBooleanTrue, nil] autorelease];
    NSDictionary *query = [[NSDictionary alloc] initWithObjects: objects forKeys: keys];
    
    // Check if the value was found
    OSStatus status = SecItemCopyMatching((CFDictionaryRef) query, (CFTypeRef *) &result);
    [query release];
    if (status != noErr) {
        // Value not found
        return nil;
    } else {
        // Value was found so return it
        NSString *value = [[(NSString *) [result objectForKey: (NSString *) kSecAttrGeneric] copy]autorelease];
        
        //DLog(@"responseString by getSecureValueForKey reback is %@",value);
        
        [result release];
        return value;
    }
}




// -------------------------------------------------------------------------
-(BOOL)storeSecureValue:(NSString *)value forKey:(NSString *)key {
    /*
     
     Store a value in the keychain
     
     */
    
    // Get the existing value for the key
    NSString *existingValue = [self getSecureValueForKey:key];
    
    // Check if a value already exists for this key
    OSStatus status;
    if (existingValue) {
        // Value already exists, so update it
        NSArray *keys = [[[NSArray alloc] initWithObjects: (NSString *) kSecClass, kSecAttrAccount, nil] autorelease];
        NSArray *objects = [[[NSArray alloc] initWithObjects: (NSString *) kSecClassGenericPassword, key, nil] autorelease];
        NSDictionary *query = [[[NSDictionary alloc] initWithObjects: objects forKeys: keys] autorelease];
        status = SecItemUpdate((CFDictionaryRef) query, (CFDictionaryRef) [NSDictionary dictionaryWithObject:value forKey: (NSString *) kSecAttrGeneric]);
    } else {
        // Value does not exist, so add it
        NSArray *keys = [[[NSArray alloc] initWithObjects: (NSString *) kSecClass, kSecAttrAccount, kSecAttrGeneric, nil] autorelease];
        NSArray *objects = [[[NSArray alloc] initWithObjects: (NSString *) kSecClassGenericPassword, key, value, nil] autorelease];
        NSDictionary *query = [[[NSDictionary alloc] initWithObjects: objects forKeys: keys] autorelease];
        status = SecItemAdd((CFDictionaryRef) query, NULL);
    }
    
    // Check if the value was stored
    if (status != noErr) {
        // Value was not stored
        return NO;
    } else {
        // Value was stored
        return YES;
    }
}



@end


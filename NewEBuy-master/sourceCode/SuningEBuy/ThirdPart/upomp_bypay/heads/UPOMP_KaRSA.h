//
//  KaRSA.h
//  mylibs
//
//  Created by pei xunjun on 11-11-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPOMP_KaRSA : NSObject {

}
-(BOOL)setPublicKey:(NSData*)publicKeyData publicKeyIdentifier:(NSString*)PKidentifier;
-(BOOL)getPublicKey:(NSString*)PKidentifier;
-(BOOL)deletePublicKey:(NSString*)PKidentifier;
- (NSData *)encode:(NSData *)strData usingKey:(SecKeyRef)key;
@property(nonatomic,readonly)SecKeyRef keyRef;
@end

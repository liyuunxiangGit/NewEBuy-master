//
//  BaseHttpDTO.h
//  SuningEMall
//
//  Created by Wang Jia on 11-1-9.
//  Copyright 2011 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpConstant.h"

@interface BaseHttpDTO : NSObject {

}

-(void)encodeFromDictionary:(NSDictionary *)dic;

@end

//
//  UPOMP_ViewCenter.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPOMP_ViewController.h"

@interface UPOMP_ViewCenter : NSObject{
    
}
-(UPOMP_ViewController*)getUIByID:(int)vID upomp:(UPOMP*)obj;
@end

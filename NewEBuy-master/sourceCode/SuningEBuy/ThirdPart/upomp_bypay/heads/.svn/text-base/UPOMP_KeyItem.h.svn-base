//
//  UPOMP_KeyItem.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_KeyBoardView.h"
@class UPOMP;

@interface UPOMP_KeyItem : NSObject{
    CGRect frame;
	NSString *value;
    NSString *otherValue;
	UPOMP_KeyBoardView *keyBoard;
	NSString *imageName;
	BOOL isSelect;
    UPOMP *upomp;
}
- (id) initWithFrame:(CGRect)rect keyboard:(UPOMP_KeyBoardView*)kboard value:(NSString*)str imageName:(NSString*)imgName upomp:(UPOMP*)obj;
- (void)draw;
@property(nonatomic,retain) NSString *value;
@property(nonatomic,retain)NSString *otherValue;
@property BOOL isSelect;
@end

//
//  UPOMP_CellViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UPOMP;

@interface UPOMP_CellViewController : UIViewController{
    UIButton *bgButton;
    UILabel *titelLabel;
    UPOMP *upomp;
    BOOL bgSelect;
    NSIndexPath *myPath;
    BOOL isComplexityCheck;
    BOOL isScoll;
    BOOL isNoCheck;
    BOOL isAnimated;
    BOOL last;
}
-(void)bgSelect:(BOOL)bo;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil upomp:(UPOMP*)obj;
-(NSString*)checkFinish;
-(NSString*)getTitel;
-(NSString*)getValue;
-(void)restText;
-(void)setIndex:(NSIndexPath*)path;
-(NSIndexPath*)getIndexPath;
-(void)noSelect;
-(void)select;
-(void)selectAct;
-(void)setKeyReturnType:(BOOL)isLast;
-(NSString*)getKey;
-(NSString*)getCompareText;
@property BOOL isNoCheck;
@property BOOL isAnimated;
@property BOOL isComplexityCheck;
@end

//
//  UPOMP_KeyBoardView.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "UPOMP_KeyBoardBgView.h"
@class UPOMP;

@protocol UPOMP_KeyBoardViewDelegate
-(void)okbuttonAction;
-(void)keyAction:(NSString*)text;
@end

@interface UPOMP_KeyBoardView : UIView{
    UPOMP *upomp;
    UPOMP_KeyBoardBgView *keyBoardBG;
    NSMutableArray *drawKeys;
    NSMutableArray *keys;
    int selectMode;
    BOOL isBig;
    BOOL isUP;
    BOOL isChangeKey;
    UIButton *numButton;
    UIButton *textButton;
    UIButton *otherButton;
    UIButton *okButton;
    id <UPOMP_KeyBoardViewDelegate> delegate;
}
- (id)initWithUPOMP:(UPOMP*)obj;
-(void)keyBoardUP;
-(void)keyBoardDown;
-(void)playSound;
-(void)setKeyReturnType:(BOOL)isLast;
-(void)numOnly;
@property(nonatomic,readonly)NSMutableArray *drawKeys;
@property int selectMode;
@property BOOL isChangeKey;
@property BOOL isBig;
@property (nonatomic, assign) id <UPOMP_KeyBoardViewDelegate> delegate;
@end

//
//  MainViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_ViewController.h"
#import "UPOMP_LoadingViewController.h"
#import "UPOMP_ErrorInfoViewController.h"
#import "UPOMP_ViewCenter.h"
#import "UPOMP_CardInfoViewController.h"
@class UPOMP;

@protocol MoreButtonDelegate<NSObject>
@required
-(void)moreButtonAct:(BOOL)b;
@end

@interface UPOMP_MainViewController : UIViewController{
    IBOutlet UIImageView *naBar;
    IBOutlet UIView *mainView;
    UPOMP *upomp;
    UPOMP_ViewController *viewController;
    UPOMP_ViewController *tempviewController;
    UPOMP_LoadingViewController *loadingView;
    UPOMP_ErrorInfoViewController *errorInfoView;
    UPOMP_CardInfoViewController *cardInfoView;
    NSMutableArray *viewIDArray;
    UPOMP_ViewCenter *viewCenter;
    int viewID;
    
    IBOutlet UITableViewCell* merchantNameCell;
    IBOutlet UILabel* merchantNameText;
    IBOutlet UILabel* merchantNameValue;
    IBOutlet UIImageView *merchantNameBG;
    IBOutlet UIView *merchantNameLine;
    
    IBOutlet UITableViewCell* merchantAmtCell;
    IBOutlet UILabel* merchantAmtText;
    IBOutlet UILabel* merchantAmtValue;
    IBOutlet UIImageView *merchantAmtBG;
    IBOutlet UIView *merchantAmtLine;
    
    IBOutlet UITableViewCell* merchantOrderIDCell;
    IBOutlet UILabel* merchantOrderIDText;
    IBOutlet UILabel* merchantOrderIDValue;
    IBOutlet UIImageView *merchantOrderIDBG;
    IBOutlet UIView *merchantOrderIDLine;
    
    IBOutlet UITableViewCell* merchantOrderTimeCell;
    IBOutlet UILabel* merchantOrderTimeText;
    IBOutlet UILabel* merchantOrderTimeValue;
    IBOutlet UIImageView *merchantOrderTimeBG;
    IBOutlet UIView *merchantOrderTimeLine;
    
    IBOutlet UITableViewCell* merchantOrderDescCell;
    IBOutlet UILabel* merchantOrderDescText;
    IBOutlet UILabel* merchantOrderDescValue;
    IBOutlet UIImageView *merchantOrderDescBG;
    
    IBOutlet UITableViewCell *topCell;
    IBOutlet UIImageView *topBG;
    
    IBOutlet UITableViewCell *bottomCell;
    IBOutlet UIImageView *bottomBG;
    
    IBOutlet UIButton *moreButton;
    
    NSMutableArray *orderInfoArray;
    
    BOOL isMoreInfo;
    BOOL isAnimation;
    
//    int loginCountDownIndex;
    NSTimer *timer;
//    NSTimer *loginTimer;
    NSTimer  *addCardTimer;
    BOOL timerRun;
//    BOOL loginTimerRun;
    BOOL addCardTimerRun;
    UIButton *titelButton;
}
-(BOOL)cardinfoClose;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil upomp:(UPOMP*)obj;
-(void)setToolBar:(int)y;
-(void)showToolBar;
-(void)downToolBar;
-(void)showTimeOver;
-(void)showOtherlogin:(NSString*)str;
-(void)addLoadingViewByLoadingType:(int)type;
-(void)removeLoadingView;
-(void)changeView:(int)vID;
-(void)replaceView:(int)vID;
-(void)backTo:(int)vID;
-(void)back;
-(void)animationMainView:(BOOL)isRight;
-(void)addTitelButton:(UIButton*)button;
-(void)addMoreButton:(UIView*)addView;
-(void)willRe;
-(void)timerStart;
//-(void)loginTimerStart;
-(void)timerOver;
//-(void)loginTimerOver;
-(void)addCardTimerStart;
-(void)addCardTimerOver;
-(void)titleShow;
-(void)showCardInfo:(BOOL)isDate;
- (NSInteger)orderInfoNumberOfRowsInSection;
- (NSInteger)orderInfoHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)orderInfoCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setErrorInfo:(NSString*)info;
- (void)setSelectInfo:(NSString*)info backButtonStr:(NSString*)bStr okButtonStr:(NSString*)oStr type:(int)type;
-(IBAction)moreAct:(id)sender;
@property(nonatomic,retain)UPOMP_ViewController *viewController;
@property BOOL isPayLogin;
@property BOOL timerRun;
@property BOOL loginTimerRun;
@property BOOL addCardTimerRun;
@property (nonatomic, assign) id <MoreButtonDelegate> moreButtonDelegate;
@end

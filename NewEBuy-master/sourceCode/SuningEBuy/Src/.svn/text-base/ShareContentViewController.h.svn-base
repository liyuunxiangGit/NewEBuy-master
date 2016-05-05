//
//  ShareContentViewController.h
//  SuningEBuy
//
//  Created by lanfeng on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "ChooseShareWayViewController.h"


@protocol ShareContentViewControllerDelegate <NSObject>
@optional
- (void)shareContentToSNS:(NSString *)content;
@end



@interface ShareContentViewController : CommonViewController<UITableViewDelegate, UITableViewDataSource,EGOImageViewDelegate,EGOImageViewExDelegate,UITextViewDelegate>{
    
    UINavigationBar *_navigationBar;
    
    NSString           *_getUserInfoURL;
    
    UIImage         *_image;
    
    id <ShareContentViewControllerDelegate> __weak _shareContentViewControllerDelegate;
    
    NSString        *_nickname;
    
    NSString        *_shareContentString;
    SNShareType  _shareType;
    
}




@property (nonatomic,strong) UINavigationBar *navigationBar;
@property (nonatomic,strong) UIView *nicknameView;
@property (nonatomic,strong) UITextView *shareContent;
@property (nonatomic,strong) UILabel *nicknamelabel;
@property (nonatomic, weak) id <ShareContentViewControllerDelegate> shareContentViewControllerDelegate;
@property (nonatomic,copy)   NSString *shareContentString;
@property (nonatomic,copy)  NSString    *nickName;
@property (nonatomic,strong)  UIImage   *image;
@property (nonatomic,strong)  NSURL     *imageURL;

@property (nonatomic,assign) SNShareType shareType;

- (id)initWithContent:(NSString *)text image:(UIImage *)image shareType:(SNShareType) shareType;



@end

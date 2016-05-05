//
//  CheckUpdateCommand.h
//  SuningEBuy
//
//  Created by  liukun on 12-11-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "Command.h"

#define kSystemVersionKey       @"iPhone"
#define kForceUpdateSwithKey    @"iPhoneUpdate"
#define kGrayUpdateSwithKey     @"Gray_Ios"
#define kUpdateVersionKey       @"switchValue"
#define kUpdateTitleKey         @"switchTitle"
#define kUpdateContentKey       @"switchContent"
#define kUpdateDetailKey        @"switchDetail"


typedef enum {
    AutoCheck,       //自动检查更新
    ManualCleck      //手动检查更新
}CheckUpdateMode;

@interface CheckUpdateCommand : Command
{
    @private
    CheckUpdateMode _mode;
}

@property(nonatomic)BOOL needUpdate;   //20140107新界面  手动检测时告诉界面要不要更新  暂定
- (id)initWithCheckUpdateMode:(CheckUpdateMode)mode;

+ (BOOL)autoChecked;
@end

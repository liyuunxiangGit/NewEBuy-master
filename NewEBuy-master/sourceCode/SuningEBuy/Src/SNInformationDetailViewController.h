//
//  SNInformationDetailViewController.h
//  SuningEBuy
//
//  Created by xingxianping on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "SNInformationService.h"


@interface SNInformationDetailViewController : CommonViewController<InformationServiceDelegate>
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) EGOImageViewEx *image;
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) UIButton *activityBtn;
@property (nonatomic,strong) UIScrollView *contentView;
@property (nonatomic,strong) UILabel *sourceLbl;

@property (nonatomic,strong) SNInformationService *informationService;

- (id)initWithInfoId:(NSString *)theInfoId andsize:(NSString *)size;
@end

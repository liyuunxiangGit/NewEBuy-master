//
//  ServiceDetailListInforCell.h
//  SuningEBuy
//
//  Created by wei xie on 12-9-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kItemText    @"itemText"
#define kItemDate    @"itemDate"
#define kItemTime    @"itemTime"

#import "ServiceDetailInfoDTO.h"
#import "OHAttributedLabel.h"
@interface ServiceDetailListInforCell : UITableViewCell<UITextViewDelegate,UIActionSheetDelegate,UIWebViewDelegate>{
    
}

@property (nonatomic, strong) ServiceDetailInfoDTO   *listDto;

//@property (nonatomic, strong) UILabel               *conLabel;

//@property (nonatomic, strong) UITextView           *conLabel;

@property (nonatomic, strong) OHAttributedLabel      *conLabel1;

@property (nonatomic, strong) UIWebView           *conLabel;

@property (nonatomic, strong) UILabel               *saleLabel;

@property (nonatomic, strong) UILabel               *timeLabel;

@property (nonatomic, strong) UIImageView          *iconImg;

@property (nonatomic, strong) UIImageView          *timeLine;

@property (nonatomic, strong) UIImageView          *timePoint;

//@property (nonatomic,strong) UIImageView           *backView;

@property (nonatomic, strong) NSString             *telephoneNmber;

@property (nonatomic, strong) UIImageView          *timeLineGray;


- (id)initWithReuseIndetifier:(NSString *)reuseIndetifier;

- (void)setDetailListCellContent:(ServiceDetailInfoDTO *)detailListDto;

- (void)setDetailListCellContentForIos7:(ServiceDetailInfoDTO *)detailListDto;

+(float)cellHeight:(NSString *)trackStr;

+(float)timeLabelHight;

+(float)trackHeight:(NSString *)trackStr;
@end

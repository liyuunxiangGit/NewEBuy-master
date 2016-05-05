//
//  ProductConsultantCell.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-24.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProductConsultantDTO.h"

#import "productToolClass.h"

@interface ProductConsultantCell : UITableViewCell
{
    ProductConsultantDTO      *_item;
    
    /* 咨询人 */
    UILabel                   *_nameLabel; 
    
     /* 咨询时间 */
    UILabel                   *_timeLabel;
    
     /* 咨询内容 */
    UILabel                   *_contentLabel;
    
     /* 回复人 */
    UILabel                   *_answerLabel;
    
     /* 回复内容 */
    UILabel                   *_answerContentLabel;
}

@property (nonatomic, strong) UILabel  *nameLabel;

@property (nonatomic, strong)UILabel   *timeLabel;

@property (nonatomic ,strong)UILabel   *contentLabel;

@property (nonatomic ,strong)UILabel   *answerLabel;

@property (nonatomic ,strong)UILabel   *answerContentLabel;

+ (CGFloat)height:(ProductConsultantDTO *)item;

- (void)setItem:(ProductConsultantDTO *)item;

@end

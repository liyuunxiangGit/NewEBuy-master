//
//  GBOrderShopInfo.h
//  SuningEBuy
//
//  Created by 王 漫 on 13-3-6.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCellEx.h"
#import "GBShopDTO.h"
#import "productToolClass.h"
#define kGBOrderShopInfoCell_name_font  [UIFont boldSystemFontOfSize:16]
#define kGBOrderShopInfoCell_name_width 280
#define kGBOrderShopInfoCell_label_font  [UIFont systemFontOfSize:14]
#define kGBOrderShopInfoCell_label_width 280
#define kGBOrderShopInfoCell_telephone_width 220


@interface GBOrderShopInfoCell : UITableViewCellEx
{
    GBShopDTO *_item;
}
@property (nonatomic,copy)GBShopDTO *item;
@property (nonatomic,strong) UILabel *shopNameLbl;
@property (nonatomic,strong)UILabel *areaLbl;
@property (nonatomic, strong)UILabel *addressLbl;
@property (nonatomic,strong)UILabel *telLbl;
@property (nonatomic ,strong)UIButton *callBtn;
@property  (nonatomic, strong)UIImageView *seperatorView;
@property (nonatomic,retain) UIImageView *lineView;

- (void)setItem:(GBShopDTO *)item;
+(CGFloat)height:(GBShopDTO *)item;
@end

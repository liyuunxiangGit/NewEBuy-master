//
//  ShopCartPromotionView.m
//  SuningEBuy
//
//  Created by  liukun on 13-8-29.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopCartPromotionView.h"

#define kSPFont     [UIFont systemFontOfSize:14.0f]
#define kSPMargin   (10.0f)

@interface ShopCartPromotionView()

@property (nonatomic, strong) NSArray *promotionArray;

@end

/*********************************************************************/

@implementation ShopCartPromotionView

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 40);
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setPromotionDesc:(NSString *)desc
{
    if (_promotionDesc != desc)
    {
        _promotionDesc = desc;
        
        self.promotionArray = [ShopCartPromotionView parseArrayFromDesc:_promotionDesc];
        
        
        [self removeAllSubviews];
        
        [self addSubview:self.titleLbl];
        
        CGFloat lineHeight = kSPFont.lineHeight;
        CGFloat top = self.titleLbl.bottom + kSPMargin;
        for (NSString *str in self.promotionArray)
        {
            UIImageView *imgView = [[UIImageView alloc] init];
            imgView.frame = CGRectMake(10, top-(20-lineHeight)/2, 20, 20);
            imgView.image = [UIImage imageNamed:@"productDetail_Cuxiao.png"];
            [self addSubview:imgView];
            
            UILabel *_label_temp = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+10, top, 300-imgView.right, lineHeight)];
            _label_temp.backgroundColor = [UIColor clearColor];
            _label_temp.font = kSPFont;
            _label_temp.textColor = [UIColor orange_Light_Color];
            _label_temp.textAlignment = NSTextAlignmentLeft;
            _label_temp.text = str;
            [self addSubview:_label_temp];
            top = _label_temp.bottom + kSPMargin;
        }
        
        self.height = top;
    }
}

+ (NSArray *)parseArrayFromDesc:(NSString *)promotionDesc
{
    NSArray *textArr = [promotionDesc componentsSeparatedByString:@"；"];
    NSMutableArray *resultArr = [textArr mutableCopy];
    [textArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *str = (NSString *)obj;
        if (str.trim.length == 0) {
            [resultArr removeObject:str];
        }
    }];
    return resultArr;
}

+ (CGFloat)height:(NSString *)promotionDesc
{
    NSInteger lineCount = [self parseArrayFromDesc:promotionDesc].count;
    CGFloat lineHeight = kSPFont.lineHeight;
    return (lineCount + 1) * (lineHeight + kSPMargin);
}


- (UILabel *)titleLbl
{
    if (!_titleLbl)
    {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.frame = CGRectMake(10, 0, 120, kSPFont.lineHeight);
        _titleLbl.textAlignment = NSTextAlignmentLeft;
        _titleLbl.textColor = [UIColor dark_Gray_Color];
        _titleLbl.backgroundColor = [UIColor clearColor];
        _titleLbl.font = kSPFont;
        _titleLbl.text = L(@"SCHasParticipatedInPreferential");
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}


@end

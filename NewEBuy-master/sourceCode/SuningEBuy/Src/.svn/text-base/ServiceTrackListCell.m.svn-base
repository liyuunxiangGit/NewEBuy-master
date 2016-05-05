//
//  ServiceTrackListCell.m
//  SuningEBuy
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ServiceTrackListCell.h"
#import "ServiceQueryDTO.h"
#import "ProductUtil.h"

@implementation ServiceTrackListCell

@synthesize ProductNameInfoLabel = _ProductNameInfoLabel;

@synthesize AmountInfoLabel = _AmountInfoLabel;
@synthesize AmountLabel = _AmountLabel;
@synthesize DiliveryModeInfoLabel = _DiliveryModeInfoLabel;
@synthesize DiliveryModeLabel = _DiliveryModeLabel;
@synthesize separateLine = _separateLine;
@synthesize aItem = _aItem;


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.autoresizesSubviews = YES;
        
//        self.backgroundColor = [UIColor cellBackViewColor];
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.iconImageView];
    }
    return  self;
}

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_aItem);
    
    TT_RELEASE_SAFELY(_ProductNameInfoLabel);
    TT_RELEASE_SAFELY(_iconImageView);
    TT_RELEASE_SAFELY(_AmountLabel);
    TT_RELEASE_SAFELY(_AmountInfoLabel);
    TT_RELEASE_SAFELY(_DiliveryModeLabel);
    TT_RELEASE_SAFELY(_DiliveryModeInfoLabel);
    TT_RELEASE_SAFELY(_separateLine);
    
}

- (UIImageView *)separateLine
{
    if (!_separateLine) {
        _separateLine = [[UIImageView alloc] init];
        _separateLine.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
        [self.contentView addSubview:_separateLine];
    }
    return _separateLine;
}

- (UILabel *)ProductNameInfoLabel{
    
    if (!_ProductNameInfoLabel) {
        
        _ProductNameInfoLabel = [[UILabel alloc] init];
       
        _ProductNameInfoLabel.backgroundColor = [UIColor clearColor];
        
        _ProductNameInfoLabel.textAlignment = UITextAlignmentLeft;
        
        _ProductNameInfoLabel.numberOfLines = 0;
        
        _ProductNameInfoLabel.lineBreakMode = UILineBreakModeWordWrap;
        
//        [_ProductNameInfoLabel sizeToFit];
        
        _ProductNameInfoLabel.font = [UIFont systemFontOfSize:13.f];
        
        _ProductNameInfoLabel.textColor = [UIColor blackColor];// [UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1];
        
        _ProductNameInfoLabel.tag = 6;
        
//        [_ProductNameInfoLabel setAdjustsFontSizeToFitWidth:YES];
        
        [self.contentView addSubview:_ProductNameInfoLabel];
    }
    
    return _ProductNameInfoLabel;
}

- (UILabel *)DiliveryModeLabel{
    
    if (!_DiliveryModeLabel) {
    
        _DiliveryModeLabel = [[UILabel alloc] initWithFrame:CGRectMake(75,55,55,21)];
      
        _DiliveryModeLabel.backgroundColor = [UIColor clearColor];
        
        _DiliveryModeLabel.textAlignment = UITextAlignmentRight;
        
        _DiliveryModeLabel.font = [UIFont systemFontOfSize:12];
        
        _DiliveryModeLabel.textColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
        
        _DiliveryModeLabel.tag = 7;
        
//        [self.contentView addSubview:_DiliveryModeLabel];
    }
    return _DiliveryModeLabel;
}

- (UILabel *)DiliveryModeInfoLabel{
    
    if (!_DiliveryModeInfoLabel) {
        
        _DiliveryModeInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(112,84,150,14)];
       
        _DiliveryModeInfoLabel.backgroundColor = [UIColor clearColor];
        
        _DiliveryModeInfoLabel.textAlignment = UITextAlignmentLeft;
        
        _DiliveryModeInfoLabel.font = [UIFont boldSystemFontOfSize:12];
        
//        _DiliveryModeInfoLabel.textColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
        _DiliveryModeInfoLabel.textColor = [UIColor orange_Red_Color];
        
        _DiliveryModeInfoLabel.tag = 8;
        
        [_DiliveryModeInfoLabel setAdjustsFontSizeToFitWidth:NO];
        
        [self.contentView addSubview:_DiliveryModeInfoLabel];
    }
    return _DiliveryModeInfoLabel;
}

- (UILabel *)AmountLabel{
    
    if (!_AmountLabel) {
       
        _AmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(250,83,33,14)];
        
        _AmountLabel.backgroundColor = [UIColor clearColor];
        
        _AmountLabel.textAlignment = UITextAlignmentRight;
        
        _AmountLabel.font = [UIFont systemFontOfSize:12];
        
        _AmountLabel.textColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
        
        _AmountLabel.tag = 9;
        
        [self.contentView addSubview:_AmountLabel];
    }
    
    return _AmountLabel;
}

- (UILabel *)AmountInfoLabel{
    
    if (!_AmountInfoLabel) {
        
        _AmountInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(283,83,40,14)];
        
        _AmountInfoLabel.backgroundColor = [UIColor clearColor];
        
        _AmountInfoLabel.textAlignment = UITextAlignmentLeft;
        
        _AmountInfoLabel.font = [UIFont systemFontOfSize:12];
        
        _AmountInfoLabel.textColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
        
        _AmountInfoLabel.tag = 10;
        
        [self.contentView addSubview:_AmountInfoLabel];
    }
    return _AmountInfoLabel;
}

-(EGOImageView *)iconImageView{
    
    
    if (!_iconImageView) {
        
        _iconImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(15, 15, 85, 85)];
        _iconImageView.backgroundColor = [UIColor clearColor];
        _iconImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _iconImageView.layer.borderWidth = 0.5f;
        _iconImageView.delegate = self;
    }
    
    return _iconImageView;
}
//- (void)setServiceQueryDto:(OrderItemDTO*)item
- (void)setServiceQueryDto:(ProductListDTO*)item

{
    if (item == nil) {
        
        return;
    }
    if (item != _aItem) {
        
        
        _aItem = item;
        
        UIFont *stringFont = self.ProductNameInfoLabel.font;
        
        CGSize stringSize = [self heightAccordToAmonut:_aItem.productName Font:stringFont label:_ProductNameInfoLabel];
        
        CGRect dateFrame =CGRectMake(112,18,183, stringSize.height);
        
        self.ProductNameInfoLabel.frame = dateFrame;
        
        self.ProductNameInfoLabel.text = _aItem.productName;
        
        self.DiliveryModeInfoLabel.text = [NSString stringWithFormat:@"￥%.2f", [self.aItem.itemPrice floatValue]];
        
        self.AmountLabel.text = L(@"Amount");
        
        NSInteger quantityValue = [_aItem.quantity integerValue];
        
        self.AmountInfoLabel.text = [NSString stringWithFormat:@"  %ld",(long)quantityValue];
        
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg])
        {
            self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:_aItem.productCode
                                                                             size:ProductImageSize160x160];
        }
        else
        {
            self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:_aItem.productCode
                                                                             size:ProductImageSize100x100];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.separateLine.frame = CGRectMake(0, 114, 320, 0.5);
}


//根据字符串得到CGSize
- (CGSize)heightAccordToAmonut:(NSString *)content Font:(UIFont *)contentfont label:(UILabel *)currentLabel
{
    CGSize maximumSize =CGSizeMake(183,MAXFLOAT);
    
    CGSize dateStringSize =[content sizeWithFont:contentfont
                                  constrainedToSize:maximumSize
                                      lineBreakMode:currentLabel.lineBreakMode];
    if (dateStringSize.height > 55) {
        dateStringSize.height = 55;
    }
    return dateStringSize;
}

@end

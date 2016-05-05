//
//  NServiceTrackListCell.m
//  SuningEBuy
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "NServiceTrackListCell.h"
#import "ServiceQueryDTO.h"
#import "ProductUtil.h"

@implementation NServiceTrackListCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.autoresizesSubviews = YES;
        
        self.backgroundColor = [UIColor cellBackViewColor];
        
        [self.contentView addSubview:self.iconImageView];
    }
    
    return  self;
}

-(void)refreshCell:(ProductListDTO *)dto{
    
    if (IsNilOrNull(dto)) {
        return;
    }
    
    
    self.ProductNameInfoLabel.text = dto.productName;
    
    self.DiliveryModeLabel.text = [NSString stringWithFormat:@"%@：",L(@"price")];
    self.DiliveryModeInfoLabel.text = dto.itemPrice;
    
    self.AmountLabel.text = L(@"Amount");
    self.AmountInfoLabel.text = dto.quantity;
    
    
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg])
    {
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto.productCode
                                                                         size:ProductImageSize160x160];
    }
    else
    {
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto.productCode
                                                                         size:ProductImageSize100x100];
    }
    
}

- (UILabel *)ProductNameInfoLabel{
    
    if (!_ProductNameInfoLabel) {
        
        _ProductNameInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(75,5,200,40)];
        
        _ProductNameInfoLabel.backgroundColor = [UIColor clearColor];
        
        _ProductNameInfoLabel.textAlignment = UITextAlignmentLeft;
        
        _ProductNameInfoLabel.numberOfLines = 0;
        
        _ProductNameInfoLabel.font = [UIFont systemFontOfSize:12];
        
        _ProductNameInfoLabel.textColor = [UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1];
        
        _ProductNameInfoLabel.tag = 6;
        
        [_ProductNameInfoLabel setAdjustsFontSizeToFitWidth:NO];
        
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
        
        [self.contentView addSubview:_DiliveryModeLabel];
    }
    return _DiliveryModeLabel;
}

- (UILabel *)DiliveryModeInfoLabel{
    
    if (!_DiliveryModeInfoLabel) {
        
        _DiliveryModeInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(135,55,55,21)];
        
        _DiliveryModeInfoLabel.backgroundColor = [UIColor clearColor];
        
        _DiliveryModeInfoLabel.textAlignment = UITextAlignmentLeft;
        
        _DiliveryModeInfoLabel.font = [UIFont systemFontOfSize:12];
        
        _DiliveryModeInfoLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        
        _DiliveryModeInfoLabel.tag = 8;
        
        [_DiliveryModeInfoLabel setAdjustsFontSizeToFitWidth:NO];
        
        [self.contentView addSubview:_DiliveryModeInfoLabel];
    }
    return _DiliveryModeInfoLabel;
}

- (UILabel *)AmountLabel{
    
    if (!_AmountLabel) {
        
        _AmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(200,55,35,21)];
        
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
        
        _AmountInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(245,55,50,21)];
        
        _AmountInfoLabel.backgroundColor = [UIColor clearColor];
        
        _AmountInfoLabel.textAlignment = UITextAlignmentLeft;
        
        _AmountInfoLabel.font = [UIFont systemFontOfSize:12];
        
        _AmountInfoLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        
        _AmountInfoLabel.tag = 10;
        
        [self.contentView addSubview:_AmountInfoLabel];
    }
    return _AmountInfoLabel;
}

-(EGOImageView *)iconImageView{
    
    
    if (!_iconImageView) {
        
        _iconImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(5, 10, 60, 60)];
        _iconImageView.backgroundColor = [UIColor clearColor];
        _iconImageView.delegate = self;
    }
    
    return _iconImageView;
}



@end

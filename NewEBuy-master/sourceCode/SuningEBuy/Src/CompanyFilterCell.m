//
//  CompanyFilterCell.m
//  SuningEBuy
//
//  Created by shasha on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CompanyFilterCell.h"

#define NameLabel_Width  200
#define Line1_Height     44


@implementation CompanyFilterCell
@synthesize item = _item;
@synthesize companyNameLabel = _companyNameLabel;
@synthesize companyImageView = _companyImageView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)dealloc {
    TT_RELEASE_SAFELY(_item);
    TT_RELEASE_SAFELY(_companyImageView);
    TT_RELEASE_SAFELY(_companyNameLabel);
}


-(void)setItem:(CompanyDTO *)item{

    if (_item != item) {
        
        TT_RELEASE_SAFELY(_item);
        
        _item = item;
        
        self.companyImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://image.suning.cn/images/advertise/hjc123/hkgs516/%@.png",self.item.airCompanyId]];
        
        self.companyNameLabel.text = self.item.airCompanyShortName;
        
        [self setNeedsDisplay];
    }

}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.companyImageView.frame = CGRectMake(15, 11, 22, 22);
    self.companyNameLabel.frame = CGRectMake(self.companyImageView.right+10, 0, 150, 44);
    
}

- (UILabel *)companyNameLabel
{
    if (nil == _companyNameLabel) 
    {
        _companyNameLabel = [[UILabel alloc]init];
        _companyNameLabel.backgroundColor = [UIColor clearColor];
        _companyNameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _companyNameLabel.textAlignment = UITextAlignmentLeft;
        _companyNameLabel.size = CGSizeMake(NameLabel_Width, Line1_Height);
        _companyNameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_companyNameLabel];
    } 
    return _companyNameLabel;
}


- (EGOImageView *)companyImageView{

    if (!_companyImageView) {
        _companyImageView = [[EGOImageView alloc] init];
        [_companyImageView setSize:CGSizeMake(22, 22)];
        _companyImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_companyImageView];
    }
    return _companyImageView;
}


@end

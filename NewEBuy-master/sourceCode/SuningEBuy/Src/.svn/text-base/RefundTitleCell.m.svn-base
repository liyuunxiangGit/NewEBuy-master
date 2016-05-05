//
//  RefundTitleCell.m
//  SuningEBuy
//
//  Created by david on 14-2-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "RefundTitleCell.h"

@interface RefundTitleCell()

@property(nonatomic,strong) UILabel *contentLbl;

@end


@implementation RefundTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
    }
    return self;
}

-(void)refreshCell:(NSString *)content{
    
    self.contentLbl.text = content;
}

#pragma mark -
#pragma mark UIView

-(UILabel *)contentLbl{
    if (_contentLbl == nil) {
        _contentLbl = [[UILabel alloc]init];
        _contentLbl.backgroundColor = [UIColor clearColor];
        _contentLbl.frame = CGRectMake(15, 15, 320-30, 60);
        _contentLbl.font = [UIFont systemFontOfSize:15];
        _contentLbl.numberOfLines = 2;
        [self.contentView addSubview:_contentLbl];
    }
    return _contentLbl;
}

@end

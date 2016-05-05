//
//  PlaneCallPhoneCell.m
//  SuningEBuy
//
//  Created by david on 14-2-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PlaneCallPhoneCell.h"

@interface PlaneCallPhoneCell()

@property(nonatomic,strong) UIView  *whiteBackView;
@property(nonatomic,strong) UILabel *leftLbl;
@property(nonatomic,strong) UILabel *rightLbl;


@end


@implementation PlaneCallPhoneCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.whiteBackView];
        [self.contentView addSubview:self.leftLbl];
        [self.contentView addSubview:self.rightLbl];
    }
    return self;
}

#pragma mark -
#pragma mark UIView
-(UIView *)whiteBackView{
    if (!_whiteBackView) {
        _whiteBackView = [[UIView alloc]init];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        _whiteBackView.frame = CGRectMake(0, 0, 320, 50);
    }
    return _whiteBackView;
}

-(UILabel *)leftLbl{
    
    if (!_leftLbl) {
        _leftLbl = [[UILabel alloc]init];
        _leftLbl.backgroundColor = [UIColor clearColor];
        _leftLbl.font = [UIFont systemFontOfSize:15];
        _leftLbl.frame = CGRectMake(15, 10, 80, 30);
        _leftLbl.text = L(@"BTCallCustomerService");
    }
    return _leftLbl;
}


-(UILabel *)rightLbl{
    
    if (!_rightLbl) {
        _rightLbl = [[UILabel alloc]init];
        _rightLbl.backgroundColor = [UIColor clearColor];
        _rightLbl.font = [UIFont systemFontOfSize:15];
        _rightLbl.frame = CGRectMake(150, 10, 130, 30);
        _rightLbl.textAlignment = UITextAlignmentRight;
        _rightLbl.text = @"4006-766-766";
    }
    return _rightLbl;
}

@end

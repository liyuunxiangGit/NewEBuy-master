//
//  PlanePayModelCell.m
//  SuningEBuy
//
//  Created by david on 14-2-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PlanePayModelCell.h"

#define UILABLE_FONT    [UIFont systemFontOfSize:15]
#define leftPadding     15
#define topPadding      20



@interface PlanePayModelCell()

@property(nonatomic,strong)UIView       *whiteBackView;
@property(nonatomic,strong)UILabel      *payModelLbl;
@property(nonatomic,strong)UILabel      *payModelValLbl;

@end


@implementation PlanePayModelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
    }
    return self;
}

+(CGFloat)height{
    
    return 60;
}

-(void)refreshCell:(PFOrderDetailDTO *)dto{

    if (dto == nil) return;
    
    self.whiteBackView.frame = CGRectMake(0, topPadding, 320, 40);
    self.payModelLbl.frame = CGRectMake(leftPadding, topPadding+5, 80, 30);
    self.payModelValLbl.frame = CGRectMake(_payModelLbl.right, _payModelLbl.top, (320-leftPadding-_payModelLbl.right), 30);
    self.payModelValLbl.text = dto.paymentType?dto.paymentType:@"--";
}

#pragma mark -
#pragma mark UIView
-(UIView *)whiteBackView{
    if (!_whiteBackView) {
        _whiteBackView = [[UIView alloc]init];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_whiteBackView];
    }
    return _whiteBackView;
}


-(UILabel *)payModelLbl{
    if (!_payModelLbl) {
        _payModelLbl = [[UILabel alloc]init];
        _payModelLbl.backgroundColor = [UIColor clearColor];
        _payModelLbl.font = UILABLE_FONT;
        _payModelLbl.text = L(@"BTPayment");
        [self.contentView addSubview:_payModelLbl];
    }
    return _payModelLbl;
}

-(UILabel *)payModelValLbl{
    if (!_payModelValLbl) {
        _payModelValLbl = [[UILabel alloc]init];
        _payModelValLbl.backgroundColor = [UIColor clearColor];
        _payModelValLbl.font = UILABLE_FONT;
        _payModelValLbl.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_payModelValLbl];
    }
    return _payModelValLbl;
}


@end

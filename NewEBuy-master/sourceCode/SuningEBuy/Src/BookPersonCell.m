//
//  BookPersonCell.m
//  SuningEBuy
//
//  Created by david on 14-2-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BookPersonCell.h"

#define UILABLE_FONT    [UIFont systemFontOfSize:15]
#define leftPadding     15
#define topPadding      20



@interface BookPersonCell()

@property(nonatomic,strong)UIView       *whiteBackView;

@property(nonatomic,strong)UILabel      *yuDingRenLbl;
@property(nonatomic,strong)UILabel      *yuDingRenValLbl;

@end


@implementation BookPersonCell

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

    //预订人
    self.yuDingRenLbl.frame = CGRectMake(leftPadding, topPadding+5, 80, 30);
    self.yuDingRenValLbl.frame = CGRectMake(_yuDingRenLbl.right, _yuDingRenLbl.top, (320-leftPadding-_yuDingRenLbl.right), 30);
    self.yuDingRenValLbl.text = [NSString stringWithFormat:@"%@(%@)",dto.contactName,dto.mobile];
    
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


-(UILabel *)yuDingRenLbl{
    if (!_yuDingRenLbl) {
        _yuDingRenLbl = [[UILabel alloc]init];
        _yuDingRenLbl.backgroundColor = [UIColor clearColor];
        _yuDingRenLbl.font = UILABLE_FONT;
        _yuDingRenLbl.text = L(@"BTReserveMan");
        [self.contentView addSubview:_yuDingRenLbl];
    }
    return _yuDingRenLbl;
}

-(UILabel *)yuDingRenValLbl{
    if (!_yuDingRenValLbl) {
        _yuDingRenValLbl = [[UILabel alloc]init];
        _yuDingRenValLbl.backgroundColor = [UIColor clearColor];
        _yuDingRenValLbl.font = UILABLE_FONT;
        _yuDingRenValLbl.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_yuDingRenValLbl];
    }
    return _yuDingRenValLbl;
}


@end

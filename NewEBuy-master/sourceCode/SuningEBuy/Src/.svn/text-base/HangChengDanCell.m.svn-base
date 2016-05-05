//
//  HangChengDanCell.m
//  SuningEBuy
//
//  Created by david on 14-2-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HangChengDanCell.h"

#define UILABLE_FONT    [UIFont systemFontOfSize:15]
#define leftPadding     15
#define topPadding      20


@interface HangChengDanCell()

@property(nonatomic,strong)UIView       *whiteBackView;
@property(nonatomic,strong)UILabel      *peiSongLbl;
@property(nonatomic,strong)UILabel      *peiSongValLbl;
@property(nonatomic,strong)UIImageView  *lineImage;
@property(nonatomic,strong)UILabel      *nameLbl;
@property(nonatomic,strong)UILabel      *mobileLbl;
@property(nonatomic,strong)UILabel      *addressLbl;


@end

/********************************************************/


@implementation HangChengDanCell

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

+(CGFloat)height:(PFOrderDetailDTO *)dto{
    
    if (dto == nil) {
        return 0;
    }
    
    if (dto.addressInfo) {
        return 150;
    }else{
        return 60;
    }
}

-(void)refreshCell:(PFOrderDetailDTO *)dto{

    if (dto == nil) return;
    
    self.whiteBackView.frame = CGRectMake(0, topPadding, 320, 40);
    self.peiSongLbl.frame = CGRectMake(leftPadding, topPadding+5, 80, 30);
    self.peiSongValLbl.frame = CGRectMake(_peiSongLbl.right, topPadding+5, (320-leftPadding-_peiSongLbl.right), 30);
    self.peiSongValLbl.text = dto.addressType?dto.addressType:@"--";
    
    if (dto.addressInfo) {
        
        self.whiteBackView.frame = CGRectMake(0, topPadding, 320, 130);

        //分割线
        self.lineImage.frame = CGRectMake(0, _peiSongLbl.bottom+5, 320, 1);
        
        //姓名
        self.nameLbl.frame = CGRectMake(leftPadding, _lineImage.bottom+5, 100, 30);
        self.nameLbl.text = dto.addressInfo.recipient;
        
        //手机号码 AddressInfoDTO
        self.mobileLbl.frame = CGRectMake(_nameLbl.right, _nameLbl.top, (320-leftPadding-_nameLbl.right), 30);
        self.mobileLbl.text = dto.addressInfo.tel;
        
        //配送地址
        self.addressLbl.frame = CGRectMake(leftPadding, _nameLbl.bottom, (320-leftPadding*2), 60);
        NSString *addressStr = [NSString stringWithFormat:@"%@%@%@%@%@",dto.addressInfo.provinceContent?dto.addressInfo.provinceContent:@"",dto.addressInfo.cityContent?dto.addressInfo.cityContent:@"",dto.addressInfo.districtContent?dto.addressInfo.districtContent:@"",dto.addressInfo.townContent?dto.addressInfo.townContent:@"",dto.addressInfo.addressContent?dto.addressInfo.addressContent:@""];
        self.addressLbl.text = addressStr;
    }
    
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


-(UILabel *)peiSongLbl{
    if (!_peiSongLbl) {
        _peiSongLbl = [[UILabel alloc]init];
        _peiSongLbl.backgroundColor = [UIColor clearColor];
        _peiSongLbl.font = UILABLE_FONT;
        _peiSongLbl.text = L(@"BTVoyageListDistribution");
        [self.contentView addSubview:_peiSongLbl];
    }
    return _peiSongLbl;
}

-(UILabel *)peiSongValLbl{
    if (!_peiSongValLbl) {
        _peiSongValLbl = [[UILabel alloc]init];
        _peiSongValLbl.backgroundColor = [UIColor clearColor];
        _peiSongValLbl.font = UILABLE_FONT;
        _peiSongValLbl.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_peiSongValLbl];
    }
    return _peiSongValLbl;
}

-(UIImageView *)lineImage{

    if (!_lineImage) {
        _lineImage = [[UIImageView alloc]init];
        UIImage *image = [UIImage newImageFromResource:@"line.png"];
        _lineImage.image = image;
        [self.contentView addSubview:_lineImage];
    }
    return _lineImage;
}


-(UILabel *)nameLbl{
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc]init];
        _nameLbl.backgroundColor = [UIColor clearColor];
        _nameLbl.font = UILABLE_FONT;
        [self.contentView addSubview:_nameLbl];
    }
    return _nameLbl;
}

-(UILabel *)mobileLbl{
    if (!_mobileLbl) {
        _mobileLbl = [[UILabel alloc]init];
        _mobileLbl.backgroundColor = [UIColor clearColor];
        _mobileLbl.font = UILABLE_FONT;
        _mobileLbl.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_mobileLbl];
    }
    return _mobileLbl;
}

-(UILabel *)addressLbl{
    if (!_addressLbl) {
        _addressLbl = [[UILabel alloc]init];
        _addressLbl.backgroundColor = [UIColor clearColor];
        _addressLbl.font = UILABLE_FONT;
        _addressLbl.numberOfLines = 0;
        [self.contentView addSubview:_addressLbl];
    }
    return _addressLbl;
}

@end

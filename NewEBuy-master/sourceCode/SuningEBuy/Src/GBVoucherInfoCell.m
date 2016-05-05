//
//  GBVourcherInfoCell.m
//  SuningEBuy
//
//  Created by xingxuewei on 13-3-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBVoucherInfoCell.h"

#define kOffsetContentLeft          30
#define kOffsetContentHight         30
#define kOffsetContentLength        60

#define kOffsetHight                30
#define kOffsetLength               220

@implementation GBVoucherInfoCell

@synthesize voucherCodeContentLbl = _voucherCodeContentLbl;
@synthesize voucherCodeLbl = _voucherCodeLbl;
@synthesize usefulLifeContentLbl = _usefulLifeContentLbl;
@synthesize usefulLifeLbl = _usefulLifeLbl;
@synthesize usedContentLbl = _usedContentLbl;
@synthesize usedLbl = _usedLbl;
@synthesize notUseContentLbl = _notUseContentLbl;
@synthesize notUseLbl = _notUseLbl;
@synthesize overUsedContentLbl = _overUsedContentLbl;
@synthesize overUnusedLbl = _overUnusedLbl;
@synthesize obsoleteContentLbl = _obsoleteContentLbl;
@synthesize obsoleteLbl = _obsoleteLbl;
@synthesize voucherPasswordContentLbl = _voucherPasswordContentLbl;
@synthesize voucherPasswordLbl = _voucherPasswordLbl;

@synthesize item = _item;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_voucherCodeContentLbl);
    TT_RELEASE_SAFELY(_voucherCodeLbl);
    TT_RELEASE_SAFELY(_usefulLifeContentLbl);
    TT_RELEASE_SAFELY(_usefulLifeLbl);
    TT_RELEASE_SAFELY(_usedContentLbl);
    TT_RELEASE_SAFELY(_usedLbl);
    TT_RELEASE_SAFELY(_notUseContentLbl);
    TT_RELEASE_SAFELY(_notUseLbl);
    TT_RELEASE_SAFELY(_overUsedContentLbl);
    TT_RELEASE_SAFELY(_overUnusedLbl);
    TT_RELEASE_SAFELY(_obsoleteContentLbl);
    TT_RELEASE_SAFELY(_obsoleteLbl);
    TT_RELEASE_SAFELY(_voucherPasswordContentLbl);
    TT_RELEASE_SAFELY(_voucherPasswordLbl);
    TT_RELEASE_SAFELY(_lineView);
}

- (void)setItem:(GBVoucherDTO *)item
{
    if (item != _item) {
    
        _item = item;

        self.voucherCodeLbl.text = _item.voucherCode;
        self.usefulLifeLbl.size = [self.usefulLifeLbl.text sizeWithFont:[UIFont systemFontOfSize:14]];
        self.usefulLifeLbl.text = [NSString stringWithFormat:@"%@至%@",_item.startTime,_item.endTime];
        self.usedLbl.text = [NSString stringWithFormat:@"%d",_item.used];;
        self.notUseLbl.text = [NSString stringWithFormat:@"%d",_item.notUse];
        self.overUnusedLbl.text = [NSString stringWithFormat:@"%d",_item.overUsed];
        self.obsoleteLbl.text = [NSString stringWithFormat:@"%d",_item.obsolete];
        self.voucherPasswordLbl.text = _item.voucherPassword;
        self.lineView.hidden = YES;
    }
}

- (UILabel *)voucherCodeContentLbl
{
    if (!_voucherCodeContentLbl)
    {
        _voucherCodeContentLbl = [[UILabel alloc] init];
        _voucherCodeContentLbl.font = [UIFont systemFontOfSize:15];
        _voucherCodeContentLbl.text = L(@"GBNumberOfCertificate");
        _voucherCodeContentLbl.backgroundColor = [UIColor clearColor];
        _voucherCodeContentLbl.textColor = [UIColor light_Black_Color];

        [self.contentView addSubview:_voucherCodeContentLbl];
    }
    return _voucherCodeContentLbl;
}

- (UILabel *)voucherCodeLbl
{
    if (!_voucherCodeLbl)
    {
        _voucherCodeLbl = [[UILabel alloc] init];
        _voucherCodeLbl.font = [UIFont systemFontOfSize:15];
        _voucherCodeLbl.backgroundColor = [UIColor clearColor];
        _voucherCodeLbl.textColor = [UIColor dark_Gray_Color];

        [self.contentView addSubview:_voucherCodeLbl];
    }
    return _voucherCodeLbl;
}

- (UILabel *)usefulLifeContentLbl
{
    if (!_usefulLifeContentLbl)
    {
        _usefulLifeContentLbl = [[UILabel alloc] init];
        _usefulLifeContentLbl.font = [UIFont systemFontOfSize:15];
        _usefulLifeContentLbl.text = L(@"GBValidityPeriod");
        _usefulLifeContentLbl.backgroundColor = [UIColor clearColor];
        _usefulLifeContentLbl.textColor = [UIColor light_Black_Color];
        [self.contentView addSubview:_usefulLifeContentLbl];
    }
    return _usefulLifeContentLbl;
}

- (UILabel *)usefulLifeLbl
{
    if (!_usefulLifeLbl)
    {
        _usefulLifeLbl = [[UILabel alloc] init];
        _usefulLifeLbl.font = [UIFont systemFontOfSize:15];
        _usefulLifeLbl.backgroundColor = [UIColor clearColor];
        _usefulLifeLbl.numberOfLines = 0;
        _usefulLifeLbl.textColor = [UIColor dark_Gray_Color];
        [self.contentView addSubview:_usefulLifeLbl];
    }
    return _usefulLifeLbl;
}

- (UILabel *)usedContentLbl
{
    if (!_usedContentLbl)
    {
        _usedContentLbl = [[UILabel alloc] init];
        _usedContentLbl.font = [UIFont systemFontOfSize:15];
        _usedContentLbl.text = L(@"GBUsed");
        _usedContentLbl.backgroundColor = [UIColor clearColor];
        _usedContentLbl.textColor = [UIColor light_Black_Color];
        [self.contentView addSubview:_usedContentLbl];
    }
    return _usedContentLbl;
}

- (UILabel *)usedLbl
{
    if (!_usedLbl)
    {
        _usedLbl = [[UILabel alloc] init];
        _usedLbl.font = [UIFont systemFontOfSize:15];
        _usedLbl.backgroundColor = [UIColor clearColor];
        _usedLbl.textColor = [UIColor light_Black_Color];

        [self.contentView addSubview:_usedLbl];
    }
    return _usedLbl;
}


- (UILabel *)notUseContentLbl
{
    if (!_notUseContentLbl)
    {
        _notUseContentLbl = [[UILabel alloc] init];
        _notUseContentLbl.font = [UIFont systemFontOfSize:15];
        _notUseContentLbl.text = L(@"GBUnused");
        _notUseContentLbl.backgroundColor = [UIColor clearColor];
        _usedLbl.textColor = [UIColor light_Black_Color];

        [self.contentView addSubview:_notUseContentLbl];
    }
    return _notUseContentLbl;
}

- (UILabel *)notUseLbl
{
    if (!_notUseLbl)
    {
        _notUseLbl = [[UILabel alloc] init];
        _notUseLbl.font = [UIFont systemFontOfSize:15];
        _notUseLbl.backgroundColor = [UIColor clearColor];
        _notUseLbl.textColor = [UIColor dark_Gray_Color];

        [self.contentView addSubview:_notUseLbl];
    }
    return _notUseLbl;
}


- (UILabel *)overUsedContentLbl
{
    if (!_overUsedContentLbl)
    {
        _overUsedContentLbl = [[UILabel alloc] init];
        _overUsedContentLbl.font = [UIFont systemFontOfSize:15];
        _overUsedContentLbl.text = L(@"GBOverdue");
        _overUsedContentLbl.backgroundColor = [UIColor clearColor];
        _overUsedContentLbl.textColor = [UIColor light_Black_Color];

        [self.contentView addSubview:_overUsedContentLbl];
    }
    return _overUsedContentLbl;
}

- (UILabel *)overUnusedLbl
{
    if (!_overUnusedLbl)
    {
        _overUnusedLbl = [[UILabel alloc] init];
        _overUnusedLbl.font = [UIFont systemFontOfSize:15];
        _overUnusedLbl.backgroundColor = [UIColor clearColor];
        _overUnusedLbl.textColor = [UIColor dark_Gray_Color];

        [self.contentView addSubview:_overUnusedLbl];
    }
    return _overUnusedLbl;
}


- (UILabel *)obsoleteContentLbl
{
    if (!_obsoleteContentLbl)
    {
        _obsoleteContentLbl = [[UILabel alloc] init];
        _obsoleteContentLbl.font = [UIFont systemFontOfSize:15];
        _obsoleteContentLbl.text = L(@"GBNullified");
        _obsoleteContentLbl.backgroundColor = [UIColor clearColor];
        _obsoleteContentLbl.textColor = [UIColor light_Black_Color];

        [self.contentView addSubview:_obsoleteContentLbl];
    }
    return _obsoleteContentLbl;
}

- (UILabel *)obsoleteLbl
{
    if (!_obsoleteLbl)
    {
        _obsoleteLbl = [[UILabel alloc] init];
        _obsoleteLbl.font = [UIFont systemFontOfSize:15];
        _obsoleteLbl.backgroundColor = [UIColor clearColor];
        _obsoleteLbl.textColor = [UIColor dark_Gray_Color];

        [self.contentView addSubview:_obsoleteLbl];
    }
    return _obsoleteLbl;
}


- (UILabel *)voucherPasswordContentLbl
{
    if (!_voucherPasswordContentLbl)
    {
        _voucherPasswordContentLbl = [[UILabel alloc] init];
        _voucherPasswordContentLbl.font = [UIFont systemFontOfSize:15];
        _voucherPasswordContentLbl.text = L(@"GBCodeOfCertificate");
        _voucherPasswordContentLbl.backgroundColor = [UIColor clearColor];
        _voucherPasswordContentLbl.textColor = [UIColor light_Black_Color];

        [self.contentView addSubview:_voucherPasswordContentLbl];
    }
    return _voucherPasswordContentLbl;
}

- (UILabel *)voucherPasswordLbl
{
    if (!_voucherPasswordLbl)
    {
        _voucherPasswordLbl = [[UILabel alloc] init];
        _voucherPasswordLbl.font = [UIFont systemFontOfSize:15];
        _voucherPasswordLbl.backgroundColor = [UIColor clearColor];
        _voucherPasswordLbl.textColor = [UIColor dark_Gray_Color];

        [self.contentView addSubview:_voucherPasswordLbl];
    }
    return _voucherPasswordLbl;
}
-(UIImageView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"category_cellSeparatorLine.png"]];
       // [self.contentView addSubview:_lineView];
    }
    return _lineView;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.voucherCodeContentLbl.frame = CGRectMake(kOffsetContentLeft, 8, kOffsetContentLength, kOffsetContentHight);
    
    self.voucherCodeLbl.frame = CGRectMake(self.voucherCodeContentLbl.right, 8, kOffsetLength, kOffsetHight);
    
    self.usefulLifeContentLbl.frame = CGRectMake(kOffsetContentLeft, self.voucherCodeContentLbl.bottom, kOffsetContentLength, kOffsetContentHight);
    
    self.usefulLifeLbl.frame = CGRectMake(self.usefulLifeContentLbl.right, self.usefulLifeContentLbl.top, kOffsetLength, kOffsetContentHight);
    
    self.usedContentLbl.frame = CGRectMake(kOffsetContentLeft, self.usefulLifeLbl.bottom, kOffsetContentLength, kOffsetContentHight);
    
    self.usedLbl.frame = CGRectMake(self.usedContentLbl.right, self.usefulLifeLbl.bottom, kOffsetLength, kOffsetHight);
    
    self.notUseContentLbl.frame = CGRectMake(kOffsetContentLeft, self.usedContentLbl.bottom, kOffsetContentLength, kOffsetContentHight);
    
    self.notUseLbl.frame = CGRectMake(self.notUseContentLbl.right, self.usedContentLbl.bottom, kOffsetLength, kOffsetHight);
    
    self.overUsedContentLbl.frame = CGRectMake(kOffsetContentLeft, self.notUseContentLbl.bottom, kOffsetContentLength, kOffsetContentHight);
    
    self.overUnusedLbl.frame = CGRectMake(self.overUsedContentLbl.right, self.notUseContentLbl.bottom, kOffsetLength, kOffsetHight);
    
    self.obsoleteContentLbl.frame = CGRectMake(kOffsetContentLeft, self.overUsedContentLbl.bottom, kOffsetContentLength, kOffsetContentHight);
    
    self.obsoleteLbl.frame = CGRectMake(self.obsoleteContentLbl.right, self.overUsedContentLbl.bottom, kOffsetLength, kOffsetHight);
    
    self.voucherPasswordContentLbl.frame = CGRectMake(kOffsetContentLeft, self.obsoleteContentLbl.bottom, kOffsetContentLength, kOffsetContentHight);
    
    self.voucherPasswordLbl.frame = CGRectMake(self.voucherPasswordContentLbl.right, self.obsoleteContentLbl.bottom, kOffsetLength, kOffsetHight);
    
    self.lineView.frame = CGRectMake(10, self.voucherPasswordLbl.bottom, 300, 2);
}


@end

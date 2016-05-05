//
//  NoticeAndOrderCell.m
//  SuningEBuy
//
//  Created by david david on 12-6-28.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "NoticeAndOrderCell.h"

@implementation NoticeAndOrderCell

@synthesize hallDto = _hallDto;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize lotteryImageView = _lotteryImageView;
@synthesize itemsNameLbl = _itemsNameLbl;
@synthesize desLbl = _desLbl;
@synthesize isNotice = _isNotice;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_hallDto);
    
    TT_RELEASE_SAFELY(_backgroundImageView);
    
    TT_RELEASE_SAFELY(_lotteryImageView);
    
    TT_RELEASE_SAFELY(_itemsNameLbl);
    
    TT_RELEASE_SAFELY(_desLbl);
    
    
}


-(void)setItem:(BOOL)tag{
    
    self.isNotice = tag;
    
    
    self.backgroundImageView.frame = CGRectMake(10, 10, 300, 88);
    
    self.lotteryImageView.frame = CGRectMake(20, 20, 65, 65);
    
    self.itemsNameLbl.frame = CGRectMake(self.lotteryImageView.right+10, 25, 80, 25);
    
    self.desLbl.frame = CGRectMake(self.lotteryImageView.right+10, 45, 220, 50);
    
    if (self.isNotice) {
        UIImage *image = nil;
        
        image = [UIImage imageNamed:@"kaijianggonggaoNew.png"];
        self.lotteryImageView.image = image;
        
        self.itemsNameLbl.text = L(@"Lottery announcement");
        
        self.desLbl.text = L(@"To overlook kinds lottery announcement number");
        
    }else{
        
        UIImage *image = nil;
        
        image = [UIImage imageNamed:@"wodedingdanNew.png"];
        self.lotteryImageView.image = image;
        
        self.itemsNameLbl.text = L(@"My lottery");//L(@"My order");
        
        self.desLbl.text = L(@"View my betting records");
        
    }
    
    
    
}


-(UIImageView *)backgroundImageView{
    
    if (_backgroundImageView == nil) {
        
        _backgroundImageView = [[UIImageView alloc]init];
        
        UIImage *image  = nil;
        
        image = [UIImage imageNamed:@"lottery_hall_backgroundNew.png"];
        image =[image stretchableImageWithLeftCapWidth:10 topCapHeight:0];
        CGRect rect = _backgroundImageView.frame;
        rect.size.height = 50;
        _backgroundImageView.frame = rect;
        
        _backgroundImageView.image = image;
        
        [self.contentView addSubview:_backgroundImageView];
        
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _backgroundImageView;
    
}




-(UIImageView *)lotteryImageView{
    
    if (_lotteryImageView == nil) {
        
        _lotteryImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_lotteryImageView];
        
        _lotteryImageView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _lotteryImageView;
    
}

-(UILabel *)itemsNameLbl{
    
    if (_itemsNameLbl == nil) {
        
        _itemsNameLbl = [[UILabel alloc]init];
        
        _itemsNameLbl.backgroundColor = [UIColor clearColor];
        
        _itemsNameLbl.font = [UIFont boldSystemFontOfSize:17.0];
        
        _itemsNameLbl.textColor = RGBCOLOR(51.0, 0, 0);
        
        [self.contentView addSubview:_itemsNameLbl];
        
    }
    
    return _itemsNameLbl;
}


-(UILabel *)desLbl{
    
    if (_desLbl == nil) {
        
        _desLbl = [[UILabel alloc]init];
        
        _desLbl.backgroundColor = [UIColor clearColor];
        
        _desLbl.font = [UIFont systemFontOfSize:12.0];
        
        _desLbl.textColor = RGBCOLOR(102.0, 51.0, 51.0);
        
        [self.contentView addSubview:_desLbl];
    }
    
    return _desLbl;
}

@end

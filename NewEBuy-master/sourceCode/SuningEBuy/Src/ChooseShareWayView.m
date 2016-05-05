//
//  ChooseShareWayView.m
//  SuningEBuy
//
//  Created by 孔斌 on 13-11-30.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ChooseShareWayView.h"
#import "SNSwitch.h"

#define kShareBtnSizeWidth       51.
#define kShareBtnSizeHeight      51.
#define kShareBtnVertialMargin   20.

NSString *const SNShareToSinaWeibo = @"SNShareToSinaWeibo";
NSString *const SNShareToSMS = @"SNShareToSMS";
NSString *const SNShareToTCWeiBo = @"SNShareToTCWeiBo";
NSString *const SNShareToWeiXin = @"SNShareToWeiXin";
NSString *const SNShareToWeiXinFriend = @"SNShareToWeiXinFriend";
NSString *const SNShareToSNWeibo = @"SNShareToSNWeibo";
NSString *const SNShareToSNCloud = @"SNShareToSNCloud";
NSString *const SNShareToSinaWeiboForGift = @"SNShareToSinaWeiboForGift";

@implementation ChooseShareWayView

- (instancetype)init
{
    return [self initWithShareTypes:@[SNShareToWeiXin,SNShareToWeiXinFriend,SNShareToSinaWeibo,SNShareToTCWeiBo,SNShareToSMS,SNShareToSinaWeiboForGift]];
}

- (instancetype)initWithShareTypes:(NSArray *)types
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self) {
        
        
        [self addTarget:self action:@selector(hideChooseShareWayView) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = RGBCOLOR(242, 242, 242);
        
        self.closeBtn.frame = CGRectMake(280, -14, 28, 28);
        self.titleLabel.frame = CGRectMake(0, 10, 320, 15);
        self.sperateLineImageView.frame = CGRectMake(0, 35, 320, 1);
        [contentView addSubview:self.closeBtn];
        [contentView addSubview:self.titleLabel];
        [contentView addSubview:self.sperateLineImageView];
        
        int line = 0, row = 0;
        int maxLineCount = 4;
        
        float btn_w = 51.f, btn_h = 51.f, btn_v_m = 20.f, lbl_h = 20.f;
        float btn_h_m = (320.f - maxLineCount * btn_w ) / (maxLineCount + 1);
        float top = self.sperateLineImageView.bottom + btn_v_m;

        for (NSString *shareType in types) {
            
            //计算frame
            CGRect btnFrame = CGRectMake(btn_h_m + (btn_h_m + btn_w)*line,
                                         top,
                                         btn_w, btn_h);
            
            EGOImageButton *btn = [[EGOImageButton alloc] initWithFrame:btnFrame];
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(chooseShare:) forControlEvents:UIControlEventTouchUpInside];
            
            //添加lbl
            CGRect lblFrame = CGRectMake(btn.left - 5, btn.bottom, btn.width + 10, lbl_h);
            UILabel *lbl = [[UILabel alloc] initWithFrame:lblFrame];
            lbl.backgroundColor = [UIColor clearColor];
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.textColor = [UIColor colorWithRGBHex:0x333333];
            lbl.font = [UIFont systemFontOfSize:12];
            
            if ([shareType isEqualToString:SNShareToSinaWeibo])
            {
                [btn setImage:[UIImage imageNamed:@"share_xinlangweibo.png"] forState:UIControlStateNormal];
                btn.tag = SNShareSinaWeibo;
                lbl.text = L(@"Product_SinaWeiBo");
            }
            else if ([shareType isEqualToString:SNShareToSMS])
            {
                [btn setImage:[UIImage imageNamed:@"share_SMS_duanxin.png"] forState:UIControlStateNormal];
                btn.tag = SNShareSMS;
                lbl.text = L(@"Product_Message");
            }
            else if ([shareType isEqualToString:SNShareToTCWeiBo])
            {
                [btn setImage:[UIImage imageNamed:@"share_tengxunweibo.png"] forState:UIControlStateNormal];
                btn.tag = SNShareTCWeiBo;
                lbl.text = L(@"Product_TencentWeiBo");
            }
            else if ([shareType isEqualToString:SNShareToWeiXin])
            {
                [btn setImage:[UIImage imageNamed:@"share_weixinhaoyou.png"] forState:UIControlStateNormal];
                btn.tag = SNShareWeiXin;
                lbl.text = L(@"Product_WeiXinFriends");
            }
            else if ([shareType isEqualToString:SNShareToWeiXinFriend])
            {
                [btn setImage:[UIImage imageNamed:@"share_weixinhaoyouquan.png"] forState:UIControlStateNormal];
                btn.tag = SNShareWeiXinFriend;
                lbl.text = L(@"Product_WeiXinFriendsCircle");
            }
            else if ([shareType isEqualToString:SNShareToSNWeibo])
            {
                [btn setImage:[UIImage imageNamed:@"share_yunxinguangchang.png"] forState:UIControlStateNormal];
                btn.tag = SNShareSNWeibo;
                lbl.text = L(@"Product_YunXinSquare");
            }
            else if ([shareType isEqualToString:SNShareToSNCloud])
            {
                [btn setImage:[UIImage imageNamed:@"share_yunxinhaoyou.png"] forState:UIControlStateNormal];
                btn.tag = SNShareSNCloud;
                lbl.text = L(@"Product_YunXinFriends");
            }
            else if ([shareType isEqualToString:SNShareToSinaWeiboForGift])
            {
                //分享有礼
                NSString *title = nil;
                NSURL *imageUrl = nil;
                if ([SNSwitch isOpenSharePromoteWithTitle:&title imageUrl:&imageUrl])
                {
                    btn.imageURL = imageUrl;
                    btn.tag = SNShareWinGift;
                    lbl.text = title;
                }
                else
                {
                    btn = nil;
                    lbl = nil;
                }
            }
            
            if (btn && lbl)
            {
                [contentView addSubview:btn];
                [contentView addSubview:lbl];
                
                //计算行列
                line ++;
                if (line >= maxLineCount) {
                    line = 0;
                    row ++;
                    top += (btn_v_m + btn_h + lbl_h);
                }
            }
        }
        
        if (line == 0) {
            row --;
            top -= (btn_v_m + btn_h + lbl_h);
        }
        
        //计算contentView的大小
        contentView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, top + btn_h + lbl_h + btn_v_m);
        
        [self addSubview:contentView];
        
        _contentView = contentView;
    }
    
    return self;
}

- (void)chooseShare:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    SNShareType selectType = btn.tag;
    
    [UIView animateWithDuration:0.3 animations:^(void){
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.contentView.width, self.contentView.height);
        self.closeBtn.hidden = YES;
        
    } completion:^(BOOL finished){
        
        if (_delegate && [_delegate respondsToSelector:@selector(chooseShareWay:)])
        {
            [_delegate chooseShareWay:selectType];
        }
        
        _bRemoved = YES;
        [self removeFromSuperview];
    }];
}

- (void)showChooseShareWayView
{
    self.contentView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.contentView.width, self.contentView.height);
    
    [self.appDelegate.window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.closeBtn.hidden = NO;
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
        self.contentView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.contentView.height, self.contentView.width, self.contentView.height);
        _bRemoved = NO;
    }];
}

- (void)hideChooseShareWayView
{
    [UIView animateWithDuration:0.3 animations:^(void){
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.contentView.width, self.contentView.height);
        self.closeBtn.hidden = YES;
        
    } completion:^(BOOL finished){
        
        _bRemoved = YES;
        [self removeFromSuperview];
    }];
}

#pragma mark - views

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        _closeBtn.backgroundColor = [UIColor clearColor];
        [_closeBtn setImage:[UIImage imageNamed:@"button_closed_normal.png"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(hideChooseShareWayView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRGBHex:0x333333];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.text = L(@"Share to friends");
        
    }
    return _titleLabel;
}

- (UIImageView *)sperateLineImageView
{
    if (!_sperateLineImageView) {
        _sperateLineImageView = [[UIImageView alloc] init];
        _sperateLineImageView.image = [UIImage imageNamed:@"line.png"];
        
    }
    return _sperateLineImageView;
}

@end


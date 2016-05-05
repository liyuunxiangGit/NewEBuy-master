//
//  CICalendarGridView.m
//  SuningEBuy
//
//  Created by  liukun on 13-9-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CICalendarGridView.h"

@implementation CICalendarGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        UIImageView *leftLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0.8, 52)];
        leftLine.image =[UIImage imageNamed:@"segment_line_vertical_gray"];
        leftLine.backgroundColor = [UIColor clearColor];
        
//        UIImageView *rightLine = [[UIImageView alloc]initWithFrame:CGRectMake(41, 0, 0.8, 52)];
//        rightLine.image =[UIImage imageNamed:@"segment_line_vertical_gray"];
//        rightLine.backgroundColor = [UIColor clearColor];
        
        UIImageView *bottomLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 51, 42, 0.8)];
        bottomLine.image = [UIImage imageNamed:@"line"];
        bottomLine.backgroundColor =[UIColor clearColor];
        
        [self addSubview:leftLine];
//        [self addSubview:rightLine];
        [self addSubview:bottomLine];
    }
    return self;
}

- (void)setDate:(CIDate *)date
{
    if (_date != date)
    {
        _date = date;
        
        CICheckState state = [self.dto checkStateInDate:self.date];
        
        switch (state) {
            case CICheckStateUnCheck:
            {
                [self.gridButton setBackgroundImage:nil
                                           forState:UIControlStateNormal];
                self.gridButton.userInteractionEnabled = NO;
                
                //设title
                [self resetTitleText];
                self.titleLabel.textColor = [UIColor dark_Gray_Color];
                self.titleLabel.shadowColor = [UIColor whiteColor];
                
                //下部
                //过去未签
                TTVIEW_RELEASE_SAFELY(_integralLabel);
                TTVIEW_RELEASE_SAFELY(_integralImageView);
                TTVIEW_RELEASE_SAFELY(_ticketLabel);
                TTVIEW_RELEASE_SAFELY(_ticketImageView);
                
                [self noRegistView];
                break;
            }
            case CICheckStateTodayUncheck:
            {
                [self.gridButton setBackgroundImage:[UIImage streImageNamed:/*@"Sign-current.png"*/@"Sign-todayUncheck.png"]
                                           forState:UIControlStateNormal];
                self.gridButton.userInteractionEnabled = YES;
                
                //设title
                [self resetTitleText];
                self.titleLabel.textColor = [UIColor whiteColor];
                self.titleLabel.shadowColor = [UIColor grayColor];
                
                //下部
                [self reloadBottomLayoutIsHighlight:YES];
                break;
            }
            case CICheckStateNormalCheck:
            {
                
                if ([self.date isEqual:self.dto.currentDate]) {
                    [self.gridButton setBackgroundImage:[UIImage streImageNamed:@"Sign-Already.png"]
                                               forState:UIControlStateNormal];
                    
                    self.gridButton.userInteractionEnabled = YES;
                    
                    self.titleLabel.textColor = [UIColor whiteColor];
                    
                    //下部
                    [self reloadBottomLayoutIsHighlight:YES];
                }else{
                    [self.gridButton setBackgroundImage:nil
                                               forState:UIControlStateNormal];
                    
                    self.gridButton.userInteractionEnabled = NO;
                    self.titleLabel.textColor = [UIColor light_Black_Color];
                    
                    //下部
                    [self reloadBottomLayoutIsHighlight:NO];
                }
                
                //设title
                [self resetTitleText];
                
                self.titleLabel.shadowColor = [UIColor grayColor];
                
                
                break;
            }
            case CICheckStateActivityCheck:
            {
//                [self.gridButton setBackgroundImage:[UIImage streImageNamed:@"Sign-Already.png"]
//                                           forState:UIControlStateNormal];
                if ([self.date isEqual:self.dto.currentDate]) {
                    [self.gridButton setBackgroundImage:[UIImage streImageNamed:@"Sign-Already.png"]
                                               forState:UIControlStateNormal];
                    self.gridButton.userInteractionEnabled = YES;
                    self.titleLabel.textColor = [UIColor whiteColor];
                    
                    //下部
                    [self reloadBottomLayoutIsHighlight:YES];
                }else{
                    [self.gridButton setBackgroundImage:nil
                                               forState:UIControlStateNormal];
                    self.gridButton.userInteractionEnabled = NO;
                    self.titleLabel.textColor = [UIColor light_Black_Color];
                    
                    //下部
                    [self reloadBottomLayoutIsHighlight:NO];
                }
                                
                //设title
                [self resetTitleText];
                
                self.titleLabel.shadowColor = [UIColor grayColor];
//                //下部
//                [self reloadBottomLayoutIsHighlight:YES];
                break;
            }
            case CICheckStateOnCheck:
            {
                [self.gridButton setBackgroundImage:nil
                                           forState:UIControlStateNormal];
                self.gridButton.userInteractionEnabled = NO;
                
                //设title
                [self resetTitleText];
                self.titleLabel.textColor = [UIColor light_Black_Color];
                self.titleLabel.shadowColor = [UIColor whiteColor];
                
                //下部
                [self reloadBottomLayoutIsHighlight:NO];
                break;
            }
            case CICheckStateOnBlank:
            {
                [self.gridButton setBackgroundImage:nil
                                           forState:UIControlStateNormal];
                self.gridButton.userInteractionEnabled = NO;
                
                //设title
                [self resetTitleText];
                self.titleLabel.textColor = [UIColor dark_Gray_Color];
                self.titleLabel.shadowColor = [UIColor whiteColor];
                
                //下部
                TTVIEW_RELEASE_SAFELY(_integralLabel);
                TTVIEW_RELEASE_SAFELY(_integralImageView);
                TTVIEW_RELEASE_SAFELY(_ticketLabel);
                TTVIEW_RELEASE_SAFELY(_ticketImageView);
                TTVIEW_RELEASE_SAFELY(_noRegistView);
                break;
            }
            default:
                break;
        }

    }
}

- (void)resetTitleText
{
    NSString *title = nil;
    if (self.date.day == 1)
    {
        title = [NSString stringWithFormat:@"%d%@", self.date.month,L(@"Product_Month")];
    }
    else
    {
        title = [NSString stringWithFormat:@"%d", self.date.day];
    }
    self.titleLabel.text = title;
}

- (void)reloadBottomLayoutIsHighlight:(BOOL)highlight
{
    //下部
    TTVIEW_RELEASE_SAFELY(_noRegistView);
    
    //常规已签
    NSString *point = [self.dto pointInDate:self.date];
    if (point.length)
    {
        self.integralLabel.text = point;
        if (highlight) {
            self.integralLabel.textColor = [UIColor whiteColor];
            self.integralImageView.image = [UIImage imageNamed:@"Sign-fen-press.png"];
        }else{
            self.integralLabel.textColor = [UIColor dark_Gray_Color];
            self.integralImageView.image = [UIImage imageNamed:@"Sign-fen.png"];
        }
    }
    else
    {
        TTVIEW_RELEASE_SAFELY(_integralLabel);
        TTVIEW_RELEASE_SAFELY(_integralImageView);
    }
    
    NSString *coupon = [self.dto couponInDate:self.date];
    if (coupon.length)
    {
        self.ticketLabel.text = coupon;
        if (highlight) {
            self.ticketLabel.textColor = [UIColor whiteColor];
            self.ticketImageView.image = [UIImage imageNamed:@"Sign-quan-press.png"];
        }else{
            self.ticketLabel.textColor = [UIColor dark_Gray_Color];
            self.ticketImageView.image = [UIImage imageNamed:@"Sign-quan.png"];
        }
    }
    else
    {
        TTVIEW_RELEASE_SAFELY(_ticketLabel);
        TTVIEW_RELEASE_SAFELY(_ticketImageView);
    }
}

- (void)doCheckIn:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(gridView:didSelectWithDate:)])
    {
        [_delegate gridView:self didSelectWithDate:self.date];
    }
}

- (UIButton *)gridButton
{
    if (!_gridButton)
    {
        _gridButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _gridButton.backgroundColor =[UIColor clearColor];
        [_gridButton addTarget:self
                        action:@selector(doCheckIn:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_gridButton];
    }
    return _gridButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 22)];
        _titleLabel.textAlignment = UITextAlignmentRight;
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.shadowOffset = CGSizeMake(0.5, 0.5);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)integralLabel
{
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 23, 20, 12)];
        _integralLabel.textAlignment = UITextAlignmentLeft;
        _integralLabel.font = [UIFont systemFontOfSize:10];
        _integralLabel.backgroundColor = [UIColor clearColor];
        _integralLabel.textColor = [UIColor whiteColor];
        _integralLabel.shadowOffset = CGSizeMake(0.15, 0.15);
        _integralLabel.shadowColor = [UIColor grayColor];
        [self addSubview:_integralLabel];
    }
    return _integralLabel;
}

- (UILabel *)ticketLabel
{
    if (!_ticketLabel) {
        _ticketLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 38, 20, 12)];
        _ticketLabel.textAlignment = NSTextAlignmentLeft;
        _ticketLabel.font = [UIFont systemFontOfSize:10];
        _ticketLabel.backgroundColor = [UIColor clearColor];
        _ticketLabel.textColor = [UIColor whiteColor];
        _ticketLabel.shadowOffset = CGSizeMake(0.15, 0.15);
        _ticketLabel.shadowColor = [UIColor grayColor];
        [self addSubview:_ticketLabel];
    }
    return _ticketLabel;
}

- (UIImageView *)integralImageView
{
    if (!_integralImageView) {
        _integralImageView = [[UIImageView alloc] initWithFrame:CGRectMake(28, 25, 10, 8)];
        [_integralImageView setImage:[UIImage imageNamed:@"Sign-fen.png"]];
        [self addSubview:_integralImageView];
    }
    return _integralImageView;
}

- (UIImageView *)ticketImageView
{
    if (!_ticketImageView) {
        _ticketImageView = [[UIImageView alloc] initWithFrame:CGRectMake(28, 40, 10, 8)];
        [_ticketImageView setImage:[UIImage imageNamed:@"Sign-quan.png"]];
        [self addSubview:_ticketImageView];
    }
    return _ticketImageView;
}

- (UIImageView *)noRegistView
{
    if (!_noRegistView) {
        _noRegistView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 40, 8, 8)];
        [_noRegistView setImage:[UIImage imageNamed:@"Sign-pins.png"]];
        [self addSubview:_noRegistView];
    }
    return _noRegistView;
}


@end

//
//  AdActiveRuleCell.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AdActiveRuleCell.h"
#import "SNSwitch.h"

#import "SNWebViewController.h"

#define kCotendSize     14
#define TitleHeight 50
@interface AdActiveRuleCell() <EGOImageButtonDelegate>
{
    BOOL isOnCouponLoaded;
    BOOL isShowDetail;
    CGFloat  detailHeight;
}

@property (nonatomic, strong) EGOImageButton *onCouponButton;


@end

/*********************************************************************/

@implementation AdActiveRuleCell

@synthesize ruleTitleLabel = ruleTitleLabel_;
@synthesize ruleContentLabel = ruleContentLabel_;
@synthesize ruleContent = ruleContent_;
@synthesize lineView = lineView_;
@synthesize showDetailBtn=showDetailBtn_;
@synthesize ruleContentView=ruleContentView_;
@synthesize delegate;
@synthesize backView = _backView;

-(void)dealloc{

    TT_RELEASE_SAFELY(ruleContentLabel_);
    TT_RELEASE_SAFELY(ruleTitleLabel_);
    TT_RELEASE_SAFELY(ruleContent_);
    TT_RELEASE_SAFELY(lineView_);
    TT_RELEASE_SAFELY(showDetailBtn_);
    TT_RELEASE_SAFELY(ruleContentView_);
    TT_RELEASE_SAFELY(_bigShowDetailBtn);
    TT_RELEASE_SAFELY(_backView);
}

/*
 * 根据ruleString返回Cell高度
 * 2014年06月26日11:32:01 Joe
 */
+ (CGFloat) cellHeight:(NSString *)ruleString
{
    return [AdActiveRuleCell height:ruleString] + 50;
}

+ (CGFloat) height:(NSString *)ruleString{
    
    CGFloat allCellHight = kOffsetHight;
	
	if (ruleString != nil) {
        
        NSString *contendInfoS =  [ruleString trim];
        
        UIFont *cellFont =[UIFont systemFontOfSize:kCotendSize];
        CGSize labelHeight = [contendInfoS sizeWithFont:cellFont];

        CGSize mainContendSize = [contendInfoS heightWithFont:cellFont width:270 linebreak:UILineBreakModeCharacterWrap];
       
        NSInteger numberOfLines = ceil(mainContendSize.height/labelHeight.height);
        if (numberOfLines > 1) {
            allCellHight = labelHeight.height*2+6+10;
        }
        else
        {
            allCellHight = labelHeight.height*2+10 + 6;
        }
	}
	
	return  allCellHight;
	
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.ruleContentView];
        [self.ruleContentView addSubview:self.ruleContentLabel];
        [self.backView addSubview:self.ruleTitleLabel];
}
    
    return self;
}

- (void)setRuleContent:(NSString *)aruleContent{

    if (ruleContent_ != aruleContent || aruleContent == nil)
    {
        ruleContent_ = [aruleContent copy];
        
        int onCouponTop = 10;
        
        if (ruleContent_.length == 0)
        {
            
        }
        else
        {
            self.ruleTitleLabel.frame = CGRectMake(14, 0, self.width - 10, 30);
            
            UIFont *cellFont =[UIFont systemFontOfSize:kCotendSize];
            CGSize labelHeight = [[self.ruleContent trim] sizeWithFont:cellFont];
            CGSize mainContendSize = [[self.ruleContent trim] heightWithFont:cellFont width:260 linebreak:UILineBreakModeCharacterWrap];
            
            NSInteger linesCount = ceil(mainContendSize.height/labelHeight.height);
            
//            if (linesCount > 1 && self.ruleContent.length - 5 > 35) {
            if (linesCount > 2) {

//                NSString *tempContend = [NSString stringWithFormat:@"%@",self.ruleContent];
                self.ruleContentLabel.textAlignment = UITextAlignmentLeft;
                self.ruleContentLabel.frame = CGRectMake(10, 0, 270, labelHeight.height*2 + 30);
                self.ruleContentView.frame = CGRectMake(0, 30 + 10, 320, labelHeight.height*2 + 6 + 20);
                
                self.ruleContentLabel.text = [self.ruleContent trim];//tempContend;
                if (!IOS6_OR_LATER) {
                    self.ruleContentLabel.frame = CGRectMake(10, 0, 270, labelHeight.height*2 + 10);
                }
                else if (!IOS7_OR_LATER) {
//                    self.ruleContentView.frame=CGRectMake(0, 30 + 10, 320, mainContendSize.height + (linesCount + 1)*10);
                    self.ruleContentLabel.frame = CGRectMake(10, 0, 270, labelHeight.height*2 + 10);
//                    self.ruleContentLabel.frame=CGRectMake(10, 0, 290, mainContendSize.height + (linesCount + 1)*10);
                }
                else
                {
                    self.ruleContentLabel.frame = CGRectMake(10, 0, 270, labelHeight.height*2 + 10 + 14);
                }
                
                [self.ruleContentView addSubview:self.showDetailBtn];
                
                [self.ruleContentView addSubview:self.bigShowDetailBtn];
                
                self.showDetailBtn.frame= CGRectMake(294, 10, 12, 8);// CGRectMake(273, self.ruleContentView.bottom - 45, 22, 22);
                
                self.showDetailBtn.hidden=NO;
                
                self.bigShowDetailBtn.hidden=NO;
                
            }
            else
            {
                self.ruleContentLabel.text = [self.ruleContent trim];
                self.ruleContentLabel.textAlignment = UITextAlignmentLeft;
                
                self.ruleContentLabel.frame=CGRectMake(10, 0, 270, labelHeight.height*2 + 20);
                self.ruleContentView.frame=CGRectMake(0, 30 + 10, 320, labelHeight.height*2 + 25);
                
                if (!IOS7_OR_LATER) {
                    self.ruleContentView.frame=CGRectMake(0, 30 + 10, 320, mainContendSize.height + (linesCount + 1)*10);
//                    self.ruleContentLabel.frame = CGRectMake(10, 0, 270, labelHeight.height*2 + 20);
                    self.ruleContentLabel.frame=CGRectMake(10, 0, 290, mainContendSize.height + (linesCount + 1)*10);
                }

                
            }
            
            onCouponTop = self.ruleContentView.top + self.ruleContentLabel.bottom + 10;
        }
        
        //领券
        NSURL *imageUrl = nil, *webUrl = nil;
        if ([SNSwitch isOnCouponForImageUrl:&imageUrl webUrl:&webUrl])
        {
            self.onCouponButton.top = onCouponTop;
            if (!isOnCouponLoaded) {
                self.onCouponButton.imageURL = imageUrl;
            }else{
                [self sizeToFitOnCouponButton];
            }
            
            [self.contentView addSubview:self.onCouponButton];
        }
    }
}

#pragma mark ----------------------------- onCoupon delegate

- (void)imageButtonLoadedImage:(EGOImageButton *)imageButton
{
    isOnCouponLoaded = YES;
    CGFloat w = imageButton.currentImage.size.width;
    CGFloat h = imageButton.currentImage.size.height;
    self.onCouponButton.height = h * 300 /w;
    [self sizeToFitOnCouponButton];
}

- (void)sizeToFitOnCouponButton
{
    int onCouponTop = 10;
    if (self.ruleContent.length)
    {
        onCouponTop = self.ruleContentView.top + self.ruleContentLabel.bottom + 10;
    }
    
    self.onCouponButton.top = onCouponTop;
    
    if ([delegate respondsToSelector:@selector(setAdRowHeight:)])
    {
        [delegate setAdRowHeight:self.onCouponButton.bottom+10];
    }
}

- (void)goToGetCoupon
{
    NSURL *imageUrl = nil, *webUrl = nil;
    if ([SNSwitch isOnCouponForImageUrl:&imageUrl webUrl:&webUrl])
    {
        if ([delegate isKindOfClass:[UIViewController class]] && webUrl)
        {
            SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeAdModel attributes:@{@"url": [webUrl absoluteString]}];
            UIViewController *control = (UIViewController *)delegate;
            [control.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark ----------------------------- views

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 20)];
        _backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.backView];
    }
    return _backView;
}

- (UIImageView *)lineView{

    if (!lineView_) {
        
        lineView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.width, 1)];
        
        lineView_.backgroundColor = RGBCOLOR(222, 216, 190);
        
        lineView_.image = [UIImage imageNamed:@"cellSeparatorLine.png"];

    }

    return lineView_;
}


- (UILabel *)ruleTitleLabel{

    if (!ruleTitleLabel_) {
        
        ruleTitleLabel_ = [[UILabel alloc] init];
        
        ruleTitleLabel_.backgroundColor = [UIColor clearColor];
        
        ruleTitleLabel_.textAlignment = UITextAlignmentLeft;
        
        ruleTitleLabel_.textColor = [UIColor blackColor];//RGBCOLOR(182,11,87);
        
        ruleTitleLabel_.font = [UIFont fontWithName:@"Verdana-BoldItalic" size:14];
        
        ruleTitleLabel_.numberOfLines = 0;
        
        ruleTitleLabel_.text = L(@"activeRule");
        
        [self.backView addSubview:ruleTitleLabel_];
    }
    
    return ruleTitleLabel_;
}


- (RuleCopyTextView *)ruleContentLabel{
    
    if (!ruleContentLabel_) {
        ruleContentLabel_ = [[RuleCopyTextView alloc] init];
        ruleContentLabel_.backgroundColor = [UIColor clearColor];
        ruleContentLabel_.textAlignment = UITextAlignmentLeft;
        ruleContentLabel_.textColor = [UIColor darkGrayColor];
        ruleContentLabel_.font = [UIFont systemFontOfSize:14];
        ruleContentLabel_.userInteractionEnabled = YES;
        ruleContentLabel_.editable = NO;
        ruleContentLabel_.scrollEnabled = NO;
        ruleContentLabel_.maxLines = 2;
//        [self.contentView addSubview:ruleContentLabel_];
    }
    
    return ruleContentLabel_;
}

-(UIView*)ruleContentView
{
    if (!ruleContentView_) {
        ruleContentView_ =[[UIView alloc] init];
        ruleContentView_.userInteractionEnabled=YES;
        ruleContentView_.backgroundColor= [UIColor whiteColor];
        
//        UILongPressGestureRecognizer *lpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//        lpress.delegate = self;
//        [ruleContentView_ addGestureRecognizer:lpress];
    }
    return ruleContentView_;
}

/* 识别侧滑 */
- (void)longPress:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded){
        if (!self.showDetailBtn.hidden) {
            return;
        }
        [self.ruleContentLabel becomeFirstResponder];
        UIMenuController * menu = [UIMenuController sharedMenuController];
        [menu setTargetRect: CGRectMake(10, 30, 200, 30) inView: [self contentView]];
        [menu setMenuVisible: YES animated: YES];
    }
}

-(UIButton *)showDetailBtn
{
    if (!showDetailBtn_) {
        isShowDetail = NO;
        detailHeight = self.ruleContentLabel.frame.size.height;
        showDetailBtn_ = [[UIButton alloc] init];
        [showDetailBtn_ setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Down.png"] forState:UIControlStateNormal];
        [showDetailBtn_ addTarget:self action:@selector(showDetail) forControlEvents:UIControlEventTouchUpInside];
    }

    return showDetailBtn_;
}

-(UIButton *)bigShowDetailBtn
{
    if (!_bigShowDetailBtn) {
        _bigShowDetailBtn = [[UIButton alloc] init];
        UIFont *cellFont =[UIFont systemFontOfSize:kCotendSize];
        CGSize labelHeight = [self.ruleContent  sizeWithFont:cellFont];
        _bigShowDetailBtn.frame=CGRectMake(0,-30, 320,labelHeight.height+22+10+30 + 20);
        _bigShowDetailBtn.backgroundColor = [UIColor clearColor];
        [_bigShowDetailBtn addTarget:self action:@selector(showDetail) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigShowDetailBtn;
}

- (EGOImageButton *)onCouponButton
{
    if (!_onCouponButton) {
        _onCouponButton = [[EGOImageButton alloc] init];
        _onCouponButton.delegate = self;
        _onCouponButton.frame = CGRectMake(10, 0, 300, 0);
        _onCouponButton.placeholderImage = nil;
        [_onCouponButton addTarget:self
                            action:@selector(goToGetCoupon)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _onCouponButton;
}

//Kristopher
- (void)showDetail
{
    if (!isShowDetail) {
        isShowDetail = YES;
        [showDetailBtn_ setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Up.png"] forState:UIControlStateNormal];
        self.ruleContentLabel.text = [NSString stringWithFormat:@"%@",self.ruleContent];
        
        //2014年06月26日11:32:48 for bug IPHONEII-5235
        self.ruleContentLabel.frame = CGRectMake(10, 0, 270, 0);
        [self.ruleContentLabel sizeToFit];
        if (!IOS7_OR_LATER) {
            CGRect frame = self.ruleContentLabel.frame;
            frame.size.height = self.ruleContentLabel.contentSize.height;
            self.ruleContentLabel.frame = frame;
        }
        self.ruleContentView.frame = CGRectMake(0, 40, 320, self.ruleContentLabel.frame.size.height);
        if (_onCouponButton) {
            [self sizeToFitOnCouponButton];
        }else{
            [self.delegate setAdRowHeight:self.ruleContentView.frame.origin.y + self.ruleContentView.frame.size.height];
        }
    }else{
        isShowDetail = NO;
        [showDetailBtn_ setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Down.png"] forState:UIControlStateNormal];
        
        self.ruleContentLabel.text = [NSString stringWithFormat:@"%@",self.ruleContent];
        
        //2014年06月26日11:32:48 for bug IPHONEII-5235
        CGFloat AdRowHeight = detailHeight + 36;
        
        self.ruleContentView.frame=CGRectMake(0, 30 + 10, 320, detailHeight);
        self.ruleContentLabel.frame=CGRectMake(10, 0, 270, detailHeight);
        if (!IOS7_OR_LATER) {
            self.ruleContentView.frame=CGRectMake(0, 30 + 10, 320, detailHeight+15);
            self.ruleContentLabel.frame=CGRectMake(10, 0, 270, detailHeight);
            AdRowHeight = AdRowHeight + 18;
        }
        if (_onCouponButton) {
            [self sizeToFitOnCouponButton];
        }else{
            [self.delegate setAdRowHeight:AdRowHeight];
        }
    }
}

+ (BOOL)canShowRuleCell:(NSString *)rule;
{
    if (rule.trim.length)
    {
        return YES;
    }
    else
    {
        if ([SNSwitch isOnCouponForImageUrl:NULL webUrl:NULL])
        {
            //送券入口
            return YES;
        }
        else
        {
            return NO;
        }
    }
}

@end

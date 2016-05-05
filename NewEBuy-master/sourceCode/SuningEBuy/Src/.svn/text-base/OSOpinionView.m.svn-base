//
//  OSOpinionView.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-18.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "OSOpinionView.h"

@implementation OSOpinionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgMask];
        [self addSubview:self.contentView];
        
        [self headFillBar];
        [self exitButton];
        [self continueButton];
        
        [self tableView];
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, self.contentView.width, 0.5)];
        v.backgroundColor = [UIColor light_Gray_Color];
        [self.contentView addSubview:v];
        //    [self button1];
        //    [self button2];
        //    [self button3];
        //    [self button4];
        //    [self button5];
        
        
    }
    return self;
}

#pragma mark ----------------------------- layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

#pragma mark ----------------------------- subviews

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        CGRect frame = self.contentView.bounds;
        frame.origin.y = 60;
        frame.size.height = 111;
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.scrollEnabled = NO;
        
        [self.contentView addSubview:_tableView];
    }
    
    return _tableView;
}

- (UIControl *)bgMask
{
    if (!_bgMask)
    {
        _bgMask = [[UIControl alloc] initWithFrame:self.bounds];
        _bgMask.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _bgMask.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
        [_bgMask addTarget:self action:@selector(touchBackground:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgMask;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.frame = CGRectMake(0, 0, 270., 237);
        _contentView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        CGRect contentRect = self.contentView.bounds;
        CGRect bgImageSize = CGRectMake(
                                        contentRect.origin.x - 4.5,
                                        contentRect.origin.y - 2,
                                        contentRect.size.width + 9,
                                        contentRect.size.height + 8.5);
        _bgImageView.frame = bgImageSize;
        _bgImageView.image = [UIImage streImageNamed:@"os_opinion_bg.png"];
        [self.contentView addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (UIImageView *)markView
{
    if (!_markView) {
        _markView = [[UIImageView alloc] init];
       // CGRect contentRect = self.contentView.bounds;
        CGRect bgImageSize = CGRectMake(130,17,12,9);
        _markView.frame = bgImageSize;
        _markView.image = [UIImage streImageNamed:@"cellMark.png"];
        //[self.contentView addSubview:_bgImageView];
    }
    return _markView;
}

- (UILabel *)tipLabel1
{
    if (!_tipLabel1) {
        _tipLabel1 = [[UILabel alloc] init];
        _tipLabel1.frame = CGRectMake(91, 12, 90, 17);
        _tipLabel1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _tipLabel1.backgroundColor = [UIColor clearColor];
        _tipLabel1.numberOfLines = 0;
        _tipLabel1.font = [UIFont systemFontOfSize:13.0f];
        _tipLabel1.textColor = [UIColor dark_Gray_Color];
        _tipLabel1.textAlignment = UITextAlignmentCenter;
        _tipLabel1.text = L(@"感谢您的咨询");
    }
    return _tipLabel1;
}

- (UILabel *)tipLabel2
{
    if (!_tipLabel2) {
        _tipLabel2 = [[UILabel alloc] init];
        _tipLabel2.frame = CGRectMake(56, 30, 160, 17);
        _tipLabel2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _tipLabel2.backgroundColor = [UIColor clearColor];
        _tipLabel2.numberOfLines = 0;
        _tipLabel2.font = [UIFont systemFontOfSize:13.0f];
        _tipLabel2.textColor = [UIColor dark_Gray_Color];
        _tipLabel2.textAlignment = UITextAlignmentCenter;
        _tipLabel2.text = L(@"请对我们的服务进行评价");
    }
    return _tipLabel2;
}

//添加x按钮
- (UIButton *)closeButton
{
    if(!_closeButton){
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(0, 0, 44, 44);
        [_closeButton setImage:[UIImage imageNamed:@"button_closed_normal"] forState:UIControlStateNormal];
        _closeButton.center = CGPointMake(self.contentView.width, 0);
        _closeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        [_closeButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

//退出按钮
- (UIButton *)exitButton
{
    if(!_exitButton){
        _exitButton = [[UIButton alloc] init];
        _exitButton.frame = CGRectMake(15, 186, 114, 35);
        _exitButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _exitButton.backgroundColor = [UIColor btnTitleHotColor];
        [_exitButton setTitle:@"直接退出" forState:UIControlStateNormal];
        _exitButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_exitButton setTitleColor:[UIColor light_White_Color] forState:UIControlStateNormal];
        [_exitButton addTarget:self action:@selector(selectExit) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_exitButton];
    }
    return _exitButton;
}

//继续咨询按钮
- (UIButton *)continueButton
{
    if(!_continueButton){
        _continueButton = [[UIButton alloc] init];
        _continueButton.frame = CGRectMake(141, 186, 114, 35);
        _continueButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _continueButton.backgroundColor = [UIColor clearColor];
        [_continueButton setTitle:@"继续咨询" forState:UIControlStateNormal];
        _continueButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_continueButton setTitleColor:[UIColor btnTitleNormalColor] forState:UIControlStateNormal];
        [_continueButton addTarget:self action:@selector(selectContinue) forControlEvents:UIControlEventTouchUpInside];
        CGFloat w = _continueButton.width;
        CGFloat h = _continueButton.height;
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 0.5)];
        line1.backgroundColor = [UIColor light_Gray_Color];
        [_continueButton addSubview:line1];
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, h-0.5, w, 0.5)];
        line2.backgroundColor = [UIColor light_Gray_Color];
        [_continueButton addSubview:line2];
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, h)];
        line3.backgroundColor = [UIColor light_Gray_Color];
        [_continueButton addSubview:line3];
        UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(w-0.5, 0, 0.5, h)];
        line4.backgroundColor = [UIColor light_Gray_Color];
        [_continueButton addSubview:line4];
        [self.contentView addSubview:_continueButton];
    }
    return _continueButton;
}

//头部添加label
- (UIImageView *)headFillBar
{
    if(!_headFillBar){
        _headFillBar = [[UIImageView alloc] init];
        _headFillBar.frame = CGRectMake(0, 0, self.contentView.width, 60);
        _headFillBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _headFillBar.backgroundColor = [UIColor colorWithRGBHex:0xf2f2f2];
        [_headFillBar addSubview:self.tipLabel1];
        [_headFillBar addSubview:self.tipLabel2];
        [self.contentView addSubview:_headFillBar];
    }
    return _headFillBar;
}

//直接退出
- (void)selectExit
{
    [self hide:YES];
}

//继续咨询
- (void)selectContinue
{
    [self hide:NO];
}

- (void)closeView
{
    [self hide:NO];
}

- (void)touchBackground:(id)sender
{
    [self hide:NO];
}

- (void)showInView:(UIView *)view withOption:(int)source
{
    //点击退出
    if(source == 1){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.closeButton.alpha = 0;
        self.exitButton.alpha = 1;
        self.continueButton.alpha = 1;
    }else{//点击评价
        self.contentView.backgroundColor = [UIColor clearColor];
        self.closeButton.alpha = 1;
        self.exitButton.alpha = 0;
        self.continueButton.alpha = 0;
    }
    [view addSubview:self];
    [self bounce0Animation];
}

- (CGAffineTransform)transformForOrientation
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5f);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2.0f);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
}

- (void)bounce0Animation{
    self.contentView.transform = CGAffineTransformScale([self transformForOrientation], 0.001f, 0.001f);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f/1.5f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationDidStop)];
    self.contentView.transform = CGAffineTransformScale([self transformForOrientation], 1.1f, 1.1f);
    [UIView commitAnimations];
}

- (void)bounce1AnimationDidStop{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationDidStop)];
    self.contentView.transform = CGAffineTransformScale([self transformForOrientation], 0.9f, 0.9f);
    [UIView commitAnimations];
}

- (void)bounce2AnimationDidStop{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounceDidStop)];
    self.contentView.transform = [self transformForOrientation];
    [UIView commitAnimations];
}

- (void)bounceDidStop{
    
    [self addSubview:self.closeButton];
    self.closeButton.frame = [self.contentView convertRect:self.closeButton.frame toView:self];
}


- (dispatch_block_t)hide:(BOOL)complete
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         self.alpha = 0;
                         
                     } completion:^(BOOL finished) {
                         
                         if (complete && self.completeBlock) {
                             self.completeBlock();
                         }
                         
                         [self removeFromSuperview];
                     }];
    
    return self.completeBlock;
}
#pragma mark ----------------------------- tableView dataSource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    OSMsgDTO *msg = [self.chatDTO.sessionMsgs objectAtIndex:indexPath.row];
//    return msg.layoutCellHeight;
    return 37;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellIdentifier = @"messageCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
        cell.textLabel.textColor = [UIColor light_Black_Color];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.backgroundColor = [UIColor whiteColor];
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(15, 36.5, cell.width-30, 0.5)];
        v.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        v.backgroundColor = [UIColor light_Gray_Color];
        [cell.contentView addSubview:v];
    }
    
    switch (indexPath.row) {
        
        case 0:{
            
            cell.textLabel.text = L(@"Satisfaction");
        }
            break;
        case 1:{
            
            cell.textLabel.text = L(@"OnlineService_Normal");
        }
            break;
        case 2:{
            
            cell.textLabel.text = L(@"DisSatisfaction");
        }
            break;
            
        default:
            break;
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell  *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryView = self.markView;
     
    NSInteger index = indexPath.row;
    
    if (index < 3 && index >= 0)
    {
        /**
         *  修复顺序错误的问题
         *  @author liukun
         */
        int opinions[3] = {OSOpinionScoreSatified,OSOpinionScoreGeneral,OSOpinionScoreNotSatisfied};
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([_delegate respondsToSelector:@selector(opinionView:didOpinion:)])
        {
            [_delegate opinionView:self didOpinion:opinions[index]];
        }
#pragma clang diagnostic pop
        
    }
    
}
@end

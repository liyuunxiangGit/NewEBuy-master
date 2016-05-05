//
//  ProducetDetailBaseViewController.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProducetDetailBaseViewController.h"

@interface ProducetDetailBaseViewController ()

@end

@implementation ProducetDetailBaseViewController

@synthesize leftView = _leftView;
@synthesize midView = _midView;
@synthesize rightView = _rightView;

-(void)dealloc{
    
    
    TT_RELEASE_SAFELY(_baseInfoBtn);
    TT_RELEASE_SAFELY(_introduceBtn);
    TT_RELEASE_SAFELY(_appraiseBtn);
    
    TT_RELEASE_SAFELY(_btnArray);
    
    TT_RELEASE_SAFELY(_appraseBtnArray);
    
//    TT_RELEASE_SAFELY(_appraisVC);
    
    TT_RELEASE_SAFELY(_headBackView);
    
    TT_RELEASE_SAFELY(_lineView);
    
    TT_RELEASE_SAFELY(_leftView);
    
    TT_RELEASE_SAFELY(_midView);
    
    TT_RELEASE_SAFELY(_rightView);
    
    TT_RELEASE_SAFELY(_backScrollView);
}

- (UIImageView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_line.png"]];
        _lineView.backgroundColor = [UIColor clearColor];
        [self.headBackView addSubview:_lineView];
    }
    return _lineView;
}

-(UIImageView *)headBackView{
    
    if (!_headBackView) {
        
        _headBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 4, 320, 30)];
        _headBackView.backgroundColor = [UIColor clearColor];
        _headBackView.userInteractionEnabled = YES;
        _headBackView.image = [UIImage imageNamed:@"search_normal_new.png"];
        
        [self.view addSubview:_headBackView];
    }
    
    return _headBackView;
}
-(UIButton *)baseInfoBtn{
    
    if (!_baseInfoBtn) {
        
        _baseInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 4, 107, 32)];
        [_baseInfoBtn addTarget:self action:@selector(btnChangeTabAction:) forControlEvents:UIControlEventTouchUpInside];
       [_baseInfoBtn setBackgroundImage:nil forState:UIControlStateNormal];
       [_baseInfoBtn setBackgroundImage:[UIImage imageNamed:@"search_fouce_left.png"] forState:UIControlStateSelected];
        [_baseInfoBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
        [_baseInfoBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
        _baseInfoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_baseInfoBtn setTitle:L(@"DJ_Good_BaseInfo") forState:UIControlStateNormal];
        _baseInfoBtn.selected = YES;
        
        self.selectType = SelectLeftBtn;
        
        [self.view addSubview:_baseInfoBtn];
    }
    return _baseInfoBtn;
}

-(UIButton *)introduceBtn{
    
    if (!_introduceBtn) {
        
        _introduceBtn = [[UIButton alloc] initWithFrame:CGRectMake(107, 4, 107, 32)];
        [_introduceBtn addTarget:self action:@selector(btnChangeTabAction:) forControlEvents:UIControlEventTouchUpInside];
        [_introduceBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [_introduceBtn setBackgroundImage:[UIImage imageNamed:@"search_fouce_middle.png"] forState:UIControlStateSelected];
        [_introduceBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
        [_introduceBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
        [_introduceBtn setTitle:L(@"DJ_Good_IntroduceInfo") forState:UIControlStateNormal];
        _introduceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:_introduceBtn];
    }
    return _introduceBtn;
}

-(UIButton *)appraiseBtn{
    
    if (!_appraiseBtn) {
        
        _appraiseBtn = [[UIButton alloc] initWithFrame:CGRectMake(214, 4, 107, 32)];
        [_appraiseBtn addTarget:self action:@selector(btnChangeTabAction:) forControlEvents:UIControlEventTouchUpInside];
        [_appraiseBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [_appraiseBtn setBackgroundImage:[UIImage imageNamed:@"search_fouce_right.png"] forState:UIControlStateSelected];
        [_appraiseBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
        [_appraiseBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
        [_appraiseBtn setTitle:L(@"Product_Comment") forState:UIControlStateNormal];
        _appraiseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:_appraiseBtn];
    }
    return _appraiseBtn;
}
-(NSArray *)btnArray{
    
    if (!_btnArray) {
        
        _btnArray = [[NSArray alloc] initWithObjects:self.baseInfoBtn,self.introduceBtn,self.appraiseBtn, nil];
    }
    return _btnArray;
}

-(UIView *)leftView{
    
    if (!_leftView) {
        
        
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 36, 320, 460)];
        _leftView.backgroundColor = [UIColor redColor];
        
        [self.backScrollView addSubview:_leftView];
    }
    
    return _leftView;
}

-(void)setLeftView:(UIView *)leftView{

    [_leftView removeFromSuperview];
    
    _leftView = leftView;
    [self.backScrollView addSubview:_leftView];
}
-(UIView *)midView{
    
    if (!_midView) {
        
        
        _midView = [[UIView alloc] initWithFrame:CGRectMake(320, 36, 320, 460)];
        _midView.backgroundColor = [UIColor clearColor];
        [self.backScrollView addSubview:_midView];
    }
    
    return _midView;
}
-(void)setMidView:(UIView *)midView{
    
    [_midView removeFromSuperview];
    
    _midView = midView;
    
    [self.backScrollView addSubview:_midView];
}

-(UIView *)rightView{
    
    if (!_rightView) {
        
        
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(640, 36, 320, 460)];
        _rightView.backgroundColor = [UIColor clearColor];
        [self.backScrollView addSubview:_rightView];
    }
    
    return _rightView;
}

-(void)setRightView:(UIView *)rightView{
    
    [_rightView removeFromSuperview];
    
    _rightView = rightView;
    
    
    [self.backScrollView addSubview:_rightView];
}

- (UIScrollView *)backScrollView
{
    if (!_backScrollView)
    {
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 36, 320, self.view.size.height - 20 - 36 - 74)];
        _backScrollView.scrollEnabled = YES;
        _backScrollView.showsVerticalScrollIndicator =  NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
        _backScrollView.alwaysBounceHorizontal = YES;
        _backScrollView.pagingEnabled = YES;
        _backScrollView.delegate = self;
        _backScrollView.contentSize = CGSizeMake(self.leftView.size.width + self.midView.size.width + self.rightView.size.width, self.view.size.height - 20 - 36 - 74);
    }
    return _backScrollView;
}

#pragma mark - UISCrollView Delegate Methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.backScrollView)
    {
        CGPoint ptOffset = self.backScrollView.contentOffset;
        if (ptOffset.x == 0)
        {
            UIButton *btn = (UIButton *)[self.btnArray objectAtIndex:0];
            [self btnChangeTabAction:btn];
        }
        else if (ptOffset.x == 320)
        {
            UIButton *btn = (UIButton *)[self.btnArray objectAtIndex:1];
            [self btnChangeTabAction:btn];
        }
        else if (ptOffset.x == 640)
        {
            UIButton *btn = (UIButton *)[self.btnArray objectAtIndex:2];
            [self btnChangeTabAction:btn];
        }
    }
}

- (SNShareKit *)shareKit
{
    if (!_shareKit) {
        _shareKit = [[SNShareKit alloc] initWithNavigationController:self.navigationController];
    }
    return _shareKit;
}
#pragma mark -
#pragma mark 自定义方法


-(void)btnChangeTabAction:(UIButton *)btn{
    
    //当改按钮没有选中时 点击该按钮响应一下操作
    if (!btn.isSelected) {
        
        //该按钮设为选中
        //其他按钮改为 非选中
        for (int i=0;i<[self.btnArray count];i++) {
            
            UIButton *obj = (UIButton *)[self.btnArray objectAtIndex:i];
            if (btn != obj) {
                
                obj.selected = NO;
            }
            else{
                
                obj.selected = YES;
                self.selectType = i;
            }
        }
        
        [self viewChangeWithType:self.selectType];
    }
}

-(void)viewChangeWithType:(BtnSelectType)type{
    

    switch (type) {
        case SelectLeftBtn:
            //基本信息
            [self showBaseView];
            break;
        case SelectMidBtn:
            //商品介绍
            [self showIntroduceView];
            break;
        case SelectRightBtn:
            //评价
            [self showAppraiseView];
            break;
            
        default:
            break;
    }
}

-(void)showBaseView{
    
//    self.leftView.hidden = NO;
//    self.midView.hidden = YES;
//    self.rightView.hidden = YES;
    [self.backScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    self.lineView.hidden = NO;
    self.lineView.frame = CGRectMake(self.introduceBtn.right, 0, 1, 31);
    
//    [self.view bringSubviewToFront:self.leftView];
}
-(void)showIntroduceView{
    
//    self.leftView.hidden = YES;
//    self.midView.hidden = NO;
//    self.rightView.hidden = YES;
    [self.backScrollView setContentOffset:CGPointMake(320, 0) animated:YES];
    
    self.lineView.hidden = YES;
   // self.lineView.frame = CGRectMake(self.introduceBtn.right, 0, 1, 31);
//    [self.view bringSubviewToFront:self.midView];
}
-(void)showAppraiseView{
    
//    self.leftView.hidden = YES;
//    self.midView.hidden = YES;
//    self.rightView.hidden = NO;
    
    [self.backScrollView setContentOffset:CGPointMake(640, 0) animated:YES];
    self.lineView.hidden = NO;
    self.lineView.frame = CGRectMake(self.baseInfoBtn.right, 0, 1, 31);
    
//    [self.view bringSubviewToFront:self.rightView];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadView{
    
    [super loadView];
    
    [self headBackView];
    
    self.lineView.frame = CGRectMake(self.introduceBtn.right, 0, 1, 31);
//    //分享按钮
//    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
//                                    initWithTitle:L(@"Share")
//                                    style:UIBarButtonItemStylePlain
//                                    target:self
//                                    action:@selector(share)];
//    
//    self.navigationItem.rightBarButtonItem = shareButton;
//    TT_RELEASE_SAFELY(shareButton);

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.5, 0, 0)];
    [btn setTitleColor:[UIColor colorWithRGBHex:0x444444] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"right_item_light_btn.png"] forState:UIControlStateNormal];
    [btn setTitle:L(@"Share") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 6, 50, 32);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];

    self.navigationItem.rightBarButtonItem = item;
    
    [self.view addSubview:self.backScrollView];
    [self btnArray];
    [self showBaseView];
    
   // [self initAppraseView];
}

//- (void)swipeFinished:(UISwipeGestureRecognizer *)ges
//{
//    int selectedBtnIndex = 0;
//    if (ges.direction == UISwipeGestureRecognizerDirectionLeft)
//    {
//        for (int i=0;i<[self.btnArray count];i++)
//        {
//            UIButton *obj = (UIButton *)[self.btnArray objectAtIndex:i];
//            if (obj.selected == YES)
//            {
//                selectedBtnIndex = i;
//                break;
//            }
//        }
//        
//        if (selectedBtnIndex == 2)
//            selectedBtnIndex = 0;
//        else
//        {
//            selectedBtnIndex++;
//        }
//        
//    }
//    else if (ges.direction == UISwipeGestureRecognizerDirectionRight)
//    {
//        for (int i=0;i<[self.btnArray count];i++)
//        {
//            UIButton *obj = (UIButton *)[self.btnArray objectAtIndex:i];
//            if (obj.selected == YES)
//            {
//                selectedBtnIndex = i;
//                break;
//            }
//        }
//        
//        if (selectedBtnIndex == 0)
//            selectedBtnIndex = 2;
//        else
//        {
//            selectedBtnIndex--;
//        }
//    }
//    UIButton *btn = (UIButton *)[self.btnArray objectAtIndex:selectedBtnIndex];
//    [self btnChangeTabAction:btn];
//}

//点击分享
- (void)share
{
    
}

//-(void)initAppraseView{
//    
//    //评论的头部的背景
//    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
//    headView.backgroundColor = [UIColor colorWithRed:246.0/255 green:242.0/255 blue:229.0/255 alpha:1];
//   // [self.rightView addSubview:headView];
//   // [headView release];
//    
//    UIButton *goodBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 35, 107, 30)];
//    [goodBtn setTitle:@"好评" forState:UIControlStateNormal];
//    [goodBtn addTarget:self action:@selector(appraiseChanged:) forControlEvents:UIControlEventTouchUpInside];
//    [goodBtn setBackgroundImage:nil forState:UIControlStateNormal];
//    [goodBtn setBackgroundImage:[UIImage imageNamed:@"search_fouce_left.png"] forState:UIControlStateSelected];
//    [goodBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    [goodBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [headView addSubview:goodBtn];
//    TT_RELEASE_SAFELY(goodBtn);
//    
//    UIButton *midBtn = [[UIButton alloc] initWithFrame:CGRectMake(107, 35, 107, 30)];
//    [midBtn setTitle:@"中评" forState:UIControlStateNormal];
//    [midBtn addTarget:self action:@selector(appraiseChanged:) forControlEvents:UIControlEventTouchUpInside];
//    [midBtn setBackgroundImage:nil forState:UIControlStateNormal];
//    [midBtn setBackgroundImage:[UIImage imageNamed:@"search_fouce_left.png"] forState:UIControlStateSelected];
//    [midBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    [midBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [headView addSubview:midBtn];
//    
//    
//    UIButton *badBtn = [[UIButton alloc] initWithFrame:CGRectMake(214, 35, 107, 30)];
//    [badBtn setTitle:@"差评" forState:UIControlStateNormal];
//    [badBtn addTarget:self action:@selector(appraiseChanged:) forControlEvents:UIControlEventTouchUpInside];
//    [badBtn setBackgroundImage:nil forState:UIControlStateNormal];
//    [badBtn setBackgroundImage:[UIImage imageNamed:@"search_fouce_left.png"] forState:UIControlStateSelected];
//    [badBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    [badBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [headView addSubview:badBtn];
//    
// //   self.appraseBtnArray = [[NSArray alloc] initWithObjects:goodBtn,midBtn,badBtn, nil];
//    
// //   [_appraseBtnArray release];
//    
//   
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Table View Delegate Methods

////无评价信息时提示用户，用户点击确定后返回"商品详情"界面
//- (void)BackToProductDetail:(NSString *)message{
//    
//    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error") message:L(message) delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
//    alert.tag = 226;
//    [alert show];
//    [alert release];
//    
//    
//}


@end

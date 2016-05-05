//
//  DJGroupDetailBaseViewController.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupDetailBaseViewController.h"
#import "MyPhoto.h"
#import "MyPhotoSource.h"
#import "EGOPhotoViewController.h"

@interface DJGroupDetailBaseViewController ()

@property(nonatomic, assign) CGRect contentFrame;

@end


@implementation DJGroupDetailBaseViewController

@synthesize shareKit = _shareKit;
@synthesize segmentView = _segmentView;
@synthesize introduceView = _introduceView;
@synthesize contentView = _contentView;
@synthesize introduceContentView = _introduceContentView;
@synthesize appraisalContentView = _appraisalContentView;
@synthesize contentFrame = _contentFrame;
@synthesize appraisalTableView = _appraisalTableView;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_shareKit);
    TT_RELEASE_SAFELY(_segmentView);
    TT_RELEASE_SAFELY(_introduceView);
    TT_RELEASE_SAFELY(_introduceContentView);
    TT_RELEASE_SAFELY(_appraisalContentView);
    TT_RELEASE_SAFELY(_contentView);
    TT_RELEASE_SAFELY(_appraisalTableView);
    
}

- (void)loadView
{
    [super loadView];

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

    self.contentFrame = [self getContentFrame];
    
    self.groupTableView.frame = CGRectMake(0, 4, 320, self.contentFrame.size.height - 90);
    [self.groupTableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 8.0f, 0.0f)];
    [self.contentView addSubview:self.groupTableView];
    
//    self.appraisalTableView.frame = CGRectMake(0, 4, 320, self.contentFrame.size.height - 90);
//    [self.appraisalTableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 8.0f, 0.0f)];
//    [self.appraisalContentView addSubview:self.appraisalTableView];
    
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.contentView];
    [self.backScrollView addSubview:self.introduceContentView];
    [self.backScrollView addSubview:self.appraisalContentView];
//    [self.view addSubview:self.contentView];
//    [self.view addSubview:self.introduceContentView];
//    [self.view addSubview:self.appraisalContentView];
}

- (void)righBarClick
{
    [self share];
}

- (CGRect)getContentFrame
{
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    frame.origin.y = kSegmentHeight;
    frame.size.width = 320;
    frame.size.height = self.view.size.height - kSegmentHeight;
    return frame;
}

//点击分享
- (void)share
{
    
}

#pragma mark - ScrollView Delegate Methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.backScrollView)
    {
        CGPoint ptOffset = self.backScrollView.contentOffset;
        DLog(@"%@", [NSValue valueWithCGPoint:ptOffset]);
        
        if (ptOffset.x == 0)
        {
            self.segmentView.selectIndex = 0;
            [self.segmentView refreshButtons];
            [self didSelectSegmentAtIndex:0];
        }
        else if (ptOffset.x == 320)
        {
            self.segmentView.selectIndex = 1;
            [self.segmentView refreshButtons];
            [self didSelectSegmentAtIndex:1];
        }
        else if (ptOffset.x == 640)
        {
            self.segmentView.selectIndex = 2;
            [self.segmentView refreshButtons];
            [self didSelectSegmentAtIndex:2];
        }
    }
}

#pragma mark - DJGroupDetailSegmentViewDelegate methods

- (void)didSelectSegmentAtIndex:(NSInteger)index
{
    [NSException raise:NSInternalInconsistencyException format:@"you must ovrride %@ in a subclass",NSStringFromSelector(@selector(didSelectSegmentAtIndex:))];
}

#pragma mark - IntroduceViewDelegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView{
	[self displayOverFlowActivityView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	[self removeOverFlowActivityView];
	self.introduceView.isNeedData = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	[self removeOverFlowActivityView];
    self.introduceView.isNeedData = YES;
}

#pragma mark - 属性方法

- (SNShareKit *)shareKit
{
    if (!_shareKit) {
        _shareKit = [[SNShareKit alloc] initWithNavigationController:self.navigationController];
    }
    return _shareKit;
}

- (DJGroupDetailSegmentView *)segmentView
{
    if (!_segmentView) {
        _segmentView = [[DJGroupDetailSegmentView alloc] init];
        _segmentView.userInteractionEnabled = YES;
        _segmentView.delegate = self;
    }
    return _segmentView;
}

- (DJGroupDetailIntroduceView *)introduceView
{
    if (!_introduceView) {
        _introduceView = [[DJGroupDetailIntroduceView alloc] initWithFrame:CGRectMake(0, 0, 320, self.contentFrame.size.height - 90)];
        _introduceView.delegate = self;
        [self.introduceContentView addSubview:_introduceView];
//        _introduceView.hidden = YES;
    }
    return _introduceView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentFrame.size.width, self.contentFrame.size.height)];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UIView *)introduceContentView
{
    if (!_introduceContentView) {
        _introduceContentView = [[UIView alloc] initWithFrame:CGRectMake(320, 0, self.contentFrame.size.width, self.contentFrame.size.height)];
        _introduceContentView.backgroundColor = [UIColor clearColor];
        //_introduceContentView.hidden = YES;
    }
    return _introduceContentView;
}

- (UIView *)appraisalContentView
{
    if (!_appraisalContentView) {
        _appraisalContentView = [[UIView alloc] initWithFrame:CGRectMake(640, 0, self.contentFrame.size.width, self.contentFrame.size.height)];
        _appraisalContentView.backgroundColor = [UIColor clearColor];
        //_appraisalContentView.hidden = YES;
    }
    return _appraisalContentView;
}

- (UITableView *)appraisalTableView{
	
	if(!_appraisalTableView){
		
		_appraisalTableView = [[UITableView alloc] initWithFrame:CGRectZero
												  style:UITableViewStylePlain];
		
		[_appraisalTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_appraisalTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_appraisalTableView.scrollEnabled = YES;
		
		_appraisalTableView.userInteractionEnabled = YES;
		
		_appraisalTableView.delegate =self;
		
		_appraisalTableView.dataSource =self;
		
		_appraisalTableView.backgroundColor =[UIColor clearColor];
        
        _appraisalTableView.backgroundView = nil;
		
	}
	
	return _appraisalTableView;
}

- (UIScrollView *)backScrollView
{
    if (!_backScrollView)
    {
        _backScrollView = [[UIScrollView alloc] initWithFrame:self.contentFrame];
        _backScrollView.scrollEnabled = YES;
        _backScrollView.showsVerticalScrollIndicator =  NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
        _backScrollView.alwaysBounceHorizontal = YES;
        _backScrollView.pagingEnabled = YES;
        _backScrollView.delegate = self;
        _backScrollView.contentSize = CGSizeMake(self.contentView.size.width + self.introduceContentView.size.width + self.appraisalContentView.size.width, self.contentFrame.size.height);
    }
    return _backScrollView;
}

//ProductImageCellDelegate
- (void)didTouchImageAtIndex:(NSInteger)index
             withSmallImages:(NSArray *)imageUrls
                andBigImages:(NSArray *)bigImageUrls
{
    NSMutableArray *sourceArr = [[NSMutableArray alloc] initWithCapacity:[bigImageUrls count]];
    for (NSURL *url in bigImageUrls)
    {
        MyPhoto *photo = [[MyPhoto alloc] initWithImageURL:url];
        [sourceArr addObject:photo];
    }
    MyPhotoSource *source = [[MyPhotoSource alloc] initWithPhotos:sourceArr];
    
    EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:source];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:photoController];
    
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    if (IOS5_OR_LATER)
    {
        [self presentViewController:navController animated:YES completion:^{
            photoController.scrollView.alpha = 1;
            [photoController moveToPhotoAtIndex:index animated:NO];
        }];
    }
    else
    {
        [self presentModalViewController:navController animated:YES];
        photoController.scrollView.alpha = 1;
        [photoController moveToPhotoAtIndex:index animated:NO];
    }
    
    TT_RELEASE_SAFELY(navController);
    TT_RELEASE_SAFELY(photoController);
    TT_RELEASE_SAFELY(source);
}

@end

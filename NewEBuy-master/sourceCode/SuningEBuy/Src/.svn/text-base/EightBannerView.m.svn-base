//
//  EightBannerView.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "EightBannerView.h"

#import "AppDelegate.h"
#import "HomeTopScrollAdDTO.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

#define kBannerScrollViewFrame    CGRectMake(0, 0, 320, 148)
//CGRectMake(0, 0, 320, 120) CGRectMake(0, 0, 320, 172)
#define kBannerPageControlFrame   CGRectMake(0, 145, 320, 3)
//CGRectMake(0, 90, 320, 20) CGRectMake(0, 169, 320, 3)

@interface EightBannerView()

@property (nonatomic, strong) UIView           *pageControlBGLayer;

@end


@implementation EightBannerView

@synthesize delegate = _delegate;
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize pageControlBGLayer = _pageControlBGLayer;
@synthesize topBannerList = _topBannerList;
@synthesize imagesArray = _imagesArray;
@synthesize curImages = _curImages;
@synthesize bgImageView = _bgImageView;

- (void)dealloc {
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_pageControl);
    TT_RELEASE_SAFELY(_pageControlBGLayer);
    TT_RELEASE_SAFELY(_topBannerList);
    TT_RELEASE_SAFELY(_imagesArray);
    TT_RELEASE_SAFELY(_curImages);
    TT_RELEASE_SAFELY(_bgImageView);
    
}

- (id)init {
    self = [super init];
    if (self)
    {
        self.frame = kBannerScrollViewFrame;
        self.backgroundColor = [UIColor cell_Back_Color];
        if (!_imagesArray) {
            _imagesArray = [[NSMutableArray alloc] init];
        }
        if (!_curImages) {
            _curImages = [[NSMutableArray alloc] init];
        }
        if ([_imagesArray count] == 0 || IsArrEmpty(_imagesArray))
        {
            _bgImageView = [[EGOImageViewEx alloc] initWithFrame:kBannerScrollViewFrame];
            
            [_bgImageView setImage:_bgImageView.placeholderImage];
            
            _bgImageView.userInteractionEnabled = NO;
            
            [self addSubview:_bgImageView];

//            [self addSubview:self.pageControlBGLayer];
        }
    }
    return self;
}

- (void)setEightBan
{
    if (![self.topBannerList count] || !self.topBannerList)
    {
        return;
    }
    
    totalPage = self.topBannerList.count;
    
    self.pageControl.numberOfPages = totalPage;
    
    
    //设置八连版背景
//    CGSize size = [self.pageControl sizeForNumberOfPages:totalPage];
//    CGRect frame = self.pageControl.frame;
//    
//    float pCWidth = size.width;
//    frame.origin.x = (self.frame.size.width-pCWidth-20)/2;
//    frame.size.width = pCWidth+20;
    
    self.pageControl.frame = kBannerPageControlFrame;
    //设置八连版背景end
    

    _currentPage = 1;                                    // 显示的是图片数组里的第一张图片
    
//    for (int i=0;i<[self.topBannerList count];i++)
    [_imagesArray removeAllObjects];
    
    for (int i=0;i<totalPage;i++)
    {
        HomeTopScrollAdDTO *adDto = [self.topBannerList objectAtIndex:i];
        
        [_imagesArray addObject:adDto.bigImageURL];
    }
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:kBannerScrollViewFrame];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    
    [self addSubview:self.pageControl];
//    [self addSubview:self.pageControlBGLayer];
    // 在水平方向滚动
    if ([self.topBannerList count]>2)
    {
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * [self.topBannerList count],
                                             _scrollView.frame.size.height);
    }
    else
    {
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 3,
                                             _scrollView.frame.size.height);
    }
    
    
    [self refreshScrollView];

}

- (void)refreshScrollView {
    
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    if ([_imagesArray count] == 0 || IsArrEmpty(_imagesArray))
    {
        _bgImageView.hidden = NO;
        return;
    }
    
    _bgImageView.hidden = YES;
    
    [self getDisplayImagesWithCurpage:_currentPage];
    
    for (int i = 0; i < 3; i++) {
        EGOImageViewEx *imageView = [[EGOImageViewEx alloc] initWithFrame:kBannerScrollViewFrame];
        imageView.userInteractionEnabled = YES;
        imageView.imageURL = [NSURL URLWithString:[_curImages objectAtIndex:i]];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTap:)];
        [imageView addGestureRecognizer:singleTap];
        
        // 水平滚动
        imageView.frame = CGRectOffset(imageView.frame, kBannerScrollViewFrame.size.width * i, 0);
                
        [_scrollView addSubview:imageView];
        
        TT_RELEASE_SAFELY(imageView);
    }
    
    [_scrollView setContentOffset:CGPointMake(kBannerScrollViewFrame.size.width, 0)];
    
    self.pageControl.currentPage = _currentPage-1;
}

- (NSArray *)getDisplayImagesWithCurpage:(int)page {
    
    int pre = [self validPageValue:_currentPage-1];
    int last = [self validPageValue:_currentPage+1];
    
    if([_curImages count] != 0) [_curImages removeAllObjects];
    
    [_curImages addObject:[_imagesArray objectAtIndex:pre-1]];
    [_curImages addObject:[_imagesArray objectAtIndex:_currentPage-1]];
    [_curImages addObject:[_imagesArray objectAtIndex:last-1]];
    
    return _curImages;
}

- (int)validPageValue:(NSInteger)value {
    
    if(value == 0) value = totalPage;                   // value＝1为第一张，value = 0为前面一张
    if(value == totalPage + 1) value = 1;
    
    return value;
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    int x = aScrollView.contentOffset.x;
    
    // 水平滚动
        // 往下翻一张
    if(x >= (2*kBannerScrollViewFrame.size.width)) {
        _currentPage = [self validPageValue:_currentPage+1];
        [self refreshScrollView];
    }
    if(x <= 0) {
        _currentPage = [self validPageValue:_currentPage-1];
        [self refreshScrollView];
    }
    
    if ([_delegate respondsToSelector:@selector(cycleScrollViewDelegate:didScrollImageView:)]) {
        [_delegate cycleScrollViewDelegate:self didScrollImageView:_currentPage];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{        
    [_scrollView setContentOffset:CGPointMake(kBannerScrollViewFrame.size.width, 0) animated:YES];
}

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"11010%d",_currentPage], nil]];
    if ([_delegate respondsToSelector:@selector(cycleScrollViewDelegate:didSelectImageView:)])
    {
        [_delegate cycleScrollViewDelegate:self didSelectImageView:_currentPage];
    }
}

//拖动触发，自动滚动不触发
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(advertisementView:willChangeDragState:)])
    {
        [self.delegate advertisementView:self willChangeDragState:ScrollDragBegin];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([self.delegate respondsToSelector:@selector(advertisementView:willChangeDragState:)])
    {
        [self.delegate advertisementView:self willChangeDragState:ScrollDragEnd];
    }
}



#pragma mark -
#pragma mark  eightBanner subviews

- (UIView *)pageControlBGLayer
{
    if (!_pageControlBGLayer) {
        _pageControlBGLayer = [[UIView alloc] init];
        _pageControlBGLayer.frame = kBannerPageControlFrame;
        _pageControlBGLayer.backgroundColor = [UIColor clearColor];//RGBACOLOR(0, 0, 0, 0.2);
        _pageControlBGLayer.hidden = YES;
    }
    return _pageControlBGLayer;
}

- (HomePageControlView *)pageControl
{
    if(!_pageControl)
    {
		_pageControl = [[HomePageControlView alloc] init];
        _pageControl.frame = kBannerPageControlFrame;
        _pageControl.backgroundColor = [UIColor clearColor];//RGBACOLOR(0, 0, 0, 0.2);
//        _pageControl.layer.cornerRadius = 5;
//        _pageControl.formPage = 9;
        _pageControl.maxPoint = 8;
        _pageControl.imageSelected = [UIImage streImageNamed:@"home_page_control_orange.png"];
        _pageControl.imageNormal = [UIImage streImageNamed:@"home_page_control_white.png"];
//        [_pageControl addTarget:self action:@selector(scrollToPage:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
        [_pageControl bringSubviewToFront:self.scrollView];
	}
	return _pageControl;
}

- (void)scrollToPage:(id)sender
{
    if(_currentPage == totalPage)
    {
        _currentPage = 1;
    }
    else
    {
        _currentPage++;
    }
    [self refreshScrollView];   
}

- (void)changePage:(id)sender
{
    if(_currentPage == totalPage)
    {
        _currentPage = 1;
    }
    else
    {
        _currentPage++;
    }
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    
    [self.scrollView.layer addAnimation:animation forKey:nil];
    
    [self refreshScrollView];
    
}

- (void)updateTopBanner:(NSArray *)topBannerArray
{
    self.topBannerList = topBannerArray;
    
    int count = [topBannerArray count];
    
    self.pageControl.numberOfPages = count;
    
    [self setEightBan];
}

#pragma mark -
#pragma mark EightBannerImagePageCellDelegate

- (void)didSelectAd:(HomeTopScrollAdDTO *)ad
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickAd:)]) {
        [_delegate didClickAd:ad];
    }
}

@end

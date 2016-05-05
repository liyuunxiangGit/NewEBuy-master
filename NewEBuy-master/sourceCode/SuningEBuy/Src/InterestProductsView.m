//
//  InterestProductsView.m
//  SuningEBuy
//
//  Created by shasha on 12-8-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "InterestProductsView.h"

@interface InterestProductsView (){
    
    NSInteger currentPageNumber_;
    
    NSInteger totalPage_;
}

@end


@implementation InterestProductsView
@synthesize infoLabel = _infoLabel;
@synthesize scrollView = _scrollView;
@synthesize productList = _productList;
@synthesize delegate = _delegate ;
@synthesize pageControl = _pageControl;

- (void)dealloc {
    TT_RELEASE_SAFELY(_infoLabel);
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_productList);
    TT_RELEASE_SAFELY(_pageControl);
    _delegate = nil;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        currentPageNumber_ = 0;
        
        _productList = [[NSMutableArray alloc] init];
        
        self.infoLabel.tag = 0;
        
    }
    
    return self;
}


- (void)showIntrestedProductView:(NSMutableArray *)productList{
    
    if (_productList != productList) {
        
        TT_RELEASE_SAFELY(_productList);
        
        _productList = productList;
        
        if (self.productList == nil || [self.productList count] == 0) {
            totalPage_ = 0;
        }
        if ([self.productList count] % 3 == 0) {
            totalPage_ = [self.productList count]/3;
        }else {
            totalPage_ = [self.productList count]/3+1;
        }
        
    }
    

    [self.scrollView reloadData];
    
    self.pageControl.numberOfPages = totalPage_;
    
    self.pageControl.currentPage = currentPageNumber_;
            
}


#pragma mark - NJPageScrollView data source and delegate

- (NSInteger)numberOfPagesInPageScrollView:(NJPageScrollView *)pageScrollView
{
    return totalPage_;  
}

- (NJPageScrollViewCell *)pageScrollView:(NJPageScrollView *)pageScrollView cellForPage:(NSInteger)page
{
    static NSString *pageIdentifier = @"pageIdentifier";
    MyEbuyHotSalePage *pageCell = (MyEbuyHotSalePage *)[pageScrollView dequeueReusablePageWithIdentifier:pageIdentifier];
    if (pageCell == nil) {
        pageCell = [[MyEbuyHotSalePage alloc] initWithReuseIdentifier:pageIdentifier];
        pageCell.delegate = self;
    }
    [pageCell setItem:self.productList range:NSMakeRange(3*page, 3)];
    return pageCell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.productList count] == 0)
    {
        return;
    }
    
    CGFloat pageWidth = 320;
    
    CGFloat content =  scrollView.contentOffset.x - currentPageNumber_ * pageWidth;
    
    if ((content / pageWidth == (int)(content / pageWidth)) && content != 0)
    {
        int page = scrollView.contentOffset.x / pageWidth;
                
        if (currentPageNumber_ != page)
        {
            currentPageNumber_ = page;
        }        
    }  
    
    self.pageControl.currentPage = currentPageNumber_;
}

- (void)didSelectHotSaleProduct:(DataProductBasic *)product
{    

    if ([self.delegate respondsToSelector:@selector(didSelectIntrestProduct:)]) {
        
        [self.delegate didSelectIntrestProduct:product];
    }
}

#pragma mark - 
#pragma mark Properties Initialization Methods

- (NJPageScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[NJPageScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 30, 320, 140);
        _scrollView.delegate = self;
        _scrollView.dataSource = self;
        //_scrollView.backgroundColor = RGBCOLOR(250, 248, 240);
        _scrollView.maxWidth = 320;
        _scrollView.scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}


-(UILabel *)infoLabel{

    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 3, 300, 30)];
        _infoLabel.text = L(@"interest products");
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.textColor = RGBCOLOR(49, 49, 49);
        _infoLabel.font = [UIFont systemFontOfSize:14.0];
        
        UIView *vBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
        vBack.backgroundColor = [UIColor clearColor];
        
        [self addSubview:vBack];
        [self addSubview:_infoLabel];
        
    }
    
    return _infoLabel;
 
}

- (UIPageControl *)pageControl{

    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] init];
        
        _pageControl.frame = CGRectMake(0, 180, 320, 20);
        //[_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        UIView *vBack = [[UIView alloc] initWithFrame:_pageControl.frame];
        vBack.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
        
        [self addSubview:vBack];
        [self addSubview:_pageControl];
        
    }
    return _pageControl;
}

//-(void)pageChanged:(UIPageControl*)pc{
//    NSArray *subViews = pc.subviews;
//    for (int i = 0; i < [subViews count]; i++) {
//        UIView* subView = [subViews objectAtIndex:i];
//        if ([NSStringFromClass([subView class]) isEqualToString:NSStringFromClass([UIImageView class])]) {
//            ((UIImageView*)subView).image = (pc.currentPage == i ? [UIImage imageNamed:@"RedPoint.png"] : [UIImage imageNamed:@"BluePoint.png"]);
//        }
//    }
//}

@end

//
//  NDetailHeadProImages.m
//  SuningEBuy
//
//  Created by xmy on 12/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NDetailHeadProImages.h"
#import "ProductUtil.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

@implementation NDetailHeadProImages

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
               
        self.dataSource = self;
        
        self.delegate = self;
        
        self.scrollEnabled = NO;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (NSArray*)imagesArr
{
    if(!_imagesArr)
    {
        _imagesArr = [[NSArray alloc] init];
    }
    
    return _imagesArr;
}

- (void)setNDetailHeadImagesArr:(NSArray *)imagesArr
{
    self.imagesArr = imagesArr;
        
    [self reloadData];
}

- (NJPageScrollView*)pageScroll
{
    if(!_pageScroll)
    {
        _pageScroll = [[NJPageScrollView alloc] init];
        
        _pageScroll.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
        
        _pageScroll.backgroundColor = [UIColor clearColor];
        
        _pageScroll.dataSource = self;
        
        _pageScroll.delegate = self;
    }
    
    return _pageScroll;
}

- (MyPageControl *)myPageControl
{
    
    if (!_myPageControl) {
        
        _myPageControl = [[MyPageControl alloc] init];
        
        _myPageControl.frame = CGRectMake(0, 38, self.frame.size.width, 20);
        
        _myPageControl.imageNormal = [UIImage imageNamed:@"productDetail_image_normal.png"];
        
        _myPageControl.imageSelected = [UIImage imageNamed:@"productDetail_image_selected.png"];
        
        _myPageControl.maxPoint = 8;
        
        [_myPageControl addTarget:self action:@selector(scrollToPage:) forControlEvents:UIControlEventValueChanged];
        
        self.currentPageNumber = 0;
        
        [self.pageScroll addSubview:_myPageControl];
        
    }
    return _myPageControl;
    
}

- (void)scrollToPage:(id)sender
{
    UIPageControl *pageControl = (UIPageControl *)sender;
    NSInteger page = pageControl.currentPage;
    [self.pageScroll setContentOffset:CGPointMake(self.pageScroll.frame.size.width*page, 0) animated:YES];
}

#pragma mark -
#pragma NJPageScrollViewDataSource And Delegate
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.width;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"NDetailHeadProImagesCell-tableView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.backgroundColor = [UIColor clearColor];
    }
    
    [cell.contentView addSubview:self.pageScroll];
    
    self.myPageControl.numberOfPages = [self.imagesArr count];
    
    self.myPageControl.currentPage = self.currentPageNumber;
            
    return cell;
}

#pragma mark -
#pragma NJPageScrollViewDataSource And Delegate
- (NSInteger)numberOfPagesInPageScrollView:(NJPageScrollView *)pageScrollView
{
    return [self.imagesArr count];
}


- (NJPageScrollViewCell*)pageScrollView:(NJPageScrollView *)pageScrollView cellForPage:(NSInteger)page
{
    static NSString *pageIndentifier = @"NDetailHeadProImagesCell";
    
    NDetailHeadProImagesCell *pageCell = (NDetailHeadProImagesCell *)[pageScrollView dequeueReusablePageWithIdentifier:pageIndentifier];
    if (pageCell == nil)
    {
        pageCell = [[NDetailHeadProImagesCell alloc] initWithReuseIdentifier:pageIndentifier];
     
        pageCell.frame = self.pageScroll.bounds;
    }
    
    NSURL *url = [self.imagesArr objectAtIndex:page];
    
    [pageCell setImageUrl:url atIndex:page];
    
    [pageCell.imageViewBtn addTarget:self action:@selector(imageBtnAction) forControlEvents:UIControlEventTouchUpInside];

    
    return pageCell;
}

- (void)pageScrollView:(NJPageScrollView *)scrollView didScrollToPage:(NJPageScrollViewCell *)page atIndex:(NSInteger)index
{

}

- (void)imageBtnAction
{
    DLog(@"imageBtnAction");
     [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121301"], nil]];
    if ([_touchImagesDelegate respondsToSelector:@selector(didTouchNDetailHeadImageAtIndex:withSmallImages:andBigImages:)])
    {
        NSArray *bigImages = nil;//[ProductUtil getBigImageUrlList:self.item];
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]
            && !self.item.isABook) {
            
            bigImages = [ProductUtil getImageUrlListWithProduct:self.item
                                                           size:ProductImageSize800x800];
            
        }
        else{
            bigImages = [ProductUtil getImageUrlListWithProduct:self.item
                                                           size:ProductImageSize400x400];
        }
        
        [_touchImagesDelegate didTouchNDetailHeadImageAtIndex:self.currentPageNumber
                                              withSmallImages:self.imagesArr
                                                 andBigImages:bigImages];
    }

    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.frame.size.width;
    
    CGFloat content =  scrollView.contentOffset.x - self.currentPageNumber * pageWidth;
    
    if ((content / pageWidth == (int)(content / pageWidth)) && content != 0)
    {
        int page = scrollView.contentOffset.x / pageWidth;
        
        self.myPageControl.currentPage = page;
        
        if (self.currentPageNumber != page)
        {
            self.currentPageNumber = page;
            
            if ([self.imagesArr count] > self.currentPageNumber+2)
            {
                NSURL *url = [self.imagesArr objectAtIndex:self.currentPageNumber+2];
                SNImageCachePreloadImages(@[url]);
            }
        }
    }

}

@end

@implementation NDetailHeadProImagesCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
        
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}

- (EGOImageButton*)imageViewBtn
{
    if(!_imageViewBtn)
    {        
        _imageViewBtn = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        
        _imageViewBtn.backgroundColor = [UIColor clearColor];
        
    }
    
    return _imageViewBtn;
}

- (void)setImageUrl:(NSURL *)imageUrl atIndex:(NSInteger)index
{
    self.imageViewBtn.imageURL = imageUrl;
        
    [self addSubview:self.imageViewBtn];
}




@end

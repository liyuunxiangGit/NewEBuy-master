//
//  UICCRefreshTableFooterView.m
//  CCRefreshCommonTableView
//
//  Created by xzoscar on 14-8-15.
//  Copyright (c) 2014年 xzoscar. All rights reserved.
//

#import "UICCRefreshTableFooterView.h"

@interface UICCRefreshTableFooterView ()

@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic,strong) IBOutlet UIImageView             *customImgView;
@property (nonatomic,strong) IBOutlet UILabel                 *textLabel; // status label
@property (nonatomic,strong) IBOutlet UILabel                 *dateLabel;

@end


@implementation UICCRefreshTableFooterView

+ (UICCRefreshTableFooterView *)refreshTableFooterView {
    return ([[NSBundle mainBundle] loadNibNamed:@"UICCRefreshTableFooterView" owner:self options:nil][0]);
}

- (void)refreshLastUpdatedDate {
//    NSDateFormatter *formart = [[NSDateFormatter alloc] init];
//    [formart setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
//    _dateLabel.text = [formart stringFromDate:[NSDate date]];
}

- (void)setState:(kUICC_EGOPullRefreshState)aState {
    
    _state = aState;
    
	switch (_state) {
		case kUICC_EGOPullRefreshPulling: { // {{{
			
			[self.textLabel setText:L(@"LCFreeMeYouGetMore")];
            self.customImgView.hidden = NO;
            
            [UIView animateWithDuration:kUICC_FLIP_ANIMATION_DURATION
                             animations:^{
                                 self.customImgView.transform = CATransform3DGetAffineTransform(CATransform3DIdentity);
                             }];
			break;
        } // }}}
		case kUICC_EGOPullRefreshNormal: { // {{{
			
            self.customImgView.hidden = NO;
            
			if (_state == kUICC_EGOPullRefreshPulling) {
                [UIView animateWithDuration:kUICC_FLIP_ANIMATION_DURATION
                                 animations:^{
                                     self.customImgView.transform = CATransform3DGetAffineTransform(CATransform3DIdentity);
                                 }];
			}
            [self.textLabel setText:L(@"LCUpMeYouGetMore")];// Pull up to load more...
            
			[self.activityIndicatorView stopAnimating];
            
            CATransform3D tansform3D = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            [UIView animateWithDuration:kUICC_FLIP_ANIMATION_DURATION
                             animations:^{
                                 self.customImgView.transform = CATransform3DGetAffineTransform(tansform3D);
                             }];
            
			[self refreshLastUpdatedDate];
			break;
        }// }}}
		case kUICC_EGOPullRefreshLoading: { // {{{
			
            [self.textLabel setText:L(@"LCLoading...")];// Loading...
			[self.activityIndicatorView startAnimating];
            
            self.customImgView.hidden = YES;
            
			break;
        }
        case kUICC_EGOPullRefreshLoaded: {
            [self.textLabel setText:L(@"LCLoaded")];// Loading...
			[self.activityIndicatorView stopAnimating];
            self.customImgView.hidden = YES;
        }// }}}
        case kUICC_EGOPullLoadMoreClose: {
            [self.textLabel setText:L(@"LCNowWithoutMore")];
            [self.activityIndicatorView stopAnimating];
            self.customImgView.hidden = YES;
        }
		default:
			break;
	}
}

- (UIEdgeInsets)edgeInsets:(UIScrollView *)sc {
    
    return  UIEdgeInsetsMake((sc.contentSize.height<=sc.frame.size.height)?-kUICC_REFRESH_REGION_HEIGHT:.0f
                             ,.0f,
                             (sc.contentSize.height>sc.frame.size.height)?kUICC_REFRESH_REGION_HEIGHT:.0f,
                             .0f);
}

#pragma mark - UIScrollView scroll action

- (void)uiccActionRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentSize.height <= scrollView.frame.size.height) {
        // 数数据列表 不足一屏幕时，这是不可以 通过footerRefreshView刷新
        self.hidden = YES;
    }else {
        self.hidden = NO;
        
        CGSize sz = scrollView.bounds.size;
        CGFloat y = MAX(scrollView.contentSize.height,sz.height);
        self.frame = CGRectMake(.0f,y,sz.width,sz.height);
        
        // {{{
        if (self.state == kUICC_EGOPullRefreshLoading) {
            
            CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
            offset = MIN(offset, 60);
            //scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f,kUICC_REFRESH_REGION_HEIGHT, 0.0f);
            scrollView.contentInset = [self edgeInsets:scrollView];//UIEdgeInsetsMake(-kUICC_REFRESH_REGION_HEIGHT,.0f,.0f,.0f);
            
        } else if (scrollView.isDragging) { // {{{ 正在拖动 且 没有正在加载数据
            
            BOOL _loading = NO;
            if ([self.delegate respondsToSelector:@selector(delegate_uiccRefreshTableView_dataSourceIsLoading:)]) {
                _loading = [self.delegate delegate_uiccRefreshTableView_dataSourceIsLoading:self];
            }
            
            if (self.state == kUICC_EGOPullRefreshPulling
                && !_loading
                && (scrollView.contentOffset.y+scrollView.frame.size.height)<(scrollView.contentSize.height+kUICC_REFRESH_REGION_HEIGHT)
                && scrollView.contentOffset.y > 0.0f ) {
                [self setState:kUICC_EGOPullRefreshNormal];
                
            } else if ( !_loading
                       && self.state == kUICC_EGOPullRefreshNormal
                       && (scrollView.contentOffset.y+scrollView.frame.size.height)>(scrollView.contentSize.height+kUICC_REFRESH_REGION_HEIGHT)) {
                [self setState:kUICC_EGOPullRefreshPulling];
            }
            
            if (scrollView.contentInset.top != 0) {
                scrollView.contentInset = UIEdgeInsetsZero;
            }
        } // }}}
    }
}

- (void)uiccActionRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    
    if (scrollView.contentSize.height <= scrollView.frame.size.height) {
        // 数数据列表 不足一屏幕时，这是不可以 通过footerRefreshView刷新
        self.hidden = YES;
    }else {
        self.hidden = NO;
        
        // {{{
        BOOL _loading = NO;
        if ([self.delegate respondsToSelector:@selector(delegate_uiccRefreshTableView_dataSourceIsLoading:)]) {
            _loading = [self.delegate delegate_uiccRefreshTableView_dataSourceIsLoading:self];
        }
        
        if (!_loading &&
            (scrollView.contentOffset.y+scrollView.frame.size.height)>(scrollView.contentSize.height+kUICC_REFRESH_REGION_HEIGHT)) {
            
            // trigger,加载数据 状态改为 loading
            if ([self.delegate respondsToSelector:@selector(delegate_uiccRefreshTableView_didTriggerRefresh:)]) {
                [self.delegate delegate_uiccRefreshTableView_didTriggerRefresh:self];
            }
            
            [self setState:kUICC_EGOPullRefreshLoading];
            
           
            
            [UIView animateWithDuration:kUICC_FLIP_ANIMATION_DURATION
                             animations:^{
                                 scrollView.contentInset = [self edgeInsets:scrollView];
                             }];
        } // }}}
    }
}

// 数据加载完成，更改state为 kUICC_EGOPullRefreshNormal
- (void)uiccActionRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    
    if (!self.isCloseLoadMore) {
        [self setState:kUICC_EGOPullRefreshLoaded];
    }
    
    UIScrollView *__weak weakScrollView = scrollView;
    
    [UIView animateWithDuration:.3f animations:^{
        weakScrollView.contentInset = UIEdgeInsetsZero;
    } completion:^(BOOL finished) {
        
        if (finished) {
            CGSize sz = weakScrollView.bounds.size;
            CGFloat y = MAX(weakScrollView.contentSize.height,sz.height);
            self.frame = CGRectMake(.0f,y,sz.width,sz.height);
            
            if (self.isCloseLoadMore) {
                [self setState:kUICC_EGOPullLoadMoreClose];
            }else {
                [self setState:kUICC_EGOPullRefreshNormal];
            }
        }
    }];
}

- (void)setIsLoading:(BOOL)isLoading {
    _isLoading = isLoading;
    if (!_isLoading) {
        [self uiccActionRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView*)self.superview];
    }
}

@end

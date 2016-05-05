//
//  UICCRefreshTableHeaderView.m
//  CCRefreshCommonTableView
//
//  Created by xzoscar on 14-8-16.
//  Copyright (c) 2014年 xzoscar. All rights reserved.
//

#import "UICCRefreshTableHeaderView.h"

@interface UICCRefreshTableHeaderView ()

@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic,strong) IBOutlet UIImageView             *customImgView;
@property (nonatomic,strong) IBOutlet UILabel                 *textLabel; // status label
@property (nonatomic,strong) IBOutlet UILabel                 *dateLabel;

@property (nonatomic,assign) kUICC_EGOPullRefreshState state;

@end

@implementation UICCRefreshTableHeaderView

+ (UICCRefreshTableHeaderView *)refreshTableHeaderView {
    UICCRefreshTableHeaderView *v = ([[NSBundle mainBundle] loadNibNamed:@"UICCRefreshTableHeaderView" owner:self options:nil][0]);
    v.state = kUICC_EGOPullRefreshNormal;
    return v;
}

- (void)refreshLastUpdatedDate {
    NSDateFormatter *formart = [[NSDateFormatter alloc] init];
    [formart setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    _dateLabel.text = [formart stringFromDate:[NSDate date]];
}

- (void)setState:(kUICC_EGOPullRefreshState)aState {
    
	switch (aState) {
		case kUICC_EGOPullRefreshPulling: { // {{{
            self.customImgView.hidden = NO;
			
			[self.textLabel setText:L(@"LCFreeMeYouGetMore")]; // Release to refresh...
            
            [UIView animateWithDuration:kUICC_FLIP_ANIMATION_DURATION
                             animations:^{
                                 self.customImgView.transform = CATransform3DGetAffineTransform(CATransform3DIdentity);
                             }];
			break;
        } // }}}
		case kUICC_EGOPullRefreshNormal: { // {{{
			
			if (_state == kUICC_EGOPullRefreshPulling) {
                [UIView animateWithDuration:kUICC_FLIP_ANIMATION_DURATION
                                 animations:^{
                                     self.customImgView.transform = CATransform3DGetAffineTransform(CATransform3DIdentity);
                                 }];
			}
            [self.textLabel setText:L(@"LCPullDownToRefresh")];// Pull down to refresh...
            
			[self.activityIndicatorView stopAnimating];
            
            CATransform3D tansform3D = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            [UIView animateWithDuration:kUICC_FLIP_ANIMATION_DURATION
                             animations:^{
                                 self.customImgView.hidden = NO;
                                 self.customImgView.transform = CATransform3DGetAffineTransform(tansform3D);
                             }];
            
			[self refreshLastUpdatedDate];
			break;
        }// }}}
		case kUICC_EGOPullRefreshLoading: { // {{{
			
            [self.textLabel setText:L(@"LCLoading...")];// Loading...
			[self.activityIndicatorView startAnimating];
            
            [UIView animateWithDuration:kUICC_FLIP_ANIMATION_DURATION
                             animations:^{
                                 self.customImgView.hidden = YES;
                             }];
			
			break;
        } // }}}
		default:
			break;
	}
    
    _state = aState;
}

#pragma mark - UIScrollView scroll action

- (void)uiccActionRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    
    // {{{
    if (self.state == kUICC_EGOPullRefreshLoading) {
        
        CGFloat offset = MAX(scrollView.contentOffset.y * -1,0);
        //offset = MIN(offset, 60.0f);
        scrollView.contentInset = UIEdgeInsetsMake(kUICC_REFRESH_REGION_HEIGHT,.0f,.0f,.0f);
        
    } else if (scrollView.isDragging) { // {{{ 正在拖动 且 没有正在加载数据
        
        
        BOOL _loading = NO;
        if ([self.delegate respondsToSelector:@selector(delegate_uiccRefreshTableView_dataSourceIsLoading:)]) {
            _loading = [self.delegate delegate_uiccRefreshTableView_dataSourceIsLoading:self];
        }
        
        if (self.state == kUICC_EGOPullRefreshPulling
            && !_loading
            && (scrollView.contentOffset.y > -kUICC_REFRESH_REGION_HEIGHT
                && scrollView.contentOffset.y < .0f)) {
                [self setState:kUICC_EGOPullRefreshNormal];
                
            } else if ( !_loading
                       && self.state == kUICC_EGOPullRefreshNormal
                       && scrollView.contentOffset.y < -kUICC_REFRESH_REGION_HEIGHT) {
                [self setState:kUICC_EGOPullRefreshPulling];
            }
        
        if (scrollView.contentInset.top != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
    } // }}}
}


- (void)uiccActionRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    // {{{
    BOOL _loading = NO;
    if ([self.delegate respondsToSelector:@selector(delegate_uiccRefreshTableView_dataSourceIsLoading:)]) {
        _loading = [self.delegate delegate_uiccRefreshTableView_dataSourceIsLoading:self];
    }
    
    if (!_loading &&
        (scrollView.contentOffset.y <= -kUICC_REFRESH_REGION_HEIGHT)) {
        
        // trigger,加载数据 状态改为 loading
        if ([self.delegate respondsToSelector:@selector(delegate_uiccRefreshTableView_didTriggerRefresh:)]) {
            [self.delegate delegate_uiccRefreshTableView_didTriggerRefresh:self];
        }
        
        [self setState:kUICC_EGOPullRefreshLoading];
        
        UIScrollView *__weak weakScrollView = scrollView;
        [UIView animateWithDuration:.2f
                         animations:^{
                             weakScrollView.contentInset = UIEdgeInsetsMake(kUICC_REFRESH_REGION_HEIGHT,.0f,.0f,.0f);
                         }];
    } // }}}
}

// 数据加载完成，更改state为 kUICC_EGOPullRefreshNormal
- (void)uiccActionRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    [self setState:kUICC_EGOPullRefreshNormal];
    
    [UIView animateWithDuration:.3f animations:^{
        [scrollView setContentInset:UIEdgeInsetsZero];
    }];
    
}

- (void)setIsLoading:(BOOL)isLoading {
    _isLoading = isLoading;
    if (!_isLoading) {
         [self uiccActionRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)self.superview];
    }
}

@end

//
//  HistorySearchView.m
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "HistorySearchView.h"

@implementation HistorySearchView

@synthesize noHistoryLabel = _noHistoryLabel;
@synthesize delAllButtonView = _delAllButtonView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        

    }
    return self;
}

- (id)initWithOwner:(id)owner {
    self = [super initWithOwner:owner];
    if (self) {
        CGRect frame1 = [[UIScreen mainScreen] bounds];
        
        CGFloat height = frame1.size.height - 172 - 32.5 - kUITabBarFrameHeight - kStatusBarHeight;
        
        CGRect frame = CGRectMake(0, 204.5, 320, height);
        self.frame = frame;
//        self.backgroundColor = [UIColor blueColor];
        //最近搜索
        self.tableView.delegate = self.owner;
        self.tableView.frame = CGRectMake(0, 0, 320, height);
        self.tableView.hidden = NO;
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)dealloc{
    TT_RELEASE_SAFELY(_noHistoryLabel);
    TT_RELEASE_SAFELY(_delAllButtonView);
    
}

- (UILabel *)noHistoryLabel
{
    if (!_noHistoryLabel) {
        _noHistoryLabel = [[UILabel alloc] init];
        _noHistoryLabel.frame = CGRectMake(0, 0, 320, 200);
        _noHistoryLabel.textAlignment = UITextAlignmentCenter;
        _noHistoryLabel.backgroundColor = [UIColor clearColor];
        _noHistoryLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _noHistoryLabel.textColor = [UIColor darkGrayColor];
        _noHistoryLabel.text = L(@"No history keywords");
        _noHistoryLabel.shadowColor = [UIColor whiteColor];
        _noHistoryLabel.shadowOffset = CGSizeMake(1, 1);
    }
    return _noHistoryLabel;
}

- (UIView *)delAllButtonView
{
    if (!_delAllButtonView) {
        _delAllButtonView = [[UIView alloc] init];
        _delAllButtonView.backgroundColor = [UIColor clearColor];
        _delAllButtonView.frame = CGRectMake(0, 0, 320, 46);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30, 5, 260, 36);
        UIImage *image = [UIImage imageNamed:@"yellowButton_new.png"];
        UIImage *streImage = [image stretchableImageWithLeftCapWidth:60 topCapHeight:0];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [button setBackgroundImage:streImage forState:UIControlStateNormal];
        [button setTitle:L(@"Delete all history keywords") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clearSearchHistorys) forControlEvents:UIControlEventTouchUpInside];
        [_delAllButtonView addSubview:button];
        
    }
    return _delAllButtonView;
}

- (void)clearSearchHistorys
{
    if ([self.owner respondsToSelector:@selector(clearSearchHistorys)]) {
        [self.owner clearSearchHistorys];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

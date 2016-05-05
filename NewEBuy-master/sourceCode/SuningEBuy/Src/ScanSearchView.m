//
//  ScanSearchView.m
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ScanSearchView.h"

@implementation ScanSearchView

@synthesize scanTableView = _scanTableView;
@synthesize noScanHistoryLabel=_noScanHistoryLabel;
@synthesize delAllScanButtonView=_delAllScanButtonView;

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
        
//        int statusbarHeight = 0;
//        if (!IOS7_OR_LATER)
//            statusbarHeight = 20;
        CGFloat height = frame1.size.height - 172 - 40 - 44 - kUITabBarFrameHeight - kStatusBarHeight;
        
        CGRect frame = CGRectMake(0, 172 + 40 + 44, 320, height);
        self.frame = frame;
        //最近浏览
        self.scanTableView.delegate = self.owner;
        self.scanTableView.frame = self.bounds;
        self.scanTableView.hidden = NO;
        [self addSubview:self.scanTableView];
    }

    return self;
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_scanTableView);
    TT_RELEASE_SAFELY(_noScanHistoryLabel);
    TT_RELEASE_SAFELY(_delAllScanButtonView);
}


- (UILabel *)noScanHistoryLabel
{
    if (!_noScanHistoryLabel) {
        _noScanHistoryLabel = [[UILabel alloc] init];
        _noScanHistoryLabel.frame = CGRectMake(0, 0, 320, 200);
        _noScanHistoryLabel.textAlignment = UITextAlignmentCenter;
        _noScanHistoryLabel.backgroundColor = [UIColor clearColor];
        _noScanHistoryLabel.font = [UIFont systemFontOfSize:14.0];
        _noScanHistoryLabel.textColor = [UIColor colorWithRGBHex:0x707070];
        _noScanHistoryLabel.text = L(@"No scan history keywords");
    }
    return _noScanHistoryLabel;
}

- (UIView *)delAllScanButtonView
{
    if (!_delAllScanButtonView) {
        _delAllScanButtonView = [[UIView alloc] init];
        _delAllScanButtonView.backgroundColor = RGBCOLOR(242, 242, 242);
        _delAllScanButtonView.frame = CGRectMake(0, 0, 320, 36);
        _delAllScanButtonView.userInteractionEnabled = YES;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30, 0, 260, 36);
//        UIImage *image = [UIImage imageNamed:@"yellowButton_new.png"];
//        UIImage *streImage = [image stretchableImageWithLeftCapWidth:60 topCapHeight:0];
//        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0];
//        [button setBackgroundImage:streImage forState:UIControlStateNormal];
//        button.layer.borderWidth = 1;
//        button.layer.borderColor = RGBCOLOR(120, 120, 120).CGColor;
        [button setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateHighlighted];
        button.backgroundColor =  [UIColor clearColor];
        
        [button setTitle:L(@"Delete all scan history keywords") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cleanScanHistory) forControlEvents:UIControlEventTouchUpInside];
        [_delAllScanButtonView addSubview:button];
        
    }
    return _delAllScanButtonView;
}

- (UITableView *)scanTableView{
	
	
	if(!_scanTableView){
		
        _scanTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                      style:UITableViewStylePlain];
		
		
		[_scanTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_scanTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_scanTableView.scrollEnabled = YES;
		
		_scanTableView.userInteractionEnabled = YES;
		
		_scanTableView.backgroundColor = [UIColor clearColor];
        
        _scanTableView.backgroundView = nil;
        
        _scanTableView.delegate = self.owner;
        
        _scanTableView.dataSource = self.owner;
	}
	
	return _scanTableView;
}


- (void)cleanScanHistory
{
    if ([self.owner respondsToSelector:@selector(cleanScanHistory)]) {
        [self.owner cleanScanHistory];
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

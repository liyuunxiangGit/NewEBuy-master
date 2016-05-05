//
//  BrandRecommend244.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#define KBrandImageTag    13000
#import "BrandRecommend244.h"

@implementation BrandRecommend244

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        self.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
        
        //10px的楼层间距
        UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenHeight, KSpace)];
        grayView.backgroundColor = [UIColor clearColor];
        [self addSubview:grayView];
        TT_RELEASE_SAFELY(grayView);
        
        //40px高度的title
        [self addSubview:self.titleBackgourdView];
        
        //分割线
        UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSpace, frame.size.width, 0.5)];
        titleImageView.image = [UIImage streImageNamed:@"line.png"];
        [self addSubview:titleImageView];
        TT_RELEASE_SAFELY(titleImageView);

        [self addSubview:self.titleLabel];
        [self addSubview:self.moreButton];
        
        //显示品牌的滚动视图
        brandScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KTitleHeight+KSpace, frame.size.width, 90+20)];
        brandScrollView.backgroundColor = [UIColor whiteColor];
        brandScrollView.pagingEnabled = YES;
        brandScrollView.delegate = self;
        brandScrollView.showsHorizontalScrollIndicator = NO;
        brandScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:brandScrollView];
        
        //指示页
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, KTitleHeight+90+KSpace, frame.size.width, 18)];
        if (IOS6_OR_LATER) {
            pageControl.pageIndicatorTintColor = [UIColor colorWithRGBHex:0xd3d3d3];
            pageControl.currentPageIndicatorTintColor = [UIColor orange_Light_Color];
        }
//        [pageControl addTarget:self action:@selector(pageControlChange:)forControlEvents:UIControlEventValueChanged];
        [self addSubview:pageControl];
        
        //底部需要画一条横线
        UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        bottomImageView.image = [UIImage streImageNamed:@"line.png"];
        [self addSubview:bottomImageView];
        TT_RELEASE_SAFELY(bottomImageView);
    }
    return self;
}


- (UIView *)titleBackgourdView {
    if (!_titleBackgourdView) {
        _titleBackgourdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0+KSpace, self.frame.size.width, KTitleHeight)];
        _titleBackgourdView.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleBackgourdView];
    }
    return _titleBackgourdView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0+KSpace, kScreenWidth-60, KTitleHeight)];
        _titleLabel.font = [UIFont fontWithName:@"Arial" size:17.0];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#313131"];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.text = L(@"BrandRecommend");
        _titleLabel.lineBreakMode = UILineBreakModeClip;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] initWithFrame:CGRectMake(265, 5+KSpace, 50, KTitleHeight-5)];
        [_moreButton addTarget:self action:@selector(moreBUttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_moreButton setTitle:L(@"BTMore") forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:17.0];
        [_moreButton setTitleColor:[UIColor colorWithHexString:@"#FC7C26"] forState:UIControlStateNormal];;
        _moreButton.hidden = YES;
    }
    return _moreButton;
}

- (void)moreBUttonClick {
    NSArray *moduleList = _floorDTO.moduleList;
    if (_delegate && [_delegate respondsToSelector:@selector(selectModuleDTO:)]) {
        [_delegate selectModuleDTO:[moduleList safeObjectAtIndex:0]];
    }
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 94], nil]];
}


- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx {
    NSArray *moduleList = _floorDTO.moduleList;
    int flag = imageViewEx.tag - KBrandImageTag;
    if (_delegate && [_delegate respondsToSelector:@selector(selectModuleDTO:)]) {
        [_delegate selectModuleDTO:[moduleList safeObjectAtIndex:flag]];
    }
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 94+flag], nil]];
}


- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto {
    
    //若为空数组，则直接返回
    if (IsNilOrNull(dto)) {
        return;
    }
    
    _floorDTO = dto;
    
    //移除旧的UI元素
    NSArray *oldArray = [brandScrollView subviews];
    [oldArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    HomeModuleDTO *moduleDTO_0 = [dto.moduleList safeObjectAtIndex:0];
    //标题
    self.titleLabel.text = moduleDTO_0.moduleName ? moduleDTO_0.moduleName : @"";
    
    //若没有配置目标URL，则不显示更多按钮
    if (IsStrEmpty(moduleDTO_0.targetURL)) {
        self.moreButton.hidden = YES;
    }
    else {
        self.moreButton.hidden = NO;
    }
    
    if (!IsStrEmpty(moduleDTO_0.bgColor)) {
        self.titleBackgourdView.backgroundColor = [UIColor colorWithHexString:moduleDTO_0.bgColor];
    }
    else {
        self.titleBackgourdView.backgroundColor = [UIColor whiteColor];
    }
    
    int pageCount = (int )ceilf(([dto.moduleList count] - 1)/8.0);
    //设置pageControl
    if (pageCount == 0) {
        pageControl.hidden = YES;
    }
    else {
        pageControl.hidden = NO;
    }
    pageControl.numberOfPages = pageCount;
    pageControl.currentPage = 0;
    
 
    brandScrollView.contentOffset = CGPointZero;
    brandScrollView.contentSize = CGSizeMake(self.frame.size.width * pageCount, 110);
    int imageWidth = self.frame.size.width / 4;
    
    for (int n = 1; n <= pageCount; n++) {
        for (int j = 0; j < 8; j++) {
            int index = (n-1)*8+j+1;
            if (index >= [dto.moduleList count]) {
                break;
            }
            
            HomeModuleDTO *moduleDTO = [dto.moduleList safeObjectAtIndex:index];
            EGOImageViewEx *brandImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake((n-1) *kScreenWidth + j % 4 * imageWidth , j / 4 * 45, imageWidth, 45)];
            brandImageView.exDelegate =  self;
            brandImageView.placeholderImage = nil;
            brandImageView.tag = KBrandImageTag + index;
            brandImageView.backgroundColor = [UIColor whiteColor];
            brandImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]];
            [brandScrollView addSubview:brandImageView];
            TT_RELEASE_SAFELY(brandImageView);
        }
    }
    
    //画边框  segment_vertical_line.png  [UIImage streImageNamed:@"line.png"]
    for (int i = 0; i < 3; i++) {
        UIImageView *horizonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*45, brandScrollView.contentSize.width, 0.5)];
        horizonImageView.image = [UIImage streImageNamed:@"line.png"];
        [brandScrollView addSubview:horizonImageView];
        TT_RELEASE_SAFELY(horizonImageView);
    }
    
    for (int i = 0; i < pageCount*8; i++) {
        UIImageView *verticalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*80, 0, 0.5, 90)];
        verticalImageView.image = [UIImage streImageNamed:@"segment_vertical_line.png"];
        [brandScrollView addSubview:verticalImageView];
        TT_RELEASE_SAFELY(verticalImageView);
    }
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int xOffset = scrollView.contentOffset.x;
    int page = scrollView.contentOffset.x / self.frame.size.width;
    
    if ((xOffset % (int)self.frame.size.width == 0)) {
        pageControl.currentPage = page;
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

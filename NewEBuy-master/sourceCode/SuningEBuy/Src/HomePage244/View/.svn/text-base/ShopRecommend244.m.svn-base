//
//  ShopRecommend244.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#define KShopImageSpaceWidth    5
#define KShopImageWidth         100
#define KShopImageTag           13000
#import "ShopRecommend244.h"

@implementation ShopRecommend244

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenHeight, KSpace)];
        grayView.backgroundColor = [UIColor clearColor];
        [self addSubview:grayView];
        TT_RELEASE_SAFELY(grayView);
        
        [self addSubview:self.labelBackgroundView];
        
        UIImageView *titleTopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSpace-0.5, frame.size.width, 0.5)];
        titleTopImageView.image = [UIImage streImageNamed:@"line.png"];
        [self addSubview:titleTopImageView];
        TT_RELEASE_SAFELY(titleTopImageView);
        
        
        UIImageView *titleBottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSpace+KTitleHeight-0.5, frame.size.width, 0.5)];
        titleBottomImageView.image = [UIImage streImageNamed:@"line.png"];
        [self addSubview:titleBottomImageView];
        TT_RELEASE_SAFELY(titleBottomImageView);
        
        [self addSubview:self.titleName];
        [self addSubview:self.moreButton];
        
        
        shopScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KTitleHeight+KSpace, frame.size.width, 125)];
        shopScrollView.backgroundColor = [UIColor whiteColor];
        shopScrollView.pagingEnabled = YES;
        shopScrollView.delegate = self;
        shopScrollView.showsHorizontalScrollIndicator = NO;
        shopScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:shopScrollView];
        
        
        shopPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, KTitleHeight + 125 +KSpace+3, frame.size.width, 17)];
        shopPageControl.numberOfPages = 1;
        if (IOS6_OR_LATER) {
            shopPageControl.pageIndicatorTintColor = [UIColor colorWithRGBHex:0xd3d3d3];
            shopPageControl.currentPageIndicatorTintColor = [UIColor orange_Light_Color];
        }
        
        [shopPageControl addTarget:self action:@selector(pageControlChange:)forControlEvents:UIControlEventValueChanged];;
        [self addSubview:shopPageControl];
        
        //底部需要画一条横线
        UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        bottomImageView.image = [UIImage streImageNamed:@"line.png"];
        [self addSubview:bottomImageView];
        TT_RELEASE_SAFELY(bottomImageView);
    }
    return self;
}

- (UIView *)labelBackgroundView {
    if (!_labelBackgroundView) {
        _labelBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0+KSpace, self.frame.size.width, KTitleHeight)];
        _labelBackgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_labelBackgroundView];
    }
    return _labelBackgroundView;
}


- (UILabel *)titleName {
    if (!_titleName) {
        _titleName = [[UILabel alloc] initWithFrame:CGRectMake(10, 0+KSpace, kScreenWidth-60, KTitleHeight)];
        _titleName.backgroundColor = [UIColor clearColor];
        _titleName.lineBreakMode = UILineBreakModeClip;
        _titleName.textAlignment = NSTextAlignmentLeft;
        _titleName.textColor = [UIColor colorWithHexString:@"#313131"];
        _titleName.font = [UIFont fontWithName:@"Arial" size:17.0];
        _titleName.text = L(@"ShopRecommend");
    }
    return _titleName;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] initWithFrame:CGRectMake(265, 5+KSpace, 50, KTitleHeight-5)];
        [_moreButton addTarget:self action:@selector(moreBUttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_moreButton setTitle:L(@"BTMore") forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor colorWithHexString:@"#FC7C26"] forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:17.0];
        _moreButton.hidden = YES;
    }
    return _moreButton;
}

- (void)moreBUttonClick {
    NSArray *moduleList = _floorDTO.moduleList;
    if (_delegate && [_delegate respondsToSelector:@selector(selectModuleDTO:)]) {
        [_delegate selectModuleDTO:[moduleList safeObjectAtIndex:0]];
    }
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120181 + 0], nil]];
}


- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx {
    NSArray *moduleList = _floorDTO.moduleList;
    int flag = imageViewEx.tag - KShopImageTag;
    if (_delegate && [_delegate respondsToSelector:@selector(selectModuleDTO:)]) {
        [_delegate selectModuleDTO:[moduleList safeObjectAtIndex:flag]];
    }
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120181 + flag], nil]];
}

- (void)pageControlChange:(UIPageControl *)pageControl {
    
}


- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto {
    if (IsNilOrNull(dto)) {
        return;
    }
    _floorDTO = dto;
    
    //移除旧的UI
    NSArray *oldArray = [shopScrollView subviews];
    [oldArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    HomeModuleDTO *moduleDTO_0 = [dto.moduleList safeObjectAtIndex:0];
    self.titleName.text = moduleDTO_0.moduleName ? moduleDTO_0.moduleName : @"";
    if (!IsStrEmpty(moduleDTO_0.targetURL)) {
        self.moreButton.hidden = NO;
    }
    else {
        self.moreButton.hidden = YES;
    }
    
    if (!IsStrEmpty(moduleDTO_0.bgColor)) {
        self.labelBackgroundView.backgroundColor = [UIColor colorWithHexString:moduleDTO_0.bgColor];
    }
    else {
        self.labelBackgroundView.backgroundColor = [UIColor whiteColor];
    }

    
    //设置pageControl
    int pageCount = (int )ceilf(([dto.moduleList count] - 1)/3.0);
    if (pageCount == 0) {
        shopPageControl.hidden = YES;
    }
    else {
        shopPageControl.hidden = NO;
    }
    
    shopPageControl.numberOfPages = pageCount;
    shopPageControl.currentPage = 0;
    shopPageControl.backgroundColor = [UIColor whiteColor];
    
    //设置scrollView
    shopScrollView.contentOffset = CGPointZero;
    shopScrollView.contentSize = CGSizeMake(pageCount * self.frame.size.width, 125);
    
    
    for (int i = 1; i < [dto.moduleList count]; i++) {
        HomeModuleDTO *moduleDTO = [dto.moduleList safeObjectAtIndex:i];
        
        EGOImageViewEx *imageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(KShopImageSpaceWidth * ((i-1) / 3 + 1) + (i-1)*(KShopImageWidth + KShopImageSpaceWidth), 5, KShopImageWidth, 120)];
        imageView.exDelegate = self;
        imageView.tag = KShopImageTag + i;
        imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]];
        
        UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, KShopImageWidth, 20)];
        grayView.backgroundColor = [UIColor light_Black_Color];
        grayView.alpha = 0.5;
        [imageView addSubview:grayView];
        TT_RELEASE_SAFELY(grayView);
        
        UILabel *descrptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, KShopImageWidth, 20)];
        descrptionLabel.lineBreakMode = UILineBreakModeClip;
        descrptionLabel.contentMode = UIViewContentModeTop;
        descrptionLabel.textAlignment = NSTextAlignmentCenter;
        descrptionLabel.font = [UIFont fontWithName:@"Arial" size:13.0];
        descrptionLabel.backgroundColor = [UIColor clearColor];
        descrptionLabel.text = moduleDTO.moduleName ? moduleDTO.moduleName : @"";
        descrptionLabel.textColor = [UIColor whiteColor];
        [imageView addSubview:descrptionLabel];
        TT_RELEASE_SAFELY(descrptionLabel);
        
        [shopScrollView addSubview:imageView];
        TT_RELEASE_SAFELY(imageView);
    }
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int xOffset = scrollView.contentOffset.x;
    int page = scrollView.contentOffset.x / self.frame.size.width;
    
    if ((xOffset % (int)self.frame.size.width == 0)) {
        shopPageControl.currentPage = page;
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

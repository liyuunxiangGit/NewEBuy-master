//
//  HomeRootTopScrollPageCell.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "EightBannerImagePageCell.h"
#import "HomeTopScrollAdDTO.h"

@interface EightBannerImagePageCell()

@property (nonatomic, strong) EGOImageViewEx *adImageView;
@property (nonatomic, strong) HomeTopScrollAdDTO *adDTO;

@end


@implementation EightBannerImagePageCell

@synthesize adImageView = _adImageView;
@synthesize adDTO = _adDTO;

@synthesize delegate = _delegate;

- (void)dealloc 
{
    TT_RELEASE_SAFELY(_adImageView);
    TT_RELEASE_SAFELY(_adDTO);
}

- (void)setItem:(HomeTopScrollAdDTO *)ad
{
    if (ad == nil) {
        return;
    }
    self.adDTO = ad;
    
    self.adImageView.imageURL = [NSURL URLWithString:ad.bigImageURL];

}

- (EGOImageViewEx *)adImageView
{
    if (!_adImageView) {
        _adImageView = [[EGOImageViewEx alloc] init];
        _adImageView.userInteractionEnabled = YES;
        _adImageView.frame = CGRectMake(0, 0, 320, 100);
        _adImageView.exDelegate = self;
        _adImageView.contentMode = UIViewContentModeScaleAspectFill;
        _adImageView.clipsToBounds = YES;
        _adImageView.placeholderImage = nil;
        [self addSubview:_adImageView];
    }
    return _adImageView;
}

- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectAd:)]) {
        [_delegate didSelectAd:self.adDTO];
    }
}

@end

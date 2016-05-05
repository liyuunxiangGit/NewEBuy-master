//
//  HotelListSegment.m
//  SuningEBuy
//
//  Created by Qin on 14-2-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HotelListSegment.h"



@implementation HotelListSegment

@synthesize segment=_segment;
@synthesize delegate= _delegate;

@synthesize priceDownUpImg=_priceDownUpImg;
@synthesize starDownUpImg=_starDownUpImg;

@synthesize sort = _sort;
@synthesize sortType = _sortType;
-(void)dealloc
{
    TT_RELEASE_SAFELY(_segment);
    TT_RELEASE_SAFELY(_priceDownUpImg);
    TT_RELEASE_SAFELY(_starDownUpImg);
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.segment];
        [self addSubview:self.priceDownUpImg];
        [self addSubview:self.starDownUpImg];
        
    }
    return self;
}
-(CustomSegment*)segment{
    if (!_segment) {
        _segment=[[CustomSegment alloc] init];
        _segment.delegate=self;
        [_segment setItems:@[L(@"Suning recommend"),[L(@"price") stringByAppendingString:@"   "],[L(@"Star Level") stringByAppendingString:@"   "]]];
    }
    return _segment;
}
-(UIImageView*)priceDownUpImg{
    if (!_priceDownUpImg) {
        _priceDownUpImg=[[UIImageView alloc] initWithFrame:CGRectMake(176, 12, 9, 7)];
        UIImage* img=[UIImage newImageFromResource:@"Purchase_up@2x.png"];
        [_priceDownUpImg setImage:img];
        TT_RELEASE_SAFELY(img);
    }
    return _priceDownUpImg;
}
-(UIImageView*)starDownUpImg{
    if (!_starDownUpImg) {
        _starDownUpImg=[[UIImageView alloc] initWithFrame:CGRectMake(283, 12, 9, 7)];
        UIImage* img=[UIImage newImageFromResource:@"Purchase_up@2x.png"];
        [_starDownUpImg setImage:img];
        TT_RELEASE_SAFELY(img);
    }
    return _starDownUpImg;
}
#pragma mark -
#pragma mark SearchSegment delegate
- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index
{
    if (index == 0)//苏宁推荐
    {
        self.sort = NO;
        self.sortType = @"0";
    }
    else if (index == 1)//价格
    {
        self.priceDownUp=!self.priceDownUp;
        if (self.priceDownUp) {
            UIImage* img=[UIImage newImageFromResource:@"orange_up_arrow.png"];
            [self.priceDownUpImg setImage:img];
            TT_RELEASE_SAFELY(img);
        }else{
            UIImage* img=[UIImage newImageFromResource:@"orange_down_arrow.png"];
            [self.priceDownUpImg setImage:img];
            TT_RELEASE_SAFELY(img);
        }
        if (self.starDownUp) {
            UIImage* img=[UIImage newImageFromResource:@"gray_up_arrow.png"];
            [self.starDownUpImg setImage:img];
            TT_RELEASE_SAFELY(img);
        }else{
            UIImage* img=[UIImage newImageFromResource:@"gray_down_arrow.png"];
            [self.starDownUpImg setImage:img];
            TT_RELEASE_SAFELY(img);
        }
        self.sort = self.priceDownUp;
        self.sortType = @"1";
    }
    else   //星级
    {
        self.starDownUp=!self.starDownUp;
        if (self.starDownUp) {
            UIImage* img=[UIImage newImageFromResource:@"orange_up_arrow.png"];
            [self.starDownUpImg setImage:img];
            TT_RELEASE_SAFELY(img);
        }else{
            UIImage* img=[UIImage newImageFromResource:@"orange_down_arrow.png"];
            [self.starDownUpImg setImage:img];
            TT_RELEASE_SAFELY(img);
        }
        if (self.priceDownUp) {
            UIImage* img=[UIImage newImageFromResource:@"gray_up_arrow.png"];
            [self.priceDownUpImg setImage:img];
            TT_RELEASE_SAFELY(img);
        }else{
            UIImage* img=[UIImage newImageFromResource:@"gray_down_arrow.png"];
            [self.priceDownUpImg setImage:img];
            TT_RELEASE_SAFELY(img);
        }
        self.sort = self.starDownUp;
        self.sortType = @"2";
    }
    if ([_delegate conformsToProtocol:@protocol(HotelListSegmentDelegate)]) {
        if ([_delegate respondsToSelector:@selector(SearchHotelSortType:sort:)]) {
            [_delegate SearchHotelSortType:self.sortType sort:self.sort];
        }
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

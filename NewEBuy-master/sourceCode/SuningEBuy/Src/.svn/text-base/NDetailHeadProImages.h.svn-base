//
//  NDetailHeadProImages.h
//  SuningEBuy
//
//  Created by xmy on 12/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NJPageScrollView.h"

#import "NJPageScrollViewCell.h"
#import "DataProductBasic.h"
#import "MyPageControl.h"

@class NDetailHeadProImages;
@protocol NDetailHeadProImagesdelegate <NSObject>

/*!
 @abstract      点击商品详情其中的某个图片的事件
 @param         index  点击的图片的位置
 @param         imageUrls 所有小图url的数组
 @param         bigImageUrls  所有大图url的数组
 */
- (void)didTouchNDetailHeadImageAtIndex:(NSInteger)index
             withSmallImages:(NSArray *)imageUrls
                andBigImages:(NSArray *)bigImageUrls;

@end

@interface NDetailHeadProImages : UITableView<NJPageScrollViewDelegate,NJPageScrollViewDataSource,UITableViewDataSource,UITableViewDelegate>
{
}

@property (nonatomic, assign)id<NDetailHeadProImagesdelegate>touchImagesDelegate;

@property (nonatomic, retain)MyPageControl *myPageControl;

@property (nonatomic,retain)DataProductBasic *item;

@property (nonatomic)NSInteger currentPageNumber;

@property (nonatomic,retain)NJPageScrollView *pageScroll;

@property (nonatomic,retain)NSArray *imagesArr;//图片数组

- (void)setNDetailHeadImagesArr:(NSArray *)imagesArr;


@end


@interface NDetailHeadProImagesCell : NJPageScrollViewCell

@property (nonatomic, strong) EGOImageButton *imageViewBtn;

- (void)setImageUrl:(NSURL *)imageUrl atIndex:(NSInteger)index;


@end

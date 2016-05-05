//
//  DisOrderPhotoView.h
//  SuningEBuy
//
//  Created by caowei on 12-2-29.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PhotoViewDelegate;

@interface DisOrderPhotoView : UIScrollView <UIScrollViewDelegate, EGOImageViewDelegate>
{
    CGRect  changeFrame;
}


@property (nonatomic, weak) id<PhotoViewDelegate> ptDelegate;

- (void)setImageUrl:(NSURL *)imageUrl;

/*还原缩放*/
- (void)turnOffZoom;

@end


@protocol PhotoViewDelegate <NSObject>

- (void)singleTouchTheImageView:(DisOrderPhotoView *)photoView;

@end

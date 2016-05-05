//
//  NBMagicPictureViewController.h
//  suningNearby
//
//  Created by suning on 14-8-7.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBCommonViewController.h"

@protocol NBMagicPictureViewControllerDelegate <NSObject>
@optional
- (void)delegate_MagicPictureViewController_composedImage:(UIImage *)composedImg;
@end


@interface NBMagicPictureViewController : NBCommonViewController
@property (nonatomic,strong) UIImage   *selectedImage;
@property (nonatomic,weak) id<NBMagicPictureViewControllerDelegate> delegate;
@end

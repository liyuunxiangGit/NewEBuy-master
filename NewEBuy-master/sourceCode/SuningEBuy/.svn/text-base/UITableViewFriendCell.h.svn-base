//
//  UITableViewFriendCell.h
//  TCWeiBoSDKDemo
//
//  Created by 北京市海淀区 guosong on 12-9-13.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"

@interface UITableViewFriendCell :UITableViewCell<ImageDownloaderDelegate> {
 
    ImageDownloader *imageDownloader;
    
    UIImageView *imageviewHead;
    
    NSMutableString  *strHeadPath;
}

@property(nonatomic,strong) UIImageView *imageviewHead;

- (void)startDownloadHead:(NSString *)strURL;
- (void)stopDownloadHead;

- (BOOL)setHeadPath:(NSString *)stringHeadPath;

@end

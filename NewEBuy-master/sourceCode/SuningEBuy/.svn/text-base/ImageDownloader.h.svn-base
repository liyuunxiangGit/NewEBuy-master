//
//  ImageDownloader.h
//  TCWeiBoSDKDemo
//
//  Created by 北京市海淀区 guosong on 12-9-13.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageDownloaderDelegate <NSObject>

- (void)imageDidFishLoad:(NSData *)dataImage;

@end


@interface ImageDownloader : NSObject {
    
    NSURLConnection *connURL;
    NSMutableData *dataImage;

    id<ImageDownloaderDelegate> delegate;
}

@property(nonatomic,strong)id<ImageDownloaderDelegate> delegate;


- (void)startDownload:(NSString *)strURL;
- (void)cancelDownload;


@end

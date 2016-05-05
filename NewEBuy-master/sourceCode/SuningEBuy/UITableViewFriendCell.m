//
//  UITableViewFriendCell.m
//  TCWeiBoSDKDemo
//
//  Created by 北京市海淀区 guosong on 12-9-13.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import "UITableViewFriendCell.h"
#import <QuartzCore/QuartzCore.h>
#import "FileStreame.h"


@implementation UITableViewFriendCell
@synthesize imageviewHead;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        imageDownloader = [[ImageDownloader alloc] init];
        [imageDownloader setDelegate:self];
        
        strHeadPath = [[NSMutableString alloc] init];
        
        // 头像
        imageviewHead = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 35, 35)];
        
        [imageviewHead.layer setCornerRadius:5];
        [imageviewHead.layer setMasksToBounds:YES];
        
        [self.contentView addSubview:imageviewHead];
    }
    
    return self;
}


- (void)dealloc {
    
    [imageDownloader cancelDownload];
    [imageDownloader setDelegate:nil];
    
    
}


- (void)startDownloadHead:(NSString *)strURL {
    
    [imageDownloader startDownload:strURL];
}

- (void)stopDownloadHead {
    
    [imageDownloader cancelDownload];
}

- (BOOL)setHeadPath:(NSString *)stringHeadPath {
    
    if (stringHeadPath == nil || [stringHeadPath length] <= 0) {
        
        return NO;
    }
    
    [strHeadPath setString:stringHeadPath];
    
    return YES;
}


#pragma mark ImageDownloader 委托

- (void)imageDidFishLoad:(NSData *)dataImage {
    
    UIImage *imageHead = [UIImage imageWithData:dataImage];
    [imageviewHead setImage:imageHead];
    
    // 存入数据库 
    [FileStreame saveHeadToFile:imageHead filePath:strHeadPath];
    
}


@end

//
//  ImageDownloader.m
//  TCWeiBoSDKDemo
//
//  Created by 北京市海淀区 guosong on 12-9-13.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader
@synthesize delegate;


- (id)init {
    
    if (self = [super init]) {
        
        dataImage = [[NSMutableData alloc] init];
        
        connURL = nil;
    }
    
    return self;
}


- (void)startDownload:(NSString *)strURL {
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    
    connURL = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}


- (void)cancelDownload {
    
    if (connURL) {
        
        [connURL cancel];
        
        connURL = nil;
    }

}


- (void)dealloc {
    
    
    if (connURL) {
        
        [connURL cancel];
        
        connURL = nil;
    }
    
}

#pragma mark NSURLConntection  委托

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    [dataImage setData:nil];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [dataImage appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
        
    if ([delegate respondsToSelector:@selector(imageDidFishLoad:)] && connURL) {
        
        [delegate imageDidFishLoad:dataImage];
    }
    
    connURL = nil;
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    connURL = nil;
}


@end

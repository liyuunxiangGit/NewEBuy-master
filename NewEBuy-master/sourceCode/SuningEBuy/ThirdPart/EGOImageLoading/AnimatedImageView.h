//
//  AnimatedImageView.h
//  TestGIF
//
//  Created by wangrui on 12-2-25.
//  Copyright 2011 suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimatedGifFrame : NSObject
{
	NSData *data;
	NSData *header;
	double delay;
	int disposalMethod;
	CGRect area;
}

@property (nonatomic, copy) NSData *header;
@property (nonatomic, copy) NSData *data;
@property (nonatomic) double delay;
@property (nonatomic) int disposalMethod;
@property (nonatomic) CGRect area;

@end


@interface AnimatedImageView : UIImageView
{
	NSData *GIF_pointer;
	NSMutableData *GIF_buffer;
	NSMutableData *GIF_screen;
	NSMutableData *GIF_global;
	NSMutableArray *GIF_frames;
	
	int GIF_sorted;
	int GIF_colorS;
	int GIF_colorC;
	int GIF_colorF;
	int animatedGifDelay;
	
	int dataPointer;
}

@property (nonatomic, retain) NSMutableArray *GIF_frames;

@property (nonatomic, copy)   NSString    *imageFileName;
@property (nonatomic, retain) NSData      *imageFileData;

- (void)loadImageData;

+ (BOOL)isGifImage:(NSData*)imageData;

- (void)decodeGIF:(NSData *)GIFData;
- (void)GIFReadExtensions;
- (void)GIFReadDescriptor;
- (BOOL)GIFGetBytes:(int)length;
- (BOOL)GIFSkipBytes: (int) length;
- (NSData*)getFrameAsDataAtIndex:(int)index;
- (UIImage*)getFrameAsImageAtIndex:(int)index;

@end

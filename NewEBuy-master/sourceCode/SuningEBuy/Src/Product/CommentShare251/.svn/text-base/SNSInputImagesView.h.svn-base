//
//  SNSInputImagesView.h
//  SuningSummer
//
//  Created by Joe Mini  on 14-7-31.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SNSInputImagesViewDelegate <NSObject>

-(void)imageDeletedAtIndex:(int)index;
-(void)imagePressedAtIndex:(int)index;
-(void)imageAdd;

@end

@interface SNSInputImagesView : UIView

@property(nonatomic,assign)id<SNSInputImagesViewDelegate> delegate;
@property(nonatomic,assign)BOOL autoSize;
@property(nonatomic,assign)int max;
@property(nonatomic,assign)BOOL showAdd;

-(NSInteger)addImageByPath:(NSString*)imagePath;
-(NSInteger)addImage:(UIImage*)image;
-(void)addImages:(NSMutableArray*)images;
-(void)clean;
-(void)reOrder;
-(float)height;
-(void)setDeleteMode:(BOOL)yesOrNo;

@end

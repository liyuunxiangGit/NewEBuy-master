//
//  ReturnPartPicViewCell.h
//  SuningEBuy
//
//  Created by zl on 14-11-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface picData:NSObject
@property(nonatomic,copy)NSString* titleName;
@property(nonatomic,assign)int  titleTag;
@end
//@protocol ReturnPartPicDelegate <NSObject>
//
//-(void)addImage:(UIImage*)image;
//
//@end
@interface ReturnPartPicViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView* addImageView;
-(void)addImage;
-(void)deleteImage;
@end

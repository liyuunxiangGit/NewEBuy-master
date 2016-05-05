//
//  MyPageControl.h
//  SuningEBuy
//
//  Created by shasha on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/*!
 @header      MyPageControl
 @abstract    定制了UIPageControl的dot点的图片。通过设置currentPage属性来改变pageControl的状态。
 @author      shasha
 */

#import <UIKit/UIKit.h>
/*!
 @abstract    定制了UIPageControl的dot点的图片
 只要设置currentPage属性，就可以改变pageControl的dot的状态
 */

@interface MyPageControl:UIPageControl{
    
    UIImage *imageNormal_;
    UIImage *imageSelected_;

} 
/*!
 未选中时候的dot的图片。
 */
@property(nonatomic,strong) UIImage *imageNormal;
/*!
 选中时候的dot的图片。
 */
@property(nonatomic,strong) UIImage *imageSelected;


@property(nonatomic)NSInteger maxPoint;

@property(nonatomic,assign) NSInteger formPage;

@end

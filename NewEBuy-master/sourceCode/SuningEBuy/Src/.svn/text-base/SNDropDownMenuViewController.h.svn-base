//
//  SNDropDownMenuViewController.h
//  SuningEBuy
//
//  Created by shasha on 12-9-26.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    eNoneAnimation,
    eDropDownAnimation,
    ePullUpAnimation

} eMenuAnimation;

@protocol SNDropDownMenuDelegate ;

@interface SNDropDownMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray  *menuDataArr;
@property (nonatomic, strong) UIImage  *menuBackgroudImage;
@property (nonatomic, strong) UIImage  *menuTableViewBackImage;
@property (nonatomic, strong) UIImage  *menuCellBackImage;
@property (nonatomic, assign) UIEdgeInsets   menuTableViewOffset;
@property (nonatomic, assign) eMenuAnimation  menuAnimation;
@property (nonatomic, weak) id  <SNDropDownMenuDelegate>delegate;

@property (nonatomic, strong) UITableView  *dropDownMenuView;
@property (nonatomic, assign) UITableViewStyle  dropDownMenuViewStyle;

@property (nonatomic, strong) UIView       *superView;
@property (nonatomic, assign) CGFloat      contentHeight;

- (id)initWithSuperView:(UIView *)view withFrame:(CGRect)Frame ;
- (void)reloadDataWithNumberOfRowAndSection:(NSArray *)sections;
- (void)displayMenuAtFrame:(CGRect)frame Animation:(eMenuAnimation)animationType;
- (void)dismissMenuWithAnimation:(eMenuAnimation)animationType;

@end


@protocol SNDropDownMenuDelegate <NSObject>

- (CGFloat)dropDownMenu:(UITableView *)dropDownMenuView heghtForRowAtIndextPath:(NSIndexPath *)indextPath;

- (void)dropDownMenu:(UITableView *)dropDownMenuView didSelectRowAtIndextPath:(NSIndexPath *)indextPath;

- (UITableViewCell *)dropDownMenu:(UITableView *)dropDownMenuView cellForRowAtIndextPath:(NSIndexPath *)indextPath;

- (void)dropDownMenu:(UITableView *)dropDownMenuView willDisplayCell:(UITableViewCell *)cell forRowAtIndextPath:(NSIndexPath *)indextPath;

@end

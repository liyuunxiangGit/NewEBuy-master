//
//  AssociationalWordDisplayController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-22.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

/*!
 @header      AssociationalWordDisplayController
 @abstract    联想词控制器，包括了页面的显示和数据请求
 @author      刘坤
 @version     v1.0.002     12-8-27
 @discussion
  使用方法： 1、使用initWithContentController:的方法初始化
            2、delegate必须同时是searchBar的delegate
            3、在searchBar的代理方法里面添加如下代码：
 
            - (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
            {
                [self.keywordDisPlayController displayView];
                return YES;
            }
 
            - (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
            {
                [self.keywordDisPlayController removeView];
                return YES;
            }
 
            - (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
            {
                [self.keywordDisPlayController refreshViewWithKeyword:searchText];
            }
 
            4、通过设置tableTopPosY和distanceToTop来确定view的frame
 
 */

#import <Foundation/Foundation.h>
#import "AssociationalWordService.h"

@protocol AssociationalWordDisplayDelegate <NSObject>

@optional
/*!
 @abstract      点击选择某一个联想词的事件传递
 @param         keyword  选择的联想词
 */
- (void)didSelectAssociationalWord:(NSString *)keyword;

@end




@interface AssociationalWordDisplayController : NSObject <AssociationalWordServiceDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UITableView  *_displayTableView;
    
    CGFloat     _tableTopPosY;          //view顶部的positionY
    CGFloat     _distanceToTop;         //view顶部到屏幕顶端的距离
    AssociationalWordType  _wordType;   //联想词类型，混合，图书
}

@property (nonatomic, strong) AssociationalWordService *service;
@property (nonatomic, weak) id<AssociationalWordDisplayDelegate> delegate;
@property (nonatomic, assign) CGFloat tableTopPosY;
@property (nonatomic, assign) CGFloat distanceToTop;
@property (nonatomic, assign) AssociationalWordType wordType;

/*!
 @abstract      初始化方法
 @param         controller  所在的viewController
 */
- (id)initWithContentController:(UIViewController *)controller;


/*!
 @abstract      展示displayView
 */
//- (void)displayView;

- (void)displayView:(NSArray *)historyKeywords;
/*!
 @abstract      移除displayView
 */
- (void)removeView;


/*!
 @abstract      传入新的keyword并刷新
 */
- (void)refreshViewWithKeyword:(NSString *)keyword;

@end

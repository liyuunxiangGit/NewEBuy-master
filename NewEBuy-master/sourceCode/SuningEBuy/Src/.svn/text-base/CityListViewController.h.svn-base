//
//  CityListViewController.h
//  citylistdemo
//
//  Created by BW on 11-11-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CityListViewController : CommonViewController<UITableViewDataSource,UITableViewDelegate>{
    NSDictionary *cities;  
    NSMutableArray *keys;
    id __weak delegate;
//    UITableView *tableView_;
    UINavigationBar *navigationBar_;
    UIImageView          *backgroundImageView_;
}
//@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic,strong) UINavigationBar *navigationBar;
@property (nonatomic,strong) UIImageView  *backgroundImageView;
@property (nonatomic, strong) NSDictionary *cities;  
@property (nonatomic, strong) NSMutableArray *keys;
@property (nonatomic, weak) id delegate;

- (void)pressReturn:(id)sender;
-(void)getCityFromPlist;

@end


@protocol CityListViewControllerProtocol
- (void) citySelectionUpdate:(NSString*)selectedCity andViewController:(id)controller;
- (NSString*) getDefaultCity;
@end


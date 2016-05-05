//
//  GBSearchViewController.h
//  SuningEBuy
//
//  Created by  liukun on 13-2-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import "GBListService.h"
#import "SearchbarView.h"

@interface GBSearchViewController : PageRefreshTableViewController <UISearchBarDelegate, UISearchDisplayDelegate,GBListServiceDelegate,UIGestureRecognizerDelegate,SearchbarViewDelegate>
{
    UISearchBar     *_searchBar;
    UISearchDisplayController *_searchDisplay;
}

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDisplay;
@property (nonatomic, copy) NSString  *cityId;
@property (nonatomic, copy) NSString  *categoryId;

@property (nonatomic, strong) NSMutableArray *searchList;

@property (nonatomic, strong) SearchbarView  *searchBarView;
@property (nonatomic, strong) UIButton      *cancelBtn;

@end

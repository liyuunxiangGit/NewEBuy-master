//
//  ProvincePickViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProvincePickViewController.h"
#import "AddressInfoDAO.h"
#import "CityPickViewController.h"

@implementation ProvincePickViewController

@synthesize provinceList = _provinceList;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_provinceList);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
    self = [super init];
    
    if (self) {        
        //self.view.frame = CGRectMake(0, 0, 230, 250);
        self.view.backgroundColor = [UIColor clearColor];
        self.isNeedBackItem = YES;
        self.titleLabel.text = L(@"Province_Pick_Title");
        isProvinceLoaded = NO;
        
        if (IOS7_OR_LATER)
            self.edgesForExtendedLayout = UIRectEdgeBottom;
        
        self.pageTitle = L(@"member_myEbuy_DeliveryCity");
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(defaultCityDidChange)
                                                     name:DEFAULT_CITY_CHANGE_NOTIFICATION
                                                   object:nil];
    }
    return self;
}

- (void)defaultCityDidChange
{
    [self refreshTitle];
}

- (void)initProvinces
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @autoreleasepool {
        
            if ([AddressInfoDAO isUpdateAddressOk]) {
                AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
                NSArray *array = [dao getAllProvince];
                
                if (NotNilAndNull(array)) {
                    self.provinceList = array;
                    isProvinceLoaded = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self.tableView reloadData]; 
                    });
                }
                
            }
        
        }
        
    });
}

- (void)loadView
{
    [super loadView];
    
    
    self.tableView.frame = self.view.bounds;
    if (IOS7_OR_LATER)
    {
        self.tableView.backgroundColor = [UIColor uiviewBackGroundColor];
    }
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)refreshTitle
{
    @autoreleasepool {
        if ([AddressInfoDAO isUpdateAddressOk]) {
            NSString *title = L(@"Province_Pick_Title");
            AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
            NSString *cityName = [dao getCityNameByCityCode:[Config currentConfig].defaultCity];
            TT_RELEASE_SAFELY(dao);
            if (cityName) {
                title = [NSString stringWithFormat:@"%@\n%@:\"%@\"",
                         L(@"Province_Pick_Title"),
                         L(@"Current_City"), 
                         cityName];
            } 
            dispatch_async(dispatch_get_main_queue(), ^{
                self.titleLabel.text = title;
                self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            });
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self refreshTitle];
    
    if (!isProvinceLoaded) {
        [self initProvinces];
    }
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.provinceList) {
        return [self.provinceList count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *provinceCellIdentifier = @"provinceCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:provinceCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:provinceCellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = RGBCOLOR(49, 49, 49);
        
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        cellSep.frame = CGRectMake(0, 35.5, 320,0.5);
        [cell.contentView addSubview:cellSep];
        


    }
    AddressInfoDTO *province = [self.provinceList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = province.provinceContent;
    UIImageView *vArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray"]];
    cell.accessoryView = vArrow;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AddressInfoDTO *province = [self.provinceList objectAtIndex:indexPath.row];
    
    CityPickViewController *cityPicker = [[CityPickViewController alloc] initWithProvince:province];
    cityPicker.delegate = self.delegate;
    [self.navigationController pushViewController:cityPicker animated:YES];
    
    TT_RELEASE_SAFELY(cityPicker);
}


@end

//
//  CityPickViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CityPickViewController.h"
#import "AddressInfoDAO.h"

@implementation CityPickViewController

@synthesize cityList = _cityList;
@synthesize provinceDTO = _provinceDTO;

- (id)init
{
    if (self = [super init])
    {
        if (IOS7_OR_LATER)
            self.edgesForExtendedLayout = UIRectEdgeBottom;
    }
    return self;
}

- (id)initWithProvince:(AddressInfoDTO *)province
{
    self = [super init];
    if (self) {
        self.provinceDTO = province;
        
        self.isNeedBackItem = YES;
        self.titleLabel.text = self.provinceDTO.provinceContent;
        
        selectCityIndex = -1;
        
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

- (void)dealloc
{
    TT_RELEASE_SAFELY(_cityList);
    TT_RELEASE_SAFELY(_provinceDTO);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)defaultCityDidChange
{
    [self refresh];
}

- (void)refresh
{
    @autoreleasepool {
        if ([AddressInfoDAO isUpdateAddressOk]) {
            NSString *title = L(@"Province_Pick_Title");
            AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
            NSString *cityName = [dao getCityNameByCityCode:[Config currentConfig].defaultCity];
            self.provinceDTO = [dao getProvinceAndCityInfoByCityName:cityName];
            self.cityList = [dao getCityByProvinceCode:self.provinceDTO.province];
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
                
                [self.tableView reloadData];
            });
        }
    }
}

- (void)initCitys
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @autoreleasepool {
        
            if ([AddressInfoDAO isUpdateAddressOk]) {
                
                AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
                NSArray *array = [dao getCityByProvinceCode:self.provinceDTO.province];
                
                if (NotNilAndNull(array)) {
                    self.cityList = array;
                    
                    for (int i = 0; i < [array count]; i++) {
                        AddressInfoDTO *cDTO = [array objectAtIndex:i];
                        if ([cDTO.city isEqualToString:[Config currentConfig].defaultCity]) {
                            selectCityIndex = i;
                            break;
                        }
                    }
                    
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
        self.tableView.backgroundColor = [UIColor uiviewBackGroundColor];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self initCitys];
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cityList) {
        return [self.cityList count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cityCellIdentifier = @"cityCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityCellIdentifier];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = RGBCOLOR(49, 49, 49);
        
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        cellSep.frame = CGRectMake(0, 35.5, 320,0.5);
        [cell.contentView addSubview:cellSep];
    }
    
    if (indexPath.row == selectCityIndex) {
        cell.accessoryView = self.checkMarkView;
    }
    else
    {
        cell.accessoryView = nil;
    }
    
    AddressInfoDTO *province = [self.cityList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = province.cityContent;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
    
    NSInteger index = indexPath.row;
    
    if (selectCityIndex != indexPath.row) {
        if (selectCityIndex == -1) {
//            NSIndexPath *selectPath = [NSIndexPath indexPathForRow:index inSection:0];
            selectCityIndex = index;
            
//            [self.tableView beginUpdates];
//            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:selectPath] withRowAnimation:UITableViewRowAnimationNone];
//            [self.tableView endUpdates];
        }
        else
        {
//            NSIndexPath *oldPath = [NSIndexPath indexPathForRow:selectCityIndex inSection:0];
//            NSIndexPath *newPath = [NSIndexPath indexPathForRow:index inSection:0];
//            
            selectCityIndex = index;
//            [self.tableView beginUpdates];
//            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:oldPath, newPath, nil] withRowAnimation:UITableViewRowAnimationNone];
//            [self.tableView endUpdates];
        }
    }
    
    [tableView reloadData];
 
    [self performSelector:@selector(postMsgAndBack) withObject:nil afterDelay:0.1];
    
//    [self.snpopoverController dismissAnimated:YES];
//    [self.snpopoverController popToRoot:NO];
}

- (void)postMsgAndBack
{
    AddressInfoDTO *cityDTO = [self.cityList objectAtIndex:selectCityIndex];
    
    //修改了默认城市
    
    [Config currentConfig].defaultCity = cityDTO.city;
    [Config currentConfig].defaultProvince = self.provinceDTO.province;
    [Config currentConfig].defaultSection = self.provinceDTO.district;
    [[NSNotificationCenter defaultCenter] postNotificationName:DEFAULT_CITY_CHANGE_NOTIFICATION object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

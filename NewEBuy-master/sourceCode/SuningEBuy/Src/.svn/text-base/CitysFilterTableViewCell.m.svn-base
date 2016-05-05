//
//  CitysFilterTableViewCell.m
//  SuningEBuy
//
//  Created by chupeng on 14-8-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CitysFilterTableViewCell.h"
#import "FilterPopupViewController.h"
#define SECTION_TEXT_LEFT 25
#define CELL_TEXT_LEFT 35

#define SECTION_TEXT_COLOR RGBCOLOR(0, 0, 0)
#define CELL_TEXT_COLOR RGBCOLOR(0, 0, 0)

#define CELL_BACK_COLOR RGBCOLOR(247, 247, 247)

@implementation CitysFilterTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        self.backgroundColor = CELL_BACK_COLOR;
        
        selectCityIndex =  -1;
        selectedSectionIndex = -1;
        self.dicProvinceCodeToCitys = [NSMutableDictionary dictionary];
        
        [self addSubview:self.tableView];
        self.tableView.frame = self.bounds;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(defaultCityDidChange)
                                                     name:DEFAULT_CITY_CHANGE_NOTIFICATION
                                                   object:nil];
        
        [self initProvincesAndCitys];
    }
    return self;
}


- (void)defaultCityDidChange
{

}

- (void)initProvincesAndCitys
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            if ([AddressInfoDAO isUpdateAddressOk]) {
                AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
                NSArray *array = [dao getAllProvince];
                
                if (NotNilAndNull(array)) {
                    self.provinceList = array;
                    NSString *defaultCity = [Config currentConfig].defaultCity;
                    for (int i = 0; i < self.provinceList.count; i++)
                    {
                        AddressInfoDTO *provinceDto = (AddressInfoDTO *)[self.provinceList objectAtIndex:i];
                        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
                        NSArray *arrayCitys = [dao getCityByProvinceCode:provinceDto.province];
                        
                        for (int j = 0; j < arrayCitys.count; j++) {
                            AddressInfoDTO *cityDto = (AddressInfoDTO *)[arrayCitys objectAtIndex:j];
                            if ([cityDto.city isEqualToString:defaultCity])
                            {
                                selectedSectionIndex = i;
                                break;
                            }
                        }
                        
                        [self.dicProvinceCodeToCitys setObject:arrayCitys forKey:provinceDto.province];
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    [self.tableView reloadData];
                    
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_FILTERVIEWCTRL object:nil];
//                    self.tableView.bounds = CGRectMake(0, 0, 320, self.tableView.contentSize.height);
                });
            }
        }
    });
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
    }
    
    return _tableView;
}


#pragma mark -
#pragma mark Table View Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.provinceList)
        return [self.provinceList count];
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == selectedSectionIndex)
    {
        if (selectedSectionOpened)
        {
            return 0;
        }
        else
        {
            if (self.provinceList)
            {
                AddressInfoDTO *provinceDto = (AddressInfoDTO *)[self.provinceList objectAtIndex:section];
                
                NSArray *arrayCitys = (NSArray *)[self.dicProvinceCodeToCitys objectForKey:provinceDto.province];
                return arrayCitys.count;
            }
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cityCellIdentifier = @"cityCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityCellIdentifier];
        cell.contentView.backgroundColor = CELL_BACK_COLOR;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CELL_TEXT_LEFT, 10, 180, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = CELL_TEXT_COLOR;
        label.tag = 100;
        
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        cellSep.frame = CGRectMake(0, 39.5, 320,0.5);
        
        UIImageView *vCheck = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightIcon"]];
        vCheck.frame = CGRectMake(190, (40 - 8.5) / 2, 12, 8.5);
        vCheck.tag = 101;
        [cell.contentView addSubview:vCheck];
        
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:cellSep];
    }
    
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
    UIImageView *vCheck = (UIImageView *)[cell.contentView viewWithTag:101];
    
    AddressInfoDTO *province = (AddressInfoDTO *)[self.provinceList objectAtIndex:indexPath.section];
    NSArray *citys = (NSArray *)[self.dicProvinceCodeToCitys objectForKey:province.province];
    AddressInfoDTO *city = (AddressInfoDTO *)[citys objectAtIndex:indexPath.row];
    
    if (vCheck)
    {
        vCheck.hidden = YES;
        
        if ([city.city isEqualToString:[Config currentConfig].defaultCity])
        {
            vCheck.hidden = NO;
        }
    }
    if (label)
    {
        label.text = city.cityContent;
    }
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:[tableView rectForSection:section]];
    headerView.backgroundColor = CELL_BACK_COLOR;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionTapped:)];
    [headerView addGestureRecognizer:tapGes];
    
    UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    cellSep.frame = CGRectMake(0, 39.5, 320,0.5);

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SECTION_TEXT_LEFT, 0, 150, 36)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = SECTION_TEXT_COLOR;
    label.font = [UIFont systemFontOfSize:15];
    
    [headerView addSubview:label];
    [headerView addSubview:cellSep];
    
    AddressInfoDTO *province = (AddressInfoDTO *)[self.provinceList objectAtIndex:section];
    label.text = province.provinceContent;
    
    headerView.tag = 100 + section;
    return headerView;
}

- (void)sectionTapped:(UITapGestureRecognizer *)ges
{
    UIView *v = ges.view;
    int sectionindex = v.tag - 100;
    
    selectedSectionIndex = sectionindex;
    
    if ([self.tableView numberOfRowsInSection:sectionindex] > 0)
    {
        selectedSectionOpened = YES;
    }
    else
    {
        selectedSectionOpened = NO;
    }
    
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_FILTERVIEWCTRL object:nil];
    
    if ([self.tableView numberOfRowsInSection:sectionindex])
    {
        if (self.filterCtrl)
        {
            CGRect rc = [self.tableView rectForSection:sectionindex];

            //内部的tableview是不能滚动的，因此滚动外部的tableview来让所选的省份保持可见
            if (rc.origin.y > 280)
                [self.filterCtrl.tableView setContentOffset:CGPointMake(0, 80 + rc.origin.y) animated:NO];
            else
                [self.filterCtrl.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    AddressInfoDTO *province = (AddressInfoDTO *)[self.provinceList objectAtIndex:indexPath.section];
    NSArray *citys = (NSArray *)[self.dicProvinceCodeToCitys objectForKey:province.province];
    AddressInfoDTO *cityDTO = (AddressInfoDTO *)[citys objectAtIndex:indexPath.row];
    
    //修改了默认城市
    
    [Config currentConfig].defaultCity = cityDTO.city;
    [Config currentConfig].defaultProvince = province.province;
    [Config currentConfig].defaultSection = province.district;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DIDSELECT_CITY object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DEFAULT_CITY_CHANGE_NOTIFICATION object:nil];
    
   
    [self.tableView reloadData];
}

@end

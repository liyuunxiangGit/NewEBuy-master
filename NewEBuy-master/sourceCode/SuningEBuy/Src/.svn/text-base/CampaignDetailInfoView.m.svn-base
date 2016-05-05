//
//  CampaignDetailInfoView.m
//  SuningEBuy
//
//  Created by JackyWu on 14-8-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CampaignDetailInfoView.h"
#import "AllCityStoreListCell.h"
#import "SNWebViewController.h"

@implementation CampaignDetailInfoView

- (id)initWithOwner:(id)owner
{
    self = [super init];
    if (self)
    {
        self.owner = owner;
        
        self.groupTableView.dataSource = self;
        
        self.groupTableView.delegate = self;
        
        self.backgroundColor = [UIColor uiviewBackGroundColor];
        
        self.campaignStore = [[NSString alloc]init];
        
        self.campaignStore = L(@"NearbySuning_ActivityStoreLookDown");
        
    }
    return self;
}

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_campaignDto);
    TT_RELEASE_SAFELY(_storeList);
    TT_RELEASE_SAFELY(_campaignStore);
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.groupTableView.frame =self.frame;
    
    [self addSubview:self.groupTableView];
    
}

#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
        
    }else
    {
        return [_storeList count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        NSString *str = [NSString stringWithFormat:@"%@\n%@：%@\n%@：%@\n%@", _campaignDto.campDescription,L(@"NearbySuning_ActivityBeginTime"), _campaignDto.activityStartTime,L(@"NearbySuning_ActivityEndTime"), _campaignDto.activityEndTime, self.campaignStore];
        
        CGSize size = [str sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:CGSizeMake(280, 350)];
        
        CGFloat height = size.height + 236;
        
        return height;
    }
    else
    {
        SuningStoreDTO *dto = [_storeList objectAtIndex:indexPath.row];
        return [AllCityStoreListCell heightOfCell:dto];;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (!IsArrEmpty(_storeList) && section == 1)
    {
        return 40;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return nil;
    }
    else if (!IsArrEmpty(_storeList) && section == 1)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        
        nameLabel.backgroundColor = [UIColor clearColor];
        
        nameLabel.frame = CGRectMake(15, 40 - 28, 200, 20);
        
        nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        nameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        
        nameLabel.text = L(@"NearbySuning_YouCanParticipateActivity");
        
        [view addSubview:nameLabel];
        
        return view;
    }
    
    return  nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString  *headerCellIdentifier = @"headerCellIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headerCellIdentifier];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headerCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSString *activityStartTime = [[NSString alloc]init];
            NSString *activityEndTime = [[NSString alloc]init];
            if (IsStrEmpty(_campaignDto.activityStartTime)) {
                activityStartTime = [NSString stringWithFormat:@"%@",@""];
            }else{
                NSArray *arr =[_campaignDto.activityStartTime componentsSeparatedByString:@":"];
                if ([arr count]>=2) {
                    activityStartTime = [NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
                }else{
                    activityStartTime = [NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
                }
            }
            if (IsStrEmpty(_campaignDto.activityEndTime)) {
                activityEndTime = [NSString stringWithFormat:@"%@",@""];
            }else{
                NSArray *arr =[_campaignDto.activityEndTime componentsSeparatedByString:@":"];
                if ([arr count]>=2) {
                    activityEndTime = [NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
                }else{
                    activityEndTime = [NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
                }
            }
            NSString *str = [NSString stringWithFormat:@"%@\n%@：%@\n%@：%@\n%@", _campaignDto.campDescription,L(@"NearbySuning_ActivityBeginTime"), activityStartTime,L(@"NearbySuning_ActivityEndTime"), activityEndTime, self.campaignStore];
            CGSize size = [str sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:CGSizeMake(280, 350)];
            
            CGFloat height = size.height + 236;
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, height)];
            
            view.backgroundColor = [UIColor uiviewBackGroundColor];
            
            UIImageView *centerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suning_list_center.png"]];
            
            UIImageView *topView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suning_list_top.png"]];
            
            UIImageView *bottomView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suning_list_bottom.png"]];
            
            centerView.frame = CGRectMake(10, 16, 300, height - 16);
            
            topView.frame = CGRectMake(10, 16, 300, 1);
            
            bottomView.frame = CGRectMake(10, height - 3, 300, 3);
            
            [view addSubview:centerView];
            
            [view addSubview:topView];
            
            [view addSubview:bottomView];
            
            SNUIImageView *imageView = [[SNUIImageView alloc]initWithFrame:CGRectMake(10, 16, 300, 180)];
            
            imageView.imageURL = [NSURL URLWithString:_campaignDto.detailPic];
            
            [view addSubview:imageView];
            
            UILabel *activityName = [[UILabel alloc] initWithFrame:CGRectMake(20, 196, 280, 30)];
            
            activityName.backgroundColor = [UIColor clearColor];
            
            activityName.font = [UIFont boldSystemFontOfSize:15.0];
            
            activityName.textColor = [UIColor colorWithRGBHex:0x313131];
            
            activityName.text = _campaignDto.name;
            
            [view addSubview:activityName];
            
            UILabel *descriptionLbl = [[UILabel alloc] init];
            
            descriptionLbl.backgroundColor = [UIColor clearColor];
            
            descriptionLbl.frame = CGRectMake(20, 226, 280, size.height);
            
            descriptionLbl.font = [UIFont systemFontOfSize:14.0];
            
            descriptionLbl.textAlignment = UITextAlignmentLeft;
            
            descriptionLbl.numberOfLines = 0;
            
            descriptionLbl.textColor = [UIColor colorWithRGBHex:0x707070];
            
            descriptionLbl.text = str;
            
            [view addSubview:descriptionLbl];
            
            [cell.contentView addSubview:view];
            
        }
        
        return cell;

    }
    else
    {
        static NSString  *allCityStoreListCellIdentifier = @"allCityStoreListCellIdentifier";
        
        AllCityStoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:allCityStoreListCellIdentifier];
        
        if (!cell) {
            
            cell = [[AllCityStoreListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allCityStoreListCellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.backView.image = [UIImage imageNamed:@"suning_bg_mendian.png"];
    
        [cell setItem:[_storeList objectAtIndex:indexPath.row]];
    
//        [cell.collectBtn setHidden:YES];
    
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1)
    {
        
        SuningStoreDTO *dto = [[SuningStoreDTO alloc]init];
        
        dto = [_storeList objectAtIndex:indexPath.row];
        
        if(_delegate && [_delegate respondsToSelector:@selector(gotoDetailSuningStore:)])
        {
            
            [_delegate gotoDetailSuningStore:dto];
            
        }
    }
    
}

@end

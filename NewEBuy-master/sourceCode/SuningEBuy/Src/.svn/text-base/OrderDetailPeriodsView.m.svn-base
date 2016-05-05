//
//  OrderDetailPeriodsView.m
//  SuningLottery
//
//  Created by yangbo on 4/12/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import "OrderDetailPeriodsView.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "OrderDetailService.h"

#define ORDER_DETAIL_PERIODS_VIEW_WIDTH [[UIScreen mainScreen] bounds].size.width

#define ORDER_DETAIL_PERIODS_VIEW_OFFSET_X          17      //“投注内容”左边距

#define ORDER_DETAIL_PERIODS_TABLE_OFFSET_X         14      //table 左边距

#define ORDER_DETAIL_PERIODS_TABLE_MAX_HEIGHT       300     //table 最大高度

#define ORDER_DETAIL_PERIODS_TABLE_CELL_HEIGHT      36      //cell高度

#define ORDER_DETAIL_PERIODS_TABLE_TOPVIEW_HEIGHT   31      //table topview 高度

@implementation OrderDetailPeriodsView

- (void)dealloc
{
    TT_RELEASE_SAFELY(_tableView);
    TT_RELEASE_SAFELY(_periodsArray);
    TT_RELEASE_SAFELY(_service);
    
}

- (id)initWithService:(LotteryOrderDetailService *)service
{
    if(self = [super init])
    {
        
        _periodsArray = [[NSArray alloc] initWithArray:service.followPeroidArray];
        _service = service;
        
        _openIndex = -1;
        
        if([_periodsArray count] > 0)
        {
            FollowPerodDetailDto *dto = [_periodsArray objectAtIndex:0];
            if([self canOpenCellWithDto:dto])
            {
                _openIndex = 0;
            }else
                _openIndex = -1;
        }
        
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORDER_DETAIL_PERIODS_VIEW_OFFSET_X, 14, ORDER_DETAIL_PERIODS_VIEW_WIDTH - ORDER_DETAIL_PERIODS_VIEW_OFFSET_X * 2, 17)];
        tagLabel.text = L(@"LOAdditionalNumberForm");
        tagLabel.textColor = RGBACOLOR(0xb4, 0x4e, 0x4b, 1);
        tagLabel.font = [UIFont systemFontOfSize:17.0f];
        tagLabel.backgroundColor = [UIColor clearColor];
        tagLabel.shadowColor = [UIColor whiteColor];
        tagLabel.shadowOffset = CGSizeMake(0, 1);
        [self addSubview:tagLabel];
        
        float height = ([_periodsArray count]+1) * ORDER_DETAIL_PERIODS_TABLE_CELL_HEIGHT+ORDER_DETAIL_PERIODS_TABLE_TOPVIEW_HEIGHT;
        
        height = height > ORDER_DETAIL_PERIODS_TABLE_MAX_HEIGHT ? ORDER_DETAIL_PERIODS_TABLE_MAX_HEIGHT : height;
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(ORDER_DETAIL_PERIODS_TABLE_OFFSET_X, CGRectGetMaxY(tagLabel.frame)+10, ORDER_DETAIL_PERIODS_VIEW_WIDTH - ORDER_DETAIL_PERIODS_TABLE_OFFSET_X * 2, height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIImageView *tableHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), ORDER_DETAIL_PERIODS_TABLE_TOPVIEW_HEIGHT)];
        tableHeaderView.image = [UIImage imageNamed:@"orderdetail_fp_head.png"];
        _tableView.tableHeaderView = tableHeaderView;
        
        //期次tip label
        UILabel *periodLabel = [[UILabel alloc] initWithFrame:CGRectMake(/*36, 0, 85,*/10,0,85, ORDER_DETAIL_PERIODS_TABLE_TOPVIEW_HEIGHT)];
        periodLabel.textAlignment = UITextAlignmentCenter;
        periodLabel.backgroundColor = [UIColor clearColor];
        periodLabel.text = L(@"LOIssueFrequency");
        periodLabel.textColor = RGBACOLOR(0x41, 0x1f, 0x1d, 1);
        periodLabel.font = [UIFont systemFontOfSize:13];
        periodLabel.shadowColor = [UIColor whiteColor];
        periodLabel.shadowOffset = CGSizeMake(0, 1);
        [tableHeaderView addSubview:periodLabel];
        
        //倍数tip label
        UILabel *multiLabel = [[UILabel alloc] initWithFrame:CGRectMake(/*10, 0, 25,*/94,0,30, ORDER_DETAIL_PERIODS_TABLE_TOPVIEW_HEIGHT)];
        multiLabel.textAlignment = UITextAlignmentCenter;
        multiLabel.backgroundColor = [UIColor clearColor];
        multiLabel.text = L(@"LOMultiple");
        multiLabel.font = [UIFont systemFontOfSize:13];
        multiLabel.shadowColor = [UIColor whiteColor];
        multiLabel.shadowOffset = CGSizeMake(0, 1);
        multiLabel.textColor = RGBACOLOR(0x41, 0x1f, 0x1d, 1);
        [tableHeaderView addSubview:multiLabel];
        
        //状态tip label
        UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(117, 0, 85, ORDER_DETAIL_PERIODS_TABLE_TOPVIEW_HEIGHT)];
        stateLabel.textAlignment = UITextAlignmentCenter;
        stateLabel.backgroundColor = [UIColor clearColor];
        stateLabel.text = L(@"efubaoStatus");
        stateLabel.font = [UIFont systemFontOfSize:13];
        stateLabel.shadowColor = [UIColor whiteColor];
        stateLabel.shadowOffset = CGSizeMake(0, 1);
        stateLabel.textColor = RGBACOLOR(0x41, 0x1f, 0x1d, 1);
        [tableHeaderView addSubview:stateLabel];
        
        //中奖信息tip label
        UILabel *awardLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_tableView.frame) - 78, 0, 60, ORDER_DETAIL_PERIODS_TABLE_TOPVIEW_HEIGHT)];
        awardLabel.textAlignment = UITextAlignmentCenter;
        awardLabel.backgroundColor = [UIColor clearColor];
        awardLabel.text = L(@"LOWinInfo");
        awardLabel.font = [UIFont systemFontOfSize:13];
        awardLabel.shadowColor = [UIColor whiteColor];
        awardLabel.shadowOffset = CGSizeMake(0, 1);
        awardLabel.textColor = RGBACOLOR(0x41, 0x1f, 0x1d, 1);
        [tableHeaderView addSubview:awardLabel];
        

        [self addSubview:_tableView];
        
        
        self.frame = CGRectMake(0, 0, ORDER_DETAIL_PERIODS_VIEW_WIDTH, CGRectGetMaxY(_tableView.frame) + 15);
    }
    return self;
}

- (NSIndexPath *)indexPathForSpreadRow
{
    if(_openIndex == -1)
        return nil;
    
    return [NSIndexPath indexPathForRow:_openIndex+1 inSection:0];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ORDER_DETAIL_PERIODS_TABLE_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_openIndex != -1 && _openIndex + 1 == [indexPath row] )   //如果点击的是展开行 返回
    {
        return;
    }
    
    int index = 0;
    if(_openIndex < [indexPath row] && _openIndex != -1)
        index = [indexPath row]-1;
    else{
        index = [indexPath row];
    }
    
    //未开奖 不展开
    FollowPerodDetailDto *dto = [_periodsArray objectAtIndex:index];
    if(![self canOpenCellWithDto:dto])
        return;
    
    int oldOpenindex = _openIndex;
    
    //重新设置_openIndex
    if(_openIndex == -1)
        _openIndex = [indexPath row];
    else if(_openIndex == [indexPath row])
    {
        _openIndex = -1;
    }else{
        _openIndex = _openIndex > [indexPath row] ? [indexPath row] : [indexPath row] - 1;
    }
    
    [_tableView beginUpdates];
    
    //更新点击的行
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    //插入新行
    if(oldOpenindex != [indexPath row])
    {
        [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[self indexPathForSpreadRow]] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    //移除展开行
    if(oldOpenindex != -1)
    {
        if(oldOpenindex != [indexPath row])
            [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:oldOpenindex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:oldOpenindex+1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [_tableView endUpdates];

}

#pragma makr - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_periodsArray count] + (_openIndex == -1 ? 0 : 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"orderDetailPeriodsIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell.contentView removeAllSubviews];
    
    int index = 0;
    if(_openIndex < [indexPath row] && _openIndex != -1)
        index = [indexPath row]-1;
    else{
        index = [indexPath row];
    }
    
    FollowPerodDetailDto *dto = [_periodsArray objectAtIndex:index];
    
    if(_openIndex == -1 || [indexPath row] != _openIndex + 1)   //普通cell
    {
        //背景
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), ORDER_DETAIL_PERIODS_TABLE_CELL_HEIGHT)];
        bgImageView.image = [UIImage imageNamed:@"orderdetail_fp_cell.png"];
        [cell.contentView addSubview:bgImageView];
        
        //倍数
        UILabel *serialLabel = [[UILabel alloc] initWithFrame:CGRectMake(96,0,25, ORDER_DETAIL_PERIODS_TABLE_CELL_HEIGHT)];
        serialLabel.backgroundColor = [UIColor clearColor];
        serialLabel.textAlignment = UITextAlignmentCenter;
        serialLabel.font = [UIFont systemFontOfSize:12.0f];
        serialLabel.textColor = RGBACOLOR(0x33, 0x33, 0x33, 1);
        serialLabel.text = dto.imulity;
        [cell.contentView addSubview:serialLabel];
        
        //期次
        UILabel *periodLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0,85, ORDER_DETAIL_PERIODS_TABLE_CELL_HEIGHT)];
        periodLabel.backgroundColor = [UIColor clearColor];
        periodLabel.textAlignment = UITextAlignmentCenter;
        periodLabel.font = [UIFont systemFontOfSize:12.0f];
        periodLabel.textColor = RGBACOLOR(0x7d, 0, 0, 1);
        periodLabel.text = [NSString stringWithFormat:@"%@%@",dto.cperiodid,L(@"LOFrequency")];
        [cell.contentView addSubview:periodLabel];
        
        //state
        UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(117, 0, 85, ORDER_DETAIL_PERIODS_TABLE_CELL_HEIGHT)];
        stateLabel.backgroundColor = [UIColor clearColor];
        stateLabel.textAlignment = UITextAlignmentCenter;
        stateLabel.font = [UIFont systemFontOfSize:12.0f];
        stateLabel.text = [self followPeriodState:dto];
        stateLabel.textColor = RGBACOLOR(0x33, 0x33, 0x33, 1);
        [cell.contentView addSubview:stateLabel];
        
        //award msg
        UILabel *awardLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_tableView.frame) - 73, 0, 50, ORDER_DETAIL_PERIODS_TABLE_CELL_HEIGHT)];
        awardLabel.backgroundColor = [UIColor clearColor];
        awardLabel.textAlignment = UITextAlignmentCenter;
        awardLabel.font = [UIFont systemFontOfSize:12.0f];
        if([dto.iamoney doubleValue] > 0)
        {
            awardLabel.textColor = RGBACOLOR(0xab, 0x3b, 0x38, 1);
        }else
            awardLabel.textColor = RGBACOLOR(0x33, 0x33, 0x33, 1);
        awardLabel.text = [self awardState:dto];
        [cell.contentView addSubview:awardLabel];
        
        //tag image 标记是否展开
        if([self canOpenCellWithDto:dto])
        {
            UIImageView *spreadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_tableView.frame)-25, (ORDER_DETAIL_PERIODS_TABLE_CELL_HEIGHT-25)/2, 25, 25)];
            if(_openIndex == [indexPath row])
            {
                spreadImageView.image = [UIImage imageNamed:@"orderdetail_down.png"];
            }else{
                spreadImageView.image = [UIImage imageNamed:@"orderdetail_up.png"];
            }
            [cell.contentView addSubview:spreadImageView];
            
        }
        
    }else{      //表格展开的cell
        
        //背景
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), ORDER_DETAIL_PERIODS_TABLE_CELL_HEIGHT)];
        bgImageView.image = [UIImage imageNamed:@"orderdetail_fp_cell_spread.png"];
        [cell.contentView addSubview:bgImageView];
        
        //开奖号码
        OHAttributedLabel *awardNumberLabel = [[OHAttributedLabel alloc] init];
        awardNumberLabel.backgroundColor = [UIColor clearColor];
        awardNumberLabel.underlineLinks = NO;
        
        NSArray *separetorArray = [dto.cawardcode componentsSeparatedByString:@"|"];
        NSString *redBallStr = @"";
        NSString *blueBallStr = @"";
        if([separetorArray count] > 0)
        {
            redBallStr = [separetorArray objectAtIndex:0];
            redBallStr = [redBallStr stringByReplacingOccurrencesOfString:@"," withString:@" "];
        }
        if([separetorArray count] > 1)
        {
            blueBallStr = [separetorArray objectAtIndex:1];
            blueBallStr = [blueBallStr stringByReplacingOccurrencesOfString:@"," withString:@" "];
        }
        
        
        NSMutableAttributedString *awardNumberString = [[NSMutableAttributedString alloc] initWithString:L(@"LOLotteryNumber")];
        [awardNumberString setFont:[UIFont systemFontOfSize:12]];
        [awardNumberString setTextColor:RGBACOLOR(0x33, 0x33, 0x33, 1)];
        
        NSMutableAttributedString *ballAttributeString = [[NSMutableAttributedString alloc] initWithString:redBallStr];
        [ballAttributeString setFont:[UIFont systemFontOfSize:12]];
        [ballAttributeString setTextColor:RGBACOLOR(0x7d, 0, 0, 1)];
        [awardNumberString appendAttributedString:ballAttributeString];
        
        if(blueBallStr != nil)
        {
            NSMutableAttributedString *blueBallAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",blueBallStr]];
            [blueBallAttributedString setFont:[UIFont systemFontOfSize:12]];
            [blueBallAttributedString setTextColor:RGBACOLOR(0, 0x1c, 0x58, 1)];
            [awardNumberString appendAttributedString:blueBallAttributedString];
        }
        awardNumberLabel.attributedText = awardNumberString;
        
        CGSize size = [awardNumberString sizeConstrainedToSize:CGSizeMake(1000, 100)];
        awardNumberLabel.frame = CGRectMake(15, (ORDER_DETAIL_PERIODS_TABLE_CELL_HEIGHT-size.height)/2, 194, size.height);
        
        [cell.contentView addSubview:awardNumberLabel];
        
        
        //中奖信息
        if([dto.iamoney length] > 0 && [dto.iamoney integerValue] != 0)
        {
            UILabel *awardLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_tableView.frame) - 87, 0, 83, ORDER_DETAIL_PERIODS_TABLE_CELL_HEIGHT)];
            awardLabel.backgroundColor = [UIColor clearColor];
            awardLabel.textAlignment = UITextAlignmentCenter;
            awardLabel.font = [UIFont systemFontOfSize:12];
            awardLabel.textColor = RGBACOLOR(0xa7, 0x16, 0x12, 1);
            awardLabel.text = [NSString stringWithFormat:L(@"LOWinNumber"),dto.iamoney];
            [cell.contentView addSubview:awardLabel];
        }
        
    }
    
    return cell;
}

//判断cell能否被展开
- (BOOL)canOpenCellWithDto:(FollowPerodDetailDto *)dto
{
    if([dto.cawardcode length] > 0 && [dto.istate isEqualToString:@"2"] && [dto.iaward isEqualToString:@"2"])
        return YES;
    return NO;
}

- (NSString *)followPeriodState:(FollowPerodDetailDto *)dto 
{
    
    if([dto.istate isEqualToString:@"0"])
    {
        return L(@"LOWaitForAdditionalNumber");
    }else if([dto.istate isEqualToString:@"1"])
    {
        return L(@"Ticketing");
    }else if([dto.istate isEqualToString:@"2"])
    {
        return L(@"LOTicketed");
    }else if([dto.istate isEqualToString:@"3"])
    {
        return L(@"LOSystemRevoke");
    }else if([dto.istate isEqualToString:@"4"])
    {
        return L(@"UserUndo");
    }else if([dto.istate isEqualToString:@"5"])
    {
        return L(@"TicketFail");
    }
    
    return @"";
}

- (NSString *)awardState:(FollowPerodDetailDto *)dto
{
    
    if([dto.istate isEqualToString:@"2"])  //已出票
    {
        if ([dto.iamoney doubleValue] > 0) {
            return L(@"Winned the lottery prize");
        }else if([dto.iaward isEqualToString:@"2"])  //已算奖 & 中奖金额==0
        {
            return L(@"Did not win prize");
        }else{
            return L(@"WaitsLottery");
        }
    }else
    {
        return @"--";
    }
}

@end

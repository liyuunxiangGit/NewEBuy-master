//
//  LoginHistoryView.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "LoginHistoryView.h"

@implementation LoginHistoryView

@synthesize loginList = _loginList;
@synthesize delegate = _delegate;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_loginList);
    
}

- (id)init
{
    self = [super init];
    if (self) {
        if (!_loginList) {
            _loginList = [[NSArray alloc] init];
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.scrollEnabled = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    return self;
}

- (void)refreshNum:(NSArray *)numList
{
    self.loginList = numList;
    
    self.tableView.frame = CGRectMake(0, 55, 320, 40 * (self.loginList.count+1));
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = self.tableView.frame;
    imageView.image = [UIImage streImageNamed:@"login_drop_down_box.png"];
    self.tableView.backgroundView = imageView;
    //        self.tableView.backgroundView = []
    [self addSubview:self.tableView];
    
    [self.tableView reloadData];
    
    
}

#pragma mark -
#pragma mark tableview delegate/datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.loginList count]+1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *loginHistoryListIdentifier = @"loginHistoryListIdentifier";
    SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:loginHistoryListIdentifier];
    
    if (cell == nil) {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loginHistoryListIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        [cell.contentView removeAllSubviews];
    }
    
    if (self.loginList.count > indexPath.row)
    {
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.textColor = [UIColor colorWithRGBHex:0x707070];
        textLabel.font = [UIFont systemFontOfSize:15.0];
        textLabel.textAlignment = UITextAlignmentLeft;
        textLabel.frame = CGRectMake(40, 0, 200, 40);
        textLabel.text = [self.loginList objectAtIndex:indexPath.row];
        [cell.contentView addSubview:textLabel];
    }
    else
    {
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.textColor = [UIColor colorWithRGBHex:0xFC7C26];
        textLabel.font = [UIFont systemFontOfSize:15.0];
        textLabel.textAlignment = UITextAlignmentCenter;
        textLabel.frame = CGRectMake(0, 0, 320, 40);
        textLabel.text = L(@"UCCleanUpHistory");
        [cell.contentView addSubview:textLabel];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.loginList.count > indexPath.row)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectLoginNum:)]) {
            [_delegate didSelectLoginNum:[self.loginList objectAtIndex:indexPath.row]];
        }
    }
    else
    {
        //清空
        [Config currentConfig].loginHistoryList = nil;
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectLoginNum:)]) {
            [_delegate didSelectLoginNum:@""];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectLoginNum:)]) {
        [_delegate didSelectLoginNum:@""];
    }
}

@end

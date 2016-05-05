//
//  SuningFamilyViewController.m
//  SuningEBuy
//
//  Created by  liukun on 12-12-5.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SuningFamilyViewController.h"
#import "ImageManipulator.h"




@implementation SuningFamilyViewController

- (void)dealloc
{
    TT_RELEASE_SAFELY(dataSource);
    
    TT_RELEASE_SAFELY(owners);
    TT_RELEASE_SAFELY(others);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"Suning family");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];

        //初始化数据源
        NSString *filePath = [[NSBundle mainBundle] pathForResource:kSFFileName ofType:@"plist"];
        dataSource = [[NSArray alloc] initWithContentsOfFile:filePath];
        
        if ([dataSource count] > 0)
        {
            owners = [[NSMutableArray alloc] initWithCapacity:1];
            others = [[NSMutableArray alloc] initWithCapacity:[dataSource count]-1];
            
            for (NSDictionary *dic in dataSource)
            {
                NSNumber *isOwner = [dic objectForKey:kSFIsOwnerKey];
                if ([isOwner boolValue]) {
                    [owners addObject:dic];
                }else{
                    [others addObject:dic];
                }
                
            }
        }
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
//    UIView *contentView = self.view;
	
	CGRect frame =[self visibleBoundsShowNav:YES showTabBar:NO] ;//contentView.frame;
	
//	frame.origin.x = 0;
//	
//	frame.origin.y = 0;
//    
//    frame.size.height = contentView.bounds.size.height - 92;
    
    self.groupTableView.frame = frame;
    
    [self.view addSubview:self.groupTableView];
    
    self.hasSuspendButton = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark table view delegate
-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
 
    return 0.0001;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.0001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.0001)];
    
    return v;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.0001)];
    
    return v;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
//        return [owners count];
//    }else{
        return [others count];
 //   }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sfCellIdentifier = @"sfCellIdentifier";
    
    FamilyCell *cell = [tableView dequeueReusableCellWithIdentifier:sfCellIdentifier];
    if (cell == nil) {
        cell = [[FamilyCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:sfCellIdentifier];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.mydelegate = self;
    }
    
    NSDictionary *dic = nil;
//    if (indexPath.section == 0)
//    {
//        dic = [owners objectAtIndex:indexPath.row];
//    }
//    else
//    {
        dic = [others objectAtIndex:indexPath.row];
//    }
    
    [cell setUIItem:dic];
//    
//    //set image
//    UIImage *img = [UIImage imageNamed:[dic objectForKey:kSFIconKey]];
//    cell.imageView.image = img;
//    
//    //set title
//    NSString *name = [dic objectForKey:kSFNameKey];
//    NSString *titleStr = [NSString stringWithFormat:@"%@", name];
//    cell.textLabel.text = titleStr;
//    
//    //setDesc
//    cell.detailTextLabel.text = [dic objectForKey:kSFDescKey];
    
    
    return cell;
}
//
//- (void)tableView:(UITableView *)tableView
//  willDisplayCell:(UITableViewCell *)cell
//forRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    cell.backgroundColor = RGBCOLOR(247, 247, 247);
//    
//    UIImageView *sepLine = (UIImageView *)[cell.contentView viewWithTag:234];
//    if (sepLine == nil) {
//        sepLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 78, 320, 2)];
//        sepLine.image = [UIImage imageNamed:@"cellSeparatorLine.png"];
//        sepLine.tag = 234;
//        [cell.contentView addSubview:sepLine];
//    }
//
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return @"我";
//    }else{
//        return @"苏宁家族";
//    }
//}
-(void)downApp:(NSDictionary *)familyDic{
    
    NSURL *localUrl = [NSURL URLWithString:[familyDic objectForKey:kSFLocalUrlKey]];
    
    if ([[UIApplication sharedApplication] canOpenURL:localUrl])
    {
        [[UIApplication sharedApplication] openURL:localUrl];
    }
    else
    {
        NSURL *itunesUrl = [NSURL URLWithString:[familyDic objectForKey:kSFiTunesUrlKey]];
        [[UIApplication sharedApplication] openURL:itunesUrl];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.section == 0) {
//        return;
//    }else{
        NSDictionary *dic = [others objectAtIndex:indexPath.row];
        NSURL *localUrl = [NSURL URLWithString:[dic objectForKey:kSFLocalUrlKey]];
        
        if ([[UIApplication sharedApplication] canOpenURL:localUrl])
        {
            [[UIApplication sharedApplication] openURL:localUrl];
        }
        else
        {
            NSURL *itunesUrl = [NSURL URLWithString:[dic objectForKey:kSFiTunesUrlKey]];
            [[UIApplication sharedApplication] openURL:itunesUrl];
        }
//    }
}

@end

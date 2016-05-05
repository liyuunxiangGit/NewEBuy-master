//
//  NewHotelIntroduceViewController.m
//  SuningEBuy
//
//  Created by Qin on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NewHotelIntroduceViewController.h"
#import "NewHotelIntroduceTitelCell.h"
#import "NewHotelIntroduceCell.h"
@interface NewHotelIntroduceViewController ()

@end

@implementation NewHotelIntroduceViewController
@synthesize introduceDto=_introduceDto;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)init
{
    self = [super init];
    
    if (self) {
        
        self.title = L(@"hotelIntroduce");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),self.title];
    }
    
    return self;
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

-(void)loadView
{
    [super loadView];
    
//    CGRect frame =[self visibleBoundsShowNav:NO showTabBar:YES];
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
    
    frame.origin.y=0;
    frame.origin.x=0;
    frame.size.height=frame.size.height-44;
    
    self.tableView.frame = frame;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setSeparatorStyle:UITableViewCellSelectionStyleNone];
    [self.view addSubview:self.tableView];
    
    self.hasSuspendButton=YES;
}
#pragma mark -
#pragma mark tableView delegate/datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        
        return [NewHotelIntroduceTitelCell cellHeightWithDto:self.introduceDto];
    }
    
    return [NewHotelIntroduceCell cellHeightWithContentString:_introduceDto.introduce];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
        static NSString *introduceTitleIdentifier = @"introduceTitleCell";
        
        NewHotelIntroduceTitelCell *cell = (NewHotelIntroduceTitelCell *)[tableView dequeueReusableCellWithIdentifier:introduceTitleIdentifier];
        
        if (cell == nil) {
            
            cell = [[NewHotelIntroduceTitelCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:introduceTitleIdentifier];
            
            //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIView *view = [[UIView alloc] init];
            view.frame = cell.bounds;
            view.backgroundColor = [UIColor whiteColor];
            cell.backgroundView = view;
            
        }
        
        [cell setCellWithDto:self.introduceDto];
        
        return cell;
    }
    
    static NSString *introduceCellIdentifier = @"introduceCell";
    
    NewHotelIntroduceCell *cell = (NewHotelIntroduceCell *)[tableView dequeueReusableCellWithIdentifier:introduceCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[NewHotelIntroduceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:introduceCellIdentifier];
        
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIView *view = [[UIView alloc] init];
        view.frame = cell.bounds;
        view.backgroundColor = [UIColor whiteColor];
        cell.backgroundView = view;
        
    }
    
    [cell setCellWithContentString:self.introduceDto.introduce];
    
    return cell;
}
@end

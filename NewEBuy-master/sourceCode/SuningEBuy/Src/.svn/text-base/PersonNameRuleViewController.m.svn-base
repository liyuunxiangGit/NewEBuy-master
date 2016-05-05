//
//  PersonNameRuleViewController.m
//  SuningEBuy
//
//  Created by lanfeng on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PersonNameRuleViewController.h"

@interface PersonNameRuleViewController()

@property(nonatomic,copy)   NSString *helpContent;

@end

@implementation PersonNameRuleViewController

@synthesize helpContent = _helpContent;


- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self.title = L(@"BTPassengerNameRule");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@%@",L(@"virtual_business"),L(@"AddPersonInfoBtn"),self.title];
        
        self.bSupportPanUI = YES;
    }
    
    return self;
}


- (void)backForePage
{
    [self doBack];
}

- (void)loadView{
    
    [super loadView];
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"personNameRule" ofType:@"txt"];
    
	NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    self.helpContent = shellTitleText;

    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    
    self.tableView.frame = frame;
    
    [self.view addSubview:self.tableView];
}


-(void)doBack{
	
	[self.navigationController popViewControllerAnimated:YES];
	
}

#pragma mark -
#pragma mark UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize size = [self.helpContent sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(300, 2000) lineBreakMode:NSLineBreakByCharWrapping];
    return (size.height+20);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if ([cell.contentView.subviews count] == 0) {

        UILabel *lab = [[UILabel alloc]init];
        lab.backgroundColor = [UIColor clearColor];
        lab.font = [UIFont systemFontOfSize:15];
        lab.numberOfLines = 0;
        lab.text = self.helpContent;
        [cell.contentView addSubview:lab];
        
        CGSize size = [self.helpContent sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(300, 2000) lineBreakMode:NSLineBreakByCharWrapping];
        lab.frame = CGRectMake(10,0, 300, size.height+20);
        
    }
    
    return cell;
    
}


@end
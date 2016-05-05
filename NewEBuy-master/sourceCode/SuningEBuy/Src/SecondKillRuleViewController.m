//
//  SecondKillRuleViewController.m
//  SuningEBuy
//
//  Created by cui zl on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SecondKillRuleViewController.h"
#import "SKRuleCell.h"


@implementation SecondKillRuleViewController

@synthesize segCate = _segCate;
@synthesize gameRuleArr = _gameRuleArr;

- (void)dealloc {
    TT_RELEASE_SAFELY(_segCate);
    
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

-(void)loadView{
    
    [super loadView];
    
    self.title = L(@"SK_RULE_SKbaodian");
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SKRule"ofType:@"plist"];
    
    _gameRuleArr = [[NSArray alloc]initWithContentsOfFile:path];
    
    [self.view addSubview:self.segCate];
    
    CGFloat y = self.segCate.bottom ;
    CGFloat height = self.view.bounds.size.height - y;
    
    self.tableView.frame = CGRectMake(0, y , 320, height-92);
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

-(UISegmentedControl*)segCate{
    
    if (!_segCate) {
        NSArray *item = [[NSArray alloc] initWithObjects:L(@"SK_RULE_SKrule"),L(@"SK_RULE_SKmiji"), nil];
        
        _segCate = [[UISegmentedControl alloc] initWithItems:item];
        
        _segCate.segmentedControlStyle = UISegmentedControlStyleBar;
        
        _segCate.selectedSegmentIndex = 0;
        
        _segCate.tintColor = [UIColor navTintColor];
        
        _segCate.multipleTouchEnabled=NO;
        
        [_segCate addTarget:self action:@selector(segmentedControl:) forControlEvents:UIControlEventValueChanged];
        
        [_segCate setFrame:CGRectMake(10, 10, 300, 35)];
        
        TT_RELEASE_SAFELY(item);
    }
    
    return _segCate;
    
}

- (void)segmentedControl:(id)sender {
    
    [self.tableView reloadData];
    
}

- (CGFloat)getHeiht:(NSInteger)section{
    
    NSString *ruleStr = nil  ;
    
    if (self.segCate.selectedSegmentIndex == 0) {
        
        ruleStr = [[[self.gameRuleArr objectAtIndex:0] allValues] objectAtIndex:0];
        
    }else{
        
        ruleStr = [[[self.gameRuleArr objectAtIndex:section] allValues] objectAtIndex:0];
        
    }
    UIFont *cellFont =[UIFont systemFontOfSize:16];
    
    CGSize mainContendSize = [ruleStr heightWithFont:cellFont width:300 linebreak:UILineBreakModeCharacterWrap];
    
    CGFloat height = mainContendSize.height + 20;
    
    return height;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.segCate.selectedSegmentIndex == 0) {
        
        return [self getHeiht:0]-50;
        
    }else{
        
        return 600;
        
    }
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.segCate.selectedSegmentIndex == 0) {
        
        return 1;
        
    }else{
        
        DLog(@"%d",  [self.gameRuleArr count]-1);
        
        return [self.gameRuleArr count]-1;
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.segCate.selectedSegmentIndex == 0)
    {
        UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"ruleCell"]  ;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ruleCell"];
            
            UILabel *textLabel = [[UILabel alloc] init];
            
            textLabel.tag = 1001;
            
            textLabel.font = [UIFont systemFontOfSize:15];
            
            textLabel.textColor = [UIColor darkGrayColor];
            
            textLabel.backgroundColor = [UIColor clearColor];
            
            textLabel.textAlignment = UITextAlignmentLeft;
            
            textLabel.numberOfLines = 0;
            
            [cell.contentView addSubview:textLabel];
            
            TT_RELEASE_SAFELY(textLabel);
            
        }
        UILabel *textLabel = (UILabel *)[cell viewWithTag:1001];
        textLabel.frame = CGRectMake(10, 0, 300, [self getHeiht:0]-50);
        NSDictionary *dic = [self.gameRuleArr objectAtIndex:0];
        textLabel.text = [[dic allValues] objectAtIndex:0];
        
        return cell;
    }else{
        
        static NSString *skRuleCellIndentifier = @"skRuleCellIndentifier";
        
        SKRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:skRuleCellIndentifier];
        
        if(cell == nil){
            
            cell = [[SKRuleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:skRuleCellIndentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        NSDictionary *dic = [self.gameRuleArr objectAtIndex:1];
        
        [cell setContentText:[dic objectForKey:L(@"SK_RULE_SKmiji")]];
        
        return cell;
    }

}


@end

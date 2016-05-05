//
//  FullScreenmagesViewController.m
//  SuningEBuy
//
//  Created by xmy on 12/2/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "FullScreenmagesViewController.h"

@interface FullScreenmagesViewController ()

@end

@implementation FullScreenmagesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    self.imageV.frame = [self setViewFrame:self.hasNav];
    
    self.tableView.frame = [self setViewFrame:self.hasNav];
    
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self useBottomNavBar];
    [self.bottomNavBar addSubview:self.bottomCell];
    
    [self.tableView addSubview:self.imageV];
    
    self.deleteBtn.hidden = NO;
    self.camerAgainBtn.hidden = NO;
    
    [self.bottomCell addSubview:self.deleteBtn];
    
    [self.bottomCell addSubview:self.camerAgainBtn];
 
    self.bottomCell.yiGouBtn.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView*)imageV
{
    if(!_imageV)
    {
        _imageV = [[UIImageView alloc] init];
        
    }
    
    return _imageV;
}

- (UIButton*)camerAgainBtn
{
    if(!_camerAgainBtn)
    {
        _camerAgainBtn = [[UIButton alloc] init];
        
        [_camerAgainBtn setTitle:L(@"Product_BuyAgain") forState:UIControlStateNormal];
        
        [_camerAgainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _camerAgainBtn.frame = CGRectMake(200, 10, 102, 35);
        
        _camerAgainBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"orange_button.png"];
        
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_camerAgainBtn setBackgroundImage:stretchableButtonImageNormal
                           forState:UIControlStateNormal];
        [_camerAgainBtn setBackgroundImage:[UIImage streImageNamed:@"orange_button_clicked.png"]
                           forState:UIControlStateHighlighted];
        _camerAgainBtn.hidden = YES;
        
        [self.bottomCell addSubview:_camerAgainBtn];
    }
    
    return _camerAgainBtn;
}



- (UIButton*)deleteBtn
{
    if(!_deleteBtn)
    {
        _deleteBtn = [[UIButton alloc] init];
        
        [_deleteBtn setTitle:L(@"Delete") forState:UIControlStateNormal];
        
        [_deleteBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        
        _deleteBtn.frame = CGRectMake(100, 10, 87, 35);

        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"button_white_normal.png"];
        
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        
        [_deleteBtn setBackgroundImage:stretchableButtonImageNormal
                                   forState:UIControlStateNormal];
        
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"]
                                   forState:UIControlStateHighlighted];
        _deleteBtn.hidden = YES;
        
        [self.bottomCell addSubview:_deleteBtn];
    }
    
    return _deleteBtn;
}


@end

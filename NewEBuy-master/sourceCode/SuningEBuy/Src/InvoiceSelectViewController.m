//
//  InvoiceSelectViewController.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-4-29.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "InvoiceSelectViewController.h"
#import "ReceiveInfoViewController.h"

//@interface InvoiceDto : NSObject
//
//@property (nonatomic, strong) NSString  *invoiceName;
//
//@property (nonatomic, assign) BOOL      isSelected;
//
//@property (nonatomic, assign) BOOL      canSelected;
//
//@property (nonatomic, assign) NSInteger tag;
//
//@end
//
//@implementation InvoiceDto
//
//@end


@interface InvoiceSelectViewController ()

//@property (nonatomic, strong) NSArray   *invoiceList;

@end

@implementation InvoiceSelectViewController
{
    NSUInteger invoiceType; // 0:电子发票 2:普通发票 5:不开发票
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWith:(ReceiveInfoViewController *)object withType:(NSInteger)type
{
    self=[super init];
    if (self) {
        self.title=@"发票信息";
        self.pageTitle = @"购物流程-购物车-发票信息";
        self.obj = object;
        invoiceType = type;
        if (invoiceType == 2)
        {
            self.isEleInvoice = YES;
        }else
        {
            self.isEleInvoice = NO;
        }
        self.invoiceTextFld.text = object.invoiceStr;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    if (IOS7_OR_LATER) {
        self.tpGroupTableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
        [self.tpGroupTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        self.tpTableView.scrollEnabled = NO;
        [self.view addSubview:self.tpGroupTableView];
        
        self.tpTableView = self.tpGroupTableView;
    }
    else
    {
        self.tpTableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
        [self.tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        self.tpTableView.scrollEnabled = NO;
        [self.view addSubview:self.tpTableView];
    }
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

- (UITextField *)invoiceTextFld
{
    if (_invoiceTextFld == nil)
    {
        _invoiceTextFld = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 180, 30)];
        _invoiceTextFld.borderStyle = UITextBorderStyleNone;
        _invoiceTextFld.backgroundColor = [UIColor clearColor];
        _invoiceTextFld.textColor = [UIColor light_Black_Color];
        _invoiceTextFld.font = [UIFont systemFontOfSize:15];
        _invoiceTextFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _invoiceTextFld.autocorrectionType = UITextAutocorrectionTypeNo;
        _invoiceTextFld.placeholder = L(@"please input invoice header");
        _invoiceTextFld.keyboardType = UIKeyboardTypeDefault;
        _invoiceTextFld.returnKeyType = UIReturnKeyDone;
        _invoiceTextFld.clearButtonMode = UITextFieldViewModeWhileEditing;
        _invoiceTextFld.delegate = self;
    }
    return _invoiceTextFld;
}

#pragma mark -
#pragma mark Table View DataSource And Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        return 65;
    }
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (0 == section )
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        view.frame = CGRectMake(0, 0, 320, 65);
        
        UIView *view1 = [[UIView alloc] init];
        view1.backgroundColor = [UIColor whiteColor];
        view1.frame = CGRectMake(0, 15, 320, 50);
        [view addSubview: view1];
        
        UILabel *titleLbl = [[UILabel alloc] init];
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.frame = CGRectMake(15, 15, 100, 20);
        titleLbl.text = L(@"PFInvoiceType");
        titleLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        titleLbl.font = [UIFont systemFontOfSize:15];
        [view1 addSubview:titleLbl];
        
        if (!IOS7_OR_LATER) {
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64.5, 320, 0.5)];
            line.image = [UIImage imageNamed:@"line.png"];
            [view addSubview:line];
        }
        
        return view;
    }
    else
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        view.frame = CGRectMake(0, 0, 320, 15);
        return view;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *invoiceCellIdentifier = @"invoiceCellIdentifier";
        InvoiceSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:invoiceCellIdentifier];
        if (cell == nil)
        {
            cell = [[InvoiceSelectCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:invoiceCellIdentifier];
            if (IOS7_OR_LATER) {
                cell.backgroundColor = [UIColor whiteColor];
            }else{
                UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
                bgView.backgroundColor = [UIColor whiteColor];
                cell.backgroundView = bgView;
            }
        }
        if (YES == self.canUseEleInvoice) {
            if (0 == indexPath.row)
            {
                [cell setItem:L(@"PFElectronicInvoice") isSelect:self.isEleInvoice];
            }
            else
            {
                [cell setItem:L(@"PFOrdinaryInvoice") isSelect:!self.isEleInvoice];
            }
        }
        else
        {
            if (0 == indexPath.row)
            {
                [cell setTitle:L(@"PFElectronicInvoice") canSelect:NO];
            }
            else
            {
                [cell setTitle:L(@"PFOrdinaryInvoice") canSelect:YES];
            }
        }
        return cell;
    }
    else if (indexPath.section ==1)
    {
        static NSString *cellIdentifier_3 = @"cellIdentifier_3";
        SNUITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellIdentifier_3];
        if (cell == nil)
        {
            cell = [[SNUITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:cellIdentifier_3];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor light_Black_Color];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@：",L(@"PFInvoiceHeader")];
        [cell.contentView addSubview:self.invoiceTextFld];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (YES == self.canUseEleInvoice) {
        if (indexPath.section == 0)
        {
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"102060%d",indexPath.row+1], nil]];
            if (indexPath.row == 0)
            {
                self.isEleInvoice = YES;
                invoiceType = 2;
            }
            else if (indexPath.row == 1)
            {
                self.isEleInvoice = NO;
                invoiceType = 0;
            }
        }
        [self.tpTableView reloadData];
    }
}

- (void)backForePage
{
    if (IsStrEmpty(self.invoiceTextFld.text))
    {
        [self presentSheet:L(@"PFInvoiceHeaderCannotBeEmpty")];
        return;
    }
    [self.obj chooseInvoiceType:invoiceType with:self.invoiceTextFld.text];
    [self.navigationController popToViewController:self.obj animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.invoiceTextFld resignFirstResponder];
    return YES;
}

@end

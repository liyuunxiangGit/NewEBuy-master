//
//  InvoiceSelectTemporaryViewController.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-11-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "InvoiceSelectTemporaryViewController.h"
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

@interface InvoiceSelectTemporaryViewController ()

@property (nonatomic, strong) NSArray   *invoiceList;

@end

@implementation InvoiceSelectTemporaryViewController
{
    NSUInteger invoiceType; // 0:电子发票 2:普通发票 5:不开发票
}
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (id)initWith:(ReceiveInfoViewController *)object withType:(NSInteger)type
//{
//    self=[super init];
//    if (self) {
//        self.title=L(@"PFInvoiceInformation");
//        self.pageTitle = L(@"Product_ShoppingCart_InvoiceInformation");
//        self.obj = object;
//        invoiceType = type;
//        
//        InvoiceDto *dto1 = [[InvoiceDto alloc] init];
//        dto1.invoiceName = L(@"PFElectronicInvoice");
//        dto1.canSelected = self.canUseEleInvoice;
//        dto1.tag = 0;
//        
//        InvoiceDto *dto2 = [[InvoiceDto alloc] init];
//        dto2.invoiceName = L(@"PFOrdinaryInvoice");
//        dto2.canSelected = YES;
//        dto2.tag = 1;
//        
//        InvoiceDto *dto3 = [[InvoiceDto alloc] init];
//        dto3.invoiceName = L(@"PFNoInvoice");
//        dto3.canSelected = self.canUseEleInvoice;
//        dto3.tag = 2;
//        
//        if (invoiceType == 0) {
//            dto2.isSelected = YES;
//            dto1.isSelected = NO;
//            dto3.isSelected = NO;
//        }
//        else if (invoiceType == 2)
//        {
//            dto1.isSelected = YES;
//            dto2.isSelected = NO;
//            dto3.isSelected = NO;
//        }
//        else
//        {
//            dto1.isSelected = NO;
//            dto2.isSelected = NO;
//            dto3.isSelected = YES;
//        }
//        
//        self.invoiceList = @[dto1,dto2,dto3];
//        
//        self.invoiceTextFld.text = object.invoiceStr;
//        self.hidesBottomBarWhenPushed = YES;
//    }
//    return self;
//}
//
//- (void)loadView
//{
//    [super loadView];
//    if (IOS7_OR_LATER) {
//        self.tpGroupTableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
//        [self.tpGroupTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
//        self.tpTableView.scrollEnabled = NO;
//        [self.view addSubview:self.tpGroupTableView];
//        
//        self.tpTableView = self.tpGroupTableView;
//    }
//    else
//    {
//        self.tpTableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
//        [self.tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
//        self.tpTableView.scrollEnabled = NO;
//        [self.view addSubview:self.tpTableView];
//    }
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (UITextField *)invoiceTextFld
//{
//    if (_invoiceTextFld == nil)
//    {
//        _invoiceTextFld = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 180, 30)];
//        _invoiceTextFld.borderStyle = UITextBorderStyleNone;
//        _invoiceTextFld.backgroundColor = [UIColor clearColor];
//        _invoiceTextFld.textColor = [UIColor light_Black_Color];
//        _invoiceTextFld.font = [UIFont systemFontOfSize:15];
//        _invoiceTextFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        _invoiceTextFld.autocorrectionType = UITextAutocorrectionTypeNo;
//        _invoiceTextFld.placeholder = L(@"please input invoice header");
//        _invoiceTextFld.keyboardType = UIKeyboardTypeDefault;
//        _invoiceTextFld.returnKeyType = UIReturnKeyDone;
//        _invoiceTextFld.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _invoiceTextFld.delegate = self;
//    }
//    return _invoiceTextFld;
//}
//
//#pragma mark -
//#pragma mark Table View DataSource And Delegate Methods
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (0 == section)
//    {
//        return [self.invoiceList count];
//    }
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (0 == section) {
//        return 65;
//    }
//    return 15;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (0 == section )
//    {
//        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = [UIColor clearColor];
//        view.frame = CGRectMake(0, 0, 320, 65);
//        
//        UIView *view1 = [[UIView alloc] init];
//        view1.backgroundColor = [UIColor whiteColor];
//        view1.frame = CGRectMake(0, 15, 320, 50);
//        [view addSubview: view1];
//        
//        UILabel *titleLbl = [[UILabel alloc] init];
//        titleLbl.backgroundColor = [UIColor clearColor];
//        titleLbl.frame = CGRectMake(15, 15, 100, 20);
//        titleLbl.text = L(@"PFInvoiceType");
//        titleLbl.textColor = [UIColor colorWithRGBHex:0x313131];
//        titleLbl.font = [UIFont systemFontOfSize:15];
//        [view1 addSubview:titleLbl];
//        
//        if (!IOS7_OR_LATER) {
//            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64.5, 320, 0.5)];
//            line.image = [UIImage imageNamed:@"line.png"];
//            [view addSubview:line];
//        }
//        
//        return view;
//    }
//    else
//    {
//        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = [UIColor clearColor];
//        view.frame = CGRectMake(0, 0, 320, 15);
//        return view;
//    }
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0)
//    {
//        static NSString *invoiceCellIdentifier = @"invoiceCellIdentifier";
//        InvoiceSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:invoiceCellIdentifier];
//        if (cell == nil)
//        {
//            cell = [[InvoiceSelectCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:invoiceCellIdentifier];
//            if (IOS7_OR_LATER) {
//                cell.backgroundColor = [UIColor whiteColor];
//            }else{
//                UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//                bgView.backgroundColor = [UIColor whiteColor];
//                cell.backgroundView = bgView;
//            }
//        }
//        
//        InvoiceDto *dto = self.invoiceList[indexPath.row];
//        if (YES == self.canUseEleInvoice) {
//            [cell setItem:dto.invoiceName isSelect:dto.isSelected];
//            //            if (YES == self.isDefaultEleInvoice) {
//            //                if (0 == indexPath.row)
//            //                {
//            //                    [cell setItem:@"电子发票" isSelect:self.isEleInvoice];
//            //                }
//            //                else if (1 == indexPath.row)
//            //                {
//            //                    [cell setItem:@"普通发票" isSelect:!self.isEleInvoice];
//            //                }
//            //                else
//            //                {
//            //                    [cell setItem:@"不开发票" isSelect:!self.isEleInvoice];
//            //                }
//            //            }
//            //            else
//            //            {
//            //                if (0 == indexPath.row)
//            //                {
//            //                    [cell setItem:@"电子发票" isSelect:!self.isEleInvoice];
//            //                }
//            //                else if (1 == indexPath.row)
//            //                {
//            //                    [cell setItem:@"普通发票" isSelect:!self.isEleInvoice];
//            //                }
//            //                else
//            //                {
//            //                    [cell setItem:@"不开发票" isSelect:self.isEleInvoice];
//            //                }
//            //            }
//            
//        }
//        else
//        {
//            [cell setTitle:dto.invoiceName canSelect:dto.canSelected];
//            //            if (0 == indexPath.row)
//            //            {
//            //                [cell setTitle:@"电子发票" canSelect:NO];
//            //            }
//            //            else if (1 == indexPath.row)
//            //            {
//            //                [cell setTitle:@"普通发票" canSelect:YES];
//            //            }
//            //            else
//            //            {
//            //                [cell setTitle:@"不开发票" canSelect:NO];
//            //            }
//        }
//        return cell;
//    }
//    else if (indexPath.section ==1)
//    {
//        static NSString *cellIdentifier_3 = @"cellIdentifier_3";
//        SNUITableViewCell *cell =
//        [tableView dequeueReusableCellWithIdentifier:cellIdentifier_3];
//        if (cell == nil)
//        {
//            cell = [[SNUITableViewCell alloc]
//                    initWithStyle:UITableViewCellStyleSubtitle
//                    reuseIdentifier:cellIdentifier_3];
//            cell.textLabel.font = [UIFont systemFontOfSize:15];
//            cell.textLabel.backgroundColor = [UIColor clearColor];
//            cell.textLabel.textColor = [UIColor light_Black_Color];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        cell.textLabel.text = [NSString stringWithFormat:@"%@：",L(@"PFInvoiceHeader")];
//        [cell.contentView addSubview:self.invoiceTextFld];
//        return cell;
//    }
//    return [UITableViewCell new];
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (YES == self.canUseEleInvoice) {
//        if (indexPath.section == 0)
//        {
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"102060%d",indexPath.row+1], nil]];
//            
//            for (InvoiceDto *dto in self.invoiceList) {
//                if (dto.tag == indexPath.row) {
//                    dto.isSelected = YES;
//                }
//                else
//                    dto.isSelected = NO;
//            }
//            
//            if (indexPath.row == 0)
//            {
//                invoiceType = 2;
//            }
//            else if (indexPath.row == 1)
//            {
//                invoiceType = 0;
//            }else
//            {
//                invoiceType = 5;
//            }
//        }
//        [self.tpTableView reloadData];
//    }
//}
//
//- (void)backForePage
//{
//    if (IsStrEmpty(self.invoiceTextFld.text))
//    {
//        [self presentSheet:L(@"PFInvoiceHeaderCannotBeEmpty")];
//        return;
//    }
//    [self.obj chooseInvoiceType:invoiceType with:self.invoiceTextFld.text];
//    [self.navigationController popToViewController:self.obj animated:YES];
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [self.invoiceTextFld resignFirstResponder];
//    return YES;
//}


@end

//
//  ProductDisOrderDetailsViewController.m
//  SuningEBuy
//
//  Created by xy ma on 12-2-17.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "ProductDisOrderDetailsViewController.h"
#import "DisOrderPhotosViewController.h"
#import "EGOPhotoViewController.h"
#import "MyPhoto.h"
#import "MyPhotoSource.h"

@implementation ProductDisOrderDetailsViewController

@synthesize webUITableView=_webUITableView;
@synthesize webView = _webView;
@synthesize productTextLabel = productTextLabel_;
@synthesize disOrderDetailLabel = disOrderDetailLabel_;
@synthesize imageArray = imageArray_;
@synthesize disOrderimageView = disOrderimageView_;
@synthesize disProductDetailsItemList = disProductDetailsItemList_;
@synthesize shaidanzhengwen =shaidanzhengwen_;
@synthesize productName = productName_;
@synthesize imageDownloadList = imageDownloadList_;
@synthesize ProductDisOrderReplyItem = ProductDisOrderReplyItem_;
@synthesize selectDisProductDetailsDTO = selectDisProductDetailsDTO_;
@synthesize dataProductBasic = dataProductBasic_;
@synthesize service=_service;


- (void)dealloc {
    TT_RELEASE_SAFELY(_webUITableView);
    TT_RELEASE_SAFELY(_webView);
    TT_RELEASE_SAFELY(productTextLabel_);
    TT_RELEASE_SAFELY(disOrderDetailLabel_);
    TT_RELEASE_SAFELY(imageArray_);
    TT_RELEASE_SAFELY(disOrderimageView_);
    TT_RELEASE_SAFELY(disProductDetailsItemList_)
    TT_RELEASE_SAFELY(imageDownloadList_);
    TT_RELEASE_SAFELY(ProductDisOrderReplyItem_);
    TT_RELEASE_SAFELY(selectDisProductDetailsDTO_);
    TT_RELEASE_SAFELY(dataProductBasic_);
}

- (id)init {
    self = [super init];
    if (self) {
        
        self.title = L(@"Display Order Delites");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];
    }
    
    return self;
}

-(id)initWithDTO:(DisProductDetailsDTO *)dto{
    if ((self = [super init])){
        self.title = L(@"Display Order Delites");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];
        self.selectDisProductDetailsDTO = dto;
        
        _service=[[FindDisorderByIdService alloc]init];
        self.service.delegate=self;
    }
    return self;
}


- (void)loadView{
    [super loadView];
    
	CGRect frame = self.view.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
    
    frame.size.height = self.view.bounds.size.height - 92 ;
    
    self.groupTableView.frame = frame;
    
    
    NSMutableArray *listArr = [[NSMutableArray alloc] init];
    self.disProductDetailsItemList = listArr;
    TT_RELEASE_SAFELY(listArr);
    
    NSMutableArray *imagelist = [[NSMutableArray alloc] init];
    self.imageDownloadList = imagelist;
    TT_RELEASE_SAFELY(imagelist);
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //初始化刷新
	if(!isOrderLoaded || ([disProductDetailsItemList_ count]==0)){
        [self displayOverFlowActivityView];
        [self.service sendFindDisorderByIdHttpRequest:self.selectDisProductDetailsDTO.articleId];
	}


    
}

#pragma mark -
#pragma mark Table View Delegate Methods

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return L(@"Product_ProductLink");
        case 1:
            return L(@"Product_DisOrderMainContent");
        case 2:
            return @"";
        case 3:
            return L(@"Product_DisOrderReply");
            
        default:
            return @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 2:
            rowCount = ([self.imageArray count]>0? ([self.imageArray count]):0);
            break;
        case 3:
            rowCount = ([self.ProductDisOrderReplyItem count]>0? ([self.ProductDisOrderReplyItem count]):0);
            break;
        default:
            rowCount = 1;
    }
    
    return rowCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 80;
        case 1:
            if (nil == self.shaidanzhengwen) {
                return 10;
            }else {
                UIFont *font = [UIFont systemFontOfSize:16.0];
                CGFloat height = [self.shaidanzhengwen heightWithFont:font width:290 linebreak:UILineBreakModeCharacterWrap].height;
                
                return height+15;
            }  
            //return 250;
        case 2:
            return 300;
        case 3:
            return [ProductDisOrderReplyCell height:[self.ProductDisOrderReplyItem objectAtIndex:indexPath.row]];
        default:
            return 100;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            
            
            static NSString *productCellIdentifier = @"productCellIdentifier";
            
            ProductDIsProductCell *cell = (ProductDIsProductCell *)[tableView dequeueReusableCellWithIdentifier:productCellIdentifier];
            
            if(cell == nil){
                
                cell = [[ProductDIsProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellIdentifier];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            // DataProductBasic *dto = [self.dataProductBasic objectAtIndex:indexPath.row];
            
            [cell setItem:self.dataProductBasic];
            
            cell.backgroundColor = [UIColor clearColor];
            
            return cell;    
            
            
        }
            
        case 1:
        {
            static NSString *disOrderDetailIdentifier = @"disOrderDetailIdentifier";
            
            UITableViewCell *disOrderDetailCell = [tableView dequeueReusableCellWithIdentifier:disOrderDetailIdentifier];
            
            if (!disOrderDetailCell)
            {
                disOrderDetailCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:disOrderDetailIdentifier];
                
                [disOrderDetailCell.contentView addSubview:self.disOrderDetailLabel];
                
            }
            
            // disOrderDetailCell.backgroundColor = [UIColor clearColor];
            
            //[disOrderDetailCell.contentView addSubview:self.disOrderDetailLabel];
            
            disOrderDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return disOrderDetailCell;
            
            
        }
            
            
        case 2:
        {
            
            static NSString *disOrderimageIdentifier = @"disOrderimageIdentifier";
            
            ProductDisImgeCell *cell = (ProductDisImgeCell *)[tableView dequeueReusableCellWithIdentifier:disOrderimageIdentifier];
            
            if (cell == nil) {
                cell =[[ProductDisImgeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:disOrderimageIdentifier];
            }
            
            [cell setItem:[self.imageArray objectAtIndex:indexPath.row]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        case 3:
        {
            NSInteger row = indexPath.row;
            
            static NSString *ProductDisOrderReplyCellIdentifier = @"ProductDisOrderReplyCellIdentifier";
            
            ProductDisOrderReplyCell *cell = (ProductDisOrderReplyCell *)[tableView dequeueReusableCellWithIdentifier:ProductDisOrderReplyCellIdentifier];
            
            if(cell == nil){
                
                cell = [[ProductDisOrderReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductDisOrderReplyCellIdentifier];
            }
            
            [cell setItem:[self.ProductDisOrderReplyItem objectAtIndex:row]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }        
            
        default:
            
            break;
    }
    
    return nil;
    
}

//点击事件：section=0 跳转到商品详情页面；section=2 跳转到图片展示页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    switch (indexPath.section) {
        case 0:{
            
            DataProductBasic *dto = self.dataProductBasic;
            
            ProductDetailViewController *productVC = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
            
            [self.navigationController pushViewController:productVC animated:YES];
            
            TT_RELEASE_SAFELY(productVC);
            
            return;
            
        }
        case 2:
        {
            
            if (self.imageArray !=nil && [self.imageArray count]>0)
            {
                
                NSMutableArray *imageStringArray = [[NSMutableArray alloc]init];
                
                for (ProductDisImgeDTO *dto in self.imageArray) 
                {
                    
                    if (dto)
                    {
                        [imageStringArray addObject:[NSURL URLWithString:dto.productDisImageClickURL]];
                    }
                    
                }            
                
//                DisOrderPhotosViewController *disOrderPhotosViewController = [[DisOrderPhotosViewController alloc] initWithImageUrlArray:imageStringArray];
//                                
//                [imageStringArray release];
//                
//                disOrderPhotosViewController.currentImagePage = indexPath.row;
//                
//                [self.navigationController presentModalViewController:disOrderPhotosViewController animated:YES];
//
//                TT_RELEASE_SAFELY(disOrderPhotosViewController);
                
                NSMutableArray *sourceArr = [[NSMutableArray alloc] initWithCapacity:[imageStringArray count]];
                for (NSURL *url in imageStringArray)
                {
                    MyPhoto *photo = [[MyPhoto alloc] initWithImageURL:url];
                    [sourceArr addObject:photo];
                }
                MyPhotoSource *source = [[MyPhotoSource alloc] initWithPhotos:sourceArr];
                
                EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:source];
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:photoController];
                
                navController.modalPresentationStyle = UIModalPresentationFullScreen;
                if (IOS5_OR_LATER)
                {
                    [self presentViewController:navController animated:YES completion:^{
                        [photoController moveToPhotoAtIndex:indexPath.row animated:NO];
                    }];
                }
                else
                {
                    [self presentModalViewController:navController animated:YES];
                    [photoController moveToPhotoAtIndex:indexPath.row animated:NO];
                }
                
                TT_RELEASE_SAFELY(navController);
                TT_RELEASE_SAFELY(photoController);
                TT_RELEASE_SAFELY(source);

                
                return;
            }
        }
            
        default:return;
    }
    
}








- (EGOImageViewEx *)disOrderimageView{
    if (disOrderimageView_ == nil) {
        disOrderimageView_ = [[EGOImageViewEx alloc]init];
        disOrderimageView_.backgroundColor = [UIColor clearColor];
        
    }
    return disOrderimageView_;
}

- (UILabel *)productTextLabel
{
    if (productTextLabel_ == nil)
    {
        
        productTextLabel_ = [[UILabel alloc]init];
        
        productTextLabel_.backgroundColor = [UIColor clearColor];
        
        productTextLabel_.textAlignment = UITextAlignmentLeft;
        
        productTextLabel_.numberOfLines = 0;
        
        productTextLabel_.text = (self.dataProductBasic.productName == nil || [self.dataProductBasic.productName  isEqualToString:@""]) ?L(@"title"):self.dataProductBasic.productName;
        
        productTextLabel_.frame = CGRectMake(5, 0, 290, 48);
        
        productTextLabel_.font = [UIFont fontWithName:@"Heiti k" size:16.0];
        
    }
    return productTextLabel_;
}



- (UILabel *)disOrderDetailLabel
{
    if (disOrderDetailLabel_ == nil)
    {
        
        disOrderDetailLabel_ = [[UILabel alloc]init];
        disOrderDetailLabel_.backgroundColor = [UIColor clearColor];
        disOrderDetailLabel_.textAlignment = UITextAlignmentLeft;
        disOrderDetailLabel_.numberOfLines = 0;
        disOrderDetailLabel_.lineBreakMode = UILineBreakModeCharacterWrap;
        
        UIFont *font = [UIFont systemFontOfSize:16.0];
        CGFloat height = [self.shaidanzhengwen heightWithFont:font width:290 linebreak:UILineBreakModeCharacterWrap].height;
        
        disOrderDetailLabel_.frame = CGRectMake(5, 0, 290, height+10);
        
        disOrderDetailLabel_.font = font;
    }
    return disOrderDetailLabel_;
}






-(void)FindDisorderByIdHttpRequestCompleteWithService:(FindDisorderByIdService *)service 
                                            isSuccess:(BOOL)isSuccess
{
    if(isSuccess)
    {
        [self removeOverFlowActivityView];
        
        isOrderLoaded = YES;
        
        self.imageArray=service.imageArray;
        
        self.disProductDetailsItemList=service.disProductDetailsItemList;
        
        self.ProductDisOrderReplyItem=service.ProductDisOrderReplyItem;
        
        DisProductDetailsDTO *shaidanDto=[self.disProductDetailsItemList objectAtIndex:0];
        
        if (NotNilAndNull(shaidanDto.content) && ![shaidanDto.content isEmptyOrWhitespace]) {
               self.shaidanzhengwen=shaidanDto.content;
        }
        else{
            
            self.shaidanzhengwen =  L(@"Product_SystemDefaultGoodComment");
            
        }
        
        self.disOrderDetailLabel.text= self.shaidanzhengwen;
        
    }
    else
    {
        [self presentSheet:service.errorMsg?service.errorMsg:L(@"Sorry loading failed")];
    }
    
    [self performSelectorOnMainThread:@selector(updateTable) withObject:nil waitUntilDone:NO];
}





- (void) updateTable{
    
    if(self.groupTableView.superview == nil){
        
        [self.view addSubview: self.groupTableView];
    }
    [self.groupTableView reloadData];
}

- (int)countSubString:(NSString *)TotalString subString:(NSString *)subString{
    
    int i = 0;
    i = [[TotalString  componentsSeparatedByString:subString] count];
    return i;
    
}



- (UIWebView *) webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        
        //验证即便html格式
        // NSString *htmlstring = @"<font color=\"#ff0000\">订单号：</font>";
        //验证图片引入
        NSString *htmlstring = L(@"Product_RemindTips");
        
        // NSString *htmlstring = @"<p><font color=\"#ff0000\" size=\"5\" face=\"宋体\">商品链接：<a href=\"http://www.suning.cn/webapp/wcs/stores/servlet/prd_10052_10051_-7__160627_1.html\">http://www.suning.cn/webapp/wcs/stores/servlet/prd_10052_10051_-7__160627_1.html</a><br />\n<font color=\"#000000\">订单号：</font><em><font color=\"#000000\">4716628<br />\n</font></em><span style=\"font-family: 宋体; font-size: 14pt\"><font color=\"#000000\"><em>订单日期：</em>2010年12月25日<br />\n</font></span></font></p>\n<h5><font color=\"#000000\"><span style=\"font-size: 14pt\"><font color=\"#000000\"><span style=\"font-family: 宋体; font-size: 14pt\"><font color=\"#000000\"><span style=\"font-family: 宋体; font-size: 14pt\">易购分享：苏宁网上的价格很给力，如果你抽到100的圣诞优惠券，你再充值5000可以获得100的返券。这样你可以省下200元，原价2158将降为<span style=\"background-color: yellow\">1958</span>。这和实体店的卖价2200差距实在太大了。但是我看了下，大部分人都是抽到的80的圣诞优惠券。另外，如果你不想充值太多，想刚好抵扣你买的C6-00的价格，那么你充2000也将有40的返券。这样你也可以省下80+40=120，算下来也就是2158-120=<span style=\"background-color: yellow\">2038</span>，这样你的易购账户充的2000也刚好用完，你再自己在线支付38元即可。而2038的价格和店面卖的2200左右的价格相比仍然是相当给力。但是苏宁的送货那是相当</spaspann><span style=\"color: #ff0000\"><span style=\"font-family: 宋体; font-size: 14pt\">不给力，<span style=\"color: #000000\">12/25晚下单，直到1/9才短信通知可以取手机，1/10晚自己门店自提取货，终于拿到手。再说下用了2天的感觉，由于以前也是用的诺基亚塞班的系统，用起来上手还是比较快。500万的摄像头，加4倍自动变焦，再加LED闪光没得话说。但是处理器就略显不足，反应速度和1GHZ的比起来是有差距，但是还是够用。2G的标配卡在删除一些不必要的软件再自己装了些飞信、qq、MSN、UC、大智慧等等软件的情况下只剩400M左右的空间。建议打算买的人再另外买张8G的卡。3.2的电阻屏还不错，虽然不能和电容屏相比，够用就行。最后，C6拿在手上的感觉很好，够分量，这点对男士来说比较重要，总不希望拿在手上像没东西一样吧。最后总评，总的来说还算比较实惠，特别是在2000左右的价格。一句话:2000左右的价格值得出手。</span></span></span></font></span></font></></font></h5>\n下面是实物图：<br />\n发票为C6拍的<br />\n<img style=\"width: 716px; height: 272px\" alt=\"\" src=\"http://zhishi.suning.com/zhishitang_docs/articles/images/urphotos/zst_199621120110112205420.jpg\" /><br />\n手机实物图为诺基亚老手机200W拍的（颜色有失真）：<br />\n<br />\n<img style=\"width: 282px; height: 169px\" alt=\"\" src=\"http://zhishi.suning.com/zhishitang_docs/articles/images/urphotos/zst_784559620110112205834.jpg\" /><img style=\"width: 238px; height: 184px\" alt=\"\" src=\"http://zhishi.suning.com/zhishitang_docs/articles/images/urphotos/zst_341066820110112205951.jpg\" /><img width=\"267\" height=\"200\" alt=\"\" src=\"http://zhishi.suning.com/zhishitang_docs/articles/images/urphotos/zst_549857820110112210051.jpg\" /><br />\n<br />\n<br />\n<br />";
        
        [_webView loadHTMLString:htmlstring baseURL:nil];
        
        _webView.frame = CGRectMake(0, 0, 320, 480);
    }
    return _webView;
}

@end

//
//  NBYStickDetailViewController.m
//  SuningEBuy
//
//  Created by XZoscar on 14-10-2.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NBYStickDetailViewController.h"
#import "NBYSHttpService.h"
#import "NBCCSharedData.h"
#import "NBYDaShangViewController.h"
#import "NBCommentsListViewController.h"
#import "UIImageView+WebCache.h"

#import "ProductDetailViewController.h"
#import "DataProductBasic.h"


@interface NBYStickDetailViewController () <NBYSHttpServiceDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) IBOutlet UIScrollView *imgsScrollView;

@property (nonatomic,strong) IBOutlet UIButton     *prodDetailButton;

@property (nonatomic,strong) IBOutlet UILabel      *pageLabel;

@property (nonatomic,strong) IBOutlet UITextView   *textView0;

@property (nonatomic,strong) NBYSHttpService       *httpService;
@property (nonatomic,strong) NSDictionary          *detail;
@property (nonatomic,assign) int                   imgsCount;
@end

@implementation NBYStickDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"详情"];
    self.view.backgroundColor = [UIColor blackColor];
    
//    SEL sel = @selector(on_panGestureRecognizerResponse:);
//    UIPanGestureRecognizer *ges = [[UIPanGestureRecognizer alloc] initWithTarget:self
//                                                                          action:sel];
//    [self.commomScrollView addGestureRecognizer:ges];
    
     _prodDetailButton.hidden = YES;
    
    [self displayOverFlowActivityView];
    [self requestGetStickDetail];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)on_panGestureRecognizerResponse:(UIPanGestureRecognizer *)ges {
//    
//    if (ges.state == UIGestureRecognizerStateEnded
//        && ges.state != UIGestureRecognizerStateFailed) {
//        BOOL bHide = self.navigationController.navigationBarHidden;
//        [self.navigationController setNavigationBarHidden:!bHide animated:YES];
//    }
//}

- (void)requestGetStickDetail {
    
    //NSString *stickId = EncodeStringFromDic(_stick, @"id");
    
    NSDictionary *paras = @{@"contId":((nil==_contId)?@"":_contId),
                           @"u":[NBCCSharedData userInfo],
                           @"pos":[NBCCSharedData postion]};

    [self.httpService requestGetStickDetailtWithParas:paras];
}

#pragma mark - http service

- (NBYSHttpService *)httpService {
    
    if (nil == _httpService) {
        _httpService = [[NBYSHttpService alloc] init];
        _httpService.delegate = self;
    }
    return _httpService;
}

- (void)delegate_nbys_httpService_result:(NSDictionary *)result
                                 usrInfo:(id)userInfo
                                   error:(NSError *)error
                                     cmd:(E_CMDCODE)cmd {
    if (cmd == CC_NBYGetStickDetail) {
     
        if (nil == error) {
            self.detail = EncodeDicFromDic(result, @"data");
            
            // {{{ 若有产品id 表明是 晒单
            NSString *productId = EncodeStringFromDic(_detail, @"productId");
            if (nil != productId) {
              _prodDetailButton.hidden = NO;
            }
            // }}}
            
            NSArray *imgs = EncodeArrayFromDic(_detail,@"images");
            if (nil != imgs) {
                CGSize sz = _imgsScrollView.frame.size;
                _imgsScrollView.contentSize = CGSizeMake(imgs.count*sz.width,sz.height);
                
                self.imgsCount = imgs.count;
                _pageLabel.text = [NSString stringWithFormat:@"1/%d",_imgsCount];
                
                int i = 0;
                for (NSDictionary *one in imgs) {
                    UIImageView *imageView =
                    [[UIImageView alloc] initWithFrame:CGRectMake(i*sz.width,.0f,sz.width,sz.height)];
                    [self.imgsScrollView addSubview:imageView];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:EncodeStringFromDic(one,@"imageUrl")]
                                 placeholderImage:[UIImage imageNamed:@"nby_ac_img_default"]];
                    ++i;
                }
            }
            
            _textView0.text = EncodeStringFromDic(_detail,@"cont");
            
        }else {
            [self presentSheet:error.localizedDescription];
        }
        
        [self removeOverFlowActivityView];
    }
}

- (IBAction)on_operationButtons_clicked:(UIButton *)sender {
    
    if ( 0 == sender.tag ){         // 打赏
        if (nil != _detail) {
            NBYDaShangViewController *ctrler = [[NBYDaShangViewController alloc] init];
            ctrler.stickItem = _detail;
            [self.navigationController pushViewController:ctrler animated:YES];
        }
    }else if ( 1 == sender.tag ) {  // 评论
        if (nil != _detail) {
            NBCommentsListViewController *ctrler = [[NBCommentsListViewController alloc] init];
            ctrler.stickItem = _detail;
            [self.navigationController pushViewController:ctrler animated:YES];
        }
        
    }else if ( 2 == sender.tag ) {  // 跳转到商品详情页面
        
        DataProductBasic *dto = [[DataProductBasic alloc] init];
        dto.productCode  = EncodeStringFromDic(_detail, @"productId");
        dto.shopCode     = EncodeStringFromDic(_detail, @"supplyId");
        
        ProductDetailViewController *ctrler = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
        [self.navigationController pushViewController:ctrler animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGSize sz = scrollView.frame.size;
    int page = (scrollView.contentOffset.x/sz.width);
    
    _pageLabel.text = [NSString stringWithFormat:@"%d/%d",(page+1),_imgsCount];
}

@end

//
//  ProductCuView.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-11-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProductCuView.h"
#import "ProductDetailViewController.h"
#import "ProductUtil.h"
#import "ShopCartV2ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <SSA_IOS/SSAIOSSNDataCollection.h>

//1：即将开始 2：已开始 3：已团完 4：已结束
#define kWillStart @"1"
#define kHaveStart @"2"
#define kNOGood @"3"
#define kHaveEnd @"4"

@implementation ProductCuView
{
    NSArray *_dataSourceArray;
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    for (DataProductBasic *innerDto in self.productDto.allAccessoryProductList)
    {
        [innerDto removeObserver:self forKeyPath:@"isAccessorySelect"];
    }
    
    [_calculagraph removeObserver:self forKeyPath:@"time"];
    [_groupBuyCalculagraph removeObserver:self forKeyPath:@"time"];
    [_bigSaleCalculagraph removeObserver:self forKeyPath:@"time"];
    [_appointmentCalculagraph removeObserver:self forKeyPath:@"time"];
    [_scScodeCalculagraph removeObserver:self forKeyPath:@"time"];
    
//    if (2 == self.type) {
//        [_calculagraph removeObserver:self forKeyPath:@"time"];
//        
//        SERVICE_RELEASE_SAFELY(_panicService);
//    }
//    else if (3 == self.type)
//    {
//        [_groupBuyCalculagraph removeObserver:self forKeyPath:@"time"];
//    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor blackColor];
         self.hidden = YES;
//        self.isClickAddCar = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshCuViewCarNumBtn) name:@"changeCuViewProductDetailCarNum"
                                                   object:nil];
        
//        CATransform3D transformPerspective = CATransform3DIdentity;
//        transformPerspective.m34 = - 1 / 100.0;
//        self.layer.sublayerTransform = transformPerspective;
    }
    return self;
}

- (OHAttributedLabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[OHAttributedLabel alloc] init];
        _tipLabel.frame = CGRectMake(13, 13, 170, 20);
        _tipLabel.font = [UIFont systemFontOfSize:14.0f];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.textAlignment = NSTextAlignmentLeft;

    }
    return _tipLabel;
}

- (OHAttributedLabel *)discountLabel
{
    if (!_discountLabel) {
        _discountLabel = [[OHAttributedLabel alloc] init];
        _discountLabel.frame = CGRectMake(135, 12, 175, 20);
        _discountLabel.font = [UIFont systemFontOfSize:14.0f];
        _discountLabel.backgroundColor = [UIColor clearColor];
        _discountLabel.textAlignment = NSTextAlignmentRight;

    }
    return _discountLabel;
}
-(EGOImageView *)productImg{
    
    if (!_productImg) {
        
        _productImg = [[EGOImageView alloc] initWithFrame:CGRectMake(15, 20, 50, 50)];
        
//        _productImg.layer.borderColor = [UIColor grayColor].CGColor;
//        _productImg.layer.borderWidth = 1.0;
        
        [self.backView addSubview:_productImg];
    }
    
    return _productImg;
}

-(UILabel *)nameLab{
    
    if (!_nameLab) {
        
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, 200, 20)];
        
        _nameLab.backgroundColor = [UIColor clearColor];
        
        _nameLab.textColor = RGBCOLOR(51, 51, 51);
        
        _nameLab.font = [UIFont systemFontOfSize:13];
        
        [self.backView addSubview:_nameLab];
        
    }
    
    return _nameLab;
}

-(UILabel *)priceLab{

    if (!_priceLab) {

        _priceLab = [[UILabel alloc] initWithFrame:CGRectMake(75, 50, 200, 20)];

        _priceLab.backgroundColor = [UIColor clearColor];

        _priceLab.textColor = RGBCOLOR(255, 0, 0);
        
        
        _priceLab.font = [UIFont systemFontOfSize:15];
        
        [self.backView addSubview:_priceLab];
    }

    return _priceLab;
}
//-(UILabel *)sellLab{
//    
//    if (!_sellLab) {
//        
//        _sellLab = [[UILabel alloc] initWithFrame:CGRectMake(75, 14, 150, 20)];
//        
//        _sellLab.backgroundColor = [UIColor grayColor];
//        
//        _sellLab.textColor = RGBCOLOR(51, 51, 51);
//    }
//    
//    return _sellLab;
//}


-(UIButton *)deleteBtn{
    
    if (!_deleteBtn) {
        
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(280, -14, 28, 28)];
        
        [_deleteBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];

        [_deleteBtn setImage:[UIImage imageNamed:@"button_closed_normal.png"] forState:UIControlStateNormal];
        
        [self.backView addSubview:_deleteBtn];
    }
    
    return _deleteBtn;
}

- (UIImageView *)applicationImageView
{
    if (!_applicationImageView) {
        CGRect frame =  [[UIScreen mainScreen] bounds];
        _applicationImageView = [[UIImageView alloc] init];
        _applicationImageView.frame = frame;
        _applicationImageView.userInteractionEnabled = YES;
        [self addSubview:_applicationImageView];
        [self insertSubview:_applicationImageView atIndex:0];
    }
    return _applicationImageView;
}

- (UIView *)backGroundView
{
    if (!_backGroundView) {
        CGRect frame =  [[UIScreen mainScreen] bounds];
        _backGroundView = [[UIView alloc] initWithFrame:frame];
        _backGroundView.backgroundColor = RGBACOLOR(0, 0, 0, 0);//[UIColor blackColor];
//        _backGroundView.alpha = 0.5;
        _backGroundView.userInteractionEnabled = YES;
        [self addSubview:_backGroundView];
        [self insertSubview:_backGroundView atIndex:1];
        
//        [self insertSubview:_backGroundView aboveSubview:self.applicationImageView];
//        [self bringSubviewToFront:_backGroundView];
        UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [_backGroundView addGestureRecognizer:singleRecognizer];
    }
    return _backGroundView;
}

- (void)displayAnimation:(CGImageRef)image
{
    transitionLayer = [[CALayer alloc] init];
    transitionLayer.backgroundColor = [UIColor cellBackViewColor].CGColor;
	transitionLayer.bounds = CGRectMake(15, 20, 50, 50);
	transitionLayer.position = CGPointMake(7.5, 10);
	transitionLayer.contents = (__bridge id)image;
	// Add layer as a sublayer of the UIView's layer
	[self.backView.layer addSublayer:transitionLayer];
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:transitionLayer.position];
    
    /*    //画二元曲线，一般和moveToPoint配合使用
     - (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint
     参数：endPoint:曲线的终点
     controlPoint:画曲线的基准点*/
    
    [movePath addQuadCurveToPoint:CGPointMake(410, [UIScreen mainScreen].bounds.size.height)
                     controlPoint:CGPointMake(0,0)];
    //关键帧
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = movePath.CGPath;
    positionAnimation.removedOnCompletion = YES;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
	scaleAnimation.toValue = [NSNumber numberWithFloat:0.025];
	scaleAnimation.duration = 0.8f;
    scaleAnimation.autoreverses = NO;
    scaleAnimation.repeatCount = 1;
    //防止动画闪烁
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
	scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.duration = 0.8f;
	animationGroup.autoreverses = NO;
	animationGroup.repeatCount = 1;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
	[animationGroup setAnimations:[NSArray arrayWithObjects:positionAnimation,scaleAnimation, nil]];
    
    [transitionLayer addAnimation:animationGroup forKey:nil];
    
    [self performSelector:@selector(cuViewAddCarFinished:) withObject:transitionLayer afterDelay:0.8f];

}

- (void)cuViewAddCarFinished:(id)sender
{    
    [transitionLayer removeFromSuperlayer];
    
    if ([_mydelegate respondsToSelector:@selector(cuViewAddCarFinished:)]) {
        
        [_mydelegate cuViewAddCarFinished:nil];
    }

}

- (ProductTimeView *)timView
{
    if (!_timView) {
        _timView = [[ProductTimeView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    }
    return _timView;
}

-(UIImageView *)buttomView{
    
    
    //DJ_Detail_GroupBtnBack.png
    
    if (!_buttomView) {
        
       
        
        
        
        _buttomView = [[UIImageView alloc] init];
        _buttomView.userInteractionEnabled = YES;
//        _buttomView.image = [UIImage imageNamed:@"DJ_Detail_GroupBtnBack.png"];
        _buttomView.backgroundColor = [UIColor whiteColor];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 170, 32)];
        [btn setTitle:L(@"Product_BuyNow") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(beginEasyBuy) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:@"N_GrayActivity.png"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];

//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateDisabled];

        btn.enabled = NO;
        [_buttomView addSubview:btn];
        
        self.buyNowBtn = btn;
        
        btn = [[UIButton alloc] initWithFrame:CGRectMake(190, 10, 120, 32)];
        [btn setTitle:L(@"Add shopCart") forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateDisabled];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addToCar) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:@"button_orange_normal.png"] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:@"N_GrayActivity.png"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];

        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        btn.enabled = NO;
        [_buttomView addSubview:btn];
        
        self.addCarBtn = btn;
        
        [_buttomView addSubview:self.CarBtn];
        
        [self.backView addSubview:_buttomView];
    }
    
    return _buttomView;
}


- (UIButton*)CarNumBtn
{
    if(!_CarNumBtn)
    {
        
        _CarNumBtn = [[UIButton alloc] initWithFrame:CGRectMake(23, -2, 17, 17)];
        
        [_CarNumBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_CarNumBtn setBackgroundImage:[UIImage streImageNamed:@"productDetail_carNumber.png"] forState:UIControlStateNormal];
        
        [_CarNumBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        [_CarNumBtn addTarget:self action:@selector(GoToCar) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _CarNumBtn;
}

- (UIButton*)CarBtn
{
    if(!_CarBtn)
    {
        
        _CarBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 10, 41.5, 43.5)];
        
        [_CarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_CarBtn addTarget:self action:@selector(GoToCar) forControlEvents:UIControlEventTouchUpInside];
        
        [_CarBtn setImage:[UIImage imageNamed:@"icon_shopCart244_default.png"] forState:UIControlStateNormal];
    }
    
    return _CarBtn;
}

- (void)GoToCar
{
    if (_mydelegate && [_mydelegate respondsToSelector:@selector(goToShopCart)]) {
        [_mydelegate goToShopCart];
    }
//    [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:3];
//    [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:NO];
}

-(void)refreshButtomView:(BOOL)showCarNum{
    
    if (showCarNum) {
        
        NSString *num = [NSString stringWithFormat:@"%i", [ShopCartV2ViewController sharedShopCart].logic.allProductQuantity];
        
        //设置购物车数量显示图片自适应大小
        
        CGRect rect = self.CarNumBtn.frame;
        
        if ([num intValue]>99) {
            num = [NSString stringWithFormat:@"99+"];
            self.CarNumBtn.titleLabel.font = [UIFont systemFontOfSize:10];
            
            rect.size.width = 22;
            
        }
        else
        {
            self.CarNumBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            
            rect.size.width = 17;
            
            
        }
        
        rect.size.height = 17;
        rect.origin.x = 34 - rect.size.width/2;
        rect.origin.y = 2;
        
        self.CarNumBtn.frame = rect;
        
        [self.CarNumBtn setTitle:[NSString stringWithFormat:@"%@",num] forState:UIControlStateNormal];
        
        self.CarBtn.frame = CGRectMake(270, 5, 44, 44);
        
        [self.buttomView addSubview:self.addCarBtn];
        [self.buttomView addSubview:self.buyNowBtn];
        [self.buttomView addSubview:self.CarBtn];
        [self.CarBtn addSubview:self.CarNumBtn];
        
        if (self.type == NormalProduct) {
            
            self.CarBtn.frame = CGRectMake(270, 5, 44, 44);
            
            if (self.addToCarType == 1) {
                self.buyNowBtn.frame = CGRectMake(15, 10, 250, 32);
                [self.buyNowBtn setTitle:L(@"payConfirm") forState:UIControlStateNormal];
                
                self.addCarBtn.hidden = YES;
                self.CarBtn.hidden = NO;
                self.CarNumBtn.hidden = NO;
            }
            else if (self.addToCarType == 2)
            {
                self.addCarBtn.frame = CGRectMake(15, 10, 250, 32);
                [self.addCarBtn setTitle:L(@"Product_AddConfirm") forState:UIControlStateNormal];
                
                self.buyNowBtn.hidden = YES;
                self.CarBtn.hidden = NO;
                self.CarNumBtn.hidden = NO;
            }
            else
            {
                self.buyNowBtn.frame = CGRectMake(10, 10, 127, 32);
                self.addCarBtn.frame = CGRectMake(147, 10, 122, 32);
                
                [self.buyNowBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateNormal];
                [self.addCarBtn setTitle:L(@"Add shopCart") forState:UIControlStateNormal];
                
                self.buyNowBtn.hidden = NO;
                self.addCarBtn.hidden = NO;
                self.CarBtn.hidden = NO;
                self.CarNumBtn.hidden = NO;
            }
        }else if (self.type == BigSaleProduct)
        {
            self.buyNowBtn.frame = CGRectMake(10, 34, 127, 35);
            self.addCarBtn.frame = CGRectMake(147, 34, 122, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
        }
        else if (self.type == ScScodeProduct)
        {
            self.addCarBtn.frame = CGRectMake(15, 34, 255, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
        }
        else if (self.type == AppointmentProduct)
        {
            if (self.isScProduct) {
                if (self.appointmentDto.scScodeStatus == OnBuy) {
                    self.buyNowBtn.frame = CGRectMake(10, 34, 127, 35);
                    self.addCarBtn.frame = CGRectMake(147, 34, 122, 35);
                    self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
                }
                else
                {
                    self.buyNowBtn.frame = CGRectMake(15, 34, 255, 35);
                    self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
                }
            }else
            {
                self.buyNowBtn.frame = CGRectMake(15, 34, 255, 35);
                self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
            }
        }
        else
        {
            self.buyNowBtn.frame = CGRectMake(15, 34, 255, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
        }
        
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
    }
    else{
        
        
        self.CarBtn.frame = CGRectMake(270, 3, 44, 44);
        
        
        if (self.type == NormalProduct) {
            
            self.CarBtn.frame = CGRectMake(270, 3, 44, 44);
            
            if (self.addToCarType == 1) {
                self.buyNowBtn.frame = CGRectMake(15, 10, 250, 32);
                [self.buyNowBtn setTitle:L(@"payConfirm") forState:UIControlStateNormal];
                
                self.addCarBtn.hidden = YES;
            }
            else if (self.addToCarType == 2)
            {
                self.addCarBtn.frame = CGRectMake(15, 10, 250, 32);
                [self.addCarBtn setTitle:L(@"Product_AddConfirm") forState:UIControlStateNormal];
                
                self.buyNowBtn.hidden = YES;
            }
            else
            {
                
                self.buyNowBtn.frame = CGRectMake(10, 10, 127, 32);
                self.addCarBtn.frame = CGRectMake(147, 10, 122, 32);
                
                [self.buyNowBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateNormal];
                [self.addCarBtn setTitle:L(@"Add shopCart") forState:UIControlStateNormal];
                
                self.buyNowBtn.hidden = NO;
                self.addCarBtn.hidden = NO;
                
            }

        }else if (self.type == BigSaleProduct)
        {
            self.buyNowBtn.frame = CGRectMake(10, 34, 127, 35);
            self.addCarBtn.frame = CGRectMake(147, 34, 122, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
        }
        else if (self.type == ScScodeProduct)
        {
            self.addCarBtn.frame = CGRectMake(15, 34, 255, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
        }
        else if (self.type == AppointmentProduct)
        {
            if (self.isScProduct) {
                if (self.appointmentDto.scScodeStatus == OnBuy) {
                    self.buyNowBtn.frame = CGRectMake(10, 34, 127, 35);
                    self.addCarBtn.frame = CGRectMake(147, 34, 122, 35);
                    self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
                }
                else
                {
                    self.buyNowBtn.frame = CGRectMake(15, 34, 255, 35);
                    self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
                }
            }else
            {
                self.buyNowBtn.frame = CGRectMake(15, 34, 255, 35);
                self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
            }
        }
        else
        {
            self.buyNowBtn.frame = CGRectMake(15, 34, 255, 35);
            self.CarBtn.frame = CGRectMake(270, 30, 44, 44);
        }
        
        [self.buttomView addSubview:self.addCarBtn];
        [self.buttomView addSubview:self.buyNowBtn];
        [self.buttomView addSubview:self.CarBtn];
        
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = YES;
    }
}

-(UIImageView *)backView{
    
    if (!_backView) {
        
        
        CGRect frame =  [[UIScreen mainScreen] bounds];
        frame.size.height = frame.size.height - 133;
        frame.origin.y = frame.size.height;
        _backView = [[UIImageView alloc] initWithFrame:frame];
        
//        _backView.image = [[UIImage imageNamed:@"cubackview.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(100, 20, 20, 100)];

        _backView.backgroundColor = [UIColor whiteColor];
        
        _backView.userInteractionEnabled = YES;
        
        [self addSubview:_backView];
    }
    
    return _backView;
}
-(UITableView *)productTable{
    
    if (!_productTable) {
        
        CGRect frame =  [[UIScreen mainScreen] bounds];
//        frame.size.height = frame.size.height - 168 - 75 - 55;
//        frame.origin.y = 168;
        
        _productTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 75, 320, frame.size.height - 138 - 75 - 45) style:UITableViewStylePlain];
        
        _productTable.delegate = self;
        
        _productTable.dataSource = self;
        
   
        _productTable.backgroundView = nil;
    
        _productTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _productTable.backgroundColor = RGBCOLOR(242, 242, 242);
        [self.backView addSubview:_productTable];
    }
    
    return _productTable;
}

- (void)setCalculagraph:(Calculagraph *)calculagraph
{
    if (_calculagraph != calculagraph) {
        [_calculagraph removeObserver:self forKeyPath:@"time"];
        _calculagraph = calculagraph;
        [_calculagraph addObserver:self
                        forKeyPath:@"time"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    }
}

- (void)setGroupBuyCalculagraph:(Calculagraph *)groupBuyCalculagraph
{
    if (_groupBuyCalculagraph != groupBuyCalculagraph) {
        [_groupBuyCalculagraph removeObserver:self forKeyPath:@"time"];
        _groupBuyCalculagraph = groupBuyCalculagraph;
        [_groupBuyCalculagraph addObserver:self
                                forKeyPath:@"time"
                                   options:NSKeyValueObservingOptionNew
                                   context:nil];
    }
}

- (void)setBigSaleCalculagraph:(Calculagraph *)bigSaleCalculagraph
{
    if (_bigSaleCalculagraph != bigSaleCalculagraph) {
        [_bigSaleCalculagraph removeObserver:self forKeyPath:@"time"];
        _bigSaleCalculagraph = bigSaleCalculagraph;
        [_bigSaleCalculagraph addObserver:self
                               forKeyPath:@"time"
                                  options:NSKeyValueObservingOptionNew
                                  context:nil];
    }
}

- (void)setAppointmentCalculagraph:(Calculagraph *)appointmentCalculagraph
{
    if (_appointmentCalculagraph != appointmentCalculagraph) {
        [_appointmentCalculagraph removeObserver:self forKeyPath:@"time"];
        _appointmentCalculagraph = appointmentCalculagraph;
        [_appointmentCalculagraph addObserver:self
                                   forKeyPath:@"time"
                                      options:NSKeyValueObservingOptionNew
                                      context:nil];
    }
}

- (void)setScScodeCalculagraph:(Calculagraph *)scScodeCalculagraph
{
    if (_scScodeCalculagraph != scScodeCalculagraph) {
        [_scScodeCalculagraph removeObserver:self forKeyPath:@"time"];
        _scScodeCalculagraph = scScodeCalculagraph;
        [_scScodeCalculagraph addObserver:self
                                   forKeyPath:@"time"
                                      options:NSKeyValueObservingOptionNew
                                      context:nil];
    }
}

- (NSMutableAttributedString *)attributedStringWithString:(NSString *)string
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:string];
    return title;
}

- (void)setTitleLabelText
{
    UIFont *font = [UIFont boldSystemFontOfSize:14];
    NSMutableAttributedString *tip = [[NSMutableAttributedString alloc] init];
    if (self.productDto.packageType == PackageTypeAccessory)
    {
        NSMutableAttributedString *temp = [self attributedStringWithString:L(@"Product_Fitting")];
        [temp setFont:[UIFont boldSystemFontOfSize:16]];
        [temp setTextColor:[UIColor darkGrayColor]];
        [tip appendAttributedString:temp];
        
        NSString *yixuan = [NSString stringWithFormat:@"%@(%d)%@",L(@"Product_Selected"), [self.productDto selectAccessoryProductCount],L(@"Purchase_Jian")];
        temp = [self attributedStringWithString:yixuan];
        [temp setFont:font];
        [temp setTextColor:[UIColor lightGrayColor]];
        [tip appendAttributedString:temp];
        
    }
    else if (self.productDto.packageType == PackageTypeSmall)
    {
        NSMutableAttributedString *temp = [self attributedStringWithString:L(@"Product_Taocan")];
        [temp setFont:font];
        [temp setTextColor:[UIColor darkGrayColor]];
        [tip appendAttributedString:temp];
        
        NSString *oldPrice = [NSString stringWithFormat:@"%@￥%.2f",L(@"DJGroup_SaveMoney"),[self.productDto.savePrice doubleValue]];
        temp = [self attributedStringWithString:oldPrice];
        [temp setFont:font];
        [temp setTextColor:[UIColor lightGrayColor]];
        [tip appendAttributedString:temp];
    }
    
    self.tipLabel.attributedText = tip;
    
    NSMutableAttributedString *discount = [[NSMutableAttributedString alloc] init];
    if (self.productDto.packageType == PackageTypeAccessory)
    {
        NSMutableAttributedString *temp = [self attributedStringWithString:L(@"Product_TaocanDiscount")];
        [temp setFont:font];
        [temp setTextColor:[UIColor darkGrayColor]];
        [discount appendAttributedString:temp];
        
        NSString *yixuan = [NSString stringWithFormat:@"￥%.2f", [self.productDto totalPrice]];
        temp = [self attributedStringWithString:yixuan];
        [temp setFont:[UIFont boldSystemFontOfSize:17]];
        [temp setTextColor:[UIColor orange_Light_Color]];
        [discount appendAttributedString:temp];
        
    }
    else if (self.productDto.packageType == PackageTypeSmall)
    {
        NSMutableAttributedString *temp = [self attributedStringWithString:L(@"Product_TaocanPrice")];
        [temp setFont:font];
        [temp setTextColor:[UIColor darkGrayColor]];
        [discount appendAttributedString:temp];
        
        NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",
                              [self.productDto.smallPackagePrice doubleValue]];
        temp = [self attributedStringWithString:oldPrice];
        [temp setFont:[UIFont boldSystemFontOfSize:17]];
        [temp setTextColor:[UIColor orange_Light_Color]];
        [discount appendAttributedString:temp];
    }
    [discount setTextAlignment:kCTTextAlignmentRight lineBreakMode:kCTLineBreakByTruncatingHead];
    
    self.discountLabel.attributedText = discount;
}

#pragma mark ----------------------------- tableview reload

- (void)reloadTableView
{
    [self prepareTableViewDatasource];
    [self refreshBtn];
    [self.productTable reloadData];
}

- (void)prepareTableViewDatasource
{
    NSMutableArray *array = [NSMutableArray array];
    
    //商品簇颜色行
    if ([self.productDto.colorItemList count] > 0)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //商品簇颜色行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"ProductColor_Cell",
                                      kTableViewCellHeightKey : @([SelectItemCell cellHeight:self.productDto type:ColorCell])};
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [array addObject:dic];
    }
    
    //商品簇尺码行
    if ([self.productDto.versionItemList count] > 0)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //商品簇尺码行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"ProductVersion_Cell",
                                      kTableViewCellHeightKey : @([SelectItemCell cellHeight:self.productDto type:SizeCell])
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [array addObject:dic];
    }
    
    //商品簇数量行
    if (self.type == NormalProduct || self.type == GroupProduct || self.type == BigSaleProduct || self.type == AppointmentProduct) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //商品簇数量行
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"ProductNum_Cell",
                                      kTableViewCellHeightKey : @60.0f
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [array addObject:dic];
    }

    //配件商品行
    if (self.type == NormalProduct)
    {
        if ([self.productDto hasPackageList])
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            //添加数据
            NSMutableArray *cellList = [NSMutableArray array];
            //配件商品价格行
            {
                NSDictionary *cellDic = @{
                                          kTableViewCellTypeKey: @"ProductPackagePrice_Cell",
                                          kTableViewCellHeightKey : @35.0f
                                          };
                [cellList addObject:cellDic];
            }
            //配件商品行
            if (self.productDto.packageType == PackageTypeAccessory)
            {
                for (DataProductBasic *dto in self.productDto.allAccessoryProductList) {
                    NSDictionary *cellDic = @{
                                              kTableViewCellTypeKey: @"Item_Cell",
                                              kTableViewCellDataKey: dto,
                                              kTableViewCellHeightKey : @77.0f
                                              };
                    [cellList addObject:cellDic];
                }
            }
            else if (self.productDto.packageType == PackageTypeSmall)
            {
                for (DataProductBasic *dto in self.productDto.smallPackageList) {
                    NSDictionary *cellDic = @{
                                              kTableViewCellTypeKey: @"Item_Cell",
                                              kTableViewCellDataKey: dto,
                                              kTableViewCellHeightKey : @77.0f
                                              };
                    [cellList addObject:cellDic];
                }
            }
            
            [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
            [dic setObject:cellList forKey:kTableViewCellListKey];
            
            [array addObject:dic];
        }
    }
    
    _dataSourceArray = array;
}


#pragma mark -
#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataSourceArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewNumberOfRowsKey] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    return [[cellDic objectForKey:kTableViewCellHeightKey] floatValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewSectionHeaderHeightKey] floatValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewSectionFooterHeightKey] floatValue];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    
    NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
    id item = [cellDic objectForKey:kTableViewCellDataKey];
    
    if ([cellType isEqualToString:@"ProductColor_Cell"])    //商品颜色选择
    {
        SelectItemCell *cell = (SelectItemCell *)[tableView dequeueReusableCellWithIdentifier:cellType];
        
        if (nil == cell)
        {
            cell = [[SelectItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.myDelegate = self;
        }
        [cell.contentView removeAllSubviews];
        [cell initViewWithSourse:self.productDto type:ColorCell];
        
        return cell;
    }
    else if ([cellType isEqualToString:@"ProductVersion_Cell"])     //商品尺码选择
    {
        SelectItemCell *cell = (SelectItemCell *)[tableView dequeueReusableCellWithIdentifier:cellType];
        
        if (nil == cell)
        {
            cell = [[SelectItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.myDelegate = self;
        }
        [cell.contentView removeAllSubviews];
        [cell initViewWithSourse:self.productDto type:SizeCell];
        
        return cell;
    }
    else if ([cellType isEqualToString:@"ProductNum_Cell"])     //商品数量选择
    {
        ProductNumberCell *cell = (ProductNumberCell *)[tableView dequeueReusableCellWithIdentifier:cellType];
        
        if (nil == cell)
        {
            cell = [[ProductNumberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        self.numberTF = cell.numberTF;
        cell.numberTF.text = [NSString stringWithFormat:@"%d",self.productDto.quantity];
        if (self.productDto.quantity == 1) {
            cell.btnDelete.enabled = NO;
            cell.btnAdd.enabled = YES;
        } else if (self.productDto.quantity == 99)
        {
            cell.btnAdd.enabled = NO;
            cell.btnDelete.enabled = YES;
        }
        else
        {
            cell.btnDelete.enabled = YES;
            cell.btnAdd.enabled = YES;
        }
        cell.mydelegate = self;
        [cell setProductInfo:self.productDto];
        return cell;
    }
    else if ([cellType isEqualToString:@"ProductPackagePrice_Cell"])     //配件商品价格
    {
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellType];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.contentView removeAllSubviews];
        [cell.contentView addSubview:self.tipLabel];
        [cell.contentView addSubview:self.discountLabel];
        [self setTitleLabelText];
        
        cell.contentView.backgroundColor = RGBCOLOR(239, 239, 239);
        
        UIImageView *img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:@"line.png"];
        img.frame = CGRectMake(0, 0, 320, 1);
        [cell.contentView addSubview:img];
        
        return cell;
    }
    else if ([cellType isEqualToString:@"Item_Cell"])     //配件商品
    {
        PackageProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[PackageProductCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 77)];
            cell.myDelegate = self;
        }
        [cell setItem:item];
        
        return cell;
    }
//    if (0 == indexPath.section) {
//        
//        static NSString *colorCell = @"colorCell";
//        
//        SelectItemCell *cell = (SelectItemCell *)[tableView dequeueReusableCellWithIdentifier:colorCell];
//        
//        if (nil == cell)
//        {
//            cell = [[SelectItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:colorCell];
//            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
//            
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.myDelegate = self;
//        }
//        
//        [cell initViewWithSourse:self.productDto type:ColorCell];
//        
//        return cell;
//    }
//    
//    if (1 == indexPath.section) {
//        
//        static NSString *sizeCell = @"sizeCell";
//        
//        SelectItemCell *cell = (SelectItemCell *)[tableView dequeueReusableCellWithIdentifier:sizeCell];
//        
//        if (nil == cell)
//        {
//            cell = [[SelectItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sizeCell];
//            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.myDelegate = self;
//        }
//        
//        [cell initViewWithSourse:self.productDto type:SizeCell];
//        
//        return cell;
//    }
//    if (2 == indexPath.section) {
//        
//        static NSString *sizeCell = @"ProductNumberCell";
//        
//        ProductNumberCell *cell = (ProductNumberCell *)[tableView dequeueReusableCellWithIdentifier:sizeCell];
//        
//        if (nil == cell)
//        {
//            cell = [[ProductNumberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sizeCell];
//            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        }
//        self.numberTF = cell.numberTF;
//        cell.numberTF.text = [NSString stringWithFormat:@"%d",self.productDto.quantity];
//        if ([cell.numberTF.text integerValue] == 1) {
//            cell.btnDelete.enabled = NO;
//        } else if ([cell.numberTF.text integerValue] == 99)
//        {
//            cell.btnAdd.enabled = NO;
//        }
//        cell.mydelegate = self;
//        
//        return cell;
//    }
//    //套餐商品栏
//    if (3 == indexPath.section && [self.productDto hasPackageList])
//    {
//        if (indexPath.row == 0) {
//            
//            static NSString *headcell = @"headcell";
//            
//            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:headcell];
//            
//            if(cell == nil){
//                
//                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headcell];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                
//            }
//
//            [cell.contentView removeAllSubviews];
//
//            [cell.contentView addSubview:self.tipLabel];
//
//            [cell.contentView addSubview:self.discountLabel];
//            
//            [self setTitleLabelText];
//            
//            cell.contentView.backgroundColor = RGBCOLOR(239, 239, 239);
//
//            UIImageView *img = [[UIImageView alloc] init];
//
//            img.image = [UIImage imageNamed:@"line.png"];
//
//            img.frame = CGRectMake(0, 0, 320, 1);
//            
//            [cell.contentView addSubview:img];
//            
//            return cell;
//        }
//        static NSString *cellIdentifier = @"productClusterCell";
//        
//        PackageProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        if (cell == nil) {
//            cell = [[PackageProductCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                             reuseIdentifier:cellIdentifier];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            
//            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 77)];
//        }
//        
//        if (self.productDto.packageType == PackageTypeAccessory)
//        {
//
//            DataProductBasic *dto = [self.productDto.allAccessoryProductList objectAtIndex:indexPath.row-1];
//            [cell setItem:dto];
//
//        }
//        else if (self.productDto.packageType == PackageTypeSmall)
//        {
//            DataProductBasic *dto = [self.productDto.smallPackageList objectAtIndex:indexPath.row-1];
//            [cell setItem:dto];
//        }
//        
//        
//        return cell;
//    }
    
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    
    NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
    id item = [cellDic objectForKey:kTableViewCellDataKey];
    
    if ([cellType isEqualToString:@"Item_Cell"])     //配件商品
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121603"], nil]];
        DataProductBasic *dto = (DataProductBasic *)item;
        dto.cityCode = [Config currentConfig].defaultCity;
        dto.shopCode = self.productDto.shopCode;

        ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
        [((UIViewController *)_mydelegate).navigationController pushViewController:vc animated:YES];
    }
//    if (indexPath.section != 3) {
//        return;
//    }
//    else if(indexPath.row > 0)
//    {
//        DataProductBasic *dto = nil;
//        if (self.productDto.packageType == PackageTypeAccessory)
//        {
//            
//            dto = [self.productDto.allAccessoryProductList objectAtIndex:indexPath.row-1];
//            
//        }
//        else if (self.productDto.packageType == PackageTypeSmall)
//        {
//            dto = [self.productDto.smallPackageList objectAtIndex:indexPath.row-1];
//        }
//        
//        dto.cityCode = [Config currentConfig].defaultCity;
//        ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
//        
//        dto.shopCode = self.productDto.shopCode;
//        
//        
//        [((UIViewController *)_mydelegate).navigationController pushViewController:vc animated:YES];
//    }

}

#pragma mark -
#pragma mark ------------  ------------

-(void)refreshBtn
{
    if(self.type == NormalProduct || self.type == BigSaleProduct){
        self.addCarBtn.hidden = NO;
        self.buyNowBtn.hidden = NO;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        if (self.type == NormalProduct) {
            if ([self isProductEnabled]) {
                self.addCarBtn.enabled = YES;
                self.buyNowBtn.enabled = YES;
            }
            else{
                self.addCarBtn.enabled = NO;
                self.buyNowBtn.enabled = NO;
            }
        }
        else if (self.type == BigSaleProduct)
        {
            if ([self isBigsaleProductEnabled]) {
                self.addCarBtn.enabled = YES;
                self.buyNowBtn.enabled = YES;
            }
            else{
                self.addCarBtn.enabled = NO;
                self.buyNowBtn.enabled = NO;
            }
        }

        if (self.buyNowBtn.enabled) {
            [self.buyNowBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateNormal];
        }else {
            [self.buyNowBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateDisabled];
        }
        
        //是否展示购物车数量按钮
        if([ShopCartV2ViewController sharedShopCart].logic.allProductQuantity > 0)
        {
            [self refreshButtomView:YES];
            
        }
        else
        {
            [self refreshButtomView:NO];
            
        }
        
        
    }
    else if(self.type == PurchuseProduct)
    {
        self.addCarBtn.hidden = YES;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        
        [self.buyNowBtn setTitle:@"" forState:UIControlStateNormal];
        
        [self.buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
        [self.buttomView addSubview:self.buyNowBtn];
        
        if (self.panicDTO.purchaseState == ReadyForSale) {
            
            self.stateStr = L(@"readyForSaleState");
            self.buyNowBtn.enabled = NO;
            
        }
        else if (self.panicDTO.purchaseState == SaleOut){
            
            self.stateStr = L(@"SK without ant piece");
            self.buyNowBtn.enabled = NO;
        }
        else if(self.panicDTO.purchaseState == OnSale){
            
            
            if (self.panicDTO.leftQty && 0 == [self.panicDTO.leftQty intValue]) {
                
                self.stateStr = L(@"SK without ant piece");
                self.buyNowBtn.enabled = NO;
            }
            //        else if(self.panicDTO.isSale && [self.panicDTO.isSale isEqualToString:@"0"]){
            //
            //            self.stateStr = @"我要抢";
            //            self.buyNowBtn.enabled = NO;
            //        }
            else{
                
                self.stateStr = L(@"Add QuickBuy");
                self.buyNowBtn.enabled = YES;
            }
        }
        else{
            
            self.stateStr = L(@"Product_Over");
            self.buyNowBtn.enabled = NO;
        }
        
        
        if ([self isPurchaseProductEnabled] == NO)
        {
            self.buyNowBtn.enabled = NO;
            
            return;
        }
        
    }
    else if (GroupProduct == self.type)
    {
        self.addCarBtn.hidden = YES;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        self.buyNowBtn.hidden = NO;
        
        [self.buyNowBtn setTitle:@"" forState:UIControlStateNormal];
        
        [self.buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
        [self.buttomView addSubview:self.buyNowBtn];
        
        if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
            
            self.stateStr = L(@"Product_LeftToBegin");
            self.buyNowBtn.enabled = NO;
            
        } else if ([self.detailDto.startFlag isEqualToString:kHaveStart]) {
            
            self.stateStr = L(@"Add GroupBuy");
            
            self.buyNowBtn.enabled = YES;
            
        }
        else if ([self.detailDto.startFlag isEqualToString:kNOGood]) {
            
            self.stateStr = L(@"Group buy is over");
            self.timeStr = nil;
            self.buyNowBtn.enabled = NO;
        }
        
        if ([self isProductEnabled] == NO)
        {
            self.buyNowBtn.enabled = NO;
            
            
        }
    }
    else if (AppointmentProduct == self.type)
    {
        self.addCarBtn.hidden = YES;
        //该商品是S码商品且在购买阶段中，展示通道入口
        if (self.isScProduct == YES && self.appointmentDto.scScodeStatus == OnBuy) {
            self.addCarBtn.hidden = NO;
            self.addCarBtn.enabled = [self isProductEnabled];
        }
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        self.buyNowBtn.hidden = NO;
        [self.buyNowBtn setTitle:@"" forState:UIControlStateNormal];
        
        [self.buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.addCarBtn setTitle:L(@"Product_BuySCode") forState:UIControlStateNormal];
        [self.addCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        
        [self.buyNowBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
        [self.buttomView addSubview:self.buyNowBtn];
        
        if (self.appointmentDto.status == ReadyForAppointment) {
            
            self.stateStr = L(@"Product_WaitForPreOrder");
            [self.buyNowBtn setTitle:L(@"Product_WaitForPreOrder") forState:UIControlStateDisabled];
            self.buyNowBtn.enabled = NO;
            
        }
        else if (self.appointmentDto.status == OnAppointment){
            
            self.stateStr = L(@"Product_PreOrderNow");
            [self.buyNowBtn setTitle:L(@"Product_PreOrderNow") forState:UIControlStateNormal];
            self.buyNowBtn.enabled = YES;
        }
        else if(self.appointmentDto.status == ReadyForPurchase || self.appointmentDto.status == WaitPurchase){
            self.stateStr = L(@"Product_WaitForPurchase");
            [self.buyNowBtn setTitle:L(@"Product_WaitForPurchase") forState:UIControlStateDisabled];
            self.buyNowBtn.enabled = NO;
            
        }
        else if(self.appointmentDto.status == OnPurchase)
        {
            self.stateStr = L(@"Product_PurchaseNow");
            [self.buyNowBtn setTitle:L(@"Product_PurchaseNow") forState:UIControlStateNormal];
            self.buyNowBtn.enabled = YES;
        }
        else{
            
            self.stateStr = L(@"SK without ant piece");
            [self.buyNowBtn setTitle:L(@"SK without ant piece") forState:UIControlStateDisabled];
            self.buyNowBtn.enabled = NO;
        }
        
        if ([self isAppointmentProductEnabled] == NO)
        {
            self.buyNowBtn.enabled = NO;
            
            return;
        }
    }
    else if(self.type == ScScodeProduct)
    {
        self.addCarBtn.hidden = NO;
        self.buyNowBtn.hidden = YES;
        self.CarBtn.hidden = NO;
        self.CarNumBtn.hidden = NO;
        [self.addCarBtn setTitle:@"" forState:UIControlStateNormal];
        
        [self.addCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.addCarBtn setBackgroundImage:[UIImage imageNamed:@"submit_button_normal.png"] forState:UIControlStateNormal];
        
        [self.addCarBtn setBackgroundImage:[UIImage imageNamed:@"button_white_disable.png"] forState:UIControlStateDisabled];
        
        [self.buttomView addSubview:self.addCarBtn];
        
        [self.addCarBtn setTitle:L(@"Product_BuySCode") forState:UIControlStateNormal];
        
        if (self.appointmentDto.scScodeStatus == BuyOver) {
            [self.addCarBtn setTitle:L(@"Product_BuySCode") forState:UIControlStateDisabled];
            self.addCarBtn.enabled = NO;
        }
        if ([self isProductEnabled] == NO) {
            self.addCarBtn.enabled = NO;
        }
    }
}


//是否能抢购
- (BOOL)isPurchaseProductEnabled
{
    if(self.panicDTO.purchaseState ==  SaleOut
       || self.panicDTO.purchaseState == TimeOver)
    {
        return NO;
    }
    else
    {
        if (self.productDto.isCShop)
        {
            if (self.productDto.suningPrice.doubleValue > 0)
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
        {
            if ([self.productDto.hasStorage isEqualToString:@"Y"] &&
                ![self.productDto.cityCode isEqualToString:@""] &&
                [self.productDto.suningPrice doubleValue] > 0 &&
                self.productDto.isPublished)
            {
                BOOL isEnabled;
                
                if (self.panicDTO.purchaseState == SaleOut) {
                    isEnabled = NO;
                }else{
                    isEnabled = YES;
                }
                return isEnabled;
                
            }
            else
            {
                return NO;
            }
        }
        
    }
}

- (BOOL)isAppointmentProductEnabled
{
    if (self.appointmentDto.status == ReadyForAppointment
        || self.appointmentDto.status == ReadyForPurchase
        || self.appointmentDto.status == PurchaseTimeOver) {
        return NO;
    }
    else
    {
        if (self.appointmentDto.status == OnAppointment) {
            return YES;
        }
        else
        {
            return [self isProductEnabled];
        }
    }
}

- (BOOL)isBigsaleProductEnabled
{
    if (self.bigsaleDto.bigSaleState == BsReadyForSale
        || self.bigsaleDto.bigSaleState == BsTimeOver
        || self.bigsaleDto.bigSaleState == BsSaleOut)
    {
        return NO;
    }
    else
    {
        return [self isProductEnabled];
    }
}

//商品是否可买
- (BOOL)isProductEnabled
{
    /*
     * liukun modify  12-12-06  如果商品价格小于等于0，默认也是不可买的
     */
    if (self.productDto.isCShop)
    {
        if ([self.productDto.hasStorage isEqualToString:@"Z"]) {
            return NO;
        }
        else
        {
            if (self.productDto.suningPrice.doubleValue > 0)
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
    else
    {
        if ([self.productDto.hasStorage isEqualToString:@"Y"] &&
            ![self.productDto.cityCode isEqualToString:@""] &&
            [self.productDto.suningPrice doubleValue] > 0 &&
            self.productDto.isPublished)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"time"]) {
        if (PurchuseProduct == self.type) {
            double seconds = [[change objectForKey:@"new"] floatValue];
            double leavingTime = 0;
            switch (self.panicDTO.purchaseState) {
                case ReadyForSale:
                {
                    leavingTime = (double)self.panicDTO.startTimeSeconds - seconds;
                    [self setTime:leavingTime];
                    break;
                }
                case OnSale:
                {
                    leavingTime = (double)self.panicDTO.endTimeSeconds - seconds;
                    [self setTime:leavingTime];
                    break;
                }
                case SaleOut:
                {
                    leavingTime = (double)self.panicDTO.endTimeSeconds - seconds;
                    [self setTime:leavingTime];
                    break;
                }
                case TimeOver:
                {
                    break;
                }
                default:
                    break;
            }
        }
        else if (GroupProduct == self.type)
        {
            if ([self.detailDto.startFlag isEqualToString:kNOGood] || [self.detailDto.startFlag isEqualToString:kHaveEnd]) {
                [self setTimer:0];
                return;
            }
            
            NSTimeInterval leavingTime = 0;
            
            if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
                leavingTime = self.detailDto.startTimeSeconds - self.groupBuyCalculagraph.seconds;
                [self setTimer:leavingTime];
                
            } else if ([self.detailDto.startFlag isEqualToString:kHaveStart]){
                leavingTime = self.detailDto.endTimeSeconds - self.groupBuyCalculagraph.seconds;
                [self setTimer:leavingTime];
                
            }else if ([self.detailDto.startFlag isEqualToString:kNOGood]){
                leavingTime = self.detailDto.endTimeSeconds - self.groupBuyCalculagraph.seconds;
                [self setTimer:leavingTime];
                
            } else {
                [self setTimer:0];
                
                [self setTimer:leavingTime];
                
                return;
            }
            
            if (leavingTime < 1) {
                if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
                    self.detailDto.startFlag = kHaveStart;
                }else if ([self.detailDto.startFlag isEqualToString:kHaveStart]){
                    self.detailDto.startFlag = kHaveEnd;
                }
                
                [self setTimer:leavingTime];
                
                return;
            }
            
            [self setTimer:leavingTime];
        }
        else if (BigSaleProduct == self.type)
        {
            double seconds = [[change objectForKey:@"new"] floatValue];
            double leavingTime = 0;
            switch (self.bigsaleDto.bigSaleState) {
                case BsReadyForSale:
                {
                    leavingTime = (double)self.bigsaleDto.startTimeSeconds - seconds;
                    [self setBigSaleTime:leavingTime];
                    break;
                }
                case BsOnSale:
                {
                    leavingTime = (double)self.bigsaleDto.endTimeSeconds - seconds;
                    [self setBigSaleTime:leavingTime];
                    break;
                }
                case BsSaleOut:
                {
                    leavingTime = (double)self.bigsaleDto.endTimeSeconds - seconds;
                    [self setBigSaleTime:leavingTime];
                    break;
                }
                case BsTimeOver:
                {
                    [self setBigSaleTime:0];
                    break;
                }
                default:
                    break;
            }
            
            
        }
        else if (AppointmentProduct == self.type)
        {
            double seconds = [[change objectForKey:@"new"] floatValue];
            double leavingTime = 0;
            switch (self.appointmentDto.status) {
                case ReadyForAppointment:
                {
                    leavingTime = (double)self.appointmentDto.scheduleStartTimeSeconds - seconds;
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case OnAppointment:
                {
                    leavingTime = (double)self.appointmentDto.scheduleEndTimeSeconds - seconds;
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case ReadyForPurchase:
                {
                    leavingTime = (double)self.appointmentDto.startTimeSeconds - seconds;
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case OnPurchase:
                {
                    leavingTime = (double)self.appointmentDto.endTimeSeconds - seconds;
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case PurchaseTimeOver:
                {
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                case WaitPurchase:
                {
                    [self setAppointmentTime:leavingTime];
                    break;
                }
                default:
                    break;
            }

        
    }
        else if (ScScodeProduct == self.type)
        {
            double seconds = [[change objectForKey:@"new"] floatValue];
            double leavingTime = 0;
            leavingTime = (double)self.appointmentDto.scEndTimeSeconds - seconds;
            [self setScScodeTime:leavingTime];
        }
    }
    else if ([keyPath isEqualToString:@"purchaseState"])
    {
        [self refreshBtn];
        
    }
}

-(void)setStateStr:(NSString *)stateStr{
    
    _stateStr = stateStr;
    
    if (self.buyNowBtn.enabled) {
        [self.buyNowBtn setTitle:[NSString stringWithFormat:@"    %@    %@",_stateStr,_timeStr?_timeStr:@""] forState:UIControlStateNormal];
    }else {
        [self.buyNowBtn setTitle:[NSString stringWithFormat:@"    %@    %@",_stateStr,_timeStr?_timeStr:@""] forState:UIControlStateDisabled];
    }
}

-(void)setTimeStr:(NSString *)timeStr{
    
    _timeStr = timeStr;
    
    if (self.buyNowBtn.enabled) {
        [self.buyNowBtn setTitle:[NSString stringWithFormat:@"    %@    %@",_stateStr,_timeStr?_timeStr:@""] forState:UIControlStateNormal];
    }else {
        [self.buyNowBtn setTitle:[NSString stringWithFormat:@"    %@    %@",_stateStr,_timeStr?_timeStr:@""] forState:UIControlStateDisabled];
    }
    
}

//预约计算时间
- (void)setAppointmentTime:(double)seconds
{
    if (self.appointmentDto.status == PurchaseTimeOver) {
        [self.timView calculagraphTime:0];
        [self.timView hiddenTimeLabel:L(@"Panic_Purchase_Finished")];
        return;
    }
    
    if (self.appointmentDto.status == WaitPurchase) {
        [self.timView calculagraphTime:0];
        [self.timView hiddenTimeLabel:L(@"Product_PurchaseTimeNotDecided")];
        return;
    }
    if (seconds < 1 ) {
        if (self.appointmentDto.status == ReadyForAppointment) {
            self.appointmentDto.status = OnAppointment;
            [self.timView setState:2];
            [self refreshBtn];
            return;
        }
        else if (self.appointmentDto.status == ReadyForPurchase)
        {
            self.appointmentDto.status = OnPurchase;
            [self.timView setState:4];
            [self refreshBtn];
        }
        else if (self.appointmentDto.status == OnAppointment){
            
            if (IsStrEmpty(self.appointmentDto.purchaseStarttime) || IsStrEmpty(self.appointmentDto.purchaseEndtime)) {
                self.appointmentDto.status = WaitPurchase;
                [self.timView hiddenTimeLabel:L(@"Product_PurchaseTimeNotDecided")];
                return;
            }
            self.appointmentDto.status = ReadyForPurchase;
            [self.timView setState:3];
            [self refreshBtn];
            return;
        }
        else if (self.appointmentDto.status == OnPurchase)
        {
            self.appointmentDto.status = PurchaseTimeOver;
            [self.timView hiddenTimeLabel:L(@"Panic_Purchase_Finished")];
            [self refreshBtn];
            return;
        }
    }
    
    if (self.appointmentDto.status == ReadyForAppointment) {
        [self.timView calculagraphTime:seconds];
        [self.timView setState:1];
    }
    else if (self.appointmentDto.status == OnAppointment)
    {
        [self.timView calculagraphTime:seconds];
        [self.timView setState:2];
    }
    else
    {
        if(self.appointmentDto.status == ReadyForPurchase || self.appointmentDto.status == OnPurchase)
        {
            if (self.appointmentDto.status == ReadyForPurchase) {
                [self.timView setState:3];
            }else if (self.appointmentDto.status == OnPurchase)
            {
                [self.timView setState:4];
            }
            
            if (self.productDto.isCShop) {
                [self.timView calculagraphTime:seconds];
            }
            else
            {
                if (self.productDto.isPublished && [[self.productDto hasStorage] isEqualToString:@"Y"]) {
                    [self.timView calculagraphTime:seconds];
                }
                else
                {
                    [self.timView calculagraphTime:0];
                    return;
                }
            }
            
        }
    }
    
}

//s码商品计算时间
- (void)setScScodeTime:(double)seconds
{
    if (seconds < 1) {
        if (self.appointmentDto.scScodeStatus == OnBuy || self.appointmentDto.scScodeStatus == BuyOver){
            self.appointmentDto.scScodeStatus = BuyOver;
            [self refreshBtn];
        }
    }
    
    if (self.appointmentDto.scScodeStatus == OnBuy) {
        if (self.productDto.isCShop) {
            [self.timView calculagraphTime:seconds];
        }
        else
        {
            if (self.productDto.isPublished && [[self.productDto hasStorage] isEqualToString:@"Y"]) {
                [self.timView calculagraphTime:seconds];
            }
            else
            {
                [self.timView calculagraphTime:0];
            }
        }
    }else
    {
        [self.timView calculagraphTime:0];
    }
}

//大聚惠计算时间
- (void)setBigSaleTime:(double)seconds
{
    if (self.bigsaleDto.bigSaleState == BsTimeOver) {
        [self.timView calculagraphTime:0];
        return;
    }
    
    if (seconds < 1 ) {
        if (self.bigsaleDto.bigSaleState == BsReadyForSale) {
            self.bigsaleDto.bigSaleState = BsOnSale;
            [self refreshBtn];
        }
        else if (self.bigsaleDto.bigSaleState == BsOnSale|| self.bigsaleDto.bigSaleState == BsSaleOut){
            self.bigsaleDto.bigSaleState = BsTimeOver;
            [self refreshBtn];
        }
    }
    
    if(self.bigsaleDto.bigSaleState == BsOnSale|| self.bigsaleDto.bigSaleState == BsSaleOut
       || self.bigsaleDto.bigSaleState == BsReadyForSale)
    {
        if (self.productDto.isCShop) {
            [self.timView calculagraphTime:seconds];
        }
        else
        {
            if (self.productDto.isPublished && [[self.productDto hasStorage] isEqualToString:@"Y"]) {
                [self.timView calculagraphTime:seconds];
            }
            else
            {
                [self.timView calculagraphTime:0];
                return;
            }
        }
    }else{
        [self.timView calculagraphTime:0];
    }
}


//抢购计算时间
- (void)setTime:(double)seconds
{
    if (self.panicDTO.purchaseState == TimeOver) {
        
        return;
    }
    
    if (seconds < 1 && self.isLoadPurchase) {
        if (self.panicDTO.purchaseState == ReadyForSale) {
            self.panicDTO.purchaseState = OnSale;
            
            [self refreshBtn];
            
        }
        else if (self.panicDTO.purchaseState == OnSale|| self.panicDTO.purchaseState == SaleOut){
            
            self.panicDTO.purchaseState = TimeOver;
            
            self.stateStr = L(@"Product_Over");
            self.buyNowBtn.enabled = NO;
            
        }
    }
    
    NSString *timeString = nil;
    
    if(self.panicDTO.purchaseState == OnSale|| self.panicDTO.purchaseState == SaleOut
       || self.panicDTO.purchaseState == ReadyForSale)
    {
        if (self.productDto.isCShop) {
            [self.timView calculagraphTime:seconds];
        }
        else
        {
            if (self.productDto.isPublished && [[self.productDto hasStorage] isEqualToString:@"Y"]) {
                [self.timView calculagraphTime:seconds];
            }
            else
            {
                [self.timView calculagraphTime:0];
            }
        }

    }else{
        [self.timView calculagraphTime:0];        
    }
    self.timeStr = timeString;
    
}

//团购计算时间
- (void)setTimer:(NSTimeInterval)seconds
{
    if ([self.detailDto.startFlag isEqualToString:@"3"] || [self.detailDto.startFlag isEqualToString:@"4"] || (seconds == 0)){
        if (self.buyNowBtn.enabled) {
            [self.buyNowBtn setTitle:L(@"Group buy is over") forState:UIControlStateNormal];
        }else {
            [self.buyNowBtn setTitle:L(@"Group buy is over") forState:UIControlStateDisabled];
        }
        self.buyNowBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.buyNowBtn.enabled = NO;
        [self.timView calculagraphTime:seconds];
        return;
    }
    
    if ([self.detailDto.startFlag isEqualToString:kWillStart]) {
        self.stateStr = L(@"Ready to start");
        self.buyNowBtn.enabled = NO;
        [self.timView calculagraphTime:seconds];
        
    } else if ([self.detailDto.startFlag isEqualToString:kHaveStart]) {
        self.stateStr = L(@"Add GroupBuy");
        [self.timView calculagraphTime:seconds];
        self.buyNowBtn.enabled = YES;
        if ([self isProductEnabled] == NO)
        {
            self.buyNowBtn.enabled = NO;
        }
    }
    else if ([self.detailDto.startFlag isEqualToString:kNOGood]) {
        
        self.stateStr = L(@"Group buy is over");
        [self.timView calculagraphTime:0];
        self.buyNowBtn.enabled = NO;
    }
}


#pragma mark -
#pragma mark package view delegate

- (void)reloadSuperTableView
{
    [self reloadTableView];
}

- (void)packageView:(ProductPackageView *)view didSelectProduct:(DataProductBasic *)product
{
    
    product.cityCode = [Config currentConfig].defaultCity;
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithDataBasicDTO:product];
    
    [((UIViewController *)_mydelegate).navigationController pushViewController:vc animated:YES];
}

-(void)selectPocket{
    
//    if (self.productDto.packageType == PackageTypeAccessory)
//    {
//        
//        NSString *yixuan = [NSString stringWithFormat:@"￥%.2f", [self.productDto totalPrice]];
//        self.priceLab.text = yixuan;
//        
//    }
//    else if (self.productDto.packageType == PackageTypeSmall)
//    {
//        
//        NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",
//                              [self.productDto.smallPackagePrice doubleValue]];
//        self.priceLab.text = oldPrice;
//    }
}
//第一次设置颜色id  版本id
-(void)initColorAndVersion{
    
    for (int i = 0; i<[self.productDto.colorVersionMap count]; i++)
    {
        DataProductBasic *mapDTO = [self.productDto.colorVersionMap objectAtIndex:i];
        if ([self.productDto.productId isEqualToString: mapDTO.productId])
        {
            self.colorId = mapDTO.colorCurr;
            self.versionId = mapDTO.versionCurr;
            
            self.productDto.colorCurr = mapDTO.colorCurr;
            self.productDto.versionCurr = mapDTO.versionCurr;
            
            break;
        }
    }
}

//根据colorid versionid获取productDto
- (DataProductBasic *)getProductMap:(NSString *)colorId versionId:(NSString *)versionId
{
    if (colorId == nil && versionId == nil)
    {
        return nil;
    }
    for (int i = 0; i<[self.productDto.colorVersionMap count]; i++)
    {
        DataProductBasic *mapDTO = [self.productDto.colorVersionMap objectAtIndex:i];
        
        mapDTO.shopCode = self.productDto.shopCode;
        
        if ([colorId isEqualToString: mapDTO.colorCurr]  &&[versionId isEqualToString: mapDTO.versionCurr])
        {
            return mapDTO;
        }
        
        //add by cuizl 由于主站商品数据维护有问题，部分商品商品簇中versionid为空
        if([versionId isEqualToString:@""]||[mapDTO.versionCurr isEqualToString:@""])
        {
            if(self.productDto.versionItemList.count == 1&&[colorId isEqualToString:mapDTO.colorCurr])
            {
                return mapDTO;
                
            }
        }
        if([colorId isEqualToString:@""]||[mapDTO.colorCurr isEqualToString:@""])
        {
            
            if(self.productDto.colorItemList.count == 1 && [versionId isEqualToString:mapDTO.versionCurr])
            {
                return mapDTO;
            }
            
        }
        
    }
    return nil;
}

-(void)selected:(NSString *)value cell:(NSInteger)type
{
    if (nil == value) {
        BBAlertView *alert = [[BBAlertView alloc ]
                              initWithTitle:nil
                              message:L(@"Cluster_Not_Product_Found ")
                              delegate:nil
                              cancelButtonTitle:L(@"Ok")
                              otherButtonTitles:nil];
        [alert show];
        TT_RELEASE_SAFELY(alert);
        
        return;
    }
    
    if (ColorCell == type) {
        
        self.colorId = value;
        if (![self isVersionIdMatchColorId:self.colorId]) {
            for (DataProductBasic *tempDto in self.productDto.colorVersionMap) {
                if ([self.colorId isEqualToString:tempDto.colorCurr]) {
                    self.versionId = tempDto.versionCurr;
                    break;
                }
            }
        }
    }
    else if(SizeCell == type){
        
        self.versionId = value;
    }
    
    [self displayOverFlowActivityView];
    //刷新界面
//    [self displayOverFlowActivityView];
//    [self.detailService beginGetProductDetailInfo:[self getProductMap:self.colorId versionId:self.versionId]];
    
    if ([_mydelegate respondsToSelector:@selector(selectCu:)]) {
        
        [_mydelegate selectCu:[self getProductMap:self.colorId versionId:self.versionId]];
    }
    
}

- (void)displayOverFlowActivityView{
	
	[self.backView showHUDIndicatorViewAtCenter:L(@"Loading...")];
    
//	self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT*1.5
//                                                           target:self
//                                                         selector:@selector(timeOutRemoveHUDView)
//                                                         userInfo:nil
//                                                          repeats:NO];
	
}

- (void)removeOverFlowActivityView
{
    [self.backView hideHUDIndicatorViewAtCenter];
    
//    TT_INVALIDATE_TIMER(_dlgTimer);
	
}

- (BOOL)isVersionIdMatchColorId:(NSString *)colorId
{
    for (DataProductBasic *tempDto in self.productDto.colorVersionMap) {
        if ([colorId isEqualToString:tempDto.colorCurr] && [self.versionId isEqualToString:tempDto.versionCurr])
        {
            return YES;
        }
    }
    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -

#pragma 自定义
-(void)backAction{

    [self hideCuView];
}

-(void)hideCuView{
    
    if ([self.mydelegate respondsToSelector:@selector(removeProductCuview)])
    {
        [_mydelegate removeProductCuview];
    }
    
//    if (self.productDto.packageType == PackageTypeAccessory)
//    {
//        unsigned int count = [self.productDto.allAccessoryProductList count];
//        
//        for (int i = 0; i < count; i++)
//        {
//            DataProductBasic *pro = [self.productDto.allAccessoryProductList objectAtIndex:i];
//            
//            if (pro.isAccessorySelect) {
//               
//                pro.isAccessorySelect = NO;
//
//            }
//        }
//    }
    
//    self.productDto.quantity = 1;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.applicationImageView.frame = [[UIScreen mainScreen] bounds];
        self.backGroundView.backgroundColor = RGBACOLOR(0, 0, 0, 0);
        self.backGroundView.frame = [[UIScreen mainScreen] bounds];
        CGRect frame =  [[UIScreen mainScreen] bounds];
        frame.size.height = frame.size.height - 133;
        frame.origin.y = 1000;
        self.backView.frame = frame;
    
    }completion:^(BOOL finished){
        [self removeFromSuperview];
        self.hidden = YES;
    }];
}
-(void)showCuView{
    
    [self deleteBtn];
    [self buttomView];
    
    //是否展示购物车数量按钮
    if([ShopCartV2ViewController sharedShopCart].logic.allProductQuantity > 0)
    {
        [self refreshButtomView:YES];
        
    }
    else
    {
        [self refreshButtomView:NO];
        
    }
    [self initColorAndVersion];
    [self reloadTableView];
    [UIView animateWithDuration:0.4 animations:^{
        self.hidden = NO;
        CGRect frame =  [[UIScreen mainScreen] bounds];
        
        self.backGroundView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
        self.backGroundView.frame = frame;
        
        CGFloat scale = 0.875;
        self.applicationImageView.frame = CGRectMake(20, 20, 320 * scale, frame.size.height * scale);
        
        frame.size.height = frame.size.height - 133;
        frame.origin.y = 140;
        self.backView.frame = frame;
    }];
    
//    CABasicAnimation *animation0;
//    CABasicAnimation *animation1;
//    CABasicAnimation *animation2;
//    CABasicAnimation *animation3;
//    CABasicAnimation *animation4;
//    CABasicAnimation *animation5;
//    CATransform3D transformRotate;
//    CATransform3D transformTranslate;
//    CATransform3D transformScale;
//    CATransform3D transformFlat;
//    
//    transformRotate = CATransform3DRotate(CATransform3DIdentity, DEGREES_TO_RADIANS(10), 1, 0, 0);
//    transformTranslate = CATransform3DTranslate(transformRotate, 0, 0, -20);
//    transformFlat = CATransform3DRotate(transformTranslate, DEGREES_TO_RADIANS(-10), 1, 0, 0);
//    
//    float duration = 0.2;
//    animation0 = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation0.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    animation0.toValue = [NSValue valueWithCATransform3D:transformRotate];
//    animation0.delegate = self;
//    animation0.duration = duration;
//    
//    animation1 = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation1.fromValue = [NSValue valueWithCATransform3D:transformRotate];
//    animation1.toValue = [NSValue valueWithCATransform3D:transformTranslate];
//    animation1.delegate = self;
//    animation1.duration = duration;
//    
//    animation3 = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation3.fromValue = [NSValue valueWithCATransform3D:transformTranslate];
//    animation3.toValue = [NSValue valueWithCATransform3D:transformFlat];
//    animation3.delegate = self;
//    animation3.duration = duration;
//    
//    animation0.beginTime = 0;
//    animation1.beginTime = 0.2;
//    animation3.beginTime = 0.4;
//    
//    
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.animations = @[animation0, animation1, animation3];
//    group.duration = 0.6;
//    
//    [self.applicationImageView.layer addAnimation:group forKey:@"0"];
//    self.applicationImageView.layer.transform = transformFlat;
//
}

//刷新底部购物车数量按钮
- (void)refreshCuViewCarNumBtn
{
    if([ShopCartV2ViewController sharedShopCart].logic.allProductQuantity > 0)
    {
        [self refreshButtomView:YES];
        
    }
    else
    {
        [self refreshButtomView:NO];
        
    }
    
}

-(void)refreshView:(DataProductBasic *)dto{
    
    CGRect frame =  [[UIScreen mainScreen] bounds];
    CGRect tableViewFrame = CGRectMake(0, 75, 320, frame.size.height - 138 - 75 - 45);
    if (self.type == NormalProduct) {
        frame.origin.y = self.backView.size.height - 55;
        frame.size.height = 55;
        [self.timView removeFromSuperview];
    }
    else
    {
        frame.origin.y = self.backView.size.height - 82;
        frame.size.height = 82;
        [self.buttomView addSubview:self.timView];
        
        tableViewFrame.size.height -= 27;
    }
    self.buttomView.frame = frame;
    self.productTable.frame = tableViewFrame;
    
    for (DataProductBasic *innerDto in self.productDto.allAccessoryProductList)
    {
        [innerDto removeObserver:self forKeyPath:@"isAccessorySelect"];
    }
    self.productDto = dto;
    
        
    for (DataProductBasic *innerDto in self.productDto.allAccessoryProductList) {
        [innerDto addObserver:self
                   forKeyPath:@"isAccessorySelect"
                      options:NSKeyValueObservingOptionNew
                      context:NULL];
    }

    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.productImg.imageURL = [ProductUtil getImageUrlWithProductCode:self.productDto.productCode size:ProductImageSize160x160];
    }
    else{
        
        self.productImg.imageURL = [ProductUtil getImageUrlWithProductCode:self.productDto.productCode size:ProductImageSize100x100];
    }
    
    self.nameLab.text = self.productDto.productName;
    
    NSString *yixuan;
    if (self.type == NormalProduct) {
        yixuan = [NSString stringWithFormat:@"￥%.2f", [self.productDto.suningPrice doubleValue]];
    }else if (self.type == PurchuseProduct)
    {
        yixuan = [NSString stringWithFormat:@"￥%.2f", [self.productDto.qianggouPrice doubleValue]];
    }else if (self.type == GroupProduct)
    {
        yixuan = [NSString stringWithFormat:@"￥%.2f", [self.productDto.tuangouPrice doubleValue]];
    }
    else if (self.type == BigSaleProduct)
    {
        yixuan = [NSString stringWithFormat:@"￥%.2f", [self.productDto.juhuiPrice doubleValue]];
    }
    self.priceLab.text = yixuan;

    [self initColorAndVersion];
    [self refreshCuViewCarNumBtn];
    [self reloadTableView];
    
}
-(void)beginEasyBuy{
    
    if ([_mydelegate respondsToSelector:@selector(buyNow)]) {
        
        [_mydelegate buyNow];
    }
}

-(void)addToCar{
    
//    self.isClickAddCar = YES;
    
    
    if ([_mydelegate respondsToSelector:@selector(addtoCar:)]) {
        
        [_mydelegate addtoCar:YES];
    }
}
-(void)btnEnable:(BOOL)enabled{
    
    self.addCarBtn.enabled = enabled;
    
    self.buyNowBtn.enabled = enabled;
}

-(void)valueChange:(NSUInteger)number
{    
    self.productDto.quantity = number;
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121601"], nil]];
//    proNum = number;
    
    [self setTitleLabelText];
}

-(void)overSide{
    
    [((CommonViewController *)_mydelegate) presentSheetOnNav:L(@"product_AmountOverFlow")];
    
}

-(void)scrollTotop{
    
    for (int i=0; i<[self.productTable numberOfSections]; i++) {
        
        if ([self.productTable numberOfRowsInSection:i]>0) {
            
            [self.productTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]
                                     atScrollPosition:UITableViewScrollPositionTop
                                             animated:YES];
            
            break;
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [self backAction];
}


@end

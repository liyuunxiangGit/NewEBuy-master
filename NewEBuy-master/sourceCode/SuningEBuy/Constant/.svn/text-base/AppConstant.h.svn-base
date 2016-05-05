/*!
 @header      AppConstant.h
 @abstract    工程常用变量定义
 @author      刘坤
 @version     2012-6-8  
 */

#pragma mark -
#pragma mark 首页

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width

#define TOP_TOOL_BAR_RECT               CGRectMake(0, 0, 1024, 54)
#define TAB_BAR_VIEW_RECT               CGRectMake(0, 54, 1024, 714)
#define BODY_VIEW_FRAME_RECT            CGRectMake(0, 0, 948, 714)
#define BODY_VIEW_BOUNDS_RECT           CGRectMake(0, 0, 948, 714)
#define VERTICAL_TAB_BAR_RECT           CGRectMake(948, 0, 76, 714)

#define SPLIT_MASTER_VIEW_RECT          CGRectMake(0, 0, 320, 714)
#define SPLIT_DETAIL_VIEW_RECT          CGRectMake(320, 0, 628, 714)
 
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

#define kServerBusyErrorMsg             L(@"NWErrorTryLater")
#define kNetSlowErrorMsg                L(@"NWRequestErrorTryAfterCheck")
#define kNetUnreachErrorMsg             L(@"NWExceptionCheckSet")

#define kHttpResponseJSONValueFailError L(@"NWRequestErrorTryAgain(2,10200)")

#pragma mark -
#pragma mark Nav and TabBar

#define kNavigationBarBackgroundImage       @"system_nav_bg.png"
#define kNavControllerBackgroundImage       @"home_system_background.png"
#define kUINavigationBarFrameHeight         44.0f
#define kUITabBarFrameHeight                49.0f
#define kIphone5Fix                         88

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#define kStatusBarHeight                    20

#pragma mark ----------------------------- login keyChain
#define kSuningLoginUserNameKey                     @"loginUserNameKeyChain"
#define kSuningLoginPasswdKey                       @"loginPassWordKeyChain"
#define kSNKeychainServiceNameSuffix                @"SN_66996699_4008365365_LoginServiceName"
//参数加密的key
#define kLoginPasswdParamEncodeKey                  @"SNLoginPassWordEncode"

#pragma mark -
#pragma mark login error message
//登录相关状态信息
#define kLoginStatusMessageStartHttp				L(@"LOGIN_SendingLoginRequest")
#define kLoginStatusMessageSendActiveHttp			L(@"LOGIN_Activing")
#define kRegisterStatusMessageSendActiveHttp		L(@"LOGIN_Registering")
#define kLoginStatusMessageRequireUserName			L(@"LOGIN_PleaseEnterUserName")
#define kLoginStatusMessageRequirePassword			L(@"LOGIN_PleaseInputPassword")
#define kLoginStatusMessageRequirePassword1			L(@"LOGIN_PasswordLengthBetween6-20Place")
#define kLoginStatusMessageRequireRegisterId		L(@"LOGIN_PleaseEnterAccount")
#define kLoginStatusMessageRepeadPassword			L(@"LOGIN_PleaseEnterConfirmPassword")
#define kLoginStatusMessageRepeadPasswordError		L(@"LOGIN_PasswordTwiceNotSameInputAgain")
#define kLoginStatusMessageRequirevalidateCode		L(@"LOGIN_PleaseInputCheckCode")
#define kLoginStatusMessageFirstLogin				L(@"LOGIN_ERROR_2002")
#define kLoginStatusMessagePasswordError			L(@"LOGIN_ERROR_2020")
#define kLoginStatusMessagePasswordError1			L(@"LOGIN_BeforeLoginAgainWaitSeconds")
#define kLoginStatusMessageServerFailed				L(@"LOGIN_WithoutResponseTrylater")
#define kLoginStatusUserHaveLoginedError            L(@"LOGIN_Logined")
#define kLoginStatusPhoneValidateCodeError			L(@"LOGIN_ERROR_PhoneCheckCode")
#define kLoginStatusPhoneNoHaveBeenUserdError		L(@"LOGIN_ERROR_RegisteredBounded")
#define kLoginStatusPhoneNoEmptyError               L(@"LOGIN_ERROR_PhoneNumber")
#define kLoginStatusMessageSendActiveCode			L(@"LOGIN_ERROR_SendCheckCode")
#define kLoginStatusMessageFirstLoginError			L(@"LOGIN_MemberFirst")
#define kLoginStatusMessageError10                  L(@"LOGIN_ERROR_UseMemberNumberLogin")
#define kLoginStatusMessageStatusUnNormal           L(@"LOGIN_ERROR_LoginStateException")
#define kLogoutSeccessValue							@"1"
#define kLogoutFailedValue							@"0"
#define kLoginStatusPhoneInputError                 L(@"LOGIN_ERROR_2010")

#define kLoginStatusMessageSendActiveMassage1		L(@"LOGIN_ERROR_ActiveMassage1")
#define kLoginStatusMessageSendActiveMassage0		L(@"LOGIN_ERROR_ActiveMassage0")
#define kLoginStatusMessageSendActiveMassage2		L(@"LOGIN_ERROR_ActiveMassage2")
#define kLoginStatusMessageSendActiveMassage3		L(@"LOGIN_ERROR_ActiveMassage3")

//手机登录
#define kRegisterStatusMessagedRegisterIdError		L(@"PleaseEnterLegalPhoneNumber")
#define kLoginStatusMessageSendActivePasswordError	L(@"PasswordCannotConformStandard:6characters,discontinuous、differ")



//商品分类类目
#define kCategoryStatusMessageStartHttp				    L(@"StriveGetCategoryInfo")

#define kCategoryDebug 0

#define kCategoryEnmuElec                               L(@"ClientDirectory_Electrical")
#define kCategoryEnmuBaby                               L(@"ClientDirectory_MotherChild")
#define kCategoryEnmuCosmetics                          L(@"ClientDirectory_Beauty")
#define kCategoryEnmuBook                               L(@"ClientDirectory_Books")
#define kCategoryAll                                    L(@"ClientDirectory_All")

#define kBookCatelogIds                                 @"22001"

#pragma mark -
#pragma mark 首页用户提示信息
#define kHTTPUserLoginMessage						L(@"WelcomeSuning")
#define kHttpUserLogoutMessage						L(@"WelcomeSuningPleaseLogin")

//shopping
#define ShoppingStatusMessageRequireUserName			L(@"PleaseEnterConsigneeName")
#define ShoppingStatusMessageRequireUserPhone			L(@"PleaseEnterConsigneePhoneNumber")
#define ShoppingStatusMessageRequireUserinvonce			L(@"PleaseEnterInvoiceName")

//手机登录
#define kRegisterStatusMessagedRegisterIdError		L(@"PleaseEnterLegalPhoneNumber")
#define kLoginStatusMessageSendActivePasswordError	L(@"PasswordCannotConformStandard:6characters,discontinuous、differ")
//注册
#define kRegisterStatusMessageRegisterPasswordError1	L(@"PasswordCannotConformStandard:6-20characters、numbers、underlines")
#define kRegisterStatusMessageRegisterPasswordError2	L(@"AccountHaveRegistered")
#define kRegisterStatusMessageRegisterPasswordError3	L(@"LOGIN_ERROR_HaveLOGINED")
#define kRegisterStatusMessageRegisterPasswordError4	kServerBusyErrorMsg
#define kRegisterStatusMessageRegisterPasswordError5	L(@"PasswordCannotContainSpace")

//表名
#define kDatabaseProvinceTableName		@"dic_province"
#define kDatabaseCityTableName			@"dic_city"
#define kDatabaseAreaTableName			@"dic_area"
#define kDatabaseTwonTableName			@"dic_twon"

//省份名称
#define kDatabaseProvinceCode			@"province_code"
#define kDatabaseProvinceName			@"province_name"

//市名称
#define kDatabaseCityCode				@"city_code"
#define kDatabaseCityName				@"city_name"

//区名称
#define kDatabaseAreaCode				@"area_code"
#define kDatabaseAreaName				@"area_name"

//镇名称
#define kDatabaseTownCode				@"town_code"
#define kDatabaseTownName				@"town_name"

//Robin : loading image status
#define kLoadNot    @"1"
#define kLoadSorry  @"2"
#define kLoadFinish @"3"
#define kLoading    @"4"

//gjf windowlleavel 
#define BBAlertLeavel  300
#define YDaoLeavel     500

#pragma mark -
#pragma mark 我的易购

typedef enum {
	MemberInfoViewControllerPath=0,
	MemberOrderCenterViewControllerPath,
	MemberEasyPaymentViewControllerPath,
	MemberMyFavoriteViewControllerPath
}MemberEnterPath;

#pragma mark - 
#pragma mark 信息搜集类型
typedef enum {
    
    SystemInfoStat,
    
    IphoneUsingStat,
    
    UserRegisterStat,
    
    UserOrderNumStat,
    
    ProductSearchStat,
    
    PageAccessingStat,
    
    SystemCrashDownStat,
    
    AppStartSendDataStat
    
} ClientInfoMark;



#pragma mark -
#pragma mark cell 位置

typedef enum {
    CellPositionSingle = 1,
    CellPositionTop,
    CellPositionCenter,
    CellPositionBottom,
}CellPosition;

static inline CellPosition CellPositionMake(unsigned int rowCount, unsigned int row)
{
    if (rowCount <= 0)
    {
        return CellPositionSingle;
    }
    else if (rowCount == 1)
    {
        return CellPositionSingle;
    }
    else if (row == 0)
    {
        return CellPositionTop;
    }
    else if (row < rowCount-1)
    {
        return CellPositionCenter;
    }
    else if (row == rowCount-1)
    {
        return CellPositionBottom;
    }
    return CellPositionSingle;
}

#pragma mark -
#pragma mark 搜索条件表格中单元格标识符
#define kPriceCell								@"PriceCell"
#define kSearchCategoryCell						@"SearchCategoryCell"


#pragma mark -
#pragma mark 商品详情标识符
#define kProductDetailImageCellIdentifier		@"ProductImageCell"
#define kProductDetailInfoCellIdentifier		@"ProductInfoCell"
#define kProductDetailIntroduceCellIdentifier   @"ProductIntroduceCell"
#define kProductDetailServiceCellIdentifier		@"ProductServiceCell"
#define kProductDetailParameterCellIdentifier	@"ProductParameterCell"
#define kProductDetailPackageCellIdentifier		@"ProductPackageCell"
#define kProductDetailEvaluationCellIdentifier	@"ProductEvaluationCell"

#define kSERVERBUSY_ERRORDESC                   kServerBusyErrorMsg


#pragma mark -
#pragma mark 商品详情返回类型
typedef enum {
	ProductDetailBackTypeSearch,
	ProductDetailBackTypeHomeRecommend,
	ProductDetailBackTypeMemberMyFavorite,
	productDetailBackTypeShoppingCart,
    ProductDetailBackTypeProductRecommend,
	productDetailBackTypePopSale
}ProductDetailBackType;

#pragma mark -
#pragma mark cell的类型
typedef enum{
    TopCell,
    MiddleCell,
    BottomCell
} CellViewType;


#pragma mark -
#pragma mark 导航栏信息
#define kNavigationTitleViewWidth				140
#define kNavigationTitleViewHeight				30
#define kNavigationTitleViewCurXLoc				90
#define kNavigationTitleViewCurYLoc				7

#pragma mark -
#pragma mark 常用的默认无图的图片
#define kNoPic10064SizeImage					@"100-64-nopic.png"
#define kNoPic300135SizeImage					@"300-135-nopic.png"
#define kNoPic22SizeImage						@"no-pic-22.png"
#define kNoPic64SizeImage						@"no-pic-64.png"
#define kNoPic115SizeImage						@"no-pic-115.png"
#define kNoPic250SizeImage						@"no-pic-250.png"
#define kNoPic300250SizeImage					@"no-pic-300-250.png"

#pragma mark -
#pragma mark 星星评价图片
#define kSuningEmptyStarImage				     	@"icon_emptystar.png"                     //空星星
#define kSuningFullStarImage				     	@"icon_fullstar.png"                      //满星星
#define kSuningHalfStarImage				        @"icon_halfstar.png"                      //半空星星

#pragma mark -
#pragma mark 普通按钮 图片
#define kButtonServiceYiZhanImage                   @"btn_new_service.png"                        //服务易栈
#define kButtonSearchConditionActiveImage           @"btn_new_serach_con_act.png"                 //搜索条件
#define kButtonSearchConditionNormalImage           @"btn_new_serach_con_normal.png"
#define kButtonBookListCenterImage                  @"btn_new_list_center.png"                    //订单中心
#define kButtonSettlementActiveImage                @"btn_new_settlement_act.png"                 //结算中心
#define kButtonSettlementNormalImage                @"btn_new_settlement_normal.png"
#define kButtonSubmitActiveImage                    @"btn_new_submit_act.png"                     //提交
#define kButtonSubmitNormalImage                    @"btn_new_submit_normal.png"
#define kButtonStockInstallActiveImage              @"btn_new_stock_install_act.png"              //送货安装详情
#define kButtonStockInstallNormalImage              @"btn_new_stock_install_normal.png"
#define kButtonResetActiveImage                     @"btn_new_reset_act.png"                      //重置
#define kButtonResetNormalImage                     @"btn_new_reset_normal.png"
#define kButtonRegisterActiveImage                  @"btn_new_register_act.png"                   //注册
#define kButtonRegisterNormalImage                  @"btn_new_register_normal.png"
#define kButtonRefreshActiveImage                   @"btn_new_refresh_act.png"                    //刷新
#define kButtonRefreshNormalImage                   @"btn_new_refresh_normal.png"
#define kButtonQueryActiveImage                     @"btn_new_query_act.png"                      //查询
#define kButtonQueryNormalImage                     @"btn_new_query_normal.png"
#define kButtonNanjingActiveImage                   @"btn_new_nj_act.png"                         //南京市
#define kButtonNanjingNormalImage                   @"btn_new_nj_normal.png"
#define kButtonModificationActiveImage              @"btn_new_modification_act.png"               //修改
#define kButtonModificationNormalImage              @"btn_new_modification_normal.png"
#define kButtonLoginActiveImage                     @"btn_new_login_act.png"                      //登录
#define kButtonLoginNormalImage                     @"btn_new_login_normal.png"
#define kButtonLogOnActiveImage                     @"btn_new_log_on_act.png"                     //注销
#define kButtonLogOnNormalImage                     @"btn_new_log_on_normal.png"
#define kButtonFinishActiveImage                    @"btn_new_finish_act.png"                     //完成
#define kButtonFinishNormalImage                    @"btn_new_finish_normal.png"
#define kButtonDeleteActiveImage                    @"btn_new_delete_act.png"                     //删除
#define kButtonDeleteNormalImage                    @"btn_new_delete_normal.png"
#define kButtonConfirmJSActiveImage                 @"btn_new_confirm_js_act.png"                 //确认结算
#define kButtonConfirmJSNormalImage                 @"btn_new_confirm_js_normal.png"
#define kButtonClearCollectActiveImage              @"btn_new_clearCollect_act.png"               //清空收藏夹
#define kButtonClearCollectNormalImage              @"btn_new_clearCollect_normal.png"
#define kButtonCancelActiveImage                    @"btn_new_cancel_act.png"                     //灰色的取消
#define kButtonCancelNormalImage                    @"btn_new_cancel_normal.png"
#define kButtonCancelBlueActiveImage                @"btn_new_cancel_blue_act.png"                //蓝色的取消
#define kButtonCancelBlueNormalImage                @"btn_new_cancel_blue_normal.png"
#define kButtonAddToShopActiveImage                 @"btn_new_addshop_act.png"                    //加入购物车
#define kButtonAddToShopNormalImage                 @"btn_new_addshop_normal.png"
#define kButtonAddToCollectActiveImage              @"btn_new_addCollect_act.png"                 //加入收藏
#define kButtonAddToCollectNormalImage              @"btn_new_addCollect_normal.png"
#define kButtonAddAdressActiveImage                 @"btn_new_addAdress_act.png"                  //增加地址
#define kButtonAddAdressNormalImage                 @"btn_new_addAdress_normal.png"
#define kButtonCancelBookListActiveImage            @"btn_new_cancellist_act.png"                 //取消订单
#define kButtonCancelBookListNormalImage            @"btn_new_cancellist_normal.png"

#pragma mark -
#pragma mark 返回按钮 图片
#define kButtonBackActiveImage                      @"btn_new_back_act.png"                      //返回
#define kButtonBackNormalImage                      @"btn_new_back_normal.png"
#define kButtonBackShopActiveImage                  @"btn_new_shopBack_act.png"                  //返回 购物车
#define kButtonBackShopNormalImage                  @"btn_new_shopBack_normal.png"
#define kButtonBackSeviceYZActiveImage              @"btn_new_service_act.png"                   //返回 服务易栈
#define kButtonBackSeviceYZNormalImage              @"btn_new_service_normal.png"
#define kButtonBackSerachConditionActiveImage       @"btn_new_serachCondition_act.png"           //返回 搜索条件
#define kButtonBackSerachConditionNormalImage       @"btn_new_serachCondition_normal.png"
#define kButtonBackSearchActiveImage                @"btn_new_search_act.png"                    //返回 搜索
#define kButtonBackSearchNormalImage                @"btn_new_search_normal.png"
#define kButtonBackAddressProvinceActiveImage       @"btn_new_province_act.png"                  //返回 地址-省
#define kButtonBackAddressProvinceNormalImage       @"btn_new_province_normal.png"
#define kButtonBackAddressCityActiveImage           @"btn_new_city_act.png"                      //返回 地址-市
#define kButtonBackAddressCityNormalImage           @"btn_new_city_normal.png"  
#define kButtonBackAddressAreaActiveImage           @"btn_new_area_act.png"                      //返回 地址-区
#define kButtonBackAddressAreaNormalImage           @"btn_new_area_normal.png"

#define kButtonBackMyeBuyActiveImage                @"btn_new_myeBuy_act.png"                    //返回 我的易购
#define kButtonBackMyeBuyNormalImage                @"btn_new_myeBuy_normal.png"
#define kButtonBackMyCollectActiveImage             @"btn_new_myCollect_act.png"                 //返回 我的收藏夹
#define kButtonBackMyCollectyNormalImage            @"btn_new_myCollect_normal.png"
#define kButtonBackBookListDetailActiveImage        @"btn_new_listDetail_act.png"                //返回 定单详情
#define kButtonBackBookListDetailNormalImage        @"btn_new_listDetail_normal.png"
#define kButtonBackBookListCenterActiveImage        @"btn_new_listCenter_act.png"                //返回 订单中心
#define kButtonBackBookListCenterNormalImage        @"btn_new_listCenter_normal.png"
#define kButtonBackHomeActiveImage                  @"btn_new_home_act.png"                      //返回 首页
#define kButtonBackHomeNormalImage                  @"btn_new_home_normal.png"
#define kButtonBackHeatSaleActiveImage              @"btn_new_heatsale_act.png"                  //返回 热门促销
#define kButtonBackHeatSaleNormalImage              @"btn_new_heatsale_normal.png"
#define kButtonBackFirstCategoryActiveImage         @"btn_new_firstCategory_act.png"             //返回 一级分类
#define kButtonBackFirstCategoryNormalImage         @"btn_new_firstCategory_normal.png"
#define kButtonBackSecondCategoryActiveImage        @"btn_new_secondCategory_act.png"            //返回 二级分类
#define kButtonBackSecondCategoryNormalImage        @"btn_new_secondCategory_normal.png"  
#define kButtonBackQueryActiveImage                 @"btn_new_back_query_act.png"                //返回 查询
#define kButtonBackQueryNormalImage                 @"btn_new_back_query_normal.png"
#define kButtonBackAppleActiveImage                 @"btn_new_apple_act.png"                     //返回 苹果专区
#define kButtonBackAppleNormalImage                 @"btn_new_apple_normal.png"
#define kButtonBackAddressListActiveImage           @"btn_new_addressList_act.png"               //返回 地址列表
#define kButtonBackAddressListNormalImage           @"btn_new_addressList_normal.png"
#define kButtonBackGoodsDetailActiveImage           @"btn_new_goods_detail_act.png"              //返回 商品详情
#define kButtonBackGoodsDetailNormalImage           @"btn_new_goods_detail_normal.png"           
#define kButtonBackUserAppraiseActiveImage          @"btn_new_userAppraise_act.png"              //返回 用户评价
#define kButtonBackUserAppraiseNormalImage          @"btn_new_userAppraise_normal.png"         
#define kButtonBackRecommendGoodsActiveImage        @"btn_new_recGoods_act.png"                  //返回 推荐商品
#define kButtonBackRecommendGoodsNormalImage        @"btn_new_recGoods_normal.png"  
#define kButtonBackTakeFromShopActiveImage          @"btn_new_takefromshop_act.png"              //返回 门店自提
#define kButtonBackTakeFromShopNormalImage          @"btn_new_takefromshop_normal.png"  
#define kButtonBackLoginViewActiveImage             @"btn_new_loginBack_act.png"                 //返回 登录
#define kButtonBackLoginViewNormalImage             @"btn_new_loginBack_normal.png"  
#define kButtonBackMemberInfoActiveImage            @"btn_new_memberInfo_act.png"                //返回 会员信息
#define kButtonBackMemberInfoNormalImage            @"btn_new_memberInfo_normal.png"  

#pragma mark -
#pragma mark 易购 Logo图片
#define kSuningLOGOeBuyImage				     	@"new_logo_ebuy.png"                          //易购logo
#define kSuningHomeEbuyLogoCNImage				   	@"new_logo_ebuy_cn.png"                       //首页导航易购logo  .cn
#define kSuningHomeEbuyLogoCOMImage				    @"new_logo_ebuy_com.png"                      //首页导航易购logo  .com

#define kBackGroundForHomeViewControllerADD         @"addBackGround.png"                            //首页的小广告的背景

#pragma mark -
#pragma mark 苹果专区图片
#define kIconProductIphone64Image                   @"icon_iphone_64.png"
#define kIconProductIpad64Image                     @"icon_ipad_64.png"
#define kIconProductIpod64Image                     @"icon_ipod_64.png"
#define kIconProductMac64Image                      @"icon_mac_64.png"

#pragma mark -
#pragma mark iphone and ipad专区图片
#define kIconProductIphone200Image                   @"icon_iphone_200.png"
#define kIconProductDataLineImage                    @"icon_iphone_ipad_line.png"
#define kIconProductIphoneCoverImage                 @"icon_iphone_cover.png"
#define kIconProductEarphoneImage                    @"icon_earphone.png"
#define kIconProductElecSourceImage                  @"icon_elec_source.png"
#define kIconProductSoundBoxImage                    @"icon_soundbox.png"

#define kIconProductIpad200Image                     @"icon_ipad_200.png"
#define kIconProductIpadKeyboardImage                @"icon_ipad_keyboard.png"
#define kIconProductIpadPitaoImage                   @"icon_ipad_pitao.png"

#pragma mark -
#pragma mark mac专区图片
#define kIconProductImac160Image                     @"icon_imac_160.png"
#define kIconProductMacBook160Image                  @"icon_MacBook_160.png"
#define kIconProductMacBookair160Image               @"icon_MacBookair_160.png"

#pragma mark -
#pragma mark ipod专区图片
#define kIconProductIpodNanoImage                    @"icon_iPod_nano.png"
#define kIconProductIpodShuffleImage                 @"icon_iPod_shuffle.png"
#define kIconProductIpodTouchImage                   @"icon_iPod_touch.png" 

#define  IMAGE_DEFAULT_SIZE_WIDTH    64
#define  IMAGE_DEFAULT_SIZE_HEIGHT   64

#pragma mark -
#pragma mark shopping Cart
#define kAddNumer  YES
#define kreductNumber  NO



#pragma mark -
#pragma mark 商品详情
#define kProductDetailAddToShoppingCar              @"product_qb_joinbutton_enable.png"
#define kProductDetailAddToShoppingCarWithNoStore   @"ButtonArr.png"
#define kProductDetailAddToShoppingCarWithDisable   @"product_qb_joinbutton_disable.png"
#define kProductDetailAddToFavorite                 @"product_addFavorite_able.png"
#define kProductAppraisalAndAskBackGround           @"backGround.png"
#define kProductImageViewDefultImage                @"ebuy_default_image_placeholder.png"

#define kNavigationSmallBarBG                       @"home_nav_small_bg.png"

#pragma mark - kVirsual Products 
#pragma mark   虚拟商品

#define kVirsualMobilePayFaildDesc           L(@"Constant_PhoneRechargePayFail")
#pragma mark - kVirsual Products
#pragma mark   银联支付错误信息

#define kBankCardPayOrderNOEmpty             L(@"BankPay_OrderNumberCannotBeNull")
#define kBankCardPayVipNOEmpty               L(@"BankPay_MemberNumberCannotBeNull")
#define kBankCardPayOrderAmoutError          L(@"BankPay_OrderPayAmountIllegal")
#define kBankCardPayYifubaoAmoutError        L(@"BankPay_EPayAmountCannotBeNull")
#define kBankCardPayOrderInfoFail            L(@"BankPay_GetOrderInfoFail")
#define kBankCardPayOrderNotExist            L(@"BankPay_TransactionOrderInexistence")
#define kBankCardPayAmoutNotEqual            L(@"BankPay_OrderAmountNotEqualEpay")
#define kBankCardPayOrderNOtWaitPay          L(@"BankPay_OrderIsNotWaitPayState")
#define kBankCardPayValidateCodeEmpty        L(@"BankPay_AuthNumberCannotBeNull")
#define kBankCardPayPayPswEmpty              L(@"BankPay_PayPasswordCannotBeNull")
#define kBankCardPayInOrderTableFail         L(@"BankPay_PayMethodFailToStore")
#define kBankCardPayMethodEmpty              L(@"BankPay_PayMethodCannotBeNull")
#define kBankCardPayProductOffShelf          L(@"BankPay_SoldOutGoodCannotPay")
#define kBankCardPayYifubaoAmoutFail         L(@"BankPay_QueryEpayBalanceException")
#define kBankCardPaySavePayInfoFail          L(@"BankPay_SuccessPayButSaveDataSynOrderException")
#define kBankCardPayOrderPayFail             L(@"BankPay_OrderPayFailTryLater")
#define kBankCardValidateYifubaoPswFail      L(@"BankPay_EpayPasswordVerifyFail")
#define kBankCardPayProuctAmoutNotEnough     L(@"BankPay_GoodInventoryInsufficientOrderNeed")
#define kBankCardGroupBuyEnd                 L(@"BankPay_ComeLateGroupBuyingEnd")
#define kBankCardPayQueryEppOrderStateFail   L(@"BankPay_QueryEPPOderStateException")



#pragma mark -
#pragma mark 彩票

#define kDealsType_DaiGou  10
#define kDealsType_ZhuiHao 11


#pragma mark ----------------------------- 购物车

#define kShopCartCheckConflict  L(@"Constant_SorrySuningGoodAndThirdNeedPaySeparate")

#define PRODUCT_DEBUG 1

#pragma mark ----------------------------- tab index

#define kHomeTabIndex       0
#define kSearchTabIndex     1
#define kCateTabIndex       2
#define kShopCartTabIndex   3
#define kMyEbuyTabIndex     4

#pragma mark -----------------------------  image defines

#define kNavRightItemImage      @"right_item_btn_new.png"
#define kNavRightItemImageLight @"right_item_light_btn_new.png"

#pragma mark ------------------------------拖动ui效果开关 by chupeng
#define kPanUISwitch 1


#define kSNReaderUseZBar        0
#define kSNReaderUseZXing       1


#define k233TextBorderColor     RGBCOLOR(227,224,216)

#define kTableViewNumberOfRowsKey       @"numberOfRows"
#define kTableViewCellListKey           @"cellList"
#define kTableViewCellHeightKey         @"cellHeight"
#define kTableViewCellTypeKey           @"cellType"
#define kTableViewCellDataKey           @"cellData"
#define kTableViewSectionHeaderHeightKey      @"sectionHeaderHeight"
#define kTableViewSectionHeaderTypeKey        @"sectionHeaderType"
#define kTableViewSectionFooterHeightKey      @"sectionFooterHeight"
#define kTableViewSectionFooterTypeKey        @"sectionFooterType"

#pragma mark ----------------------------- 在线客服资源

#define kOS_hewolianxi_normal_image             @"productDetail_zaixiankefu_normal.png"
#define kOS_hewolianxi_normal_image_clicked     @"productDetail_zaixiankefu_clicked.png"
#define kOS_hewolianxi_disable_iamge            @"productDetail_zaixiankefu_lixian.png"

#define kOS_lixianliuyan_image                  @"productDetail_lixianliuyan_normal.png"
#define kOS_lixianliuyan_image_clicked          @"productDetail_lixianliuyan_clicked.png"

#pragma mark ----------------------------- 用卷支付
#define kCouponSwitch 1

#pragma mark ----------------------------- 数据搜集
#define kAppName                                L(@"eBuy")

#pragma mark ----------------------------- url schemes

#define kURLSchemeSNBook                    @"com.suning.reader4iphone://"
#define kURLSchemeSuningEBuy                @"com.suning.SuningEBuy://"

#pragma mark - SNRouter

#define kSNRouterAdNotFoundDefaultError     L(@"Constant_SorryActionOutOfdateOrCantFindIt")

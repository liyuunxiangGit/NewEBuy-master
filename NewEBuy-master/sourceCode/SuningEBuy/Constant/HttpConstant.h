//
//  HttpConstant.h
//  SuningFutureStoreVersion2
//
//  Created by Wang Jia on 10-11-28.
//  Copyright 2010 IBM. All rights reserved.
//

#import "SuningEBuyConfig.h"

#pragma mark -
#pragma mark 网络畅通测试地址
#define	kNetworkTestAddress						@"http://www.baidu.com"


#pragma mark -
#pragma mark HTTP服务器域名

#ifdef kPreTest

    //搜索促销mts一拖2接口 http://10.24.64.188/mts-web/spfs/querySalesShow_000000000101234039_1_9137__1.html  /querySalesShow/{productId}_{channelId}_{cityId}_{marketId}_{endDeviceId}.html
    #define kSearchMtsPromotion  @"http://mpre.cnsuning.com/mts-web/spfs/querySalesShow"


    //搜索mts接口action
    #define kSearchMtsAction     @"mts-web/spfs/queryCommontidyActivity.html"

//    #define shopJumpToUrlHost @"http://mpre.cnsuning.com/webapp/wcs/stores/servlet/SNMWCshopInfoView?storeId=10052&shopId="
    #define shopJumpToUrlHost @"http://mpre.cnsuning.com/shop/%@_1.html"

    //热门搜索词action
    #define kNewHotWordsAction @"hotwords/hotwordsApp.do"

    //热销品牌推荐
    #define kNewSearchQueryRecommendedBrandHost @"http://mpre.cnsuning.com/search/queryRecommendedBrand.do"

    //Mts&Mobts
    #define kHostSuningMobts                    @"http://mobimsgpre.cnsuning.com/suning-web-mobile"
    #define kHostSuningMobtsHttps               @"https://mobimsgpre.cnsuning.com/suning-web-mobile"
    #define kHostSuningMts                      @"http://mpre.cnsuning.com"
    #define kHostSuningMtsHttps                 @"https://mtspre.cnsuning.com/mts-web"

    //wap
    #define kHostSuningWap                      @"http://wappre.cnsuning.com/"
    #define kHostSuningWapHttps                 @"https://wappre.cnsuning.com/"

    //门店列表单独的Host
    #define kHostSuningWebMobileShopList        kHostSuningMts

    //add by gjf cpa&cps
    #define kHostSuningCPA                      kHostSuningMts
    //推荐
    #define kProductDetailRecommendHttp         @"http://tuijianpre.cnsuning.com/recommend-portal/recommendv3"

    //分类筛选无结果页推荐列表和关键词搜索无结果推荐列表接口
    #define kSearchNoResultNewHostHttp          @"http://tuijianpre.cnsuning.com/recommend-portal/recommendv2/biz.jsonp"

    //检验码图片host
    #define kHostVCSImageCode                   @"http://vcspre.cnsuning.com/vcs/imageCode.htm"

    #define kPASSPORT_MODULE_IDS                @"https://passportpre.cnsuning.com/ids/"
    //passport登录
    #define kPassportLoginParamService          @"https://aqpre.cnsuning.com/asc/auth"
    #define kPassportLoginParamTargetUrl        @"https://sslpre.cnsuning.com/emall/SNiPhoneAppLogonCouponViewpp"
    #define kPassportLoginUrl                   @"https://passportpre.cnsuning.com/ids/login"
    #define kPassportLogout                     @"https://passportpre.cnsuning.com/ids/logout"
    #define kPassportTrustLoginUrl              @"https://passportpre.cnsuning.com/ids/trustLogin"
    #define kPassportNeedVerifyCode             @"http://passportpre.cnsuning.com/ids/needVerifyCode"

    //易付宝passport登录
    #define kPayPassportForHttps                    @"https://prepaypassport.cnsuning.com/ids/login"

    //生活中心
    #define kHostWBGameForHttp                  @"http://gamesit.cnsuning.com/game-web/h5/recharge/onlineGameRecharge.htm"
    #define KHostWBWebForHttp                   @"http://10.19.250.55:8000/ios.suning.com/index.php?route=common/recommend&page_title=%E5%BA%94%E7%94%A8%E6%8E%A8%E8%8D%90"
    #define KHostWBBookForHttp                  @"http://snbook.suning.com/m/lapp/trad/index.htm?noTitleFlag=1"//@"http://subook.suning.com/m/201/bookstore/index.htm?ebuyFlag=1"
    #define KHostWBCaiPiaoForHttp               @"http://caipiaosit.cnsuning.com/html5/index.shtml?origin=3"

    //伪静态
    #define kHostAddressForHtml                 @"http://b2cpre.cnsuning.com/emall"
    //c店铺
    #define kMHostAddressForHttp                @"http://shop.mpre.cnsuning.com/app"
    //@"http://m.cnsuning.com/emall/shop"

    #define kNewSwitchURL                       @"http://api.mpre.cnsuning.com/switch/appswitch.html"
    #define kHostAddressForHttp					@"http://b2cpre.cnsuning.com/webapp/wcs/stores/servlet"
    #define kHostAddressForHttps				@"https://sslpre.cnsuning.com/webapp/wcs/stores/servlet"
    #define kImageAddressForHttp				@"http://preimage3.suning.cn/content/catentries"
    #define kCategoryAddressForHttp				@"http://preimage3.suning.cn/content/categories"
    #define kProductDetailPageForHttp           @"http://b2cpre.cnsuning.com/emall"
    //知识堂服务器pre
    #define kHostZhiShiForHttp                  @"http://zhishitangsit.cnsuning.com/zhishitang/terminal"
    //@"http://10.22.7.244:8080/zhishitang/terminal"
    //易付宝服务器pre
    #define kHostHuiFuHttp                      @"http://192.168.121.82/epp-portal/pay/phone-gate-way.action?pcCode=10001&payOrderId"
    //机票服务器pre
    #define kHostPlaneTicketNewForHttp          @"http://prejipiao.cnsuning.com/vgs-web/mobile/newpayment"
    #define kHostPlaneTicketForHttp             @"http://prejipiao.cnsuning.com/vgs-web/mobile"
    #define kHostPlaneTicketOctForHttp          @"http://prejipiao.cnsuning.com/vgs-web/mobile/oct"
    //酒店服务器pre
    #define kHostHotelOrderForHttp              @"http://10.19.250.143/hotelpay-web/hotelTerminal/fnd"
    #define kHostHotelImageForHttp              @"http://image3.suning.cn/vgsimages/hotelpay"
    //彩票服务器pre
    #define kHostLotteryTicketForHttp           @"http://192.168.157.171:9080"
    //抢购服务器
    #define kHostPanicPurchaseForHttp           @"http://qiangpre.cnsuning.com"
    //搜索服务器
//    #define kSearchHostAddressForHttp           @"http://searchpre.cnsuning.com/emall/mobile"
    #define kSearchHostAddressForHttp           @"http://192.168.33.2/emall/mobile"

    //店铺搜索地址
    #define kShopSearchHost @"http://searchpre.cnsuning.com/shop/phoneSearch.json"
//    #define kShopSearchHost @"http://searchpre.cnsuning.com/shop/searchPhone.json"

    //新团购服务器
    #define kHostGroupBuyAddressForHttp         @"http://tuanpre.cnsuning.com/hoteltuannew-web/groupbuy/mobileclient"
    //图片服务器
    #define kImageServerHost                    @"http://image.suning.cn/b2c/catentries"
    //注册图片url
    #define kRegisterPictureUrl                 @"http://b2cpre.cnsuning.com/webapp/wcs/stores/jcaptcha"
    #define kRegisterForHttps                   @"http://b2cpre.cnsuning.com/webapp/wcs/stores/servlet"

    //获取商品图片
    #define kGetCommodityImageForHttps          @"http://preimage3.suning.cn"

    //分类中电子书出版url
    #define kEBookTradEnrtyHttp                 @"http://subookpre.cnsuning.com/m/lapp/trad/index.htm"

    //分类中电子书原创首页
    #define kEBookIntactEnrtyHttp               @"http://subookpre.cnsuning.com/m/lapp/intact/index.htm"

    //价格图片服务器
    #define kPriceServerHost                    @"http://preprice1.suning.cn/webapp/wcs/stores/prdprice"

    //web收银台
    #define kEppHostAddress                     @"http://mpaypre.cnsuning.com"

    #define kEvaluateServerHost                 @"http://zonepre.cnsuning.com/review/mobile"
    //上一个http的主站url
    #define kEvaluateServerHostJson             @"http://zonepre.cnsuning.com/review/json"

    #define kCommentShareReviewServer           @"http://zone.suning.com/review/"

    //头像服务器
    #define kCardPhotoHostAddressHost           @"https://10.19.95.100/uimg/cmf"

    //头像服务器
    #define kWBCardPhotoHostAddressHost         @"http://uimgpre.cnsuning.com/uimg/cmf/cust_headpic"

    //在线客服
    #define kOnlineServiceServerHost           @"http://conlinesit.cnsuning.com/visitor/chat"
    #define kOnlineServiceServerHostGetMessage @"http://conlinesit.cnsuning.com/visitor/chat"


//    #define kOnlineServiceServerHost           @"http://talkpre.cnsuning.com/visitor/chat"
//
//    #define kOnlineServiceServerHostGetMessage @"http://talkmsgpre.cnsuning.com/visitor/chat"



   #define kOrderConfirmAcceptWapUrl            @"http://mpaypre.cnsuning.com/epp-m/showCheckPayPWD.htm?redecitString=suningMobileCheckPassSucess"
   #define kOrderConfirmAcceptWapBackUrl        @"http://mpaypre.cnsuning.com/epp-m/suningMobileCheckPassSucess"

    //v购-我的预约
    #define KvGouMyYuyueURL @"http://mpre.cnsuning.com/vgou/private/myVgou.do"

    //我的预约-商品预约
    #define KShangPinYuyueURL @"http://mpre.cnsuning.com/mts-web/appointment/private/my_appoint_1.html"

    //C店店铺
    #define kCShopHostURL   @"http://mpre.cnsuning.com/shop"

    //wap
    #define kEbuyWapHostURL     @"http://mpre.cnsuning.com"

    #define KNewHomeAPIURL      @"http://api.mpre.cnsuning.com/"

    #define kMFSServer          @"http://mfspre.cnsuning.com"

    //猜你喜欢（首页推荐）
    #define kGuessYouLikeURL    @"http://tuijianpre.cnsuning.com/"

    //缴费城市列表(水电煤城市选择)
    #define kChargeCityListURL  @"http://mpre.cnsuning.com/mylife/chargeCityList.html"
    #define kChargeModeQueryURl @"http://mpre.cnsuning.com/mylife/chargeModeQuery.html"

    //会员收藏接口Host
    #define kMemberFavoriteHostURL       @"http://mpre.cnsuning.com/mts-web/favorite/private"
    //会员等级接口Host
    #define kMemberLevelHostURL       @"http://mpre.cnsuning.com/mts-web/favorite/custlv/private"
//门店评价
#define kStoreEvaluationHostURL    @"http://mts.suning.com/comment/private/mobile"


#elif kSitTest
    #define kSearchMtsPromotion  @"http://msit.cnsuning.com/mts-web/spfs/querySalesShow"

//    #define shopJumpToUrlHost @"http://msit.cnsuning.com/webapp/wcs/stores/servlet/SNMWCshopInfoView?storeId=10052&shopId="
    #define shopJumpToUrlHost @"http://msit.cnsuning.com/shop/%@_1.html"

    //搜索mts接口action
    #define kSearchMtsAction     @"mts-web/spfs/queryCommontidyActivity.do"

    //热门搜索词action
    #define kNewHotWordsAction @"hotwords/hotwordsApp.do"

    //热销品牌推荐
    #define kNewSearchQueryRecommendedBrandHost @"http://msit.cnsuning.com/search/queryRecommendedBrand.do"

    //Mts&Mobts
    #define kHostSuningMobts                    @"http://mobimsgsit.cnsuning.com/suning-web-mobile"
    #define kHostSuningMobtsHttps               @"https://mobimsgsit.cnsuning.com/suning-web-mobile"
    #define kHostSuningMts                      @"http://mtssit.cnsuning.com/mts-web"
    #define kHostSuningMtsHttps                 @"https://msit.cnsuning.com/mts-web"

    //wap
    #define kHostSuningWap                      @"http://wapsit.cnsuning.com/"
    #define kHostSuningWapHttps                 @"https://wapsit.cnsuning.com/"

    //add by gjf cpa&cps
    #define kHostSuningCPA                      @"http://msit.cnsuning.com"
    //门店列表单独的Host
    #define kHostSuningWebMobileShopList        kHostSuningMobts

    //推荐
    #define kProductDetailRecommendHttp         @"http://10.19.90.232:9080/recommend-portal/recommendv3"

    //分类筛选无结果页推荐列表和关键词搜索无结果推荐列表接口
    #define kSearchNoResultNewHostHttp          @"http://10.19.90.232:9080/recommend-portal/recommendv2/biz.jsonp"

    //检验码图片host
    #define kHostVCSImageCode                   @"http://vcssit.cnsuning.com/vcs/imageCode.htm"

    #define kPASSPORT_MODULE_IDS                @"https://passportsit.cnsuning.com/ids/"
    //passport登录
    #define kPassportLoginParamService          @"https://aqsit.cnsuning.com/asc/auth"
    #define kPassportLoginParamTargetUrl        @"https://sslsit.cnsuning.com/emall/SNiPhoneAppLogonCouponViewpp"
    #define kPassportLoginUrl                   @"https://passportsit.cnsuning.com/ids/login"
    #define kPassportTrustLoginUrl              @"https://passportsit.cnsuning.com/ids/trustLogin"

    //易付宝passport登录
    #define kPayPassportForHttps                    @"https://sitpaypassport.cnsuning.com/ids/login"

    //passport注销
    #define kPassportLogout                     @"https://passportsit.cnsuning.com/ids/logout"
    #define kPassportNeedVerifyCode             @"http://passportsit.cnsuning.com/ids/needVerifyCode"

    //生活中心
    #define kHostWBGameForHttp                  @"http://gamesit.cnsuning.com/game-web/h5/recharge/onlineGameRecharge.htm"
    #define KHostWBWebForHttp                   @"http://10.19.250.55:8000/ios.suning.com/index.php?route=common/recommend&page_title=%E5%BA%94%E7%94%A8%E6%8E%A8%E8%8D%90"
    #define KHostWBBookForHttp                  @"http://snbook.suning.com/m/lapp/trad/index.htm?noTitleFlag=1"//@"http://subooksit.suning.com/m/201/bookstore/index.htm?ebuyFlag=1"
    #define KHostWBCaiPiaoForHttp               @"http://caipiaosit.cnsuning.com/html5/index.shtml?origin=3"

    //伪静态
    #define kHostAddressForHtml                 @"http://b2csit.cnsuning.com/emall"

    //c店铺
    #define kMHostAddressForHttp                @"http://shop.msit.cnsuning.com/app"

    //@"http://m.cnsuning.com/emall/shop"

    #define kNewSwitchURL                       @"http://api.msit.cnsuning.com/switch/appswitch.html"

    #define kHostAddressForHttp                 @"http://b2csit.cnsuning.com/webapp/wcs/stores/servlet"
    #define kHostAddressForHttps                @"https://sslsit.cnsuning.com/webapp/wcs/stores/servlet"
    #define kImageAddressForHttp                @"http://sitimage3.suning.cn/content/catentries"
    #define kCategoryAddressForHttp             @"http://sitimage3.suning.cn/content/categories"
    #define kProductDetailPageForHttp           @"http://b2csit.cnsuning.com/emall"
    //易付宝服务器连通汇付天下服务sit
    #define kHostHuiFuHttp                      @"http://192.168.157.100/epp-portal/pay/phone-gate-way.action?pcCode=10001&payOrderId"
    //知识堂服务器sit
    #define kHostZhiShiForHttp                  @"http://zhishitangsit.cnsuning.com/zhishitang/terminal"
    //机票服务器sit
    #define kHostPlaneTicketNewForHttp          @"http://sitjipiao.cnsuning.com/vgs-web/mobile/newpayment"
    #define kHostPlaneTicketForHttp             @"http://10.19.250.122:9080/vgs-web/mobile"
    #define kHostPlaneTicketOctForHttp          @"http://10.19.250.122:9080/vgs-web/mobile/oct"
    //酒店服务器sit
    #define kHostHotelOrderForHttp              @"http://10.19.250.122/hotelpay-web/hotelTerminal/fnd"
    #define kHostHotelImageForHttp              @"http://image3.suning.cn/vgsimages/hotelpay"
    //彩票服务器sit（彩票没有sit，故使用pre）
    #define kHostLotteryTicketForHttp           @"http://10.19.250.72:9080"

    //分类中电子书出版首页url
    #define kEBookTradEnrtyHttp                 @"http://subooksit.cnsuning.com/m/lapp/trad/index.htm"

    //分类中电子书原创首页
    #define kEBookIntactEnrtyHttp               @"http://subooksit.cnsuning.com/m/lapp/intact/index.htm"

    //抢购服务器
    #define kHostPanicPurchaseForHttp           @"http://qiangsit.cnsuning.com"
    #define kSearchHostAddressForHttp           @"http://searchsit.cnsuning.com/emall/mobile"
    //新团购服务器
    #define kHostGroupBuyAddressForHttp         @"http://10.19.250.122/hoteltuan-web/groupbuy/mobileclient"
    //图片服务器
    #define kImageServerHost                    @"http://image.suning.cn/b2c/catentries"
    //注册图片url
    #define kRegisterPictureUrl                 @"http://b2csit.cnsuning.com/webapp/wcs/stores/jcaptcha"
    #define kRegisterForHttps                   @"http://b2csit.cnsuning.com/webapp/wcs/stores/servlet"

    //获取商品图片
    #define kGetCommodityImageForHttps          @"http://sitimage3.suning.cn"

    //价格图片服务器
    #define kPriceServerHost                    @"http://sitprice1.suning.cn/webapp/wcs/stores/prdprice"
    //web收银台
    #define kEppHostAddress                     @"http://mpaysit.cnsuning.com"

    #define kEvaluateServerHost                 @"http://zonesit.cnsuning.com/review/mobile"

    //上一个http的主站url
    #define kEvaluateServerHostJson             @"http://zonesit.cnsuning.com/review/json"

    #define kCommentShareReviewServer           @"http://zone.suning.com/review/"
    //头像服务器
    #define kCardPhotoHostAddressHost           @"https://10.19.95.100/uimg/cmf"

    //头像服务器
    #define kWBCardPhotoHostAddressHost         @"http://uimgpre.cnsuning.com/uimg/cmf/cust_headpic"

    //在线客服
    #define kOnlineServiceServerHost            @"http://conlinesit.cnsuning.com/visitor/chat"
    #define kOnlineServiceServerHostGetMessage  @"http://conlinesit.cnsuning.com/visitor/chat"

//#define kOnlineServiceServerHost            @"http://talksit.cnsuning.com/visitor/chat"
//
//#define kOnlineServiceServerHostGetMessage  @"http://talkmsgsit.cnsuning.com/ocs-msg-web/visitor/chat"



    #define kOrderConfirmAcceptWapUrl           @"http://mpaysit.cnsuning.com/epp-m/showCheckPayPWD.htm?redecitString=suningMobileCheckPassSucess"
    #define kOrderConfirmAcceptWapBackUrl       @"http://mpaysit.cnsuning.com/epp-m/suningMobileCheckPassSucess"

    //店铺搜索地址
    #define kShopSearchHost @"http://searchsit.cnsuning.com/shop/phoneSearch.json"

    //v购-我的预约
    #define KvGouMyYuyueURL @"http://msit.cnsuning.com/vgou/private/myVgou.do"

    //我的预约-商品预约
    #define KShangPinYuyueURL @"http://msit.cnsuning.com/mts-web/appointment/private/my_appoint_1.html"

    //C店店铺
    #define kCShopHostURL   @"http://msit.cnsuning.com/shop"

    //wap
    #define kEbuyWapHostURL     @"http://msit.cnsuning.com"

    #define KNewHomeAPIURL      @"http://api.msit.cnsuning.com/"

    #define kMFSServer          @"http://mfssit.cnsuning.com"

    //猜你喜欢（首页推荐）
    #define kGuessYouLikeURL    @"http://10.19.90.232:9080/"

    //缴费城市列表(水电煤城市选择)
    #define kChargeCityListURL  @"http://msit.cnsuning.com/mylife/chargeCityList.html"
    #define kChargeModeQueryURl @"http://msit.cnsuning.com/mylife/chargeModeQuery.html"

    //会员收藏接口Host
    #define kMemberFavoriteHostURL       @"http://mpre.cnsuning.com/mts-web/favorite/private"
    //会员等级接口Host
    #define kMemberLevelHostURL         @"http://mpre.cnsuning.com/mts-web/favorite/custlv/private"
//门店评价
#define kStoreEvaluationHostURL    @"http://msit.cnsuning.com/comment/private/mobile"


#elif kReleaseH

    #define kSearchMtsPromotion  @"http://m.suning.com/mts-web/spfs/querySalesShow"

    //搜索mts接口action  http://m.suning.com/spfs/queryCommontidyActivity.html?set=5&keyword=102550703&st=0&ci=&cityId=9173&ps=15&cp=0&cf=&iv=-1&ct=-1&sp=
    #define kSearchMtsAction     @"mts-web/spfs/queryCommontidyActivity.html"
    #define kSearchMtsRelease     @"http://m.suning.com"

    //热门搜索词action  http://wap.suning.com/hotwords/hotwordsApp.do?channel=3
    #define kNewHotWordsAction @"hotwords/hotwordsApp.do"

    //http://m.suning.com/shop/{shopid}_1.html
//    #define shopJumpToUrlHost   @"http://m.suning.com/webapp/wcs/stores/servlet/SNMWCshopInfoView?storeId=10052&shopId="
    #define shopJumpToUrlHost @"http://m.suning.com/shop/%@_1.html"
    //热门搜索词生产环境域名  邓武林: http://m.suning.com/mts-web/hotwords/hotwordsApp.do?channel=3
    #define kNewHotWordsServer @"http://m.suning.com/mts-web"

    #define kNewSearchQueryRecommendedBrandHost @"http://api.m.suning.com/search/queryRecommendedBrand.do"

    //Mts&Mobts
    #define kHostSuningMobts                    @"http://mobts.suning.com/suning-web-mobile"
    #define kHostSuningMobtsHttps               @"https://mobts.suning.com/suning-web-mobile"
    #define kHostSuningMts                      @"http://mts.suning.com/mts-web"
    #define kHostSuningMtsHttps                 @"https://mts.suning.com/mts-web"

    //wap
    #define kHostSuningWap                      @"http://mts.suning.com/mts-web"
    #define kHostSuningWapHttps                 @"https://mts.suning.com/mts-web"

    //add by gjf cpa&cps
    #define kHostSuningCPA                      @"http://m.suning.com"

//门店列表单独的Host
    #define kHostSuningWebMobileShopList        kHostSuningMobts

    //推荐
    #define kProductDetailRecommendHttp         @"http://tuijian.suning.com/recommend-portal/recommendv3"

    //分类筛选无结果页推荐列表和关键词搜索无结果推荐列表接口
    #define kSearchNoResultNewHostHttp             @"http://tuijian.suning.com/recommend-portal/recommendv2/biz.jsonp"

    //检验码图片host
    #define kHostVCSImageCode                   @"http://vcs.suning.com/vcs/imageCode.htm"

    #define kPASSPORT_MODULE_IDS                @"https://passport.suning.com/ids/"
    //passport登录
    #define kPassportLoginParamService          @"https://aq.suning.com/asc/auth"
    #define kPassportLoginParamTargetUrl        @"https://ssl.suning.com/emall/SNiPhoneAppLogonCouponViewpp"
    #define kPassportLoginUrl                   @"https://passport.suning.com/ids/login"
    #define kPassportLogout                     @"https://passport.suning.com/ids/logout"
    #define kPassportTrustLoginUrl              @"https://passport.suning.com/ids/trustLogin"
    #define kPassportNeedVerifyCode             @"http://passport.suning.com/ids/needVerifyCode"

    //易付宝passport登录
    #define kPayPassportForHttps                    @"https://paypassport.suning.com/ids/login"

    //生活中心
    #define kHostWBGameForHttp                  @"http://game.suning.com/game-web/h5/recharge/onlineGameRecharge.htm"
    #define KHostWBWebForHttp                   @"http://mapp.suning.com/ios/index.php?route=common/recommend"
    #define KHostWBBookForHttp                  @"http://snbook.suning.com/m/lapp/trad/index.htm?noTitleFlag=1"//@"http://subook.suning.com/m/201/bookstore/index.htm?ebuyFlag=1"
    #define KHostWBCaiPiaoForHttp               @"http://caipiao.suning.com/html5/index.shtml?origin=3"

    //伪静态
    #define kHostAddressForHtml                 @"http://www.suning.com/emall"
    //c店铺
    #define kMHostAddressForHttp                @"http://shop.m.suning.com/app"
    //@"http://m.suning.com/emall/shop"

    #define kNewSwitchURL                       @"http://api.m.suning.com/switch/appswitch.html"

    #define kHostAddressForHttp                 @"http://www.suning.com/webapp/wcs/stores/servlet"
    #define kHostAddressForHttps				@"https://ssl.suning.com/webapp/wcs/stores/servlet"
    #define kImageAddressForHttp				@"http://image3.suning.cn/content/catentries"
    #define kCategoryAddressForHttp				@"http://image3.suning.cn/content/categories"
    #define kProductDetailPageForHttp           @"http://www.suning.com/emall"
    //知识堂服务器prd
    #define kHostZhiShiForHttp                  @"http://zhishi.suning.com/zhishitang/terminal"
    //机票服务器prd
    #define kHostPlaneTicketNewForHttp          @"http://jipiao.suning.com/vgs-web/mobile/newpayment"
    #define kHostPlaneTicketForHttp             @"http://jipiao.suning.com/vgs-web/mobile"
    #define kHostPlaneTicketOctForHttp          @"http://jipiao.suning.com/vgs-web/mobile/oct"
    //易付宝服务器prd
    #define kHostHuiFuHttp                      @"http://pay.suning.com/epp-portal/pay/phone-gate-way.action?pcCode=10001&payOrderId"
    //酒店服务器prd
    #define kHostHotelOrderForHttp              @"http://jiudian.suning.com/hotelpay-web/hotelTerminal/fnd"
    #define kHostHotelImageForHttp              @"http://image3.suning.cn/vgsimages/hotelpay"
    //彩票服务器prd
    #define kHostLotteryTicketForHttp           @"http://caipiao.suning.com"
    //抢购服务器
    #define kHostPanicPurchaseForHttp           @"http://qiang.suning.com"
    //搜索服务器
    #define kSearchHostAddressForHttp           @"http://search.suning.com/emall/mobile"

    //店铺搜索地址
    #define kShopSearchHost @"http://search.suning.com/shop/phoneSearch.json"

    //分类中电子书出版首页url
    #define kEBookTradEnrtyHttp                 @"http://snbook.suning.com/m/lapp/trad/index.htm"

    //分类中电子书原创首页
    #define kEBookIntactEnrtyHttp               @"http://snbook.suning.com/m/lapp/intact/index.htm"

    //新团购服务器
    #define kHostGroupBuyAddressForHttp         @"http://tuan.suning.com/hoteltuan-web/groupbuy/mobileclient"
    //图片服务器
    #define kImageServerHost                    @"http://image.suning.cn/b2c/catentries"
    //注册图片url
    #define kRegisterPictureUrl                 @"https://aq.suning.com/asc/jcaptcha"
    #define kRegisterForHttps                   @"https://aq.suning.com/asc/servlet"

    //获取商品图片
    #define kGetCommodityImageForHttps                   @"http://image5.suning.cn"

    //价格图片服务器    
    #define kPriceServerHost                    @"http://price1.suning.cn/webapp/wcs/stores/prdprice"
    //web收银台
    #define kEppHostAddress                     @"https://mpay.suning.com"
    #define kEvaluateServerHost                 @"http://zone.suning.com/review/mobile"
    //上一个http的主站url
    #define kEvaluateServerHostJson             @"http://zone.suning.com/review/json"
    //评价晒单图片上传服务器Url
    #define kCommentShareReviewServer           @"http://zone.suning.com/review/"

    //头像服务器10.19.95.100
    #define kCardPhotoHostAddressHost           @"https://imgssl.suning.com/uimg/cmf"

    //头像服务器
    #define kWBCardPhotoHostAddressHost         @"http://image.suning.cn/uimg/cmf/cust_headpic"

    //在线客服
    #define kOnlineServiceServerHost            @"http://monline.suning.com/visitor/chat"

    #define kOnlineServiceServerHostGetMessage  @"http://monline.suning.com/visitor/chat"



    #define kOrderConfirmAcceptWapUrl           @"http://mpay.suning.com/epp-m/showCheckPayPWD.htm?redecitString=suningMobileCheckPassSucess"
    #define kOrderConfirmAcceptWapBackUrl       @"http://mpay.suning.com/epp-m/suningMobileCheckPassSucess"

    //v购-我的预约
    #define KvGouMyYuyueURL @"http://m.suning.com/vgou/private/myVgou.do"

    //我的预约-商品预约
    #define KShangPinYuyueURL @"http://m.suning.com/mts-web/appointment/private/my_appoint_1.html"

    //C店店铺
    #define kCShopHostURL   @"http://m.suning.com/shop"

    //wap
    #define kEbuyWapHostURL     @"http://m.suning.com"

    #define KNewHomeAPIURL      @"http://api.m.suning.com/"

    #define kMFSServer          @"http://mfs.suning.com"

    //猜你喜欢（首页推荐）
    #define kGuessYouLikeURL    @"http://tuijian.suning.com/"

    //缴费城市列表(水电煤城市选择)
    #define kChargeCityListURL  @"http://m.suning.com/mylife/chargeCityList.html"
    #define kChargeModeQueryURl @"http://m.suning.com/mylife/chargeModeQuery.html"

    //会员收藏接口Host
     #define kMemberFavoriteHostURL       @"http://mpre.cnsuning.com/mts-web/favorite/private"
    //会员等级接口Host
    #define kMemberLevelHostURL       @"http://mpre.cnsuning.com/mts-web/favorite/custlv/private"
//门店评价
#define kStoreEvaluationHostURL    @"http://mts.suning.com/comment/private/mobile"


#endif

#pragma mark -
#pragma mark 推送

#ifdef kMobileDevTest
    #define kMobileHostAddress                  @"http://10.21.135.86:8080/mms_1.2"
#elif kMobileSitTest
    #define kMobileHostAddress                  @"http://mbmsgsit.cnsuning.com/mms"
#elif  kMobileReleaseH
    #define kMobileHostAddress                  @"http://mobimsg.suning.com/mms" // @"http://58.213.19.63/mms"
#endif

/* deprecated by liukun
#pragma mark -
#pragma mark 渠道号

#ifdef kDownloadChannelAppStore
    #define kDownloadChannel                        @"app store"
    #define kDownloadChannelNum                     @"20000"
#elif kDownloadChannelSuNing
    #define kDownloadChannel                        @"易购网站"
    #define kDownloadChannelNum                     @"20001"
#elif kDownloadChannelSuningAppStore
    #define kDownloadChannel                        @"Suning App Store"
    #define kDownloadChannelNum                     @"20002"
#elif kDownloadChannel91Helper
    #define kDownloadChannel                        @"http://zs.91.com/"
    #define kDownloadChannelNum                     @"20003"
#elif kDownloadChannelBeijingYiXun
    #define kDownloadChannel                        @"BeiJingYiXun"
    #define kDownloadChannelNum                     @"20004"
#elif kDownloadChannelPaoJiao
    #define kDownloadChannel                        @"PaoJiao"
    #define kDownloadChannelNum                     @"20005"
#elif kDownloadChannelDAYM
    #define kDownloadChannel                        @"suning_daym"
    #define kDownloadChannelNum                     @"20006"
#elif kDownloadChannelPPSYY
    #define kDownloadChannel                        @"suning_bbsyy"
    #define kDownloadChannelNum                     @"20007"
#elif kDownloadChannelSoHu
    #define kDownloadChannel                        @"SoHu"
    #define kDownloadChannelNum                     @"20008"
#elif kDownloadChannelWeiFeng
    #define kDownloadChannel                        @"WeiFeng"
    #define kDownloadChannelNum                     @"20009"
#elif kDownloadChannelTongBuTui
    #define kDownloadChannel                        @"TongBuTui"
    #define kDownloadChannelNum                     @"20010"
#elif kDownloadChannelPPHelper
    #define kDownloadChannel                        @"PPHelper"
    #define kDownloadChannelNum                     @"20011"
#elif kDownloadChannelIPBBS
    #define kDownloadChannel                        @"suning_ipbbs"
    #define kDownloadChannelNum                     @"20012"
#elif kDownloadChannelCanDou
    #define kDownloadChannel                        @"CanDou"
    #define kDownloadChannelNum                     @"20013"
#elif kDownloadChannelTaiPingYang
    #define kDownloadChannel                        @"TaiPingYang"
    #define kDownloadChannelNum                     @"20014"
#endif
*/

#pragma mark -
#pragma mark 新搜索

#define kHttpRequestMobileAssocialWords         @"mobileAssocialWords.jsonp"
#define kHttpRequestMobileHotWords              @"mobileHotWords.jsonp"
#define kHttpRequestMobileNoResSugGoods         @"SNMobileNoResRecom"
#define kHttpRequestMobileSearch                @"SNMobileSearch"
#define kHttpRequestMobileSearchJsonp           @"mobileSearch.jsonp"


#pragma mark -
#pragma mark 信息搜集服务器
#ifdef kPreInfoTest
#define kInfoCollectAddressForHttp				@"http://clickpre.suning.cn/sa"
#define kInfoCollectAddressForHttps             @"https://clickpre.suning.cn/sa"
#elif kSitInfoTest
#define kInfoCollectAddressForHttp              @"http://clicksit.suning.cn/sa"
#define kInfoCollectAddressForHttps             @"https://clicksit.suning.cn/sa"
#elif kReleaseInfoH
#define kInfoCollectAddressForHttp				@"http://click.suning.cn/sa"
#define kInfoCollectAddressForHttps             @"https://click.suning.cn/sa"
#else
#define kInfoCollectAddressForHttp              @"http://10.21.160.41:9000/da-sa-war"
#define kInfoCollectAddressForHttps             @"https://10.21.160.41:9000/da-sa-war"
#endif

#pragma mark -
#pragma mark Sweepstack Info URL
#define kSweepstakesInfoHTMLURL     @"http://sale.suning.com/images/advertise/hg/20130130qianggouyemian/index.html"

#define kSweepstakesInfoImageURL  @"http://sale.suning.com/images/advertise/hg/20130130choujianggaidong/640_3.jpg"


#pragma mark -
#pragma mark HTTPS服务器域名

#pragma mark -
#pragma mark 默认http访问超时时间
#define kHttpTimeoutSeconds						15

#pragma mark -
#pragma mark 资源缓存路径
#define	kCachePath								@"resource"

#pragma mark -
#pragma mark 偏好设置文件
#define kPreferenceSetting						@"PreferenceSetting.plist"

#pragma mark -
#pragma mark 系统信息收集
#define kClientUseInfo                          @"phone.gif"
#define kUserRegisterInfo                       @"phoneRegister.gif"
#define kUserOrderNumInfo                       @"phoneOrder.gif"

#pragma mark -
#pragma mark 首页http请求
#define kHttpRequestHomeFirstViewNew            @"SNMobileAllThirdContentView"

#define kHttpRequestHomeFirstView				@"SNmobileTopMenu"
#define kHttpRequestHomeSecondView				@"SNmobileSecMenuView"
#define kHttpRequestHomeThirdView				@"SNmobileThirdMenuView"
//八联版广告接口
#define kHttpRequestAdvertiseEightView          @"SNiPhoneAdvertiseEightView"
//八联版广告内页内容接口
#define kHttpRequestAdInnerContentView          @"SNiPhoneAdInnerContentView"

#define	kHttpRequestHomeStoreKey				@"storeId"
#define	kHttpRequestHomeStoreValue				@"10052"
#define	kHttpRequestHomeCatalogIdsKey			@"catalogIds"
#define	kHttpRequestHomeCatalogIdsValue			@"22001-10051"
#define kHttpRequestHomeCategoryCode			@"categoryCode"
#define kHttpRequestHomeCatalogIdKey            @"catalogId"
#define	kHttpRequestHomeCatalogIdValue			@"10051"
#define kHttpRequestBookCatalogIdValue          @"22001"



#pragma mark -
#pragma mark 手机充值
#pragma mark根据手机号码获取省份和运营商
#define kIspTypeAndProviceForNumber             @"SNMTMobileQueryNuminfo"
#define kIspTypeAndProviceKey                   @"storeId"
#define kIspTypeAndProviceValue                 @"10052"
#define kMobileNumberKey                        @"mobileNum"

#define  kPartnerKey           @"partner"
#define kPartnerValue                             @"SN_IPHONE"


#pragma mark 查询优惠金额
#define kCheckPreferentialPrice                 @"SNMTMobileQueryPrice"
#define kfillMoneyKey                           @"fillmoney"


#pragma mark 话费充值
#define kPayMobileOrder                        @"SNiPhoneFillPayOrderView"

#pragma mark -
#pragma mark 电话充值查询
#define kHttpRequestMobilePayQueryViewKey        @"SNiPhoneFillQueryAllOrderView"

#pragma mark - 会员接口

#define kGetProductsFavoriteList         @"getProductsFavoriteList.do"//查询商品收藏列表
#define kCancelProductsFavorite          @"cancelProductFavoriteBatch.do"//取消商品收藏
#define kMemberLevel                     @"getCustLevel.do"//会员等级


#pragma mark -
#pragma mark 首页 Top 推荐信息

#define	kResponseErrorCodeValueUserIdError		@"2001"
#define	kResponseErrorCodeValueFirstLogin		@"2002"
#define	kResponseErrorCodeValueFirstLogin1		@"2003"
#define	kResponseErrorCodeValuePasswordError	@"2010"
#define	kResponseErrorCodeValuePasswordError1	@"2030"
#define	kResponseErrorCodeValuePasswordError2	@"9050"
#define	kResponseErrorCodeValuePasswordError3	@"2031"
#define	kResponseErrorCodeValuePasswordError4	@"2300"
#define	kResponseErrorCodeValuePasswordError5	@"2031"
#define	kResponseErrorCodeValuePasswordError6	@"9050"
#define	kResponseErrorCodeValuePasswordError7	@"9010"
#define	kResponseErrorCodeValuePasswordError8	@"1001"
#define	kResponseErrorCodeValuePasswordError9	@"1005"
#define kResponseErrorCodeValueError10          @"5350"


#define	kResponseErrorCodeValuePasswordNotOk	@"2200"

#pragma mark -
#pragma mark 手机验证
#define	kResponseErrorCodeMobilePasswordError	@"5311"
#define	kResponseErrorCodeMobilePasswordError1	@"53304"
#define	kResponseErrorCodeMobilePasswordError0	@"53303"
#define	kResponseErrorCodeMobilePasswordError2	@"5320"
#define	kResponseErrorCodeMobilePasswordError3	@"53274"
#define	kResponseErrorCodeMobilePasswordError4	@"5311"


#pragma mark -
#pragma mark 首页八联版


#pragma mark -
#pragma mark 首页八联版内页信息
#define kHttpRequestInnerAdIdkey                @"adId" 
#define kHttpRequestInnerCityIdkey              @"cityId"
#define kHttpRequestInnerAdView                 @"SNiPhoneAdInnerContentView"



#pragma mark -
#pragma mark 首页 Top 推荐信息

#define kHttpRequestHomeTopCityId               @"cityID"
#define kHttpRequestHomeTopZoneId               @"zoneid"


#define kResponseHomeTopErrorCode				@"errorCode"
#define kResponseHomeTopRecommendResource		@"hotZone"
#define kHttpResponseHomeTopProductCode			@"partnumber"
#define kHttpResponseHomeTopProductId			@"catentryId"
#define kHttpResponseHomeTopProductName			@"catenname"
#define kHttpResponseRecommendAdverId           @"adverId"
#define kHttpResponseHomeTopProductPrice        @"netPrice"
#define khttpresponseHomeTopPorductDesc         @"catentry_desc"
#pragma mark -
#pragma mark 首页 一级分类 推荐信息

//新分类接口字段 一级
#define NewCategoryTest                         1

#define kHttpRequestHomePartNameKey             @"partName"
#define kHttpRequestHomePartNameValue           @"客户端目录-电器"

#define kResponseHomeFirstCategoryRecource		@"firstCategoryList"
#define kHttpResponseHomeFirstCategoryCode		@"categoryCode"
#define kHttpResponseHomeFirstCategoryName		@"categoryName"
#define kHttpResponseHomeFirstCategoryId		@"categoryId"
#define kHttpResponseHomeFirstCategoryDes		@"categoryDes"
#define kHttpResponseHomeFirstCategoryURL		@"categoryURL"
#define kHttpResponseHomeFirstCatelogIds		@"catalogIds"
#define kHttpResponseHomeFirstCategorySecList   @"secondCategoryList"

#pragma mark -
#pragma mark 2.33分类
#define kResponseCategoryRecource		        @"shopKindInfo"

#define kHttpResponseCategoryKindId 	        @"kindId"
#define kHttpResponseCategoryParentId 	        @"parentId"
#define kHttpResponseCategoryKindName 	        @"kindName"
#define kHttpResponseCategoryKindDesc	        @"kindDesc"
#define kHttpResponseCategoryPictureUrl	        @"pictureUrl"
#define kHttpResponseCategoryChaKind	        @"chaKind"
#define kHttpResponseCategoryRelation	        @"usingRel"
#define kHttpResponseCategoryCi		            @"ci"
#define kHttpResponseCategoryCf		            @"cf"
#define kHttpResponseCategorySecList	        @"kindList2"
#define kHttpResponseCategoryThirdList	        @"kindList3"

#pragma mark -
#pragma mark 首页 二级分类 推荐品牌
#define kResponseHomeSecondBannerRecource		@"recommendBrand"
#define kHttpResponseHomeSecondBannerCode		@"brandCode"
#define kHttpResponseHomeSecondBannerName		@"brandName"
#define kHttpResponseHomeSecondBannerImageURL	@"brandImageURL"

#pragma mark -
#pragma mark 首页 二级分类 分类信息
#define kResponseHomeSecondCategoryRecource		@"secondCategory"

#if NewCategoryTest

#define kHttpResponseHomeSecondCategoryId		@"categoryId"
#define kHttpResponseHomeSecondCategoryName		@"categoryName"
#define kHttpResponseHomeSecondCategoryCi		@"categoryCi"
#define kHttpResponseHomeSecondCategoryCf		@"categoryCf"
#define kHttpResponseHomeSecondCategoryURL		@"picture"
#define kHttpResponseHomeSecondCatelogIds		@"catalogIds"


#define kHttpResponseHomeSecondCategoryCode		@"categoryCode"
#else

#define kHttpResponseHomeSecondCategoryCode		@"categoryCode"
#define kHttpResponseHomeSecondCategoryName		@"categoryName"

#endif


#pragma mark -
#pragma mark 首页 三级级分类 分类信息
#define kResponseHomeThirdCategoryRecource		@"categoryList"
#define kHttpResponseHomeThirdCategoryCode		@"categoryCode"
#define kHttpResponseHomeThirdCategoryName		@"categoryName"


#pragma mark -
#pragma mark 登录http请求
#define kHttpRequestUserLogin					@"SNiPhoneAppLogon"
#define kRequestLoginUserId						@"logonId"
#define kRequestLoginPassword					@"logonPassword"

//passport登录


//首次登录
#define kRequestFirstLoginCardCode				@"cardCode"
#define kRequestFirstLoginPassword				@"password"
#define kReponseFirstLoginMobile				@"mobile"
#define kRequestFirstLoginPasswordVerify		@"passwordVerify"
#define kRequestFirstLoginActiveCode			@"activeCode"

//用户注册
#define kHttpRequestRegisterHome				@"SNiPhoneAppUserRegister"
#define kRequestRegisterId						@"registerId"				//邮箱或手机
#define kRequestRegisterPassword				@"registerPassword"			//密码
#define kReponseRegisterPasswordVerify			@"registerPasswordVerify"	//密码确认
#define kRequestRegisterType					@"registerType"				//注册类型，1：手机注册 2：其他

//忘记密码
#define kHttpRequestForgetPassword              @"SNmobileForgetPassword"
#define kHttpRequestResetPassword               @"SNmobileResetPassword"
#define kRequestMobileFlag                      @"mobileFlag"


//用户注销
#define kHttpRequestLogoutHome					@"SNiPhoneAppLogoff"

//用户修改
#pragma mark -
#pragma mark 用户修改
#define kHttpRequestEditUserInfoHome			@"SNiPhoneAppUserUpdateCmd"

#define kRequestEditUserInfoFirstName			@"firstName"			//姓名
#define kRequestEditUserInfoGender				@"gender"				//性别 M:男；F:女
#define kReponseEditUserInfoBirthday			@"demographicField6"	//生日 YYYYMMDD
#define kReponseEditUserInfoPhone1				@"phone1"				//电话 手机号码

#pragma mark -
#pragma mark 用户信息
#define kHttpResponseUserId						@"userId"

#define kHttpResponseUserLevel					@"userLevel"
#define kHttpResponseLoginName					@"name"
#define kHttpResponseLoginNickName				@"nickName"
#define kHttpResponseLoginSex					@"sex"
#define kHttpResponseLoginBirthDate				@"birthDate"
#define kHttpResponseLoginPhone					@"phoneNo"
#define kHttpResponseLoginMemberCard			@"memberCardNo"
#define kHttpResponseLoginYifubao				@"yifubaoBalance"
#define kHttpResponseLoginAddress				@"address"
#define kHttpResponseHasOrderByAfterPay			@"lockFlag"
#define kHttpResponseLoginEppStatus             @"eppStatus"
#define kHttpResponseLogincustLevelCN           @"custLevelCN"
#define kHttpResponseLoginIsBindMobile          @"isBindMobile"
#define kHttpResponseLoginEmailStatus           @"emailStatus"

#define kHttpResponseLoginSnTeck                @"snTeck"
#define khttpResponseLoginAccountNo             @"accountNo"
#define khttpResponseLoginInternalNum           @"internalNum"


#pragma mark-
#pragma mark dm单信息

#define kHttpResponseDMUrl                     @"dmPictureUrl"
#define kHttpResponseAdId                      @"adId"
#define kHttpResponseRule                      @"activityRule"
#define kHttpResponseTitle                     @"activityTitle"
#define kHttpResponseActivityUrl               @"activityPictureUrl"
#define kHttpResponseTypeCode                  @"adTypeCode"

#pragma mark-
#pragma mark 地址信息
#define kHttpRequestAddressInfoListHome			@"SNiPhoneAppAddressView"
/*
 地址编码，省编码，市编码，区编码，镇编码，地址内容，收件人，联系电话
 */
#define kHttpResponseAddressNo					@"addressNo"
#define kHttpResponseAddressProvince			@"province"
#define kHttpResponseAddressCity				@"city"
#define kHttpResponseAddressDistrict			@"district"
#define kHttpResponseAddressTown				@"town"
#define kHttpResponseAddressAddressContent		@"addressContent"
#define kHttpResponseAddressRecipient			@"recipient"
#define kHttpResponseAddressTel					@"tel"

//新增地址
#define kHttpRequestAddAddressInfoHome			@"SNiPhoneAppAddressAdd"

#define kHttpRequestAddAdressMemberId			@"memberId"			//即userId，用户在数据库中的唯一标识
#define kHttpRequestAddAdressProvince			@"state"			//省编码
#define kHttpRequestAddAdressCity				@"city"				//市编码
#define kHttpRequestAddAdressDistrict			@"addressField1"	//区编码
#define kHttpRequestAddAdressTown				@"addressField2"	//镇编码
#define kHttpRequestAddAdressAddressContent		@"address1"			//地址内容
#define kHttpRequestAddAdressRecipient			@"firstName"		//收件人
#define kHttpRequestAddAdressTel				@"phone1"			//联系电话
#define kHttpRequestAddAdressPreferFlag         @"preferFlag"       //是否是默认地址

//地址修改
#define kHttpRequestEditAddressInfoHome			@"SNiPhoneAppAddressUpdate"

#define kHttpRequestAddAdressId					@"addressId"		//地址编号

#pragma mark -
#pragma mark 我的易购 
#define	kHttpRequestMemberOrderCenterAmount		@"SNiPhoneAppOrderStatusView"
#define	kHttpRequestMemberSelectTime			@"selectTime"
#define	kHttpRequestMemberSelectTimeValue		@"all"
#define	kResponseMemberOrders					@"orders"
#define	kResponseMemberOrderType				@"orderType"
#define	kResponseMemberOrderNum					@"orderNum"
#define	kHttpRequestMemberStatus				@"status"
#define	kHttpRequestMemberPage					@"page"

#define	kResponseMemberResultSetSize			@"resultSetSize"
#define	kResponseMemberPageNumber				@"pageNumber"
#define	kResponseMemberOrdersData				@"ordersData"

#define	kHttpRequestMemberOrderSpecific			@"SNIphoneNewMyOrderDisplayView"
#define	kResponseMemberOrderId					@"orderId"
#define	kResponseMemberPrepayAmount				@"prepayAmount"
#define	kResponseMemberLastUpdate				@"lastUpdate"
#define	kResponseMemberOiStatus					@"oiStatus"
#define	kResponseMemberPolicyDesc				@"policyDesc"
#define	kResponseMemberMerchantOrder			@"merchantOrder"
#define	kResponseMemberOrdersDisplay			@"ordersDisplay"
#define	kResponseMemberQuantityInIntValue		@"quantityInIntValue"
#define	kResponseMemberTotalProduct				@"totalProduct"
#define	kResponseMemberPosOrderNumber			@"posOrderNumber"
#define	kResponseMemberVerificationCode			@"verificationCode"
#define	kResponseMemberCurrentShipModeType		@"currentShipModeType"
#define	kResponseMemberTaxType					@"taxType"
#define	kResponseMemberItemPlacerName			@"itemPlacerName"
#define	kResponseMemberItemMobilePhone			@"itemMobilePhone"
#define	kResponseMemberAddress					@"address"
#define	kResponseMemberInvoice					@"invoice"
#define	kResponseMemberInvoiceDescription		@"invoiceDescription"
#define kResponseMemberInvoiceCode              @"invoiceCode"
#define kResponseMemberInvoiceNumber            @"invoiceNumber"
#define kResponseMemberInvoicePrintPwd          @"printPwd"
#define	kResponseMemberWarrantyQuantity			@"exWarrantyQuantity"
#define	kResponseMemberWarrantyName				@"exWarrantyName"
#define	kResponseMemberWarrantyPrice			@"exWarrantyPrice"
#define	kResponseMemberWarrantyFlag				@"exWarrantyFlag"
#define	kResponseMemberOrderRemark				@"orderRemark"

#define	kHttpRequestMemberOrderCancel			@"SNiPhoneAppOrderCancel"


#define kHttpRequestMemberMyFavorite            @"SNiPhoneAppInterestListView"
#define kHttpRequestMemberClearMyFavorite       @"SNiPhoneAppInterestClear"

#define	kHttpRequestMemberCatEntryIdKey			@"catEntryId"
#define	kHttpRequestMemberCatEntryIdValue		@"*"
#define kHttpRequestMemberCurrentPageKey        @"page"
#define kResponseMemberMyFavoriteList           @"myFavoriteList"
#define kResponseMemberEasyPaymentBalance       @"balance"
#define kResponseMemberProdectCode              @"productCode"
#define kResponseMemberProdectName              @"productName"
#define kResponseMemberProdectId                @"productId"
#define kResponseMemberCollectTime              @"addTime"
#define kResponseMemberNumberOfPages            @"numberOfPages"

#pragma mark -
#pragma mark 购物车
#define kHttpRequestAddToShoppingcart			@"addToShoppingCart.do"
#define kHttpResponseShoppingCartProductCode	@"productCode"
#define kHttpResponseShoppingCartProductId		@"productId"
#define kHttpResponseShoppingCartCityCode		@"cityCode"

#define kHttpRequestShoppingcartToPay				@"SNiPhoneAppOrderItemAdd"
#define kHttpResponseShoppingCartToPayLangId		@"langId"
#define kHttpResponseShoppingCartToPayOrderInfo		@"orderInfo"
#define kHttpResponseShoppingCartToPayItems			@"items"
#define kHttpResponseShoppingCartToPayProductCode 	@"productCode"
#define kHttpResponseShoppingCartToPayProductId 	@"productId"
#define kHttpResponseShoppingCartToPayCityCode		@"cityCode"
#define kHttpResponseShoppingCartToPayBuyPackSort			@"buyPackSort"
#define kHttpResponseShoppingCartToPayBuyPackPartNumber 	@"buyPackPartNumber"
#define kHttpResponseShoppingCartToPayAddressId				@"addressId"
#define kHttpResponseShoppingCartToPayInvoice				@"invoice"
#define kHttpRequestShoppingcartAddressDelete			    @"SNiPhoneAppAddressDelete"


#define kHttpRequestShoppingcartPay					@"SNiPhoneAppOrderProcess"
#define kHttpResponseShoppingCartPayLangId			@"langId"
#define kHttpResponseShoppingCartPayOrderInfo		@"orderId"
#define kHttpResponseShoppingCartPayPolicyId		@"policyId"
#define kHttpResponseShoppingCartPaySubpolicyid 	@"subpolicyid"
#define kHttpResponseShoppingCartPaySubCodpolicyId	@"subCodpolicyId"
#define kHttpResponseShoppingCartPayPrepay			@"prepay"
#define kHttpResponseShoppingCartPayIsPrepay		@"isPrepay"
#define kHttpResponseShoppingCartPayOrderPlacerTel 	@"orderPlacerTel"
#define kHttpResponseShoppingCartPayPassword        @"eppPayPwd"
#define kHttpResponseShoppingCartPayLangValue       @"-7"


#pragma mark -
#pragma mark 搜索
//#define kHttpRequestSearchProduct				@"SNMobileSearchCmd"	for 101
#define kHttpRequestSearchProduct				@"SNIPhoneSearchView"

#pragma mark -
#pragma mark 商品详情
#define kHttpRequestProductDetail				@"SNiPhoneAppShopProductDisplay"

#pragma mark -
#pragma mark 收藏夹
#define kHttpRequestFavorite				    @"SNiPhoneAppInterestItemAdd"


#pragma mark -
#pragma mark 搜索参数
#define kHttpRequestSearchKeyword				@"keyword"
#define kHttpRequestSearchPage					@"searchPage"
#define kHttpRequestSearchCityCode				@"cityId"
#define kHttpRequestSearchLowPrice				@"lowPrice"
#define kHttpRequestSearchHighPrice				@"highPrice"
#define kHttpRequestSearchSort					@"sort" 
#define kHttpRequestSearchCategoryCode			@"catgroupId"
#define kHttpRequestSearchSecFlag				@"secFlag"
#define kHttpRequestSearchSpecial				@"auxDescription"

#pragma mark -
#pragma mark 搜索返回
#define kHttpResponseSearchTotalPage			@"totalPage"
#define kHttpResponseSearchSearchList			@"searchList"
#define kHttpResponseSearchSuccess				@"1"

#pragma mark -
#pragma mark 搜索品类
#define kSearchCategoryEmpty					@"全部品类"

#pragma mark -
#pragma mark 搜索请求路径
#define kHttpRequestSearchFirstCategory			@"SNiphoneAppFirstCategoryList"
#define kHttpRequestSearchNextCategory		    @"SNiphoneAppLevel2CategoryView"

#pragma mark -
#pragma mark 商品详情参数
#define kHttpResponseErrorCode                  @"errorCode"
#define kHttpResponseImageNum                   @"imageNum"
#define kHttpResponseProductName                @"productName"
#define kHttpResponseProductCode                @"productCode"
#define kHttpResponseProductId					@"productId"
#define kHttpResponseCityCode					@"cityCode"
#define kHttpResponseSectionCode                   @"xsection"
#define kHttpResponseHasStorage					@"hasStorage"
#define kHttpResponseCanTake					@"canTake"
#define kHttpResponseIsOldToNew					@"isOldToNew"
#define kHttpResponseHasAnnex                   @"hasAnnex"
#define kHttpResponseMarketPrice				@"marketPrice"
#define kHttpResponseSuningPrice				@"suningPrice"
#define kHttpResponsePromotionPrice             @"promotionPrice"
#define kHttpResponseItemPrice                  @"itemPrice"
#define kHttpResponseProductFeature				@"productFeature"
#define kHttpResponsePackageList				@"packageList"
#define kHttpResponseRelatedProductList			@"relatedProductList"
#define kHttpResponseEvaluation					@"evaluation"
#define kHttpResponseListPrice					@"price"
#define kHttpResponseIsProducerSent				@"canCashOnDelivery"
#define kHttpResponseShipOffSet					@"shipOffset"
#define kHttpResponseShipOffSetText             @"shipOffSetText"
#define kHttpResponseIsABook                    @"isABook" 

//#define kHttpRequestProductParameter            @"getProductParameter.do"
#define kHttpRequestProductParameter            @"SNiPhoneNewProductAttributeView"
#define kHttpResponseParameters                 @"parameters"
#define kHttpResponseParameterName              @"parameterName"
#define kHttpResponseParameterContents          @"parameterContents"

//#define kHttpResponseServiceDo                  @"productService.do"
#define kHttpResponseService					@"services"
#define kHttpResponseServiceName                @"serviceName"
#define kHttpResponseServicePrice               @"servicePrice"
#define kHttpResponseServiceCode                @"serviceCode"
#define kHttpResponseServiceId                  @"serviceId"

//#define kHttpResponseIntroduceHtml              @"productIntroduce.do"
#define kHttpResponseIntroduceHtml              @"SNiPhoneAppProductDescView"

#define KHttpResponseSendPage                   @"pageNum"
#define kHttpResponseConsultTPage               @"totlePage"
#define kHttpResponseConsultRCPage				@"resultCurrentPage"
#define kHttpResponseConsultRNumber				@"resultNumber"

//#define kHttpResponseConsultDo                  @"productCons.do"
#define kHttpResponseConsultDo                  @"SNiPhoneAppProductConsView"
#define kHttpResponseConsultConsultant			@"consultant"
#define kHttpResponseConsultConsultantContent	@"consultantContent"
#define kHttpResponseConsultConsultantReply		@"consultantReply"
#define kHttpResponseConsultConsultantTime		@"consultantTime"

#define kHttpResponseConsultSearchList          @"searchList"

//#define kHttpResponseEvaluationDo               @"productEval.do"
#define kHttpResponseEvaluationDo               @"SNiPhoneAppProductEvalView"
#define kHttpResponseEvaluationPerson			@"evaluationPerson"
#define kHttpResponseEvaluationTime				@"evaluationTime"
#define kHttpResponseEvaluationTitle			@"evaluationTitle"
#define kHttpResponseEvaluationContents			@"evaluationContents"
#define kHttpResponseEvaluationStars			@"stars"

#pragma mark -
#pragma mark 门店信息
#define kHttpRequestShopInfo					@"SNiPhoneAppGetShopsView"

#pragma mark-
#pragma mark 新物流查询
#define kHttpRequestLogistics                   @"SNiPhoneAppOrderListView"
#define kHttpLogisticsSelectTime                @"selectTime"
#define kHttpLogisticeStatus                    @"status"
#define kHttpLogisticePage                      @"page"
#define kHttpLogisticePageSize                  @"pageSize"

#pragma mark-
#pragma mark 服务查询
#define KHttpRequestURL                         @"SNIPhoneDistributionServiceListView"
#define KHttpRequestSearchCriteria              @"searchCriteria"
#define KHttpRequestSearchKeyWord               @"searchKeyWord"
#define KHttpRequestSearchKeyWord1              @"searchKeyWord1"
#define KHttpRequestSearchKeyWord2              @"searchKeyWord2"
#define KHttpRequestProductId                   @"productId"
#define KHttpRequestProductName                 @"productName"
#define KHttpRequestMemberCardNo                @"memberCardNo"
#define KHttpRequestSalNum                      @"salNum"
#define KHttpRequestDistributionMode            @"distributionMode"
#define KHttpRequestQuantity                    @"quantity"
#define KHttpRequestSaleTime                    @"saleTime"


#pragma mark -
#pragma mark 服务详情
#define KHttpRequestDetailURL                   @"SNIPhoneDistributionServiceDetailInfoView"
#define KHttpRequestOrderItemId                 @"orderItemId"
#define KHttpRequestOrderId                     @"orderId"
#define KHttpRequestSaleNum                     @"saleNum"
#define KHttpRequestDeliveryDate                @"deliveryDate"
#define KHttpRequestDeliverQuantity             @"deliveryQuantity"
#define KHttpRequestDeliveryAddress             @"deliveryAddress"
#define KHttpRequestChangeReturnDoc             @"changeReturnDoc"
#define KHttpRequestItemDate                    @"itemDate"
#define KHttpRequestItemText                    @"itemText"
#define KHttpRequestItemTime                    @"itemTime"
#define KHttpRequestServiceTime                 @"serviceTime"
#define KHttpRequestServiceStatus               @"serviceStatus"
#define KHttpRequestServiceOrderName            @"serviceOrderName"
#define KHttpRequestWorkerTel                   @"workerTel"
#define KHttpRequestWorkerName                  @"workerName"
#define KHttpRequestServiceDate                 @"serviceDate" //add by 谢伟
#define KHttpRequestCommentOrNot                @"commentOrNot"
#define KHttpRequestShowOrNot                   @"showOrNot"
#define KHttpRequestSimOrPhoneFlag              @"simOrPhoneFlag"
#define KHttpRequestPartName                    @"partName"
#define KHttpRequestPhoneNum                    @"phoneNum"
#define KHttpRequestMonthlyAmt                  @"monthlyAmt"
#define KHttpRequestPlanTypeName                @"planTypeName"
#define KHttpRequestSignDuration                @"signDuration"
#define KHttpRequestSimPicPath                @"simPicPath"


#pragma mark -
#pragma mark 维修详情
#define KHttpRequestServiceNum                  @"serviceNum"
#define KHttpRequestOrderType                   @"orderType"
#define KHttpRequestExpectedServiceTime         @"expectedServiceTime"
#define KHttpRequestEngineerName                @"engineerName"
#define KHttpRequestEngineerPhoneNum            @"engineerPhoneNum"

#pragma mark -
#pragma mark 预约管理
#define kHttpRequestBookingProcessFlagValue     @"PBK"
#define kHttpRequestBookingProcessFlagKey       @"processFlag"
#define kHttpRequestBookingServiceRequireKey    @"serviceRequire"


#pragma mark -
#pragma mark 地区
#define kHttpRequestGetAreaRequireKey           @"SNiPhoneAppGetAreaByFeeTypeView"
#define KHttpRequestTypeCode                    @"typeCode"


#pragma mark -
#pragma mark 地区公司
#define kHttpRequestGetCompanyByAreaRequireKey  @"SNiPhoneAppGetCompanyByAreaView"
#define KHttpRequestAreaCode                    @"areaCode"

#pragma mark -
#pragma mark 缴费模式
#define kHttpRequestGetCompanyModeRequireKey     @"SNiPhoneAppGetFeeModeView"
#define KHttpRequestcompanyId                    @"companyId"
#define kHttpRequestcompanyCode                  @"companyCode"

#pragma mark -
#pragma mark 帐号信息
#define kHttpRequestGetAccountInfoRequireKey     @"SNiPhoneAppGetAccountInfoView"

#pragma mark -
#pragma mark 申请支付
#define kHttpRequestPayMentApplyRequireKey       @"SNiPhoneAppFeePaymentApplyView"

#pragma mark -
#pragma mark 缴费查询
#define kHttpRequestFeePaymentQueryViewKey       @"SNiPhoneAppFeePaymentQueryView"

#pragma mark -
#pragma mark 获取版本
#define kHttpRequestGetClientVersionRequireKey   @"SNMobileGetClientVersionView"
#define kHttpRequestClentVersionKey              @"clientName"
#define kClientVersion                           @"clientVersion"
#define kUpdateTips                              @"updateMessage"
#define kItunesAppLink                           @"http://itunes.apple.com/cn/app/id424598114?l=en&mt=8"

#pragma mark -
#pragma mark 用户新增评价与咨询
#define kHttpRequestGetPublishArticleKey         @"SNiPhonePublishArticle"
#define kHttpRequestProductCodeKey               @"productCode"
#define kHttpRequestScoreKey                     @"score"
#define kHttpRequestModelTypeKey                 @"modelType"
#define kHttpRequestAuthorNickNameKey            @"authorNickName"
#define kHttpRequestCurrCityKey                  @"currCity"
#define kHttpRequestTitleKey                     @"title"
#define kHttpRequestContentKey                   @"content"

#pragma mark -
#pragma mark 用户评价与咨询列表
#define kHttpRequestBookAppraiseConsultKey       @"SNiPhoneBookAppraiseConsultView"

#pragma mark - 
#pragma mark 抢购
#define kHttpResponseBuyingImageURL              @"imageURL"
#define kHttpResponseBuyingTime                  @"time" 
#define kHttpResponseBuyingProductTitle          @"productTitle"
#define kHttpResponseBuyingProductDescription    @"productDescription"
#define kHttpResponseBuyingPrice                 @"price"
//#define kHttpResponseBuyingDiscount              @"discount"
#define kHttpResponseBuyType                     @"buyType"


#pragma mark -
#pragma mark 用户行为分析数据收集
//系统字段
#define kHttpRequestAppVersion          @"app_version"
#define kHttpRequestSysKind             @"sys_kind"
#define kHttpRequestOsVersion           @"os_version"
#define kHttpRequestPlatform            @"platform"
#define kHttpRequestUserIP              @"user_ip"
#define kHttpRequestUniqueId            @"unique_id"
#define kHttpRequestSessionId           @"session_id"
#define kHttpRequestAppDownWay          @"app_down_way"
#define kHttpRequestIsLogin             @"is_login"
#define kHttpRequestLoginName           @"login_name"
#define kHttpRequestField1              @"field1"
#define kHttpRequestField2              @"field2"
//应用字段
#define kHttpRequestAppStartTime                @"app_start_time"
#define kHttpRequestAppStopTime                 @"app_stop_time"
#define kHttpRequestRegisterName                @"register_name"
#define kHttpRequestOrderNum                    @"order_num"
#define kHttpRequestSearchKey                   @"search_key"
#define kHttpRequestSearchResult                @"search_result"
#define kHttpRequestPageKey                     @"page_key"
#define kHttpRequestPageName                    @"page_name"
#define kHttpRequestPageInTime                  @"page_in_time"
#define kHttpRequestPageOutTime                 @"page_out_time"
#define kHttpRequestCrashInfo                   @"crash_info"


#pragma mark - 
#pragma mark 抢购
#define  kHttpRequestHomeBuyingView				@"SNiPhoneQuickBuyViewNew"
#define  kHttpResponseHomeBuyingList            @"quickBuy"
#define  kHttpResponseBuyingID                  @"xgrppu_id"
#define  kHttpResponseBuyingProductID           @"catentry_id"
#define  kHttpResponseBuyingCurrentTime         @"currenttime"
#define  kHttpResponseBuyingStartTime           @"starttime"
#define  kHttpResponseBuyingEndTime             @"endtime"
#define  kHttpResponseBuyingPrice               @"price"
#define  kHttpResponseBuyingDiscount            @"netPrice"
#define  kHttpResponseBuyingProductName         @"catenname"
#define  kHttpResponseBuyingPartNumber          @"partnumber"
#define  kHttpResponseBuyingLimitCount          @"limit_count" 
#define  kHttpResponseBuyingSubCount            @"subCount"
#define  kHttpResponseBuyingDescription         @"catentry_desc"
//#define  kHttpResponseBuyingActivityType @""



//-----------------分类数据库表信息-----------------------
//一级二级三级分类表明细
#define kDataBaseCategoryLevel1TableNameV2   @"dic_cate1_v2"
#define kDataBaseCategoryLevel1TableName   @"dic_cate1"
#define kDataBaseCategoryLevel2TableName   @"dic_cate2"
#define kDataBaseCategoryLevel3TableName   @"dic_cate3_new"
#define kdataBaseCategoryBrandTableName    @"dic_brand"

#define kDataBaseFirstCategoryCode         @"fircode"
#define kDataBaseSecondCategoryCode        @"seccode"
#define kDataBaseThirdCategoryCode         @"thircode"
#define kDataBaseBrandCategoryCode         @"brandcode"

#define kDataBaseFirstCategoryName          @"firname"
#define kDataBaseSecondCategoryName         @"secname"
#define kDataBaseThirdCategoryName          @"thirname"
#define kDataBaseBrandCategoryName          @"brandname"


#define kDataBaseFirstCategoryImageURL      @"firimageurl"
#define kDataBaseSecondCategoryImageURL     @"secimageurl"
#define kDataBaseThirdCategoryImageURL      @"thirimageurl"
#define kDataBaseBrandCategoryImageURL      @"brandimageurl"


#define kDataBaseFirstCategoryDes          @"firdes"

#define kDataBaseFirstCategoryId          @"firid"

#define kDataBaseFirstCatelogids          @"firlogids"


#define kDataBaseCategoryID                 @"cate_id"
//----------------我的易付宝发送手机验证码短信数据库表
#define kDataBaseSendCountTableName         @"dic_sendCount"



//-----------------图书参数列表-----------------------
//图书参数列表

#pragma mark -
#pragma mark 图书参数列表
#define kHttpResponseParameterName             @"parameterName"
#define kHttpResponseParameterContents         @"parameterContents"
#define kHttpResponseBookPublishView           @"SNiPhoneBookPublishView"
#define kHttpResponseBookInfoView              @"SNiPhoneBookProductInfoView"

#pragma mark -
#pragma mark 苏宁资讯
#define kHttpRequestPromotionInfoView              @"SNMobilePromotionInfoView"

//-----------------晒单功能列表-----------------------
//晒单功能

#pragma mark -
#define  KHttpRequestDisOrderIntefaceName      @"queryURPhotosByCatentryId.action"
#define kHttpfindURPhotoById                    @"findURPhotoById.action"
#define kZhishiErrCode   @"errCode"
//晒单id，作者id，回复类型，标题，发布时间，晒单正文，是否管理员回，作者昵称
#define kHttpArticleId                              @"articleId"
#define kHttpAuthorId                               @"authorId"
#define kHttpAnswerType                             @"answerType"
#define kHttpTitle                                  @"title"
#define kHttpCreateTime                             @"createTime"
#define kHttpContent                                @"content"
#define kHttpQaType                                 @"qaType"
#define kHttpNickName                               @"nickName"

#define  KHttpResponseDisOrderNickName         @"nickName"
#define  KHttpResponseDisOrderContents         @"title"
#define  KHttpResponseDisOrderCreateTime       @"createTime"
#define  KHttpRequestDisOrderCatEntryId        @"catEntryId"
#define  KHttpRequestDisOrderCurrentPage       @"currentPage"
#define  KHttpRequestDisOrderVerifyCode        @"verifyCode"	


//机票的接口
#define KPlaneTicketFlightInfo          @"flightInfo.htm" //查询航班信息
#define KPlaneTicketModifyTraveller     @"modifyTraveller.htm"//新增和修改登机人
#define KPlaneTicketViewTraveller       @"viewTraveller.htm"//获取登机人列表
#define KPlaneTicketDeleteTraveller     @"deleteTraveller.htm"//删除登机人
#define KPlaneTicketSubmitOrder         @"submitOrder.htm"//提交订单
#define KPlaneTicketPayByHftx           @"payByHftx.htm"//汇付支付
#define KPlaneTicketPayByEpp            @"payByEpp.htm"//易付宝支付
#define KPlaneTicketPayOnBank           @"payByMobileBank.htm"//银联支付
#define KPlaneTicketSubmitOrder         @"submitOrder.htm"//提交订单
#define KPlaneTicketOrderList           @"orderList.htm"//订单列表
#define KPlaneTicketOrderInfo           @"orderInfo.htm"//订单详情
#define KPlaneTicketRuleInfo            @"ruleInfo.htm"//退改签规则
#define kPlaneTicketStopInfo            @"stopInfo.htm"//获取经停信息
#define kPlaneTicketCancelOrder         @"cancelOrder.htm"//取消订单
#define kPlaneTicketQueryInsurance      @"queryInsurance.htm"//查询险种

//酒店
#define KHotelInfoDetail                @"showHotelDetail.htm"
#define KHotelInfoRatePlans             @"showHotelRatePlans.htm"
#define KHotelOrderList                 @"searchHotelOrders.htm"
#define KHotelOrderDetail               @"showHotelOrderDetail.htm"
#pragma mark -
#pragma mark 活动开关，送券
#define kHttpRequestSwitchListView                  @"SNMobileSwitchListView"
#define kHttpResponseSwitchSwitchList               @"switchList"
#define kHttpResponseSwitchSwitchName               @"switchName"
#define kHttpResponseSwitchSwitchValue              @"switchValue"

#define kHttpRequestIssueCouponForActivity          @"SNMobileIssueCouponForActivity"


//彩票接口
/*
 #define KLotteryTicketHall                  @"json.jo?file=/data/kaijiang/aopencode.xml" //彩票大厅接口
 #define KLotteryTicketPayment               @"trade/pcast2.go"                          //彩票支付接口
 #define KLotteryTicketOrderList             @"user/query.go"                            //彩票订单列表接口
 #define KLotteryTicketOrderDetail           @"trade/pinfo.go"                           //彩票订单详情接口
 */

#define KLotteryTicketHall                   @"trade/queryAwardAndSalePeriod.go" // 彩票大厅接口
#define KLotteryTicketPayment                @"trade/pcast2.go"                  // 彩票代购订单易付宝支付接口
#define KLotteryUnionPayment                 @"trade/mobileUnionPcast.go"        // 彩票代购订单银联支付接口
#define KLotteryTicketSerialNumberPayment    @"trade/zcast2.go"                  // 彩票追号订单易付宝支付接口
#define KLotterySerialNumberUnionPayment     @"trade/mobileUnionZcast.go"        // 彩票追号订单银联支付接口
#define KLotteryTicketOrderList              @"user/queryMobile.go"              // 彩票订单列表接口
#define KLotteryTicketOrderFollowOrderDetail @"user/queryMobile.go"              // 追号订单详情接口
#define KLotteryTicketOrderDetail            @"trade/mobilepinfo.go"             // 代购详情查询接口
#define KLotteryTicketFollowOrderProject     @"user/queryZHProj.go"              // 追号方案查询
#define KLotteryHistoryCode                  @"json.jo?file=/data/kaijiang/"     // 开奖公告历史开奖号码接口前面
#define KLotteryHistoryCodeLast              @"/l10.xml"                         // 开奖公告历史开奖号码接口后面


#define kHttpResponseCode            @"@code"
#define kHttpResponseDesc            @"@desc"
#define kHttpResponseDate            @"@date"

#define kHttpResponseErrorCode       @"errorCode"
#define kHttpResponseErrorMsg        @"errorDesc"
#define kHttpResponseSuccess         @"isSuccess"

#define kHttpResponseUserNotLoggedIn @"common.2.userNotLoggedIn"

#define kSysCodeForManzuo                       @"manzuowap"

#ifdef kSitTest

#define kHostLotteryTicketForHttps              @"http://10.19.250.73"
#define kHostForManzuo                          @"http://sm.manzuo.com/"
#define kHostForManZuoOrderList                 @"http://sm.manzuo.com/mymanzuo/"
#define kHostForManzuoTrustLogin                [kHostForManzuo stringByAppendingString:@"openPlatform/trustLogin"]


#elif kPreTest

#define kHostLotteryTicketForHttps              @"http://10.19.250.73"
#define kHostForManzuo                          @"http://sm.manzuo.com/"
#define kHostForManZuoOrderList                 @"http://sm.manzuo.com/mymanzuo/"
#define kHostForManzuoTrustLogin                [kHostForManzuo stringByAppendingString:@"openPlatform/trustLogin"]

#elif kReleaseH

#define kHostLotteryTicketForHttps              @"https://caipiao.suning.com"
#define kHostForManzuo                          @"http://sm.manzuo.com/"
#define kHostForManZuoOrderList                 @"http://sm.manzuo.com/mymanzuo/"
#define kHostForManzuoTrustLogin                [kHostForManzuo stringByAppendingString:@"openPlatform/trustLogin"]

#endif


//新抢购
#define  kActChanID						@"111"
#define  kMtID					@"1"

//附近苏宁

#define KSNMTGetStoreInfo       @"SNMTGetStoreInfo"

#define kSNStoreList            @"store/getNearStoreList.do"

#define kSNStoreDetailInfo      @"store/getStoreInfo.do"

#define kACStoreList                @"shops/getAllStoreList"
#define kACStoreDetailInfo          @"shops/getStoreDetail"
#define kACServiceList              @"shops/getServiceList"
#define kACCampaignList             @"shops/getAllActiveList"
#define kACCampStoreList            @"shops/getActiveStoreList"
#define kACServiceStoreList         @"shops/getServiceStoreList"
#define kACUpdateFavoStore          @"shops/updateFavouriteStore.do"
#define kACMyFavoStore              @"shops/getFavouriteStoreList"
#define kACTopCampaignList          @"shops/getTopActiveList"
#define kACNearestStore             @"shops/getNearStore"

#define kNearbySpotStore             @"shops/getNearStoreList.do"


#define kRequestPwdFlag                          @"pwdFlag" //是否加密标志位，“1”:密码加密，其他:密码不加密,此参数不传默认为不加密

#pragma mark -
#pragma mark web收银台

#define kMobileEppMyEpp                 @"epp-m/show/userPay.htm"
#define kMobileEppShowCharge            @"epp-m/rechargeGateway/showCharge.htm"

//cpa*cps
#define kInviteFriend                       @"newRed/private/inviteFriend.html"
#define kQqueryReward                       @"newRed/private/queryReward.html"
#define kGetRedPackEntry                    @"newRed/public/getRedPackEntry.html"
#define kGgetRedPack                        @"newRed/private/getRedPack.html"
//RSA公钥
#ifdef kReleaseH
#define kRegisterRSAPublicKey  \
@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDE2aunhLVwLp0rsXhRhpkoaKHIt2kaFoaiwVzn98BApxEs3wmyf9w1YrZBFlm9L4JNjzT+X1KFbAEbnHuqZArys06KedkwlhsdSXjFDJgSi7PyN/bmnbXptvL0BNJKatwGRo9I/hVAP42i/HdecWhrlUcmT/TJk2cznKXhoNq2WQIDAQAB"
#else
#define kRegisterRSAPublicKey  \
@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCSh6+KnrtF37KHrGbWnfr9qlOsdtxER3CezagsRHbdBD9CLo3aCbRQMjG9f11Dyp0USB7eX0tc/naBvX4qXuKjeu8oPwnqyARRmUkiBHLwCRolSYJgzmSM6wpvd5R95uA/SfPTQgWulHV6b0c5AAT6Ei8klHGtUHOXgXsnLihGWwIDAQAB"
#endif

//subook下载链接
#define kSNBookItunesLink       @"http://itunes.apple.com/cn/app/id568803051?l=en&mt=8"

//商品信息咨询
#define kgetConsultList         @"consultation/getConsultList.do"

//商品咨询总数
#define kgetConsultCount         @"consultation/getGoodsConsultNum.do"

//我的咨询历史
#define kgetMyConsult           @"consultation/private/getMyConsultInfo.do"

//发表咨询
#define kPublichconsult         @"consultation/private/publishConsultFactory.do"

//咨询数量概况
#define kConsultNumDetail       @"consultation/syncConsultNumDetails.do"

//咨询满意度
#define kConsultSatisfaction    @"consultation/private/syncConsultSatisfaction.do"

//咨询类型查询接口
#define KgetConsultationType    @"consultation/getConsultationType.html"
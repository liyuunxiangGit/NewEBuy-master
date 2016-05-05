//
//  productToolClass.h
//  SuningEBuy
//
//  Created by   on 11-10-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//



#import <Foundation/Foundation.h>
 
#define kProductTitleHeaderCell_label_bigtitle_width    280
#define kProductTitleHeaderCell_label_secondtitle_width 280
#define kProductTitleHeaderCell_label_bigtitle_font      [UIFont boldSystemFontOfSize:15]
#define kProductTitleHeaderCell_label_secondtitle_font       [UIFont boldSystemFontOfSize:12]

#define k_ProductParaCell_ParaName_width 110
#define k_ProductParaCell_Paradetail_width 172

#define kProductPriceCELL_button_Font [UIFont systemFontOfSize:20]


#define kProductAppraisalCELL_label_title_font      [UIFont systemFontOfSize:13]
#define kProductAppraisalCELL_label_time_font       [UIFont systemFontOfSize:13]
#define kProductAppraisalCELL_label_content_font    [UIFont systemFontOfSize:15]
#define kProductAppraisalCELL_label_name_font       [UIFont systemFontOfSize:13]

#define kProductAppraisalCELL_label_title_width     170
#define kProductAppraisalCELL_label_time_width      120
#define kProductAppraisalCELL_label_content_width   290
#define kProductAppraisalCELL_label_name_width      160

#define kProductAskCELL_label_name_width                170  
#define kProductAskCELL_label_time_width                120
#define kProductAskCELL_label_content_width             300
#define kProductAskCELL_label_answername_width          200
#define kProductAskCELL_label_answercontent_width       300

#define kProductAskCELL_label_name_font                 [UIFont systemFontOfSize:14]
#define kProductAskCELL_label_time_font                 [UIFont systemFontOfSize:14]
#define kProductAskCELL_label_content_font              [UIFont systemFontOfSize:14]
#define kProductAskCELL_label_answername_font           [UIFont systemFontOfSize:14]
#define kProductAskCELL_label_answercontent_font        [UIFont systemFontOfSize:14]
#define kProductAskCELL_label_answerName        @"苏宁回复:"

enum tag_element {
    TAG_ProductViewController_button_addFavorite,
    TAG_ProductViewController_button_addShoppingCar,
    TAG_ProductViewController_button_addHotLine
};


CGRect returnFrame(UIViewController *sourceViewController);
CGSize returnTextFrame(NSString *source,UIFont *font,NSInteger width,UILineBreakMode uilinkbreakmode);
NSString* returnRightString(NSString *source);





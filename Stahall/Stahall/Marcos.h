//
//  Marcos.h
//  Stahall
//
//  Created by JM_Pro on 14-12-12.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#ifndef Stahall_Marcos_h
#define Stahall_Marcos_h

#define Mywidth self.view.frame.size.width
#define Myheight self.view.frame.size.height


#define MALLDetailIP_Test @"http://192.168.1.116:8080/stahall/mall/getDetail"


/*
  首页轮播图
*/
#define home_HeadIP  @"http://218.244.158.59/stahall/poster/getArtistPoster"


/*
    首页预告
 */
#define advanceIp @"http://218.244.158.59/stahall/trailer/getTrailer"

/*
    首页案例
 */
#define CaseIP @"http://218.244.158.59/stahall/case"

/*
 首页行程
 */
#define TravelIP @"http://218.244.158.59/stahall/travel/getTravel"


/*
 首页案例详情
 */
#define CaseDetailIP @"http://218.244.158.59/stahall/case/getCase"


/*
  首页秀MALL列表
 */
#define MALLListIP @"http://218.244.158.59/stahall/mall/getMall"


/*
 秀MALL详情
 */
#define MALLDetailIP @"http://218.244.158.59/stahall/mall/getDetail"


/*
 图片上传
 */
#define ImageUpLoadIP @"http://218.244.158.59/stahall/upload"


/*
 我的演出
 */
#define MyShowsIP @"http://218.244.158.59/stahall/show/getShow"

/*
 我的演出详情
 */
#define MyShowsDetailsIP @"http://218.244.158.59/stahall/show/detail"





/*
 我的估价
 */
//#define MyValuationIP @"http://218.244.158.59/stahall/valuation/getValuation"
#define MyValuationIP @"http://218.244.158.59/stahall/valuation/getValuation"


/*
  新建演出(提交)
*/
#define AddNewShowIP @"http://218.244.158.59/stahall/show/submit"

/*
  帮助中心
 */
#define HelpCenterIP @"http://218.244.158.59/stahall/help"

/*
 公司简介
 */
#define CompanyProfileIP @"http://218.244.158.59/stahall/help/about"


/*
 二级账户列表
 */
#define SecondAccountListIP @"http://218.244.158.59/stahall/business/children"


/*
 增加二级账户
 */
#define AddSecondIP @"http://218.244.158.59/stahall/business/add/child"

/*
 删除二级账户
 */
#define DeleteSecondIP @"http://218.244.158.59/stahall/business/delete"



// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif

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
#define advanceIp @"http://218.244.158.59/stahall/trailer/getTrailer?start=0&limit=20"


/*
  首页秀MALL列表
 */
#define MALLListIP @"http://218.244.158.59/stahall/mall/getMall"


/*
 秀MALL详情
 */
#define MALLDetailIP @"http://218.244.158.59/stahall/mall/getDetail"

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif

//
//  FrankfanApis.h
//  Stahall
//
//  Created by frankfan on 14/12/22.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#ifndef Stahall_FrankfanApis_h
#define Stahall_FrankfanApis_h

//请求艺人数据
//#define API_StarInfo @"http://218.244.158.59/stahall/artist/getArtist"
#define API_StarInfo @"http://192.168.1.116:8080/stahall/artist/getArtist"


//根据艺人Id请求艺人详情
#define API_GetStarDetailById @"http://192.168.1.116:8080/stahall/artist/getArtistDetail"
//#define API_GetStarDetailById @"http://218.244.158.59/stahall/artist/getArtistDetail"


//提交堂估价 http://192.168.1.116:8080
//#define API_PostStaHallValutionInfo @"http://218.244.158.59/stahall/valuation/submit"
#define API_PostStaHallValutionInfo @"http://192.168.1.116:8080/stahall/valuation/submit"


//估价加急
#define API_AddSpeedEvalution @"http://192.168.1.116:8080/stahall/valuation/add"
//#define API_AddSpeedEvalution @"http://218.244.158.59/stahall/valuation/add"
#endif

//
//  ArtistSchedule.h
//
//  Created by   on 15/1/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ArtistSchedule : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double scheduleId;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *artistId;
@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSString *scheduleName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

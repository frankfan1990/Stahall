//
//  Data.h
//
//  Created by   on 15/1/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class ArtistClaim, ArtistPrice;
#import "ArtistPrice.h"
#import "ArtistClaim.h"

@interface Data : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *artistSchedule;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *artistId;
@property (nonatomic, strong) ArtistClaim *artistClaim;
@property (nonatomic, strong) ArtistPrice *artistPrice;
@property (nonatomic, assign) id artistVideo;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

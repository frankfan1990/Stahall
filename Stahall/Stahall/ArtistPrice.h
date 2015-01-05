//
//  ArtistPrice.h
//
//  Created by   on 15/1/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ArtistPrice : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *artistId;
@property (nonatomic, strong) NSString *wedding;
@property (nonatomic, strong) NSString *media;
@property (nonatomic, strong) NSString *other;
@property (nonatomic, strong) NSString *companyShow;
@property (nonatomic, strong) NSString *represent;
@property (nonatomic, strong) NSString *platter;
@property (nonatomic, strong) NSString *nightclubShow;
@property (nonatomic, strong) NSString *concert;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

//
//  ArtistClaim.h
//
//  Created by   on 15/1/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ArtistClaim : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *luxuryCar;
@property (nonatomic, strong) NSString *economyClass;
@property (nonatomic, strong) NSString *otherClass;
@property (nonatomic, strong) NSString *restrictiveCondition;
@property (nonatomic, strong) NSString *otherHotel;
@property (nonatomic, strong) NSString *businessClass;
@property (nonatomic, assign) double claimId;
@property (nonatomic, strong) NSString *artistId;
@property (nonatomic, strong) NSString *casualDining;
@property (nonatomic, strong) NSString *hotelsRate;
@property (nonatomic, strong) NSString *deluxeDouble;
@property (nonatomic, strong) NSString *commercialCar;
@property (nonatomic, strong) NSString *otherCar;
@property (nonatomic, strong) NSString *deluxeRoom;
@property (nonatomic, strong) NSString *otherDining;
@property (nonatomic, strong) NSString *luggageCar;
@property (nonatomic, strong) NSString *firstClass;
@property (nonatomic, strong) NSString *suite;
@property (nonatomic, strong) NSString *artistDining;
@property (nonatomic, strong) NSString *suvCar;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

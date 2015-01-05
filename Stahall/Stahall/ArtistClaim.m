//
//  ArtistClaim.m
//
//  Created by   on 15/1/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ArtistClaim.h"


NSString *const kArtistClaimLuxuryCar = @"luxuryCar";
NSString *const kArtistClaimEconomyClass = @"economyClass";
NSString *const kArtistClaimOtherClass = @"otherClass";
NSString *const kArtistClaimRestrictiveCondition = @"restrictiveCondition";
NSString *const kArtistClaimOtherHotel = @"otherHotel";
NSString *const kArtistClaimBusinessClass = @"businessClass";
NSString *const kArtistClaimClaimId = @"claimId";
NSString *const kArtistClaimArtistId = @"artistId";
NSString *const kArtistClaimCasualDining = @"casualDining";
NSString *const kArtistClaimHotelsRate = @"hotelsRate";
NSString *const kArtistClaimDeluxeDouble = @"deluxeDouble";
NSString *const kArtistClaimCommercialCar = @"commercialCar";
NSString *const kArtistClaimOtherCar = @"otherCar";
NSString *const kArtistClaimDeluxeRoom = @"deluxeRoom";
NSString *const kArtistClaimOtherDining = @"otherDining";
NSString *const kArtistClaimLuggageCar = @"luggageCar";
NSString *const kArtistClaimFirstClass = @"firstClass";
NSString *const kArtistClaimSuite = @"suite";
NSString *const kArtistClaimArtistDining = @"artistDining";
NSString *const kArtistClaimSuvCar = @"suvCar";


@interface ArtistClaim ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ArtistClaim

@synthesize luxuryCar = _luxuryCar;
@synthesize economyClass = _economyClass;
@synthesize otherClass = _otherClass;
@synthesize restrictiveCondition = _restrictiveCondition;
@synthesize otherHotel = _otherHotel;
@synthesize businessClass = _businessClass;
@synthesize claimId = _claimId;
@synthesize artistId = _artistId;
@synthesize casualDining = _casualDining;
@synthesize hotelsRate = _hotelsRate;
@synthesize deluxeDouble = _deluxeDouble;
@synthesize commercialCar = _commercialCar;
@synthesize otherCar = _otherCar;
@synthesize deluxeRoom = _deluxeRoom;
@synthesize otherDining = _otherDining;
@synthesize luggageCar = _luggageCar;
@synthesize firstClass = _firstClass;
@synthesize suite = _suite;
@synthesize artistDining = _artistDining;
@synthesize suvCar = _suvCar;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.luxuryCar = [self objectOrNilForKey:kArtistClaimLuxuryCar fromDictionary:dict];
            self.economyClass = [self objectOrNilForKey:kArtistClaimEconomyClass fromDictionary:dict];
            self.otherClass = [self objectOrNilForKey:kArtistClaimOtherClass fromDictionary:dict];
            self.restrictiveCondition = [self objectOrNilForKey:kArtistClaimRestrictiveCondition fromDictionary:dict];
            self.otherHotel = [self objectOrNilForKey:kArtistClaimOtherHotel fromDictionary:dict];
            self.businessClass = [self objectOrNilForKey:kArtistClaimBusinessClass fromDictionary:dict];
            self.claimId = [[self objectOrNilForKey:kArtistClaimClaimId fromDictionary:dict] doubleValue];
            self.artistId = [self objectOrNilForKey:kArtistClaimArtistId fromDictionary:dict];
            self.casualDining = [self objectOrNilForKey:kArtistClaimCasualDining fromDictionary:dict];
            self.hotelsRate = [self objectOrNilForKey:kArtistClaimHotelsRate fromDictionary:dict];
            self.deluxeDouble = [self objectOrNilForKey:kArtistClaimDeluxeDouble fromDictionary:dict];
            self.commercialCar = [self objectOrNilForKey:kArtistClaimCommercialCar fromDictionary:dict];
            self.otherCar = [self objectOrNilForKey:kArtistClaimOtherCar fromDictionary:dict];
            self.deluxeRoom = [self objectOrNilForKey:kArtistClaimDeluxeRoom fromDictionary:dict];
            self.otherDining = [self objectOrNilForKey:kArtistClaimOtherDining fromDictionary:dict];
            self.luggageCar = [self objectOrNilForKey:kArtistClaimLuggageCar fromDictionary:dict];
            self.firstClass = [self objectOrNilForKey:kArtistClaimFirstClass fromDictionary:dict];
            self.suite = [self objectOrNilForKey:kArtistClaimSuite fromDictionary:dict];
            self.artistDining = [self objectOrNilForKey:kArtistClaimArtistDining fromDictionary:dict];
            self.suvCar = [self objectOrNilForKey:kArtistClaimSuvCar fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.luxuryCar forKey:kArtistClaimLuxuryCar];
    [mutableDict setValue:self.economyClass forKey:kArtistClaimEconomyClass];
    [mutableDict setValue:self.otherClass forKey:kArtistClaimOtherClass];
    [mutableDict setValue:self.restrictiveCondition forKey:kArtistClaimRestrictiveCondition];
    [mutableDict setValue:self.otherHotel forKey:kArtistClaimOtherHotel];
    [mutableDict setValue:self.businessClass forKey:kArtistClaimBusinessClass];
    [mutableDict setValue:[NSNumber numberWithDouble:self.claimId] forKey:kArtistClaimClaimId];
    [mutableDict setValue:self.artistId forKey:kArtistClaimArtistId];
    [mutableDict setValue:self.casualDining forKey:kArtistClaimCasualDining];
    [mutableDict setValue:self.hotelsRate forKey:kArtistClaimHotelsRate];
    [mutableDict setValue:self.deluxeDouble forKey:kArtistClaimDeluxeDouble];
    [mutableDict setValue:self.commercialCar forKey:kArtistClaimCommercialCar];
    [mutableDict setValue:self.otherCar forKey:kArtistClaimOtherCar];
    [mutableDict setValue:self.deluxeRoom forKey:kArtistClaimDeluxeRoom];
    [mutableDict setValue:self.otherDining forKey:kArtistClaimOtherDining];
    [mutableDict setValue:self.luggageCar forKey:kArtistClaimLuggageCar];
    [mutableDict setValue:self.firstClass forKey:kArtistClaimFirstClass];
    [mutableDict setValue:self.suite forKey:kArtistClaimSuite];
    [mutableDict setValue:self.artistDining forKey:kArtistClaimArtistDining];
    [mutableDict setValue:self.suvCar forKey:kArtistClaimSuvCar];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.luxuryCar = [aDecoder decodeObjectForKey:kArtistClaimLuxuryCar];
    self.economyClass = [aDecoder decodeObjectForKey:kArtistClaimEconomyClass];
    self.otherClass = [aDecoder decodeObjectForKey:kArtistClaimOtherClass];
    self.restrictiveCondition = [aDecoder decodeObjectForKey:kArtistClaimRestrictiveCondition];
    self.otherHotel = [aDecoder decodeObjectForKey:kArtistClaimOtherHotel];
    self.businessClass = [aDecoder decodeObjectForKey:kArtistClaimBusinessClass];
    self.claimId = [aDecoder decodeDoubleForKey:kArtistClaimClaimId];
    self.artistId = [aDecoder decodeObjectForKey:kArtistClaimArtistId];
    self.casualDining = [aDecoder decodeObjectForKey:kArtistClaimCasualDining];
    self.hotelsRate = [aDecoder decodeObjectForKey:kArtistClaimHotelsRate];
    self.deluxeDouble = [aDecoder decodeObjectForKey:kArtistClaimDeluxeDouble];
    self.commercialCar = [aDecoder decodeObjectForKey:kArtistClaimCommercialCar];
    self.otherCar = [aDecoder decodeObjectForKey:kArtistClaimOtherCar];
    self.deluxeRoom = [aDecoder decodeObjectForKey:kArtistClaimDeluxeRoom];
    self.otherDining = [aDecoder decodeObjectForKey:kArtistClaimOtherDining];
    self.luggageCar = [aDecoder decodeObjectForKey:kArtistClaimLuggageCar];
    self.firstClass = [aDecoder decodeObjectForKey:kArtistClaimFirstClass];
    self.suite = [aDecoder decodeObjectForKey:kArtistClaimSuite];
    self.artistDining = [aDecoder decodeObjectForKey:kArtistClaimArtistDining];
    self.suvCar = [aDecoder decodeObjectForKey:kArtistClaimSuvCar];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_luxuryCar forKey:kArtistClaimLuxuryCar];
    [aCoder encodeObject:_economyClass forKey:kArtistClaimEconomyClass];
    [aCoder encodeObject:_otherClass forKey:kArtistClaimOtherClass];
    [aCoder encodeObject:_restrictiveCondition forKey:kArtistClaimRestrictiveCondition];
    [aCoder encodeObject:_otherHotel forKey:kArtistClaimOtherHotel];
    [aCoder encodeObject:_businessClass forKey:kArtistClaimBusinessClass];
    [aCoder encodeDouble:_claimId forKey:kArtistClaimClaimId];
    [aCoder encodeObject:_artistId forKey:kArtistClaimArtistId];
    [aCoder encodeObject:_casualDining forKey:kArtistClaimCasualDining];
    [aCoder encodeObject:_hotelsRate forKey:kArtistClaimHotelsRate];
    [aCoder encodeObject:_deluxeDouble forKey:kArtistClaimDeluxeDouble];
    [aCoder encodeObject:_commercialCar forKey:kArtistClaimCommercialCar];
    [aCoder encodeObject:_otherCar forKey:kArtistClaimOtherCar];
    [aCoder encodeObject:_deluxeRoom forKey:kArtistClaimDeluxeRoom];
    [aCoder encodeObject:_otherDining forKey:kArtistClaimOtherDining];
    [aCoder encodeObject:_luggageCar forKey:kArtistClaimLuggageCar];
    [aCoder encodeObject:_firstClass forKey:kArtistClaimFirstClass];
    [aCoder encodeObject:_suite forKey:kArtistClaimSuite];
    [aCoder encodeObject:_artistDining forKey:kArtistClaimArtistDining];
    [aCoder encodeObject:_suvCar forKey:kArtistClaimSuvCar];
}

- (id)copyWithZone:(NSZone *)zone
{
    ArtistClaim *copy = [[ArtistClaim alloc] init];
    
    if (copy) {

        copy.luxuryCar = [self.luxuryCar copyWithZone:zone];
        copy.economyClass = [self.economyClass copyWithZone:zone];
        copy.otherClass = [self.otherClass copyWithZone:zone];
        copy.restrictiveCondition = [self.restrictiveCondition copyWithZone:zone];
        copy.otherHotel = [self.otherHotel copyWithZone:zone];
        copy.businessClass = [self.businessClass copyWithZone:zone];
        copy.claimId = self.claimId;
        copy.artistId = [self.artistId copyWithZone:zone];
        copy.casualDining = [self.casualDining copyWithZone:zone];
        copy.hotelsRate = [self.hotelsRate copyWithZone:zone];
        copy.deluxeDouble = [self.deluxeDouble copyWithZone:zone];
        copy.commercialCar = [self.commercialCar copyWithZone:zone];
        copy.otherCar = [self.otherCar copyWithZone:zone];
        copy.deluxeRoom = [self.deluxeRoom copyWithZone:zone];
        copy.otherDining = [self.otherDining copyWithZone:zone];
        copy.luggageCar = [self.luggageCar copyWithZone:zone];
        copy.firstClass = [self.firstClass copyWithZone:zone];
        copy.suite = [self.suite copyWithZone:zone];
        copy.artistDining = [self.artistDining copyWithZone:zone];
        copy.suvCar = [self.suvCar copyWithZone:zone];
    }
    
    return copy;
}


@end

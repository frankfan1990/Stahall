//
//  ArtistPrice.m
//
//  Created by   on 15/1/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ArtistPrice.h"


NSString *const kArtistPriceArtistId = @"artistId";
NSString *const kArtistPriceWedding = @"wedding";
NSString *const kArtistPriceMedia = @"media";
NSString *const kArtistPriceOther = @"other";
NSString *const kArtistPriceCompanyShow = @"companyShow";
NSString *const kArtistPriceRepresent = @"represent";
NSString *const kArtistPricePlatter = @"platter";
NSString *const kArtistPriceNightclubShow = @"nightclubShow";
NSString *const kArtistPriceConcert = @"concert";


@interface ArtistPrice ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ArtistPrice

@synthesize artistId = _artistId;
@synthesize wedding = _wedding;
@synthesize media = _media;
@synthesize other = _other;
@synthesize companyShow = _companyShow;
@synthesize represent = _represent;
@synthesize platter = _platter;
@synthesize nightclubShow = _nightclubShow;
@synthesize concert = _concert;


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
            self.artistId = [self objectOrNilForKey:kArtistPriceArtistId fromDictionary:dict];
            self.wedding = [self objectOrNilForKey:kArtistPriceWedding fromDictionary:dict];
            self.media = [self objectOrNilForKey:kArtistPriceMedia fromDictionary:dict];
            self.other = [self objectOrNilForKey:kArtistPriceOther fromDictionary:dict];
            self.companyShow = [self objectOrNilForKey:kArtistPriceCompanyShow fromDictionary:dict];
            self.represent = [self objectOrNilForKey:kArtistPriceRepresent fromDictionary:dict];
            self.platter = [self objectOrNilForKey:kArtistPricePlatter fromDictionary:dict];
            self.nightclubShow = [self objectOrNilForKey:kArtistPriceNightclubShow fromDictionary:dict];
            self.concert = [self objectOrNilForKey:kArtistPriceConcert fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.artistId forKey:kArtistPriceArtistId];
    [mutableDict setValue:self.wedding forKey:kArtistPriceWedding];
    [mutableDict setValue:self.media forKey:kArtistPriceMedia];
    [mutableDict setValue:self.other forKey:kArtistPriceOther];
    [mutableDict setValue:self.companyShow forKey:kArtistPriceCompanyShow];
    [mutableDict setValue:self.represent forKey:kArtistPriceRepresent];
    [mutableDict setValue:self.platter forKey:kArtistPricePlatter];
    [mutableDict setValue:self.nightclubShow forKey:kArtistPriceNightclubShow];
    [mutableDict setValue:self.concert forKey:kArtistPriceConcert];

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

    self.artistId = [aDecoder decodeObjectForKey:kArtistPriceArtistId];
    self.wedding = [aDecoder decodeObjectForKey:kArtistPriceWedding];
    self.media = [aDecoder decodeObjectForKey:kArtistPriceMedia];
    self.other = [aDecoder decodeObjectForKey:kArtistPriceOther];
    self.companyShow = [aDecoder decodeObjectForKey:kArtistPriceCompanyShow];
    self.represent = [aDecoder decodeObjectForKey:kArtistPriceRepresent];
    self.platter = [aDecoder decodeObjectForKey:kArtistPricePlatter];
    self.nightclubShow = [aDecoder decodeObjectForKey:kArtistPriceNightclubShow];
    self.concert = [aDecoder decodeObjectForKey:kArtistPriceConcert];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_artistId forKey:kArtistPriceArtistId];
    [aCoder encodeObject:_wedding forKey:kArtistPriceWedding];
    [aCoder encodeObject:_media forKey:kArtistPriceMedia];
    [aCoder encodeObject:_other forKey:kArtistPriceOther];
    [aCoder encodeObject:_companyShow forKey:kArtistPriceCompanyShow];
    [aCoder encodeObject:_represent forKey:kArtistPriceRepresent];
    [aCoder encodeObject:_platter forKey:kArtistPricePlatter];
    [aCoder encodeObject:_nightclubShow forKey:kArtistPriceNightclubShow];
    [aCoder encodeObject:_concert forKey:kArtistPriceConcert];
}

- (id)copyWithZone:(NSZone *)zone
{
    ArtistPrice *copy = [[ArtistPrice alloc] init];
    
    if (copy) {

        copy.artistId = [self.artistId copyWithZone:zone];
        copy.wedding = [self.wedding copyWithZone:zone];
        copy.media = [self.media copyWithZone:zone];
        copy.other = [self.other copyWithZone:zone];
        copy.companyShow = [self.companyShow copyWithZone:zone];
        copy.represent = [self.represent copyWithZone:zone];
        copy.platter = [self.platter copyWithZone:zone];
        copy.nightclubShow = [self.nightclubShow copyWithZone:zone];
        copy.concert = [self.concert copyWithZone:zone];
    }
    
    return copy;
}


@end

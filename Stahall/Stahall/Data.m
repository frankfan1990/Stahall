//
//  Data.m
//
//  Created by   on 15/1/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Data.h"
#import "ArtistSchedule.h"
#import "ArtistClaim.h"
#import "ArtistPrice.h"


NSString *const kDataArtistSchedule = @"artistSchedule";
NSString *const kDataIntroduction = @"introduction";
NSString *const kDataArtistId = @"artistId";
NSString *const kDataArtistClaim = @"artistClaim";
NSString *const kDataArtistPrice = @"artistPrice";
NSString *const kDataArtistVideo = @"artistVideo";


@interface Data ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Data

@synthesize artistSchedule = _artistSchedule;
@synthesize introduction = _introduction;
@synthesize artistId = _artistId;
@synthesize artistClaim = _artistClaim;
@synthesize artistPrice = _artistPrice;
@synthesize artistVideo = _artistVideo;


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
    NSObject *receivedArtistSchedule = [dict objectForKey:kDataArtistSchedule];
    NSMutableArray *parsedArtistSchedule = [NSMutableArray array];
    if ([receivedArtistSchedule isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedArtistSchedule) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedArtistSchedule addObject:[ArtistSchedule modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedArtistSchedule isKindOfClass:[NSDictionary class]]) {
       [parsedArtistSchedule addObject:[ArtistSchedule modelObjectWithDictionary:(NSDictionary *)receivedArtistSchedule]];
    }

    self.artistSchedule = [NSArray arrayWithArray:parsedArtistSchedule];
            self.introduction = [self objectOrNilForKey:kDataIntroduction fromDictionary:dict];
            self.artistId = [self objectOrNilForKey:kDataArtistId fromDictionary:dict];
            self.artistClaim = [ArtistClaim modelObjectWithDictionary:[dict objectForKey:kDataArtistClaim]];
            self.artistPrice = [ArtistPrice modelObjectWithDictionary:[dict objectForKey:kDataArtistPrice]];
            self.artistVideo = [self objectOrNilForKey:kDataArtistVideo fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForArtistSchedule = [NSMutableArray array];
    for (NSObject *subArrayObject in self.artistSchedule) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForArtistSchedule addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForArtistSchedule addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForArtistSchedule] forKey:kDataArtistSchedule];
    [mutableDict setValue:self.introduction forKey:kDataIntroduction];
    [mutableDict setValue:self.artistId forKey:kDataArtistId];
    [mutableDict setValue:[self.artistClaim dictionaryRepresentation] forKey:kDataArtistClaim];
    [mutableDict setValue:[self.artistPrice dictionaryRepresentation] forKey:kDataArtistPrice];
    [mutableDict setValue:self.artistVideo forKey:kDataArtistVideo];

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

    self.artistSchedule = [aDecoder decodeObjectForKey:kDataArtistSchedule];
    self.introduction = [aDecoder decodeObjectForKey:kDataIntroduction];
    self.artistId = [aDecoder decodeObjectForKey:kDataArtistId];
    self.artistClaim = [aDecoder decodeObjectForKey:kDataArtistClaim];
    self.artistPrice = [aDecoder decodeObjectForKey:kDataArtistPrice];
    self.artistVideo = [aDecoder decodeObjectForKey:kDataArtistVideo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_artistSchedule forKey:kDataArtistSchedule];
    [aCoder encodeObject:_introduction forKey:kDataIntroduction];
    [aCoder encodeObject:_artistId forKey:kDataArtistId];
    [aCoder encodeObject:_artistClaim forKey:kDataArtistClaim];
    [aCoder encodeObject:_artistPrice forKey:kDataArtistPrice];
    [aCoder encodeObject:_artistVideo forKey:kDataArtistVideo];
}

- (id)copyWithZone:(NSZone *)zone
{
    Data *copy = [[Data alloc] init];
    
    if (copy) {

        copy.artistSchedule = [self.artistSchedule copyWithZone:zone];
        copy.introduction = [self.introduction copyWithZone:zone];
        copy.artistId = [self.artistId copyWithZone:zone];
        copy.artistClaim = [self.artistClaim copyWithZone:zone];
        copy.artistPrice = [self.artistPrice copyWithZone:zone];
        copy.artistVideo = [self.artistVideo copyWithZone:zone];
    }
    
    return copy;
}


@end

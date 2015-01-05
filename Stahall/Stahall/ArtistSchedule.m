//
//  ArtistSchedule.m
//
//  Created by   on 15/1/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ArtistSchedule.h"


NSString *const kArtistScheduleScheduleId = @"scheduleId";
NSString *const kArtistScheduleStartTime = @"startTime";
NSString *const kArtistScheduleEndTime = @"endTime";
NSString *const kArtistScheduleArtistId = @"artistId";
NSString *const kArtistScheduleStatus = @"status";
NSString *const kArtistScheduleScheduleName = @"scheduleName";


@interface ArtistSchedule ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ArtistSchedule

@synthesize scheduleId = _scheduleId;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;
@synthesize artistId = _artistId;
@synthesize status = _status;
@synthesize scheduleName = _scheduleName;


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
            self.scheduleId = [[self objectOrNilForKey:kArtistScheduleScheduleId fromDictionary:dict] doubleValue];
            self.startTime = [self objectOrNilForKey:kArtistScheduleStartTime fromDictionary:dict];
            self.endTime = [self objectOrNilForKey:kArtistScheduleEndTime fromDictionary:dict];
            self.artistId = [self objectOrNilForKey:kArtistScheduleArtistId fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kArtistScheduleStatus fromDictionary:dict] doubleValue];
            self.scheduleName = [self objectOrNilForKey:kArtistScheduleScheduleName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.scheduleId] forKey:kArtistScheduleScheduleId];
    [mutableDict setValue:self.startTime forKey:kArtistScheduleStartTime];
    [mutableDict setValue:self.endTime forKey:kArtistScheduleEndTime];
    [mutableDict setValue:self.artistId forKey:kArtistScheduleArtistId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kArtistScheduleStatus];
    [mutableDict setValue:self.scheduleName forKey:kArtistScheduleScheduleName];

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

    self.scheduleId = [aDecoder decodeDoubleForKey:kArtistScheduleScheduleId];
    self.startTime = [aDecoder decodeObjectForKey:kArtistScheduleStartTime];
    self.endTime = [aDecoder decodeObjectForKey:kArtistScheduleEndTime];
    self.artistId = [aDecoder decodeObjectForKey:kArtistScheduleArtistId];
    self.status = [aDecoder decodeDoubleForKey:kArtistScheduleStatus];
    self.scheduleName = [aDecoder decodeObjectForKey:kArtistScheduleScheduleName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_scheduleId forKey:kArtistScheduleScheduleId];
    [aCoder encodeObject:_startTime forKey:kArtistScheduleStartTime];
    [aCoder encodeObject:_endTime forKey:kArtistScheduleEndTime];
    [aCoder encodeObject:_artistId forKey:kArtistScheduleArtistId];
    [aCoder encodeDouble:_status forKey:kArtistScheduleStatus];
    [aCoder encodeObject:_scheduleName forKey:kArtistScheduleScheduleName];
}

- (id)copyWithZone:(NSZone *)zone
{
    ArtistSchedule *copy = [[ArtistSchedule alloc] init];
    
    if (copy) {

        copy.scheduleId = self.scheduleId;
        copy.startTime = [self.startTime copyWithZone:zone];
        copy.endTime = [self.endTime copyWithZone:zone];
        copy.artistId = [self.artistId copyWithZone:zone];
        copy.status = self.status;
        copy.scheduleName = [self.scheduleName copyWithZone:zone];
    }
    
    return copy;
}


@end

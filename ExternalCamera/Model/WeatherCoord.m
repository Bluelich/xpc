//
//	WeatherCoord.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeatherCoord.h"

NSString *const kWeatherCoordLat = @"lat";
NSString *const kWeatherCoordLon = @"lon";

@interface WeatherCoord ()
@end
@implementation WeatherCoord

+ (BOOL)supportsSecureCoding
{
    return YES;
}


/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kWeatherCoordLat] isKindOfClass:[NSNull class]]){
		self.lat = [dictionary[kWeatherCoordLat] floatValue];
	}

	if(![dictionary[kWeatherCoordLon] isKindOfClass:[NSNull class]]){
		self.lon = [dictionary[kWeatherCoordLon] floatValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kWeatherCoordLat] = @(self.lat);
	dictionary[kWeatherCoordLon] = @(self.lon);
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:@(self.lat) forKey:kWeatherCoordLat];	[aCoder encodeObject:@(self.lon) forKey:kWeatherCoordLon];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.lat = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherCoordLat] floatValue];
	self.lon = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherCoordLon] floatValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeatherCoord *copy = [WeatherCoord new];

	copy.lat = self.lat;
	copy.lon = self.lon;

	return copy;
}
@end

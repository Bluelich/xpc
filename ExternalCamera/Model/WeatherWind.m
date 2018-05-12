//
//	WeatherWind.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeatherWind.h"

NSString *const kWeatherWindDeg = @"deg";
NSString *const kWeatherWindSpeed = @"speed";

@interface WeatherWind ()
@end
@implementation WeatherWind

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
	if(![dictionary[kWeatherWindDeg] isKindOfClass:[NSNull class]]){
		self.deg = [dictionary[kWeatherWindDeg] integerValue];
	}

	if(![dictionary[kWeatherWindSpeed] isKindOfClass:[NSNull class]]){
		self.speed = [dictionary[kWeatherWindSpeed] floatValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kWeatherWindDeg] = @(self.deg);
	dictionary[kWeatherWindSpeed] = @(self.speed);
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
	[aCoder encodeObject:@(self.deg) forKey:kWeatherWindDeg];	[aCoder encodeObject:@(self.speed) forKey:kWeatherWindSpeed];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.deg = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherWindDeg] integerValue];
	self.speed = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherWindSpeed] floatValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeatherWind *copy = [WeatherWind new];

	copy.deg = self.deg;
	copy.speed = self.speed;

	return copy;
}
@end

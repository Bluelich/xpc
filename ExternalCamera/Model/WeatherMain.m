//
//	WeatherMain.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeatherMain.h"

NSString *const kWeatherMainHumidity = @"humidity";
NSString *const kWeatherMainPressure = @"pressure";
NSString *const kWeatherMainTemp = @"temp";
NSString *const kWeatherMainTempMax = @"temp_max";
NSString *const kWeatherMainTempMin = @"temp_min";

@interface WeatherMain ()
@end
@implementation WeatherMain

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
	if(![dictionary[kWeatherMainHumidity] isKindOfClass:[NSNull class]]){
		self.humidity = [dictionary[kWeatherMainHumidity] integerValue];
	}

	if(![dictionary[kWeatherMainPressure] isKindOfClass:[NSNull class]]){
		self.pressure = [dictionary[kWeatherMainPressure] integerValue];
	}

	if(![dictionary[kWeatherMainTemp] isKindOfClass:[NSNull class]]){
		self.temp = [dictionary[kWeatherMainTemp] floatValue];
	}

	if(![dictionary[kWeatherMainTempMax] isKindOfClass:[NSNull class]]){
		self.tempMax = [dictionary[kWeatherMainTempMax] integerValue];
	}

	if(![dictionary[kWeatherMainTempMin] isKindOfClass:[NSNull class]]){
		self.tempMin = [dictionary[kWeatherMainTempMin] floatValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kWeatherMainHumidity] = @(self.humidity);
	dictionary[kWeatherMainPressure] = @(self.pressure);
	dictionary[kWeatherMainTemp] = @(self.temp);
	dictionary[kWeatherMainTempMax] = @(self.tempMax);
	dictionary[kWeatherMainTempMin] = @(self.tempMin);
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
	[aCoder encodeObject:@(self.humidity) forKey:kWeatherMainHumidity];	[aCoder encodeObject:@(self.pressure) forKey:kWeatherMainPressure];	[aCoder encodeObject:@(self.temp) forKey:kWeatherMainTemp];	[aCoder encodeObject:@(self.tempMax) forKey:kWeatherMainTempMax];	[aCoder encodeObject:@(self.tempMin) forKey:kWeatherMainTempMin];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.humidity = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherMainHumidity] integerValue];
	self.pressure = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherMainPressure] integerValue];
	self.temp = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherMainTemp] floatValue];
	self.tempMax = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherMainTempMax] integerValue];
	self.tempMin = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherMainTempMin] floatValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeatherMain *copy = [WeatherMain new];

	copy.humidity = self.humidity;
	copy.pressure = self.pressure;
	copy.temp = self.temp;
	copy.tempMax = self.tempMax;
	copy.tempMin = self.tempMin;

	return copy;
}
@end

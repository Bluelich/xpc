//
//	WeatherSy.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeatherSy.h"

NSString *const kWeatherSyCountry = @"country";
NSString *const kWeatherSyIdField = @"id";
NSString *const kWeatherSyMessage = @"message";
NSString *const kWeatherSySunrise = @"sunrise";
NSString *const kWeatherSySunset = @"sunset";
NSString *const kWeatherSyType = @"type";

@interface WeatherSy ()
@end
@implementation WeatherSy

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
	if(![dictionary[kWeatherSyCountry] isKindOfClass:[NSNull class]]){
		self.country = dictionary[kWeatherSyCountry];
	}

	if(![dictionary[kWeatherSyIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kWeatherSyIdField] integerValue];
	}

	if(![dictionary[kWeatherSyMessage] isKindOfClass:[NSNull class]]){
		self.message = [dictionary[kWeatherSyMessage] floatValue];
	}

	if(![dictionary[kWeatherSySunrise] isKindOfClass:[NSNull class]]){
		self.sunrise = [dictionary[kWeatherSySunrise] integerValue];
	}

	if(![dictionary[kWeatherSySunset] isKindOfClass:[NSNull class]]){
		self.sunset = [dictionary[kWeatherSySunset] integerValue];
	}

	if(![dictionary[kWeatherSyType] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[kWeatherSyType] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.country != nil){
		dictionary[kWeatherSyCountry] = self.country;
	}
	dictionary[kWeatherSyIdField] = @(self.idField);
	dictionary[kWeatherSyMessage] = @(self.message);
	dictionary[kWeatherSySunrise] = @(self.sunrise);
	dictionary[kWeatherSySunset] = @(self.sunset);
	dictionary[kWeatherSyType] = @(self.type);
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
	if(self.country != nil){
		[aCoder encodeObject:self.country forKey:kWeatherSyCountry];
	}
	[aCoder encodeObject:@(self.idField) forKey:kWeatherSyIdField];	[aCoder encodeObject:@(self.message) forKey:kWeatherSyMessage];	[aCoder encodeObject:@(self.sunrise) forKey:kWeatherSySunrise];	[aCoder encodeObject:@(self.sunset) forKey:kWeatherSySunset];	[aCoder encodeObject:@(self.type) forKey:kWeatherSyType];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.country = [aDecoder decodeObjectOfClass:NSString.class forKey:kWeatherSyCountry];
	self.idField = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherSyIdField] integerValue];
	self.message = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherSyMessage] floatValue];
	self.sunrise = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherSySunrise] integerValue];
	self.sunset = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherSySunset] integerValue];
	self.type = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherSyType] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeatherSy *copy = [WeatherSy new];

	copy.country = [self.country copy];
	copy.idField = self.idField;
	copy.message = self.message;
	copy.sunrise = self.sunrise;
	copy.sunset = self.sunset;
	copy.type = self.type;

	return copy;
}
@end

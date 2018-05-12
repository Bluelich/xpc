//
//	WeatherRootClass.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WeatherRootClass.h"
#import <YYModel.h>

NSString *const kWeatherRootClassBase = @"base";
NSString *const kWeatherRootClassClouds = @"clouds";
NSString *const kWeatherRootClassCod = @"cod";
NSString *const kWeatherRootClassCoord = @"coord";
NSString *const kWeatherRootClassDt = @"dt";
NSString *const kWeatherRootClassIdField = @"id";
NSString *const kWeatherRootClassMain = @"main";
NSString *const kWeatherRootClassName = @"name";
NSString *const kWeatherRootClassSys = @"sys";
NSString *const kWeatherRootClassVisibility = @"visibility";
NSString *const kWeatherRootClassWeather = @"weather";
NSString *const kWeatherRootClassWind = @"wind";

@interface WeatherRootClass ()
@end
@implementation WeatherRootClass


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
	if(![dictionary[kWeatherRootClassBase] isKindOfClass:[NSNull class]]){
		self.base = dictionary[kWeatherRootClassBase];
	}

	if(![dictionary[kWeatherRootClassClouds] isKindOfClass:[NSNull class]]){
		self.clouds = [[WeatherCloud alloc] initWithDictionary:dictionary[kWeatherRootClassClouds]];
	}

	if(![dictionary[kWeatherRootClassCod] isKindOfClass:[NSNull class]]){
		self.cod = [dictionary[kWeatherRootClassCod] integerValue];
	}

	if(![dictionary[kWeatherRootClassCoord] isKindOfClass:[NSNull class]]){
		self.coord = [[WeatherCoord alloc] initWithDictionary:dictionary[kWeatherRootClassCoord]];
	}

	if(![dictionary[kWeatherRootClassDt] isKindOfClass:[NSNull class]]){
		self.dt = [dictionary[kWeatherRootClassDt] integerValue];
	}

	if(![dictionary[kWeatherRootClassIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kWeatherRootClassIdField] integerValue];
	}

	if(![dictionary[kWeatherRootClassMain] isKindOfClass:[NSNull class]]){
		self.main = [[WeatherMain alloc] initWithDictionary:dictionary[kWeatherRootClassMain]];
	}

	if(![dictionary[kWeatherRootClassName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kWeatherRootClassName];
	}

	if(![dictionary[kWeatherRootClassSys] isKindOfClass:[NSNull class]]){
		self.sys = [[WeatherSy alloc] initWithDictionary:dictionary[kWeatherRootClassSys]];
	}

	if(![dictionary[kWeatherRootClassVisibility] isKindOfClass:[NSNull class]]){
		self.visibility = [dictionary[kWeatherRootClassVisibility] integerValue];
	}

	if(dictionary[kWeatherRootClassWeather] != nil && [dictionary[kWeatherRootClassWeather] isKindOfClass:[NSArray class]]){
		NSArray * weatherDictionaries = dictionary[kWeatherRootClassWeather];
		NSMutableArray * weatherItems = [NSMutableArray array];
		for(NSDictionary * weatherDictionary in weatherDictionaries){
			Weather * weatherItem = [[Weather alloc] initWithDictionary:weatherDictionary];
			[weatherItems addObject:weatherItem];
		}
		self.weather = weatherItems;
	}
	if(![dictionary[kWeatherRootClassWind] isKindOfClass:[NSNull class]]){
		self.wind = [[WeatherWind alloc] initWithDictionary:dictionary[kWeatherRootClassWind]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.base != nil){
		dictionary[kWeatherRootClassBase] = self.base;
	}
	if(self.clouds != nil){
		dictionary[kWeatherRootClassClouds] = [self.clouds toDictionary];
	}
	dictionary[kWeatherRootClassCod] = @(self.cod);
	if(self.coord != nil){
		dictionary[kWeatherRootClassCoord] = [self.coord toDictionary];
	}
	dictionary[kWeatherRootClassDt] = @(self.dt);
	dictionary[kWeatherRootClassIdField] = @(self.idField);
	if(self.main != nil){
		dictionary[kWeatherRootClassMain] = [self.main toDictionary];
	}
	if(self.name != nil){
		dictionary[kWeatherRootClassName] = self.name;
	}
	if(self.sys != nil){
		dictionary[kWeatherRootClassSys] = [self.sys toDictionary];
	}
	dictionary[kWeatherRootClassVisibility] = @(self.visibility);
	if(self.weather != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Weather * weatherElement in self.weather){
			[dictionaryElements addObject:[weatherElement toDictionary]];
		}
		dictionary[kWeatherRootClassWeather] = dictionaryElements;
	}
	if(self.wind != nil){
		dictionary[kWeatherRootClassWind] = [self.wind toDictionary];
	}
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
	if(self.base != nil){
		[aCoder encodeObject:self.base forKey:kWeatherRootClassBase];
	}
	if(self.clouds != nil){
		[aCoder encodeObject:self.clouds forKey:kWeatherRootClassClouds];
	}
	[aCoder encodeObject:@(self.cod) forKey:kWeatherRootClassCod];
    if(self.coord != nil){
		[aCoder encodeObject:self.coord forKey:kWeatherRootClassCoord];
	}
	[aCoder encodeObject:@(self.dt) forKey:kWeatherRootClassDt];
    [aCoder encodeObject:@(self.idField) forKey:kWeatherRootClassIdField];
    if(self.main != nil){
		[aCoder encodeObject:self.main forKey:kWeatherRootClassMain];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kWeatherRootClassName];
	}
	if(self.sys != nil){
		[aCoder encodeObject:self.sys forKey:kWeatherRootClassSys];
	}
	[aCoder encodeObject:@(self.visibility) forKey:kWeatherRootClassVisibility];
    if (self.weather) {
        [aCoder encodeObject:self.weather forKey:kWeatherRootClassWeather];
    }
	if(self.wind != nil){
		[aCoder encodeObject:self.wind forKey:kWeatherRootClassWind];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.base = [aDecoder decodeObjectOfClass:NSString.class forKey:kWeatherRootClassBase];
	self.clouds = [aDecoder decodeObjectOfClass:WeatherCloud.class forKey:kWeatherRootClassClouds];
	self.cod = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherRootClassCod] integerValue];
	self.coord = [aDecoder decodeObjectOfClass:WeatherCoord.class forKey:kWeatherRootClassCoord];
	self.dt = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherRootClassDt] integerValue];
	self.idField = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherRootClassIdField] integerValue];
	self.main = [aDecoder decodeObjectOfClass:WeatherMain.class forKey:kWeatherRootClassMain];
	self.name = [aDecoder decodeObjectOfClass:NSString.class forKey:kWeatherRootClassName];
	self.sys = [aDecoder decodeObjectOfClass:WeatherSy.class forKey:kWeatherRootClassSys];
	self.visibility = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherRootClassVisibility] integerValue];
    NSSet *set = [NSSet setWithArray:@[NSArray.class,Weather.class,NSString.class,NSNumber.class]];
    self.weather = [aDecoder decodeObjectOfClasses:set forKey:kWeatherRootClassWeather];
	self.wind = [aDecoder decodeObjectOfClass:WeatherWind.class forKey:kWeatherRootClassWind];
	return self;
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	WeatherRootClass *copy = [WeatherRootClass new];

	copy.base = [self.base copy];
	copy.clouds = [self.clouds copy];
	copy.cod = self.cod;
	copy.coord = [self.coord copy];
	copy.dt = self.dt;
	copy.idField = self.idField;
	copy.main = [self.main copy];
	copy.name = [self.name copy];
	copy.sys = [self.sys copy];
	copy.visibility = self.visibility;
	copy.weather = [self.weather copy];
	copy.wind = [self.wind copy];

	return copy;
}
@end

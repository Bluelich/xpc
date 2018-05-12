//
//	Weather.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Weather.h"

NSString *const kWeatherDescriptionField = @"description";
NSString *const kWeatherIcon = @"icon";
NSString *const kWeatherIdField = @"id";
NSString *const kWeatherMain = @"main";

@interface Weather ()
@end
@implementation Weather

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
	if(![dictionary[kWeatherDescriptionField] isKindOfClass:[NSNull class]]){
		self.descriptionField = dictionary[kWeatherDescriptionField];
	}
    
	if(![dictionary[kWeatherIcon] isKindOfClass:[NSNull class]]){
        self.icon = [NSString stringWithFormat:@"https://openweathermap.org/img/w/%@.png",dictionary[kWeatherIcon]];
	}

	if(![dictionary[kWeatherIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kWeatherIdField] integerValue];
	}

	if(![dictionary[kWeatherMain] isKindOfClass:[NSNull class]]){
		self.main = dictionary[kWeatherMain];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.descriptionField != nil){
		dictionary[kWeatherDescriptionField] = self.descriptionField;
	}
	if(self.icon != nil){
		dictionary[kWeatherIcon] = self.icon;
	}
	dictionary[kWeatherIdField] = @(self.idField);
	if(self.main != nil){
		dictionary[kWeatherMain] = self.main;
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
	if(self.descriptionField != nil){
		[aCoder encodeObject:self.descriptionField forKey:kWeatherDescriptionField];
	}
	if(self.icon != nil){
		[aCoder encodeObject:self.icon forKey:kWeatherIcon];
	}
	[aCoder encodeObject:@(self.idField) forKey:kWeatherIdField];	if(self.main != nil){
		[aCoder encodeObject:self.main forKey:kWeatherMain];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.descriptionField = [aDecoder decodeObjectOfClass:NSString.class forKey:kWeatherDescriptionField];
	self.icon = [aDecoder decodeObjectOfClass:NSString.class forKey:kWeatherIcon];
	self.idField = [[aDecoder decodeObjectOfClass:NSNumber.class forKey:kWeatherIdField] integerValue];
	self.main = [aDecoder decodeObjectOfClass:NSString.class forKey:kWeatherMain];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Weather *copy = [Weather new];

	copy.descriptionField = [self.descriptionField copy];
	copy.icon = [self.icon copy];
	copy.idField = self.idField;
	copy.main = [self.main copy];

	return copy;
}
@end

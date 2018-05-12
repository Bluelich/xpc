#import <AppKit/AppKit.h>
#import "WeatherCloud.h"
#import "WeatherCoord.h"
#import "WeatherMain.h"
#import "WeatherSy.h"
#import "Weather.h"
#import "WeatherWind.h"

typedef NS_ENUM(NSUInteger, ThermometricScale) {
    ThermometricScale_Celsius    = 0,
    ThermometricScale_Fahrenheit = 1,
};

@interface WeatherRootClass : NSObject<NSSecureCoding>

@property (nonatomic, strong) NSString * base;
@property (nonatomic, strong) WeatherCloud * clouds;
@property (nonatomic, assign) NSInteger cod;
@property (nonatomic, strong) WeatherCoord * coord;
@property (nonatomic, assign) NSInteger dt;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) WeatherMain * main;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) WeatherSy * sys;
@property (nonatomic, assign) NSInteger visibility;
@property (nonatomic, strong) NSMutableArray<Weather *> *weather;
@property (nonatomic, strong) WeatherWind * wind;

@property (nonatomic,strong) NSError *error;

@property (nonatomic,assign) ThermometricScale thermometricScale;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end

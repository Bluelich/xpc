#import <AppKit/AppKit.h>

@interface WeatherSy : NSObject<NSSecureCoding>

@property (nonatomic, strong) NSString * country;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) CGFloat message;
@property (nonatomic, assign) NSInteger sunrise;
@property (nonatomic, assign) NSInteger sunset;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end

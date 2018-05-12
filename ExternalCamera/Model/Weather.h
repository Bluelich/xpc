#import <AppKit/AppKit.h>

@interface Weather : NSObject<NSSecureCoding>

@property (nonatomic, strong) NSString * descriptionField;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * main;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end

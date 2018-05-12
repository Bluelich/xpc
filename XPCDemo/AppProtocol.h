//
//  AppProtocol.h
//  XPCDemo
//
//  Created by zhouqiang on 2018/5/9.
//  Copyright © 2018 Bluelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherRootClass.h"

@protocol AppProtocol <NSObject>

@optional
- (void)xpcDidLog:(NSString *)log array:(NSArray<NSString *> *)texts reply:(void(^)(NSString *text,WeatherRootClass *weather,Weather *today,NSArray<Weather *> *weathers))reply;
- (void)logFromXPC:(NSString *)log;
- (void)xpcDidReceive:(NSString *)text
              weather:(WeatherRootClass *)weather
                today:(Weather *)today
             weathers:(NSArray<Weather *> *)weathers;
@end

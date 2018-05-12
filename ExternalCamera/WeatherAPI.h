//
//  WeatherAPI.h
//  StatusBarMenu
//
//  Created by zhouqiang on 2018/5/2.
//  Copyright © 2018 Bluelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherRootClass.h"

@interface WeatherAPI : NSObject
+ (void)fetchWeather:(NSString *)query
            logBlock:(void(^)(NSString *log))logBlock
          completion:(void(^)(WeatherRootClass *weather,NSError *error))completion;
@end

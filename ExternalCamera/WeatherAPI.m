//
//  WeatherAPI.m
//  StatusBarMenu
//
//  Created by zhouqiang on 2018/5/2.
//  Copyright © 2018 Bluelich. All rights reserved.
//

#import "WeatherAPI.h"

NSString *AppID   = @"63506e9a364d07604f4a18704dce3e07";
NSString *BaseURL = @"https://api.openweathermap.org/data/2.5/weather";

@implementation WeatherAPI
+ (void)fetchWeather:(NSString *)query
            logBlock:(void(^)(NSString *log))logBlock
          completion:(void (^)(WeatherRootClass *weather,NSError *error))completion
{
    NSString *urlString = [NSString stringWithFormat:@"%@?APPID=%@&units=imperial&q=%@",BaseURL,AppID,query];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    logBlock([NSString stringWithFormat:@"=====>>>>> query weather info \n%@",urlString]);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"weather api error:%@",error);
            logBlock([NSString stringWithFormat:@"weather api error:%@",error]);
            !completion ?: completion(nil,error);
            return;
        }
        if ([response isKindOfClass:NSHTTPURLResponse.class]) {
            NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse *)response;
            NSInteger statusCode = httpURLResponse.statusCode;
            if (statusCode != 200) {
                NSString *errMsg = nil;
                if (statusCode == 401) {
                    errMsg = @"weather api returned an 'unauthorized' response. Did you set your API key?";
                }else{
                    errMsg = [NSString stringWithFormat:@"weather api returned response: %ld %@",statusCode,[NSHTTPURLResponse localizedStringForStatusCode:statusCode]];
                }
                NSError *error = [NSError errorWithDomain:@"[Wrong Status Code]" code:statusCode userInfo:@{NSLocalizedDescriptionKey:errMsg}];
                !completion ?: completion(nil,error);
                NSLog(@"error:%@",error);
            }else{
                NSError *error = nil;
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                NSLog(@"%@",dic);
                WeatherRootClass *model = [[WeatherRootClass alloc] initWithDictionary:dic];
                if (completion) {
                    completion(model,error);
                }
            }
        }
    }];
    [dataTask resume];
}
@end

//
//  ExternalCamera.m
//  ExternalCamera
//
//  Created by zhouqiang on 2018/5/7.
//  Copyright © 2018 Bluelich. All rights reserved.
//

#import "ExternalCamera.h"
#import "WeatherAPI.h"

@interface ExternalCamera ()
@property (weak) NSXPCConnection *xpcConnection;
@end

@implementation ExternalCamera
- (instancetype)initWithXPCConnection:(NSXPCConnection *)xpcConnection
{
    self = [super init];
    if (self) {
        _xpcConnection = xpcConnection;
    }
    return self;
}
- (void)prepare
{
    //Do nothing;
    [self.xpcConnection.remoteObjectProxy logFromXPC:@"xpc did prepare"];
}
- (void)log:(NSString *)log
{
    NSString *info = [NSString stringWithFormat:@"Log from XPC Target : %@",log];
    NSLog(@"%@",info);
    NSObject<AppProtocol> *xpcConnectionObject = [self.xpcConnection remoteObjectProxyWithErrorHandler:^(NSError * _Nonnull error) {
        if (error) {
            NSLog(@"xpc err:%@",error);
        }
    }];
    NSSet *set = [NSSet setWithArray:@[NSArray.class,Weather.class]];
    [self.xpcConnection.remoteObjectInterface setClasses:set forSelector:@selector(xpcDidLog:array:reply:) argumentIndex:3 ofReply:YES];
    [xpcConnectionObject xpcDidLog:info array:@[@"aaa",@"bbb"] reply:^(NSString *text,WeatherRootClass *weather,Weather *today,NSArray<Weather *> *weathers) {
        NSLog(@"text:%@",text);
        [xpcConnectionObject xpcDidReceive:text weather:weather today:today weathers:weathers];
    }];
}

- (void)requestWeather:(NSString *)city
            completion:(void (^)(WeatherRootClass *weather,NSError *error))completion
{
    __weak typeof(self) weakSelf = self;
    [WeatherAPI fetchWeather:city
                    logBlock:^(NSString *log) {
                        [weakSelf.xpcConnection.remoteObjectProxy logFromXPC:log];
                    } completion:completion];
}

@end

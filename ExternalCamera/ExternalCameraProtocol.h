//
//  ExternalCameraProtocol.h
//  ExternalCamera
//
//  Created by zhouqiang on 2018/5/7.
//  Copyright © 2018 Bluelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherRootClass.h"

// The protocol that this service will vend as its API. This header file will also need to be visible to the process hosting the service.
@protocol ExternalCameraProtocol

@optional

- (void)prepare;

- (void)log:(NSString *)log;

- (void)requestWeather:(NSString *)city
            completion:(void (^)(WeatherRootClass *weather,NSError *error))completion;

@end

/*
 To use the service from an application or other process, use NSXPCConnection to establish a connection to the service by doing something like this:

     _connectionToService = [[NSXPCConnection alloc] initWithServiceName:@"com.bluelich.ExternalCamera"];
     _connectionToService.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(ExternalCameraProtocol)];
     [_connectionToService resume];

Once you have a connection to the service, you can use it like this:

     [[_connectionToService remoteObjectProxy] upperCaseString:@"hello" withReply:^(NSString *aString) {
         // We have received a response. Update our text field, but do it on the main thread.
         NSLog(@"Result string was: %@", aString);
     }];

 And, when you are finished with the service, clean up the connection like this:

     [_connectionToService invalidate];
*/

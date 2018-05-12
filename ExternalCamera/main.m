//
//  main.m
//  ExternalCamera
//
//  Created by zhouqiang on 2018/5/7.
//  Copyright © 2018 Bluelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExternalCamera.h"
#import <YYModel.h>
#import "AppProtocol.h"

@interface ServiceDelegate : NSObject <NSXPCListenerDelegate>
@end

@implementation ServiceDelegate

- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection {
    newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(ExternalCameraProtocol)];
    ExternalCamera *obj = [[ExternalCamera alloc] initWithXPCConnection:newConnection];
    newConnection.exportedObject        = obj;
    newConnection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(AppProtocol)];
    [newConnection resume];
    return YES;
}

@end

int main(int argc, const char *argv[])
{
    ServiceDelegate *delegate = [ServiceDelegate new];
    // Set up the one NSXPCListener for this service. It will handle all incoming connections.
    NSXPCListener *listener = [NSXPCListener serviceListener];
    listener.delegate = delegate;
    [listener resume];
//    [NSProcessInfo.processInfo disableSuddenTermination];
//    [NSProcessInfo.processInfo disableAutomaticTermination:@"login agent"];
    [[NSRunLoop currentRunLoop] run];
    return 0;
}

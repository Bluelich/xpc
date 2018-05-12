//
//  ExternalCamera.h
//  ExternalCamera
//
//  Created by zhouqiang on 2018/5/7.
//  Copyright © 2018 Bluelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExternalCameraProtocol.h"
#import "AppProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface ExternalCamera : NSObject <ExternalCameraProtocol>

@property (weak,readonly) NSXPCConnection  *xpcConnection;

- (instancetype)initWithXPCConnection:(NSXPCConnection *)xpcConnection;

@end

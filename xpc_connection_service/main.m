//
//  main.m
//  xpc_connection_service
//
//  Created by zhouqiang on 2018/5/10.
//  Copyright © 2018 Bluelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XPCKit/XPCKit.h>

static void XPCService_event_handler(xpc_connection_t peer)
{
    xpc_connection_set_event_handler(peer, ^(xpc_object_t event) {
        //        XPCService_peer_event_handler(peer, event);
        xpc_type_t type = xpc_get_type(event);
        if (type == XPC_TYPE_ERROR) {
            if (event == XPC_ERROR_CONNECTION_INVALID) {
                //连接无效
            }else if (event == XPC_ERROR_TERMINATION_IMMINENT){
                //即将终止
            }
            return;
        }
        //处理业务
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfXPCObject:event];
        NSLog(@"\nxpc receive:%@",dictionary);
        {
            NSDictionary *dic = @{@"messageFromApp":dictionary,
                                  @"from":@"xpc"};
            NSLog(@"xpc send:%@",dic);
            xpc_object_t obj = [dic newXPCObject];
            xpc_connection_send_message(peer, obj);
        }
        
    });
    xpc_connection_resume(peer);
}

int main(int argc, const char *argv[])
{
    xpc_main(XPCService_event_handler);
    return 0;
}

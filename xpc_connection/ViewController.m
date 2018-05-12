//
//  ViewController.m
//  xpc_connection
//
//  Created by zhouqiang on 2018/5/10.
//  Copyright © 2018 Bluelich. All rights reserved.
//

#import "ViewController.h"
#import <XPCKit/XPCKit.h>

const char *xpc_connection_service_name = "com.bluelich.xpc-connection-service";

@interface ViewController ()
@property xpc_connection_t connection;
@property XPCConnection *mathConnection;
@property XPCConnection *readConnection;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test2];
    });
}
- (void)test1
{
    self.mathConnection = [[XPCConnection alloc] initWithServiceName:@"com.mustacheware.TestService"];
    self.mathConnection.eventHandler = ^(NSDictionary *message, XPCConnection *inConnection){
        NSNumber *result = [message objectForKey:@"result"];
        NSData *data = [message objectForKey:@"data"];
        NSFileHandle *fileHandle = [message objectForKey:@"fileHandle"];
        NSDate *date = [message objectForKey:@"date"];
        if(result){
            NSLog(@"We got a calculation result! %@", result);
        }else if(data || fileHandle){
            NSData *newData = [fileHandle readDataToEndOfFile];
            NSLog(@"We got a file handle! Read %ld bytes - %@", newData.length, fileHandle);
        }else if(date){
            NSLog(@"It is now %@", date);
        }
    };
    self.readConnection = [[XPCConnection alloc] initWithServiceName:@"com.mustacheware.TestService"];
    self.readConnection.eventHandler = ^(NSDictionary *message, XPCConnection *inConnection){
        NSData *data = [message objectForKey:@"data"];
        NSFileHandle *fileHandle = [message objectForKey:@"fileHandle"];
        if(data || fileHandle){
            NSData *newData = [fileHandle readDataToEndOfFile];
            if(newData){
                NSLog(@"We got maybe mapped data! %ld bytes - Equal? %@", data.length, ([newData isEqualToData:data] ? @"YES" : @"NO"));
            }
            NSLog(@"We got a file handle! Read %ld bytes - %@", newData.length, fileHandle);
        }
    };
    NSDictionary *multiplyData = @{@"operation":@"multiply",
                                   @"values":@[@7,@6,@1.67]};
    NSDictionary *readData = @{@"operation":@"read",
                               @"path":@"/Users/syco/Library/Safari/Bookmarks.plist"};
    NSData *loadedData = [[NSFileManager defaultManager] contentsAtPath:[readData objectForKey:@"path"]];
    NSFileHandle *loadedHandle = [NSFileHandle  fileHandleForReadingAtPath:[readData objectForKey:@"path"]];
    NSLog(@"Sandbox is %@ at path %@, got %ld bytes and a file handle %@",((loadedData.length == 0 && loadedHandle == nil) ? @"working" : @"NOT working"), [readData objectForKey:@"path"], loadedData.length, loadedHandle);
    
    [self.mathConnection sendMessage:multiplyData];
    [self.readConnection sendMessage:readData];
    [self.mathConnection sendMessage:@{@"operation":@"whatTimeIsIt"}];
}
- (void)test2
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self connect];
    });
}
- (void)connect
{
    dispatch_queue_t targetq = NULL;
    targetq = dispatch_get_main_queue();
    self.connection = xpc_connection_create(xpc_connection_service_name, targetq);
    xpc_connection_set_event_handler(self.connection, ^(xpc_object_t object){
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfXPCObject:object];
        NSLog(@"\napp receive:%@",dic);
    });
    xpc_connection_resume(self.connection);
    
    for (int i = 0; i < 100; i++) {
        [self sendMessage:@"test"];
        sleep(2);
    }
}
- (void)sendMessage
{
    xpc_object_t dictionary = xpc_dictionary_create(NULL, NULL, 0);
    xpc_dictionary_set_double(dictionary, "value1", 1.0);
    xpc_dictionary_set_double(dictionary, "value2", 2.0);
    xpc_connection_send_message(self.connection, dictionary);
}
- (void)sendMessage:(NSString *)message
{
    NSDictionary *dic = @{@"from"   :@"app",
                          @"message":message ?: @"null"};
    NSLog(@"\napp send:%@",dic);
    xpc_object_t obj = [dic newXPCObject];
    xpc_connection_send_message(self.connection, obj);
}
@end

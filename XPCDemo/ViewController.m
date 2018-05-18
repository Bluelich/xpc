//
//  ViewController.m
//  XPCDemo
//
//  Created by zhouqiang on 2018/5/7.
//  Copyright © 2018 Bluelich. All rights reserved.
//

#import "ViewController.h"
#import "ExternalCameraProtocol.h"
#import <YYModel.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ExternalCamera.h"
#import "AppProtocol.h"

@interface ViewController ()
<
NSXPCListenerDelegate,
AppProtocol
>
@property (weak) IBOutlet NSButton *connectButton;

@property (weak) IBOutlet NSTextView *textView;
@property (nonatomic,strong) AVCaptureView  *captureView;
@property (nonatomic,strong) NSXPCConnection *xpcConnection;
@property (nonatomic,strong) id<ExternalCameraProtocol> xpcConnectionObject;

@property (nonatomic,strong) NSArray<AVCaptureDevice *> *videoDevices;
@property (nonatomic,strong) AVCaptureDevice *defaultVideoDevice;
@property (nonatomic,strong) NSArray<AVCaptureDevice *> *audioDevices;
@property (nonatomic,strong) AVCaptureDevice *defaultAudioDevice;
@property (nonatomic,strong) WeatherRootClass *weatherInfo;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(deviceWasConnected:) name:AVCaptureDeviceWasConnectedNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(deviceWasDisconnected:) name:AVCaptureDeviceWasDisconnectedNotification object:nil];
}
- (void)setup
{
    [self reloadDevices];
    [self connect];
}
- (void)reloadDevices
{
    [self reloadVideoDevices];
    [self reloadAudioDevices];
}
- (void)reloadVideoDevices
{
    self.videoDevices       = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    self.defaultVideoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
}
- (void)reloadAudioDevices
{
    self.audioDevices       = [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio];
    self.defaultAudioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
}
- (void)printDevices:(NSArray<AVMediaType> *)mediaTypes
{
    if (mediaTypes.count == 0) {
        return;
    }
    NSMutableDictionary *devices = [NSMutableDictionary dictionary];
    if ([mediaTypes containsObject:AVMediaTypeVideo]) {
        [devices addEntriesFromDictionary:@{@"videoDevices"      :self.videoDevices,
                                            @"defaultVideoDevice":self.defaultVideoDevice}];
    }
    if ([mediaTypes containsObject:AVMediaTypeAudio]) {
        [devices addEntriesFromDictionary:@{@"audioDevices"      :self.audioDevices,
                                            @"defaultAudioDevice":self.defaultAudioDevice}];
    }
    NSLog(@"[device info:%@]\n%@",mediaTypes,devices.yy_modelDescription);
}
#pragma mark - AppProtocol
- (void)xpcDidLog:(NSString *)log array:(NSArray<NSString *> *)texts reply:(void (^)(NSString *text,WeatherRootClass *weather,Weather *today,NSArray<Weather *> *weathers))reply
{
    [self appendText:log];
    if (reply) {
        reply(@"successful",self.weatherInfo,self.weatherInfo.weather.firstObject,self.weatherInfo.weather);
    }
}
- (void)xpcDidReceive:(NSString *)text weather:(WeatherRootClass *)weather today:(Weather *)today weathers:(NSArray<Weather *> *)weathers
{
    [self appendText:[NSString stringWithFormat:@"%@ %@ %@ %@",text,weather,today,weathers]];
}
- (void)logFromXPC:(NSString *)log
{
    [self appendText:log];
}
#pragma mark - Notification
- (void)deviceWasConnected:(NSNotification *)noti
{
    AVCaptureDevice *device = noti.object;
    NSLog(@"deviceWasConnected : %@",device.yy_modelDescription);
    NSMutableArray<AVMediaType> *typesOfChanges = [NSMutableArray array];
    if ([device hasMediaType:AVMediaTypeVideo]) {
        [typesOfChanges addObject:AVMediaTypeVideo];
        [self reloadVideoDevices];
    }
    if ([device hasMediaType:AVMediaTypeAudio]) {
        [typesOfChanges addObject:AVMediaTypeAudio];
        [self reloadAudioDevices];
    }
    [self printDevices:typesOfChanges];
}
- (void)deviceWasDisconnected:(NSNotification *)noti
{
    AVCaptureDevice *device = noti.object;
    NSLog(@"deviceWasDisconnected : %@",device.yy_modelDescription);
    NSMutableArray<AVMediaType> *typesOfChanges = [NSMutableArray array];
    if ([device hasMediaType:AVMediaTypeVideo]) {
        [typesOfChanges addObject:AVMediaTypeVideo];
        [self reloadVideoDevices];
    }
    if ([device hasMediaType:AVMediaTypeAudio]) {
        [typesOfChanges addObject:AVMediaTypeAudio];
        [self reloadAudioDevices];
    }
    [self printDevices:typesOfChanges];
}
#pragma mark - Action
- (IBAction)connect:(NSButton *)sender
{
    [self connect];
}
- (IBAction)testLog:(NSButton *)sender
{
    [self.xpcConnectionObject log:@"test log"];
}
- (IBAction)clear:(NSButton *)sender
{
    self.textView.string = @"";
}
- (IBAction)request:(NSButton *)sender
{
    __weak typeof(self) weakSelf = self;
    [self.xpcConnectionObject requestWeather:@"Beijing" completion:^(WeatherRootClass *info, NSError *error) {
        if (error) {
            [weakSelf appendText:error.localizedDescription];
        }else{
            weakSelf.weatherInfo = info;
            [weakSelf appendText:info.yy_modelToJSONObject];
        }
        [weakSelf appendText:@"\n"];
    }];
}
#pragma mark - Other
- (void)connect
{
    self.xpcConnection = [[NSXPCConnection alloc] initWithServiceName:@"com.bluelich.ExternalCamera"];
    __weak typeof(self) weakSelf = self;
    [self.xpcConnection setInterruptionHandler:^{
        NSLog(@"Interruption handler");
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.connectButton.enabled = YES;
        });
    }];
    [self.xpcConnection setInvalidationHandler:^{
        NSLog(@"Invalidation handler");
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.connectButton.enabled = YES;
        });
    }];
    
    self.xpcConnection.exportedInterface     = [NSXPCInterface interfaceWithProtocol:@protocol(AppProtocol)];
    self.xpcConnection.exportedObject        = self;
    self.xpcConnection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(ExternalCameraProtocol)];
    [self appendText:@"connecting..."];
    [self.xpcConnection resume];
    NSSet *set = [NSSet setWithArray:@[NSArray.class,Weather.class]];
    [self.xpcConnection.exportedInterface setClasses:set forSelector:@selector(xpcDidReceive:weather:today:weathers:) argumentIndex:3 ofReply:NO];
    self.xpcConnectionObject = [self.xpcConnection remoteObjectProxyWithErrorHandler:^(NSError * _Nonnull error) {
        if (error) {
            [self appendText:@"connect failed"];
            [weakSelf appendText:error.localizedDescription];
        }
    }];
    if (self.xpcConnectionObject) {
        [self appendText:@"connected"];
        self.connectButton.enabled = NO;
        [self.xpcConnectionObject prepare];
    }
}
- (void)log:(NSString *)log
{
    [self appendText:log];
}
- (void)appendText:(NSString *)string
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableString *text = self.textView.string.mutableCopy;
        [text appendFormat:@"\n%@",string];
        self.textView.string = text;
        [self.textView scrollToEndOfDocument:self];
    });
}
@end

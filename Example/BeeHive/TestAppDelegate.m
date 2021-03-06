
//  TestAppDelegate.m
//  BeeHive
//
//  Created by 一渡 on 07/10/2015.
//  Copyright (c) 2015 一渡. All rights reserved.
//

#import "TestAppDelegate.h"
#import "BeeHive.h"
#import "BHService.h"
#import "BHTimeProfiler.h"

@interface TestAppDelegate ()


@end

@implementation TestAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    [BHContext shareInstance].application = application;
    [BHContext shareInstance].launchOptions = launchOptions;
    [BHContext shareInstance].moduleConfigName = @"BeeHive.bundle/BeeHive";//可选，默认为BeeHive.bundle/BeeHive.plist
    [BHContext shareInstance].serviceConfigName = @"BeeHive.bundle/BHService";
    
    [BeeHive shareInstance].enableExpection = YES;
    [[BeeHive shareInstance] setContext:[BHContext shareInstance]];
    [[BHTimeProfiler sharedTimeProfiler] recordEventTime:@"BeeHive::super start launch"];

    
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    
    id<HomeServiceProtocol> homeVc = [[BeeHive shareInstance] createService:@protocol(HomeServiceProtocol)];
    

    if ([homeVc isKindOfClass:[UIViewController class]]) {
        UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:(UIViewController*)homeVc];
        
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = navCtrl;
        
        [self.window makeKeyAndVisible];
    }
    
    return YES;
}


@end

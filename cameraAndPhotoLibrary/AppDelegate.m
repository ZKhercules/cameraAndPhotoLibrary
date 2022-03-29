//
//  AppDelegate.m
//  cameraAndPhotoLibrary
//
//  Created by zhangkeqin on 2022/3/29.
//

#import "AppDelegate.h"
#import "ZKMainViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ZKMainViewController alloc] init]];
    return YES;
}





@end

//
//  AppDelegate.m
//  Stahall
//
//  Created by frankfan on 14/12/9.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LeftMenuViewController.h"
#import "RESideMenu.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window =[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor =[UIColor whiteColor];
    
    MainViewController *mainViewController =[MainViewController new];
    UINavigationController *mainViewNavigationController =[[UINavigationController alloc]initWithRootViewController:mainViewController];
    [mainViewNavigationController setNavigationBarHidden:NO animated:NO];
    
    LeftMenuViewController *leftMenuVController =[[LeftMenuViewController alloc]init];
    
    /**
     创建侧边菜单
     */
    RESideMenu *sideMenu =[[RESideMenu alloc]initWithContentViewController:mainViewNavigationController leftMenuViewController:leftMenuVController rightMenuViewController:nil];
    
    sideMenu.backgroundImage =[UIImage imageNamed:@"backgroundImage"];
    sideMenu.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    sideMenu.panGestureEnabled = YES;
    
    
    self.window.rootViewController = sideMenu;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {


}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  
    
}

- (void)applicationWillTerminate:(UIApplication *)application {

    
}

@end

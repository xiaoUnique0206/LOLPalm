//
//  AppDelegate.m
//  LOLPalm
//
//  Created by 宋庆亮 on 16/1/21.
//  Copyright © 2016年 宋庆亮. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CommunityViewController *communityTVC = [[CommunityViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:communityTVC];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(Gap, Gap, Gap, Gap);
    flowLayout.itemSize = CGSizeMake((W-6*Gap)/3, (H-206)/3);
    VideoCollectionViewController *videoTVC = [[VideoCollectionViewController alloc]initWithCollectionViewLayout:flowLayout];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:videoTVC];

    HeroTableViewController *heroTVC = [[HeroTableViewController alloc]init];

    UICollectionViewFlowLayout *flowLayout1 = [[UICollectionViewFlowLayout alloc] init];
    flowLayout1.itemSize = CGSizeMake(130, 180);
    flowLayout1.sectionInset = UIEdgeInsetsMake(20, 20, 20, 30);

    InformationCollectionViewController *informationTVC = [[InformationCollectionViewController alloc]initWithCollectionViewLayout:flowLayout1];
    

    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:heroTVC];
    

    
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:informationTVC];
    
    UICollectionViewFlowLayout *flowLayoutA = [[UICollectionViewFlowLayout alloc] init];
    MoreCollectionViewController *moreTVC = [[MoreCollectionViewController alloc]initWithCollectionViewLayout:flowLayoutA];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:moreTVC];
    
           NSArray *array = @[nav1,nav2,nav3,nav4,nav5];
    UITabBarController *tabBar = [UITabBarController new];
    tabBar.viewControllers = array;
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = tabBar;
    tabBar.tabBar.barTintColor = [UIColor blackColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

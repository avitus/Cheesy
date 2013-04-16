//
//  CheesyAppDelegate.m
//  Cheesy
//
//  Created by Andy Vitus on 4/3/13.
//  Copyright (c) 2013 Andy Vitus. All rights reserved.
//

#import <Parse/Parse.h>

#import "CheesyAppDelegate.h"
#import "CheesyMasterViewController.h"
#import "CheeseTasting.h"

@implementation CheesyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Register Parse subclasses
    [CheeseTasting registerSubclass];
    
    // Set Parse Keys
    [Parse setApplicationId:@"bX7DUk8pjZub2OGeAzMaREQPIDn6MZHk8fBQIZew"
                  clientKey:@"tgbrjAFNQdyNJvaQ0fWKBhrczQ7ywOg21L5rVKtZ"];
    
    // Add Parse Analytics
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    // Override point for customization after application launch.
    [self customizeAppearance];
    
    return YES;
}

- (void)customizeAppearance
{
    //Set the status bar to black color.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
    
    // Customize navigation bar - http://www.raywenderlich.com/21703/user-interface-customization-in-ios-6
    // Create resizable images
    UIImage *gradientImage44 = [[UIImage imageNamed:@"navbar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
    UIImage *gradientImage32 = [[UIImage imageNamed:@"navbar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
    
    // Set the background image for *all* UINavigationBars
    [[UINavigationBar appearance] setBackgroundImage:gradientImage44 forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:gradientImage32 forBarMetrics:UIBarMetricsLandscapePhone];
    
    // Customize the title text for *all* UINavigationBars
//    [[UINavigationBar appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
//      UITextAttributeTextColor,
//      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
//      UITextAttributeTextShadowColor,
//      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
//      UITextAttributeTextShadowOffset,
//      [UIFont fontWithName:@"Arial-Bold" size:0.0],
//      UITextAttributeFont,
//      nil]];
    
    // Customize navigation button - http://www.raywenderlich.com/21703/user-interface-customization-in-ios-6
    UIImage *button30 = [[UIImage imageNamed:@"navbar-icon.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIImage *button24 = [[UIImage imageNamed:@"navbar-icon.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:button30 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:button24 forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    
//    [[UIBarButtonItem appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIColor colorWithRed:220.0/255.0 green:104.0/255.0 blue:1.0/255.0 alpha:1.0],
//      UITextAttributeTextColor,
//      [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0],
//      UITextAttributeTextShadowColor,
//      [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
//      UITextAttributeTextShadowOffset,
//      [UIFont fontWithName:@"AmericanTypewriter" size:0.0],
//      UITextAttributeFont,
//      nil]
//                                                forState:UIControlStateNormal];
    
    // Customize back button
    UIImage *buttonBack30 = [[UIImage imageNamed:@"back-button.png"]
                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
    UIImage *buttonBack24 = [[UIImage imageNamed:@"back-button.png"]
                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 5)];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack30
                                                      forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack24
                                                      forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end

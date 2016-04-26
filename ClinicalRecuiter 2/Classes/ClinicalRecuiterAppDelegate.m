//
//  ClinicalRecuiterAppDelegate.m
//  ClinicalRecuiter
//
//  Created by Hirak on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClinicalRecuiterAppDelegate.h"
#import "titleView.h"

@implementation ClinicalRecuiterAppDelegate

@synthesize window;
@synthesize dictTrailsListMain,tabBarController,dictUserData,arrSearchData,isFirstShow,dictTrailsList,isEditTrail;
@synthesize dicSubscribInfo;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
    
    // Override point for customization after application launch.

    // Add the tab bar controller's view to the window and display.
	isEditTrail = FALSE;
	isFirstShow = TRUE;
	
	titleView *obj = [[titleView alloc] init];
	
	dictUserData = [[NSMutableDictionary alloc] init];
	dictTrailsList = [[NSMutableDictionary alloc] init];
	dictTrailsListMain = [[NSMutableDictionary alloc] init];
	arrSearchData = [[NSMutableArray alloc] init];
	[self checkAndCreateDatabase];
    
    dicSubscribInfo = [[NSMutableDictionary alloc] init];
    self.tabBarController.delegate=self;
    
    
	
    [self.window addSubview:tabBarController.view];
	
	CGRect frame = CGRectMake(0.0, 0.0, 320, 48);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    [v setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabB.png"]]];
    [v setAlpha:1.0];
    //[tabBarController.view addSubview:v];
	//[tabBarController.tabBar insertSubview:v atIndex:0];
	[tabBarController.view insertSubview:v atIndex:0];
	[[tabBarController tabBar] insertSubview:v atIndex:0];
    [v release];
	
	
	[self.window addSubview:obj.view];
    [self.window makeKeyAndVisible];

//	splash =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]] ;
  //  splash.frame =CGRectMake(0, 20, 320, 460);
 //   [self.window addSubview:splash];
	
	//[self performSelector:@selector(removeSplash) withObject:nil afterDelay:15.0];
 //   [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(removeSplash) userInfo:nil repeats:NO];
	
	
    return YES;
}

-(void)removeSplash{
 
	[splash removeFromSuperview];
}

-(void) checkAndCreateDatabase
{
	BOOL success;
	
	NSString *databaseName = @"details.sqlite";
	NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	//NSLog(@"database path:%@",databasePath);
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	success = [fileManager fileExistsAtPath:databasePath];
	
	if(success) return;
	
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	[fileManager release];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	
	
//	splash =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]] ;
//    splash.frame =CGRectMake(0, 20, 320, 460);
//    [self.window addSubview:splash];
//	
//	//[self performSelector:@selector(removeSplash) withObject:nil afterDelay:15.0];
//    [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(removeSplash) userInfo:nil repeats:NO];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	
	
	
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end


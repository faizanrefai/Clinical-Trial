//
//  ClinicalRecuiterAppDelegate.h
//  ClinicalRecuiter
//
//  Created by Hirak on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClinicalRecuiterAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	NSString *databasePath;
	BOOL isFirstShow;
	BOOL isEditTrail;
	
	NSMutableDictionary *dictUserData;
	NSMutableArray *arrSearchData;
	NSMutableDictionary *dictTrailsList;
	NSMutableDictionary *dictTrailsListMain;
    
    
	
	UIImageView *splash;
}
@property (nonatomic,assign) NSMutableDictionary *dictTrailsListMain;
@property (nonatomic,assign) NSMutableDictionary *dictTrailsList;
@property (nonatomic,assign) BOOL isFirstShow;
@property (nonatomic,assign) BOOL isEditTrail;
@property (nonatomic,retain) NSMutableArray *arrSearchData;
@property (nonatomic,retain) NSMutableDictionary *dictUserData;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic,retain) NSMutableDictionary *dicSubscribInfo;


-(void) checkAndCreateDatabase;
@end

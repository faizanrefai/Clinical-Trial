//
//  SubscriptionInfoView.h
//  ClinicalRecuiter
//
//  Created by openxcell121 on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AddClinicalTrails.h"
#import "FTCoreTextView.h"

#import "ClinicalRecuiterAppDelegate.h"
#import "WSPContinuous.h"
#import "webService.h"
#import <StoreKit/StoreKit.h>
#import "CustomStoreObserver.h"

@interface SubscriptionInfoView : UIViewController <CustomStoreObserverDelegate,FTCoreTextViewDelegate> 

{

IBOutlet UIButton *profileBtn;
    
    CustomStoreObserver *paymentobserver;
    IBOutlet UILabel *plseWaitLbl;
    
    ClinicalRecuiterAppDelegate *appDelge;
    
    NSString *planStr;
    
    NSMutableDictionary *allkeysDic;

}

-(void)alertHandler;


@property (retain, nonatomic) IBOutlet UIButton *profileBtn;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollPlan;
@property (retain, nonatomic) IBOutlet UIButton *freePlanBtn;
@property (retain, nonatomic) IBOutlet UIButton *monthlyPlanBtn;
@property (retain, nonatomic) IBOutlet UIButton *yearlyPlanBtn;
@property (nonatomic, retain) FTCoreTextView *coreTextView;


-(IBAction)profileBtnPressed:(id)sender;
-(IBAction)freePlanBtnPressed:(id)sender;
-(IBAction)monthlyPlanBtnPressed:(id)sender;
-(IBAction)yearlyPlanBtnPressed:(id)sender;
- (NSString *)textForView;
- (NSArray *)coreTextStyle;

-(void)listOfTrail;


@end

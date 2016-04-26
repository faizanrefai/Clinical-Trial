//
//  EditTrialView.h
//  ClinicalRecuiter
//
//  Created by Hirak on 1/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertHandler.h"
#import "JSON.h"
#import "JSONParser.h"
#import "ClinicalRecuiterAppDelegate.h"
#import "myScrollView.h"

@interface EditTrialView : UIViewController <UIActionSheetDelegate,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
	ClinicalRecuiterAppDelegate *appDel;
	
	IBOutlet myScrollView *scrlView;
	
	IBOutlet UITextField *txtFrom;
	IBOutlet UITextField *txtTo;
	IBOutlet UITextField *txtDesc;
	IBOutlet UITextField *txtTitle;
	IBOutlet UITextField *txtName;
	IBOutlet UITextField *txtCreiteria;
	IBOutlet UIButton *btnYes;
	IBOutlet UIButton *btnNo;
	IBOutlet UITextView *txtView;
	IBOutlet UIImageView *imgCompBack;
	IBOutlet UIView *staticView;
	IBOutlet UIButton *btnAdd;
	IBOutlet UIButton *btnRemove;
	IBOutlet UIImageView *imgMain;
	
	UIDatePicker *pkrFrom;
	UIDatePicker *pkrTo;
	NSString *centerID;
	NSString *centerName;
	NSString *startDate;
	NSString *endDate;
	NSString *trailID;
	CGFloat animatedDistance;
	
	UIImageView *imgNew;
	UITextField *txtField;
	int fieldCount;
	NSMutableArray *myView_arr;
	
	NSString *msg;
}
@property(nonatomic,retain) UITextField *txtDesc;
@property(nonatomic,retain) UITextField *txtFrom;
@property(nonatomic,retain) UITextField *txtTo;
@property(nonatomic,retain) UIScrollView *scrlView;
@property(nonatomic,retain) UITextField *txtTitle;
@property(nonatomic,retain) UITextField *txtName;
@property(nonatomic,retain) UITextView *txtView;

-(IBAction)addClicked:(id)sender;
//-(IBAction)fromClicked:(id)sender;
//-(IBAction)toClicked:(id)sender;
-(IBAction)addCriteriaClicked:(id)sender;
-(IBAction)removeCriteriaClicked:(id)sender;
-(IBAction)backClicked:(id)sender;
-(IBAction)yesClicked:(id)sender;
-(IBAction)noClicked:(id)sender;

@end

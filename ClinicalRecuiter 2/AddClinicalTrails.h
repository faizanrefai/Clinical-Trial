//
//  AddClinicalTrails.h
//  ClinicalRecuiter
//
//  Created by Hirak on 1/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webService.h"
#import "WSPContinuous.h"
#import "AlertHandler.h"

#import "JSONParser.h"
#import "ClinicalRecuiterAppDelegate.h"
#import "myScrollView.h"



@interface AddClinicalTrails : UIViewController <
UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
	ClinicalRecuiterAppDelegate *appDel;
	
	IBOutlet myScrollView *scrlView;
	
	IBOutlet UITextField *txtFrom;
	IBOutlet UITextField *txtTo;
	IBOutlet UITextField *txtDesc;
	IBOutlet UITextField *txtTitle;
	IBOutlet UITextField *txtName;
	IBOutlet UITextField *txtIRBNum;
	
	IBOutlet UITextView *txtView;
	UIDatePicker *pkrFrom;
	UIDatePicker *pkrTo;
	NSString *centerID;
	NSString *centerName;
	NSString *startDate;
	NSString *endDate;
	NSString *trailID;
	
	UITextField *txtAlert;
	NSMutableArray *arrCriteria;
	NSArray *arr11;
	
	CGFloat animatedDistance;
	IBOutlet UIButton *btnYes;
	IBOutlet UIButton *btnNo;
    IBOutlet UIToolbar *toolbar;
	
	IBOutlet UIImageView *imgCompBack;
	
	IBOutlet UIView *staticView;
	IBOutlet UIButton *btnAdd;
	IBOutlet UIButton *btnRemove;
	IBOutlet UIImageView *imgMain;
	
	UIImageView *imgNew;
	UITextField *txtField;
	int fieldCount;
	NSMutableArray *myView_arr;
	
	NSData * dataImg;
	
	
	
}
@property (retain, nonatomic) IBOutlet UITextField *TxtCritearea;

@property(nonatomic,retain) UITextField *txtIRBNum;
@property(nonatomic,retain) UITextField *txtDesc;
@property(nonatomic,retain) UITextField *txtFrom;
@property(nonatomic,retain) UITextField *txtTo;
@property(nonatomic,retain) UIScrollView *scrlView;
@property(nonatomic,retain) UITextField *txtTitle;
@property(nonatomic,retain) UITextField *txtName;
@property(nonatomic,retain) UITextView *txtView;


- (IBAction)backPress:(id)sender;



-(IBAction)addClicked:(id)sender;
//-(IBAction)fromClicked:(id)sender;
//-(IBAction)toClicked:(id)sender;
-(IBAction)addCriteriaClicked:(id)sender;
-(IBAction)removeCriteriaClicked:(id)sender;
-(IBAction)backClicked:(id)sender;
-(IBAction)btnUpload:(id)sender;
-(IBAction)yesClicked:(id)sender;
-(IBAction)noClicked:(id)sender;
@end

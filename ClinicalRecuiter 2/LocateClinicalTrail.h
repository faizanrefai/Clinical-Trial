//
//  LocateClinicalTrail.h
//  ClinicalRecuiter
//
//  Created by Hirak on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
#import "LoginView.h"
#import "ClinicalRecuiterAppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/CALayer.h>


@interface LocateClinicalTrail : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UITextFieldDelegate>
{
	IBOutlet UITableView *tblView;
	IBOutlet UIPickerView *pickrTArea;
	IBOutlet UIPickerView *pickrLocation;
	//IBOutlet UILabel *lblSelectedItem;
	IBOutlet UITextField *txtSearch;
	IBOutlet UITextField *txtGPS;
	IBOutlet UITextField *txtMedical;
	IBOutlet UITextField *txtZip;
	IBOutlet UITextField *txtState;
	IBOutlet UIButton *btnrcName;
	IBOutlet UIButton *btnExpAre;
	IBOutlet UIButton *btnLocation;
	
	
	ClinicalRecuiterAppDelegate *appDel;
	NSString *countryId;
    NSMutableArray *arrStateName;
	int select;
	NSString *area;
	NSString *lati;
	NSString *longi;
	
	NSMutableArray *arrAutoSuggestData;
	NSString *selectedCenterID;
	
	NSMutableArray *arrArea;
	NSString *strAreSelected;
	NSMutableArray *arrLocation;
	NSString *strLocation;
	UIActivityIndicatorView *activityIndicatorpicker;
}
@property (nonatomic,retain) UITableView *tblView;
@property (nonatomic,retain) UITextField *txtSearch;
@property (nonatomic,retain) IBOutlet UITextField *txtGPS;
@property (nonatomic,retain) IBOutlet UITextField *txtMedical;
@property (nonatomic,retain) IBOutlet UITextField *txtZip;
@property (nonatomic,retain) IBOutlet UITextField *txtState;
@property (nonatomic,retain)NSString *countryId;
@property (nonatomic,retain)NSMutableArray *arrStateName;


-(void)GetCountryData;


-(IBAction) researchClicked:(id)sender;
-(IBAction) medicalClicked:(id)sender;
-(IBAction) locationClicked:(id)sender;
-(IBAction) tempClicked:(id)sender;

-(IBAction)searchClinicalClicked:(id)sender;
-(IBAction)showAllClicked :(id)sender;

@end

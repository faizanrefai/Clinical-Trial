//
//  DetailView.h
//  ClinicalRecuiter
//
//  Created by Hirak on 12/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webService.h"
#import "WSPContinuous.h"
#import "myScrollView.h"
#import "ClinicalRecuiterAppDelegate.h"
#import "DetailView.h"
#import "ALPickerView.h"
#import "AddClinicalTrails.h"
#import "ListTrails.h"
#import "EGOImageView.h"
#import "SubscriptionInfoView.h"

@interface DetailView : UIViewController <EGOImageViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,ALPickerViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
	ALPickerView *pickerView;
	ClinicalRecuiterAppDelegate *appDel;
	SubscriptionInfoView *objAdd ;
	IBOutlet myScrollView *scrlView;
		IBOutlet UIButton *btnPhoto;
	
	IBOutlet UIButton *btnAddTrails;
	IBOutlet UIButton *btnListTrails;
	IBOutlet UIButton *btnSubscribe;
	IBOutlet UIButton *researchBtnAdd;
	
	IBOutlet UITextView *txtExpAre;
	
    IBOutlet UITextField *rcAdd4;
	IBOutlet UITextField *rcUname;
	IBOutlet UITextField *rcName;
	IBOutlet UITextField *rcOverview;
	IBOutlet UITextField *rcAdd1;
	IBOutlet UITextField *rcAdd2;
	IBOutlet UITextField *rcAdd3;
    IBOutlet UITextField *rcBusinessNo;
	IBOutlet UITextField *rcFaxNo;
	IBOutlet UITextField *rcContactName;
	IBOutlet UITextField *rcEmail1;
    IBOutlet UITextField *rcEmail2;
	IBOutlet UITextField *rcURL;
	IBOutlet UITextField *rcArea;
	IBOutlet UITextField *rcMobileNO;
	IBOutlet UILabel *lblExpArea;
	IBOutlet UIButton *btnAreaExp;
	//IBOutlet UITextField *lblRBINum;
	
	NSArray *entries;
	NSMutableArray *arrayNo;
	NSMutableArray *arr11;
    NSURL *url;
    NSString * urlstring;
	NSMutableDictionary *selectionStates;
	
	BOOL isEdit;
	BOOL isFromLogin;
 	IBOutlet UIPickerView *pkrExpArea;
	
	NSString *strExpArea;
	NSString *countExpAre;
	NSString *userID;
	NSString *strImg;
	UIImagePickerController *picker;
	CGFloat animatedDistance;
    NSMutableArray *countriesDicArray,*stateNameArray;
    UIPickerView *pkrCountry;
    UIPickerView *pickerState;
    NSMutableString *countryId;

	IBOutlet UIBarButtonItem *rightBtn;
	IBOutlet UIBarButtonItem *BtnLogout;
	IBOutlet UIImageView *imgPhoto;
	IBOutlet UIButton *selectStateBtn;
    IBOutlet UIButton *selectCountryBtn;
	
	IBOutlet UIButton *btnToggle;
	
	IBOutlet UIImageView *lblAreaExpNew;
	IBOutlet UIImageView *imgAreaExpNew;
	IBOutlet UIImageView *bgImag;
    
    EGOImageView *myimageView2;
	
    NSDictionary *allkeysDic;
    
}
@property (nonatomic,retain) UIImageView *lblAreaExpNew;
@property (nonatomic,retain) UIImageView *imgAreaExpNew;
//@property (nonatomic,retain) UITextField *lblRBINum;
@property (nonatomic,retain) UITextView *txtExpAre;
@property (nonatomic,retain) UIImageView *imgPhoto;
@property (nonatomic,retain) UIImagePickerController *picker;
@property (nonatomic,retain) UIButton *btnPhoto;
@property (nonatomic,assign) UILabel *lblExpArea;
@property (nonatomic,assign) BOOL isFromLogin;
@property (nonatomic,retain) UIPickerView *pkrExpArea;
@property (nonatomic,retain) IBOutlet UITextField *rcUname;
@property (nonatomic,retain) IBOutlet UITextField *rcName;
@property (nonatomic,retain) IBOutlet UITextField *rcOverview;
@property (nonatomic,retain) IBOutlet UITextField *rcAdd1;
@property (nonatomic,retain) IBOutlet UITextField *rcAdd4;
@property (nonatomic,retain) IBOutlet UITextField *rcAdd2;
@property (nonatomic,retain) IBOutlet UITextField *rcAdd3;
@property (nonatomic,retain) IBOutlet UITextField *rcBusinessNo;
@property (nonatomic,retain) IBOutlet UITextField *rcFaxNo;
@property (nonatomic,retain) IBOutlet UITextField *rcContactName;
@property (nonatomic,retain) IBOutlet UITextField *rcEmail1;
@property (nonatomic,retain) IBOutlet UITextField *rcEmail2;
@property (nonatomic,retain) IBOutlet UITextField *rcURL;
@property (nonatomic,retain) IBOutlet UITextField *rcArea;
@property (nonatomic,retain) IBOutlet UITextField *rcMobileNO;
@property (nonatomic,retain) IBOutlet UIScrollView *scrlView;
@property (nonatomic,retain) UIPickerView *pkrCountry;

-(IBAction)toggleEditing :(id)sender;
//-(IBAction)researchCancelclicked:(id)sender;
-(IBAction)researchAddClicked:(id)sender;
-(IBAction)expAreaClicked:(id)sender;
-(IBAction)addTrailsClicked:(id)sender;
-(IBAction)listTrailsClicked:(id)sender;
-(IBAction)logoutClicked :(id)sender;
-(IBAction)photoClicked: (id)sender;
-(IBAction)onSbuscribe:(id)sender;
-(void)listOfTrail;

-(UIImage *)scaleImage:(UIImage*)image toResolution:(int)resolution;
-(void)GetCountryData;

@end

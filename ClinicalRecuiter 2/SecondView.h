//
//  SecondView.h
//  ClinicalRecuiter
//
//  Created by Hirak on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webService.h"
#import "WSPContinuous.h"
#import "myScrollView.h"
#import "ClinicalRecuiterAppDelegate.h"
#import "DetailView.h"
#import "NSDataAdditions.h"
#import "ALPickerView.h"


@interface SecondView : UIViewController <UINavigationControllerDelegate,ALPickerViewDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
	ClinicalRecuiterAppDelegate *appDel;
	ALPickerView *pickerView;
    
	IBOutlet UIImageView *areaOfExpLabel;
	IBOutlet myScrollView *scrlView;
	
	IBOutlet UIButton *researchBtnCancel;
	IBOutlet UIButton *researchBtnAdd;
		IBOutlet UIButton *btnAreaExp;
	IBOutlet UIButton *btnPhoto;
	
    IBOutlet UIButton *selectStateBtn;
    IBOutlet UIButton *selectCountryBtn;
    IBOutlet UITextField *rcConfPass;
	IBOutlet UITextField *rcUname;
	IBOutlet UITextField *rcPassword;
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
	IBOutlet UITextField *rcMobileNO;
	//IBOutlet UITextField *rcIRBNum;
	
    UIPickerView *pkrCountry;  
    UIPickerView *pickerState;

	IBOutlet UIImageView *imgPhoto;
	BOOL isPatient;
	
    IBOutlet UILabel *detailLable;
	NSMutableArray *arrayNo;
	NSMutableArray *arr11;
	NSArray *entries;
	NSMutableDictionary *selectionStates;
	
    IBOutlet UITextField *rcAdd4;
	UIImagePickerController *picker;
    NSURL *url;
    NSString * urlstring;
	NSString *strExpArea;
	NSString *countExpAre;
	NSString *strImg;
	CGFloat animatedDistance;
	IBOutlet UILabel *ExpAraMendatory;
    
    NSMutableArray *countriesDicArray,*stateNameArray;
    NSMutableString *countryId;
    
    BOOL isPicker;
    
    
}
@property (nonatomic,retain) UIPickerView *pickerState;
@property(nonatomic,retain) NSMutableString *countryId;
@property(nonatomic,retain)IBOutlet UITextField *rcAdd4;

@property (nonatomic,retain) UIImageView *imgPhoto;
@property (nonatomic,retain) UIImagePickerController *picker;
@property (nonatomic,retain) UIButton *btnPhoto;
@property (nonatomic,retain) UILabel *lblExp;
@property (nonatomic,readwrite) BOOL isPatient;
@property (nonatomic,retain) UIPickerView *pkrExpArea,*pkrCountry;
@property (nonatomic,retain)    NSMutableArray *countriesDicArray,*stateNameArray;

//@property (nonatomic,retain) IBOutlet UITextField *rcIRBNum;
@property (nonatomic,retain) IBOutlet UITextField *rcConfPass;
@property (nonatomic,retain) IBOutlet UITextField *rcUname;
@property (nonatomic,retain) IBOutlet UITextField *rcPassword;
@property (nonatomic,retain) IBOutlet UITextField *rcName;
@property (nonatomic,retain) IBOutlet UITextField *rcOverview;
@property (nonatomic,retain) IBOutlet UITextField *rcAdd1;
@property (nonatomic,retain) IBOutlet UITextField *rcAdd2;
@property (nonatomic,retain) IBOutlet UITextField *rcAdd3;
@property (nonatomic,retain) IBOutlet UITextField *rcBusinessNo;
@property (nonatomic,retain) IBOutlet UITextField *rcFaxNo;
@property (nonatomic,retain) IBOutlet UITextField *rcContactName;
@property (nonatomic,retain) IBOutlet UITextField *rcEmail1;
@property (nonatomic,retain) IBOutlet UITextField *rcEmail2;
@property (nonatomic,retain) IBOutlet UITextField *rcURL;
@property (nonatomic,retain) IBOutlet UITextField *rcMobileNO;
@property (nonatomic,retain) IBOutlet UIScrollView *scrlView;

//-(void)GDATA;
-(IBAction)researchCancelclicked:(id)sender;
-(IBAction)researchAddClicked:(id)sender;

-(IBAction)expAreaClicked:(id)sender;
-(IBAction)photoClicked: (id)sender;
-(IBAction)backClicked: (id)sender;
-(void)GetCountryData;
-(IBAction)countryButtonPressed;
-(IBAction)stateButtonPressed;
    
    


@end








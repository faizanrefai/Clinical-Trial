//
//  JoinAsPatient.h
//  ClinicalRecuiter
//
//  Created by Hirak on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClinicalRecuiterAppDelegate.h"
#import "myScrollView.h"
#import "ALPickerView.h"
#import "AlertHandler.h"

@interface DetailMail : UIViewController <ALPickerViewDelegate,UIActionSheetDelegate>
{
    IBOutlet UIButton *btnTextViewStudyInterest;
    IBOutlet UIButton *cancelButtonAgreementView;
    	IBOutlet UIButton *patBtnCancel;
	IBOutlet UIButton *patBtnAdd;
	IBOutlet UIButton *btnDOB;
	IBOutlet UIButton *btnMediHistory;
	IBOutlet UIButton *btnSave;
	IBOutlet UIButton *btnCancel;
	NSMutableArray *pickeArray;
	NSMutableArray *pickerDictionaryArray;
    
    UIDatePicker *dtPicker;
    
	IBOutlet UITextField *patName;
	IBOutlet UITextField *patAdd;
	IBOutlet UITextField *patAdd2;
	IBOutlet UITextField *patHome;
	IBOutlet UITextField *patMob;
	IBOutlet UITextField *patEmail;
	
	NSDictionary *reserchCenterDic;
	
	IBOutlet UILabel *txtView;
	int mediCount;

	NSString *dateFromString;
	NSMutableDictionary *dictUserData;
	
	ClinicalRecuiterAppDelegate *appDel;
	
	IBOutlet myScrollView *scrlView;
	
	ALPickerView *ALpicker;
	NSMutableDictionary *selectionStates;
	NSMutableArray *arr11;
	NSMutableArray *arrSavedData;
	NSString *strNewEntry;
    NSString *stringSelIntrestId;
	
	BOOL isNewRecord;
	
    BOOL loginFlag;
    
	NSString *randomString;
	}

@property(nonatomic,retain)	NSString *strNewEntry;
@property(nonatomic,retain) NSString *stringSelIntrestId;
@property(nonatomic,retain)NSMutableArray *pickeArray;

@property(nonatomic,retain)NSMutableDictionary *selectionStates;

@property(nonatomic,retain)NSMutableArray *arr11;

@property (nonatomic,retain)  UITextField *txtCaptchaName;
@property (nonatomic,retain)  UITextField *txtCaptcha;
@property (nonatomic,retain)  UITextField *patAdd2;
@property (nonatomic,retain)  UITextField *patHome;

@property (nonatomic,retain) myScrollView *scrlView;
@property (nonatomic,retain) UILabel *txtView;
@property (nonatomic,retain) IBOutlet UITextField *patName;
@property (nonatomic,retain) IBOutlet UITextField *patAdd;
@property (nonatomic,retain) IBOutlet UITextField *patMob;
@property (nonatomic,retain) IBOutlet UITextField *patEmail;
@property (nonatomic,retain) NSMutableArray *pickerDictionaryArray;
@property (nonatomic,retain) 	NSDictionary *reserchCenterDic;



-(IBAction)patCancelclicked:(id)sender;
-(IBAction)patAddClicked:(id)sender;
-(IBAction)dateOfBirthClicked:(id)sender;
-(IBAction)historyClicked:(id)sender;
-(void)resignResponderText;

-(void)upLoadDetail;
-(void)studyInterestWebserviceResponse:(NSDictionary*)dictionary;

- (void)animateTextField:(UITextField*) textField up: (BOOL) up ;
@end

//
//  JoinAsPatient.h
//  ClinicalRecuiter
//
//  Created by Hirak on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAL.h"
#import "ClinicalRecuiterAppDelegate.h"
#import "myScrollView.h"
#import "ALPickerView.h"
#import "AlertHandler.h"
#include "ProfileUpdateView.h"

@interface JoinAsPatient : UIViewController <ALPickerViewDelegate,UIScrollViewDelegate,UIScrollViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    IBOutlet UIButton *btnTextViewStudyInterest;
    IBOutlet UIButton *cancelButtonAgreementView;
        IBOutlet UIButton *loginBtn;
    IBOutlet UIView *loginView;
	IBOutlet UIButton *patBtnCancel;
	IBOutlet UIButton *patBtnAdd;
	IBOutlet UIButton *btnDOB;
	IBOutlet UIButton *btnMediHistory;
	IBOutlet UIButton *btnEdit;
	IBOutlet UIButton *btnSave;
	IBOutlet UIButton *btnCancel;
	NSMutableArray *pickeArray;
	NSMutableArray *pickerDictionaryArray;
    
	IBOutlet UITextField *patName;
	IBOutlet UITextField *patAdd;
	IBOutlet UITextField *patAdd2;
	IBOutlet UITextField *patAdd3;
	IBOutlet UITextField *patHome;
	IBOutlet UITextField *patMob;
	IBOutlet UITextField *patEmail;
	IBOutlet UIDatePicker *dtPicker;
	
	
	
	IBOutlet UITextView *txtView;
	int mediCount;
	IBOutlet UITextField *registrationUname;
  IBOutlet UITextField *registrationPass;

    IBOutlet UITextField *passTxtField;
    IBOutlet UITextField *unameTxtField;
	NSString *dateFromString;
	NSMutableDictionary *dictUserData;
	
    IBOutlet UIButton *joinBtn;
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

@property(nonatomic,retain) IBOutlet UITextField *registrationUname;
@property(nonatomic,retain) IBOutlet UITextField *registrationPass;
@property(nonatomic,retain)NSMutableArray *arr11;

@property(nonatomic,retain) IBOutlet UITextField *passTxtField;
@property(nonatomic,retain) IBOutlet UITextField *unameTxtField;
@property (nonatomic,retain)  UITextField *txtCaptchaName;
@property (nonatomic,retain)  UITextField *txtCaptcha;
@property (nonatomic,retain)  UITextField *patAdd2;
@property (nonatomic,retain)  UITextField *patAdd3;
@property (nonatomic,retain)  UITextField *patHome;

@property (nonatomic,retain) myScrollView *scrlView;
@property (nonatomic,retain) UITextView *txtView;
@property (nonatomic,retain) IBOutlet UITextField *patName;
@property (nonatomic,retain) IBOutlet UITextField *patAdd;
@property (nonatomic,retain) IBOutlet UITextField *patMob;
@property (nonatomic,retain) IBOutlet UITextField *patEmail;
@property (nonatomic,retain) NSMutableArray *pickerDictionaryArray;
@property (nonatomic,retain)IBOutlet UIButton *loginBtn;

-(IBAction)cancelButtonAgreementView;

-(IBAction)loginClicked;
-(IBAction)signUp;

-(IBAction)editClicked:(id)sender;
-(IBAction)patCancelclicked:(id)sender;
-(IBAction)patAddClicked:(id)sender;
-(IBAction)dateOfBirthClicked:(id)sender;
-(IBAction)historyClicked:(id)sender;
-(void)resignResponderText;
-(void)responseresult1:(NSDictionary *)dictinory;
-(void)responsePatientDetail:(NSDictionary *)dictinory;

-(void)upLoadDetail;
-(void)studyInterestWebserviceResponse:(NSDictionary*)dictionary;

-(NSString *)createUniqueIdentifier:(NSString *)withPrefix;
- (void)animateTextField:(UITextField*) textField up: (BOOL) up ;
@end

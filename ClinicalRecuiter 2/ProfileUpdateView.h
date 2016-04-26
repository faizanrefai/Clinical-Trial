//
//  ProfileUpdateView.h
//  ClinicalRecuiter
//
//  Created by openxcell121 on 3/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClinicalRecuiterAppDelegate.h"
#import "myScrollView.h"
#import "ALPickerView.h"
#import "AlertHandler.h"
#import "JoinAsPatient.h"
#import "titleView.h"
#import "JSON.h"
#import "JSONParser.h"

@class JoinAsPatient;

@interface ProfileUpdateView : UIViewController<ALPickerViewDelegate,UIScrollViewDelegate,UIScrollViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UITextFieldDelegate> {
    
    ALPickerView *ALpicker;
    JoinAsPatient *joinPatientobj;
    NSString   *dateFromString;
    NSMutableArray *pickerDataArray;
    NSMutableArray *pickerDictionaryDataArray;
    NSMutableDictionary *selectionStates;
	NSMutableArray *arr11;
	NSMutableArray *arrSavedData;
	NSString *strNewEntry;
    NSString *stringSelIntrestId;
    NSMutableArray *fileArray;
    
    
    IBOutlet UITextField *txtName;
    IBOutlet UITextField *txtHome;
    
    IBOutlet UIButton *saveBtn;
    IBOutlet UIButton *cancelBtn;
    IBOutlet UITextView *studyInterestTxtView;
    IBOutlet UIButton *studyinterestBtn;
    IBOutlet UIButton *selectBtn;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtmobile;
    IBOutlet UITextField *txtAdd3;
    IBOutlet UITextField *txtAdd2;
    IBOutlet UITextField *txtAddress;
    IBOutlet UIButton *editBtn;
    IBOutlet UIDatePicker *dtPicker;

    IBOutlet myScrollView *scrollView;
    
}


@property(nonatomic,retain) NSMutableDictionary *selectionStates;


-(IBAction)editClicked:(id)sender;
-(IBAction)dateOfBirthClicked:(id)sender;
-(IBAction)studyInterest:(id)sender;
-(IBAction)saveButtonClicked:(id)sender;
-(IBAction)cancelButtonClicked:(id)sender;

-(void)studyInterestWebserviceResponse:(NSDictionary*)dictionary;
-(void)upDatePatientInformation;
- (BOOL)validateEmailWithString:(NSString*)email11;
- (void)animateTextField:(UITextField*) textField up: (BOOL) up; 


@end

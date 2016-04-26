//
//  LoginView.h
//  EcoBurner
//
//  Created by apple on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResetPassword.h"
#import "SecondView.h"
#import "ClinicalRecuiterAppDelegate.h"
#import "DetailView.h"



@class SignUpView,SecondView,ResetPassword;

@interface LoginView : UIViewController <UIActionSheetDelegate,UITextFieldDelegate>
{
	IBOutlet UITextField *nameField;
	IBOutlet UITextField *passField;
	
	NSMutableArray *getDataArray;
	NSMutableDictionary *dataDict;
    SecondView *obj;
    IBOutlet UIButton *sponserBtn;
    DetailView *objDetail;
	
	ClinicalRecuiterAppDelegate *appDel;
	
	IBOutlet UIButton *btnProfe;
	IBOutlet UIButton *btnRemember;
	
}
@property (nonatomic ,retain) UIButton *btnProfe;
@property (nonatomic ,retain) UIButton *btnPatient;
@property (nonatomic ,retain) IBOutlet UITextField *nameField;
@property (nonatomic ,retain) IBOutlet UITextField *passField;
@property (nonatomic ,retain) NSMutableArray *getDataArray;
@property (nonatomic ,retain) NSMutableDictionary *dataDict;

-(IBAction) doneClicked;
-(IBAction) resetPassword:(id)sender;
-(IBAction) resetPassword:(id)sender;
-(IBAction) investigatorClicked:(id)sender;
-(IBAction) sponcerClicked:(id)sender;
-(IBAction) paticipentClicked:(id)sender;
-(IBAction) loginClicked:(id)sender;
-(IBAction) rememberClicked :(id)sender;
-(IBAction) tempClicked:(id)sender;


@end

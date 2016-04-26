//
//  ResetPassword.h
//  ClinicalRecuiter
//
//  Created by APPLE  on 11/9/11.
//  Copyright 2011 openxcel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "AlertHandler.h"
#import "JSONParser.h"

@interface ResetPassword : UIViewController <UITextFieldDelegate>
{
	IBOutlet UIButton *btnDone;
	
	IBOutlet UIButton *btnForgot;
	IBOutlet UIButton *btnChange;
	
	IBOutlet UIImageView *imgFirstText;
	IBOutlet UIImageView *imgSecondText;
	IBOutlet UIImageView *imgThirdText;
	
	IBOutlet UITextField *txtFirst;
	IBOutlet UITextField *txtSecond;
	IBOutlet UITextField *txtThird;
	
	BOOL isReset;
	
}
-(IBAction)forgotClicked:(id)sender;
-(IBAction)changeClicked:(id)sender;
-(IBAction)backClicked:(id)sender;
-(IBAction)resetClicked:(id)sender;
@end

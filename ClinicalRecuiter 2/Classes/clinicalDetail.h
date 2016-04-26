//
//  clinicalDetail.h
//  ClinicalRecuiter
//
//  Created by Hirak on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "ClinicalRecuiterAppDelegate.h"
#import "ContactDetail.h"
#import "DetailMail.h"
#import <QuartzCore/QuartzCore.h>

@interface clinicalDetail : UIViewController <UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate,MFMailComposeViewControllerDelegate>
{
    IBOutlet UILabel *investigatorLabel;

    IBOutlet UILabel *lblCompansation;
    IBOutlet UITextView *lblDesc;
    IBOutlet UIButton *btnContact;
	IBOutlet UILabel *lblName;
	IBOutlet UILabel *start;
	IBOutlet UILabel *end;
	IBOutlet UILabel *lblInvestiName;
	
    IBOutlet UIImageView *irbAdImage;
	IBOutlet UITextView *txtCompansation;
	IBOutlet UIScrollView *scrlView;
	
    IBOutlet UILabel *irbNolabel;
	IBOutlet UIView *staticView;
	ClinicalRecuiterAppDelegate *appDel;
	IBOutlet UIImageView *imgInvestiName;
	IBOutlet UIImageView *imgDescBack;
	IBOutlet UIImageView *imgCom;
	IBOutlet UIImageView *imgTitleBack;
	IBOutlet UIImageView *imgMainBack;
	IBOutlet UIImageView *imgCriteriaBack;
	IBOutlet UILabel *lblCriteria;
	
	UIImageView *imgNew;
	UITextField *txtField;
	
	IBOutlet UITextField *txtCreiteria;
}
@property(nonatomic,retain) IBOutlet UILabel *lblCompansation;

@property (nonatomic,retain) UITextField *txtCreiteria;
@property (nonatomic,retain) UIImageView *imgCriteriaBack;
@property (nonatomic,retain) UIImageView *imgMainBack;
@property (nonatomic,retain) UIImageView *imgTitleBack;
@property (nonatomic,retain) UILabel *lblCriteria;
@property (nonatomic,retain) UIScrollView *scrlView;
//@property (nonatomic,retain) UITextView *txtCreiteria;
@property (nonatomic,retain) UITextView *txtCompansation;
-(IBAction) mailBtnPressed:(id)sender;
//-(void)displayComposerSheet;
//-(void)launchMailAppOnDevice;

-(IBAction)backClicked:(id)sender;
@end

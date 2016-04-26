//
//  TrialDetailsView.h
//  ClinicalRecuiter
//
//  Created by Hirak on 1/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClinicalRecuiterAppDelegate.h"
#import "EditTrialView.h"

@interface TrialDetailsView : UIViewController <UITextFieldDelegate,UIScrollViewDelegate>
{
	ClinicalRecuiterAppDelegate *appDel;
	
	IBOutlet UIScrollView *scrlView;
	
    IBOutlet UILabel *irbLabel;
    IBOutlet UILabel *investigatorLabel;
	IBOutlet UILabel *lblName;
	IBOutlet UILabel *lblDesc;
	IBOutlet UILabel *lblInvestiName;
	IBOutlet UILabel *lblDuration;
	IBOutlet UILabel *lblVisit;
	IBOutlet UILabel *start;
    IBOutlet UILabel *irbTxtFld;
	IBOutlet UILabel *end;
	IBOutlet UITextField *txtCreiteria;
    IBOutlet UIImageView *irbBackImage;
	IBOutlet UITextView *txtCompansation;
	
    IBOutlet UIImageView *irbAdimage;
    IBOutlet UILabel *labelCompnsatin;
	
	IBOutlet UIView *staticView;
	//ClinicalRecuiterAppDelegate *appDel;
	
	IBOutlet UIImageView *imgDescBack;
	IBOutlet UIImageView *imgInvestiBack;
	
	IBOutlet UIImageView *imgCom;
	IBOutlet UIImageView *imgTitleBack;
	IBOutlet UIImageView *imgMainBack;
	IBOutlet UIImageView *imgCriteriaBack;
	IBOutlet UILabel *lblCriteria;
	
	UIImageView *imgNew;
	UITextField *txtField;
	
	IBOutlet UIButton *btnDeactive;
	NSString *key;
}
@property (nonatomic ,retain) UIScrollView *scrlView;
@property (nonatomic,retain) UIImageView *imgCom;
@property (nonatomic,retain) UIImageView *imgCriteriaBack;
@property (nonatomic,retain) UIImageView *imgMainBack;
@property (nonatomic,retain) UIImageView *imgTitleBack;
@property (nonatomic,retain) UILabel *lblCriteria;
@property (nonatomic,retain) UITextField *txtCreiteria;
@property (nonatomic,retain) UITextView *txtCompansation;

-(IBAction)backClicked:(id)sender;
-(IBAction)editClicked:(id)sender;
-(IBAction)deactiveClicked:(id)sender;
-(IBAction)deleteClicked:(id)sender;
@end

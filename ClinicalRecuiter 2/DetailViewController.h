//
//  DetailViewController.h
//  ClinicalRecuiter
//
//  Created by Hirak on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddTestimonials.h"
#import "AvailableClinical.h"
#import "webService.h"
#import "WSPContinuous.h"
#import "AlertHandler.h"
#import "JSONParser.h"
#import "JSON.h"
#import "EGOImageView.h"

@interface DetailViewController : UIViewController <EGOImageViewDelegate,UINavigationControllerDelegate,UITextViewDelegate,MFMailComposeViewControllerDelegate>
{
	//IBOutlet UIBarButtonItem *btnRight;
	IBOutlet UIButton *btnTesti;
	IBOutlet UIImageView *imgView;
    EGOImageView *myimageView2;
	IBOutlet UIButton *btnAvaClinic;
    IBOutlet UILabel *centerNameLabel;
	IBOutlet UITextView *txtView;
	NSString *userID;
	BOOL isPushed;
	
}
@property (nonatomic,retain) UITextView *txtView;

-(IBAction) addTestiPressed:(id)sender;
-(IBAction)availableClinicPressed :(id)sender;

-(IBAction)backClicked:(id)sender;
@end

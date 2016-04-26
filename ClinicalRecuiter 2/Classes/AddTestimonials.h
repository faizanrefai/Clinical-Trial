//
//  AddTestimonials.h
//  ClinicalRecuiter
//
//  Created by Hirak on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddTestimonials : UIViewController <UITextViewDelegate>
{
	IBOutlet UITextView *txtView;
	IBOutlet UIButton *btnAdd;
	IBOutlet UIButton *btnCancel;
}

@property (nonatomic,retain) IBOutlet UITextView *txtView;

-(IBAction) addPressed:(id)sender;
-(IBAction) cancelPressed:(id)sender;
@end

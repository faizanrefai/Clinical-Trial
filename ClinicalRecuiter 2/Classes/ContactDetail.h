//
//  ContactDetail.h
//  ClinicalRecuiter
//
//  Created by Hirak on 1/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAL.h"
#import "AlertHandler.h"

@interface ContactDetail : UIViewController 
{
	IBOutlet UILabel *lblName;
	IBOutlet UILabel *lblAdd1;
	IBOutlet UILabel *lblAdd2;
	IBOutlet UILabel *lblAdd3;
	IBOutlet UILabel *lblHome;
	IBOutlet UILabel *lblMobile;
	IBOutlet UILabel *lblEmail;
	IBOutlet UILabel *lblDOB;
	IBOutlet UITextView *lblInterest;
    NSMutableArray*  fileArray;
	
	DAL *objDal;
}

@property (nonatomic,retain) UILabel *lblName;
@property (nonatomic,retain) UILabel *lblAdd1;
@property (nonatomic,retain) UILabel *lblAdd2;
@property (nonatomic,retain) UILabel *lblAdd3;
@property (nonatomic,retain) UILabel *lblHome;
@property (nonatomic,retain) UILabel *lblMobile;
@property (nonatomic,retain) UILabel *lblEmail;
@property (nonatomic,retain) UILabel *lblDOB;
@property (nonatomic,retain) UITextView *lblInterest;

-(IBAction)cancelClicked:(id)sender;
-(IBAction)sendClicked:(id)sender;


@end

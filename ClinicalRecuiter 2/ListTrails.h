//
//  ListTrails.h
//  ClinicalRecuiter
//
//  Created by Hirak on 1/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "JSONParser.h"
#import "AlertHandler.h"
#import "AddClinicalTrails.h"
#import "ClinicalRecuiterAppDelegate.h"
#import "TrialDetailsView.h"

@interface ListTrails : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
	ClinicalRecuiterAppDelegate *appDel;
	
	IBOutlet UITableView *tblView;
	IBOutlet UITableViewCell *myCell;
	IBOutlet UITextView *txtTitle;
	IBOutlet UIButton *btnDisclosure;
	
	
	NSString *centerName;
	
	//IBOutlet UILabel *lblStart;
//	IBOutlet UILabel *lblEnd;
//	IBOutlet UILabel *lblTitle;
//	IBOutlet UILabel *lblName;
//	IBOutlet UITextView *txtCriteria;
//	IBOutlet UITextView *txtCompan;
	
	//IBOutlet UIButton *btnEdit;
//	IBOutlet UIButton *btnDeactivate;
}
@property (nonatomic ,retain) UITextView *txtTitle;
//@property (nonatomic ,retain) UIButton *btnEdit;
//@property (nonatomic ,retain) UIButton *btnDeactivate;
@property (nonatomic ,retain) UITableView *tblView;
@property (nonatomic ,retain) UITableViewCell *myCell;

//@property (nonatomic ,retain) UILabel *lblStart;
//@property (nonatomic ,retain) UILabel *lblEnd;
//@property (nonatomic ,retain) UILabel *lblTitle;
//@property (nonatomic ,retain) UILabel *lblName;
//@property (nonatomic ,retain) UITextView *txtCriteria;
//@property (nonatomic ,retain) UITextView *txtCompan;


@property (nonatomic,retain)NSMutableDictionary *detailDic;


-(IBAction)backClicked:(id)sender;
-(IBAction)detailClicked:(id)sender;
//-(IBAction)deactivateClicked:(id)sender;

@end

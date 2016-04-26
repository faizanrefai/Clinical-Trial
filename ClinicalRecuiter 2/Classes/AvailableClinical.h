//
//  AvailableClinical.h
//  ClinicalRecuiter
//
//  Created by Hirak on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "clinicalDetail.h"
#import "JSONParser.h"
#import "JSON.h"
#import "AlertHandler.h"
#import "ClinicalRecuiterAppDelegate.h"

@interface AvailableClinical : UIViewController <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
	IBOutlet UISearchBar *srchBar;
	IBOutlet UITableView *tblView;
	IBOutlet UITableViewCell *myCell;
	
	IBOutlet UITextView *txtView;
	NSMutableArray *arrayNo;
	NSMutableArray *finalArr;
	NSMutableDictionary *dataDict;
	
	IBOutlet UIButton *btnDisclosure;
	
	ClinicalRecuiterAppDelegate *appDel;
}
@property (nonatomic ,retain) UITextView *txtView;
@property (nonatomic ,retain) UITableViewCell *myCell;
@property (nonatomic ,retain) IBOutlet UISearchBar *srchBar;
@property (nonatomic ,retain) IBOutlet UITableView *tblView;
-(IBAction)backClicked:(id)sender;
-(IBAction)detailClicked:(id)sender;

@end
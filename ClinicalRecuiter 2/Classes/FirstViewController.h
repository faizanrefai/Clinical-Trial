//
//  FirstViewController.h
//  ClinicalRecuiter
//
//  Created by Hirak on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "LoginView.h"
#import "ClinicalRecuiterAppDelegate.h"


@interface FirstViewController : UIViewController <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
	IBOutlet UISearchBar *srchBar;
    IBOutlet UIButton *strBtn1;
    IBOutlet UIView *ratingView;
    IBOutlet UITableViewCell *custmCell;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *strBtn5;
    IBOutlet UIActivityIndicatorView *indicator;
    IBOutlet UIButton *strBtn2;
    IBOutlet UIButton *strBtn4;
    IBOutlet UIButton *strBtn3;
	IBOutlet UITableView *tblView;
	ClinicalRecuiterAppDelegate *appDel;
	NSMutableArray *classArray;
    
    NSMutableArray *ratingArry;
    
}
- (IBAction)starBtnPressed:(id)sender;

@property (nonatomic ,retain) IBOutlet UISearchBar *srchBar;
@property (nonatomic ,retain) IBOutlet UITableView *tblView;

-(IBAction)backClicked:(id)sender;
-(void)ratingWSCall:(NSURL*)url;

-(void)searchStringWithString:(NSString*)search;
@end

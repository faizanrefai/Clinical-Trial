//
//  DetailViewController.m
//  ClinicalRecuiter
//
//  Created by Hirak on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "EGOCache.h"
#import "DetailMail.h"


@implementation DetailViewController
@synthesize txtView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
-(IBAction)backClicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.



- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBarHidden = TRUE;
	//self.navigationItem.title =@"Details";
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_view.png"]];
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	[btnTesti setHidden:YES];
	userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"selectedUser"];
    

    
}







- (void)viewWillAppear:(BOOL)animated {
	if(isPushed)
		return;
	[AlertHandler showAlertForProcess];
	WSPContinuous *wspcontinuous;
	wspcontinuous = [[WSPContinuous alloc] initWithRequestForThread:[webService getURq_getansascreen:[webService getWS_profile:userID]] 
															rootTag:@"Record" 
														startingTag:[NSDictionary dictionaryWithObjectsAndKeys:nil] 
														  endingTag:[NSDictionary dictionaryWithObjectsAndKeys:@"research_center_id",@"research_center_id",@"username",@"username",@"research_center_name",@"research_center_name",@"overview",@"overview",@"center_photo",@"center_photo",@"address1",@"address1",@"address2",@"address2",@"address3",@"address3",@"business_number",@"business_number",@"fax_number",@"fax_number",@"contact_name",@"contact_name",@"contact_email1",@"contact_email1",@"contact_email2",@"contact_email2",@"URL",@"URL",@"expertise_area",@"expertise_area",@"mobile_number",@"mobile_number",@"role",@"role",@"center_status",@"center_status",nil] 
														  otherTags:[NSDictionary dictionaryWithObjectsAndKeys:nil] 
																sel:@selector(finisheParsing:) 
														 andHandler:self]; 
}
-(void)finisheParsing:(NSDictionary*)dictionary
{
	
//	NSLog(@"%@",dictionary);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=FALSE;

    
    [[NSUserDefaults standardUserDefaults]setValue:[[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"research_center_id"] forKey:@"reserchCenterId"];
    [[NSUserDefaults standardUserDefaults]synchronize];

   	[[NSUserDefaults standardUserDefaults] setValue:[[[dictionary valueForKey:@"array"] objectAtIndex:0]valueForKey:@"expertise_area"] forKey:@"exp_Area"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	txtView.text= [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"overview"];
	
    centerNameLabel.text= [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"research_center_name"];
    NSString *photoURL = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"center_photo"];
 //	imgView.imageURL =[NSURL URLWithString:photoURL];
    
   	//[[EGOCache currentCache]clearCache];
    [self performSelector:@selector(imgLoad:) withObject:photoURL afterDelay:2];

    
}

-(void)imgLoad:(NSString*)imgUrl{
    
    [[EGOCache currentCache]clearCache];

    myimageView2.image = nil;
    if(!myimageView2)
    {
        myimageView2 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"place_beinspire1_img.png"]];
        myimageView2.frame =CGRectMake(0, 0, 249, 136);
        myimageView2.delegate = self;
        [ imgView addSubview:myimageView2];
    }
    
//    myimageView2.imageURL = [NSURL URLWithString:[imgUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];    
    NSData *data =[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[imgUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]];
    myimageView2.image=[UIImage imageWithData:data];
    
    [AlertHandler hideAlert];
}

-(IBAction) addTestiPressed:(id)sender
{
	AddTestimonials *objAddTest = [[AddTestimonials alloc] initWithNibName:@"AddTestimonials" bundle:nil];
	[self.navigationController pushViewController:objAddTest animated:YES];
	[objAddTest release];
}
-(IBAction)availableClinicPressed :(id)sender
{
	isPushed =TRUE;
	AvailableClinical *objAvail = [[AvailableClinical alloc] initWithNibName:@"AvailableClinical" bundle:nil];
	[self.navigationController pushViewController:objAvail animated:YES];
	[objAvail release];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [centerNameLabel release];
    centerNameLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [centerNameLabel release];
    [super dealloc];
}


@end

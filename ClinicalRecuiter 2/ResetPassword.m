//
//  ResetPassword.m
//  ClinicalRecuiter
//
//  Created by APPLE  on 11/9/11.
//  Copyright 2011 openxcel. All rights reserved.
//

#import "ResetPassword.h"


@implementation ResetPassword

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_view.png"]];
    // Do any additional setup after loading the view from its nib.
	
	[imgFirstText setHidden:FALSE];
	[imgSecondText setHidden:FALSE];
	[imgThirdText setHidden:TRUE];
	
	[txtFirst setHidden:FALSE];
	[txtSecond setHidden:FALSE];
	[txtThird setHidden:TRUE];
	
	[btnForgot setSelected:YES];
	
}

-(IBAction)forgotClicked:(id)sender
{
	if ([btnForgot isSelected])
	{
		[btnForgot setSelected:NO];
		
		[imgFirstText setHidden:TRUE];
		[imgSecondText setHidden:TRUE];
		[imgThirdText setHidden:TRUE];
		
		[txtFirst setHidden:TRUE];
		[txtSecond setHidden:TRUE];
		[txtThird setHidden:TRUE];
		
		
	}
	else
	{
		isReset=FALSE;
		
		[imgFirstText setHidden:FALSE];
		[imgSecondText setHidden:FALSE];
		[imgThirdText setHidden:TRUE];
		
		[txtFirst setHidden:FALSE];
		[txtSecond setHidden:FALSE];
		[txtThird setHidden:TRUE];
		
		[txtFirst setPlaceholder:@"Username"];
		[txtSecond setPlaceholder:@"Email"];
		
		[btnForgot setSelected:YES];
		[btnChange setSelected:NO];
	}

}
-(IBAction)changeClicked:(id)sender
{
	if ([btnChange isSelected])
	{
		[btnChange setSelected:NO];
		
		[imgFirstText setHidden:TRUE];
		[imgSecondText setHidden:TRUE];
		[imgThirdText setHidden:TRUE];
		
		[txtFirst setHidden:TRUE];
		[txtSecond setHidden:TRUE];
		[txtThird setHidden:TRUE];
	}
	else
	{
		isReset=TRUE;
		
		[imgFirstText setHidden:FALSE];
		[imgSecondText setHidden:FALSE];
		[imgThirdText setHidden:FALSE];
		
		[txtFirst setHidden:FALSE];
		[txtSecond setHidden:FALSE];
		[txtThird setHidden:FALSE];
		
		[txtFirst setPlaceholder:@"Username"];
		[txtSecond setPlaceholder:@"Old Password"];
		[txtThird setPlaceholder:@"New Password"];
		
		[btnChange setSelected:YES];
		[btnForgot setSelected:NO];
	}
}
-(IBAction)resetClicked:(id)sender
{
	NSString *urlString;
	if (isReset==FALSE)
	{
		urlString = [NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/forgot_password.php?username=%@&email=%@",txtFirst.text,txtSecond.text];
	}
	else
	{
		urlString = [NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/change_password.php?username=%@&opassword=%@&npassword=%@",txtFirst.text,txtSecond.text,txtThird.text];
	}
	
	urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[AlertHandler showAlertForProcess];
	urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];	
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];

}
-(void)searchResult:(NSDictionary*)dictionary
{
	[AlertHandler hideAlert];
	NSLog(@"%@",dictionary);
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Password Changed Successfully!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[txtFirst resignFirstResponder];
	[txtSecond resignFirstResponder];
	[txtThird resignFirstResponder];
}
-(IBAction)backClicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

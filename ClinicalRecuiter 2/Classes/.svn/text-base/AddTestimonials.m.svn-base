//
//  AddTestimonials.m
//  ClinicalRecuiter
//
//  Created by Hirak on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddTestimonials.h"


@implementation AddTestimonials
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBarHidden = TRUE;
	self.navigationItem.title =@"Add Testimonial";
}

-(IBAction) addPressed:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(IBAction) cancelPressed:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (void)textViewDidEndEditing:(UITextView *)textView
{
	[txtView resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

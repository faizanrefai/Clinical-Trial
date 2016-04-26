//
//  MyBlog.m
//  ClinicalRecuiter
//
//  Created by openxcell121 on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyBlog.h"

@implementation MyBlog
@synthesize webViewing;


-(void)webViewDidStartLoad:(UIWebView *)webView{

 [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; 
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [webViewing stopLoading];

}

#pragma mark - View lifecycle
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
    [webViewing stopLoading];

}
-(void)viewWillAppear:(BOOL)animated{
   
    NSURLRequest *url = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://clinicaltrialrecruiter.com/forum/"]];
    [webViewing loadRequest:url];

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
        // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setWebViewing:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [webViewing release];
    [super dealloc];
}
@end

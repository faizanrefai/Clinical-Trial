//
//  LoginView.m
//  EcoBurner
//
//  Created by apple on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginView.h"
#import "AlertHandler.h"
#import "titleView.h"

@implementation LoginView
@synthesize nameField,passField,getDataArray,dataDict,btnProfe,btnPatient;

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
- (void)viewDidLoad 
{
    [super viewDidLoad];

	appDel = (ClinicalRecuiterAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.navigationController.navigationBarHidden = TRUE;
	UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleBordered target:self action:@selector(tempClicked:)];
	self.navigationItem.leftBarButtonItem = leftBtn;
	[leftBtn release];

	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
	
    [sponserBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [btnProfe setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
	dataDict = [[NSMutableDictionary alloc] init];
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}
-(IBAction) tempClicked:(id)sender
{
	titleView *objTitle = [[titleView alloc] initWithNibName:@"titleView" bundle:nil];
	appDel.isFirstShow=FALSE;
	[self presentModalViewController:objTitle animated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];	
	NSString *unameStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"uname"];
	NSString *passStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"pass"];	
	if ([unameStr length]>0){
		[btnRemember setSelected:YES];
	}
	else{
		[btnRemember setSelected:NO];
	}	
	nameField.text =unameStr;
	passField.text =passStr;
	[btnPatient setHidden:YES];	
	[btnProfe setSelected:NO];
	[btnPatient setSelected:NO];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(IBAction) rememberClicked :(id)sender{
	if ([btnRemember isSelected]){
		[[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"uname"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		[[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"pass"];
		[[NSUserDefaults standardUserDefaults] synchronize];		
		[btnRemember setSelected:NO];
	}
	else{
		[[NSUserDefaults standardUserDefaults] setValue:nameField.text forKey:@"uname"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		[[NSUserDefaults standardUserDefaults] setValue:passField.text forKey:@"pass"];
		[[NSUserDefaults standardUserDefaults] synchronize];		
		[btnRemember setSelected:YES];
	}
}

-(IBAction) investigatorClicked:(id)sender{
    if(obj){
        obj =nil;
        [obj release];
    }
    
    obj = [[SecondView alloc] initWithNibName:@"SecondView" bundle:nil];

    obj.isPatient = FALSE;
	if ([btnProfe isSelected]){
		[btnProfe setSelected:NO];
	}
	else{
		[btnProfe setSelected:YES];
		[btnPatient setSelected:NO];
	}	
        
    obj.isPatient = FALSE;
    [appDel.dictUserData setValue:@"Investigator Center" forKey:@"role"];
   
    [self.navigationController pushViewController:obj animated:YES];

        
}
-(IBAction) sponcerClicked:(id)sender{
	

    if(obj){
        obj =nil;
        [obj release];
    }
    obj = [[SecondView alloc] initWithNibName:@"SecondView" bundle:nil];

	if ([sponserBtn isSelected]){
		[sponserBtn setSelected:NO];
	}
	else{
		[sponserBtn setSelected:YES];
		[sponserBtn setSelected:NO];
	}	

    obj.isPatient = TRUE;
        [appDel.dictUserData setValue:@"Sponcer" forKey:@"role"];
    [self.navigationController pushViewController:obj animated:YES];
    
}
-(IBAction) paticipentClicked:(id)sender{
	if ([btnPatient isSelected]){
		[btnPatient setSelected:NO];
	}
	else{
		[btnPatient setSelected:YES];
		[btnProfe setSelected:NO];
	}
	
	obj.isPatient= TRUE;
	[appDel.dictUserData setValue:@"Participants" forKey:@"role"];
	UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Sign Up",nil];
	action.tag=2;
	action.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[action showInView:self.tabBarController.tabBar];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (actionSheet.tag==1){
		if (buttonIndex==0){
			obj.isPatient = TRUE;
			
			[appDel.dictUserData setValue:@"Sponcer" forKey:@"role"];
			[self.navigationController pushViewController:obj animated:YES];
		}
		else if (buttonIndex==1){
			obj.isPatient = FALSE;
			[appDel.dictUserData setValue:@"Investigator Center" forKey:@"role"];
			[self.navigationController pushViewController:obj animated:YES];
		}
		else{
			[btnProfe setSelected:NO];
		}

	}
	else if (actionSheet.tag==2){ 
		if (buttonIndex==0){
			[self.navigationController pushViewController:obj animated:YES];
		}
		else{
			[btnPatient setSelected:NO];
		}

	}

}

//-(IBAction) signupClicked:(id)sender
//{
//	[self.navigationController pushViewController:obj animated:YES];
//}

-(IBAction) resetPassword:(id)sender{
	
	ResetPassword *ResetPassObj = [[ResetPassword alloc] initWithNibName:@"ResetPassword" bundle:nil];
	[self.navigationController pushViewController:ResetPassObj animated:YES];
}

-(IBAction) loginClicked:(id)sender{
		
	[nameField resignFirstResponder];
	[passField resignFirstResponder];
	    
    if ([passField.text length]!=0 && [nameField.text length]!=0 ) {
        
        
        [AlertHandler showAlertForProcess];
        WSPContinuous *wspcontinuous;
        wspcontinuous = [[WSPContinuous alloc] initWithRequestForThread:[webService getURq_getansascreen:[webService getWS_login:nameField.text :passField.text]] 
                                                                rootTag:@"Record" 
                                                            startingTag:[NSDictionary dictionaryWithObjectsAndKeys:nil] 
                                                              endingTag:[NSDictionary dictionaryWithObjectsAndKeys:@"research_center_id",@"research_center_id",@"msg",@"msg",nil] 
                                                              otherTags:[NSDictionary dictionaryWithObjectsAndKeys:nil] 
                                                                    sel:@selector(finisheParsing:) 
                                                             andHandler:self];
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Enter Username and Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert setTag:589];
		[alert show];
        [alert release];
        
    }

    if ([btnRemember isSelected]){
		[[NSUserDefaults standardUserDefaults] setValue:nameField.text forKey:@"uname"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		[[NSUserDefaults standardUserDefaults] setValue:passField.text forKey:@"pass"];
		[[NSUserDefaults standardUserDefaults] synchronize];		
		[btnRemember setSelected:YES];
	}
    	
}

-(void)finisheParsing:(NSDictionary*)dictionary{
    
    	[AlertHandler hideAlert];
	NSLog(@" duc %@",dictionary);
	
	NSString *msg = [[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"msg"];
	
	
	if ([msg isEqualToString:@"Login successful"])
	{
		NSString *userId = [[NSString alloc] initWithFormat:@"%@",[[[dictionary valueForKey:@"array"] objectAtIndex:0] valueForKey:@"research_center_id"]];
		[[NSUserDefaults standardUserDefaults]setValue:userId forKey:@"userProfileID"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [appDel.dictUserData setValue:userId forKey:@"uid"];
        if (objDetail) {
            objDetail=nil;
            [objDetail release];
        }
        
		objDetail = [[DetailView alloc] initWithNibName:@"DetailView" bundle:nil];
		
		objDetail.isFromLogin=TRUE;
		UINavigationController *naviCOntroller = [[UINavigationController alloc] initWithRootViewController:objDetail];
		naviCOntroller.navigationBar.tintColor=[UIColor blackColor];
		[self.navigationController presentModalViewController:naviCOntroller animated:YES];
    }
	else
	{
		if ([msg length]==0) {
            msg = @"NO Connection Found";
        }
        
        if ([msg isEqualToString:@"Please activate your account check your mail."]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please activate your account check your mail." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release]; 
        }
        else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username or Password Incorrect.\n Please Retry or Change Reset Username or Password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
        }
	}
}
-(IBAction) doneClicked
{
			[self dismissModalViewControllerAnimated:YES];

}

#pragma mark -
#pragma mark text field methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[nameField resignFirstResponder];
	[passField resignFirstResponder];
	return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [sponserBtn release];
    sponserBtn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [sponserBtn release];
    [super dealloc];
}


@end

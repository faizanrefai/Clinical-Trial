//
//  ContactDetail.m
//  ClinicalRecuiter
//
//  Created by Hirak on 1/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ContactDetail.h"
#import "JSONParser.h"


@implementation ContactDetail
@synthesize lblName,lblAdd1,lblAdd2,lblAdd3,lblHome,lblMobile,lblEmail,lblDOB,lblInterest;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}

-(void)responsePatientDetail:(NSDictionary *)dictinory{
    
    [AlertHandler hideAlert];
  
    //This method is response of the web services called in View will appear 
    
    lblName.text  = [dictinory  valueForKey:@"name"];
    lblAdd1.text   = [dictinory valueForKey:@"address1"];
    lblAdd2.text  = [dictinory  valueForKey:@"address2"];
    lblAdd3.text  = [dictinory valueForKey:@"address3"];
    lblHome.text  = [dictinory  valueForKey:@"home"];
    lblMobile.text = [dictinory  valueForKey:@"mobile_number"];
    lblEmail.text = [dictinory  valueForKey:@"contact_email"];
  fileArray = [[NSMutableArray alloc] initWithArray:[ [dictinory  valueForKey:@"study_interest"]componentsSeparatedByString:@","]]; 
    
    [lblDOB setText:[dictinory valueForKey:@"birthdate"] ];
    

    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad {
    [super viewDidLoad];
	    
	//objDal = [[DAL alloc] init];
	//[objDal initDatabase:@"details.sqlite"];
	
//	NSMutableArray *dictData  = [[NSMutableArray alloc] init];
	//dictData = [objDal SelectWithStar:@"user_details"];
    
    NSString *stateUrl1=[[NSString alloc ]initWithFormat:@"http://openxcelluk.info/clinical/web_services/patient_profile.php?id=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Patient_id"]];
    
   // NSLog(@"%@",stateUrl1);
    
    NSMutableURLRequest *request1=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:stateUrl1]];
    JSONParser *parser1 = [[JSONParser alloc] initWithRequestForThread:request1 sel:@selector(responsePatientDetail:) andHandler:self];
  //  NSLog(@"%@",parser1);

    // Patient study Interest -  Webservices start
    
    
    NSString *str_planturl=[NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/study_interest_area_list.php"];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_planturl]];
	JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(studyInterestWebserviceResponse:) andHandler:self];
    NSLog(@"%@",parser);
    
    // Patient study Interest - Webservices End
    
    [AlertHandler showAlertForProcess];


	
}
-(void)studyInterestWebserviceResponse:(NSDictionary*)dictionary{
    
    //This method is response of the web services called in View will appear 
    
    NSMutableString *tempString = [[NSMutableString alloc]init];
    NSMutableString *tempString1 = [[NSMutableString alloc]init];
    
 NSMutableArray*   pickerDictionaryDataArray = [[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"study_interest_areas"]];
    lblInterest.text=@"";

    int j= 0;
    int i =0;
    
for (i=0; i<[pickerDictionaryDataArray count]; i++) {
      
    tempString = [[[[dictionary valueForKey:@"study_interest_areas"]objectAtIndex:i]valueForKey:@"interest_area"]retain];
      //  [pickerDataArray addObject:tempString];
        
        for (j=0;j<=[fileArray count]-1;j++ ) {
            
            
            if ([[[pickerDictionaryDataArray objectAtIndex:i]valueForKey:@"id"]  isEqual:[fileArray objectAtIndex:j]]) {
                
                tempString1=  [[[pickerDictionaryDataArray objectAtIndex:i]valueForKey:@"interest_area"]retain];
                
                //  studyInterestTxtView.text =   [studyInterestTxtView.text stringByAppendingFormat:tempString1];
                
                if (j==0)
                {
                    lblInterest.text = [[lblInterest.text stringByAppendingString:[NSString stringWithFormat:@"%@",tempString1]]retain];
                    
                }
                else if(j<=[fileArray count]-1)
                {
                    lblInterest.text = [[lblInterest.text stringByAppendingString:[NSString stringWithFormat:@",%@",tempString1]]retain];
                }
            }
		
			lblInterest.text = [lblInterest.text retain];
            
        }
    } 
    
    [tempString release];
    [tempString1 release];
    
    [AlertHandler hideAlert];
    
}


-(void)viewDidAppear{

}



-(IBAction)cancelClicked:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}
-(IBAction)sendClicked:(id)sender{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you" message:@"Your Contact Details Were Sent!\n The Center Will Be Contacting You Shortly." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

	[self dismissModalViewControllerAnimated:YES];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

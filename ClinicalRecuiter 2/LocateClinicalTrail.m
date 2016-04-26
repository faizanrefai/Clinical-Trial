//
//  LocateClinicalTrail.m
//  ClinicalRecuiter
//
//  Created by Hirak on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocateClinicalTrail.h"
#import "AlertHandler.h"
#import "titleView.h"

@implementation LocateClinicalTrail
@synthesize txtGPS,txtMedical,txtZip,txtState,txtSearch,tblView,countryId,arrStateName;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (void)dealloc {
    [super dealloc];
	[activityIndicatorpicker release];
    [countryId release];
    [arrStateName release];
    [arrLocation release];
    [txtGPS release];
    [txtMedical release];
    [txtZip release];
}

-(void)GetCountryData {
    NSString *str_planturl=[NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/country.php"];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_planturl]];
	JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
    NSLog(@"%@",parser);    
}

-(void)searchResult:(NSDictionary*)dictionary {
    arrLocation = [[NSMutableArray alloc] init];
	arrLocation=[[dictionary valueForKey:@"countries"]mutableCopy];
}	

-(void)getStateData:(id)sender {  
	NSString *str_planturl=[NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/states.php?cid=%@",sender];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_planturl]];
	JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResultState:) andHandler:self];
	NSLog(@"%@",parser);       
}

-(void)searchResultState:(NSDictionary*)dictionary{
	[activityIndicatorpicker stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    arrStateName=[[dictionary valueForKey:@"states"]mutableCopy];  
    [pickrLocation reloadComponent:1];  
}	


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];	    
    countryId= @"239";
	selectedCenterID =@"1";
    arrStateName = [[NSMutableArray alloc] init];    
    [self GetCountryData];
    [self getStateData:countryId];   
    tblView.separatorColor = [UIColor blackColor];
	appDel = (ClinicalRecuiterAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	self.navigationController.navigationBarHidden = TRUE;
	self.navigationItem.title = @"Locate a Clinical Trial";
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];	
	[tblView setHidden:YES];	
	UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleBordered target:self action:@selector(tempClicked:)];
	self.navigationItem.leftBarButtonItem = leftBtn;
	[leftBtn release];	
	arrArea = [[NSMutableArray alloc] initWithObjects:@"Cardiology/Vascular",@"Dental/Maxillofacial",@"Dermatology/Plastic",@"Endocrinology",@"Gastroenterology",@"Hematology",@"Immunology/ID",@"Internal Medicine",@"Musculoskeletal",@"Nephrology/Urology",@"Neurology",@"OBGYN",@"Opthalmology",@"Orthopedics",@"Otolaryngology",@"Pediatric/Neonate",@"Pharmacology/Tox",@"Podiatry",@"Psychiatry",@"Pulmonary",@"Rheumatology",@"Sleep Medicine",@"Trauma/Emergency",@"Healthy Patients",nil];	
}

-(void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:YES];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_view.png"]];	
	[arrAutoSuggestData removeAllObjects];
	[tblView reloadData];	
	txtSearch.text=@"";
	[btnLocation setSelected:NO];
	[btnExpAre setSelected:NO];
	select=1;
	[btnrcName setSelected:YES];	    
    tblView.layer.masksToBounds = YES;
    tblView.layer.borderColor= [UIColor blackColor].CGColor;
    tblView.layer.borderWidth=1;    
    [self.view addSubview:tblView];  
     
}

-(IBAction) tempClicked:(id)sender {
	titleView *objTitle = [[titleView alloc] initWithNibName:@"titleView" bundle:nil];
	appDel.isFirstShow=FALSE;
	[self presentModalViewController:objTitle animated:NO];
}

#pragma mark -
#pragma mark Picker Methods


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    if (pickerView.tag==2) {
        return 2;
    }else{
    return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
	if (pickerView.tag==1)
	{
		return [arrArea count];
	}
    else if (pickerView.tag==2)
	{
		if (component ==0) {
          
            return [arrLocation count];
            
        }if (component==1) {
            
            if ([arrStateName count]>0) {
                
                return [arrStateName count];                
            }            
        }
	}
	return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
	if (pickerView.tag==1)
	{
		return [arrArea objectAtIndex:row];
	}
	else if (pickerView.tag==2)
	{
		
        if (component==0) {
            return [[arrLocation objectAtIndex:row]valueForKey:@"country"];
        }if (component==1) {
            
            if ([arrStateName count]>0) {
              return [[arrStateName objectAtIndex:row]valueForKey:@"state"];
            }
        }
	}
	return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (pickerView.tag==1)
	{
		selectedCenterID = [[NSString alloc] initWithFormat:@"%d",row+1];
		strAreSelected = [[NSString alloc] initWithFormat:@"%@",[arrArea objectAtIndex:row]];
	}
	else if (pickerView.tag==2)
	{
		if (component==0) {
            strLocation = [[[NSString alloc] initWithFormat:@"%@",[[arrLocation objectAtIndex:row]valueForKey:@"country"]]retain];
            countryId= [[[arrLocation objectAtIndex:row]valueForKey:@"cid"]retain];
            
			if(!activityIndicatorpicker){
				activityIndicatorpicker = [[UIActivityIndicatorView alloc] 
										   initWithFrame:CGRectMake(225.0f, 95.0f, 30.0f, 30.0f)];				
			}
			
			[activityIndicatorpicker setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
			activityIndicatorpicker.hidesWhenStopped =YES;
			activityIndicatorpicker.hidden =FALSE;
			[pickrLocation addSubview:activityIndicatorpicker];
			
			[activityIndicatorpicker startAnimating];
			
			[arrStateName removeAllObjects];
			[pickrLocation reloadComponent:1];
            [self performSelector:@selector(getStateData:) withObject:countryId afterDelay:1];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            
        }if (component==1) {
            
            if ([arrStateName count]>0) {
        
                strAreSelected = [[[NSString alloc] initWithFormat:@"%@",[[arrStateName objectAtIndex:row]valueForKey:@"state"]]retain];
            }
        }
	}
}


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrAutoSuggestData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	// Configure the cell.
	
	if (select==1)
	{
		cell.textLabel.text= [[arrAutoSuggestData objectAtIndex:indexPath.row] valueForKey:@"research_center_name"];
	}
	else if (select==2)
	{
		cell.textLabel.text= [[arrAutoSuggestData objectAtIndex:indexPath.row] valueForKey:@"expertise_name"];
	}	
	cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (select==1) {
		txtSearch.text   = [[arrAutoSuggestData objectAtIndex:indexPath.row] valueForKey:@"research_center_name"];
		selectedCenterID = [[arrAutoSuggestData objectAtIndex:indexPath.row] valueForKey:@"research_center_id"];
	}
	
	[tblView setHidden:YES];
}

-(IBAction) researchClicked:(id)sender{	
	select=1;
	txtSearch.text=@"";
	txtSearch.enabled =TRUE;	
	[btnrcName setSelected:YES];
	[btnExpAre setSelected:NO];
	[btnLocation setSelected:NO];
	[txtSearch becomeFirstResponder];
	
}
-(IBAction) medicalClicked:(id)sender {	
	[txtSearch resignFirstResponder];
	txtSearch.enabled =FALSE;
	select=2;
	[tblView setHidden:TRUE];
	[btnExpAre setSelected:YES];
	[btnrcName setSelected:NO];
	[btnLocation setSelected:NO];
	
	pickrTArea = [[UIPickerView alloc] init];
	pickrTArea.delegate=self;
	pickrTArea.dataSource=self;
	[pickrTArea setShowsSelectionIndicator:YES];
	[pickrTArea selectRow:1 inComponent:0 animated:NO];
	[pickrTArea setTag:1];		
	UIActionSheet *actionResearch = [[UIActionSheet alloc] initWithTitle:@"Pickup Time\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Set" otherButtonTitles:nil];
	actionResearch.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[actionResearch setBounds:CGRectMake(0, 0, 320, 250)];
	actionResearch.tag=1;
	[actionResearch addSubview:pickrTArea];
	[actionResearch showInView:self.tabBarController.view];
	[pickrTArea reloadAllComponents];
}

-(IBAction) locationClicked:(id)sender {
	[txtSearch resignFirstResponder];
	txtSearch.enabled =FALSE;
	select=3;
	[tblView setHidden:TRUE];
	[btnLocation setSelected:YES];
	[btnrcName setSelected:NO];
	[btnExpAre setSelected:NO];	
	pickrLocation = [[UIPickerView alloc] init];
	pickrLocation.delegate=self;
	pickrLocation.dataSource=self;
	[pickrLocation setShowsSelectionIndicator:YES];
    [pickrLocation setTag:2];	
	UIActionSheet *actionLocation = [[UIActionSheet alloc] initWithTitle:@"Pickup Time\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Set" otherButtonTitles:nil];
	actionLocation.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[actionLocation setBounds:CGRectMake(0, 0, 320, 250)];
	actionLocation.tag=2;
	[actionLocation addSubview:pickrLocation];
	[actionLocation showInView:self.tabBarController.view];
	
    if(!activityIndicatorpicker){
        
		activityIndicatorpicker = [[UIActivityIndicatorView alloc] 
								   initWithFrame:CGRectMake(225.0f, 95.0f, 30.0f, 30.0f)];
        
	}
	
	[activityIndicatorpicker setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
	activityIndicatorpicker.hidesWhenStopped =YES;
	activityIndicatorpicker.hidden =FALSE;
	[pickrLocation addSubview:activityIndicatorpicker];
	[activityIndicatorpicker startAnimating];
	[arrStateName removeAllObjects];
	[pickrLocation reloadComponent:1];
	[self getStateData:countryId];
	[pickrLocation selectedRowInComponent:0];
    [pickrLocation selectRow:238 inComponent:0 animated:NO];
    [pickrLocation reloadAllComponents];

	
}

-(IBAction)searchClinicalClicked:(id)sender
{
	if ([txtSearch.text length]==0)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Enter Keyword" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else 
	{
		if (select==1)
		{
			[AlertHandler showAlertForProcess];
			
			NSString *urlString = [NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/search_key.php?type=research_center_name&key=%@",txtSearch.text];
			
			urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];	
			NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
			JSONParser *parser;
			parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchClicked:) andHandler:self];
			
		}
		else if(select==2)
		{
			[AlertHandler showAlertForProcess];
			
			NSString *urlString = [NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/search_key.php?type=expertise_area&key=%@",selectedCenterID];
			
			urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];	
			NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
			JSONParser *parser;
			parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchClicked:) andHandler:self];
			
		}
		else if (select==3)
		{
			[AlertHandler showAlertForProcess];
			
			NSString *urlString = [NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/search_key.php?type=addr&key=%@",txtSearch.text];
			
			urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];	
			NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
			JSONParser *parser;
			parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchClicked:) andHandler:self];
		}
		else
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Select Criteria" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	}

}
-(IBAction)showAllClicked :(id)sender
{
	select = 4;
	[AlertHandler showAlertForProcess];
	WSPContinuous *wspcontinuous;
	wspcontinuous = [[WSPContinuous alloc] initWithRequestForThread:[webService getURq_getansascreen:[webService getWS_allCenter]] 
															rootTag:@"Record" 
														startingTag:[NSDictionary dictionaryWithObjectsAndKeys:nil] 
														  endingTag:[NSDictionary dictionaryWithObjectsAndKeys:@"research_center_id",@"research_center_id",@"research_center_name",@"research_center_name",@"rating",@"rating",nil] 
														  otherTags:[NSDictionary dictionaryWithObjectsAndKeys:nil] 
																sel:@selector(searchClicked:) 
														 andHandler:self];
}

-(void)searchClicked:(NSDictionary*)dictionary {
	[AlertHandler hideAlert];
	[appDel.arrSearchData removeAllObjects];
	
	if (select==1 || select==2 || select==3)
	{
		if ([[dictionary valueForKey:@"msg"] isEqualToString:@"no data found"])
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Data Found.\n Please Try Again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		else
		{
			appDel.arrSearchData = [dictionary valueForKey:@"centers"];
		}
	}
	else
	{
		appDel.arrSearchData = [dictionary valueForKey:@"array"];
	}
	
	//NSLog(@"%@",[appDel.arrSearchData objectAtIndex:0]);
	if ([appDel.arrSearchData count]>0)
	{
		NSString *msg = [[[dictionary valueForKey:@"centers"] objectAtIndex:0] valueForKey:@"msg"];
		if (msg==nil)
		{
			FirstViewController *objFirst = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
			[self.navigationController pushViewController:objFirst animated:YES];
			[objFirst release];
		}
		else
		{
//			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			[alert show];
//			[alert release];
		}
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex==0)
	{
		if (actionSheet.tag==1)
		{
			strAreSelected = [arrArea objectAtIndex:[pickrTArea selectedRowInComponent:0]];
			txtSearch.text = strAreSelected;
		}
		else if (actionSheet.tag==2)
		{
			
            strLocation = [[[arrLocation objectAtIndex:[pickrLocation selectedRowInComponent:0]]valueForKey:@"country"]retain];
          
            if ([arrStateName count]>0) {
              
            strAreSelected=[[[arrStateName objectAtIndex:[pickrLocation selectedRowInComponent:1]]valueForKey:@"state"]retain];
            }
            txtSearch.text =[NSString   stringWithFormat:@"%@,%@",strAreSelected,strLocation];
            
            [arrStateName removeAllObjects];
			[pickrLocation reloadComponent:1];
			[self performSelector:@selector(getStateData:) withObject:nil afterDelay:0.5];
		}
	}
}

-(void)webServiceFireForTable{

    WSPContinuous *wspcontinuous;
	wspcontinuous = [[WSPContinuous alloc] initWithRequestForThread:[webService getURq_getansascreen:[webService getWS_allCenter]] 
															rootTag:@"Record" 
														startingTag:[NSDictionary dictionaryWithObjectsAndKeys:nil] 
														  endingTag:[NSDictionary dictionaryWithObjectsAndKeys:@"research_center_id",@"research_center_id",@"research_center_name",@"research_center_name",nil] 
														  otherTags:[NSDictionary dictionaryWithObjectsAndKeys:nil] 
																sel:@selector(dataSearch:) 
														 andHandler:self];
  
    
}
-(void)dataSearch:(NSDictionary*)dictionary {
    
	//NSLog(@"%@",dictionary);
	
    tblView.hidden=FALSE;
    
    arrAutoSuggestData = [[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"array"]];	
	int rowCount = [arrAutoSuggestData count];
	
	if (rowCount<4)
	{
		tblView.frame = CGRectMake(37, 150, 234,30*rowCount);
	}
	else
	{
		tblView.frame = CGRectMake(37, 150, 234,85);
	}
	
    [tblView reloadData];
 
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	
    [self webServiceFireForTable];  
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *substring = [NSString stringWithString:textField.text];
	substring = [substring stringByReplacingCharactersInRange:range withString:string];
	//NSLog(@"%@",substring);
	
	    
	if (select==3)
	{
	}
	else
	{
		NSString *urlString;
		if (select==1)
		{
			urlString = [NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/search_key.php?type=research_center_name&key=%@",substring];
		}
		else if (select==2)
		{
			urlString = [NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/search_key.php?key=%@",substring];
		}
		
		if ([substring isEqualToString:@""] ) {
            
            [tblView setHidden:YES];
        }
        else{
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];	
		NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
		JSONParser *parser;
		parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult4:) andHandler:self];
        }
	}
    
	return YES;
}

-(void)searchResult4:(NSDictionary*)dictionary
{
    [AlertHandler hideAlert];
	//NSLog(@"%@",dictionary);
	tblView.hidden=FALSE;
        
    if (select==1)
	{
		arrAutoSuggestData = [[[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"centers"]] retain];
	}
	else if (select==2)
	{
		arrAutoSuggestData = [[[NSMutableArray alloc] initWithArray:[dictionary valueForKey:@"expertise_area"]] retain];
	}	
	int rowCount = [arrAutoSuggestData count];
	if (rowCount<4)
	{
		tblView.frame = CGRectMake(37, 150, 234,30*rowCount);
	}
	else
	{
		tblView.frame = CGRectMake(37, 150, 234,85);
	}

    if ([txtSearch.text length]==0) {
        [self webServiceFireForTable];
    }
    
	[tblView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[tblView setHidden:YES];
	[textField resignFirstResponder];
	return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}
- (void)viewDidDisappear:(BOOL)animated
{
	[txtSearch resignFirstResponder];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end

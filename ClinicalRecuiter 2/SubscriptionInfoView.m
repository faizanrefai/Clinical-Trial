//
//  SubscriptionInfoView.m
//  ClinicalRecuiter
//
//  Created by openxcell121 on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubscriptionInfoView.h"
#import "JSON.h"
#import "NSDataAdditions.h"
#import "EGOImageView.h"

@implementation SubscriptionInfoView
@synthesize profileBtn;
@synthesize scrollPlan;
@synthesize freePlanBtn;
@synthesize monthlyPlanBtn;
@synthesize yearlyPlanBtn;
@synthesize coreTextView;


#pragma mark - View lifecycle

- (void)dealloc {
    [profileBtn release];
    [scrollPlan release];
    [scrollPlan release];
    [freePlanBtn release];
    [monthlyPlanBtn release];
    [yearlyPlanBtn release];
    [plseWaitLbl release];
    [super dealloc];
}


- (void)productPurchased:(NSString *)productId
{
	NSLog(@"hello");
}


-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    
    [self listOfTrail];
    
    
    
    NSString *payment_expiry_date = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_expiry_date"];
    
    NSString *payment_plan = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_plan"];
    //  NSString *payment_status = [[[appDel.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_status"];
    
    // Date comparision
    
    NSDate *Date1 = [NSDate date];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
	[dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    
    NSDate *Date2 = [dateFormat dateFromString:payment_expiry_date];  
    
    NSComparisonResult result = [Date1 compare:Date2];
    
    
    if (result==NSOrderedAscending) {
        
               
        NSLog(@"payment_expiry_date  Date2 is in the future");
        
    } else if (result==NSOrderedDescending) {
        
                NSLog(@"payment_expiry_date  Expired dates");
        freePlanBtn.userInteractionEnabled=TRUE;
        monthlyPlanBtn.userInteractionEnabled=TRUE;
        yearlyPlanBtn.userInteractionEnabled=TRUE;
        freePlanBtn.enabled=TRUE;
        monthlyPlanBtn.enabled=TRUE;
        
        
    } else if(result==NSOrderedSame) {
        
        NSLog(@"payment_expiry_date  Both dates are the same");
        
        if ([payment_expiry_date isEqualToString:@"0000-00-00"]) {
            
            freePlanBtn.userInteractionEnabled=TRUE;
            monthlyPlanBtn.userInteractionEnabled=TRUE;
            yearlyPlanBtn.userInteractionEnabled=TRUE;
            freePlanBtn.enabled=TRUE;
            monthlyPlanBtn.enabled=TRUE;

                        
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    scrollPlan.layer.borderColor= [UIColor colorWithRed:30.0/255.0 green:86.00/255.0 blue:131.0/255.0 alpha:1].CGColor;
    scrollPlan.layer.borderWidth = 1.50;
    scrollPlan.layer.cornerRadius =16.0;
     
    allkeysDic =[[NSMutableDictionary alloc]init];
    
    appDelge = (ClinicalRecuiterAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    planStr  = [[NSString alloc]init];
    // Store Kit Manager In App Purchase

    
    //  Core Text Statement
    
	//scrollPlan.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    coreTextView = [[FTCoreTextView alloc] initWithFrame:CGRectMake(10, 10,scrollPlan.frame.size.width-20,scrollPlan.frame.size.height-20)];
	
    coreTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    // set text
    [coreTextView setText:[self textForView]];
    // set styles
    [coreTextView addStyles:[self coreTextStyle]];
    // set delegate
    [coreTextView setDelegate:self];
	
	[coreTextView fitToSuggestedHeight];
       [scrollPlan addSubview:coreTextView];
    [scrollPlan setContentSize:CGSizeMake(CGRectGetWidth(scrollPlan.bounds), CGRectGetHeight(coreTextView.frame) + 40)];
    
    
    [freePlanBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [monthlyPlanBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [yearlyPlanBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    
    
    NSString *Payment_create_date = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"Payment_create_date"];
    
    NSString *payment_expiry_date = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_expiry_date"];
    
    NSString *payment_plan = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_plan"];
    
    NSString *payment_status = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_status"];
    
    
    if ([payment_plan isEqualToString:@"Free-Plan"]) {
        
        monthlyPlanBtn.selected=FALSE;
        freePlanBtn.selected=TRUE;
        yearlyPlanBtn.selected=FALSE;
        planStr =@"Free-Plan";
        
        
    }else if([payment_plan isEqualToString:@"Monthly-Plan"]) {
        
        monthlyPlanBtn.userInteractionEnabled=FALSE;
        freePlanBtn.selected=FALSE;
        freePlanBtn.enabled=FALSE;
        monthlyPlanBtn.selected=TRUE;   
        yearlyPlanBtn.selected=FALSE;
        planStr =@"Monthly-Plan";

        
    }else if([payment_plan isEqualToString:@"Yearly-Plan"]) {
        
        freePlanBtn.selected=FALSE;
        yearlyPlanBtn.userInteractionEnabled=FALSE;
        monthlyPlanBtn.selected=FALSE;
        freePlanBtn.enabled=FALSE;
        monthlyPlanBtn.enabled=FALSE;
        yearlyPlanBtn.selected=TRUE;
        planStr =@"Yearly-Plan";
        
    }
    
}


-(void)listOfTrail
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=TRUE;
    
    NSString *centerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"userProfileID"];
    
	NSString *urlString = [NSString stringWithFormat:@"http://openxcelluk.info/clinical/web_services/list_trial.php?research_center_id=%@",centerID];
	urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];	
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
	JSONParser *parser;
    parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(listOfTrailReslt:) andHandler:self];
    
}


-(void)listOfTrailReslt:(NSDictionary*)dic
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=FALSE;
    
    NSLog(@"%@", [dic valueForKey:@"trials"] );
    
    if ([[dic valueForKey:@"msg"] isEqualToString:@"no trial found"]) {
        
        return;
    }
    
    [allkeysDic setValuesForKeysWithDictionary:nil];

    [allkeysDic setValuesForKeysWithDictionary:dic];
    
    
    
    NSString *Payment_create_date = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"Payment_create_date"];
    
    NSString *payment_expiry_date = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_expiry_date"];
    
    NSString *payment_plan = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_plan"];
    
    NSString *payment_status = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_status"];
    
    
    if ([payment_plan isEqualToString:@"Free-Plan"]) {
        
        monthlyPlanBtn.selected=FALSE;
        freePlanBtn.selected=TRUE;
        yearlyPlanBtn.selected=FALSE;
        planStr =@"Free-Plan";
       
        
        if ([[[allkeysDic valueForKey:@"trials"] allKeys] count]==3)
        {
            
            monthlyPlanBtn.selected=FALSE;
            freePlanBtn.selected=TRUE;
            yearlyPlanBtn.selected=FALSE;
            freePlanBtn.userInteractionEnabled=FALSE;
            planStr =@"Free-Plan";
            
        } 
    }
        
        
}


- (void)viewDidUnload
{
    [self setProfileBtn:nil];
    [scrollPlan release];
    scrollPlan = nil;
    [self setScrollPlan:nil];
    [self setFreePlanBtn:nil];
    [self setMonthlyPlanBtn:nil];
    [self setYearlyPlanBtn:nil];
    [plseWaitLbl release];
    plseWaitLbl = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (BOOL)isPosition:(UITextPosition *)position withinTextUnit:(UITextGranularity)granularity inDirection:(UITextDirection)direction{
    
    return YES;

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



#pragma mark - IBAction Division

-(IBAction)profileBtnPressed:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];

}
-(IBAction)freePlanBtnPressed:(id)sender{
     
    monthlyPlanBtn.selected=FALSE;
    freePlanBtn.selected=TRUE;
    yearlyPlanBtn.selected=FALSE;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];

    planStr =@"Free-Plan";
    
    [self alertHandler];

}
-(IBAction)monthlyPlanBtnPressed:(id)sender{
    freePlanBtn.selected=FALSE;
    monthlyPlanBtn.selected=TRUE;   
    yearlyPlanBtn.selected=FALSE;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];

    planStr =@"Monthly-Plan";
    
    paymentobserver = [[CustomStoreObserver alloc]init];
    paymentobserver.paymentDelegate=self;
    [paymentobserver buyProduct:@"com.clinical.monthlyplan"];
    plseWaitLbl.hidden=FALSE;
    
}
-(IBAction)yearlyPlanBtnPressed:(id)sender{
    freePlanBtn.selected=FALSE;
    monthlyPlanBtn.selected=FALSE;
    yearlyPlanBtn.selected=TRUE;

    planStr =@"Yearly-Plan";
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];

    paymentobserver = [[CustomStoreObserver alloc]init];
    paymentobserver.paymentDelegate=self;
    [paymentobserver buyProduct:@"com.clinical.yearlyplan"];
    plseWaitLbl.hidden=FALSE;
    
    
}
#pragma mark -
#pragma mark Custom Store delegate

- (void)completePaymentTransaction{
	paymentobserver = nil;
    [paymentobserver release];

	NSLog(@"success");
    plseWaitLbl.hidden=TRUE;
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
    [self alertHandler];
    
}


-(void)alertHandler{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];

    
    NSDate *Date1 = [NSDate date];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
	[dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    
    
    NSString *Payment_create_date=   [dateFormat stringFromDate:Date1];
    
    [dateFormat release];
    
    NSString *payment_expiry_date = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_expiry_date"];

    
   // NSString *Payment_create_date = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"Payment_create_date"];
 
    
    if ([planStr isEqualToString:@"Monthly-Plan"]) {
        
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        
        [offsetComponents setMonth:+1];
        
        NSDate *notificaDate = [gregorian dateByAddingComponents:offsetComponents toDate:Date1 options:1];
        
        NSDateFormatter *dateFormat1=[[NSDateFormatter alloc]init];
        [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
        [dateFormat1 setTimeZone:[NSTimeZone localTimeZone]];
        
        payment_expiry_date =  [dateFormat1 stringFromDate:notificaDate];
        
        [offsetComponents release];
        [gregorian release];
        
        [dateFormat1 release];
        
          
        
    }else
        if([planStr isEqualToString:@"Yearly-Plan"])
    {
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        
        [offsetComponents setYear:+1];
        
        NSDate *notificaDate = [gregorian dateByAddingComponents:offsetComponents toDate:Date1 options:1];
        
        NSDateFormatter *dateFormat1=[[NSDateFormatter alloc]init];
        [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
        [dateFormat1 setTimeZone:[NSTimeZone localTimeZone]];
        
        payment_expiry_date =  [dateFormat1 stringFromDate:notificaDate];
        
        [offsetComponents release];
        [gregorian release];
        
        [dateFormat1 release];
        
 
        
        
    }
    else 
        if([planStr isEqualToString:@"Free-Plan"])
    {
        
       payment_expiry_date = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_expiry_date"];
        
        
    }
    
    
    
    
//    NSString *payment_plan = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_plan"];
    
    NSString *payment_status = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"payment_status"];

    NSString *URL = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"URL"];
    
    NSString *address1 = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"address1"];
    
    
    NSString *address2 = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"address2"];
    
    
    NSString *address3 = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"address3"];
    
    
    NSString *address4 = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"address4"];
    
    
    NSString *business_number = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"business_number"];
    
    
    NSString *center_photo = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"center_photo"];
    
    
    NSString *contact_email1 = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"contact_email1"];
    
    
    NSString *contact_email2 = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"contact_email2"];
    
    
    NSString *contact_name = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"contact_name"];
    
    
    NSString *expertise_area = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"expertise_area"];
    
    
    NSString *fax_number = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"fax_number"];
    
    
    NSString *mobile_number = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"mobile_number"];
    
    
    NSString *overview = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"overview"];
    
    
    NSString *research_center_id = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"research_center_id"];
    
    
    NSString *research_center_name = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"research_center_name"];
    
    NSString *username = [[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0] valueForKey:@"username"];
 
    NSString *photoName = [[NSString alloc] initWithFormat:@"%@.jpg",username];
    

    
    EGOImageView*     myimageView2 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"checkTrue.png"]];
    myimageView2.imageURL = [NSURL URLWithString:center_photo];	
    
    NSData *imgData =UIImageJPEGRepresentation(myimageView2.image, 0.50);
    
	NSString *c11 = [imgData base64Encoding];
    
    

     c11 = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)c11, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
   
    NSLog(@"%@",[[appDelge.dicSubscribInfo valueForKey:@"array"] objectAtIndex:0]);  
    
    
	NSString *post =[NSString stringWithFormat:@"research_center_id=%@&research_center_name=%@&overview=%@&address1=%@&address2=%@&address3=%@&address4=%@&business_number=%@&fax_number=%@&contact_name=%@&contact_email1=%@&contact_email2=%@&URL=%@&expertise_area=%@&mobile_number=%@&center_photo=%@&center_photo_code=%@",research_center_id,research_center_name,overview,address1,address2,address3,address4,business_number,fax_number,contact_name,contact_email1,contact_email2,URL,expertise_area,mobile_number,photoName,c11];
    
  //  NSLog(@"%@",post);
    
    NSString *postD = [NSString stringWithFormat:@"&Payment_create_date=%@&payment_expiry_date=%@&payment_plan=%@&payment_status=%@",Payment_create_date,payment_expiry_date,planStr,payment_status];
    
    
    NSMutableData *postData = [NSMutableData data ];
    
    [postData appendData:[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    [postData appendData:[postD dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:@"http://openxcelluk.info/clinical/web_services/update.php"]];
    [request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *uData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data11=[[NSString alloc]initWithData:uData encoding:NSUTF8StringEncoding];
   
    
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
    
	NSMutableDictionary *temp = [data11 JSONValue];
	//NSString *msg = [[NSString alloc] initWithFormat:@"%@",[temp valueForKey:@"msg"]];
    
  //  NSLog(@"%@",msg);
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Record Updated Successfully!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//	[alert show];
//	[alert release];
  
    AddClinicalTrails *addTrail =[[AddClinicalTrails alloc]initWithNibName:@"AddClinicalTrails" bundle:nil];
    [self.navigationController pushViewController:addTrail animated:YES];
    [addTrail release];

    
    
}


-(void)finishBuy:(NSDictionary *)dictinary
{
	NSLog(@"finishBuy:(NSDictionary *)");
	
}


- (void)paymentTransactionFail{
	paymentobserver = nil;
    [paymentobserver release];
    plseWaitLbl.hidden=TRUE;
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
	NSLog( @"Fail to buy credit for video upload.!!");;
	NSLog(@"fail");
}



#pragma Core Text View


- (NSString *)textForView
{
    return [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"text" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
}

- (NSArray *)coreTextStyle
{
    NSMutableArray *result = [NSMutableArray array];
    
	FTCoreTextStyle *defaultStyle = [FTCoreTextStyle new];
	defaultStyle.name = FTCoreTextTagDefault;	//thought the default name is already set to FTCoreTextTagDefault
	defaultStyle.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:14.f];
	defaultStyle.textAlignment = FTCoreTextAlignementJustified;
	[result addObject:defaultStyle];
	
	
	FTCoreTextStyle *titleStyle = [FTCoreTextStyle styleWithName:@"title"]; // using fast method
	titleStyle.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:40.f];
	titleStyle.paragraphInset = UIEdgeInsetsMake(0, 0, 20, 0);
	titleStyle.textAlignment = FTCoreTextAlignementCenter;
	[result addObject:titleStyle];
	
	FTCoreTextStyle *imageStyle = [FTCoreTextStyle new];
	imageStyle.paragraphInset = UIEdgeInsetsMake(0,0,0,0);
	imageStyle.name = FTCoreTextTagImage;
	imageStyle.textAlignment = FTCoreTextAlignementCenter;
	[result addObject:imageStyle];
	[imageStyle release];	
	
	FTCoreTextStyle *firstLetterStyle = [FTCoreTextStyle new];
	firstLetterStyle.name = @"firstLetter";
	firstLetterStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:30.f];
	[result addObject:firstLetterStyle];
	[firstLetterStyle release];
	
	FTCoreTextStyle *linkStyle = [defaultStyle copy];
	linkStyle.name = FTCoreTextTagLink;
	linkStyle.color = [UIColor orangeColor];
	[result addObject:linkStyle];
	[linkStyle release];
	
	FTCoreTextStyle *subtitleStyle = [FTCoreTextStyle styleWithName:@"subtitle"];
	subtitleStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:18.f];
	subtitleStyle.color =[UIColor colorWithRed:30.0/255.0 green:86.00/255.0 blue:131.0/255.0 alpha:1];
    subtitleStyle.textAlignment =UITextAlignmentRight;
	subtitleStyle.paragraphInset = UIEdgeInsetsZero;
	[result addObject:subtitleStyle];
	
	FTCoreTextStyle *bulletStyle = [defaultStyle copy];
	bulletStyle.name = FTCoreTextTagBullet;
	bulletStyle.bulletFont = [UIFont fontWithName:@"TimesNewRomanPSMT" size:10.f];
	bulletStyle.bulletColor = [UIColor colorWithRed:30.0/255.0 green:86.00/255.0 blue:131.0/255.0 alpha:1];
	[result addObject:bulletStyle];
	[bulletStyle release];
    
    FTCoreTextStyle *italicStyle = [defaultStyle copy];
	italicStyle.name = @"italic";
	italicStyle.underlined = YES;
    italicStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:16.f];
	[result addObject:italicStyle];
	[italicStyle release];
    
    FTCoreTextStyle *boldStyle = [defaultStyle copy];
	boldStyle.name = @"bold";
    boldStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:16.f];
	[result addObject:boldStyle];
	[boldStyle release];
    
    FTCoreTextStyle *coloredStyle = [defaultStyle copy];
    [coloredStyle setName:@"colored"];
    [coloredStyle setColor:[UIColor redColor]];
	[result addObject:coloredStyle];
    [defaultStyle release];
    
    return  result;
}

- (void)coreTextView:(FTCoreTextView *)acoreTextView receivedTouchOnData:(NSDictionary *)data {
    
    CGRect frame = CGRectFromString([data objectForKey:FTCoreTextDataFrame]);
    
    if (CGRectEqualToRect(CGRectZero, frame)) return;
    
    frame.origin.x -= 3;
    frame.origin.y -= 1;
    frame.size.width += 6;
    frame.size.height += 6;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view.layer setCornerRadius:3];
    [view setBackgroundColor:[UIColor orangeColor]];
    [view setAlpha:0];
    [acoreTextView.superview addSubview:view];
    [UIView animateWithDuration:0.2 animations:^{
        [view setAlpha:0.4];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            [view setAlpha:0];
        }];
    }];
    
    return;
    
    NSURL *url = [data objectForKey:FTCoreTextDataURL];
    if (!url) return;
    [[UIApplication sharedApplication] openURL:url];
}






@end

//
//  webService.m
//  ZawJi
//
//  Created by openxcell open on 11/16/10.
//  Copyright 2010 xcsxzc. All rights reserved.
//

#import "webService.h"

//static NSString *webServiceURL = @"http://index.goweb.it/goweb";

@implementation webService
+(NSMutableURLRequest*)getURq_getansascreen:(NSString*)ws_name{
	NSMutableURLRequest *urlReq = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:ws_name] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
	
	[urlReq addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[urlReq setHTTPMethod:@"POST"];
	return urlReq;
	
}


//-----------------------------------------------------------------


+(NSString*)getWS_register:(NSString *)uname :(NSString *)pass :(NSString *)Confirm :(NSString *)center_name :(NSString *)overview :(NSString *)photo :(NSString *)address1 :(NSString *)address2 :(NSString *)address3 :(NSString *)business_num :(NSString *)fax_num :(NSString *)contact :(NSString *)email1 :(NSString *)email2 :(NSString *)URL :(NSString *)expertise :(NSString *)mobile_nu :(NSString *)role :(NSString *)status :(NSString *)imgCode
{
	NSString *st = [NSString stringWithFormat:@"http://www.openxcellaus.info/clinical/registration.php?username=%@&password=%@&Confirm_password=%@&research_center_name=%@&overview=%@&center_photo=%@&address1=%@&address2=%@&address3=%@&business_number=%@&fax_number=%@&contact_name=%@&contact_email1=%@&contact_email2=%@&URL=%@&expertise_area=%@&mobile_number=%@&role=%@&center_status=%@&center_photo_code=%@",uname,pass,Confirm,center_name,overview,photo,address1,address2,address3,business_num,fax_num,contact,email1,email2,URL,expertise,mobile_nu,role,status,imgCode];
	st = [st stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return st;
}
+(NSString*)getWS_login :(NSString *)uname :(NSString *)pass;
{
	NSString *st = [NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/login_clinical.php?username=%@&password=%@",uname,pass];
	st = [st stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return st;
}
+(NSString*)getWS_profile :(NSString *)userID
{
	NSString *st = [NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/profile.php?id=%@",userID];
	st = [st stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	//NSLog(st);
	return st;
}
+(NSString*)getWS_edit :(NSString *)userID :(NSString *)center_name :(NSString *)overview :(NSString *)address1 :(NSString *)address2 :(NSString *)address3 :(NSString *)business_num :(NSString *)fax_num :(NSString *)contact :(NSString *)email1 :(NSString *)email2 :(NSString *)URL :(NSString *)expertise :(NSString *)mobile_nu
{
	NSString *st = [NSString stringWithFormat:@"http://www.openxcellaus.info/clinical/update.php?id=%@&research_center_name=%@&overview=%@&address1=%@&address2=%@&address3=%@&business_number=%@&fax_number=%@&contact_name=%@&contact_email1=%@&contact_email2=%@&URL=%@&expertise_area=%@&mobile_number=%@",userID,center_name,overview,address1,address2,address3,business_num,fax_num,contact,email1,email2,URL,expertise,mobile_nu];
	st = [st stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return st;
}
+(NSString*)getWS_searchByCenter :(NSString *)keyword
{
    NSString *st = [NSString stringWithFormat:@"http://www.openxcellaus.info/clinical/search.php?type=research_center_name&key=%@",keyword];
	st = [st stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return st;
}
+(NSString*)getWS_searchByExpArea :(NSString *)keyword
{
	NSString *st = [NSString stringWithFormat:@"http://www.openxcellaus.info/clinical/search.php?type=expertise_area&key=%@",keyword];
	st = [st stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return st;
}
+(NSString*)getWS_searchByLocation:(NSString *)lati :(NSString *)longi :(NSString *)area
{
	NSString *st = [NSString stringWithFormat:@"http://www.openxcellaus.info/clinical/search.php?lat=%@&lng=%@&dist=%@",lati,longi,area];
	st = [st stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return st;
}
+(NSString*)getWS_allProfile
{
	NSString *st = [NSString stringWithFormat:@"http://www.openxcellaus.info/clinical/profile.php"];
	st = [st stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return st;
}
+(NSString*)getWS_allCenter
{
	NSString *st = [NSString stringWithFormat:@"http://www.openxcelluk.info/clinical/web_services/profile_abstract.php"];
	st = [st stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return st;
}
//+(NSString*)getWS_addTrails:(NSString *)center_id :(NSString *)trial_title :(NSString *)criteria :(NSString *)startDate :(NSString *)endDate :(NSString *)compansation
//{
//	NSString *st = [NSString stringWithFormat:@"http://openxcellaus.info/clinical/add_trial.php?research_center_id=%@&trial_title=%@&criteria=%@&start_date=%@&end_date=%@&compensation=%@",center_id,trial_title,criteria,startDate,endDate,compansation];
//	st = [st stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//	return st;
//}
@end

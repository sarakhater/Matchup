//
//  JETSRegisterationViewController.m
//  Match GAME
//
//  Created by JETS on 4/1/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import "JETSRegisterationViewController.h"
#import "JETSLoginViewController.h"

@interface JETSRegisterationViewController ()

@end

@implementation JETSRegisterationViewController

-(NSString *)prepareURL{
    NSString *username = [self.usernameTF text];
    NSString *password = [self.passwordTF text];
    
    NSString *url = [NSString stringWithFormat:@"http://%@:8084/matchUp/signup?username=%@&password=%@",self.IP_ADDRESS,username,password];
    printf("%s",[url UTF8String]);
    return url ;

}

-(void)signUpButton:(id)sender{
    if([[self.usernameTF text] isEqualToString:@""] ||  [[self.passwordTF text] isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert Dialog" message: @"please, type a valid data " delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alertView show];
    }else{
        
        NSURL *url = [[NSURL alloc]initWithString:[self prepareURL]];
        NSURLRequest * request = [NSURLRequest requestWithURL:url] ;
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection start];
    }
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"failed");
    
    NSLog(@"%@",error);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    receivedDate = data ;
    
   
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    

    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:receivedDate options:kNilOptions error:nil];
    
    if([[dictionary objectForKey:@"response"] isEqualToString:@"failed"]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert Dialog" message:[dictionary objectForKey:@"body"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok",@"cancel", nil];
        [alertView show];
        
    }else if([[dictionary objectForKey:@"response"]isEqualToString:@"success"]){

        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert Dialog" message:[dictionary objectForKey:@"body"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alertView show];
        
    }else if([[dictionary objectForKey:@"response"] isEqualToString:@"exception"]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert Dialog" message:[dictionary objectForKey:@"body"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alertView show];
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    printf("ip adderss = %s ", [self.IP_ADDRESS UTF8String] );
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

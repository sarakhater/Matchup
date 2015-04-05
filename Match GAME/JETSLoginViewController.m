//
//  JETSLoginViewController.m
//  Match GAME
//
//  Created by JETS on 4/1/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import "JETSLoginViewController.h"
#import "JETSRegisterationViewController.h"

@interface JETSLoginViewController ()

@end


@implementation JETSLoginViewController{
    NSUserDefaults *defaults;

}


-(void)signInButton:(id)sender{
    
    if([[self.usernameTF text] isEqualToString:@""] ||  [[self.passwordTF text] isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert Dialog" message: @"please, type a valid data " delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alertView show];
    }else{
    
    NSURL *url = [[NSURL alloc]initWithString:[self prepareUrl]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url] ;
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    }
}



-(NSString*)prepareUrl{
    
    
    NSString *username = [self.usernameTF text];
    NSString *password = [self.passwordTF text];
    
    NSString *url = [NSString stringWithFormat:@"http://%@:8084/matchUp/signin?username=%@&password=%@",IPADDRESS,username,password];
    printf("%s",[url UTF8String]);
    return url ;
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"failed");
    
    NSLog(@"%@",error);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    receivedDate = data ;
    
    printf("%s",[[[NSString alloc ]initWithData:receivedDate encoding:nil] UTF8String]);    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *username = [self.usernameTF text];
    NSString *password = [self.passwordTF text];
    
    printf("in the connectionDidFinishLoading");
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:receivedDate options:kNilOptions error:nil];
    
    if([[dictionary objectForKey:@"response"] isEqualToString:@"failed"]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert Dialog" message:[dictionary objectForKey:@"body"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alertView show];
        
    }else if([[dictionary objectForKey:@"response"]isEqualToString:@"success"]){
        
        
        [defaults setValue:username forKey:@"username"];
        [defaults setValue: password forKey:@"password"];
        [defaults setBool:YES forKey:@"loggedIn"];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert Dialog" message:[dictionary objectForKey:@"body"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alertView show];
        
    }else if([[dictionary objectForKey:@"response"] isEqualToString:@"exception"]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert Dialog" message:[dictionary objectForKey:@"body"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alertView show];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"toSignUpSegue"])
    {
        // Get reference to the destination view controller
        JETSRegisterationViewController *registerViewController = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
   //     [registerViewController setIPADDRESS:IPADDRESS];
    
        registerViewController.IP_ADDRESS = IPADDRESS;
    
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
    
  //  IPADDRESS =  @"192.168.1.2" ;
    
 
    
    defaults = [NSUserDefaults standardUserDefaults];
  /*      [defaults setBool:NO forKey:@"loggedIn"];
    
    
    if( [defaults boolForKey:@"loggedIn"]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"goto home - user defaults" message:@"login successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alertView show];
        // navigate to home view controller
        
    }else{
        
        // do nothing - until the user logged in.
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"login first userdefaults" message:@"login failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alertView show];
    }
*/
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Hello!" message:@"Please type ther server IP:" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeNumberPad;
    [alertTextField setText:[defaults objectForKey:@"IPADDRESS"]];
    alertTextField.placeholder = @"ex : 192.168.1.1";
    alert.tag = 1 ;
    [alert show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
        if (alertView.tag == 1) {
            if (buttonIndex == 0) {
                NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
                IPADDRESS = [[alertView textFieldAtIndex:0] text];
                 [defaults setObject:IPADDRESS forKey:@"IPADDRESS"];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

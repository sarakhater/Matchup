//
//  JETSLoginViewController.h
//  Match GAME
//
//  Created by JETS on 4/1/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *IPADDRESS;
@interface JETSLoginViewController : UIViewController <NSURLConnectionDataDelegate, NSURLConnectionDelegate>
{
   
    NSData *receivedDate ;
}
@property IBOutlet UITextField *usernameTF, *passwordTF;





-(IBAction)signInButton:(id)sender;
//-(IBAction)signUpButton:(id)sender;
-(void)saveUserData;
-(NSString*)prepareUrl ;
@end

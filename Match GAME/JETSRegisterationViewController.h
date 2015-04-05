//
//  JETSRegisterationViewController.h
//  Match GAME
//
//  Created by JETS on 4/1/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JETSRegisterationViewController : UIViewController{
   // NSString *IPADDRESS;
    
    NSData *receivedDate ;
}

@property IBOutlet UITextField *usernameTF, *passwordTF;
@property NSString * IP_ADDRESS;



-(IBAction)signUpButton:(id)sender;
-(NSString*)prepareURL ;
@end

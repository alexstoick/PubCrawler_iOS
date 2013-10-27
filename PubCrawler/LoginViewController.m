//
//  LoginViewController.m
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "AFNetworking.h"
#import "LoginViewController.h"
#import "PubListDataSource.h"

@interface LoginViewController ()

@property (strong,nonatomic) AFHTTPRequestOperationManager* manager ;

@end

@implementation LoginViewController

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
    [self.navigationController setNavigationBarHidden:YES animated:false];
    if ( [[NSUserDefaults standardUserDefaults] valueForKey:@"isLoggedIn" ] )
    {
        [ self performSegueWithIdentifier:@"loginToMainView" sender:self] ;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(AFHTTPRequestOperationManager *) manager {
    if ( ! _manager  )
    {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager ;
}

- (IBAction)buttonPressed:(id)sender {
    
    //validate the username & password
    
    if ( [_username.text length] == 0 )
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Username field empty!"
                                                             message:@"Please fill in the username field!"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [errorAlert show];
    }
    else if ( [_password.text length] == 0 )
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Password field empty!"
                                                             message:@"Please fill in the password field!"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [errorAlert show];
    }
    else {
    
        NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
        [params setValue:_username.text forKey:@"username"] ;
        [params setValue:_password.text forKey:@"password"] ;
        
        [self.manager POST:@"http://pubcrawl.uclr.org/services/authenticate/" parameters:params
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSNumber * success = [responseObject valueForKey:@"success"] ;
                NSLog( @"Login result: %@" , success ) ;
                if ( [success isEqualToNumber: @1] )
                {
                    [[NSUserDefaults standardUserDefaults] setValue:@1 forKey:@"isLoggedIn" ] ;
                    [self performSegueWithIdentifier:@"loginToMainView" sender:self] ;
                }
                else
                {
                    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Login failed !"
                                                                         message:@"Password and/or user not correct ! "
                                                                        delegate:nil
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil];
                    [errorAlert show];
                }
                
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog ( @"%@" , error ) ;
        }] ;
    }

}

@end

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
    
    NSLog(@"%@ , %@", _username.text , _password.text );
    
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
    
    NSDictionary * params = [[NSDictionary alloc] init];
    
    [params setValue:_username.text forKey:@"username"] ;
    [params setValue:_password.text forKey:@"password"] ;
    
    [self.manager POST:@"http://pubcrawl.uclr.org/services/authenticate/" parameters:params
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog( @"%@" , responseObject ) ;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog ( @"%@" , error ) ;
    }] ;
    
//    [[PubListDataSource getInstance] parsePubListWithCompletion:^(BOOL success) {
//        if ( success)
//        {
//            [self performSegueWithIdentifier:@"changeToPubList" sender:self] ;
//        }
//        else
//        {
//            NSLog ( @"uat" ) ;
//        }
//    }] ;


}

@end

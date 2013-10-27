//
//  PubListController.m
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "PubListController.h"
#import "PubListDataSource.h"
#import "PubTableCell.h"
#import "Pub.h"
#import "PubDetailController.h"

@interface PubListController ()

@end

@implementation PubListController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:false];
    [self.navigationItem setHidesBackButton:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog ( @"COUNT : %d" , [[PubListDataSource getInstance].pubList count] ) ;
    return [[PubListDataSource getInstance].pubList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"pubListTableCell";
    PubTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Pub * currentPub = [PubListDataSource getInstance].pubList[indexPath.row] ;
    
    cell.titleLabel.text = currentPub.name ;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ( [segue.identifier isEqualToString:@"pubListToPubDetail" ] )
    {
        PubDetailController * detailController = segue.destinationViewController ;
        NSIndexPath * path = [self.tableView indexPathForSelectedRow] ;
        detailController.currentPub = [PubListDataSource getInstance].pubList[path.row] ;
    }
    
}



@end

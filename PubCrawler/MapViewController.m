//
//  MapViewController.m
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "MapViewController.h"
#import "PubListDataSource.h"
#import "Pub.h"
#import "GeneratedPubsList.h"
#import "PubTableCell.h"

static BOOL _setupMap = NO ;

@interface MapViewController ()

@property (strong,nonatomic) NSArray * generatedPubList ;

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:false];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.showsUserLocation = YES;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    if ( ! _setupMap )
    {
        MKCoordinateRegion mapRegion;
        mapRegion.center = mapView.userLocation.coordinate;
        mapRegion.span.latitudeDelta = 0.01;
        mapRegion.span.longitudeDelta = 0.01;
        [mapView setRegion:mapRegion animated: YES];
        [self createRouteFromGeneratedPubList];
        _setupMap = YES ;
    }
}

-(void)createRouteFromGeneratedPubList {
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.transportType = MKDirectionsTransportTypeWalking ;
    [request setSource: [MKMapItem mapItemForCurrentLocation]];
   
    GeneratedPubsList * pubListInstance = [GeneratedPubsList getInstance ] ;
    self.generatedPubList = pubListInstance.generatedPubsList ;
    [self.tableView reloadData ];
    for ( Pub * pub in self.generatedPubList )
    {
        MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
        
        CLLocationCoordinate2D coordinate ;
        coordinate.latitude = [pub.latitude doubleValue] ;
        coordinate.longitude = [pub.longitude doubleValue] ;
     
        annot.coordinate = coordinate;
        annot.title = pub.name ;
        [self.mapView addAnnotation:annot] ;
        MKPlacemark * mapPlacemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary: nil] ;
        MKMapItem *mapItem_destination = [[MKMapItem alloc] initWithPlacemark: mapPlacemark] ;
        
        [request setDestination:mapItem_destination ];
        
        request.requestsAlternateRoutes = YES;
        MKDirections *directions =
        [[MKDirections alloc] initWithRequest:request];
        
        [directions calculateDirectionsWithCompletionHandler:
         ^(MKDirectionsResponse *response, NSError *error) {
             if (error) {
                 // Handle Error
                 NSLog ( @"Error calculating directions: %@" , error ) ;
             } else {
                 [self showRoute:response];
             }
         }];
        
        [request setSource: mapItem_destination];
    }
}

-(void)showRoute:(MKDirectionsResponse *)response
{
    MKRoute *route =  response.routes[0] ;
//
//    for (MKRouteStep *step in route.steps)
//    {
//        NSLog(@"%@", step.instructions);
//    }
    
    [ self.mapView
     addOverlay:route.polyline level:MKOverlayLevelAboveRoads];

}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    renderer.strokeColor = color;
    renderer.lineWidth = 5.0;
    return renderer;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.generatedPubList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"pubListTableCell";
    PubTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Pub * currentPub = self.generatedPubList[indexPath.row] ;
    
    cell.titleLabel.text = currentPub.name ;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Pub * currentPub = self.generatedPubList[indexPath.row] ;
    
    CLLocationCoordinate2D centre_point ;
    
    centre_point.latitude = [currentPub.latitude doubleValue];
    centre_point.longitude = [currentPub.longitude doubleValue];
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = centre_point ;
    mapRegion.span.latitudeDelta = 0.001;
    mapRegion.span.longitudeDelta = 0.001;
    [self.mapView selectAnnotation:[self.mapView.annotations objectAtIndex:indexPath.row] animated:NO] ;
    [self.mapView setRegion:mapRegion animated: YES];
}



@end

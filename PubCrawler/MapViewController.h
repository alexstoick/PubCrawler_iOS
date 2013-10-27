//
//  MapViewController.h
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate>

+(MapViewController*)getInstance;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
-(void)createRouteFromPubList: (NSArray *)publist ;



@end

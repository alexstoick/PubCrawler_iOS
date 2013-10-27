//
//  MainViewController.h
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/27/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicSlider.h"

@interface MainViewController : UIViewController

@property (nonatomic) IBOutlet BasicSlider *moneySlider;
@property (nonatomic) IBOutlet BasicSlider *pubsSlider;


@end

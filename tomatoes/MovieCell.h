//
//  MovieCell.h
//  tomatoes
//
//  Created by David Law on 1/19/14.
//  Copyright (c) 2014 David Law. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *movieTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *synopsisLabel;
@property (nonatomic, weak) IBOutlet UILabel *castLabel;
@end

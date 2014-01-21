//
//  MovieImageCell.h
//  tomatoes
//
//  Created by David Law on 1/21/14.
//  Copyright (c) 2014 David Law. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieImageCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *image;
@property (nonatomic, weak) IBOutlet UILabel *summaryLabel;
@property (nonatomic, weak) IBOutlet UILabel *castLabel;

@end

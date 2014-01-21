//
//  MovieViewController.m
//  tomatoes
//
//  Created by David Law on 1/21/14.
//  Copyright (c) 2014 David Law. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieImageCell.h"
#import "UIImageView+AFNetworking.h"


@interface MovieViewController ()

@end

@implementation MovieViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MovieImageCell *cell = (MovieImageCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieImageCell"];
        [cell.image setImageWithURL:self.movie.orig_image_url];
        
        return cell;
    }
    else if (indexPath.row == 1){
        MovieImageCell *cell = (MovieImageCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieSummaryCell"];
        cell.summaryLabel.text = self.movie.synopsis;
        return cell;
    }
    else {
        MovieImageCell *cell = (MovieImageCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCastCell"];
        cell.castLabel.text = [self.movie getCast];
        return cell;
    }
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

@end

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
-(void)resizeHeightForLabel: (UILabel*)label;
-(float)heightForLabel: (UILabel*) label;
@end

@implementation MovieViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.movie.title;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Table View Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // Determine height for cell
 
    // You will need a buffer in addition to using the dynamic height of the UILabel
    float buffer = 50.0f;
    
    // Default to standard height determination
    CGFloat height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
    if (indexPath.row == 1) {
        MovieImageCell *cell = (MovieImageCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieSummaryCell"];
        cell.summaryLabel.text = self.movie.synopsis;
        
        return [self heightForLabel:cell.summaryLabel] + buffer;
    }
    else if (indexPath.row == 2){
        MovieImageCell *cell = (MovieImageCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCastCell"];
        cell.castLabel.text = [self.movie getCast];
        
        return [self heightForLabel:cell.castLabel] + buffer;
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Determine what type of cell to return.  I'm pretty sure this is not the ideal way to implement this.
    if (indexPath.row == 0) {
        // First cell contains the Movie Image
        MovieImageCell *cell = (MovieImageCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieImageCell"];
        [cell.image setImageWithURL:self.movie.orig_image_url];
        
        return cell;
    }
    else if (indexPath.row == 1){
        // Second cell contains the Movie Summary
        MovieImageCell *cell = (MovieImageCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieSummaryCell"];
        cell.summaryLabel.text = self.movie.synopsis;
        
        [self resizeHeightForLabel:cell.summaryLabel];
        
        return cell;
    }
    else {
        // Third cell contains the Cast
        MovieImageCell *cell = (MovieImageCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCastCell"];
        cell.castLabel.text = [self.movie getCast];
        
        [self resizeHeightForLabel:cell.castLabel];
        
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

# pragma mark - Private Methods

-(void)resizeHeightForLabel: (UILabel*)label {
    // Resizes Height for a UILabel
    // Found at
    // http://stackoverflow.com/questions/18660976/resize-uilabel-with-sizewithfontconstrainedtosizelinebreakmode-deprecated-in
    label.numberOfLines = 0;
    UIView *superview = label.superview;
    [label removeFromSuperview];
    [label removeConstraints:label.constraints];
    CGRect labelFrame = label.frame;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        CGRect expectedFrame = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, 9999)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 label.font, NSFontAttributeName,
                                                                 nil]
                                                        context:nil];
        labelFrame.size = expectedFrame.size;
        labelFrame.size.height = ceil(labelFrame.size.height); //iOS7 is not rounding up to the nearest whole number
    } else {
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        labelFrame.size = [label.text sizeWithFont:label.font
                                 constrainedToSize:CGSizeMake(label.frame.size.width, 9999)
                                     lineBreakMode:label.lineBreakMode];
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
    }
    label.frame = labelFrame;
    [superview addSubview:label];
}

-(float)heightForLabel: (UILabel*) label {
    // Given a label, return the height of the label
    label.numberOfLines = 0;
    [label removeFromSuperview];
    [label removeConstraints:label.constraints];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        CGRect expectedFrame = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, 9999)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 label.font, NSFontAttributeName,
                                                                 nil]
                                                        context:nil];
        return expectedFrame.size.height;
    }
    return 0.0;
}



@end

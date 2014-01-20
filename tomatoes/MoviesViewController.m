//
//  MoviesViewController.m
//  tomatoes
//
//  Created by David Law on 1/19/14.
//  Copyright (c) 2014 David Law. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "Movie.h"

@interface MoviesViewController ()

@property (nonatomic, strong) NSMutableArray *movies;

-(void)reload;

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.movies = [NSMutableArray new];
        // Custom initialization
        [self reload];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.movies = [NSMutableArray new];
        // Custom initialization
        [self reload];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

# pragma mark - Table View Methods

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    Movie *movie = self.movies[indexPath.row];
    cell.movieTitleLabel.text = movie.title;
    cell.synopsisLabel.text = movie.synopsis;
    cell.castLabel.text = [movie getCast];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Private Methods

- (void)reload {
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

        NSArray *movies = [object objectForKey:@"movies"];
        for (id movie in movies) {
            Movie *cell = [[Movie alloc] initWithDictionary:movie];
            [self.movies addObject: cell];
        }
        
        [self.tableView reloadData];
        //NSLog(@"%@", object);
    }];
}

@end

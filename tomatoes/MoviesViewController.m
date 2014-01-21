//
//  MoviesViewController.m
//  tomatoes
//
//  Created by David Law on 1/19/14.
//  Copyright (c) 2014 David Law. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieViewController.h"
#import "MovieCell.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"

@interface MoviesViewController ()

@property (nonatomic, strong) NSMutableArray *movies;

-(void)refreshData;
-(void)reload;

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.movies = [NSMutableArray new];
        self.title = @"Movies";
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.movies = [NSMutableArray new];
        self.title = @"Movies";
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Reloading Movies"];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [self reload];
}

# pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    Movie *movie = self.movies[indexPath.row];
    cell.movieTitleLabel.text = movie.title;
    cell.synopsisLabel.text = movie.synopsis;
    cell.castLabel.text = [movie getCast];
    [cell.image setImageWithURL:movie.profile_image_url];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Private Methods

- (void)refreshData {
    [self.refreshControl endRefreshing];
    [self performSelector:@selector(reload) withObject:nil];
}
- (void)reload {
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        if (!connectionError && responseCode == 200) {
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

            NSArray *movies = [object objectForKey:@"movies"];
            for (id movie in movies) {
                Movie *cell = [[Movie alloc] initWithDictionary:movie];
                [self.movies addObject: cell];
            }
        
            [self.tableView reloadData];
            
            // End refresh and dismiss HUD if it exists
            [self.refreshControl endRefreshing];
            [SVProgressHUD dismiss];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"Network error.  Please try again later"];
        }

    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *selectedCell = (UITableViewCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
    Movie *movie = self.movies[indexPath.row];
    
    MovieViewController *movieViewController = (MovieViewController *)segue.destinationViewController;
    movieViewController.movie = movie;
}

@end

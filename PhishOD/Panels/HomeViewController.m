//
//  HomeViewController.m
//  Phish Tracks
//
//  Created by Alec Gorge on 10/29/13.
//  Copyright (c) 2013 Alec Gorge. All rights reserved.
//

#import "HomeViewController.h"

#import <SVWebViewController/SVWebViewController.h>

#import "PhishNetAuth.h"

#import "AppDelegate.h"
#import "YearsViewController.h"
#import "SongsViewController.h"
#import "ToursViewController.h"
#import "TopRatedViewController.h"
#import "PhishTracksStatsViewController.h"
#import "SettingsViewController.h"
#import "VenuesViewController.h"
#import "SearchViewController.h"
#import "RandomShowViewController.h"
#import "SearchDelegate.h"
#import "FavoritesViewController.h"
#import "GlobalActivityViewController.h"
#import "CuratedPlaylistsViewController.h"

#import "PhishNetBlogViewController.h"
#import "PhishNetNewsViewController.h"
#import "PhishNetShowsViewController.h"

#import "PhishinDownloadedShowsViewController.h"
#import "DownloadQueueViewController.h"

NS_ENUM(NSInteger, kPhishODMenuItems) {
	kPhishODMenuItemYears,
	kPhishODMenuItemSongs,
	kPhishODMenuItemVenues,
	kPhishODMenuItemTours,
	kPhishODMenuItemTopRated,
	kPhishODMenuItemRandomShow,
	kPhishODMenuItemPlaylists,
	kPhishODMenuItemDownloaded,
	kPhishODMenuItemDownloadQueue,
	kPhishODMenuItemsCount
};

NS_ENUM(NSInteger, kPhishODMenuStatsItems) {
	kPhishODMenuStatsItemStats,
	kPhishODMenuStatsItemFavorites,
	kPhishODMenuStatsItemGlobalActivity,
	kPhishODMenuStatsItemsCount
};

NS_ENUM(NSInteger, kPhishODMenuTicketsItems) {
    kPhishODMenuTicketsItemCashOrTrade,
    kPhishODMenuTicketsItemsCount,
};

NS_ENUM(NSInteger, kPhishODMenuSectionPhishNetItems) {
	kPhishODMenuPhishNetItemMyShows,
//	kPhishODMenuPhishNetItemForum,
	kPhishODMenuPhishNetItemNews,
	kPhishODMenuPhishNetItemBlog,
	kPhishODMenuPhishNetItemCount,
};

NS_ENUM(NSInteger, kPhishODMenuSections) {
	kPhishODMenuSectionNowPlaying,
	kPhishODMenuSectionMenu,
	kPhishODMenuSectionPhishNet,
	kPhishODMenuSectionStats,
	kPhishODMenuSectionTickets,
	kPhishODMenuSectionsCount
};

@interface HomeViewController ()

@property (nonatomic) UISearchDisplayController *con;
@property (nonatomic) SearchDelegate *conDel;
@property (nonatomic) UISearchBar *searchBar;

@end

@implementation HomeViewController

- (void)createSearchBar {
	self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
	
	self.con = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar
												 contentsController:self];
	
	self.conDel = [[SearchDelegate alloc] initWithTableView:self.searchDisplayController.searchResultsTableView
									andNavigationController:self.navigationController];
	
	self.searchDisplayController.searchResultsDelegate = self.conDel;
	self.searchDisplayController.searchResultsDataSource = self.conDel;
	self.searchDisplayController.delegate = self.conDel;
	
	self.tableView.tableHeaderView = self.searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"PhishOD";
    
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage settingsNavigationIcon] style:UIBarButtonItemStylePlain target:self action:@selector(presentSettings)];
    self.navigationItem.rightBarButtonItem = settingsButton;
    
	[self createSearchBar];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.tableView reloadData];
}

-(void)dealloc {
	self.con = nil;
}

- (void)presentSettings {
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[SettingsViewController new]];
    
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return kPhishODMenuSectionsCount;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
	if(section == kPhishODMenuSectionNowPlaying) {
		return 1;
	}
	else if(section == kPhishODMenuSectionMenu) {
		return kPhishODMenuItemsCount;
	}
    else if(section == kPhishODMenuSectionPhishNet) {
        return kPhishODMenuPhishNetItemCount;
    }
	else if(section == kPhishODMenuSectionTickets) {
		return kPhishODMenuTicketsItemsCount;
	}
	
	return kPhishODMenuStatsItemsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	
	if(!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
									  reuseIdentifier:@"cell"];
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.detailTextLabel.text = nil;
	
	if(indexPath.section == kPhishODMenuSectionNowPlaying) {
		PhishinShow *show = [AppDelegate sharedDelegate].currentlyPlayingShow;
		
		cell.textLabel.text = @"Now Playing";

		if(show != nil) {
			cell.detailTextLabel.text = show.date;
		}
		else {
			cell.detailTextLabel.text = @"Nothing yet...";
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
		
		return cell;
	}
	
	NSInteger row = indexPath.row;
	NSInteger section = indexPath.section;
	if (section == kPhishODMenuSectionMenu && row == kPhishODMenuItemYears) {
		cell.textLabel.text = @"Years";
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemSongs) {
		cell.textLabel.text = @"Songs";
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemVenues) {
		cell.textLabel.text = @"Venues";
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemTours) {
		cell.textLabel.text = @"Tours";
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemTopRated) {
		cell.textLabel.text = @"Top Rated Shows";
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemRandomShow) {
		cell.textLabel.text = @"Random Show";
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemDownloaded) {
		cell.textLabel.text = @"Downloaded Shows";
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemPlaylists) {
		cell.textLabel.text = @"Curated Playlists";
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemDownloadQueue) {
		cell.textLabel.text = @"Download Queue";
	}
	else if(section == kPhishODMenuSectionStats && row == kPhishODMenuStatsItemStats) {
		cell.textLabel.text = @"Stats";
	}
	else if(section == kPhishODMenuSectionStats && row == kPhishODMenuStatsItemFavorites) {
		cell.textLabel.text = @"Favorites";
	}
	else if(section == kPhishODMenuSectionStats && row == kPhishODMenuStatsItemGlobalActivity) {
		cell.textLabel.text = @"Recent Activity";
	}
	else if(section == kPhishODMenuSectionPhishNet && row == kPhishODMenuPhishNetItemBlog) {
		cell.textLabel.text = @"Blog";
	}
	else if(section == kPhishODMenuSectionPhishNet && row == kPhishODMenuPhishNetItemNews) {
		cell.textLabel.text = @"News";
	}
//	else if(section == kPhishODMenuSectionPhishNet && row == kPhishODMenuPhishNetItemForum) {
//		cell.textLabel.text = @"Forum";
//	}
	else if(section == kPhishODMenuSectionPhishNet && row == kPhishODMenuPhishNetItemMyShows) {
		cell.textLabel.text = @"My Shows";
	}
	else if(section == kPhishODMenuSectionTickets && row == kPhishODMenuTicketsItemCashOrTrade) {
		cell.textLabel.text = @"Face Value Tickets";
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath
							 animated:YES];
	
	if(indexPath.section == 0 && [AppDelegate sharedDelegate].currentlyPlayingShow != nil) {
		[self pushViewController:[[ShowViewController alloc] initWithShow:AppDelegate.sharedDelegate.currentlyPlayingShow]];
		return;
	}
	
	NSInteger row = indexPath.row;
	NSInteger section = indexPath.section;
	if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemYears) {
		[self pushViewController:[[YearsViewController alloc] init]];
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemSongs) {
		[self pushViewController:[[SongsViewController alloc] init]];
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemVenues) {
		[self pushViewController:[[VenuesViewController alloc] init]];
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemTours) {
		[self pushViewController:[[ToursViewController alloc] init]];
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemTopRated) {
		[self pushViewController:[[TopRatedViewController alloc] init]];
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemRandomShow) {
		[self pushViewController:[[RandomShowViewController alloc] init]];
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemDownloaded) {
		[self pushViewController:PhishinDownloadedShowsViewController.alloc.init];
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemPlaylists) {
		[self pushViewController:CuratedPlaylistsViewController.alloc.init];
	}
	else if(section == kPhishODMenuSectionMenu && row == kPhishODMenuItemDownloadQueue) {
		[self pushViewController:DownloadQueueViewController.alloc.init];
	}
	else if(section == kPhishODMenuSectionStats && row == kPhishODMenuStatsItemStats) {
		[self pushViewController:[[PhishTracksStatsViewController alloc] init]];
	}
	else if(section == kPhishODMenuSectionStats && row == kPhishODMenuStatsItemFavorites) {
		[self pushViewController:[[FavoritesViewController alloc] init]];
	}
	else if(section == kPhishODMenuSectionStats && row == kPhishODMenuStatsItemGlobalActivity) {
		[self pushViewController:[[GlobalActivityViewController alloc] init]];
	}
	else if(section == kPhishODMenuSectionPhishNet && row == kPhishODMenuPhishNetItemBlog) {
		[self pushViewController:PhishNetBlogViewController.alloc.init];
	}
	else if(section == kPhishODMenuSectionPhishNet && row == kPhishODMenuPhishNetItemNews) {
		[self pushViewController:PhishNetNewsViewController.alloc.init];
	}
	else if(section == kPhishODMenuSectionPhishNet && row == kPhishODMenuPhishNetItemMyShows) {
		[PhishNetAuth.sharedInstance ensureSignedInFrom:self
												success:^{
													[self pushViewController:PhishNetShowsViewController.alloc.init];
												}];
	}
	else if(section == kPhishODMenuSectionTickets && row == kPhishODMenuTicketsItemCashOrTrade) {
		[self pushViewController:[SVWebViewController.alloc initWithAddress:@"http://m.cashortrade.org/"]];
	}
}

- (void)pushViewController:(UIViewController*)vc {
	[self.navigationController pushViewController:vc
										 animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
	if(section == kPhishODMenuSectionStats) {
		return @"Stats";
	}
    else if(section == kPhishODMenuSectionPhishNet) {
        return @"Phish.net";
    }
	else if(section == kPhishODMenuSectionTickets) {
		return @"Tickets";
	}
    
	return nil;
}

@end

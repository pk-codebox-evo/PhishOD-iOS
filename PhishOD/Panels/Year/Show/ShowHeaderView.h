//
//  ShowHeaderView.h
//  PhishOD
//
//  Created by Alec Gorge on 7/31/14.
//  Copyright (c) 2014 Alec Gorge. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AXRatingView/AXRatingView.h>

@class PhishinShow;

@interface ShowHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *uiVenueLabel;
@property (weak, nonatomic) IBOutlet UILabel *uiSoundboardLabel;
@property (weak, nonatomic) IBOutlet UILabel *uiRemasteredLabel;
@property (weak, nonatomic) IBOutlet UILabel *uiDurationLabel;
@property (weak, nonatomic) IBOutlet AXRatingView *uiRatingView;
@property (weak, nonatomic) IBOutlet UILabel *uiRatingReviewCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *uiDownloadAllButton;
@property (weak, nonatomic) IBOutlet UILabel *uiDetailsLabel;

@property (copy, nonatomic) void (^headerTapped)(void);
@property (copy, nonatomic) void (^downloadAllTapped)(void);

- (void)updateCellForShow:(PhishinShow *)show
			  withSetlist:(PhishNetSetlist *)setlist
			  inTableView:(UITableView *)tableView;

+ (CGFloat)cellHeightForShow:(PhishinShow *)show
				 inTableView:(UITableView *)tableView;

@end

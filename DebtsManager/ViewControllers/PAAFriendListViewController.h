//
//  PAAFriendListTableViewController.h
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FriendPAA+CoreDataClass.h"


@class PAAFriendListViewController;


@protocol PAAFriendListViewControllerDelegate <NSObject>

- (void)friendListViewController:(PAAFriendListViewController *)controller didChooseFriend:(FriendPAA *)friendModel;

@end


@interface PAAFriendListViewController : UITableViewController

@property (nonatomic, weak) id <PAAFriendListViewControllerDelegate> delegate;

@end

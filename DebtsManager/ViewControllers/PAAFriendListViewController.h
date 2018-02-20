//
//  PAAFriendListTableViewController.h
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FriendPAA+CoreDataClass.h"


/**
 Объявление класса для его объявления в протоколе ниже
 */
@class PAAFriendListViewController;


/**
 Протокол для реализации делегата.
 Необходим для передачи модели друга во вьюконтроллер с моделью долга
 */
@protocol PAAFriendListViewControllerDelegate <NSObject>

/**
 Вызывается, когда был выбран друг
 @param controller - текущий контроллер, из которого вызывается метод
 @param friendModel - модель друга CoreData
 */
- (void)friendListViewController:(PAAFriendListViewController *)controller didChooseFriend:(FriendPAA *)friendModel;

@end

/**
 * Вьюконтроллер отображает список твоих друзей в виде таблицы
 */
@interface PAAFriendListViewController : UITableViewController

/** Делегат для передачи модели друга вьюконтроллеру с долгом */
@property (nonatomic, weak) id <PAAFriendListViewControllerDelegate> delegate;

@end

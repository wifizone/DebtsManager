//
//  PAADebtTableViewCell.h
//  DebtsManager
//
//  Created by Антон Полуянов on 30/01/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <UIKit/UIKit.h>


/**
 * Класс - ячейка TableView. Создает контролы и верстает их расположение в ячейке
 */
@interface PAADebtTableViewCell : UITableViewCell

/** Свойство вьюшка для фотографии друга */
@property (nonatomic, strong) UIImageView *personPhotoImage;

/** Свойство лейбл с именем друга*/
@property (nonatomic, strong) UILabel *personNameLabel;

/** Свойство лейбл с суммой долга другу*/
@property (nonatomic, strong) UILabel *sumToRepayLabel;

/** Свойство лейбл с датой, когда вернуть долг другу*/
@property (nonatomic, strong) UILabel *dueDateLabel;

@end

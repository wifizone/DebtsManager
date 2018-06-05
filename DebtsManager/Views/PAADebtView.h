//
//  PAADebtView.h
//  DebtsManager
//
//  Created by Антон Полуянов on 11/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <UIKit/UIKit.h>

/**
 * Класс - вьюшка, отображает все контролы, связанные с долгом
 */
@interface PAADebtView : UIView

/** Свойство текстовое поле для ввода имени друга. По нажатии, открывается список для выбора друзей. Нельзя ввести имя вручную */
@property (nonatomic, strong) UITextField *textFieldName;

/** Свойство текстовое поле для ввода фамилии друга.По нажатии, открывается список для выбора друзей. Нельзя ввести фамилию вручную */
@property (nonatomic, strong) UITextField *textFieldSurname;

/** Свойство текстовое поле для ввода суммы долга. По нажатии, открывается цифровая клавиатура. Нельзя скопировать или вставить сумму */
@property (nonatomic, strong) UITextField *textFieldSum;

/** Свойство поле для выбора даты возврата долга */
@property (nonatomic, strong) UIDatePicker *dueDatePicker;

/** Свойство поле для выбора даты, когда долг появился */
@property (nonatomic, strong) UIDatePicker *debtAppearedDatePicker;

/** Свойство вьюшка для отображения фотографии друга */
@property (nonatomic, strong) UIImageView *personPhotoView;

/** Конструктор - инициализация вьюшки контролами */
- (instancetype)init;

@end

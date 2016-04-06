//
//  ProtoClass.h
//  Pro 1.5
//
//  Created by T on 05.09.15.
//  Copyright (c) 2015 Ilya. All rights reserved.
//

#import <Foundation/Foundation.h>

// 1) Создаем и даем имя протоколу.

@protocol ProtoClassDelegate;

@interface ProtoClass : NSObject

// 1) Прописываются свойства протокола.

@property (nonatomic, weak) id <ProtoClassDelegate> delegate;

// 1) Создаем метод делегата.

-(void) metWithString: (NSString *) ivstring ;

-(void) metWithImage ;


@end

//**********************************************

@protocol ProtoClassDelegate  <NSObject>

// 1) Метод обязателен к реализации - @requied

@required

// 1) Вызываем методы протокола.

- (void) protoMethod: (ProtoClass *) protoClass string: (NSMutableArray *) array;

@end

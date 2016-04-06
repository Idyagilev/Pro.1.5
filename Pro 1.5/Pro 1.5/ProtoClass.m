//
//  ProtoClass.m
//  Pro 1.5
//
//  Created by T on 05.09.15.
//  Copyright (c) 2015 Ilya. All rights reserved.
//

#import "ProtoClass.h"

@implementation ProtoClass
//_________________________________________________________________________________________________________________________
//  1) Метод делегата.

-(void) metWithString: (NSString *) ivstring {
    
    NSMutableArray * arrayM = [[NSMutableArray alloc] init];
    
    NSArray * arrayBrands = [[NSArray alloc] initWithObjects:@"Pioneer", @"Vestax", @"Numark", nil];
    
    NSArray * arrayModel = [[NSArray alloc] initWithObjects:@"CDJ-1000", @"VCI-380", @"Mixtrack", nil];
    
    
    for (int i = 0; i < arrayModel.count; i++) {
        
//      1) Здесь создаем коллекцию и указываем что обьект под индексом i будет равен ключу model.
        
        NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                               [arrayModel objectAtIndex:i], @"model",
                               [arrayBrands objectAtIndex:i], @"brand",nil];

        
//      1) И при каждом цикле мы будем добавлять наш dictionary в массив.
        
        [arrayM addObject:dict];
        
    }
    
//    1) После выполнения цикла мы передадим массив вот сюда.
//    [self shadowMet:arrayM];
    
    NSDictionary * dictNotification = [[NSDictionary alloc]initWithObjectsAndKeys:arrayM, @"array", nil];
//  2) Инициализируем новую коллекцию с arrayM
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WHEN_DATA_IS_LOADED object:nil userInfo:dictNotification];
//    2) слово раздражитель произносится в этом методе, добавляется коллекция с массивом данных

}
//________________________________________________________________________________________________________________________

-(void) metWithImage {
    
    NSMutableArray * arrayM = [[NSMutableArray alloc] init];
    
    NSArray * arrayBrands = [[NSArray alloc] initWithObjects:@"Pawn", @"Queen", @"Rook",  nil];
    
    NSArray * arrayPosition = [[NSArray alloc] initWithObjects:@"e2 e4", @"a1 f5", @"h3 c5", nil];
    
    
    for (int i = 0; i < arrayPosition.count; i++) {
        
        
        NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                               [arrayPosition objectAtIndex:i], @"position",
                               [arrayBrands objectAtIndex:i], @"brand",nil];
        
        [arrayM addObject:dict];
        
    }
    
    NSDictionary * dictNotification = [[NSDictionary alloc]initWithObjectsAndKeys:arrayM, @"array", nil];
    //  2) Инициализируем новую коллекцию с arrayM
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FIGURE_IS_LOADED object:nil userInfo:dictNotification];
    //    2) слово раздражитель произносится в этом методе, добавляется коллекция с массивом данных
    
}
//_________________________________________________________________________________________________________________________

-(void) shadowMet: (NSMutableArray *)  array {
    
//    1) Обращаемся к свойствам, вызываем протокол у метода, в кач-ве обьекта возвращаем self, в кач-ве строки вернем строку shadow которую данный метод получит в кач-ве аргумента. А перед этим нужно обязательно проверить, чтобы исключить возможность падения программы - подписан ли ты прото, есть там такая запись?
    
    if ([self.delegate respondsToSelector:@selector(protoMethod:string:)]) {

    [self.delegate protoMethod:self string:array];
        
    }
}

@end

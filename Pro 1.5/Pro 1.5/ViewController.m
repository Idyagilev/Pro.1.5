//
//  ViewController.m
//  Pro 1.5
//
//  Created by T on 05.09.15.
//  Copyright (c) 2015 Ilya. All rights reserved.
//

#import "ViewController.h"
#import "ProtoClass.h"
#import "CUSTOMTableViewCellOne.h"


@interface ViewController () < UITableViewDelegate, UITableViewDataSource, ProtoClassDelegate>

@property (nonatomic, strong) NSMutableArray * arrayData;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)actionLoadedFigures:(id)sender;

- (IBAction)actionLoadedData:(id)sender;


@end

@implementation ViewController

//__________________________________________________________________________________________________________________________

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    1) Это свойство скрывает пустые ячейки в таблице.
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView :) name:NOTIFICATION_WHEN_DATA_IS_LOADED object:nil];
    // 2) Подписываемся на нотификацию, если ставим  : то в метод будет передаваться нотиф-ия
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView :) name:NOTIFICATION_FIGURE_IS_LOADED object:nil];
    
}

-(void) dealloc  {
//   2) Обязательно отписываемся от нотификации
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//_________________________________________________________________________________________________________________________
//    1) Создаем метод, обьект и говорим свойствам что делегат - это я! Я заказчик, я клиент, которому надо принести блюдо.   Значит у меня и реализуется тот метод, который прописан в протоколе. Третья строка вызывает метод.

- (void) start {
    
    ProtoClass * proto = [ProtoClass new];
    proto.delegate = self;
    [proto metWithString:@"Zakaz"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}
//_________________________________________________________________________________________________________________________
//    1) Метод протокола, официант который выполняет заказ делегата

- (void) protoMethod: (ProtoClass *) protoClass string: (NSMutableArray *) array {

    self.arrayData = [[NSMutableArray alloc] initWithArray:array];
    
}
//_________________________________________________________________________________________________________________________
//   1) Метод перезагрузки таблицы с анимацией. 2) Добавляем : и нотификацию, добавляем массивы

- (void) reloadTableView :(NSNotification *) notification {
    
    [self.arrayData removeAllObjects];
//    2) удаляем все данные из массива и загружаем по новому
    
    NSArray * array = [notification.userInfo objectForKey:@"array"];
    
    self.arrayData = [[NSMutableArray alloc] initWithArray:array];

    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
    
}
//_________________________________________________________________________________________________________________________
//  1) Методы копируем из UITableViewDataSource, методы возвращают: 1) число, метод возвращает количество табличных ячеек, которые нужно показать

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//  1) Здесь мы указываем, что вернем число ячеек равное количеству обьектов в массиве, ктотрый прописан в property.
    
    return self.arrayData.count;
    
}
//_________________________________________________________________________________________________________________________
//  1) Метод обрабатывает каждую ячейку, т.е метод будет вызван тогда, когда ячейка будет показана на экране. Если скролим снизу вверх, каждая ячейка появляется тогда, когда метод срабатывает.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"Serenity";
    
    static NSString * identifier1 = @"Serenity2";
    
    NSDictionary * dict = [self.arrayData objectAtIndex:indexPath.row];

    if ([dict objectForKey:@"position"]) {
        
        CUSTOMTableViewCellOne * cell = (CUSTOMTableViewCellOne *) [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath: indexPath];

//        2) еще раз прочищаем кеш, чтоб не было багов, картинки могут накладываться друг на друга
        cell.imageViewCustomCell.image = nil;
        cell.labelFigure.text = nil;
        cell.labelPosition.text = nil;
        
        
        NSString * imageName = [NSString stringWithFormat:@"%@.jpg", [dict objectForKey:@"brand"]];

        
//      2)  Указываем путь к картинкам
//        NSString * fikePath = [[NSBundle mainBundle] pathForResource:[dict objectForKey:@"brand"] ofType:@"jpg"];
//        cell.imageViewCustomCell.image = [UIImage imageWithContentsOfFile:fikePath]; // 2) и здесь путь к картинкам, картинки не хранятся в кэше
        
        cell.imageViewCustomCell.image = [UIImage imageNamed: imageName];  //2) Альтернативный способ загрузки картинки, она всегда в кэше, приложение не будет постоянно обращаться на диск
        cell.labelFigure.text = [dict objectForKey:@"position"];
        cell.labelPosition.text = [dict objectForKey:@"brand"];

        return cell;

    }
    
    else {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier1 forIndexPath: indexPath];
    
    
    cell.textLabel.text = [dict objectForKey:@"brand"];
    
    cell.detailTextLabel.text = [dict objectForKey:@"model"];
    
    
    return cell;
    }
}
//_________________________________________________________________________________________________________________________
//   1) Данный метод срабатывает тогда когда нажимаешь на табличную ячейку, когда происходит касание.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    1) Обращаемся к свойству плавной анимации-затуханию после  нажатия на ячейку.
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"Touchscreen %i", indexPath.row);
    
}

-(CGFloat) tableView: (UITableView *) tableView heghtForRowAtIndexPath: (NSIndexPath *) indexPath {
    
    CGFloat size = 0.0f;
    
    NSDictionary * dict = [self.arrayData objectAtIndex:indexPath.row];
    
    if ([dict objectForKey:@"position"]) {
        
        size = 69;
        
    }
    
    else {
    
        size = 37;
    }
    
        return size;
        
}

- (IBAction)actionLoadedFigures:(id)sender {
    
    ProtoClass * proto = [ProtoClass new];
    [proto metWithImage];

}

- (IBAction)actionLoadedData:(id)sender {
    
    [self start];
}

@end


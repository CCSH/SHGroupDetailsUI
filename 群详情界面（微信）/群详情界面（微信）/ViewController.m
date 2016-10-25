//
//  ViewController.m
//  群详情界面（微信）
//
//  Created by CSH on 16/6/28.
//  Copyright © 2016年 CSH. All rights reserved.
//

#import "ViewController.h"
#import "GroupDetalisCollectionViewCell.h"

#define ShakingRadian(R) ((R) / 180.0 * M_PI)

#define HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define WIDTH ([UIScreen mainScreen].bounds.size.width)

#define HeadWidth 60
#define HeadHeight 80
#define HeadNum 5


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>{
    BOOL isOpen;
}

//数据源
@property (nonatomic, copy)NSMutableArray *dataSoure;
@property (strong, nonatomic) UICollectionView *peploCollection;


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController
#pragma mark - 懒加载
- (NSMutableArray *)dataSoure{
    if (!_dataSoure) {
        _dataSoure = [[NSMutableArray alloc]init];
    }
    return _dataSoure;
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 20, WIDTH, HEIGHT - 20);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (NSUInteger i = 0; i < 21; i++) {
        [self.dataSoure addObject:[NSString stringWithFormat:@"第%lu个",(unsigned long)i]];
    }
    //创建collectionView
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    self.peploCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    self.peploCollection.backgroundColor = [UIColor whiteColor];
    
    UINib *cellNib = [UINib nibWithNibName:@"GroupDetalisCollectionViewCell" bundle:nil];
    [self.peploCollection registerNib:cellNib forCellWithReuseIdentifier:@"GroupDetalisCollectionViewCell"];
    self.peploCollection.delegate = self;
    self.peploCollection.dataSource = self;
    self.peploCollection.showsVerticalScrollIndicator = NO;
    self.peploCollection.bounces = NO;
    [self collectionViewHigh:self.dataSoure];
    
}

#pragma mark  - UITableViewDelegate
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row) {
        return 44;
    }else{
        return self.peploCollection.frame.size.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    if (indexPath.row) {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }else{
        [cell addSubview:self.peploCollection];
    }
    
    
    return cell;
}

#pragma mark  - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSoure.count + 2;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
#pragma mark - 实例化UICollectionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GroupDetalisCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroupDetalisCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row < self.dataSoure.count) {//正常头像

        cell.headImage.image = [UIImage imageNamed:@"head.png"];
        cell.headTitle.text =  self.dataSoure[indexPath.row];
        cell.deleteImage.hidden = !isOpen;
        [self shaking:cell isStart:isOpen];
    }else if (indexPath.row == self.dataSoure.count){//删除
        
        cell.headImage.image = [UIImage imageNamed:@"group_minus.jpg"];
        cell.headTitle.text = @"";
        cell.deleteImage.hidden = YES;
        [self shaking:cell isStart:NO];
    }else  if (indexPath.row == self.dataSoure.count + 1){//添加
        
        cell.headImage.image = [UIImage imageNamed:@"group_plus.png"];
        cell.headTitle.text = @"";
        cell.deleteImage.hidden = YES;
        [self shaking:cell isStart:NO];
    }

    return cell;
}
#pragma mark - 定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(HeadWidth, HeadHeight);
}
#pragma mark - 定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, (WIDTH-HeadNum*HeadWidth)/(HeadNum - 1), 10, (WIDTH-HeadNum*HeadWidth)/(HeadNum - 1));
}
#pragma mark - UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row < self.dataSoure.count) {
        if (isOpen) {//删除状态点击头像
            
            [self deleteButtonClick:(int)indexPath.row];
            
        }else{//非删除状态点击头像
           NSLog(@"正常点击==%@",self.dataSoure[indexPath.row]);
        }
        
    }else if (indexPath.row  == self.dataSoure.count) {
        NSLog(@"删除");
        isOpen = !isOpen;
        
    }else if (indexPath.row  == self.dataSoure.count +1){
        NSLog(@"添加");
        if (isOpen) {
            isOpen = NO;
        }
        //在这里可以进行界面跳转
        
        [self.dataSoure addObject:[NSString stringWithFormat:@"新增:%d",arc4random()%10]];
    }
    
    [self collectionViewHigh:self.dataSoure];
}
#pragma mark - 所有改变刷新界面需要调用此方法适配
- (void)collectionViewHigh:(NSArray *)arr{

    float  line = (arr.count+2)/HeadNum + ((arr.count+2)%HeadNum != 0);
    
    //重新设置大小 （10为偏移量，+10为微调）
    CGFloat height = (((HeadHeight + 10) *line + 10) >= (self.view.frame.size.height - 20)) ?(self.view.frame.size.height - 20) : ((HeadHeight + 10) *line + 10);
    self.peploCollection.frame = CGRectMake(0, 0, WIDTH, height);
    
    [self.peploCollection reloadData];
    //刷新
    [self.tableView reloadData];
}
#pragma mark - 删除点击方法
-(void)deleteButtonClick:(int)index{
    NSLog(@"删除===%d",index);
    [self.dataSoure removeObjectAtIndex:index];
    
    [self collectionViewHigh:self.dataSoure];
}
#pragma mark - 抖动动画

- (void)shaking:(UIView *)view isStart:(BOOL)isStart{
   
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.keyPath = @"transform.rotation";
    
    anim.values = @[@(ShakingRadian(-5)),  @(ShakingRadian(5)), @(ShakingRadian(-5))];
    
    anim.duration = 0.25;
    
    // 动画的重复执行次数
    
    anim.repeatCount = MAXFLOAT;
    
    // 保持动画执行完毕后的状态
    
    anim.removedOnCompletion = NO;
    
    anim.fillMode = kCAFillModeForwards;
    
    if (isStart) {
        //开始动画
        [view.layer addAnimation:anim forKey:@"shake"];
    }else{
        //结束动画
        [view.layer removeAnimationForKey:@"shake"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

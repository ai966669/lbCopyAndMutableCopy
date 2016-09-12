//
//  ViewController.m
//  lbCopyAndMutableCopy
//
//  Created by ai966669 on 16/9/12.
//  Copyright © 2016年 ai966669. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testCopyAndMutableCopy];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)testCopyAndMutableCopy {
    
    //    copy和mutableCopy的区别
    //在iOS开发中，我们有如下三种赋值方式
    //A=B
    //A=[B copy]
    //A=[B mutableCopy]
    //“=”赋值，被赋值对象是否可以修改是受原值类型影响,受创建时候的修饰符影响(详见http://www.jianshu.com/p/a29a0bdd5da8)，我们在这里不做讨论。
    //1.copy，mutableCopy都是深拷贝，所谓深拷贝也就是说copy，mutableCopy都会重新开辟出一块内存来保存和原有值相同的值，原有值的变化不会修改被赋值对象的值。
    //1.1注：是容器对象中的元素依旧是浅拷贝，修改后依旧会对被赋值对象造成影响。
    //2.copy的被赋值对象不可被修改，mutableCopy得到的对象可被修改。且不受原值和接受值的类型影响。
    //   下面我们依次通过非容器变量和容器变量来验证上面两条。
   
    
    
    //验证【copy，mutableCopy都是深拷贝，所谓深拷贝也就是说copy，mutableCopy都会重新开辟出一块内存来保存和原有值相同的值，原有值的变化不会修改被赋值对象的值】
    //非容器变量
    //初始化一个mStrOrigin，copy赋值给mStrFromCopy,mStrFromMCopy，输出三者的值和地址。观察他们的值和地址是否相同，从而判断是copy和mutableCopy是否深拷贝。
    NSMutableString *mStrOrigin = [[NSMutableString alloc] initWithString:@"mStr"];
    NSMutableString *mStrFromCopy = [mStrOrigin copy];
    NSMutableString *mStrFromMCopy = [mStrOrigin mutableCopy];
    NSLog(@"值：mStrOrigin：%@ mStrFromCopy：%@  mStrFromMCopy：%@ \n  地址：mStrOrigin：%p mStrFromCopy：%p  mStrFromMCopy：%p \n",mStrOrigin,mStrFromCopy,mStrFromMCopy,mStrOrigin,mStrFromCopy,mStrFromMCopy);
    NSLog(@"现象：mStrA和mStrB数据地址不一样");
    NSLog(@"结论：copy和mutableCopy是深拷贝");
    //修改原值mStrOrigin 观察mStrFromCopy,mStrFromMCopy是否会随之变化
    [mStrOrigin appendString:@"-change1"];
    NSLog(@"值：mStrOrigin：%@ mStrFromCopy：%@  mStrFromMCopy：%@ \n  地址：mStrOrigin：%p mStrFromCopy：%p  mStrFromMCopy：%p \n",mStrOrigin,mStrFromCopy,mStrFromMCopy,mStrOrigin,mStrFromCopy,mStrFromMCopy);
    NSLog(@"现象：mStrB不随着mStrA修改而修改 。 此处是非容器可变变量，读者可以自己实验非容器不可变变量，如NSString,效果是一样的");
    NSLog(@"结论：copy和mutableCopy出来的是新的内存，原值改变新的值不改变。");
    
    
    //容器对象
    //创建一个可变容器mArrOrigin，初始化添加value1，value2两个元素。并通过copy和mutableCopy赋值给mArrFromCopy，mArrFromMCopy。为原值增加一个元素value3，输出三者地址和值。查看地址和值观察是否是深拷贝
    NSMutableArray   *mArrOrigin = [[NSMutableArray alloc] init];
    NSMutableString  *mstr1 = [[NSMutableString alloc] initWithString:@"value1"];
    NSMutableString  *mstr2 = [[NSMutableString alloc] initWithString:@"value2"];
    NSMutableString  *mstr3 = [[NSMutableString alloc] initWithString:@"value3"];
    
    [mArrOrigin addObject:mstr1];
    [mArrOrigin addObject:mstr2];
    
    NSMutableArray *mArrFromCopy = [mArrOrigin copy];
    NSMutableArray *mArrFromMCopy = [mArrOrigin mutableCopy];
    [mArrOrigin addObject:mstr3];
    NSLog(@"值：mArrOrigin :%@ mArrFromCopy:%@ mArrFromMCopy%@\n  地址：mArrOrigin :%p\n mArrFromCopy:%p\n mArrFromMCopy:%p\n",mArrOrigin,mArrFromCopy,mArrFromMCopy,mArrOrigin,mArrFromCopy,mArrFromMCopy);
    NSLog(@"现象：mArrFromCopy，mArrFromMCopy出来的数组是新的地址。读者可实验不可变容器变量NSArray,效果一样");
    NSLog(@"结论：copy和mutableCopy出来的是新的地址，原值改变新的值不改变。");
    //修改原来容器中元素的值mstr1，输出三个容器，观察他们的值是否会改变，从而判断容器对象的copy和mutableCopy赋值是否元素也会深拷贝
    [mstr1 appendString:@"-change2"];
    NSLog(@"值：mArrOrigin :%@ mArrFromCopy:%@ mArrFromMCopy%@\n  地址：mArrOrigin :%p\n mArrFromCopy:%p\n mArrFromMCopy:%p\n",mArrOrigin,mArrFromCopy,mArrFromMCopy,mArrOrigin,mArrFromCopy,mArrFromMCopy);
    NSLog(@"现象：mArrFromCopy，mArrFromMCopy的元素随之改变");
    NSLog(@"结论：容器的copy和mutableCopy赋值中，容器本身是深拷贝，容器中的元素依旧是浅拷贝");
    
    
    
    
    
    
    
    
    
    
    //验证【copy的被赋值对象不可被修改，mutableCopy得到的对象可被修改。且不受原值和接受值的类型影响。】
    //尝试修改mStrFromCopy和mArrFromCopy（他们分别指向copy得到的数据地址），查看是否会崩溃，从而判断copy出来的对象不可被修改的
//    [mStrFromCopy appendString:@"-change3"]; //崩溃 'Attempt to mutate immutable object with appendString:'
//    [mArrFromCopy addObject:mstr3]; //崩溃 [__NSArrayI addObject:]
    NSLog(@"现象：发送崩溃");
    NSLog(@"结论：copy出来的内存是不可被修改的，就算你使用可变变量指针去接受，也不能被修改");
    //尝试修改mStrFromMCopy和mArrFromCopy，查看是否会奔溃
    [mStrFromMCopy appendString:@"-change4"];
    [mArrFromMCopy addObject:mstr3];
    NSLog(@"%@ %@",mStrFromMCopy,mArrFromMCopy);
    NSLog(@"现象：修改成功");
    NSLog(@"结论：mutableCopy出来的数据地址可被修改");
    
    //既然可以修改，如果我们用不可变量指针接受mutableCopy值，那内存地址还能修改吗？
    //我们试验下，此处用可变变量mStrFromMCopy2弱引用指向mutableCopy的数据地址，尝试修改mStrFromMCopy2并输出三者 查看是否能修改成功。
    NSString *strFromMCopy = [mStrOrigin mutableCopy];
    NSMutableString *mStrFromMCopy2 = strFromMCopy;
    //输出地址，证明此时mStrFromMCopy2和strFromMCopy指向同一个数据内存地址
    NSLog(@"值：strFromMCopy：%@  mStrFromMCopy2:%@ 地址：strFromMCopy：%p mStrFromMCopy2:%p",strFromMCopy,mStrFromMCopy2,strFromMCopy,mStrFromMCopy2);
    [mStrFromMCopy2 appendString:@"-change5"];
    NSLog(@"值：strFromMCopy：%@  mStrFromMCopy2:%@ 地址：strFromMCopy：%p mStrFromMCopy2:%p",strFromMCopy,mStrFromMCopy2,strFromMCopy,mStrFromMCopy2);
    NSLog(@"现象：修改mStrFromMCopy2成功。");
    NSLog(@"结论：mutableCopy出来的数据地址可被修改，就算接受指针是不可变类型。此处还说明一个问题指针可以指向不同类型的数据内存");
   
    //刚才试验了不可变对象mutableCopy得到的值可被修改，但如果原值本身就不可修改呢，那么mutableCopy后是否被赋值对象也可修改。
    //创建不可变对象
    NSString *strOrigin = [[NSString alloc] initWithUTF8String:"string 1"];
    mStrFromMCopy = [strOrigin mutableCopy];
    [mStrFromMCopy appendString:@"-change6"];
    NSLog(@"值：strOrigin %@，mStrFromMCopy %@",strOrigin,mStrFromMCopy);
    NSLog(@"现象：修改mStrFromMCopy成功。");
    NSLog(@"结论：mutableCopy出来的数据地址可被修改，就算原值是不可变类型");
    
    NSString *temp;
    NSLog(@"%@",[NSString stringWithFormat:@"%@",temp]);
    
    NSLog(@"综上所述：1.copy和mutableCopy都是深拷贝，但如果是容器对象的话，容器中的元素依旧是浅拷贝(即多个指针指向一个数据地址)。2.copy和mutableCopy生成的内存地址上的数据是否可变跟原值类型和被赋值的指针类型无关。如不可变数据copy出来的内存，用可变指针指向，当你尝试修改的时候，仍然会发生崩溃。提示不可修改");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  Readme.h
//  TableViewDemo
//
//  Created by 张帆 on 16/7/22.
//  Copyright © 2016年 fanstudio. All rights reserved.
//

#ifndef Readme_h
#define Readme_h
#if 0


概览：
1）基本使用，包含索引。
2）等高cell的几种创建方式。
3）非等高cell的几种创建方式。

————————————————————————————————————————————————————————

2.自定义UITableViewCell五种创建方式

方式一：
纯代码实现
dequeueReusableCellWithIdentifier:
缓存池中不存在的采用下面的方法创建，
所以自定义的控件也写在下面这个方法中
initWithStyle: reuseIdentifier:

方式二：
xib方式实现
dequeueReusableCellWithIdentifier:
缓存池中不存在的采用下面的方法创建，注意记得给xib的重用属性填上相应的标识。
loadNibNamed: owner: options:

方式三：
本质上还是纯属代码，只是注册以后，缓存池中没有cell自动调用，方式一的创建方法。
registerClass:forCellReuseIdentifier:
dequeueReusableCellWithIdentifier:

方式四：
本质上还是XIB，只是注册以后，缓存池中没有cell自动调用，方式二的创建方法，
这里可以偷懒不在xib的属性填重用标识，但是建议还是填上。
registerNib:forCellReuseIdentifier:
dequeueReusableCellWithIdentifier:

方式五：
仅使用dequeueReusableCellWithIdentifier:方法
前提是在storyboard中的TableView已经创建了cell,并且指定了标识，本质上类似于方式二。


————————————————————————————————————————————————————————
3.非等高cell的实现

方法一，纯代码frame方式自定义非等高UITableViewCell注意事项：
1）cell的高度需要在代理方法提前计算好，也就在tableView:heightForRowAtIndexPath:中。
2）为保持封装性，一般会在对应的数据模型中，为每个UI元素创建对应的CGRect属性，并计算出整个cell的高度，注意这里的计算不是在cell中计算。
3）在tableView:heightForRowAtIndexPath:直接调用模型计算好的高度。
4）在cell的layoutSubViews中直接去拿模型中对应的frame。

这种套路是：
1）先要所有CELL的高度
2）创建对应的cell，并给cell对应的model赋值
3）cell拿到模型，装填数据。
4）cell统一布局，调用layoutSubViews，这个时候去拿model对应的frame。

补充说明：
这种情况下有多少条需要展际的cell数据，就会调用多少次
tableView:heightForRowAtIndexPath:以确定tableView的contentSize，
也用于展示tableview的滚动动长度，数据越多，长度越短。
这种布局是先获取到使用cell的高度，然后调用tableView: cellForRowAtIndexPath:创建具体的cell



方法二，autoLayout方式（可以是代码或者是xib/storyboard）
1）自定义cell，并添加相应的约束，将相应的控件暴露在头文件中
2）在tableView:heightForRowAtIndexPath:中创建一个临时的cell（建议通过缓存池去取，并且保存下来，避免重复创建）。
3） 设置cell中的子控件如label.preferredMaxLayoutWidth的值。
4）给临时cell添加对应的model
5）强制cell布局，layoutIfNeeded(当前计算的cell并没有显示，不显示的cell，auto layout不会自动去计算宽高)。
6）返回自动计算出的宽高，
7）优化tableView:heightForRowAtIndexPath:的调用方式。设置tableView.estimatedRowHeight = (估算值)。这个
值的大小可以影响tableView:heightForRowAtIndexPath:的调用次数，次数大致等于= 屏幕高度 / 估算值。如果值
大小，起不到优化作用，值太大，最终显示时，还是会调用对应cell数的次数，建议还是大致与实际相同。
8）设置估算值后，会改变原有的方法调用顺序，从先获取高度再创建cell，变为先创建cell再获取高度，也就是说
先执行vtableView: cellForRowAtIndexPath:再执行 tableView:heightForRowAtIndexPath:

注意上面的1~6步骤中，计算cell的实际高度。
不仅是UILabel，还有UITextView这类貌似都需要填上类似于preferredMaxLayoutWidth的值？？？这里在编码时再来完善。



方法三，利用苹果的self-sizing技术，自动计算高度。
1）在storyboard中的UITableViewCell添加子控件，并设置约束（有默认宽高的可以不设置宽高，但是一要表示出各控件的间距）。
2）添加如下代码
tableView.rowHeight = UITableViewAutomaticDimension；
tableView.estimatedRowHeight = 44.0(估算值)
3）控件动态显示或隐藏，是通过修改约束的高度并配合hiden属性来实现的。
4）注意该项技术是在ios8之前无法使用。










#endif
#endif /* Readme_h */

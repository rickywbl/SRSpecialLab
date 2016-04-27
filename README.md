# SRSpecialLab
部分文字可以响应时间的lab

##使用

``` objc
NSString *str = @"【广西出台41条措施降低实体经济企业成本】广西壮族自治区政府日前出台４１条措施，明确从降低制度性交易成本、税费、人工成本等７个方面降低实体经济企业成本，进一步改善企业发展环境，增强企业盈利能力和发展活力。http://t.cn/RqWmb2r";

NSString *speciaStr1 = @"http://t.cn/RqWmb2r";

NSRange rang1 = [str rangeOfString:speciaStr1];

SRSpecialObj *obj1 = [[SRSpecialObj alloc]init];
obj1.text = speciaStr1;
obj1.range = rang1;
NSString *speciaStr2 = @"广西出台41条措施降";
NSRange rang2 = [str rangeOfString:speciaStr2];

SRSpecialObj *obj2 = [[SRSpecialObj alloc]init];
obj2.text = speciaStr2;
obj2.range = rang2;

SRSpecialLable *lable = [[SRSpecialLable alloc]initWithFrame:CGRectMake(20, 100, 300, 200)];
lable.specials = @[obj1,obj2];
lable.SRdelegate  =  self;
lable.attributedText = [[NSAttributedString alloc]initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];

[self.view addSubview:lable];
```
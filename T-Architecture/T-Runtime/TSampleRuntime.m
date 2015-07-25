//
//  TSampleRuntime.m
//  T-Architecture
//
//  Created by T.J. on 15/6/14.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import "TSampleRuntime.h"
#import <objc/runtime.h>
#import "TRuntimeTest.h"
#import <UIKit/UIKit.h>
#import "NSArray+Swizzle.h"

/*
    runtime 只能在MRC的环境下使用
 */

@implementation TSampleRuntime

/*
    对象copy
 */
- (void)copyObject
{
    TRuntimeTest *obj = [TRuntimeTest new];
    NSLog(@"obj:%p", obj);
    
    id copyObj = object_copy(obj, sizeof(obj));
    NSLog(@"copyObj:%p", copyObj);
    
    [copyObj testFun];
}

/*
    对象释放
 */
- (void)objectDispose
{
    TRuntimeTest *obj = [TRuntimeTest new];
    object_dispose(obj);
    
    // 重复释放 crash
//    [obj release];
    
    // crash
    [obj testFun];
}

/*
    更改对象的类
 */
- (void)setClass
{
    TRuntimeTest *obj = [TRuntimeTest new];
    [obj testFun];
    
    Class newClass = object_setClass(obj, [TNewRuntimeTest class]);
    
    NSLog(@"new class:%@", NSStringFromClass(newClass));
    NSLog(@"obj class:%@", NSStringFromClass([obj class]));

    // 有警告信息，但实际是能找到TNewRuntimeTest中的newTestFun方法
    [(TNewRuntimeTest *)obj newTestFun];
}

/*
    获取对象的类
 */
- (void)getClass
{
    TRuntimeTest *obj = [TRuntimeTest new];
    Class objClass = object_getClass(obj);
    NSLog(@"objClass:%@", NSStringFromClass(objClass));
}

/*
    获取对象的类名
 */
- (void)getClassName
{
    TRuntimeTest *obj = [TRuntimeTest new];
    NSString *className = [NSString stringWithCString:object_getClassName(obj) encoding:NSUTF8StringEncoding];
    
    NSLog(@"className:%@", className);
}

/*
    给类增加一个方法
 */
int functionWithOneParam(id self, SEL _cmd, NSString *str)
{
    NSLog(@"str:%@", str);
    return 0;
}

- (void)addMethodWithOneParam
{
    TRuntimeTest *obj = [TRuntimeTest new];
    
    // add method
    class_addMethod([TRuntimeTest class], @selector(newMethod:), (IMP)functionWithOneParam, @"i@:@");

    if ([obj respondsToSelector:@selector(newMethod:)]) {
        NSLog(@"Yes, obj respondsToSelector:@selector(newMethod:)");
    }
    else {
        NSLog(@"no");
    }
    
    int ret = (int)[obj newMethod:@"this is OC method, by C function!"];
    NSLog(@"ret:%d", ret);
}

int functionWithTwoParam(id self, SEL _cmd, NSString *str1, NSString *str2)
{
    NSLog(@"str1:%@>>><<<str2%@", str1, str2);
    return 0;
}

- (void)addMethodWithTwoParam
{
    TRuntimeTest *obj = [TRuntimeTest new];
    
    class_addMethod([TRuntimeTest class], @selector(newMethodWithTwoParam::), (IMP)functionWithTwoParam, @"i@:@@");
    
    if ([obj respondsToSelector:@selector(newMethodWithTwoParam::)]) {
        NSLog(@"Yes, obj respondsToSelector:@selector(newMethodWithTwoParam::)");
    }
    else {
        NSLog(@"no");
    }
    
    int ret = (int)[obj newMethodWithTwoParam:@"this is OC method, by C function!":@"second param!"];
    NSLog(@"ret:%d", ret);
}

/*
    说明：
    ObjC的方法（method）就是一个至少需要两个参数（self，_cmd）的C函数，IMP有点类似函数指针，指向具体的Method实现。

    BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)
    参数说明：
    cls：被添加方法的类
    name：可以理解为方法名
    imp：实现这个方法的函数
    types：一个定义该函数返回值类型和参数类型的字符串
 

    eg：class_addMethod([TestClass class], @selector(ocMethod:), (IMP)testFunc, "i@:@");
 
    其中types参数为"i@:@“，按顺序分别表示：
    i：返回值类型int，若是v则表示void
    @：参数id(self)
    :：SEL(_cmd)
    @：id(str)
 */


/*
    获取一个类的所有方法
 */
- (void)getClassAllMethod
{
    u_int count;
    Method *methods = class_copyMethodList([UIViewController class], &count);
    for (int i=0; i<count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *methodName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"%d:%@", i, methodName);
    }
}

/*
    获取一个类的所有属性
 */
- (void)getClassAllProperty
{
    u_int count;
    objc_property_t *properties = class_copyPropertyList([UIViewController class], &count);
    for (int i=0; i<count; i++) {
        const char *name = property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        NSLog(@"%d:%@", i, propertyName);
    }
}

/*
    获取类中全局变量的值，属性（property）不可以获取到
 */
- (void)getInstanceVar
{
    float floatValue;
    TRuntimeTest *obj = [TRuntimeTest new];
    object_getInstanceVariable(obj, "myValue", (void *)&floatValue);
    NSLog(@"floatValue:%f", floatValue);
}

/*
    设置类中全局变量的值
 */
- (void)setInstanceVar
{
    float newValue = 10.0f;
    TRuntimeTest *obj = [TRuntimeTest new];
    
    // 注意第三个参数的使用方式
    object_setInstanceVariable(obj, "myValue", *(float **)&newValue);
    [obj testFun];
}

/*
    判断类中某个属性的类型
 */
- (void)getVarType
{
    TRuntimeTest *obj = [TRuntimeTest new];
    Ivar var = class_getInstanceVariable(object_getClass(obj), "myValue");
    const char *type = ivar_getTypeEncoding(var);
    NSString *stringType = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
    NSLog(@"stringType:%@", stringType);
}

/*
    反射机制，通过属性的值来获取属性的名称
 */
- (void)nameOfInstance
{
    unsigned int numIvars = 0;
    NSString *key = nil;
    TRuntimeTest *obj = [TRuntimeTest new];

    Ivar *ivars = class_copyIvarList([TRuntimeTest class], &numIvars);
    for (int i=0; i<numIvars; i++) {
        Ivar var = ivars[i];
        const char *type = ivar_getTypeEncoding(var);
    
        NSString *typeString = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        if (![typeString hasPrefix:@"@"]) {
            continue;
        }
        
        // object_getIvar 这个方法遇到非ObjC对象会crash，因此不能对基本数据类型，如“float”型属性进行反射
        if ([object_getIvar(obj, var) isEqual:@"hello"]) {
            key = [NSString stringWithUTF8String:ivar_getName(var)];
            NSLog(@"key:%@", key);
            continue;
        }
    }
    free(ivars);
}

/*
    替换系统类的方法
 */
- (void)methodExchange
{
    Method m1 = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method m2 = class_getInstanceMethod([NSString class], @selector(uppercaseString));
    method_exchangeImplementations(m1, m2);
    
    NSLog(@"lowercaseString:%@", [@"aaBBcc" lowercaseString]);
    NSLog(@"uppercaseString:%@", [@"aaBBcc" uppercaseString]);
}

/*
    替换自定义类中方法的实现
 */
- (void)methodSetImplementation
{
    // 类TRuntimeTest中的方法被替换成了类TNewRuntimeTest中的方法newTestFun
    Method myMethod = class_getInstanceMethod([TNewRuntimeTest class], @selector(newTestFun));
    IMP originalImp = method_getImplementation(myMethod);
    Method method = class_getInstanceMethod([TRuntimeTest class], @selector(testFun));
    method_setImplementation(method, originalImp);
}

/*
    覆盖系统类中的方法
 */
- (void)systemMethodExchange
{
    Method originalMethod = class_getInstanceMethod([NSArray class], @selector(lastObject));
    Method myMethod = class_getInstanceMethod([NSArray class], @selector(myLastObject));
    method_exchangeImplementations(originalMethod, myMethod);
}

@end

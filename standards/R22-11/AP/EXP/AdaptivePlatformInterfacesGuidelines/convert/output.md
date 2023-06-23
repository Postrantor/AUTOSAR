---
tip: translate by openai@2023-06-23 13:06:23
...
# Table of Contents

- [Table of Contents](#table-of-contents)
  - [Prereads](#prereads)
  - [Relationship to other AUTOSAR specifications](#relationship-to-other-autosar-specifications)
    - [ErrorCode](#errorcode)
    - [Result](#result)
    - [Faults inside constructors](#faults-inside-constructors)
  - [Deterministic Execution](#deterministic-execution)
    - [Advanced State Management functionality](#advanced-state-management-functionality)
    - [Key Value Storage](#key-value-storage)
    - [File Storage](#file-storage)
  - [Example usage of Key-Value Storage API](#example-usage-of-key-value-storage-api)
  - [Example usage of File Storage API](#example-usage-of-file-storage-api)
  - [Redundancy feature](#redundancy-feature)
  - [Reset Storage](#reset-storage)
  - [Update and Removal of Persistent Data](#update-and-removal-of-persistent-data)
  - [Method deployments](#method-deployments)
  - [Data transfer, message loss and block sizes](#data-transfer-message-loss-and-block-sizes)
- [References](#references)

```{=html}
<!-- -->
```


1. # Introduction to this document

> # 此文档介绍

   1. ## Contents


While SWS of FC is a specification for ARA interfaces, some of the interfaces require "guidelines" on how to use them. The guidelines are indeed related to the specification, but some are indirect and having such information within each SWS bloats SWS hence making it difficult for readers to grasp the usage. Another important perspective is that these guidelines are a kind of requirement against AA to follow, but SWS of FC are specification requirements for FCs. Therefore, it does not fit well to have these contents in SWS, and this is the purpose of this "Guidelines for using Adaptive Platform Interfaces."

> 虽然FC的SWS是ARA接口的一个规范，但有些接口需要“指南”来指导如何使用它们。这些指南确实与规范有关，但有些是间接的，而把这些信息放在每个SWS中会使SWS膨胀，从而使读者很难理解其用法。另一个重要的观点是，这些指南是AA必须遵守的一种要求，但FC的SWS是FC必须遵守的规范要求。因此，把这些内容放在SWS中并不合适，这就是本“使用自适应平台接口的指南”的目的。


The main contents of this document will be the guidelines for applications to follow as mentioned in the background above. Not necessarily all FCs will have contents in this document; they will be added when it deems valid.

> 本文档的主要内容将是根据上述背景提及的申请指南。不一定所有的FC都会在本文档中有内容；在认为合适时将会添加。


The contents are organized per relevant topic, but in general, this will be grouped by FC, each having its independent chapter. Also, note that the contents may be provided in separate AUTOSAR AP documents. If this is the case, such documents will be listed or referenced from this guideline.

> 内容按相关主题组织，但一般情况下，将按FC分组，每个FC有其独立的章节。此外，请注意，内容可能在单独的AUTOSAR AP文档中提供。如果是这种情况，则会在本指南中列出或引用这些文档。

## Prereads


This document is a supplementary document to the SWS of AP. Therefore, the relevant SWS of the topic in these guidelines should be read in parallel. Also, the first AP document to be read is \[1\], which gives the architectural overview of AP.

> 这份文件是AP的SWS的补充文件。因此，这些指南中与话题相关的SWS应该并行阅读。此外，第一份需要阅读的AP文件是[1]，它提供了AP的架构概览。

## Relationship to other AUTOSAR specifications


Refer to [Contents](#contents) and [Prereads](#prereads).

> 参考[目录](#contents)和[预读](#prereads)。

2. # Common Regulations


   1. ## Reserved namespaces

> ## 保留的命名空间


The namespace ara (and all namespaces below it) are reserved by AUTOSAR.

> ara命名空间（及其所有下属命名空间）由AUTOSAR保留。


The behavior of an Adaptive Application is undefined if it adds declarations or definitions to namespace ara or to a namespace within namespace ara.

> 行为自适应应用程序如果向ara命名空间或ara命名空间内的命名空间添加声明或定义是不确定的。

Note: the standardized namespaces could have been extended by the platform vendors to be able to implement the standard or to provide extensions.

3. # Adaptive Core

   1. ## Error handling


Handling errors is a crucial topic for any software development. For safety-critical software, it is even more important, because lives can depend on it. However, current standards for the development of safety-critical software places significant restrictions on the build toolchain, especially with regard to C++ exceptions. For ASIL applications, using C++ exceptions is usually not possible due to the lack of exceptions support with ASIL-certified C++ compilers.

> 处理错误对于任何软件开发来说都是一个至关重要的主题。对于安全关键软件，它更加重要，因为生命可能取决于它。然而，当前用于开发安全关键软件的标准对构建工具链，尤其是关于C++异常方面施加了严格的限制。对于ASIL应用，由于ASIL认证的C++编译器缺乏异常支持，通常不能使用C++异常。


The Adaptive Platform introduces a concept that enables error handling without C++ exceptions and defines a number of C++ data types to aid in this.

> 适应性平台引入了一种概念，可以在不使用C++异常的情况下处理错误，并定义了一些C++数据类型来帮助实现这一点。


From an application programmer's point of view, the central types implementing this concept are []{#_bookmark8 .anchor}ara::core::ErrorCode and ara::core::Result.

> 从应用程序开发者的角度来看，实现这一概念的核心类型是ara::core::ErrorCode和ara::core::Result。

### ErrorCode


An instance of ara::core::ErrorCode represents a specific error condition within a software. It is similar to std::error_code, but differs in significant aspects from it.

> 一个ara::core::ErrorCode的实例代表软件中的一个具体的错误条件。它类似于std::error_code，但在重要方面有所不同。


An ErrorCode always contains an enumeration value (type-erased into an integral type) and a reference to an *error domain*. The enumeration value describes the specific type of error, and the error domain reference defines the context where that error is applicable. Additional optional members are a user-defined message string and a vendor-defined supplementary error description value.

> 一个错误码总是包含一个枚举值（被擦除成一个整数类型）和一个对*错误域*的引用。枚举值描述特定类型的错误，而错误域引用定义了该错误适用的上下文。其他可选成员还有用户定义的消息字符串和供应商定义的辅助错误描述值。

### Result


Class ara::core::Result follows the "ValueOrError" concept from the C++ proposal p0786 (see https://wg21.link/P0786). It either contains a value or an error. Due to their templated nature, both value and error can be of any type. However,

> ara::core::Result 遵循 C++ 提案 p0786 中的“ValueOrError”概念（参见https://wg21.link/P0786）。它要么包含一个值，要么包含一个错误。由于它们的模板性质，值和错误都可以是任何类型。


*ErrorType* defaults to ara::core::ErrorCode, and it is expected that this assignment is kept throughout the Adaptive Platform.

> *ErrorType* 默认设置为ara::core::ErrorCode，并期望在整个Adaptive Platform中保持这种赋值。


Because the *ErrorType* is defaulted to ara::core::ErrorCode, most declarations of ara::core::Result only need to give the *ValueType*, e.g. ara::core::Result\<int\> for a Result type that contains either an int variable, or an ErrorCode.

> 因为*ErrorType*默认为ara::core::ErrorCode，所以大多数ara::core::Result的声明只需要指定*ValueType*，例如ara::core::Result\<int\>表示一个可以包含int变量或ErrorCode的Result类型。


ARA interfaces use ara::core::Result as the return type for functions that can encounter recoverable errors. This type can be used to either generate a C++ exception from the object if the user chooses to use exceptions, or retrieve

> ARA 的接口使用 ara::core::Result 作为可能遇到可恢复错误的函数的返回类型。如果用户选择使用异常，此类型可用于从对象生成 C++ 异常。


error information via observer methods without using exceptions.

> 通过观察者方法而不使用异常来传递错误信息。


This section guides you on how to handle such Result objects returned from ARA interface in your application code, and also gives guidance on how to create new Result objects within your own Adaptive Application.

> 此部分指导您如何在应用程序代码中处理从ARA接口返回的这些Result对象，并就如何在自己的自适应应用程序中创建新的Result对象给出指导。


1. **Creation of a Result**

> 创造一个结果


For creating a Result with an embedded *value*, there are constructors allowing implicit conversion from a *ValueType*. This makes defining a Result with a value quite straightforward:

> 为了创建一个带有嵌入式*值*的结果，有构造函数允许从*值类型*进行隐式转换。这使得定义一个带有值的结果变得相当简单:


Result\<int\> res1(42); Result\<int\> res2 = 42;

> 结果\<int\> res1（42）；结果\<int\> res2 = 42；


Returning a value from a function declared to return a Result is similarly straightforward:

> 从声明为返回结果的函数返回值也同样简单：


Result\<int\> myfunction()

> 结果\<int\>我的函数()

{

return 42;

}


Putting an *error* inside a Result requires calling an explicit constructor, e.g.:

> 将一个错误放入结果中需要调用一个显式的构造函数，例如：


ErrorCode ec = MyEnum::some_error; Result\<int\> res2(ec);

> 错误码ec = MyEnum::some_error; 结果res2（ec）;


Alternatively, construction of Result objects is also possible with static member functions, for instance:

> 另外，也可以使用静态成员函数来构造Result对象，例如：


Result\<int\> res1 = Result\<int\>::FromValue(42); Result\<int\> res2 = Result\<int\>::FromError(ec);

> 结果\<int\> res1 = 结果\<int\>::从值(42); 结果\<int\> res2 = 结果\<int\>::从错误(ec);


These forms can be advantageous when *ValueType* or *ErrorType* are expensive to copy because they allow in-place construction. For instance, returning a Result containing an instance of BigClass which is constructed with two constructor arguments "a1" and "a2" could look like this:

> 当*ValueType*或*ErrorType*昂贵且复制时，这些形式可能具有优势，因为它们允许原地建构。例如，返回一个包含用两个构造函数参数"a1"和"a2"构建的BigClass实例的Result可能看起来像这样：


return Result\<BigClass\>::FromValue(a1, a2);

> 返回Result<BigClass>::FromValue（a1，a2）；


For *ErrorType*, this also allows implicit construction of the ErrorCode instance, including an optional supplementary data value:

> 对于*ErrorType*，这也允许隐式构建ErrorCode实例，包括可选的补充数据值：


return Result\<BigClass\>::FromError(

> 返回Result<BigClass>::FromError(


MyEnum::some_error, // ErrorCode enum value

> 我的枚举::一些错误，// 错误码枚举值


0x12345678 // support data value

> 0x12345678 // 支持数据值

);


With this form of construction, only one constructor call is performed, unlike the regular (unnamed) constructor call, where at least two constructor calls are performed, because the pre-created value must then be copied or moved into the Result instance.

> 使用这种构造形式，只执行一次构造函数调用，而不像常规（未命名）构造函数调用那样至少执行两次构造函数调用，因为必须将预先创建的值复制或移动到Result实例中。


2. **Retrieving values and errors**

> 2. **检索值和错误**


When trying to retrieve the value or error that is contained within a Result, one first has to consider which one of these (value or error) is available. In general, this is not

> 在尝试检索Result中包含的值或错误时，首先要考虑哪一个（值或错误）可用。一般来说，这不是


When working without exceptions, the Result object is queried to check whether it contains a value or an error:

> 当不使用异常的时候，需要查询Result对象来检查它是否包含一个值或错误。


Result\<int\> some_function() { ... }

> 结果\<int\> some_function() { ... }


Result\<int\> res = some_function(); if (res.HasValue()) {

> 结果\<int\> res = some_function(); 如果(res.有值()) {


int theValue = res.Value();

> 在Value()中的值 = res.Value();

} else {


ErrorCode const& ec = res.Error();

> 错误码const& ec = res.Error();

}


This code also works in a completely exception-free environment, including with a compiler that does not support exceptions at all.

> 这段代码也可以在完全没有异常的环境中正常工作，甚至是在不支持异常的编译器中也可以正常工作。


When working with an exception-based workflow, the query code looks quite similar to regular exception-based code:

> 在使用基于异常的工作流时，查询代码看起来与常规基于异常的代码相似：


Result\<int\> some_function() { ... }

> 结果\<int\> some_function() { ... }


int theValue = some_function().ValueOrThrow();

> int 值 = some_function().ValueOrThrow();


Here, the Result object that is returned by some_function() is immediately reduced to its *ValueType* (int) by calling its ValueOrThrow() member function.

> 在这里，通过调用some_function（）返回的Result对象立即通过调用其ValueOrThrow（）成员函数被缩减为其*ValueType*（int）。


If the Result did contain an ErrorCode, this would immediately throw an exception type that corresponds to the embedded ErrorCode object.

> 如果结果包含错误代码，这将立即引发与嵌入的错误代码对象对应的异常类型。


Naturally, a try...catch block should be added at a suitable location in the code.

> 自然而然，应该在代码的合适位置添加一个try...catch块。

3. **Advanced topics**


The two basic methods for retrieving the embedded value or error are called just as such: Result::Value() and Result::Error(). However, when calling any of these, one has to be certain that the Result object does indeed contain what is implied by calling one of these functions. In the previous section, this was done by first calling Result::HasValue(), and calling Value() or Error() depending on the outcome of that call.

> 两种检索嵌入值或错误的基本方法分别称为Result::Value()和Result::Error()。但是，调用这些函数时，必须确保Result对象确实包含调用其中一个函数所暗示的内容。在上一节中，通过首先调用Result::HasValue()，并根据该调用的结果调用Value()或Error()来完成此操作。


A more convenient way of accessing the embedded value has already also been mentioned in the previous section: By calling Result::ValueOrThrow, no if-statement is needed, and the invocation collapses into a single-line statement (excluding the try...catch block, which might exist elsewhere).

> 在上一节中已经提到了更方便的访问嵌入值的方法：通过调用Result::ValueOrThrow，不需要if语句，调用可以简化为单行语句（不包括可能存在的try...catch块）。


Other convenience methods exist, for instance Result::ValueOr, which retrieves the value, if if exists, or takes a default value otherwise (i.e., in case of any error), e.g.:

> 其他方便的方法也存在，例如Result::ValueOr，它可以检索值（如果存在），或者在出现任何错误时采用默认值，例如：


int res = some_function().ValueOr(42);

> int res = some_function().ValueOr(42);
int res = some_function().取值或(42);


A generalization of Result::ValueOr is called Result::Resolve, which does not take a default value as an argument, but a Callable, which is to create the default value on-

> 一个Result::ValueOr的泛化版本叫做Result::Resolve，它不需要一个默认值作为参数，而是一个可调用的，可以在运行时创建默认值。


int res = some_function()

> int res = 某些函数（）


.Resolve(\[\](ErrorCode const& ec){ return 42; });

> 解析（[](ErrorCode const& ec){ 返回 42; });


For this particular example, using Result::Resolve instead of Result::ValueOr does not make much sense. However, it can be advantageous when the default value is expensive to create. By using Result::Resolve, the default value is only created when it is needed.

> 对于这个特定的例子，使用Result::Resolve而不是Result::ValueOr没有太多意义。但是，当默认值创建成本高时，使用Result::Resolve可以具有优势。通过使用Result::Resolve，只有在需要时才会创建默认值。


Another convenience method is Result::Bind, which allows to transform the contained value into another value, or even into another type. For instance:

> 另一个方便的方法是Result::Bind，它允许将包含的值转换为另一个值，甚至转换为另一种类型。例如：


Result\<String\> res = some_function()

> 结果\<字符串\> res = some_function()


.Bind(\[\](int v){ return v + 1; })

> `.绑定（[](int v){return v + 1;})`


.Bind(\[\](int v){ return std::to_string(v); })

> .绑定（[ ]（int v）{ return std::to_string（v）; }）


.Bind(\[\](String const& s) { return \"\'\" + s + \"\'\"); });

> `.绑定（[ ]（const& s字符串）{返回“'”+ s +“'”；}）；）；


The first call to Result::Bind takes the int value contained in the Result object, adds one to it, puts that into a new Result object, and returns it.

> 第一次调用Result::Bind会取出Result对象中包含的int值，将其加1，将结果放入一个新的Result对象中，并返回它。


The second call to Result::Bind takes the incremented int value from the new Result object, converts it into a String, and returns a new Result\<String\> object with it.

> 第二次调用Result::Bind从新的Result对象中获取增加的int值，将其转换为字符串，并返回一个新的Result\<String\>对象。


The third and final call to Result::Bind takes the String object contained in the new

> 第三次和最終次調用Result::Bind將新的字符串對象綁定起來。


Result object, adds quote characters to it, and returns a new Result object with it.

> 结果对象，向其添加引号字符，并返回带有它的新结果对象。


If the Result does not contain a value, then none of these Callables are invoked, and the Result object is only type-converted but retains the original ErrorCode.

> 如果结果不包含值，那么这些可调用对象都不会被调用，结果对象只会进行类型转换，但保留原始的错误码。


The Callables passed to Result::Bind must take a suitable type as a parameter and can return either a *ValueType* directly (as shown above, and either the same *ValueType* as before, or a new, different *ValueType*), or a Result\<ValueType\>.

> 传递给Result::Bind的可调用对象必须接受一个合适类型的参数，并且可以直接返回*ValueType*（如上所示，前一个*ValueType*与后一个*ValueType*可以相同也可以不同），或者返回Result\<ValueType\>。

### Faults inside constructors


Constructors cannot return ara::core::Result objects. Therefore, constructors that may encounter recoverable errors will throw exceptions when they do so. The ARA API uses a technique that is similar to the named constructor idiom to support applications that do not use exception mechanisms. For each constructor that may throw exceptions as part of its defined behavior, a class provides an additional static method as an alternative to create objects. The method has the name Create and does not throw exceptions. It has the same parameters as the constructor.

> 构造函数不能返回ara::core::Result对象。因此，可能遇到可恢复错误的构造函数在发生这种情况时会抛出异常。ARA API使用类似于命名构造函数惯用法的技术来支持不使用异常机制的应用程序。对于可能抛出异常作为其定义行为的构造函数，该类提供另一个静态方法作为创建对象的替代方法。该方法名为Create，不会抛出异常。它具有与构造函数相同的参数。

简体中文：构造函数不能返回ara::core::Result对象。因此，可能遇到可恢复错误的构造函数在发生这种情况时会抛出异常。ARA API使用类似于命名构造函数惯用法的技术来支持不使用异常机制的应用程序。对于可能抛出异常作为其定义行为的构造函数，类提供另一个静态方法作为创建对象的替代方法，名为Create，不会抛出异常，参数与构造函数相同。


For example, a class that provides the constructor

> 例如，一个提供构造函数的类


SomeClass::SomeClass(uint8_t i);

> SomeClass::SomeClass（uint8_t i）；


which may throw exceptions, also provides the static method

> 可能抛出异常，也提供静态方法。


static ara::core::Result\<SomeClass\> SomeClass::Create(uint8_t i) noexcept;

> 静态ara::core::Result<SomeClass> SomeClass::Create（uint8_t i）noexcept;


The method Create returns an ara::core::Result object, which either contains the new instance of the class or an error. Retrieving one or the other from the return value is similar to all other functions that return ara::core::Result objects (see Section 2.1.2).

> 方法Create返回一个ara::core::Result对象，其中包含类的新实例或错误。从返回值中检索一个或另一个与其他返回ara::core::Result对象的函数相似（参见第2.1.2节）。


Both the constructor itself and the method Create are available for constructors that may throw exceptions if the toolchain supports exceptions. However, if the toolchain does not support exceptions, only the method Create is available. Calling the constructor will result in a compilation error. Accordingly, code that uses the static method will compile on both kinds of toolchains. Code that uses the constructor will only compile on toolchains that support exceptions.

> 如果工具链支持异常，构造函数本身和Create方法都可用于构造函数，它们可能会抛出异常。但是，如果工具链不支持异常，则只有Create方法可用。调用构造函数将导致编译错误。因此，使用静态方法的代码将在两种工具链上编译。使用构造函数的代码只能在支持异常的工具链上编译。


The static methods for creating instances of a class are only provided for constructors that may throw exceptions as part of their defined behavior. For other constructors, invariably use the constructor.

> 静态方法用于创建类的实例只针对可能抛出异常作为其定义行为的构造函数提供。对于其他构造函数，始终使用构造函数。

2. ## Reserved symbols


   1. ### Preprocessor macros

> ### 预处理宏


The Adaptive Platform generally avoids the use of C/C++ preprocessor macros.

> 适应性平台通常避免使用C/C++预处理器宏。


However, in case macros are introduced at some later point in time, any such macro will start with the prefix ARA. Macros with this prefix should thus not be defined by developers of an Adaptive Application.

> 然而，如果在以后的某个时间点引入宏，任何这样的宏都将以ARA作为前缀开始。因此，自适应应用程序的开发人员不应定义具有此前缀的宏。


4. # Execution Management

> 4. # 执行管理


   1. ## Execution State

> ## 执行状态


The Execution State characterizes the internal lifecycle of any Process. Each Process needs to report changes in its Execution State to Execution Management, using the ExecutionClient::ReportExecutionState() interface (see \[2\]).

> 执行状态描述了任何进程的内部生命周期。每个进程都需要使用ExecutionClient::ReportExecutionState（）接口（参见[2]）向执行管理报告其执行状态的变化。

![](./media/image1.png){width="6.364103237095363in" height="1.2962489063867018in"}

**Figure 4-1 Execution States**


Upon Process startup, Execution Management shall consider Process initialization complete when the state kRunning is reported (see \[SWS_EM_01004 and SWS_EM_01402\]). Please note that Service Discovery can introduce nondeterministic delays and thus is advised to be done after reporting kRunning state; thus, the Process may not have completed all its initialization when the kRunning state is reported by the Process.

> 在进程启动时，执行管理应当在进程报告kRunning状态时认为进程初始化完成（参见[SWS_EM_01004和SWS_EM_01402]）。请注意，服务发现可能引起不确定性延迟，因此建议在报告kRunning状态后进行；因此，当进程报告kRunning状态时，进程可能尚未完成其所有初始化工作。


Execution Management initiates Process termination by sending the SIGTERM signal to a Process.

> 执行管理通过向进程发送SIGTERM信号来启动进程终止。


On receipt of SIGTERM, the Process is expected to save persistent data and free all internally used resources. The Process indicates completion of the Terminating state by termination with exit status 0 (EXIT_SUCCESS). Execution Management does not require an explicit notification of actual Process termination by the process itself.

> 收到SIGTERM时，进程预期会保存持久数据并释放所有内部使用的资源。进程通过以退出状态0（EXIT_SUCCESS）终止来表明终止状态的完成。执行管理不需要进程本身对实际进程终止进行显式通知。

## Deterministic Execution


Execution Management supports a fully deterministic multithreaded execution of a Process, so processing a given set of input data always produces a consistent output within a bounded time, i.e. the behavior is reproducible.

> 执行管理支持进程的完全确定性多线程执行，因此处理给定的输入数据总是在有限的时间内产生一致的输出，即行为是可重现的。


Expected use cases of the AUTOSAR Adaptive Platform where such determinism is required include redundant execution in a Software Lockstep framework for systems with high safety goals (up to ASIL D) and reuse of verified software. For more details see \[2\], section "Deterministic Execution".

> 预期的AUTOSAR Adaptive 平台的使用案例，其中需要这种确定性，包括在具有高安全目标（最高可达ASIL D）的软件锁步框架中的冗余执行以及已验证软件的重用。有关更多详细信息，请参见[2]，“确定性执行”一节。


A Process that can be executed fully deterministically must be designed, implemented and integrated in a way such that it is independent of processor load caused by other functions and calculations, sporadic unrelated events, race conditions, deviating random numbers, etc.

> 一个可以完全确定性执行的过程必须被设计、实现和整合，以便它独立于由其他功能和计算引起的处理器负载、偶发的不相关事件、竞争条件、偏离随机数等。


Non-deterministic behavior may arise from different reasons; for example insufficient computing resources, or uncoordinated access of data, potentially by multiple threads running on multiple processor cores. The order in which the threads access such data will affect the result, which makes it non-deterministic.

> 非确定性行为可能由不同原因引起；例如不足的计算资源，或者多个线程在多个处理器核心上无序访问数据。线程访问数据的顺序会影响结果，这使得它变得非确定性。


Full deterministic execution includes:

> 完全确定性执行包括：


- Time Determinism: The output of the calculation is always produced before a given deadline. The resource demands of the Process need to be described in a standardized way, so the integrator can assign sufficient resources to the Process (see subsection "Real-Time Resources" in \[2\]).

> 时间决定论：计算的输出总是在给定的截止日期之前产生。过程的资源需求需要以标准化的方式描述，以便集成器可以为过程分配足够的资源（参见[2]中的“实时资源”小节）。

- Data Determinism: Given the same input and internal state, the calculation always produces the same output. The rest of this section will describe how to achieve Data Determinism.

> 数据决定性：给定相同的输入和内部状态，计算总是产生相同的输出。本节的其余部分将描述如何实现数据决定性。


Execution Management provides DeterministicClient library functions to support deterministic execution:

> 执行管理提供DeterministicClient库函数来支持确定性执行。


- Control of a process-internal cycle by wait point API WaitForNextActivation() (\[SWS_EM_01301\]). The Process shall execute one cycle when the API returns and then call the API again to wait for the next activation. A return value of the API controls the internal lifecycle (e.g. init, run, terminate) of the Process, which must be prepared accordingly (\[SWS_EM_01302\], \[SWS_EM_01303\] and \[SWS_EM_01304\]).

> 控制进程内部周期通过等待点API WaitForNextActivation()（[SWS_EM_01301]）。当API返回时，进程将执行一个周期，然后再调用API等待下一次激活。API的返回值控制进程的内部生命周期（例如初始化、运行和终止），必须相应地准备（[SWS_EM_01302]，[SWS_EM_01303]和[SWS_EM_01304]）。

- A blocking deterministic worker pool API RunWorkerPool() (\[SWS_EM_01305\]) for the execution of a set of container elements (\[SWS_EM_01306\]) which are processed in parallel or sequentially by the same worker runnable object (i.e. application function).

> 一个阻塞的确定性工作池API RunWorkerPool（[SWS_EM_01305]），用于执行一组容器元素（[SWS_EM_01306]），这些元素由相同的工作可运行对象（即应用程序函数）以并行或顺序方式处理。

- APIs GetActivationTime() (\[SWS_EM_01310\]) and GetNextActivationTime() (\[SWS_EM_01311\]) to provide activation time stamps which don\'t change until the Process reaches its next wait point.

> 提供激活时间戳的API GetActivationTime（\[SWS_EM_01310\]）和GetNextActivationTime（\[SWS_EM_01311\]），直到进程到达下一个等待点，这些时间戳不会改变。

- API GetRandom() to provide random numbers (\[SWS_EM_01308\]). If used from within the worker pool, the random numbers are assigned to specific

> API GetRandom() 提供随机数（\[SWS_EM_01308\]）。如果从工作池内使用，则随机数将分配给特定的


To ensure deterministic behavior, only a "deterministic subset" of all available APIs may be used by the deterministic user Process, including the worker runnable objects:

> 为了确保确定性行为，只有“确定性子集”可以被确定性用户进程使用，包括工作可运行对象：


- The Process is not allowed to create threads on its own by using normal POSIX mechanisms or access any other POSIX APIs directly, to avoid the risk of inducing indeterministic behavior.

> 进程不允许使用普通的POSIX机制或直接访问其他POSIX API来自行创建线程，以避免引起不确定行为的风险。

- Only a "deterministic subset" of all available ara::com mechanisms are allowed to be used by the Process. A detailed list of such APIs and mechanisms will be provided at a later point in time.

> 只允许使用ara::com机制的“确定性子集”。稍后将提供这些API和机制的详细列表。
- Only the following ara::exec interfaces may be used:

  - DeterministicClient
  - ExecutionClient
- No other ARA interfaces are allowed to be accessed by the user Process.


If the worker pool API RunWorkerPool() is used, the worker runnable object which processes the container elements, i.e. the jobs to be computed, needs to satisfy certain implementation rules to ensure Data Determinism:

> 如果使用工作池API RunWorkerPool()，处理容器元素（即要计算的作业）的工作可运行对象需要满足某些实现规则，以确保数据确定性。


- The runnable object is not allowed to exchange any information while it is running, i.e. it doesn\'t access data which can be altered by other instances of the runnable object to avoid race conditions.

> 可运行对象在运行时不允许进行任何信息交换，即它不能访问可以被其他可运行对象更改的数据，以避免竞争条件。


Rationale: The runnable object instances can physically run in parallel or sequentially in any order. The timing between individual workers is not guaranteed. The Operating System is scheduling threads individually.

> 理由：可运行的对象实例可以并行或顺序地以任何顺序运行。个体工作者之间的时间不能保证。操作系统单独调度线程。


Concurrent influencing of the same data will result in indeterminate results.

> 同时影响同一数据将导致不确定的结果。


- No locks and synchronization points except common joins for all workers by returning from RunWorkerPool() (e.g. no Semaphores/Mutexes, no locking/blocking).

> 没有锁和同步点，除了从RunWorkerPool（）返回时为所有工作者共同加入（例如没有信号量/互斥量，没有锁定/阻塞）。


Rationale: locking/blocking makes Process runtime in-deterministic. Workers are provided to increase the utilization of runtime. If synchronization is needed, a return from RunWorkerPool() is necessary.

> 理由：锁定/阻止使得进程运行时不可预测。提供工人以增加运行时的利用率。如果需要同步，则必须从RunWorkerPool()返回。


The worker pool cannot be used to process multiple different tasks in parallel. The use of multiple potentially different explicit functions (worker runnable objects) could add unnecessary complexity and can lead to extremely heterogeneous runtime utilization, as each worker may have different computing time. This would complicate the planning of resource deployment, which is necessary for black-box integration.

> 工人池不能用于并行处理多个不同的任务。使用多个可能不同的显式函数（工人可运行对象）可能会增加不必要的复杂性，并可能导致极端不均匀的运行时利用率，因为每个工人可能具有不同的计算时间。这将使资源部署的规划变得复杂，这对黑盒集成是必要的。


Example of the implementation of Worker Pool Users, i.e. of a worker runnable object:

> 例如，工作池用户的实现示例，即可运行对象：

class MyWorker1


: public DeterministicClient::WorkerrunnableBase\<myContainer:: value_type, MyWorker1\>

> 公共DeterministicClient::WorkerrunnableBase<myContainer::value_type，MyWorker1>

{

public:


void worker_runnable(myContainer::value_type& container_element, DeterministicClient::WorkerThread& t)

> void worker_runnable(我的容器::值类型& 容器元素, DeterministicClient::WorkerThread& t)

{


// Get a unique and deterministic pseudo-random number} uint64_t random_number = t.GetRandom();

> uint64_t随机数 = t.GetRandom(); // 获取唯一且可预测的伪随机数

}

};

Worker-thread object:


class DeterministicClient::WorkerThread

> 确定性客户端::工作线程

{


// returns a deterministic pseudo-random number}

> // 返回一个确定性伪随机数


// which is unique for each container element} uint64_t GetRandom();

> uint64_t GetRandom（）; 这个函数为每个容器元素生成唯一的随机值。

\...

};

5. # State Management


   1. ## Interaction with AUTOSAR Adaptive (Platform) Applications

> ## 与AUTOSAR Adaptive（Platform）应用的交互

      1. ### Basic State Management functionality


State Management provides a set of 'Trigger' and 'Notifier' fields via ara::com. The SM essentially listens to the 'Triggers', and perform implementation‐specific state machine processing internally, and provides the effect to the 'Notifier' fields if there is any. The State Management also interacts with other FCs through the standard interface provided by them.

> 状态管理通过ara::com提供一组“触发器”和“通知者”字段。SM基本上是监听“触发器”，在内部执行特定于实现的状态机处理，如果有任何效果，就将效果提供给“通知者”字段。状态管理还通过其他FC提供的标准接口与其他FC进行交互。


The following effects can be achieved by using this mechanism:

> 以下效果可以通过使用这种机制来实现：

- FunctionGroups can be requested to be set to a dedicated state
- (Partial) Networks can be requested to be de- / activated
- The machine can be requested to be shutdown or restarted
- Other Adaptive (Platform) Applications can be influenced in their behavior
- Project specific actions could be performed.


Some of these functions are critical. Therefor the access to the Trigger fields has to be secured properly by Integrator via Identity and Access Management not to change the internal state of State Management (and therefor the depending effects) accidently.

> 有些功能非常重要，因此必须通过身份和访问管理来正确地保护Trigger字段的访问，以防止意外改变状态管理的内部状态（以及由此产生的影响）。


The internal states of State Management are propagated to the system through its provided 'Notifier' fields. The read access to these fields is less critical and so each Adaptive (Platform) Application can register to their events to be informed whenever State Managements internal states change. So each Adaptive (Platform) Application can carry out an operation(s) (when needed) when the state of State Management changes.

> 状态管理的内部状态通过其提供的“Notifier”字段传播到系统中。对这些字段的读取访问不太重要，因此每个自适应（平台）应用程序都可以注册其事件，以便在状态管理的内部状态发生变化时得到通知。因此，每个自适应（平台）应用程序可以在状态管理更改时执行操作（如果需要）。

![](./media/image2.png){width="6.859725503062117in" height="3.9004166666666666in"}

**Figure 5-1 A basic application State transition example**

### Advanced State Management functionality


Some use cases within AUTOSAR Adaptive require to support a synchronized behavior in the states managed by State Management. One example might be a low- power mode: State Management can only switch finally to a low-power state when all Adaptive (Platform) Applications which are involved in this low-power mode scenario are finally prepared for low-power (e.g. have persisted its information).

> 一些AUTOSAR Adaptive的使用案例需要支持由状态管理所管理的状态之间的同步行为。一个例子可能是低功耗模式：当所有涉及到低功耗模式场景的Adaptive（平台）应用程序最终准备好进入低功耗（例如已持久化其信息）时，状态管理才能最终切换到低功耗状态。


To achieve such kind of synchronized communication AUTOSAR adaptive provides a mechanism called CommunicationGroup. This mechanism provides a template for the messages and reply messages, from which the corresponding ara::com methods and events are generated by the tooling. For Details see TPS_ManifestSpecification and SWS_CommunicationManagement.

> 要实现这种同步通信，AUTOSAR自适应提供了一种称为CommunicationGroup的机制。该机制提供了消息和回复消息的模板，工具根据此模板生成相应的ara :: com方法和事件。有关详细信息，请参阅TPS_ManifestSpecification和SWS_CommunicationManagement。

![](./media/image3.jpeg){width="6.004486001749782in" height="2.6902077865266842in"}

**Figure 5-2 CoomunicationGroup ServiceInterface**


Therefore each Adaptive (Platform) Application which is required to support such a synchronized working mode has to offer the method and the event generated in the context of CommunicationGroupClient.

> 因此，每个需要支持这种同步工作模式的自适应（平台）应用程序都必须提供CommunicationGroupClient上下文中生成的方法和事件。


StateMangement provides two predefined sets of messages and reply messages:

> 状态管理提供两套预定义的消息和回复消息：

- PowerMode
- DiagnosticReset


For details see SWS_StateManagement.

> 详细信息请参阅SWS_StateManagement。

![](./media/image4.png){width="6.09417760279965in" height="4.590937226596675in"}

**Figure 5-3 Distributing PowerMode example**


StateManagement offers methods and events in the context of CommunicationGroupServer. So it can broadcast the PowerMode to all Processes, which are part of the CommunicationGroup (means offering the methods and events of the CommunicationGroupClient). Each Process has to give its answer to the request by writing to the response field, thus StateManagement can collect all answers.

> 状态管理提供了通信组服务器的方法和事件。因此它可以将PowerMode广播到所有属于通信组（即提供通信组客户端的方法和事件）的进程。每个进程都必须通过写入响应字段来回答请求，从而状态管理可以收集所有答案。


StateManagement can retrieve a list of all clients in the CommunicationGroup, thus it can check if all clients did answer (in time). Depending on the result (all clients answered, not all clients answered (in time), the answer was different from \"success\",

> 状态管理可以检索通信组中所有客户端的列表，因此可以检查所有客户端是否均已回复（及时）。根据结果（所有客户端都回复了，未能及时回复所有客户端），答案不同于“成功”。

\...)


StateManagement has to do a project-specific reaction.

> 状态管理必须对项目做出特定的反应。


The messages and reply messages for the DiagnosticReset are meant as a tool for Diagnostic reset requests, where it should be possible to communicate to running Processes (without the need to terminate and restart them). If and how this tool is used is project-specific.

> 这些用于诊断重置请求的消息和回复消息是一种工具，可以在不需要终止和重新启动它们的情况下与正在运行的进程进行通信。如何使用这个工具是特定项目的。


6. # Persistency cluster

> 6. # 持久性集群

   1. ## Overview


Persistency is one of the foundation clusters of the adaptive AUTOSAR platform which provides static APIs to the application to store and retrieve the user data. It supports two different storage mechanisms: Key-Value Storage and File Storage.

> 持久性是Adaptive AUTOSAR平台的基础集群之一，它为应用程序提供静态API来存储和检索用户数据。它支持两种不同的存储机制：键值存储和文件存储。


Both storage mechanisms might use a file system of the operating system, and in this case rely on this file system to be able to synchronize changes immediately. This has to be ensured by a proper integration of the file system, e.g. by using appropriate mount options. See also Appendix C of the SWS Persistency.

> 两种存储机制可能使用操作系统的文件系统，并且在这种情况下依赖于此文件系统以立即同步更改。必须通过适当的文件系统集成来确保这一点，例如通过使用适当的挂载选项。另请参见SWS持久性的附录C。

![](./media/image5.png){width="6.286327646544182in" height="4.174061679790026in"}

**Figure 6-1 Persistency functionality overview**

### Key Value Storage


It is a simple key based data base that helps the user to store their smaller data in the data base.

> 这是一个基于键的简单数据库，可以帮助用户将其较小的数据存储在数据库中。

### File Storage


It is a file based storage and the data is stored in the files under a folder and it supports storing huge data into files.

> 这是一种基于文件的存储，数据存储在文件夹下的文件中，它支持将大量数据存储到文件中。


An application needs to design Key Value Storage and File Storage as a port interface in order to access the Key Value Storage and File Storage features. After designing the persistency port interfaces, further configuration information will be

> 需要设计键值存储和文件存储作为端口接口以访问键值存储和文件存储功能的应用程序。在设计持久性端口接口之后，将进一步配置信息。


provided during the deployment stage (e.g. storage location, redundancy CRC, redundancy M out of N configurations, etc.)

> 在部署阶段提供（例如存储位置，冗余CRC，冗余M out of N配置等）。


Based on the logging implementation inside persistency, the cluster can log the run time-related warnings errors and fatal problems can be reported to PHM.

> 根据持久性内部的日志实现，集群可以记录与运行时相关的警告错误和致命问题，可以报告给PHM。

Note: AUTOSAR_SWS_Persistency does not specify the above details as that is implementation specific.

## Example usage of Key-Value Storage API


Deploy the Key-Value Storage in a specific location and map the short name of the Key-Value Storage with location during deployment of the Key-Value Storage.

> 部署键值存储在特定的位置，并在部署键值存储时将其简称与位置映射起来。


**Write operation sequence**

> 写操作序列


1. Open the Key-Value Storage with the instance specifier

> 1. 使用实例指定符打开键值存储


ara::core::Result\<SharedHandle\<KeyValueStorage\>\> kvsRes = ara::per::OpenKeyValueStorage(kDatabaseNameIS);

> ara::core::Result<共享句柄<键值存储>> kvsRes = ara::per::OpenKeyValueStorage(kDatabaseNameIS);


Parse the ara::core::Result to check success or error in case of failure of open Key-Value Storage operation

> 解析ara::core::Result以检查开放键值存储操作失败时的成功或错误。


2. Parse the KeyValueStorage object (kvs) from ara::core::Result SharedHandle\<KeyValueStorage\> db = std::move(kvsRes).Value();

> 解析ara::core::Result SharedHandle<KeyValueStorage> db = std::move(kvsRes).Value();中的KeyValueStorage对象(kvs)。

3. Invoke the SetValue with key and value that needs to be persisted in the Key-

> 调用SetValue，传入需要在键中持久化的键和值。

Value Storage


ara::core::Result\<void\> result = db-\>SetValue(kDoubleKeyName, DoubleValue);

> result = db->SetValue(kDoubleKeyName, DoubleValue); 的结果是ara::core::Result<void>。


Parse the result to check the status of the write operation

> 解析结果以检查写操作的状态


Hint: In order to effectively use the underlying storage device it is designed that all the user requests are stored intermediately in the RAM and the data will be persisted to file system only after invoking the below sync call. Hence it is suggested that after opening the Key-Value Storage, perform multiple SetValue() operations then persist the data finally via sync call.

> 为了有效地使用基础存储设备，设计将所有用户请求都存储在RAM中，并且只有在调用下面的同步调用后，数据才会持久化到文件系统中。因此，建议在打开键值存储后，执行多个SetValue()操作，然后通过同步调用最终持久化数据。


4. Invoke the below API to persist data to the nonvolatile storage (Flash/Hard disk)

> 调用以下API将数据持久化到非易失性存储（闪存/硬盘）


ara::core::Result\<void\> result = db-\>SyncToStorage();

> ara::core::结果<void>结果 = db->SyncToStorage();


Parse the result to check the status of the sync operation

> 解析结果以检查同步操作的状态


5. There is a possibility that a user can go to last sync state by calling the API DiscardPendingChanges() which will discard the transaction of syncing the locally stored key value pairs with the underlying data base.

> 有可能通过调用API DiscardPendingChanges()，使用户可以回到上次同步状态，这将放弃将本地存储的键值对与底层数据库同步的事务。


ara::core::Result\<void\> result = db-\>DiscardPendingChanges();

> ara::core::结果<void>结果 = db->放弃待处理的更改（）；


**Read operation sequence:**

> **读取操作序列：**


1. Open the Key-Value Storage with the instance specifier

> 1. 使用实例指定符打开键值存储


ara::core::Result\<SharedHandle\<KeyValueStorage\>\> kvsRes = ara::per::OpenKeyValueStorage(kDatabaseNameIS);

> ara::core::结果<共享句柄<键值存储>> kvsRes = ara::per::打开键值存储(kDatabaseNameIS);


This returns ara::core::Result which contains kvsobject or error in case of failure

> 这会返回一个ara::core::Result，如果失败，其中包含kvsobject或错误。


2. Parse the Kvs object from ara::core::Result SharedHandle\<KeyValueStorage\> db = std::move(kvsRes).Value();

> 从ara::core::Result SharedHandle<KeyValueStorage> db = std::move(kvsRes).Value();解析Kvs对象

3. Invoke the GetValue with key and value that needs to be retrieved from the

> 调用GetValue方法，使用需要从中检索的键和值。

Key-Value Storage


ara::core::Result\<ara::core::String\> first_value = db-\> GetValue\<String\>(kStringKeyName);

> ara::core::Result<ara::core::String> first_value = db->GetValue<String>(kStringKeyName); 
结果ara::core::String first_value = db->GetValue<String>(kStringKeyName);


Parse the result to check the status of the read operation and get the value assigned to a key

> 解析结果以检查读取操作的状态，并获取分配给键的值。

## Example usage of File Storage API

**Write operation**


1. Open File storage with the short name of the portprototype

> 打开名为portprototype的文件存储


ara::core::Result\<SharedHandle\<FileStorage\>\> fsRes = OpenFileStorage(kFolderNameIS);

> ara::core::结果<共享句柄<文件存储> > fsRes = OpenFileStorage（kFolderNameIS）;


Parse the ara::core::Result to check success or error in case of failure

> 解析ara::core::Result以检查失败时的成功或错误


2. Parse the File Storage object from ara::core::Result SharedHandle\<FileStorage\> fs = std::move(fsRes).Value();

> 从ara::core::Result SharedHandle<FileStorage> fs中解析文件存储对象：std::move(fsRes).Value();

3. Invoke the OpenFileWriteOnly with the file name which is short name of the

> 调用OpenFileWriteOnly函数，并使用文件的短名称作为参数。


portprototype to get the writeaccessor object

> 获取写访问器对象的Portprototype


ara::core::Result\<UniqueHandle\<ReadWriteAccessor\>\> fileRes = fs-\> OpenFileWriteOnly(kFileName);

> ara::core::结果<唯一句柄<读写访问器>>文件Res = fs->打开文件仅供写入(kFileName);


4. Perform the formatted writing via overloading operator

> 通过重载操作符执行格式化写入


(\*(std::move(fileRes).Value())) \<\< \"Overwriting!\";

> (std::move(fileRes).Value()) << "覆盖！";

**Read operation**


1. Open File storage with the short name of the portprototype

> 打开短名称为portprototype的文件存储


ara::core::Result\<SharedHandle\<FileStorage\>\> fsRes =

> ara::core::Result<共享句柄<文件存储>> fsRes =


Parse the ara::core::Result to check success or error in case of failure

> 解析ara::core::Result以检查失败时的成功或错误。


2. Parse the FileStorage object from ara::core::Result SharedHandle\<FileStorage\> fs = std::move(fsRes).Value();

> 从ara::core::Result SharedHandle\<FileStorage\> fs中解析FileStorage对象：std::move(fsRes).Value();

3. Invoke the OpenFileReadWrite() with the file name to get the

> 使用文件名调用OpenFileReadWrite()


readwriteaccessor object

> 读写访问器对象


ara::core::Result\<UniqueHandle\<ReadWriteAccessor\>\> fileRes = fs-\> OpenFileReadWrite(kFileName);

> ara::core::结果<唯一句柄<读写访问器>>文件Res = fs->OpenFileReadWrite（kFileName）;


4. Perform the read operation

> 执行读操作


UniqueHandle\<ReadWriteAccessor\> rwa = std::move(fileRes).Value(); ara::core::Result\<ara::core::String\> = rwa-\>ReadLine();

> UniqueHandle<ReadWriteAccessor> rwa = std::move(fileRes).Value(); ara::core::Result<ara::core::String> = rwa->ReadLine();

UniqueHandle<ReadWriteAccessor> rwa = std::move(fileRes).Value(); ara::core::Result<ara::core::String> = rwa->读取一行();


Read the value in the buffer until default delimiter.

> 读取缓冲区中的值直到默认分隔符。

## Redundancy feature


This feature ensures persistent data safety for both Key-Value Storage and File Storage. There are three possible ways to ensure data safety (integrity).

> 这个功能确保键值存储和文件存储的持久数据安全。有三种可能的方法来确保数据安全（完整性）。

1. CRC
2. Hashes
3. M out of N approach


It is a configurable parameter. Based on the project need, either one or a combination of them can be configured. With respect to CRC, all the AUTOSAR CRCs are supported to configure. In addition to the detection of integrity M out of N approach helps to recover the data if there are sufficient redundant copies available.

> 这是一个可配置参数。根据项目需要，可以配置一个或多个参数。关于CRC，支持配置所有AUTOSAR CRCs。此外，如果有足够的冗余副本可用，M out of N方法可以帮助恢复数据。


Persistency also allows the application to install a callback that will report any problems detected in any of the storages, even if the problem could be corrected because the redundancy was sufficient. This callback can be used in safety critical application, or when the application wants to monitor the health of the hardware.

> 持久性还允许应用程序安装一个回调，以报告任何在任何存储中检测到的问题，即使问题可以因为冗余足够而得到纠正。这个回调可以用于安全关键应用程序，或者当应用程序想要监视硬件健康时。


**Recover Storage:** It is part of Redundancy Feature if integrity checks fail for Key- Value Storage or File Storage or file or key-value pair, user can use RecoverKeyValueStorage/RecoverFileStorage/RecoverFile/RecoverKey APIs to recover the data based on best effort recovery mechanism. Upon invocation of Recover APIs, a valid Key-Value Storage/File Storage/file/key-value pair could be retrieved which might have lost some key-value pairs/files as it is a best effort recovery mechanism.

> **恢复存储：**如果对键值存储或文件存储或文件或键值对的完整性检查失败，用户可以使用RecoverKeyValueStorage / RecoverFileStorage / RecoverFile / RecoverKey APIs来恢复数据，根据最佳恢复机制。调用恢复API后，可以检索到一个有效的键值存储/文件存储/文件/键值对，因为这是最佳恢复机制，可能会丢失一些键值对/文件。

## Reset Storage


This feature resets a Key-Value Storage/File Storage/file/key-value pair to the initial state, containing only Keys/Files which were deployed from the manifest, with their initial values and it will fail with a kResourceBusyError when the Key-Value Storage/FileStorage/File/Key-Value Pair is currently open/accessed and with a kInitValueNotAvailableError when deployment

> 这个功能可以将键值存储/文件存储/文件/键值对重置为初始状态，只包含从清单部署的键/文件，并带有其初始值。当键值存储/文件存储/文件/键值对当前正在打开/访问时，它将失败，并显示kResourceBusyError，当部署时，初始值不可用时，将显示kInitValueNotAvailableError。


does not define an initial content for the Key-Value Pair/File.

> 不为键值对/文件定义初始内容

Reset APIs:


-ResetPersistency(): Reset all Key-Value Storages and File Storages to the initial state with key-value pairs deployed from manifest

> -重置持久性（）：将所有键值存储和文件存储重置为从清单部署的初始键值对状态。


-ResetKeyValueStorage(): Reset Key-Value Storage to the initial state with key-value pairs deployed from manifest

> -重置键值存储（）：从清单中部署的键值对将键值存储重置为初始状态。


-ResetAllFiles(): Reset the whole File Storage, including all files from the deployed content from manifest

> -重置所有文件（）：重置整个文件存储，包括所有从清单部署的内容的文件。

-ResetFile(): Reset a single file to its initial content which was deployed from the manifest


-ResetKey(): Reset a single key-value pair to its initial content which was deployed from the manifest

> -重置键（）：将单个键值对重置为从清单中部署的初始内容

## Update and Removal of Persistent Data


There are APIs which will perform the specific action (update/rollback/remove) on the persistent data of the application based on the invocation of API UpdatePersistency(Update all persistency file and key-value storages after a new manifest was installed). An application may also register a callback function (RegisterApplicationDataUpdateCallback) that is called after the update of any Key- Value Storage and File Storage. This callback function will be called from the context of UpdatePersistency(), OpenKeyValueStorage(), or OpenFileStorage().

> 有一些API可以根据调用API UpdatePersistency（在安装新的清单后更新所有持久文件和键值存储）来对应用程序的持久数据执行特定操作（更新/回滚/删除）。应用程序还可以注册一个回调函数（RegisterApplicationDataUpdateCallback），在更新任何键值存储和文件存储后调用。此回调函数将从UpdatePersistency（）、OpenKeyValueStorage（）或OpenFileStorage（）的上下文中调用。


7. # Platform Health Management

> 7. # 平台健康管理


   1. ## Shutdown functionality

> ## 关机功能


In the sense of a safe system, the integrator shall ensure that the applications are configured to be supervised by Platform Health Management are terminated before triggering shut down of the Platform Health Management. Please refer to \[3\]

> 在安全系统的意义上，集成商应确保应用程序被配置为由Platform Health Management监督，并在触发Platform Health Management关闭之前终止。请参考[3]。


8. # Update and Configuration Management

> 8. # 更新和配置管理


   1. ## Port configuration

> ## 端口配置


UCM can be configured to share a network port with other applications and does not necessarily need a dedicated port.

> UCM可以配置与其他应用程序共享网络端口，而不一定需要专用端口。

## Method deployments


Most UCM methods have no or small parameters or return values that fit into an unsegmented SOMEIP message (\~1300 byte payload) and can therefore be deployed via UDP. Some have however potentially large parameters or return values and therefore need to be deployed via TCP or SOMEIP/TP. The following table shows the recommended deployments.

> 大多数UCM方法没有或参数很小，返回值可以放入未分段的SOMEIP消息（\~1300字节有效载荷）中，因此可以通过UDP部署。但有些参数或返回值可能很大，因此需要通过TCP或SOMEIP/TP部署。下表显示了推荐的部署方式。


A similar consideration can be done for the UCM master interface methods.

> 可以对UCM主接口方法进行类似的考虑。

## Data transfer, message loss and block sizes


UCM needs to transfer potentially large amounts of data over the ara::com service interface. The configuration of the TransferData method is crucial for the performance of the data transmission.

> UCM需要通过ara::com服务接口传输大量数据。 TransferData方法的配置对数据传输的性能至关重要。


Non-trivial software packages exceed the segmantation size of a single SOMEIP message transmitted over UDP. UCM can set the maximum BlockSize that may be used by the client so that the message will not be segemented (\~1440 byte).

> 软件包的大小超过了单个SOMEIP消息通过UDP传输时的分段大小。UCM可以设置客户端可以使用的最大BlockSize，以便消息不被分段（\~1440字节）。


However, this will lead to poor transfer performance because each block has to be acknowledged in the application context before sending the next block.

> 然而，这会导致转移性能不佳，因为在发送下一个块之前，必须在应用程序上下文中确认每个块。


If the platform supports method calls via TCP or SOMEIP/TP segmentation the BlockSize setting can be increased to reduce protocol header overhead and move the segmentation effort into lower layers.

> 如果平台支持通过TCP或SOMEIP/TP分段来调用方法，可以增加BlockSize设置，以减少协议头开销，并将分段工作移至较低层。


In case of SOMEIP/TP the integrator has to consider that a message loss will lead to the loss of the complete SOMEIP message. The following formula shows how to calculate the total probability of losing the segmented message 𝑝~SOMEIP/TP~ from the probability of a single UDP message loss 𝑝~UDP~, the maximum transmission unit MTU~Eth~, the individual layers header sizes Header~𝑖~ and the BlockSize. The individual loss probability is multiplicated by the number of messages sent to get the total loss probability. Note: For IPv6 the header size is 40 byte, so the denominator would be 1440 instead of 1460.

> 在SOMEIP/TP的情况下，集成器必须考虑消息丢失会导致整个SOMEIP消息的丢失。下面的公式显示如何计算分段消息𝑝~SOMEIP/TP~的总丢失概率，从单个UDP消息丢失的概率𝑝~UDP~，最大传输单元MTU~Eth~，各个层次的头部大小Header~𝑖~和BlockSize开始。将单个丢失概率乘以发送的消息数量以获得总丢失概率。注：对于IPv6，头部大小为40字节，因此分母为1440而不是1460。


In case of TCP, message loss is handled by its retransmission features, so loss of an individual TCP message does not break the SOMEIP message. The block size is virtually unlimited, so you could transfer the complete software package in a single TransferData call. In addition to this, the segmantation is handled in kernel space with highly optimized implementations. However, establishing the connection in a three-way handshake and keeping the connection context on both sides consumes more resources compared to SOMEIP/TP.

> 在TCP的情况下，消息丢失由其重传功能处理，因此单个TCP消息的丢失不会破坏SOMEIP消息。块大小几乎是无限的，因此您可以在单个TransferData调用中传输完整的软件包。除此之外，分段在内核空间中进行高度优化的实现。但是，与SOMEIP/TP相比，建立三方握手连接并在两端保持连接上下文消耗更多的资源。


The following table shows a summary of pros and cons of the options.

> 以下表格总结了各选项的利弊。

# References

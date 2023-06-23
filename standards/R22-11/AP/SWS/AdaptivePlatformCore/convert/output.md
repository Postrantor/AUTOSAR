---
tip: translate by openai@2023-06-23 18:24:07
...
# Contents

```
1. Introduction 8
2. Acronyms and Abbreviations 9
3. Related documentation 10

   1. Input documents & related standards and norms 10
4. Constraints and assumptions 11

   1. Limitations 11
   2. Applicability to car domains 11
5. Dependencies to other modules 12
6. Requirements Tracing 13
7. [Requirements Specification](#requirements-specification) 25

   1. [General requirements for all Functional Clusters](#general-requirements-for-all-functional-clusters) 25

      1. [Initialize/Deinitialize](#initializedeinitialize) 27
   2. [Functional Specification](#functional-specification) 28

      1. [Error handling](#error-handling) 28

         1. [Types of unsuccessful operations](#types-of-unsuccessful-operations) 28
         2. [Traditional error handling in C and C++](#traditional-error-handling-in-c-and-c) 28
         3. [Handling of unsuccessful operations in the Adaptive](#handling-of-unsuccessful-operations-in-the-adaptive-platform) [Platform](#handling-of-unsuccessful-operations-in-the-adaptive-platform) 29
         4. [Facilities for Error Handling](#facilities-for-error-handling) 30

            1. [ErrorCode](#errorcode) 30
            2. [ErrorDomain](#errordomain) 32
            3. [Result](#result) 33
            4. [Future and Promise](#future-and-promise) 33
         5. [Duality of ErrorCode and exceptions](#duality-of-errorcode-and-exceptions) 34
         6. [Exception hierarchy](#exception-hierarchy) 34
         7. [Creating new error domains](#creating-new-error-domains) 35

            1. [Error condition enumeration](#error-condition-enumeration) 35
            2. [Exception base class](#exception-base-class) 36
            3. [ErrorDomain subclass](#errordomain-subclass) 36
            4. [Non-member ErrorDomain subclass accessor](#non-member-errordomain-subclass-accessor-function) [function](#non-member-errordomain-subclass-accessor-function) 38
            5. [Non-member MakeErrorCode overload](#non-member-makeerrorcode-overload) 38
            6. [C++ pseudo code example](#c-pseudo-code-example) 39
         8. [AUTOSAR error domains](#autosar-error-domains) 39
      2. [Async signal safety](#async-signal-safety) 40
      3. [Explicit Operation Abortion](#explicit-operation-abortion) 40

         1. [AbortHandler](#aborthandler) 41
         2. [SIGABRT handler](#sigabrt-handler) 42
      4. [Advanced data types](#advanced-data-types) 43

         1. [AUTOSAR types](#_bookmark38) 43

            1. [InstanceSpecifier](#_bookmark39) 43
            2. [ScaleLinearAndTexttable](#scalelinearandtexttable) 44
         2. [Types derived from the base C++ standard](#types-derived-from-the-base-c-standard) 44

            1. [Array](#array) 44
            2. [Vector](#vector) 45
            3. [Map](#map) 45
            4. [String and BasicString](#string-and-basicstring) 45
            5. [SteadyClock](#steadyclock-7.2.4.2.5.1-definitions-of-terms) 45

               1. [Definitions of terms](#steadyclock-7.2.4.2.5.1-definitions-of-terms) 45
               2. [Clocks in the Adaptive Platform](#clocks-in-the-adaptive-platform) 46
         3. [Types derived from newer C++ standards](#types-derived-from-newer-c-standards) 47

            1. [Optional](#optional) 47
            2. [Variant](#variant) 48
            3. [StringView](#stringview) 48
            4. [Span](#span) 48
            5. [ara::core::Byte](#aracorebyte) 48
      5. [Initialization and Shutdown](#initialization-and-shutdown) 50
8. API specification 52

   1. C++ language binding 52

      1. ErrorDomain data type 52
      2. ErrorCode data type 56

         1. ErrorCode non-member operators 59
      3. Exception data type 60
      4. Result data type 62

         1. Result\<void, E\> template specialization 75
         2. Non-member function overloads 85
      5. Core Error Domain 89

         1. CORE error codes 89
         2. CoreException type 89
         3. CoreErrorDomain type 90
         4. GetCoreErrorDomain accessor function 92
         5. MakeErrorCode overload for CoreErrorDomain . 92
      6. Future and Promise data types 93

         1. future_errc enumeration 93
         2. FutureException type 94
         3. FutureErrorDomain type 94
         4. FutureErrorDomain accessor function 96
         5. MakeErrorCode overload for FutureErrorDomain 97
         6. future_status enumeration 97
         7. Future data type 98

            1. Future\<void, E\> template specialization . 103
         8. Promise data type 108

            1. Promise\<void, E\> template specialization . 112
      7. Array data type 116

         1. Class Array 116
         2. Non-member functions 126
         3. Tuple interface 129
      8. Vector data type 131
      9. Map data type 134
      10. Optional data type 135
      11. Variant data type 136
      12. StringView data type 137
      13. String data types 137
      14. Span data type 146
      15. SteadyClock data type 165
      16. InstanceSpecifier data type 167
      17. ScaleLinearAndTexttable data type 172
      18. Generic helpers 183

          1. ara::core::Byte 183
          2. In-place disambiguation tags 184

             1. in_place_t tag 184
             2. in_place_type_t tag 185
             3. in_place_index_t tag 186
          3. Non-member container access 186
      19. Initialization and Shutdown 190
      20. Abnormal process termination 190

```


7. # Requirements Specification

> 7. # 要求规格


   1. ## General requirements for all Functional Clusters

> ## 所有功能簇的一般要求


The goal of this section is to define a common set of basic requirements that apply to all Functional Clusters of the Adaptive Platform. It adds a common part to the specifications and it needs to be respected by platform vendors.

> 这一部分的目标是为自适应平台的所有功能群定义一套基本要求。它为规范增加了一个共同的部分，平台供应商需要遵守。


**[SWS_CORE_90001] Include folder structure** *[*All #include directives in header files that refer to ARA libraries shall be written in the form

> **[SWS_CORE_90001] 包括文件夹结构** *[*所有指向ARA库的头文件中的#include指令都应以以下形式书写

```
#include \"ara/fc/header.h\"
```


with "ara" as the first path element, "fc" being the remaining directory path of the implementation's *installed* header file, starting with the Functional Cluster short name, and "header.h" being the filename of the header file.*♩(RS_AP_00116, RS_AP_00111)*

> 以"ara"为第一个路径元素，以"fc"为实施的*已安装*头文件的其余目录路径，以功能簇短名称开头，以"header.h"为头文件的文件名。♩（RS_AP_00116，RS_AP_00111）


The Functional Cluster short names are defined in [3].

> 功能簇简称定义在[3]中。


Example: Execution Management (short name "exec") provides class ExecutionClient, which can be accessed with:

> 例如，执行管理（简称“exec”）提供ExecutionClient类，可以通过以下方式访问：

#include \"ara/exec/execution_client.h\"


The \"\...\" form of #include statements shall be used, due to the recommendation given in [4, the C++14 standard] section 16.2.7.

> "应该使用“\...”形式的#include语句，这是根据[4，C++14标准]第16.2.7节中的建议而定的。"


**[SWS_CORE_90002] Prevent multiple inclusion of header file** *[*All public header files shall prevent multiple inclusion by using #include guards that are likely to be system-wide unique.*♩(RS_AP_00111)*

> **[SWS_CORE_90002] 防止头文件的多次包含** *[*所有公共头文件都应该使用可能系统范围内唯一的#include保护来防止多次包含。*♩(RS_AP_00111)*


While uniqueness can generally not be guaranteed, the likelihood of collisions can be decreased with a naming scheme that is regular and results in long symbol names.

> 虽然通常不能保证唯一性，但可以通过规则化的命名方案来减少碰撞的可能性，从而产生长符号名称。


The following #include guard naming scheme should be used by implementations for all header files that cover symbols within the ara namespace or a sub-namespace therein:

> 以下#include守护命名方案应该由实现用于所有覆盖ara命名空间或其子命名空间内符号的头文件：

ARA\_\<PATH\>\_H\_


where \<PATH\> is the relative path name of the header file within the location of the implementation's *installed* header files, starting with the Functional Cluster name (and omitting the file extension), and with all components of \<PATH\> separated by underscore (\"\_\") characters and containing only upper-case characters of the ASCII character set.

> 在实现的*已安装*头文件位置中，\<PATH\>是头文件的相对路径名称，以功能簇名称开头（并省略文件扩展名），\<PATH\>的所有组件用下划线（“\_”）分隔，并且仅包含ASCII字符集的大写字符。


Example: The header file included with #include \"ara/log/logger.h\" should use the #include guard symbol ARA_LOG_LOGGER_H\_.

> 示例：使用#include \"ara/log/logger.h\"包含的头文件应使用#include guard符号ARA_LOG_LOGGER_H\_。


**[SWS_CORE_90003]**{DRAFT} *[*C/C++ preprocessor symbols that start with ARA are reserved for use by AUTOSAR.*♩(RS_AP_00111)*

> **[SWS_CORE_90003]**{草案} *[*以ARA开头的C/C++预处理符号专供AUTOSAR使用。♩(RS_AP_00111)*


The Adaptive Platform generally avoids the use of C/C++ preprocessor macros. However, in case macros are introduced at some later point in time, any such macro will start with the prefix ARA. Platform vendors should thus not define any symbols (both macros and C/C++ ones) with this prefix, lest they conflict with such future additions to the standard.

> 通常情况下，自适应平台避免使用C/C++预处理器宏。但是，如果在以后的某个时间点引入宏，任何此类宏都将以ARA前缀开头。因此，平台供应商不应定义任何具有此前缀的符号（宏和C/C++符号），以免与标准的未来添加物发生冲突。


**[SWS_CORE_90004]**{DRAFT} **Implementation-defined declaration classifiers** *[*All APIs shall be implemented with the exact same declaration classifiers that are specified, except for inline and friend, which may be added as necessary.*♩(RS_AP\_00111)*

> **[SWS_CORE_90004]**{草案} **实现定义声明分类器** *[*所有API都必须按照指定的完全相同的声明分类器来实现，除了可能根据需要添加内联和友好的声明。*♩(RS_AP\_00111)*


*Note: The order of declarations may be freely chosen.*

> 注意：声明的顺序可以自由选择。


[4, The C++14 standard] defines in chapter 7.1 [dcl.spec] the specifiers that can be used in a declaration; these include, for instance, static, virtual, constexpr, inline and friend. An implementation that uses a different set of specifiers in its declaration of a specified API may be incompatible to the standard, or may allow nonstandardized usage of that API, leading to portability concerns.

> 标准C++14在第7.1章[dcl.spec]中定义了可以用于声明的规范符号，其中包括静态、虚拟、constexpr、内联和友元等。如果实现在声明指定API时使用了不同的规范符号，可能会与标准不兼容，或允许非标准化使用该API，从而导致可移植性问题。


**[SWS_CORE_90005]**{DRAFT} **Custom declarations and definitions** *[*Implementation shall not add public declarations or definitions that are not specified in an SWS to the namespace ara or any of its direct sub-namespaces.*♩(RS_AP_00111)*

> **[SWS_CORE_90005]**{草案} **自定义声明和定义** *[*实施不应在ara或其直接子命名空间中添加未在SWS中指定的公共声明或定义。*♩(RS_AP_00111)*


The Adaptive Platform is designed for source code portability. Wherefore any conformant implementation of the Adaptive Platform allows a successful compilation and linking of an Adaptive Application that uses ARA only as specified in the standard. No changes to the source code, and no conditional compilation constructs will be necessary for this if the application only uses constructs from the designated minimum C++ language version. The implementation may provide proprietary, non-ARA interfaces, as long as they are not contradicting the AP standard.

> 适应性平台旨在实现源代码的可移植性。因此，符合适应性平台的任何实现都可以成功编译和链接使用ARA的适应性应用程序，而不需要对源代码进行任何更改，也不需要条件编译构造，只要应用程序仅使用指定的最低C++语言版本中的构造。实现可以提供专有的非ARA接口，只要它们不与AP标准相矛盾即可。


**[SWS_CORE_90006]**{DRAFT} *[*If a constructor in the ara framework is called with wrong or invalid ara::core::InstanceSpecifier, the Functional Cluster implementation shall treat this as a [Violation](#_bookmark7) with a standardized log message \"Invalid InstanceSpecifer \>passed InstanceSpecifier\< in ctor \>ctor.shortname\<\".*♩(RS_AP_00111)*

> **[SWS_CORE_90006]**{草案} *[*如果在ara框架中调用构造函数传入错误或无效的ara::core::InstanceSpecifier，功能集群实现应将其视为[违规](#_bookmark7)，并使用标准日志消息“无效的InstanceSpecifer \>传递的InstanceSpecifier\< 在ctor \>ctor.shortname\<中”。*♩(RS_AP_00111)*

简体中文：**[SWS_CORE_90006]**{草案} *[*如果在ara框架中调用构造函数传入错误或无效的ara::core::InstanceSpecifier，功能集群实现应将其视为[违规](#_bookmark7)，并使用标准日志消息“无效的InstanceSpecifer \>传递的InstanceSpecifier\< 在ctor \>ctor.shortname\<中”。*♩(RS_AP_00111)*


The rationale to treat this as a [Violation](#_bookmark7) is that this is seen as an integration error which anyway cannot be handled by the caller of the API. Aborting execution is in line with the strategy to fail early.

> 理由将此视为[违规](#_bookmark7)是因为此被视为集成错误，无论如何都无法由API的调用者处理。中止执行符合早期失败的策略。


Any other error check within the constructors is defined within the respective SWS.

> 其他错误检查在构造函数中定义在各自的SWS中。

### Initialize/Deinitialize


ara::core::Initialize allows a central initialization of all included shared libraries of the ARA framework. This could include static initializers or the setup of daemon links (details are up to the platform vendor).

> ara::core::Initialize允许对ARA框架中包含的所有共享库进行中央初始化。这可能包括静态初始化器或设置守护进程链接（细节取决于平台供应商）。


The general advice for application developers is to call ara::core::Initialize

> 一般建议应用程序开发人员调用ara::core::Initialize。


right at the entry point of the application.

> 在应用程序的入口处。


**[SWS_CORE_90020]**{DRAFT} *[*If functionality is called that depends on prior initialization via ara::core::Initialize and ara::core::Initialize has not been called, the Functional Cluster implementation shall treat this as a [Violation](#_bookmark7).*♩(RS\_AP_00111)*

> **[SWS_CORE_90020]**{草稿} *[*如果调用的功能依赖于通过ara::core::Initialize进行的先前初始化，而ara::core::Initialize尚未被调用，那么功能集群实现应将此视为[违规](#_bookmark7)。*♩(RS\_AP_00111)*


The rationale to treat this as a [Violation](#_bookmark7) is that it cannot be handled by the caller of the API at the point in time where the error is detected. Aborting execution is the only way to signal this kind of systematic error and prevent later failures.

> 理由将此视为[违规](#_bookmark7)是因为在检测到错误的时候，API调用者无法处理。中止执行是唯一的方式来表示这种系统性错误，以防止后续失败。

## Functional Specification


This section describes the concepts that are introduced with this Functional Cluster. Particular emphasis is put on error handling.

> 这一节描述了引入此功能集群的概念。特别强调了错误处理。

1. ### Error handling


   1. ### Types of unsuccessful operations

> ### 不成功的操作类型


During execution of an implementation of Adaptive Platform APIs, different abnormal conditions might be detected and need to be handled and/or reported. Based on their nature, the following types of unsuccessful operations are distinguished within the Adaptive Platform:

> 在执行Adaptive Platform API的实施过程中，可能会检测到不同的异常情况，需要进行处理和/或报告。根据其性质，Adaptive Platform内部区分了以下类型的不成功操作。


**[SWS_CORE_00020]**{DRAFT} **Semantics of an Error** *[*An Error []{#_bookmark6 .anchor}is the inability of an assumed-bug-free API function to fulfill its specified purpose; it is often a consequence of invalid and/or unexpected (i.e. possibly valid, but received in unexpected circumstances) input data. An [Error](#_bookmark6) is recoverable.*♩(RS_AP_00142)*

> **[SWS_CORE_00020]**{草案} **错误的语义** *[*错误[]{#_bookmark6 .anchor}是一个假定无错误的API函数无法实现其指定目的的情况；它通常是无效和/或意外（即可能有效，但在意外情况下接收）输入数据的结果。[错误](#_bookmark6)是可恢复的。*♩（RS_AP_00142）*


**[SWS_CORE_00021]**{DRAFT} **Semantics of a Violation** *[*A []{#_bookmark7 .anchor}Violation is the consequence of failed preor post-conditions of internal state of the application framework. They are the Adaptive Platform's analog to a failed assertion. A [Violation](#_bookmark7) is nonrecoverable.*♩(RS_AP_00142)*

> **[SWS_CORE_00021]**{草案}**违规的语义** *[*一个[]{#_bookmark7 .anchor}违规是应用框架内部状态前置或后置条件失败的结果。它们是自适应平台的失败断言的类似物。[违规](#_bookmark7)是不可恢复的。*♩(RS_AP_00142)*


**[SWS_CORE_00022]**{DRAFT} **Semantics of a Corruption** *[*A []{#_bookmark8 .anchor}Corruption is the consequence of the corruption of a system resource, e.g. stack or heap overflow, or a hardware memory flaw (including even, for instance, a detected bit flip). A [Corrup-](#_bookmark8) [tion](#_bookmark8) is non-recoverable.*♩(RS_AP_00142)*

> **[SWS_CORE_00022]**{草稿} **腐败的语义** *[*腐败是系统资源腐败的结果，例如堆栈或堆栈溢出，或硬件存储器缺陷（包括例如发现的位翻转）。腐败是不可恢复的。*♩(RS_AP_00142)*


**[SWS_CORE_00023]**{DRAFT} **Semantics of a Failed Default Allocation** *[*A Failed Default Allocation is the inability of the framework's default memory allocation mechanism to satisfy an allocation request. A Failed Default Allocation is non-recoverable.*♩(RS_AP_00142)*

> **[SWS_CORE_00023]**{草案}**失败的默认分配的语义** *[*失败的默认分配是指框架的默认内存分配机制无法满足分配请求。失败的默认分配是不可恢复的。*♩(RS_AP_00142)*


It is expected that a [Violation](#_bookmark7) or [Corruption](#_bookmark8) might occur during development of the framework, when new features are just coming together, but will not be experienced by a user (i.e. an application developer), unless there is something seriously wrong in the system's environment (e.g. faulty hardware: [Corruption](#_bookmark8)), or basic assumptions about resource requirements are violated ([Violation](#_bookmark7)), or possibly the user runs the framework in a configuration that is not supported by its vendor ([Violation](#_bookmark7)).

> 预计在框架开发过程中可能会发生[违规](#_bookmark7)或[腐败](#_bookmark8)，尤其是当新功能刚刚结合在一起时，但用户（即应用程序开发人员）不会遇到这种情况，除非系统环境中出现严重错误（例如：故障硬件：[腐败](#_bookmark8)），或者资源需求的基本假设被违反（[违规](#_bookmark7)），或者用户以供应商不支持的配置运行框架（[违规](#_bookmark7)）。

### Traditional error handling in C and C++


The C language largely relies on error codes for any kind of error handling. While it also has the setjmp/longjmp facility for performing "non-local gotos", its use for error

> C语言在处理错误时主要依赖错误码。虽然它也有setjmp/longjmp设施来执行“非局部跳转”，但它的用途仅限于错误处理。


handling is not widespread, mostly due to the difficulty of reliably avoiding resource leaks.

> 处理并不普遍，主要是由于难以可靠地避免资源泄漏的困难。


Error codes in C come in several flavors:

> C 语言中的错误代码有几种类型：

- return values
- out parameters
- error singletons (e.g. errno)


Typically, these error codes in C are plain int variables, making them a very low-level facility without any type safety.

> 通常，这些C语言中的错误代码是普通的int变量，使它们成为一种没有任何类型安全的低级设施。


C++ inherited these approaches to error handling from C (not least due to the inheritance of the C standard library as part of the C++ standard), but it also introduced exceptions as an alternative means of error propagation. There are many advantages of using exceptions for error propagation, which is why the C++ standard library generally relies on them for error propagation.

> C++继承了C中的错误处理方法（尤其是因为C++标准库继承了C标准库），但它也引入了异常作为另一种错误传播的方式。使用异常进行错误传播有许多优势，这就是为什么C++标准库通常依赖它们来传播错误。


Notwithstanding the advantages of exceptions, error codes are still in widespread use in C++, even within the standard library. Some of that can be explained with concerns about binary compatibility with C, but many new libraries still prefer error codes to exceptions. Reasons for that include:

> 尽管异常有其优势，但错误码仍在C++中广泛使用，即使是在标准库中也是如此。一些原因可以用与C的二进制兼容性有关的担忧来解释，但许多新库仍然更喜欢错误码而不是异常。原因包括：

- with exceptions, it can be difficult to reason about a program's control flow

- exceptions have much higher runtime cost than error codes (either in general, or only in the exception-thrown case)

> 异常的运行时成本比错误码（无论是总体上还是只在异常抛出的情况下）要高得多。


The first of these reasons concerns both humans and code analysis tools. Because exceptions are, in effect, a kind of hidden control flow, a C++ function that seems to contain only a single return statement might in fact have many additional function returns due to exceptions. That can make such a function hard to review for humans, but also hard to analyze for static code analysis tools.

> 这些原因中的第一个涉及人类和代码分析工具。由于异常实际上是一种隐藏的控制流，似乎只包含单个返回语句的C++函数实际上可能由于异常而有许多额外的函数返回。这可能使这样的函数难以人工审查，也难以静态代码分析工具分析。


The second one is even more critical in the context of developing safety-critical software. The specification of C++ exceptions pose significant problems for C++ compiler vendors that want their products be certified for development of safety-critical software. In fact, ASIL-certified C++ compilers generally do not support exceptions at all. One particular problem with exceptions is that exception handling, as specified for C++, implies the use of dynamic memory allocation, which generally has non-predictable or even unbounded execution time. This makes exceptions currently unsuitable for development of certain safety-critical software in the automotive industry.

> 第二个在开发安全关键软件的背景下更关键。C++异常规范给希望让他们的产品获得安全认证的C++编译器供应商带来了重大问题。事实上，ASIL认证的C++编译器通常根本不支持异常。异常的一个特别问题是，按C++规定的异常处理意味着使用动态内存分配，这通常具有不可预测或甚至是无界的执行时间。这使得异常目前不适合用于汽车行业中某些安全关键软件的开发。

### Handling of unsuccessful operations in the Adaptive Platform


The types of unsuccessful operations defined in section [7.2.1.1](#types-of-unsuccessful-operations) ("[Types of unsuccessful](#types-of-unsuccessful-operations) [operations](#types-of-unsuccessful-operations)") are to be treated in different ways.

> 在第7.2.1.1节（“不成功的操作类型”）定义的不成功操作类型应以不同的方式处理。


**[SWS_CORE_00002] Handling of Errors** *[*An [Error](#_bookmark6) shall be returned from the function as an instance of ara::core::Result or ara::core::Future.*♩(RS_AP\_00142, RS_AP_00139, RS_AP_00128)*

> **[SWS_CORE_00002] 错误处理** *[*错误应该以ara::core::Result或ara::core::Future的实例形式从函数中返回。*♩(RS_AP\_00142, RS_AP_00139, RS_AP_00128)*


[]{#_bookmark11 .anchor}**[SWS_CORE_00003] Handling of Violations** *[*If a [Violation](#_bookmark7) is detected, then the operation shall be terminated by either:

> **[SWS_CORE_00003] 处理违规行为**
*如果检测到[违规行为](#_bookmark7)，则操作应通过以下方式终止：*

- throwing an exception that is not a subclass of ara::core::Exception
- explicitly terminating the process abnormally via a call to ara::core::Abort

*♩(RS_AP_00142)*


**[SWS_CORE_00004] Handling of Corruptions** *[*If a [Corruption](#_bookmark8) is detected, it shall result in unsuccessful process termination, in an implementation-defined way.*♩(RS\_AP_00142)*

> 如果检测到[腐败](#_bookmark8)，它将以实现定义的方式导致进程失败终止。


*Note: It can either be abnormal or normal unsuccessful termination, depending on the implementation's ability to detect the [Corruption](#_bookmark8) and to react to it by cleaning up resources.*

> 注意：根据实现检测[损坏](#_bookmark8)并释放资源的能力，可能会出现异常或正常的失败终止。


**[SWS_CORE_00005] Handling of failed default allocations** *[*A \"failed default allocation\" shall be treated the same as a [Violation](#_bookmark7).*♩(RS_AP_00142)*

> **[SWS_CORE_00005] 处理失败的默认分配** *[*“失败的默认分配”应该和[违规](#_bookmark7)一样处理。*♩(RS_AP_00142)*


*Note: An error of a custom allocator is not subject to this definition.*

> *注意：自定义分配器的错误不适用于此定义。*

### Facilities for Error Handling


For handling [Errors](#_bookmark6), there are a number of data types defined that help in dealing with them. These are described in the following subsections.

> 处理[错误](#_bookmark6)时，定义了一些数据类型来帮助处理它们。这些在以下子节中描述。

### ErrorCode


As its name implies, ara::core::ErrorCode is a form of error code; however, it is a class type, loosely modeled on std::error_code, and thus allows much more sophisticated handling of errors than the simple error codes as used in typical C APIs. It always contains a low-level error code value and a reference to an error domain.

> 名字所暗示的，ara::core::ErrorCode是一种错误代码的形式；然而，它是一种类型，松散地模仿std::error_code，因此比典型的C API中使用的简单错误代码允许更复杂的错误处理。它总是包含一个低级错误代码值和一个错误域的引用。


The error code value is an enumeration, typically a scoped one. When stored into a ara::core::ErrorCode, it is type-erased into an integral type and thus handled similarly to a C-style error code. The error domain reference defines the context for which the error code value is applicable and thus provides some measure of type safety.

> 错误代码值是枚举类型，通常是范围限定的。当存储到ara :: core :: ErrorCode中时，它会被擦除为整数类型，因此类似于C样式的错误代码来处理。错误域引用定义了该错误代码值适用的上下文，从而提供了某种类型安全性。


An ara::core::ErrorCode also contains a support data value, which *can* be defined by an implementation of the Adaptive Platform to give a vendor-specific additional piece of data about the error.

> 一个ara::core::ErrorCode也包含一个支持数据值，可以由Adaptive Platform的实现来定义，以提供有关错误的供应商特定的附加数据。


**[SWS_CORE_10302]**{DRAFT} **Semantics of ErrorCode** *[*The type ara::core::ErrorCode provides a class interface for storing an error condition. It shall contain these properties:

> **[SWS_CORE_10302]**{草稿} **错误码的语义** *[*ara::core::ErrorCode类型提供了一个用于存储错误条件的类接口。它应包含以下属性：

- error code value: an integral representation of a low-level error code
- error domain: reference to the context for which the *error code value* is applicable
- support data value: an optional vendor-specific additional piece of data about the error

*♩(RS_AP_00119)*


ara::core::ErrorCode instances are usually not created directly, but only via the forwarding form of the function ara::core::Result::FromError.

> 实例一般不直接创建ara::core::ErrorCode，而只能通过函数ara::core::Result::FromError的转发形式来创建。


An ara::core::ErrorCode is not restricted to any known set of error domains. Its internal type erasure of the enumeration makes sure that it is a simple (i.e., nontemplated) type which can contain arbitrary errors from arbitrary domains.

> 一个ara::core::ErrorCode不受任何已知错误域的限制。它的内部类型擦除枚举确保它是一个简单（即非模板）类型，可以包含任意域的任意错误。


However, comparison of two ara::core::ErrorCode instances only considers the error code value and the error domain reference; the support data value member is not considered for checking equality. This is due to the way ara::core::ErrorCode instances are usually compared against a known set of errors for which to check:

> 然而，比较两个ara :: core :: ErrorCode实例只考虑错误代码值和错误域引用；支持数据值成员不考虑检查相等。这是由于ara :: core :: ErrorCode实例通常比较一组已知的错误，以便进行检查：

1 ErrorCode ec = \...


2 if (ec == MyEnum::some_error)

> 如果（ec == MyEnum::some_error），则为2

3 // \...


4 else if (ec == AnotherEnum::another_error)

> 如果（ec == 另一个枚举::另一个错误）

5 // \...


Each of these comparisons will create a temporary ara::core::ErrorCode object for the right-hand side of the comparison, and then compare ec against that. Such automatically created instances naturally do not contain any meaningful support data value.

> 每个比较都会为比较右侧创建一个临时的ara::core::ErrorCode对象，然后将ec与之进行比较。这些自动创建的实例自然不包含任何有意义的支持数据值。


**[SWS_CORE_10301]**{DRAFT} **Comparison of ara::core::ErrorCode instances** *[*Any comparison of two ara::core::ErrorCode instances shall consider only the following members:

> **[SWS_CORE_10301]**{草稿}**ara :: core :: ErrorCode实例的比较** *[*任何对两个ara :: core :: ErrorCode实例的比较只应考虑以下成员：

- error code value
- error domain

*♩(RS_AP_00119)*


This frequent creation of temporary ara::core::ErrorCode instances is expected to be so fast as to induce no noticeable runtime cost. This is usually ensured by ara::core::ErrorCode being a *literal type*.

> 这种频繁创建临时ara::core::ErrorCode实例的速度期望是如此之快，以至于不会产生明显的运行时成本。通常，通过ara::core::ErrorCode作为一个*文字类型*来确保这一点。


**[SWS_CORE_10300] ErrorCode type properties** *[*Class ara::core::ErrorCode shall be a *literal type*, as defined in section 3.9-10 [basic.types] of [4, the C++14 standard].*♩(RS_AP_00130)*

> [SWS_CORE_10300] 错误码类型属性 *[*类 ara::core::ErrorCode 必须是一种*文字量类型*，如[4，C++14 标准]中第3.9-10节所定义。*♩（RS_AP_00130）*

### ErrorDomain


ara::core::ErrorDomain is the abstract base class for concrete error domains that are defined within Functional Clusters or even Adaptive Applications. This class is loosely based on std::error_category, but differs significantly from it.

> ara::core::ErrorDomain是针对功能群组或自适应应用程序中定义的具体错误域的抽象基类。此类基于std::error_category，但与其有很大不同。


An error domain has an associated error code enumeration and an associated base exception type. Both these are usually defined in the same namespace as the ara::core::ErrorDomain subclass. For normalized access to these associated types,

> 一个错误域具有相关的错误代码枚举和相关的基本异常类型。这些通常都定义在ara :: core :: ErrorDomain子类的相同命名空间中。为了获得这些相关类型的规范访问，


type aliases with standardized names are defined within the ara::core::ErrorDomain subclass. This makes the ErrorDomain subclass the root of all data about errors.

> 在ara::core::ErrorDomain子类中定义了具有标准名称的类型别名。这使得ErrorDomain子类成为所有关于错误的数据的根源。


**[SWS_CORE_10303]**{DRAFT} **Semantics of ErrorDomain** *[*The type ara::core::ErrorDomain defines a context for a set of error conditions.*♩(RS_AP_00119)*

> **[SWS_CORE_10303]**{草案} **ErrorDomain的语义** *[*ara::core::ErrorDomain类型定义了一组错误条件的上下文。*♩(RS_AP_00119)*


Identity of error domains is defined in terms of unique identifiers. AUTOSAR-defined error domains are given standardized identifiers; user-defined error domains are also required to define unique identifiers.

> 错误域的标识是根据唯一标识符来定义的。AUTOSAR定义的错误域被赋予标准标识符；用户定义的错误域也需要定义唯一标识符。


The ara::core::ErrorDomain class definition requires this unique identifier to be of unsigned 64 bit integer type (std::uint64_t). The range of possible values is large enough to apply UUID-like generation patterns (for UID-64) even if typical UUIDs have 128 bits and are thus larger than that. When a new error domain is created (either an AUTOSAR defined or an user defined one) an according Id shall be randomly generated, which represents this error domain. The uniqueness and standardization of such an Id per error domain is mandatory, since the exchange of information on occured errors between callee and caller (potentially located at different ECUs) is based on this Id.

> 类定义ara :: core :: ErrorDomain要求此唯一标识符为无符号64位整数类型（std :: uint64_t）。可能值的范围足够大，以便即使典型的UUID具有128位，因此比该值更大，也可以应用类似UUID的生成模式（用于UID-64）。当创建新的错误域（无论是AUTOSAR定义的还是用户定义的）时，将随机生成相应的ID，它代表此错误域。每个错误域的唯一性和标准化的ID是强制性的，因为在被调用者和调用者（可能位于不同的ECU上）之间基于此ID交换发生错误的信息。


**[SWS_CORE_10401]**{DRAFT} **Identity of ErrorDomains** *[*Two instances of ara::core::ErrorDomain shall compare equal if and only if their unique identifiers are the same.*♩(RS_AP_00119)*

> **[SWS_CORE_10401]**{草案} **错误域的标识** *[*ara::core::ErrorDomain的两个实例只有当它们的唯一标识符相同时，才能比较相等。*♩(RS_AP_00119)*


Given this definition of identity of error domains, it usually makes sense to have only one single instance of each ara::core::ErrorDomain subclass. While new instances of these subclasses can be created by calling their constructors, the recommended way to gain access to these subclasses is to call their non-member accessor functions. For instance, the error domain class ara::core::FutureErrorDomain is referenced by calling ara::core::GetFutureErrorDomain; within any process space, this will always return a reference to the same global instance of this class.

> 根据错误域标识的定义，通常最好只有一个ara::core::ErrorDomain子类的实例。虽然可以通过调用其构造函数创建这些子类的新实例，但建议的获取这些子类的方式是调用它们的非成员访问器函数。例如，通过调用ara::core::GetFutureErrorDomain引用错误域类ara::core::FutureErrorDomain；在任何进程空间中，这将始终返回对此类的全局实例的引用。


For error domains that are modeled in ARXML (as ApApplicationErrorDomain), the C++ language binding will create a C++ class for each such ApApplicationErrorDomain. This C++ class will be a subclass of ara::core::ErrorDomain, and its name will follow a standard scheme.

> 对于在ARXML中建模的错误域（如ApApplicationErrorDomain），C++语言绑定将为每个ApApplicationErrorDomain创建一个C++类。此C++类将是ara :: core :: ErrorDomain的子类，其名称将遵循标准方案。


ara::core has two pre-defined error domains, called ara::core::CoreErrorDomain (containing the set of errors returned by non-Future/Promise facilities from the

> ara::core 有两个预定义的错误域，分别称为ara::core::CoreErrorDomain（包含由非Future/Promise设施返回的错误集）。


ara::core Functional Cluster) and ara::core::FutureErrorDomain (containing errors equivalent to those defined by std::future_errc).

> ara::core功能集群和ara::core::FutureErrorDomain（包含与std::future_errc定义的错误等效的错误）。


Application programmers usually do not interact with class ara::core::ErrorDomain or its subclasses directly; most access is done via ara::core::ErrorCode.

> 应用程序程序员通常不会直接与ara :: core :: ErrorDomain或其子类交互；大多数访问都是通过ara :: core :: ErrorCode完成的。


As ara::core::ErrorDomain subclasses are expected to be implicitly referred to from within constant (i.e. compile-time) expressions (typically involving ara::core:-

> 作为ara::core::ErrorDomain的子类，预计会从常量（即编译时表达式）中隐式引用（通常涉及ara::core：-）


:ErrorCode), they are expected to be *literal types*.

> 错误代码），它们预期是文字类型。


[]{#_bookmark15 .anchor}**[SWS_CORE_10400] ErrorDomain type properties** *[*Class ara::core::ErrorDomain and all its subclasses shall be *literal types*, as defined in section 3.9-10 [basic.types] of [4, the C++14 standard].*♩(RS_AP_00130)*

> [SWS_CORE_10400] 错误域类型属性*[*ara::core::ErrorDomain及其所有子类必须是[4，C++14标准]中3.9-10节[基本类型]中定义的文字类型*♩(RS_AP_00130)*

### Result


The ara::core::Result type follows the ValueOrError concept from the C++ proposal p0786 [5]. It either contains a value (of type ValueType), or an error (of type ErrorType). Both ValueType and ErrorType are template parameters of ara::core::Result, and due to their templated nature, both value and error can be of any type. However, ErrorType is defaulted to ara::core::ErrorCode, and it is expected that this assignment is kept throughout the Adaptive Platform.

> ara::core::Result类型遵循C++提案p0786 [5]中的ValueOrError概念。它要么包含一个值（类型为ValueType），要么包含一个错误（类型为ErrorType）。ValueType和ErrorType都是ara::core::Result的模板参数，由于它们的模板性质，值和错误都可以是任何类型。然而，ErrorType默认为ara::core::ErrorCode，并且期望在整个Adaptive Platform中保持这种赋值。


ara::core::Result acts as a "wrapper type" that connects the exception-less API approach using ara::core::ErrorCode with C++ exceptions. As there is a direct mapping between ara::core::ErrorCode and a domain-specific exception type, ara::core::Result allows to "transform" its embedded ara::core::ErrorCode into the appropriate exception type, by calling ara::core::Result::ValueOrThrow.

> ara::core::Result作为一种“封装类型”，使用ara::core::ErrorCode连接无异常的API方法，从而与C++异常相连接。由于ara::core::ErrorCode与特定领域的异常类型之间存在直接映射，ara::core::Result允许通过调用ara::core::Result::ValueOrThrow将其嵌入的ara::core::ErrorCode“转换”为适当的异常类型。


**[SWS_CORE_10600]**{DRAFT} **Semantics of ara::core::Result** *[*The type ara::core::Result shall provide a means to handle both return values and errors from synchronous function calls in an exception-less way, by providing an encapsulated return type which may be either:

> **[SWS_CORE_10600]**{草案} **ara :: core :: Result的语义** *[*类型ara :: core :: Result应提供一种无需异常的方式来处理同步函数调用的返回值和错误，通过提供封装的返回类型，可以是：

- a value *V*, where *V* may be any C++ type; or
- an error *E*, where *E* may be any C++ type; default is ara::core::ErrorCode.


*♩(RS_AP_00119, RS_AP_00142, RS_AP_00128)*

> *♩(RS_AP_00119、RS_AP_00142、RS_AP_00128)*

### Future and Promise


ara::core::Future and its companion class ara::core::Promise are closely modeled on std::future and std::promise, but have been adapted to interoperate with ara::core::Result. Similar to ara::core::Result described in section [7.2.1.4.3](#result), the class ara::core::Future either contains a value, or an error (the Fu-

> ara::core::Future和它的伴随类ara::core::Promise紧密模仿std :: future和std :: promise，但已被调整以与ara :: core :: Result互操作。与在[7.2.1.4.3]（#result）中描述的ara :: core :: Result类似，ara :: core :: Future类既包含值，也包含错误（Fu-


ture first has to be in "ready" state, though). Class ara::core::Promise has been adapted in two aspects: std::promise::set_exception has been removed, and ara::core::Promise::SetError has been introduced in its stead. For ara::core::Future, there is a new member function ara::core::Future::GetResult that is similar to ara::core::Future::get, but never throws an exception and returns a ara::core::Result instead.

> 首先，ture必须处于“ready”状态，ara::core::Promise已经在两个方面进行了适配：移除了std::promise::set_exception，并且引入了ara::core::Promise::SetError。对于ara::core::Future，新增了成员函数ara::core::Future::GetResult，它类似于ara::core::Future::get，但不会抛出异常，而是返回ara::core::Result。


Thus, ara::core::Future as return type allows the same dual approach to error handling as ara::core::Result, in that it either works exception-based (with ara::core::Future::get), or exception-free (with ara::core::Future::GetResult).

> 因此，ara::core::Future作为返回类型允许与ara::core::Result相同的双重错误处理方法，即可以基于异常（使用ara::core::Future::get）或无异常（使用ara::core::Future::GetResult）。


ara::core::Result is a type used for returning values or errors from a *synchronous* function call, whereas ara::core::Future is a type used for returning values or errors from an *asynchronous* function call.

> ara::core::Result 是一种用于从*同步*函数调用中返回值或错误的类型，而ara::core::Future是一种用于从*异步*函数调用中返回值或错误的类型。


**[SWS_CORE_10800]**{DRAFT} **Semantics of ara::core::Future and ara::core::Promise** *[*The types ara::core::Future and ara::core::Promise shall provide a means to handle both return values and errors from asynchronous function calls in an exception-less way. Together, they provide a means to store a value type *T* or an error type *E* which may be asynchronously retrieved in a thread-safe manner at a later point in time.*♩(RS_AP_00138, RS_AP_00128)*

> **[SWS_CORE_10800]**{草稿} **ara::core::Future和ara::core::Promise的语义** *[*ara::core::Future和ara::core::Promise类型应提供一种无异常的方式来处理异步函数调用的返回值和错误。它们一起提供了一种在稍后的时间以线程安全的方式存储值类型*T*或错误类型*E*的方法。*♩(RS_AP_00138, RS_AP_00128)*

### Duality of ErrorCode and exceptions


By using the classes listed above, all APIs of the Adaptive Platform can be used with either an exception-based or an exception-less error handling workflow. However, no API function will ever treat an [Error](#_bookmark6) by throwing an exception directly; it will always return an error code in the form of a ara::core::Result or ara::core::Future return value instead. It is then possible for the caller to "transform" the [Error](#_bookmark6) into an exception, typically via the member function ara::core::Result::ValueOrThrow.

> 使用上面列出的类，可以使用基于异常或无异常的错误处理工作流来使用Adaptive Platform的所有API。但是，没有API函数会直接抛出[Error](#_bookmark6)，它将始终以ara :: core :: Result或ara :: core :: Future返回值的形式返回错误代码。然后，调用者可以通过成员函数ara :: core :: Result :: ValueOrThrow将[Error](#_bookmark6)“转换”为异常。


When working with a C++ compiler that does not support exceptions at all (or one that has been configured to disable them with an option such as g++'s -fnoexceptions), all API functions still show the same behavior. What *does* differ then is that ara::core::Result::ValueOrThrow is not defined -this member function is only defined when the compiler does support exceptions.

> 当使用不支持异常（或者使用g++的-fnoexceptions选项禁用异常）的C++编译器时，所有API函数仍然表现出相同的行为。那么*不同*的是，ara :: core :: Result :: ValueOrThrow不存在——这个成员函数只有在编译器支持异常时才定义。

### Exception hierarchy


The Adaptive Platform defines a base exception type ara::core::Exception for all exceptions defined in the standard. This exception takes a ara::core::ErrorCode object as mandatory constructor argument, similar to the way std::system_error takes a std::error_code argument for construction.

> 适应性平台为所有标准中定义的异常定义了一个基本异常类型ara::core::Exception。该异常以ara::core::ErrorCode对象作为必需的构造函数参数，类似于std::system_error接受std::error_code参数进行构造。


Below this exception base type, there is an additional layer of exception base types, one for each error domain.

> 在这个异常基类之下，还有一个额外的异常基类层，每个错误域都有一个。


For error domains that are modeled in ARXML, the C++ language binding will generate an exception class in addition to the ErrorDomain subclass (which is described in section [7.2.1.4.2](#errordomain)). This exception class also conforms to a standard naming scheme:

> 对于在ARXML中建模的错误域，C++语言绑定除了描述在[7.2.1.4.2]（#errordomain）章节中的ErrorDomain子类之外，还将生成一个异常类。此异常类也遵循标准命名规则：


\<shortname\> of ApApplicationErrorDomain plus "Exception" suffix (this makes it distinguishable from the ErrorDomain subclass itself). It is located in the same namespace as the corresponding ErrorDomain subclass.

> \<shortname\> ApApplicationErrorDomain 的加上"Exception"后缀（这使它与ErrorDomain子类本身区分开来）。它位于与相应ErrorDomain子类相同的命名空间中。

### Creating new error domains


Any new software module with significant logical separation from all existing modules of the Adaptive Platform should define one or more own error domains.

> 任何与自适应平台的所有现有模块具有重大逻辑分离的新软件模块都应定义一个或多个自己的错误域。


An error domain consists of:

> 一个错误域包括：

- an error condition enumeration
- an exception base class
- an ara::core::ErrorDomain subclass
- a non-member ErrorDomain subclass accessor function
- a non-member MakeErrorCode function overload


All these are to reside not in the ara::core namespace, but in the "target" one.

> 这些都不应该位于ara::core命名空间，而应位于"target"命名空间中。


**[SWS_CORE_10999] Custom error domain scope** *[*The ara::core::ErrorDomain subclass and the corresponding enumeration, exception base class, nonmember accessor function, and the MakeErrorCode overload shall be defined in the same namespace as the software module for which they are being specified.*♩(RS\_AP_00130)*

> **[SWS_CORE_10999] 自定义错误域范围** *[*ara :: core :: ErrorDomain 子类及其相应的枚举、异常基类、非成员访问器函数以及MakeErrorCode重载应在与为其指定的软件模块相同的命名空间中定义。*♩(RS\_AP_00130)*


*Note: This is to help making sure that the C++ ADL mechanism works as expected by other parts of this standard.*

> 注意：这是为了帮助确保C++ ADL机制可以按照本标准的其他部分的预期工作。


An error domain defined in the way specified in this section is suitable to be used for the ApApplicationErrorDomain model element.

> 一个按照本节指定的方式定义的错误域适合用于ApApplicationErrorDomain模型元素。


Throughout this section, the character sequence \<SN\> is a placeholder for the *shortname* of the ApApplicationErrorDomain.

> 在本节中，字符序列\<SN\>是ApApplicationErrorDomain的*短名称*的占位符。

### Error condition enumeration


The error condition enumeration describes all known error conditions of the new software module. It should be reasonably fine-grained to allow users to differentiate error conditions that they might want to handle in different ways.

> 新软件模块的错误条件枚举描述了所有已知的错误条件。它应该具有合理的细粒度，以便用户能够区分他们可能想以不同方式处理的错误条件。


[]{#_bookmark22 .anchor}**[SWS_CORE_10900] Error condition enumeration type** *[*Each error domain shall define an error condition enum class with the base type ara::core::ErrorDomain::CodeType that holds all error conditions of that error domain.*♩(RS_AP_00130)*

> [SWS_CORE_10900] 错误条件枚举类型*[*每个错误域都应定义一个错误条件枚举类，其基类型为ara::core::ErrorDomain::CodeType，其中包含该错误域的所有错误条件。*♩（RS_AP_00130）*


**[SWS_CORE_10901] Error condition enumeration naming** *[*Error domain error condition enumerations shall follow the naming scheme \<SN\>Errc, where \<SN\> is the shortname of the ApApplicationErrorDomain.*♩(RS_AP_00130)*

> **[SWS_CORE_10901] 错误条件枚举命名** *[*错误域错误条件枚举应遵循\<SN\>Errc的命名方案，其中\<SN\>是ApApplicationErrorDomain的简称。♩(RS_AP_00130)*


**[SWS_CORE_10902] Error condition enumeration contents** *[*Error domain error condition enumerations shall not contain any values that indicate success.*♩(RS_AP\_00130)*

> **[SWS_CORE_10902] 错误条件枚举内容** *[*错误域错误条件枚举不应包含任何表示成功的值。*♩（RS_AP\_00130）*


**[SWS_CORE_10903] Error condition enumeration numbers** *[*Error domain error condition enumerations shall keep the number 0 unassigned.*♩(RS_AP_00130)*

> **[SWS_CORE_10903] 错误条件枚举号** *[*错误域错误条件枚举应保持号码0未分配。♩(RS_AP_00130)*

### Exception base class


As a complement to the error condition enumeration, an exception base class for this error domain also needs to be defined. This exception base class is used for the "transformation" of an ara::core::ErrorCode object into an exception.

> 为了补充错误条件枚举，还需要为此错误域定义一个异常基类。此异常基类用于将ara :: core :: ErrorCode对象转换为异常。


Additional exception types can be defined by the software module, but all these then derive from this base type.

> 软件模块可以定义额外的异常类型，但所有这些类型都派生自此基本类型。


[]{#_bookmark24 .anchor}**[SWS_CORE_10910] ErrorDomain exception base type** *[*Each error domain shall define an exception base type that is a subclass of ara::core::Exception.*♩(RS\_AP_00130)*

> [SWS_CORE_10910] 错误域异常基类类型错误：*每个错误域都应定义一个异常基类类型，它是ara::core::Exception的子类。*♩（RS_AP_00130）


**[SWS_CORE_10911] ErrorDomain exception base type naming** *[*All error domain exception base types specified by [[SWS_CORE_10910](#_bookmark24)] shall follow the naming scheme \<SN\>Exception, where \<SN\> is the shortname of the ApApplicationErrorDomain.*♩(RS_AP_00130)*

> **[SWS_CORE_10911] 错误域异常基类命名** *[*所有由[[SWS_CORE_10910](#_bookmark24)]指定的错误域异常基类都应遵循\<SN\>Exception的命名方案，其中\<SN\>是ApApplicationErrorDomain的简称。*♩(RS_AP_00130)*


**[SWS_CORE_10912]**{DRAFT} **ErrorDomain exception type hierarchy** *[*All additional exception types defined by a software module shall have the exception base type specified by [[SWS_CORE_10910](#_bookmark24)] as a base class.*♩(RS_AP_00130)*

> **[SWS_CORE_10912]**{草案} **错误域异常类型层次结构** *[*软件模块定义的所有附加异常类型都应以[[SWS_CORE_10910](#_bookmark24)]指定的异常基类作为基类。*♩（RS_AP_00130）*

### ErrorDomain subclass


Then, a new class is created that derives from ara::core::ErrorDomain and overrides all the pure virtual member functions. In addition to that, it also needs to define in its scope a type alias called Errc for the error condition enumeration, as well as another type alias called Exception for the exception base class for this new error domain.

> 然后，创建一个新类，它派生自ara :: core :: ErrorDomain并重写所有纯虚拟成员函数。此外，它还需要在其范围内定义一个类型别名Errc，用于该错误条件枚举，以及另一个类型别名Exception，用于该新错误域的异常基类。


**[SWS_CORE_10930] ErrorDomain subclass type** *[*Each error domain shall define a class type that derives publicly from ara::core::ErrorDomain.*♩(RS_AP_00130)*

> **[SWS_CORE_10930] 错误域子类类型** *[*每个错误域都应定义一个公开从ara::core::ErrorDomain派生的类类型。*♩(RS_AP_00130)*


**[SWS_CORE_10931] ErrorDomain subclass naming** *[*All subclasses of ara::core::ErrorDomain shall follow the naming scheme \<SN\>ErrorDomain, where

> **[SWS_CORE_10931] 错误域子类命名** *[*ara::core::ErrorDomain的所有子类都应遵循\<SN\>ErrorDomain的命名方案，其中


\<SN\> is the shortname of the ApApplicationErrorDomain.*♩(RS_AP_00130)*

> \<SN\>是ApApplicationErrorDomain的简称。♩(RS_AP_00130)


**[SWS_CORE_10932] ErrorDomain subclass non-extensibility** *[*All subclasses of

> **[SWS_CORE_10932] 错误域子类不可扩展**


ara::core::ErrorDomain shall be final.*♩(RS_AP_00130, RS_AP_00140)*

> ara::core::ErrorDomain 应该是最终的。♩（RS_AP_00130，RS_AP_00140）


**[SWS_CORE_10933] ErrorDomain subclass Errc symbol** *[*All subclasses of ara::core::ErrorDomain shall contain in their scope a type alias called Errc that refers to the error condition enumeration defined by [[SWS_CORE_10900](#_bookmark22)].*♩(RS_AP_00130)*

> **[SWS_CORE_10933] 错误域子类 Errc 符号** *[*所有 ara::core::ErrorDomain 的子类都应在其作用域中包含一个名为 Errc 的类型别名，该别名指向由[[SWS_CORE_10900](#_bookmark22)]定义的错误条件枚举。*♩(RS_AP_00130)*


[]{#_bookmark26 .anchor}**[SWS_CORE_10934] ErrorDomain subclass Exception symbol** *[*All subclasses of ara::core::ErrorDomain shall contain in their scope a type alias called Exception that refers to the exception base type defined by [[SWS_CORE_10910](#_bookmark24)].*♩(RS\_AP_00130)*

> 所有ara::core::ErrorDomain的子类都应该在它们的范围内包含一个叫做Exception的类型别名，它指向由[[SWS_CORE_10910](#_bookmark24)]定义的异常基类型。♩（RS_AP_00130）


All ErrorDomain subclasses are usable from within constant expressions, see [[SWS_CORE_10400](#_bookmark15)]. In particular, this includes that ErrorDomain subclasses can be defined as constexpr global variables.

> 所有ErrorDomain子类都可以在常量表达式中使用，详见[[SWS_CORE_10400](#_bookmark15)]。特别是，这包括ErrorDomain子类可以被定义为constexpr全局变量。


In order to further ease working with error domains, all member functions of the ErrorDomain subclass are required to be noexcept, with the obvious exception of ara::core::ErrorDomain::ThrowAsException.

> 为了进一步简化对错误域的处理，要求ErrorDomain子类的所有成员函数都必须是noexcept的，显然ara :: core :: ErrorDomain :: ThrowAsException除外。


**[SWS_CORE_10950] ErrorDomain subclass member function property** *[*With the exception of ara::core::ErrorDomain::ThrowAsException, all public member functions of all ErrorDomain subclasses shall be noexcept.*♩(RS_AP_00130)*

> 除了ara::core::ErrorDomain::ThrowAsException，所有ErrorDomain子类的所有公共成员函数都必须是不可抛出异常的。


The virtual member function ara::core::ErrorDomain::Name returns the shortname of the ApApplicationErrorDomain, mostly for logging purposes.

> 虚拟成员函数ara::core::ErrorDomain::Name返回ApApplicationErrorDomain的简称，主要用于日志记录的目的。


**[SWS_CORE_10951] ErrorDomain subclass shortname retrieval** *[*The return value of an error domain's ara::core::ErrorDomain::Name member function shall be equal to the shortname of the ApApplicationErrorDomain.*♩(RS_AP_00130)*

> **[SWS_CORE_10951] 错误域子类短名检索** *[*错误域的ara::core::ErrorDomain::Name成员函数的返回值应等于ApApplicationErrorDomain的短名。*♩(RS_AP_00130)*


Each error domain has an identifier that is used to determine equality of error domains. The error domains that are pre-defined by the Adaptive Platform have standardized identifiers. Application-specific error domains should make sure their identifiers are system-wide unique.

> 每个错误域都有一个标识符，用于确定错误域的相等性。Adaptive Platform预定义的错误域具有标准标识符。应用程序特定的错误域应确保它们的标识符在系统范围内是唯一的。


**[SWS_CORE_10952] ErrorDomain subclass unique identifier retrieval** *[*The return value of an error domain's ara::core::ErrorDomain::Id member function shall be a unique identifier that follows the rules defined by [[SWS_CORE_00010](#_bookmark31)].*♩(RS\_AP_00130)*

> **[SWS_CORE_10952] 错误域子类唯一标识符检索** *[*错误域的ara::core::ErrorDomain::Id成员函数的返回值应该是一个遵循[[SWS_CORE_00010](#_bookmark31)]中定义的规则的唯一标识符。*♩(RS\_AP_00130)*


An ErrorDomain can "transform" an ErrorCode into an exception.

> 一个ErrorDomain可以将ErrorCode转换成异常。


**[SWS_CORE_10953] Throwing ErrorCodes as exceptions** *[*The type of an exception thrown by the ErrorDomain subclass's implementation of ara::core::ErrorDomain::ThrowAsException shall derive from that ErrorDomain subclass's Exception type alias defined by [[SWS_CORE_10934](#_bookmark26)].*♩(RS_AP_00130)*

> [SWS_CORE_10953] 抛出错误码作为异常。*[*ErrorDomain子类的ara :: core :: ErrorDomain :: ThrowAsException实现抛出的异常类型必须派生自该ErrorDomain子类的Exception类型别名，由[[SWS_CORE_10934](#_bookmark26)]定义。*♩(RS_AP_00130)*

### Non-member ErrorDomain subclass accessor function


A non-member accessor function for the new error domain class is to be defined. For an error domain class MyErrorDomain, the accessor function is named GetMyErrorDomain. This accessor function returns a reference to a single global instance of that class. This accessor function shall be fully constexpr-capable; this in turn implies that the ErrorDomain subclass also shall be constexpr-constructible (see [[SWS_CORE_10400](#_bookmark15)]).

> 要为新的错误域类定义一个非成员访问函数。对于错误域类MyErrorDomain，访问函数的名称为GetMyErrorDomain。此访问函数返回该类的单个全局实例的引用。此访问函数应完全支持constexpr；这反过来意味着ErrorDomain子类也应该是可constexpr构造的（参见[[SWS_CORE_10400](#_bookmark15)）。


**[SWS_CORE_10980] ErrorDomain subclass accessor function** *[*For all subclasses of ara::core::ErrorDomain, there shall be a non-member constexpr function that returns a reference-to-const to a singleton instance of it.*♩(RS_AP_00130)*

> **[SWS_CORE_10980] 错误域子类访问器函数** *[*对于ara::core::ErrorDomain的所有子类，应该有一个非成员constexpr函数，它返回一个对它的单例实例的常量引用。*♩(RS_AP_00130)*

### [SWS_CORE_10981] ErrorDomain subclass accessor function naming *[*All ara::core::ErrorDomain subclass accessor functions shall follow the naming scheme Get\<SN\>ErrorDomain, where \<SN\> is the shortname of the ApApplicationErrorDomain.*♩(RS_AP_00130)*


**[SWS_CORE_10982] ErrorDomain subclass accessor function** *[*All ara::core::ErrorDomain subclass accessor functions shall have a return type of const ErrorDomain&.*♩(RS_AP_00130)*

> **[SWS_CORE_10982] 错误域子类访问器函数** *[*所有ara::core::ErrorDomain子类的访问器函数的返回类型都应为const ErrorDomain&。*♩(RS_AP_00130)*

### Non-member MakeErrorCode overload


And finally, a non-member factory function MakeErrorCode needs to be defined, which is implicitly used by the convenience constructors of class ara::core::ErrorCode. This factory function will make use of the non-member accessor function for the error domain subclass, and call the type-erased constructor of class ara::core::ErrorCode.

> 最后，需要定义一个非成员工厂函数MakeErrorCode，它会被ara :: core :: ErrorCode的便捷构造函数隐式地使用。这个工厂函数将使用错误域子类的非成员访问函数，并调用ara :: core :: ErrorCode的类型擦除构造函数。


**[SWS_CORE_10990] MakeErrorCode overload for new error domains** *[*For all subclasses of ara::core::ErrorDomain, there shall be a constexpr overload of the non-member function MakeErrorCode that creates an ara::core::ErrorCode instance for a given error condition value within the ara::core::ErrorDomain subclass's error condition range.*♩(RS_AP_00130)*

> **[SWS_CORE_10990] 为新的错误域提供MakeErrorCode重载** *[*对于ara::core::ErrorDomain的所有子类，应该有一个constexpr重载的非成员函数MakeErrorCode，它为ara::core::ErrorDomain子类的错误条件范围内的给定错误条件值创建一个ara::core::ErrorCode实例。*♩(RS_AP_00130)*


**[SWS_CORE_10991] MakeErrorCode overload signature** *[*All overloads of the nonmember function MakeErrorCode shall have the following signature:

> **[SWS_CORE_10991] MakeErrorCode 重载签名** *[*非成员函数 MakeErrorCode 的所有重载都应具有以下签名：


1 constexpr ErrorCode MakeErrorCode(\<SN\>Errc code, ErrorDomain:: SupportDataType data) noexcept;

> constexpr 错误代码 MakeErrorCode(<SN>Errc 代码, ErrorDomain::SupportDataType 数据) noexcept;


where \<SN\> is the shortname of the ApApplicationErrorDomain.*♩(RS_AP\_00130)*

> 在哪里，SN是ApApplicationErrorDomain的简称。(RS_AP_00130)

### C++ pseudo code example


The following C++ pseudo code illustrates how these definitions come together:

> 以下C++伪代码演示了这些定义如何结合在一起：

```
1 namespace my

2 {

3

4 enum class \<SN\>Errc : ara::core::ErrorDomain::CodeType

5 {

6 // \...

7 };

8

9 class \<SN\>Exception : public ara::core::Exception

10 {

11 public:

12 \<SN\>Exception(ara::core::ErrorCode err) noexcept;

13 };

14

15 class \<SN\>ErrorDomain final : public ara::core::ErrorDomain

16 {

17 public:

18 using Errc = \<SN\>Errc;

19 using Exception = \<SN\>Exception;

20

21 constexpr \<SN\>ErrorDomain() noexcept;

22

23 const char\* Name() const noexcept override;

24 const char\* Message(ara::core::ErrorDomain::CodeType errorCode) const noexcept override;

25 void ThrowAsException(const ara::core::ErrorCode& errorCode) const noexcept(false) override;

26 };

27

28 constexpr const ara::core::ErrorDomain& Get\<SN\>ErrorDomain() noexcept;

29

30 constexpr ara::core::ErrorCode MakeErrorCode(\<SN\>Errc code, ara::core:: ErrorDomain::SupportDataType data) noexcept;

31

32 } // namespace my
```

### AUTOSAR error domains


The full range of unique error domain identifiers is partitioned into a range of AUTOSAR-specified IDs, another range of vendor-defined IDs, and another range of user-defined IDs.

> 全部独特的错误域标识符被划分为AUTOSAR规定的ID范围、供应商定义的ID范围和用户定义的ID范围。


User-defined IDs have their top-bit set to 0 and can use the remaining 63 bits to provide uniqueness. IDs with their top-bit set to 1 are reserved for AUTOSAR and stack vendor use.

> 用户定义的ID将其顶位设置为0，可以使用剩余的63位来提供唯一性。将其顶位设置为1的ID保留供AUTOSAR和堆栈供应商使用。


[]{#_bookmark31 .anchor}**[SWS_CORE_00010] Error domain identifier** *[*All error domains shall have a systemwide unique identifier that is represented as a 64-bit unsigned integer value.*♩(RS_AP\_00130)*

> [SWS_CORE_00010] 错误域标识符** *[*所有错误域都必须具有系统范围内唯一的标识符，该标识符表示为64位无符号整数值。*♩(RS_AP\_00130)*


**[SWS_CORE_00011] AUTOSAR error domain range** *[*Error domain identifiers where bit #63 is set to 1 and bit #62 is set to 0 are reserved for AUTOSAR-defined error domains.*♩(RS_AP_00130)*

> **[SWS_CORE_00011] AUTOSAR错误域范围** *[*当位#63设置为1且位#62设置为0时，将保留用于AUTOSAR定义的错误域的标识符。*♩(RS_AP_00130)*


**[SWS_CORE_00016]**{DRAFT} **Vendor-defined error domain range** *[*Error domain identifiers where the top 32 bits (i.e. bit #63..#32) are equal to 0xc000'0000 are reserved for vendor-specific error domains. Bits #31..#16 hold the vendor's numerical identifier, and bits #15..#0 can be used by each vendor for error domain identifiers.*♩ (RS_AP_00130)*

> **[SWS_CORE_00016]**{草稿} **供应商定义的错误域范围** *[*错误域标识符的前 32 位（即位 #63..#32）等于 0xc000'0000，专门用于供应商特定的错误域。位 #31..#16 保存供应商的数字标识符，位 #15..#0 可由每个供应商用于错误域标识符。*♩ (RS_AP_00130)*


**[SWS_CORE_00013] The Future error domain** *[*There shall be an error domain ara::core::FutureErrorDomain for all errors originating from the interaction of the classes ara::core::Future and ara::core::Promise. It shall have the shortname Future and the identifier 0x8000'0000'0000'0013.*♩(RS_AP_00130)*

> **[SWS_CORE_00013] 未来错误域** *[*ara :: core :: FutureErrorDomain 将是所有源自类 ara :: core :: Future 和 ara :: core :: Promise 交互的错误的错误域。它的简称为Future，标识符为0x8000'0000'0000'0013。♩(RS_AP_00130)*


**[SWS_CORE_00014] The Core error domain** *[*There shall be an error domain ara::core::CoreErrorDomain for errors originating from non-Future/Promise facilities of ara::core. It shall have the shortname Core and the identifier 0x8000'0000'0000'0014.*♩(RS_AP_00130)*

> **[SWS_CORE_00014] 核心错误域** *[*ara::core的非Future / Promise设施将具有ara :: core :: CoreErrorDomain的错误域。它的简称为Core，标识符为0x8000'0000'0000'0014。♩（RS_AP_00130）*

### Async signal safety


An *async-signal-safe* function is one that can be safely called from within a POSIX signal handler.

> 一个*异步信号安全*函数是可以安全地从POSIX信号处理程序中调用的函数。


[6, The POSIX standard] defines a set of functions that are guaranteed to be asyncsignal-safe; all functions not on that list need to be assumed unsuitable to be called within a signal handler. This includes all ARA APIs, as it is not specified (and in general not possible to determine) which other functions (whether from POSIX or from other standards or implementations) are called within them.

> POSIX标准[6]定义了一组保证异步信号安全的函数；所有不在该列表中的函数都不能在信号处理程序中调用。这包括所有ARA API，因为没有指定（一般来说也不可能确定）它们调用了哪些其他函数（无论是来自POSIX还是其他标准或实现）。


Usage of any ARA API within a signal handler will result in undefined behavior of the application, unless otherwise specified.

> 使用任何ARA API在信号处理程序中将导致应用程序的未定义行为，除非另有规定。

### Explicit Operation Abortion


If a [Violation](#_bookmark7) has been detected by the implementation of an API function, [[SWS_CORE_00003](#_bookmark11)] mandates to abort this operation immediately. It allows two ways to do this; either by throwing certain kinds of exceptions (if the implementation supports C++ exceptions), or by calling ara::core::Abort.

> 如果API函数的实现检测到[违规](#_bookmark7)，[[SWS_CORE_00003](#_bookmark11)]规定立即中止此操作。它允许两种方式来实现：要么抛出某些类型的异常（如果实现支持C++异常），要么调用ara::core::Abort。


Calling ara::core::Abort will result in an Explicit Operation Abortion, which usually leads to an Unexpected Termination as defined by [7]. This section defines the behavior of this mechanism.

> 调用ara::core::Abort将导致显式操作中止，通常会导致[7]定义的意外终止。本节定义了此机制的行为。


Like std::abort, calling ara::core::Abort is meant to terminate the current process abnormally and immediately, without performing stack unwinding and without calling destructors of static objects.

> 类似于std::abort，调用ara::core::Abort旨在立即异常终止当前进程，而无需执行堆栈撤消操作，也无需调用静态对象的析构函数。


**[SWS_CORE_12402]**{DRAFT} **"Noreturn" property for Abort** *[*The function ara:-

> **[SWS_CORE_12402]**{草案} **"Noreturn" 属性用于中止** *[*函数ara:-


:core::Abort shall not return to its caller.*♩(RS_AP_00130)*

> :core::Abort 不应返回给其调用者。♩(RS_AP_00130)


[]{#_bookmark34 .anchor}**[SWS_CORE_12403]**{DRAFT} **Logging of Explicit Operation Abortion** *[*Calling ara::core::Abort shall result in a log message, which shall contain the string that has been passed to the function as argument, being output to the process's standard error stream.*♩(RS_AP_00130)*

> [SWS_CORE_12403]{DRAFT} **记录明确操作的中止** *[*调用ara::core::Abort应产生一条日志消息，该消息应将作为参数传递给该函数的字符串输出到进程的标准错误流中。*♩(RS_AP_00130)*


**[SWS_CORE_12407]**{DRAFT} **Thread-safety of Explicit Operation Abortion** *[*While a call to ara::core::Abort is in progress, other calls to this function shall block the calling threads.*♩(RS_AP_00130)*

> **[SWS_CORE_12407]**{草稿} **显式操作终止的线程安全性** *[*当调用ara::core::Abort时，其他对此函数的调用将阻塞调用线程。*♩(RS_AP_00130)*


ara::core::Abort provides a means to add a "hook" into the system, by calling ara::core::SetAbortHandler, similar to the way std::atexit allows to install a callback for the std::exit mechanism.

> ara::core::Abort提供了一种通过调用ara::core::SetAbortHandler将"钩子"添加到系统中的方法，类似于std::atexit允许为std::exit机制安装回调函数的方式。


**[SWS_CORE_12404]**{DRAFT} **AbortHandler invocation** *[*Calling ara::core::Abort shall invoke the AbortHandlers after the log message as per [[SWS_CORE_12403](#_bookmark34)] has been output, in the reverse order of installation.*♩(RS_AP\_00130)*

> **[SWS_CORE_12404]**{草案} **中止处理程序调用** *[*调用ara::core::Abort应该在输出[[SWS_CORE_12403](#_bookmark34)]中指定的日志消息后，以安装的相反顺序调用中止处理程序。*♩(RS_AP\_00130)*

### AbortHandler


This handler can be installed with ara::core::SetAbortHandler or ara::core::AddAbortHandler. It is invoked in turn when ara::core::Abort is called, and it may perform arbitrary operations and then has these four principal choices for its final statements: it can either

> 这个处理程序可以使用ara::core::SetAbortHandler或ara::core::AddAbortHandler安装。当调用ara::core::Abort时，它将依次被调用，它可以执行任意操作，然后有四个主要选择作为其最终语句：它可以

- terminate the process, or
- return from the function call, or
- defer function return by entering an infinite loop, or
- perform a non-local goto operation such as std::longjmp.


The use of non-local goto operations, including std::longjmp, is strongly discouraged and also expressively prohibited by MISRA, the AUTOSAR C++14 Coding Guidelines, and most other coding guidelines as well.

> 使用非局部的goto操作，包括std::longjmp，强烈不推荐，并且MISRA、AUTOSAR C++14编码规范以及其他大多数编码规范也明确禁止。


Similarly, deferring function return by entering an infinite loop is discouraged as well; while this still leads to the desired outcome that the *operation* which caused a [Viola-](#_bookmark7) [tion](#_bookmark7) has been aborted, it will do so at the cost of "defunct'ing" the calling thread and risking the destabilization of the software, which already has encountered a [Viola-](#_bookmark7) [tion](#_bookmark7).

> 同样，通过进入无限循环而延迟函数返回也是不被鼓励的；虽然这仍然会导致预期的结果，即引起Viola-tion的操作已经被中止，但这将以调用线程“僵死”的代价实现，并冒着已经遇到Viola-tion的软件稳定性的风险。


An AbortHandler that terminates the process is strongly advised to do so by calling std::abort. This will make sure that the Unexpected Termination is properly seen by Execution Management as an Abnormal Termination as well.

> 强烈建议使用AbortHandler终止进程，并通过调用std :: abort来完成。这样可以确保执行管理将意外终止正确视为异常终止。


If all AbortHandlers return, or if no AbortHandler is defined at all, then the final action of ara::core::Abort is to call std::abort.

> 如果所有AbortHandlers都返回，或者根本没有定义AbortHandler，那么ara::core::Abort的最终操作就是调用std::abort。


**[SWS_CORE_12405]**{DRAFT} **Final action without AbortHandler** *[*If there is no custom ara::core::AbortHandler that has been installed with ara::core::SetAbortHandler or ara::core::AddAbortHandler, then the implementation of ara::core::Abort shall call std::abort().*♩(RS_AP_00130)*

> **[SWS_CORE_12405]**{草案} **不使用AbortHandler的最终行动** *[*如果没有使用ara::core::SetAbortHandler或ara::core::AddAbortHandler安装自定义ara::core::AbortHandler，那么ara::core::Abort的实现将调用std::abort()。*♩(RS_AP_00130)*


**[SWS_CORE_12406]**{DRAFT} **Final action with returning AbortHandlers** *[*If there are custom ara::core::AbortHandlers that have been installed with ara::core::SetAbortHandler or ara::core::AddAbortHandler and all of them return, then the implementation of ara::core::Abort shall call std::abort().*♩ (RS_AP_00130)*

> **[SWS_CORE_12406]**{草案} **最终行动，返回AbortHandlers** *[*如果使用ara::core::SetAbortHandler或ara::core::AddAbortHandler安装了自定义ara::core::AbortHandlers，并且所有这些都返回，那么ara::core::Abort的实现将调用std::abort()。*♩ (RS_AP_00130)*

简体中文：**[SWS_CORE_12406]**{草案} **最终行动，返回AbortHandlers** *[*如果使用ara::core::SetAbortHandler或ara::core::AddAbortHandler安装了自定义ara::core::AbortHandlers，并且所有这些都返回，那么ara::core::Abort的实现将调用std::abort()。*♩ (RS_AP_00130)*

### SIGABRT handler


In addition to the ara::core::AbortHandler, or alternatively to it, the application can also influence this mechanism by installing a signal handler for SIGABRT.

> 除了ara::core::AbortHandler之外，或者作为替代，应用程序还可以通过为SIGABRT安装信号处理程序来影响此机制。


The signal handler for SIGABRT has the same choices of actions as the ara::core::AbortHandler: it can terminate the process, return from the function call, defer function return by entering an infinite loop, or perform a non-local goto operation. The same caveats as for the ara::core::AbortHandler apply here: non-local goto operations and infinite loops should be avoided.

> SIGABRT的信号处理程序与ara::core::AbortHandler具有相同的操作选择：它可以终止进程、从函数调用中返回、通过进入无限循环而延迟函数返回，或者执行非局部跳转操作。同样的警告也适用于ara::core::AbortHandler：应避免使用非局部跳转操作和无限循环。


If the SIGABRT handler does not return, it should in general terminate abnormally with SIGABRT. To do this without entering an infinite loop, it should restore the default disposition of SIGABRT with std::signal(SIGABRT, SIG_DFL) and then re-raise SIGABRT with e.g. std::raise(SIGABORT).

> 如果SIGABRT处理程序不返回，它通常应该以SIGABRT异常终止。为了避免进入无限循环，它应该使用std :: signal（SIGABRT，SIG_DFL）恢复SIGABRT的默认处置，然后使用例如std :: raise（SIGABORT）重新引发SIGABRT。


This "second step" of influence that the SIGABRT handler provides allows applications that are already handling other synchronous signals such as SIGSEGV or SIGFPE to treat SIGABRT the same way.

> 这种SIGABRT处理程序提供的“第二步”影响允许已经处理其他同步信号（如SIGSEGV或SIGFPE）的应用程序以相同的方式处理SIGABRT。


1. ### Advanced data types

> ### 高级数据类型


   1. []{#_bookmark38 .anchor}**AUTOSAR types**

> **AUTOSAR类型**

      1. []{#_bookmark39 .anchor}**InstanceSpecifier**


Instances of ara::core::InstanceSpecifier are used to identify service port prototype instances within the AUTOSAR meta-model and are therefore used in the ara::com API and elsewhere. A detailed description and background can be found in [8] sections 6.1 ("Instance Identifiers") and 9.4.4 ("Usage of meta-model identifiers within ara::com based application code").

> 使用ara::core::InstanceSpecifier实例来标识AUTOSAR元模型中的服务端口原型实例，因此它们被用于ara::com API和其他地方。有关详细描述和背景，请参阅[8]部分6.1（“实例标识符”）和9.4.4（“ara::com基础应用程序代码中的元模型标识符的使用”）。


ara::core::InstanceSpecifier can conceptually be understood to be a wrapper for a string representation of a valid meta-model path. It is designed to be either constructed from a string representation via a factory method ara::core::InstanceSpecifier::Create, which provides an exception-free solution, or directly by using the constructor, which might throw an exception if the string representation is invalid.

> ara::core::InstanceSpecifier可以从概念上理解为一个用于有效元模型路径的字符串表示的包装器。它被设计为可以通过工厂方法ara::core::InstanceSpecifier::Create从字符串表示中构造，该方法提供异常免费的解决方案，或者直接使用构造函数，如果字符串表示无效可能会抛出异常。


[]{#_bookmark40 .anchor}**[SWS_CORE_10200] Valid InstanceSpecifier representations application interaction** *[*In case of application interaction and thus in the presence of PortPrototypes the string representation of a valid ara::core::InstanceSpecifier consists of a \"/\"-separated list of model element shortNames starting from an Executable via the RootSwComponentPrototype and several SwComponentPrototypes to the respective PortPrototype to which the ara::core::InstanceSpecifier shall apply.*♩(RS_AP_00130)*

> 在应用程序交互的情况下，即存在端口原型的情况下，ara :: core :: InstanceSpecifier的有效字符串表示从可执行文件开始，通过RootSwComponentPrototype和几个SwComponentPrototype，到应用InstanceSpecifier的相应PortPrototype，由“/”分隔的模型元素短名列表。


Thus, in case of application interaction the content of a valid ara::core::InstanceSpecifier adheres to the following pattern: Executable.shortName/RootSwComponentPrototype.shortName

> 因此，在应用交互的情况下，有效ara :: core :: InstanceSpecifier的内容遵循以下模式：可执行文件。shortName / RootSwComponentPrototype.shortName。


/SwComponentPrototype.shortName/\.../PortPrototype.shortName

> /SwComponentPrototype.shortName/\.../PortPrototype.shortName/
简称：SwComponentPrototype/.../PortPrototype


**[SWS_CORE_10203] Valid InstanceSpecifier representations functional cluster interaction** *[*In case of functional cluster interaction and thus in the absence of PortPrototypes the string representation of a valid ara::core::InstanceSpecifier consists of a \"/\"-separated list of model element shortNames starting from a top-level ARPackage via contained sub-packages to the respective mapping element that is derived from FunctionalClusterInteractsWithFunctionalClusterMapping (see TPS_MANI_03268 for further details).*♩(RS_AP_00130)*

> 在功能集群交互的情况下，以及因缺少端口原型而存在的情况下，一个有效的ara :: core :: InstanceSpecifier的字符串表示形式由从顶级ARPackage开始的“/”分隔的模型元素shortNames列表组成，经过包含的子包到相应的映射元素，该映射元素来自FunctionalClusterInteractsWithFunctionalClusterMapping（有关更多详细信息，请参见TPS_MANI_03268）。♩（RS_AP_00130）


Thus, in case of functional cluster interaction the content of a valid ara::core::InstanceSpecifier adheres to the following pattern:

> 因此，在功能群集交互的情况下，有效的ara :: core :: InstanceSpecifier的内容遵循以下模式：


ARPackage.shortName/\.../ARPackage.shortName

> ARPackage.shortName/\.../ARPackage.shortName
简称ARPackage/\.../ARPackage简称


/FunctionalClusterInteractsWithFunctionalClusterMapping.shortName

> 功能集群与功能集群映射的简称


**[SWS_CORE_10201] Validation of meta-model paths** *[*The construction mechanisms of class ara::core::InstanceSpecifier shall reject meta-model paths that are syntactically invalid according to the syntax rules defined in [[SWS_CORE_10200](#_bookmark40)].*♩(RS_AP_00130)*

> **[SWS_CORE_10201] 元模型路径的验证** *[*ara::core::InstanceSpecifier的构造机制应拒绝根据[[SWS_CORE_10200](#_bookmark40)]中定义的语法规则语法上无效的元模型路径。*♩(RS_AP_00130)*


**[SWS_CORE_10202] Construction of InstanceSpecifier objects** *[*APIs for construction of ara::core::InstanceSpecifier objects shall be available in both potentially-throwing and non-throwing form.*♩(RS_AP_00130)*

> **[SWS_CORE_10202] 构建实例说明对象** *[*ara::core::InstanceSpecifier对象的构建API可以以可能抛出异常的形式和不抛出异常的形式提供。*♩(RS_AP_00130)*

### ScaleLinearAndTexttable


A ara::core::ScaleLinearAndTexttable type is a struct type that emulates an enumeration type with extended capabilities, such as those given in [9, the C++17 standard]

> 一个ara::core::ScaleLinearAndTexttable类型是一种结构类型，模拟具有扩展功能的枚举类型，例如[9，C++17标准]中提供的功能。


In particular, it can hold the values of the enumeration, but also any value of the underlying type of the Enumeration Data Type with which it was defined.

> 特别是，它可以保存枚举的值，也可以保存它被定义时的枚举数据类型的底层类型的任何值。

### Types derived from the base C++ standard


In addition to AUTOSAR-devised data types, which are mentioned in the previous sections, the Adaptive Platform also contains a number of generic data types and helper functions.

> 此外，除了在前面几节中提到的AUTOSAR设计的数据类型外，Adaptive Platform还包含许多通用数据类型和辅助函数。


Some types are already contained in [4, the C++14 standard]; however, types with almost identical behavior are re-defined within the ara::core namespace. The reason for this is that the memory allocation behavior of the std:: types is often unsuitable for automotive purposes. Thus, the ara::core ones define their own memory allocation behavior, and perform some other necessary adaptions as well, including about the throwing of exceptions.

> 一些类型已经包含在[4，C++14标准]中；然而，具有几乎相同行为的类型会在ara::core命名空间中重新定义。这是因为std::类型的内存分配行为通常不适用于汽车用途。因此，ara::core类型定义了自己的内存分配行为，并执行一些其他必要的调整，包括抛出异常。


**[SWS_CORE_00040]**{DRAFT} **Errors originating from C++ standard classes** *[*For the classes in ara::core specified below in terms of the corresponding classes of the C++ standard, all functions that are specified by [4, the C++14 standard], [9, the C++17 standard], or [10, the draft C++20 standard] to throw any exceptions, are instead specified to be the cause of a [Violation](#_bookmark7) when they do so.*♩(RS_AP_00130)*

> **[SWS_CORE_00040]**{草案} **C++标准类引发的错误** *[*对于ara::core中下列指定的类，按照[4，C++14标准]、[9，C++17标准]或[10，C++20草案标准]指定抛出任何异常的函数，在它们抛出异常时，被指定为引起[违规](#_bookmark7)。*♩(RS_AP_00130)*


Examples for such data types are: Array, Vector, Map, and String.

> 例如这些数据类型：数组、向量、映射和字符串。

### Array


This section describes the ara::core::Array type that represents a container which encapsulates fixed size arrays.

> 这一节介绍ara::core::Array类型，它代表一个封装固定大小数组的容器。


ara::core::Array is an almost-equivalent of std::array, and most type properties of std::array apply to ara::core::Array as well.

> ara::core::Array 是 std::array 的几乎等价物，大多数类型属性也适用于 ara::core::Array。


These differences to std::array are intended:

> 这些与std::array的差异是有意的：

- std::array::at has been omitted (in order to avoid mandatory exception handling)


**[SWS_CORE_11200] Array base behavior** *[*ara::core::Array and all its member functions and supporting constructs shall behave identical to those of std::array in header \<array\> from [4, the C++14 standard], except for the differences specified in this document.*♩(RS_AP_00130)*

> **[SWS_CORE_11200] 数组基本行为** *[ara::core::Array 及其所有成员函数和支持结构，应与[4，C++14标准]中的std :: array头文件\<array\>中的行为完全一致，除本文档中指定的差异外。*♩(RS_AP_00130)*

### Vector


This section describes the ara::core::Vector type that represents a container of variable size.

> 这一节介绍ara::core::Vector类型，它表示一个可变大小的容器。


**[SWS_CORE_11300]**{DRAFT} **Vector base behavior** *[*ara::core::Vector and all its member functions and supporting constructs shall behave identical to those of std::vector in header \<vector\> from [4, the C++14 standard], except for the differences specified in this document.*♩(RS_AP_00130)*

> **[SWS_CORE_11300]**{草案} **向量基本行为** *[*ara::core::Vector及其所有成员函数和支持构造，除本文档中指定的差异外，应与来自[4，C++14标准]的\<vector\>头文件中的std :: vector的行为完全一致。*♩(RS_AP_00130)*

### Map


This section describes the ara::core::Map type that represents an associative container of variable size.

> 这一部分描述了ara::core::Map类型，它表示一个可变大小的关联容器。


**[SWS_CORE_11400]**{DRAFT} **Map base behavior** *[*ara::core::Map and all its member functions and supporting constructs shall behave identical to those of std::map in header \<map\> from [4, the C++14 standard], except for the differences specified in this document.*♩(RS_AP_00130)*

> **[SWS_CORE_11400]**{草案} **映射基础行为** *[*ara::core::Map及其所有成员函数和支持结构必须与[4，C ++ 14标准]中的std :: map头文件\<map\>的行为完全一致，除了本文档中指定的差异。*♩(RS_AP_00130)*

### String and BasicString


This section describes the ara::core::String and ara::core::BasicString

> 这一节介绍了ara::core::String和ara::core::BasicString。

types.


**[SWS_CORE_12000]**{DRAFT} **String base behavior** *[*ara::core::String, ara::core::BasicString and all their member functions and supporting constructs shall behave identical to those of std::string and std::basic_string in header \<string\> from [4, the C++14 standard], except for the differences specified in this document.*♩(RS_AP_00130)*

> **[SWS_CORE_12000]**{草案} **字符串基本行为** *[*ara::core::String、ara::core::BasicString及其所有成员函数和支持结构[4，C++14标准]中的std::string和std::basic_string在头文件\<string\>中行为应完全一致，除了本文档中指定的差异。*♩(RS_AP_00130)*

### SteadyClock 7.2.4.2.5.1 Definitions of terms


The C++ std::chrono library defines a number of concepts and types for handling time and durations. One of these concepts is that of a "clock" which is able to create snapshots of specific "time points". When talking about clocks and time points, the

> C++ std::chrono 库定义了许多概念和类型来处理时间和持续时间。其中一个概念是“时钟”，它能够创建特定“时间点”的快照。当谈论时钟和时间点时，


three qualities *resolution*, *precision*, and *accuracy* are distinguished within this document as follows:

> 在本文中，将*决心*、*精确度*和*准确性*三个品质区分开来：


- The []{#_bookmark49 .anchor}resolution relates to the smallest increment that can be expressed with the clock's measurement data type.

> 解析度与时钟测量数据类型所表达的最小增量有关。


For clocks of the POSIX clock_gettime API, the [resolution](#_bookmark49) is implicitly defined as nanoseconds by the API's usage of struct timespec with its timespec::tv_nsec field.

> 对于POSIX clock_gettime API的时钟，API使用具有timespec::tv_nsec字段的struct timespec定义隐式将分辨率定义为纳秒。


For C++ clocks of the std::chrono APIs, the [resolution](#_bookmark49) is variable.

> 对于C++中std::chrono API的时钟，其[分辨率](#_bookmark49)是可变的。


- The []{#_bookmark50 .anchor}precision of a clock is the smallest time interval that its timer is able to measure. The [precision](#_bookmark50) is implementation-defined and depends on the properties and capabilities of the physical machine as well as the operating system.

> 精度是指时钟的最小时间间隔，它的计时器能够测量。精度是实现定义的，取决于物理机器和操作系统的属性和功能。

- The accuracy []{#_bookmark51 .anchor}of a clock is the relation between the reported value and the truth.

> 准确度是指时钟报告值与真实值之间的关系。


In addition to that, the epoch []{#_bookmark52 .anchor}is an important property of a clock as well, as it defines the base of the time range that can originate from a clock. Clocks that measure calendar time often use "Unix time", which is given as number of seconds (without leap seconds) since the "Unix Epoch", which is 1970-01-01, 00:00:00 UTC.

> 此外，时代也是时钟的一个重要属性，因为它定义了时钟可以产生的时间范围的基础。测量日历时间的时钟通常使用“Unix时间”，它以自“Unix时代”（即1970年1月1日00:00:00 UTC）以来的秒数（不含闰秒）给出。


Clocks that place more emphasis on high [precision](#_bookmark50) often do not relate to calendar time at all, but generate timestamps as offsets from something like the power-up time of the system.

> 那些更加重视精度的时钟通常与日历时间毫无关联，而是以系统启动时间等为基准，生成时间戳。

### Clocks in the Adaptive Platform


The C++ std::chrono library defines a number of standard clocks. Amongst these is std::chrono::steady_clock, which represents a monotonic clock whose time points are strictly increasing with a fixed interval.

> C++ std::chrono库定义了许多标准时钟。其中之一是std::chrono::steady_clock，它表示一个单调时钟，其时间点严格按照固定间隔增加。


However, the C++ standard does not place any requirements on the [resolution](#_bookmark49), [precision](#_bookmark50), and [accuracy](#_bookmark51) of this clock. The undefinedness of its [resolution](#_bookmark49) can pose some difficulties for application programmers, but these can usually be solved by agreeing on a common -or minimum -[resolution](#_bookmark49). The [precision](#_bookmark50) and [ac-](#_bookmark51) [curacy](#_bookmark51) are always dependent on the physical properties of the machine and of the operating system.

> 然而，C ++标准对此时钟的[分辨率](#_bookmark49)，[精度](#_bookmark50)和[准确性](#_bookmark51)没有任何要求。其[分辨率](#_bookmark49)的不确定性可能会给应用程序程序员带来一些困难，但通常可以通过同意一个共同的或最低的[分辨率](#_bookmark49)来解决这些问题。[精度](#_bookmark50)和[精确度](#_bookmark51)总是取决于机器和操作系统的物理特性。


The Adaptive Platform defines ara::core::SteadyClock as a std::chronocompatible clock with nanosecond [resolution](#_bookmark49) and a std::int64_t datatype. Its [precision](#_bookmark50) and [accuracy](#_bookmark51) are still implementation-defined and can be given as characteristic values of a concrete platform. Its [epoch](#_bookmark52) is the power-up time of the ECU. With these properties, timestamps generated by ara::core::SteadyClock will not overflow until 292 years after its [epoch](#_bookmark52).

> 平台自适应定义ara::core::SteadyClock作为一个具有纳秒[分辨率](#_bookmark49)和std::int64_t数据类型的std::chronocompatible时钟。它的[精度](#_bookmark50)和[准确性](#_bookmark51)仍然是实现定义的，可以作为具体平台的特征值给出。它的[纪元](#_bookmark52)是ECU的上电时间。有了这些属性，ara::core::SteadyClock生成的时间戳在它的[纪元](#_bookmark52)之后的292年内不会溢出。


It is the standard clock of the Adaptive Platform and should be used for most timekeeping purposes.

> 这是自适应平台的标准时钟，应该用于大多数计时目的。


The properties of ara::core::SteadyClock imply that a type alias to

> ara::core::SteadyClock的特性意味着可以将其类型别名为“简化的中文”。


std::chrono::steady_clock is a conforming implementation of ara::core::SteadyClock, if std::chrono::steady_clock::period is equivalent to std::nano, and std::chrono::steady_clock::rep is a 64-bit signed integer type such as std::int64_t.

> std::chrono::steady_clock是ara::core::SteadyClock的一个符合要求的实现，如果std::chrono::steady_clock::period与std::nano相等，并且std::chrono::steady_clock::rep是一种64位有符号整数类型，如std::int64_t。


**[SWS_CORE_11800] SteadyClock type requirements** *[*Class ara::core::SteadyClock shall meet the requirements of *TrivialClock* from [4, the C++14 standard].*♩(RS_AP_00130)*

> [SWS_CORE_11800] 要求稳定时钟类型：ara::core::SteadyClock 类必须符合C++14标准[4]中TrivialClock的要求。(RS_AP_00130)


**[SWS_CORE_11801] Epoch of SteadyClock** *[*The [epoch](#_bookmark52) of ara::core::SteadyClock shall be the system start-up.*♩(RS_AP_00130)*

> [SWS_CORE_11801] SteadyClock的历元：ara::core::SteadyClock的历元应为系统启动时间。

### Types derived from newer C++ standards


These types have been defined in or proposed for a newer C++ standard, and the Adaptive Platform includes them into the ara::core namespace, usually because they are necessary for certain constructs of the Manifest.

> 这些类型已经在新版本的C++标准中定义或提出，Adaptive Platform将它们包含在ara::core命名空间中，通常是因为它们对Manifest的某些构造是必需的。


Examples for such data types are: Optional, StringView, Span, and Variant.

> 例子包括：可选项、字符串视图、跨度和变量。

### Optional


This section describes the ara::core::Optional type.

> 这一节描述ara::core::Optional类型。


**[SWS_CORE_11000]**{DRAFT} **Optional base behavior** *[*ara::core::Optional and all its member functions and supporting constructs shall behave identical to those of std::optional in header \<optional\> from [9, the C++17 standard], except for the differences specified in this document.*♩(RS_AP_00130)*

> **[SWS_CORE_11000]**{草案} **可选基本行为** *[*ara::core::Optional及其所有成员函数和支持结构都应该与[9，C++17标准]中\<optional\>头文件中的std :: optional的行为完全一致，除了本文档中指定的差异之外。*♩（RS_AP_00130）*


Note: The value() function and the bad_optional_access exception defined in the C++ standard library are left out of this specification to provide an API that does not make use of exceptions. Use either has_value or operator bool() to check if the ara::core::Optional contains a value before accessing the value with e.g., operator\*. Alternatively, use the value_or functions to access the value and provide a default value in case the ara::core::Optional contains no value.

> 注意：为了提供不使用异常的API，本规范中没有包括C++标准库中定义的value（）函数和bad_optional_access异常。在使用比如operator*访问ara::core::Optional中的值之前，请使用has_value或operator bool（）检查ara::core::Optional是否包含值。或者，使用value_or函数访问值，并在ara::core::Optional不包含值的情况下提供默认值。


**[SWS_CORE_01030]**{DRAFT} **value member function overloads** *[*Contrary to the description in [9], no member functions with this name exist in ara::core::Optional.*♩(RS_AP_00130)*

> **[SWS_CORE_01030]**{草稿} **值成员函数重载** *[*与[9]中的描述相反，ara::core::Optional中不存在此名称的成员函数。♩(RS_AP_00130)*


**[SWS_CORE_01031]**{DRAFT} **class bad_optional_access** *[*No class named

> **[SWS_CORE_01031]**{草案}**类 bad_optional_access** *[*没有叫做


bad_optional_access is defined in the ara::core namespace.*♩(RS_AP_00130)*

> bad_optional_access定义在ara::core命名空间中。

### Variant


This section describes the ara::core::Variant type that represents a type-safe union.

> 这节描述ara::core::Variant类型，它表示一种安全的联合类型。


**[SWS_CORE_11600]**{DRAFT} **Variant base behavior** *[*ara::core::Variant and all its member functions and supporting constructs shall behave identical to those of std::variant in header \<variant\> from [9, the C++17 standard], except for the differences specified in this document.*♩(RS_AP_00130)*

> **[SWS_CORE_11600]**{草案} **变体基本行为** *[*ara::core::Variant及其所有成员函数和支持构造应与[9，C++17标准]中的std::variant头文件\<variant\>中的行为完全一致，除本文档中指定的差异外。*♩(RS_AP_00130)*

### StringView


This section describes the ara::core::StringView type that represents a readonly view over a contiguous sequence of characters whose storage is owned by another object.

> 这一节描述了ara::core::StringView类型，它表示一个只读的视图，可以查看另一个对象拥有的连续字符序列。


**[SWS_CORE_12200]**{DRAFT} **StringView base behavior** *[*ara::core::StringView and all its member functions and supporting constructs shall behave identical to those of std::string_view in header \<string_view\> from [9, the C++17 standard], except for the differences specified in this document.*♩(RS_AP\_00130)*

> **[SWS_CORE_12200]**{草案} **StringView 基础行为** *[*ara::core::StringView 及其所有成员函数和支持结构，除本文指定的差异外，应与[9，C++17标准]中的std::string_view头文件中的行为完全相同。*♩(RS_AP\_00130)*

### Span


ara::core::Span is a type that represents an abstraction over a linear sequence of values of a certain type. It is closely modeled on std::span from C++20, with deviations mostly coming from the lack of C++20's "ranges" feature.

> ara::core::Span 是一种表示特定类型线性序列抽象的类型。它严格模仿C++20中的std::span，主要的差异在于缺少C++20的“范围”功能。


**[SWS_CORE_11900]**{DRAFT} **Span base behavior** *[*ara::core::Span and all its member functions and supporting constructs shall behave identical to those of std::span in header \<span\> from [10, the draft C++20 standard], except for the differences specified in this document.*♩(RS_AP_00130)*

> **[SWS_CORE_11900]**{草案} **跨度基本行为** *[*ara::core::Span 及其所有成员函数和支持构造，除了本文指定的差异外，应与 [10，草案C++20标准] 中的 std::span 头文件 \<span\> 中的行为完全一致。♩(RS_AP_00130)*

### ara::core::Byte


ara::core::Byte is a type that is able to hold a "byte" of the machine. It is an own type distinct from any other type.

> ara::core::Byte是一种能够容纳机器“字节”的类型。它是一种独特的类型，与其他类型不同。


The definitions of this section have been carefully set up in a way to make std::byte from [9, the C++17 standard] a conforming implementation, but also allow a classbased implementation with only C++14 means.

> 此节的定义已经精心设置，以便使[9，C++17标准]的std :: byte成为符合实现，但也允许仅使用C++14手段的基于类的实现。


Unlike std::byte from [9, the C++17 standard], it is implementation-defined whether ara::core::Byte can be used for type aliasing without triggering Undefined Behavior.

> 不同于C++17标准中的std::byte[9]，ara::core::Byte 是否可以用于类型别名而不会引发未定义行为，取决于实现。


**[SWS_CORE_10100] Type property of ara::core::Byte** *[*The type ara::core::Byte shall not be an integral type. In particular, the value

> **[SWS_CORE_10100] ara::core::Byte的类型** *[*ara::core::Byte的类型不应为整数类型。特别地，该值


std::is_integral\<ara::core::Byte\>::value shall be 0.*♩(RS_AP_00130)*

> std::is_integral<ara::core::Byte>::value 应该是 0.♩(RS_AP_00130)


**[SWS_CORE_10101] Size of type ara::core::Byte** *[*The size (in bytes) of an instance of type ara::core::Byte (determined with sizeof(ara::core::Byte)) shall be

> [SWS_CORE_10101] ara::core::Byte 的大小（以字节为单位，使用 sizeof(ara::core::Byte) 确定）应为

1.*♩(RS_AP_00130)*


[]{#_bookmark60 .anchor}**[SWS_CORE_10102] Value range of type ara::core::Byte** *[*The value of an instance of type ara::core::Byte shall be constrained to the range [0..std::numeric_limits\<unsigned char\>::max()].*♩(RS_AP_00130)*

> 实例类型ara::core::Byte的值应限制在[0..std::numeric_limits<unsigned char>::max()]范围内。


**[SWS_CORE_10103] Creation of ara::core::Byte instances** *[*An instance of type ara::core::Byte shall be creatable from an integral type with brace-initialization syntax. This initialization shall also be possible when called in a constant expression. If the initializer value is outside the value range of type ara::core::Byte (see [[SWS_CORE_10102](#_bookmark60)]), the behavior is undefined.*♩(RS_AP_00130)*

> **[SWS_CORE_10103] 创建ara::core::Byte实例** *[*可以使用花括号初始化语法从整数类型创建ara::core::Byte类型的实例。当在常量表达式中调用时也可以进行初始化。如果初始化值超出ara::core::Byte类型的值范围（参见[[SWS_CORE_10102](#_bookmark60)]），行为是未定义的。*♩(RS_AP_00130)*


**[SWS_CORE_10104] Default-constructed ara::core::Byte instances** *[*An instance of type ara::core::Byte shall be constructible without giving an initializer value. Such a variable definition shall incur no runtime cost, and the value of the instance shall have indeterminate content.*♩(RS_AP_00130)*

> **[SWS_CORE_10104]默认构造ara :: core :: Byte实例** *[*可以构造ara :: core :: Byte类型的实例，而不必提供初始值。这样的变量定义不会产生运行时成本，实例的值具有不确定的内容。*♩(RS_AP_00130)*


**[SWS_CORE_10105] Destructor of type ara::core::Byte** *[*The destructor of type

> **[SWS_CORE_10105] ara::core::Byte 类型的析构函数**


ara::core::Byte shall be trivial.*♩(RS_AP_00130)*

> ara::core::Byte应该是简单的。♩(RS_AP_00130)


**[SWS_CORE_10106] Implicit conversion from other types** *[*The type ara::core::Byte shall not be implicitly convertible from any other type.*♩(RS_AP_00130)*

> [SWS_CORE_10106] 隐式从其他类型转换
ara::core::Byte 类型不得从任何其他类型隐式转换。


**[SWS_CORE_10107] Implicit conversion to other types** *[*The type ara::core::Byte shall allow no implicit conversion to any other type, including bool.*♩(RS_AP\_00130)*

> **[SWS_CORE_10107] 隐式转换到其他类型** *[*ara::core::Byte类型不允许隐式转换到任何其他类型，包括bool类型。*♩(RS_AP\_00130)*


**[SWS_CORE_10108] Conversion to unsigned char** *[*The type ara::core::Byte shall allow conversion to unsigned char with a static_cast\<\> expression. This conversion shall also be possible when called in a constant expression.*♩(RS_AP\_00130)*

> **[SWS_CORE_10108] 转换为无符号字符** *[*ara::core::Byte 类型应允许使用 static_cast\<\> 表达式进行无符号字符的转换。当在常量表达式中调用时，也应该可以执行此转换。*♩(RS_AP_00130)*


**[SWS_CORE_10109] Equality comparison for ara::core::Byte** *[*The type ara::core::Byte shall be comparable for equality with other instances of type ara::core::Byte. This comparison shall also be possible when called in a constant expression.*♩(RS_AP_00130)*

> **[SWS_CORE_10109] 类型ara :: core :: Byte的相等比较** *[*ara :: core :: Byte的类型应可与其他ara :: core :: Byte类型的实例进行比较。当在常量表达式中调用时，也应可进行此比较。*♩（RS_AP_00130）*


**[SWS_CORE_10110] Non-equality comparison for ara::core::Byte** *[*The type ara::core::Byte shall be comparable for non-equality with other instances of type ara::core::Byte. This comparison shall also be possible when called in a constant expression.*♩(RS_AP_00130)*

> [SWS_CORE_10110] ara::core::Byte的非等式比较
[*对于ara::core::Byte类型，应该可以与其他ara::core::Byte类型的实例进行非等式比较。即使在常量表达式中也可以进行这种比较。*♩(RS_AP_00130)*]

[SWS_CORE_10110] ara::core::Byte的非等比较
[*对于ara::core::Byte类型，可以与其他ara::core::Byte类型的实例进行非等比较。即使在常量表达式中也可以进行这种比较。*♩(RS_AP_00130)*]

### Initialization and Shutdown


This section describes the global initialization and shutdown of the ARA framework. Before the framework is initialized, and after the it is deinitialized, not all ARA functionality may be available.

> 此部分描述ARA框架的全局初始化和关闭。在框架初始化之前和初始化之后，ARA的功能可能不全。


While it is usually possible for a framework implementation to initialize all parts of the framework in an "initialize on first use" fashion, this might not always be desirable, as it introduces potentially noticeable delays during runtime.

> 通常，框架实现可以以“首次使用时初始化”的方式初始化框架的所有部分，但这可能不总是可取的，因为它会在运行时引入可能引起注意的延迟。


For this reason, there exist initialization and shutdown functions that may be used by the framework vendor to initialize/shutdown the framework to an extent that no lazy initialization during runtime is necessary.

> 为此，存在可由框架供应商使用的初始化和关闭功能，可以将框架初始化/关闭到无需在运行时进行延迟初始化的程度。


On the other hand, another framework implementation might well have empty implementations of these functions, e.g. if this framework chooses to fully adopt the "initialize on first use" idiom.

> 另一方面，另一个框架的实现可能会有这些函数的空实现，例如如果这个框架选择完全采用“首次使用时初始化”习惯。


**[SWS_CORE_15003]**{DRAFT} **Startup and initialization of ARA** *[*The ara::core::Initialize function shall initiate the start-up of the ARA framework, which might include (but is not limited to):

> **[SWS_CORE_15003]**{草案} **ARA的启动和初始化** *[*ara::core::Initialize函数应该启动ARA框架，可能包括（但不限于）：

- initialization of ARA framework specific data structures
- initialization of system resources
- spawning of background threads

*♩(RS_Main_00011)*


**[SWS_CORE_15004]**{DRAFT} **Shutdown and de-initialization of ARA** *[*The ara::core::Deinitialize function shall initiate the shutdown of the ARA framework, which might include (but is not limited to):

> **[SWS_CORE_15004]**{草稿} **ARA的关闭和反初始化** *[*ara::core::Deinitialize函数应该启动ARA框架的关闭，其中可能包括（但不限于）：

- orderly shutdown of spawned background threads
- deallocation of dynamically allocated memory
- deallocation of other system resources

*♩(RS_Main_00011)*


An error returned by ara::core::Deinitialize is the only way for the ARA to report an error that is guaranteed to be available, e.g. in case ara::log has already been deinitialized. The user is not expected to be able to recover from such an error. However, the user may have a project-specific way of recording errors during deinitialization without ara::log. A typical error case to be reported here is that the user is still holding some resource from the ARA.

> 一个由ara :: core :: Deinitialize返回的错误是ARA报告一个保证可用的错误的唯一方式，例如，如果ara :: log已经被反初始化。用户不期望能够从这样的错误中恢复。但是，用户可能有一个特定项目的方式在反初始化时记录错误而不使用ara :: log。这里要报告的典型错误情况是用户仍然保持ARA的一些资源。


Calling ara::core::Deinitialize while ARA APIs are still being called concurrently results in undefined behavior of the application and the framework.

> 调用ara::core::Deinitialize时，若ARA API仍在并发调用，将导致应用程序和框架的未定义行为。


For a proper shutdown, it is also expected that ara::core::Deinitialize is called before the statically initialized data is destructed.

> 为了正确关机，预计应在静态初始化数据被析构之前调用ara::core::Deinitialize。

### [SWS_CORE_15001] {DRAFT} Handling of interaction with the ARA of an un-


**/deinitialized runtime** *[*A call to any ARA API (other than the ones mentioned in [[SWS_CORE_15002](#_bookmark62)]) without prior call to ara::core::Initialize shall be treated by the Functional Cluster implementation as a [Violation](#_bookmark7).*♩(RS_AP_00142)*

> 对于任何除[[SWS_CORE_15002](#_bookmark62)中提及的ARA API之外的ARA API的调用，如果没有先进行ara::core::Initialize调用，功能集群实现将将其视为[违规](#_bookmark7)。♩(RS_AP_00142)


The rationale to treat this as a [Violation](#_bookmark7) is that such occurrences cannot be handled by the caller of the API at the point in time where the error is detected. Aborting execution is the only way to signal this kind of systematic error and prevent later failures.

> 理由将此视为[违规](＃_bookmark7)是，此类情况无法在检测到错误时由API调用者处理。中止执行是唯一方式来发出这种系统性错误的信号，以防止后续故障。


[]{#_bookmark62 .anchor}**[SWS_CORE_15002]**{DRAFT} **Special ara::core types to be used without initialization** *[*A small subset of ara::core types and functions shall be usable independently of initialization with ara::core::Initialize. These are:

> **[SWS_CORE_15002]{DRAFT}**特殊的ara::core类型可以不经过初始化就使用*[*一小组ara::core类型和函数可以不通过ara::core::Initialize进行初始化就能使用。它们是：


- ara::core::ErrorCode and all its member functions and supporting constructs (including non-member operators)

> - ara::core::ErrorCode及其所有成员函数和支持结构（包括非成员运算符）

- ara::core::StringView and all its member functions and supporting constructs (including non-member operators)

> ara::core::StringView及其所有成员函数和支持结构（包括非成员操作符）

- ara::core::Result and all its member functions and supporting constructs, except for ara::core::Result::ValueOrThrow

> ara::core::Result及其所有成员函数和支持的结构，除了ara::core::Result::ValueOrThrow

- ara::core::ErrorDomain and all its member functions and its subclasses, as long as they adhere to [[SWS_CORE_10400](#_bookmark15)], but excluding \<Prefix\>ErrorDomain::ThrowAsException.

> - ara::core::ErrorDomain及其所有成员函数和子类，只要它们遵守[[SWS_CORE_10400](#_bookmark15)]，但不包括\<Prefix\>ErrorDomain::ThrowAsException。

*♩(RS_AP_00142)*


The rationale for the exception for this subset is the intended use before initialization and that these types are used as part of the initialization (ara::core::Result, ara::core::ErrorCode, ara::core::ErrorDomain).

> 例外的理由是这个子集在初始化之前的预期使用，而且这些类型被用作初始化的一部分（ara::core::Result，ara::core::ErrorCode，ara::core::ErrorDomain）。

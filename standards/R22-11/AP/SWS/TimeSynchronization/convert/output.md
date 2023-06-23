---
tip: translate by openai@2023-06-23 17:09:11
...
# Contents

```
1. [Introduction and functional overview](#introduction-and-functional-overview) 7
2. Acronyms and Abbreviations 8

   1. Acronyms and Abbreviations . . . . . . . . . . . . . . . . . . . . . . . . 8
   2. Definitions . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 9

      1. ara::core::SteadyClock . . . . . . . . . . . . . . . . . . . . . 9
      2. Time Base Application . . . . . . . . . . . . . . . . . . . . . . 9
3. [Related documentation](#related-documentation) 10

   1. [Input documents & related standards and norms](#input-documents-related-standards-and-norms) 10
   2. [Further applicable specification](#further-applicable-specification) 10
4. [Constraints and assumptions](#constraints-and-assumptions) 11

   1. [Known limitations](#known-limitations) 11

      1. [Configuration](#configuration) 11
      2. [Time Gateway](#time-gateway) 11
      3. [Out of Scope](#out-of-scope) 11
      4. [Security](#security) 11
   2. [Applicability to car domains](#applicability-to-car-domains) 11
   3. [Recommendation](#recommendation) 12
5. [Dependencies to other Functional Clusters](#dependencies-to-other-functional-clusters) 13
6. Requirements Tracing 14
7. [Functional specification](#functional-specification) 17

   1. [General Overview of TS](#general-overview-of-ts) 17

      1. [Base functionality of every Time Base](#base-functionality-of-every-time-base) 18

         1. [Time Base Status](#time-base-status) 18
         2. [Rate Deviation](#rate-deviation) 18
         3. [Clock Time Value](#clock-time-value) 18
      2. [Status Flags of TBRs](#status-flags-of-tbrs) 19
      3. [Time Synchronization and Protocols](#time-synchronization-and-protocols) 19
   2. [Functional cluster life cycle](#functional-cluster-life-cycle) 19

      1. [Startup](#startup) 19

         1. [Default values](#default-values) 20
      2. [Shutdown](#shutdown) 20
   3. [Normal Operation](#normal-operation) 21

      1. [Introduction](#introduction) 21

         1. [Time Base Manifestations](#time-base-manifestations) 22
      2. [Roles of the Time Base Resources](#roles-of-the-time-base-resources) 22

         1. [Global Time Master](#global-time-master) 22
         2. [Time Slave](#time-slave) 22
      3. [Time Base Resources](#time-base-resources) 22

         1. [Slave Time Bases](#slave-time-bases) 22
      4. [Immediate Time Synchronization](#immediate-time-synchronization) 23
      5. [User Data](#user-data) 23
      6. [Time Correction](#time-correction) 24

         1. [Rate Correction for Time Slaves](#rate-correction-for-time-slaves) 24
         2. [Offset Correction for Time Consumer](#offset-correction-for-time-consumer) 26
         3. [Rate Correction for Global Time Masters](#rate-correction-for-global-time-masters) 27
      7. [Notifications of Time Base Consumer](#notifications-of-time-base-consumer) 28

         1. [Status flags notification](#status-flags-notification) 28
         2. [Synchronization status notification](#synchronization-status-notification) 28
         3. [LeapJump notification](#leapjump-notification) 28
      8. [Global Time Precision Measurement Support](#global-time-precision-measurement-support) 28
      9. [Global Time Validation Measurement Support](#global-time-validation-measurement-support) 29
8. API specification 32

   1. API Common Data Types 32

      1. Timestamp 32
      2. TimeBase struct 32

         1. rep 32
         2. period 33
         3. duration 33
         4. time_point 34
         5. is_steady 34
      3. LeapJump 34
      4. SynchronizationStatus 35
   2. Common Function Definition of Time Bases Provider 35

      1. SynchronizedTimeBaseProvider 35

         1. Special member functions 35
         2. SetTime 37
         3. UpdateTime 38
         4. GetCurrentTime 38
         5. SetRateCorrection 39
         6. GetRateCorrection 39
         7. SetUserData 39
         8. GetUserData 40
         9. RegisterTimeValidationNotification 40
         10. UnregisterTimeValidationNotification 41
      2. OffsetTimeBaseProvider 41

         1. Special member functions 41
         2. SetOffsetTime 43
         3. GetCurrentTime 43
         4. SetRateCorrection 44
         5. GetRateCorrection 44
         6. SetUserData 44
         7. GetUserData 45
         8. RegisterTimeValidationNotification 45
         9. UnregisterTimeValidationNotification 46
   3. Common Function Definition of Time Bases Consumer 46

      1. SynchronizedTimeBaseConsumer 46

         1. Special member functions 46
         2. GetCurrentTime 48
         3. GetRateDeviation 49
         4. GetTimeWithStatus 49
         5. RegisterStatusChangeNotifier 49
         6. UnregisterStatusChangeNotifier 50
         7. RegisterSynchronizationStateChangeNotifier 50
         8. UnregisterSynchronizationStateChangeNotifier 51
         9. RegisterTimeLeapNotifier 51
         10. UnregisterTimeLeapNotifier 52
         11. RegisterTimeValidationNotification 52
         12. UnregisterTimeValidationNotification 52
         13. RegisterTimePrecisionMeasurementNotifier 53
         14. UnregisterTimePrecisionMeasurementNotifier 53
      2. SynchronizedTimeBaseStatus 54

         1. Special member functions 54
         2. GetCreationTime 56
         3. GetSynchronizationStatus 56
         4. GetLeapJump 56
         5. GetUserData 57
   4. C++ Time Validation Interface 57

      1. Type definitions 57

         1. TimeMasterMeasurementType 57
         2. TimeSlaveMeasurementType 58
         3. PdelayInitiatorMeasurementType 60
         4. PdelayResponderMeasurementType 63
      2. Provider TimeBase Validation Notification 64

         1. SetPdelayResponderData 65
         2. SetMasterTimingData 65
      3. Consumer TimeBase Provider Notification 65

         1. SetPdelayInitiatorData 66
         2. SetSlaveTimingData 66
   5. C++ Time Precision Interface 66

      1. Type definitions 66

         1. TimePrecisionMeasurement type 66

A.  Mentioned Class Tables 70
B.  [Interfaces to other Functional Clusters (informative)](#interfaces-to-other-functional-clusters-informative) 74
1.  [Overview](#overview) 74
2.  [Interface Tables](#_bookmark59) 74
```

# 1 Introduction and functional overview


Time Synchronization between different applications and/or ECUs is of paramount im- portance when correlation of different events across a distributed system is needed, either to be able to track such events in time or to trigger them at an accurate point in time.

> 时间同步在不同的应用程序和/或ECU之间至关重要，因为需要在分布式系统中对不同事件进行关联，要么是为了能够按时跟踪这些事件，要么是为了在准确的时间点触发它们。


For this reason, a Time Synchronization API is offered to the Application, so it can retrieve the time information synchronized with other entities / ECUs.

> 为此，提供时间同步API给应用程序，以便它可以获取与其他实体/ECU同步的时间信息。


For the format, message sequences and semantics of the time synchronization pro- tocols to use, please refer to the Protocol Requirements Specicification (PRS) of the AUTOSAR Time synchronization Protocol (see \[[1](#_bookmark3)\]).

> 就时间同步协议的格式、消息序列和语义而言，请参考AUTOSAR时间同步协议的协议要求规范（见[1]）。


The Time Synchronization functionality is then offered by means of different \"Time Base Resources\" (from now on referred to as TBR).

> 功能时间同步通过不同的“时间基础资源”（以下简称TBR）提供。


These TBRs are classified in different types. These types have an equivalent design to the types of the time bases offered in the Synchronized Time Base Manager speci- fication \[[2](#_bookmark4)\] (from now on referred to as StbM). The classification is the following:

> 这些TBRs被分类为不同类型。这些类型与Synchronized Time Base Manager规范中提供的时基类型具有相同的设计（从现在开始称为StbM）。分类如下：

- Synchronized Master Time Base
- Offset Master Time Base
- Synchronized Slave Time Base
- Offset Slave Time Base


As in StbM, the TBRs offered by the Time Synchronization module (TS from now on), are also synchronized with other Time Bases on other nodes of a distributed system.

> 正如在StbM中，由时间同步模块（以下简称TS）提供的TBR也与分布式系统中其他节点上的其他时间基准同步。


The Application consumes the time information provided and managed by the TBRs. Therefore, the TBRs serve as Time Base brokers, offering access to Synchronized Time Bases. By doing so, the TS module abstracts from the \"real\" Time Base provider.

> 应用程序消耗由TBRs提供和管理的时间信息。因此，TBRs作为时间基础经纪商，提供对同步时间基础的访问。通过这样做，TS模块从“真实”时间基础提供商中抽象出来。


3. # Related documentation

> # 相关文档


   1. ## Input documents & related standards and norms

> ## 输入文件及相关标准和规范

```{=html}
<!-- -->
```


1. []{#_bookmark3 .anchor}Time Synchronization Protocol Specification []{#_bookmark4 .anchor}AUTOSAR_PRS_TimeSyncProtocol

> 1. [时间同步协议规范]{#_bookmark3 .anchor}AUTOSAR_PRS_TimeSyncProtocol{#_bookmark4 .anchor}

2. Specification of Synchronized Time-Base Manager AUTOSAR_SWS_SynchronizedTimeBaseManager

> 2. AUTOSAR_SWS_SynchronizedTimeBaseManager 的同步时基管理器规范

3. Glossary AUTOSAR_TR_Glossary

> 3. AUTOSAR 名词表

4. Requirements on Time Synchronization []{#_bookmark5 .anchor}AUTOSAR_RS_TimeSync

> 要求时间同步[ ]（＃_bookmark5.anchor）AUTOSAR_RS_TimeSync

5. General Requirements specific to Adaptive Platform []{#_bookmark6 .anchor}AUTOSAR_RS_General

> 5. 适用于Adaptive Platform的通用要求[]{#_bookmark6 .anchor}AUTOSAR_RS_General

6. Specification of Adaptive Platform Core []{#_bookmark7 .anchor}AUTOSAR_SWS_AdaptivePlatformCore

> 6. 自适应平台核心规范AUTOSAR_SWS_AdaptivePlatformCore

7. List of Adaptive Platform Functional Clusters []{#_bookmark8 .anchor}AUTOSAR_TR_FunctionalClusterShortnames

> 7. AUTOSAR功能群簇短名称列表[]{#_bookmark8 .anchor}

8. ISO/IEC 14882:2011, Information technology -- Programming languages -- C++ []{#_bookmark9 .anchor}[http://www.iso.org](http://www.iso.org/)

> 信息技术——编程语言——C++（ISO/IEC 14882:2011）[http://www.iso.org](http://www.iso.org/)

9. Standard for Information Technology--Portable Operating System Interface (POSIX(R)) Base Specifications, Issue 7 []{#_bookmark10 .anchor}[http://pubs.opengroup.org/onlinepubs/9699919799/](http://pubs.opengroup.org/onlinepubs/9699919799/)

> 九、信息技术标准——可移植操作系统接口（POSIX(R)）基本规范，第7版[](#_bookmark10 .anchor)[http://pubs.opengroup.org/onlinepubs/9699919799/](http://pubs.opengroup.org/onlinepubs/9699919799/)

10. Specification of Time Synchronization over Ethernet []{#_bookmark11 .anchor}AUTOSAR_SWS_TimeSyncOverEthernet

> 10. 以太网时间同步规范（AUTOSAR_SWS_TimeSyncOverEthernet）

11. Specification of Manifest AUTOSAR_TPS_ManifestSpecification

> 11. AUTOSAR_TPS 清单规范规格


NOTE: \[[5](#_bookmark5), RS-RSGeneral\] is listed here as an input document because it applies to SWS TimeSync as well as to all SWS documents of the Adaptive Platform. Since it includes only non-functional requirements the tracing is not necessary.

> 注意：\[[5](#_bookmark5)，RS-RSGeneral\]被列在这里作为输入文档，因为它适用于SWS TimeSync以及所有SWS文档的Adaptive Platform。由于它只包含非功能性需求，因此不需要跟踪。

## Further applicable specification


AUTOSAR provides a core specification \[[6](#_bookmark6), SWS AdaptiveCore\] which is also appli- cable for Time Synchronization. The chapter \"General requirements for all Func- tional Clusters\" of this specification shall be considered as an additional and required specification for implementation of Time Synchronization.

> AUTOSAR提供了一个核心规范[[6](#_bookmark6), SWS AdaptiveCore]，也适用于时间同步。本规范的“所有功能簇的一般要求”章节应被视为实现时间同步的额外和必要的规范。


4. # Constraints and assumptions

> 4. # 约束和假设


   1. ## Known limitations

> ## 已知限制


The Time Synchronization module is bound to Adaptive Platform Systems.

> 時間同步模組與適應平台系統綁定。

### Configuration


Please refer to the corresponding model elements.

> 请参考相应的模型元素。

### Time Gateway


Time Gateway functionality is currently not in scope of the Time Synchronization mod- ule for the Adaptive Platform.

> 功能时间网关目前不在Adaptive Platform的时间同步模块的范围之内。

### Out of Scope


Errors, which occurred during Global Time establishment and which are not caused by the module itself (i.e. loss of PTP global time is not an issue of the TS but of the TSP modules) are out of the scope of this module.

> 错误，发生在全球时间建立期间，而不是由模块本身引起的（即PTP全球时间的丢失不是TS的问题，而是TSP模块的问题），不在本模块的范围之内。

### Security


Secured Time Synchronization using the AUTOSAR Sub-TLV: Time Authenticated (see PRS-TimeSync \[[1](#_bookmark3)\]) is currently not supported for the Adaptive Platform.

> 安全时间同步使用AUTOSAR Sub-TLV：时间认证（参见PRS-TimeSync [[1]]）目前不支持自适应平台。


**Note:** Secured Time Synchronization messages received in AP ECUs works with- out verifying the security measures (i.e., AUTOSAR Sub-TLV:Time Authenticated is ignored).

> **注意：**AP ECU接收的安全时间同步消息不需要验证安全措施（即忽略AUTOSAR子TLV：时间认证）。

## Applicability to car domains


The concept is targeted at supporting time-critical automotive applications. This does not mean that the concept has all that is required by such systems though, but crucial timing-related features which cannot be deferred to implementation are considered.

> 概念旨在支持时间关键的汽车应用。但这并不意味着该概念拥有这些系统所需的所有功能，而是考虑了不能延迟到实施的关键时序相关功能。

## Recommendation


In the case where the TSP is based on Ethernet, the protocol to be used is defined in the PRS (see \[[1](#_bookmark3)\]).

> 在基于以太网的TSP的情况下，要使用的协议由PRS定义（参见[[1]](#_bookmark3)）。

\...

# Dependencies to other Functional Clusters


TS is part of the ara::tsync \[[7](#_bookmark7)\] namespace.

> TS是ara::tsync命名空间的一部分[[7]](#_bookmark7)。

# Functional specification


The functional behavior is described under the following specific contexts:

> 功能行为在以下特定上下文中被描述：

- Startup Behavior
- Shutdown Behavior
- Construction Behavior (Initialization)
- Normal Operation
- Error Handling
- Error Classification
- Version Check


  1. ## General Overview of TS

> ## TS 的概览


For the Adaptive Platform, three different technologies were considered to fulfill such Time Synchronization requirements. These technologies were:

> 对于自适应平台，考虑了三种不同的技术来满足时间同步要求。这些技术是：

- StbM of the Classic Platform
- Library chrono - either std::chrono (C++11) or boost::chrono \[[8](#_bookmark8)\]
- The Time posix interface \[[9](#_bookmark9)\]


The following table shows the interfaces provided to the Application by means of this API and their equivalent interface in StbM.

> 以下表格展示了该API向应用程序提供的接口及其在StbM中的等效接口。

*[q]{.smallcaps}*

*Δ*

---


updateCounter (attribute of the TimeBase Status class)   StbM_GetTimeBaseUpdateCounter

> 更新计数器（TimeBase Status类的属性）StbM_GetTimeBaseUpdateCounter

---


This information is accessible via the Status flags      StbM_GetMasterConfig

> 这些信息可以通过状态标志StbM_GetMasterConfig获得。

---


**Table 7.1: Interface comparison between TS and STBM**

> 表7.1：TS和STBM之间的接口比较

### Base functionality of every Time Base


Every Time Base has to provide a minimum set of functionality, as listed below:

> 每次基础设施必须提供一组最低功能，如下所列：

- offer possibility to obtain the current timestamp
- creating a snapshot of its parameters


This chapter briefly describes these functionalities. Details on how to use and the exact behavior of these core methods are given in chapter 8.

> 本章简要描述了这些功能。有关如何使用以及这些核心方法的确切行为的详细信息，请参阅第8章。

### Time Base Status


This TimeBaseStatus is a snapshot of all the information of a Time Base Resource it is related to, like status flags, amount of times the TBR has been updated, time leap information (possibly generated during the last synchronization of the Time Base Resource), etc.

> 这个TimeBaseStatus是所有与之相关的时间基础资源信息的快照，如状态标志、TBR更新的次数、上次同步时可能产生的时间跳变信息等。

### Rate Deviation


Applications will have different thresholds for acceptable time drift values. Hence there needs to be a way, how applications can access this information.

> 应用程序将有不同的可接受的时间漂移值的阈值。因此需要有一种方式，应用程序可以访问这些信息。


**\[SWS_TS_00202\]** *\[*ara::tsync::SynchronizedTimeBaseConsumer::Ge- tRateDeviation shall return the calculated rate deviation of its TBR against the time source it is synchronized to. In case there is no rate deviation calculated yet, the initial rate deviation of 1 shall be returned.*♩(RS_TS_00018)*

> **[SWS_TS_00202]** *[*ara::tsync::SynchronizedTimeBaseConsumer::GetRateDeviation应返回其TBR与其同步的时间源之间的计算出的速率偏差。 如果尚未计算出速率偏差，则应返回初始速率偏差1。*♩(RS_TS_00018)*


**Note:** For more information of how rate deviation is calculated see: [7.3.6](#time-correction) Time Correc- tion.

> **注意：**要了解更多有关如何计算速率偏差的信息，请参见：[7.3.6](#time-correction) 时间校正。

### Clock Time Value


Reading the clock's time value is very likely the most commonly performed operation by the applications interacting with TS.

> 读取时钟的时间值可能是与TS交互的应用程序中最常见的操作。


To ensure type safe handling of time values, the timepoint is provided as std::chrono structure.

> 为了确保对时间值的安全处理，timepoint提供了std::chrono结构。


More detailed information on how this is implemented is given in the further chapters and in chapter 8.

> 更多关于实施方法的详细信息可以在后面的章节和第八章中找到。

### Status Flags of TBRs


Time Synchronization defines a set of status flags that are used to express specific status conditions of a TBR. Status flags can be queried by an application through a ara::tsync::SynchronizedTimeBaseConsumer::GetTimeWithStatus.

> 时间同步定义了一组状态标志，用于表达TBR的特定状态条件。应用程序可以通过ara :: tsync :: SynchronizedTimeBaseConsumer :: GetTimeWithStatus查询状态标志。


Synchronization status GetSynchronizationStatus includes:

> 同步状态GetSynchronizationStatus包括：


- kNotSynchronizedUntilStartup: Indicates whether a synchronization of a time base to its corresponding TBR happend until start-up (initial state)

> 指示在启动（初始状态）之前是否发生了时间基准与其相应的TBR同步的情况。

- kTimeOut: Indicates whether a synchronization of a time base to its correspond- ing TBR is lost or delayed.

> - kTimeOut：表明时间基准是否与其对应的TBR同步丢失或延迟。

- kSynchronized: Indicates if the time base of the corresponding TBR has been successfully synchronized at least once against its time source.

> - kSynchronized：表明相应的TBR是否曾经成功地与其时间源同步过至少一次。

- kSynchToGateway: Indicates if the corresponding TBR updates are based on a Time Gateway below the Global Time Master.

> - kSynchToGateway：指示相应的TBR更新是否基于低于全局时间主机的时间网关。


The status if a leap jump happend since the last status request through a GetTime- WithStatus could be retrieved via GetLeapJump:

> 上一次状态请求后发生跳跃的状态可以通过GetLeapJump通过GetTime- WithStatus检索。

- kTimeLeapNone: Indicates that no leap jump happend
- kTimeLeapFuture: Indicates if there has been a jump in time to the future.
- kTimeLeapPast: Indicates if there has been a jump in time to the past.


  1. ### Time Synchronization and Protocols

> ### 时间同步和协议


Time Synchronization mechanisms and protocols (i.e. \[[10](#_bookmark10)\] are out of the Scope of this document, for protocol specification please refer to the PRS (see \[[1](#_bookmark3)\]).

> 时间同步机制和协议（即\[[10](#_bookmark10)\]）不在本文档的范围之内，关于协议规范，请参考PRS（参见\[[1](#_bookmark3)\]）。


1. ## Functional cluster life cycle

> 功能集群生命周期

   1. ### Startup


This chapter describes the necessary initializations, which are performed by the entity that has control over the Time Base Resources, in order to prepare the TS module for

> 本章节描述了控制时间基础资源的实体所执行的必要初始化，以准备TS模块。


normal operation. After its initialization, the module is expected to provide all synchro- nized time services to the applications.

> 正常操作。初始化后，该模块有望为应用提供所有同步时间服务。


**\[SWS_TS_00213\]**{DRAFT} *\[*For each TBR configured as Time Master for which storage to persistent memory is activated, i.e. a 'TimeBaseProvider- ToPersistencyMapping.timeBaseProvider' is present, the value of Global Time shall be restored from persistent memory such that the value of backupTimestamp is used to initialize the Time Base. Immediately after successfully loading the stored backupTimestamp, the Time Mas- ter shall store a new backupTimestamp (= *loaded*(*old*)*backupTimestamp* +

> **[SWS_TS_00213]**{草案} 对于配置为时间主机的每个TBR，如果激活了存储到持久内存的功能，即存在'TimeBaseProvider- ToPersistencyMapping.timeBaseProvider'，则应从持久内存恢复全局时间的值，以使备份时间戳用于初始化时间基准。在成功加载存储的备份时间戳后，时间主机应存储新的备份时间戳（=加载（旧）*备份时间戳* +）


TimeBaseProviderToPersistencyMapping*.*cyclicBackupInterval)*♩(RS\_-*

> 时间基础提供者到持久性映射*.*循环备份间隔)*♩(RS\_-*


*TS_00024, RS_TS_00004)*

> *TS_00024，RS_TS_00004)*


**\[SWS_TS_00214\]**{DRAFT} *\[*In case the restore from persistent memory is not suc- cessful, the Time Base shall start with zero.*♩(RS_TS_00024)*

> 如果从持久存储器恢复不成功，时基应从零开始。♩(RS_TS_00024)


**\[SWS_TS_00215\]**{DRAFT} *\[*For each TBR configured as Time Slave, Clock Update Counter shall be initialized with zero.*♩(RS_TS_00024)*

> 对于每个配置为时间从属的TBR，应将时钟更新计数器初始化为零。♩（RS_TS_00024）

### Default values


When the system starts up, the TBRs have to be set to known default values so that their behavior is well defined.

> 当系统启动时，TBRs必须设置为已知的默认值，以便确定它们的行为。


**\[SWS_TS_00007\]**{DRAFT} *\[*Characteristics of Time Base Resources shall be initial- ized as follows:

> **\[SWS_TS_00007\]**{草案} *\[*时间基础资源的特性应该如下初始化：

- Active Status Flags shall be invalidated.
- The User Data is to be deleted.
- Time Leap information shall be reset.

*♩(RS_TS_00009)*

### Shutdown


**\[SWS_TS_00212\]**{DRAFT} *\[*For each TBR configured as Time Master for which stor- age to persistent memory is activated, i.e a 'TimeBaseProviderToPersisten- cyMapping.timeBaseProvider' is present, first the current value of the Global Time shall be read every 'TimeBaseProviderToPersistencyMapping.cyclicBack- upInterval'. Then the value of the 'TimeBaseProviderToPersistencyMap- ping.cyclicBackupInterval' itself shall be added and this check-pointed value of the Global Time shall then be stored into persistent memory 'TimeBaseProvider- ToPersistencyMapping.timeBaseProvider' (see \[[11](#_bookmark11)\]) as backupTimestamp if persistent storage is required. The initial value of backupTimestamp shall be set to 0.

> 对于配置为时间主机，且启用了存储到持久内存的TBR，即存在“TimeBaseProviderToPersistencyMapping.timeBaseProvider”，每次都应按“TimeBaseProviderToPersistencyMapping.cyclicBackupInterval”读取全局时间的当前值，然后加上“TimeBaseProviderToPersistencyMapping.cyclicBackupInterval”的值，将该检查点值的全局时间存储到持久内存“TimeBaseProviderToPersistencyMapping.timeBaseProvider”（参见[11]）作为备份时间戳，如果需要持久存储。备份时间戳的初始值应设置为0。


Upon a graceful shutdown the Global Time shall be stored without applying another 'TimeBaseProviderToPersistencyMapping.cyclicBackupInterval' as back-off.*♩(RS_TS_00024)*

> 在一次优雅的关机之后，全球时间将被存储而不再应用另一个“TimeBaseProviderToPersistencyMapping.cyclicBackupInterval”作为回退。♩(RS_TS_00024)


**Note:** Regardless of the exact shutdown event, the last stored value of backupTi- mestamp will be restored during the next startup (see [7.2.1](#startup)).

> **注意：**无论确切的关机事件如何，在下次启动时将恢复最后存储的backupTimestamp值（参见[7.2.1]（#startup））。

2. ## Normal Operation

   1. ### Introduction


A Global Time network consists of a Time Master and at least one Time Slave. For each Time Domain, the Time Master is distributing the Global Time Base to the con- nected Time Slaves via Time Synchronization messages. The Time Slave corrects the received Global Time Base taking into account the Time Stamp at the transmitter side and the own generated receiver Time Stamp.

> 一个全球时间网络由一个时间主机和至少一个时间从机组成。对于每个时间域，时间主机通过时间同步消息将全球时间基准分发给连接的时间从机。时间从机根据发射端的时间戳和自己生成的接收端时间戳来校正接收到的全球时间基准。


The local time of a Slave Time Base will be maintained autonomously and updated whenever a new time value is received from its associated Master Time Base.

> 本地从属时间基准将自主维护，并在从关联的主时间基准接收到新的时间值时更新。

![](./media/image1.jpeg){width="5.633333333333334in" height="3.908332239720035in"}

**Figure 7.1: Global Time Base Distribution.**

### Time Base Manifestations


From the Time Domain point of view, Time Bases are classified in Synchronized and Offset Time Bases.

> 从时域角度来看，时域基础可以分为同步时域和偏移时域。


The number of Synchronized Time Bases and Offset Time Bases is not limited by the TS functionality, but by the functional needs of the system to be fulfilled (i.e. the TS does not define a limit of Offset/Synchronized Time Bases identifiers in the system).

> 在系统中同步时间基准和偏移时间基准的数量不受TS功能的限制，而是受系统要满足的功能需求（即TS不定义系统中偏移/同步时间基准标识符的限制）。


2. ### Roles of the Time Base Resources

> ### 时间基础资源的角色


   1. ### Global Time Master

> ### 全球时间大师


A TBR can act as a Global Time Master, in which case it is the system wide origin for a given time value that is then distributed via the network to the Time Slaves.

> 一个TBR可以充当全球时间大师，在这种情况下，它是系统范围内给定时间值的来源，然后通过网络分发给时间奴隶。

### Time Slave


In the role of a Time Slave, the TBR updates its internally-maintained local time to a value of a Global Time Base, which is provided by the corresponding TSP module.

> 在时间奴隶的角色中，TBR将其内部维护的本地时间更新为由相应的TSP模块提供的全局时间基准值。


3. ### Time Base Resources

> ### 基于时间的资源


   1. ### Slave Time Bases

> ### 奴隶时间基准


**\[SWS_TS_00139\]** *\[*Monitoring of time leaps to the future shall only be enabled, if a timeLeapFutureThreshold is other than zero and ara::tsync::Syn- chronizationStatus unequal to kNotSynchronizedUntilStartup.*♩(RS_TS\_- 00009)*

> **[SWS_TS_00139]** *[*监控未来的时间跳跃只有当timeLeapFutureThreshold不为零且ara::tsync::SynchronizationStatus不等于kNotSynchronizedUntilStartup时才会启用。*♩(RS_TS_- 00009)*


**\[SWS_TS_00140\]** *\[*Monitoring of time leaps to the past shall only be enabled, if a timeLeapPastThreshold is other than zero and ara::tsync::Synchroniza- tionStatus unequal to kNotSynchronizedUntilStartup.*♩(RS_TS_00009)*

> **\[SWS_TS_00140\]**：只有当timeLeapPastThreshold不等于零且ara :: tsync :: SynchronizationStatus不等于kNotSynchronizedUntilStartup时，才能启用对过去时间的监控。♩（RS_TS_00009）


**\[SWS_TS_00141\]** *\[*A check for time leaps shall be performed on every successful synchronization with the master clock, but only after the clock has been synchronized once (ara::tsync::SynchronizationStatus unequal to kNotSynchronize- dUntilStartup).*♩(RS_TS_00009)*

> **\[SWS_TS_00141\]** *\[*每次成功与主时钟同步后，都应该检查时间跳变，但只有在时钟同步一次之后（ara::tsync::SynchronizationStatus不等于kNotSynchronizedUntilStartup）。*♩(RS_TS_00009)*


**\[SWS_TS_00027\]** *\[*If the adjustment made by the resynchronization exceeded the specified threshold values, the corresponding ara::tsync::LeapJump status shall be set to kTimeLeapNone if no leap jump occurred. kTimeLeapFuture: if jump oc- cured in time to the future greater than timeLeapFutureThreshold. kTimeLeap- Past: if jump occured in time to the past greater than timeLeapPastThreshold.*♩ (RS_TS_00009)*

> **\[SWS_TS_00027\]** *\[*如果重新同步所做的调整超出了指定的阈值，则如果没有发生跃迁，则相应的ara :: tsync :: LeapJump状态将设置为kTimeLeapNone。 kTimeLeapFuture：如果跳跃超过timeLeapFutureThreshold。 kTimeLeap- Past：如果跳跃超过timeLeapPastThreshold。*♩ (RS_TS_00009)*


**\[SWS_TS_00064\]**{DRAFT} *\[*The initial value of ara::tsync::LeapJump shall be

> SWS_TS_00064{草案}*\[*ara::tsync::LeapJump的初始值应为


kTimeLeapNone.*♩(RS_TS_00009)*

> 没有时间跳跃。*♩（RS_TS_00009）*


**\[SWS_TS_00028\]** *\[*Active Time Leap Status ara::tsync::LeapJump shall be set to kTimeLeapNone, if a consecutive number timeLeapHealingCounter of synchro- nizations were all below the Time Leap Future and Past Thresholds.*♩(RS_TS_00009)*

> **[SWS_TS_00028]** *[*活动时间跳跃状态ara :: tsync :: LeapJump应设置为kTimeLeapNone，如果连续的时间跳跃治疗计数器都低于时间跳跃未来和过去的阈值。*♩（RS_TS_00009）*


[]{#_bookmark42 .anchor}**\[SWS_TS_00030\]** *\[*Each instance of ara::tsync::SynchronizedTimeBaseCon- sumer shall independently monitor for a synchronization timeout by measuring the time since that last update and a specified timeout duration in syncLossTimeout.*♩(RS\_- TS_00009)*

> [SWS_TS_00030] 每个ara::tsync::SynchronizedTimeBaseConsumer实例都应独立监视同步超时，通过测量自上次更新以来的时间以及syncLossTimeout中指定的超时时间来实现（参见RS-TS_00009）。


**\[SWS_TS_00032\]** *\[*In case of a monitored timeout (refer \[[SWS_TS_00030](#_bookmark42)\]) the ara:-

> **[SWS_TS_00032]** *[*在监控超时的情况下（参见[SWS_TS_00030]（＃_bookmark42）），ara：-


:tsync::SynchronizationStatus shall be set to kTimeOut.*♩(RS_TS_00009)*

> :tsync::同步状态应设置为kTimeOut.*♩(RS_TS_00009)*


**\[SWS_TS_00011\]** *\[*If the update of the Time Base is successful and SYNC_TO_GATEWAY bit is set, the ara::tsync::SynchronizationStatus shall be set to kSynchToGateway.*♩(RS_TS_00009)*

> **\[SWS_TS_00011\]** 如果时间基准更新成功且设置了SYNC_TO_GATEWAY位，ara::tsync::SynchronizationStatus将被设置为kSynchToGateway。♩（RS_TS_00009）


**\[SWS_TS_00033\]** *\[*If the update of the Time Base is successful and the SYNC_TO_GATEWAY bit is NOT set, the ara::tsync::SynchronizationSta- tus shall be set to kSynchronized.*♩(RS_TS_00009)*

> **\[SWS_TS_00033\]** *\[*如果时间基准更新成功，且SYNC_TO_GATEWAY位未设置，则ara::tsync::SynchronizationStatus应设置为kSynchronized。♩（RS_TS_00009）*

### Immediate Time Synchronization


All TSP Modules are working independently of the TS regarding the handling of the bus-specific Time Synchronization protocol (i.e. autonomous transmission of Timesync messages on the bus).

> 所有TSP模块在处理专用于总线的时间同步协议（即在总线上自主传输Timesync消息）方面，独立于TS工作。


Time information is passed from a TSP to the TBR. Implementation details as well as the interaction of such a TSP with the TBR are outside of the scope of this specifica- tion(for protocol specification please refer to \[[1](#_bookmark3)\]).

> 时间信息从TSP传递到TBR。实施细节以及TSP与TBR之间的交互超出了本规范的范围（有关协议规范，请参见[[1]]）。

### User Data


User Data is part of each Time Base. User Data is set by the Global Time Master of each Time Base and distributed as part of the Timesync messages.

> 用户数据是每个时间基础的一部分。用户数据由每个时间基础的全局时间主人设置，并作为Timesync消息的一部分分发。


User Data can be used to characterize the Time Base, e.g., regarding the quality of the underlying clock source or regarding the progress of time.

> 用户数据可用于表征时间基准，例如关于基础时钟源的质量或关于时间进展。


User Data consists of a vector of bytes. Due to the frame format of various Timesync messages it might not be possible to transmit the complete vector on every bus system. It is the responsibility of the system designer to use only those User Data bytes in the vector that can be distributed inside the vehicle network.

> 用户数据由字节向量组成。由于各种Timesync消息的帧格式，可能无法在每个总线系统上传输完整的向量。系统设计师有责任仅使用那些可以在车辆网络内分发的用户数据字节。

### Time Correction


TS provides the ability for Time Slaves to perform Rate and Offset Correction of the Synchronized TBR and Rate Correction of an Offset Time Base.

> TS提供了时间奴隶执行同步TBR的速率和偏移校正以及偏移时基的速率校正的能力。


For Global Time Masters, the TS provides the ability to perform Rate Correction of their Time Base(s).

> 对于全球时间大师，TS提供了对其时基进行速率校正的能力。


Time correction can be configured individually for each Time Base.

> 时间校正可以为每个时间基础单独配置。

### Rate Correction for Time Slaves


Rate Correction detects and eliminates rate deviations of local instances of Time Bases and of Offset Time Bases. Rate Correction determines the rate deviation in the scope of a measurement. This rate deviation is used as correction factor which the TBR uses to correct the Time Base's time whenever it is read (e.g. in the scope of ara::- tsync::SynchronizedTimeBaseConsumer::GetCurrentTime).

> 率校正检测和消除本地时基实例和偏移时基实例的速率偏差。率校正确定测量范围内的速率偏差。此速率偏差用作校正因子，TBR在读取时基的时间时使用此校正因子（例如在ara :: - tsync :: SynchronizedTimeBaseConsumer :: GetCurrentTime的范围内）。


**\[SWS_TS_00041\]**{DRAFT} *\[*The TBR shall perform Rate Correction measurements to determine its rate deviation if ara::tsync::SynchronizationStatus is set to kSynchronized.*♩(RS_TS_00002, RS_TS_00018)*

> **[SWS_TS_00041]**{草案} *[*当ara::tsync::SynchronizationStatus设置为kSynchronized时，TBR应执行速率校正测量以确定其速率偏差。*♩(RS_TS_00002, RS_TS_00018)*


**\[SWS_TS_00042\]**{DRAFT} *\[*The TBR shall perform Rate Correction measurements continuously. The end of a measurement marks the start of the next measurement.

> **[SWS_TS_00042]**{草案} *[*TBR应持续进行比率校正测量。测量结束标志着下一次测量的开始。


The start and end of measurements is always triggered by (and aligned to) the recep- tion of time values for Synchronized or Offset Time Bases.*♩(RS_TS_00002, RS_TS\_- 00007, RS_TS_00018, RS_TS_00019)*

> 测量的开始和结束总是由（并且对齐）接收到的同步或偏移时间基础的时间值来触发（RS_TS_00002，RS_TS_-00007，RS_TS_00018，RS_TS_00019）。

![](./media/image2.png){width="5.61114501312336in" height="1.6686450131233597in"}

**Figure 7.2: Visualization of two parallel measurements.**


**\[SWS_TS_00043\]**{DRAFT} *\[*During runtime, the Synchronized TBR shall determine the timespan of a Rate Correction measurement on the basis of clock ara::core:-

> **\[SWS_TS_00043\]**{草案} *\[*运行时，Synchronized TBR 应根据时钟ara::core确定Rate Correction测量的时间跨度：


:SteadyClock.*♩(RS_TS_00018)*

> :稳定的时钟。 ♩（RS_TS_00018）


**\[SWS_TS_00044\]**{DRAFT} *\[*The TBR shall perform as many simultaneous Rate Correction measurements as configured by the parameter 'TimeSyncCorrection. rateCorrectionsPerMeasurementDuration'.*♩(RS_TS_00018)*

> **[SWS_TS_00044]**{草案} *\[*TBR 将按照参数'TimeSyncCorrection.rateCorrectionsPerMeasurementDuration'配置的数量执行多个同时的速率校正测量。*♩(RS_TS_00018)*


**\[SWS_TS_00045\]**{DRAFT} *\[*Simultaneous Rate Correction measurements shall be started with a defined offset (to*~n~*) to yield Rate Corrections evenly distributed over the measurement duration. The value will be calculated according to the following formula: to*~n~* = n \* (rateDeviationMeasurementDuration / rateCorrection- PerMeasurementDuration) (where 'n' is the zero-based index of the current measurement)*♩(RS_TS_00018, RS_TS_00019)*

> **\[SWS_TS_00045\]**{草案} *\[*同步速率校正测量应以定义的偏移量（至*~n~*）开始，以便在测量持续时间内均匀分布速率校正。该值将按照以下公式计算：to*~n~* = n \*（rateDeviationMeasurementDuration / rateCorrection- PerMeasurementDuration）（其中'n'是当前测量的基于零的索引）*♩（RS_TS_00018，RS_TS_00019）*


**\[SWS_TS_00046\]**{DRAFT} *\[*At the start of a Rate Correction measurement, the Syn- chronized TBR shall take the time-snapshots TGStart and TOStart in the scope of TSP.*♩(RS_TS_00018)*

> **[SWS_TS_00046]{草稿}*[*在速率校正测量开始时，Synchronized TBR 应在 TSP 范围内采取时间快照 TGStart 和 TOStart。*♩（RS_TS_00018）*


**\[SWS_TS_00047\]**{DRAFT} *\[*At the start of a Rate correction measurement, the Offset TBR, shall take the following time-snapshots in the scope of TSP:*♩(RS_TS_00018)*

> **[SWS_TS_00047]**{草案} \[在速率校正测量开始时，偏移TBR应在TSP范围内采取以下时间快照：♩（RS_TS_00018）\]

- TSStart
- TOStart


**\[SWS_TS_00048\]**{DRAFT} *\[*At the end of the Rate Correction measurement, the Syn- chronized TBR shall take the time-snapshots TGStop and TVStop in the scope TSP.*♩ (RS_TS_00018)*

> **[SWS_TS_00048]**{草案} *\[*在Rate Correction测量结束时，Synchronized TBR应在TSP范围内采取TGStop和TVStop时间快照。*♩ (RS_TS_00018)*


**\[SWS_TS_00049\]**{DRAFT} *\[*At the end of the Rate Correction measurement, the Off- set TBR shall take the following time-snapshots in the scope TSP:*♩(RS_TS_00018)*

> **[SWS_TS_00049]{草稿} [*At the end of the Rate Correction measurement, the Off- set TBR shall take the following time-snapshots in the scope TSP:*♩(RS_TS_00018)*]** 在TSP范围内，在速率校正测量结束时，Offset TBR应采取以下时间快照：♩(RS_TS_00018)


**\[SWS_TS_00050\]**{DRAFT} *\[*At the end of a Rate Correction measurement, the Syn- chronized TBR shall calculate the resulting correction rate (r*~rc~*) according to the follow- ing formula:

> **\[SWS_TS_00050\]**{草案} *\[*在比率校正测量结束时，同步TBR应按照以下公式计算出最终校正比率(r*~rc~*)：


r*~rc~* = (TG*~Stop~* - TG*~Start~*) / (TV*~Stop~*- TV*~Start~*)*♩(RS_TS_00018, RS_TS_00019)*

> r*~rc~* = (TG*~停止~* - TG*~开始~*) / (TV*~停止~*- TV*~开始~*)*♩(RS_TS_00018, RS_TS_00019)*


**Note:** To determine the resulting rate deviation the value 1 has to be subtracted from r*~rc~*.

> **注意：**要确定最终的汇率偏差，必须从r*~rc~*减去1。


**\[SWS_TS_00051\]**{DRAFT} *\[*The last r*~rc~* value has to be used until a new value is calculated.*♩(RS_TS_00018, RS_TS_00019)*

> **\[SWS_TS_00051\]**{草案} *\[*直到计算出新值之前，必须使用最后的 r*~rc~* 值*♩(RS_TS_00018, RS_TS_00019)*


**\[SWS_TS_00052\]**{DRAFT} *\[*Offset TBRs shall not perform yet another rate correction, because this is done by the underlying TBR already.*♩(RS_TS_00018, RS_TS_00019)*

> **\[SWS_TS_00052\]**{草案} *\[*偏移TBR不应该再次执行另一个速率校正，因为这已经由底层TBR完成了。*♩(RS_TS_00018, RS_TS_00019)*


**\[SWS_TS_00053\]**{DRAFT} *\[*On invocation of ara::tsync::SynchronizedTime- BaseConsumer::GetRateDeviation the TBR shall return the calculated rate devi- ation (i.e. r*~rc~*-1).*♩(RS_TS_00018)*

> **\[SWS_TS_00053\]**{草案} *\[*当调用ara::tsync::SynchronizedTime- BaseConsumer::GetRateDeviation时，TBR应返回计算出的速率偏差（即r*~rc~*-1）。*♩(RS_TS_00018)*


**\[SWS_TS_00070\]**{DRAFT} *\[*If no rate deviation r*~rc~* has yet been calculated, ara:-

> **\[SWS_TS_00070\]**{草案} *\[*如果尚未计算出费率偏差r*~rc~*，请：


:tsync::SynchronizedTimeBaseConsumer::GetRateDeviation shall return 0.0.*♩(RS_TS_00018)*

> :tsync::SynchronizedTimeBaseConsumer::GetRateDeviation 应返回 0.0.*♩(RS_TS_00018)*


**\[SWS_TS_00054\]**{DRAFT} *\[*If a valid correction rate (r*~rc~*) has been calculated, the Synchronized TBR shall apply a Rate Correction.*♩(RS_TS_00018, RS_TS_00019)*

> **\[SWS_TS_00054\]**{草案} *\[*如果计算出有效的校正率（r*~rc~*），同步TBR 将应用率校正。*♩（RS_TS_00018，RS_TS_00019）*


**\[SWS_TS_00071\]**{DRAFT} *\[*If a valid correction rate (r*~oc~*) has been calculated, the Offset TBR shall apply a Rate Correction.*♩(RS_TS_00018, RS_TS_00019)*

> **[SWS_TS_00071]**{草案} *[*如果已经计算出有效的校正率(r*~oc~*)，Offset TBR 将应用率校正。*♩(RS_TS_00018, RS_TS_00019)*

简体中文：**[SWS_TS_00071]**{草案} *[*如果已经计算出有效的校正率(r*~oc~*)，Offset TBR 将应用率校正。*♩(RS_TS_00018, RS_TS_00019)*

### Offset Correction for Time Consumer


Offset Correction eliminates time offsets of local instances of Synchronized Time Bases. This correction takes place whenever the current time is read (e.g. in the scope of ara::tsync::SynchronizedTimeBaseConsumer::GetCurrentTime). The offset is measured when the local instance of the Time Base is synchronized in the scope of TSP.

> 抵消校正消除了同步时间基础的本地实例的时间偏移。每当读取当前时间时（例如在ara :: tsync :: SynchronizedTimeBaseConsumer :: GetCurrentTime的范围内），就会发生此校正。在TSP的范围内同步时间基础的本地实例时测量偏移。


**\[SWS_TS_00055\]**{DRAFT} *\[*For Synchronized TBRs, it shall be measured the offset between its local instance of the Time Base and the Global Time Base whenever the Time Base is synchronized in the scope of the function TSP by taking a snapshot of the TLSync and TVSync.*♩(RS_TS_00013)*

> **\[SWS_TS_00055\]**{草案} *\[*对于同步的TBR，在TSP功能范围内同步时间基准时，应测量其本地时间基准实例与全局时间基准之间的偏移，通过拍摄TLSync和TVSync的快照。*♩（RS_TS_00013）*


[]{#_bookmark48 .anchor}**\[SWS_TS_00056\]**{DRAFT} *\[*If the absolute value of the time offset between Global Time Base and local instance of the Time Base (abs(TG - TL*~Sync~*)) is equal or greater than 'TimeSyncCorrection.offsetCorrectionJumpThreshold', the TBR shall calculate the corrected time (TL) of its local instance of the Time Base according to the following formula:

> **\[SWS_TS_00056\]**{DRAFT} *\[*如果全局时间基准与本地时间基准（abs（TG-TL*~Sync~*））之间的时间偏移绝对值大于或等于'TimeSyncCorrection.offsetCorrectionJumpThreshold'，TBR应根据以下公式计算其本地时间基准的校正时间（TL）：


TL = TG + (TV - TV*~Sync~*) \* r*~rc~♩(RS_TS_00013, RS_TS_00019)*

> TL=TG+(TV-TV*~同步~*)*r*~收发~♩(RS_TS_00013, RS_TS_00019)*

### Note:


This correction will be done whenever the time is read in the scope of e.g. the function

> 这个修正将在例如函数范围内读取时间时进行。


ara::tsync::SynchronizedTimeBaseConsumer::GetCurrentTime.

> ara::tsync::SynchronizedTimeBaseConsumer::获取当前时间

### Note:


This correction will be done when the TBR needs to determine the time of the local instance of the Time Base.

> 这个纠正将在TBR需要确定时间基准的本地实例时进行。


**\[SWS_TS_00057\]**{DRAFT} *\[*The TBR shall correct absolute time offsets between the Global Time Base and the local instance of the Time Base (abs(TG - TL*~Sync~*)), which are smaller than the value given by 'TimeSyncCorrection.offsetCorrection- JumpThreshold' by temporarily applying an additional rate (r*~oc~*) to r*~rc~*. This rate shall be used for the duration defined by parameter 'TimeSyncCorrection.offsetCor- rectionAdaptionInterval'. r*~oc~* is calculated according to the following formula: r*~oc~* = (TG - TL*~Sync~*) / (T*~CorrInt~*) + 1

> **[SWS_TS_00057]**{草案}*[*TBR 应当校正全球时间基准与本地时间基准（abs(TG - TL*~Sync~*)）之间的绝对时间偏移，该偏移的值小于'TimeSyncCorrection.offsetCorrection- JumpThreshold' 所给出的值。通过临时应用附加率（r*~oc~*）到r*~rc~*来实现该校正。该率将按照参数'TimeSyncCorrection.offsetCor- rectionAdaptionInterval'所定义的时长使用。r*~oc~* 按照以下公式计算：r*~oc~* = (TG - TL*~Sync~*) / (T*~CorrInt~*) + 1


*♩(RS_TS_00013, RS_TS_00019)*

> *♩(RS_TS_00013, RS_TS_00019)*

*♩(RS_TS_00013，RS_TS_00019)*


**\[SWS_TS_00058\]**{DRAFT} *\[*If the absolute time offset between Global Time Base and local instance of the Time Base (abs(TG - TL*~Sync~*)) is smaller than 'TimeSync- Correction.offsetCorrectionJumpThreshold', the TBR shall calculate the corrected time (TL) of its local instance of the Time Base **within** the period of ' TimeSyncCorrection.offsetCorrectionAdaptionInterval' according to the following formula:

> **[SWS_TS_00058]{草案}** 如果全局时间基准和本地时间基准（abs（TG-TL *~Sync~*））之间的绝对时间偏移小于“TimeSync-Correction.offsetCorrectionJumpThreshold”，则TBR应根据以下公式在“TimeSyncCorrection.offsetCorrectionAdaptionInterval”期间计算其本地时间基准的校正时间（TL）：


TL = TL*~Sync~* + (r*~rc~* \* (TV - TV*~Sync~*) \* r*~oc~* )

> TL = TL*~同步~* + (r*~rc~* * (TV - TV*~同步~*) * r*~oc~*)


*♩(RS_TS_00013, RS_TS_00019)*

> *♩(RS_TS_00013，RS_TS_00019)*

### Note:


This correction will be done whenever the time is read in the scope of e.g. the function

> 这个纠正会在比如函数范围内读取时间的时候进行。


ara::tsync::SynchronizedTimeBaseConsumer::GetCurrentTime.

> ara::tsync::SynchronizedTimeBaseConsumer::获取当前时间

### Note:


This correction will be done when the TBR needs to determine the time of the local instance of the Time Base.

> 这个纠正将在TBR需要确定本地时间基准实例的时间时进行。


**\[SWS_TS_00059\]**{DRAFT} *\[*If the absolute time offset between the Global Time Base and the local instance of the Time Base (abs(TG - TL)) is smaller than TimeSyncCorrection.offsetCorrectionJumpThreshold, the TBR shall calcu- late the corrected time (TL) of its local instance of the Time Base **after** the period of TimeSyncCorrection.offsetCorrectionAdaptionInterval as specified in \[[SWS_TS_00056](#_bookmark48)\]*♩(RS_TS_00013)*

> **\[SWS_TS_00059\]**{草案} *\[*如果全局时间基准和本地时间基准之间的绝对时间偏移（abs（TG-TL））小于TimeSyncCorrection.offsetCorrectionJumpThreshold，则TBR应按照\[[SWS_TS_00056](#_bookmark48)\]中指定的TimeSyncCorrection.offsetCorrectionAdaptionInterval期间计算其本地时间基准的校正时间（TL）**之后**♩（RS_TS_00013）*


**\[SWS_TS_00060\]**{DRAFT} *\[*If TimeSyncCorrection.offsetCorrection- JumpThreshold is set to 0, Offset Correction shall be performed by Jump Correction only.*♩(RS_TS_00013)*

> **\[SWS_TS_00060\]**{草案} *\[*如果TimeSyncCorrection.offsetCorrection- JumpThreshold设置为0，则只能通过Jump Correction来执行Offset Correction。*♩(RS_TS_00013)*

### Rate Correction for Global Time Masters


Rate correction in Global Time Masters can be applied to Synchronized and Offset Time Bases Resources.

> 全球时间大师中的比率校正可以应用于同步和偏移时间基准资源。


Rate correction is applied by setting a correction factor which the TBR uses to cor- rect the Time Base's time whenever it is transmitted over the network. This happens independent of the rate correction done by the slave.

> 比率修正是通过设置一个修正因子来实现的，TBR会在时基的时间传输到网络时使用该因子来修正时间。这个过程独立于从机所做的比率修正。


**\[SWS_TS_00061\]**{DRAFT} *\[*If 'TimeSyncCorrection.allowProviderRateCor- rection' equals *true*, an invocation of ara::tsync::SynchronizedTimeBase- Provider::SetRateCorrection shall set the rate correction value. Otherwise ara::tsync::SynchronizedTimeBaseProvider::SetRateCorrection shall do nothing and return the error kLimitsExceeded*♩(RS_TS_00018)*

> **\[SWS_TS_00061\]**{草案} *\[*如果'TimeSyncCorrection.allowProviderRateCor- rection'等于*true*，那么ara::tsync::SynchronizedTimeBase- Provider::SetRateCorrection的调用将设置速率校正值。否则ara::tsync::SynchronizedTimeBaseProvider::SetRateCorrection不做任何处理，并返回错误kLimitsExceeded*♩(RS_TS_00018)*


**\[SWS_TS_00062\]**{DRAFT} *\[*The TBR shall apply rate correction, if allowProvider- RateCorrection equals TRUE and a valid rate correction value has been set by ara::tsync::SynchronizedTimeBaseProvider::SetRateCorrection.*♩ (RS_TS_00018)*

> **\[SWS_TS_00062\]**{草案} *\[*如果allowProvider- RateCorrection等于TRUE且ara::tsync::SynchronizedTimeBaseProvider::SetRateCorrection设置了有效的比率校正值，TBR将应用比率校正。*♩ (RS_TS_00018)*


**\[SWS_TS_00063\]**{DRAFT} *\[*If the absolute value of the rate correction parame- ter rateCorrection, which is passed to SetRateCorrection(), is greater than MasterRateDeviationMax, SetRateCorrection() shall set the actu- ally applied rate correction value to either (MasterRateDeviationMax) or (- MasterRateDeviationMax)(depending on sign of rateCorrection).*♩(RS_TS\_- 00018)*

> **\[SWS_TS_00063\]**{草案} *\[*如果传递给SetRateCorrection（）的rateCorrection参数的绝对值大于MasterRateDeviationMax，SetRateCorrection（）应将实际应用的速率校正值设置为（MasterRateDeviationMax）或（- MasterRateDeviationMax）（取决于rateCorrection的符号）。*♩（RS_TS\_- 00018）*


**Note:** The actual applied resulting rate will be the passed deviation value + 1. If align- ing the rate of one Time Base to the rate of another one, it is possible to use ara::- tsync::SynchronizedTimeBaseProvider::GetRateDeviation and pass the

> **注意：** 实际应用的结果比率将是传递的偏差值+1。如果将一个时间基准的比率与另一个时间基准的比率对齐，可以使用ara :: -tsync :: SynchronizedTimeBaseProvider :: GetRateDeviation并传递


value as argument to ara::tsync::SynchronizedTimeBaseProvider::Se- tRateCorrection.

> 将值作为ara::tsync::SynchronizedTimeBaseProvider::SetRateCorrection的参数。

### Notifications of Time Base Consumer


The Application might request to be notified of dedicated events for a specific TBR.

> 应用程序可能会要求接收特定TBR的专用事件的通知。

### Status flags notification


A change in the StatusFlags of the ara::tsync::SynchronizedTimeBaseStatus can be notified.

> 可以通知ara::tsync::SynchronizedTimeBaseStatus的StatusFlags的变化。


**\[SWS_TS_00701\]** *\[*A registered notifier via ara::tsync::SynchronizedTime- BaseConsumer::RegisterStatusChangeNotifier shall be invoked, if one of the following content is changed: ara::tsync::SynchronizationStatus, ara::- tsync::LeapJump or the user data.*♩(RS_TS_00021)*

> **[SWS_TS_00701]** *[*一个通过ara::tsync::SynchronizedTime-BaseConsumer::RegisterStatusChangeNotifier注册的通知者，如果以下内容之一发生变化：ara::tsync::SynchronizationStatus，ara::tsync::LeapJump或用户数据，则应调用该通知者。♩（RS_TS_00021）*

### Synchronization status notification


A change in the StatusFlags of the ara::tsync::SynchronizationStatus (e.g. if the timebase is in Timeout) can be notified.

> 状态标志的更改ara::tsync::SynchronizationStatus（例如，如果时间基在超时）可以通知。


**\[SWS_TS_00702\]** *\[*A registered notifier via ara::tsync::SynchronizedTime- BaseConsumer::RegisterSynchronizationStateChangeNotifier shall be invoked, if ara::tsync::SynchronizationStatus is changed.*♩(RS_TS_00009)*

> **[SWS_TS_00702]** *[*注册通知者通过ara::tsync::SynchronizedTime-BaseConsumer::RegisterSynchronizationStateChangeNotifier应该被调用，如果ara::tsync::SynchronizationStatus发生变化。♩(RS_TS_00009)*

### LeapJump notification


A leap jump can be notified.

> 跳跃可以得到通知。


**\[SWS_TS_00703\]** *\[*A registered notifier via ara::tsync::SynchronizedTime- BaseConsumer::RegisterTimeLeapNotifier shall be invoked, if ara::- tsync::LeapJump is changed.*♩(RS_TS_00034)*

> **[SWS_TS_00703]** *[*一个通过ara::tsync::SynchronizedTime-BaseConsumer::RegisterTimeLeapNotifier注册的通知者应当被调用，如果ara::tsync::LeapJump被改变了。♩(RS_TS_00034)*

简体中文：**[SWS_TS_00703]** *[*如果ara::tsync::LeapJump发生变化，应该调用通过ara::tsync::SynchronizedTime-BaseConsumer::RegisterTimeLeapNotifier注册的通知者。♩(RS_TS_00034)*

### Global Time Precision Measurement Support


To verify the precision of each Local Time Base compared to the Global Time Base a recording mechanism shall be optionally supported for Time Slaves and Time Gate- ways. In principle, a snapshot is taken of all required data at the point in time, where a synchronization event takes place. Access is provided to those values by an actively pushed API function on each successful assembled data block. An Off-Board Tester collects each block and calculates the precision afterwards and maintains a history of

> 为了验证每个局部时间基准与全局时间基准之间的精度，可以选择性地为时间从属和时间网关支持录制机制。原则上，在同步事件发生的时间点，会对所有所需的数据进行快照。每次成功组装的数据块，都会通过一个主动推送的API功能提供这些值。一个外部测试器会收集每个数据块，计算精度，并保持历史记录。


recorded blocks and their elements accordingly. How and by which protocol the data will be transferred to the Off-Board Tester will be specified by the Application.

> 记录的块及其元素将按照应用程序指定的协议，如何将数据传输到车外测试器。


**\[SWS_TS_00803\]**{DRAFT} *\[*A registration via ara::tsync::SynchronizedTime- BaseConsumer::RegisterTimePrecisionMeasurementNotifier shall only be possible for Synchronized Time Bases and Offset Time Bases, for which isSys- temWideGlobalTimeMaster is set to FALSE.*♩(RS_TS_00034)*

> **\[SWS_TS_00803\]**{草案} *\[*通过ara::tsync::SynchronizedTime- BaseConsumer::RegisterTimePrecisionMeasurementNotifier注册只能用于isSys- temWideGlobalTimeMaster设置为FALSE的同步时间基准和偏移时间基准。*♩(RS_TS_00034)*


**\[SWS_TS_00800\]** *\[*For Synchronized Time Bases, a registered TimePrecisionMea- surement notifier (via ara::tsync::SynchronizedTimeBaseConsumer::Reg- isterTimePrecisionMeasurementNotifier) shall write the block elements

> **\[SWS_TS_00800\]** 对于同步时间基准，注册的时间精度测量通知者（通过ara::tsync::SynchronizedTimeBaseConsumer::RegisterTimePrecisionMeasurementNotifier）应写入块元素。

- glbSeconds
- glbNanoSeconds
- timeBaseStatus
- virtualLocalTimeLow
- rateDeviation
- locSeconds
- locNanoSeconds
- pathDelay


to the related measurement recording table after updating the Main Time Tuple (i.e., after updating the Local Time Base by the Global Time Base). GlbSeconds, Glb- NanoSeconds are the elements of the Global Time part of the Received Time Tuple (i.e., TGRx); VirtualLocalTimeLow is the nanosecondsLo element of the Virtual Local Time part of the Received Time Tuple (i.e., TVRx).*♩(RS_TS_00034)*

> 将更新后的主时间元组（即更新全局时间基准后）的相关测量记录表。GlbSeconds、Glb- NanoSeconds是接收时间元组（即TGRx）的全局时间部分的元素；VirtualLocalTimeLow是接收时间元组（即TVRx）的虚拟本地时间部分的nanosecondsLo元素。（RS_TS_00034）


**\[SWS_TS_00801\]** *\[*For Offset Time Bases, a registered TimePrecisionMeasure- ment notifier (via ara::tsync::SynchronizedTimeBaseConsumer::Regis- terTimePrecisionMeasurementNotifier) shall only write the block elements GlbSeconds, GlbNanoSeconds and TimeBaseStatus to the related measurement recording table.*♩(RS_TS_00034)*

> **\[SWS_TS_00801\]** *\[*对于偏移时间基准，注册的TimePrecisionMeasurement Notifier（通过ara :: tsync :: SynchronizedTimeBaseConsumer :: RegisterTimePrecisionMeasurementNotifier）只能将块元素GlbSeconds、GlbNanoSeconds和TimeBaseStatus写入相关的测量记录表。*♩（RS_TS_00034）*

简体中文：**\[SWS_TS_00801\]** *\[*对于偏移时间基准，已注册的TimePrecisionMeasurement Notifier（通过ara :: tsync :: SynchronizedTimeBaseConsumer :: RegisterTimePrecisionMeasurementNotifier）只能将块元素GlbSeconds、GlbNanoSeconds和TimeBaseStatus写入相关的测量记录表。*♩（RS_TS_00034）*

### Global Time Validation Measurement Support


Figure [7.3](#_bookmark56) outlines the basic concept of the Time Validation feature.

> 图7.3概述了时间验证功能的基本概念。


A Time Slave collects information on the time synchronization process, to predict e.g. the Sync Ingress based on its local instance of Global Time and check whether Master and Slave agree upon the current time. The prediction itself will be locally analyzed by a separate Adaptive Application to detect any existing impairments. Furthermore, information on the time synchronization process from Time Masters and Slaves is also shared with a Validator Adaptive Application which may run anywhere in the network,

> 时间奴隶会收集有关时间同步过程的信息，以预测例如基于其本地的全局时间实例的同步入口，并检查主机和从机是否就当前时间达成一致。预测本身将由单独的自适应应用程序来本地分析，以检测任何现有的损害。此外，来自时间主机和从机的有关时间同步过程的信息也会与可在网络中的任何位置运行的验证器自适应应用程序共享。


e.g. on the owner of Global Time.

> 例如，关于全球时间的所有者。


The Validator uses the information on the time synchronization process received from the Time Master and Time Slave Entities via a user defined feedback channel to re- construct the whole synchronization process and check that a coherent time base is established among all peers.

> 验证器使用来自时间主机和时间从器实体通过用户定义的反馈通道接收的关于时间同步过程的信息，重新构建整个同步过程，并检查在所有对等方之间建立了一个连贯的时间基础。


The Time Validation feature only provides API to the Adaptive Application. The feed- back channel and the actual validation performed by the respective Adaptive Applica- tion is not standardized in AUTOSAR. It is done in a user defined way on application level.

> 时间验证功能仅为自适应应用程序提供API。AUTOSAR中未对反馈通道和由各自自适应应用程序执行的实际验证进行标准化。它是在应用程序级别以用户定义的方式完成的。

**Figure 7.3:** []{#_bookmark56 .anchor}**Time Validation mechanism**


For an optional validation of the Timesync and Pdelay mechanisms, the Time Synchro- nization functional cluster provides the following functionality.

> 为了可选择地验证Timesync和Pdelay机制，时间同步功能集群提供以下功能。


**\[SWS_TS_00424\]**{DRAFT} *\[*Everytime a Follow_Up message is received, all pa- rameters defined by ara::tsync::TimeSlaveMeasurementType shall be up- dated and the function ara::tsync::ConsumerTimeBaseValidationNotifi- cation::SetSlaveTimingData shall be invoked.*♩(RS_TS_00034)*

> **\[SWS_TS_00424\]**{草案} *\[*每次收到跟进消息，都应更新ara::tsync::TimeSlaveMeasurementType定义的所有参数，并调用ara::tsync::ConsumerTimeBaseValidationNotification::SetSlaveTimingData函数。*♩(RS_TS_00034)*


**\[SWS_TS_00425\]**{DRAFT} *\[*Everytime a Sync message is transmitted, all parameters defined by ara::tsync::TimeMasterMeasurementType shall be updated and the function ara::tsync::ProviderTimeBaseValidationNotification::- SetMasterTimingData shall be invoked.*♩(RS_TS_00034)*

> **\[SWS_TS_00425\]**{草案} *\[*每次发送同步消息时，将更新ara :: tsync :: TimeMasterMeasurementType定义的所有参数，并调用函数ara :: tsync :: ProviderTimeBaseValidationNotification :: - SetMasterTimingData。*♩(RS_TS_00034)*


**\[SWS_TS_00426\]**{DRAFT} *\[*After the current Pdelay measurement is finished, i.e., upon reception of the Pdelay_Resp_Follow_Up message, all parameters defined by ara::tsync::PdelayInitiatorMeasurementType shall be updated and

> **\[SWS_TS_00426\]**{草案} *\[*在当前的Pdelay测量完成后，即收到Pdelay_Resp_Follow_Up消息时，ara :: tsync :: PdelayInitiatorMeasurementType定义的所有参数都将被更新并


the function ara::tsync::ConsumerTimeBaseValidationNotification::- SetPdelayInitiatorData shall be invoked.*♩(RS_TS_00034)*

> 函数ara::tsync::ConsumerTimeBaseValidationNotification::-SetPdelayInitiatorData应被调用（RS_TS_00034）


**\[SWS_TS_00427\]**{DRAFT} *\[*After the current Pdelay measurement is finished, i.e., upon transmission of the Pdelay_Resp_Follow_Up, all parameters defined by ara::tsync::PdelayResponderMeasurementType shall be updated and the function ara::tsync::ProviderTimeBaseValidationNotification::- SetPdelayResponderData shall be invoked.*♩(RS_TS_00034)*

> **\[SWS_TS_00427\]**{草稿} *\[*在当前的Pdelay测量完成后，即Pdelay_Resp_Follow_Up传输完成后，ara :: tsync :: PdelayResponderMeasurementType定义的所有参数都将被更新，并调用函数ara :: tsync :: ProviderTimeBaseValidationNotification :: - SetPdelayResponderData。*♩（RS_TS_00034）*

简体中文：**\[SWS_TS_00427\]**{草案} *\[*在当前的Pdelay测量完成后，即Pdelay_Resp_Follow_Up传输完成后，ara :: tsync :: PdelayResponderMeasurementType定义的所有参数都将被更新，并调用函数ara :: tsync :: ProviderTimeBaseValidationNotification :: - SetPdelayResponderData。*♩（RS_TS_00034）*


**Note:** Please note that there is a decoupling between reception and transmission of the respective PTP event messages and the forwarding of measurement data.

> **注意：**请注意，接收和发送各自的PTP事件消息以及转发测量数据之间存在解耦。

# Interfaces to other Functional Clusters (informative)


**Note:** This is chapter is created in the scope of the new SWS document template and in the current version is not applicable.

> **注意：**本章节是根据新的 SWS 文档模板创建的，目前的版本不适用。

## Overview


AUTOSAR decided not to standardize interfaces which are exclusively used between Functional Clusters (on platform-level only), to allow efficient implementations, which might depend e.g. on the used Operating System.

> AUTOSAR决定不对仅在平台级别上在功能群集之间使用的接口进行标准化，以允许高效的实现，这可能取决于所使用的操作系统。


This chapter provides informative guidelines how the interaction between Functional Clusters looks like, by clustering the relevant requirements of this document to describe Inter-Functional Cluster (IFC) interfaces. In addition, the standardized public interfaces which are accessible by user space applications (see chapters 8 can also be used for interaction between Functional Clusters.

> 本章提供了信息指南，描述了功能集群之间的交互如何进行，通过将本文档中相关的要求聚类以描述跨功能集群（IFC）接口。此外，可以使用第8章中可由用户空间应用程序访问的标准公共接口来进行功能集群之间的交互。


The goal is to provide a clear understanding of Functional Cluster boundaries and in- teraction, without specifying syntactical details. This ensures compatibility between documents specifying different Functional Clusters and supports parallel implementa- tion of different Functional Clusters. Details of the interfaces are up to the platform provider. Additional interfaces, parameters and return values can be added.

> 目的是提供对功能集群边界和交互的清晰理解，而不指定句法细节。这确保了指定不同功能集群的文档之间的兼容性，并支持不同功能集群的并行实现。接口的细节取决于平台提供商。可以添加额外的接口，参数和返回值。


2. []{#_bookmark59 .anchor}**Interface Tables**

> 接口表

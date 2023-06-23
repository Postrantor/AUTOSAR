---
tip: translate by openai@2023-06-23 18:00:35
...
# Contents

```
1. Introduction and Functional Overview 9
2. Acronyms and Abbreviations 10
3. Related Documentation 12

   1. Input Documents & Related Standards and Norms 12
   2. Further Applicable Specifications 12
4. [Constraints and Assumptions](#constraints-and-assumptions) 13

   1. [Known Limitations](#known-limitations) 13
   2. [Constraints on Configuration](#constraints-on-configuration) 13
   3. [Direct Access to Storage Hardware](#direct-access-to-storage-hardware) 13
5. [Dependencies to Other Functional Clusters](#dependencies-to-other-functional-clusters) 14

   1. [Protocol Layer Dependencies](#protocol-layer-dependencies) 14
6. Requirements Tracing 15
7. [Functional Specification](#functional-specification) 28

   1. [The Architecture of Persistency](#the-architecture-of-persistency) 28

      1. [Persistency in the Manifest](#persistency-in-the-manifest) 28
      2. [Key-Value Storages in the Manifest](#key-value-storages-in-the-manifest) 30
      3. [File Storages in the Manifest](#file-storages-in-the-manifest) 30
   2. [General Features of Persistency](#general-features-of-persistency) 32

      1. [Functional Cluster Lifecycle](#functional-cluster-lifecycle) 32

         1. [Initialization and Shutdown of Persistency](#initialization-and-shutdown-of-persistency) 32
      2. [Error Handling](#error-handling) 33

         1. [Handling of General Errors](#handling-of-general-errors) 33
      3. [Parallel Access to Persistent Data](#parallel-access-to-persistent-data) 36
      4. [Security Concepts](#security-concepts) 38
      5. [Redundancy Concepts](#redundancy-concepts) 41

         1. [Redundancy Types](#redundancy-types) 45
      6. [Installation and Update of Persistent Data](#installation-and-update-of-persistent-data) 48

         1. [Installation of Persistent Data](#installation-of-persistent-data) 51

            1. [Installation of Key-Value Storage](#installation-of-key-value-storage) 51
            2. [Installation of File Storage](#installation-of-file-storage) 52
         2. [Update of Persistent Data](#update-of-persistent-data) 53

            1. [Update of Key-Value Storage](#update-of-key-value-storage) 54
            2. [Update of File Storage](#update-of-file-storage) 56
         3. [Finalization of Persistent Data after Successful Update](#finalization-of-persistent-data-after-successful-update) 57
         4. [Roll-Back of Persistent Data after Failed Update](#roll-back-of-persistent-data-after-failed-update) 57
         5. [Removal of Persistent Data](#removal-of-persistent-data) 57
      7. [Resource Management Concepts](#resource-management-concepts) 59
   3. [Key-Value Storage specific Features](#key-value-storage-specific-features) 61

      1. [Supported Data Types in Key-Value Storages](#supported-data-types-in-key-value-storages) 63
   4. [File Storage specific Features](#file-storage-specific-features) 65

      1. [Access to Additional Information about Files](#access-to-additional-information-about-files) 70
8. [API Specification](#api-specification) 72

   1. [General Features of Persistency](#general-features-of-persistency-1) 72

      1. [ara::core Types](#aracore-types) 72
      2. Installation and Update of Persistent Data 73

         1. RegisterApplicationDataUpdateCallback 73
         2. UpdatePersistency 74
         3. ResetPersistency 75
      3. Redundancy Handling 76

         1. RecoveryReportKind 76
         2. RegisterRecoveryReportCallback 77
      4. Handle Classes 79

         1. SharedHandle Class 79

            1. SharedHandle::SharedHandle 79
            2. SharedHandle::operator= 80
            3. SharedHandle::operator bool 81
            4. SharedHandle::Operator-\81
            5. SharedHandle::Operator\* 82
         2. UniqueHandle Class 83

            1. UniqueHandle::UniqueHandle 83
            2. UniqueHandle::operator= 84
            3. UniqueHandle::operator bool 85
            4. UniqueHandle::Operator-\85
            5. UniqueHandle::Operator\* 86
      5. Errors 87

         1. PerErrc 87
         2. GetPerDomain 88
         3. MakeErrorCode 88
         4. PerException Class 89

            1. PerException::PerException 89
         5. PerErrorDomain Class 89

            1. PerErrorDomain::Errc 90
            2. PerErrorDomain::Exception 90
            3. PerErrorDomain::PerErrorDomain 91
            4. PerErrorDomain::Name 91
            5. PerErrorDomain::Message 91
            6. PerErrorDomain::ThrowAsException 92
   2. Key-Value Storage 93

      1. OpenKeyValueStorage 93
      2. RecoverKeyValueStorage 94
      3. ResetKeyValueStorage 95
      4. GetCurrentKeyValueStorageSize 96
      5. KeyValueStorage Class 96

         1. KeyValueStorage::KeyValueStorage 97
         2. KeyValueStorage::operator= 98
         3. KeyValueStorage::\~KeyValueStorage 98
         4. KeyValueStorage::GetAllKeys 99
         5. KeyValueStorage::KeyExists 99
         6. KeyValueStorage::GetCurrentValueSize 100
         7. KeyValueStorage::GetValue 101
         8. KeyValueStorage::SetValue 102
         9. KeyValueStorage::RemoveKey 103
         10. KeyValueStorage::RecoverKey 104
         11. KeyValueStorage::ResetKey 105
         12. KeyValueStorage::RemoveAllKeys 106
         13. KeyValueStorage::SyncToStorage 107
         14. KeyValueStorage::DiscardPendingChanges 107
   3. File Storage 109

      1. OpenFileStorage 109
      2. RecoverAllFiles 110
      3. ResetAllFiles 111
      4. GetCurrentFileStorageSize 112
      5. OpenMode 112
      6. operator\| for FileStorage::OpenMode 113
      7. operator\|= for FileStorage::OpenMode 113
      8. FileCreationState 114
      9. FileModificationState 114
      10. FileInfo 115

          1. FileInfo.creationTime 115
          2. FileInfo.modificationTime 115
          3. FileInfo.accessTime 116
          4. FileInfo.fileCreationState 116
          5. FileInfo.fileModificationState 116
      11. FileStorage Class 117

          1. FileStorage::FileStorage 117
          2. FileStorage::operator= 118
          3. FileStorage::\~FileStorage 118
          4. FileStorage::GetAllFileNames 119
          5. FileStorage::DeleteFile 119
          6. FileStorage::FileExists 120
          7. FileStorage::RecoverFile 121
          8. FileStorage::ResetFile 122
          9. FileStorage::GetCurrentFileSize 123
          10. FileStorage::GetFileInfo 123
          11. FileStorage::OpenFileReadWrite 124
          12. FileStorage::OpenFileReadOnly 127
          13. FileStorage::OpenFileWriteOnly 129
      12. Origin 132
      13. ReadAccessor Class 132

          1. ReadAccessor::ReadAccessor 133

```


4. # Constraints and Assumptions

> 4. # 约束和假设

5. ## Known Limitations


- Although a Key-Value Storage and File Storage can be configured as write-only, the current API always allows read access. Read access is even possible when a file has been opened with ara::per::FileStorage::OpenFileWriteOnly.

> 尽管键值存储和文件存储可以配置为只写，但当前的API始终允许读取访问。即使使用ara :: per :: FileStorage :: OpenFileWriteOnly打开文件，也可以进行读取访问。


6. ## Constraints on Configuration

> 6. ## 配置的约束


There are several constraints on the Persistency configuration that need to be observed by the tooling which creates/processes this part of the Execution Manifest. These constraints are defined in [3].

> 有几个关于持久性配置的约束需要由创建/处理执行清单这部分的工具遵守。这些约束在[3]中定义。

## Direct Access to Storage Hardware


Modern embedded controllers use flash memory and similar hardware to store data. These devices have the intrinsic problem that the signal that can be read from each memory cell is reduced over time, mainly influenced by the number of write accesses. In the end, the cell will produce arbitrary values on each read access.

> 现代嵌入式控制器使用闪存和类似的硬件来存储数据。这些设备具有固有的问题，即每个存储单元读取的信号随着时间的推移而减少，主要受写入访问次数的影响。最终，每次读取时，单元会产生任意值。


Unfortunately, the distribution of write accesses in typical systems is very uneven. Some parameters might be updated a few times a second, while some code may stay untouched for the whole life time of the ECU. To avoid early read errors, wear leveling should be deployed, such that frequent updates of single data elements are distributed over the whole memory area.

> 不幸的是，在典型系统中，写访问的分布非常不均匀。某些参数可能每秒更新几次，而某些代码可能在ECU的整个生命周期中保持不变。为了避免早期读取错误，应部署磨损均衡，以便将频繁更新的单个数据元素分布在整个存储器区域中。


On the other hand, most operating systems include a file system or at least a flash driver that takes care of wear leveling, such that a typical implementation of the Persistency will not have to care about the wear leveling. This use case is therefore not described in any detail in this specification.

> 另一方面，大多数操作系统都包含一个文件系统或至少一个闪存驱动器，可以实现磨损均衡，因此典型的持久性实现无需关心磨损均衡。因此，本规范没有详细描述此用例。


5. # Dependencies to Other Functional Clusters

> 5. 与其他功能集群的依赖关系


   1. ## Protocol Layer Dependencies

> ## 协议层依赖


The Persistency is (at least partially) compiled as part of an Executable of an Adaptive Application, and therefore also executed as part of a Process, which creates an implicit dependency on the Execution Management [4].

> 持久性至少部分地编译成自适应应用程序的可执行文件的一部分，因此也作为进程的一部分执行，这就对执行管理产生了隐含的依赖关系[4]。


For the implementation of redundancy and security purposes, the Persistency accesses services of the Cryptography [5].

> 为了实现冗余和安全性，持久性访问加密服务[5]。


For the installation, update, and deletion of persisted data, the Persistency interacts with the Update and Configuration Management [6].

> 为了安装、更新和删除持久性数据，持久性与更新和配置管理[6]进行交互。


7. # Functional Specification

> 7. # 功能规范


   1. ## The Architecture of Persistency

> ## 持久性的架构


The Persistency offers two different mechanisms to access persistent memory: Key-Value Storages offer access to a set of keys with associated values (similar to a database), while File Storages offer access to a set of files (similar to a directory of a file system).

> 持久性提供两种不同的机制访问持久性存储：键值存储提供对具有关联值的一组键的访问（类似于数据库），而文件存储提供对一组文件的访问（类似于文件系统的目录）。


The typical usage of the Persistency within an Adaptive Application is depicted in [Figure](#_bookmark8) [7.1](#_bookmark8). As shown there, an Adaptive Application can use a combination of multiple Key-Value Storages and multiple File Storages. Of course, the same applies to other functional clusters using Persistency.

> 典型的持久性在自适应应用程序中的使用情况如[图7.1](#_bookmark8)所示。如图所示，自适应应用程序可以使用多个键值存储和多个文件存储的组合。当然，同样适用于使用持久性的其他功能群集。

![](./media/image1.png)

**Figure 7.1:** []{#\_bookmark8 .anchor}**Typical usage of Persistency within an Adaptive Application**


Persistency can also be used directly by other Functional Clusters without involvement of the application. The library part of these Functional Clusters will use dedicated deployment information of Persistency, while Daemons of Functional Clusters can be modeled similarly to Adaptive Applications.

> 持久性也可以直接由其他功能群体使用，而无需应用程序参与。这些功能群体的库部分将使用持久性的专用部署信息，而功能群体的守护程序可以类似于自适应应用程序进行建模。

### Persistency in the Manifest


The Persistency usage of an Adaptive Application is modeled in the Execution Manifest (furtheron simply referred to as the "manifest") as part of the

> 在执行清单（以下简称"清单"）中，模拟了自适应应用程序的持久性使用。


AdaptiveApplicationSwComponentTypes of an Executable. The model has two principal parts: The application design information, aggregated by the PersistencyKeyValueStorageInterface and the PersistencyFileStorageInterface, and the deployment information, aggregated by the PersistencyKeyValueStorage and the PersistencyFileStorage. The latter is also used when the Persistency is accessed directly by another Functional Cluster.

> 适用于可执行文件的自适应应用软件组件类型。该模型有两个主要部分：通过PersistencyKeyValueStorageInterface和PersistencyFileStorageInterface聚合的应用程序设计信息，以及通过PersistencyKeyValueStorage和PersistencyFileStorage聚合的部署信息。当另一个功能集群直接访问持久性时，也会使用后者。


The API specification holds the classes ara::per::KeyValueStorage and ara::per::FileStorage for access to a Key-Value Storage or a File Storage, respectively. The global functions of these classes receive either the identifier (the fully qualified shortName path) of a PortPrototype typed by a PersistencyInterface, or the shortName path of a FunctionalClusterInteractsWithPersistencyDeploymentMapping. Both are then used as an ara::core::InstanceSpecifier input parameter (see subsection 8.2.1 and subsection 8.3.1). Depending on the nature of the PortPrototype or on the value of FunctionalClusterInteractsWithPersistencyDeploymentMapping.persistencyAccess, the Key-Value Storage or File Storage will be accessible as:

> API 规范提供了 ara::per::KeyValueStorage 和 ara::per::FileStorage 类来访问键值存储或文件存储。这些类的全局函数接收一个由 PersistencyInterface 类型化的 PortPrototype 的标识符（完全限定的 shortName 路径）或者 FunctionalClusterInteractsWithPersistencyDeploymentMapping 的 shortName 路径。然后将它们都用作 ara::core::InstanceSpecifier 输入参数（参见 8.2.1 小节和 8.3.1 小节）。根据 PortPrototype 的性质或 FunctionalClusterInteractsWithPersistencyDeploymentMapping.persistencyAccess 的值，可以以以下方式访问键值存储或文件存储：


**Read Only** if the PortPrototype is instantiated as RPortPrototype or FunctionalClusterInteractsWithPersistencyDeploymentMapping. persistencyAccess is read, or

> 如果PortPrototype被实例化为RPortPrototype或FunctionalClusterInteractsWithPersistencyDeploymentMapping，则persistencyAccess只读。


**Read/Write** if the PortPrototype is instantiated as PRPortPrototype or FunctionalClusterInteractsWithPersistencyDeploymentMapping. persistencyAccess is readWrite, or

> 如果PortPrototype被实例化为PRPortPrototype或FunctionalClusterInteractsWithPersistencyDeploymentMapping，persistencyAccess为读写。


**Write Only** if the PortPrototype is instantiated as PPortPrototype or FunctionalClusterInteractsWithPersistencyDeploymentMapping. persistencyAccess is write.

> 只有在PortPrototype被实例化为PPortPrototype或FunctionalClusterInteractsWithPersistencyDeploymentMapping时，persistencyAccess才具有写的权限。


In case of application access to Persistency, the manifest contains separate deployment data for each Process that references the Executable. The Process is bound to the deployment data by specialization of the class PersistencyPortPrototypeToDeploymentMapping, which refers to a PortPrototype typed by a PersistencyInterface, a PersistencyDeployment, and the Process.

> 在应用访问持久性的情况下，清单包含每个引用可执行文件的进程的单独部署数据。该进程通过对PersistencyPortPrototypeToDeploymentMapping类的特殊化而绑定到部署数据，该类引用一个由PersistencyInterface、PersistencyDeployment和Process类型的PortPrototype。

### Key-Value Storages in the Manifest


Every Key-Value Storage is either represented by a PortPrototype typed by a PersistencyKeyValueStorageInterface in the application design for the respective AdaptiveApplicationSwComponentType, or by a FunctionalClusterInteractsWithPersistencyDeploymentMapping, and in both cases by a PersistencyKeyValueStorage containing deployment information. Every Key-

> 每个键值存储都可以用在应用程序设计中为相应的AdaptiveApplicationSwComponentType类型而定义的PortPrototype或者FunctionalClusterInteractsWithPersistencyDeploymentMapping表示，并且在两种情况下都由包含部署信息的PersistencyKeyValueStorage表示。每个键值存储都是由PersistencyKeyValueStorageInterface定义的。


-Value Storage can hold multiple key-value pairs. Key-value pairs can be added and removed at run-time by the Adaptive Application or Functional Cluster using the Persistency API (see subsubsection 8.2.5.8 and subsubsection 8.2.5.9).

> 存储值可以容纳多个键值对。通过持久性API（参见8.2.5.8和8.2.5.9子子节），自适应应用程序或功能集群可以在运行时添加和删除键值对。


A Key-Value Storage with predefined key-value pairs can be deployed with default data during installation or update of an Adaptive Application or Functional Cluster. This operation is (indirectly) triggered by the Update and Configuration Management [6] during installation or update using the deployment information and data provided by the software package of the Adaptive Application or Functional Cluster. See [subsection](#installation-and-update-of-persistent-data) [7.2.6](#installation-and-update-of-persistent-data).

> 一个具有预定义键值对的键值存储可以在安装或更新自适应应用程序或功能集群时以默认数据部署。此操作（间接）由更新和配置管理[6]在安装或更新时触发，使用自适应应用程序或功能集群的软件包提供的部署信息和数据。请参见[子节](#installation-and-update-of-persistent-data) [7.2.6](#installation-and-update-of-persistent-data)。


The link between application design and deployment information of a Key-

> 应用设计与重要部署信息之间的联系


-Value Storage is represented by PersistencyPortPrototypeToKeyValueStorageMapping, which refers to a PortPrototype typed by a PersistencyKeyValueStorageInterface, the corresponding PersistencyKeyValueStorage, and a Process.

> 存储值由PersistencyPortPrototypeToKeyValueStorageMapping表示，它指的是一个由PersistencyKeyValueStorageInterface类型的PortPrototype，相应的PersistencyKeyValueStorage和一个Process。

### File Storages in the Manifest


Every File Storage is represented by a PortPrototype typed by a PersistencyFileStorageInterface in the application design for the respective AdaptiveApplicationSwComponentType, or by a FunctionalClusterInteractsWithPersistencyDeploymentMapping, and in both cases by a PersistencyFileStorage containing deployment information. Every File Storage can hold multiple files as described in [3]. Similar to the key-value pairs mentioned above, files can be created and deleted at run-time by the Adaptive Application or Functional Cluster using the Persistency API (see subsubsection 8.3.11.11, subsubsection 8.3.11.13, and subsubsection 8.3.11.5).

> 每个文件存储都由应用程序设计中的PortPrototype类型的PersistencyFileStorageInterface或FunctionalClusterInteractsWithPersistencyDeploymentMapping表示，在两种情况下都由包含部署信息的PersistencyFileStorage表示。每个文件存储可以容纳多个文件，如[3]中所述。与上述键值对类似，文件可以通过Persistency API（参见8.3.11.11子子节，8.3.11.13子子节和8.3.11.5子子节）在运行时由自适应应用程序或功能集群创建和删除。


A File Storage with predefined files with initial content can be deployed during installation or update. This operation is also (indirectly) triggered by the Update and Configuration Management [6]. All needed deployment information

> 一个带有预定义文件和初始内容的文件存储可以在安装或更新时部署。此操作也受更新和配置管理[6]的（间接）触发。所有需要的部署信息


and files come with the software package of the Adaptive Application or

> 随软件包Adaptive Application而来的文件


Functional Cluster. See [subsection](#installation-and-update-of-persistent-data) [7.2.6](#installation-and-update-of-persistent-data).

> 功能集群。请参阅[7.2.6](#installation-and-update-of-persistent-data)小节。


The link between application design and deployment information of a File Storage is represented by PersistencyPortPrototypeToFileStorageMapping, which refers to a PortPrototype typed by a PersistencyFileStorageInterface, the corresponding PersistencyFileStorage, and a Process.

> 连接应用程序设计和文件存储的部署信息由PersistencyPortPrototypeToFileStorageMapping表示，它引用了一个由PersistencyFileStorageInterface类型的PortPrototype，相应的PersistencyFileStorage和一个过程。

## General Features of Persistency


**[SWS_PER_00002]** *[*All specified classes within the Persistency shall reside within the C++ namespace ara::per._♩(RS_AP_00115)_

> **[SWS_PER_00002]** 所有指定的持久性类都应位于C++命名空间ara::per中。♩(RS_AP_00115)


1. ### Functional Cluster Lifecycle

> ### 功能集群生命周期


   1. ### Initialization and Shutdown of Persistency

> ### 持久性的初始化和关闭


Using ara::core::Initialize and ara::core::Deinitialize, the application can start and shut down all functional clusters with direct ARA interfaces (i.e. the Adaptive Platform Foundation).

> 使用ara::core::Initialize和ara::core::Deinitialize，应用程序可以通过直接ARA接口（即Adaptive Platform Foundation）启动和关闭所有功能集群。


[]{#\_bookmark15 .anchor}**[SWS_PER_00408]** *[*When ara::core::Initialize is called, the Persistency

> 当调用ara::core::Initialize时，持久性将被初始化。


shall read in the manifest information and prepare the access structures to all Key-

> 阅读清单信息，准备对所有关键字的访问结构。

-Value Storages and File Storages that are defined in the manifest._♩(RS_PER_00018)_


**[SWS_PER_00409]** *[*When ara::core::Deinitialize is called, the Persistency shall implicitly ensure that all open files of all File Storages are persisted as though ara::per::ReadWriteAccessor::SyncToFile was called and closed as though the ara::per::UniqueHandles were destructed, and that not persisted values in all Key-Value Storages are dropped as though ara::per::KeyValueStorage::DiscardPendingChanges was called. Afterwards, all access structures shall be freed._♩(RS_PER_00018)_

> 当调用ara::core::Deinitialize时，持久性将隐式确保所有文件存储的所有打开文件都被持久化，就像调用了ara::per::ReadWriteAccessor::SyncToFile并关闭了ara::per::UniqueHandles一样，而所有键值存储中未持久化的值都会被丢弃，就像调用了ara::per::KeyValueStorage::DiscardPendingChanges一样。之后，所有访问结构都将被释放。


The application is expected not to call any API of Persistency (directly or indirectly through other functional clusters) before ara::core::Initialize or after ara::core::Deinitialize, but Persistency needs to protect itself against such eventualities.

> 应用程序不应在ara::core::Initialize之前或ara::core::Deinitialize之后直接或间接通过其他功能集群调用任何持久性API，但持久性需要防止这种可能性的发生。


[]{#\_bookmark16 .anchor}**[SWS_PER_00410]**{DRAFT} *[*All functions of Persistency and all methods of its classes shall call ara::core::Abort when they are called after static initialization but before ara::core::Initialize was called or after ara::core::Deinitialize was called._♩(RS_PER_00018)_

> 所有持久性的功能和它的类的所有方法，如果在静态初始化之后但在ara::core::Initialize调用之前或者在ara::core::Deinitialize调用之后被调用，则应调用ara::core::Abort。(RS_PER_00018)

### Error Handling


Error handling in Persistency is aligned with the guidelines described in [2]. To this end, the Persistency has to implement a set of standard classes and APIs, which are described in this section.

> 错误处理在持久性中与[2]中描述的指南一致。为此，持久性必须实现一组标准类和API，这些类和API在本节中有所描述。


**[SWS_PER_00472]** *[*Persistency shall use the error codes defined in ara::per::PerErrc to report problems to the calling application via ara::core::Result. Vendors of Persistency may add their own errors to ara::per::PerErrc, using codes above 255._♩(RS_AP_00128)_

> **[SWS_PER_00472]** *[*持久性应使用ara::per::PerErrc中定义的错误代码将问题报告给调用应用程序通过ara::core::Result。持久性的供应商可以将自己的错误添加到ara::per::PerErrc中，使用大于255的代码。_♩(RS_AP_00128)_`


ara::per::PerErrc belongs to the ara::per::PerErrorDomain, which can be used by an application to classify returned errors.

> ara::per::PerErrc属于ara::per::PerErrorDomain，应用程序可以使用它来对返回的错误进行分类。


**[SWS_PER_00473]** *[*ara::per::GetPerDomain shall return the global ara::per::PerErrorDomain object._♩(RS_AP_00128)_

> **[SWS_PER_00473]** *[*ara::per::GetPerDomain应返回全局ara::per::PerErrorDomain对象。_♩(RS_AP_00128)_


To create its own Persistency error codes, the application may use ara::per::MakeErrorCode.

> 应用程序可以使用ara::per::MakeErrorCode来创建自己的持久性错误代码。


**[SWS_PER_00474]** *[*ara::per::MakeErrorCode shall return an ara::core::ErrorCode when called with an error code from ara::per::PerErrc._♩(RS_AP_00128)_

> **[SWS_PER_00474]** *[*ara::per::MakeErrorCode应该返回一个ara::core::ErrorCode，当用ara::per::PerErrc中的一个错误码调用时。(RS_AP_00128)_*

> **[SWS_PER_00353]** *[*ara::per::PerErrorDomain::Name shall return the NULterminated string "Per"._♩(RS_AP_00128)_
>
> **[SWS_PER_00475]** *[*ara::per::PerErrorDomain::Message shall return the error message associated with the passed ara::core::ErrorCode._♩(RS_AP_00128)_


The whole Persistency API has been designed to be exception-less. If an application prefers to use exceptions, it may use ara::per::PerErrorDomain::ThrowAsException, or simply ara::core::ErrorCode::ThrowAsException.

> 整个持久性API被设计为不抛出异常。如果应用程序更喜欢使用异常，可以使用ara :: per :: PerErrorDomain :: ThrowAsException，或者简单地使用ara :: core :: ErrorCode :: ThrowAsException。


**[SWS_PER_00476]** *[*ara::per::PerErrorDomain::ThrowAsException shall throw an ara::per::PerException that is created from the passed error code._♩ (RS_AP_00128)_

> [SWS_PER_00476] *ara::per::PerErrorDomain::ThrowAsException 应抛出一个由传入的错误代码创建的 ara::per::PerException。（RS_AP_00128）

### Handling of General Errors


**[SWS_PER_00536]** *[*When a function or method of Persistency encounters a problem with the hardware or the underlaying operating system services during the access to a storage or an element of a storage, Persistency shall return the error kPhysicalStorageFailure._♩(RS_AP_00128)_

> 当持久性功能或方法在访问存储或存储元素时遇到硬件或底层操作系统服务的问题时，持久性应返回错误kPhysicalStorageFailure。♩（RS_AP_00128）


When kPhysicalStorageFailure occurs, the application cannot access the affected storage any more. Depending on the system, a reboot might restore the access.

> 当发生kPhysicalStorageFailure时，应用程序将无法访问受影响的存储设备。根据系统的不同，重新启动可能会恢复访问权限。


**[SWS_PER_00537]** *[*When a method of Persistency would modify the underlying storage, but the storage is configured as read-only (the PortPrototype that is typed by the corresponding PersistencyInterface is instantiated as RPortPrototype), Persistency shall return the error kIllegalWriteAccess._♩(RS_AP_00128)_

> 当持久性方法会修改基础存储，但存储被配置为只读（由相应的持久性接口类型化的PortPrototype被实例化为RPortPrototype）时，持久性应返回错误kIllegalWriteAccess。


**[SWS_PER_00538]** *[*When a function of Persistency is called with an ara::core::InstanceSpecifier that is not available in the manifest, Persistency shall return the error kStorageNotFound._♩(RS_AP_00128)_

> **[SWS_PER_00538]** 当使用ara::core::InstanceSpecifier调用持久性功能时，如果在清单中找不到该实例，则持久性应返回错误kStorageNotFound。_♩（RS_AP_00128）_


The two previous errors (kIllegalWriteAccess and kStorageNotFound) occur when the configuration does not match the implemented access to a storage. An application might be implemented to be aware of this possibility and react accordingly to the error by avoiding (write) accesses to the storage. If the application depends on (write) access to the storage, these errors would hint at an incorrect configuration of the storage.

> 这两个前面的错误（kIllegalWriteAccess和kStorageNotFound）发生时，配置与对存储的实施访问不匹配。应用程序可能被实施为意识到这种可能性，并通过避免（写）访问存储来对错误做出反应。如果应用程序依赖于（写）访问存储，这些错误将暗示存储的配置不正确。


**[SWS_PER_00539]** *[*When a function or method of Persistency detects a fundamental problem in the structure of the storage that prevents accessing the storage, Persistency shall return the error kIntegrityCorrupted._♩(RS_AP_00128)_

> 当持久性的函数或方法检测到存储结构中的一个根本问题，阻止访问存储时，持久性应返回错误kIntegrityCorrupted。


The application can restore a corrupted storage by calling ara::per::RecoverKeyValueStorage, ara::per::ResetKeyValueStorage, ara::per::RecoverAllFiles, or ara::per::ResetAllFiles. When the kIntegrityCorrupted is reported for an element of a storage, integrity can be restored by calling ara::per::KeyValueStorage::RecoverKey, ara::per::KeyValueStorage::ResetKey, ara::per::FileStorage::RecoverFile, or ara::per::FileStorage::ResetFile.

> 应用程序可以通过调用ara :: per :: RecoverKeyValueStorage、ara :: per :: ResetKeyValueStorage、ara :: per :: RecoverAllFiles或ara :: per :: ResetAllFiles来恢复已损坏的存储。当存储的元素报告kIntegrityCorrupted时，可以通过调用ara :: per :: KeyValueStorage :: RecoverKey、ara :: per :: KeyValueStorage :: ResetKey、ara :: per :: FileStorage :: RecoverFile或ara :: per :: FileStorage :: ResetFile来恢复完整性。


When Persistency detects insufficient or broken redundancy, it will report kValidationFailed as described in [[SWS_PER_00221](#_bookmark22)].

> 当持久性检测到不足或损坏的冗余时，它将按照[[SWS_PER_00221](#_bookmark22)]中的描述报告kValidationFailed。


**[SWS_PER_00540]** *[*When encryption or decryption of persistent data fails within a function or method of Persistency, Persistency shall return the error kEncryptionFailed._♩(RS_AP_00128)_

> 当持久性数据的加密或解密在持久性函数或方法中失败时，持久性应返回错误kEncryptionFailed。♩（RS_AP_00128）


**[SWS_PER_00564]** *[*When the calculation or verification of the MAC of persistent data fails within a function or method of Persistency, Persistency shall return the error kAuthenticationFailed._♩(RS_AP_00128)_

> 当持久性数据的MAC的计算或验证在持久性的函数或方法中失败时，持久性应返回错误kAuthenticationFailed。


The two previous errors can occur when the configured cryptographic keys or algorithms are not available at run time, or when the storage or the element of a storage is corrupted. The latter case could be detected or even avoided by configuring redundancy.

> 两个先前的错误可能发生在配置的加密密钥或算法在运行时不可用，或者存储或存储元素被损坏时。后一种情况可以通过配置冗余来检测或甚至避免。


**[SWS_PER_00541]** *[*When a method of Persistency tries to read data from a file, but the position is already at the end, Persistency shall return the error kIsEof._♩ (RS_AP_00128)_

> **[SWS_PER_00541]** *当一种持久性方法试图从文件中读取数据时，但位置已经在末尾，持久性应返回错误kIsEof。_♩ (RS_AP_00128)_


This error can typically be dealt with by the application, and can be avoided by using ara::per::ReadAccessor::IsEof.

> 这个错误通常可以通过应用程序处理，并且可以通过使用ara :: per :: ReadAccessor :: IsEof来避免。


**[SWS_PER_00542]** *[*When a function or method of Persistency would create a file, but the number of existing files already equals the configured PersistencyFileStorageInterface.maxNumberOfFiles of the corresponding File Storage, Persistency shall return the error kTooManyFiles._♩(RS_AP_00128)_

> 当一个持久性函数或方法创建一个文件时，但现有文件的数量已经等于相应的文件存储中配置的PersistencyFileStorageInterface.maxNumberOfFiles，持久性将返回错误kTooManyFiles。


This error might occur when a new file is opened for writing, or when a File Storage is updated or when it is recovered after an error. An application seeing this error might delete some files to be able to create the new file (or files), or reset the File Storage to the initial state using ara::per::ResetAllFiles or ara::per::ResetPersistency.

> 此错误可能在打开新文件进行写入时发生，或者当更新文件存储或在错误发生后恢复时发生。看到此错误的应用程序可能会删除一些文件以便能够创建新文件（或文件），或使用ara :: per :: ResetAllFiles或ara :: per :: ResetPersistency将文件存储重置为初始状态。


**[SWS_PER_00543]** *[*When a function or method of Persistency would increase the size of a storage or an element of a storage such that the total storage size would exceed the configured PersistencyDeployment.maximumAllowedSize of the storage, Persistency shall return the error kQuotaExceeded._♩(RS_AP_00128)_

> 当一个持久性函数或方法增加存储或存储元素的大小，使得总存储大小超过配置的PersistencyDeployment.maximumAllowedSize时，持久性应返回错误kQuotaExceeded。(RS_AP_00128)


This error means that the application tried to store data that exceeds the configured quota of a storage. The application has to be able to deal with this situation, and either write less data to the affected storage or remove outdated data from this storage, or reset the affected element/storage with a call to ara::per::ResetKeyValueStorage, ara::per::ResetAllFiles, ara::per::KeyValueStorage::ResetKey, ara::per::FileStorage::ResetFile, or even ara::per::ResetPersistency.

> 这个错误意味着应用程序试图存储超过配置存储配额的数据。应用程序必须能够处理这种情况，可以减少对受影响存储的数据写入量，或者从该存储中删除过时的数据，或者通过调用ara :: per :: ResetKeyValueStorage、ara :: per :: ResetAllFiles、ara :: per :: KeyValueStorage :: ResetKey、ara :: per :: FileStorage :: ResetFile甚至ara :: per :: ResetPersistency来重置受影响的元素/存储。


**[SWS_PER_00544]** *[*When a function or method of Persistency cannot increase the size of a storage because the physical storage is not sufficient (e.g. file system quoata exceeded or partition full), Persistency shall return the error kOutOfStorageSpace._♩(RS_AP_00128)_

> 当一个持久性的函数或方法不能增加存储空间的大小，因为物理存储不足（例如，文件系统配额已超出或分区已满），持久性应返回错误kOutOfStorageSpace。


This error means that some other storage or even a completely independent process occupies so much physical storage that Persistency cannot store additional data. This can only happen if PersistencyDeployment.maximumAllowedSize is configured to a higher value than PersistencyDeployment.minimumSustainedSize. The application has to be able to deal with this situation, and either write less data to the affected storage or remove outdated data from this or another storage, or reset this or another element/storage with a call to ara::per::ResetKeyValueStorage, ara::per::ResetAllFiles, ara::per::KeyValueStorage::ResetKey, ara::per::FileStorage::ResetFile, or even ara::per::ResetPersistency.

> 这个错误意味着其他存储或甚至完全独立的进程占用了太多的物理存储空间，以至于Persistency无法存储额外的数据。这只有在将PersistencyDeployment.maximumAllowedSize配置为比PersistencyDeployment.minimumSustainedSize更高的值时才会发生。应用程序必须能够处理这种情况，并且要么减少向受影响存储写入的数据，要么从这个或另一个存储中删除过期的数据，或者使用ara::per::ResetKeyValueStorage、ara::per::ResetAllFiles、ara::per::KeyValueStorage::ResetKey、ara::per::FileStorage::ResetFile或ara::per::ResetPersistency重置这个或另一个元素/存储。

### Parallel Access to Persistent Data


According to [9], the persistent data is local to one Process. Therefore, Persistency will never share persistent data between two (or more) Processes, even of the same Executable. The background of this decision is that Persistency should not provide an additional communication path for applications besides the mechanisms provided by the functional cluster Communication Management (e.g. using ara::com).

> 根据[9]，持久数据局限于一个进程。因此，持久性永远不会在两个（或更多）进程之间共享持久数据，即使是同一个可执行文件。这一决定的背景是持久性不应为应用程序提供除功能集群通信管理（例如使用ara :: com）提供的机制之外的额外通信路径。


**[SWS_PER_00309]** *[*Persistent data shall always be local to one Process._♩_

> 数据总是局限于一个进程中的持久数据。

> _(RS_PER_00001)_


If persistent data needs to be accessed by multiple Processes (of the same or different applications), it is the duty of the application designer to provide Service Interfaces for communication.

> 如果多个进程（同一个或不同的应用程序）需要访问持久数据，应用程序设计者有责任提供服务接口进行通信。


Persistency is, on the other hand, prepared to handle concurrent access from multiple threads of the same application, running in the context of the same Process. To create shared access to a Key-Value Storage or File Storage, either the ara::per::SharedHandle returned by ara::per::OpenKeyValueStorage and ara::per::OpenFileStorage can be passed on (i.e. copied) to another thread, or ara::per::OpenKeyValueStorage and ara::per::OpenFileStorage can be called in independent threads for the same Key-Value Storage or File Storage, respectively. All operations of the Key-Value Storage and File Storage support concurrent access from multiple threads, though operations like ara::per::RecoverKeyValueStorage and ara::per::ResetKeyValueStorage or ara::per::RecoverAllFiles and ara::per::ResetAllFiles will only succeed when the corresponding Key-Value Storage or File Storage is not opened.

> 持久性另一方面准备处理来自同一应用程序的多个线程的并发访问，这些线程运行在同一个进程的上下文中。要创建对键值存储或文件存储的共享访问，可以传递（即复制）ara :: per :: OpenKeyValueStorage和ara :: per :: OpenFileStorage返回的ara :: per :: SharedHandle到另一个线程，或者可以在同一个键值存储或文件存储的独立线程中调用ara :: per :: OpenKeyValueStorage和ara :: per :: OpenFileStorage。所有键值存储和文件存储的操作都支持来自多个线程的并发访问，尽管像ara :: per :: RecoverKeyValueStorage和ara :: per :: ResetKeyValueStorage或ara :: per :: RecoverAllFiles和ara :: per :: ResetAllFiles这样的操作只有在相应的键值存储或文件存储没有打开时才能成功。


**[SWS_PER_00545]** *[*When a function of Persistency that modifies a storage is called while another function that modifies the same storage is being executed, Persistency shall return the error kResourceBusy._♩(RS_AP_00128)_

> 当一个修改存储的持久性功能被调用时，如果另一个修改同一存储的功能正在执行，持久性将返回错误kResourceBusy（RS_AP_00128）。


This restriction also applies to global functions like ara::per::UpdatePersistency, which will only succeed if no storage is open, and no other thread is currently modifying a storage with functions like ara::per::RecoverKeyValueStorage or ara::per::ResetAllFiles.

> 这个限制也适用于全局函数，比如ara::per::UpdatePersistency，只有在没有打开存储，且没有其他线程正在使用ara::per::RecoverKeyValueStorage或ara::per::ResetAllFiles等函数修改存储时，才能成功。


Access to single key-value pairs of a Key-Value Storage is possible from multiple threads at the same time, because the operation of ara::per::KeyValueStorage::GetValue and ara::per::KeyValueStorage::SetValue are atomic, as are those of ara::per::KeyValueStorage::RemoveKey, ara::per::KeyValueStorage::RemoveAllKeys, ara::per::KeyValueStorage::SyncToStorage, and ara::per::KeyValueStorage::DiscardPendingChanges.

> 访问键值存储的单个键值对可以同时从多个线程进行，因为ara :: per :: KeyValueStorage :: GetValue和ara :: per :: KeyValueStorage :: SetValue的操作是原子的，ara :: per :: KeyValueStorage :: RemoveKey，ara :: per :: KeyValueStorage :: RemoveAllKeys，ara :: per :: KeyValueStorage :: SyncToStorage和ara :: per :: KeyValueStorage :: DiscardPendingChanges也是如此。


Access to single files of a File Storage cannot be shared between multiple threads, because it would be impossible to synchronize read and write accesses and the corresponding change of the seek position in a file. Accordingly, the ara::-

> 文件存储的单个文件无法在多个线程之间共享，因为无法同步读写访问和文件中的搜索位置的相应更改。因此，ara::不适用。


per::UniqueHandle returned by the OpenFile\* APIs can only be moved to another thread, and trying to open an already opened file will fail. Likewise, operations like ara::per::FileStorage::DeleteFile, ara::per::FileStorage::RecoverFile, and ara::per::FileStorage::ResetFile will also not be possible on open files.

> OpenFile\* API 返回的 per::UniqueHandle 只能移动到另一个线程，尝试打开已经打开的文件将会失败。同样，ara::per::FileStorage::DeleteFile、ara::per::FileStorage::RecoverFile 和 ara::per::FileStorage::ResetFile 等操作也不能在已打开的文件上进行。


**[SWS_PER_00546]** *[*When a method of ara::per::FileStorage that opens or modifies a file is called while the same file is currently open or being modified by another method, Persistency shall return the error kResourceBusy._♩(RS_AP_00128)_

> 当一个ara::per::FileStorage的方法被调用来打开或修改一个文件，而同一文件当前正被另一个方法打开或正在被修改时，持久性应返回错误kResourceBusy（RS_AP_00128）。


Files are implicitly closed when their ara::per::UniqueHandle goes out of scope, or when the File Storage to which they belong is closed.

> 文件在其ara::per::UniqueHandle超出作用域时会隐式关闭，或者当它们所属的文件存储被关闭时也会被关闭。


**[SWS_PER_00425]** *[*When a File Storage is closed, because all related ara::per::SharedHandles go out of scope, any files which are still open are also closed._♩(RS_PER_00001)_

> 当文件存储被关闭，因为所有相关的ara :: per :: SharedHandles都超出范围，任何仍处于打开状态的文件也将被关闭。


Accessing a ara::per::UniqueHandle of a file of a closed File Storage will result in undefined behavior.

> 访问一个已关闭文件存储的文件的ara::per::UniqueHandle将导致未定义的行为。

### Security Concepts


The Persistency supports protection of the authenticity and confidentiality of data stored in a Key-Value Storage or File Storage. Which kind of protection is applied and the used algorithms are decided at deployment time. The application is not aware of this fact.

> 持久性支持对存储在键值存储或文件存储中的数据的真实性和机密性的保护。应用的保护和使用的算法是在部署时决定的，应用程序不知道这一事实。


If confidentiality of data shall be protected, a storage or an element of a storage are encrypted after the creation of the storage and when the storage is saved, and are decrypted when a storage is opened. Therefore, only encrypted data is stored persistently. In case of a read-only storage, encryption is done only once during installation, decryption is done every time the storage is opened.

> 如果要保护数据的机密性，则在创建存储或存储元素后对其进行加密，并在保存存储时对其进行解密，从而只储存加密的数据。对于只读存储，只在安装时进行一次加密，每次打开存储时进行解密。


If authenticity of data shall be protected, a message authentication code (MAC) is generated after the creation of a storage and when the storage is saved, and verified when the storage is opened. Therefore, unauthorized modifications to the storage can be detected.

> 如果要保护数据的真实性，在创建存储后会生成消息认证码（MAC），并在保存存储时进行验证，打开存储时也要进行验证。因此，可以检测到对存储的未经授权的修改。


In case of a read-only storage, it is also possible to protect the authenticity of the storage(or an element therein) by calculating a hash value of the data to be protected and comparing this calculated value to a hash value provided in the manifest. This assumes that the authenticity of the processed manifest is protected using other mechanisms (like secure boot).

> 在只读存储的情况下，也可以通过计算要保护的数据的哈希值并将其与清单中提供的哈希值进行比较来保护存储（或其中的元素）的真实性。这假定处理的清单的真实性是通过其他机制（如安全引导）保护的。


If authenticity and confidentiality shall be protected, authenticated encryption schemes (like AES GCM) can be used.

> 如果要保护真实性和保密性，可以使用认证加密方案（如AES GCM）。


**[SWS_PER_00210]** *[*If a PersistencyDeploymentToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentToCryptoKeySlotMapping.keySlotUsage is set to encryption, the Persistency shall encrypt all data related to the storage using the algorithm specified by PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString before storing it to the persistent memory._♩(RS_PER_00005, RS_PER_00010)_

> 如果清单中存在PersistencyDeploymentToCryptoKeySlotMapping，并且PersistencyDeploymentToCryptoKeySlotMapping.keySlotUsage设置为加密，则Persistency应使用PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString指定的算法在将数据存储到持久存储器之前对所有与存储相关的数据进行加密。 （RS_PER_00005，RS_PER_00010）


**[SWS_PER_00464]** *[*If a PersistencyDeploymentElementToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentElementToCryptoKeySlotMapping.keySlotUsage is set to encryption, the Persistency shall encrypt the element data using the algorithm specified by PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString before storing it to the persistent memory._♩(RS_PER_00005, RS_PER_00010)_

> 如果在清单中存在PersistencyDeploymentElementToCryptoKeySlotMapping，并且PersistencyDeploymentElementToCryptoKeySlotMapping.keySlotUsage设置为加密，则Persistency在将元素数据存储到持久内存之前，必须使用PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString指定的算法对元素数据进行加密。(RS_PER_00005, RS_PER_00010)


**[SWS_PER_00211]** *[*If a PersistencyDeploymentToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentToCryptoKeySlotMapping.keySlotUsage is set to encryption, the Persistency shall decrypt all data related to the storage using the algorithm specified by PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString after reading it from persistent memory._♩(RS_PER_00005, RS_PER_00010)_

> 如果清单中存在PersistencyDeploymentToCryptoKeySlotMapping，并且PersistencyDeploymentToCryptoKeySlotMapping.keySlotUsage设置为加密，那么Persistency在从持久内存中读取数据后，将使用PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString指定的算法解密与存储相关的所有数据（RS_PER_00005，RS_PER_00010）。


**[SWS_PER_00465]** *[*If a PersistencyDeploymentElementToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentElementTo-

> **[SWS_PER_00465]** 如果在清单中存在PersistencyDeploymentElementToCryptoKeySlotMapping，并且PersistencyDeploymentElementTo-


CryptoKeySlotMapping.keySlotUsage is set to encryption, the Persistency shall decrypt the element data using the algorithm specified by PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString after reading it from persistent memory._♩(RS_PER_00005, RS_PER_00010)_

> CryptoKeySlotMapping.keySlotUsage 被设置为加密，持久性应该使用PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString指定的算法，从持久存储中读取元素数据后进行解密。（RS_PER_00005，RS_PER_00010）


**[SWS_PER_00449]** *[*If a PersistencyDeploymentToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentToCryptoKeySlotMapping.keySlotUsage is set to verification, the Persistency shall create and store a message authentication code (MAC) for all data related to the storage using the algorithm specified by PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString when storing it to the persistent memory._♩(RS_PER_00005, RS_PER_00010)_

> 如果在清单中存在PersistencyDeploymentToCryptoKeySlotMapping，并且PersistencyDeploymentToCryptoKeySlotMapping.keySlotUsage设置为验证，则Persistency将使用PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString指定的算法为所有与存储相关的数据创建并存储消息认证码（MAC），当将其存储到持久性存储器时。♩（RS_PER_00005，RS_PER_00010）


**[SWS_PER_00466]** *[*If a PersistencyDeploymentElementToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentElementToCryptoKeySlotMapping.keySlotUsage is set to verification, the Persistency shall create and store a message authentication code (MAC) for the element data using the algorithm specified by PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString when storing it to the persistent memory._♩(RS_PER_00005, RS_PER_00010)_

> 如果在清单中存在PersistencyDeploymentElementToCryptoKeySlotMapping，并且PersistencyDeploymentElementToCryptoKeySlotMapping.keySlotUsage设置为verification，则Persistency在将其存储到持久存储器时，应使用PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString指定的算法为元素数据创建和存储消息认证码（MAC）。（RS_PER_00005，RS_PER_00010）


**[SWS_PER_00450]** *[*If a PersistencyDeploymentToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentToCryptoKeySlotMapping.keySlotUsage is set to verification, the Persistency shall verify the MAC of all data related to the storage using the algorithm specified by PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString after reading it from persistent memory._♩(RS_PER_00005, RS_PER_00010)_

> 如果在清单中存在PersistencyDeploymentToCryptoKeySlotMapping，且PersistencyDeploymentToCryptoKeySlotMapping.keySlotUsage设置为验证，则Persistency应使用PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString指定的算法，从持久存储器中读取后，验证与存储相关的所有数据的MAC。（RS_PER_00005，RS_PER_00010）


**[SWS_PER_00467]** *[*If a PersistencyDeploymentElementToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentElementToCryptoKeySlotMapping.keySlotUsage is set to verification, the Persistency shall verify the MAC of the element data using the algorithm specified by PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString after reading it from persistent memory._♩(RS_PER_00005, RS_PER_00010)_

> 如果在清单中存在PersistencyDeploymentElementToCryptoKeySlotMapping，并且PersistencyDeploymentElementToCryptoKeySlotMapping.keySlotUsage设置为验证，则持久性应该在从持久存储器读取后，使用PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString指定的算法验证元素数据的MAC。（RS_PER_00005，RS_PER_00010）


**[SWS_PER_00451]** *[*If PersistencyDeploymentToCryptoKeySlotMapping. verificationHash is available, the Persistency shall calculate a hash value over all data related to the storage using the hash algorithm specified by PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString and verify that the calculated hash value matches PersistencyDeploymentToCryptoKeySlotMapping.verificationHash._♩(RS_PER_00005, RS_PER_00010)_

> 如果PersistencyDeploymentToCryptoKeySlotMapping.verificationHash可用，则Persistency应使用PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString指定的哈希算法计算与存储相关的所有数据的哈希值，并验证所计算的哈希值与PersistencyDeploymentToCryptoKeySlotMapping.verificationHash匹配。(RS_PER_00005, RS_PER_00010)


**[SWS_PER_00468]** *[*If PersistencyDeploymentElementToCryptoKeySlotMapping.verificationHash is available, the Persistency shall calculate a hash value over the element data using the hash algorithm specified by PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString and verify that the calculated hash value matches PersistencyDeployment-

> 如果PersistencyDeploymentElementToCryptoKeySlotMapping.verificationHash可用，Persistency应使用PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString指定的哈希算法计算元素数据的哈希值，并验证所计算的哈希值与PersistencyDeployment相匹配。


ElementToCryptoKeySlotMapping.verificationHash._♩(RS_PER_00005, RS_PER_00010)_

> 元素到加密密钥槽映射。验证哈希。_♩（RS_PER_00005，RS_PER_00010）_


The Persistency will use the services of the Cryptography [5] for all cryptographic operations.

> 持久性将使用加密学[5]的服务进行所有加密操作。

### Redundancy Concepts


The Persistency shall take care of the integrity of the stored data, both for safety purposes and to prevent data loss. This can be achieved by calculating CRCs or hash values of the stored data, and by creating redundant copies. All these measures effectively create some redundancy for the stored data. The concrete measures to be taken are configurable: The application designer can use PersistencyInterface. redundancy to request redundancy (by setting it to redundant or redundantPerElement), or use PersistencyInterface.redundancyHandling to preselect the actual measures to be taken. During deployment, the integrator can define the actual measures taken to ensure data integrity using PersistencyDeployment.redundancyHandling. If PersistencyInterface.redundancyHandling is configured, the integrator shall use it as a guidance, but may also choose other, more appropriate measures based on superior knowledge of the final system.

> 持久性应该确保存储数据的完整性，既是出于安全目的，也是为了防止数据丢失。这可以通过计算存储数据的CRC或哈希值，以及创建冗余副本来实现。所有这些措施有效地为存储的数据创建了冗余。具体的措施是可配置的：应用程序设计师可以使用PersistencyInterface.redundancy请求冗余（通过将其设置为冗余或redundantPerElement），或者使用PersistencyInterface.redundancyHandling预先选择要采取的实际措施。在部署期间，集成器可以使用PersistencyDeployment.redundancyHandling定义确保数据完整性所采取的实际措施。如果配置了PersistencyInterface.redundancyHandling，集成器应该把它作为指导，但也可以根据对最终系统的更高级别的了解，选择其他更合适的措施。


**[SWS_PER_00317]** *[*The Persistency shall store redundant information for every storage represented by a PersistencyDeployment where PersistencyDeployment.redundancyHandling is configured._♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

> 持久性应为每个由PersistencyDeployment表示的存储存储冗余信息，其中PersistencyDeployment.redundancyHandling已配置。（RS_PER_00008，RS_PER_00009，RS_PER_00010）


The actual handling of the redundancy configured during deployment is described in the following sections, see also [[SWS_PER_00318](#_bookmark34)], [[SWS_PER_00319](#_bookmark35)], and [[SWS_PER_00447](#_bookmark36)].

> 实施部署时配置的冗余的实际处理方法在下面的章节中有描述，另请参见[[SWS_PER_00318](#_bookmark34)]、[[SWS_PER_00319](#_bookmark35)]和[[SWS_PER_00447](#_bookmark36)]。


[]{#\_bookmark22 .anchor}**[SWS_PER_00221]** *[*Persistency shall check the redundant data when accessing stored data. When the stored data is corrupted, Persistency shall try to restore it using the available redundancy. If Persistency is not able to recover using the redundancy, it shall report kValidationFailed._♩(RS_PER_00008)_

> 持久性在访问存储数据时应检查冗余数据。当存储的数据损坏时，持久性应尝试使用可用的冗余来恢复它。如果持久性无法使用冗余来恢复，它应报告kValidationFailed.♩（RS_PER_00008）


Depending on the actual implementation, Persistency might access the stored data at different times, e.g. when ara::core::Initialize is called, when a Key-

> 根据实际实现，持久性可能在不同时间访问存储的数据，例如当ara :: core :: Initialize被调用时，当Key-


-Value Storage is opened, or when a file is accessed. The question whether the redundancy is sufficient for recovery is also implementation specific and can only be safely assumed for PersistencyRedundancyMOutOfN.

> 值存储打开时或访问文件时，问题是冗余是否足够恢复，这也是实现特定的，只能安全地假设PersistencyRedundancyMOutOfN。


When the recovery failed, the application can choose to use ara::per::RecoverKeyValueStorage, ara::per::KeyValueStorage::RecoverKey, ara::per::RecoverAllFiles, or ara::per::FileStorage::RecoverFile to recover as much as possible and set the corresponding Key-Value Storage or File Storage again into a consistent state.

> 当恢复失败时，应用程序可以选择使用ara :: per :: RecoverKeyValueStorage，ara :: per :: KeyValueStorage :: RecoverKey，ara :: per :: RecoverAllFiles或ara :: per :: FileStorage :: RecoverFile来尽可能恢复，并将相应的键值存储或文件存储重新设置为一致的状态。


**[SWS_PER_00452]** *[*When ara::per::RecoverKeyValueStorage is called, Persistency shall restore the Key-Value Storage to a consistent state, including redundancy. First, the infrastructure of the whole Key-Value Storage shall be restored, then Persistency shall try to recover all key-value pairs available in the Key-Value Storage as described in [[SWS_PER_00453](#_bookmark23)]. Depending on available information, the whole Key-Value Storage might be reset to the initial state as described in [[SWS_PER_00456](#_bookmark25)], losing all updated values of its key-value pairs, or may contain outdated key-value pairs after the operation._♩(RS_PER_00009)_

> 当调用ara::per::RecoverKeyValueStorage时，持久性应将键值存储恢复到一致的状态，包括冗余。首先，恢复整个键值存储的基础架构，然后持久性应尝试根据[[SWS_PER_00453](#_bookmark23)]中描述的方式恢复键值存储中可用的所有键值对。根据可用的信息，整个键值存储可能会被重置为[[SWS_PER_00456](#_bookmark25)]中描述的初始状态，从而丢失其所有更新后的键值对值，或者操作完成后可能会包含过时的键值对。♩（RS_PER_00009）


**[SWS_PER_00547]** *[*When ara::per::KeyValueStorage::RecoverKey is called, Persistency shall first check whether the key-value pair is present in any instance of the Key-Value Storage, and otherwise return directly with kKeyNotFound._♩(RS_AP_00128)_

> 当调用ara::per::KeyValueStorage::RecoverKey时，Persistency应首先检查该键值对是否存在于Key-Value Storage的任何实例中，否则直接返回kKeyNotFound。♩（RS_AP_00128）


[]{#\_bookmark23 .anchor}**[SWS_PER_00453]** *[*When ara::per::KeyValueStorage::RecoverKey is called for an existing key-value pair, Persistency shall try to restore the given key to a consistent state, including redundancy. Depending on available information, the key might be removed, reset to the initial value as described in [[SWS_PER_00477](#_bookmark26)], or might contain an outdated value after the operation._♩ (RS_PER_00009)_

> 当调用ara::per::KeyValueStorage::RecoverKey对现有键值对进行恢复时，持久性应尝试将给定的键恢复到一致的状态，包括冗余。根据可用信息，该键可能会被删除，重置为[[SWS_PER_00477](#_bookmark26)]中描述的初始值，或者在操作后可能包含过时的值。（RS_PER_00009）


**[SWS_PER_00454]** *[*When ara::per::RecoverAllFiles is called, Persistency shall restore the File Storage to a consistent state, including redundancy. First, the infrastructure of the whole File Storage shall be restored as described in [[SWS_PER_00478](#_bookmark27)], then Persistency shall try to recover all currently available files as described in [[SWS_PER_00455](#_bookmark24)]. Depending on available information, the whole File Storage might be reset to the initial state, losing all updated content of its files, or may contain outdated files after the operation._♩(RS_PER_00009)_

> 当调用ara::per::RecoverAllFiles时，持久性应恢复文件存储到一个一致的状态，包括冗余。首先，应按照[[SWS_PER_00478](#_bookmark27)]中的描述恢复整个文件存储的基础结构，然后持久性应尝试恢复所有当前可用的文件，如[[SWS_PER_00455](#_bookmark24)]中所述。根据可用信息，整个文件存储可能会重置为初始状态，丢失其文件的所有更新内容，或者在操作后可能包含过时的文件。_♩(RS_PER_00009)_


**[SWS_PER_00548]** *[*When ara::per::FileStorage::RecoverFile is called, Persistency shall first check whether the file is present in the File Storage, and otherwise return directly with kFileNotFound._♩(RS_AP_00128)_

> 当调用ara::per::FileStorage::RecoverFile时，Persistency首先应检查文件是否存在于文件存储中，否则直接返回kFileNotFound。♩（RS_AP_00128）


[]{#\_bookmark24 .anchor}**[SWS_PER_00455]** *[*When ara::per::FileStorage::RecoverFile is called for an existing file, Persistency shall try to restore the given file to a consistent state, including redundancy. Depending on available information, the file might be removed, reset to the initial state as described in [[SWS_PER_00479](#_bookmark28)], or might contain outdated content after the operation._♩(RS_PER_00009)_

> 当调用ara::per::FileStorage::RecoverFile对已存在的文件时，Persistency应尝试将给定文件恢复到一致的状态，包括冗余。根据可用信息，文件可能被删除，重置为[[SWS_PER_00479](#_bookmark28)中描述的初始状态，或者在操作后可能会包含过时的内容。_♩（RS_PER_00009）_


Of course the application has to validate the restored data in this case.

> 在这种情况下，当然应用程序必须验证恢复的数据。


Or it can use ara::per::ResetPersistency (see [[SWS_PER_00556](#_bookmark41)]), ara::per::ResetKeyValueStorage, ara::per::KeyValueStorage::ResetKey, ara::per::ResetAllFiles, or ara::per::FileStorage::ResetFile to reset the corrupted item to the initial state according to the current manifest.

> 可以使用ara::per::ResetPersistency（参见[[SWS_PER_00556](#_bookmark41)）、ara::per::ResetKeyValueStorage、ara::per::KeyValueStorage::ResetKey、ara::per::ResetAllFiles或ara::per::FileStorage::ResetFile，根据当前的清单将损坏的项目重置为初始状态。


[]{#\_bookmark25 .anchor}**[SWS_PER_00456]** *[*When ara::per::ResetKeyValueStorage is called, Persistency shall reset the Key-Value Storage to the state it would have after installation of the application using the current manifest information._♩(RS_PER_00009)_

> 当调用ara::per::ResetKeyValueStorage时，持久性应将键值存储重置为使用当前清单信息安装应用程序后的状态。♩（RS_PER_00009）


[]{#\_bookmark26 .anchor}**[SWS_PER_00477]** *[*When ara::per::KeyValueStorage::ResetKey is called, Persistency shall reset the given key to the state it would have after installation of the application using the current manifest information. If the key is not available in the manifest, the call shall fail with kInitValueNotAvailable._♩(RS_PER_00009)_

> 当调用ara::per::KeyValueStorage::ResetKey时，Persistency应将给定的键重置为使用当前清单信息安装应用程序后的状态。如果清单中不存在该键，则调用将失败，并显示kInitValueNotAvailable。（RS_PER_00009）


[]{#\_bookmark27 .anchor}**[SWS_PER_00478]** *[*When ara::per::ResetAllFiles is called, Persistency shall reset the File Storage to the state it would have after installation of the application using the current manifest information._♩(RS_PER_00009)_

> 当调用ara::per::ResetAllFiles时，Persistency将重置文件存储到使用当前清单信息安装应用程序后的状态。♩（RS_PER_00009）


[]{#\_bookmark28 .anchor}**[SWS_PER_00479]** *[*When ara::per::FileStorage::ResetFile is called, Persistency shall reset the given file to the state it would have after installation of the application using the current manifest information. If the file is not available in the manifest, the call shall fail with kInitValueNotAvailable._♩ (RS_PER_00009)_

> 当调用ara::per::FileStorage::ResetFile时，Persistency应将给定文件重置为使用当前清单信息安装应用程序后的状态。如果文件在清单中不可用，则调用将失败，并显示kInitValueNotAvailable。（RS_PER_00009）


The application may want to monitor its storages for any problem detected by redundancy, even if Persistency is able to recover by itself. This might be required to e.g. get an early indication of hardware problems or for safety critical applications. This monitoring is supported by Persistency, which will trigger a callback function of the application in case of any problems with the storages. To activate this monitoring, the application has to register that callback function using ara::per::RegisterRecoveryReportCallback.

> 应用程序可能需要监控其存储以检测冗余所检测到的任何问题，即使持久性能够自行恢复。这可能是为了获得早期硬件问题的指示或安全关键应用程序所必需的。持久性支持此监控，并将在存储出现任何问题时触发应用程序的回调函数。要激活此监控，应用程序必须使用ara::per::RegisterRecoveryReportCallback注册该回调函数。


**[SWS_PER_00480]** *[*When ara::per::RegisterRecoveryReportCallback is called, Persistency shall register the provided function and enable reporting of redundancy problems in all storages of this application._♩(RS_PER_00008)_

> 当调用ara::per::RegisterRecoveryReportCallback时，Persistency应注册提供的函数，并启用此应用程序中所有存储的冗余问题报告。（RS_PER_00008）


Persistency may check redundancy at different places, e.g. when ara::core::Initialize is called, when a storage is opened, or when elements of the storage are accessed. Whenever a problem is detected with redundancy, independently of the situation in which the problem appeared or whether the problem could be handled, Persistency will inform the application about these problems via the registered callback, stating kKeyValueStorageRecovered, kKeyRecovered, kFileStorageRecovered, or kFileRecovered when recovery of a Key-

> 持久性可以在不同的地方检查冗余，例如当调用ara :: core :: Initialize，打开存储或访问存储元素时。无论出现何种问题，无论出现问题的情况如何或问题是否可以处理，持久性都会通过注册的回调通知应用程序，当恢复关键值存储时，指出kKeyValueStorageRecovered，kKeyRecovered，kFileStorageRecovered或kFileRecovered。


-Value Storage, a File Storage, a key-value pair, or a file was possible, and kKeyValueStorageRecoveryFailed, kKeyRecoveryFailed, kFileStorageRecoveryFailed, or kFileRecoveryFailed if not. The callback also reports the affected storage, the affected elements, and how many copies of these elements were affected (the latter only in case PersistencyRedundancyMOutOfN is configured).

> 值存储，文件存储，键值对或文件皆可能，若不行则会报告kKeyValueStorageRecoveryFailed、kKeyRecoveryFailed、kFileStorageRecoveryFailed或kFileRecoveryFailed。回调函数还会报告受影响的存储，受影响的元素以及这些元素受影响的副本数（仅当配置了PersistencyRedundancyMOutOfN时）。


**[SWS_PER_00481]** *[*When a Key-Value Storage is accessed, and a redundancy problem affecting the whole Key-Value Storage is detected that cannot be handled by Persistency (i.e. kValidationFailed is returned), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the Key-Value Storage, recoveryReportKind set to kKeyValueStorageRecoveryFailed, an empty ara::core::Vector for reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the Key-Value Storage in reportedInstances._♩(RS_PER_00008)_

> 当访问键值存储时，如果检测到影响整个键值存储的冗余问题而无法由持久性（即返回kValidationFailed）处理时，持久性应调用注册的回调，将存储设置为ara :: core :: InstanceSpecifier的键值存储，recoveryReportKind设置为kKeyValueStorageRecoveryFailed，报告元素的ara :: core :: Vector为空，以及ara :: core :: Vector中受影响的冗余实例的索引在reportedInstances中。


**[SWS_PER_00482]** *[*When a Key-Value Storage is accessed, and a redundancy problem affecting the whole Key-Value Storage is detected that can be handled by Persistency (i.e. the operation succeeds), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the Key-

> 当访问键值存储时，如果检测到影响整个键值存储的冗余问题可以通过持久性（即操作成功）来处理，持久性应该调用已注册的回调，将存储设置为ara :: core :: InstanceSpecifier的键值。


-Value Storage, recoveryReportKind set to kKeyValueStorageRecovered, an empty ara::core::Vector for reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the Key-Value Storage in reportedInstances._♩(RS_PER_00008)_

> 值存储，recoveryReportKind设置为kKeyValueStorageRecovered，一个空的ara :: core :: Vector用于报告元素，以及一个ara :: core :: Vector，其中包含受影响的冗余实例的索引Key-Value存储在reportedInstances中。(RS_PER_00008)


**[SWS_PER_00483]** *[*When a File Storage is accessed, and a redundancy problem affecting the whole File Storage is detected that cannot be handled by Persistency (i.e. kValidationFailed is returned), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the File Storage, recoveryReportKind set to kFileStorageRecoveryFailed, an empty ara::core::Vector for reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the File Storage in reportedInstances._♩(RS_PER_00008)_

> 当访问文件存储并检测到影响整个文件存储且无法由持久性处理的冗余问题时（即返回kValidationFailed），持久性应调用注册的回调，将存储设置为文件存储的ara::core::InstanceSpecifier，将recoveryReportKind设置为kFileStorageRecoveryFailed，将reportedElements设置为空的ara::core::Vector，并将受影响的冗余实例的索引设置为ara::core::Vector中的reportedInstances。


**[SWS_PER_00484]** *[*When a File Storage is accessed, and a redundancy problem affecting the whole File Storage is detected that can be handled by Persistency (i.e. the operation succeeds), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the File Storage, recoveryReportKind set to kFileStorageRecovered, an empty ara::core::Vector for reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the File Storage in reportedInstances._♩ (RS_PER_00008)_

> 当访问文件存储并检测到影响整个文件存储的冗余问题，并且该问题可以由持久性（即操作成功）处理时，持久性应调用注册的回调，将存储设置为文件存储的ara :: core :: InstanceSpecifier，recoveryReportKind设置为kFileStorageRecovered，报告元素的ara :: core :: Vector为空，并且ara :: core :: Vector包含受影响的冗余实例的索引在reportedInstances中。(RS_PER_00008)


[]{#\_bookmark29 .anchor}**[SWS_PER_00485]** *[*When a Key-Value Storage or one of its keys is accessed, and a redundancy problem affecting a set of keys is detected that cannot be handled by Persistency (i.e. kValidationFailed is returned), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the Key-Value Storage, recoveryReportKind set to kKeyRecoveryFailed, an ara::core::Vector with the affected keys in reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the keys in reportedInstances._♩(RS_PER_00008)_

> 当访问键值存储或其中的某个键时，如果检测到一组无法由持久性（即返回kValidationFailed）处理的冗余问题，持久性应调用注册的回调，将存储设置为ara::core::InstanceSpecifier的键值存储，recoveryReportKind设置为kKeyRecoveryFailed，ara::core::Vector元素为受影响的键，ara::core::Vector元素为受影响的键的冗余实例的索引。（RS_PER_00008）


[]{#\_bookmark30 .anchor}**[SWS_PER_00486]** *[*When a Key-Value Storage or one of its keys is accessed, and a redundancy problem affecting a set of keys is detected that can be handled by Persistency (i.e. the operation succeeds), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the Key-Value Storage, recoveryReportKind set to kKeyRecovered, an ara::core::Vector with the affected keys in reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the keys in reportedInstances._♩(RS_PER_00008)_

> 当访问键值存储或其中的某个键时，如果检测到影响一组键的冗余问题可以由持久性（即操作成功）处理时，持久性应调用注册的回调，将存储设置为ara :: core :: InstanceSpecifier的键值存储，recoveryReportKind设置为kKeyRecovered，ara :: core :: Vector中报告元素的受影响的键，以及ara :: core :: Vector中报告实例的受影响的冗余键的索引。_♩（RS_PER_00008）_


**[SWS_PER_00487]** *[*When a redundancy problem of single keys is reported according to [[SWS_PER_00485](#_bookmark29)] or [[SWS_PER_00486](#_bookmark30)], Persistency shall in general ensure that each entry in reportedElements matches an entry in reportedInstances at the same positions, the two ara::core::Vectors shall have the same size. If several instances of a key are affected, the key may appear several times in reportedElements. As an optimization, if only one key is affected, reportedElements may contain the affected key as single entry, related to all entries of

> 当根据[[SWS_PER_00485](#_bookmark29)]或[[SWS_PER_00486](#_bookmark30)]报告单键的冗余问题时，持久性通常应确保报告元素中的每个条目与相同位置上的报告实例中的条目匹配，两个ara :: core :: Vectors应具有相同的大小。 如果多个键受到影响，则该键可能会在报告元素中多次出现。 作为优化，如果只有一个键受到影响，则报告元素可以将受影响的键作为单个条目包含，与所有条目相关联。


reportedInstances._♩(RS_PER_00008)_

> 报告实例._♩（RS_PER_00008）_


[]{#\_bookmark31 .anchor}**[SWS_PER_00488]** *[*When a File Storage or one of its files is accessed, and a redundancy problem affecting a set of files is detected that cannot be handled by Persistency (i.e. kValidationFailed is returned), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the File Storage, recoveryReportKind set to kFileRecoveryFailed, an ara::core::Vector with the affected files in reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the files in reportedInstances._♩(RS_PER_00008)_

> 当访问文件存储或其中的一个文件时，如果检测到一组无法由持久性（即返回kValidationFailed）处理的冗余问题，持久性将使用存储设置为文件存储的ara :: core :: InstanceSpecifier，recoveryReportKind设置为kFileRecoveryFailed，ara :: core :: Vector以及受影响的文件中报告元素的索引以及受影响的文件的冗余实例的索引报告实例调用注册的回调。_♩（RS_PER_00008）_


[]{#\_bookmark32 .anchor}**[SWS_PER_00489]** *[*When a File Storage or one of its files is accessed, and a redundancy problem affecting a set of files is detected that can be handled by Persistency (i.e. the operation succeeds), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the File Storage, recoveryReportKind set to kFileRecovered, an ara::core::Vector with the affected files in reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the files in reportedInstances._♩(RS_PER_00008)_

> 当访问文件存储或其中的一个文件时，如果检测到影响一组文件的冗余问题可以由持久性（即操作成功）处理，持久性应调用已注册的回调，其中storage设置为File Storage的ara :: core :: InstanceSpecifier，recoveryReportKind设置为kFileRecovered，ara :: core :: Vector中包含受影响的文件在reportedElements中，以及ara :: core :: Vector中包含受影响的文件冗余实例的索引在reportedInstances中。_♩（RS_PER_00008）_


**[SWS_PER_00490]** *[*When a redundancy problem of single file is reported according to [[SWS_PER_00488](#_bookmark31)] or [[SWS_PER_00489](#_bookmark32)], Persistency shall in general ensure that each entry in reportedElements matches an entry in reportedInstances at the same positions, the two ara::core::Vectors shall have the same size. If several instances of a file are affected, the file may appear several times in reportedElements. As an optimization, if only one file is affected, reportedElements may contain the affected file as single entry, related to all entries of reportedInstances._♩(RS_PER_00008)_

> 当根据[[SWS_PER_00488](#_bookmark31)]或[[SWS_PER_00489](#_bookmark32)]报告单个文件的冗余问题时，持久性通常应确保报告元素中的每个条目与相同位置上的报告实例中的条目匹配，两个ara :: core :: Vectors应具有相同的大小。 如果多个文件受到影响，则该文件可能会在报告元素中出现多次。 作为优化，如果只有一个文件受影响，则报告元素可以将受影响的文件作为单个条目包含，与报告实例的所有条目相关联。_♩(RS_PER_00008)_

### Redundancy Types


The type of redundancy that is applied by the Persistency is defined by the set of PersistencyRedundancyHandling classes aggregated as PersistencyDeployment.redundancyHandling. The level to which redundancy is applied is defined by the possible values of the PersistencyRedundancyHandlingScopeEnum, which are persistencyRedundancyHandlingScopeStorage and persistencyRedundancyHandlingScopeElement for a Key-Value Storage and its key-value pairs, or a File Storage and its files, respectively.

> 持久性所应用的冗余类型由作为持久性部署的冗余处理类集合定义。冗余应用的程度由PersistencyRedundancyHandlingScopeEnum的可能值定义，其中针对键值存储及其键值对或文件存储及其文件分别为persistencyRedundancyHandlingScopeStorage和persistencyRedundancyHandlingScopeElement。


[]{#\_bookmark34 .anchor}**[SWS_PER_00318]** *[*In case a PersistencyRedundancyHandling aggregated as PersistencyDeployment.redundancyHandling is derived as PersistencyRedundancyCrc, the Persistency shall calculate a CRC value when persisting the storage or an element of the storage (depending on PersistencyDeployment.redundancyHandling.scope), and shall use this CRC to check the storage or the element when it is read back._♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

> 如果PersistencyRedundancyHandling被聚合为PersistencyDeployment.redundancyHandling，并被派生为PersistencyRedundancyCrc，那么Persistency在持久化存储或存储的元素（取决于PersistencyDeployment.redundancyHandling.scope）时，应计算CRC值，并使用该CRC值在读取存储或元素时检查。♩（RS_PER_00008，RS_PER_00009，RS_PER_00010）


**[SWS_PER_00439]** *[*Persistency shall calculate the CRC value using the algorithm defined by PersistencyRedundancyCrc.algorithmFamily with the bit width defined by PersistencyRedundancyCrc.length._♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

> **[SWS_PER_00439]** *[*持久性应使用PersistencyRedundancyCrc.algorithmFamily定义的算法，使用PersistencyRedundancyCrc.length定义的位宽计算CRC值。♩（RS_PER_00008，RS_PER_00009，RS_PER_00010）_*


[]{#\_bookmark35 .anchor}**[SWS_PER_00319]** *[*In case a PersistencyRedundancyHandling aggregated as PersistencyDeployment.redundancyHandling is derived as PersistencyRedundancyMOutOfN, the Persistency shall store N copies when persisting the storage or an element of the storage (depending on PersistencyDeployment. redundancyHandling.scope), and shall check that at least M of the N copies of the storage or the element are identical when it is read back. N is defined by n, and M is defined by m._♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

> 如果将持久性冗余处理聚合为持久性部署冗余处理，则持久性应在持久化存储或存储的元素（取决于持久性部署冗余处理的范围）时存储N个副本，并在读回时检查N个副本中至少M个副本是相同的。N由n定义，M由m定义。（RS_PER_00008，RS_PER_00009，RS_PER_00010）


It is possible to configure more than one PersistencyDeployment.deploymentUri for a storage that uses PersistencyRedundancyMOutOfN. In this case, the copies will be distributed over the different locations. The existence of multiple URIs for a single storage is limited to this case by [constr_10366].

> 可以为使用PersistencyRedundancyMOutOfN的存储配置多个PersistencyDeployment.deploymentUri。在这种情况下，副本将分布在不同的位置。单个存储的多个URI的存在仅限于此情况[constr_10366]。


**[SWS_PER_00555]** *[*In case multiple PersistencyDeployment.deploymentUris exist, and PersistencyDeployment.redundancyHandling.scope is persistencyRedundancyHandlingScopeStorage, Persistency shall store the copies of the storage in the different locations as follows:

> **[SWS_PER_00555]** 如果存在多个PersistencyDeployment.deploymentUris，且PersistencyDeployment.redundancyHandling.scope为persistencyRedundancyHandlingScopeStorage，则Persistency应将存储的副本按下列方式存储在不同位置：


**2** The first location contains the main copy, the second location contains all other copies.

> 第一个位置包含主要副本，第二个位置包含所有其他副本。


**n** (== PersistencyRedundancyMOutOfN.n) Each copy is placed in a separate location.

> 每份副本都放在不同的位置（**n**（等于PersistencyRedundancyMOutOfN.n））


_♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

> _♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

♩(RS_PER_00008、RS_PER_00009、RS_PER_00010)


[]{#\_bookmark36 .anchor}**[SWS_PER_00447]**{DRAFT} *[*In case a PersistencyRedundancyHandling aggregated as PersistencyDeployment.redundancyHandling is derived as PersistencyRedundancyHash, the Persistency shall calculate a hash value when persisting the storage or an element of the storage (depending on PersistencyDeployment.redundancyHandling.scope), and shall use this hash value to check the storage or the element when it is read back._♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

> 如果将持久性冗余处理聚合为持久性部署冗余处理，并从中派生出持久性冗余散列，持久性应当在持久化存储或存储的元素（取决于持久性部署冗余处理的范围）时计算散列值，并使用该散列值在读取存储或元素时检查。（RS_PER_00008，RS_PER_00009，RS_PER_00010）


**[SWS_PER_00448]**{DRAFT} *[*Persistency shall calculate the hash value using the algorithm defined by PersistencyRedundancyHash.algorithmFamily with the bit width defined by PersistencyRedundancyHash.length. If PersistencyRedundancyHash.initializationVectorLength is configured, an initialization vector of this length shall be calculated containing random data and passed to the hash algorithm._♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

> **[SWS_PER_00448]**{草案} *[*Persistency 应使用由 PersistencyRedundancyHash.algorithmFamily 定义的算法，以 PersistencyRedundancyHash.length 定义的位宽计算哈希值。如果配置了 PersistencyRedundancyHash.initializationVectorLength，则应计算包含随机数据的此长度的初始化向量，并将其传递给哈希算法。♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_


A possible approach to calculate the hash value and the random data would be to use the Cryptography [5]. The integration will have to take care that the configured PersistencyRedundancyHash.length and PersistencyRedundancy-

> 可能的计算哈希值和随机数据的方法是使用密码学[5]。集成将需要确保配置的PersistencyRedundancyHash.length和PersistencyRedundancy-。


Hash.initializationVectorLength are supported by the configured PersistencyRedundancyHash.algorithmFamily.

> 配置的PersistencyRedundancyHash.algorithmFamily支持Hash.initializationVectorLength。

### Installation and Update of Persistent Data


The Update and Configuration Management [6] handles the life cycle of Adaptive Applications with the following phases:

> 更新和配置管理[6]处理自适应应用程序的生命周期，具有以下阶段：

- Installation of new software
- Update of already installed software
- Finalization of updated software after the update succeeded
- Roll-back of updated software after the update failed
- Removal of installed software


For all these phases, persistent data needs to be handled alongside the application. The Adaptive Application may trigger this handling explicitly by calling ara::per::UpdatePersistency during the verification phase that follows the installation or update, or rely on the Persistency to do this implicitly when persistent data is accessed (ara::per::OpenKeyValueStorage/ara::per::OpenFileStorage). In both cases, the Persistency will compare the stored manifest version against the current manifest version, and perform the required action.

> 所有这些阶段，都需要处理持久性数据，并且应用程序也要一起处理。自适应应用程序可以显式地调用ara :: per :: UpdatePersistency，以在安装或更新后的验证阶段触发此处理，或者依靠持久性来隐式执行此操作，当访问持久性数据时（ara :: per :: OpenKeyValueStorage / ara :: per :: OpenFileStorage）。在两种情况下，持久性都将比较存储的清单版本与当前清单版本，并执行所需的操作。


Persistency stores information about already installed storages together with version information in a central location.

> 持久性在一个中央位置存储已安装存储的信息以及版本信息。


**[SWS_PER_00463]**{DRAFT} *[*Persistency shall store information about the installed Key-Value Storages and File Storages in the location denoted by ProcessToMachineMapping.persistencyCentralStorageURI of the ProcessToMachineMapping that refers to the Process that is referenced by PersistencyPortPrototypeToDeploymentMappings. It shall also store the current manifest version in this location._♩(RS_PER_00010, RS_PER_00012, RS_PER_00013, RS_PER_00014, RS_PER_00016)_

> 持久性应将有关已安装的键值存储和文件存储的信息存储在ProcessToMachineMapping.persistencyCentralStorageURI所指示的位置，该ProcessToMachineMapping引用由PersistencyPortPrototypeToDeploymentMappings引用的进程。它还应在此位置存储当前清单版本。


**[SWS_PER_00469]** *[*When ara::per::UpdatePersistency is called, the Persistency shall follow [[SWS_PER_00382](#_bookmark43)] (for installation), [[SWS_PER_00386](#_bookmark56)] and [[SWS_PER_00387](#_bookmark57)] (for update), or [[SWS_PER_00396](#_bookmark63)] (for roll-back) for each storage configured as PersistencyDeployment in the deployment data._♩(RS_PER_00010, RS_PER_00012, RS_PER_00013, RS_PER_00014)_

> 当调用ara::per::UpdatePersistency时，持久性应遵循部署数据中配置为PersistencyDeployment的每个存储的[[SWS_PER_00382](#_bookmark43)]（安装）、[[SWS_PER_00386](#_bookmark56)]和[[SWS_PER_00387](#_bookmark57)]（更新）或[[SWS_PER_00396](#_bookmark63)]（回滚）。_♩（RS_PER_00010，RS_PER_00012，RS_PER_00013，RS_PER_00014）_


**[SWS_PER_00470]** *[*When a Key-Value Storage is opened by the application using ara::per::OpenKeyValueStorage, the Persistency shall follow [[SWS_PER_00382](#_bookmark43)] (for installation), [[SWS_PER_00386](#_bookmark56)] and [[SWS_PER_00387](#_bookmark57)] (for update), [[SWS_PER_00446](#_bookmark61)] (for finalization), or [[SWS_PER_00396](#_bookmark63)] (for roll-back) for this Key-Value Storage configured as PersistencyKeyValueStorage in the deployment data._♩(RS_PER_00010, RS_PER_00012, RS_PER_00013, RS_PER_00014, RS_PER_00016)_

> 当应用程序使用ara::per::OpenKeyValueStorage打开键值存储时，持久性必须遵循部署数据中配置为PersistencyKeyValueStorage的此键值存储的[[SWS_PER_00382](#_bookmark43)]（安装）、[[SWS_PER_00386](#_bookmark56)]和[[SWS_PER_00387](#_bookmark57)]（更新）、[[SWS_PER_00446](#_bookmark61)]（完成）或[[SWS_PER_00396](#_bookmark63)]（回滚）。♩（RS_PER_00010、RS_PER_00012、RS_PER_00013、RS_PER_00014、RS_PER_00016）


**[SWS_PER_00471]** *[*When a File Storage is opened by the application using ara::per::OpenFileStorage, the Persistency shall follow [[SWS_PER_00382](#_bookmark43)] (for installation), [[SWS_PER_00386](#_bookmark56)] and [[SWS_PER_00387](#_bookmark57)] (for update), [[SWS_PER_00446](#_bookmark61)] (for finalization), or [[SWS_PER_00396](#_bookmark63)] (for roll-back) for each File Storage configured as PersistencyFileStorage in the deployment data._♩(RS_PER_00010, RS_PER_00012, RS_PER_00013, RS_PER_00014, RS_PER_00016)_

> 当应用程序使用ara::per::OpenFileStorage打开文件存储时，持久性将遵循部署数据中配置为PersistencyFileStorage的每个文件存储的[[SWS_PER_00382](#_bookmark43)]（安装）、[[SWS_PER_00386](#_bookmark56)]和[[SWS_PER_00387](#_bookmark57)]（更新）、[[SWS_PER_00446](#_bookmark61)]（完成）或[[SWS_PER_00396](#_bookmark63)]（回滚）。♩（RS_PER_00010，RS_PER_00012，RS_PER_00013，RS_PER_00014，RS_PER_00016）


**[SWS_PER_00378]** *[*Persistency shall extract the Executable.version and the PersistencyDeployment.version from the manifest, and store them persistently in the location denoted by ProcessToMachineMapping.persistencyCentralStorageURI._♩(RS_PER_00010, RS_PER_00013, RS_PER_00014)_

> **[SWS_PER_00378]** *[*持久性应从清单中提取可执行文件版本和持久性部署版本，并将它们持久地存储在由ProcessToMachineMapping.persistencyCentralStorageURI指定的位置。_♩（RS_PER_00010，RS_PER_00013，RS_PER_00014）_


The Executable.version is used by Persistency to detect a change of the application (see [[SWS_PER_00387](#_bookmark57)]), while the PersistencyDeployment.version is used to detect a change of the deployed persistent data (see [[SWS_PER_00386](#_bookmark56)] and [[SWS_PER_00396](#_bookmark63)]).

> 执行文件版本（Executable.version）被持久性（Persistency）用来检测应用程序的变化（参见[[SWS_PER_00387](#_bookmark57)），而持久性部署版本（PersistencyDeployment.version）用于检测部署的持久数据的变化（参见[[SWS_PER_00386](#_bookmark56)]和[[SWS_PER_00396](#_bookmark63)）。


**[SWS_PER_CONSTR_00001]**{DRAFT} *[*When the Executable.version is increased, the PersistencyDeployment.version needs to be increased, too._♩(RS_PER_00010, RS_PER_00012)_

> 当可执行文件的版本增加时，持久性部署的版本也需要增加（参考RS_PER_00010和RS_PER_00012）。


The PersistencyDeployment.version and Executable.version are StrongRevisionLabelStrings. These strings consists of a MajorVersion, a MinorVersion, a PatchVersion, and additional labels for pre-release versions and build information. It is assumed that at least one of the first three will be incremented when the version is changed, while the additional labels might be arbitrary.

> PersistencyDeployment.version和Executable.version都是StrongRevisionLabelStrings。这些字符串由MajorVersion、MinorVersion、PatchVersion和预发布版本和构建信息的附加标签组成。假定在更改版本时，至少会增加其中的一个，而附加标签可以是任意的。


**[SWS_PER_CONSTR_00002]**{DRAFT} *[*When the PersistencyDeployment. version or Executable.version is increased, the MajorVersion, MinorVersion, or PatchVersion have to be incremented._♩(RS_PER_00010, RS_PER_00012)_

> 当PersistencyDeployment.版本或Executable.版本增加时，MajorVersion、MinorVersion或PatchVersion必须增加。(RS_PER_00010，RS_PER_00012)


After installation of the Adaptive Application, the Persistency will install predefined persistent data from the manifest. There are different possibilities how this persistent data can be defined in the manifest:

> 安装自适应应用程序后，持久性将从清单中安装预定义的持久数据。清单中可以使用不同的方式定义这些持久数据：


- Persistent data can be defined by an application designer within PersistencyKeyValueStorageInterface or PersistencyFileStorageInterface.

> 持久数据可以由应用程序设计师在PersistencyKeyValueStorageInterface或PersistencyFileStorageInterface中定义。

- Persistent data that was defined by an application designer can be changed and fine-tuned by an integrator within PersistencyKeyValueStorage or PersistencyFileStorage.

> 按照应用程序设计者定义的持久数据可以在PersistencyKeyValueStorage或PersistencyFileStorage中被集成者更改和微调。

- Persistent data can be directly defined by an integrator within PersistencyKeyValueStorage or PersistencyFileStorage.

> 持久数据可以由PersistencyKeyValueStorage或PersistencyFileStorage中的集成器直接定义。


[]{#\_bookmark38 .anchor}**[SWS_PER_00379]** *[*Elements defined in the deployment data (PersistencyDeploymentElement) shall always be preferred over the elements defined in the application design (PersistencyInterfaceElement). The latter shall only be used if the former does not exist._♩(RS_PER_00010, RS_PER_00012, RS_PER_00013)_

> 在部署数据（PersistencyDeploymentElement）中定义的元素总是优先于应用程序设计（PersistencyInterfaceElement）中定义的元素。前者不存在时，才能使用后者。（RS_PER_00010，RS_PER_00012，RS_PER_00013）


After an update of the Adaptive Application or the manifest, the Persistency will create a backup of the persistent data, and then update the existing persistent data using one of the following strategies:

> 更新Adaptive Application或清單後，持久性將會創建持久數據的備份，然後使用以下策略之一更新現有的持久數據：

- Existing persistent data is kept unchanged (keepExisting).
- Existing persistent data is replaced (overwrite).
- Existing persistent data is removed (delete).
- New persistent data is added (keepExisting and overwrite).


The update strategy can be set during application design or deployment, and can be defined for the whole Key-Value Storage or File Storage (PersistencyCollectionLevelUpdateStrategyEnum -keepExisting or delete) and for a single key-value pair or file (PersistencyElementLevelUpdateStrategyEnum -keepExisting, overwrite, or delete).

> 更新策略可以在应用程序设计或部署期间设置，可以为整个键值存储或文件存储（PersistencyCollectionLevelUpdateStrategyEnum -keepExisting或delete）定义，也可以为单个键值对或文件（PersistencyElementLevelUpdateStrategyEnum -keepExisting，overwrite或delete）定义。


[]{#\_bookmark39 .anchor}**[SWS_PER_00251]** *[*An update strategy defined in the deployment data (PersistencyDeploymentElement.updateStrategy) shall always be preferred over the update strategy defined in the application design (PersistencyInterfaceElement.updateStrategy). The latter shall only be used if the former does not exist._♩ (RS_PER_00010, RS_PER_00012, RS_PER_00013)_

> 按照部署数据（PersistencyDeploymentElement.updateStrategy）定义的更新策略总是优先于应用程序设计（PersistencyInterfaceElement.updateStrategy）中定义的更新策略。只有在前者不存在时，才使用后者（RS_PER_00010，RS_PER_00012，RS_PER_00013）。


PersistencyDeployment.updateStrategy is a mandatory attribute and therefore PersistencyInterface.updateStrategy is just a recommendation for the deployment and never used by Persistency.

> 持久性部署的更新策略是一个必需的属性，因此持久性接口的更新策略只是对部署的建议，而不会被持久性使用。


[]{#\_bookmark40 .anchor}**[SWS_PER_00380]** *[*An update strategy defined for a single element (PersistencyDeploymentElement.updateStrategy, PersistencyInterfaceElement. updateStrategy) shall always be preferred over the update strategy defined for the enclosing storage (PersistencyDeployment.updateStrategy, PersistencyInterface.updateStrategy). The latter shall only be used if the former does not exist._♩(RS_PER_00010, RS_PER_00012, RS_PER_00013)_

> 一个元素（PersistencyDeploymentElement.updateStrategy，PersistencyInterfaceElement.updateStrategy）定义的更新策略总是优先于包围存储（PersistencyDeployment.updateStrategy，PersistencyInterface.updateStrategy）定义的更新策略。只有在前者不存在的情况下，才使用后者。（RS_PER_00010，RS_PER_00012，RS_PER_00013）


When the update succeeded, the Update and Configuration Management will finalize the new Adaptive Application. The Persistency will free the resources allocated by the last backup when it is opened the first time after the update succeeded.

> 当更新成功时，更新和配置管理将完成新的自适应应用程序。持久性将在更新成功后第一次打开时释放上次备份分配的资源。


When the update failed, the Update and Configuration Management will revert to the old Adaptive Application and/or manifest. The Persistency will then replace the currently used persistent data by the backup created during the update.

> 当更新失败时，更新和配置管理将恢复到旧的自适应应用程序和/或清单。持久性将用备份在更新期间创建的数据替换当前使用的持久数据。


The application can always reset its storages or elements of the storages to their initial state, using ara::per::ResetPersistency, ara::per::ResetKeyValueStorage (see [[SWS_PER_00456](#_bookmark25)]), ara::per::KeyValueStorage::ResetKey (see [[SWS_PER_00477](#_bookmark26)]), ara::per::ResetAllFiles (see [[SWS_PER_00478](#_bookmark27)]), or ara::per::FileStorage::ResetFile (see [[SWS_PER_00479](#_bookmark28)]).

> 应用程序可以使用ara::per::ResetPersistency、ara::per::ResetKeyValueStorage（参见[[SWS_PER_00456](#_bookmark25)]）、ara::per::KeyValueStorage::ResetKey（参见[[SWS_PER_00477](#_bookmark26)]）、ara::per::ResetAllFiles（参见[[SWS_PER_00478](#_bookmark27)]）或ara::per::FileStorage::ResetFile（参见[[SWS_PER_00479](#_bookmark28)]）将其存储或存储元素始终重置为其初始状态。


[]{#\_bookmark41 .anchor}**[SWS_PER_00556]** *[*When ara::per::ResetPersistency is called, Persistency shall reset all Key-Value Storages and File Storages to the state they would have after installation of the application using the current manifest information._♩(RS_PER_00010, RS_PER_00012)_

> 当调用ara::per::ResetPersistency时，持久性应使用当前清单信息将所有键值存储和文件存储重置为安装应用程序后的状态。(RS_PER_00010, RS_PER_00012)


Finally, when the Adaptive Application is removed, the Update and Configuration Management is responsible to remove the related persistent data as well.

> 最后，当自适应应用程序被删除时，更新和配置管理负责删除相关的持久数据。

### Installation of Persistent Data


[]{#\_bookmark43 .anchor}**[SWS_PER_00382]** *[*When a storage is opened by the application, the Persistency shall check for the existence of any persistent data of this Process. If no persistent data is found, the Persistency shall initialize the persistent data._♩(RS_PER_00010, RS_PER_00012)_

> 当应用程序打开存储时，持久性应检查此进程的任何持久数据的存在。如果未发现持久数据，持久性应初始化持久数据。♩（RS_PER_00010，RS_PER_00012）


Initialization of persistent data is described in [paragraph](#installation-of-key-value-storage) [7.2.6.1.1](#installation-of-key-value-storage) and [paragraph](#installation-of-file-storage) [7.2.6.1.2](#installation-of-file-storage).

> 初始化持久数据在[段落](#installation-of-key-value-storage) [7.2.6.1.1](#installation-of-key-value-storage) 和[段落](#installation-of-file-storage) [7.2.6.1.2](#installation-of-file-storage) 中有描述。


To be able to update Persistency with changed redundancy, Persistency stores the information about the used redundancy measures within the meta data of each storage. The same applies to the used keys and algorithms for encryption and authentication.

> 为了能够使用更改后的冗余更新持久性，持久性存储每个存储的元数据中使用的冗余措施的信息。同样适用于用于加密和认证的密钥和算法。


**[SWS_PER_00558]** *[*When a new storage is installed, Persistency shall store the information about the used redundancy in the meta data of the storage._♩(RS_PER_00008, RS_PER_00010, RS_PER_00012)_

> 当安装新存储时，持久性应将关于所使用冗余的信息存储在存储的元数据中。（RS_PER_00008，RS_PER_00010，RS_PER_00012）

> **[SWS_PER_00559]** *[*When a new storage is installed, Persistency shall store the information about keys and algorithms used for encryption and authentication in the meta data of the storage._♩(RS_PER_00005, RS_PER_00010, RS_PER_00012)_

### Installation of Key-Value Storage


[]{#\_bookmark45 .anchor}**[SWS_PER_00383]** *[*Persistency shall create a Key-Value Storage for each PortPrototype typed by a PersistencyKeyValueStorageInterface that is found in the manifest of a newly installed Adaptive Application._♩(RS_PER_00010, RS_PER_00012)_

> 持久性应为每个通过PersistencyKeyValueStorageInterface在新安装的自适应应用程序清单中指定的PortPrototype创建一个键值存储（RS_PER_00010，RS_PER_00012）。


The Key-Value Storages created by [[SWS_PER_00383](#_bookmark45)] are identified at runtime by the shortName path of the PortPrototype, passed as ara::core::InstanceSpecifier to ara::per::OpenKeyValueStorage.

> 由[[SWS_PER_00383](#_bookmark45)]创建的键值存储在运行时由PortPrototype的shortName路径标识，作为ara::core::InstanceSpecifier传递给ara::per::OpenKeyValueStorage。


[]{#\_bookmark46 .anchor}**[SWS_PER_00252]** *[*Persistency shall create an entry in the Key-Value Storage for each PersistencyKeyValueStorageInterface.dataElement and PersistencyKeyValueStorage.keyValuePair that is found in the manifest of a newly installed or updated Adaptive Application, and for which the update strategy is not delete._♩(RS_PER_00010, RS_PER_00012)_

> 每当安装或更新自适应应用程序的清单中发现PersistencyKeyValueStorageInterface.dataElement和PersistencyKeyValueStorage.keyValuePair，且更新策略不是删除时，持久性将在键值存储中创建一个条目。♩（RS_PER_00010，RS_PER_00012）


Key-Value Storage entries are identified by the key. An entry with identical key might be defined both in the PersistencyKeyValueStorageInterface as dataElement and the PersistencyKeyValueStorage as keyValuePair, in which case [[SWS_PER_00379](#_bookmark38)] applies. The update strategy is determined according to [[SWS_PER_00251](#_bookmark39)] and [[SWS_PER_00380](#_bookmark40)].

> 条目的标识符是键。在PersistencyKeyValueStorageInterface中定义具有相同键的条目作为dataElement，并且在PersistencyKeyValueStorage中定义为keyValuePair时，将遵循[[SWS_PER_00379](#_bookmark38)]。更新策略将根据[[SWS_PER_00251](#_bookmark39)]和[[SWS_PER_00380](#_bookmark40)]来确定。


[]{#\_bookmark47 .anchor}**[SWS_PER_00253]** *[*Entries in the Key-Value Storage shall use the shortName of the PersistencyDataElement and/or PersistencyKeyValuePair as key._♩ (RS_PER_00010, RS_PER_00012)_

> 在键值存储中的条目应使用PersistencyDataElement和/或PersistencyKeyValuePair的shortName作为键（RS_PER_00010，RS_PER_00012）


[]{#\_bookmark48 .anchor}**[SWS_PER_00254]** *[*Entries in the Key-Value Storage shall be created with the data type defined by the CppImplementationDataType which types the PersistencyDataElement and/or by the CppImplementationDataType referenced as PersistencyKeyValuePair.valueDataType._♩(RS_PER_00010, RS_PER_00012)_

> 在键值存储中的条目应使用由CppImplementationDataType定义的数据类型创建，该类型类型化PersistencyDataElement，或者引用为PersistencyKeyValuePair.valueDataType的CppImplementationDataType。（RS_PER_00010，RS_PER_00012）


[]{#\_bookmark49 .anchor}**[SWS_PER_00384]** *[*Entries in the Key-Value Storage shall be created with the value taken from the PersistencyKeyValuePair.initValue or, if that does not exist, from the PersistencyDataRequiredComSpec.initValue._♩(RS_PER_00010, RS_PER_00012)_

> 在键值存储中的条目应使用PersistencyKeyValuePair.initValue的值创建，如果不存在，则使用PersistencyDataRequiredComSpec.initValue的值。（RS_PER_00010，RS_PER_00012）


**[SWS_PER_CONSTR_00003]** *[*A manifest is not valid if the value or data type of any PersistencyKeyValuePair or PersistencyDataElement cannot be determined, or if the determined data types are conflicting._♩(RS_PER_00010, RS_PER_00012)_

> **[SWS_PER_CONSTR_00003]** 如果任何PersistencyKeyValuePair或PersistencyDataElement的值或数据类型无法确定，或者确定的数据类型相互冲突，则清单无效（RS_PER_00010，RS_PER_00012）。


Invalid manifests should be rejected by the tooling.

> 工具应该拒绝无效的清单。

### Installation of File Storage


[]{#\_bookmark51 .anchor}**[SWS_PER_00385]** *[*Persistency shall create a File Storage for each PortPrototype typed by a PersistencyFileStorageInterface that is found in the manifest of a newly installed Adaptive Application._♩(RS_PER_00010, RS_PER_00012)_

> 持久性应为每个由持久性文件存储器接口（在新安装的自适应应用程序的清单中发现）类型的PortPrototype创建一个文件存储（SWS_PER_00385）。（RS_PER_00010，RS_PER_00012）


The File Storages created by [[SWS_PER_00385](#_bookmark51)] are identified at run-time by the shortName path of the PortPrototype, passed as ara::core::InstanceSpecifier to ara::per::OpenFileStorage.

> 文件存储由[[SWS_PER_00385](#_bookmark51)]创建，在运行时通过作为ara::core::InstanceSpecifier传递的PortPrototype的简称路径来识别，并由ara::per::OpenFileStorage打开。


[]{#\_bookmark52 .anchor}**[SWS_PER_00265]** *[*Persistency shall create a file in the File Storage for each PersistencyFileStorageInterface.fileElement and PersistencyFileStorage.file that is found in the manifest of a newly installed or updated Adaptive Application, and for which the update strategy is not delete._♩(RS_PER_00010, RS_PER_00012)_

> 持久性应为新安装或更新的自适应应用程序的清单中发现的每个PersistencyFileStorageInterface.fileElement和PersistencyFileStorage.file创建一个文件存储中的文件，其更新策略不是删除。(RS_PER_00010，RS_PER_00012)


The files within a File Storage are identified by their file name. A file with the same file name might be defined both in the PersistencyFileStorageInterface as fileElement and the PersistencyFileStorage as file, in which case [[SWS_PER_00379](#_bookmark38)] applies. The update strategy is determined according to [[SWS_PER_00251](#_bookmark39)] and [[SWS_PER_00380](#_bookmark40)].

> 文件存储中的文件由其文件名标识。 同一文件名的文件可以在PersistencyFileStorageInterface中定义为fileElement，也可以在PersistencyFileStorage中定义为file，在这种情况下，将适用[[SWS_PER_00379](#_bookmark38)]。 更新策略根据[[SWS_PER_00251](#_bookmark39)]和[[SWS_PER_00380](#_bookmark40)]确定。


[]{#\_bookmark53 .anchor}**[SWS_PER_00266]** *[*Files in the File Storage shall use the file name identified by PersistencyFileElement.fileName and/or PersistencyFile.fileName._♩(RS_PER_00010, RS_PER_00012)_

> 文件存储中的文件应使用PersistencyFileElement.fileName和/或PersistencyFile.fileName标识的文件名（RS_PER_00010，RS_PER_00012）。


[]{#\_bookmark54 .anchor}**[SWS_PER_00267]** *[*Files in the File Storage shall be created with the content taken from the resource (within the installed SoftwarePackage) that is addressed by PersistencyFile.contentUri or, if that does not exist, by PersistencyFileElement.contentUri. If that does not exist either, an empty file shall be created._♩(RS_PER_00010, RS_PER_00012)_

> 文件存储中的文件应以PersistencyFile.contentUri或者PersistencyFileElement.contentUri指向的安装的软件包资源中的内容创建，如果不存在，则应创建一个空文件。♩（RS_PER_00010，RS_PER_00012）


**[SWS_PER_CONSTR_00004]** *[*A manifest is invalid if the shortNames of a PersistencyFileElement and a PersistencyFile with the same file name differs._♩(RS_PER_00010, RS_PER_00012)_

> **[SWS_PER_CONSTR_00004]** 如果持久性文件元素和具有相同文件名称的持久性文件的短名称不同，则清单无效。♩（RS_PER_00010，RS_PER_00012）


Invalid manifests should be rejected by the tooling.

> 工具应该拒绝无效的清单。

### Update of Persistent Data


[]{#\_bookmark56 .anchor}**[SWS_PER_00386]** *[*When a storage is opened by the application, the Persistency shall compare the PersistencyDeployment.version in the manifest against the stored version. If the version in the manifest is higher than the stored version, the Persistency shall first create a backup of all the persistent data of this Process and then update the data._♩(RS_PER_00010, RS_PER_00013)_

> 当应用程序打开存储时，持久性应比较清单中的PersistencyDeployment.version与存储的版本。如果清单中的版本高于存储的版本，持久性应首先创建此过程的所有持久数据的备份，然后更新数据。♩（RS_PER_00010，RS_PER_00013）


Only one set of backup data needs to be kept at any time. When a new update is performed, old backup data could be overwritten. Update of persistent data is described in [paragraph](#update-of-key-value-storage) [7.2.6.2.1](#update-of-key-value-storage) and [paragraph](#update-of-file-storage) [7.2.6.2.2](#update-of-file-storage).

> 只需要保留一份备份数据。当进行新的更新时，旧的备份数据可以被覆盖。持久数据的更新描述在[7.2.6.2.1](#update-of-key-value-storage)和[7.2.6.2.2](#update-of-file-storage)节中。


[]{#\_bookmark57 .anchor}**[SWS_PER_00387]** *[*If the application registered a function using ara::per::RegisterApplicationDataUpdateCallback, and if the Persistency had to update at least one of its storages according to [[SWS_PER_00386](#_bookmark56)], it shall compare the Executable.version in the manifest against the stored version. If the version in the manifest is higher than the stored version, the Persistency shall call the registered function for each storage that was updated according to [[SWS_PER_00386](#_bookmark56)]._♩ (RS_PER_00010, RS_PER_00013)_

> 如果应用程序使用ara :: per :: RegisterApplicationDataUpdateCallback注册了一个功能，并且如果持久性必须根据[[SWS_PER_00386](#_bookmark56)]更新其存储中的至少一个存储，则它应比较清单中的Executable.version与存储的版本。如果清单中的版本高于存储的版本，则持久性应为根据[[SWS_PER_00386](#_bookmark56)]更新的每个存储调用已注册的函数。（RS_PER_00010，RS_PER_00013）


The function registered by the application using ara::per::RegisterApplicationDataUpdateCallback can be used by the application to update elements of a storage manually. The storage is identified by the ara::core::InstanceSpecifier provided to this function. The application might then, based on the Executable.version of the stored data provided as second argument to the

> 应用程序使用ara::per::RegisterApplicationDataUpdateCallback注册的函数可以用于应用程序手动更新存储元素。存储由提供给此函数的ara::core::InstanceSpecifier标识。然后，应用程序可以基于作为第二个参数提供的存储数据的Executable.version进行操作。


function, read in the stored data in the old format or with the old type, convert the data, and store it again with the new format or new type expected by the current version.

> 函数，读取存储在旧格式或旧类型中的数据，转换数据，并以当前版本所预期的新格式或新类型重新存储。


Example: Version 1 of the application stored the maximum speed in _mph_ as uint8, but version 2 expects the maximum speed in _km/h_ as uint16. The update callback function will then see that a Key-Value Storage from version 1 of the Executable has been updated to the current version, and can read in the old maximum speed by ara::per::KeyValueStorage::GetValue as uint8, convert it, and store it as uint16 with ara::per::KeyValueStorage::SetValue after removing the old value with ara::per::KeyValueStorage::RemoveKey.

> 例如：应用程序的第一个版本将最大速度以_mph_的uint8格式存储，但第二个版本期望以_km/h_的uint16格式存储最大速度。更新回调函数将会看到从可执行文件的第一个版本更新到当前版本的键值存储，并且可以通过ara :: per :: KeyValueStorage :: GetValue读取旧的最大速度，将其转换，并在删除旧值之后使用ara :: per :: KeyValueStorage :: SetValue以uint16格式存储它。


In case the redundancy configuration or the configuration of encryption and authentication of the updated manifest differs from the old manifest, special care has to be taken to keep the data consistent and readable.

> 如果更新的清单中的冗余配置或加密和身份验证的配置与旧清单不同，必须特别注意以保持数据的一致性和可读性。


**[SWS_PER_00560]** *[*During the update, when the old storage is read, Persistency shall check the redundancy according to the information stored in the meta data of the storage._♩(RS_PER_00008, RS_PER_00010, RS_PER_00013)_

> 在更新期间，当读取旧存储时，Persistency 应根据存储中的元数据信息检查冗余性。(RS_PER_00008，RS_PER_00010，RS_PER_00013)

> **[SWS_PER_00561]** *[*When the storage is persisted after the update, Persistency shall use the redundancy configured in the manifest, and store the information about the used redundancy in the meta data of the storage._♩(RS_PER_00008, RS_PER_00010, RS_PER_00013)_


Please note that this means that in some situations redundant information might become obsolete and can be removed, e.g. when the new manifest has a lower n for PersistencyRedundancyMOutOfN.

> 请注意，这意味着在某些情况下，多余的信息可能会变得过时，可以被删除，例如当新的清单具有更低的PersistencyRedundancyMOutOfN的n时。


**[SWS_PER_00562]** *[*During the update, when the old storage is read, Persistency shall decrypt and verify the signature of the storage or the elements of the storage according to the information stored in the meta data of the storage._♩ (RS_PER_00005, RS_PER_00010, RS_PER_00013)_

> 在更新期间，当读取旧存储时，Persistency 应根据存储中的元数据解密和验证存储或存储元素的签名。（RS_PER_00005，RS_PER_00010，RS_PER_00013）


**[SWS_PER_00563]** *[*When the storage is persisted after the update, Persistency shall encrypt and sign the storage or the elements of the storage as configured in the manifest, and store the information about the used keys and algorithms in the meta data of the storage._♩(RS_PER_00005, RS_PER_00010, RS_PER_00013)_

> 当更新后存储被持久化时，Persistency应根据清单中的配置加密和签名存储或存储的元素，并将所使用的密钥和算法的信息存储在存储的元数据中（RS_PER_00005，RS_PER_00010，RS_PER_00013）。

### Update of Key-Value Storage


**[SWS_PER_00388]** *[*When a new PortPrototype typed by a PersistencyKeyValueStorageInterface is detected in an updated manifest, the Persistency shall create a Key-Value Storage as specified in [[SWS_PER_00383](#_bookmark45)]._♩(RS_PER_00010, RS_PER_00013)_

> 当更新的清单中检测到由PersistencyKeyValueStorageInterface类型的新PortPrototype时，Persistency应按照[[SWS_PER_00383](#_bookmark45)]中指定的方式创建一个键值存储。♩(RS_PER_00010, RS_PER_00013)

> **[SWS_PER_00389]** *[*When a PortPrototype typed by a PersistencyKeyValueStorageInterface is missing in an updated manifest, the Persistency shall remove the corresponding Key-Value Storage._♩(RS_PER_00010, RS_PER_00013)_


**[SWS_PER_00390]** *[*When a PersistencyKeyValueStorageInterface. dataElement and/or a PersistencyKeyValueStorage.keyValuePair with a new key is detected in an updated manifest for which the update strategy is not delete, the Persistency shall create a new entry in the Key-Value Storage as specified in [[SWS_PER_00252](#_bookmark46)], [[SWS_PER_00253](#_bookmark47)], [[SWS_PER_00254](#_bookmark48)], and [[SWS_PER_00384](#_bookmark49)]._♩(RS_PER_00010, RS_PER_00013)_

> 当更新策略不是删除时，如果在更新的清单中检测到PersistencyKeyValueStorageInterface.dataElement和/或具有新键的PersistencyKeyValueStorage.keyValuePair，则Persistency应按照[[SWS_PER_00252](#_bookmark46)], [[SWS_PER_00253](#_bookmark47)], [[SWS_PER_00254](#_bookmark48)], 和[[SWS_PER_00384](#_bookmark49)]中的说明在键值存储中创建一个新条目。_♩(RS_PER_00010, RS_PER_00013)_


**[SWS_PER_00391]** *[*When an existing key-value pair cannot be associated with any PersistencyKeyValueStorageInterface.dataElement or PersistencyKeyValueStorage.keyValuePair in an updated manifest, and the update strategy of the PersistencyKeyValueStorage corresponding to the Key-Value Storage is delete, the Persistency shall remove that key-value pair from the Key-Value Storage._♩(RS_PER_00010, RS_PER_00013)_

> 当一个现有的键值对无法与更新后清单中的任何PersistencyKeyValueStorageInterface.dataElement或PersistencyKeyValueStorage.keyValuePair相关联时，如果与该键值存储相关的持久性更新策略是删除，则持久性应从键值存储中删除该键值对。♩（RS_PER_00010，RS_PER_00013）


The update strategy is determined according to [[SWS_PER_00251](#_bookmark39)].

> 更新策略根据[[SWS_PER_00251](#_bookmark39)]确定。


**[SWS_PER_00275]** *[*When an existing key-value pair can be associated with a PersistencyKeyValueStorageInterface.dataElement or PersistencyKeyValueStorage.keyValuePair in an updated manifest, and the update strategy is overwrite, the Persistency shall replace that key-value pair with the new type and value as specified in [[SWS_PER_00254](#_bookmark48)] and [[SWS_PER_00384](#_bookmark49)]._♩ (RS_PER_00010, RS_PER_00013)_

> **[SWS_PER_00275]** 当一个现有的键值对可以与PersistencyKeyValueStorageInterface.dataElement或PersistencyKeyValueStorage.keyValuePair相关联，并且更新策略是覆盖时，持久性应该根据[[SWS_PER_00254](#_bookmark48)]和[[SWS_PER_00384](#_bookmark49)]替换该键值对，使用新的类型和值。（RS_PER_00010, RS_PER_00013）


An entry with identical key might be defined both in the PersistencyKeyValueStorageInterface and the PersistencyKeyValueStorage, in which case [[SWS_PER_00379](#_bookmark38)] applies. The update strategy is determined according to [[SWS_PER_00251](#_bookmark39)] and [[SWS_PER_00380](#_bookmark40)].

> 一个相同键的条目可以在PersistencyKeyValueStorageInterface和PersistencyKeyValueStorage中定义，在这种情况下，[SWS_PER_00379]（＃_bookmark38）适用。更新策略根据[SWS_PER_00251]（＃_bookmark39）和[SWS_PER_00380]（＃_bookmark40）确定。


**[SWS_PER_00277]** *[*When an existing key-value pair can be associated with a PersistencyKeyValueStorageInterface.dataElement or PersistencyKeyValueStorage.keyValuePair in an updated manifest, and the update strategy is delete, the Persistency shall remove that key-value pair from the Key-Value Storage._♩(RS_PER_00010, RS_PER_00013)_

> 当现有的键值对可以与更新后的清单中的PersistencyKeyValueStorageInterface.dataElement或PersistencyKeyValueStorage.keyValuePair相关联时，如果更新策略是删除，Persistency应该从键值存储中删除该键值对。（RS_PER_00010，RS_PER_00013）


Updated key-value pairs with the update strategy keepExisting will not be touched during an update. Persistency will neither check the value nor the type of the existing entry.

> 更新策略 keepExisting 下更新的键值对不会被改变。持久性也不会检查现有条目的值或类型。


To support the conversion from one CppImplementationDataType to another (or to a different version of the same type) in the function registered using ara::per::RegisterApplicationDataUpdateCallback, Persistency provides the ability to read data types from a storage that are no longer used by the application. These types are configured in the manifest as previousDataType of a PersistencyKeyValueDataTypeMapping that references a currently used type as currentDataType.

> 为了支持在使用ara :: per :: RegisterApplicationDataUpdateCallback注册的函数中从一个CppImplementationDataType转换到另一个（或同一类型的不同版本），Persistency提供了从存储中读取不再由应用程序使用的数据类型的能力。这些类型在清单中配置为引用当前使用类型作为currentDataType的PersistencyKeyValueDataTypeMapping的previousDataType。


There are two scenarios in which such a conversion is necessary:

> 有两种情况需要进行这样的转换：


1. An existing data type has been modified for the new application. The data type still uses the same identifier.

> 现有的数据类型已经被修改用于新应用程序。该数据类型仍使用相同的标识符。

2. A new data type was introduced that replaces a data type that is no longer used in the new application. The two data types have different identifiers.

> 新的数据类型被引入，取代了新应用中不再使用的数据类型。这两种数据类型有不同的标识符。


**[SWS_PER_CONSTR_00005]** *[*In case an existing data type is changed in a new application, Persistency expects PersistencyKeyValueDataTypeMappings referring to a copy of the old data type as previousDataType and the new data type as currentDataType. The name of the old data type shall be formed as follows:

> 如果在新的应用程序中更改了现有数据类型，持久性期望PersistencyKeyValueDataTypeMappings引用旧数据类型的副本作为previousDataType和新数据类型作为currentDataType。旧数据类型的名称应按照以下方式组成：


\<PersistencyKeyValueDataTypeMapping.currentDataType.shortName\>\_\< PersistencyKeyValueDataTypeMapping.previousExecutableVersion\>._♩ (RS_PER_00010, RS_PER_00013)_

> \<PersistencyKeyValueDataTypeMapping.currentDataType.shortName\>\_\< PersistencyKeyValueDataTypeMapping.previousExecutableVersion\>._♩ (RS_PER_00010, RS_PER_00013)_：当前数据类型的简称_上一个可执行版本。♩ (RS_PER_00010, RS_PER_00013)_

### Update of File Storage


**[SWS_PER_00392]** *[*When a new PortPrototype typed by a PersistencyFileStorageInterface is detected in an updated manifest, the Persistency shall create a File Storage as specified in [[SWS_PER_00385](#_bookmark51)]._♩(RS_PER_00010, RS_PER_00013)_

> 当更新的清单中检测到由PersistencyFileStorageInterface类型的新PortPrototype时，Persistency应按照[[SWS_PER_00385](#_bookmark51)]中的说明创建文件存储。♩(RS_PER_00010, RS_PER_00013)

> **[SWS_PER_00393]** *[*When a PortPrototype typed by a PersistencyFileStorageInterface is missing in an updated manifest, the Persistency shall remove the corresponding File Storage._♩(RS_PER_00010, RS_PER_00013)_


**[SWS_PER_00394]** *[*When a PersistencyFileStorageInterface.fileElement and/or PersistencyFileStorage.file with a new file name is detected in an updated manifest for which the update strategy is not delete, the Persistency shall create a new file in the File Storage as specified in [[SWS_PER_00265](#_bookmark52)], [[SWS_PER_00266](#_bookmark53)], and [[SWS_PER_00267](#_bookmark54)]._♩(RS_PER_00010, RS_PER_00013)_

> 当检测到更新后的清单中存在一个新的文件名的PersistencyFileStorageInterface.fileElement和/或PersistencyFileStorage.file，且更新策略不是删除时，持久性应按照[[SWS_PER_00265](#_bookmark52)], [[SWS_PER_00266](#_bookmark53)], 和[[SWS_PER_00267](#_bookmark54)]中的规定，在文件存储中创建一个新的文件。♩(RS_PER_00010, RS_PER_00013)


**[SWS_PER_00395]** *[*When an existing file cannot be associated with any PersistencyFileStorageInterface.fileElement or PersistencyFileStorage.file in an updated manifest, and the update strategy of the PersistencyFileStorage corresponding to the File Storage is delete, the Persistency shall remove that file from the File Storage._♩(RS_PER_00010, RS_PER_00013)_

> 当一个现有文件无法与任何PersistencyFileStorageInterface.fileElement或PersistencyFileStorage.file关联，而该文件存储对应的更新策略是删除时，Persistency应从文件存储中删除该文件。（RS_PER_00010，RS_PER_00013）


The update strategy is determined according to [[SWS_PER_00251](#_bookmark39)].

> 更新策略根据[[SWS_PER_00251](#_bookmark39)]确定。


**[SWS_PER_00281]** *[*When an existing file can be associated with a PersistencyFileStorageInterface.fileElement or PersistencyFileStorage.file in an updated manifest, and the update strategy is overwrite, the Persistency shall replace the content of that file with the new content as specified in [[SWS_PER_00267](#_bookmark54)]._♩(RS_PER_00010, RS_PER_00013)_

> **[SWS_PER_00281]** 当现有文件可以与更新后的清单中的PersistencyFileStorageInterface.fileElement或PersistencyFileStorage.file相关联，并且更新策略是覆盖时，Persistency应该用[[SWS_PER_00267](#_bookmark54)]中指定的新内容替换该文件的内容。♩(RS_PER_00010, RS_PER_00013)


A file with the same file name might be defined both in the PersistencyFileStorageInterface and the PersistencyFileStorage, in which case [[SWS_PER_00379](#_bookmark38)] applies. The update strategy is determined according to [[SWS_PER_00251](#_bookmark39)] and [[SWS_PER_00380](#_bookmark40)].

> 如果同一个文件名在PersistencyFileStorageInterface和PersistencyFileStorage中都被定义，则[SWS_PER_00379]（# _bookmark38）适用。更新策略根据[SWS_PER_00251]（# _bookmark39）和[SWS_PER_00380]（# _bookmark40）确定。


**[SWS_PER_00283]** *[*When an existing file can be associated with a PersistencyFileStorageInterface.fileElement or PersistencyFileStorage.file in an updated manifest, and the update strategy is delete, the Persistency shall remove that file from the File Storage._♩(RS_PER_00010, RS_PER_00013)_

> 当现有文件可以与更新后清单中的PersistencyFileStorageInterface.fileElement或PersistencyFileStorage.file关联时，如果更新策略是删除，Persistency应从文件存储中删除该文件。♩（RS_PER_00010，RS_PER_00013）


Updated files with the update strategy keepExisting will not be touched during an update. Persistency will not check the content of the existing file.

> 更新策略为keepExisting的文件在更新过程中不会受到影响。持久性不会检查现有文件的内容。

### Finalization of Persistent Data after Successful Update


After installation and update, Persistency will usually be called with ara::per::UpdatePersistency within the verification phase of the application. When this succeeded, the application will be finalized by Update and Configuration Management and then started again in normal execution mode. In this case, Persistency should remove any backups that were created during a preceding update.

> 安装和更新后，在应用程序的验证阶段通常会使用ara :: per :: UpdatePersistency调用Persistency。当这成功时，应用程序将由更新和配置管理完成，然后在正常执行模式下重新启动。在这种情况下，Persistency应该删除在前一次更新期间创建的任何备份。


[]{#\_bookmark61 .anchor}**[SWS_PER_00446]** *[*When a storage is opened by the application, and ara::per::UpdatePersistency has not been called since Persistency was initialized, the Persistency shall compare the PersistencyDeployment.version in the manifest against the stored version. If the two versions are identical, the Persistency shall remove all backup data of the storage._♩(RS_PER_00016)_

> 当应用程序打开存储介质时，如果自从初始化持久性以来尚未调用ara::per::UpdatePersistency，则持久性应比较清单中的PersistencyDeployment.version与存储的版本。如果两个版本相同，持久性应删除存储的所有备份数据。


Update of persistent data is described in [subsubsection](#update-of-persistent-data) [7.2.6.2](#update-of-persistent-data).

> 持久数据的更新在[7.2.6.2](#update-of-persistent-data)的[子小节](#update-of-persistent-data)中有描述。

### Roll-Back of Persistent Data after Failed Update


[]{#\_bookmark63 .anchor}**[SWS_PER_00396]** *[*When a storage is opened by the application, the Persistency shall compare the PersistencyDeployment.version in the manifest against the stored version. If the version in the manifest is lower than the stored version, the Persistency shall compare the version in the manifest against the version stored in backup data. If the versions match, the Persistency shall restore the backup. Otherwise, it shall remove all storages, and re-install the persistent data from the manifest._♩(RS_PER_00014)_

> 当应用程序打开存储时，持久性应比较清单中的PersistencyDeployment.version与存储的版本。如果清单中的版本低于存储的版本，持久性应将清单中的版本与备份数据中存储的版本进行比较。如果版本匹配，持久性应恢复备份。否则，它应删除所有存储，并从清单中重新安装持久数据。


Initialization of persistent data is described in [subsubsection](#installation-of-persistent-data) [7.2.6.1](#installation-of-persistent-data).

> 初始化持久性数据描述在[子小节](#installation-of-persistent-data)[7.2.6.1](#installation-of-persistent-data)中。

### Removal of Persistent Data


Persistency is not able to remove its own data when the Update and Configuration Management removes an application, because the application will not be executed in this case, and therefore Persistency does not run. On the other hand, the Update and Configuration Management may use the information in the manifest (ProcessToMachineMapping.persistencyCentralStorageURI

> 持久性不能在更新和配置管理移除应用程序时移除自身数据，因为此时应用程序将不会被执行，因此持久性不会运行。另一方面，更新和配置管理可以使用清单（ProcessToMachineMapping.persistencyCentralStorageURI）中的信息。


and PersistencyDeployment.deploymentUri) to obtain the locations of persistent data, and, if it has access to the locations, remove it.

> 取得持久数据的位置，通过PersistencyDeployment.deploymentUri，如果有访问这些位置的权限，则删除它们。

### Resource Management Concepts


The Persistency supports configuration of both an upper and a lower limit for the resources used by a Key-Value Storage or a File Storage.

> 持久性支持配置键值存储或文件存储所使用资源的上限和下限。


The lower limit may already be defined by the application developer using PersistencyInterface.minimumSustainedSize.

> 应用开发者可以使用PersistencyInterface.minimumSustainedSize来定义下限。


During deployment, the integrator may update the lower limit using PersistencyDeployment.minimumSustainedSize and add an upper limit using PersistencyDeployment.maximumAllowedSize.

> 在部署期间，集成器可以使用PersistencyDeployment.minimumSustainedSize更新下限，并使用PersistencyDeployment.maximumAllowedSize添加上限。


**[SWS_PER_00320]** *[*The Persistency shall ensure that the space configured by PersistencyDeployment.minimumSustainedSize is always available for the storage._♩(RS_PER_00010, RS_PER_00011)_

> [SWS_PER_00320] 持久性应确保由PersistencyDeployment.minimumSustainedSize配置的空间始终可用于存储（RS_PER_00010，RS_PER_00011）。


One possibility to achieve this would be to initially allocate the minimum size during deployment, and never reduce the size below this value when persistent data is removed. But the implementation of the Persistency is free to chose other appropriate measures.

> 一种实现这一目标的可能性是在部署时最初分配最小尺寸，并且在移除持久数据时不要将尺寸减小到该值以下。但是持久性的实施可以选择其他适当的措施。


**[SWS_PER_00321]** *[*The Persistency shall ensure that the space actually allocated by a storage never surpasses the amount configured by PersistencyDeployment.maximumAllowedSize._♩(RS_PER_00010, RS_PER_00011)_

> [SWS_PER_00321] 持久性应确保存储分配的空间永远不会超过PersistencyDeployment.maximumAllowedSize所配置的量(RS_PER_00010, RS_PER_00011)。


This could be ensured by supervising all write accesses to persistent data. But again, the implementation of the Persistency is free to chose other appropriate measures.

> 这可以通过监督对持久数据的所有写入访问来确保。但是，持久性的实现可以选择其他适当的措施。


The application can also poll the amount of storage space currently occupied by a complete Key-Value Storage or File Storage by using ara::per::GetCurrentKeyValueStorageSize or ara::per::GetCurrentFileStorageSize, respectively. Naturally, the returned values will not drop below a configured minimum size (PersistencyDeployment.minimumSustainedSize) or rise above a configured maximum size (PersistencyDeployment.maximumAllowedSize).

> 应用程序还可以使用ara::per::GetCurrentKeyValueStorageSize来轮询完整的键值存储或文件存储占用的存储空间大小，分别使用ara :: per :: GetCurrentFileStorageSize。当然，返回的值不会低于配置的最小大小（PersistencyDeployment.minimumSustainedSize）或高于配置的最大大小（PersistencyDeployment.maximumAllowedSize）。


**[SWS_PER_00491]** *[*ara::per::GetCurrentKeyValueStorageSize shall return the total size of the storage space currently allocated to a Key-Value Storage, including administrative data (apart from data stored in ProcessToMachineMapping.persistencyCentralStorageURI), redundant data, and backup data. The reported size may be inaccurate if the Key-Value Storage is currently open, or if another operation is currently being executed on the same storage._♩(RS_PER_00011)_

> [SWS_PER_00491]*[*ara::per::GetCurrentKeyValueStorageSize应返回当前分配给键值存储的总存储空间，包括管理数据（除存储在ProcessToMachineMapping.persistencyCentralStorageURI中的数据外），冗余数据和备份数据。如果键值存储当前打开或者另一个操作正在对同一存储执行，则报告的大小可能不准确。_♩(RS_PER_00011)_


The inaccuracy is mainly due to the fact that meta data of the storage is only updated when the storage is fully synchronized, and predicting the meta data size is sometimes very difficult.

> 由于存储的元数据只有在存储完全同步时才会更新，而预测元数据大小有时非常困难，因此不准确性主要是由此造成的。


[]{#\_bookmark66 .anchor}**[SWS_PER_00492]** *[*ara::per::GetCurrentFileStorageSize shall return the total size of the storage space currently allocated to a File Storage, including administrative data (apart from data stored in ProcessToMachineMapping.persistencyCentralStorageURI), all its files, redundant data, and backup data. The

> ara::per::GetCurrentFileStorageSize 应该返回分配给文件存储的总空间大小，包括管理数据（除了存储在ProcessToMachineMapping.persistencyCentralStorageURI中的数据），其所有文件，冗余数据和备份数据。


reported size may be inaccurate if the File Storage is currently open, or if another operation is currently being executed on the same storage._♩(RS_PER_00011)_

> 报告的大小可能不准确，如果文件存储当前处于打开状态，或者如果另一个操作正在同一存储上执行，则可能不准确。

## Key-Value Storage specific Features


To access a Key-Value Storage, the application has to call ara::per::OpenKeyValueStorage with the ara::core::InstanceSpecifier derived from the manifest (a shortName path from the Executable to a PortPrototype or a mapping derived from FunctionalClusterInteractsWithFunctionalClusterMapping). This call will return an ara::per::SharedHandle of an ara::per::KeyValueStorage. The Key-Value Storage is closed when the ara::per::SharedHandle and all of its copies go out of scope, or when ara::core::Deinitialize is called.

> 要访问键值存储，应用程序必须调用ara :: per :: OpenKeyValueStorage，传入从清单（从可执行文件到端口原型的简称路径或从功能集群交互与功能集群映射派生的映射）派生的ara :: core :: InstanceSpecifier。此调用将返回ara :: per :: SharedHandle的ara :: per :: KeyValueStorage。当ara :: per :: SharedHandle及其所有副本失去作用域或调用ara :: core :: Deinitialize时，键值存储将关闭。


**[SWS_PER_00506]** *[*When ara::per::OpenKeyValueStorage is called, and Persistency is properly initialized as described in [[SWS_PER_00408](#_bookmark15)], Persistency shall create a temporary storage that provides access to the Key-Value Storage identified by the ara::core::InstanceSpecifier, and shall create and return an ara::per::SharedHandle of an ara::per::KeyValueStorage._♩ (RS_PER_00002)_

> 当调用ara::per::OpenKeyValueStorage，且按照[[SWS_PER_00408](#_bookmark15)]中所述正确初始化Persistency时，Persistency将创建一个临时存储，提供对由ara::core::InstanceSpecifier标识的键值存储的访问，并创建并返回ara::per::KeyValueStorage的ara::per::SharedHandle。（RS_PER_00002）


If ara::per::OpenKeyValueStorage is called without proper initialization, [[SWS_PER_00410](#_bookmark16)] applies.

> 如果没有正确初始化，ara::per::OpenKeyValueStorage 将会执行 [[SWS_PER_00410](#_bookmark16)]。


All operations on a Key-Value Storage will be done in a temporary storage created during the call to ara::per::OpenKeyValueStorage, which the application can persist using ara::per::KeyValueStorage::SyncToStorage, or reset to the last stored state with ara::per::KeyValueStorage::DiscardPendingChanges.

> 所有对键值存储的操作都将在调用ara::per::OpenKeyValueStorage时创建的临时存储中完成，应用程序可以通过ara::per::KeyValueStorage::SyncToStorage持久化该存储，或者使用ara::per::KeyValueStorage::DiscardPendingChanges重置为最后存储的状态。


Therefore, if the Key-Value Storage is just destructed (also implicitly when the Process terminates), the Key-Value Storage is not updated, and the next time the Key-Value Storage is accessed, the application will see the last saved state.

> 因此，如果键值存储被破坏（也可以在进程终止时隐式发生），键值存储不会被更新，下次访问键值存储时，应用程序将看到最后保存的状态。


**[SWS_PER_00331]** *[*Modifications of a Key-Value Storage that have not been persisted with a call to ara::per::KeyValueStorage::SyncToStorage shall be discarded when the Key-Value Storage is closed or the system is restarted, just as if ara::per::KeyValueStorage::DiscardPendingChanges had been called._♩ (RS_PER_00003)_

> **[SWS_PER_00331]** *[*当Key-Value存储关闭或系统重新启动时，没有通过调用ara :: per :: KeyValueStorage :: SyncToStorage持久化的Key-Value存储的修改将被丢弃，就像调用了ara :: per :: KeyValueStorage :: DiscardPendingChanges一样。_♩ (RS_PER_00003)_

简体中文：**[SWS_PER_00331]** *[*当Key-Value存储关闭或系统重新启动时，没有通过调用ara :: per :: KeyValueStorage :: SyncToStorage持久化的Key-Value存储的修改将会被丢弃，就像调用了ara :: per :: KeyValueStorage :: DiscardPendingChanges一样。_♩ (RS_PER_00003)_


Changes done by any thread (using a copy of the ara::per::SharedHandle) will be immediately visible in all other threads. This also applies to ara::per::KeyValueStorage::DiscardPendingChanges, which resets the key-value pairs in all threads, and to ara::per::KeyValueStorage::SyncToStorage, which persists all changes done by any thread.

> 所有线程（使用ara::per::SharedHandle的副本）所做的更改将立即在其他线程中可见。这也适用于ara::per::KeyValueStorage::DiscardPendingChanges，它会重置所有线程中的键值对，以及ara::per::KeyValueStorage::SyncToStorage，它会持久化任何线程所做的更改。


**[SWS_PER_00494]** *[*When ara::per::KeyValueStorage::SyncToStorage is called, Persistency shall store all changes permanently that have been done to the Key-Value Storage since the last call to this method or since the Key-Value Storage was opened. Persistency shall also update any configured redundancy within this call._♩(RS_PER_00001)_

> 当调用ara::per::KeyValueStorage::SyncToStorage时，持久性应该永久存储自上次调用此方法或自打开键值存储以来对键值存储所做的所有更改。持久性还应该在此调用中更新任何配置的冗余。


The handling of redundancy is described in detail in [subsection](#redundancy-concepts) [7.2.5](#redundancy-concepts).

> 处理冗余的详细内容可在[7.2.5小节](#redundancy-concepts)中找到。


**[SWS_PER_00495]** *[*When ara::per::KeyValueStorage::DiscardPendingChanges is called, Persistency shall reset the Key-Value Storage to the last persisted state, which is the state after the last call to ara::per::KeyValueStorage::SyncToStorage or after opening the Key-Value Storage._♩ (RS_PER_00001)_

> 当调用ara::per::KeyValueStorage::DiscardPendingChanges时，持久性应将键值存储重置为上次持久化的状态，即最后一次调用ara::per::KeyValueStorage::SyncToStorage或打开键值存储后的状态。（RS_PER_00001）


Single key-value pairs of the Key-Value Storage are accessed using ara::per::KeyValueStorage::GetValue and ara::per::KeyValueStorage::SetValue. ara::per::KeyValueStorage::SetValue may also be used to create a key-value pair.

> 单个键值对的键值存储可以使用ara::per::KeyValueStorage::GetValue和ara::per::KeyValueStorage::SetValue进行访问。ara::per::KeyValueStorage::SetValue也可以用来创建键值对。


**[SWS_PER_00496]** *[*When ara::per::KeyValueStorage::GetValue is called, Persistency shall first check whether the key-value pair is present in the temporary storage, and otherwise return directly with kKeyNotFound._♩(RS_PER_00002, RS_PER_00003)_

> 当调用ara::per::KeyValueStorage::GetValue时，Persistency应首先检查临时存储中是否存在键值对，否则直接返回kKeyNotFound。（RS_PER_00002，RS_PER_00003）


**[SWS_PER_00497]** *[*When ara::per::KeyValueStorage::GetValue is called for an existing key-value pair, Persistency shall check whether the templated data type matches the stored data type, and otherwise return directly with kDataTypeMismatch._♩(RS_PER_00002, RS_PER_00003)_

> 当调用ara::per::KeyValueStorage::GetValue获取现有键值对时，持久性应检查模板数据类型是否与存储的数据类型匹配，否则直接返回kDataTypeMismatch。（RS_PER_00002，RS_PER_00003）


**[SWS_PER_00498]** *[*When ara::per::KeyValueStorage::GetValue is called for an existing key-value pair with the correct templated data type, Persistency shall return the stored value of the key-value pair, or, if the value was recently changed by ara::per::KeyValueStorage::SetValue (also in another thread), this new temporary value._♩(RS_PER_00002, RS_PER_00003)_

> 当ara::per::KeyValueStorage::GetValue被调用时，如果为给定的键值对指定了正确的模板数据类型，Persistency将返回存储的该键值对的值，或者，如果该值最近由ara::per::KeyValueStorage::SetValue（也可以是另一个线程）更改，则返回新的临时值。


**[SWS_PER_00499]** *[*When ara::per::KeyValueStorage::SetValue is called for an existing key-value pair, Persistency shall check whether the templated data type matches the stored data type, and otherwise return directly with kDataTypeMismatch._♩(RS_PER_00001, RS_PER_00003)_

> **[SWS_PER_00499]** 当调用ara::per::KeyValueStorage::SetValue更新现有的键值对时，Persistency应检查模板数据类型是否与存储的数据类型匹配，否则直接返回kDataTypeMismatch。（RS_PER_00001，RS_PER_00003）


**[SWS_PER_00534]** *[*When ara::per::KeyValueStorage::SetValue is called for an existing key-value pair with the correct templated data type, Persistency shall store the new value of the key-value pair in the temporary storage._♩(RS_PER_00001, RS_PER_00003)_

> 当调用ara::per::KeyValueStorage::SetValue为具有正确模板数据类型的现有键值对时，持久性应将新键值对的值存储在临时存储中(RS_PER_00001, RS_PER_00003)。


**[SWS_PER_00501]** *[*When ara::per::KeyValueStorage::SetValue is called, and the key-value pair does not exist in the temporary storage, Persistency shall create the key-value pair with the templated data type and the provided value in the temporary storage._♩(RS_PER_00001, RS_PER_00003)_

> 当调用ara::per::KeyValueStorage::SetValue时，如果该键值对不存在于临时存储中，Persistency应在临时存储中使用模板数据类型和提供的值创建该键值对。♩（RS_PER_00001，RS_PER_00003）


To remove a single key-value pair, the application may use ara::per::KeyValueStorage::RemoveKey, while ara::per::KeyValueStorage::RemoveAllKeys empties the Key-Value Storage. The type of a key-value pair may be changed by first removing it, and then creating it with the new type.

> 要删除单个键值对，应用程序可以使用ara :: per :: KeyValueStorage :: RemoveKey，而ara :: per :: KeyValueStorage :: RemoveAllKeys会清空键值存储。可以通过首先删除它，然后使用新类型创建它来改变键值对的类型。


**[SWS_PER_00502]** *[*When ara::per::KeyValueStorage::RemoveKey is called, Persistency shall first check whether the key-value pair is present in the temporary storage, and otherwise return directly with kKeyNotFound._♩_

> 当调用ara::per::KeyValueStorage::RemoveKey时，Persistency首先应检查临时存储中是否存在该键值对，否则直接返回kKeyNotFound。


_(RS_PER_00001, RS_PER_00003)_

> （RS_PER_00001，RS_PER_00003）

> **[SWS_PER_00535]** *[*When ara::per::KeyValueStorage::RemoveKey is called for an existing key-value pair, Persistency shall remove the key-value pair from the temporary storage._♩(RS_PER_00001, RS_PER_00003)_


**[SWS_PER_00503]** *[*When ara::per::KeyValueStorage::RemoveAllKeys is called, Persistency shall remove all key-value pairs from the temporary storage, resulting in an empty Key-Value Storage._♩(RS_PER_00001)_

> 当调用ara::per::KeyValueStorage::RemoveAllKeys时，Persistency应从临时存储中删除所有键值对，从而使键值存储为空。（RS_PER_00001）


Finally, the application can check for the existence of a single key with ara::per::KeyValueStorage::KeyExists, check the current size of a value using ara::per::KeyValueStorage::GetCurrentValueSize, and acquire a list of all currently available keys using ara::per::KeyValueStorage::GetAllKeys.

> 最后，应用程序可以使用ara :: per :: KeyValueStorage :: KeyExists检查单个键的存在，使用ara :: per :: KeyValueStorage :: GetCurrentValueSize检查值的当前大小，并使用ara :: per :: KeyValueStorage :: GetAllKeys获取当前可用键的列表。


**[SWS_PER_00504]** *[*ara::per::KeyValueStorage::KeyExists shall return true if the key is present in the temporary storage, otherwise it shall return false._♩ (RS_PER_00003)_

> [SWS_PER_00504] *[ara::per::KeyValueStorage::KeyExists 应该返回true，如果键存在于临时存储中，否则应该返回false。_♩（RS_PER_00003）_*


**[SWS_PER_00565]** *[*When ara::per::KeyValueStorage::GetCurrentValueSize is called, Persistency shall first check whether the key-value pair is present in the temporary storage, and otherwise return directly with kKeyNotFound._♩(RS_PER_00003)_

> 当调用ara::per::KeyValueStorage::GetCurrentValueSize时，Persistency应首先检查临时存储中是否存在键值对，否则直接返回kKeyNotFound。♩（RS_PER_00003）


**[SWS_PER_00566]** *[*When ara::per::KeyValueStorage::GetCurrentValueSize is called for an existing key-value pair, Persistency shall return the current size of its value._♩(RS_PER_00003)_

> 当调用ara::per::KeyValueStorage::GetCurrentValueSize对现有的键值对时，Persistency 应该返回其值的当前大小。♩（RS_PER_00003）


**[SWS_PER_00505]** *[*ara::per::KeyValueStorage::GetAllKeys shall return an ara::core::Vector of ara::core::String, containing all the keys that are present in the temporary storage. If the temporary storage is empty, an empty ara::core::Vector shall be returned._♩(RS_PER_00003)_

> [SWS_PER_00505]*[*ara::per::KeyValueStorage::GetAllKeys 将返回一个ara::core::Vector，其中包含临时存储中所有的键。如果临时存储为空，则将返回一个空的ara::core::Vector。_♩(RS_PER_00003)_

### Supported Data Types in Key-Value Storages


The Persistency supports the following classes of data types in the functions ara::per::KeyValueStorage::GetValue (templated via T), ara::per::KeyValueStorage::GetValue with out parameter (templated via T), and ara::per::KeyValueStorage::SetValue (templated via T) of a Key-Value Storage.

> 持久性支持在ara :: per :: KeyValueStorage :: GetValue（通过T模板）、ara :: per :: KeyValueStorage :: GetValue（无参数模板通过T）和ara :: per :: KeyValueStorage :: SetValue（通过T模板）函数中的键值存储的以下数据类型。


**[SWS_PER_00302]** *[*The Persistency shall be able to store all data types described in [10] in a Key-Value Storage._♩(RS_PER_00001)_

> 持久性必须能够在键值存储中存储[10]中描述的所有数据类型。♩（RS_PER_00001）


**[SWS_PER_00303]** *[*The Persistency shall be able to store serialized binary data in a Key-Value Storage. Persistency shall accept serialized binary data in the form of an ara::core::Vector of ara::core::Byte or an ara::core::Span of ara::core::Byte._♩(RS_PER_00001)_

> **[SWS_PER_00303]** *[*持久性应能够将序列化的二进制数据存储在键值存储中。持久性应该接受以ara::core::Vector of ara::core::Byte或ara::core::Span of ara::core::Byte的形式序列化的二进制数据。_♩(RS_PER_00001)_*


This allows the application to store custom data types.

> 这允许应用程序存储自定义数据类型。


Please note that an ara::core::Span of ara::core::Byte cannot be returned by ara::per::KeyValueStorage::GetValue. It can only be passed in to ara::per::KeyValueStorage::SetValue and ara::per::KeyValueStorage::GetValue with out parameter.

> 请注意，ara::core::Byte的ara::core::Span不能由ara::per::KeyValueStorage::GetValue返回。它只能传递给ara::per::KeyValueStorage::SetValue和ara::per::KeyValueStorage::GetValue，而不需要参数。


**[SWS_PER_00304]** *[*The Persistency shall be able to store all CppImplementationDataTypes referenced by PersistencyKeyValueStorageInterface.dataTypeForSerialization or as PersistencyKeyValueStorageInterface.dataElement in the application design of a PersistencyKeyValueStorage in the corresponding Key-Value Storage._♩(RS_PER_00001, RS_PER_00010)_

> 持久性应能够存储由PersistencyKeyValueStorageInterface.dataTypeForSerialization或PersistencyKeyValueStorageInterface.dataElement在应用程序设计中引用的所有CppImplementationDataTypes，以及相应的键值存储中的键值存储。（RS_PER_00001，RS_PER_00010）


The definitions of these data types are generated as described in [11]. Typically,

> 这些数据类型的定义是根据[11]中的描述生成的。通常情况下，


Persistency will generate serializers and deserializers for these types.

> 持久性将为这些类型生成序列化器和反序列化器。

## File Storage specific Features


To access a File Storage, the application has to call ara::per::OpenFileStorage with the ara::core::InstanceSpecifier derived from the manifest (a shortName path from the Executable to a PortPrototype or a mapping derived from FunctionalClusterInteractsWithFunctionalClusterMapping). This call will return an ara::per::SharedHandle of an ara::per::FileStorage. The File Storage is closed when the ara::per::SharedHandle and all of its copies go out of scope, or when ara::core::Deinitialize is called.

> 要访问文件存储，应用程序必须调用ara :: per :: OpenFileStorage，该调用使用从清单（从可执行文件到端口原型的短名称路径或从功能集群交互功能集群映射派生的ara :: core :: InstanceSpecifier）派生的ara :: core :: InstanceSpecifier。此调用将返回ara :: per :: FileStorage的ara :: per :: SharedHandle。当ara :: per :: SharedHandle及其所有副本离开作用域时，或当调用ara :: core :: Deinitialize时，文件存储将关闭。


**[SWS_PER_00507]** *[*When ara::per::OpenFileStorage is called, and Persistency is properly initialized as described in [[SWS_PER_00408](#_bookmark15)], Persistency shall create the necessary structures to access the File Storage identified by the ara::core::InstanceSpecifier, and create and return an ara::per::SharedHandle of an ara::per::FileStorage._♩(RS_PER_00004)_

> 当调用ara::per::OpenFileStorage并且正确地按照[[SWS_PER_00408](#_bookmark15)]中的描述初始化Persistency时，Persistency将创建必要的结构来访问由ara::core::InstanceSpecifier标识的文件存储，并创建并返回ara::per::FileStorage的ara::per::SharedHandle。♩(RS_PER_00004)


If ara::per::OpenFileStorage is called without proper initialization, [[SWS_PER_00410](#_bookmark16)] applies.

> 如果没有正确初始化，ara::per::OpenFileStorage 将会受到 [[SWS_PER_00410](#_bookmark16)] 的影响。


To check for the existence of a single file, the application may call ara::per::FileStorage::FileExists, and ara::per::FileStorage::GetAllFileNames will return a list of all currently available files of the File Storage.

> 检查单个文件是否存在，应用程序可以调用ara :: per :: FileStorage :: FileExists，ara :: per :: FileStorage :: GetAllFileNames将返回File Storage中当前可用的所有文件的列表。


**[SWS_PER_00508]** *[*ara::per::FileStorage::FileExists shall return true if the file is present in the File Storage, otherwise it shall return false._♩(RS_PER_00004)_

> [SWS_PER_00508] *ara::per::FileStorage::FileExists应该在文件存储中存在时返回true，否则应返回false。♩(RS_PER_00004)


**[SWS_PER_00509]** *[*ara::per::FileStorage::GetAllFileNames shall return an ara::core::Vector of ara::core::String, containing the file names of all the files that are present in the File Storage. If the File Storage is empty, an empty ara::core::Vector shall be returned._♩(RS_PER_00004)_

> **[SWS_PER_00509]** *[*ara::per::FileStorage::GetAllFileNames应返回ara::core::Vector，其中包含文件存储中所有文件的文件名。如果文件存储为空，则应返回一个空的ara::core::Vector。_♩(RS_PER_00004)_`


Files may be have been installed with the application or may have been created during an update. To create new files, the application may use ara::per::FileStorage::OpenFileReadWrite or ara::per::FileStorage::OpenFileWriteOnly, and it can use ara::per::FileStorage::DeleteFile to remove any file.

> 文件可能已经随应用程序安装，或者可能是在更新过程中创建的。要创建新文件，应用程序可以使用ara :: per :: FileStorage :: OpenFileReadWrite或ara :: per :: FileStorage :: OpenFileWriteOnly，并可以使用ara :: per :: FileStorage :: DeleteFile来删除任何文件。


**[SWS_PER_00510]** *[*When ara::per::FileStorage::DeleteFile is called, Persistency shall first check whether the file is present in the File Storage, and otherwise return directly with kFileNotFound._♩(RS_PER_00004)_

> 当调用ara::per::FileStorage::DeleteFile时，Persistency应首先检查文件是否存在于文件存储中，否则直接返回kFileNotFound。（RS_PER_00004）


**[SWS_PER_00511]** *[*When ara::per::FileStorage::DeleteFile is called for an existing file, Persistency shall remove the file from the File Storage._♩ (RS_PER_00004)_

> 当ara::per::FileStorage::DeleteFile被调用以删除一个现有文件时，持久性应该从文件存储中移除该文件。(RS_PER_00004)


To access a file of a File Storage, the application has to call ara::per::FileStorage::OpenFileReadWrite, ara::per::FileStorage::OpenFileReadOnly, or ara::per::FileStorage::OpenFileWriteOnly with the file

> 要访问文件存储中的文件，应用程序必须调用ara :: per :: FileStorage :: OpenFileReadWrite、ara :: per :: FileStorage :: OpenFileReadOnly或ara :: per :: FileStorage :: OpenFileWriteOnly，带有文件。


name of the file. These calls will return an ara::per::UniqueHandle of an

> 文件名。这些调用将返回一个ara::per::UniqueHandle。


ara::per::ReadAccessor or ara::per::ReadWriteAccessor.

> ara::per::只读访问器或ara::per::读写访问器。


**[SWS_PER_00551]** *[*When ara::per::FileStorage::OpenFileReadOnly (or one of the overloaded versions ara::per::FileStorage::OpenFileReadOnly with ara::per::OpenMode or ara::per::FileStorage::OpenFileReadOnly with ara::per::OpenMode and separate buffer) is called, Persistency shall first check whether the file is present in the File Storage, and otherwise return directly with kFileNotFound._♩(RS_AP_00128)_

> 当调用ara::per::FileStorage::OpenFileReadOnly（或其带有ara::per::OpenMode或ara::per::FileStorage::OpenFileReadOnly，带有ara::per::OpenMode和单独缓冲区的重载版本）时，持久性应首先检查文件是否存在于文件存储中，否则直接返回kFileNotFound。_♩（RS_AP_00128）_


**[SWS_PER_00552]** *[*When ara::per::FileStorage::OpenFileReadOnly with ara::per::OpenMode (or the overloaded version ara::per::FileStorage::OpenFileReadOnly with ara::per::OpenMode and separate buffer) is called, Persistency shall first check whether the provided mode consists only of either kAtTheBeginning or kAtTheEnd, and otherwise return directly with kInvalidOpenMode._♩(RS_AP_00128)_

> 当调用ara::per::FileStorage::OpenFileReadOnly（或带有ara::per::OpenMode和单独缓冲区的重载版本ara::per::FileStorage::OpenFileReadOnly）时，持久性应首先检查提供的模式是否仅由kAtTheBeginning或kAtTheEnd组成，否则直接返回kInvalidOpenMode。


**[SWS_PER_00512]** *[*When ara::per::FileStorage::OpenFileReadOnly (or one of the overloaded versions ara::per::FileStorage::OpenFileReadOnly with ara::per::OpenMode or ara::per::FileStorage::OpenFileReadOnly with ara::per::OpenMode and separate buffer) is called for an existing file and with a valid ara::per::OpenMode, Persistency shall create the necessary structures to access the file identified by the file name, and create and return an ara::per::UniqueHandle of an ara::per::ReadAccessor._♩(RS_PER_00004)_

> 当ara::per::FileStorage::OpenFileReadOnly（或其中一个带有ara::per::OpenMode的重载版本ara::per::FileStorage::OpenFileReadOnly或带有ara::per::OpenMode和单独缓冲区的ara::per::FileStorage::OpenFileReadOnly）被调用时，如果文件存在并且有效的ara::per::OpenMode，持久性将创建必要的结构来访问由文件名标识的文件，并创建并返回一个ara::per::UniqueHandle的ara::per::ReadAccessor。_♩(RS_PER_00004)_


**[SWS_PER_00553]** *[*When ara::per::FileStorage::OpenFileReadWrite with ara::per::OpenMode or ara::per::FileStorage::OpenFileWriteOnly with ara::per::OpenMode (or one of the overloaded versions ara::per::FileStorage::OpenFileReadWrite with ara::per::OpenMode and separate buffer or ara::per::FileStorage::OpenFileWriteOnly with ara::per::OpenMode and separate buffer) is called, Persistency shall first check whether the provided mode contains either kAtTheBeginning, possibly combined with kTruncate and kAppend, or kAtTheEnd, possibly combined with kAppend, or only kTruncate. Otherwise, the call shall return directly with kInvalidOpenMode._♩ (RS_AP_00128)_

> 当调用ara::per::FileStorage::OpenFileReadWrite，使用ara::per::OpenMode或者调用ara::per::FileStorage::OpenFileWriteOnly，使用ara::per::OpenMode（或者其重载版本，比如ara::per::FileStorage::OpenFileReadWrite，使用ara::per::OpenMode和单独的缓冲区，或者ara::per::FileStorage::OpenFileWriteOnly，使用ara::per::OpenMode和单独的缓冲区），持久性应该首先检查提供的模式是否包含kAtTheBeginning，可能结合kTruncate和kAppend，或者kAtTheEnd，可能结合kAppend，或者仅仅是kTruncate。否则，调用将直接返回kInvalidOpenMode。（RS_AP_00128）


**[SWS_PER_00513]** *[*When ara::per::FileStorage::OpenFileReadWrite or ara::per::FileStorage::OpenFileWriteOnly (or one of their overloaded versions ara::per::FileStorage::OpenFileReadWrite with ara::per::OpenMode, ara::per::FileStorage::OpenFileReadWrite with ara::per::OpenMode and separate buffer, ara::per::FileStorage::OpenFileWriteOnly with ara::per::OpenMode, or ara::per::FileStorage::OpenFileWriteOnly with ara::per::OpenMode and separate buffer) are called with a valid ara::per::OpenMode, Persistency shall create the necessary structures to access the file identified by the file name, and create and return an ara::per::UniqueHandle of an ara::per::ReadWriteAccessor._♩ (RS_PER_00004)_

> 当调用ara::per::FileStorage::OpenFileReadWrite或ara::per::FileStorage::OpenFileWriteOnly（或其重载版本ara::per::FileStorage::OpenFileReadWrite，带有ara::per::OpenMode，ara::per::FileStorage::OpenFileReadWrite，带有ara::per::OpenMode和单独的缓冲区，ara::per::FileStorage::OpenFileWriteOnly，带有ara::per::OpenMode，或ara::per::FileStorage::OpenFileWriteOnly，带有ara::per::OpenMode和单独的缓冲区）时，如果使用有效的ara::per::OpenMode，持久性将创建必要的结构来访问由文件名标识的文件，并创建并返回一个ara::per::UniqueHandle的ara::per::ReadWriteAccessor。（RS_PER_00004）


The file is closed when the ara::per::UniqueHandle goes out of scope, or when

> 文件在ara::per::UniqueHandle作用域结束或被关闭时被关闭。


ara::core::Deinitialize is called.

> ara::core::Deinitialize 被调用了。


**[SWS_PER_00457]** *[*When a file is closed, Persistency shall ensure that all changes to the file are persisted. This does not need to be done immediately like when ara::per::ReadWriteAccessor::SyncToFile is called, but may happen at a later time, latest when the file is opened again, or ara::core::Deinitialize is called._♩(RS_PER_00004)_

> 当文件关闭时，持久性应确保将所有对文件的更改都保留下来。 这不需要像调用ara :: per :: ReadWriteAccessor :: SyncToFile那样立即完成，而是可以在稍后的时间内完成，最晚是再次打开文件时，或调用ara :: core :: Deinitialize时。


Some of the overloads of the file opening functions receive an ara::per::OpenMode as an argument. OpenModes can be combined using the operators "\|" and "\|=".

> 一些文件打开函数的重载接收ara::per::OpenMode作为参数。OpenModes可以使用运算符"\|"和"\|="组合。


**[SWS_PER_00514]** *[*ara::per::operator "\|" and ara::per::operator "\|=" take two ara::per::OpenMode arguments and return the combined ara::per::OpenMode._♩(RS_PER_00004)_

> **[SWS_PER_00514]** *[*ara::per::操作符"\|"和ara::per::操作符"\|="接受两个ara::per::OpenMode参数，并返回组合的ara::per::OpenMode。_♩(RS_PER_00004)_


All files of Persistency are implicitly readable, even when opened as \"write only\", which is expressed by ara::per::ReadWriteAccessor inheriting from ara::per::ReadAccessor. The ara::per::ReadAccessor class consequently also offers the methods related to file positions.

> 所有Persistency文件都可以隐式读取，即使以“只写”方式打开，这由ara：per：ReadWriteAccessor从ara：per：ReadAccessor继承而来。因此，ara：per：ReadAccessor类也提供了与文件位置相关的方法。


**[SWS_PER_00515]** *[*ara::per::ReadAccessor::SetPosition shall set the file position to the provided position. If the provided position is located outside of the current content of the file (including the position at the end of the file), ara::per::ReadAccessor::SetPosition shall keep the previous file position and return kInvalidPosition._♩(RS_PER_00004)_

> **[SWS_PER_00515]** *[*ara::per::ReadAccessor::SetPosition应将文件位置设置为提供的位置。 如果提供的位置位于文件当前内容之外（包括文件末尾的位置），则ara :: per :: ReadAccessor :: SetPosition将保持先前的文件位置并返回kInvalidPosition。_♩(RS_PER_00004)_


**[SWS_PER_00516]** *[*ara::per::ReadAccessor::MovePosition shall move the file position to offset bytes according to the provided origin. If the new position would be located outside of the current content of the file (including the position at the end of the file), ara::per::ReadAccessor::MovePosition shall keep the previous file position and return kInvalidPosition._♩(RS_PER_00004)_

> **[SWS_PER_00516]** *[*ara::per::ReadAccessor::MovePosition应根据提供的起点将文件位置移动到偏移字节。如果新位置位于文件当前内容之外（包括文件末尾的位置），ara::per::ReadAccessor::MovePosition将保持先前的文件位置，并返回kInvalidPosition。_♩(RS_PER_00004)_


**[SWS_PER_00517]** *[*ara::per::ReadAccessor::GetPosition shall return the current read/write position in the file. In the case of an empty file, the position shall be returned as 0._♩(RS_PER_00004)_

> **[SWS_PER_00517]** *[*ara::per::ReadAccessor::GetPosition应该返回文件中的当前读/写位置。在空文件的情况下，位置应该返回为0。_♩(RS_PER_00004)_*


**[SWS_PER_00518]** *[*ara::per::ReadAccessor::IsEof shall return true if the position is the last possible position in the file, i.e. the position directly after the last character in the file, or 0 in case the file is empty._♩(RS_PER_00004)_

> **[SWS_PER_00518]** *[*ara::per::ReadAccessor::IsEof 应该在文件的最后可能位置，即最后一个字符之后的位置时返回true，如果文件为空，则返回0。_♩(RS_PER_00004)_


ara::per::ReadAccessor::IsEof will return true if the current position corresponds to the total file size, which can be obtained separately using ara::per::ReadAccessor::GetSize.

> ara::per::ReadAccessor::IsEof 将返回 true，如果当前位置对应于总文件大小，可以使用 ara::per::ReadAccessor::GetSize 单独获得。


**[SWS_PER_00519]** *[*ara::per::ReadAccessor::GetSize shall return the current total size of the file._♩(RS_PER_00004)_

> [SWS_PER_00519] *ara::per::ReadAccessor::GetSize 应该返回文件的当前总大小。(RS_PER_00004)


Persistency does not care whether the content of a file is text or some binary data, and therefore offers separate methods to access the file content as text or as

> 持久性不管文件的内容是文本还是二进制数据，因此提供了单独的方法来访问文件内容作为文本或作为。


binary data. To read content from a text file, the application may use one of the following methods of the ara::per::ReadAccessor class:

> 应用程序可以使用ara::per::ReadAccessor类的以下方法之一来读取文本文件的内容：


**[SWS_PER_00520]** *[*ara::per::ReadAccessor::PeekChar shall return the character at the current file position without changing the position._♩(RS_PER_00004)_

> [SWS_PER_00520] *[*ara::per::ReadAccessor::PeekChar 应该在当前文件位置返回字符，而不改变位置。_♩(RS_PER_00004)_


**[SWS_PER_00521]** *[*ara::per::ReadAccessor::GetChar shall return the character at the current file position and advance the position by one._♩(RS_PER_00004)_

> **[SWS_PER_00521]** *[*ara::per::ReadAccessor::GetChar 应该返回当前文件位置的字符，并将位置向前移动一个。_♩(RS_PER_00004)_


**[SWS_PER_00522]** *[*ara::per::ReadAccessor::ReadText shall read the text from the current position to the end of the file and return it as an ara::core::String. The position shall be set to the end of the file._♩(RS_PER_00004)_

> **[SWS_PER_00522]** *[*ara::per::ReadAccessor::ReadText 应从当前位置读取文本到文件结尾，并将其作为ara::core::String返回。位置应设置为文件结尾。_♩(RS_PER_00004)_`


**[SWS_PER_00523]** *[*ara::per::ReadAccessor::ReadText shall read the n characters of text from the current position and return them as an ara::core::String. The position shall be incremented by n. In case the end of the file is reached during this operation, the available characters shall be returned, and the position shall be set to the end of the file._♩(RS_PER_00004)_

> **[SWS_PER_00523]** *[*ara::per::ReadAccessor::ReadText应从当前位置读取n个字符的文本，并将其作为ara::core::String返回。位置应增加n。如果在此操作期间到达文件结尾，则应返回可用字符，并将位置设置为文件结尾。_♩(RS_PER_00004)_


**[SWS_PER_00524]** *[*ara::per::ReadAccessor::ReadLine shall read all characters until the delimiter (defaulting to the newline character) or the end of the file is reached, and return them as a ara::core::String. The delimiter shall not be included in the returned ara::core::String. The position shall be set to the character following the delimiter or the end of the file._♩(RS_PER_00004, RS_AP_00136)_

> **[SWS_PER_00524]** *[*ara::per::ReadAccessor::ReadLine应该读取所有字符，直到到达分隔符（默认为换行符）或文件结束为止，并将它们作为ara::core::String返回。分隔符不包括在返回的ara::core::String中。该位置应设置为分隔符后面的字符或文件结束。♩（RS_PER_00004，RS_AP_00136）_


All these methods return characters with a size of eight bits, which are just so-called code units in case of UTF-8, not code points. Therefore, these methods might return incomplete code points. Persistency itself does not change or interpret the content of a file when accessing it in text mode. It is assumed, though, that files in the File Storage are encoded as UTF-8 (see [RS_AP_00136]). It is also assumed that line endings are handled according to UNIX conventions, i.e. just LF (\"\\n\").

> 所有这些方法都会返回具有八位大小的字符，在UTF-8的情况下，它们只是所谓的代码单元，而不是代码点。因此，这些方法可能会返回不完整的代码点。持久性本身在以文本模式访问文件时不会更改或解释文件的内容。不过，假设文件存储中的文件编码为UTF-8（参见[RS_AP_00136]）。还假设行尾的处理按照UNIX的约定，即只有LF（“\ n”）。


**[SWS_PER_CONSTR_00006]** *[*If a CppImplementationDataType with category equal to STRING is used as PersistencyDataElement, then the encoding of this string data type is expected to be UTF-8._♩(RS_PER_00003, RS_PER_00004, RS_AP_00136)_

> **[SWS_PER_CONSTR_00006]** 如果使用CppImplementationDataType，其类别等于STRING作为PersistencyDataElement，那么这个字符串数据类型的编码预期为UTF-8。♩（RS_PER_00003，RS_PER_00004，RS_AP_00136）


This means that a CppImplementationDataType can only be mapped to an ApplicationDataType of category STRING where attribute swDataDefProps. swTextProps.baseType.baseTypeDefinition.baseTypeEncoding is set to the value UTF-8 as defined by [constr_5035]. If a CppImplementationDataType without an ApplicationDataType is used there is no formal description about the UTF8 encoding in the ServiceInterface description.

> 这意味着，只有当swDataDefProps. swTextProps.baseType.baseTypeDefinition.baseTypeEncoding被设置为[constr_5035]定义的值UTF-8时，CppImplementationDataType才能映射到类别STRING的ApplicationDataType。如果使用的CppImplementationDataType没有ApplicationDataType，那么ServiceInterface描述中没有关于UTF8编码的正式描述。


The following methods of the ara::per::ReadAccessor class can be used by an

> 以下ara::per::ReadAccessor类的方法可以被使用者使用


application to read binary content from a file:

> 用于从文件读取二进制内容的应用程序


**[SWS_PER_00525]** *[*ara::per::ReadAccessor::PeekByte shall return the byte at the current file position without changing the position._♩(RS_PER_00004)_

> [SWS_PER_00525] *[*ara::per::ReadAccessor::PeekByte 应返回当前文件位置的字节，而不改变位置。_♩(RS_PER_00004)_


**[SWS_PER_00526]** *[*ara::per::ReadAccessor::GetByte shall return the byte at the current file position and advance the position by one._♩(RS_PER_00004)_

> **[SWS_PER_00526]** *[*ara::per::ReadAccessor::GetByte 应该返回当前文件位置的字节，并将位置向前移动一个。_♩(RS_PER_00004)_


**[SWS_PER_00527]** *[*ara::per::ReadAccessor::ReadBinary shall read binary data from the current position to the end of the file and return it as an ara::core::Vector of ara::core::Byte. The position shall be set to the end of the file._♩_

> [SWS_PER_00527]*ara :: PER :: ReadAccessor :: ReadBinary 将从当前位置读取二进制数据，直到文件结尾，并将其作为ara :: core :: Vector的ara :: core :: Byte返回。位置将设置为文件结尾。

_(RS_PER_00004)_


**[SWS_PER_00528]** *[*ara::per::ReadAccessor::ReadBinary shall read the n characters of text from the current position and return them as an ara::core::Vector of ara::core::Byte. The position shall be incremented by n. In case the end of the file is reached during this operation, the available bytes shall be returned, and the position shall be set to the end of the file._♩(RS_PER_00004)_

> **[SWS_PER_00528]** *[*ara::per::ReadAccessor::ReadBinary应从当前位置读取n个字符的文本，并将它们作为ara::core::Vector的ara::core::Byte返回。位置将增加n个。如果在此操作期间到达文件结尾，则将返回可用字节，并将位置设置为文件结尾。_♩(RS_PER_00004)_


To write text to files, the application may use the ara::per::ReadWriteAccessor::WriteText method or the ara::per::ReadWriteAccessor::operator\<\< of the ara::per::ReadWriteAccessor class, which treat text in the same way as described above for e.g. ara::per::ReadAccessor::ReadText.

> 要将文本写入文件，应用程序可以使用ara :: per :: ReadWriteAccessor :: WriteText方法或ara :: per :: ReadWriteAccessor :: operator \ <<类，它们以与ara :: per :: ReadAccessor :: ReadText等描述的方式处理文本。


[]{#\_bookmark70 .anchor}**[SWS_PER_00557]** *[*If the file was opened with ara::per::OpenMode set to kAppend, Persistency shall always set the current position to the end of the file before writing data to the file according to [[SWS_PER_00529](#_bookmark71)], [[SWS_PER_00530](#_bookmark72)], or [[SWS_PER_00531](#_bookmark73)]._♩(RS_PER_00004)_

> 如果文件以ara :: per :: OpenMode设置为kAppend打开，持久性应根据[[SWS_PER_00529](#_bookmark71)], [[SWS_PER_00530](#_bookmark72)], 或[[SWS_PER_00531](#_bookmark73)]在写入文件数据之前始终设置当前位置到文件结尾。_♩(RS_PER_00004)_


[]{#\_bookmark71 .anchor}**[SWS_PER_00529]** *[*ara::per::ReadWriteAccessor::WriteText shall write the characters provided as ara::core::StringView to the file at the current position, possibly overwriting current content and advancing the end of the file if necessary. The position shall be set to the character following the last character that was written during this operation, or to the end of the file._♩(RS_PER_00004)_

> ara::per::ReadWriteAccessor::WriteText 将提供的ara::core::StringView作为字符写入文件，可能会覆盖当前内容，并在必要时推进文件的结尾。该位置将设置为此操作期间写入的最后一个字符的后面的字符，或者设置为文件的结尾。


[]{#\_bookmark72 .anchor}**[SWS_PER_00530]** *[*ara::per::ReadWriteAccessor::operator\<\< shall write the characters provided as ara::core::StringView to the file at the current position, possibly overwriting current content and advancing the end of the file if necessary. The position shall be set to the character following the last character that was written during this operation, or to the end of the file. If an error occurs during this operation, the file content might be partially updated and the resulting file position might not be as expected._♩(RS_PER_00004)_

> ara::per::ReadWriteAccessor::operator<< 将提供的ara::core::StringView字符写入文件，可能会覆盖当前内容并在必要时推进文件结尾。如果此操作期间发生错误，文件内容可能会部分更新，并且最终的文件位置可能不会如预期。位置将设置为此次操作期间写入的最后一个字符之后的字符，或者文件结尾。


To write binary data to a file, the application may use the method ara::per::ReadWriteAccessor::WriteBinary of the ara::per::ReadWriteAccessor

> 要将二进制数据写入文件，应用程序可以使用ara::per::ReadWriteAccessor::WriteBinary方法。


class. See also [[SWS_PER_00557](#_bookmark70)] for ara::per::OpenMode kAppend.

> 类。另请参见[[SWS_PER_00557](#_bookmark70)]关于ara::per::OpenMode kAppend的说明。


[]{#\_bookmark73 .anchor}**[SWS_PER_00531]** *[*ara::per::ReadWriteAccessor::WriteBinary shall write the bytes provided as ara::core::Span of ara::core::Byte to the file at the current position, possibly overwriting current content and advancing the end of the file if necessary. The position shall be set to the byte following the last byte that was written during this operation, or to the end of the file._♩(RS_PER_00004)_

> ara::per::ReadWriteAccessor::WriteBinary 将提供的ara::core::Span的ara::core::Byte字节写入文件的当前位置，可能会覆盖当前内容并在必要时推进文件的结尾。在此操作期间，位置应设置为最后一个字节之后的字节，或者设置为文件的结尾。


The application may use ara::per::ReadWriteAccessor::SetFileSize to explicitly set the file size to a defined value in order to truncate a file or to empty

> 应用程序可以使用ara::per::ReadWriteAccessor::SetFileSize来明确将文件大小设置为定义的值，以便截断文件或清空文件。


it. Enlarging files is not supported by ara::per::ReadWriteAccessor::SetFileSize.

> 不支持通过ara::per::ReadWriteAccessor::SetFileSize来放大文件。


**[SWS_PER_00532]** *[*ara::per::ReadWriteAccessor::SetFileSize shall set the file size to the provided value. The read/write position shall be set to the end of the file if the current position is higher than the new file size. If the provided value is larger than the current file size, ara::per::ReadWriteAccessor::SetFileSize shall return kInvalidSize._♩(RS_PER_00004)_

> **[SWS_PER_00532]** *[*ara::per::ReadWriteAccessor::SetFileSize 必须将文件大小设置为提供的值。如果当前位置高于新文件大小，则读/写位置将设置为文件末尾。如果提供的值大于当前文件大小，ara::per::ReadWriteAccessor::SetFileSize 将返回 kInvalidSize。(RS_PER_00004)


When the application changed a file, Persistency will ensure that these changes are persisted. This can happen at any time, and latest when the file is closed. To trigger an additional synchronization of the file content to the persistent storage, the application may call ara::per::ReadWriteAccessor::SyncToFile.

> 当应用程序更改文件时，持久性将确保这些更改被持久化。这可能发生在任何时候，最晚是文件关闭时。要触发对文件内容的附加同步到持久存储，应用程序可以调用ara：per：ReadWriteAccessor：SyncToFile。


**[SWS_PER_00533]** *[*When ara::per::ReadWriteAccessor::SyncToFile is called, Persistency shall start writing the content of the file to the persistent storage. The actual update of the persistent storage may still be ongoing or may not even have started when this call returns._♩(RS_PER_00004)_

> 当调用ara::per::ReadWriteAccessor::SyncToFile时，Persistency将开始将文件的内容写入持久存储。实际的持久存储更新可能仍在进行中，甚至在此调用返回时可能尚未开始。_♩（RS_PER_00004）_

### Access to Additional Information about Files


To gain information about stored files, the Persistency provides the methods ara::per::FileStorage::GetCurrentFileSize and ara::per::FileStorage::GetFileInfo.

> 要获取有关存储文件的信息，Persistency提供了ara::per::FileStorage::GetCurrentFileSize和ara::per::FileStorage::GetFileInfo方法。


The application can poll the amount of storage space currently occupied by a single file using ara::per::FileStorage::GetCurrentFileSize of an open File Storage.

> 应用程序可以使用ara::per::FileStorage::GetCurrentFileSize查询打开的文件存储中单个文件当前占用的存储空间量。


**[SWS_PER_00549]** *[*When ara::per::FileStorage::GetCurrentFileSize is called, Persistency shall first check whether the file is present in the File Storage, and otherwise return directly with kFileNotFound._♩(RS_AP_00128)_

> 当调用ara::per::FileStorage::GetCurrentFileSize时，Persistency应首先检查文件是否存在于文件存储中，否则直接返回kFileNotFound。_♩（RS_AP_00128）_


**[SWS_PER_00493]** *[*When ara::per::FileStorage::GetCurrentFileSize is called for an existing file, Persistency shall return the current size of the passed file. This size shall reflect only the data contained in the file. In case the file is currently open, Persistency shall return the current size of the file, which might differ from the size of the file in the storage if the last changes are not yet synchronized. Otherwise, if the file is not open, Persistency shall return the size of any existing instance of the file without checking the consistency/validity of the file._♩ (RS_PER_00011)_

> 当调用ara::per::FileStorage::GetCurrentFileSize时，对于一个现有的文件，Persistency应返回传入文件的当前大小。此大小仅反映文件中包含的数据。如果文件当前处于打开状态，Persistency应返回文件的当前大小，这可能与存储中的文件大小不同，如果最后的更改尚未同步。否则，如果文件未打开，Persistency应返回任何现有实例的大小，而不检查文件的一致性/有效性。（RS_PER_00011）


Please note that administrative and redundant information is not included in the file size reported by ara::per::FileStorage::GetCurrentFileSize, while it is included in the total size of the File Storage returned by ara::per::GetCurrentFileStorageSize (see [[SWS_PER_00492](#_bookmark66)]).

> 请注意，ara :: per :: FileStorage :: GetCurrentFileSize报告的文件大小不包括行政和多余的信息，而ara :: per :: GetCurrentFileStorageSize返回的文件存储的总大小则包括（参见[[SWS_PER_00492]]）。


Using ara::per::FileStorage::GetFileInfo, the application can acquire information about the time the file was created (creationTime), last modified ( modificationTime), and last accessed (accessTime), and how and by whom it was created (fileCreationState) and last modified (fileModificationState).

> 使用ara::per::FileStorage::GetFileInfo，应用程序可以获取文件创建时间（creationTime）、上次修改时间（modificationTime）、上次访问时间（accessTime）以及文件是如何创建（fileCreationState）和上次修改（fileModificationState）的信息。


**[SWS_PER_00550]** *[*When ara::per::FileStorage::GetFileInfo is called, Persistency shall first check whether the file is present in the File Storage, and otherwise return directly with kFileNotFound._♩(RS_AP_00128)_

> 当调用ara::per::FileStorage::GetFileInfo时，Persistency应首先检查文件是否存在于文件存储中，否则直接返回kFileNotFound。♩（RS_AP_00128）


**[SWS_PER_00440]** *[*When ara::per::FileStorage::GetFileInfo is called for an existing file, Persistency shall gather the required information into a ara::per::FileInfo struct and return it to the application._♩(RS_PER_00004)_

> 当ara::per::FileStorage::GetFileInfo被调用用于一个存在的文件时，Persistency应收集所需的信息到ara::per::FileInfo结构体中，并将其返回给应用程序。♩（RS_PER_00004）


In case the Persistency uses a file system of the underlying OS, part of that information (like the creation or access time) can be obtained from the file system. This information might not be accurate if the file is currently open.

> 如果持久性使用底层操作系统的文件系统，部分信息（如创建或访问时间）可从文件系统获得。如果文件当前处于打开状态，此信息可能不准确。


**[SWS_PER_00458]** *[*If creationTime, modificationTime, or accessTime are not available, they shall be set to 0._♩(RS_PER_00004)_

> 如果创建时间、修改时间或访问时间不可用，则应将其设置为0。（RS_PER_00004）


As an example, the accessTime is not available for a read-only File Storage, and would therefore be reported as "midnight 1970-01-01".

> 举个例子，只读文件存储没有可用的访问时间，因此会报告为“1970年1月1日午夜”。

# API Specification


The APIs for accessing File Storages and Key-Value Storage are completely separate, and therefore divided into separate sections. Additional sections describe common functionality.

> API 用于访问文件存储和键值存储是完全分开的，因此分为不同的部分。另外的部分描述了常见的功能。


The API of Persistency is designed around the ara::per::SharedHandle and

> API 持久性设计围绕 ara::per::SharedHandle。


ara::per::UniqueHandle, which are returned by factory functions like ara::per::OpenKeyValueStorage or ara::per::FileStorage::OpenFileReadWrite. The classes defined in this chapter cannot be constructed directly by the Adaptive Application, and consequently the default constructors are considered to be not publicly accessible (i.e. to be deleted, private, or protected).

> ara::per::UniqueHandle 是由工厂函数（比如 ara::per::OpenKeyValueStorage 或 ara::per::FileStorage::OpenFileReadWrite）返回的。本章中定义的类不能直接由自适应应用程序构造，因此默认构造函数被认为是不公开可见的（即被删除、私有或受保护）。


1. ## General Features of Persistency

> ## 持久性的一般特征


   1. ### ara::core Types

> ### ara::core 类型


The ara::per API is based heavily on the ara::core types defined in [2].

> ara::per API 严重依赖于在[2]中定义的ara::core类型。


ara::core::Result is used wherever possible, and because of this, most methods are defined as noexcept.

> ara::core::Result被尽可能多地使用，因此大多数方法都被定义为noexcept。


Consequently, in situations where memory cannot be allocated for new objects, the Persistency shall terminate the process by calling ara::core::Abort (see [2]).

> 因此，在无法为新对象分配内存的情况下，Persistency 将通过调用 ara::core::Abort（参见[2]）终止该进程。

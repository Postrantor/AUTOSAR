---
tip: translate by openai@2023-06-23 17:24:02
...
# Contents

```
1. [Introduction and functional overview](#introduction-and-functional-overview) 9
2. Acronyms and abbreviations 10
3. [Related documentation](#related-documentation) 12

   1. [Input documents & related standards and norms](#input-documents-related-standards-and-norms) 12
   2. [Related specification](#related-specification) 12
   3. [Further applicable specification](#further-applicable-specification) 13
4. [Constraints and assumptions](#constraints-and-assumptions) 14

   1. [Known Limitations](#known-limitations) 14
   2. [Applicability to car domains](#applicability-to-car-domains) 14
5. [Dependencies to other functional clusters](#dependencies-to-other-functional-clusters) 15

   1. [Interfaces to Adaptive State Management](#interfaces-to-adaptive-state-management) 15
   2. [UCM service over ara::com](#ucm-service-over-aracom) 15
   3. [Interfaces to Adaptive Crypto Interface](#interfaces-to-adaptive-crypto-interface) 15
   4. [Interfaces to Identity and Access Management](#interfaces-to-identity-and-access-management) 16
   5. [Interfaces to Adaptive TimeSynchronization Interface](#interfaces-to-adaptive-timesynchronization-interface) 16
   6. [UCM use of Persistency library](#ucm-use-of-persistency-library) 16
6. Requirements Tracing 17
7. [Functional specification](#functional-specification) 28

   1. [UCM](#ucm) 28

      1. [Software Cluster lifecycle](#software-cluster-lifecycle) 28
      2. [Technical Overview](#technical-overview) 29

         1. [Software Package Management](#software-package-management) 30
         2. [Runtime dependencies](#runtime-dependencies) 34
         3. [Update scope and State Management](#update-scope-and-state-management) 34
      3. [Transferring Software Packages](#transferring-software-packages) 35

         1. [Error handling in TransferStart](#error-handling-in-transferstart) 38
         2. [Error handling in TransferData](#error-handling-in-transferdata) 38
         3. [Error handling in TransferExit](#error-handling-in-transferexit) 40
         4. [Error handling in DeleteTransfer](#error-handling-in-deletetransfer) 42
      4. [Processing of Software Packages from a stream](#processing-of-software-packages-from-a-stream) 42
      5. [Processing Software Packages](#processing-software-packages) 43

         1. [Error handling during Processing Software Packages](#error-handling-during-processing-software-packages) 44
         2. [Error handling for Cancel](#error-handling-for-cancel) 46
         3. [Error handling for RevertProcessedSwPackages](#error-handling-for-revertprocessedswpackages-sws_ucm_00279draft-revertprocessedswpackages-error-handling-order) 47
         4. [Error handling for GetSwProcessProgress](#error-handling-for-getswprocessprogress) 47
      6. [Activation and Rollback](#activation-and-rollback) 47

         1. [Activation](#activation) 48
         2. [Rollback](#rollback) 50
         3. [Boot options](#boot-options) 51
         4. [Finishing activation](#finishing-activation) 52
      7. [Status Reporting](#status-reporting) 52
      8. [Robustness against reset](#robustness-against-reset) 57

         1. [Boot monitoring](#boot-monitoring) 57
      9. [History](#history) 58
      10. [Version Reporting](#version-reporting) 58
      11. [Securing Software Updates](#securing-software-updates) 59
      12. [Functional cluster lifecycle](#functional-cluster-lifecycle) 59

          1. [Shutdown behaviour](#shutdown-behaviour) 60
   2. [UCM Master](#ucm-master) 61

      1. [UCM Master Functional Cluster lifecycle](#ucm-master-functional-cluster-lifecycle) 61
      2. [Technical Overview](#technical-overview-1) 61
      3. [UCM Master general behaviour](#ucm-master-general-behaviour) 62
      4. [UCM identification](#ucm-identification) 63
      5. [UCM Master Software Packages transfer or streaming](#ucm-master-software-packages-transfer-or-streaming) 63
      6. [Adaptive Applications interacting with UCM Master](#adaptive-applications-interacting-with-ucm-master) 64

         1. [OTA Client](#ota-client) 65
         2. [Vehicle Driver Interface](#vehicle-driver-interface) 66
         3. [Vehicle State Manager](#vehicle-state-manager) 68
         4. [Flashing Adapter](#flashing-adapter) 69
      7. [Non Adaptive Platform update](#non-adaptive-platform-update) 70

         1. [D-PDU API implementation support](#d-pdu-api-implementation-support) 70
         2. [Not required D-PDU API concepts](#not-required-d-pdu-api-concepts) 71
         3. [Not required D-PDU API functions](#not-required-d-pdu-api-functions) 71
         4. [Classic platform update with UCM Master and diag-](#classic-platform-update-with-ucm-master-and-diagnostic-tool) [nostic tool](#classic-platform-update-with-ucm-master-and-diagnostic-tool) 73
      8. [Status reporting](#status-reporting-1) 74

         1. [States](#states) 76
         2. [States Transitions](#states-transitions) 77
      9. [Campaign cancelling](#campaign-cancelling) 79
      10. [Campaign Reporting](#campaign-reporting) 80
      11. [Content of Vehicle Package](#content-of-vehicle-package) 81
      12. [Vehicle update security and confidentiality](#vehicle-update-security-and-confidentiality) 83
8. [API specification](#api-specification) 84
9. [Service Interfaces](#service-interfaces) 85

   1. [Type definitions](#type-definitions) 85

      1. UCMIdentifierType 87
      2. TransferIdType 87
      3. SwNameType 87
      4. StrongRevisionLabelString 88
      5. SwNameVersionType 88
      6. SwNameVersionVectorType 88
      7. ByteVectorType 89
      8. SwPackageStateType 89
      9. SwPackageInfoType 89
      10. SwPackageInfoVectorType 90
      11. SwDescType 90
      12. SwDescVectorType 91
      13. SwPackageDescType 91
      14. SwPackageDescVectorType 91
      15. SwClusterStateType 92
      16. SwClusterInfoType 92
      17. SwClusterInfoVectorType 92
      18. PackageManagementStatusType 93
      19. ActionType 93
      20. ResultType 94
      21. GetHistoryType 94
      22. GetHistoryVectorType 94
      23. CampaignHistoryType 95
      24. CampaignHistoryVectorType 95
      25. CampaignResultType 95
      26. UCMMasterResolutionType 96
      27. UCMStepErrorVectorType 96
      28. UCMStepErrorType 96
      29. SoftwarePackageStepType 97
      30. HistoryVectorType 97
      31. HistoryType 98
      32. CampaignStateType 98
      33. TransferStateType 99
      34. SafetyConditionType 99
      35. SafetyConditionsVectorType 99
      36. SafetyStatesType 100
      37. SafetyStatesVectorType 100
   2. Provided Service Interfaces 100

      1. Package Management 100
      2. Vehicle Package Management 107
      3. Vehicle Driver Application Interface 115
      4. Vehicle State Manager 118
   3. Required Interface 120

      1. State Management Update Request 120
   4. Application Errors 120

      1. Application Error Domain 120

         1. UCMErrorDomain 120
10. Sequence diagrams 122

    1. Update process 122
    2. Data transmission 123
    3. Package processing 124
    4. Activation 125
    5. Failing activation 126
    6. Failing rollback 127
    7. UCM Master simplified vehicle update 128
```

# 1 Introduction and functional overview


This software specification contains the functional description and interfaces of the functional cluster Update and Configuration Management which belongs to the AUTOSAR Adaptive Platform Services. Update and Configuration Management has the responsibility of installing, updating and removing software on an AUTOSAR Adaptive Platform in a safe and secure way while not sacrificing the dynamic nature of the AUTOSAR Adaptive Platform.

> 这个软件规范包含了属于AUTOSAR自适应平台服务的功能群更新和配置管理的功能描述和接口。更新和配置管理负责安全可靠地安装、更新和移除AUTOSAR自适应平台上的软件，同时不牺牲AUTOSAR自适应平台的动态性。


The Update and Configuration Management functional cluster is responsible for:

> 該更新和配置管理功能群組負責：

- Version reporting of the software present in the AUTOSAR Adaptive Platform
- Receiving and buffering software updates
- Checking that enough resources are available to ensure a software update
- Performing software updates and providing log messages and progress information
- Validating the outcome of a software update
- Providing rollback functionality to restore a known functional state in case of failure


In addition to updating and changing software on the AUTOSAR Adaptive Platform, the Update and Configuration Management is also responsible for updates and changes to the AUTOSAR Adaptive Platform itself, including all functional clusters, the underlying POSIX OS and its kernel with the responsibilities defined above.

> 除了更新和更改AUTOSAR Adaptive平台的软件外，更新和配置管理还负责对AUTOSAR Adaptive平台本身的更新和更改，包括所有功能集群、基础POSIX操作系统及其内核，以及上述定义的职责。


In order to allow flexibility in how Update and Configuration Management is used, it will expose its functionality via ara::com service interfaces, not direct APIs. This ensures that the user of the functional cluster Update and Configuration Management does not have to be located on the same ECU.

> 为了允许在使用更新和配置管理时有更多的灵活性，它将通过ara :: com服务接口而不是直接的API来暴露其功能。这确保功能集群更新和配置管理的用户不必位于同一个ECU上。


3. # Related documentation

> # 相关文档


   1. ## Input documents & related standards and norms

> ## 输入文件及相关标准和规范

```{=html}
```


1. Glossary [AUTOSAR_TR_Glossary

> 1. 术语表（AUTOSAR_TR_Glossary）

2. Specification of Execution Management AUTOSAR_SWS_ExecutionManagement

> 2. AUTOSAR_SWS_执行管理的规范

3. Specification of State Management AUTOSAR_SWS_StateManagement

> 3. AUTOSAR_SWS_状态管理规范

4. Specification of Communication Management AUTOSAR_SWS_CommunicationManagement

> 4. AUTOSAR_SWS_CommunicationManagement 的通信管理规范

5. General Requirements specific to Adaptive Platform AUTOSAR_RS_General

> 五、针对Adaptive Platform AUTOSAR_RS_General的具体要求

6. Specification of Cryptography AUTOSAR_SWS_Cryptography

> 6. 加密算法AUTOSAR_SWS_Cryptography的规范

7. Specification of Identity and Access Management AUTOSAR_SWS_IdentityAndAccessManagement

> 7. AUTOSAR_SWS_IdentityAndAccessManagement 的身份和访问管理规范

8. Specification of Time Synchronization AUTOSAR_SWS_TimeSynchronization

> 8. AUTOSAR_SWS_TimeSynchronization 的时间同步规范

9. Requirements on Update and Configuration Management AUTOSAR_RS_UpdateAndConfigurationManagement

> 要求关于AUTOSAR_RS_更新与配置管理

10. Specification of Manifest AUTOSAR_TPS_ManifestSpecification

> 10. AUTOSAR_TPS 清单规范说明

11. Explanation of Adaptive Platform Design AUTOSAR_EXP_PlatformDesign

> 11. 自适应平台设计AUTOSAR的解释

12. Specification of Persistency AUTOSAR_SWS_Persistency

> 12. AUTOSAR_SWS_持久性规范

13. Specification of Platform Health Management AUTOSAR_SWS_PlatformHealthManagement

> 13. AUTOSAR_SWS_PlatformHealthManagement 平台健康管理规范

    1. ## Related specification


See chapter [3.1](#input-documents-related-standards-and-norms).

> 见第三章第一节（#输入文档相关标准和规范）。

## Further applicable specification


AUTOSAR provides a general specification [[5](#_bookmark6)] which is also applicable for UCM. The specification RS General shall be considered as additional and required specification for implementation of UCM.

> AUTOSAR提供了一个通用规范[[5](#_bookmark6)]，也适用于UCM。RS General规范应被视为实现UCM所必需的附加规范。


4. # Constraints and assumptions

> 4. # 约束和假设


   1. ## Known Limitations

> ## 已知限制


UCM is not responsible to initiate the update process. UCM realizes a service interface to achieve this operation. The user of this service interface is responsible to verify that the vehicle is in a updatable state before executing a software update procedure on demand. It is also in the responsibility of the user to communicate with other AUTOSAR Adaptive Platforms or AUTOSAR Classic Platforms within the vehicle.

> UCM不负责启动更新过程。UCM提供一个服务接口来实现此操作。使用此服务接口的用户负责在执行软件更新程序之前验证车辆处于可更新状态。用户还负责与车辆内的其他AUTOSAR Adaptive Platforms或AUTOSAR Classic Platforms进行通信。


The UCM receives a locally available software package for processing. The software package is usually downloaded from the OEM backend. The download of the software packages has to be done by another application, i.e. UCM does not manage the connection to the OEM backend. Prior to triggering their processing, the software packages have to be transferred to UCM by using the provided ara::com interface.

> UCM接收本地可用的软件包用于处理。通常情况下，该软件包需要从OEM后端进行下载。软件包的下载必须由另一个应用程序完成，即UCM不负责与OEM后端的连接。在触发其处理之前，必须使用提供的ara :: com接口将软件包传输到UCM。


The UCM update process is designed to cover updates on use case with single AUTOSAR Adaptive Platform. UCM can update Adaptive Applications, the AUTOSAR Adaptive Platform itself, including all functional clusters and the underlying OS.

> UCM更新过程旨在涵盖使用单个AUTOSAR自适应平台的用例的更新。UCM可以更新自适应应用程序，包括AUTOSAR自适应平台本身，所有功能集以及底层操作系统。


The UCM is not responsible for enforcing authentication and access control to the provided interfaces. The document currently does not provide any mechanism for the confidentiality protection as well as measures against denial of service attacks. The assumption is that the platform preserves the integrity of parameters exchanged between UCM and its user.

> UCM不负责对提供的接口进行身份验证和访问控制。目前文件未提供任何机制来保护机密性以及防止拒绝服务攻击。假设平台保持UCM和其用户之间交换参数的完整性。


The possibility to restart a specific application instead of a Machine reboot depends of the kind of update and application, is therefore implementation specific and is defined in the Software Package manifest.

> 取决于更新类型和应用程序，重启特定应用而不是机器重启的可能性，因此是特定实现的，并在软件包清单中定义。


UCM does only support updates of ARA::COM and UDS (ISO-14229) compliant ECUs. UCM is not controlling any action done by diagnostic tool directly updating a Classic platform. For instance UCM cannot protect against downgrading of a Software Cluster in a Classic platform by a diagnostic tool.

> UCM只支持ARA::COM和符合UDS（ISO-14229）的ECU的更新。 UCM不能直接控制诊断工具更新经典平台所做的任何操作。 例如，UCM无法防止诊断工具在经典平台上降级软件集。

## Applicability to car domains


No restrictions to applicability.

> 没有适用性限制。

# Dependencies to other functional clusters


The UCM functional cluster expose services to client applications via the ara::com

> 功能集群UCM向客户端应用程序通过ara::com暴露服务。

![](./media/image1.png)middleware.
**Figure 5.1: UCM dependencies to other Functional Clusters.**

## Interfaces to Adaptive State Management


UCM relies on State Management and its provided UpdateRequest Service Interface to perform the necessary Function Group state changes needed to activate the newly installed, updated or removed software.

> UCM依靠状态管理和提供的更新请求服务接口来执行必要的功能组状态更改，以激活新安装、更新或删除的软件。


Certain applications can conflict with the update process or the newly updated package, and they need to be stopped during the update process. This could be achieved by putting the machine to a safe Machine state, by activating a combination of suitable Function Groups and its states. It is the responsibility of the platform integrator to define this state or Function Groups. The Adaptive Application accessing the UCM, should make sure that the platform is switched to this state (using interfaces from State Management), before starting the update.

> 某些应用程序可能与更新过程或新更新的软件包发生冲突，在更新过程中需要停止这些应用程序。可以通过激活合适的功能组及其状态的组合，将机器置于安全状态来实现。平台集成器负责定义此状态或功能组。访问UCM的自适应应用程序应确保在开始更新之前，将平台切换到此状态（使用状态管理的接口）。

## UCM service over ara::com


The UCM shall provide a service interface over ara::com using methods and fields.

> UCM需要通过ara::com提供一个服务接口，使用方法和字段。

## Interfaces to Adaptive Crypto Interface


UCM uses Crypto Interface for AUTOSAR Adaptive Platform [[6](#_bookmark7)] to verify package integrity and authenticity and to decrypt confidential update data.

> UCM使用Crypto Interface for AUTOSAR Adaptive Platform [[6](#_bookmark7)]来验证包裹的完整性和真实性，并解密机密更新数据。

## Interfaces to Identity and Access Management


Identity and Access Management [[7](#_bookmark8)] controls the UCM's Clients access to UCM's service interface PackageManagement.

> 身份和访问管理[[7](#_bookmark8)]控制UCM的客户访问UCM的服务接口PackageManagement。

## Interfaces to Adaptive TimeSynchronization Interface


UCM uses TSync Interface [[8](#_bookmark9)] for AUTOSAR Adaptive Platform to get the latest timestamp.

> UCM使用TSync接口[[8](#_bookmark9)]为AUTOSAR Adaptive Platform获取最新的时间戳。

## UCM use of Persistency library


UCM may use ara::per to store internal status information. This can e.g. be used to recover after reboot.

> UCM可以使用ara::per来存储内部状态信息。这可以用于重新启动后的恢复。


7. # Functional specification

> 功能规格说明

   1. ## UCM

      1. ### Software Cluster lifecycle

![](./media/image3.png)![](./media/image4.png)RevertProcessedSw Packages

**Figure 7.1:** **State Machine for a Software Cluster**


The state machine in Fig. [7.1](#_bookmark29) describes the life-cycle states of a Software Cluster. These states are reported with GetSwClusterChangeInfo method.

> 图7.1中的状态机描述了软件集群的生命周期状态。这些状态使用GetSwClusterChangeInfo方法报告。


**[SWS_UCM_00191] Software Cluster life-cycle state kAdded** [A Software Cluster state shall be kAdded after the Software Cluster is successfully processed with ProcessSwPackage method call on the AUTOSAR Adaptive Platform and if it was not previously present in the AUTOSAR Adaptive Platform and before activation is finished.*♩(RS_UCM_00011)*

> **[SWS_UCM_00191] 软件集群生命周期状态 kAdded** [当软件集群成功地使用AUTOSAR Adaptive平台的ProcessSwPackage方法调用处理，且在AUTOSAR Adaptive平台中之前不存在，在激活完成之前，软件集群状态应为kAdded。♩(RS_UCM_00011)**


**[SWS_UCM_00192] Software Cluster life-cycle state transition from kAdded to kPresent** [A Software Cluster state shall change from kAdded to kPresent after a successful activation of a newly added Software Cluster with Finish method call.*♩(RS_UCM_00011)*

> **[SWS_UCM_00192] 软件集群的生命周期状态从kAdded转换到kPresent** [一个软件集群的状态应该在成功激活新添加的软件集群后，通过Finish方法调用从kAdded转换到kPresent。*♩(RS_UCM_00011)*


**[SWS_UCM_00195] Software Cluster life-cycle state kUpdating** [A Software Cluster state shall be kUpdating after a successful processing of the updated Software Cluster with ProcessSwPackage method call and before activation is finished.*♩(RS_UCM_00011)*

> **[SWS_UCM_00195]软件集群生命周期状态kUpdating**[在使用ProcessSwPackage方法调用成功处理更新后，软件集群状态应为kUpdating，在激活完成之前。*♩(RS_UCM_00011)*


**[SWS_UCM_00193] Software Cluster life-cycle state transition from kUpdating to kPresent** [A Software Cluster state shall change from kUpdating to kPresent after a successful activation of the updated Software Cluster with Finish method call, or after reverting the Software Cluster update with a RevertProcessedSwPackages method call.*♩(RS_UCM_00011)*

> **[SWS_UCM_00193] 软件集群的生命周期状态从kUpdating转换为kPresent** [软件集群的状态应该在成功激活更新后的软件集群，或者通过RevertProcessedSwPackages方法调用恢复软件集群更新后，从kUpdating转换为kPresent。*♩(RS_UCM_00011)*


**[SWS_UCM_00196] Software Cluster life-cycle state kRemoved** [A Software Cluster state shall be kRemoved after successful completion of method ProcessSwPackage which involves the removal of the existed Software Cluster and before activation is finished.*♩(RS_UCM_00011)*

> **[SWS_UCM_00196] 软件集群生命周期状态kRemoved** [在成功完成涉及删除现有软件集群的ProcessSwPackage方法之后，在激活完成之前，软件集群状态应该设置为kRemoved。*♩(RS_UCM_00011)*


**[SWS_UCM_00194] Software Cluster life-cycle state transition from kRemoved to kPresent in case of RevertProcessedSwPackages call** [A Software Cluster state shall change from kRemoved to kPresent after a successful call to RevertProcessedSwPackages method in case the Software Cluster was previously requested to be removed by ProcessSwPackage method call.*♩(RS_UCM\_00011)*

> **[SWS_UCM_00194] 如果调用RevertProcessedSwPackages，软件集群的生命周期状态从kRemoved转换为kPresent。[如果先前通过ProcessSwPackage方法调用请求删除软件集群，则在成功调用RevertProcessedSwPackages后，软件集群的状态将从kRemoved更改为kPresent。*♩(RS_UCM\_00011)*`


**[SWS_UCM_00286] Software Cluster life-cycle state transition from kRemoved to kPresent in case of Finish call** [A Software Cluster state shall change from kRemoved to kPresent after a successful call to Finish method in case a Software Cluster being removed has to be rolled back after a failing activation.*♩(RS_UCM_00011)*

> **[SWS_UCM_00286] 在完成调用的情况下，软件集群的生命周期状态从kRemoved转换为kPresent。如果在激活失败后需要回滚已删除的软件集群，则在成功调用Finish方法后，软件集群的状态应从kRemoved转换为kPresent。*♩(RS_UCM_00011)*


**[SWS_UCM_00197] End of Software Cluster life-cycle state from state kAdded in case of RevertProcessedSwPackages call** [A Software Cluster shall reach the end of its life-cycle from kAdded after a successful removal of a newly added Software Cluster with RevertProcessedSwPackages method call in case the Software Cluster was previously requested to be added by ProcessSwPackage method call.*♩(RS_UCM_00011)*

> **[SWS_UCM_00197] 如果调用RevertProcessedSwPackages，从kAdded状态结束软件集群的生命周期。[如果先前通过ProcessSwPackage方法调用请求添加软件集群，则成功删除新添加的软件集群后，软件集群将从kAdded状态达到其生命周期结束。*♩(RS_UCM_00011)*


**[SWS_UCM_00287] End of Software Cluster life-cycle state from state kAdded in case of Finish call** [A Software Cluster shall reach the end of its life-cycle from kAdded after a successful removal of a newly added Software Cluster with Finish method call in case the newly added Software Cluster has to be rolled back after a failing activation.*♩(RS_UCM_00011)*

> [SWS_UCM_00287] 如果调用Finish方法，新添加的软件集群在激活失败后需要回滚，则软件集群的生命周期从kAdded状态结束。♩（RS_UCM_00011）


**[SWS_UCM_00198] End of Software Cluster life-cycle state from state kRemoved** [A Software Cluster shall reach the end of its life-cycle if it is successfully removed with a Finish method call and the Software Cluster is in state kRemoved.*♩(RS_UCM_00011)*

> **[SWS_UCM_00198] 软件集群生命周期状态从kRemoved状态结束** [如果软件集群成功地使用Finish方法调用移除并且处于kRemoved状态，它将达到其生命周期的结束。*♩(RS_UCM_00011)*


**[SWS_UCM_00199] Reporting of Software Cluster reaching end of life-cycle** [Any Software Cluster reaching the end of its life-cycle shall not be reported by UCM any more.*♩(RS_UCM_00011)*

> **[SWS_UCM_00199]软件集群到达生命周期终点的报告**[任何软件集群到达其生命周期终点后将不再由UCM报告。*♩(RS_UCM_00011)*

### Technical Overview


One of the declared goals of AUTOSAR Adaptive Platform is the ability to flexibly update the software and its configuration through over-the-air updates. During the lifecycle of an AUTOSAR Adaptive Platform, UCM is responsible to perform software modifications on the machine and to retain consistency of the whole system.

> 一个被宣布的AUTOSAR Adaptive Platform的目标是通过在空中更新的能力灵活地更新软件和其配置。在AUTOSAR Adaptive Platform的生命周期中，UCM负责对机器进行软件修改并保持整个系统的一致性。


The UCM Functional Cluster provides a service interface that exposes its functionality to retrieve AUTOSAR Adaptive Platform software information and consistently execute software updates. Since ara::com is used, the client using the UCM service interface can be located on the same AUTOSAR Adaptive Platform, but also remote clients are possible.

> 功能群组（UCM）提供了一个服务接口，可以暴露其功能以检索AUTOSAR自适应平台软件信息，并一致地执行软件更新。由于使用了ara::com，使用UCM服务接口的客户端可以位于同一个AUTOSAR自适应平台上，也可以是远程客户端。


The service interface has been primarily designed with the goal to make it possible to use standard diagnostic services for downloading and installing software updates for the AUTOSAR Adaptive Platform. However, the methods and fields in the service interface are designed in such a way that they can be used in principle by any Adaptive Application. UCM does not impose any specific protocol on how data is transferred to the AUTOSAR Adaptive Platform and how package processing is controlled. In particular UCM does not expose diagnostic services.

> 服务接口的主要设计目标是使其能够使用标准诊断服务来下载和安装AUTOSAR自适应平台的软件更新。但是，服务接口中的方法和字段设计得可以原则上由任何自适应应用程序使用。UCM不对数据传输到AUTOSAR自适应平台以及包处理控制的具体协议施加任何限制。特别是UCM不暴露诊断服务。


As shown in Figure [7.2](#_bookmark31), whether the use case is an over-the-air update or garage update done through diagnostics, it is not visible to the UCM. The UCM Client abstracts the use case from the UCM and forwards the data stream and sequence control commands to the UCM. Later in this document, the term UCM Client is used to describe an Adaptive Application that consumes UCM PackageManagement services through UCM ara::com API. Diagnostic Application and UCM Master are two examples of such UCM Clients.

> 如图7.2所示，无论使用案例是通过空中更新还是通过诊断进行的车库更新，UCM都无法看到它。 UCM客户端将使用案例从UCM抽象出来，并将数据流和序列控制命令转发到UCM。 在本文档的后面，将使用术语UCM客户端来描述使用UCM ara :: com API通过UCM PackageManagement服务消费的自适应应用程序。 诊断应用程序和UCM主机是这样的UCM客户端的两个示例。

![](./media/image5.png)«device»
![](./media/image9.jpeg){width="0.6664162292213474in" height="0.5622615923009624in"}**Server**
**Figure 7.2:** **Architecture overview for diagnostic use case**

### Software Package Management


The UCM update sequence consists three different phases:

> UCM更新序列包括三个不同的阶段：


- Software Package transfer: A phase in which, one or several Software Packages are transferred from the UCM's Client Application to the internal buffer of the UCM. For further information see chapter [7.1.3](#transferring-software-packages).

> 软件包传输：一个阶段，一个或多个软件包从UCM的客户端应用程序转移到UCM的内部缓冲区。有关更多信息，请参见第7.1.3节。

- Software Package processing: A phase in which the UCM performs the operation (kInstall, kUpdate, kRemove) on the relevant SoftwareCluster. For further information see chapter [7.1.5](#processing-software-packages).

> 软件包处理：UCM对相关软件集群执行操作（kInstall、kUpdate、kRemove）的阶段。有关更多信息，请参见第7.1.5节（处理软件包）。

- Activation: A phase in which the UCM checks the dependencies of the SoftwareClusters that have been involved in the operation, then activates them and finally check that all the SoftwareClusters can be executed properly (via State Management) prior to finishing the update. For further information see chapter [7.1.6](#activation-and-rollback)

> 激活：UCM检查参与操作的软件集群之间的依赖关系的阶段，然后激活它们，最后通过状态管理检查所有软件集群是否可以正常执行，然后完成更新。有关更多信息，请参见第7.1.6节。


  1. ### Software Package

> ### 软件包


**[SWS_UCM_00122] Software Package utilization** [The unit for deployment that the UCM shall take as input is called Software Package, see [[1](#_bookmark3)]. Each Software Package shall address a single SoftwareCluster.*♩(RS_UCM_00026)*

> **[SWS_UCM_00122] 软件包利用**[UCM所采用的部署单位称为软件包，参见[[1](#_bookmark3)]。每个软件包都应解决一个软件集群。*♩(RS_UCM_00026)*


A SoftwareCluster can act in two roles:

> 软件集群可以扮演两个角色:


- 'Sub'-SoftwareCluster : It is a SoftwareCluster without diagnostic target address, containing processes, executables and further elements

> - 'Sub'-软件集群：这是一个没有诊断目标地址的软件集群，包含进程、可执行文件和其他元素。

- 'Root'-SoftwareCluster : It is a SoftwareCluster with a diagnostic target address that may reference several other 'Sub'-SoftwareClusters, which thus form a logical group.

> 这是一个软件集群，具有诊断目标地址，可以引用其他几个“子”软件集群，从而形成一个逻辑组。


A SoftwareCluster can be of the following categories expressed by the attribute

> 一个软件集群可以按属性归类为以下几类。


SoftwareCluster.category :

> 软件集群。类别：

- APPLICATION_LAYER: the SoftwareCluster can be removed by UCM
- PLATFORM_CORE: the SoftwareCluster cannot be removed as it would break the system.
- PLATFORM: the SoftwareCluster is part of the platform software and can be removed


**[SWS_UCM_00245]**{DRAFT} **Software Cluster category** [UCM shall not remove a SoftwareCluster that has installationBehavior set to value cannotBeRemoved. In case of such an attempt, UCM shall raise ApplicationError SwclRemovalDenied.*♩(RS_UCM_00028, RS_UCM_00029)*

> **[SWS_UCM_00245]**{草稿} **软件集群类别** [UCM不应删除其installationBehavior设置为value cannotBeRemoved的软件集群。 如果尝试这样做，UCM应引发ApplicationError SwclRemovalDenied。*♩（RS_UCM_00028，RS_UCM_00029）*


A Software Package has to be modelled as a so-called SoftwareCluster which describes the content of a Software Package that is downloaded or uploaded to the AUTOSAR Adaptive Platform, see [[10](#_bookmark10)].

> 一个软件包必须模型化为所谓的SoftwareCluster，它描述了被下载或上传到AUTOSAR自适应平台的软件包的内容，详见[[10](#_bookmark10)]。


The term Software Package is used for the \"physical\", uploadable Software Package that is processed by UCM whereas the term SoftwareCluster is used for the modeling element. In the model, the content of a SoftwareCluster is define by references to all required model elements. The SoftwareCluster and the related model elements define the content of the manifest that is part of the Software Package. The Software Package format and the update scope are described in chapter \"Content of a Software Package\" as well as in [[11](#_bookmark11)].

> 术语软件包用于由UCM处理的“物理”，可上传的软件包，而术语SoftwareCluster用于建模元素。在模型中，SoftwareCluster的内容由对所有所需模型元素的引用来定义。SoftwareCluster及相关模型元素定义了软件包的清单的内容，该清单是软件包的一部分。软件包格式及更新范围在“软件包内容”章节中以及[[11](#_bookmark11)]中有详细描述。


**[SWS_UCM_CONSTR_00012]**{DRAFT} [The SoftwareCluster aggregation of ArtifactChecksum shall not include the uri of this same SoftwareCluster manifest.*♩(RS_UCM_00012)*

> **[SWS_UCM_CONSTR_00012]**{草案} [软件集群聚合的ArtifactChecksum不应包含此软件集群清单的uri。*♩(RS_UCM_00012)*


The uri attribute in ArtifactChecksum is referring to the artifact contained in the

> 属性uri在ArtifactChecksum中指的是包含在其中的artifact。

SoftwareCluster.

### Content of a Software Package


Each Software Package addresses a single SoftwareCluster and contains manifests, executables and further data (depending on the role of the SoftwareCluster) as the example sketched in Figure [7.3](#_bookmark35).

> 每个软件包都针对一个软件集群，包含清单、可执行文件和其他数据（取决于软件集群的角色），如图7.3所示。

**Figure 7.3:** **Software Package content description**


A single Software Package is designed in a way that it could contain one or several executables of Adaptive Applications, kernel or firmware updates, or updated configuration and calibration data to be deployed on the AUTOSAR Adaptive Platform.

> 一个软件包被设计成可以包含一个或多个自适应应用程序的可执行文件、内核或固件更新，或者是要部署在AUTOSAR自适应平台上的更新配置和校准数据。


The Software Package manifest is recommended to be sent at the beginning in order for UCM to have early information of for instance memory usage or streaming.

> 软件包清单建议在开始时发送，以便UCM能够尽早获取例如内存使用情况或流媒体等信息。


An exemplary implementation of the adaptive workflow with Software Packages can be seen in chapter Methodology and Manifest in [[11](#_bookmark11)]. For more details on the Software Package class, you can refer to SoftwarePackage

> 可以在[[11](#_bookmark11)]章节中看到软件包的自适应工作流的示范实现。要了解更多关于软件包类的信息，可以参考软件包。


**[SWS_UCM_00112] Software Cluster and version** [SoftwareCluster's manifest shall include a name and a version following description of StrongRevisionLabelString.*♩(RS_UCM_00002)*

> **[SWS_UCM_00112] 软件集群和版本** [软件集群的清单应包括一个名称和一个版本，遵循StrongRevisionLabelString的描述。*♩(RS_UCM_00002)*


**[SWS_UCM_CONSTR_00001]** [If any content (for instance an executable or persistent data) of an already installed SoftwareCluster is modified by an incoming Software Package, then the version number of the incoming SoftwareCluster indicated in the Software Package shall be higher than the version number of the already installed SoftwareCluster.*♩(RS_UCM_00002, RS_UCM_00010, RS_UCM\_00011)*

> **[SWS_UCM_CONSTR_00001]** 如果一个已安装的软件集合的内容（例如可执行文件或持久数据）被一个新的软件包修改，那么新软件包中指示的软件集合的版本号应该比已安装的软件集合的版本号更高。*♩(RS_UCM_00002, RS_UCM_00010, RS_UCM\_00011)*


If the constraint is violated, an error will be raised according to [[SWS_UCM_00103](#_bookmark102)].

> 如果违反了约束，将根据[[SWS_UCM_00103](#_bookmark102)]引发错误。


A higher version number is achieved by an increment of the MajorVersion, the MinorVersion, or the PatchVersion.

> 一个更高的版本号可以通过增加主版本号、次版本号或补丁版本号来实现。


If there is a need to downgrade a failing SoftwareCluster (for instance, malfunction in the field that was not detected at activation), it will therefore be needed to repackage the same old SoftwareCluster that was properly working with an higher version number.

> 如果需要降级一个失败的SoftwareCluster（例如，在激活时没有检测到的现场故障），因此需要用较高版本号重新打包原来正常工作的SoftwareCluster。


**[SWS_UCM_00130] Software Cluster and version error** [If SoftwareCluster's manifest does not contain any SoftwareCluster.version following description of StrongRevisionLabelString, UCM shall raise the ApplicationError InvalidPackageManifest.*♩(RS_UCM_00002)*

> **[SWS_UCM_00130] 软件集群和版本错误** [如果软件集群的清单不包含任何SoftwareCluster.version，以StrongRevisionLabelString描述，UCM应引发ApplicationError InvalidPackageManifest。*♩(RS_UCM_00002)*


**[SWS_UCM_CONSTR_00014]**{DRAFT} **Software Package and Software Cluster shortNames** [SoftwarePackage and the referenced SoftwareCluster shall share the same shortName in order to be able to compare their versions.*♩(RS_UCM\_00033)*

> **[SWS_UCM_CONSTR_00014]**{草案}**软件包和软件集简称**[软件包和其引用的软件集必须具有相同的简称，以便能够比较它们的版本。*♩(RS_UCM\_00033)*

### Applications Persisted Data


Updating and rolling back of persisted data is handled completely by the application using persistency without involvement of UCM. A detailed explanation can be found in the Persistency Specification [[12](#_bookmark12)]. An exception here is the removal of persistent data after a SoftwareCluster is removed.

> 持久化数据的更新和回滚完全由应用程序使用持久性处理，而不涉及UCM。详细说明可以在持久性规范[[12]（#_bookmark12）]中找到。在软件集群被移除后，持久数据的删除是一个例外。


**[SWS_UCM_00184] Persistent data clean-up after Software Cluster removal** [UCM shall remove persistent data of a removed SoftwareCluster by aggregating the information given in the application manifest, namely PersistencyKeyValueStorage.uri and PersistencyFileStorage.uri, in order to leave the AUTOSAR Adaptive Platform and the file system clean.*♩(RS_UCM_00026, RS_UCM_00005, RS_UCM_00004)*

> [SWS_UCM_00184] 在软件集群移除后持久数据清理：UCM应通过聚合应用程序清单中提供的信息（即PersistencyKeyValueStorage.uri和PersistencyFileStorage.uri）来移除被移除的软件集群的持久数据，以便使AUTOSAR Adaptive Platform和文件系统保持清洁。♩（RS_UCM_00026，RS_UCM_00005，RS_UCM_00004）


**[SWS_UCM_00273]**{DRAFT} **Persistent data clean-up after Software Cluster update that removes a process** [UCM shall remove persistent data of a removed process by aggregating the information given in the execution manifest, namely PersistencyKeyValueStorage.uri and PersistencyFileStorage.uri, in order to leave the AUTOSAR Adaptive Platform and the file system clean.*♩(RS_UCM_00026, RS\_UCM_00005, RS_UCM_00004)*

> **[SWS_UCM_00273]**{草案} **软件集群更新后的持久数据清理，移除一个过程** [UCM 应通过聚合执行清单中给出的信息，即 PersistencyKeyValueStorage.uri 和 PersistencyFileStorage.uri，来移除被移除进程的持久数据，以便使 AUTOSAR Adaptive 平台和文件系统保持整洁。*♩(RS_UCM_00026, RS\_UCM_00005, RS_UCM_00004)*

简体中文：**[SWS_UCM_00273]**{草案} **软件集群更新后持久数据清理，移除一个过程** [UCM 应通过聚合执行清单中提供的信息，即 PersistencyKeyValueStorage.uri 和 PersistencyFileStorage.uri，来移除被移除进程的持久数据，以保持 AUTOSAR Adaptive 平台和文件系统的整洁。*♩(RS_UCM_00026, RS\_UCM_00005, RS_UCM_00004)*


Persistent data can include administrative and backup data.

> 持久性数据可以包括行政和备份数据。

### Runtime dependencies


Processes within a SoftwareCluster can have functional dependencies toward other SoftwareClusters.

> 软件集群内的进程可能与其他软件集群存在功能依赖关系。


Dependencies are described in the SoftwareCluster metamodel, see [[10](#_bookmark10)].

> 依赖性在软件集群元模型中有描述，请参见[[10](#_bookmark10)]。


**[SWS_UCM_00120]**{DRAFT} **Runtime dependencies check** [Before the activation of the new software version triggered by Activate method call, UCM shall check runtime dependencies.*♩(RS_UCM_00007)*

> 在通过Activate方法调用触发新软件版本激活之前，UCM应检查运行时依赖关系。♩(RS_UCM_00007)


The rationale is, if UCM has to process several Software Packages, then execution dependencies may not be fulfilled at all times during the Software Packages process but must be fulfilled before changes can be activated.

> 理由是，如果UCM必须处理多个软件包，那么在软件包处理过程中可能无法始终满足执行依赖关系，但必须在更改生效前满足这些依赖关系。

### Update scope and State Management


Software Package processed by UCM can contain Adaptive Applications, updates to AUTOSAR Adaptive Platform itself or to the underlying OS. Update type depends on the content of the Software Package.

> 软件包经UCM处理可以包含自适应应用程序、更新AUTOSAR自适应平台本身或底层操作系统。更新类型取决于软件包的内容。


**[SWS_UCM_00099] Update of Adaptive Application** [UCM shall be able to update Adaptive Applications*♩(RS_UCM_00001)*

> [SWS_UCM_00099] 更新自适应应用程序[UCM应能够更新自适应应用程序*♩(RS_UCM_00001)*


**[SWS_UCM_00100]**{DRAFT} **Update of Functional Clusters** [UCM shall be able to update all Functional Clusters, including UCM itself.*♩(RS_UCM_00028)*

> **[SWS_UCM_00100]**{草稿} **功能集群的更新** [UCM应该能够更新所有的功能集群，包括UCM本身。*♩(RS_UCM_00028)*


**[SWS_UCM_00101]**{DRAFT} **Update of Host** [UCM shall be able to update the underlying OS hosting the AUTOSAR Adaptive Platform.*♩(RS_UCM_00029)*

> **[SWS_UCM_00101]**{草案} **更新主机** [UCM应能够更新承载AUTOSAR Adaptive Platform的基础操作系统。*♩（RS_UCM_00029）*


Definition of an updatable state with respect to the system setup is the OEM responsibility. Based on the system setup and the application, the system might need to be

> 系统设置方面的可更新状态的定义是OEM的责任。根据系统设置和应用程序，可能需要对系统进行更新。


switched into a predefined state, to free resource to speed up the update, to block normal usage of software which might cause interruptions to update process and to block using functionality which might be interrupted by the update sequence.

> 切换到预定义状态，释放资源以加快更新，阻止可能会影响更新过程的软件的正常使用，并阻止使用可能会被更新序列打断的功能。


**[SWS_UCM_00257] Update session** [To confirm the system is in an updatable state, UCM shall start an update session by calling State Management UpdateRequest Service Interface RequestUpdateSession method after its dependency check triggered by Activate method call successfully completes.*♩(RS_UCM_00026, RS\_UCM_00003)*

> **[SWS_UCM_00257] 更新会话** [为了确认系统处于可更新状态，UCM在其被Activate方法调用成功触发的依赖性检查完成后，应通过调用State Management UpdateRequest Service Interface RequestUpdateSession方法来启动一个更新会话。*♩(RS_UCM_00026, RS\_UCM_00003)*


**[SWS_UCM_00258] Update session rejected** [If State Management UpdateRequest Service Interface RequestUpdateSession method call raises error kRejected, UCM shall transition from kActivating to kReady states and Activate method call shall return ApplicationError UpdateSessionRejected.*♩ (RS_UCM_00026, RS_UCM_00024)*

> **[SWS_UCM_00258] 更新会话被拒绝** [如果状态管理 UpdateRequest 服务接口 RequestUpdateSession 方法调用引发错误 kRejected，UCM 将从 kActivating 状态转换为 kReady 状态，并且 Activate 方法调用将返回 ApplicationError UpdateSessionRejected。（RS_UCM_00026，RS_UCM_00024）**


If update session could be recurrently rejected, it is up to implementer to cache the dependency check result in order to avoid unnecessary computation and compute it only once.

> 如果更新会话反复被拒绝，那么实现者需要缓存依赖性检查结果以避免不必要的计算，并且只计算一次。


During the update session, the minimum applications required for the Update process should be executed. This way system is more robust, more resources are free and user is blocked from using applications, of which failure could cause safety risk to the user.

> 在更新会话期间，应该执行更新过程所需的最低应用程序。这样，系统更加健壮，资源更加充足，用户被阻止使用可能会给用户带来安全风险的应用程序。


Update of some components require a Machine reset to be performed. These components should be configured to be part of Function Group MachineFG, as the update sequence of Function Group MachineFG includes a Machine reset. Execution Management, State Management, Communication Management and UCM itself are good examples which probably require a Machine reset to activate the update. Other such components could be applications involved in the update sequence or applications involved in safety monitoring. Further details on Function Group MachineFG can be found in State Management.

> 更新某些组件需要执行机器重置。这些组件应配置为机器FG功能组的一部分，因为机器FG功能组的更新序列包括机器重置。执行管理、状态管理、通信管理和UCM本身是很好的例子，可能需要机器重置来激活更新。其他此类组件可能是参与更新序列的应用程序或参与安全监控的应用程序。有关机器FG功能组的更多详细信息可在状态管理中找到。

### Transferring Software Packages


To speed up the overall data transmission time, the package transfer is decoupled from the processing and activation process. This section describes requirements for initiation of a data transfer, the data transmission and ending of the data transmission.

> 为了加快整体数据传输时间，数据传输与处理和激活过程被解耦。本节描述了数据传输的启动要求、数据传输和结束数据传输的要求。


Each Software Package gets its own state as soon as it is being transferred to UCM. The state machines in Fig. [7.4](#_bookmark41) specify the lifecycle of a Software Package that is transferred to and processed by UCM. During this lifecycle, a Software Package is uniquely identified with an id that UCM provides to the client.

> 每个软件包在被传输到UCM时就会获得自己的状态。图7.4中的状态机指定了被传输到UCM并被处理的软件包的生命周期。在这个生命周期中，软件包由UCM提供的唯一标识符进行唯一标识。


The UCM has the possibility to keep the Software Package in kTransferred states in case it failed and retry later: transferring Software Package can be costly, if

> UCM有可能将软件包保持在kTransferred状态，以防失败并稍后重试：传输软件包可能成本高昂，如果


it is authenticated, there could be no reason to delete it if the update has not been successfully finished.

> 它已经被认证，如果更新没有成功完成，就没有理由删除它。

![](./media/image10.png)Initi al
**Figure 7.4:** State Machine representing Software Packages lifecycle**


**[SWS_UCM_00007] Data transfer at any time** [UCM shall provide support to transfer Software Packages at any time when UCM is running. Transferring is decoupled from the UCM Package Management states.*♩(RS_UCM_00013, RS_UCM_00019, RS_UCM_00025)*

> UCM需要提供支持，在UCM运行时随时传输软件包。传输与UCM包管理状态解耦。♩（RS_UCM_00013，RS_UCM_00019，RS_UCM_00025）


**[SWS_UCM_00272]**{DRAFT} **Transfer block size** [TransferStart shall return BlockSize parameter to indicate the maximum block size (unit: bytes, as defined by maxBlockSize) to be allowed to transfer in one TransferData method call.*♩ (RS_UCM_00025)*

> **[SWS_UCM_00272]**{草稿} **传输块大小** [TransferStart 应返回 BlockSize 参数，以指示允许在一个 TransferData 方法调用中传输的最大块大小（单位：字节，由 maxBlockSize 定义）。*♩（RS_UCM_00025）*


The block size should be aligned to flashing capability in case of Classic Platform capability for instance.

> 块大小应该与经典平台能力的闪存能力对齐，例如。


**[SWS_UCM_00088] Preparation of data transfer** [Data transfer shall be prepared with the method TransferStart. In the preparation step the number of bytes to be transferred is provided by the client and UCM assigns an id for the Software Package to be transferred.*♩(RS_UCM_00013, RS_UCM_00019, RS_UCM_00025)*

> **[SWS_UCM_00088] 数据传输准备** [数据传输应使用TransferStart方法准备。 在准备步骤中，客户端提供要传输的字节数，UCM为要传输的软件包分配一个ID。 *♩(RS_UCM_00013，RS_UCM_00019，RS_UCM_00025)*


While a Software Package is being transferred, if UCM receives a subsequent TransferStart call targeting another Software Package, UCM should make sure that the sum of the size of both Software Packages (the one being transferred and the one requested to be transferred) does not exceed the size of the UCM buffer. Otherwise, the TransferStart should raise the ApplicationError InsufficientMemory and the newly requested transmission should be rejected as described above.

> 当正在传输一个软件包时，如果UCM收到针对另一个软件包的后续TransferStart调用，UCM应确保两个软件包（正在传输的和要求传输的）的大小总和不超过UCM缓冲区的大小。否则，TransferStart应引发ApplicationError InsufficientMemory，新请求的传输应按上述方式被拒绝。


**[SWS_UCM_00008] Executing the data transfer** [After successful call of TransferStart method, the transmission of the Software Package block-wise shall be supported by the method TransferData.*♩(RS_UCM_00013, RS_UCM_00019, RS\_UCM_00025)*

> **[SWS_UCM_00008] 执行数据传输** [在成功调用TransferStart方法之后，软件包的块传输将由TransferData方法支持。*♩(RS_UCM_00013, RS_UCM_00019, RS\_UCM_00025)*


**[SWS_UCM_00145] Sequential order of data transfer** [The method TransferData shall support the parameter blockCounter that shall start with 0x01 and be incremented by one for each subsequent block.*♩(RS_UCM_00013, RS_UCM_00019, RS_UCM_00025)*

> **[SWS_UCM_00145] 数据传输的顺序** [TransferData 方法应支持参数 blockCounter，它应从 0x01 开始，并且每传输一个块就增加 1。*♩(RS_UCM_00013，RS_UCM_00019，RS_UCM_00025)*


**[SWS_UCM_00010] End of data transfer** [After transmission of a Software Package is completed, the transmission can be finished with method TransferExit.*♩ (RS_UCM_00013, RS_UCM_00019, RS_UCM_00025)*

> **[SWS_UCM_00010] 数据传输结束** [软件包传输完成后，可以使用TransferExit方法结束传输。*♩ (RS_UCM_00013, RS_UCM_00019, RS_UCM_00025)*


Software Package contains authentication and integrity tags, which are used during the transfer sequence to authenticate the content of the Software Package.

> 软件包包含身份验证和完整性标签，在传输序列期间用于验证软件包内容。


[SWS_UCM_00075] Multiple data transfers in parallel** [Handling of multiple data transfers in parallel shall be supported by UCM.*♩(RS_UCM_00019)*

> [SWS_UCM_00075] 并行多数据传输** UCM应支持并行多数据传输的处理。*♩(RS_UCM_00019)*


If UCM provide enough buffering resources for Software Packages, several packages could be transferred (in parallel) before they are processed one after the other. The processing (i.e. unpacking and actually applying changes to the AUTOSAR Adaptive Platform) of Software Packages described by the state kProcessing is further detailed in Sect. [7.1.5](#processing-software-packages).

> 如果UCM提供足够的缓冲资源用于软件包，则可以在将它们依次处理之前，并行传输多个软件包。状态kProcessing描述的软件包的处理（即解包和实际应用更改到AUTOSAR自适应平台）在[7.1.5]（＃处理软件包）节中有进一步的详细说明。


**[SWS_UCM_00021] Deleting transferred Software Packages** [UCM shall provide a method DeleteTransfer that shall delete the targeted Software Package and free the resources reserved to store that Software Package.*♩(RS_UCM_00018)*

> **[SWS_UCM_00021] 删除传输的软件包** [UCM应提供一种DeleteTransfer方法，用于删除目标软件包并释放用于存储该软件包的资源。*♩（RS_UCM_00018）*


**[SWS_UCM_00069]**{OBSOLETE} **Report information on Software Packages** [ UCM shall provide a method GetSwPackages of the interface service PackageManagement to provide the Software Packages' identifiers, names, versions, states, consecutive bytes received and consecutive blocks received.*♩(RS_UCM_00010, RS\_UCM_00002)*

> **[SWS_UCM_00069]**{过时的} **报告软件包信息** [UCM应提供PackageManagement接口服务的GetSwPackages方法，以提供软件包的标识符、名称、版本、状态、接收的连续字节和接收的连续块。 *♩（RS_UCM_00010，RS\_UCM_00002）*


At the invocation of method GetSwPackages of the service interface PackageManagement, UCM returns the Software Packages' identifiers, names, versions, states, consecutive bytes received and consecutive blocks received.

> 在PackageManagement服务接口的GetSwPackages方法调用时，UCM返回软件包的标识符、名称、版本、状态、已接收字节数和已接收块数。


If Software Package is in kTransferring state, it is not possible to get versions or names as manifest could not be complete or accessible, therefore method GetSwPackages should return empty values except for TransferID, ConsecutiveBytesReceived and ConsecutiveBlocksReceived at this particular state.

> 如果软件包处于kTransferring状态，无法获取版本或名称，因为清单无法完整或可访问，因此在此状态下，GetSwPackages方法应该返回空值，除了TransferID，ConsecutiveBytesReceived和ConsecutiveBlocksReceived。


**[SWS_UCM_00216] Validity of TransferId** [The TransferId of a Software Package shall be invalidated for further use when it reaches final lifecycle state.*♩(RS_UCM\_00019)*

> **[SWS_UCM_00216] 转移ID的有效性** [当软件包达到最终生命周期状态时，其转移ID将被作废，不能再用于进一步使用。*♩(RS_UCM\_00019)*

### Error handling in TransferStart


TransferStart allocates resources for the client transfer.

> 转移开始为客户转移分配资源。


**[SWS_UCM_00140] UCM insufficient memory** [TransferStart method shall raise the ApplicationError InsufficientMemory if the UCM buffer has not enough resources to store the corresponding Software Package.*♩(RS_UCM_00013, RS\_UCM_00019, RS_UCM_00025)*

> **[SWS_UCM_00140] UCM内存不足**[TransferStart方法如果UCM缓冲区没有足够的资源来存储相应的软件包，则应引发ApplicationError InsufficientMemory。*♩（RS_UCM_00013，RS\_UCM_00019，RS_UCM_00025）*

### Error handling in TransferData


TransferData executes the following checks. It is recommended to follow the specified order.

> TransferData执行以下检查。建议按照指定顺序执行。


**[SWS_UCM_00275]**{DRAFT} **TransferData error handling order** [TransferData method shall check the following error conditions and return the respective error code.

> **[SWS_UCM_00275]**{草稿} **TransferData 错误处理顺序** [TransferData 方法应检查以下错误条件并返回相应的错误代码。

```
1. [[SWS_UCM_00208](#_bookmark45)]
2. [[SWS_UCM_00203](#_bookmark46)]
3. [[SWS_UCM_00204](#_bookmark47)]
4. [[SWS_UCM_00243](#_bookmark48)]
5. [[SWS_UCM_00205](#_bookmark49)]
6. [[SWS_UCM_00206](#_bookmark50)]
7. [[SWS_UCM_00289](#_bookmark51)]
8. [[SWS_UCM_00207](#_bookmark52)]
9. [[SWS_UCM_00294](#_bookmark53)]
10. [[SWS_UCM_00098](#_bookmark54)]
11. [[SWS_UCM_00092](#_bookmark59)]
12. [[SWS_UCM_00245](#_bookmark33)]
13. [[SWS_UCM_00103](#_bookmark102)]
```


*♩(RS_UCM_00013, RS_UCM_00019, RS_UCM_00025)*

> *♩(RS_UCM_00013，RS_UCM_00019，RS_UCM_00025)*


[SWS_UCM_00208] TransferData OperationNotPermitted** [Calling TransferData after calling TransferExit for a specific TransferId shall raise the error ApplicationError OperationNotPermitted*♩(RS_UCM_00019)*

> [SWS_UCM_00208] 在为特定的TransferId调用TransferExit之后调用TransferData将引发ApplicationError OperationNotPermitted*♩(RS_UCM_00019)*错误


[SWS_UCM_00203] TransferData InvalidTransferId** [TransferData shall raise the error ApplicationError InvalidTransferId in case an invalid TransferId (An ID that was not initiated by TransferStart or marked invalid by DeleteTransfer or RevertProcessedSwPackages) is sent by the client.*♩(RS_UCM_00019)*

> [SWS_UCM_00203] 传输数据无效的TransferId** [如果客户端发送无效的TransferId（未由TransferStart发起的ID或由DeleteTransfer或RevertProcessedSwPackages标记为无效的ID），TransferData将引发错误ApplicationError InvalidTransferId。*♩(RS_UCM_00019)*


[SWS_UCM_00204] TransferData IncorrectBlock** [TransferData shall raise ApplicationError IncorrectBlock upon receipt of a block counter value that is successfully transmitted to UCM before or upon receipt of an unexpected block counter value.*♩(RS_UCM_00014, RS_UCM_00019)*

> [SWS_UCM_00204] TransferData 不正确的块**[TransferData 在收到一个成功传输到UCM之前或者收到一个意外的块计数值时，应该引发ApplicationError 不正确的块。*♩(RS_UCM_00014, RS_UCM_00019)*


[SWS_UCM_00243] Too big block size received by UCM** [In the case the received block size with TransferData exceeds the block size returned by TransferStart for the same TransferId, UCM shall raise the ApplicationError IncorrectBlockSize.*♩(RS_UCM_00013, RS_UCM_00014, RS_UCM_00025)*

> [SWS_UCM_00243] UCM收到的块大小过大**如果TransferData收到的块大小超过TransferStart为同一TransferId返回的块大小，UCM应引发ApplicationError IncorrectBlockSize。♩（RS_UCM_00013，RS_UCM_00014，RS_UCM_00025）


[SWS_UCM_00205] TransferData IncorrectSize** [In case the transferred Software package size exceeds the provided size in TransferStart, TransferData shall raise ApplicationError IncorrectSize*♩(RS_UCM_00014, RS_UCM_00019)*

> [SWS_UCM_00205] 如果传输的软件包大小超过TransferStart中提供的大小，TransferData应引发ApplicationError IncorrectSize*♩(RS_UCM_00014，RS_UCM_00019)*


**[SWS_UCM_00206] TransferData InsufficientMemory** [TransferData shall raise the error ApplicationError InsufficientMemory if resources to store the Software Package ceased to exist during the transfer operation.*♩(RS_UCM_00013, RS_UCM_00019, RS_UCM_00025)*

> **[SWS_UCM_00206] TransferData  内存不足** [TransferData 在传输操作期间，如果用于存储软件包的资源不再存在，则应引发错误ApplicationError InsufficientMemory。*♩(RS_UCM_00013, RS_UCM_00019, RS_UCM_00025)*


**[SWS_UCM_00289]**{DRAFT} **TransferData TransferFailed** [TransferData shall raise the error ApplicationError TransferFailed if UCM cannot persist transferred block.*♩(RS_UCM_00013)*

> **[SWS_UCM_00289]**{草稿} **传输数据传输失败** [如果UCM无法持久传输块，传输数据应引发错误ApplicationError TransferFailed。*♩(RS_UCM_00013)*


**[SWS_UCM_00207]**{DRAFT} **TransferData BlockInconsistent** [If UCM checks consistency of Block for each TransferData, UCM shall raise the error ApplicationError BlockInconsistent in case Consistency check for transferred block fails.*♩ (RS_UCM_00012)*

> **[SWS_UCM_00207]**（草稿）**TransferData块不一致**[如果UCM检查每个TransferData块的一致性，当一致性检查失败时，UCM应引发ApplicationError BlockInconsistent错误。*♩ （RS_UCM_00012）*


The BlockInconsistent error is intended to be used by the Flashing Adapter. The Flashing Adapter can calculate additional consistency information for each block internally, e.g. a CRC32 checksum. It can then use UDS protocol to send block data and checksum to the target ECU. In case checksum verification fails, the Flashing Adapter can report the BlockInconsistent error to the UCM Master or diagnostic client application.

> 错误BlockInconsistent旨在由闪存适配器使用。闪存适配器可以为每个块内部计算额外的一致性信息，例如CRC32校验和。然后它可以使用UDS协议将块数据和校验和发送到目标ECU。如果校验和验证失败，闪存适配器可以向UCM主机或诊断客户端应用程序报告BlockInconsistent错误。


As described in section [7.1.2.1.2](#content-of-a-software-package) and [[10](#_bookmark10)], each Software Package has an authentication tag CryptoServiceCertificate which protects integrity and authenticity.

> 根据[7.1.2.1.2](#content-of-a-software-package)和[[10](#_bookmark10)]中所述，每个软件包都有一个身份验证标签CryptoServiceCertificate，以保护完整性和真实性。


Therefore additional consistency check information is not needed. If authentication check fails, AuthenticationFailed error is intended to be used instead.

> 因此不需要额外的一致性检查信息。如果认证检查失败，则应使用AuthenticationFailed错误。


**[SWS_UCM_00294]**{DRAFT} **Unsupported package format for UCM** [In the case the Software Package archiving format is not supported, UCM TransferData method shall return ApplicationError UnsupportedPackageFormat.*♩(RS\_UCM_00025)*

> **[SWS_UCM_00294]**{草案} **UCM 不支持的软件包格式** [如果软件包存档格式不受支持，UCM TransferData 方法应返回 ApplicationError UnsupportedPackageFormat。*♩(RS\_UCM_00025)*


**[SWS_UCM_00098]**{DRAFT} **Software Package Authentication failure** [UCM shall raise the ApplicationError AuthenticationFailed, if the Software Package authentication check fails.*♩(RS_UCM_00006, RS_UCM_00019, RS_UCM\_00025)*

> **[SWS_UCM_00098]**{草稿} **软件包认证失败** [如果软件包认证检查失败，UCM将引发ApplicationError AuthenticationFailed。*♩（RS_UCM_00006，RS_UCM_00019，RS_UCM\_00025）*


This error can happen when TransferData, TransferExit and ProcessSwPackage methods are called. When AuthenticationFailed error is raised, it is up to client to decide if a DeleteTransfer will be called or not. The behaviour may vary depending on the life cycle, meaning R&D phase or on the field phase.

> 此错误可能会在调用TransferData、TransferExit和ProcessSwPackage方法时发生。当抛出AuthenticationFailed错误时，由客户端决定是否要调用DeleteTransfer。其行为可能会根据生命周期（即研发阶段或现场阶段）而有所不同。


TransferData checks the package version format in accordance to [[SWS_UCM_00161](#_bookmark70)] (IncompatiblePackageVersion).

> TransferData检查根据[[SWS_UCM_00161](#_bookmark70)]（IncompatiblePackageVersion）的包版本格式。


TransferData checks if the Software Cluster to be removed has attribute installationBehavior set to cannotBeRemoved. If this is the case, UCM shall not remove it in accordance to [[SWS_UCM_00245](#_bookmark33)].

> TransferData 检查要被移除的软件集群是否将安装行为设置为不能被移除。如果是这种情况，根据[[SWS_UCM_00245]]，UCM 不应移除它。


TransferData checks if the Software Cluster version being updated is older than currently present in Machine in accordance to [[SWS_UCM_00103](#_bookmark102)] (OldVersion).

> TransferData检查正在更新的软件集群版本是否比机器中当前存在的版本更旧，根据[[SWS_UCM_00103](#_bookmark102)]（OldVersion）。

### Error handling in TransferExit


**[SWS_UCM_00276]**{DRAFT} **TransferExit error handling order** [TransferExit method shall check the following error conditions and return the respective error code.

> **[SWS_UCM_00276]**{草案} **传输退出错误处理顺序** [传输退出方法应检查以下错误条件并返回相应的错误代码。

```
1. [[SWS_UCM_00148](#_bookmark56)]
2. [[SWS_UCM_00212](#_bookmark57)]
3. [[SWS_UCM_00087](#_bookmark58)]
4. [[SWS_UCM_00294](#_bookmark53)]
5. [[SWS_UCM_00098](#_bookmark54)]
6. [[SWS_UCM_00092](#_bookmark59)]
7. [[SWS_UCM_00161](#_bookmark70)]
8. [[SWS_UCM_00213](#_bookmark60)]
9. [[SWS_UCM_00245](#_bookmark33)]
10. [[SWS_UCM_00103](#_bookmark102)]

```


*♩(RS_UCM_00013, RS_UCM_00019, RS_UCM_00025)*

> *♩(RS_UCM_00013，RS_UCM_00019，RS_UCM_00025)*


**[SWS_UCM_00148] Transfer sequence order** [Calling TransferExit without calling TransferData at least once or after TransferExit is called for a specific TransferID, shall raise the ApplicationError OperationNotPermitted.*♩(RS_UCM\_00019)*

> **[SWS_UCM_00148] 转移序列顺序** [在特定的TransferID上，如果没有调用TransferData至少一次或者在调用TransferExit后，调用TransferExit将引发ApplicationError OperationNotPermitted。*♩(RS_UCM\_00019)*


**[SWS_UCM_00212] TransferExit InvalidTransferId** [TransferExit shall raise the error ApplicationError InvalidTransferId in case an invalid TransferId is sent by the client.*♩(RS_UCM_00019)*

> **[SWS_UCM_00212] TransferExit 无效TransferId** [TransferExit 应当在客户端发送无效TransferId时引发ApplicationError InvalidTransferId错误。*♩(RS_UCM_00019)*


**[SWS_UCM_00087] Insufficient amount of data transferred** [When TransferExit method is called, UCM shall check if all blocks of the Software Package have been transferred according to the size parameter of TransferStart. If not UCM shall return ApplicationError InsufficientData.*♩(RS_UCM_00013, RS\_UCM_00019, RS_UCM_00025)*

> **[SWS_UCM_00087] 传输的数据量不足** [当调用TransferExit方法时，UCM应检查根据TransferStart的大小参数是否已经传输了所有软件包块。如果没有，UCM应返回ApplicationError InsufficientData。*♩（RS_UCM_00013，RS_UCM_00019，RS_UCM_00025）*


TransferExit checks if the Software Package archiving format is supported in accordance to [[SWS_UCM_00294](#_bookmark53)] (UnsupportedPackageFormat).

> TransferExit检查软件包存档格式是否符合[[SWS_UCM_00294](#_bookmark53)]（不受支持的包格式）的要求。


TransferExit checks authentication in accordance to [[SWS_UCM_00098](#_bookmark54)] (AuthenticationFailed).

> 转账退出根据[[SWS_UCM_00098](#_bookmark54)]（认证失败）检查认证。


**[SWS_UCM_00092] Software Package integrity** [When TransferData or TransferExit method is called, UCM shall raise the ApplicationError PackageInconsistent if the Software Package integrity check fails. This Software Package integrity check may be realized by the UCM via a Software Package Checksum check or via other mechanisms.*♩(RS_UCM_00012, RS_UCM_00006)*

> **[SWS_UCM_00092] 软件包完整性** 当调用TransferData或TransferExit方法时，UCM应该抛出ApplicationError PackageInconsistent，如果软件包完整性检查失败。这个软件包完整性检查可以通过UCM通过软件包校验和检查或其他机制来实现。*♩(RS_UCM_00012，RS_UCM_00006)*


TransferExit checks the package version format in accordance to [[SWS_UCM_00161](#_bookmark70)] (IncompatiblePackageVersion).

> TransferExit按照[[SWS_UCM_00161](#_bookmark70)]（IncompatiblePackageVersion）检查包版本格式。


**[SWS_UCM_00213] TransferExit InvalidPackageManifest** [TransferExit shall raise the error ApplicationError InvalidPackageManifest upon receival of an invalid manifest.*♩(RS_UCM_00012)*

> **[SWS_UCM_00213] TransferExit 无效的包裹清单无效** [TransferExit 在收到无效的清单时应引发 ApplicationError 无效的包裹清单错误。*♩(RS_UCM_00012)*


TransferExit checks if the Software Cluster to be removed is from category PLATFORM_CORE. If this is the case, UCM shall not remove it in accordance to [[SWS_UCM_00245](#_bookmark33)].

> TransferExit检查要删除的软件集群是否属于PLATFORM_CORE类别。 如果是这种情况，UCM根据 [[SWS_UCM_00245](#_bookmark33)] 不应删除它。


TransferExit checks if the Software Cluster version being updated is older than currently present in Machine in accordance to [[SWS_UCM_00103](#_bookmark102)] (OldVersion).

> TransferExit检查正在更新的软件集群版本是否比机器上当前存在的版本更旧，根据[[SWS_UCM_00103](#_bookmark102)]（OldVersion）。

### Error handling in DeleteTransfer


**[SWS_UCM_00283]**{DRAFT} **DeleteTransfer error handling order** [DeleteTransfer method shall check the following error conditions and return the respective error code.

> **[SWS_UCM_00283]**{草稿} **删除传输错误处理顺序** [DeleteTransfer 方法应检查以下错误条件并返回相应的错误代码。

```
1. [[SWS_UCM_00214](#_bookmark62)]
2. [[SWS_UCM_00215](#_bookmark63)]
```


*♩(RS_UCM_00013, RS_UCM_00019, RS_UCM_00025)*

> *♩（RS_UCM_00013，RS_UCM_00019，RS_UCM_00025）*


DeleteTransfer checks if the supplied parameter TransferId is valid.

> 删除传输检查提供的参数TransferId是否有效。


**[SWS_UCM_00214] DeleteTransfer InvalidTransferId** [DeleteTransfer shall raise the error ApplicationError InvalidTransferId in case an invalid TransferId is sent by the client.*♩(RS_UCM_00019)*

> **[SWS_UCM_00214] 删除传输无效的TransferId** [如果客户端发送了无效的TransferId，删除传输应该引发ApplicationError无效的TransferId错误。(RS_UCM_00019)**


**[SWS_UCM_00215] DeleteTransfer OperationNotPermitted** [Calling DeleteTransfer during processing or during the processing stream shall raise the error ApplicationError OperationNotPermitted.*♩(RS_UCM_00019)*

> **[SWS_UCM_00215] 删除传输操作不允许** [在处理期间或在处理流程期间调用DeleteTransfer时将引发ApplicationError OperationNotPermitted错误。*♩(RS_UCM_00019)*

### Processing of Software Packages from a stream


It is also possible to process a Software Package while the transfer is still ongoing. The following requirements apply for this use case.

> 也可以在转移过程中处理软件包。 下面的要求适用于此用例。


**[SWS_UCM_00165] Processing from stream** [The UCM may support calling ProcessSwPackage directly from stream without waiting to receive the Software Package completely.*♩(RS_UCM_00001, RS_UCM_00003, RS_UCM_00004, RS\_UCM_00025)*

> **[SWS_UCM_00165] 从流中处理** [UCM可能支持直接从流中调用ProcessSwPackage而无需等待完全接收软件包。*♩(RS_UCM_00001，RS_UCM_00003，RS_UCM_00004，RS\_UCM_00025)*


**[SWS_UCM_00166] Processing from stream state** [If UCM supports processing from stream and is in state kIdle or kReady, the method ProcessSwPackage for a Software Package in state kTransferring shall set this Software Package to state kProcessingStream.*♩(RS_UCM_00024, RS_UCM_00025)*

> **[SWS_UCM_00166]处理流状态**[如果UCM支持从流中处理，并且处于kIdle或kReady状态，则对于处于kTransferring状态的软件包，ProcessSwPackage方法应将该软件包设置为kProcessingStream状态。*♩(RS_UCM_00024，RS_UCM_00025)*


**[SWS_UCM_00167]**{DRAFT} **Cancelling streamed packages** [When Cancel is called, UCM shall remove all temporary and processed data of a Software Package in state kProcessingStream.*♩(RS_UCM_00020, RS_UCM_00025)*

> 当取消被调用时，UCM应删除处于kProcessingStream状态的软件包的所有临时和处理数据。♩（RS_UCM_00020，RS_UCM_00025）


**[SWS_UCM_00168] Transferring while processing from stream** [Software Package state shall remain in kProcessingStream when TransferData is called.*♩(RS_UCM_00024, RS_UCM_00025)*

> **[SWS_UCM_00168] 在处理流程中转移时**[软件包状态在调用TransferData时应保持在kProcessingStream状态。*♩(RS_UCM_00024, RS_UCM_00025)*


**[SWS_UCM_00169] Finishing transfer while processing from stream** [Software Package state shall be set to kProcessed when TransferExit is called and the Software Package is completely processed.*♩(RS_UCM_00024, RS_UCM_00025)*

> **[SWS_UCM_00169] 在处理流程中完成传输** [当调用TransferExit且软件包完全处理完毕时，软件包状态应设置为kProcessed。*♩(RS_UCM_00024, RS_UCM_00025)*


**[SWS_UCM_00200] Failing authentication** [UCM shall delete the Software Package and its related data processed by ProcessSwPackage call if authentication is failing at TransferExit or ProcessSwPackage call.*♩(RS_UCM_00039, RS_UCM\_00006)*

> **[SWS_UCM_00200] 认证失败** [如果TransferExit或ProcessSwPackage调用时认证失败，UCM将删除由ProcessSwPackage调用处理的软件包及其相关数据。*♩（RS_UCM_00039，RS_UCM_00006）*

### Processing Software Packages


In contrast to package transmission, only one Software Package can be processed at the same time to ensure consistency of the system. In the following, a software or package processing can involve any combination of an installation, update or removal of applications, configuration data, calibration data or manifests. It is up to the vendor-specific metadata inside a Software Package to describe the tasks UCM has to perform for its processing. For a removal, this might involve metadata describing which data needs to be deleted. Nevertheless, the communication sequence between the triggering application of the software modification and UCM is the same in any case. For an update of an existing application, the Software Package can contain only partial data, e.g. just an updated version of the execution manifest. Any UCM Client need to confirm that UCM is in kIdle CurrentStatus state before starting any update (process/activate).

> 相比于传输包，为了确保系统的一致性，只能同时处理一个软件包。接下来，软件或包处理可以涉及安装、更新或删除应用程序、配置数据、校准数据或清单的任何组合。由软件包内的供应商特定元数据来描述UCM需要执行的处理任务。对于删除，可能涉及描述需要删除哪些数据的元数据。但是，触发软件修改的应用程序和UCM之间的通信序列在任何情况下都是相同的。对于现有应用程序的更新，软件包可以只包含部分数据，例如只有更新的执行清单。任何UCM客户端在开始任何更新（处理/激活）之前，都需要确认UCM处于kIdle当前状态。


**[SWS_UCM_00001]**{OBSOLETE} **Starting the package processing** [UCM shall provide a method ProcessSwPackage to process transferred Software Package. id corresponding to Software Package shall be provided for this method.*♩(RS_UCM\_00001, RS_UCM_00004)*

> **[SWS_UCM_00001]**{已废弃} **开始处理软件包** [UCM应提供一种ProcessSwPackage方法来处理传输的软件包。与软件包对应的ID应该为此方法提供。*♩(RS_UCM\_00001，RS_UCM_00004)*


At the invocation of method ProcessSwPackage, UCM processes transferred Software Package with id argument corresponding to this Software Package.

> 当调用ProcessSwPackage方法时，UCM会使用与该软件包对应的id参数处理传输的软件包。


**[SWS_UCM_00137] Processing several update Software Packages** [UCM shall support processing of several Software Packages, not in parallel, by calling method ProcessSwPackage several times in sequence.*♩(RS_UCM_00001, RS\_UCM_00004)*

> [SWS_UCM_00137]处理多个更新软件包[UCM应通过按顺序多次调用ProcessSwPackage方法来支持处理多个软件包，而不是并行处理。*♩（RS_UCM_00001，RS\_UCM_00004）*


During package processing, the progress is provided.

> 在包裹处理期间，会提供处理进度。


**[SWS_UCM_00018]**{OBSOLETE} **Providing Progress Information** [UCM shall provide a method GetSwProcessProgress to query the progress of executing the ProcessSwPackage method call for provided TransferId. Parameter progress shall be set to a value representing the progress between 0% and 100% (0x00 \... 0x64).*♩(RS\_UCM_00023)*

> **[SWS_UCM_00018]**{已过时} **提供进度信息** [UCM应提供一种GetSwProcessProgress方法来查询为提供的TransferId执行ProcessSwPackage方法调用的进度。参数progress应设置为表示从0％到100％（0x00 \... 0x64）之间的值。*♩（RS \_UCM_00023）*


At the invocation of method GetSwProcessProgress, UCM returns the progress of executing the ProcessSwPackage method call for provided TransferId. Parameter progress will be set to a value representing the progress between 0% and 100% (0x00 \... 0x64).

> 当调用GetSwProcessProgress方法时，UCM会返回提供的TransferId执行ProcessSwPackage方法调用的进度。参数progress将被设置为一个介于0％到100％（0x00 ... 0x64）之间的值。


**[SWS_UCM_00003] Cancelling the package processing** [On call of Cancel

> **[SWS_UCM_00003] 取消包裹处理** [在取消电话的时候


method, UCM shall abort the running package processing task, undo the changes to

> 方法，UCM 将中止正在运行的包处理任务，撤消所做的更改。


the Software Cluster for which processing started and free the reserved resources used for it.*♩(RS_UCM_00020)*

> 软件集群开始处理，释放为其保留的资源，标记为：RS_UCM_00020。


**[SWS_UCM_00024] Revert all processed Software Packages** [UCM shall provide a method RevertProcessedSwPackages to revert all changes done with ProcessSwPackage.*♩(RS_UCM_00008)*

> [SWS_UCM_00024] 恢复所有已处理的软件包 [UCM 应提供一种方法 RevertProcessedSwPackages 来恢复使用 ProcessSwPackage 所做的所有更改。*♩(RS_UCM_00008)*


The main difference between a RevertProcessedSwPackages and a Rollback is that the former can only be performed before the successful activation of the targeted Software Package(s) while the latter can only be performed after such activation.

> 主要区别在于RevertProcessedSwPackages只能在成功激活目标软件包之前执行，而Rollback只能在激活后执行。


Depending on the capabilities of UCM and of the updated target, RevertProcessedSwPackages is used to revert all the changes that have been applied by ProcessSwPackage. Cancel is also used to revert the changes of the Software Package for which processing started by ProcessSwPackage method call and identified by TransferId. For example, if an application with large resource files is updated "in place" (i.e. in the same partition) then it might not be feasible to revert the update. In this case, to perform a rollback the triggering application could download a Software Package to restore a stable version of the application.

> 根据UCM的能力和更新后的目标，RevertProcessedSwPackages用于撤消ProcessSwPackage应用的所有更改。取消也可用于撤消由ProcessSwPackage方法调用并由TransferId标识的软件包的更改。例如，如果一个带有大型资源文件的应用程序以“原地”（即在同一分区）进行更新，则可能无法撤消该更新。在这种情况下，要执行回滚，触发应用程序可以下载软件包以恢复应用程序的稳定版本。

### Error handling during Processing Software Packages


**[SWS_UCM_00277]**{DRAFT} **ProcessSwPackage error handling order** [ProcessSwPackage method shall check the following error conditions and return the respective error code.

> **[SWS_UCM_00277]**{草案} **处理软件包错误处理顺序** [ProcessSwPackage 方法应检查以下错误条件并返回相应的错误代码。

```
1. [[SWS_UCM_00219](#_bookmark67)]
2. [[SWS_UCM_00017](#_bookmark68)]
3. [[SWS_UCM_00218](#_bookmark69)]
4. [[SWS_UCM_00098](#_bookmark54)]
5. [[SWS_UCM_00161](#_bookmark70)]
6. [[SWS_UCM_00029](#_bookmark71)]
7. [[SWS_UCM_00285](#_bookmark72)]
8. [[SWS_UCM_00231](#_bookmark73)]
9. [[SWS_UCM_00217](#_bookmark74)]
10. [[SWS_UCM_00267](#_bookmark75)]
11. [[SWS_UCM_00104](#_bookmark76)]
12. [[SWS_UCM_00245](#_bookmark33)]
13. [[SWS_UCM_00103](#_bookmark102)]
14. [[SWS_UCM_00150](#_bookmark77)]
```

*♩(RS_UCM_00026)*


**[SWS_UCM_00219] ProcessSwPackage OperationNotPermitted** [ProcessSwPackage shall raise the error ApplicationError OperationNotPermitted in case the processing of the specified Software Package is already done.*♩(RS\_UCM_00025, RS_UCM_00026)*

> **[SWS_UCM_00219] ProcessSwPackage 操作不允许** [如果指定的软件包处理已经完成，ProcessSwPackage 将引发错误 ApplicationError OperationNotPermitted。*♩（RS_UCM_00025, RS_UCM_00026）*


**[SWS_UCM_00017] Sequential Software Package Processing** [Once method ProcessSwPackage has been called by a client, further calls to the same method shall be rejected with ApplicationError ServiceBusy as long as CurrentStatus is different than kProcessing.*♩(RS_UCM_00001, RS_UCM_00003, RS_UCM\_00026)*

> **[SWS_UCM_00017] 顺序软件包处理** [一旦客户端调用了ProcessSwPackage方法，只要CurrentStatus不等于kProcessing，那么进一步调用同一方法将被拒绝，并返回ApplicationError ServiceBusy。（RS_UCM_00001，RS_UCM_00003，RS_UCM_00026）


When UCM Master or OTA Client calls ProcessSwPackage method and it raises ApplicationError ServiceBusy, UCM Master can retry the ProcessSwPackage method again later for the same package. This behaviour is configured by UcmRetryStrategy.

> 当UCM主机或OTA客户端调用ProcessSwPackage方法并引发ApplicationError ServiceBusy时，UCM主机可以稍后再次尝试对同一个包的ProcessSwPackage方法。此行为由UcmRetryStrategy配置。


**[SWS_UCM_00297]**{DRAFT} **Retry Strategy for ServiceBusy** [When ProcessSwPackage returns ApplicationError ServiceBusy more than maximumNumberOfRetries within retryIntervalTime, then UCM Master shall cancel the active campaign by transitioning to kCancelling state and delete the failing package.*♩ (RS_UCM_00001, RS_UCM_00003, RS_UCM_00026)*

> **[SWS_UCM_00297]**{草稿} **服务繁忙的重试策略** [当ProcessSwPackage在retryIntervalTime内返回ApplicationError ServiceBusy超过maximumNumberOfRetries次时，UCM Master应将活动活动转换为kCancelling状态并删除失败的包。*♩(RS_UCM_00001，RS_UCM_00003，RS_UCM_00026)*


If no retry strategy is needed, the maximum number of attempts can be specified as 0 in UcmRetryStrategy.

> 如果不需要重试策略，可以在UcmRetryStrategy中指定最大尝试次数为0。


**[SWS_UCM_00218] ProcessSwPackage InvalidTransferId** [ProcessSwPackage shall raise the error ApplicationError InvalidTransferId in case an invalid TransferId is sent by the client.*♩(RS_UCM_00026)*

> **[SWS_UCM_00218] ProcessSwPackage 无效的TransferId** [ProcessSwPackage 在客户端发送无效的TransferId时应引发ApplicationError无效的TransferId错误。 *♩(RS_UCM_00026)*


ProcessSwPackage checks authentication in accordance to [[SWS_UCM_00098](#_bookmark54)] (

> ProcessSwPackage根据[[SWS_UCM_00098](#_bookmark54)]检查身份验证

AuthenticationFailed)


**[SWS_UCM_00161] Check Software Package version compatibility against UCM version** [At ProcessSwPackage, TransferData or TransferExit calls, UCM shall raise ApplicationError IncompatiblePackageVersion if the version for the Software Package expressed by minimumSupportedUcmVersion attribute is higher than the current version of UCM as available in version attribute.*♩(RS_UCM_00007)*

> [SWS_UCM_00161] 检查软件包版本与UCM版本的兼容性。在ProcessSwPackage、TransferData或TransferExit调用时，如果minimumSupportedUcmVersion属性表示的软件包版本高于version属性中可用的当前UCM版本，UCM将引发ApplicationError IncompatiblePackageVersion。♩(RS_UCM_00007)


The Software Package is generated by a tooling including a packager which version could not match with the UCM version, leading to manifest interpretation issues for instance.

> 软件包是由一个工具集生成的，其中的打包器的版本与UCM版本不匹配，导致例如清单解释问题。


**[SWS_UCM_00029] Consistency Check of Manifest** [UCM shall validate the content of the manifest against the schema defined for the meta-data(eg: for missing parameter or for value out of range of the parameter) and shall raise the ApplicationError InvalidPackageManifest if it finds discrepancies there.*♩(RS_UCM_00012)*

> **[SWS_UCM_00029] 清单的一致性检查 [UCM 应该根据为元数据定义的模式（例如：缺少参数或参数值超出范围）验证清单的内容，如果发现差异，则应抛出ApplicationError InvalidPackageManifest。*♩（RS_UCM_00012）*


**[SWS_UCM_00285]**{DRAFT} **Removing or updating a Software Cluster not existing in the Machine** [If a Software Package's action is to remove or update a

> **[SWS_UCM_00285]**{草案} **删除或更新机器中不存在的软件集群** [如果软件包的操作是删除或更新


Software Cluster that is not at one of the states kPresent, kRemoved, kUpdating and kAdded, UCM shall raise ApplicationError SoftwareClusterMissing when ProcessSwPackage is called.*♩(RS_UCM_00015)*

> 当ProcessSwPackage被调用时，如果软件集群不在kPresent、kRemoved、kUpdating和kAdded之一的状态，UCM将引发ApplicationError SoftwareClusterMissing（RS_UCM_00015）。


**[SWS_UCM_00231]**{DRAFT} **ProcessSwPackage IncompatibleDelta** [ProcessSwPackage shall raise the error ApplicationError IncompatibleDelta if deltaPackageApplicableVersion is different from the currently installed version of the referenced SoftwareCluster.*♩(RS_UCM_00007)*

> **[SWS_UCM_00231]**{草案} **ProcessSwPackage IncompatibleDelta** [如果deltaPackageApplicableVersion与引用的SoftwareCluster的当前安装版本不同，则ProcessSwPackage应引发错误ApplicationError IncompatibleDelta。*♩(RS_UCM_00007)*


**[SWS_UCM_00217]**{DRAFT} **ProcessSwPackage InsufficientMemory** [ProcessSwPackage method shall raise the ApplicationError InsufficientMemory if the UCM buffer has not enough resources to process the corresponding Software Package.*♩(RS_UCM_00013, RS_UCM_00025)*

> **[SWS_UCM_00217]**{草案} **ProcessSwPackage 缺乏内存** [如果UCM缓冲区没有足够的资源来处理相应的软件包，则ProcessSwPackage方法应引发ApplicationError缺乏内存。*♩（RS_UCM_00013，RS_UCM_00025）*


**[SWS_UCM_00267]**{DRAFT} **Error when checksum is not recognised at processing time** [If checksum attribute of ArtifactChecksum or CryptoProvider are not recognised, UCM shall raise the ApplicationError InvalidChecksumDescription.*♩(RS_UCM_00012)*

> **[SWS_UCM_00267]**{草案} **处理时如果校验和不被识别，则会出现错误** [如果ArtifactChecksum或CryptoProvider的校验和属性不被识别，UCM应引发ApplicationError InvalidChecksumDescription。*♩(RS_UCM_00012)*


**[SWS_UCM_00104] Integrity Check of processed Package** [UCM shall raise the ApplicationError ProcessedSoftwarePackageInconsistent if integrity check of the processed Software Packages fails.*♩(RS_UCM_00012)*

> **[SWS_UCM_00104]处理软件包完整性检查** [如果处理的软件包的完整性检查失败，UCM将抛出ApplicationError ProcessedSoftwarePackageInconsistent。*♩(RS_UCM_00012)*


This operation is realized by the UCM to verify that it did not corrupt any files during the processing. This integrity check is vendor specific and may be realized by the UCM by checking the payload Checksum or by any other mechanisms.

> 此操作由UCM实现，以验证在处理过程中没有损坏任何文件。此完整性检查是供应商特定的，可以通过检查有效负载校验和或其他任何机制由UCM实现。


ProcessSwPackage checks if the Software Cluster to be removed is from category PLATFORM_CORE. If this is the case, UCM shall not remove it in accordance to [[SWS_UCM_00245](#_bookmark33)].

> ProcessSwPackage检查要删除的软件集群是否属于PLATFORM_CORE类别。 如果是这种情况，UCM根据[[SWS_UCM_00245](#_bookmark33)]不得删除它。


ProcessSwPackage checks if the Software Cluster version being updated is older than currently present in Machine in accordance to [[SWS_UCM_00103](#_bookmark102)] (OldVersion).

> ProcessSwPackage检查正在更新的软件集群版本是否比根据[[SWS_UCM_00103](#_bookmark102)]（OldVersion）中机器上当前存在的版本更旧。


**[SWS_UCM_00150] Cancellation of a Software Package processing** [ProcessSwPackage method shall raise the ApplicationError ProcessSwPackageCancelled if the Cancel method has been called during the processing of a Software Package.*♩(RS_UCM_00024)*

> **[SWS_UCM_00150] 软件包处理取消** [ProcessSwPackage方法应该引发ApplicationError ProcessSwPackageCancelled，如果在处理软件包时调用了Cancel方法。*♩(RS_UCM_00024)*

### Error handling for Cancel


**[SWS_UCM_00278]**{DRAFT} **Cancel error handling order** [Cancel method shall check the following error conditions and return the respective error code.

> **[SWS_UCM_00278]**{草案} **取消错误处理订单** [取消方法应检查以下错误条件并返回相应的错误代码。


1. [[SWS_UCM_00234](#_bookmark79)]

> [[SWS_UCM_00234](#_bookmark79)]

2. [[SWS_UCM_00235](#_bookmark80)]

> 2. [[SWS_UCM_00235](#_bookmark80)]

*♩(RS_UCM_00020)*


**[SWS_UCM_00234] Cancel OperationNotPermitted** [Cancel shall raise the error ApplicationError OperationNotPermitted in case the targeted Software Package processing has not yet started or has been already finished.*♩(RS_UCM\_00020)*

> **[SWS_UCM_00234] 取消 OperationNotPermitted** [在目标软件包处理尚未开始或已经完成的情况下，取消操作将引发ApplicationError OperationNotPermitted错误。*♩(RS_UCM\_00020)*


**[SWS_UCM_00235] Cancel InvalidTransferId** [Cancel shall raise the error ApplicationError InvalidTransferId in case an invalid TransferId is sent by the client.*♩(RS_UCM_00020)*

> [SWS_UCM_00235] 如果客户端发送了无效的TransferId，取消操作应引发ApplicationError InvalidTransferId错误。♩(RS_UCM_00020)

### Error handling for RevertProcessedSwPackages [SWS_UCM_00279] {DRAFT} RevertProcessedSwPackages error handling order


[RevertProcessedSwPackages method shall check the following error conditions

> [RevertProcessedSwPackages 方法应检查以下错误条件]


and return the respective error code.

> 并返回相应的错误代码。


1. [[SWS_UCM_00237](#_bookmark82)]

> [[SWS_UCM_00237](#_bookmark82)]

2. [[SWS_UCM_00236](#_bookmark83)]

> 2. [[SWS_UCM_00236](#_bookmark83)]

*♩(RS_UCM_00020)*


**[SWS_UCM_00237] RevertProcessedSwPackages OperationNotPermitted** [RevertProcessedSwPackages method call shall raise the error ApplicationError OperationNotPermitted in case the processed Software Packages are successfully activated or it is called at other states than kReady (Software Package(s) are finished being processed) or kProcessing states.*♩(RS_UCM_00020)*

> **[SWS_UCM_00237] RevertProcessedSwPackages 操作不允许**[如果已成功激活处理的软件包或者在kReady（软件包已完成处理）或kProcessing状态下调用RevertProcessedSwPackages方法，则会引发ApplicationError OperationNotPermitted错误。♩（RS_UCM_00020）*


**[SWS_UCM_00236]**{DRAFT} **RevertProcessedSwPackages NotAbleToRevertPackages** [RevertProcessedSwPackages shall raise the error ApplicationError NotAbleToRevertPackages in case reverting of processed Software Packages have failed.*♩(RS_UCM_00020)*

> **[SWS_UCM_00236]**{草稿} **RevertProcessedSwPackages无法还原软件包** [如果还原处理的软件包失败，RevertProcessedSwPackages应引发错误ApplicationError NotAbleToRevertPackages。*♩（RS_UCM_00020）*

### Error handling for GetSwProcessProgress


**[SWS_UCM_00220] GetSwProcessProgress InvalidTransferId** [GetSwProcessProgress shall raise the error ApplicationError InvalidTransferId in case an invalid TransferId is sent by the client.*♩(RS_UCM_00023)*

> **[SWS_UCM_00220] GetSwProcessProgress 无效的TransferId** [GetSwProcessProgress 如果客户端发送无效的TransferId，应引发ApplicationError InvalidTransferId错误。*♩(RS_UCM_00023)*

### Activation and Rollback


UCM should notify the activation or rollback of Software Packages to other Functional Clusters of the AUTOSAR Adaptive Platform. Vendor specific solution dictates to which modules this information is available, in which form and if this is done directly when change is done or when change is executed.

> UCM应该通知AUTOSAR自适应平台的其他功能集群软件包的激活或回滚。供应商特定的解决方案指定哪些模块可以获得这些信息，以何种形式获得，以及是在变更时直接完成，还是在执行变更时完成。

### Activation


The SoftwareCluster state kPresent does not express whether a SoftwareCluster is currently executed or not. You can refer to chapter [7.1.1](#software-cluster-lifecycle) Software Cluster Lifecycle for more details about kPresent state and sequence diagram 10.4 for more details about activation.

> 软件集群状态kPresent不表达当前是否正在执行软件集群。您可以参考第7.1.1节软件集群生命周期以获取有关kPresent状态的更多详细信息，以及序列图10.4以获取有关激活的更多详细信息。


An activation of SoftwareClusters is triggered by an Activate method call. At beginning of activation, UCM is asking State Management for an update session. Once granted, UCM is requesting State Management to stop running processes from the outdated SoftwareClusters. When processes stopped, UCM makes available to the AUTOSAR Adaptive Platform the updated or installed SoftwareClusters, the core action step of the activation. A verification of the activated SoftwareClusters is then performed by requesting State Management changing the SoftwareClusters Function Groups modes to kVerify. For an example of activation sequence, you can refer to chapter 10.4

> 软件集群的激活是由调用激活方法触发的。在激活的开始，UCM向状态管理请求更新会话。一旦获得授权，UCM就要求状态管理停止运行过时的软件集群中的进程。当进程停止时，UCM将更新或安装的软件集群提供给AUTOSAR自适应平台，这是激活的核心动作步骤。然后，通过要求状态管理将软件集群功能组的模式更改为kVerify，来对激活的软件集群进行验证。有关激活序列的示例，请参见第10.4章。


**[SWS_UCM_00293]**{DRAFT} **VerifyUpdate method** [At kVerifying state and before triggering to kActivated state, UCM shall call the State Management UpdateRequest Service Interface VerifyUpdate method passing the list of Function Groups defined in SoftwareCluster claimedFunctionGroup attribute of the class.*♩(RS_UCM_00024)*

> **[SWS_UCM_00293]**{草案} **验证更新方法** [在kVerifying状态和触发到kActivated状态之前，UCM应调用状态管理更新请求服务接口VerifyUpdate方法，传递类的SoftwareCluster claimedFunctionGroup属性定义的功能组列表。*♩(RS_UCM_00024)*


**[SWS_UCM_00107] Activated state** [UCM state kActivated shall be set after the new versions of updated SoftwareClusters have been verified.*♩(RS_UCM_00008, RS_UCM_00030)*

> **[SWS_UCM_00107] 已激活状态**[在新版本的更新软件集群已经验证后，应将UCM状态设置为kActivated。*♩(RS_UCM_00008，RS_UCM_00030)*


The state management [[3](#_bookmark5)] on the level of execution is handled by the UCM's client controlling the update process.

> 状态管理[3]在执行级别上由UCM的客户端控制更新过程。


UCM has to be able to update several SoftwareClusters for an update campaign. However, these SoftwareClusters could have dependencies not satisfied if updates are processed and activated one by one. Therefore, UCM splits the activation action from the general package processing.

> UCM必须能够为更新活动更新几个软件集群。但是，如果一次一个地处理和激活这些软件集群，可能会导致依赖关系不满足。因此，UCM将激活动作与一般的软件包处理分开。


**[SWS_UCM_00027]**{OBSOLETE} **Delta Package version applicability** [Applicable version of SoftwareCluster on which to apply delta shall be included into related SoftwarePackage's deltaPackageApplicableVersion attribute.*♩(RS_UCM\_00007)*

> **[SWS_UCM_00027]**{已过时} **增量包版本适用性** [应将要应用增量的软件集群的适用版本包含在相关软件包的deltaPackageApplicableVersion属性中。*♩(RS_UCM\_00007)*


Applicable version of a SoftwareCluster on which to apply delta is included into related SoftwarePackage's deltaPackageApplicableVersion attribute

> 适用于应用增量的软件集群的适用版本包含在相关软件包的deltaPackageApplicableVersion属性中。


**[SWS_UCM_00025]**{OBSOLETE} **Activation of SoftwareClusters** [At the invocation of method Activate, UCM shall enable execution of any pending changes from the previously processed Software Packages.*♩(RS_UCM_00021)*

> **[SWS_UCM_00025]**{已废弃} **软件集群的激活** [在调用Activate方法时，UCM应启用任何先前处理的软件包中的任何待处理的变更。*♩(RS_UCM_00021)*


Every call to ProcessSwPackage makes necessary preparations of possible actions on the Software Cluster (ActionType [SWS_UCM_00132]) : kInstall, kRemove, kUpdate. The Activate call finalises the started actions during processing

> 每次调用ProcessSwPackage都需要对软件集群（ActionType [SWS_UCM_00132]）进行可能的操作准备：kInstall、kRemove、kUpdate。Activate调用在处理过程中完成启动的操作。


and then UCM applies changes at activation that were still pending from processing, like for instance updating the list of processes managed by Execution Management.

> 然后UCM在激活时应用仍未处理的更改，例如更新由执行管理管理的进程列表。


After Activate, the new set of SoftwareClusters can be started. Activation covers all the processed Software Packages for all the clients.

> 激活后，可以启动新的软件集群。激活覆盖了所有处理过的客户端软件包。


**[SWS_UCM_00022] Activation of Software Clusters** [UCM shall activate all the Software Clusters extracted from the Software Packages when Activate is called.*♩(RS_UCM_00021)*

> **[SWS_UCM_00022] 软件集群的激活** [UCM 在调用激活时应该激活从软件包中提取的所有软件集群。*♩(RS_UCM_00021)*


The activation method could lead to a full system reset. When Software Package updates underlying OS, AUTOSAR Adaptive Platform or any Adaptive Application which is configured to be part of Function Group MachineFG, the execution of updated software occurs through system reset by calling State Management UpdateRequest Service Interface ResetMachine method. Meta-data of Software Package defines the activation method.

> 激活方法可能导致完全系统重置。当软件包更新底层操作系统、AUTOSAR自适应平台或任何配置为Function Group MachineFG一部分的自适应应用程序时，通过调用状态管理更新请求服务接口ResetMachine方法来执行更新的软件。软件包的元数据定义了激活方法。


In principle, it is possible to activate multiple versions of the same SoftwareCluster in one activation step. This could be useful for example with delta package updates but does not apply to firmware updates. The specification does not prohibit to create this kind of chained updates. The decision to use chained updates should be based on safety aspects and the applicability of the underlying update technology, if the update is for a classic or an adaptive platform, if a file system is involved or if the used platform even support it.

> 原则上，可以在一个激活步骤中激活同一软件集群的多个版本。例如，这对于delta包更新可能很有用，但不适用于固件更新。规范不禁止创建这种链式更新。是否使用链式更新应基于安全方面和所使用的更新技术的适用性，如果更新是针对传统平台还是自适应平台，如果涉及文件系统或使用的平台是否支持它。

### Error handling for Activate


**[SWS_UCM_00281] Activate error handling order** [Activate method shall check the following error conditions and return the respective error code.

> [SWS_UCM_00281] 激活错误处理顺序[激活方法应检查以下错误条件并返回相应的错误代码。

```
1. [[SWS_UCM_00241](#_bookmark87)]
2. [[SWS_UCM_00026](#_bookmark88)]
3. [[SWS_UCM_00258](#_bookmark39)]
4. [[SWS_UCM_00242](#_bookmark89)]
5. [[SWS_UCM_00280](#_bookmark90)]
```

*♩(RS_UCM_00026)*


**[SWS_UCM_00241] Activate OperationNotPermitted** [Activate shall raise the error ApplicationError OperationNotPermitted in case the UCM state is not kReady.*♩(RS_UCM_00021)*

> **[SWS_UCM_00241]激活OperationNotPermitted** [如果UCM状态不是kReady，激活将引发ApplicationError OperationNotPermitted错误。*♩(RS_UCM_00021)*


**[SWS_UCM_00026] Dependency Check** [During the UCM state kActivating, UCM shall perform a dependency check to ensure that all the Software Clusters having dependencies are not missing any necessary Software Cluster as defined by

> [SWS_UCM_00026] 依赖性检查 [在UCM状态kActivating期间，UCM应执行依赖性检查，以确保所有具有依赖关系的软件集群不缺少定义的必要软件集群。


dependsOn and do not conflict towards each other as defined by conflictsTo, otherwise return ApplicationError MissingDependencies.*♩(RS_UCM_00007)*

> 取决于彼此，并根据conflictsTo定义不冲突，否则返回应用程序错误MissingDependencies.♩（RS_UCM_00007）


If Activate method cannot establish an Update Session with State Management, it returns UpdateSessionRejected, see [[SWS_UCM_00258](#_bookmark39)].

> 如果Activate方法无法建立与状态管理的更新会话，它将返回UpdateSessionRejected，详见[[SWS_UCM_00258](#_bookmark39)]。


When UCM Master or OTA Client calls Activate method and it raises ApplicationError UpdateSessionRejected, UCM Master can retry the Activate method again later to enter Update Session again. This behaviour is configured by UcmRetryStrategy.

> 当UCM Master或OTA Client调用Activate方法并引发ApplicationError UpdateSessionRejected时，UCM Master可以稍后再次调用Activate方法以再次进入更新会话。此行为由UcmRetryStrategy配置。


**[SWS_UCM_00298]**{DRAFT} **Retry Strategy for UpdateSessionRejected** [When Activate returns ApplicationError UpdateSessionRejected more than maximumNumberOfRetries within retryIntervalTime, then UCM Master shall cancel the active campaign by transitioning to kCancelling state.*♩(RS_UCM_00026, RS_UCM_00024)*

> **[SWS_UCM_00298]**{草案} **更新会话被拒绝的重试策略** [当激活返回的ApplicationError UpdateSessionRejected超过maximumNumberOfRetries在retryIntervalTime内，UCM Master将通过转换到kCancelling状态取消活动活动。*♩（RS_UCM_00026，RS_UCM_00024）*


If no retry strategy is needed, the maximum number of attempts can be specified as 0 in UcmRetryStrategy.

> 如果不需要重试策略，可以在UcmRetryStrategy中将最大尝试次数指定为0。


**[SWS_UCM_00242] Activate PrepareUpdateFailed** [Activate shall raise the error ApplicationError PrepareUpdateFailed in case of activation state transition failure from State Management side.*♩(RS_SM_00001)*

> [SWS_UCM_00242]激活PrepareUpdateFailed失败  如果激活状态转换从状态管理方面失败，激活将引发错误ApplicationError PrepareUpdateFailed。*♩(RS_SM_00001)*


**[SWS_UCM_00280] Activate VerificationFailed** [Activate shall raise the error ApplicationError VerificationFailed in case of verification failure returned by State Management.*♩(RS_UCM_00021)*

> **[SWS_UCM_00280] 激活验证失败** [如果状态管理返回的验证失败，激活将引发错误ApplicationError VerificationFailed。*♩(RS_UCM_00021)*

### Rollback


**[SWS_UCM_00005]**{OBSOLETE} **Rollback to the software prior to Finish the update process** [UCM shall provide a method Rollback to recover from an activation that went wrong.*♩(RS_UCM_00008)*

> [SWS_UCM_00005]{废弃}**完成更新过程后回滚至软件之前的版本**[UCM应提供一种回滚方法来恢复激活失败的情况*♩(RS_UCM_00008)*


Rollback can be called in the case of A/B partitions or UCM uses some other solution to maintain backups of updated or removed Software Packages.

> 回滚可以在A/B分区的情况下使用，或者UCM使用其他解决方案来维护更新或删除的软件包的备份。


**[SWS_UCM_00110] Rolling-back the software update** [At kRollingBack state, UCM shall disable the changes done by the software update by calling State Management UpdateRequest Service Interface PrepareRollback method for each Function Group of the processed Software Cluster in the update session. Then UCM shall call State Management UpdateRequest Service Interface ResetMachine method if any Software Cluster requires a machine reboot to be rolled back.*♩(RS_UCM_00008)*

> **[SWS_UCM_00110] 回滚软件更新**[在kRollingBack状态下，UCM应在更新会话中为处理的软件集群的每个功能组调用State Management UpdateRequest服务接口PrepareRollback方法来禁用软件更新所做的更改。然后，如果任何软件集群需要重新启动机器以进行回滚，UCM应调用State Management UpdateRequest服务接口ResetMachine方法。*♩(RS_UCM_00008)*


If a reset of the Machine is not necessary, an implementation specific way to inform Execution Management that a Software Cluster was updated can be performed.

> 如果不需要对机器进行重置，可以采取一种特定的实施方式来通知执行管理，软件集群已更新。


**[SWS_UCM_00299]**{DRAFT} **Verify rolled back Software Clusters** [After a UCM successful Rollback using call State Management UpdateRequest Service Interface PrepareRollback method and optional Machine reset or manifest reparse, UCM shall call State Management UpdateRequest Service Interface VerifyUpdate method to confirm that all Software Clusters impacted by update are still safe to be launched.*♩(RS_UCM_00008)*

> **[SWS_UCM_00299]**{草案} **验证回滚的软件集群** [在使用状态管理更新请求服务接口PrepareRollback方法和可选的机器重置或清单重新解析完成UCM成功回滚后，UCM应调用状态管理更新请求服务接口VerifyUpdate方法来确认更新影响的所有软件集群仍然可以安全启动。*♩(RS_UCM_00008)*


**[SWS_UCM_00302]**{DRAFT} **Rollback failing is triggering production error** [When a Rollback is failing, UCM shall report UCM_FAILED_ROLLBACK production error.*♩ (RS_UCM_00008, RS_UCM_00027)*

> **[SWS_UCM_00302]**{草案} **回滚失败会引发生产错误** [当回滚失败时，UCM应报告UCM_FAILED_ROLLBACK生产错误。*♩ (RS_UCM_00008，RS_UCM_00027)*

### Error handling for Rollback


**[SWS_UCM_00282] Rollback error handling order** [Rollback method shall check the following error conditions and return the respective error code.

> **[SWS_UCM_00282] 回滚错误处理顺序** [回滚方法应检查以下错误条件并返回相应的错误代码。


1\. [[SWS_UCM_00239](#_bookmark92)]

> 1. [[SWS_UCM_00239](#_bookmark92)]

*♩(RS_UCM_00008)*


**[SWS_UCM_00239] Rollback OperationNotPermitted** [Rollback shall raise the error ApplicationError OperationNotPermitted in case UCM current state is not kActivated nor kVerifying.*♩(RS_UCM_00020)*

> **[SWS_UCM_00239] 回滚操作不允许** [如果UCM当前状态不是kActivated或kVerifying，则回滚操作将引发ApplicationError OperationNotPermitted错误。*♩(RS_UCM_00020)*

### Boot options


During update process the executed software is switched from original software to updated software and in case of rollback, from updated software to original version. Which version of software is executed is dependent on the UCM state and this is managed by the UCM. In case of platform and OS update the switch between software versions occurs through system reset and depending on the system design the Execution Management [[2](#_bookmark4)] might be started before UCM. In this case there can't be direct interface between UCM and Execution Management [[2](#_bookmark4)] to define which versions of software would be executed. Instead this would be controlled through persistent controls which are referred as Boot options in this document.

> 在更新过程中，执行的软件从原始软件切换到更新的软件，而在回滚的情况下，从更新的软件切换到原始版本。哪个版本的软件被执行取决于UCM状态，并由UCM管理。在平台和操作系统更新时，软件版本之间的切换是通过系统重置实现的，根据系统设计，执行管理[[2](#_bookmark4)]可能会在UCM之前启动。在这种情况下，UCM和执行管理[[2](#_bookmark4)]之间不能直接接口来定义将要执行的软件版本。相反，这将通过持久控件（在本文中称为引导选项）来控制。


**[SWS_UCM_00094] Management of executable software** [UCM shall manage which version of software is available for the Execution Management [[2](#_bookmark4)] to launch.*♩(RS\_UCM_00021)*

> [SWS_UCM_00094] 可执行软件的管理[UCM 应当管理哪个版本的软件可用于执行管理[[2](#_bookmark4)]来启动。*♩(RS\_UCM_00021)*


During the kActivating state, UCM modifies the Boot options so that in the next restart for the updated software the new versions will be executed. In the kRollingBack state, UCM modifies the Boot options so that in the next restart of the updated software the original versions will be executed.

> 在kActivating状态下，UCM修改启动选项，以便在下次重新启动更新的软件时执行新版本。在kRollingBack状态下，UCM修改启动选项，以便在下次重新启动更新的软件时执行原始版本。

### Finishing activation


**[SWS_UCM_00020] Finishing the packages activation** [UCM shall provide a method Finish to commit all the changes and clean up all temporary data of the processed Software Packages.*♩(RS_UCM_00015)*

> [SWS_UCM_00020] 完成软件包激活[UCM应提供一种Finish方法来提交所有更改并清理处理过的软件包的所有临时数据*♩(RS_UCM_00015)*


UCM should also remove Software Packages, logs or any older versions of changed software to save storage space. It is up to implementer to remove or not the Software Packages.

> UCM也应该移除软件包、日志或任何已更改软件的旧版本，以节省存储空间。是否移除软件包完全由实施者决定。


**[SWS_UCM_00259] Ending the update session** [UCM shall call State Management UpdateRequest Service Interface StopUpdateSession method when UCM is exiting the kCleaningUp state.*♩(RS_UCM_00021, RS_UCM_00018)*

> **[SWS_UCM_00259] 结束更新会话** [当UCM退出kCleaningUp状态时，UCM应调用状态管理更新请求服务接口StopUpdateSession方法。*♩（RS_UCM_00021，RS_UCM_00018）*


**[SWS_UCM_00240] Finish OperationNotPermitted** [Finish shall raise the error ApplicationError OperationNotPermitted in case there are no activated nor rolled-back Software Packages pending finalization (i.e UCM state is not kActivated nor kRolledBack.*♩(RS_UCM_00001, RS_UCM_00026)*

> **[SWS_UCM_00240]完成操作不允许**[如果没有激活或回滚的软件包待最终确认（即UCM状态不是kActivated或kRolledBack.），完成将引发错误ApplicationError OperationNotPermitted。*♩（RS_UCM_00001，RS_UCM_00026）*


For UCM to be able to free all unneeded resources while processing the Finish request, it is up to the vendor and platform specific implementation to make sure that obsolete versions of changed SoftwareClusters aren't executed anymore.

> 为了使UCM能够在处理完成请求时释放所有不需要的资源，由供应商和特定平台的实现来确保不再执行已更改的SoftwareClusters的过时版本。

### Status Reporting


Once Software Packages are transferred to UCM, they are ready to be processed to finally apply changes to the AUTOSAR Adaptive Platform. In contrast to the transmission, the processing and activation tasks have to happen in a strict sequential order.

> 一旦软件包被传输到UCM，它们就可以处理，最终应用变化到AUTOSAR自适应平台上。与传输相反，处理和激活任务必须按严格的顺序进行。


To give an overview of the update sequence, the global state of UCM is described in this section. The details of the processing and activation phases and the methods are specified in the [7.1.5](#processing-software-packages) and [7.1.6](#activation-and-rollback).

> 为了概括更新序列，本节描述了UCM的全局状态。处理和激活阶段的细节以及方法在[7.1.5](#processing-software-packages)和[7.1.6](#activation-and-rollback)中有详细说明。


The global state of UCM can be queried using the field CurrentStatus. The state machine for CurrentStatus is shown in Fig. [7.5](#_bookmark96). This diagram does not include behaviour after a reset. Examples can be found of how UCM and its CurrentStatus field behave including reset management in chapter 10 Sequence Diagram.

> 全局UCM状态可以使用CurrentStatus字段查询。CurrentStatus的状态机如图7.5所示。此图不包括重置后的行为。在第10章序列图中可以找到UCM及其CurrentStatus字段的行为，包括重置管理的示例。


**[SWS_UCM_00019] Status Field of Package Management** [The global state of UCM

> **[SWS_UCM_00019] 包管理的状态字段** [UCM的全局状态]


shall be provided using the field CurrentStatus*♩(RS_UCM_00024)*

> 将使用字段CurrentStatus*♩(RS_UCM_00024)*提供

![](./media/image12.png)

**Figure 7.5:** **State Machine for the package processing using service interface: PackageManagement**


UCM supported method calls for each value of field CurrentStatus are shown in Fig. [7.5](#_bookmark96).

> 图7.5中显示了UCM支持的每个CurrentStatus字段值的方法调用。


**[SWS_UCM_00080] Idle state of Package Management** [kIdle shall be the default state.*♩(RS_UCM_00024)*

> [SWS_UCM_00080] 包管理的空闲状态[空闲状态应该是默认状态。*♩(RS_UCM_00024)*


**[SWS_UCM_00149] Return to the Idle state from Processing state** [kIdle state shall be set when ProcessSwPackage returns with error code ProcessSwPackageCancelled and if no other Software Packages were previously processed during this processing operation.*♩(RS_UCM_00024)*

> [SWS_UCM_00149] 从处理状态返回到空闲状态。 如果ProcessSwPackage返回错误代码ProcessSwPackageCancelled，并且在此处理操作期间未处理其他软件包，则应设置kIdle状态(RS_UCM_00024)。


**[SWS_UCM_00151] Entering the Ready state of Package Management after a Cancel call** [If ProcessSwPackage has been cancelled, UCM shall return error code ProcessSwPackageCancelled and set state to kReady only if at least one other Software Package was previously processed during this processing operation.*♩ (RS_UCM_00024)*

> **[SWS_UCM_00151] 在取消调用后进入软件包管理的就绪状态。如果ProcessSwPackage被取消，UCM应返回错误代码ProcessSwPackageCancelled，并将状态设置为kReady，只有在此处理操作期间先前处理了至少一个其他软件包时才可以。（RS_UCM_00024）


**[SWS_UCM_00081] Processing state of Package Management** [kProcessing state shall be set only if ProcessSwPackage has been called. This shall only be possible, if CurrentStatus is reported as kIdle or kReady.*♩(RS_UCM_00024)*

> **[SWS_UCM_00081] 包管理的处理状态** [k处理状态只有在调用ProcessSwPackage之后才能设置。只有当CurrentStatus报告为kIdle或kReady时，才有可能。*♩(RS_UCM_00024)*


**[SWS_UCM_00266]**{DRAFT} **OperationNotPermitted error and UCM state** [UCM shall return ApplicationError OperationNotPermitted if ProcessSwPackage is called by a client with UCM at CurrentStatus state different than kIdle, kProcessing or kReady.*♩(RS_UCM_00001, RS_UCM_00004)*

> **[SWS_UCM_00266]**{草案} **操作不允许错误和UCM状态** [如果客户端调用ProcessSwPackage时，UCM的当前状态不是kIdle、kProcessing或kReady，UCM将返回ApplicationError OperationNotPermitted。*♩(RS_UCM_00001，RS_UCM_00004)*


**[SWS_UCM_00083] Entering the Ready state of Package Management after a successful processing operation** [kReady state shall be set after a Software Package processing has been completed successfully.*♩(RS_UCM_00024)*

> [SWS_UCM_00083] 在成功处理操作后进入软件包管理的就绪状态[kReady状态应在软件包处理成功完成后设置*♩(RS_UCM_00024)*


**[SWS_UCM_00265] state transition due to ProcessSwPackage error** [If ProcessSwPackage raises an ApplicationError other than ProcessSwPackageCancelled, it shall transition from kProcessing to kIdle if no other Software Packages were previously processed during this processing operation, or kReady if at least one other Software Package was previously processed before the failed processing operation, and shall perform clean-up actions.*♩(RS_UCM_00015, RS_UCM_00026)*

> **[SWS_UCM_00265] 如果ProcessSwPackage引发的ApplicationError不是ProcessSwPackageCancelled，如果在此处理操作期间没有其他软件包被处理，则它将从kProcessing转换为kIdle，如果在失败的处理操作之前至少处理了一个其他软件包，则它将转换为kReady，并执行清理操作。*♩(RS_UCM_00015，RS_UCM_00026)*


Clean-up actions could be similar to the cancel call by for instance deleting files, folders or artefacts of the processed Software Cluster.

> 清理行动可以类似于取消通话，例如删除处理软件群集的文件、文件夹或工件。


**[SWS_UCM_00152] Entering the Ready state of Package Management after a missing dependency** [kReady state shall be set when Activate fails due to an ApplicationError MissingDependencies.*♩(RS_UCM_00024)*

> **[SWS_UCM_00152] 在缺少依赖项后进入包管理的就绪状态*♩(RS_UCM_00024)*


**[SWS_UCM_00084] Entering the kActivating state of Package Management** [kActivating shall be set when Activate is called. This triggers the dependency check and returns ApplicationError MissingDependencies if this check fails.*♩(RS\_UCM_00024)*

> **[SWS_UCM_00084] 进入包管理的kActivating状态** [当调用Activate时，kActivating应被设置。如果依赖性检查失败，则会返回ApplicationError MissingDependencies。*♩(RS_UCM_00024)*


**[SWS_UCM_00153] Action in kActivating state of Package Management** [When kActivating is set and after the State Management UpdateRequest Service Interface RequestUpdateSession method call by UCM, the UCM shall call the State Management UpdateRequest Service Interface PrepareUpdate method for the concerned Software Cluster including a list of all Function Groups belonging to that Software Cluster.*♩(RS_UCM_00024)*

> **[SWS_UCM_00153] 在Package Management的kActivating状态下的操作** [当kActivating被设置，并且UCM调用了State Management UpdateRequest服务接口的RequestUpdateSession方法之后，UCM应当调用State Management UpdateRequest服务接口的PrepareUpdate方法，其中包括属于该软件集群的所有功能组的列表。*♩(RS_UCM_00024)*


**[SWS_UCM_00260]**{DRAFT} **PrepareUpdate, VerifyUpdate and PrepareRollback orders** [UCM shall compute the order of the State Management UpdateRequest Service Interface PrepareUpdate, VerifyUpdate and PrepareRollback method calls from the dependency model included in the Software Cluster manifests.*♩ (RS_UCM_00007, RS_UCM_00021, RS_UCM_00030)*

> **[SWS_UCM_00260]**{草案}**准备更新、验证更新和准备回滚指令** [UCM 应根据软件集清单中包含的依赖模型计算状态管理更新请求服务接口PrepareUpdate、VerifyUpdate和PrepareRollback方法调用的顺序。*♩ (RS_UCM_00007, RS_UCM_00021, RS_UCM_00030)*


**[SWS_UCM_00261] PrepareUpdate, VerifyUpdate and PrepareRollback synchronous calls** [Calls to State Management UpdateRequest Service Interface PrepareUpdate, VerifyUpdate and PrepareRollback methods shall not be concurrent.*♩(RS_UCM_00026)*

> [SWS_UCM_00261] 同步调用PrepareUpdate、VerifyUpdate和PrepareRollback：对状态管理UpdateRequest服务接口的PrepareUpdate、VerifyUpdate和PrepareRollback方法的调用不能是并发的（RS_UCM_00026）。


**[SWS_UCM_00262]**{DRAFT} **Update preparation rejected** [If any call of the State Management UpdateRequest Service Interface PrepareUpdate method returns error kRejected too many times (maxNumberOfPrepareUpdateRetries) or for

> **[SWS_UCM_00262]**{草案} **更新准备被拒绝** [如果状态管理更新请求服务接口PrepareUpdate方法被拒绝太多次（maxNumberOfPrepareUpdateRetries）或被拒绝，


too long (prepareUpdateTimeout), UCM shall transition from kActivating to

> 太长（prepareUpdateTimeout），UCM将从kActivating转换为


kReady states.*♩(RS_UCM_00026)*

> 准备状态。♩（RS_UCM_00026）


**[SWS_UCM_00263] Update preparation failure** [If any one of the State Management UpdateRequest Service Interface PrepareUpdate method returns error kFailed, UCM shall transition from kActivating to kReady states.*♩(RS_UCM\_00026)*

> **[SWS_UCM_00263] 更新准备失败** [如果State Management UpdateRequest Service Interface PrepareUpdate方法中任何一个返回错误kFailed，UCM将从kActivating状态转换到kReady状态。*♩（RS_UCM\_00026）*


**[SWS_UCM_00154] Entering the Verifying state of Package Management** [kVerifying shall be set when the dependency check have been performed successfully (all dependencies are satisfied) and that the preparation of the Software Clusters by the State Management has been successfully performed.*♩(RS_UCM_00024)*

> [SWS_UCM_00154] 成功地执行了依赖性检查（所有依赖关系都已满足）和状态管理成功地准备了软件集群后，将进入软件包管理的验证状态（RS_UCM_00024）。


The machine could most likely be restarted in case a A/B partition is used. In case the A/B partition is not used, all affected Function Groups or the platform could be restarted. Immediately after the processed Software Package has been restarted, a system check has to be performed in order to make sure the machine is able to start up as expected. With this check it is verified that other safety relevant software like Functional Cluster Platform Health Manager [[13](#_bookmark13)] is running and user can be protected from any issues caused by the update after the update has finished.

> 如果使用A/B分区，机器很可能可以重新启动。如果没有使用A/B分区，所有受影响的功能组或平台可以重新启动。处理软件包重新启动后，必须进行系统检查，以确保机器能够按预期启动。通过这个检查，可以验证其他安全相关软件，如功能集群平台健康管理器[[13]](＃_bookmark13)正在运行，并且用户可以在更新完成后免受更新带来的任何问题的保护。


An update could most likely require to reparse the manifests after performing the atomic activation of the Software Clusters (switching A/B partition, changing symlinks, etc.) if a machine reset is not needed.

> 更新可能需要在执行软件集群的原子激活（切换A/B分区、更改符号链接等）后重新解析清单，如果不需要机器重置。


**[SWS_UCM_00085] Entering the kActivated state of Package Management** [kActivated state shall be set when the VerifyUpdate method of State Management service interface UpdateRequest is returned successfully.*♩(RS_UCM_00024)*

> **[SWS_UCM_00085] 进入包管理的kActivated状态** [当状态管理服务接口UpdateRequest的VerifyUpdate方法成功返回时，应设置kActivated状态。*♩(RS_UCM_00024)*


By a successful return of VerifyUpdate, UCM assumes all impacted Function Groups (the ones related to the processed Software Package) have been successfully restarted and verified.

> 通过VerifyUpdate的成功返回，UCM假定所有受影响的功能组（与处理的软件包相关的功能组）已经成功重新启动并验证。


kVerifying state gives the client controlling the update process a chance to perform verification test by calling State Management UpdateRequest Service Interface [SWS_SM_91017] VerifyUpdate method, though functionality in verify state can be limited. Client can also coordinate the results over several AUTOSAR Adaptive Platforms and still perform a Rollback if verification indicates the need for it.

> 验证状态可以让客户端控制更新过程，通过调用状态管理更新请求服务接口[SWS_SM_91017] VerifyUpdate方法来执行验证测试，尽管在验证状态下的功能可能有限。客户端还可以在几个AUTOSAR自适应平台之间协调结果，如果验证表明有必要，还可以执行回滚操作。


If the system check is successful, the client can decide either to Rollback the current active processing so that the previous processed working software gets started, or to perform Finish so that the changes of processed software become permanent. By calling Finish a clean-up is initiated and in case of A/B partition, a swap between the partitions happens and the newly inactive partition becomes a copy of the newly active partition. In case Finish succeeds (including the clean-up), the current CurrentStatus changes to kIdle.

> 如果系统检查成功，客户可以选择回滚当前活动处理，以便启动先前处理的工作软件，或执行完成，以使处理软件的更改成为永久性的。通过调用Finish，将启动清理，并在A / B分区的情况下，发生分区之间的交换，新的不活动分区成为新活动分区的副本。如果Finish成功（包括清理），当前的CurrentStatus将更改为kIdle。


For Rollback the update software needs to be deactivated and possibly reactivated from original version, e.g. self-update of UCM. For this reason Rollback is also performed through two states, similarly as activation. Calling Rollback sets UCM

> 回滚更新软件需要先被停用，并可能从原版本重新激活，例如UCM的自动更新。因此，回滚也是通过两个状态来完成的，类似于激活。调用回滚将UCM设置为


into kRollingBack state where original software version is made executable and where original software is activated by the State Management. This is started by calling State Management UpdateRequest Service Interface [SWS_SM_91017] PrepareRollback method for each Software Cluster. On success, UCM goes to kRollingBack state. In this state all the changes introduced during update process have been deactivated and can be cleaned by calling Finish.

> UCM通过调用状态管理更新请求服务接口[SWS_SM_91017]为每个软件集群准备回滚方法，进入kRollingBack状态，在此状态下，原始软件版本可执行，原始软件也被状态管理激活。成功后，UCM进入kRollingBack状态。在此状态下，更新过程中引入的所有更改都被停用，可以通过调用完成来清理。


**[SWS_UCM_00126] Entering the kRollingBack state after a Rollback call** [The state kRollingBack shall be set when Rollback is called.*♩(RS_UCM_00008, RS\_UCM_00030)*

> **[SWS_UCM_00126] 在回滚调用后进入kRollingBack状态**[当调用回滚时，应将kRollingBack状态设置为*♩(RS_UCM_00008, RS\_UCM_00030)*。


**[SWS_UCM_00155] Entering the kRolling-Back state after a failure in the kVerifying state** [The state kRollingBack shall be set if any of the State Management UpdateRequest Service Interface VerifyUpdate method calls returns the result kFailed.*♩(RS_UCM_00008, RS_UCM_00030)*

> **[SWS_UCM_00155] 在kVerifying状态失败后进入kRolling-Back状态（如果状态管理更新请求服务接口VerifyUpdate方法调用的结果为kFailed，则应设置状态kRollingBack）。♩（RS_UCM_00008，RS_UCM_00030）**


**[SWS_UCM_00264]**{DRAFT} **Update verification rejected** [If any call of the State Management UpdateRequest Service Interface VerifyUpdate returns error kRejected too many times (maxNumberOfVerifyUpdateRetries) or for too long ( verifyUpdateTimeout), UCM shall transition to kRollingBack state.*♩(RS_UCM\_00030, RS_UCM_00008)*

> **[SWS_UCM_00264]**{草案} **更新验证被拒绝** [如果状态管理更新请求服务接口VerifyUpdate调用返回错误kRejected太多次（maxNumberOfVerifyUpdateRetries）或太长时间（verifyUpdateTimeout），UCM应过渡到kRollingBack状态。* ♩（RS_UCM\_00030，RS_UCM_00008）*


**[SWS_UCM_00111] Entering the kRollingBack state** [The state kRollingBack shall be set after all calls to State Management UpdateRequest Service Interface PrepareRollback have returned successfully.*♩(RS_UCM_00008, RS_UCM_00030)*

> **[SWS_UCM_00111] 进入kRollingBack状态**[在所有调用状态管理更新请求服务接口PrepareRollback返回成功后，将设置kRollingBack状态。*♩（RS_UCM_00008，RS_UCM_00030）*


**[SWS_UCM_00300]**{DRAFT} **Software Cluster failing to rollback** [If Rollback is failing, UCM CurrentStatus shall transition from kRollingBack to kRollingBackFailed.*♩(RS_UCM_00024)*

> **[SWS_UCM_00300]**{草案} **软件集群无法回滚** [如果回滚失败，UCM CurrentStatus 应从kRollingBack转换为kRollingBackFailed. *♩(RS_UCM_00024)*


**[SWS_UCM_00301]**{DRAFT} **Retry ro Rollback again when UCM is in kRollingBackFailed state** [If Rollback method is called while being at kRollingBackFailed, UCM CurrentStatus shall transition from kRollingBackFailed to kRollingBack.*♩(RS_UCM_00024)*

> **[SWS_UCM_00301]**（草稿）**当UCM处于kRollingBackFailed状态时，重试或回滚**[如果在处于kRollingBackFailed状态时调用回滚方法，UCM的当前状态应从kRollingBackFailed转换到kRollingBack。*♩（RS_UCM_00024）*


**[SWS_UCM_00146] Entering the Cleaning-up state after a Finish call** [The state kCleaningUp shall be set when Finish is called and the UCM starts to perform cleanup actions.*♩(RS_UCM_00008, RS_UCM_00030)*

> **[SWS_UCM_00146] 在完成呼叫后进入清理状态（当调用Finish时，UCM将设置状态kCleaningUp，并开始执行清理操作。*♩(RS_UCM_00008, RS_UCM_00030)*


**[SWS_UCM_00162] Entering the Cleaning-up state after a RevertProcessedSwPackages call** [The state kCleaningUp shall be set when RevertProcessedSwPackages is called in kProcessing or kReady states and the UCM starts to perform cleanup actions.*♩(RS_UCM_00008, RS_UCM_00030)*

> **[SWS_UCM_00162] 在调用RevertProcessedSwPackages后进入清理状态[当在kProcessing或kReady状态下调用RevertProcessedSwPackages时，UCM将开始执行清理活动，并将状态设置为kCleaningUp。*♩(RS_UCM_00008, RS_UCM_00030)*


**[SWS_UCM_00163] Action in Cleaning-up state** [When kCleaningUp state is set, the UCM shall clean up all data of the processed packages that are not needed anymore.*♩(RS_UCM_00008, RS_UCM_00030)*

> **[SWS_UCM_00163] 在清理状态下的行动**[当kCleaningUp状态被设置时，UCM应清理所有已处理的不再需要的包的数据。*♩(RS_UCM_00008, RS_UCM_00030)*


**[SWS_UCM_00164] Cleaning up of Software Packages** [In kCleaningUp state, the

> **[SWS_UCM_00164] 软件包的清理** [在kCleaningUp状态下，


UCM may remove (from the UCM buffer for instance) the \"physical\" Software Package

> UCM可能会从UCM缓冲区中移除“物理”软件包。


(e.g. zip file) that was used to transport the the SoftwareCluster to the UCM.*♩(RS\_UCM_00008, RS_UCM_00030)*

> 这些(例如zip文件)用于将SoftwareCluster传输到UCM，具体编号为RS_UCM_00008和RS_UCM_00030。


**[SWS_UCM_00127] Finishing update sequence** [kIdle shall be set when Finish is called and the clean-up has been successfully performed. This finishes the update sequence and next sequence can be started.*♩(RS_UCM_00008, RS_UCM_00030)*

> **[SWS_UCM_00127] 完成更新序列** [当调用Finish并且成功执行清理操作时，应将kIdle设置为。这将完成更新序列，下一个序列可以开始。*♩（RS_UCM_00008，RS_UCM_00030）*


**[SWS_UCM_00147] Return to the Idle state from Cleaning-up state** [kIdle state shall be set when the Clean-up operation has been completed successfully.*♩(RS\_UCM_00024)*

> [SWS_UCM_00147] 在清理状态完成后返回到空闲状态*♩(RS\_UCM_00024)*

### Robustness against reset


Failure during over-the-air updates could lead into corrupted or inconsistent software configuration and further updates might be blocked. For this reason UCM needs to be robust against interruptions like power downs.

> 空中更新期间的失败可能导致软件配置损坏或不一致，并且可能阻止进一步的更新。因此，UCM需要对像断电这样的中断具有强大的抗性。


**[SWS_UCM_00157] Detection of reset** [At start up UCM shall identify if uncontrolled reset occurred.*♩(RS_UCM_00027)*

> [SWS_UCM_00157] 检测重置[在启动时，UCM应识别是否发生了不受控重置。*♩（RS_UCM_00027）*


The way for UCM to detect uncontrolled reset is project specific. UCM could use hardware platform specific registers to detect Soft/Hard reset. Or it could access PHM Functional Cluster to detect uncontrolled reset. UCM could also check that the CurrentStatus persistent field is not kIdle or kVerifying.

> UCM可以检测无控复位的方法是特定于项目的。UCM可以使用特定于硬件平台的寄存器来检测软/硬复位。或者它可以访问PHM功能集群来检测无控复位。UCM还可以检查CurrentStatus持久字段是否不是kIdle或kVerifying。


**[SWS_UCM_00158] Cleanup of interrupted actions** [After an uncontrolled reset, UCM shall check non volatile memory integrity, recover processed artifacts in case it is corrupted and resume interrupted actions in order to return the system into a state from where UCM can continue serving its Clients.*♩(RS_UCM_00027)*

> [SWS_UCM_00158] 在不受控制的复位后，UCM应检查非易失存储器的完整性，在存储器损坏的情况下恢复处理过的工件，并重新启动被中断的操作，以使系统恢复到UCM可以继续为客户服务的状态。♩(RS_UCM_00027)


After an uncontrolled reset, it can be possible as an example for UCM to confirm consistency of any processed artifacts based on ArtifactChecksum class associated to SoftwareCluster. If checksum value of an artifact does not match, it can be deleted and processed again.

> 在一次未受控的重置之后，作为一个例子，UCM 可以根据与软件集群关联的 ArtifactChecksum 类来确认已处理的工件的一致性。如果工件的校验和值不匹配，可以将其删除并重新处理。


**[SWS_UCM_00270] UCM internal state persistency** [UCM shall persist CurrentStatus state field to be able to resume on-going update after an intended or unintended reboot.*♩(RS_UCM_00027)*

> [SWS_UCM_00270] UCM 内部状态持久性[UCM 应将当前状态字段持久化，以便在有意或无意的重新启动后能够恢复正在进行的更新*♩(RS_UCM_00027)*

### Boot monitoring


Activation failure during OS and Platform-self updates can lead to a state in which the system is not able to reach a point where UCM and the client are able to function as expected and thus not able to execute the rollback. For these cases the system should include component which is responsible to monitor that the OS and platform will start up correctly. In case of failure, the Boot monitoring component should trigger a reset or modify the boot options to trigger a rollback.

> 操作系统和平台自我更新过程中的激活失败可能导致系统无法达到UCM和客户端可以正常工作的状态，因此无法执行回滚操作。对于这些情况，系统应包括一个负责监控操作系统和平台能够正确启动的组件。如果失败，启动监控组件应触发重置或修改启动选项以触发回滚。

### History


**[SWS_UCM_00115] History** [GetHistory method shall retrieve all actions that have been performed by UCM within a specific time window input parameter.*♩(RS_UCM\_00032)*

> [SWS_UCM_00115] 历史[GetHistory方法应在特定的时间窗口输入参数内检索UCM已执行的所有操作。*♩(RS_UCM\_00032)*


In the case the UCM Client requests a rollback after a successful activation, CurrentStatus field transitioning to kActivated, GetHistory method will later return GetHistoryType, with subelement Resolution of type ResultType equal to kActivatedAndRolledBack.

> 在UCM客户端在激活成功后请求回滚的情况下，CurrentStatus字段转换为kActivated，GetHistory方法将会后续返回GetHistoryType，其子元素Resolution的类型为ResultType，并且等于kActivatedAndRolledBack。


**[SWS_UCM_00292] History elements ordering** [UCM shall return from GetHistory method a vector of GetHistoryType sorted in an increasing chronological order.*♩ (RS_UCM_00032)*

> [SWS_UCM_00292] 历史元素排序[UCM 应通过 GetHistory 方法返回一个 GetHistoryType 的向量，按照逐渐增加的时间顺序排序。(RS_UCM_00032)


**[SWS_UCM_00160] Processing results records** [When UCM is entering kVerifying, UCM shall save activation time based on timeBaseResource and activation result of processed Software Packages in the history.*♩(RS_UCM_00032)*

> [SWS_UCM_00160]处理结果记录[当UCM进入kVerifying时，UCM应根据timeBaseResource和处理的软件包的激活结果在历史中保存激活时间。*♩(RS_UCM_00032)*


**[SWS_UCM_00271]**{DRAFT} **Keeping history of failure error code** [UCM shall keep in GetHistoryType subelement FailureError the last failure error code as described in [SWS_UCM_00136]. If no error occurred, the stored value shall be 0.*♩ (RS_UCM_00032)*

> **[SWS_UCM_00271]**{草案} **保存故障错误代码的历史记录** [UCM应在GetHistoryType子元素FailureError中保存根据[SWS_UCM_00136]所述的最后一个故障错误代码。如果没有发生错误，存储的值应为0。*♩（RS_UCM_00032）*


**[SWS_UCM_00303]**{DRAFT} **failing to record history** [If UCM is failing to record a new entry in history, UCM shall report a production error: UCM_HISTORY_RECORD\_FAILED. Any successful history update shall report a pass to this production error.*♩ (RS_UCM_00032)*

> **[SWS_UCM_00303]**{草案} **记录历史失败** [如果UCM无法记录新条目的历史，UCM应报告生产错误：UCM_HISTORY_RECORD\_FAILED。任何成功的历史更新都应向此生产错误报告通过。*♩ (RS_UCM_00032)*

### Version Reporting


**[SWS_UCM_00004]**{OBSOLETE} **Report software information** [UCM shall provide a method GetSwClusterInfo of the interface service PackageManagement to provide the identifiers and versions of the SoftwareClusters that are in state kPresent.*♩(RS_UCM_00002)*

> **[SWS_UCM_00004]**{已过时} **报告软件信息** [UCM应提供接口服务PackageManagement的方法GetSwClusterInfo，以提供处于kPresent状态的SoftwareClusters的标识符和版本。*♩(RS_UCM_00002)*


**[SWS_UCM_00030] Report changes** [UCM shall provide a method GetSwClusterChangeInfo of the interface service PackageManagement to provide the identifiers and versions of the SoftwareCluster that are in state kAdded, kUpdating or kRemoved.*♩(RS_UCM_00011)*

> [SWS_UCM_00030] 报告变更[UCM 应提供一种接口服务PackageManagement的GetSwClusterChangeInfo方法，以提供处于kAdded、kUpdating或kRemoved状态的SoftwareCluster的标识符和版本。*♩(RS_UCM_00011)*


**[SWS_UCM_00185] Provide SoftwareCluster general information** [At the invocation of method GetSwClusterDescription, UCM shall return the version, type approval, license and release notes of the SoftwareCluster that are in state kPresent.*♩(RS_UCM_00002, RS_UCM_00011)*

> 在调用GetSwClusterDescription方法时，UCM应该返回处于kPresent状态的软件集群的版本、批准类型、许可证和发布说明。（RS_UCM_00002，RS_UCM_00011）

### Securing Software Updates


UCM provides service interface using ara::com. There is no authentication of the client in UCM's update sequence.

> UCM使用ara::com提供服务接口。在UCM的更新序列中没有对客户端进行认证。


For authentication of the Software Package, you can refer to [7.1.3](#transferring-software-packages)

> 为了进行软件包的认证，您可以参考[7.1.3](#transferring-software-packages)。


**[SWS_UCM_00103]**{DRAFT} **Update to older Software Cluster version than currently present and than previously removed** [If the version of a SoftwarePackage (returned by GetSwPackages) is smaller than the version of currently present SoftwareCluster (returned by GetSwClusterInfo), the UCM method TransferExit or TransferData shall raise the ApplicationError OldVersion, log this attempt in history (retrievable from GetHistory) and delete the rejected Software Package.*♩(RS_UCM_00031)*

> **[SWS_UCM_00103]**{草案} **更新到比目前存在的和以前删除的更旧的软件集群版本**[如果软件包（由GetSwPackages返回）的版本小于当前存在的软件集群（由GetSwClusterInfo返回）的版本，UCM方法TransferExit或TransferData应引发ApplicationError OldVersion，将此尝试记录在历史记录中（可从GetHistory检索）并删除被拒绝的软件包。*♩(RS_UCM_00031)*


**[SWS_UCM_00190] Reinstallation of older Software Cluster version than previously removed** [New Software Clusters getting installed shall be compared with the history of all installed Software Clusters to prevent installation of a Software Cluster with a lower or equal version than previously installed.*♩(RS_UCM\_00003, RS_UCM_00031)*

> **[SWS_UCM_00190] 重新安装比之前删除的旧软件集群版本** [新安装的软件集群应与所有已安装的软件集群的历史记录进行比较，以防止安装先前安装的版本低于或等于的软件集群。*♩（RS_UCM\_00003，RS_UCM_00031）*


**[SWS_UCM_CONSTR_00002]**{DRAFT} **UCM confidential information handling** [The PackageManagement interface shall only be mapped via ara::com to a secure endpoint using secure communication channel providing confidentiality protection.*♩(RS_UCM_00002, RS_UCM_00010, RS_UCM_00011)*

> [SWS_UCM_CONSTR_00002]{草案} UCM机密信息处理 [PackageManagement 接口必须通过 ara::com 映射到安全端点，使用提供保密保护的安全通信通道。*♩（RS_UCM_00002，RS_UCM_00010，RS_UCM_00011）*


The GetSwClusterInfo, GetSwClusterChangeInfo, GetHistory, GetSwClusterDescription and GetSwPackages methods are using data that could identify vehicle user and therefore should be protected for confidentiality.

> 这些GetSwClusterInfo、GetSwClusterChangeInfo、GetHistory、GetSwClusterDescription和GetSwPackages方法正在使用可以识别车辆用户的数据，因此应该保护其机密性。


**[SWS_UCM_00202]**{DRAFT} **Trusted Platform compliance** [UCM shall ensure that after processing updates, all the necessary changes to comply with the Trusted Platform are applied.*♩(RS_EM_00014)*

> **[SWS_UCM_00202]**{草案} **可信平台符合性** [UCM应确保在处理更新后，应用所有必要的变更以符合可信平台。*♩(RS_EM_00014)*


The authentication tag of the Trusted Platform corresponding to the updated/removed/added executable files should also be updated/removed/added. See also Chapter 7.10 of the Execution Management [[2](#_bookmark4)] for details on the Trusted Platform.

> 对应更新/删除/添加的可执行文件，可信平台的认证标签也应该更新/删除/添加。关于可信平台的详细信息，参见[[2]](#_bookmark4)的执行管理章节7.10。

### Functional cluster lifecycle


**[SWS_UCM_00274]**{DRAFT} **UCM initialization** [UCM shall offer its services only after its internal initialization has been completed, after reporting kRunning state to Execution Management.*♩(RS_UCM_00044)*

> **[SWS_UCM_00274]**{草案} **UCM初始化** [UCM只有在完成内部初始化，并将kRunning状态报告给执行管理后，才提供服务。*♩(RS_UCM_00044)*


This requirement prevents calling UCM subordinate API while internal initialization is on-going. The concrete initialization tasks are implementation specific.

> 这个要求阻止在内部初始化正在进行时调用UCM下级API。具体的初始化任务是实现特定的。

### Shutdown behaviour


There are no requirements of shutdown behaviour from UCM functional cluster.

> 没有任何UCM功能集群的关机行为要求。

1. ## UCM Master


   1. ### UCM Master Functional Cluster lifecycle

> ### UCM主功能集群的生命周期


**[SWS_UCM_01205]**{DRAFT} **UCM Master internal state persistency** [UCM Master shall persist its state to be able to resume on-going update campaign after an intended or unintended reboot.*♩(RS_UCM_00035, RS_UCM_00042)*

> **[SWS_UCM_01205]**{草稿} **UCM 主内部状态持久性** [UCM 主机应持久化其状态，以便在故意或非故意重新启动后能够恢复正在进行的更新活动。*♩（RS_UCM_00035，RS_UCM_00042）*


**[SWS_UCM_01019]**{DRAFT} **UCM Master initialization** [UCM Master shall offer its services only after its internal initialization has been completed, after switching to Running state.*♩(RS_UCM_00044)*

> **[SWS_UCM_01019]**{草案} **UCM 主机初始化** [UCM 主机只有在其内部初始化完成，并切换到运行状态后，才能提供其服务。*♩(RS_UCM_00044)*


This requirement prevents calling UCM Master API while internal initialization is ongoing. The concrete initialization tasks are implementation specific.

> 这个要求防止在内部初始化正在进行时调用UCM主API。具体的初始化任务是实现特定的。

### Technical Overview


UCM Master objective is to provide a standard Adaptive Autosar solution to safely and securely update a complete vehicle Over The Air or by a Diagnostic Tester.

> UCM的目标是提供一种标准的自适应自动化可编程软件架构（Adaptive Autosar）解决方案，以安全可靠地通过空中更新（Over The Air）或诊断测试仪（Diagnostic Tester）来更新整辆车辆。


UCM Master receives packages from Backend or Diagnostic tool, parses and interprets the Vehicle Package, transfers or streams Software Packages to suitable targets (UCM subordinate or Diagnostic Application) and orchestrates the processing, activations and eventual rollbacks. All these actions are what is called a campaign which UCM Master is coordinating. The UCM of the machines in the same network of a UCM Master, candidates target of a campaign, are referred to as UCM subordinates.

> UCM Master从后端或诊断工具接收包，解析和解释车辆包，将软件包传输或流式传输到合适的目标（UCM下属或诊断应用程序），并协调处理、激活和最终回滚。所有这些操作都被称为UCM Master协调的活动。与UCM Master同一网络中的机器的UCM，候选活动的目标，被称为UCM下属。

![](./media/image13.png){width="6.29996062992126in" height="3.1910411198600177in"}

**Figure 7.6: Example of UCM Master architecture overview within a vehicle**


The UCM Master could be considered as a set of add-on features that could enrich any UCM instance. Therefore, as per the UCM APIs, the UCM Master APIs are part of the Adaptive Platform Services. UCM and UCM Master have separate service instances.

> UCM Master可以被视为一组可以丰富任何UCM实例的附加功能。因此，根据UCM API，UCM Master API是Adaptive Platform Services的一部分。UCM和UCM Master有单独的服务实例。


The OTA Client establishes a communication between Backend and UCM Master so that they can exchange information of the installed Software Clusters in the vehicle and the Software Clusters available in the Backend. This communication could be triggered by OTA Client with a scheduler and UCM Master to request the updates in case of newly available Software Clusters (pull case) or by Backend to push, for instance, an important security update to a fleet of vehicles (push case). The computation to find new Software Clusters versions and resolution of dependencies between Software Clusters can be either done at UCM Master or Backend.

> OTA客户端建立了后端和UCM主机之间的通信，以便它们可以交换车辆中安装的软件集群和后端中可用的软件集群的信息。这种通信可以由OTA客户端的调度程序和UCM主机触发，以便在新可用的软件集群（拉取情况）出现时请求更新，或者由后端推送，例如向一组车辆推送重要的安全更新（推送情况）。可以在UCM主机或后端执行找到新软件集群版本和解决软件集群之间依赖关系的计算。


Vehicle Driver interface Adaptive Application is required if it is needed during an update campaign to interact with vehicle human driver through for instance HumanMachine Interface. Download of packages from a Backend could have various financial costs for the driver depending of communication types, so consent from driver could be suitable.

> 如果在更新活动期间需要通过例如人机界面与车辆人驾驶员进行交互，则需要车辆驾驶员界面自适应应用程序。从后端下载软件包可能会给驾驶员带来不同的财务成本，因此驾驶员的同意可能是合适的。


Vehicle State Manager Adaptive Application is required if it is needed during an update campaign to control the vehicle state for safety purposes. For instance, it could be required for safety to have standing still vehicle, shut-off engine, closed doors, etc. before starting an UCM activation or during its processing.

> 需要在更新活动期间控制车辆状态以确保安全的情况下，需要使用车辆状态管理器自适应应用程序。例如，在开始UCM激活或处理过程之前，可能需要将车辆保持静止、关闭引擎和关闭门等以确保安全。

### UCM Master general behaviour


The UCM Master acts as a client of the service interface offered by the UCM subordinates, already specified in UCM. However, the UCM Master also offers three different service interfaces to OTA Client, Vehicle Driver interface and Vehicle State Manager respectively. UCM Master aggregates UCM subordinates states and can report its status field to a Backend through its OTA Client.

> UCM主机作为UCM下级提供的服务接口的客户端，其接口已在UCM中指定。但是，UCM主机还向OTA客户端、车辆驱动程序接口和车辆状态管理器分别提供了三种不同的服务接口。UCM主机聚合UCM下级状态，并可通过其OTA客户端将其状态字段报告给后端。


A UCM Master receives a Vehicle Package and transfers or streams Software Package(s) to the UCM subordinates for an AUTOSAR Adaptive Platform Software Cluster update. A Vehicle Package contains instructions for orchestrating updates between ECUs. The UCM Master provides information about ECUs in the vehicle, installed software and update campaign resolution.

> 一个UCM主机接收车辆包，并传输或流式传输软件包给UCM下属，以进行AUTOSAR自适应平台软件集群的更新。车辆包包含用于编排ECU之间更新的指令。UCM主机提供有关车辆中的ECU、已安装的软件和更新活动解决方案的信息。


**[SWS_UCM_01003] UCM Master checks states of UCM subordinates** [A UCM Master shall check the status of its UCM subordinates are all at kIdle CurrentStatus state before starting a campaign.*♩(RS_UCM_00043)*

> [SWS_UCM_01003] UCM 主控制器检查UCM下级的状态
在启动一个活动之前，UCM主控制器应检查其UCM下级的状态是否都处于kIdle CurrentStatus状态。(RS_UCM_00043)


UCM Master should for instance make sure that there is no ongoing diagnostic updates before starting an update campaign by checking the reported state(s) of the UCM subordinate(s) to be idle.

> UCM主节点应该在开始更新活动之前，通过检查UCM从属节点的报告状态是否处于空闲状态，确保没有正在进行的诊断更新。

### UCM identification


For UCM Master to distribute Software Packages to other UCM subordinates, UCM Master has to identify UCM subordinates in vehicle. This identification could be at boot or later but at least before any communication with Backend are engaged. Each UCM has a unique identifier in Vehicle Package UcmModuleInstantiation called identifier to help UCM Master transferring packages to targeted UCMs. To get such identifier, UCM Master will perform first a service discovery through ara::com to get all UCMs service instances available. Then UCM Master will call GetId method for each UCM subordinates returning each corresponding UcmModuleInstantiation identifiers.

> 对于UCM主机来说，为了将软件包分发给其他UCM子机，必须首先在车辆中识别出UCM子机。这种识别可以在引导时进行，也可以在与后端建立连接之前进行。每个UCM都在车辆包UcmModuleInstantiation中具有唯一的标识符，以帮助UCM主机将包传送到目标UCM。要获取这样的标识符，UCM主机将首先通过ara :: com执行服务发现，以获取所有可用的UCM服务实例。然后，UCM主机将为每个UCM子机调用GetId方法，返回每个相应的UcmModuleInstantiation标识符。


If an ECU hosting UCM subordinate is replaced physically, it will register its services to the registry at boot up and UCM Master will be able to communicate with UCM subordinate(s).

> 如果物理上更换了托管UCM的ECU，它将在引导时注册其服务到注册表，UCM主机将能够与UCM下属（s）通信。


**[SWS_UCM_01005] UCM Master is discovering UCMs in vehicle** [UCM Master shall continuously look for UCM service instances (use of StartFindService() call).*♩ (RS_UCM_00036)*

> [SWS_UCM_01005] UCM 主机正在搜索车辆中的UCM（UCM 主机应持续寻找UCM服务实例（使用StartFindService（）调用）。(RS_UCM_00036)


If a UCM Master is failing, another inactive UCM Master could be used or activated by OTA Client.

> 如果UCM主机出现故障，可以使用或通过OTA客户端激活另一个处于非活动状态的UCM主机。


Default (at boot) Master/Subordinate hierarchy or priority could be optionally overwritten for each campaign based on Vehicle Package content at the condition OTA Client could properly parse Vehicle Packages.

> 默认（引导时）主/从层级或优先级可以根据车辆包内容在OTA客户端能够正确解析车辆包的情况下被选择性地覆盖每个活动。

### UCM Master Software Packages transfer or streaming


UCM Master has generally same transfer API as UCM in order to simplify implementation and reuse code as much as possible (could be shared library between UCM and UCM Master).

> 为了尽可能简化实现和重用代码，UCM Master通常具有与UCM相同的传输API（可以在UCM和UCM Master之间共享库）。


It is necessary to distinguish Vehicle Package (UCM Master specific) from Software Packages transfer.

> 需要区分车辆包（UCM主特定）和软件包传输。


**[SWS_UCM_01011] TransferVehiclePackage InsufficientMemory** [TransferVehiclePackage method shall raise the ApplicationError InsufficientMemory if the UCM buffer has not enough resources to process the corresponding Vehicle Package.*♩(RS_UCM_00013)*

> **[SWS_UCM_01011] TransferVehiclePackage 内存不足**[TransferVehiclePackage 方法如果UCM缓冲区没有足够的资源来处理相应的车辆包，则会引发ApplicationError InsufficientMemory。*♩(RS_UCM_00013)*


**[SWS_UCM_01018]**{DRAFT} **TransferVehiclePackage BusyWithCampaign** [ TransferVehiclePackage method shall return the ApplicationError BusyWithCampaign, if the OTA Client wants to start a new campaign, while a campaign is already started and active.*♩(RS_UCM_00035)*

> **[SWS_UCM_01018]**{草案} **TransferVehiclePackage 正忙于活动** [如果OTA客户端想要启动新的活动，而已经有一个活动正在启动和活跃时，TransferVehiclePackage方法应该返回ApplicationError BusyWithCampaign。*♩(RS_UCM_00035)*


**[SWS_UCM_01014] Packages transferring sequence** [TransferStart method shall raise the ApplicationError UnexpectedPackage if the Software Package name parameter was not a value of the RequestedPackage field.*♩(RS_UCM\_00043)*

> **[SWS_UCM_01014] 包传输序列**[TransferStart 方法如果软件包名称参数不是RequestedPackage字段的值，则会引发ApplicationError UnexpectedPackage。*♩(RS_UCM\_00043)*


**[SWS_UCM_01013] Too big block size received by UCM Master** [In the case the received block size with TransferData exceeds the block size returned by TransferStart or TransferVehiclePackage for the same TransferId, UCM Master shall raise the ApplicationError IncorrectBlockSize.*♩(RS_UCM_00035)*

> [SWS_UCM_01013] UCM 主机收到的块大小过大。在收到的TransferData块大小超过与同一TransferId相关联的TransferStart或TransferVehiclePackage返回的块大小时，UCM 主机应该抛出ApplicationError IncorrectBlockSize (RS_UCM_00035)。


**[SWS_UCM_01015] Invalid Vehicle Package manifest** [TransferExit shall raise the ApplicationError InvalidPackageManifest when a Vehicle Package manifest is not compliant with the AUTOSAR schema.*♩(RS_UCM_00036, RS_UCM\_00043)*

> **[SWS_UCM_01015] 无效的车辆包清单** [TransferExit 应当在车辆包清单不符合 AUTOSAR 架构时抛出 ApplicationError InvalidPackageManifest。*♩(RS_UCM_00036, RS_UCM\_00043)*


**[SWS_UCM_01016] Invalid Package Manifest** [UCM Master shall raise the ApplicationError InvalidPackageManifest in case a manifest file is not compliant with the AUTOSAR schema.*♩(RS_UCM_00036, RS_UCM_00043)*

> **[SWS_UCM_01016] 无效的包清单** [UCM 主机在清单文件不符合 AUTOSAR 架构时，应引发 ApplicationError InvalidPackageManifest。*♩(RS_UCM_00036, RS_UCM_00043)*


**[SWS_UCM_01017] RequestedPackage field** [The field RequestedPackage shall contain the requested Software Package name and version as configured in campaign which is modelled by VehiclePackage.*♩(RS_UCM_00042)*

> [SWS_UCM_01017] RequestedPackage字段：[RequestedPackage字段应包含由VehiclePackage建模的活动中配置的所请求的软件包名称和版本。*♩(RS_UCM_00042)*


OTA Client does not know what Software Packages should be transferred in a given campaign contained in a Vehicle Package. OTA Client can know what Software Package is expected to be transferred by subscribing to UCM Master's RequestedPackage field. Version is added to support campaigns which need an update path for a Software Package requiring an intermediate update to a transitional version. In this case the version parameter makes it unambiguous which package version shall be transferred as both have the same name assigned.

> OTA客户端不知道在给定的车辆包中应该传输哪些软件包。OTA客户端可以通过订阅UCM Master的RequestedPackage字段来知道预期要传输的软件包。版本被添加以支持需要中间更新到过渡版本的软件包的活动。在这种情况下，版本参数使得明确应该传输哪个版本的包更加清晰，因为它们都有相同的名称。


When UCM Master or OTA Client calls TransferData method and it raises ApplicationError BlockInconsistent, UCM Master or OTA Client can retry the TransferData method again later for the same block. This behaviour is configured by UcmRetryStrategy.

> 当UCM Master或OTA Client调用TransferData方法并引发ApplicationError BlockInconsistent时，UCM Master或OTA Client可以稍后再次尝试同一块的TransferData方法。此行为由UcmRetryStrategy配置。


**[SWS_UCM_01020]**{DRAFT} **Retry Strategy for BlockInconsistent** [When TransferData returns ApplicationError BlockInconsistent more than maximumNumberOfRetries within retryIntervalTime, then UCM Master shall cancel the active campaign by transitioning to kCancelling state and delete the failing package.*♩(RS_UCM_00012)*

> **[SWS_UCM_01020]**{草稿} **块不一致的重试策略** [当TransferData返回的ApplicationError BlockInconsistent超过maximumNumberOfRetries在retryIntervalTime之内，UCM主机应通过转换到kCancelling状态取消活动活动，并删除失败的包裹。*♩（RS_UCM_00012）*


If no retry strategy is needed, the maximum number of attempts can be specified as 0 in UcmRetryStrategy.

> 如果不需要重试策略，可以在UcmRetryStrategy中指定最大尝试次数为0。

### Adaptive Applications interacting with UCM Master


In order to have interoperability between several vendors platforms, Adaptive Applications interacting with UCM Master via ara::com like OTA Client, Vehicle

> 为了在几个供应商平台之间实现互操作性，通过ara :: com（如OTA客户端和车辆）与UCM Master交互的自适应应用程序。


State Manager or Vehicle Driver Interface have their APIs specified. However, their detailed behaviours are out of scope for this specification document.

> 状态管理器或车辆驱动程序界面的API已经被指定。然而，它们的详细行为不在本规范文档的范围之内。

### OTA Client


OTA Client is an Adaptive Application that sets communication channel between Backend and UCM Master. The communication between Backend and OTA Client is abstracted and details like protocol are out of scope for this specification document. OTA Client should make sure Backend is providing the right information and packages to the vehicle by identifying the vehicle, by for instance sending VIN to Backend.

> OTA客户端是一个自适应应用程序，它在后端和UCM主机之间建立通信通道。后端和OTA客户端之间的通信被抽象化，协议等细节不在本规范文档的范围之内。OTA客户端应该通过识别车辆（例如发送VIN给后端）确保后端向车辆提供正确的信息和包裹。


OTA Client uses the UCM Master as a service provider via ara::com. Since transferring Vehicle Packages and Software Packages from Backend to UCM Master is OTA Client's responsibility, OTA Client should be able to accommodate any proprietary communication protocol used between OTA Client and Backend and convert it into ara::com transport protocol. OTA Client should support UCM Master Software Packages transfer or streaming as specified in chapter [7.2.5](#ucm-master-software-packages-transfer-or-streaming), it should then provide at least the following functionality:

> OTA客户端通过ara :: com使UCM主机作为服务提供商。由于OTA客户端负责将车辆包和软件包从后端传输到UCM主机，因此OTA客户端应能够容纳OTA客户端和后端之间使用的任何专有通信协议，并将其转换为ara :: com传输协议。OTA客户端应支持UCM主机软件包传输或流式传输，如第7.2.5节所述，然后提供至少以下功能：


- Comply to the requirements of chapter [7.1.3](#transferring-software-packages) in the context of package transfer between OTA Client and UCM Master.

> 遵守第7.1.3章节中OTA客户端和UCM主机之间的软件包传输的要求。

- OTA Client should subscribe to UCM Master's RequestedPackage field to know what Software Package is expected to be transferred

> OTA客户端应订阅UCM主机的RequestedPackage字段，以知道预期传输的软件包。
- OTA Client should subscribe to UCM Master's TransferState field to know what is campaign state

- OTA Client should subscribe to UCM Master's SafetyState field to eventually make sure vehicle is in a safe state before transferring Packages

> OTA客户端应该订阅UCM主机的安全状态字段，以确保在传输包之前车辆处于安全状态。

- OTA Client could support multiple data transfers in parallel, as specified in [[SWS_UCM_00075](#_bookmark42)]

> 客户端OTA可以支持按照[[SWS_UCM_00075](#_bookmark42)]中指定的多种数据传输同时进行。


In addition, OTA Client could support the ability to pause or resume the package transfer for the current campaign to prioritize the transfer of the packages from a different campaign. The ability of OTA Client to pause or resume the package transfer might be helpful in the case there is a need to cancel an ongoing campaign at kTransferring state to allow higher priority campaign to be performed.

> 此外，OTA客户端可以支持暂停或恢复当前活动的包裹传输的能力，以优先传输来自不同活动的包裹。OTA客户端暂停或恢复包裹传输的能力可能在有需要取消正在进行的活动时很有帮助，以允许更高优先级的活动执行。


Only one UCM Master has to be used by OTA Clients per network domain. As UCM Master is distributing Software Packages and coordinating UCM subordinates, OTA Clients in the same network domain have to make sure there are no already on-going campaigns when starting a new campaign with TransferVehiclePackage method call by checking UCM Master's state with TransferState field, in order to avoid any interference and guarantee success of an update campaign.

> 只有一个UCM主机可以被OTA客户端在同一网络域中使用。由于UCM主机正在分发软件包并协调UCM下属，因此同一网络域中的OTA客户端在使用TransferVehiclePackage方法调用启动新的活动时，必须通过检查UCM主机的状态（使用TransferState字段）来确保没有已经正在进行的活动，以避免任何干扰并保证更新活动的成功。


**[SWS_UCM_01101] Provide information of installed Software Clusters in vehicle** [UCM Master shall provide a method GetSwClusterInfo to return information of all Software Cluster that are in state kPresent.*♩(RS_UCM_00033)*

> **[SWS_UCM_01101] 提供车辆安装的软件集群的信息** [UCM Master应提供一个名为GetSwClusterInfo的方法来返回所有处于kPresent状态的软件集群的信息。*♩(RS_UCM_00033)*


UCM Master can aggregate Software Cluster information from several UCMs within a vehicle and returns the result to a Backend which can compute if there is any new Software Cluster available and decide to send to UCM Master through OTA Client a Vehicle Package. It is up to OTA Client to make sure the synchronisation of the versions of Software Packages present in Backend and Software Clusters in the vehicles using GetSwClusterInfo or SwPackageInventory is recent enough before starting a campaign with TransferVehiclePackage call.

> UCM Master可以从车辆内的几个UCM聚合软件集群信息，并将结果返回给后端，以便后端可以计算是否有新的软件集群可用，并决定通过OTA Client向UCM Master发送车辆包。在使用GetSwClusterInfo或SwPackageInventory开始活动之前，由OTA Client确保后端和车辆中的软件包的版本同步是最新的。


**[SWS_UCM_01103] Inform Backend of needed Software Packages for an update** [On SwPackageInventory call, UCM Master shall compare the supplied list of available Software Packages in the Backend for the vehicle to its own internal information of present Software Clusters in the vehicle and return the list of Software Packages selected for update.*♩(RS_UCM_00033)*

> [SWS_UCM_01103] 告知后端需要更新的软件包。在SwPackageInventory调用时，UCM主机将比较车辆后端提供的可用软件包列表与其自身内部车辆现有软件集群的信息，并返回选择更新的软件包列表。*♩(RS_UCM_00033)*


The OTA Client uses this returned Software Packages list to request the selected packages to the Backend. As required by constraint [[SWS_UCM_CONSTR_00014](#_bookmark36)], each Software Cluster corresponds to one Software Package and share the same shortName.

> OTA客户端使用返回的软件包列表请求后端选定的包。根据约束[[SWS_UCM_CONSTR_00014](#_bookmark36)]的要求，每个软件集对应一个软件包，并共享相同的短名称。


**[SWS_UCM_CONSTR_00016]**{DRAFT} **OTA Client use of RequestedPackage field** [When UCM Master updates the RequestedPackage field, the OTA Client shall start the transfer of the requested Software Package.*♩(RS_UCM_00042)*

> **[SWS_UCM_CONSTR_00016]**{草案} **OTA 客户端使用 RequestedPackage 字段** [当 UCM Master 更新 RequestedPackage 字段时，OTA 客户端应开始传输所请求的软件包。*♩（RS_UCM_00042）*


**[SWS_UCM_01119]**{OBSOLETE} **Report information of Software Packages** [ UCM Master shall provide a method GetSwPackages to return the identifiers, names, versions, Consecutive Bytes Received, Consecutive Blocks Received and states of Software Packages.*♩(RS_UCM_00035)*

> **[SWS_UCM_01119]**{过时的} **报告软件包信息** [UCM Master应提供一个GetSwPackages方法来返回软件包的标识符、名称、版本、连续接收字节数、连续接收块数和状态。*♩(RS_UCM_00035)*


At the invocation of method GetSwPackages, UCM Master returns the identifiers, names, versions, Consecutive Bytes Received, Consecutive Blocks Received and states of Software Packages.

> 在调用GetSwPackages方法时，UCM Master返回软件包的标识符、名称、版本、连续接收的字节数、连续接收的块数和状态。

### Vehicle Driver Interface


Vehicle driver interface could be required by legal constrains or communication cost consideration. To support mandatory safety and security critical updates, driver interaction can be used for:

> 依法要求或考虑通信成本，可能需要车辆驾驶员界面。为了支持强制性的安全和安全关键更新，可以使用驾驶员交互：

- Requesting transfer, processing or activation permission from vehicle driver

- Notifying vehicle driver of safety and security measures he has to apply to the vehicle in order to proceed to next step into the update campaign

> 通知车辆司机应采取的安全和安全措施，以便进行下一步更新活动。


**[SWS_UCM_01105]**{OBSOLETE} **Interaction of UCM Master with Vehicle Driver** [ UCM Master shall provide a method DriverApproval in order to receive the confirmation of the vehicle driver's approval.*♩(RS_UCM_00038)*

> **[SWS_UCM_01105]**{已过时} **UCM主机与车辆司机的交互** [UCM主机应提供一种DriverApproval方法以接收车辆司机的确认。*♩(RS_UCM_00038)*


**[SWS_UCM_CONSTR_00017]**{DRAFT} **Interaction of UCM Master with Vehicle Driver** [When vehicle driver accepts or denies the campaign, Vehicle Driver Application shall call DriverApproval method of VehicleDriverApplicationInterface to inform UCM Master of the vehicle driver's decision.*♩(RS_UCM_00038)*

> **[SWS_UCM_CONSTR_00017]**{草稿} **车辆司机与UCM主机的交互** [当车辆司机接受或拒绝活动时，车辆司机应用程序应调用VehicleDriverApplicationInterface的DriverApproval方法，以向UCM主机通知车辆司机的决定。*♩(RS_UCM_00038)*


The Vehicle Driver Interface Adaptive Application could adapt its notification content related to safety by subscribing to the UCM Master's SafetyConditions field.

> 车辆驾驶员界面自适应应用可以通过订阅UCM主机的SafetyConditions字段来调整其与安全相关的通知内容。


**[SWS_UCM_01117]**{DRAFT} **UCM Master SafetyState field** [UCM Master shall provide to vehicle driver interface the SafetyConditions field containing the required safety condition for the campaign as configured in safetyCondition.*♩(RS\_UCM_00038, RS_UCM_00037)*

> **[SWS_UCM_01117]**{草案}**UCM主安全状态字段**[UCM主机必须提供给车辆驾驶员界面SafetyConditions字段，其中包含根据RS_UCM_00038和RS_UCM_00037配置的活动所需的安全条件。


UCM Master can notify vehicle driver with SafetyState field if the vehicle safety is breached during the update, by for instance popping-up a message.

> UCM Master可以在更新期间通过SafetyState字段向车辆司机发出安全警告，例如弹出一条消息。


**[SWS_UCM_01118] UCM Master waiting for vehicle driver approval** [In the case approval from driver is requested as configured in VehiclePackage, UCM Master shall wait for DriverApproval method with parameter Approval=True before transitioning state from kVehiclePackageTransferring to kSoftwarePackage\_Transferring, kSoftwarePackage_Transferring to kProcessing or kProcessing to kActivating.*♩(RS_UCM_00038)*

> [SWS_UCM_01118] 如果根据车辆包的配置要求，UCM Master 将等待驾驶员审批，在从 kVehiclePackageTransferring 状态转换到 kSoftwarePackage_Transferring，或从 kSoftwarePackage_Transferring 状态转换到 kProcessing 或从 kProcessing 状态转换到 kActivating 之前，必须等待 DriverApproval 方法，参数 Approval 为 True。♩(RS_UCM_00038)


**[SWS_UCM_CONSTR_00003] Exclusive use of Vehicle Driver Interface** [Software Integrator shall ensure that only one Adaptive Application is using the UCM Master's Vehicle Driver Interface.*♩(RS_UCM_00035, RS_UCM_00037)*

> 软件集成商应确保只有一个自适应应用程序使用UCM主机的车辆驾驶员接口（RS_UCM_00035，RS_UCM_00037）。


For example, the integrator may restrict the access of Vehicle Driver Interface from UCM Master by configuring the Identity and Access Management functional cluster accordingly.

> 例如，集成器可以通过相应地配置身份和访问管理功能群来限制UCM主机对车辆驾驶员界面的访问。


**[SWS_UCM_CONSTR_00004] Unsupported safety by Vehicle driver interface** [In the case the Vehicle Driver Interface Adaptive Application does not support at least one safety condition contained in the SafetyConditions field, the Vehicle Driver Interface Adaptive Application shall call the method ReportUnsupportedSafetyConditions with parameter UnsupportedSafetyConditions containing all the safety conditions which are not supported by Vehicle Driver Interface Adaptive Application.*♩(RS_UCM_00037)*

> [SWS_UCM_CONSTR_00004] 车辆驾驶员界面不支持安全性：如果车辆驾驶员界面自适应应用程序不支持SafetyConditions字段中至少一个安全条件，车辆驾驶员界面自适应应用程序应调用ReportUnsupportedSafetyConditions方法，其参数UnsupportedSafetyConditions包含车辆驾驶员界面自适应应用程序不支持的所有安全条件。♩（RS_UCM_00037）


**[SWS_UCM_01120] Provide Software Packages general information** [UCM Master shall provide a method GetSwPackageDescription to return the description of each Software Packages that are part of current campaign and that are contained in Vehicle Package.*♩(RS_UCM_00033, RS_UCM_00038)*

> **[SWS_UCM_01120] 提供软件包的一般信息** [UCM 主机应提供一种 GetSwPackageDescription 方法，用于返回当前活动中包含在车辆包中的每个软件包的描述。*♩(RS_UCM_00033, RS_UCM_00038)*


**[SWS_UCM_01135] Get Software Clusters descriptions from a vehicle** [At GetSwClusterDescription method call via VehicleDriverApplicationInterface interface, UCM Master shall return the descriptions of all Software Clusters which are aggregated from all the UCM Subordinates and all Flashing Adapters.*♩ (RS_UCM_00033, RS_UCM_00038)*

> [SWS_UCM_01135] 从车辆中获取软件集群描述。通过VehicleDriverApplicationInterface接口调用GetSwClusterDescription方法时，UCM Master应该返回所有软件集群的描述，这些软件集群是由所有UCM Subordinates和所有闪存适配器聚合而成的。（RS_UCM_00033，RS_UCM_00038）

### Vehicle State Manager


Vehicle State Manager is collecting states from the several vehicle ECUs and informs UCM Master when the safety state computed based on the safety policy referred in the Vehicle Package is changing. If the safety policy is not met, the UCM Master can for instance decide to:

> 车辆状态管理器正在从几个车辆ECU收集状态，并在根据车辆包中引用的安全策略计算出的安全状态发生变化时通知UCM主控制器。如果不符合安全策略，UCM主控制器可以决定：

- Inform vehicle driver that the safety conditions are not met to continue the update
- postpone, pause or cancel the update until policy is met


**[SWS_UCM_01109]**{DRAFT} **UCM Master provides a safety interface** [UCM Master shall set the SafetyConditions field taking the value from safetyCondition attribute for each VehicleRolloutStep of the VehiclePackage.*♩(RS\_UCM_00037)*

> UCM Master提供一个安全接口。UCM Master应该根据每个车辆包装的VehicleRolloutStep的safetyCondition属性，设置SafetyConditions字段。


Vehicle State Manager Adaptive Application can inform any vehicle state changes by calling PublishSafetyState method.

> 车辆状态管理自适应应用可以通过调用PublishSafetyState方法来通知任何车辆状态的变化。


**[SWS_UCM_CONSTR_00005]**{DRAFT} **Safety state change** [Vehicle State Manager Adaptive Application shall call PublishSafetyState method provided by UCM Master when the safety state is changing.*♩(RS_UCM_00035, RS_UCM_00037)*

> [SWS_UCM_CONSTR_00005]{草案} **安全状态变更** [车辆状态管理自适应应用程序在安全状态变更时应调用UCM Master提供的PublishSafetyState方法。*♩(RS_UCM_00035，RS_UCM_00037)*


**[SWS_UCM_CONSTR_00009]**{DRAFT} **Safety condition change** [Vehicle State Manager Adaptive Application shall call PublishSafetyState method provided by UCM Master when the field SafetyConditions is changing value.*♩(RS_UCM\_00035, RS_UCM_00037)*

> **[SWS_UCM_CONSTR_00009]**{草案} **安全状态变更** [当安全条件字段发生变化时，车辆状态管理自适应应用程序应调用UCM Master提供的PublishSafetyState方法。*♩(RS_UCM\_00035, RS_UCM_00037)*


**[SWS_UCM_CONSTR_00015]**{DRAFT} **Trigger on kVehicleChecking state** [On transition to kVehicleChecking state provided by CampaignState from VehicleStateManagerInterface, Vehicle State Manager shall first perform checks to assess the post-activation state of the vehicle.*♩(RS_UCM_00035)*

> **[SWS_UCM_CONSTR_00015]**{草案} **在 kVehicleChecking 状态触发** [当从 VehicleStateManagerInterface 提供的 CampaignState 转换到 kVehicleChecking 状态时，车辆状态管理器首先必须执行检查以评估车辆的激活后状态。*♩(RS_UCM_00035)*


Vehicle State Manager could be responsible for performing post-activation checks, interfacing with an application performing such checks, confirming backend is still reachable and further updates are still possible.

> 车辆状态管理器可以负责执行激活后的检查，与执行此类检查的应用程序进行接口，确认后端仍然可以访问，并且仍然可以进行进一步的更新。


**[SWS_UCM_01272]**{DRAFT} **VehicleCheck call not permitted** [UCM Master shall return ApplicationError OperationNotPermitted if VehicleCheck method is called in another UCM Master state than kVehicleChecking.*♩(RS_UCM_00035)*

> **[SWS_UCM_01272]**{草案} **车辆检查调用不允许** [如果在另一个UCM Master状态（而不是kVehicleChecking）中调用VehicleCheck方法，UCM Master应返回ApplicationError OperationNotPermitted。*♩(RS_UCM_00035)*


**[SWS_UCM_CONSTR_00006]**{DRAFT} **Exclusive use of Vehicle State Manager** [System Integrator shall ensure that Vehicle State Manager is the exclusive user of the PublishSafetyState method.*♩(RS_UCM_00035, RS_UCM_00037)*

> **[SWS_UCM_CONSTR_00006]**{草案} **车辆状态管理器的专用使用** [系统集成商应确保车辆状态管理器是PublishSafetyState方法的专用用户。*♩(RS_UCM_00035，RS_UCM_00037)*


For example, the integrator may restrict the access to Vehicle State Manager in configuring the Identity and Access Management functional cluster accordingly.

> 例如，集成器可以通过相应地配置身份和访问管理功能集群来限制对车辆状态管理器的访问。


**[SWS_UCM_01275]**{DRAFT} **Safety conditions during activation** [UCM Master shall apply the safetyCondition of the last VehicleRolloutStep to SafetyConditions field during the ECUs activations as configured in the VehiclePackage*♩(RS_UCM_00043, RS_UCM_00037)*

> **[SWS_UCM_01275]**{草案} **激活期间的安全条件** [UCM Master 在 ECU 激活期间，根据 VehiclePackage*♩(RS_UCM_00043, RS_UCM_00037)* 中的配置，将上一个 VehicleRolloutStep 的 safetyCondition 应用于 SafetyConditions 字段。


**[SWS_UCM_CONSTR_00007]**{DRAFT} **Unsupported safety conditions by Vehicle State Manager** [In the case the requested SafetyConditions field is not referring to an existing safety condition implemented by Vehicle State Manager, the Vehicle State Manager shall call VehicleStateManagerInterface service interface PublishSafetyState method with parameter SafetyStates containing at least one value equal to 'NotSupported'.*♩(RS_UCM_00037)*

> **[SWS_UCM_CONSTR_00007]**{草案} **车辆状态管理器不支持的安全条件** [如果所请求的SafetyConditions字段不指向由车辆状态管理器实现的现有安全条件，车辆状态管理器应使用参数SafetyStates调用VehicleStateManagerInterface服务接口PublishSafetyState方法，其中至少一个值等于“NotSupported”。*♩(RS_UCM_00037)*

简体中文：**[SWS_UCM_CONSTR_00007]**{草案} **车辆状态管理器不支持的安全条件** [如果所请求的SafetyConditions字段不指向由车辆状态管理器实现的现有安全条件，车辆状态管理器应使用参数SafetyStates调用VehicleStateManagerInterface服务接口PublishSafetyState方法，其中至少一个值等于“NotSupported”。*♩(RS_UCM_00037)*


**[SWS_UCM_CONSTR_00008]**{DRAFT} **Switching vehicle into update mode** [Vehicle State Manager shall change vehicle's state and its ECUs in the right update mode in order to avoid any timeout issues during update.*♩(RS_UCM_00037)*

> [SWS_UCM_CONSTR_00008]{草稿}切换车辆到更新模式[车辆状态管理器应该改变车辆的状态及其ECU到正确的更新模式，以避免更新期间出现超时问题。*♩(RS_UCM_00037)*


This vehicle state change could be triggered based on UCM Master State Machine.

> 这种车辆状态变化可以基于UCM主状态机触发。

### Flashing Adapter


Flashing Adapter is an application that is used in the case UCM Master is updating a AUTOSAR Classic Platform or any platform that can be flashed using diagnostic. It contains OEM specific diagnostic sequences and communicates via ara::com with the UCM Master and the AUTOSAR Adaptive Platform, and uses an implementation of diagnostic protocol data unit application programming interface (D-PDU API) to communicate with Classic ECUs over the Vehicle Bus.

> 通用编程模型（UCM）主机更新AUTOSAR经典平台或任何可以使用诊断进行烧录的平台时，闪存适配器是一个应用程序。它包含原始设备制造商特定的诊断序列，并通过ara :: com与UCM主机和AUTOSAR自适应平台进行通信，并使用诊断协议数据单元应用程序编程接口（D-PDU API）的实现来通过车辆总线与经典ECU进行通信。


The data transfer from Flashing Adapter to the target ECU via diagnostic communication can be subject to interruptions if communication on a higher priority protocol occurs, e.g. OBD services. In that case the Flashing Adapter can use a project specific strategy to detect the interruption, retry the transfer from the beginning, and decide whether to notify or not the client about the transfer interruption.

> 数据从闪存适配器传输到目标ECU通过诊断通信可能会因为更高优先级协议的通信而中断，例如OBD服务。在这种情况下，闪存适配器可以使用项目特定的策略来检测中断，重新从头开始传输，并决定是否通知客户端传输中断。


**[SWS_UCM_CONSTR_00011]**{DRAFT} **Flashing Adapter provided interface** [Flashing Adapter shall provide the same ara::com service interface as UCM ([SWS_UCM_00131]).*♩(RS_UCM_00035)*

> **[SWS_UCM_CONSTR_00011]**{草稿} **闪烁适配器提供的接口** [闪烁适配器应提供与UCM（[SWS_UCM_00131]）相同的ara :: com服务接口。*♩（RS_UCM_00035）*

### Non Adaptive Platform update


**[SWS_UCM_01121]**{DRAFT} **Adaptive Platform interface provided for Flashing Adapter** [The interface provided by the AUTOSAR Adaptive Platform in order to update non AUTOSAR Platform should comply with ISO 22900-2:2017 (D-PDU API) but as this standard's coverage is wide, it is allowed to implement a reduced API that is needed to update for instance a AUTOSAR Classic Platform.*♩(RS_UCM_00035)*

> **[SWS_UCM_01121]**{草案}**适配平台接口为闪存适配器提供**[AUTOSAR适配平台提供的接口，以更新非AUTOSAR平台应符合ISO 22900-2:2017（D-PDU API），但由于该标准的覆盖范围较广，允许实施所需的减少API，以更新例如AUTOSAR经典平台。*♩(RS_UCM_00035)*


The implementation of the D-PDU API is processing binary data from the Flashing Adapter and do all of the required session, transport and network layer handling to send and receive the data on the physical vehicle bus with respect to the underlying protocols. The reason of using ISO 22900-2:2017 is to ensure that the specific Flashing Adapter from any vehicle or tool manufacturer can operate on a common software interface and can easily exchange MVCI (Modular Vehicle Communication Interface) protocol module implementations.

> 实现D-PDU API正在处理来自闪存适配器的二进制数据，并根据底层协议执行所有必要的会话、传输和网络层处理，以在物理车辆总线上发送和接收数据。使用ISO 22900-2:2017的原因是确保任何车辆或工具制造商的特定闪存适配器可以在公共软件接口上运行，并可以轻松交换MVCI（模块化车辆通信接口）协议模块实现。


In the case the targeted ECU by an update does not have the capability to switch between current and new Software Cluster, the vehicle package campaign should foresee to download not only the new version but also the currently installed version of the Software Cluster to be updated in order to make possible a rollback from the new version to the old version of the Software Cluster. The location to store the current Software Package could be the Flashing Adapter but ultimately it has to be available to Flashing Adapter in order to flash it in case of a rollback.

> 如果更新的目标ECU没有切换当前和新软件集群的能力，车辆套件运动应预先下载不仅新版本，而且要更新的当前安装的软件集群的版本，以便可以从新版本回滚到旧版本的软件集群。存储当前软件包的位置可以是闪存适配器，但最终必须可以提供给闪存适配器，以便在回滚时进行闪存。

### D-PDU API implementation support


**[SWS_UCM_01122]**{DRAFT} **Supported physical layers by D-PDU API implementation** [ISO_11898_2\_DWCAN (Dual Wire CAN), ISO_11898_3\_DWFTCAN (Dual Wire CAN Fault tolerant), SAE_J2411_SWCAN (Single Wire CAN) and IEEE_802_3(Ethernet) physical layers shall be supported if their respective physical vehicle bus is available inside the ECU, all other physical layers present in D-PDU API are optional.*♩(RS_UCM_00035)*

> **[SWS_UCM_01122]**{草案} **D-PDU API实施支持的物理层** [ISO_11898_2\_DWCAN（双线CAN）、ISO_11898_3\_DWFTCAN（双线CAN容错）、SAE_J2411_SWCAN（单线CAN）和IEEE_802_3（以太网）物理层如果ECU内部有相应的车辆总线可用，则应支持，D-PDU API中的其他物理层是可选的。*♩（RS_UCM_00035）*


**[SWS_UCM_01123]**{DRAFT} **Supported application layers by D-PDU API implementation** [ISO_15765_3 (Unified diagnostic services, UDS on CAN, ISO withdrawn UDS), ISO_14229_3 (Unified diagnostic services on CAN implementation, UDSonCAN) and ISO_14229_5 (Unified diagnostic services on Internet Protocol implementation, UDSonIP) application layers shall be supported if their respective application layer is available inside the ECU, all other application layers present in D-PDU API are optional.*♩(RS_UCM_00035)*

> **[SWS_UCM_01123]**{草案} **D-PDU API实现支持的应用层** [ISO_15765_3（CAN上的统一诊断服务，ISO撤回的UDS），ISO_14229_3（CAN实现的统一诊断服务，UDSonCAN）和ISO_14229_5（Internet协议实现的统一诊断服务，UDSonIP）应用层将在ECU内部可用时被支持，D-PDU API中的其他所有应用层都是可选的。*♩(RS_UCM_00035)*


**[SWS_UCM_01124]**{DRAFT} **Supported protocols by D-PDU API implementation** [ISO UDS on CAN with Application layer ISO_15765_3, ISO UDS on CAN with Application layer ISO_14229_3 (UDSonCAN) and ISO UDS on DoIP with Application layer ISO_14229_5 (UDSonIP) protocols shall be supported, all other protocols are optional.*♩(RS_UCM_00035)*

> **[SWS_UCM_01124]**{草案} **D-PDU API实现支持的协议** [具有应用层ISO_15765_3的CAN上的ISO UDS，具有应用层ISO_14229_3（UDSonCAN）的CAN上的ISO UDS以及具有应用层ISO_14229_5（UDSonIP）的DoIP上的ISO UDS协议必须支持，其他协议均为可选项。*♩(RS_UCM_00035)*


These protocols are present in 'Table B.2 Standard protocol combination list' of ISO 22900-2:2017(E).

> 这些协议出现在ISO 22900-2:2017(E)的“表B.2 标准协议组合列表”中。

### Not required D-PDU API concepts


Dynamic Link Libraries for Windows operating system are not required. The Windows installation process out of ISO 22900-2:2017(E) chapter 8.7.2 is not applicable to the AUTOSAR Adaptive Platform which is using POSIX Operating System.

> 在Windows操作系统中不需要动态链接库。ISO 22900-2:2017(E)第8.7.2章节中的Windows安装过程不适用于使用POSIX操作系统的AUTOSAR Adaptive Platform。


**[SWS_UCM_01125]**{DRAFT} **Separation of D-PDU API-Software with the MVCI protocol module firmware** [A D-PDU API implementation may be split at OSI-Layer 4 into a D-PDU API implementation on OSI-Layer 5 (usually in the PC itself) and the VCI-Module on OSI-Layers 3 and 4 (usually the VCI itself).*♩(RS_UCM_00035)*

> **[SWS_UCM_01125]**{草案} 将D-PDU API软件与MVCI协议模块固件分离[D-PDU API实现可以在OSI-Layer 4层上分割为OSI-Layer 5层上的D-PDU API实现（通常在PC本身）和OSI-Layers 3和4层上的VCI-Module（通常是VCI本身）。*♩（RS_UCM_00035）*


**[SWS_UCM_01126]**{DRAFT} **Root description file (RDF)** [Within an AUTOSAR Adaptive Platform, only one D-PDU API implementation is required for UCM, therefore the D-PDU API implementation may not use the D-PDU API root description file (RDF).*♩(RS_UCM_00035)*

> **[SWS_UCM_01126]**{草案} **根描述文件（RDF）**[在AUTOSAR自适应平台中，UCM只需要一个D-PDU API实现，因此D-PDU API实现不需要使用D-PDU API根描述文件（RDF）。*♩（RS_UCM_00035）*


The only instance of the D-PDU API within a Software Cluster can be statically linked with the Flashing Adapter.

> 唯一一个软件集群中的D-PDU API实例可以与闪存适配器静态链接。


**[SWS_UCM_01127]**{DRAFT} **Module Description File (MDF)** [The D-PDU API implementation should not implement a protocol description file.*♩(RS_UCM_00035)*

> **[SWS_UCM_01127]**{草案} **模块描述文件（MDF）** [D-PDU API实现不应实现协议描述文件。*♩(RS_UCM_00035)*


The supported protocol module types are fixed in the UCM use case.

> 支持的协议模块类型在UCM用例中是固定的。


**[SWS_UCM_01128]**{DRAFT} **Symbolic names and IDs** [The Flashing Adapter may operate the D-PDU API without using symbolic names and IDs during runtime. If the use case excludes frequent changes to the MDFs, simple Flashing Adapter may even hardcode (e.g. in a header file) all necessary IDs and operate the D-PDU API without symbolic names.*♩(RS_UCM_00035)*

> **[SWS_UCM_01128]**{草案} **符号名称和ID** [闪烁适配器可以在运行时不使用符号名称和ID来操作D-PDU API。如果使用场景排除了对MDF的频繁更改，简单的闪烁适配器甚至可以将所有必要的ID硬编码（例如在头文件中），并在不使用符号名称的情况下操作D-PDU API。*♩(RS_UCM_00035)*


**[SWS_UCM_01129]**{DRAFT} **SAE J2534-1 and RP 1210a compatibility** [D-PDU API implementation may not be compatible to SAE J2534-1 and RP 1210a.*♩(RS\_UCM_00035)*

> **[SWS_UCM_01129]**{草案} **SAE J2534-1和RP 1210a的兼容性** [D-PDU API实现可能不兼容SAE J2534-1和RP 1210a。*♩(RS\_UCM_00035)*


The Adaptive Platform does not need any migration path.

> 适应性平台不需要任何迁移路径。


**[SWS_UCM_01130]**{DRAFT} **ComPrimitives in RawMode** [D-PDU API implementation may not implement the IOCTL filter data structure.*♩(RS_UCM_00035)*

> **[SWS_UCM_01130]**{草稿} **原始模式中的ComPrimitives** [D-PDU API 实现可能不实现 IOCTL 过滤器数据结构*♩(RS_UCM_00035)*

### Not required D-PDU API functions


PDULockResource() and PDUUnlockResource() are used to lock and unlock exclusive access to a ComLogicalLink in case of parallel usage of the D-PDU API implementation by multiple applications on the same physical communication link. Flashing of

> PDULockResource()和PDUUnlockResource()用于锁定和解锁对同一物理通信链路上多个应用程序并行使用D-PDU API实现的ComLogicalLink的独占访问权限。闪烁


a Classic ECU always requires some exclusive access and should be handled in the

> 一台经典的ECU通常需要一些独特的访问权限，并且应该在专业人员的指导下进行处理。


AUTOSAR Adaptive Platform itself.

> AUTOSAR Adaptive平台本身。


**[SWS_UCM_01131]**{DRAFT} **PDUIoCtl(PDU_IOCTL_RESET)** [The parameter PDU_IOCTL_RESET may not be implemented in D-PDU API implementation so the call of PDUIoCtl(PDU_IOCTL_RESET) shall return the error code PDU_ERR_ID_NOT_SUPPORTED.*♩(RS_UCM_00035)*

> **[SWS_UCM_01131]**{草案} **PDUIoCtl（PDU_IOCTL_RESET）** [参数PDU_IOCTL_RESET可能不会在D-PDU API实现中实现，因此调用PDUIoCtl（PDU_IOCTL_RESET）应返回错误代码PDU_ERR_ID_NOT_SUPPORTED。*♩（RS_UCM_00035）*

### [SWS_UCM_01132] {DRAFT} PDUIoCtl(PDU_IOCTL_START_MSG_FILTER), PDUIoCtl(PDU_IOCTL_CLEAR_MSG_FILTER), PDUIoCtl(


**PDU_IOCTL_STOP_MSG_FILTER)** [The call of PDUIoCtl() with the pa-

> PDUIoCtl（）的调用，其参数为PDU_IOCTL_STOP_MSG_FILTER，用于停止消息过滤。


rameters PDU_IOCTL_START_MSG, PDU_IOCTL_CLEAR_MSG_FILTER

> PDU_IOCTL_START_MSG：启动消息
PDU_IOCTL_CLEAR_MSG_FILTER：清除消息过滤器


and PDU_IOCTL_CLEAR_MSG_FILTER shall return the error code PDU_ERR_ID_NOT_SUPPORTED.*♩(RS_UCM_00035)*

> PDU_IOCTL_CLEAR_MSG_FILTER 将返回错误代码 PDU_ERR_ID_NOT_SUPPORTED。 ♩（RS_UCM_00035）


The parameters PDU_IOCTL_START_MSG, PDU_IOCTL_CLEAR_MSG_FILTER and PDU_IOCTL_CLEAR_MSG_FILTER are intended for the PassThru-Mode for comprimitives and therefore an implementation is not required for the Flashing Adapter.

> 这些参数PDU_IOCTL_START_MSG、PDU_IOCTL_CLEAR_MSG_FILTER和PDU_IOCTL_CLEAR_MSG_FILTER是为压缩原语设计的PassThru模式而设计的，因此不需要为闪存适配器实现它们。

### [SWS_UCM_01133] {DRAFT} PDUIoCtl(PDU_IOCTL_SEND_BREAK)


[The IOCTL command PDU_IOCTL_SEND_BREAK shall return PDU_ERR_ID_NOT_SUPPORTED.*♩(RS_UCM_00035)*

> 命令PDU_IOCTL_SEND_BREAK应返回PDU_ERR_ID_NOT_SUPPORTED。♩（RS_UCM_00035）


The IOCTL command PDU_IOCTL_SEND_BREAK is used to send a break signal on the ComLogicalLink. A break signal can only be sent on certain physical layers (e.g. SAE J1850 VPW physical links and UART physical links) which are not supported by UCM.

> 命令PDU_IOCTL_SEND_BREAK用于在ComLogicalLink上发送断点信号。只有在某些物理层（例如SAE J1850 VPW物理链接和UART物理链接）上才能发送断点信号，而UCM不支持这些物理层。


**[SWS_UCM_01134]**{DRAFT} **Not used D-PDU API function return codes** [The return codes PDU_ERR_CABLE_UNKNOWN, PDU_ERR_RSC_LOCKED, PDU_ERR_RSC_NOT_LOCKED, PDU_ERR_API_SW_OUT_OF_DATE and

> **[SWS_UCM_01134]**{草案} **未使用的D-PDU API函数返回代码** [返回代码PDU_ERR_CABLE_UNKNOWN, PDU_ERR_RSC_LOCKED, PDU_ERR_RSC_NOT_LOCKED, PDU_ERR_API_SW_OUT_OF_DATE和


PDU_ERR_MODULE_FW_OUT_OF_DATE may not be implemented into the

> PDU_ERR_MODULE_FW_OUT_OF_DATE可能无法实施到


D-PDU API of the AUTOSAR Adaptive Platform.*♩(RS_UCM_00035)*

> D-PDU API，AUTOSAR自适应平台。♩（RS_UCM_00035）


There is no cable attached to the ECU and therefore no cable detection return code PDU_ERR_CABLE_UNKNOWN could occur.

> 没有接在ECU上的电缆，因此不会出现电缆检测返回代码PDU_ERR_CABLE_UNKNOWN。


Locking is not required for the Flashing Adapter, therefore PDU_ERR_RSC_LOCKED and PDU_ERR_RSC_NOT_LOCKED return code could not occur.

> 不需要锁定刷新适配器，因此不会出现PDU_ERR_RSC_LOCKED和PDU_ERR_RSC_NOT_LOCKED返回代码。


There is no separation of D-PDU API-Software with the MVCI protocol module firmware required in the AUTOSAR Adaptive Platform, so PDU_ERR_API_SW_OUT_OF_DATE and PDU_ERR_MODULE_FW_OUT_OF_DATE return codes could not occur.

> 没有AUTOSAR Adaptive Platform中MVCI协议模块固件所需的D-PDU API-Software分离，因此不会出现PDU_ERR_API_SW_OUT_OF_DATE和PDU_ERR_MODULE_FW_OUT_OF_DATE返回代码。

### Classic platform update with UCM Master and diagnostic tool

![](./media/image14.jpeg)

**Figure 7.7: Classic platform update with UCM Master and diagnostic tool**


The Diagnostic Manager connects the Diagnostic tool to the Adaptive Platform. The diagnostic application is acting like an OTA Client and uses the UCM Master services to push Vehicle Packages and Software Packages.

> 诊断管理器将诊断工具连接到自适应平台。诊断应用程序充当OTA客户端，并使用UCM主服务推送车辆包和软件包。

### Status reporting


UCM Master supports a mechanism to provide the state of an update campaign typically to OTA Client, Vehicle Driver Application and Vehicle State Manager.

> UCM Master支持一种机制，以向OTA客户端、车辆驱动程序和车辆状态管理器提供更新活动的状态。

![](./media/image25.png)

**Figure 7.8:** **Campaign State Machine (CampaignState field)**
**Figure 7.9:** **Campaign State Machine for OTA Client (TransferState field)**


Diagrams [7.8](#_bookmark123) and [7.9](#_bookmark124) do not include behaviour after reset ([[SWS_UCM_01205](#_bookmark107)] for more details)

> 图7.8和7.9不包括重置后的行为（详情请参考SWS_UCM_01205）。


**[SWS_UCM_01201] Sequential orchestration of campaigns** [UCM Master shall orchestrate at most a single campaign at any one time.*♩(RS_UCM_00043)*

> [SWS_UCM_01201] 按顺序编排活动[UCM主系统每次只能编排一个活动。*♩(RS_UCM_00043)*


**[SWS_UCM_01265] TransferState field** [UCM Master shall provide the state of a campaign over the TransferState field of the UCM Master's VehiclePackageManagement service interface.*♩(RS_UCM_00042)*

> UCM 主机应通过其VehiclePackageManagement服务接口的TransferState字段提供活动的状态（RS_UCM_00042）。


**[SWS_UCM_01203] CampaignState field** [UCM Master shall provide the state of a campaign over the CampaignState field of the UCM Master VehicleDriverApplicationInterface and VehicleStateManagerInterface.*♩(RS_UCM\_00042)* There is an overview of the campaign state machine in Fig. [7.8](#_bookmark123) detailing UCM Master campaign states and transitions.

> **[SWS_UCM_01203] 活动状态字段** [UCM Master 应通过UCM Master VehicleDriverApplicationInterface 和 VehicleStateManagerInterface 的CampaignState字段提供活动的状态。*♩（RS_UCM\_00042）* 图7.8中概述了活动状态机，详细说明了UCM Master 活动状态和转换。

### States


**[SWS_UCM_01204] Initial state** [UCM Master shall have kIdle default state.*♩(RS\_UCM_00035)*

> **[SWS_UCM_01204] 初始状态** [UCM 主机应具有kIdle默认状态。*♩(RS\_UCM_00035)*


**[SWS_UCM_01207] Trigger on kSoftwarePackage_Transferring state** [On transition to kSoftwarePackage_Transferring state and if all UCM subordinates part of the campaign are in kIdle state, UCM Master shall start or resume transferring (TransferStart and TransferData as well as TransferExit if no streaming required) the software packages to the UCM subordinates according to the campaign orchestration.*♩(RS_UCM_00035, RS_UCM_00043)*

> **[SWS_UCM_01207] 在kSoftwarePackage_Transferring状态触发**[在进入kSoftwarePackage_Transferring状态时，如果活动中的所有UCM下属都处于kIdle状态，UCM Master将根据活动编排开始或恢复传输（TransferStart、TransferData以及如果不需要流媒体则执行TransferExit）软件包到UCM下属。*♩(RS_UCM_00035, RS_UCM_00043)*


**[SWS_UCM_01209] Trigger on kProcessing state** [On transition to kProcessing state, UCM Master shall call ProcessSwPackage method to UCM subordinates to start or resume processing the software packages ready for processing according to the campaign orchestration.*♩(RS_UCM_00035, RS_UCM_00043)*

> [SWS_UCM_01209] 在kProcessing状态触发：当进入kProcessing状态时，UCM Master应调用ProcessSwPackage方法，向UCM下属调用者发出命令，根据活动编排开始或恢复处理准备处理的软件包（参见RS_UCM_00035，RS_UCM_00043）。


**[SWS_UCM_00210] Transferring of software packages on kProcessing state** [If UCM Master is in kProcessing state, UCM Master shall transfer Software Packages to the UCM subordinates according to the campaign orchestration.*♩(RS\_UCM_00035, RS_UCM_00043)*

> 如果UCM主机处于kProcessing状态，UCM主机应根据活动编排将软件包传输给UCM下级（参考RS_UCM_00035，RS_UCM_00043）。


**[SWS_UCM_01212] Trigger on kActivating state** [On transition to kActivating state, UCM Master shall ask UCM subordinates to activate the software with Activate method call according to the campaign orchestration as configured in the VehiclePackage.*♩(RS_UCM_00035, RS_UCM_00043)*

> 当进入kActivating状态时，UCM主机应根据车辆包中配置的活动编排，要求UCM从属机使用Activate方法调用来激活软件（参考RS_UCM_00035和RS_UCM_00043）。


**[SWS_UCM_01214]**{DRAFT} **Final action on kVehicleChecking state** [If UCM Master is in kVehicleChecking state and receives the method VehicleCheck call with parameter VehicleCheckResolution=True, UCM Master shall secondly commit (Finish) the software on all UCM subordinates part of the campaign.*♩(RS\_UCM_00035)*

> **[SWS_UCM_01214]**{草案} **在kVehicleChecking状态下的最终行动** [如果UCM Master处于kVehicleChecking状态，并收到具有参数VehicleCheckResolution = True的VehicleCheck方法调用，UCM Master应其次提交（完成）该活动中所有UCM从属的软件。*♩（RS\_UCM_00035）*


**[SWS_UCM_01215]**{DRAFT} **Trigger on kCancelling state** [On transition to kCancelling state, UCM Master shall rollback (Rollback) the activated or being verified Software Clusters, and revert the processed packages (RevertProcessedSwPackages) of the UCM subordinates part of the campaign.*♩(RS_UCM_00035)*

> **[SWS_UCM_01215]**{草案} **触发kCancelling状态** [在转换到kCancelling状态时，UCM Master应回滚（Rollback）已激活或正在验证的软件集群，并还原属于该活动的UCM下属部分的已处理软件包（RevertProcessedSwPackages）。*♩（RS_UCM_00035）*


**[SWS_UCM_01216] Final action on kCancelling state** [If UCM Master is in kCancelling state and the rollback of software on all UCM subordinates is successful (successful Rollback and transition from kRollingBack to kRolledBack), UCM Master shall secondly commit (Finish) the software on all UCM subordinates part of the campaign.*♩(RS_UCM_00035)*

> **[SWS_UCM_01216] 在kCancelling状态下的最终行动** [如果UCM主机处于kCancelling状态，并且所有UCM下级的软件回滚成功（成功回滚并从kRollingBack转换到kRolledBack），UCM主机第二次应提交（完成）该活动中所有UCM下级的软件。*♩（RS_UCM_00035）*


**[SWS_UCM_01217] Monitoring of UCM subordinates** [UCM Master shall subscribe to the CurrentStatus field, in order to follow the current campaign from the state of the UCM Subordinates.*♩(RS_UCM_00035)*

> **[SWS_UCM_01217] 监控UCM下属** [UCM主机应订阅CurrentStatus字段，以便跟踪UCM下属当前活动的状态。*♩(RS_UCM_00035)*

### States Transitions


**[SWS_UCM_01218] Transition from kIdle state to kSyncing state** [If UCM Master is in kIdle state for CampaignState field and kIdle state for TransferState field, UCM Master shall enter the kSyncing state for CampaignState and kSyncing for TransferState on a request to GetSwClusterInfo or SwPackageInventory.*♩(RS_UCM_00035, RS_UCM_00033)*

> 如果UCM主机的CampaignState字段处于kIdle状态，TransferState字段处于kIdle状态，则在发出GetSwClusterInfo或SwPackageInventory请求时，UCM主机将进入CampaignState的kSyncing状态，TransferState的kSyncing状态(参见RS_UCM_00035，RS_UCM_00033)。


**[SWS_UCM_01219] Transition from kSyncing state to kIdle state** [If UCM Master is in kSyncing state for CampaignState field and kSyncing state for TransferState field, UCM Master shall enter the kIdle state and kIdle for TransferState on completion of GetSwClusterInfo or SwPackageInventory.*♩(RS\_UCM_00035)*

> **[SWS_UCM_01219] 在CampaignState字段和TransferState字段处于kSyncing状态时，UCM Master完成GetSwClusterInfo或SwPackageInventory操作后，应进入kIdle状态，并且TransferState应处于kIdle状态。*♩(RS\_UCM_00035)*


**[SWS_UCM_01220] Transition from kIdle state to kVehiclePackageTransferring and kTransferring states** [If UCM Master is in kIdle state for CampaignState field and kIdle state for TransferState field, UCM Master shall enter the kVehiclePackageTransferring state and kTransferring state on successful completion of TransferVehiclePackage.*♩(RS_UCM_00035)*

> **[SWS_UCM_01220] 在CampaignState字段的kIdle状态和TransferState字段的kIdle状态之间进行转换：UCM主机在成功完成TransferVehiclePackage后，应进入kVehiclePackageTransferring状态和kTransferring状态。♩(RS_UCM_00035)**


**[SWS_UCM_01221] Transition from kVehiclePackageTransferring state and kTransferring state to kCancelling state** [If UCM Master is in kVehiclePackageTransferring state for CampaignState field and kTransferring state for TransferState field, UCM Master shall enter the kCancelling state for CampaignState and kCancelling state for TransferState on unsuccessful completion of TransferExit (Vehicle Package) or successful completion of DeleteTransfer (Vehicle Package) or non recoverable error of TransferData.*♩(RS_UCM_00035, RS_UCM_00039)*

> 如果UCM主机的CampaignState字段处于kVehiclePackageTransferring状态，TransferState字段处于kTransferring状态，则在TransferExit（车辆包）不成功完成或DeleteTransfer（车辆包）成功完成或TransferData非可恢复错误时，UCM主机应进入kCancelling状态（CampaignState和TransferState均为kCancelling状态）。（RS_UCM_00035，RS_UCM_00039）


**[SWS_UCM_01222] Transition from kVehiclePackageTransferring state to kSoftwarePackage_Transferring state** [If UCM Master is in kVehiclePackageTransferring state, UCM Master shall enter the kSoftwarePackage\_Transferring state on successful completion of TransferExit (Vehicle Package).*♩(RS_UCM_00035, RS_UCM_00037, RS_UCM_00038)*

> **[SWS_UCM_01222] 当UCM主机处于kVehiclePackageTransferring状态时，在TransferExit（车辆包）成功完成后，UCM主机将进入kSoftwarePackage_Transferring状态。*♩（RS_UCM_00035，RS_UCM_00037，RS_UCM_00038）**


**[SWS_UCM_01227] Transition from kSoftwarePackage_Transferring state and kTransferring state to kCancelling state** [If UCM Master is in kSoftwarePackage_Transferring state for CampaignState and kTransferring state for TransferState, UCM Master shall enter the kCancelling state for CampaignState and kCancelling state for TransferState on successful cancellation request (CancelCampaign) or if there is a non recoverable transfer failure from one of the UCM subordinates.*♩(RS_UCM_00035)*

> 如果UCM主机处于CampaignState的kSoftwarePackage_Transferring状态和TransferState的kTransferring状态，则在成功取消请求（CancelCampaign）或UCM下级出现不可恢复的传输故障时，UCM主机应进入CampaignState的kCancelling状态和TransferState的kCancelling状态。 ♩（RS_UCM_00035）


**[SWS_UCM_01228] Transition from kSoftwarePackage_Transferring state and kTransferring state to kProcessing state and kUpdating state** [When UCM Master is in kSoftwarePackage_Transferring state for CampaignState and kTransferring state for TransferState, if all Software Packages are ready for processing, all Software Packages from all UCM subordinates are at state kTransferred or at least one Software Package started being processed by

> 当UCM主机处于CampaignState的kSoftwarePackage_Transferring状态和TransferState的kTransferring状态时，如果所有软件包都准备好处理，则所有来自所有UCM下属的软件包均处于kTransferred状态，或者至少有一个软件包已经开始被处理，则将进入kProcessing状态和kUpdating状态。


ProcessSwPackage call to one UCM subordinate according to the campaign orchestration, UCM Master shall enter the kProcessing state for CampaignState and kUpdating state for TransferState.*♩(RS_UCM_00035, RS_UCM_00037, RS\_UCM_00038, RS_UCM_00043)*

> 当根据活动编排调用一个UCM下属的ProcessSwPackage时，UCM Master应该进入CampaignState的kProcessing状态和TransferState的kUpdating状态（RS_UCM_00035，RS_UCM_00037，RS\_UCM_00038，RS_UCM_00043）。


**[SWS_UCM_01229]**{DRAFT} **SafetyConditions while processing stream** [In the case there is transition from kSoftwarePackage_Transferring state to kProcessing state, the SafetyConditions for kProcessing state shall apply even though there are Software Packages transferring.*♩(RS_UCM_00035, RS_UCM_00037)*

> **[SWS_UCM_01229]**{草案} **处理流程时的安全条件** [如果从kSoftwarePackage_Transferring状态转换到kProcessing状态，即使有软件包正在传输，也应该应用kProcessing状态的安全条件。*♩(RS_UCM_00035, RS_UCM_00037)*

简体中文：**[SWS_UCM_01229]**{草案} **处理流程时的安全条件** [如果从kSoftwarePackage_Transferring状态转换到kProcessing状态，即使有软件包正在传输，也应该应用kProcessing状态的安全条件。*♩(RS_UCM_00035, RS_UCM_00037)*


It is integrator's responsibility to make sure in this use case that safety conditions for Processing will also cover safety approach of transferring.

> 这种使用案例中，集成器负责确保处理过程的安全条件也包括传输的安全方法。


**[SWS_UCM_01234] Transition from kProcessing state to kActivating state** [If UCM Master is in kProcessing state and all software packages of the campaign have been successfully (successful ProcessSwPackage) processed and all UCM subordinates part to the campaign are in the kReady state, UCM Master shall enter the kActivating state.*♩(RS_UCM_00035, RS_UCM_00037, RS_UCM_00038)*

> 如果UCM主机处于kProcessing状态，并且活动的所有软件包都已成功处理（successful ProcessSwPackage），并且该活动的所有UCM子机都处于kReady状态，UCM主机将进入kActivating状态（RS_UCM_00035，RS_UCM_00037，RS_UCM_00038）。


**[SWS_UCM_01236] Transition from kProcessing state and kUpdating state to kCancelling state** [If UCM Master is in kProcessing state for CampaignState and kUpdating state for TransferState, UCM Master shall enter the kCancelling state for CampaignState and kCancelling state for TransferState on successful cancellation request (CancelCampaign) or in case of non recoverable processing failure of one of the UCM subordinates.*♩(RS_UCM_00035)*

> **[SWS_UCM_01236] 如果UCM主机处于CampaignState的kProcessing状态和TransferState的kUpdating状态，则在成功取消请求（CancelCampaign）或非可恢复处理失败的UCM子机之一的情况下，UCM主机应进入CampaignState的kCancelling状态和TransferState的kCancelling状态。*♩（RS_UCM_00035）*


**[SWS_UCM_01239] Transition from kActivating state and kUpdating state to kCancelling state** [If UCM Master is in kActivating state for CampaignState and kUpdating state for TransferState, UCM Master shall enter the kCancelling state for CampaignState and kCancelling state for TransferState if any UCM subordinates part of the campaign unsuccessfully (unsuccessful Activate and transition from kVerifying to kRollingBack) completed activation.*♩(RS_UCM_00035)*

> 如果UCM主机处于CampaignState的kActivating状态和TransferState的kUpdating状态，当任何一个参与活动的UCM子机未能成功（从kVerifying到kRollingBack的未成功激活和转换）完成激活时，UCM主机应该进入CampaignState的kCancelling状态和TransferState的kCancelling状态。♩（RS_UCM_00035）


**[SWS_UCM_01240] Transition from kActivating state to kVehicleChecking state** [If UCM Master is in kActivating state, UCM Master shall enter the kVehicleChecking state if all UCM subordinates part of the campaign successfully (successful Activate and transition from kVerifying to kActivated) completed activation.*♩(RS_UCM_00035, RS_UCM_00037)*

> 如果UCM主机处于kActivating状态，如果所有参与活动的UCM子机都成功完成激活并从kVerifying状态转换到kActivated状态，UCM主机将进入kVehicleChecking状态（根据RS_UCM_00035和RS_UCM_00037）。


**[SWS_UCM_01241]**{DRAFT} **Transition from kVehicleChecking state and kUpdating state to kCancelling state** [If UCM Master is in kVehicleChecking state for CampaignState and kUpdating state for TransferState, and receives the method VehicleCheck call with parameter VehicleCheckResolution=False, UCM Master shall enter the kCancelling state for CampaignState and kCancelling state for TransferState.*♩(RS_UCM_00035)*

> 如果UCM主机处于CampaignState的kVehicleChecking状态和TransferState的kUpdating状态，并收到具有参数VehicleCheckResolution=False的VehicleCheck方法调用，则UCM主机应进入CampaignState的kCancelling状态和TransferState的kCancelling状态（参考RS_UCM_00035）。


**[SWS_UCM_01242] Transition from kVehicleChecking state and kUpdating state to kIdle state** [If UCM Master is in kVehicleChecking state for CampaignState and kUpdating state for TransferState and all UCM subordinates part of the campaign transitioned from kCleaningUp to kIdle, UCM Master shall enter the kIdle state for CampaignState and kIdle state for TransferState.*♩(RS_UCM\_00035)*

> 如果UCM主机的CampaignState处于kVehicleChecking状态，TransferState处于kUpdating状态，而所有参与活动的UCM子机都从kCleaningUp状态转换到kIdle状态，UCM主机将进入CampaignState的kIdle状态和TransferState的kIdle状态（RS_UCM_00035）。


**[SWS_UCM_01243] Transition from kCancelling state to kIdle state** [If UCM Master is in kCancelling state for CampaignState and kCancelling state for TransferState and all UCM subordinates part of the campaign transitioned from kCleaningUp to kIdle, UCM Master shall enter the kIdle state for CampaignState and kIdle state for TransferState.*♩(RS_UCM_00035)*

> **[SWS_UCM_01243] 从kCancelling状态转换到kIdle状态** [如果UCM主机处于CampaignState的kCancelling状态和TransferState的kCancelling状态，并且所有UCM下属部分都从kCleaningUp转换到了kIdle，那么UCM主机将进入CampaignState的kIdle状态和TransferState的kIdle状态。*♩(RS_UCM_00035)*


**[SWS_UCM_01246]**{DRAFT} **Unreachable UCM during update campaign** [In case a UCM is not reachable by UCM Master during an update campaign (from kTransferring or kUpdating), UCM Master shall transit to kCancelling state for CampaignState and kCancelling state for TransferState.*♩(RS_UCM_00035, RS\_UCM_00037)*

> **[SWS_UCM_01246]**{草稿} **更新活动期间UCM无法访问** [如果UCM在更新活动期间无法被UCM主机访问（从kTransferring或kUpdating），UCM主机应将CampaignState转换为kCancelling状态，TransferState转换为kCancelling状态。*♩(RS_UCM_00035, RS\_UCM_00037)*

### Campaign cancelling


CancelCampaign method could be used at garage to unlock a blocked update. Details on action by UCM Master, like cleaning up the several UCMs, changing AUTOSAR Adaptive Platform states, etc. are implementation specific.

> 方法“CancelCampaign”可以在车库中用于解锁被阻止的更新。UCM Master采取的行动的细节，如清理几个UCMs，更改AUTOSAR Adaptive Platform状态等，是实现特定的。


In case an update campaign was cancelled, a new update campaign could use again the already transferred Software Packages. UCM Master could list transferred Software Packages by calling the UCM subordinates with GetSwPackages.

> 如果取消了更新活动，新的更新活动可以再次使用已经传输的软件包。UCM Master可以通过调用UCM下属机构的GetSwPackages来列出已传输的软件包。


**[SWS_UCM_01244]**{DRAFT} **Cancellation of an update campaign shall be possible** [Method CancelCampaign from UCM Master shall trigger a campaign cancel from kTransferring or kUpdating states (from TransferState field).*♩(RS\_UCM_00035, RS_UCM_00037)*

> **[SWS_UCM_01244]**{草案}**取消更新活动应该是可能的** [UCM Master的CancelCampaign方法应该触发从kTransferring或kUpdating状态（从TransferState字段）的活动取消。*♩(RS\_UCM_00035, RS_UCM_00037)*


**[SWS_UCM_01270]**{DRAFT} **New campaign disabling** [UCM Master shall remain in kIdle when a CancelCampaign method has been called with DisableCampaign parameter set.*♩(RS_UCM_00035)*

> **[SWS_UCM_01270]**{草案} **新的活动禁用** [当调用CancelCampaign方法并将DisableCampaign参数设置为true时，UCM Master应保持在kIdle状态。*♩(RS_UCM_00035)*


**[SWS_UCM_01271]**{DRAFT} **New campaign enabling** [Method AllowCampaign from UCM Master shall reallow new campaign after a CancelCampaign method was called with DisableCampaign parameter set.*♩(RS_UCM_00035)*

> **[SWS_UCM_01271]**{草案}**启用新活动** [UCM Master的AllowCampaign方法应在以DisableCampaign参数调用CancelCampaign方法后重新允许新活动。*♩(RS_UCM_00035)*


**[SWS_UCM_01273]**{DRAFT} **CancelCampaign CancelFailed error** [CancelCampaign shall raise the error ApplicationError CancelFailed in case cancelling of a campaign fails.*♩(RS_UCM_00020)*

> **[SWS_UCM_01273]**{草案} **取消活动失败错误** [如果取消活动失败，取消活动应引发ApplicationError CancelFailed错误。*♩(RS_UCM_00020)*


**[SWS_UCM_01274]**{DRAFT} **CancelCampaign OperationNotPermitted error** [CancelCampaign shall raise the error ApplicationError OperationNotPermitted in case the UCM Master states are at kIdle, kSyncing or kCancelling.*♩ (RS_UCM_00020)*

> **[SWS_UCM_01274]**{草案} **取消活动操作不被允许的错误** [如果UCM主状态处于kIdle、kSyncing或kCancelling，取消活动应引发ApplicationError OperationNotPermitted错误。*♩ (RS_UCM_00020)*

### Campaign Reporting


After campaign is finished (finish method has been sent to all UCM subordinates), UCM Master should report to Backend server status of the vehicle, with for instance updated information of Software Clusters present in vehicle.

> 当活动结束（结束方法已发送给所有UCM下属）后，UCM主要应向后端服务器报告车辆的状态，例如更新车辆中存在的软件集群的信息。


**[SWS_UCM_01247] Method to read History Report** [UCM Master shall provide a method GetCampaignHistory to retrieve all actions that have been performed by UCM Master when exiting state kUpdating from a specific time window.*♩(RS_UCM\_00034)*

> **[SWS_UCM_01247] 读取历史报告的方法** [UCM Master 应提供一种 GetCampaignHistory 方法，以便在从特定时间窗口退出 kUpdating 状态时检索所有已由 UCM Master 执行的操作。*♩(RS_UCM\_00034)*


**[SWS_UCM_01248] Content of History Report** [UCM Master shall save the point in time when TransferVehiclePackage method is called and the point in time when kIdle state is entered from any state except kSyncing and the campaign result in CampaignHistoryType*♩(RS_UCM_00034)*

> **[SWS_UCM_01248] 历史报告内容** [UCM 主机应保存调用TransferVehiclePackage方法的时间点以及从除kSyncing之外的任何状态进入kIdle状态的时间点，以及CampaignHistoryType*♩(RS_UCM_00034)*中的活动结果。


The elements of HistoryVectorType [SWS_UCM_00254] are not sorted.

> 元素历史向量类型[SWS_UCM_00254]未经排序。


**[SWS_UCM_01266]**{DRAFT} **Subordinate Not Available On The Network** [ UCM Master shall record persistently the error kSubordinateNotAvailableOnTheNetwork in case one of the UCM subordinate involved in the current campaign stops offering its service interface and later report it with GetCampaignHistory.*♩ (RS_UCM_00034)*

> **[SWS_UCM_01266]**{草案} **下属节点不在网络上** [UCM Master应在当前活动中涉及的某个UCM下属节点停止提供其服务接口后，持久记录错误kSubordinateNotAvailableOnTheNetwork，然后使用GetCampaignHistory来报告它。*♩ (RS_UCM_00034)*


**[SWS_UCM_01267]**{DRAFT} **Vehicle State Manager Communication Error** [UCM Master shall record persistently the error kVehicleStateManagerCommunicationError in case the communication with Vehicle State Manager is not possible and later report it with GetCampaignHistory.*♩(RS_UCM_00034)*

> **[SWS_UCM_01267]**{草案} **车辆状态管理器通信错误** [UCM主机在与车辆状态管理器通信不可能时应持久记录错误kVehicleStateManagerCommunicationError，并在稍后使用GetCampaignHistory报告它。*♩(RS_UCM_00034)*


**[SWS_UCM_01268]**{DRAFT} **Vehicle Driver Interface Communication Error** [UCM Master shall record persistently the error kVehicleDriverInterfaceCommunicationError in case the communication with Vehicle Driver Interface is no longer possible and later report it with GetCampaignHistory.*♩(RS_UCM_00034)*

> **[SWS_UCM_01268]**{草案} **车辆驾驶员界面通信错误** [UCM Master应该在与车辆驾驶员界面通信不再可能时持久记录错误kVehicleDriverInterfaceCommunicationError，并稍后通过GetCampaignHistory来报告它。*♩(RS_UCM_00034)*


**[SWS_UCM_01269]**{DRAFT} **Campaign cancellation history** [If CancelCampaign method is called, UCM Master shall record persistently this event to later report it with GetCampaignHistory.*♩(RS_UCM_00034)*

> **[SWS_UCM_01269]**{草稿} **活动取消历史** [如果调用了CancelCampaign方法，UCM Master应该持久地记录此事件，以便稍后通过GetCampaignHistory来报告。*♩(RS_UCM_00034)*

### Content of Vehicle Package

**Figure 7.10: Vehicle package overview**


A Vehicle Package is typically assembled by an OEM Backend. A Vehicle Package has to be modelled as a so-called VehiclePackage which describes the content of the Vehicle Package. It contains a collection of Software Package Manifests extracted from Backend packages stored in the Backend database. These Software Packages have to be modelled as a so-called SoftwarePackage which describes the content of the Software Package. A Vehicle Package contains only one Vehicle Package Manifest. Several archive file formats could be used for the Vehicle Package or Software Package like .zip, gz, bz2, etc. UCM and UCM Master could implement several extraction algorithm compatible with several archiving formats and identify the right format to apply by analysing the file header.

> 一个车辆包通常由OEM后端组装。车辆包必须被建模为所谓的VehiclePackage，描述车辆包的内容。它包含从后端数据库中存储的后端包中提取的软件包清单的集合。这些软件包必须被建模为所谓的SoftwarePackage，描述软件包的内容。车辆包只包含一个车辆包清单。可以使用多种归档文件格式来存储车辆包或软件包，如.zip，gz，bz2等。UCM和UCM Master可以实现多种与多种归档格式兼容的提取算法，并通过分析文件头来确定正确的格式来应用。


It is possible that within an update campaign, several Machine or ECUs need to be updated/installed/removed by groups. Some Software Clusters could require reboot of Machine or ECU, some just a restart of Adaptive Application or nothing (waiting passively for next reboot) to get activated. To optimize a campaign or fulfil dependencies, it could be required to activate Software Clusters one after the other or several at once. To support all possible campaigns, the Vehicle Package includes a model describing this coordination. It also contains a way to identify the several involved UCMs for packages distribution within the vehicle and potentially overwriting default UCM Master for this specific campaign.

> 可能在更新活动中，需要通过组合来更新/安装/移除多个机器或ECU。一些软件集群可能需要重新启动机器或ECU，有些只需要重新启动自适应应用程序或什么都不需要（等待下一次重新启动）才能激活。为了优化活动或满足依赖关系，可能需要按顺序或同时激活软件集群。为了支持所有可能的活动，车辆包括一个模型来描述这种协调。它还包含一种方法来识别车辆内包裹分发的多个相关UCM，并且可能覆盖此特定活动的默认UCM Master。


You can find below for information purpose a description of the information that must be contained in Vehicle Package manifest:

> 以下是车辆包装清单所必须包含的信息的描述，供您参考：

- Repository: uri, repository or diagnostic address, for history, tracking and security purposes
- Vehicle description: vehicle description

- Vehicle Driver notifications: it might be needed to ask vehicle driver if UCM Master can start transferring Software Packages, processing it and activating it but also inform him of the necessary safety requirements if applicable.

> 车辆司机通知：如果UCM主机可以开始传输软件包、处理和激活，可能需要询问车辆司机，并通知他必要的安全要求（如果有）。

- Safety policy: safety policy index to be used as argument to subscribe a field to vehicle safety manager. With this field, UCM Master will be informed at any time of campaign if vehicle safety is met or not.

> 安全政策：安全政策索引可用作订阅车辆安全经理的参数。有了这个字段，UCM Master将随时了解活动是否符合安全要求。
- UCM Master identifiers list: defines backup UCM Masters

- Campaign orchestration: You can refer to [[10](#_bookmark10)] for more details. This campaign model allows to group activation of several UCMs and group Software Packages processing and transferring.

> 运营策划：您可以参考[[10](#_bookmark10)]了解更多细节。此活动模型允许将多个UCM和组软件包处理和传输进行分组激活。


**[SWS_UCM_01301]**{DRAFT} **Vehicle Package authentication** [The Vehicle Package shall be successfully authenticated by the UCM Master using CryptoServiceCertificate at TransferData or TransferExit call before any transfer of the Software Packages, otherwise raise ApplicationError OperationNotPermitted.*♩(RS_UCM_00039, RS_UCM_00043)*

> **[SWS_UCM_01301]**{草案} **车辆包认证** [在TransferData或TransferExit调用之前，车辆包必须通过UCM Master使用CryptoServiceCertificate进行成功认证，否则应抛出ApplicationError OperationNotPermitted。*♩(RS_UCM_00039，RS_UCM_00043)*


If Vehicle Package is not yet authenticated, UCM Master does not accept any transfer of Software Packages that are not confirmed to be part of Campaign for security purpose.

> 如果车辆包尚未经过认证，UCM Master不接受任何未经确认为安全目的活动组成部分的软件包的转移。


**[SWS_UCM_01302]**{DRAFT} **Vehicle Package authentication failure** [In case Vehicle Package authentication fails at TransferExit call, UCM Master shall raise the ApplicationError AuthenticationFailed.*♩(RS_UCM_00039, RS\_UCM_00043)*

> **[SWS_UCM_01302]**{草案} **车辆包认证失败** [如果在TransferExit调用时车辆包认证失败，UCM主机应引发ApplicationError AuthenticationFailed。*♩(RS_UCM_00039, RS\_UCM_00043)*


**[SWS_UCM_01303]**{DRAFT} **Dependencies between Software Packages** [UCM Master shall check dependencies based on Vehicle Package Manifests and Software Packages Manifests before an transfer of Software Packages.*♩ (RS_UCM_00035, RS_UCM_00043)*

> **[SWS_UCM_01303]**{草稿} **软件包之间的依赖关系** [在软件包转移之前，UCM 主机应根据车辆包清单和软件包清单检查依赖关系。*♩ (RS_UCM_00035, RS_UCM_00043)*


In case UCM Master does not handle any recovery from a failing dependency check, UCM Master could cancel the active campaign and return ApplicationError MissingDependencies from TransferExit. UCM Master could avoid returning MissingDependencies error from TransferExit by resolving missing dependencies. For instance, UCM Master could request to install missing Software Cluster using RequestedPackage field, or remove conflicting Software Cluster.

> 如果UCM Master在依赖性检查失败时未能处理任何恢复操作，UCM Master可以取消正在进行的活动，并从TransferExit返回ApplicationError MissingDependencies。UCM Master可以通过解决缺失的依赖项来避免从TransferExit返回MissingDependencies错误。例如，UCM Master可以使用RequestedPackage字段请求安装缺失的软件集群，或删除冲突的软件集群。


The Vehicle Package contains a Vehicle Package manifest and Software Packages manifests of ARXML format in order to have interoperability between vendors.

> 车辆包含有车辆包清单和ARXML格式的软件包清单，以便在供应商之间实现互操作性。


**[SWS_UCM_01305]**{DRAFT} **Vehicle Package format** [When the UCM Master receives a Vehicle Package whose Vehicle Package manifest and Software Package manifests formats are not ARXML, then the UCM Master shall return ApplicationError InvalidPackageManifest from either TransferData or TransferExit method call and transition from kVehiclePackageTransferring or kTransferring to kIdle*♩(RS_UCM_00035, RS_UCM_00043)*

> **[SWS_UCM_01305]**{草案} **车辆包格式** [当UCM主机接收到车辆包的车辆包清单和软件包清单格式不是ARXML时，UCM主机应从TransferData或TransferExit方法调用中返回ApplicationError InvalidPackageManifest，并从kVehiclePackageTransferring或kTransferring过渡到kIdle*♩(RS_UCM_00035, RS_UCM_00043)*


**[SWS_UCM_01307]**{DRAFT} **Vehicle Package format not supported** [UCM Master shall return ApplicationError UnsupportedPackageFormat from TransferData or TransferExit methods call in the case the Vehicle Package format is not supported.*♩(RS_UCM_00043)*

> **[SWS_UCM_01307]**{草案} **车辆包格式不受支持** [如果车辆包格式不受支持，UCM Master 将从 TransferData 或 TransferExit 方法调用中返回 ApplicationError UnsupportedPackageFormat。*♩(RS_UCM_00043)*


**[SWS_UCM_01306] TransferExit Invalid package manifest** [TransferExit shall raise the error ApplicationError InvalidPackageManifest upon reception of an invalid manifest.*♩(RS_UCM_00012)*

> **[SWS_UCM_01306] TransferExit 无效的包清单** [TransferExit 应在收到无效的清单时引发错误 ApplicationError InvalidPackageManifest。*♩（RS_UCM_00012）*


**[SWS_UCM_01308]**{DRAFT} **Check Vehicle Package version compatibility against UCM Master version** [At TransferExit call, UCM Master shall raise ApplicationError IncompatiblePackageVersion if the version for the Vehicle Package transferred expressed by minimumSupportedUcmMasterVersion attribute is higher than the current version of UCM Master expressed by version attribute.*♩(RS\_UCM_00043)*

> **[SWS_UCM_01308]**{草稿} **检查车辆包版本与UCM主版本的兼容性** [在TransferExit调用时，如果传输的车辆包版本的minimumSupportedUcmMasterVersion属性表示的版本高于UCM主版本的version属性表示的版本，UCM主版本将引发ApplicationError IncompatiblePackageVersion。*♩(RS\_UCM_00043)*

### Vehicle update security and confidentiality


The methods GetSwClusterInfo, SwPackageInventory and GetHistory could use private or confidential information.

> 这些方法GetSwClusterInfo、SwPackageInventory和GetHistory可能使用私人或机密信息。


**[SWS_UCM_CONSTR_00013]**{DRAFT} **Confidential information protection** [The VehiclePackageManagement and VehicleDriverApplicationInterface interfaces shall only be called over secure communication channel providing confidentiality protection.*♩(RS_UCM_00033)*

> **[SWS_UCM_CONSTR_00013]**{草案} **保护机密信息** [车辆包管理和车辆驱动程序接口只能通过提供机密保护的安全通信通道调用。*♩(RS_UCM_00033)*


The GetSwClusterInfo, SwPackageInventory, GetCampaignHistory, GetSwClusterChangeInfo, GetHistory, GetSwClusterDescription and GetSwPackages methods are using data that could identify vehicle user and therefore should be protected for confidentiality.

> 这些方法：GetSwClusterInfo、SwPackageInventory、GetCampaignHistory、GetSwClusterChangeInfo、GetHistory、GetSwClusterDescription和GetSwPackages正在使用可以识别车辆用户的数据，因此应该保护其机密性。

# API specification


There are no APIs defined in this release.

> 在本次发布中没有定义任何API。

9. # Service Interfaces


   1. ## Type definitions

> ## 类型定义


This chapter lists all types provided by the UCM.

> 本章节列出了UCM提供的所有类型。

![](./media/image32.png)![](./media/image34.png)The two following figures are informative and only meant to support reader having global view of UCM Subordinate and UCM Master types and service interfaces.

![](./media/image35.png)![](./media/image37.png)**Figure 9.1: UCM Subordinate composite structure**
![](./media/image38.png)![](./media/image41.png){width="5.628228346456693in" height="7.606536526684165in"}**Figure 9.2: UCM Master composite structure**


B.  # Interfaces to other Functional Clusters (informative)

> B.  # 与其他功能群联系的界面（信息性）

1. ## Overview


AUTOSAR decided not to standardize interfaces which are exclusively used between Functional Clusters (on platform-level only), to allow efficient implementations, which might depend e.g. on the used Operating System.

> AUTOSAR决定不对仅在平台级别上在功能集群之间使用的接口进行标准化，以允许高效的实现，这可能取决于所使用的操作系统。


This chapter provides informative guidelines how the interaction between Functional Clusters looks like, by clustering the relevant requirements of this document. In addition, the standardized public interfaces which are accessible by user space applications (see chapter [8](#api-specification)) can also be used for interaction between Functional Clusters.

> 本章提供了信息指南，说明功能簇之间的交互是如何通过聚类本文档的相关要求来实现的。此外，用户空间应用程序可以访问的标准公共接口（参见第8章[API规范]）也可以用于功能簇之间的交互。


The goal is to provide a clear understanding of Functional Cluster boundaries and interaction, without specifying syntactical details. This ensures compatibility between documents specifying different Functional Clusters and supports parallel implementation of different Functional Clusters. Details of the interfaces are up to the platform provider.

> 目标是提供清晰的功能集群边界和交互理解，而不指定句法细节。这确保了指定不同功能集群的文档之间的兼容性，并支持不同功能集群的并行实现。接口的细节取决于平台提供者。

2. ## Interfaces Tables


   1. ### UCM update notification

> ### UCM更新通知


UCM shall provide the notification to other Functional Clusters that changes have been done to the software. This enables other functional clusters to check if updated manifests have changes relevant for the concerned Functional Cluster. This can be done through the field CurrentStatus provided by the UCM service.

> UCM将向其他功能集群发出通知，表明软件已经做出了更改。这使得其他功能集群可以检查更新的清单是否对有关功能集群有相关更改。这可以通过UCM服务提供的CurrentStatus字段完成。


C.  # Packages distribution within vehicle detailed sequence examples

> C.  # 车辆内部包裹分布的详细序列示例

```
1.  ## Collect information of present Software Clusters in vehicle
```


From a regular basis, UCM master and UCM can collect information of present Software Clusters from the other AUTOSAR Adaptive Platforms of the vehicle in order to be used later when communicating with Backend and then determine if there are new actions (update, remove, install) required.

> 从常规基础上，UCM主机和UCM可以收集车辆上其他AUTOSAR自适应平台的当前软件集群的信息，以便在与后端通信时使用，然后确定是否需要新的操作（更新，删除，安装）。

![](./media/image42.png)

**Figure C.1: Collect information of Software Clusters present in vehicle from several AUTOSAR Adaptive Platforms**

## Action computation


In order to find out if there is a new update available from Backend or the need to install or remove a Software Cluster, vehicle and Backend have to share their current status and either Backend or vehicle have to compute what UCM Master actions are needed.

> 为了查看是否有可用的来自后端的新更新，或需要安装或卸载软件集群、车辆和后端必须共享它们的当前状态，而后端或车辆必须计算出所需的UCM主操作。


Backend will have the possibility to push a package into the vehicle when communication is established, for instance for security purpose.

> 后端将有可能在建立通信后将一个包推送到车辆中，例如用于安全目的。


Communication trial between Backend and UCM master can be done on driver's request or from a scheduler.

> 可以根据驱动程序的要求或者定时调度来完成后端与UCM主机之间的通信试验。

### Pull package from Backend into vehicle


Case where vehicle is computing the difference between Software Clusters versions that are present in vehicle and the ones available in Backend.

> 车辆计算车辆中存在的软件集群版本与后端可用版本之间的差异的情况。

![](./media/image45.png){width="8.238188976377953e-2in" height="0.2864577865266842in"} ![](./media/image46.png){width="8.279746281714785e-2in" height="0.22312445319335084in"} ![](./media/image46.png){width="8.279746281714785e-2in" height="0.22312445319335084in"} ![](./media/image46.png){width="8.279746281714785e-2in" height="0.22312445319335084in"}

![](./media/image47.png)

**Figure C.2: Pull package from backend**

### Push package from backend into vehicle


Case where Backend is computing the difference between Software Clusters versions that are present in vehicle and the ones available in Backend.

> 汽车中存在的软件集群版本与后端可用版本之间的差异由后端计算的情况。

![](./media/image50.png){width="0.1003565179352581in" height="0.3489577865266842in"} ![](./media/image51.png){width="0.10050196850393701in" height="0.2708333333333333in"} ![](./media/image51.png){width="0.10050196850393701in" height="0.2708333333333333in"} ![](./media/image51.png){width="0.10050196850393701in" height="0.2708333333333333in"}

![](./media/image52.png)

**Figure C.3: Push package from backend**

## Packages transfer from backend into targeted UCM

**Figure C.4: Stream packages blocks from backend into targeted UCM**

## Package processing

**Figure C.5: Packages processing by UCMs**

## Package activation

![](./media/image62.png)
**Figure C.6: Packages activation by UCMs**

## Package rollback

![](./media/image66.png){width="9.136920384951881e-2in" height="0.3177077865266842in"} ![](./media/image67.png){width="9.083770778652668e-2in" height="0.2447911198600175in"} ![](./media/image67.png){width="9.083770778652668e-2in" height="0.2447911198600175in"} ![](./media/image68.png){width="9.083770778652668e-2in" height="0.2447911198600175in"} ![](./media/image67.png){width="9.083770778652668e-2in" height="0.2447911198600175in"}

**Figure C.7: Packages rollback by UCMs**

## Campaign reporting

![](./media/image76.png){width="0.10934383202099737in" height="0.3802077865266842in"} ![](./media/image77.png){width="0.10823272090988627in" height="0.2916666666666667in"} ![](./media/image77.png){width="0.10823272090988627in" height="0.2916666666666667in"} ![](./media/image77.png){width="0.10823272090988627in" height="0.2916666666666667in"} ![](./media/image77.png){width="0.10823272090988627in" height="0.2916666666666667in"}

![](./media/image78.png)OTA Client

**Figure C.8: Campaign reporting to backend**

# Security Analysis of Installation and Update


This chapter presents a summary for the security analysis of the UCM. Some of the threats could not be addressed by specifying AUTOSAR requirements. The main reason for not specifying the countermeasures is to allow vendors to flexibly decide on the solution that fits their setup. Here we aim to raise awareness and provide advice on the selected topics:

> 本章概括了UCM的安全分析。一些威胁不能通过指定AUTOSAR要求来解决。不指定对策的主要原因是允许供应商灵活地决定适合其设置的解决方案。在这里，我们的目标是提高意识，并就所选主题提供建议。

## Securing Software Package


UCM is responsible for applying changes of the platform and applications contained in the Software Packages it receives. Therefore, integrity and authenticity of Software Packages are critical to protect system integrity. It shall be ensured that the Software Packages are neither illegitimately altered nor issued by unauthorized parties. This can be achieved by applying cryptographic techniques such as digital signatures. The period that Software Package resides in UCM before being activated shall not be neglected. It provides a window of opportunity for an attacker to tamper with the Software Package after the authentication is done at TransferExit.

> UCM负责应用它收到的软件包中的平台和应用程序的变更。因此，软件包的完整性和真实性对于保护系统完整性至关重要。应确保软件包既不被非法更改，也不是由未经授权的方面发布的。这可以通过应用密码技术，如数字签名来实现。在UCM中软件包停留的时间不应被忽视。它为攻击者在TransferExit进行身份验证后篡改软件包提供了一个窗口机会。


Information disclosure is another security threat category that might be applicable to Software Packages. Packages that contain sensitive information, such as intellectual properties or cryptographic keys, require confidentiality protection in addition to integrity and authenticity when being persisted or transmitted over a communication channel.

> 信息披露是另一种可能适用于软件包的安全威胁类别。包含敏感信息的包，如知识产权或加密密钥，在持久化或通过通信通道传输时，除了完整性和真实性之外，还需要保密保护。


Another aspect of protecting Software Update Packages is their freshness. An attacker may try to manipulate the system by downgrading the software via replaying an authentic but older Software Update Package. In this regard, the platform shall ensure that only newer packages (i.e. packages that contain newer version of installed SWCL) can be installed.

> 另一个保护软件更新包的方面是它们的新鲜度。攻击者可能会试图通过重放一个真实但较旧的软件更新包来降级软件。在这方面，该平台应确保只能安装较新的包（即包含已安装SWCL的较新版本的包）。

## Securing Calls to UCM


UCM provides a very critical functionality in the platform that allows modifying applications and platform components. In that sense, it is critical to prevent unauthorized access to UCM, meaning only legitimate callers should be allowed to reach the UCM service interface. This is primarily enforced in the communication layer supported by the Identity and Access Management. Additionally, the calls to the UCM interface shall be protected against altering, e.g. changing API arguments. When the service and client reside on the same machine, the security relies on the integrity of the operating system and the platform. In case, the service and the client are running on different machines, a secure communication, assuring authenticity and integrity of communication, is additionally required.

> UCM在平台上提供了非常关键的功能，允许修改应用程序和平台组件。因此，防止未经授权的访问UCM至关重要，这意味着只有合法的调用者才能访问UCM服务接口。这主要是由身份和访问管理支持的通信层来强制执行的。此外，对UCM接口的调用应受到保护，以防被更改，例如更改API参数。当服务和客户端位于同一台机器上时，安全取决于操作系统和平台的完整性。如果服务和客户端在不同的机器上运行，则还需要安全通信来确保通信的真实性和完整性。


Moreover, some API methods of the UCM interface returns sensitive information about the platform. This subset (GetSwClusterInfo, GetSwClusterChangeInfo, GetHistory, GetSwPackages) shall be protected against information disclosure and should only be reachable over a channel that provides confidentiality.

> 此外，UCM接口的一些API方法会返回关于平台的敏感信息。这一子集（GetSwClusterInfo，GetSwClusterChangeInfo，GetHistory，GetSwPackages）应该受到保护，以防止信息泄露，并且只能通过提供机密性的通道访问。


A similar reasoning is applicable for securing the communication between UCM Master and its clients. Regarding protection against information disclosure, GetSwClusterInfo, SwPackageInventory and GetHistory for UCM Master shall only be called over confidential channels.

> 相同的推理也适用于保护UCM主机和其客户端之间的通信安全。为了防止信息泄露，UCM主机上的GetSwClusterInfo、SwPackageInventory和GetHistory应该只在安全通道上调用。

## Suppressing Call to UCM


Multiple scenarios can be envisioned where an attacker targets suppressing the calls to UCM. The attack could block the calls to or the response from UCM. In both cases the caller of the service may assume that UCM is not responding and retries its request. This would lead to undesired overhead on the system. For such scenarios, it is recommended that both UCM and the UCM Client consider reporting security events when same calls repeatedly received at UCM or calls repeatedly fail at the caller side. This information could potentially be picked up by Intrusion Detection Systems or Anomaly Detection Systems.

> 多种情况可以想象，攻击者可以针对UCM的呼叫进行抑制。攻击可以阻止对UCM的呼叫或者UCM的响应。在这两种情况下，服务的调用者可能会认为UCM没有响应，然后重试其请求。这将导致系统上的不必要开销。为了防止这种情况，建议UCM和UCM客户端考虑在收到重复的呼叫或者呼叫在调用者端失败时报告安全事件。这些信息可能被入侵检测系统或异常检测系统捕获。

## Resource Starvation


According to the current specification, the available resources for transferring a Software Package is only checked when TransferStart is called but not reserved. This means, while the transfer is ongoing, the system storage can be exhausted by other processes using the same storage media. This scenario is also applicable to UCM Master when receiving data from its client. A similar case is possible for processing of Software Package, as the resources are only checked at the beginning but not reserved. In this regard, a solution could be to reserve the necessary resources for the Software Package transfer or processing from the beginning to prevent attacks aiming at such scenarios.

> 根据当前的规格，传输软件包时可用资源只在调用TransferStart时检查，但不保留。这意味着，在传输过程中，其他使用相同存储介质的进程可能会耗尽系统存储。此场景也适用于UCM Master，当从客户端接收数据时。处理软件包的情况也可能类似，因为资源只在开始时检查，而不保留。在这方面，一种解决方案可能是从一开始就为软件包传输或处理保留必要的资源，以防止旨在此类场景的攻击。


At the same time, reserving the resources might provide opportunity to the attacker in other scenarios. The specification allows transferring multiple Software Packages in parallel. Consequently, a misbehaving or compromised client can open unlimited number of transfer sessions causing UCM to run out of resources. To cope with this scenario, a threshold for the number of parallel transfer sessions can be defined.

> 同时，保留资源可能为攻击者在其他场景提供机会。该规范允许并行传输多个软件包。因此，行为不当或被植入恶意软件的客户端可以打开无限数量的传输会话，导致UCM耗尽资源。为了应对这种情况，可以定义并行传输会话的阈值。

## Zombie Sessions


The AUTOSAR specification does not enforce any expiry time for the established transfer sessions. As a result, the resources that are hold by an ongoing session will not

> AUTOSAR规范不强制任何结束传输会话的期限。因此，正在进行的会话所持有的资源不会被释放。


be released no matter how long time it takes. At the same time, in certain cases it may take a long time for larger software packages to be transferred to UCM or UCM Master, especially when they are received from external sources with weak connectivity on-the-fly. However, a timeout may be considered for such a transfer to prevent attackers from mounting denial of service attacks by long term allocation of resources.

> 无论需要多长时间，都要发布。同时，在某些情况下，将较大的软件包从UCM或UCM Master传输可能需要很长时间，特别是当它们从具有薄弱连接的外部源接收时。但是，可以考虑为此类传输设置超时，以防止攻击者通过长期分配资源来发起拒绝服务攻击。

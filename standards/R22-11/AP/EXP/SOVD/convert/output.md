---
tip: translate by openai@2023-06-23 13:27:52
...

# **Contents**

# Introduction

This document contains explanation and description how to use the SOVD extensions in AUTOSAR Adaptive. In contrast to the AUTOSAR_SWS_Diagnostics this document does aim on providing a more general overview on the usage of SOVD inclduing a reference architecture, whereas the AUTOSAR_SWS_Diagnostics focuses describes the behavior of one individual SOVD server within this architecture.

> 此文档包含有关如何使用 AUTOSAR Adaptive 中的 SOVD 扩展的解释和描述。与 AUTOSAR_SWS_Diagnostics 相比，本文档旨在提供更通用的 SOVD 使用概述，包括参考架构，而 AUTOSAR_SWS_Diagnostics 则描述了此架构中一个单独的 SOVD 服务器的行为。

SOVD is a modern API standardized by ASAM with the intent of accessing diagnostic information of a vehicle. The main motivation and principles of SOVD are:

> SOVD 是一种由 ASAM 标准化的现代 API，旨在访问车辆的诊断信息。SOVD 的主要动机和原则是：

- Central edge node
- Usage of state-of-the-art technologies
- Support of remote, proximity and in-vehicle diagnostics use case
- Independence from diagnostic data interpretation files such as ODX files
- Encapsulation of UDS (ISO 14229-1)
- Support of HPC use-cases

These principles lead to many new challenges that need to be addressed. Since SOVD clients shall only communicate with one central edge node, the entire vehicle must be abstracted by the SOVD API. For distributed E/E systems this leads to different re- quirements on different levels of the E/E architecture. Chapter 2 covers the challenges on bringing together one SOVD API in a distributes system. Therefore, a reference architecture will be presented with several functional blocks. Besides infrastructural challenges SOVD also introduces new use cases and defines APIs for existing use cases. AUTOSAR Adaptive aims to provide a native SOVD support by the Diagnostic Manager. Chapter 3 summarizes how different SOVD use cases are realized by the Diagnostic Manager and how SOVD coexists besides UDS (ISO 14229-1).

> 这些原则导致了许多需要解决的新挑战。由于 SOVD 客户端只能与一个中央边缘节点通信，因此整个车辆必须由 SOVD API 抽象。对于分布式 E/E 系统，这在 E/E 架构的不同层次上带来了不同的要求。第 2 章涵盖了在分布式系统中如何将一个 SOVD API 结合起来的挑战。因此，将提出一个参考架构，其中包含几个功能块。除基础设施挑战外，SOVD 还引入了新的用例，并定义了现有用例的 API。AUTOSAR Adaptive 旨在通过诊断管理器提供本机 SOVD 支持。第 3 章总结了不同的 SOVD 用例如何由诊断管理器实现，以及 SOVD 如何与 UDS（ISO 14229-1）共存。

# SOVD reference architecture

Providing a central SOVD edge node in a distributed system does require some infras- tructural components. To achieve this a reference architecture that clusters functions into several blocks has been introduced. This architecture is displayed in Figure 1.

> 在分布式系统中提供一个中央 SOVD 边缘节点需要一些基础设施组件。为了实现这一点，已经引入了将功能聚类到几个模块的参考架构。该架构如图 1 所示。

Main components of this reference architecture are:

> 主要组件这个参考架构有：

- SOVD Gateway
- Diagnostic Manager
- SOVD to UDS Translation

![](./media/image1.png){width="5.035in" height="3.0749989063867016in"}

**Figure 2.1: SOVD Reference architecture**

## SOVD Gateway

Upon request from a SOVD client the SOVD Gateway acts as SOVD edge node and routes the requests to respective internal SOVD endpoints. The routing takes place based on the entity part in the URI of the SOVD request. The SOVD Gateway must extract this part of the URI and route towards the corresponding endpoint. The setup of potential internal SOVD endpoints can be statically configured or dynamically dis- covered using mDNS. The forwarding itself takes place on application layer, i. e. the SOVD gateway acts as HTTP reverse proxy.

> 当收到一个 SOVD 客户的请求时，SOVD 网关将充当 SOVD 边缘节点，并把请求路由到相应的内部 SOVD 端点。路由基于 SOVD 请求的 URI 中的实体部分。SOVD 网关必须提取 URI 的这一部分，并路由到相应的端点。潜在的内部 SOVD 端点的设置可以是静态配置的，也可以使用 mDNS 动态发现。转发本身是在应用层，即 SOVD 网关充当 HTTP 反向代理。

For the configuration of the SOVD Gateway the SOVDGatewayInstantiation has been introduced in the TPS_Manifest. This manifest allows to configure the external SOVD connection towards SOVD clients as well as the internal forwarding targets.

> 为了配置 SOVD 网关，已经在 TPS_Manifest 中引入了 SOVDGatewayInstantiation。该清单允许配置 SOVD 客户端的外部 SOVD 连接以及内部转发目标。

## Diagnostic Manager

Before the introduction of SOVD the Diagnostic Manager's main purpose was to handle diagnostic services and fault memory according to ISO 14229-1. With the introduction of SOVD the Diagnostic Manager also aims on natively supporting SOVD and therefore acts as SOVD server.

> 在引入 SOVD 之前，诊断管理器的主要目的是根据 ISO 14229-1 处理诊断服务和故障存储器。随着 SOVD 的引入，诊断管理器还旨在本地支持 SOVD，因此充当 SOVD 服务器。

One of the main guiding principles for the introduction of SOVD was to reuse as much of existing functionality of UDS as suitable while not limiting the native support of SOVD.

> 一个主要的指导原则是引入 SOVD 时尽可能重用 UDS 的现有功能，同时不限制 SOVD 的本机支持。

On structural level the Diagnostic manager does allow multiple Diagnostic Server In- stances. This aims on keeping individual Software Clusters independent. Each Diag- nostic Contribution Set in the DEXT represents one Diagnostic Server Instance with an individual Diagnostic Address. This addressing principle was adapted by SOVD. The Diagnostic Manager itself represents a SOVD component, whereas each Diagnostic Server Instance is represented by a SOVD subcomponent.

> 在结构层面上，诊断管理器确实允许多个诊断服务器实例。这旨在保持单独的软件集群独立。DEXT 中的每个诊断贡献集代表一个具有单独诊断地址的诊断服务器实例。SOVD 采用了这种地址原则。诊断管理器本身代表 SOVD 组件，而每个诊断服务器实例则由 SOVD 子组件表示。

Still the Diagnostic Manager acts as SOVD server and routing towards each subcom- ponent is handled within the Diagnostic Manager. For the configuration of this SOVD server the SOVDServerInstance has been introduced in the TPS_Manifest. The inter- nal behavior of the Diagnostic Manager does depend on the SOVD use case and will be discussed in detail in SWS Diagnostic.

> 仍然，诊断管理器充当 SOVD 服务器，并且对每个子组件的路由由诊断管理器处理。为了配置这个 SOVD 服务器，TPS_Manifest 中引入了 SOVDServerInstance。诊断管理器的内部行为取决于 SOVD 的使用情况，并将在 SWS 诊断中详细讨论。

## SOVD to UDS Translation

This functional block allows the translation of SOVD commands to UDS requests, based on predefined ODX definition of SOVD to UDS mapping. The details of this SOVD to UDS translation is defined by ASAM. This functional block shall be treated as an on-board test client and will send UDS requests to the target diagnostic address and send translated UDS responses to SOVD clients.

> 这个功能块允许根据预定义的 ODX SOVD 到 UDS 映射定义，将 SOVD 命令转换为 UDS 请求。这种 SOVD 到 UDS 转换的细节由 ASAM 定义。这个功能块应该被看作是一个机载测试客户端，它将 UDS 请求发送到目标诊断地址，并将转换后的 UDS 响应发送给 SOVD 客户端。

The complexity of this functional block from implementation point of view is high. But since ASAM has defined these details, AUTOSAR will just refer to ASAM standard at this point.

> 这个功能块从实施的角度来看，复杂性很高。但是由于 ASAM 已经定义了这些细节，AUTOSAR 此时只需要参考 ASAM 标准就可以了。

## Backend Connectivity

SOVD aims on supporting proximity, remote and in-vehicle diagnostics. SOVD has standardized proximity and in-vehicle access rather precisely by introducing mDNS. Standardizing remote access is rather difficult since many dependencies towards the backend infrastructure exist. This degree of freedom kept open by AUTOSAR.

> SOVD 旨在支持近距离、远程和车载诊断。 SOVD 通过引入 mDNS，对近距离和车载访问进行了精确的标准化。由于对后端基础架构存在许多依赖关系，因此标准化远程访问相当困难。 AUTOSAR 保留了这种自由度。

Nonetheless a rather straightforward solution is possible by abstracting the backend connection by some backend connectivity functional block, which routes the SOVD requests towards the SOVD Gateway. Discovery of the SOVD Gateway by the Backend

> 尽管如此，通过抽象出后端连接的某个后端连接功能块，可以实现一种相对简单的解决方案，该功能块将 SOVD 请求路由到 SOVD 网关。后端可以发现 SOVD 网关。

Connectivity function block can be accomplished by using mDNS, while routing can be realized by HTTP forwarding.

> 可以通过使用 mDNS 来完成连接功能块，而路由可以通过 HTTP 转发实现。

3. # SOVD use cases

   1. ## SOVD use cases

This chapter focuses on describing how SOVD use cases on level of a Diagnostic Server Instance are designed and achieved.

> 本章节重点描述了 SOVD 如何在诊断服务器实例层面上设计和实现使用案例。

## SOVD differentiation and new use-cases

A big portion of the SOVD use cases can be mapped in a straightforward fashion to existing UDS use cases. How this mapping has been done in the context of the Diagnostic manager is displayed in SWS Diagnostics.

> 大部分 SOVD 用例可以直接映射到现有的 UDS 用例。在诊断管理器的上下文中，这种映射是如何完成的，可以在 SWS 诊断中查看。

For cases matching UDS (ISO 14229-1) one of the main principles was introduced: Reuse of the same port instance as used for the corresponding UDS service. This is especially convenient for designing applications since no further ports need to be integrated with redundant functionality. Also, for these kinds of implementations the same rules regarding reentrancy and parallel execution as for UDS apply.

> 对于匹配 UDS（ISO 14229-1）的情况，引入了一个主要原则：重用与相应 UDS 服务相同的端口实例。这对设计应用程序特别方便，因为无需集成具有冗余功能的其他端口。此外，对于这类实现，与 UDS 相同的重入性和并行执行规则也适用。

SOVD handling of some use-cases may be sufficiently different from their UDS coun- terparts requiring differentiated requirements and mechanisms.

> SOVD 处理某些用例的方式可能与其 UDS 对应物有很大不同，因此需要不同的要求和机制。

Also, in terms of methodology these SOVD methods are adopting the existing config- uration mechanism by using DEXT and only extending the DEXT at certain needed place. This matching has been done in the following way:

> 这些 SOVD 方法采用现有的配置机制，使用 DEXT 并在某些需要的地方进行扩展。该匹配的方式如下：

- SOVD data are derived from DiagnosticDataIdentifier
- SOVD configuration are derived from DiagnosticDataIdentifier
- SOVD operation are derived from DiagnosticRoutine
- SOVD fault are derived from DiagnosticTroubleCodeUDS

Since DiagnosticDataIdentifier are used for both SOVD data and configuration the stan- dardized categories SOVD_CONFIGURATION and SOVD_DATA were introduced.

> 由于诊断数据标识符用于 SOVD 数据和配置，因此引入了标准化类别 SOVD_CONFIGURATION 和 SOVD_DATA。

Besides these configurable methods also two standardized modes have been intro- duced which match the existing ISO 14229-1 services 0x28 CommunicationControl and 0x85 ControlDTCSettings.

> 除了这些可配置的方法，还引入了两种标准模式，它们与现有的 ISO 14229-1 服务 0x28 CommunicationControl 和 0x85 ControlDTCSettings 匹配。

The static meta data needed for SOVD are derived from semantically corresponding DEXT and Manifest attributes. Details of this mapping is listed in the SWS_Diagnostics and in the TPS_Manifest.

> 静态元数据需要 SOVD 是从语义相对应的 DEXT 和 Manifest 属性中派生出来的。这种映射的细节列在 SWS_Diagnostics 和 TPS_Manifest 中。

For the dynamic data which is passed from application to the Diagnostic Master an interpretation must be done by the Diagnostic Master. This is a big contradiction to the UDS (ISO 14229-1) solution, where the Diagnostic Manager could simply pass the data towards the tester, which in return was parameterized. These dynamic data are

> 对于从应用程序传递给诊断主机的动态数据，诊断主机必须进行解释。这与 UDS（ISO 14229-1）解决方案形成了很大的矛盾，其中诊断管理器可以简单地将数据传递给测试者，而测试者则进行了参数化。这些动态数据

expressed in the DEXT by DiagnosticDataElements. For expressing the data interpre- tation the compuMethod within the SwDataDefProps of the DiagnosticDataElement is used. The Diagnostic Manager must then use this compuMethods to convert the byte stream from the application to valid SOVD JSON for the SOVD client and vice versa. Details on how this conversion shall be done is expressed in SWS_Diagnostics.

> 在诊断数据元的 DEXT 中表达。为了表达数据解释，诊断数据元的 SwDataDefProps 中的 compuMethod 被使用。然后，诊断管理器必须使用这个 compuMethods 将应用程序的字节流转换为 SOVD 客户端的有效 SOVD JSON，反之亦然。有关如何执行此转换的详细信息，请参阅 SWS_Diagnostics。

### SOVD specific use cases

Use cases that are exclusively for SOVD and find no match in ISO 14229-1 are also supported by the Diagnostic Manager. For these use cases new interfaces are intro- duced to the Diagnostic Manager that are exclusively used by SOVD. Currently two new interfaces have been introduced for Authorization and Proximity Challenge.

> 使用案例仅针对 SOVD 且在 ISO 14229-1 中没有匹配项也受诊断管理器的支持。为了这些使用案例，新的接口被引入到诊断管理器中，这些接口仅由 SOVD 使用。目前已经引入了两个新接口，用于授权和接近挑战。

Additionally, the SOVD use case data-lists is handled by the Diagnostic Manager na- tively. Further SOVD specific use cases will be added in further releases.

> 此外，SOVD 使用案例数据列表由诊断管理器本地处理。在以后的版本中将添加更多 SOVD 特定的用例。

### Authorization

Authorization in SOVD is handled using OAuth tokens that are part of the request header. When a request with OAuth token is received, the Diagnostic Manager uses the interface SovdAuthorization to request the encoded authorization role from the application. With this authorization role the Diagnostic Manager can determine whether the SOVD Client is authorized to perform the requested SOVD.

> 授权在 SOVD 中使用 OAuth 令牌作为请求头部的一部分来处理。当收到带有 OAuth 令牌的请求时，诊断管理器会使用接口 SovdAuthorization 请求从应用程序获取的编码授权角色。通过这个授权角色，诊断管理器可以确定 SOVD 客户端是否被授权执行所请求的 SOVD。

For the underlying roles, the existing DEXT model for Service 0x29 of ISO 14229-1 is used. Meaning the DiagnosticAuthRoles as well as the relation between Diagnostic AccessPermission and the individual SOVD methods (which have been mapped to the existing services as described in the SOVD section of the Diagnostic Manager).

> 对于基础角色，使用 ISO 14229-1 服务 0x29 的现有 DEXT 模型。这意味着诊断认证角色以及诊断访问权限与各个 SOVD 方法之间的关系（这些方法已按照诊断管理器的 SOVD 部分描述的方式映射到现有服务）。

## Proximity Challenge

SOVD proximity challenge is used by the SOVD server to challenge the client for prove of proximity before executing a SOVD operation. For this challenge, the new interface SovdProximityChallenge was introduced that hands the challenge procedure to the application and informs the Diagnostic Manager about the result. Based on the result the Diagnostic Manager will then perform the operation.

> SOVD 近邻挑战被 SOVD 服务器用于在执行 SOVD 操作之前向客户端提出接近性验证的挑战。为此，引入了新的接口 SovdProximityChallenge，将挑战程序交给应用程序，并向诊断管理器通报结果。根据结果，诊断管理器将执行操作。

The configuration whether a SOVD operation does require a proximity challenge or not is also done by DEXT using a special data group (SDG). For details of this SDG see SWS_Diagnostics

> 配置是否需要 SOVD 操作近距离挑战也由 DEXT 使用特殊数据组（SDG）来完成。有关此 SDG 的详细信息，请参阅 SWS_Diagnostics。

## Limitations

- Identification of SW Clusters associated to SOVD entities.

- Deployment of routine and data elements deployed for UDS identified and asso- ciated to SOVD resources (SOVD/ASAM recommends but does not require that for elements exposed in SOVD and UDS that there should be a 1:1 mapping between a UDS service deployment and a SOVD resource).

> 部署 UDS 所确定的例行程序和数据元素，并与 SOVD 资源关联（SOVD/ASAM 建议，但不要求 SOVD 和 UDS 中公开的元素之间应该有 1:1 的映射，即 UDS 服务部署和 SOVD 资源之间应该有 1:1 的映射）。

1. ## Unsupported use cases

> ## 不支持的使用案例

With step I of the implementation of SOVD in AUTOSAR Adaptive, the mandatory SOVD features will be supported. In step 2, the optional use cases are planned to be added in R23-11.

> 随着 AUTOSAR Adaptive 中 SOVD 实施的第一步，将支持强制性的 SOVD 功能。在第二步中，计划在 R23-11 中添加可选用例。

# Example

As an example, providing all fault memory entries of a single ECU could be mentioned or even the fault memory entries of the entire vehicle.

> 例如，可以提及单个 ECU 的所有故障内存条目，甚至整车的故障内存条目。

---

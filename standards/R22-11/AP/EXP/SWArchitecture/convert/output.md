---
tip: translate by openai@2023-06-23 12:52:36
...

- [Building Block View](#building-block-view)
  - [Overview](#overview)
    - [Description pattern](#description-pattern)
  - [Runtime](#runtime)
    - [Execution Management](#execution-management)
    - [State Management](#state-management)
    - [Log and Trace](#log-and-trace)
    - [Core](#core)
    - [Operating System Interface](#operating-system-interface)
  - [Communication](#communication)
    - [Communication Management](#communication-management)
    - [Network Management](#network-management)
    - [Time Synchronization](#time-synchronization)
  - [Storage](#storage)
    - [Persistency](#persistency)
  - [Security](#security)
    - [Cryptography](#cryptography)
- [Runtime View](#runtime-view)
  - [Vehicle Software Deployment](#vehicle-software-deployment)
  - [Deployment of Software Packages on a Machine](#deployment-of-software-packages-on-a-machine)
- [Cross-cutting Concepts](#cross-cutting-concepts)
  - [Overview of Platform Entities](#overview-of-platform-entities)
  - [Function Group](#function-group)
  - [Function Group State](#function-group-state)
  - [Software Cluster](#software-cluster)
  - [Machine](#machine)
  - [Manifest](#manifest)
  - [Application Design](#application-design)
  - [Execution Manifest](#execution-manifest)
  - [Error Handling](#error-handling)
  - [Trusted Platform](#trusted-platform)
  - [Secure Communication](#secure-communication)
- [Risks and Technical Debt](#risks-and-technical-debt)
    - [Risk List](#risk-list)
  - [Technical Debt](#technical-debt)
- [References](#references)

# Contents

# Introduction

This explanatory document provides detailed technical description of the software ar- chitecture of the AUTOSAR Adaptive Platform standard with the main focus on the architecture model.

> 这份说明文件详细描述了 AUTOSAR Adaptive Platform 标准的软件架构，重点介绍了架构模型。

## Objectives

This document is an architecture description of the AUTOSAR Adaptive Platform in accordance to \[[1](#_bookmark323), ISO/IEC 42010\] and has the following main objectives:

- Identify the **stakeholders** of the AUTOSAR Adaptive Platform and their **concerns**.
- Identify the **system scope** and provide **overview information** of the AUTOSAR Adaptive Platform.
- Provide definitions for all used **architecture viewpoints** and a **mapping of all stakeholder concerns to those viewpoints**.
- Provide an **architecture view** and its **architecture models** for each architecture viewpoint used in this architecture description.
- Provide **correspondence rules** and **correspondences** among the contents of this architecture description.
- Provide an **architecture rationale** (explanation, justification, reasoning for de- cisions made) on a high level. A more in-depth documentation of decisions is provided in \[[2](#_bookmark324), EXP_SWArchitecturalDecisions\].
- Provide a **record of known inconsistencies and gaps** among the architecture description.

> 本文档是根据[1]和 ISO/IEC 42010 的自适应 AUTOSAR 平台的架构描述，具有以下主要目标：
>
> - 确定 Autosar 自适应平台的**利益相关者**及其**concerns**。
> - 识别系统范围并提供 AUTOSAR Adaptive Platform 的概览信息。
> - 为所有使用的**架构视图**提供定义，并将所有利益相关者的关切与这些视图建立映射关系。
> - 提供用于此架构描述的每个架构视图的**架构视图**及其**架构模型**。
> - 提供本体结构描述中内容之间的**对应规则**和**对应关系**。
> - 提供一个**架构基础**(解释、理由、决定的原因)的高水平概述。更详细的决定文档可以在 [2] 中找到。
> - 在体系结构描述中提供已知不一致和差距的记录。

There is some potential for ambiguity about the term \"architecture\". Association with this term is quite different e.g., for a mass production project in contrast with Adap- tive Platform standardization. For system development of an automotive embedded computer the software architecture usually defines the details of the structural and the behavioral architecture views down to module level. In contrast the architecture of AU- TOSAR Adaptive Platform lacks such details deliberately to provide more degrees of freedom for stack vendors in their solution design.

> 有关“架构”一词存在一定的模糊性。与这一术语的联想在大规模生产项目与 Adaptive Platform 标准化之间存在很大的不同。对于汽车嵌入式计算机的系统开发，软件架构通常定义结构和行为架构视图的细节，直至模块级别。相比之下，AUTOSAR Adaptive Platform 的架构故意缺乏这样的细节，以为堆栈供应商在其解决方案设计中提供更多的自由度。

Beyond the specification of APIs the term \"architecture\" for Adaptive Platform refers to guidelines how to apply the standard to concrete development projects.

> 超出 API 规范，“架构”对于自适应平台的含义是指如何将标准应用于具体开发项目的指导方针。

This document describes the original architectural design of the AUTOSAR Adaptive Platform including details how the building blocks should interact with each other. It is an example how an implementation of the standard should work internally. However, a stack vendor is free to choose another design as long as it complies with the binding AUTOSAR Adaptive Platform standard.

> 这份文件描述了 AUTOSAR Adaptive Platform 的原始架构设计，包括构建块应该如何相互交互的细节。它是标准实施的一个示例，但是堆栈供应商可以选择另一种设计，只要它符合约束的 AUTOSAR Adaptive Platform 标准即可。

1. **Scope**

This explanatory document applies to the AUTOSAR Adaptive Platform. It is recom- mended to get an overview of the AUTOSAR Adaptive Platform for all members of the working groups, stack vendors, and application developers.

> 这份说明文件适用于 AUTOSAR Adaptive 平台。建议所有工作小组成员、堆栈供应商和应用程序开发人员都对 AUTOSAR Adaptive 平台有一个概览。

2. **Document Structure**

This document is organized as follows. Section [4](#_bookmark8) provides an overview of the main requirements for the AUTOSAR Adaptive Platform, the top quality goals of its architec- ture, and a list of stakeholders that are affected by it. Section [5](#_bookmark12) lists requirements that constrain design and implementation decisions or decisions about the development process.

> 此文档的组织结构如下：第 4 节提供了 AUTOSAR Adaptive Platform 的主要要求、其架构的最高质量目标以及受其影响的利益相关者列表。第 5 节列出了限制设计和实施决策或关于开发过程的决策的要求。

Section [6](#_bookmark15) is the base for discovering trade-offs and sensitivity points in the architecture of the AUTOSAR Adaptive Platform by introducing a quality attribute tree followed by the most important quality scenarios. The system context in which the AUTOSAR Adaptive Platform is intended to be used is outlined in section [7](#_bookmark21). Section [8](#_bookmark40) summarizes the fundamental decisions and solution strategies, that shape the architecture of the AUTOSAR Adaptive Platform such as technology decisions or architectural patterns to be used.

> 第 [6] 节通过引入质量属性树以及最重要的质量场景，为发现 AUTOSAR Adaptive Platform 架构中的折衷点和敏感点提供了基础。第 7 节概述了 AUTOSAR Adaptive Platform 被预期用于的系统上下文。第 8 节总结了形成 AUTOSAR Adaptive Platform 架构的基本决策和解决方案，如技术决策或要使用的体系结构模式。

Sections [9](#building-block-view) to [12](#_bookmark293) explain the software architecture from different view points. First, sec- tion [9](#building-block-view) explains the decomposition of the AUTOSAR Adaptive Platform into Functional Clusters and their interdependencies. Then, section [11](#runtime-view) demonstrates how the main use cases are realized using the Functional Clusters in the AUTOSAR Adaptive Plat- form. Section [12](#_bookmark293) shows different scenarios how applications based on the AUTOSAR Adaptive Platform may be deployed.

> 章节[9]到[12]解释了不同视角下的软件架构。首先，第[9]节解释了 AUTOSAR Adaptive Platform 的分解成功能簇及其相互依赖性。然后，第[11]节演示了如何使用 AUTOSAR Adaptive Platform 中的功能簇来实现主要用例。第[12]节展示了基于 AUTOSAR Adaptive Platform 的应用程序可以如何部署的不同场景。

Section [13](#cross-cutting-concepts) provides an overview of concepts and patterns used by the AUTOSAR Adaptive Platform. Section [14](#risks-and-technical-debt) lists and rates risks associated with the architecture of the AUTOSAR Adaptive Platform and technical debt.

> 章节[13]提供了 AUTOSAR Adaptive Platform 使用的概念和模式的概述。章节[14]列出并评估了 AUTOSAR Adaptive Platform 架构相关的风险和技术债务。

2. **Definition of Terms and Acronyms**

2.1. **Acronyms and Abbreviations**

```
---
**Abbreviation / Acronym**   **Description**
---
DoIP                         Diagnostics over Internet Protocol
POSIX                        Portable Operating System Interface
SecOC                        AUTOSAR Secure Onboard Communication
TLS                          Transport Layer Security
UML                          Unified Modeling Language
------------------------------------------------------
```

2.2. **Definition of Terms**

This section lists terms that are specific to this document. A list of general terms for AUTOSAR is provided in the \[[3](#_bookmark325), glossary\].

> 此部分列出了专用于此文件的术语。 AUTOSAR 的一般术语列表可在[3]，词汇表中找到。

```

```

2.3. **Related Documentation**

This document provides a high-level overview of the AUTOSAR Adaptive Platform ar- chitecture. It is closely related to general requirements for AUTOSAR Adaptive Plat- form specified in \[[4](#_bookmark326), RS_Main\] and \[[5](#_bookmark327), RS_General\], and the architectural decisions documented in \[[2](#_bookmark324), EXP_SWArchitecturalDecisions\].

> 此文档提供了 AUTOSAR Adaptive Platform 架构的高级概述。它与[4]，RS_Main 和[5]，RS_General 中指定的 AUTOSAR Adaptive Platform 的一般要求以及[2]，EXP_SWArchitecturalDecisions 中记录的架构决策密切相关。

The individual building blocks of the architecture (Functional Clusters) are spec- ified in separate documents. Each Functional Cluster defines one or more requirements specification(s) (RS document), one or more software specification(s) (SWS document) and one or more explanatory document(s) (EXP document). Please refer to these documents for any details on the AUTOSAR Adaptive Platform standard.

> 软件架构的个体组件(功能群)在单独的文档中进行规定。每个功能群定义一个或多个需求规范(RS 文档)、一个或多个软件规范(SWS 文档)和一个或多个解释文档(EXP 文档)。有关 AUTOSAR Adaptive Platform 标准的任何细节，请参阅这些文档。

4. []{#\_bookmark8 .anchor}**Overview and Goals**

> **概览和目标**

In conventional automotive systems ECUs are used to replace or augment electro- mechanical systems. Those resource constrained, deeply-embedded ECUs typically perform basic control functions by creating electrical output signals (e.g. for actors) based on input signals (e.g. from sensors) and information from other ECUs con- nected to the vehicle network. Much of the control software is specifically designed and implemented for the target vehicle and does not change significantly during vehi- cle lifetime. The AUTOSAR Classic Platform standard addresses the needs of these deeply-embedded systems.

> 在传统汽车系统中，ECU 用于取代或增强电子机械系统。这些资源受限的深度嵌入式 ECU 通常通过根据输入信号(例如来自传感器)和来自连接到车辆网络的其他 ECU 的信息来执行基本控制功能(例如创建电气输出信号)。大部分控制软件是专门为目标车辆设计和实施的，在车辆使用寿命期间不会显着改变。 AUTOSAR Classic Platform 标准解决了这些深度嵌入式系统的需求。

Recent and future vehicle functions, such as highly automated driving, will introduce complex and computing resource demanding software that shall fulfill strict safety, in- tegrity and security requirements. Such software performs for example, environment perception and behavior planning, and interacts with external backend and infrastruc- ture systems. The software in the vehicle regularly needs to be updated during the life-cycle of the vehicle, due to evolving external systems, improved or added function- ality, or security problems. The AUTOSAR Classic Platform standard cannot fulfill the needs of such systems. Therefore, AUTOSAR specifies a second software platform, the AUTOSAR Adaptive Platform. It provides high-performance computing and com- munication mechanisms as well as a flexible software configuration, for example, to support software update over-the-air. Features that are specifically defined for the AU- TOSAR Classic Platform, such as access to electrical signals and automotive specific bus systems, can be integrated into the AUTOSAR Adaptive Platform but is not in the focus of standardization.

> 近期和未来的车辆功能，如高度自动驾驶，将引入复杂且计算资源要求严格的安全、完整性和安全性要求的软件。例如，该软件执行环境感知和行为规划，并与外部后端和基础设施系统进行交互。车辆中的软件在车辆的使用寿命中需要定期更新，以应对演变的外部系统、改进或添加功能，或安全问题。AUTOSAR Classic Platform 标准无法满足这些系统的需求。因此，AUTOSAR 指定了第二个软件平台，即 AUTOSAR Adaptive Platform。它提供了高性能计算和通信机制，以及灵活的软件配置，例如支持软件空中更新。特别为 AUTOSAR Classic Platform 定义的功能，如访问电信号和汽车特定总线系统，可以集成到 AUTOSAR Adaptive Platform 中，但不是标准化的重点。

1. []{#\_bookmark9 .anchor}**Requirements Overview**

> **概述要求**

This section provides an overview of the basic requirements for the AUTOSAR Adap- tive Platform that impact its architecture. The corresponding requirement identifiers are provided in square brackets. Please refer to \[[4](#_bookmark326), RS_Main\] and \[[5](#_bookmark327), RS_General\] for any details, rationale or intended use-cases of these requirements.

> 这一部分概述了对 AUTOSAR 自适应平台架构有影响的基本要求，相应的要求标识符用方括号括起来。有关这些要求的任何细节、基本原理或预期用例，请参考[4，RS_Main]和[5，RS_General]。

**Support of state-of-the-art Technology**

> 支持最先进的技术

The AUTOSAR Adaptive Platform aims to support resource-intensive (memory, cpu) applications on state-of-the-art hardware. Therefore, the AUTOSAR Adaptive Platform shall support high performance computing platforms \[RS_Main_00002\] as well as vir- tualized environments \[RS_Main_00511\]. The AUTOSAR Adaptive Platform shall be able to run multiple applications in parallel \[RS_Main_00049\], each with concurrent application internal control flows \[RS_Main_00050\].

> AUTOSAR 自适应平台旨在支持在最新硬件上的资源密集型(内存、CPU)应用程序。因此，AUTOSAR 自适应平台应支持高性能计算平台\[RS_Main_00002\]以及虚拟化环境\[RS_Main_00511\]。AUTOSAR 自适应平台应能够并行运行多个应用程序\[RS_Main_00049\]，每个应用程序都具有并发的应用内控制流\[RS_Main_00050\]。

**Software Update and Configuration**

> 软件更新与配置

The AUTOSAR Adaptive Platform shall support a flexible (configuration) data and soft- ware update. Hereby, AUTOSAR Adaptive Platform shall support up- and download of such update packages \[RS_Main_00650\] and change of communication and applica- tion software at runtime \[RS_Main_00503\].

> AUTOSAR Adaptive Platform 需要支持灵活的(配置)数据和软件更新。因此，AUTOSAR Adaptive Platform 需要支持这些更新包的上传和下载[RS_Main_00650]以及运行时更改通信和应用程序软件[RS_Main_00503]。

AUTOSAR shall provide a unified way to describe software systems deployed to Adaptive and / or Classic platforms \[RS_Main_00161\]. That kind of description shall also support the deployment and reallocation of AUTOSAR Application Software \[RS_Main_00150\], and shall provide means to describe interfaces of the entire system \[RS_Main_00160\].

> AUTOSAR 将提供一种统一的方式来描述部署到自适应和/或经典平台上的软件系统[RS_Main_00161]。这种描述也将支持 AUTOSAR 应用软件的部署和重新分配[RS_Main_00150]，并且提供描述整个系统接口的手段[RS_Main_00160]。

**Security**

The AUTOSAR Adaptive Platform shall support the development of secure systems \[RS_Main_00514\] with secure access to ECU data and services \[RS_Main_00170\], and secure onboard communication \[RS_Main_00510\].

> AUTOSAR Adaptive 平台应支持开发安全系统[RS_Main_00514]，提供 ECU 数据和服务的安全访问[RS_Main_00170]，并实现安全的机载通信[RS_Main_00510]。

**Safety**

The AUTOSAR Adaptive Platform shall support the development of safety related systems \[RS_Main_00010\] that are reliable \[RS_Main_00011\] and highly available \[RS_Main_00012\]. The AUTOSAR Adaptive Platform specifications shall be analyz- able and support methods to demonstrate the achievement of safety related properties accordingly \[RS_Main_00350\].

> AUTOSAR 自适应平台应支持开发可靠[RS_Main_00011]和高可用性[RS_Main_00012]的安全相关系统[RS_Main_00010]。AUTOSAR 自适应平台规范应可分析，并且支持相应的方法以证明安全相关属性的实现[RS_Main_00350]。

**Reuse and Interoperability**

> 重复使用和互操作性

The AUTOSAR Adaptive Platform shall support standardized interoperability with non-AUTOSAR software \[RS_Main_00190\] as well as (source code) portability for AUTOSAR Adaptive Applications across different implementations of the platform \[RS_AP_00111\]. Hereby, the AUTOSAR Adaptive Platform shall provide means to describe a component model for application software \[RS_Main_00080\], and support bindings for different programming languages \[RS_Main_00513\].

> AUTOSAR 自适应平台应支持与非 AUTOSAR 软件的标准互操作性[RS_Main_00190]，以及跨不同实现的 AUTOSAR 自适应应用程序的(源代码)可移植性[RS_AP_00111]。因此，AUTOSAR 自适应平台应提供描述应用软件组件模型的手段[RS_Main_00080]，并支持不同编程语言的绑定[RS_Main_00513]。

**Communication**

The AUTOSAR Adaptive Platform shall support standardized automotive communica- tion protocols \[RS_Main_00280\] for intra ECU communication \[RS_Main_01001\] with different network topologies \[RS_Main_00230\].

> AUTOSAR Adaptive 平台应支持标准汽车通信协议[RS_Main_00280]用于 ECU 内部通信[RS_Main_01001]，支持不同的网络拓扑[RS_Main_00230]。

**Diagnostics**

The AUTOSAR Adaptive Platform shall provide diagnostics means during runtime for production and services purposes \[RS_Main_00260\].

> AUTOSAR 自适应平台应在运行时为生产和服务目的提供诊断手段[RS_Main_00260]。

2. []{#\_bookmark10 .anchor}**Quality Goals**

> **质量目标**

This section will list the top quality goals for the architecture whose fulfillment is of highest importance to the major stakeholders in a future version of this document. Please refer to the currently un-prioritized list of Quality Attributes in Section [6.1](#_bookmark16).

> 本节将列出架构的最高质量目标，其实现对未来版本本文档的主要利益相关者至关重要。请参阅[6.1](＃\_bookmark16)节中尚未优先排序的质量属性列表。

3. []{#\_bookmark11 .anchor}**Stakeholders**

> **干系人**

This section lists the stakeholders of the AUTOSAR Adaptive Platform architecture and their main expectations.

> 这一节列出了 AUTOSAR 自适应平台架构的利益相关者及其主要期望。

```

```

**Table 4.1: Stakeholder table with roles and expectations**

> 表 4.1：角色和期望的干系人表

5. []{#\_bookmark12 .anchor}**Architecture Constraints**

> **架构约束**

AUTOSAR is a worldwide development partnership of vehicle manufacturers, suppli- ers, service providers and companies from the automotive electronics, semiconductor and software industry. AUTOSAR standardizes the AUTOSAR Adaptive Platform au- tomotive middleware. The AUTOSAR Adaptive Platform is not a concrete implemen- tation. The AUTOSAR Adaptive Platform standard leaves a certain degree of freedom to implementers of the standard, as most standards do. On the one hand, more free- dom enables competition among the different implementations and a broader choice of properties for users of the AUTOSAR Adaptive Platform. On the other hand, a more strict standardization makes the different implementations compatible and exchange- able (within the standardized scope). Naturally, those attributes are in conflict. It is usually a choice of the standardization organization to evaluate the attributes and de- fine the desired level of strictness.

> AUTOSAR 是一个全球性的汽车制造商、供应商、服务提供商和汽车电子、半导体和软件行业公司的发展合作伙伴关系。AUTOSAR 标准化了 AUTOSAR 自适应平台汽车中间件。AUTOSAR 自适应平台不是一个具体的实现。AUTOSAR 自适应平台标准给实施者提供了一定程度的自由，就像大多数标准一样。一方面，更多的自由可以在不同的实现之间展开竞争，为 AUTOSAR 自适应平台的用户提供更多的选择。另一方面，更严格的标准化使不同的实现兼容并可交换(在标准化范围内)。自然，这些属性是相互冲突的。标准化组织通常需要评估这些属性，并确定所需的严格程度。

The AUTOSAR Classic Platform is rather strict in that sense by specifying a detailed layered software architecture imposing many constraints on its implementations. The AUTOSAR Adaptive Platform launched with a less strict approach. That less strict approach puts constraints on the AUTOSAR Adaptive Platform architecture as outlined below.

> AUTOSAR Classic Platform 在这方面非常严格，其指定了详细的分层软件架构，对实现施加了许多限制。而 AUTOSAR Adaptive Platform 则以更宽松的方式推出。这种更宽松的方式对 AUTOSAR Adaptive Platform 架构施加了限制，如下所示。

1. []{#\_bookmark13 .anchor}**Internal Interfaces**

> **内部接口**

An important architectural constraint is that only interfaces that are intended to be used by applications or interfaces that are used to extend the functionality of the AUTOSAR Adaptive Platform shall be standardized. Internal interfaces between the building blocks of the AUTOSAR Adaptive Platform shall not be standardized. This approach leaves a lot of freedom to design and optimize the internals of an AUTOSAR Adaptive Platform stack. However, it also imposes constraints on how the AUTOSAR Adaptive Platform architecture can be defined and described in this document. Also, this means that it might not be possible to use different functional clusters from different AUTOSAR Adaptive Platform stack vendors.

> 重要的架构约束是，只有那些旨在被应用程序使用或用于扩展 AUTOSAR Adaptive Platform 功能的接口才能被标准化。AUTOSAR Adaptive Platform 构建块之间的内部接口不能被标准化。这种方法为设计和优化 AUTOSAR Adaptive Platform 堆栈的内部提供了很多自由。但是，它也对如何在本文档中定义和描述 AUTOSAR Adaptive Platform 体系结构施加了约束。此外，这意味着可能无法使用来自不同 AUTOSAR Adaptive Platform 堆栈供应商的不同功能集群。

First, the existence of internal interfaces and their usage by other building blocks is in most cases a recommendation and reflects the original design approach of the authors of the standard. The same applies to any interactions described in this document that make use of such internal interfaces.

> 首先，内部接口的存在及其被其他构建块使用通常是一个建议，反映了标准作者的原始设计方法。同样适用于本文档中描述的任何使用此类内部接口的交互。

Second, some quality attributes may be hard to ensure in general by the architec- ture of the standard. Additional measures like security or safety considerations lack well-defined inputs such as data flows or specifications of interdependencies. Con- sequently, a more thorough design phase is required when an AUTOSAR Adaptive Platform stack is implemented.

> 第二，一些质量属性可能很难通过标准架构来确保。像安全或安全性考虑等额外的措施缺乏明确的输入，如数据流或相互依赖关系的规范。因此，当实施 AUTOSAR 自适应平台堆栈时，需要进行更彻底的设计阶段。

2. []{#\_bookmark14 .anchor}**Distributed Work**

> **分布式工作**

Standardization of the AUTOSAR Adaptive Platform is a worldwide distributed effort. The individual building blocks are specified by dedicated working groups in separate documents to be able to scale in that distributed setup. This impacts the way the AUTOSAR Adaptive Platform architecture is described in this document.

> 标准化 AUTOSAR 自适应平台是一项全球性的分布式努力。各个构建模块由专门的工作组在独立的文件中指定，以便在分布式环境中进行缩放。这会影响本文档中 AUTOSAR 自适应平台体系结构的描述。

First, this document shows interfaces on an architectural level only. This document does not specify details of interfaces such as individual operations. This keeps redun- dancies and thus dependencies between this document and the documents actually specifying the individual building blocks manageable. Another consequence is that the interactions shown in this document are not based on actual operations specified in the interfaces but rather on an architectural level as well.

> 首先，本文件仅以架构层面显示接口。本文件不指定接口的详细信息，如单独操作。这样可以保持冗余并且使本文件与实际指定各个构建块的文件之间的依赖性可控制。另一个结果是，本文件中显示的交互不是基于实际操作指定的接口，而是以架构层面。

Second, this document aims to provide guidance for the working groups in specify- ing the individual building blocks by defining patterns and concepts to solve common problems. This guidance should help to build a uniform and consistent standard from ground up.

> 第二，本文件旨在为工作组提供指导，以通过定义模式和概念来解决常见问题来确定各个构建块。这种指导应有助于从基础建立统一和一致的标准。

6. []{#\_bookmark15 .anchor}**Quality Requirements**

> **质量要求**

Quality requirements define the expectations of AUTOSAR Adaptive Platform stake- holders for the quality and the attributes of the AUTOSAR Adaptive Platform standard that indicate whether the quality factors are satisfied or not. Section [6.1](#_bookmark16) starts by list- ing the quality attributes that, in the end, are used to assess whether the AUTOSAR Adaptive Platform and its software architecture satisfies the expected quality factors or not. Section [6.2](#_bookmark20) then provides quality scenarios that operationalize quality attributes and turn them into measurable quantities by describing the reaction of the system to a stimulus in a certain situation.

> 质量要求定义 AUTOSAR 自适应平台参与者对质量和 AUTOSAR 自适应平台标准属性的期望，以指示质量因素是否得到满足。第 6.1 节开始列出质量属性，最终用于评估 AUTOSAR 自适应平台及其软件架构是否满足预期的质量因素。第 6.2 节提供质量场景，通过描述系统对某种情况下刺激的反应，将质量属性操作化并转化为可测量的数量。

1. []{#\_bookmark16 .anchor}**Quality Attributes**

> 质量属性

The AUTOSAR Adaptive Platform has many stakeholders with different concerns. Thus, this document uses the following three quality attribute categories that corre- spond to the three main stakeholder groups in order to make the requirements and their impact on the architecture more comprehensible:

> AUTOSAR Adaptive Platform 拥有许多具有不同关切的利益相关者。因此，本文档使用以下三个质量属性类别，以便使需求及其对架构的影响更加易懂，这三个主要利益相关者组分别如下：

- **AUTOSAR Adaptive Platform Standard:** Quality requirements for the AU- TOSAR standard itself. These requirements may directly affect the architecture of the AUTOSAR Adaptive Platform.

> -**AUTOSAR 自适应平台标准：**针对 AUTOSAR 标准本身的质量要求。这些要求可能直接影响 AUTOSAR 自适应平台的架构。

- **AUTOSAR Adaptive Platform Stack:** Quality requirements for an implementa- tion of the AUTOSAR standard as an AUTOSAR stack. These requirements may indirectly affect the architecture of the AUTOSAR Adaptive Platform.

> -**AUTOSAR 自适应平台堆栈：**对作为 AUTOSAR 堆栈实现 AUTOSAR 标准的质量要求。这些要求可能会间接影响 AUTOSAR 自适应平台的体系结构。

- **AUTOSAR Adaptive Application:** Quality requirements for an application based on an AUTOSAR stack. These requirements may transitively affect the architec- ture of the AUTOSAR Adaptive Platform.

> **AUTOSAR 自适应应用：** 基于 AUTOSAR 栈的应用程序的质量要求。这些要求可能会间接影响 AUTOSAR 自适应平台的架构。

The quality attributes are organized according to the Architecture Tradeoff Analysis Method (ATAM) \[[6](#_bookmark328)\] as a tree, one for each of the quality attribute categories. The leafs of those trees are the individual quality attributes.

> 质量属性按照架构权衡分析法(ATAM)[[6](#\_bookmark328)]组织为树状结构，每个质量属性类别一棵树。这些树的叶子是各个质量属性。

1. []{#\_bookmark17 .anchor}**AUTOSAR Adaptive Platform Standard**

> AUTOSAR 自适应平台标准

- Functional suitability

  - The software architecture shall reflect the project objectives (POs) and be the consistent source for all specifications (here: completeness with respect to the PO; see also usability below).

> 软件架构应反映项目目标(POs)，并成为所有规格的一致源(即：相对于 PO 的完整性；另见下文的可用性)。

- The standard shall not contain elements that are not traceable to POs, change requests (CRs), or concepts.

> 标准不应包含无法追溯到采购订单，变更请求(CRs)或概念的元素。

- The standard shall contain at least one element derived from each PO, CR, or concept.
- Performance efficiency

  - The specification shall allow for a run-time efficient implementation. Run- time efficiency refers to all resource consumption, CPU, RAM, ROM.

> 要求规范应允许实现运行时高效的实现。运行时效率指的是所有资源消耗，包括 CPU，RAM，ROM。

- Compatibility

  - The standard shall retain older versions of its elements in the face of change.

  - The standard shall be interoperable with pre-existing standards, especially the AUTOSAR Classic Platform. Pre-existing standards means network pro- tocols and the like.

> 标准应与现有标准互操作，特别是 AUTOSAR Classic Platform。现有标准指网络协议等。

- The standard shall adopt new versions of pre-existing standards only after an impact analysis.
- Usability

  - The use of the standard shall be as easy as possible for suppliers and appli- cation developers. Easy means: not much material and resources required.

> 使用标准应该尽可能容易，对供应商和应用程序开发者来说。容易意味着：所需的材料和资源较少。

- The holistic approach shall not be broken (avoid different approaches in one standard).
- The standard shall contain application sample code for all its elements.
- The standard shall contain documentation of the use cases for its elements.
- The standard shall document the semantics of its elements.

- The standard shall document its decisions, consequences, and implemen- tation restrictions (both for stack & apps) including their rationale.

> 标准应记录其决定、后果和实施限制(包括堆栈和应用程序)及其基本原理。

- The standards elements shall be easy to use and hard to misuse.

- The standard shall stick to pre-existing standards, as far as no functional requirements are compromised.

> 标准应遵循现有标准，只要不影响功能要求。

- The standard shall be as stable as possible.

- AUTOSAR standards shall not change disruptive but rather evolve evolution- ary (for example, backward-compatibility can be a help).

> AUTOSAR 标准不应发生破坏性变化，而应该演化(例如，向后兼容性可以提供帮助)。

- The software architecture shall reflect the PO and be the consistent source for all specifications (here: consistency; see also functional suitability above).

> 软件架构应反映 PO，并成为所有规范的一致来源(这里：一致性；参见上文的功能合适性)。

- Reliability

  - The standard shall classify its elements with respect to safety relevance (that is, functional clusters shall be marked if they participate in safety critical operations of the platform).

> 标准应根据安全相关性对其元素进行分类(即，如果功能簇参与平台的安全关键操作，则应标记该功能簇)。

- The standard shall specify control flow restrictions between its elements in order to achieve freedom from interference.

> 标准应该规定元素之间的控制流限制，以实现免受干扰的自由。

- The standard shall contain use case driven argumentation for safety sce- narios that can be used to build a safety case. (This should help the stack implementers in getting a certification, if they follow the standard.)

> 标准应包含基于用例的论证，用于构建安全案例的安全场景。(如果遵循标准，这将有助于堆栈实现者获得认证。)

- Security

  - The standard shall specify data flow restrictions between its elements, and between applications.

> 标准应规定它的元素之间以及应用程序之间的数据流限制。

- The standard shall classify its elements with respect to security sensitivity (that is, functional clusters shall be marked if they handle sensitive data.)

> 标准应根据安全敏感性对其元素进行分类(即，如果处理敏感数据，则应标记功能簇)。

- The standard shall contain use case driven argumentation for security sce- narios that can be used to build a security case. (This should help the stack implementers in getting a certification, if they follow the standard.)

> 标准应包含基于用例的安全场景论证，以便用于构建安全案例。(如果遵循标准，这将有助于堆栈实施者获得认证。)

- Maintainability

  - It shall be possible in an efficient way to maintain AUTOSAR Adaptive Plat- form without preventing the introduction of new technologies (efficient in terms of effort on the modification of the standard).

> 可以以有效的方式维护 AUTOSAR Adaptive Platform，而不会阻碍新技术的引入(在标准修改方面的努力是有效的)。

- The impact set of a change shall be available.
- The standard shall be structured in a way that minimizes change impact.
- It shall be possible to drop/deprecate elements of the standard.

- It shall be easy to add new features/needs without breaking the maintain- ability or the need to redesign the software architecture. Easy means quick, with low effort, local changes only and no heavy side effects.

> 它应该很容易添加新功能/需求而不破坏可维护性或需要重新设计软件架构。容易意味着快速，低成本，仅局部更改，没有重大的副作用。

- The maturity of parts of the standard shall be visible.

- The process shall enforce an architectural impact analysis in a very early stage of the change process.

> 过程应在变更过程的早期阶段强制执行架构影响分析。

- The process shall enforce minimizing changes, that is not adding similar functionality multiple times.

> 过程应该强制最小化更改，也就是不要多次添加类似的功能。

- Portability

  - Applications shall be portable between different stack implementations and different machines.
  - It shall be possible to scale the software architecture to the given project needs.

    1. []{#\_bookmark18 .anchor}**AUTOSAR Adaptive Platform Stack**

```{=html}
<!-- -->
```

- Compatibility

  - An AUTOSAR Adaptive Platform stack implementation shall be capable to offer multiple versions of the same service.

> 一个 AUTOSAR 自适应平台堆栈实现必须能够提供相同服务的多个版本。

- An instance of an AUTOSAR Adaptive Platform stack implementation shall be able to co-exist with other instances on different machines, within the same vehicle.

> 一个 AUTOSAR 自适应平台堆栈实施的实例可以与在同一车辆上不同机器上的其他实例共存。

- Usability

  - An AUTOSAR Adaptive Platform stack implementation shall explicitly doc- ument restrictions on the application development that go beyond the stan- dard.

> 一个 AUTOSAR 自适应平台堆栈实现应该明确文档化超出标准的应用程序开发的限制。

- Maintainability

  - An AUTOSAR Adaptive Platform stack implementation shall be traceable to the contents of the standard.

> 一个 AUTOSAR 自适应平台堆栈实现应该可以追溯到标准内容。

- An AUTOSAR Adaptive Platform stack implementation shall support multiple versions of the same service.

> 一个 AUTOSAR 自适应平台堆栈实现应该支持同一服务的多个版本。

- Portability

  - An AUTOSAR Adaptive Platform stack shall be portable to a different custom hardware.
  - An AUTOSAR Adaptive Platform stack shall provide mechanisms to replace parts.

    1. []{#\_bookmark19 .anchor}**AUTOSAR Adaptive Application**

```{=html}
<!-- -->
```

- Usability

  - _No Goal:_ An application developer shall be able to supply custom implemen- tation for pre-defined platform functionality.

> 无目标：应用程序开发人员应能够为预定义的平台功能提供自定义实现。

- Maintainability

  - An application shall explicitly state which parts of the standard it uses.

- Portability

  - An application entirely based on AUTOSAR Adaptive Platform (i.e. with- out custom extensions) shall be portable to another AUTOSAR Adaptive Platform stack of the same version without modifications to the application source code itself (source code compatibility).

> 一个完全基于 AUTOSAR Adaptive Platform(即不带自定义扩展)的应用程序应该可以在同一版本的另一个 AUTOSAR Adaptive Platform 栈上无需修改应用程序源代码(源代码兼容性)而进行移植。

1. []{#\_bookmark20 .anchor}**Quality Scenarios**

> **质量场景**

There are currently no quality scenarios defined for the AUTOSAR Adaptive Platform.

> 目前尚未为 AUTOSAR Adaptive Platform 定义任何质量场景。

7. []{#\_bookmark21 .anchor}**System Scope and Context**

> **系统范围和上下文**

This chapter provides an overview of the AUTOSAR Adaptive Platform system context by separating the AUTOSAR Adaptive Platform and its communication partners (e.g., external systems). Considering Figure [7.1](#_bookmark22), there are three categories of communica- tion partners for the AUTOSAR Adaptive Platform.

> 本章概述了 AUTOSAR Adaptive 平台系统的上下文，将 AUTOSAR Adaptive 平台及其通信伙伴(例如，外部系统)分开。考虑[7.1]图，AUTOSAR Adaptive 平台有三类通信伙伴。

![](./media/image1.png)
![](./media/image2.png)
![](./media/image1.png)
**Figure 7.1:** []{#\_bookmark22 .anchor}**Overview of AUTOSAR Adaptive Platform and its context**

The AUTOSAR Adaptive Platform is conceptually a middleware. AUTOSAR Adaptive Platform provides services to [Adaptive Application](#_bookmark24)s beyond those available from the underlying operating system, drivers, and extensions (cf. Section [7.2](#_bookmark25)). Section

> AUTOSAR Adaptive 平台在概念上是一个中间件。AUTOSAR Adaptive 平台为(参见 7.2 节)超出底层操作系统、驱动程序和扩展程序所提供的服务提供给自适应应用程序。

[7.3](#_bookmark31) describes the third category that are external systems communicating with (an

> [7.3](#\_bookmark31)描述了与之通信的第三类外部系统。

[Adaptive Application](#_bookmark24) via) AUTOSAR Adaptive Platform.

> 通过 AUTOSAR 自适应平台实现自适应应用。

1. []{#\_bookmark23 .anchor}**Adaptive Application**

> **自适应应用**

[]{#\_bookmark24 .anchor}[Adaptive Application](#_bookmark24)s are built on the functionality provided by the AUTOSAR Adaptive Platform. They directly use the various interfaces provided by the individual building blocks of AUTOSAR Adaptive Platform described in more detail in chapter [9](#building-block-view).

> 自适应应用程序建立在 AUTOSAR 自适应平台提供的功能之上。它们直接使用 AUTOSAR 自适应平台各个构建块提供的各种接口，具体内容可参见第 9 章(构建块视图)。

2. []{#\_bookmark25 .anchor}**Dependencies**

> **依赖**

1.  []{#\_bookmark26 .anchor}**Crypto Provider**

> 加密提供商

Crypto Provider is a component that provides implementations of cryptographic routines and hash functions to the AUTOSAR Adaptive Platform.

> 加密提供商是一个组件，它为 AUTOSAR 自适应平台提供加密程序和哈希函数的实现。

2. []{#\_bookmark27 .anchor}**Operating System**

> **操作系统**

[]{#\_bookmark28 .anchor}The [Operating System](#_bookmark28) is the main component that AUTOSAR Adaptive Plat- form uses to provide its services. The [Operating System](#_bookmark28) controls processes and threads, and provides inter-process communication facilities. The [Operating Sys-](#_bookmark28) [tem](#_bookmark28) also provides access to network interfaces, protocols like TCP/IP, and access to non-volatile storage.

> 操作系统是 AUTOSAR Adaptive Platform 提供服务的主要组件。操作系统控制进程和线程，并提供进程间通信设施。操作系统还提供对网络接口、TCP/IP 等协议的访问，以及对非易失性存储的访问。

3. []{#\_bookmark29 .anchor}**Watchdog**

> 监督者

[]{#\_bookmark30 .anchor}The [Watchdog](#_bookmark30) is a component to control the hardware watchdog of the machine an AUTOSAR Adaptive Platform runs on.

> 监督者(Watchdog)是一个控制 AUTOSAR Adaptive Platform 运行所在机器硬件看门狗的组件。

3. []{#\_bookmark31 .anchor}**External Systems**

> 外部系统

![](./media/image3.png)

**Figure 7.2: Overview of the AUTOSAR Adaptive Platform and external systems**

The AUTOSAR Adaptive Platform supports applications that are operated in heteroge- neous environments. This section lists the external systems that AUTOSAR Adaptive Platform is intended to interface.

> AUTOSAR Adaptive Platform 支持在异构环境中运行的应用程序。本节列出 AUTOSAR Adaptive Platform 旨在与之接口的外部系统。

1. []{#\_bookmark32 .anchor}**AUTOSAR Adaptive Application**

> **AUTOSAR 自适应应用**

There may be many [Adaptive Application](#_bookmark24)s deployed in a vehicle on different Ma- chines. An [Adaptive Application](#_bookmark24) that does not run on the current instance of the AUTOSAR Adaptive Platform is therefore an external system to the AUTOSAR Adap- tive Platform. Such [Adaptive Application](#_bookmark24)s may exchange data such as sensor or status information by means of ara::com service interfaces.

> 可能会在车辆上部署许多[自适应应用程序](#_bookmark24)，这些应用程序都运行在不同的机器上。因此，不运行在 AUTOSAR 自适应平台当前实例上的[自适应应用程序](#_bookmark24)就是 AUTOSAR 自适应平台的外部系统。这类[自适应应用程序](#_bookmark24)可以通过 ara :: com 服务接口交换数据，如传感器或状态信息。

2. []{#\_bookmark33 .anchor}**AUTOSAR Classic Platform**

> **AUTOSAR 经典平台**

[]{#\_bookmark34 .anchor}The [AUTOSAR Classic Platform](#_bookmark34) is the main platform for deeply-embedded appli- cations such as sensor/actor systems. [Adaptive Application](#_bookmark24)s may require ac- cess for example to sensor data provided by an [AUTOSAR Classic Platform](#_bookmark34) ECU and vice versa.

> AUTOSAR 经典平台是深度嵌入式应用(如传感器/执行器系统)的主要平台。自适应应用可能需要访问 AUTOSAR 经典平台 ECU 提供的传感器数据，反之亦然。

3. []{#\_bookmark35 .anchor}**Third-party Platform**

> 三方平台

Besides the both platforms (AUTOSAR Adaptive Platform and [AUTOSAR Classic](#_bookmark34) [Platform](#_bookmark34)) provided by AUTOSAR, there may be ECUs in a vehicle and other sys- tems that are built on different platforms that need to communicate with an [Adaptive](#_bookmark24) [Application](#_bookmark24) via AUTOSAR Adaptive Platform.

> 除了 AUTOSAR 提供的两个平台(AUTOSAR Adaptive Platform 和 AUTOSAR Classic Platform)外，车辆中可能还有基于不同平台构建的 ECU 和其他系统，它们需要通过 AUTOSAR Adaptive Platform 与 Adaptive Application 进行通信。

4. []{#\_bookmark36 .anchor}**Diagnostic Client**

> **诊断客户端**

[]{#\_bookmark37 .anchor}A [Diagnostic Client](#_bookmark37) uses the diagnostic services provided by the AUTOSAR Adaptive Platform.

> 一个诊断客户端使用 AUTOSAR Adaptive Platform 提供的诊断服务。

5. []{#\_bookmark38 .anchor}**Backend**

> 后端

[]{#\_bookmark39 .anchor}A [Backend](#_bookmark39) system provides Software Packages for download and controls the update process via [Update and Configuration Management](#_bookmark200).

> 系统提供软件包供下载，并通过更新和配置管理来控制更新过程。

8. []{#\_bookmark40 .anchor}**Solution Strategy**

> 解决方案策略

The AUTOSAR Adaptive Platform is a standard for an automotive middleware. It is not a concrete implementation. The AUTOSAR Adaptive Platform standard leaves a certain degree of freedom to its implementers by defining requirements and software specifications that need to be fulfilled without specifying how.

> AUTOSAR 自适应平台是一种汽车中间件标准。它不是一个具体的实现。AUTOSAR 自适应平台标准通过定义需要满足的要求和软件规范而给实施者留下一定的自由度，但没有指定具体的实现方式。

1. []{#\_bookmark41 .anchor}**Architectural Approach**

> 架构方法

To support the complex applications, while allowing maximum flexibility and scalabil- ity in processing distribution and compute resource allocations, AUTOSAR Adaptive Platform follows the concept of a service-oriented architecture (SOA). In a service- oriented architecture a system consists of a set of services, in which one may use another in turn, and applications that use one or more of the services depending on its needs. Often service-oriented architectures exhibit system-of-system characteris- tics, which AUTOSAR Adaptive Platform also has. A service, for instance, may reside on a local ECU that an application also runs, or it can be on a remote ECU, which is also running another instance of AP. The application code is the same in both cases - the communication infrastructure will take care of the difference providing transparent communication. Another way to look at this architecture is that of distributed comput- ing, communicating over some form of message passing. At large, all these represent the same concept. This message passing, communication-based architecture can also benefit from the rise of fast and high-bandwidth communication such as Ethernet.

> 为了支持复杂的应用，同时允许在处理分配和计算资源分配方面最大限度的灵活性和可扩展性，AUTOSAR Adaptive Platform 遵循服务导向架构(SOA)的概念。在服务导向架构中，系统由一组服务组成，其中一个可以反过来使用另一个，而应用程序可以根据其需求使用其中的一个或多个服务。通常，服务导向架构具有系统系统特性，AUTOSAR Adaptive Platform 也具有这些特性。例如，服务可以位于应用程序也运行的本地 ECU 上，也可以位于运行另一个 AP 实例的远程 ECU 上。应用程序代码在两种情况下是相同的 - 通信基础架构将处理差异，提供透明通信。另一种查看此架构的方法是分布式计算，通过某种形式的消息传递进行通信。总的来说，所有这些都代表相同的概念。这种基于消息传递的通信架构也可以从 Ethernet 等快速高带宽通信中受益。

2. []{#\_bookmark42 .anchor}**Decomposition Strategy**

> **分解策略**

The building blocks of the AUTOSAR Adaptive Platform architecture are refined step- by-step in this document according to the model depicted in figure [8.1](#_bookmark43). The top-level categories are chosen to give an overview from a users perspective what kind of func- tionality the AUTOSAR Adaptive Platform provides. A category contains one or more Functional Clusters. The Functional Clusters of the AUTOSAR Adaptive Platform are defined to group a specific coherent technical functionality. Functional Clusters themselves specify a set of interfaces and components to provide and real- ize that technical functionality. The building block view also contains information of the Functional Clusters interdependencies based on interfaces from other Func- tional Clusters they use. However, note that these interdependencies are recom- mendations rather than strict specifications because they would constrain implementa- tions.

> 这份文件根据图 8.1 所示的模型，逐步细化了 AUTOSAR 自适应平台体系结构的构建块。顶级类别的选择是为了让用户从宏观角度了解 AUTOSAR 自适应平台提供的功能。一个类别包含一个或多个功能集群。AUTOSAR 自适应平台的功能集群被定义为把特定的相关技术功能分组起来。功能集群本身指定一组接口和组件，以提供和实现该技术功能。构建块视图还包含基于其他功能集群使用的接口的功能集群之间相互依赖关系的信息。但是，请注意，这些相互依赖关系仅是建议，而不是严格的规范，因为它们会制约实施。

![](./media/image8.png)![](./media/image9.png)![](./media/image10.png)1..\*

**Figure 8.1:** []{#\_bookmark43 .anchor}**Type model of building blocks**

3. []{#\_bookmark44 .anchor}**UML Profile**

> **UML 轮廓**

The UML diagrams presented in this document use a UML profile to provide a more precise semantics of the elements and relationships. Table [8.1](#_bookmark45) provides an overview of the stereotypes in that profile and their semantics. The names of all stereotypes that are specific to the AUTOSAR architecture are prefixed with _aap_ (short for AUTOSAR Architecture Profile) to make them easily distinguishable from standard UML stereo- types and keywords.

> 本文档中提供的 UML 图使用 UML 配置文件来提供元素和关系的更精确的语义。表[8.1]提供了该配置文件中的特定类型的概述及其语义。所有特定于 AUTOSAR 架构的特定类型的名称都加上*aap*(AUTOSAR 架构配置文件的简称)前缀，以便与标准 UML 特定类型和关键字进行区分。

```

```

**Table 8.1: Overview of Stereotypes**

> 表 8.1：刻板印象概览

4. []{#\_bookmark46 .anchor}**Technology**

> **技术**

1.  ### Implementation Language

> ### 实施语言

C++ is the programming language of choice for the AUTOSAR Adaptive Platform and [Adaptive Application](#_bookmark24)s. C++ was chosen due to its safer programming model (compared to C) and availability of certified compilers that produce highly optimized machine code. Such properties are especially important for safety- and performance- critical, real-time applications (such as typical [Adaptive Application](#_bookmark24)s) where C++ has become more and more popular in the software industry and academics.

> C++是 AUTOSAR Adaptive 平台和[自适应应用](#_bookmark24)的编程语言。C++之所以被选择，是因为它比 C 更安全的编程模型，以及可以生成高度优化的机器码的认证编译器。这些属性对于安全性和性能关键的实时应用(如典型的[自适应应用](#_bookmark24))尤为重要，C++在软件行业和学术界越来越受欢迎。

### Parallel Processing

Although the design for AUTOSAR Adaptive Platform as a service-oriented architecture inherently leverages parallel processing, the advancement of (heterogeneous) many-

> 尽管 AUTOSAR Adaptive Platform 的设计作为面向服务的架构本质上利用并行处理，但(异构)多核处理的进展仍然是一个挑战。

core processors offers additional opportunities. The AUTOSAR Adaptive Platform is designed to scale its functionality and performance as (heterogeneous) many-core technologies advance. Hardware and platform interface specifications are one part of that equation. However, advancements in operating system and hypervisor tech- nologies as well as development tools (for example automatic parallelization) are also crucial and are to be fulfilled by AUTOSAR Adaptive Platform providers, the software industry, and academics.

> 核心处理器提供了额外的机会。AUTOSAR Adaptive 平台旨在随着(异构)多核技术的发展而扩展其功能和性能。硬件和平台接口规范是其中一部分。然而，操作系统和虚拟机技术以及开发工具(例如自动并行化)的进步也至关重要，并且由 AUTOSAR Adaptive 平台提供商、软件行业和学术界来实现。

## Design Principles

The architecture of the AUTOSAR Adaptive Platform is based on several design prin- ciples that are outlined below.

> AUTOSAR 自适应平台的架构基于以下概述的设计原则。

### Leveraging existing standards

AUTOSAR Adaptive Platform aims to leverage existing standards and specifications wherever possible. For example, AUTOSAR Adaptive Platform ist built on the existing and open C++ standard (cf. Section [8.4.1](#implementation-language)) to facilitate a faster development of the AUTOSAR Adaptive Platform itself and benefiting from the eco-systems of such stan- dards. It is, therefore, a critical focus in developing the AUTOSAR Adaptive Platform specification not to casually introduce a new replacement functionality that an existing standard already offers. For instance, no new interfaces are casually introduced just because an existing standard provides the functionality required but the interface is superficially hard to understand.

> AUTOSAR Adaptive Platform 旨在尽可能利用现有的标准和规范。例如，AUTOSAR Adaptive Platform 建立在现有的开放式 C++标准(参见第 8.4.1 节)上，以便更快地开发 AUTOSAR Adaptive Platform 本身，并从这种标准的生态系统中受益。因此，在开发 AUTOSAR Adaptive Platform 规范时，关键的重点是不要轻易地引入一种新的替代功能，因为现有的标准已经提供了所需的功能，但界面表面上很难理解。

### SOLID principles

The SOLID principles \[[7](#_bookmark329)\] are a central part of the design principles of AUTOSAR. While these five principles are all valid, only the Single-responsibility Principle, the Interface Segregation Principle and the Dependency Inversion Principle are relevant on the ab- straction level of this document. Therefore, they are elaborated in the following.

> SOLID 原则\[[7](#_bookmark329)\]是 AUTOSAR 设计原则的核心部分。虽然这五个原则都是有效的，但只有单一职责原则、接口隔离原则和依赖倒置原则与本文抽象层次有关。因此，它们将在下面进行详细阐述。

1. **Single-responsibility Principle**

> 原则：单一职责

The single-responsibility principle (SRP,SWEBOK3) \[[7](#_bookmark329)\] states that a component or class should be responsible for a single part of the overall functionality provided by the soft- ware. That responsibility should be encapsulated by the component or class. The services provided by the component or class (via its interface(s)) should be closely aligned with its responsibility.

> 原则(SRP，SWEBOK3)\[[7](#_bookmark329)\]规定，一个组件或类应该负责软件提供的整体功能的一部分。该责任应由组件或类封装。组件或类提供的服务(通过其接口)应与其责任密切相关。

The single-responsibility principle minimizes the reasons (i.e. a change to the single responsibility) that require a change to its interface. Thus, it minimizes impact on clients of such an interface and leads to a more maintainable architecture (or code).

> 原则中的单一职责最大限度地减少了需要更改其接口的原因(即对单一职责的更改)。因此，它最大限度地减少了对此类接口客户的影响，并导致更可维护的架构(或代码)。

2. **Interface Segregation Principle**

> 原则 2：接口隔离原则

The interface segregation principle (ISP) \[[7](#_bookmark329)\], \[[8](#_bookmark330)\] states that clients should not be forced to depend on methods that they don't use. As a consequence of the interface segre- gation principle, interfaces should be split up to reflect different roles of clients.

> 接口隔离原则(ISP)[[7]]，[[8]]规定客户端不应被迫依赖他们不使用的方法。作为接口分离原则的结果，接口应该被分割以反映客户端的不同角色。

Similar to the single-responsibility principle, the segregation of interfaces reduce the impact of a change to an interface to the clients and suppliers of an segregated inter- face.

> 类似于单一职责原则，接口的隔离减少了对隔离接口的客户和供应商更改的影响。

3. **Dependency Inversion Principle**

> 依赖倒置原则

The dependency inversion principle (DIP) \[[7](#_bookmark329)\], \[[8](#_bookmark330)\] states that high-level building blocks should not depend on low-level building blocks. Both should depend on abstractions (e.g. interfaces). Furthermore, the dependency inversion principle states that abstrac- tions (e.g. interfaces) should not depend on details. Details (e.g. a concrete imple- mentation) should depend on abstractions.

> 原则依赖倒置(DIP)[[7]]，[[8]]规定高层构件不应依赖低层构件。两者都应该依赖抽象(例如接口)。此外，依赖倒置原则规定抽象(例如接口)不应依赖细节。细节(例如具体实现)应该依赖抽象。

The dependency inversion principle results in a decoupling of the implementations of building blocks. This is important to scale implementation efforts (cf. Section [5.2](#_bookmark14)) and to perform proper integration tests.

> 依赖倒置原则导致构建模块实现的解耦。这对于扩展实施努力(参见第 5.2 节)和进行正确的集成测试是非常重要的。

### Acyclic Dependencies Principle

The acyclic dependencies principle (ADP) \[[7](#_bookmark329)\], \[[8](#_bookmark330)\] states that dependencies between building blocks should form a directed acyclic graph.

> 原则(ADP)[[7]](＃\_bookmark329)，[[8]](＃\_bookmark330)规定，构建块之间的依赖关系应形成有向无环图。

The acyclic dependencies principle helps to identify participating building blocks and reason about error propagation and freedom from interference. In general, it also re- duces the extend of building blocks to consider during activities such as test, build and deployment.

> 原则的无环依赖有助于识别参与组件，并考虑错误传播和免受干扰。一般来说，它也减少了组件的范围，以便在测试、构建和部署等活动中考虑。

## Deployment

The AUTOSAR Adaptive Platform supports the incremental deployment of applica- tions, where resources and communications are managed dynamically to reduce the effort for software development and integration, enabling short iteration cycles. Incre- mental deployment also supports explorative software development phases. For prod- uct delivery, the AUTOSAR Adaptive Platform allows the system integrator to carefully

> AUTOSAR 自适应平台支持应用程序的增量部署，其中资源和通信被动态管理以减少软件开发和集成的工作量，实现短迭代周期。增量部署也支持探索性的软件开发阶段。对于产品交付，AUTOSAR 自适应平台允许系统集成商仔细地构建和部署系统。

limit dynamic behavior to reduce the risk of unwanted or adverse effects allowing safety qualification. Dynamic behavior of an application will be limited by constraints stated in the Execution Manifest (cf. Section [13.8](#execution-manifest)), for example, dynamic allocation of resources and communication paths are only possible in defined ways, within config- ured ranges. Implementations of an AUTOSAR Adaptive Platform may further remove dynamic capabilities from the software configuration for production use. Examples of reduced behavioral dynamics might be:

> 限制动态行为以减少不希望或不良效果的风险，从而允许安全资格认证。应用程序的动态行为将由执行清单(参见[13.8]节)中指定的约束所限制，例如，资源和通信路径的动态分配仅能以定义的方式，在配置的范围内进行。 AUTOSAR 自适应平台的实现可能进一步从软件配置中删除动态能力，以供生产使用。减少行为动态性的示例可能包括：

- Pre-determination of the service discovery process
- Restriction of dynamic memory allocation to the startup phase only
- Fair scheduling policy in addition to priority-based scheduling
- Fixed allocation of processes to CPU cores
- Access to pre-existing files in the file-system only
- Constraints for AUTOSAR Adaptive Platform API usage by applications
- Execution of authenticated code only

  1. ## Verification and Validation

> ## 验证与验证

The AUTOSAR Adaptive Platform standard uses a dedicated implementation of the standard (AUTOSAR Adaptive Platform Demonstrator) to validate the requirements and to verify the (still abstract) software design imposed by the individual software specifications.

> AUTOSAR Adaptive Platform 标准使用一个专用的标准实现(AUTOSAR Adaptive Platform Demonstrator)来验证要求并验证由单个软件规范强加的(仍然抽象的)软件设计。

# Building Block View

This chapter provides an overview of the static structure of the AUTOSAR Adaptive Platform by describing the high-level building blocks and their inter-dependencies. Please note that the use of interfaces between Functional Clusters in the AU- TOSAR Adaptive Platform is currently not standardized. Some aspects, for example, access management, are also not yet fully incorporated and standardized in all Func- tional Clusters.

> 本章概述了 AUTOSAR Adaptive Platform 的静态结构，描述了高级构建块及其相互依赖关系。请注意，AUTOSAR Adaptive Platform 中功能簇之间的接口使用目前尚未标准化。一些方面，例如访问管理，在所有功能簇中尚未完全纳入和标准化。

## Overview

Figure [9.1](#_bookmark57) provides an overview of the different categories of building blocks available in the AUTOSAR Adaptive Platform. The categories are explained in more detail in the subsequent sections.

> 图 9.1 提供了 AUTOSAR Adaptive 平台可用的不同类别的构建块的概述。在随后的部分中将对这些类别进行更详细的解释。

**Figure 9.1:** []{#\_bookmark57 .anchor}**Overview of the AUTOSAR Adaptive Platform and its building block cate- gories**

### Description pattern

The description of all building blocks (FunctionalClusters) in this section uses the same pattern. Each FunctionalCluster is described in a separate section of the document. Such a section starts with an overview of the responsibilities of the FunctionalCluster followed by a sub-section called \"Defined interfaces\". The sub- section \"Defined interfaces\" lists all architectural interfaces specified in the namespace of the FunctionalCluster. Each interface is detailed in a separate table.

> 所有构建块(FunctionalCluster)的描述在本节中使用相同的模式。每个 FunctionalCluster 在文档的单独部分中有描述。这样的一个部分以 FunctionalCluster 的责任概述开始，然后是叫做“定义的接口”的子部分。“定义的接口”子部分列出 FunctionalCluster 的命名空间中指定的所有架构接口。每个接口都在单独的表格中进行详细说明。

The subsection \"Provided interfaces\" then lists all interfaces provided by the Func- tionalCluster (i.e. it is fully implemented by the FunctionalCluster) to other FunctionalClusters.

> 该子节“提供的接口”列出了 FunctionalCluster 提供给其他 FunctionalClusters 的所有接口(即它完全由 FunctionalCluster 实现)。

The last subsection \"Required interfaces\" lists all interfaces required by the Func- tionalCluster from other FunctionalClusters and external components like the operating system.

> 最后一节“所需接口”列出了 FunctionalCluster 从其他 FunctionalCluster 和外部组件(如操作系统)所需的所有接口。

## Runtime

![](./media/image11.png)![](./media/image12.png)![](./media/image13.png)![](./media/image14.png)![](./media/image15.png)

**Figure 9.2: Functional Clusters in category Runtime**

### Execution Management

```

```

1. **Defined interfaces**

> **定义的接口**

The interfaces of [Execution Management](#_bookmark61) are categorized into interfaces for state reporting (see Section [9.2.1.1.1](#_bookmark62)), interfaces for the deterministic execution (see Section [9.2.1.1.2](#_bookmark65)), and interfaces for [State Management](#_bookmark76) (see Section [9.2.1.1.3](#_bookmark69)).

> 管理执行(参见第 9.2.1.1.1 节)的接口分为状态报告接口、确定性执行接口(参见第 9.2.1.1.2 节)和状态管理接口(参见第 9.2.1.1.3 节)。

1. []{#\_bookmark62 .anchor}**Interfaces for state reporting**

> 报告状态的接口

All processes started by [Execution Management](#_bookmark61) (i.e. all processes of the AU- TOSAR Adaptive Platform and all processes of Adaptive Applications) shall report their execution state back to [Execution Management](#_bookmark61) via the [ExecutionClient](#_bookmark64) interface (cf. Figure [9.3](#_bookmark63)).

> 所有由[执行管理](#_bookmark61)启动的过程(即自适应软件开发框架(AUTOSAR)的所有过程和自适应应用程序的所有过程)都必须通过[执行客户端](#_bookmark64)界面将其执行状态反馈给[执行管理](#_bookmark61)(参见图[9.3](#_bookmark63))。

![](./media/image16.png)
![](./media/image17.png)

**Figure 9.3:** []{#\_bookmark63 .anchor}**Interfaces for state reporting**

```

```

2. []{#\_bookmark65 .anchor}**Interfaces for deterministic execution**

> 极确定性执行的接口

The [DeterministicClient](#_bookmark67) API (cf. Figure [9.4](#_bookmark66)) provides operations to perform determin- istic execution of tasks.

> API DeterministicClient(参见图 9.4)提供操作来执行任务的确定性执行。

![](./media/image18.png)
**Figure 9.4:** []{#\_bookmark66 .anchor}**Interfaces for deterministic execution**

```

```

3. []{#\_bookmark69 .anchor}**Interfaces for State Management**

> **状态管理的接口**

![](./media/image20.png)The [StateClient](#_bookmark71) API (cf. Figure [9.5](#_bookmark70)) provides operations to control [FunctionGroup](#_bookmark74)s and their [FunctionGroupState](#_bookmark73)s.

![](./media/image21.png)

**Figure 9.5:** []{#\_bookmark70 .anchor}**Interfaces for State Management**

```

```

2. **Provided interfaces**

> 2. **提供的接口**

![](./media/image20.png) ![](./media/image22.png) ![](./media/image23.png) ![](./media/image24.png) ![](./media/image25.png)

![](./media/image26.png)
![](./media/image20.png)**Figure 9.6: Users of the ExecutionClient interface**
![](./media/image27.png)

**Figure 9.7: Users of the State Management interfaces**

```

```

**Table 9.1: Interfaces provided by Execution Management to other Functional Clusters**

> 表 9.1：执行管理为其他功能集群提供的接口

3. **Required interfaces**

> 3. **必需的接口**

![](./media/image28.png)
![](./media/image29.png)
![](./media/image21.png) ![](./media/image30.png) ![](./media/image31.png)

**Figure 9.8: Interfaces required by Execution Management**

**Table 9.2: Interfaces required by Execution Management**

> 表 9.2：执行管理所需的接口

### State Management

```

```

1. **Defined interfaces**

> **定义的接口**

The interfaces of [State Management](#_bookmark76) are categorized into interfaces for triggering state changes (see Section [9.2.2.1.1](#_bookmark77)), interfaces for diagnostic reset (see Section [9.2.2.1.2](#_bookmark79)), interfaces for requesting a Power Mode (see Section [9.2.2.1.3](#_bookmark83)), and inter- faces for interaction with [Update and Configuration Management](#_bookmark200) (see Section [9.2.2.1.4](#_bookmark87)).

> 控制状态管理的接口分为触发状态更改的接口(见第 9.2.2.1.1 节)、诊断复位的接口(见第 9.2.2.1.2 节)、请求功耗模式的接口(见第 9.2.2.1.3 节)以及与更新和配置管理(见第 9.2.2.1.4 节)的交互接口。

1. []{#\_bookmark77 .anchor}**Interfaces for triggering state changes**

> 控制状态变化的接口

[State Management](#_bookmark76) provides several interface blueprints to get and set its internal state (cf. Figure [9.9](#_bookmark78)).

> 状态管理提供了几种接口蓝图来获取和设置其内部状态(参见图 9.9)。

![](./media/image32.png)

![](./media/image33.png)

**Figure 9.9:** []{#\_bookmark78 .anchor}**Interfaces for triggering state changes**

```

```

2. []{#\_bookmark79 .anchor}**Interfaces for requesting a diagnostic reset**

> 2. 请求诊断重置的接口

The [DiagnosticReset](#_bookmark80) interface propagates a diagnostic reset request ([DiagnosticRe-](#_bookmark82) [set::message()](#_bookmark82)) to all affected Processes. These Processes then shall answer the diagnostic reset request by calling [DiagnosticReset::event()](#_bookmark81).

> 接口 DiagnosticReset 传播诊断重置请求(DiagnosticReset :: message())到所有受影响的进程。这些进程然后应通过调用 DiagnosticReset :: event()来回答诊断重置请求。

![](./media/image34.png) ![](./media/image35.png)

![](./media/image36.png)

**Figure 9.10: Interface for handling a diagnostic reset**

```

```

3. []{#\_bookmark83 .anchor}**Interfaces for requesting a Power Mode**

> 求助于电源模式的接口

The [PowerMode](#_bookmark84) interface propagates a diagnostic Power Mode request ([Power-](#_bookmark86) [Mode::message()](#_bookmark86)) to all running Processes. These Processes then shall answer the Power Mode request by calling [PowerMode::event()](#_bookmark85).

> 界面 PowerMode 传播一个诊断的功率模式请求(Power-Mode::message())到所有正在运行的进程。这些进程然后应该通过调用 PowerMode::event()来回答功率模式请求。

![](./media/image37.png)

![](./media/image38.png)

**Figure 9.11: Interface for handling a Power Mode request**

4. []{#\_bookmark87 .anchor}**Interfaces for interaction with Update and Configuration Management**

> 更新和配置管理的交互界面

![](./media/image39.png)

![](./media/image40.png)

**Figure 9.12: Interface for software update handling**

2. ![](./media/image41.png)**Provided interfaces**

> **提供的接口**

![](./media/image42.png)![](./media/image43.png)

![](./media/image44.png)

**Figure 9.13: Users of the State Management interfaces**

```

```

**Table 9.3: Interfaces provided by State Management to other Functional Clusters**

> 表 9.3：状态管理向其他功能簇提供的接口

3. **Required interfaces**

> 3. **必需的接口**

```

```

![](./media/image45.png)«aapFunctionalClust\...
![](./media/image46.png)**Figure 9.14: Interfaces required by State Management**
![](./media/image49.png)
![](./media/image50.png)

**Figure 9.15: Interfaces of Execution Management required by State Management**

```

```

**Table 9.4: Interfaces required by State Management**

> 表 9.4：状态管理所需的接口

### Log and Trace

```

```

1. **Defined interfaces**

> **定义的接口**

The entry point to the Log and Trace framework is the [CreateLogger()](#_bookmark93) operation that constructs a new [Logger](#_bookmark91) context. Afterwards, new messages can be constructed using the [LogStream](#_bookmark94) that is returned by the operations in [Logger](#_bookmark91), for example [LogInfo](#_bookmark92) [()](#_bookmark92).

> 入口点到日志和跟踪框架是[CreateLogger()](#_bookmark93)操作，它构造一个新的[Logger](#_bookmark91)上下文。之后，可以使用[Logger](#_bookmark91)中返回的[LogStream](#_bookmark94)构造新的消息，例如[LogInfo](#_bookmark92) [()](#_bookmark92)。

![](./media/image51.png)

![](./media/image52.png)

**Figure 9.16: Interfaces of Log and Trace**

```

```

2. **Provided interfaces**

> 2. **提供的接口**

![](./media/image28.png) ![](./media/image53.png) ![](./media/image55.png) ![](./media/image56.png)
![](./media/image58.png)![](./media/image59.png)![](./media/image59.png)
![](./media/image20.png)
![](./media/image24.png)![](./media/image60.png)![](./media/image22.png)**Figure 9.17: Users of the Log and Trace interfaces**

```

```

**Table 9.5: Interfaces provided by Log and Trace to other Functional Clusters**

> 表 9.5：日志和跟踪提供给其他功能群的接口

3. **Required interfaces**

> 3. **必需的接口**

![](./media/image61.png)

![](./media/image62.png)![](./media/image63.png)**Figure 9.18: Interfaces required by LogAndTrace**

```

```

**Table 9.6: Interfaces required by Log and Trace**

> 表 9.6：日志和跟踪所需的接口

### Core

```

```

1. **Defined interfaces**

> **定义的接口**

![](./media/image64.png)

**Figure 9.19: Interfaces of Core**

1. **Interfaces for initialization and de-initialization**

> 1. 初始化和反初始化的接口

The AUTOSAR Adaptive Platform for Applications needs to be initialized by an appli- cation before it is used (using [Initialize()](#_bookmark98)) and de-initialized after it is no longer used (using [Deinitialize()](#_bookmark97)).

> AUTOSAR 自适应应用平台在使用之前需要由应用程序进行初始化(使用[Initialize()](#_bookmark98))，在不再使用时需要进行反初始化(使用[Deinitialize()](#_bookmark97))。

```

```

2. **Interfaces for process termination**

> 2. **进程终止的接口**

The AUTOSAR Adaptive Platform for Applications provides an explicit abnormal termi- nation facility using [Abort()](#_bookmark99).

> AUTOSAR Adaptive 平台为应用提供了一个显式的异常终止设施，使用[Abort()](#_bookmark99)。

```

```

2. **Provided interfaces**

> 2. **提供的接口**

[Core](#_bookmark96) currently provides no interfaces to other Functional Clusters.

> 核心目前没有提供与其他功能集群的接口。

3. **Required interfaces**

> 3. **必需的接口**

[Core](#_bookmark96) currently requires no interfaces.

> 核心目前不需要任何界面。

### Operating System Interface

```

```

1. **Defined interfaces**

> **定义的接口**

![](./media/image16.png)

![](./media/image17.png)

**Figure 9.20: Interfaces defined by Operating System Interface**

```

```

2. **Provided interfaces**

> 2. **提供的接口**

![](./media/image65.png)

![](./media/image66.png)

**Figure 9.21: Users of the OperatingSystemInterface interfaces**

```

```

**Table 9.7: Interfaces provided by Operating System Interface to other Functional Clus- ters**

> 表 9.7：操作系统接口提供的接口对其他功能群

3. **Required interfaces**

> 3. **必需的接口**

![](./media/image67.png)

![](./media/image68.png)

**Figure 9.22: Interfaces required by Operating System Interface**

```

```

**Table 9.8: Interfaces required by Operating System Interface**

> 表 9.8：操作系统接口所需的接口

## Communication

![](./media/image69.png)![](./media/image69.png)![](./media/image70.png)

**Figure 9.23: Functional Clusters in category Communication**

### Communication Management

**_Responsibilities:_** [Communication Management](#_bookmark105) is responsible for all levels of service-oriented and raw communication between applications in a distributed real-time embedded environment. That is, intra-process communication, inter-process communication and inter-machine communication. The latter is also possible with AUTOSAR Classic Platforms and third-party platforms. Communication paths can be established at design-, start-up-, and run-time. [Communication Management](#_bookmark105) consists of a generic part that handles brokering and configuration as well as generated skeletons for service providers and respective proxies for service consumers.

> 责任：[通信管理](#_bookmark105)负责分布式实时嵌入式环境中应用之间的所有服务和原始通信级别。也就是，进程间通信、进程间通信和机器间通信。后者也可以使用 AUTOSAR Classic Platforms 和第三方平台。可以在设计、启动和运行时建立通信路径。[通信管理](#_bookmark105)由通用部分组成，该部分负责经纪和配置，以及为服务提供者生成骨架和相应的服务消费者代理。

1. **Defined interfaces**

> **定义的接口**

The interfaces of [Communication Management](#_bookmark105) are categorized into interfaces for raw data streams (see Section [9.3.1.1.1](#_bookmark106)), interfaces for SecOC (see Section [9.3.1.1.2](#_bookmark108)), and interfaces freshness value management (see Section [9.3.1.1.3](#_bookmark109)). Please note that a implementation of [Communication Management](#_bookmark105) will generate additional inter- faces for each modeled Service, e.g. a Proxy and a Skeleton interface. However, these generated interfaces are not covered in this document.

> 界面管理(参见[9.3.1.1.1](＃*书签 106))的界面被分为原始数据流的界面，SecOC 的界面(参见[9.3.1.1.2](＃*书签 108))和新鲜度值管理的界面(参见[9.3.1.1.3](＃\_书签 109))。请注意，界面管理的实施将为每个建模的服务生成额外的接口，例如代理和骨架接口。但是，这些生成的接口不在本文档中涵盖。

1. ![](./media/image2.png)[]{#\_bookmark106 .anchor}**Interfaces for raw data streams**

> 接口用于原始数据流

![](./media/image30.png)

**Figure 9.24: Interfaces for raw data streams**

2. []{#\_bookmark108 .anchor}**Interfaces for SecOC**

> **SecOC 的接口**

![](./media/image72.png)

**Figure 9.25: Interfaces for SecOC**

3. []{#\_bookmark109 .anchor}**Interfaces for freshness value management**

> 提高新鲜度值管理的界面

![](./media/image73.png)

**Figure 9.26: Interfaces for freshness value management**

2. **Provided interfaces**

> 2. **提供的接口**

[Communication Management](#_bookmark105) currently provides no interfaces to other Func- tional Clusters.

> 通信管理目前没有提供与其他功能集群的接口。

3. **Required interfaces**

> 3. **必需的接口**

![](./media/image74.png)

![](./media/image75.png)![](./media/image76.png)![](./media/image77.png)![](./media/image21.png) ![](./media/image78.png)

**Figure 9.27: Interfaces required by Communication Management**

**Table 9.9: Interfaces required by Communication Management**

> 表 9.9：通信管理所需的接口

### Network Management

1. **Defined interfaces**

> **定义的接口**

![](./media/image20.png)

![](./media/image79.png)

**Figure 9.28: Interfaces for time base providers**

2. **Provided interfaces**

> 2. **提供的接口**

![](./media/image20.png)

![](./media/image80.png)

**Figure 9.29: Users of Network Management interfaces**

**Table 9.10: Interfaces provided by Network Management to other Functional Clusters**

> 表 9.10：网络管理提供给其他功能集群的接口

3. **Required interfaces**

> 3. 必需的接口

![](./media/image81.png)

![](./media/image82.png)

![](./media/image83.png)**Figure 9.30: Interfaces required by Network Management**

**Table 9.11: Interfaces required by Network Management**

> 表 9.11：网络管理所需的接口

### Time Synchronization

1. **Defined interfaces**

> **定义的接口**

The interfaces of [Time Synchronization](#_bookmark115) are categorized into interfaces for provid- ing time information (see Section [9.3.3.1.1](#_bookmark116)) and interfaces for consuming time informa- tion (see Section [9.3.3.1.2](#_bookmark119)).

> 時間同步的介面可分為提供時間資訊的介面(參見第 9.3.3.1.1 節)和消費時間資訊的介面(參見第 9.3.3.1.2 節)。

1. []{#\_bookmark116 .anchor}**Interfaces for time base providers**

> 提供时间基准的接口

![](./media/image34.png)[Time Synchronization](#_bookmark115) defines the [SynchronizedTimeBaseProvider](#_bookmark117) and [Offset-](#_bookmark118) [TimeBaseProvider](#_bookmark118) interfaces to provide time information for a synchronized time base.

![](./media/image84.png)

**Figure 9.31: Interfaces for time base providers**

2. []{#\_bookmark119 .anchor}**Interfaces for time base consumers**

> 消费者时间基础接口

[Time Synchronization](#_bookmark115) defines the [SynchronizedTimeBaseConsumer](#_bookmark120) interface to retrieve time information for a synchronized time base. [SynchronizedTimeBaseStatus](#_bookmark121) is used to determine the status of a synchronized time base.

> [时间同步](#_bookmark115)定义了[SynchronizedTimeBaseConsumer](#_bookmark120)接口来获取同步时间基础的时间信息。[SynchronizedTimeBaseStatus](#_bookmark121)用于确定同步时间基础的状态。

![](./media/image85.png)![](./media/image86.png)

**Figure 9.32: Interfaces for time base consumers**

2. ![](./media/image87.png)![](./media/image88.png)**Provided interfaces**

> 提供的接口

![](./media/image89.png)

**Figure 9.33: Users of Time Synchronization interfaces**

**Table 9.12: Interfaces provided by Time Synchronization to other Functional Clusters**

> 表 9.12：时间同步提供给其他功能集群的接口

3. **Required interfaces**

> 3. **必需的界面**

![](./media/image91.png)

![](./media/image92.png) ![](./media/image93.png) ![](./media/image94.png)

**Figure 9.34: Interfaces required by Time Synchronization**

**Table 9.13: Interfaces required by Time Synchronization**

> 表 9.13：时间同步所需的接口

## Storage

![](./media/image95.png)

**Figure 9.35: Functional Clusters in category Storage**

### Persistency

1. **Defined interfaces**

> **定义的接口**

The interfaces of [Persistency](#_bookmark124) are categorized into interfaces for file access (see Section [9.4.1.1.1](#_bookmark125)), interfaces for a key-value-based data access (see Section [9.4.1.1.2](#_bookmark136)) and interfaces for general management of persistent data (see Section [9.4.1.1.3](#_bookmark145)).

> 持久性的接口被分为文件访问接口(参见 9.4.1.1.1 节)、基于键值的数据访问接口(参见 9.4.1.1.2 节)和持久数据的通用管理接口(参见 9.4.1.1.3 节)。

1. []{#\_bookmark125 .anchor}**Interfaces for file storage**

> **文件存储的接口**

[Persistency](#_bookmark124) provides read and write access to plain files by means of a [FileStor-](#_bookmark130) [age](#_bookmark130) (cf. Figure [9.36](#_bookmark126)). A [FileStorage](#_bookmark130) has to be opened using [OpenFileStorage()](#_bookmark129). A [FileStorage](#_bookmark130) then provides access to several files using their name.

> 持久性(参见图 9.36)通过文件存储(FileStorage)提供对普通文件的读写访问。必须使用 OpenFileStorage()打开文件存储(FileStorage)。然后，文件存储(FileStorage)可以使用文件名访问多个文件。

![](./media/image96.png)

![](./media/image97.png)«aapAPI,aapNativeInterface» Persistency

**Figure 9.36:** []{#\_bookmark126 .anchor}**Interfaces for file storage**

2. []{#\_bookmark136 .anchor}**Interfaces for key-value storage**

> 接口用于键值存储

[Persistency](#_bookmark124) provides read and write access to data structured as key-value pairs by means of the [KeyValueStorage](#_bookmark141) API (cf. Figure [9.37](#_bookmark137)). A [KeyValueStorage](#_bookmark141) has to be created by calling [OpenKeyValueStorage()](#_bookmark140). A [KeyValueStorage](#_bookmark141) then provides access to data stored for individual keys using the [GetValue()](#_bookmark142) and [SetValue()](#_bookmark143) operations.

> 持久性通过[KeyValueStorage](#_bookmark141) API(参见图 9.37)提供以键值对形式结构化的数据的读写访问。[KeyValueStorage](#_bookmark141)必须通过调用[OpenKeyValueStorage()](#_bookmark140)来创建。然后，[KeyValueStorage](#_bookmark141)提供使用[GetValue()](#_bookmark142)和[SetValue()](#_bookmark143)操作访问存储在单个键中的数据的访问权限。

![](./media/image47.png)**Figure 9.37:** []{#\_bookmark137 .anchor}**Interfaces for key-value-based data storage**

3. []{#\_bookmark145 .anchor}**Interfaces for general persistency handling**

> 持久性处理的通用接口

[Persistency](#_bookmark124) provides operations for handling and recovery of persistent data of a

> 持久性提供了处理和恢复持久数据的操作。

Process (cf. Figure [9.38](#_bookmark146)).

> 处理(参见图 9.38)。

![](./media/image2.png)

![](./media/image100.png)

**Figure 9.38:** []{#\_bookmark146 .anchor}**Interfaces for general persistency handling**

2. ![](./media/image101.png)**Provided interfaces**

> **提供的接口**

![](./media/image102.png)

![](./media/image103.png)

![](./media/image104.png)![](./media/image102.png)**Figure 9.39: Users of the FileStorage interfaces**

![](./media/image105.png)

**Figure 9.40: Users of the KeyValueStorage interfaces**

**Table 9.14: Interfaces provided by Persistency to other Functional Clusters**

> 表 9.14：持久性向其他功能集群提供的接口

3. **Required interfaces**

> 3. **必需的接口**

![](./media/image90.png)

![](./media/image107.png)

![](./media/image108.png)![](./media/image109.png)![](./media/image110.png)**Figure 9.41: Interfaces required by Persistency**

**Table 9.15: Interfaces required by Persistency**

> 表 9.15：持久性所需的接口

## Security

![](./media/image111.png)![](./media/image112.png)![](./media/image113.png)![](./media/image114.png)

**Figure 9.42: Functional Clusters in category Security**

### Cryptography

1. **Defined interfaces**

> **定义的接口**

1.  []{#\_bookmark151 .anchor}**Common interfaces**

> **常用接口**

The main entry point for using the [Cryptography](#_bookmark150) API are the factory functions [Load-](#_bookmark152) [CryptoProvider()](#_bookmark152) for using cryptographic routines, [LoadKeyStorageProvider()](#_bookmark153) for ac- cess to the key store, and [LoadX509Provider()](#_bookmark154) for X.509 certificate handling.

> 主要使用[加密](#_bookmark150) API 的入口点是工厂函数[加载](#_bookmark152) [CryptoProvider()](#_bookmark152)，用于使用加密程序，[LoadKeyStorageProvider()](#_bookmark153)用于访问密钥存储，以及[LoadX509Provider()](#_bookmark154)用于 X.509 证书处理。

![](./media/image99.png)

![](./media/image115.png)

**Figure 9.43: Common Interfaces of Cryptography**

2. **General cryptography interfaces**

> 2. 一般加密接口

The [CryptoProvider](#_bookmark157) interface provides access to various cryptographic routines. Each of those routines is managed by specializations of the [CryptoContext](#_bookmark158) interface.

> 接口 CryptoProvider 提供对各种加密程序的访问。每个程序都由接口 CryptoContext 的特殊实现管理。

![](./media/image99.png)

![](./media/image116.png)

**Figure 9.44: General Cryptography Interfaces**

3. **Cryptography context interfaces**

> 3. **密码学上下文接口**

![](./media/image37.png)

![](./media/image117.png)

**Figure 9.45: BlockService and CryptoContext Interfaces**

**Figure 9.46: CryptoService and CryptoContext Interfaces**

![](./media/image51.png)

![](./media/image119.png)

**Figure 9.47: DigestService and CryptoContext Interfaces**

**Table 10.16: Use-Case Report Security Event**

> 表 10.16：安全事件用例报告

# Runtime View

This chapter shows the original design approach of the AUTOSAR Adaptive Platform for implementing selected use cases. The presented use cases currently cover just a small part of the functionality of the AUTOSAR Adaptive Platform. More use cases will be added in future versions of this document. Please note that individual imple- mentations of the AUTOSAR Adaptive Platform may always choose a different design internally. Thus, interaction partners, the type of messages, and their order may differ.

> 本章介绍了 AUTOSAR Adaptive Platform 实现所选用例的原始设计方法。目前提供的用例仅涵盖 AUTOSAR Adaptive Platform 的一小部分功能。未来版本的文档将添加更多的用例。请注意，AUTOSAR Adaptive Platform 的个体实现可能会有不同的内部设计。因此，交互伙伴、消息类型及其顺序可能会有所不同。

1. []{#\_bookmark258 .anchor}**Runtime**

> 运行时

1.  []{#\_bookmark259 .anchor}**Execution Management**

> 执行管理

      1. **Start Adaptive Platform**

         1. **Scenario: Start Platform with Supervision of Applications**

![](./media/image251.png)

**Figure 11.1:** []{#\_bookmark261 .anchor}**Scenario: Start Platform with Supervision of Applications**

Figure [11.1](#_bookmark261) shows a scenario of for [Start Adaptive Platform](#_bookmark242) with an supervi- sion of Adaptive Applications. It therefore includes the startup of [Platform Health](#_bookmark186) [Management](#_bookmark186) that performs supervision and the startup of an Adaptive Application that is supervised as part of the Startup Machine Function Group State.

> 图 11.1 显示了一个 Start Adaptive Platform 的场景，其中包括 Adaptive Applications 的监督，以及 Startup Machine Function Group State 的一部分，用于执行监督和启动被监督的 Adaptive Application 的 Platform Health Management 的启动。

During the preceding startup of the Machine the [Operating System](#_bookmark28) performs ini- tialization steps in an implementation-specific way. These steps include starting any middleware related to the [Operating System](#_bookmark28), including device-drivers and services handling low-level middleware. The AUTOSAR Adaptive Platform demands that the

> 在机器的前一次启动期间，操作系统以实现特定的方式执行初始化步骤。这些步骤包括启动与操作系统相关的任何中间件，包括设备驱动程序和处理低级中间件的服务。AUTOSAR Adaptive Platform 要求操作系统在启动过程中必须满足一定的要求。

[Watchdog](#_bookmark30) is enabled prior to the startup of the AUTOSAR Adaptive Platform, for ex- ample, the [Watchdog](#_bookmark30) could already be enabled by the Bootloader or the [Operat-](#_bookmark28) [ing System](#_bookmark28).

> 监视狗在 AUTOSAR Adaptive Platform 启动之前已经启用，例如，监视狗可以由引导程序或操作系统已经启用。

[Execution Management](#_bookmark61) is started by the [Operating System](#_bookmark28) as the first process of the AUTOSAR Adaptive Platform. [Execution Management](#_bookmark61) then controls the startup of the AUTOSAR Adaptive Platform by activating the standardized Function Group State called Startup of the Machine Function Group State. This trig- gers the start of additional processes that are configured to run in the Startup state. It is mandatory that [State Management](#_bookmark76) is part of the Startup state. Other processes of the AUTOSAR Adaptive Platform, for example [Platform Health Management](#_bookmark186) and application processes may also be part of the Startup state (see Figure [11.1](#_bookmark261)).

> 执行管理由操作系统作为 AUTOSAR 自适应平台的第一个进程启动。执行管理通过激活称为机器功能组状态启动的标准功能组状态来控制 AUTOSAR 自适应平台的启动。这会触发配置为启动状态运行的其他进程的启动。状态管理必须是启动状态的一部分。AUTOSAR 自适应平台的其他进程，例如平台健康管理和应用程序进程也可以是启动状态的一部分(参见图 11.1)。

[Platform Health Management](#_bookmark186) is responsible to service the [Watchdog](#_bookmark30). Thus, the time between enabling the [Watchdog](#_bookmark30) during the start of the Machine and the start of [Platform Health Management](#_bookmark186) needs to be less than the [Watchdog](#_bookmark30) timeout. The integrator needs to fulfill this constraint.

> 平台健康管理负责为 Watchdog 服务。因此，在机器启动时启用 Watchdog 和平台健康管理启动之间的时间需要小于 Watchdog 超时时间。集成器需要满足这一约束。

After the Startup state has been reached, [State Management](#_bookmark76) takes over control to determine the desired Function Group States.

> 当启动状态达到后，[状态管理](#_bookmark76)接管控制，以确定所需的功能组状态。

2. **Shutdown Adaptive Platform**

> 关闭自适应平台

1.  **Scenario: Shutdown Platform with Supervision of Applications**

> 情景：在应用程序的监督下关闭平台

![](./media/image254.png)

**Figure 11.2:** []{#\_bookmark263 .anchor}**Scenario: Shutdown Platform with Supervision of Applications**

[]{#\_bookmark264 .anchor}Figure [11.2](#_bookmark263) shows a scenario for [Shutdown Adaptive Platform](#_bookmark243) with a super- vision of Adaptive Applications. It therefore includes the shutdown of [Platform](#_bookmark186) [Health Management](#_bookmark186) that performs supervision.

> 图 11.2 显示了一个关闭自适应平台的场景，其中包括自适应应用程序的监督。因此，它还包括执行监督的平台健康管理的关闭。

The shutdown is triggered by [State Management](#_bookmark76) by requesting the standardized Machine Function Group State called Shutdown. In general, it is assumed that the only processes configured to run in the Shutdown state are [State Management](#_bookmark76) and an application that issues a shutdown request towards the [Operating System](#_bookmark28) (shutdownApp in Figure [11.2](#_bookmark263)). [Execution Management](#_bookmark61) will therefore perform an orderly shutdown of the other running application and platform processes (including [Platform Health Management](#_bookmark186)) before starting the application process that issues a shutdown request towards the [Operating System](#_bookmark28). The [Operating System](#_bookmark28) terminates the remaining processes (i.e. [State Management](#_bookmark76), [Execution Man-](#_bookmark61) [agement](#_bookmark61)) of the AUTOSAR Adaptive Platform and shuts down the Machine in an implementation-specific way.

> 关机是由[状态管理](#_bookmark76)通过请求标准机器功能组状态(称为关机)触发的。通常，假定只有在关机状态下配置运行的进程是[状态管理](#_bookmark76)和一个向[操作系统](#_bookmark28)发出关机请求的应用程序(图 11.2 中的 shutdownApp)。[执行管理](#_bookmark61)将在启动发出关机请求的应用程序之前，有序关闭其他正在运行的应用程序和平台进程(包括[平台健康管理](#_bookmark186))。[操作系统](#_bookmark28)会终止 AUTOSAR 自适应平台的其余进程(即[状态管理](#_bookmark76)和[执行管理](#_bookmark61))，并以实现特定的方式关闭机器。

3. **Change Function Group State**

> **更改功能群组状态**

1.  **Scenario: Change Function Group State**

> **场景：更改功能组状态**

![](./media/image255.png)

**Figure 11.3:** []{#\_bookmark265 .anchor}**Scenario: Regular change of a Function Group State**

Figure [11.3](#_bookmark265) shows a scenario for changing a Function Group State. The sce- nario is triggered by [State Management](#_bookmark76). [Execution Management](#_bookmark61) will terminate all processes that are not part of the requested target Function Group State or that have a different StateDependentStartupConfig.

> 图 11.3 显示了更改功能组状态的场景。该场景由状态管理触发。执行管理将终止不属于所请求的目标功能组状态或具有不同 StateDependentStartupConfig 的所有进程。

Just before terminating a process (with a SIGTERM signal), [Execution Manage-](#_bookmark61) [ment](#_bookmark61) notifies [Platform Health Management](#_bookmark186) that will stop all supervisions of the process. Consequently, [State Management](#_bookmark76) will not receive any information about failed supervisions during the shutdown of the process. The shutdown is monitored by [Execution Management](#_bookmark61) by means of StartupConfig.timeout configured in the Manifest.

> 在终止进程(使用 SIGTERM 信号)之前，执行管理将通知平台健康管理停止对该进程的所有监管。因此，状态管理在进程关闭期间不会收到任何有关失败监管的信息。通过在 Manifest 中配置的 StartupConfig.timeout，执行管理可以监视关机过程。

Afterwards, [Execution Management](#_bookmark61) starts the processes of the target Function Group State in the order imposed by their StateDependentStartupConfig. When a processes reports its execution state as kRunning, [Execution Manage-](#_bookmark61) [ment](#_bookmark61) notifies [Platform Health Management](#_bookmark186) to start Alive Supervision for

> 之后，[执行管理](#_bookmark61)按照目标功能组状态的 StateDependentStartupConfig 按顺序开始进程。当进程报告其执行状态为 kRunning 时，[执行管理](#_bookmark61)通知[平台健康管理](#_bookmark186)开始存活监督。

[]{#\_bookmark269 .anchor}that process. Other kinds of supervisions (Deadline Supervision, and Logical Supervision) are started when the first checkpoint is reported for them.

> 这个过程。其他类型的监督(截止日监督和逻辑监督)将在报告第一个检查点时开始。

2. []{#\_bookmark266 .anchor}**State Management**

> 状态管理

1.  **Change System State**

> 更改系统状态

      1. **Scenario: Accept Trigger Input**

![](./media/image259.png)![](./media/image261.png){width="8.172025371828522e-2in" height="0.227665135608049in"}[]{#\_bookmark267 .anchor}«aapFunctionalClust\...

**Figure 11.4:** []{#\_bookmark268 .anchor}**Scenario: Accept Trigger Input**

Figure [11.4](#_bookmark268) shows the default scenario for changing the system state. An [Adaptive](#_bookmark24) [Application](#_bookmark24) changes a field in the TriggerIn\_{StateGroup} service interface. Alternatively, the TriggerInOut\_{StateGroup} may be used (not shown). Based on the new input data, [State Management](#_bookmark76) determines a new desired system state, that is a set of desired Function Group States, and requests these Function Group States from [Execution Management](#_bookmark61) by calling [SetState()](#_bookmark72).

> 图 11.4 显示更改系统状态的默认情景。自适应应用程序更改 TriggerIn* {StateGroup}服务接口中的一个字段。另外，可以使用 TriggerInOut* {StateGroup}(未显示)。根据新的输入数据，状态管理确定一个新的期望系统状态，即一组期望的功能组状态，并通过调用 SetState()从执行管理请求这些功能组状态。

After the new system state has been reached, [State Management](#_bookmark76) updates the fields in the TriggerOut\_{StateGroup} (and TriggerInOut\_{StateGroup}, not shown) interfaces accordingly.

> 在达到新的系统状态后，[状态管理](#_bookmark76)会相应地更新 TriggerOut*{StateGroup}(以及未显示的 TriggerInOut*{StateGroup})接口中的字段。

2. **Scenario: Reject Trigger Input**

> **场景：拒绝触发输入**

![](./media/image262.png){width="8.23928258967629e-2in" height="0.22916666666666666in"}

![](./media/image263.png)app: Adaptive Application

**Figure 11.5:** []{#\_bookmark270 .anchor}**Scenario: Reject Trigger Input**

Figure [11.5](#_bookmark270) shows an alternate scenario. An [Adaptive Application](#_bookmark24) changes a field in the TriggerIn\_{StateGroup} (alternatively TriggerI- nOut\_{StateGroup}) service interface. Despite the new input data, [State Man-](#_bookmark76) [agement](#_bookmark76) determines that the current system state is still the desired system state. Therefore, no further action is taken by [State Management](#_bookmark76).

> 图 11.5 显示了一个替代方案。自适应应用程序更改 TriggerIn*{StateGroup}(或者 TriggerInOut*{StateGroup})服务接口中的一个字段。尽管有新的输入数据，但状态管理确定当前系统状态仍然是所需的系统状态。因此，状态管理不会采取进一步的行动。

2. **Recover from Supervision Failure**

> 恢复监督失败

1.  **Scenario: Successful Recovery**

> 情景：成功恢复

![](./media/image265.png)

**Figure 11.6:** []{#\_bookmark272 .anchor}**Scenario: Successful Recovery**

Figure [11.6](#_bookmark272) shows the scenario for performing successful recovery after a supervision failure has been detected by [Platform Health Management](#_bookmark186). [Platform Health](#_bookmark186) [Management](#_bookmark186) notifies [State Management](#_bookmark76) by invoking the call-back method [Recov-](#_bookmark194) [eryHandler()](#_bookmark194). [State Management](#_bookmark76) then determines a new desired state (which may be the same as the current state) and requests corresponding Function Group State transitions from [Execution Management](#_bookmark61).

> 图 11.6 显示了在平台健康管理检测到监督失败后成功恢复的情景。平台健康管理通过调用回调方法 RecoveryHandler()来通知状态管理。然后，状态管理确定一个新的期望状态(可能与当前状态相同)，并从执行管理请求相应的功能组状态转换。

2. []{#\_bookmark273 .anchor}**Storage**

> 存储

1.  []{#\_bookmark274 .anchor}**Persistency**

> 持久性

      1. **Read Persistent Data from File**

         1. ![](./media/image267.png){width="8.225721784776903e-2in" height="0.22916666666666666in"}![](./media/image268.png){width="8.225503062117236e-2in" height="0.22916666666666666in"}**Scenario: Read Data from File Successfully**

![](./media/image269.png)

**Figure 11.7:** []{#\_bookmark276 .anchor}**Scenario: Read Data from File Successfully**

Figure [11.7](#_bookmark276) shows the scenario for successfully reading data from a file successfully. The [Adaptive Application](#_bookmark24) needs to open a [FileStorage](#_bookmark130) by calling [OpenFileStor-](#_bookmark129) [age()](#_bookmark129). Afterwards, the [Adaptive Application](#_bookmark24) needs to open an individual file by calling [OpenFileReadOnly()](#_bookmark131) or [OpenFileReadWrite()](#_bookmark132) depending if the [Adaptive Ap-](#_bookmark24) [plication](#_bookmark24) needs to write data to the file as well. Then, the [Adaptive Applica-](#_bookmark24) [tion](#_bookmark24) can read data via the methods provided by [ReadAccessor](#_bookmark134) either as binary data or text data.

> 图 11.7 显示了成功从文件中读取数据的场景。自适应应用程序需要通过调用 OpenFileStor- age()来打开 FileStorage。之后，自适应应用程序需要根据应用程序是否需要将数据写入文件，调用 OpenFileReadOnly()或 OpenFileReadWrite()来打开单个文件。然后，自适应应用程序可以通过 ReadAccessor 提供的方法以二进制数据或文本数据的形式读取数据。

If enabled in the Manifest, [Persistency](#_bookmark124) will detect and try to correct data errors when reading from a file. If the file or [FileStorage](#_bookmark130) is configured to use encryption, the contents of the file will be transparently decrypted during read.

> 如果在清单中启用，[Persistency](#_bookmark124)将在从文件读取时检测并尝试纠正数据错误。如果配置文件或[FileStorage](#_bookmark130)使用加密，则文件的内容将在读取时透明解密。

2. []{#\_bookmark279 .anchor}**Read Persistent Data with Unique ID**

> 阅读具有唯一 ID 的持久数据

1.  **Scenario: Read Data with Unique ID Successfully**

> 场景：成功使用唯一 ID 读取数据

![](./media/image273.png){width="8.225831146106737e-2in" height="0.22916666666666666in"}![](./media/image274.png){width="8.225612423447069e-2in" height="0.22916666666666666in"}

[]{#\_bookmark277 .anchor}:Adaptive Application :Operating System

> 自适应应用程序：操作系统

![](./media/image275.png)**Figure 11.8:** []{#\_bookmark278 .anchor}**Scenario: Read Data with Unique ID Successfully**

Figure [11.8](#_bookmark278) shows the scenario for successfully reading data by providing a unique identifier (key). The [Adaptive Application](#_bookmark24) needs to open a [KeyValueStorage](#_bookmark141) by calling [OpenKeyValueStorage()](#_bookmark140). Then, the [Adaptive Application](#_bookmark24) can read data associated to a key by calling [GetValue()](#_bookmark142).

> 图 11.8 显示了通过提供唯一标识符(键)成功读取数据的场景。自适应应用程序需要通过调用 OpenKeyValueStorage()来打开 KeyValueStorage。然后，自适应应用程序可以通过调用 GetValue()来读取与键相关联的数据。

If enabled in the Manifest, [Persistency](#_bookmark124) will detect and try to correct data errors when reading data. If the individual key or [KeyValueStorage](#_bookmark141) is configured to use en- cryption, data will be transparently decrypted during read.

> 如果在清单中启用，持久性将在读取数据时检测并尝试纠正数据错误。如果配置个别键或 KeyValueStorage 使用加密，则在读取时将透明地解密数据。

3. **Store Persistent Data to File**

> 3. **将持久数据存储到文件中**

1.  **Scenario: Store Data to File Successfully**

> 场景：成功地将数据存储到文件

**Figure 11.9:** []{#\_bookmark280 .anchor}**Scenario: Store Data to File Successfully**

Figure [11.9](#_bookmark280) shows a scenario for storing data to a file successfully. The [Adaptive](#_bookmark24) [Application](#_bookmark24) needs to open a [FileStorage](#_bookmark130) by calling [OpenFileStorage()](#_bookmark129). Afterwards, the [Adaptive Application](#_bookmark24) needs to open an individual file for writing by calling [OpenFileWriteOnly()](#_bookmark133) or [OpenFileReadWrite()](#_bookmark132) depending if the [Adaptive Applica-](#_bookmark24) [tion](#_bookmark24) needs to read data from the file as well. Then, the [Adaptive Application](#_bookmark24) can store data via the methods provided by [ReadWriteAccessor](#_bookmark135) either as binary data or text data.

> 图 11.9 显示了一个成功存储数据到文件的场景。自适应应用程序需要通过调用 OpenFileStorage()来打开文件存储。之后，自适应应用程序需要根据自适应应用程序是否需要从文件中读取数据来调用 OpenFileWriteOnly()或 OpenFileReadWrite()来打开一个单独的文件进行写入。然后，自适应应用程序可以通过 ReadWriteAccessor 提供的方法将数据存储为二进制数据或文本数据。

If enabled in the Manifest, [Persistency](#_bookmark124) stores redundant data to detect and cor- rect errors when reading from a file later. If the file or [FileStorage](#_bookmark130) is configured to use encryption, data will be encrypted before it is written to the underlying storage.

> 如果在清单中启用，持久性可以存储冗余数据以便在稍后从文件中读取时能够检测和纠正错误。如果文件或文件存储被配置为使用加密，数据将在写入底层存储之前被加密。

4. **Store Persistent Data with Unique ID**

> 存储具有唯一 ID 的持久数据

1.  **Scenario: Store Data with Unique ID Successfully**

> 情景：成功地使用唯一 ID 存储数据

![](./media/image283.png){width="8.225831146106737e-2in" height="0.22916666666666666in"}
![](./media/image282.png){width="8.08442694663167e-2in" height="0.22916666666666666in"}

**Figure 11.10:** []{#\_bookmark282 .anchor}**Scenario: Store Persistent Data with a Unique ID Successfully**

Figure [11.10](#_bookmark282) shows a scenario for storing data associated with a unique identifier (key) successfully. The [Adaptive Application](#_bookmark24) needs to open a [KeyValueStorage](#_bookmark141) by calling [OpenKeyValueStorage()](#_bookmark140). Then, the [Adaptive Application](#_bookmark24) can store data associated to a key by calling [SetValue()](#_bookmark143). The data is updated in memory by calling [SetValue()](#_bookmark143) but not written to persistent storage. The [Adaptive Application](#_bookmark24) needs to call [SyncToStorage()](#_bookmark144) to write one or more such changes to persistent storage.

> 图 11.10 显示了一种成功存储与唯一标识符(键)相关的数据的场景。[自适应应用程序](#_bookmark24)需要通过调用[OpenKeyValueStorage()](#_bookmark140)来打开[KeyValueStorage](#_bookmark141)。然后，[自适应应用程序](#_bookmark24)可以通过调用[SetValue()](#_bookmark143)来存储与键相关的数据。通过调用[SetValue()](#_bookmark143)更新内存中的数据，但不会写入持久存储。[自适应应用程序](#_bookmark24)需要调用[SyncToStorage()](#_bookmark144)来将一个或多个这样的更改写入持久存储。

If enabled in the Manifest, [Persistency](#_bookmark124) stores redundant data to detect and cor- rect errors when reading from a [KeyValueStorage](#_bookmark141) later. If the key or [KeyValueStorage](#_bookmark141) is configured to use encryption, data will be encrypted before it is written to the under- lying storage.

> 如果在 Manifest 中启用，持久性会存储冗余数据以便在以后从 KeyValueStorage 读取时检测和纠正错误。如果配置了密钥或 KeyValueStorage 使用加密，则在写入底层存储之前会对数据进行加密。

5. **Get Storage Size**

   1. **Scenario: File Store**

> **场景：文件存储**

![](./media/image286.png){width="8.226159230096237e-2in" height="0.22916666666666666in"}![](./media/image287.png){width="8.084645669291339e-2in" height="0.22916666666666666in"}

[]{#\_bookmark283 .anchor}:Adaptive Application :Operating System

> 自适应应用程序：操作系统

**Figure 11.11:** []{#\_bookmark284 .anchor}**Scenario for determining the size of a FileStorage**

Figure [11.11](#_bookmark284) shows the scenario for monitoring the storage space of a [FileStorage](#_bookmark130). The [Adaptive Application](#_bookmark24) needs to call [GetCurrentFileStorageSize()](#_bookmark128) to determine the current size.

> 图 11.11(#\_bookmark284)展示了用于监控[FileStorage](#_bookmark130)存储空间的场景。[自适应应用程序](#_bookmark24)需要调用[GetCurrentFileStorageSize()](#_bookmark128)来确定当前大小。

2. **Scenario: Key Value Store**

> **场景：键值存储**

![](./media/image288.png){width="8.226159230096237e-2in" height="0.22916666666666666in"}![](./media/image287.png){width="8.084645669291339e-2in" height="0.22916666666666666in"}

[]{#\_bookmark285 .anchor}:Adaptive Application :Operating System

> 自适应应用程序：操作系统

GetCurrentKeyValueStorageSize()

> 获取当前键值存储大小()

**Figure 11.12:** []{#\_bookmark286 .anchor}**Scenario for determining the size of a KeyValueStorage**

Figure [11.12](#_bookmark286) shows the scenario for monitoring the storage space of a [KeyValueStor-](#_bookmark141) [age](#_bookmark141). The [Adaptive Application](#_bookmark24) needs to call [GetCurrentKeyValueStorageSize()](#_bookmark139) to determine the current size.

> 图 11.12 显示了监控 KeyValueStorage 大小的场景。自适应应用程序需要调用 GetCurrentKeyValueStorageSize()来确定当前的大小。

3. []{#\_bookmark287 .anchor}**Security**

> **安全**

1.  []{#\_bookmark288 .anchor}**Firewall**

> **防火墙**

      1. **Switch Firewall State**

         1. **Scenario: Switch Firewall State Successfully**

![](./media/image289.png){width="8.226049868766404e-2in" height="0.22916666666666666in"}![](./media/image290.png){width="8.084536307961505e-2in" height="0.22916666666666666in"}

[]{#\_bookmark289 .anchor}:Adaptive Application :Operating System

> 自适应应用程序：操作系统

**Figure 11.13:** []{#\_bookmark290 .anchor}**Scenario: Switch Firewall State Successfully**

Figure [11.13](#_bookmark290) shows the scenario for successfully switching the state of the [Firewall](#_bookmark182). The [Adaptive Application](#_bookmark24) triggers the state switch by calling [SwitchFirewallState](#_bookmark183) [()](#_bookmark183). The [Firewall](#_bookmark182) will then apply the FirewallRules configured for the request state

> 图 11.13 显示了成功切换防火墙状态的场景。自适应应用程序通过调用 SwitchFirewallState()来触发状态切换。然后，防火墙将应用配置为请求状态的 FirewallRules。

in an implementation-specific way (e.g., using tools provided with the TCP/IP stack of the [Operating System](#_bookmark28)).

> 以实现特定的方式(例如使用 TCP/IP 堆栈提供的工具[操作系统](#\_bookmark28))。

2. **Report Security Event**

> 报告安全事件

1.  **Scenario: Report Security Event Successfully**

> 场景：成功报告安全事件

**Figure 11.14:** []{#\_bookmark292 .anchor}**Scenario: Report Security Event Successfully**

Figure [11.14](#_bookmark292) shows the scenario for successfully reporting a Security Event to [Adaptive Intrusion Detection System Manager](#_bookmark178). The [Operating System](#_bookmark28) (or another component that implements the actual firewall) reports that a packet has been blocked by a specific rule to the [Firewall](#_bookmark182). If a Security Event has been configured for that rule in the Manifest, the [Firewall](#_bookmark182) will create a correspond- ing Security Event and report it to [Adaptive Intrusion Detection System](#_bookmark178) [Manager](#_bookmark178) by calling [ReportEvent()](#_bookmark180). [Adaptive Intrusion Detection System](#_bookmark178) [Manager](#_bookmark178) will then handle the Security Event accordingly.

> 图 11.14 显示了成功向自适应入侵检测系统管理器报告安全事件的场景。操作系统(或实现实际防火墙的另一组件)报告特定规则已阻止了一个数据包，防火墙将创建一个相应的安全事件并通过调用 ReportEvent()向自适应入侵检测系统管理器报告它。自适应入侵检测系统管理器将相应地处理安全事件。

12. []{#\_bookmark293 .anchor}**Deployment View**

> **部署视图**

This chapter provides an overview of exemplary deployment scenarios for an AU- TOSAR Adaptive Platform. Since the AUTOSAR Adaptive Platform is highly config- urable in its deployment, this section rather provides constraints on supported deploy- ments and a selection of relevant deployment scenarios.

> 本章提供了 AU-TOSAR 自适应平台的示例部署方案概述。由于 AUTOSAR 自适应平台在部署方面具有高度的可配置性，因此本节主要提供支持部署的约束条件以及相关部署方案的选择。

## Vehicle Software Deployment

![](./media/image294.png)

**Figure 12.1: Exemplary vehicle software update scenario**

[Update and Configuration Management](#_bookmark200) allows to install and update software on the AUTOSAR Adaptive Platform and AUTOSAR Classic Platform. For the AU- TOSAR Adaptive Platform, [Update and Configuration Management](#_bookmark200) also al- lows to remove software. The software packages can be received either from a Di- agnostic Client or from a specific Backend System for over-the-air updates. In a vehicle, one [Adaptive Application](#_bookmark24) takes the role of a master that controls the update process in the vehicle and distributes individual software packages to the Ma- chines and ECUs within a vehicle.

> [更新和配置管理](#_bookmark200)允许在 AUTOSAR 自适应平台和 AUTOSAR 经典平台上安装和更新软件。对于 AUTOSAR 自适应平台，[更新和配置管理](#_bookmark200)还允许删除软件。软件包可以从诊断客户端或特定的后端系统获得，以实现远程更新。在车辆中，一个[自适应应用程序](#_bookmark24)扮演主控制车辆内更新过程并将单个软件包分发到车辆内的机器和 ECU 的角色。

## ![](./media/image300.png)Deployment of Software Packages on a Machine

![](./media/image301.png)

**Figure 12.2:** []{#\_bookmark296 .anchor}**Exemplary deployment of Software Packages on a Machine**

[Update and Configuration Management](#_bookmark200) manages the software installed on a Machine using one or more Software Packages. The configuration of the contents of a Software Package is done in the Manifest by means of a Software Clus- ter. Software Cluster defines the enumeration attribute category with the val- ues APPLICATION, PLATFORM, and PLATFORM_CORE. Some rules apply on the use of the Software Cluster category and corresponding Software Packages which are outlined in the following.

> 更新和配置管理使用一个或多个软件包来管理机器上安装的软件。软件包的配置内容在清单中通过软件集群完成。软件集群定义了枚举属性类别，值为 APPLICATION、PLATFORM 和 PLATFORM_CORE。在使用软件集群类别和相应的软件包时，有一些规则，如下所述。

For a Machine there shall exist exactly one Software Cluster with category PLATFORM_CORE. The corresponding Platform Core Package needs to include all required core components provided by the Platform Vendor and Machine Vendor, for example the operating system, device drivers, and the required Func- tional Clusters of the Adaptive Platform (see Figure [12.2](#_bookmark296)). It is assumed that at least the Functional Clusters [Execution Management](#_bookmark61), [State Management](#_bookmark76), and [Update and Configuration Management](#_bookmark200) are part of the Platform Core Package since they are required to install any additional Software Packages. How- ever, the concrete extend of a Platform Core Package is vendor and/or project specific. A Platform Core Package cannot be removed. The Software Clus- ter with category PLATFORM_CORE needs to be self-contained and therefore shall not have dependencies to other Software Clusters.

> 对于每台机器，应该只有一个属于 PLATFORM_CORE 类别的软件集群。相应的平台核心包应包括由平台供应商和机器供应商提供的所有必需的核心组件，例如操作系统、设备驱动程序和自适应平台所需的功能集群(参见图 12.2)。假设至少包括执行管理(Execution Management)、状态管理(State Management)和更新和配置管理(Update and Configuration Management)三个功能集群，因为它们是安装任何其他软件包所必需的。然而，平台核心包的具体范围是供应商和/或项目特定的。平台核心包不能被移除。具有 PLATFORM_CORE 类别的软件集群需要是自包含的，因此不应该有对其他软件集群的依赖性。

Optional Functional Clusters of the Adaptive Platform may be distributed as part of any number of additional Software Clusters with category PLATFORM within Platform Packages. Such Software Clusters may depend on the the

> 可选的自适应平台功能群可以作为平台包中任何数量的其他软件群的一部分分发。这些软件群可能取决于 the the。

Software Cluster with category PLATFORM_CORE (see Figure [12.2](#_bookmark296)). Platform Packages may be installed and removed as needed.

> 软件集群具有 PLATFORM_CORE 类别(见图 12.2)。可以根据需要安装和卸载平台包。

Application components should be distributed as part of additional Software Clus- ters with category APPLICATION within Application Packages. Such Soft- ware Clusters may depend on the on Software Clusters with any kind of cat- egory (see Figure [12.2](#_bookmark296)). Application Packages may be installed and removed as needed.

> 应将应用组件作为应用程序包中具有类别 APPLICATION 的附加软件集群的一部分进行分发。此类软件集群可能取决于具有任何类别的软件集群(参见图 12.2)。可以根据需要安装和移除应用程序包。

The Platform Core Package and Platform Packages shall include all required Functional Cluster daemons and their respective configuration (e.g., startup con- figuration). This frees applications (distributed as Application Packages) from tak- ing care of the configuration of the platform.

> 核心平台包和平台包应包括所有所需的功能集群守护进程及其相应的配置(例如，启动配置)。这使得作为应用程序包分发的应用程序免于负责平台的配置。

# Cross-cutting Concepts

This section provides an overview of cross-cutting concepts and patterns used in the AUTOSAR Adaptive Platform.

> 这一节提供了 AUTOSAR Adaptive Platform 中使用的横切概念和模式的概述。

## Overview of Platform Entities

The AUTOSAR Adaptive Platform defines design entities that several Functional Clusters depend on. Figure [13.1](#_bookmark299) provides an overview of these entities, their logical relationships, and the Functional Clusters that depend on them. For the sake of brevity, this overview uses simplifications and abstractions over the actual specifica- tions in the \[[9](#_bookmark331), manifest specification\].

> AUTOSAR Adaptive Platform 定义了多个功能簇所依赖的设计实体。图 13.1 提供了这些实体、它们的逻辑关系以及依赖它们的功能簇的概览。为了简洁起见，此概览使用了\[[9](#_bookmark331)，清单规范\]中实际规范的简化和抽象。

![](./media/image205.png)

**Figure 13.1:** []{#\_bookmark299 .anchor}**Overview of platform entities and their logical relationships**

A Software Package is a digitally signed package that can be installed/uninstalled via [Update and Configuration Management](#_bookmark200). A Software Package contains exactly one Software Cluster (see Section [13.4](#software-cluster) for details). A Software Clus- ter refers to a set of Executables (and other files). The corresponding executable file then holds the executable code for the Machine that the AUTOSAR Adaptive Plat- form runs on.

> 一个软件包是一个经过数字签名的包，可以通过[更新和配置管理](＃\_bookmark200)安装/卸载。一个软件包包含一个软件集群(有关详细信息，请参见[13.4](＃软件集群)节)。软件集群指的是一组可执行文件(和其他文件)。然后，相应的可执行文件为 AUTOSAR Adaptive Platform 运行的机器提供可执行代码。

Additionally, a Software Cluster configuration collects a set of Processes (cf. Section [13.4](#software-cluster)) and related entities. A Process refers to an Executable and provides different Startup Configuration values, for example parameters, a scheduling

> 此外，软件集群配置收集一组进程(参见第 13.4 节)及相关实体。进程指可执行文件，并提供不同的启动配置值，例如参数、调度等。

priority, and resource constraints. A Startup Configuration of a Process ap- plies to one or more Function Group States. Function Group States belong to a Function Group.

> 优先级和资源约束。过程的初始配置适用于一个或多个功能组状态。功能组状态属于功能组。

During runtime, [State Management](#_bookmark76) requests to enter a Function Group State from [Execution Management](#_bookmark61). [Execution Management](#_bookmark61) then terminates and starts the Processes accordingly using the underlying [Operating System](#_bookmark28).

> 在运行时，[状态管理](#_bookmark76)要求从[执行管理](#_bookmark61)输入功能组状态。[执行管理](#_bookmark61)然后终止并使用底层[操作系统](#_bookmark28)启动相应的进程。

For safety-critical systems, [Platform Health Management](#_bookmark186) performs supervision of Processes according to rules (logical sequence, deadlines) defined in PhmSuper- visions. A PhmSupervision refers to a number of Supervision Checkpoints. During runtime, a process reports whenever it has reached such a checkpoint in its control flow.

> 为了保证安全关键系统，[Platform Health Management](#_bookmark186) 根据 PhmSuper- visions 中定义的规则(逻辑顺序、期限)对过程进行监督。PhmSupervision 指的是一系列的监督检查点。在运行期间，当过程到达控制流程中的检查点时，会上报。

## Function Group

A Function Group is (logically) made up a set of modeled Processes that provide a certain functionality. For example, a Function Group could be an application, or a service. A special Function Group is the Machine State that groups the Process of the AUTOSAR Adaptive Platform itself. A Function Group contains a set of Function Group States.

> 一个功能组(逻辑上)由一组建模的流程组成，提供某种功能。例如，一个功能组可以是一个应用程序或服务。一个特殊的功能组是机器状态，它将 AUTOSAR 自适应平台本身的流程分组。一个功能组包含一组功能组状态。

## Function Group State

A Function Group State defines which Processes of a Function Group with what configuration parameters shall be running or not. The Machine State (that refers to the Processes of the AUTOSAR Adaptive Platform itself) defines at least the following Function Group States: Off, Startup, Shutdown, and Restart.

> 一个功能组状态定义了哪些功能组的进程以及配置参数应该运行或不运行。机器状态(指 AUTOSAR 自适应平台本身的进程)至少定义了以下几个功能组状态：关闭、启动、关闭和重启。

## Software Cluster

A Software Cluster configuration refers to a set of modeled Processes. Those Processes are (transitively) used by one or more Function Group(s). Hereby, a Function Group and its associated entities shall be part of only one Software Cluster. In other words, Function Groups that span several Software Clus- ters are invalid. A Software Cluster is packaged into one Software Package

> 软件集群配置指的是一组建模的过程。这些过程(传递地)被一个或多个功能组使用。因此，功能组及其相关实体应该只属于一个软件集群。换句话说，跨越多个软件集群的功能组是无效的。软件集群打包成一个软件包。

\- the atomic installable/updateable unit managed by Update and Configuration Management. A Software Cluster may depend on other Software Clusters. Such dependencies are expressed by version constraints. A Software Cluster may also specify structural dependencies to Sub Software Clusters in order to build larger installable units. The top of such a structural dependency hierarchy is called a Root Software Cluster. Please note that a Software Cluster is only used to configure deployment aspects. A Software Cluster is not a runtime entity.

> 一个软件集群由更新和配置管理管理的原子可安装/可更新单位组成。软件集群可能依赖于其他软件集群。这些依赖关系由版本约束表达。软件集群还可以指定结构依赖关系，以构建更大的可安装单元。这种结构依赖层次结构的顶级称为根软件集群。请注意，软件集群仅用于配置部署方面。软件集群不是运行时实体。

A Root Software Cluster may specify a diagnostic configuration, in particular, a diagnostic address. In contrast, a Sub Software Cluster may depend on a diag- nostic configuration of its Root Software Cluster. The diagnostic configuration applies to Processes that are (transitively) contained in a Root Software Clus- ter and its Sub Software Cluster(s). That means, at runtime, any diagnostic event produced by those Processes will be associated with the diagnostic address. Please refer to Section [13.11](#diagnostics-deployment) for further details on the diagnostic deployment.

> 一个根软件集群可以指定一个诊断配置，特别是一个诊断地址。相比之下，一个子软件集群可能依赖于其根软件集群的诊断配置。诊断配置适用于(传递)包含在根软件集群及其子软件集群中的进程。这意味着，在运行时，由这些进程产生的任何诊断事件都将与诊断地址关联。有关诊断部署的更多详细信息，请参见[13.11](＃诊断部署)节。

An exemplary Software Cluster during application design is shown in Figure [13.2](#_bookmark303). The application Software Cluster(s) are modeled/configured in the same way as the platform Software Cluster by defining Function Groups with Function Group States and associating StartupConfigurations of Processes to them.

> 在应用设计中，图 13.2 显示了一个示范软件集群。应用软件集群以相同的方式建模/配置，即通过定义功能组和功能组状态，并将进程的启动配置关联到它们。

A Software Cluster serves as a grouping entity during application design. As a result, entities within a Software Cluster, in particular the Function Groups, do not need to have a unique (simple) name within the overall model because their path is still unique. This allows to design Software Clusters independently, for example, by external suppliers.

> 软件集群在应用程序设计时充当分组实体。因此，软件集群中的实体，特别是功能组，在整体模型中不需要具有唯一(简单)的名称，因为它们的路径仍然是唯一的。这允许独立设计软件集群，例如，由外部供应商。

![](./media/image263.png)

**Figure 13.2:** []{#\_bookmark303 .anchor}**Exemplary Software Cluster during application design**

From such a standardized model, an equivalent implementation-specific configura- tion for [Execution Management](#_bookmark61) is derived that is used during runtime (see Figure [13.3](#_bookmark304)). That configuration advises [Execution Management](#_bookmark61) to start and configure processes accordingly when a Function Group State is requested. Hereby, [Ex-](#_bookmark61) [ecution Management](#_bookmark61) (logically) merges configurations contributed by all installed Software Packages. Other Functional Clusters that depend on configuration provided in the Manifests merge the configurations contributed by all installed Soft- ware Packages in the same way. Please also note that there is no corresponding runtime entity for a Software Cluster (see Figure [13.3](#_bookmark304)).

> 从这样的标准模型中，可以派生出一个用于运行时使用的等效实现特定配置(请参见图 13.3)。该配置建议[执行管理](＃\_bookmark61)在请求功能组状态时启动和配置进程。因此，[Ex-](＃\_bookmark61)[ecution Management](＃\_bookmark61)(逻辑上)合并所有安装软件包提供的配置。其他依赖于清单中提供的配置的功能集群以相同的方式合并所有安装的软件包提供的配置。请注意，软件集群没有相应的运行时实体(请参见图 13.3)。

![](./media/image318.png)

**Figure 13.3:** []{#\_bookmark304 .anchor}**Impact of exemplary Software Cluster during runtime**

All Processes related to the Functional Clusters of the AUTOSAR Adaptive Platform should be referenced only in Software Clusters of category PLAT- FORM_CORE or PLATFORM. This allows for platform-independent development of Software Clusters of category APPLICATION_LAYER.

> 所有与 AUTOSAR Adaptive Platform 功能簇有关的进程都应只在类别 PLATFORM_CORE 或 PLATFORM 的软件簇中引用。这样可以实现类别 APPLICATION_LAYER 的软件簇的平台独立开发。

In case a Functional Cluster may need multiple logical instances (for example, Diagnostic Management has a logical instance per diagnostic address), an imple- mentation of the Functional Cluster should still use a single physical (daemon) process.

> 如果功能集群需要多个逻辑实例(例如，诊断管理有一个每个诊断地址的逻辑实例)，功能集群的实现仍应使用单个物理(守护进程)进程。

An AUTOSAR Adaptive Platform vendor may deviate from this design guide but should provide additional countermeasures to keep [Adaptive Application](#_bookmark24)s portable.

> 一个 AUTOSAR 自适应平台供应商可能会偏离这个设计指南，但应该提供额外的对策来保持自适应应用程序的可移植性。

## Machine

The AUTOSAR Adaptive Platform regards hardware it runs on as a Machine. The ra- tionale behind that is to achieve a consistent platform view regardless of any virtualiza- tion technology which might be used. The Machine might be a real physical machine, a fully-virtualized machine, a para-virtualized OS, an OS-level-virtualized container or any other virtualized environment.

> AUTOSAR Adaptive Platform 将其运行的硬件视为机器。其背后的原理是无论使用何种虚拟化技术，都能够实现一致的平台视图。机器可以是真实的物理机器，完全虚拟化的机器，一个 para-virtualized OS，一个 OS 级别的虚拟容器或者其他任何虚拟化的环境。

On hardware, there can be one or more Machine, and only a single instance of AU- TOSAR Adaptive Platform runs on a machine. It is generally assumed that this hard- ware includes a single chip, hosting a single or multiple Machines. However, it is also possible that multiple chips form a single Machine if the AUTOSAR Adaptive Platform implementation allows it.

> 在硬件上，可以有一个或多个机器，而 AU- TOSAR 自适应平台只能在一台机器上运行一个实例。通常假定这种硬件包括一片芯片，承载一个或多个机器。但是，如果 AUTOSAR 自适应平台的实现允许，多片芯片也可以组成一个机器。

## Manifest

A Manifest represents a piece of AUTOSAR model description that is created to support the configuration of an AUTOSAR Adaptive Platform product and which is up- loaded to the AUTOSAR Adaptive Platform product, potentially in combination with other artifacts (like binary files) that contain executable code to which the Manifest applies. Please note that a typical [Adaptive Application](#_bookmark24) will make use of several distinct but interrelated Manifests. Hereby, the individual Manifests contribute in- formation to the complete application model. For example, each Software Cluster may contribute a self-contained set of Manifests to configure its functionality.

> 一个清单代表一个 AUTOSAR 模型描述的一部分，旨在支持 AUTOSAR 自适应平台产品的配置，并上传到 AUTOSAR 自适应平台产品，可能与其他包含可执行代码的二进制文件结合使用，清单适用。请注意，典型的[自适应应用程序](#_bookmark24)将使用几个不同但相互关联的清单。因此，各个清单为完整的应用程序模型提供信息。例如，每个软件集簇可以提供一组独立的清单来配置其功能。

The usage of a Manifest is limited to the AUTOSAR Adaptive Platform. This does not mean, however, that all ARXML produced in a development project that targets the AUTOSAR Adaptive Platform is automatically considered a Manifest. In fact, the AUTOSAR Adaptive Platform is usually not exclusively used in a vehicle project. A typical vehicle will most likely be also equipped with a number of ECUs developed on the AUTOSAR Classic Platform and the system design for the entire vehicle will, therefore, have to cover both, ECUs built on top of the AUTOSAR Classic Platform and Machines created on top of the AUTOSAR Adaptive Platform.

> 使用清单仅限于 AUTOSAR 自适应平台。然而，这并不意味着在针对 AUTOSAR 自适应平台开发的项目中产生的所有 ARXML 都被自动视为清单。事实上，通常不会仅在车辆项目中使用 AUTOSAR 自适应平台。典型的车辆很可能也会配备基于 AUTOSAR 经典平台开发的一些 ECU，因此，整个车辆的系统设计将必须涵盖基于 AUTOSAR 经典平台和基于 AUTOSAR 自适应平台创建的机器。

In principle, the term Manifest could be defined such that there is conceptually just one \"Manifest\" and every deployment aspect would be handled in this context. This does not seem appropriate because it became apparent that Manifest-related model- elements exist that are relevant in entirely different phases of a typical development project.

> 原则上，“Manifest”这个术语可以定义为只有一个概念上的“Manifest”，每个部署方面都会在这个上下文中处理。但这似乎不合适，因为显然有与 Manifest 相关的模型元素，它们与典型开发项目的完全不同阶段有关。

This aspect is taken as the main motivation that next to the application design it is necessary to subdivide the definition of the term Manifest in three different partitions:

> 这一方面被视为主要动机，因此除了应用程序设计之外，还必须将术语 Manifest 的定义细分为三个不同的部分：

**Application Design** This kind of description specifies all design-related aspects that apply to the creation of application software for the AUTOSAR Adaptive Platform. It is not necessarily required to be deployed to the adaptive platform machine, but the application design aids the definition of the deployment of application software in the

> **应用设计** 这种描述指定适用于为 AUTOSAR Adaptive Platform 创建应用软件的所有与设计相关的方面。它不一定需要部署到自适应平台机器，但是应用设计有助于定义应用软件在其中的部署。

Execution Manifest and Service Instance Manifest. See Section [13.7](#application-design) for details.

> 执行清单和服务实例清单。详细信息请参见[13.7](＃应用程序设计)节。

**Execution Manifest** This kind of Manifest is used to specify the deployment-related information of applications running on the AUTOSAR Adaptive Platform. An Execu- tion Manifest is bundled with the actual executable code to support the integration of the executable code onto the machine. See Section [13.8](#execution-manifest) for details.

> **执行清单** 这种清单用于指定在 AUTOSAR 自适应平台上运行的应用程序的部署相关信息。执行清单与实际可执行代码一起打包，以支持将可执行代码集成到机器上。有关详细信息，请参见第 13.8 节。

**Service Instance Manifest** This kind of Manifest is used to specify how service- oriented communication is configured in terms of the requirements of the underlying transport protocols. A Service Instance Manifest is bundled with the actual executable code that implements the respective usage of service-oriented communi- cation. See Section [13.9](#service-instance-manifest) for details.

> **服务实例清单** 此类清单用于指定服务导向通信如何根据底层传输协议的要求进行配置。服务实例清单与实际执行实现相关服务导向通信用法的可执行代码一起打包。有关详细信息，请参见第 13.9 节(服务实例清单)。

**Machine Manifest** This kind of Manifest is supposed to describe deployment-related content that applies to the configuration of just the underlying machine (i.e. without any applications running on the machine) that runs an AUTOSAR Adaptive Platform. A Machine Manifest is bundled with the software taken to establish an instance of the AUTOSAR Adaptive Platform. See Section [13.10](#machine-manifest) for details.

> **机器清单** 这种清单旨在描述仅适用于运行 AUTOSAR 自适应平台的基础机器(即在机器上没有运行任何应用程序)的部署相关内容。机器清单与用于建立 AUTOSAR 自适应平台实例的软件一起打包。有关详细信息，请参见第 13.10 节(机器清单)。

The temporal division between the definition (and usage) of different kinds of Mani- fest leads to the conclusion that in most cases different physical files will be used to store the content of the three kinds of Manifest. In addition to the Application Design and the different kinds of Manifest, the AUTOSAR Methodology supports a Sys- tem Design with the possibility to describe Software Components of both AUTOSAR Platforms that will be used in a System in one single model. The Software Compo- nents of the different AUTOSAR platforms may communicate in a service-oriented way with each other. But it is also possible to describe a mapping of Signals to Services to create a bridge between the service-oriented communication and the signal-based communication.

> 在定义(和使用)不同类型的 Manifest 之间的时间分割导致了这样的结论：在大多数情况下，将使用不同的物理文件来存储三种 Manifest 的内容。除了应用设计和不同类型的 Manifest 外，AUTOSAR 方法还支持系统设计，可以在一个模型中描述将在系统中使用的 AUTOSAR 平台上的软件组件。不同的 AUTOSAR 平台的软件组件可以以服务导向的方式相互通信。但是也可以描述信号到服务的映射，以建立服务导向通信和基于信号的通信之间的桥梁。

## Application Design

The application design describes all design-related modeling that applies to the cre- ation of application software for the AUTOSAR AP. Application Design focuses on the following aspects:

> 应用设计描述了所有与 AUTOSAR AP 创建应用软件相关的设计模型。应用设计重点关注以下方面：

- Data types used to classify information for the software design and implementa- tion
- Service interfaces as the pivotal element for service-oriented communication
- Definition how service-oriented communication is accessible by the application
- Persistency Interfaces as the pivotal element to access persistent data and files
- Definition how persistent storage is accessible by the application
- Definition how files are accessible by the application
- Definition how crypto software is accessible by the application
- Definition how the Platform Health Management is accessible by the application
- Definition how Time Bases are accessible by the application

- Serialization properties to define the characteristics of how data is serialized for the transport on the network

> 序列化属性用于定义网络传输时数据序列化的特性。

- Description of client and server capabilities
- Grouping of applications in order to ease the deployment of software.

The artifacts defined in the application design are independent of a specific deployment of the application software and thus ease the reuse of application implementations for different deployment scenarios.

> 应用设计中定义的工件与应用软件的具体部署无关，从而便于为不同部署场景重复使用应用实现。

## Execution Manifest

The purpose of the execution manifest is to provide information that is needed for the actual deployment of an application onto the AUTOSAR AP. The general idea is to keep the application software code as independent as possible from the deployment scenario to increase the odds that the application software can be reused in different deployment scenarios. With the execution manifest the instantiation of applications is controlled, thus it is possible to

> 执行清单的目的是提供将应用程序部署到 AUTOSAR AP 所需的信息。一般的想法是尽可能使应用软件代码与部署方案独立，以增加应用软件可以在不同部署方案中重复使用的几率。通过执行清单控制应用程序的实例化，因此可以实现应用程序的部署。

- instantiate the same application software several times on the same machine, or to

- deploy the application software to several machines and instantiate the applica- tion software per machine.

> 部署应用程序软件到多台机器，并在每台机器上实例化应用程序软件。

The Execution manifest focuses on the following aspects:

> 执行清单主要关注以下方面：

- Startup configuration to define how the application instance shall be started. The startup includes the definition of startup options and access roles. Each startup may be dependent on machines states and/or function group states.

> 配置启动以定义应用实例如何启动。启动包括定义启动选项和访问角色。每个启动可能取决于机器状态和/或功能组状态。

- Resource Management, in particular resource group assignments.

  1. ## Service Instance Manifest

> ## 服务实例清单

The implementation of service-oriented communication on the network requires con- figuration which is specific to the used communication technology (e.g. SOME/IP). Since the communication infrastructure shall behave the same on the provider and the requesters of a service, the implementation of the service shall be compatible on both sides.

> 实现网络上的服务导向通信需要特定于所使用的通信技术(例如 SOME / IP)的配置。由于通信基础设施在服务提供者和服务请求者之间应该表现一致，因此服务的实施应该在双方都兼容。

The Service Instance Manifest focuses on the following aspects:

> 服务实例清单重点关注以下方面：

- Service interface deployment to define how a service shall be represented on the specific communication technology.

> 服务接口部署定义了如何在特定通信技术上表示服务。

- Service instance deployment to define for specific provided and required service instances the required credentials for the communication technology.

> 为特定提供的和需要的服务实例定义服务实例部署，以确定所需的通信技术凭据。

- The configuration of E2E protection
- The configuration of Security protection
- The configuration of Log and Trace

  1. ## Machine Manifest

> ## 机器清单

The machine manifest allows to configure the actual adaptive platform instance running on specific hardware (machine).

> 机器清单允许配置在特定硬件(机器)上运行的实际自适应平台实例。

The Machine Manifest focuses on the following aspects:

> 机器宣言着重关注以下方面：

- Configuration of the network connection and defining the basic credentials for the network technology (e.g. for Ethernet this involves setting of a static IP address or the definition of DHCP).

> 配置网络连接并为网络技术定义基本凭据(例如，对于以太网，这涉及设置静态 IP 地址或定义 DHCP)。

- Configuration of the service discovery technology (e.g. for SOME/IP this involves the definition of the IP port and IP multi-cast address to be used).

> 配置服务发现技术(例如对于 SOME / IP，这涉及定义要使用的 IP 端口和 IP 多播地址)。

- Definition of the used machine states.
- Definition of the used function groups.

- Configuration of the adaptive platform functional cluster implementations (e.g. the operating system provides a list of OS users with specific rights).

> 配置自适应平台功能集群实施(例如，操作系统提供具有特定权限的操作系统用户列表)。

- The configuration of the Crypto platform Module.
- The configuration of Platform Health Management.
- The configuration of Time Synchronization.

- Documentation of available hardware resources (e.g. how much RAM is avail- able; how many processor cores are available).

> 文档提供可用的硬件资源(例如可用的 RAM 大小；有多少处理器内核)。

1. ## Diagnostics deployment

> ## 诊断部署

A diagnostic configuration, in particular a diagnostic address, may only be assigned to a Root Software Cluster in the Manifest. Nevertheless, the mapped Diag- nosticContributionSet(s) may be distributed across several Software Clus- ters. This concept provides a lot of flexibility in assignment of a single diagnostic address to Software Clusters. For example, in one extreme this allows to use a single diagnostic address for the whole Machine (see Figure [13.4](#_bookmark312)), in another extreme

> 一个诊断配置，特别是一个诊断地址，只能在清单中分配给根软件集群。尽管如此，映射的 DiagnosticContributionSet(s)可以分布在几个软件集群中。这个概念为将单个诊断地址分配给软件集群提供了很大的灵活性。例如，在一个极端，这允许使用单个诊断地址为整个机器(参见图 13.4)，在另一个极端

a single diagnostic address per Software Cluster could be used (see Figure [13.5](#_bookmark313)). Deployment scenarios in between those extremes are also possible.

> 一个软件集群可以使用单个诊断地址(参见图 13.5)。也可能存在在这些极端之间的部署方案。

![](./media/image323.png)![](./media/image263.png)

**Figure 13.4:** []{#\_bookmark312 .anchor}**Example defining a single diagnostic address for the whole Machine**

![](./media/image323.png)

**Figure 13.5:** []{#\_bookmark313 .anchor}**Example using one diagnostic address for each Software Cluster**

![](./media/image324.png)In the case of a distributed DiagnosticContributionSet, each Software Clus- ter shall include its related diagnostic configuration objects (for example, the Data Identifier configuration). The merge of such a split DiagnosticContribution- Set is done internally by the AUTOSAR Adaptive Platform (e.g. during installation or during start up the Diagnostic Management daemon).

## Error Handling

Proper handling of errors during runtime is an important aspect to build safe and se- cure systems. The AUTOSAR Adaptive Platform does provide means for raising and handling of such errors on different levels in the platform.

> 正确处理运行时发生的错误是构建安全可靠系统的重要方面。AUTOSAR Adaptive Platform 提供了在平台不同层次上报告和处理这些错误的手段。

[Platform Health Management](#_bookmark186) detects errors (errors in the logical control flow, missed deadlines, and missed liveness reporting) at the level of Processes and performs recovery actions (for example, degradation) according to rules defined in the Manifest. [Execution Management](#_bookmark61) detects unexpected termination of Pro- cesses and reports to [State Management](#_bookmark76) for handling of such errors.

> 平台健康管理(#\_bookmark186)可以检测出逻辑控制流中的错误、未按时完成的任务和未及时报告的活动性，并根据清单中定义的规则执行恢复操作(例如降级)。执行管理(#\_bookmark61)可以检测到进程的意外终止，并将此错误报告给状态管理(#\_bookmark76)以处理。

During execution of a Process of an [Adaptive Application](#_bookmark24), different abnormal conditions might be detected and need to be handled and/or reported. The follow- ing types of unsuccessful operations are distinguished within the AUTOSAR Adaptive Platform:

> 在[自适应应用](#_bookmark24)的过程中，可能会检测到不同的异常情况，需要处理和/或报告。AUTOSAR 自适应平台内部区分了以下类型的不成功操作：

- An Error is the inability of an AUTOSAR Runtime for Adaptive Applications API function to fulfill its specified purpose. An Error it is often a consequence of invalid and/or unexpected input data. An Error is considered to be recoverable and therefore shall be handled by applications.

> 一个错误是 AUTOSAR 运行时适应性应用程序 API 函数无法实现其指定目的的能力。错误通常是无效和/或意外的输入数据的结果。错误被认为是可恢复的，因此应由应用程序处理。

- A Violation is the consequence of failed pre- or post-conditions of internal state of the AUTOSAR Runtime for Adaptive Applications. A Violation is con- sidered to be non-recoverable.

> 违反是自适应应用程序的 AUTOSAR 运行时内部状态的前置或后置条件失败的后果。违反被认为是不可恢复的。

- A Corruption is the consequence of the corruption of a system resource, e.g. stack or heap overflow, or a hardware memory flaw (for example, a detected bit flip). A Corruption is considered to be non-recoverable.

> 损坏是系统资源损坏的结果，例如堆栈或堆栈溢出，或硬件内存缺陷(例如，检测到的位翻转)。损坏被认为是不可恢复的。

- A failed default allocation is the inability of the AUTOSAR Runtime for Adaptive Applications's default memory allocation mechanism to satisfy an allo- cation request (for example, there is not enough free memory available).

> 无法满足分配请求的默认分配失败是 AUTOSAR 运行时适应应用程序的默认内存分配机制无法满足分配请求(例如，可用内存不足)。

It is expected that a Violation or Corruption will not be experienced by a user of the AUTOSAR Adaptive Platform (i.e. an application developer), unless there is some- thing seriously wrong in the overall system. For example, faulty hardware may lead to a Corruption. A Violation may occur if basic assumptions about resource require- ments are violated, or the user runs the AUTOSAR Runtime for Adaptive Applications in a configuration that is not supported by its vendor.

> 预期不会出现任何 AUTOSAR Adaptive Platform(即应用程序开发者)用户的违规或腐败，除非整个系统出现严重问题。例如，故障硬件可能会导致腐败。如果违反了资源需求的基本假设或者用户运行的 AUTOSAR Runtime for Adaptive Applications 配置不受其供应商支持，可能会发生违规。

## Trusted Platform

To guarantee the correct function of the system, it is crucial to ensure that the code ex- ecuted on the AUTOSAR Adaptive Platform is unaltered (integrity) and has legitimate origin (authenticity). Keeping this property allows the integrator to build a Trusted Platform. A key property of a system that implements a Trusted Platform is a Trust Anchor (also called Root of Trust). A Trust Anchor is often realized

> 为了保证系统的正确功能，确保在 AUTOSAR Adaptive Platform 上执行的代码不受改变(完整性)并具有合法的起源(真实性)至关重要。保持这一特性允许集成器构建一个可信平台。实现可信平台的系统的一个关键属性是可信锚点(也称为可信根)。可信锚点通常是实现的。

as a public key that is stored in a secure environment, e.g. in non-modifiable persistent memory or in an Hardware Security Module. A system designer is responsible to ensure that the system starts beginning with a Trust Anchor and that the chain of trust is kept until the [Execution Management](#_bookmark61) is launched. Depending on the mech- anism that is chosen by the system designer to establish the chain of trust, the integrity and authenticity of the entire system (including all executables) may be checked during system start-up. Alternatively, the system designer might only ensure that the already executed software has been checked regarding integrity and authenticity and [Execu-](#_bookmark61) [tion Management](#_bookmark61) takes over responsibility on continuing the chain of trust when it takes over control of the system. In the latter case, the system integrator is responsible to ensure that the [Execution Management](#_bookmark61) is configured accordingly.

> 作为一个存储在安全环境中的公钥，例如存储在不可修改的持久内存中或硬件安全模块中。系统设计者负责确保系统从信任锚点开始启动，并确保信任链在启动[执行管理](#_bookmark61)时保持不变。根据系统设计者选择的建立信任链的机制，可以在系统启动时检查整个系统(包括所有可执行文件)的完整性和真实性。或者，系统设计者可以仅确保已执行的软件已经检查了完整性和真实性，并且[执行管理](#_bookmark61)在接管系统控制权时负责继续保持信任链。在后一种情况下，系统集成商负责确保[执行管理](#_bookmark61)得到正确配置。

Passing trust requires that a trusted entity checks (using trusted functionality) that the entity down the chain is authentic. The Trust Anchor (the first entity in the chain) is authentic by definition. An example of such a chain of trust could look like this: The Trust Anchor authenticates the bootloader before the bootloader is being started. In each subsequent step in the boot process, the to-be-started executable shall be au- thenticated first, for example by the executable started previously or by some external entity like an Hardware Security Module. After the relevant parts of the [Operat-](#_bookmark28) [ing System](#_bookmark28) have been authentically started, it shall launch [Execution Manage-](#_bookmark61) [ment](#_bookmark61) as one of its first processes in the same manner passing trust to the AUTOSAR Adaptive Platform. Then, [Execution Management](#_bookmark61) takes over the responsibility of authenticating [Adaptive Application](#_bookmark24)s before launching them.

> 传递信任需要一个可信任的实体(使用可信任的功能)检查链中下一个实体是否真实可靠。信任锚点(链中的第一个实体)默认是可信任的。这样的信任链的一个例子可以是：信任锚点在启动引导程序之前验证它。在启动过程的每一步，要启动的可执行文件应该首先被验证，例如由先前启动的可执行文件或某些外部实体(如硬件安全模块)验证。在真实启动相关的操作系统部分之后，它应该以相同的方式启动执行管理作为它的第一个进程，将信任传递给 AUTOSAR 自适应平台。然后，执行管理负责在启动自适应应用程序之前验证它们。

As stated above, if authenticity is not checked by the functionality of the Trust An- chor itself, which is authentic by definition, the functionality that shall be applied to verify authenticity of an executable has to be authenticated as well before it is applied. For instance, if the Crypto Functional Cluster shall be used to verify authentic- ity of executables, the Crypto Functional Cluster itself shall be authenticated by some trusted entity before it is used.

> 如上所述，如果可信锚点本身的功能没有检查真实性(由定义可知是可信的)，则必须在应用它之前验证用于验证可执行文件真实性的功能是否可信。例如，如果要使用加密功能集群来验证可执行文件的真实性，则必须在使用之前由某个可信实体验证加密功能集群本身。

## Secure Communication

AUTOSAR supports different protocols that provide communication security over a net- work. Integrity of messages can be ensured by the end-to-end protection offered by the \[[10](#_bookmark332), AUTOSAR E2E library\]. End-to-end protection assumes that safety- and security- related data exchange shall be protected at runtime against the effects of faults within the communication link. Such faults include random hardware faults (e.g. corrupt regis- ters of a transceiver), interference (e.g. electromagnetic interference), and systematic faults in the communication stack. The configuration of end-to-end-protection is done via Service Instance Manifest on level of Service events, methods, and fields (notifier, get, and set methods). Confidentiality and authenticity of messages can be ensured by dedicated configurations for the individual transport protocols (e.g. TLS, SecOC) in the Service Instance Manifest on level of Service events, meth- ods, and fields (notifier, get, and set methods).

> AUTOSAR 支持不同的协议，可以在网络上提供通信安全。消息的完整性可以通过[10]，AUTOSAR E2E 库提供的端到端保护来确保。端到端保护假设安全和安全相关的数据交换应该在通信链路中的故障的影响下运行时保护。这些故障包括随机硬件故障(例如，收发器的错误寄存器)，干扰(例如，电磁干扰)以及通信堆栈中的系统故障。端到端保护的配置是通过服务实例清单在服务事件、方法和字段(通知者，获取和设置方法)的级别上完成的。消息的机密性和真实性可以通过为单个传输协议(例如 TLS，SecOC)在服务实例清单的服务事件、方法和字段(通知者，获取和设置方法)的级别上的专用配置来确保。

# Risks and Technical Debt

This chapter lists and rates risks associated with the overall architecture of the AU- TOSAR Adaptive Platform in Section [14.1](#risks). These risks usually might cause that some of the quality attributes of the AUTOSAR Adaptive Platform are not (fully) meat. Sec- tion [14.2](#technical-debt) lists technical debt of the AUTOSAR Adaptive Platform that may impact its maintainability.

> 本章节列出和评估与 AUTOSAR Adaptive Platform 的整体架构相关的风险，在[14.1](#risks)中。这些风险通常可能导致 AUTOSAR Adaptive Platform 的某些质量属性不能(完全)满足。[14.2](#technical-debt)部分列出了可能影响其可维护性的 AUTOSAR Adaptive Platform 的技术债务。

1. ## Risks

   1. ### Risk Assessment

> ### 风险评估

This document categorizes risks according to their severity. The severity is a function of the probability and the impact of a risk. The probabilities are categorized as follows:

> 这份文件根据风险的严重性对风险进行了分类。严重性是概率和风险影响的函数。概率分为以下几类：

- **very low** - probability is less than 1 thousandth
- **low** - probability is between 1 thousandth and 1 percent
- **medium** - probability is between 1 percent and 10 percent
- **high** - probability is between 10 percent and 50 percent

- **very high** - probability is more than 50 percent The impact of a risk is categorized as follows:

> 风险的影响可以分为以下几类：**非常高** - 概率超过 50％

- **very low** - at most one quality scenario will take additional significant effort to be satisfied

> 最多只有一个质量场景需要额外的重大努力才能满足。

- **low** - more than one quality scenario will take additional significant effort to be satisfied
- **medium** - at most one quality scenario is not satisfied with small gaps
- **high** - at most one quality scenario is not satisfied with big gaps

- **very high** - more than one quality scenario is not satisfied with big gaps The final severity of a risk is then calculated according to table [14.1](#_bookmark320).

> 风险的最终严重程度然后根据表 14.1 来计算，但是超过一个质量场景都不满足，存在较大差距。

[]{#\_bookmark320 .anchor}**Probability**

> 概率

**Table 14.1: Risk Severity Matrix**

> 表 14.1：风险严重性矩阵

### Risk List

No architectural risks were identified yet.

> 暂时没有发现任何架构风险。

## Technical Debt

No technical debt has been identified yet.

> 尚未发现技术债务。

# References

1. []{#\_bookmark323 .anchor}ISO 42010:2011 -- Systems and software engineering -- Architecture description []{#\_bookmark324 .anchor}[http://www.iso.org](http://www.iso.org/)

> ISO 42010:2011－系统和软件工程－架构描述－[http://www.iso.org](http://www.iso.org/)

2. Explanation of Adaptive and Classic Platform Software Architectural Decisions []{#\_bookmark325 .anchor}AUTOSAR_EXP_SWArchitecturalDecisions

> 自适应和经典平台软件架构决策的解释[]{#\_bookmark325 .anchor}AUTOSAR_EXP_SWArchitecturalDecisions

3. Glossary []{#\_bookmark326 .anchor}AUTOSAR_TR_Glossary

> 3.术语表[]{#\_bookmark326 .anchor}AUTOSAR_TR_Glossary

4. Main Requirements []{#\_bookmark327 .anchor}AUTOSAR_RS_Main

> 4. 主要要求[ ]{#\_bookmark327 .anchor}AUTOSAR_RS

5. General Requirements specific to Adaptive Platform []{#\_bookmark328 .anchor}AUTOSAR_RS_General

> 五、适用于 Adaptive Platform 的一般要求[]{#\_bookmark328 .anchor}AUTOSAR_RS_General

6. ATAMSM: Method for Architecture Evaluation [https://resources.sei.cmu.edu/asset_files/TechnicalReport/2000_005_001](https://resources.sei.cmu.edu/asset_files/TechnicalReport/2000%5Chskip%200em%7B%7D_005%5Chskip%200em%7B%7D_001%5Chskip%200em%7B%7D_13706.pdf)

> 6. ATAMSM：架构评估方法[https://resources.sei.cmu.edu/asset_files/TechnicalReport/2000_005_001](https://resources.sei.cmu.edu/asset_files/TechnicalReport/2000%5Chskip%200em%7B%7D_005%5Chskip%200em%7B%7D_001%5Chskip%200em%7B%7D_13706.pdf)

[]{#\_bookmark329 .anchor}[\_13706.pdf](https://resources.sei.cmu.edu/asset_files/TechnicalReport/2000%5Chskip%200em%7B%7D_005%5Chskip%200em%7B%7D_001%5Chskip%200em%7B%7D_13706.pdf)

> []{#\_bookmark329 .anchor}[\_13706.pdf](https://resources.sei.cmu.edu/asset_files/TechnicalReport/2000%5Chskip%200em%7B%7D_005%5Chskip%200em%7B%7D_001%5Chskip%200em%7B%7D_13706.pdf)

请点击此处查看\_13706.pdf：https://resources.sei.cmu.edu/asset_files/TechnicalReport/2000%5Chskip%200em%7B%7D_005%5Chskip%200em%7B%7D_001%5Chskip%200em%7B%7D_13706.pdf

7. []{#\_bookmark330 .anchor}Agile Software Development: Principles, Patterns, and Practices

> 敏捷软件开发：原则、模式和实践

8. Guide to the Software Engineering Body of Knowledge, Version 3.0 []{#\_bookmark331 .anchor}[www.swebok.org](http://www.swebok.org/)

> 引导到软件工程知识体系，版本 3.0(www.swebok.org)

9. Specification of Manifest []{#\_bookmark332 .anchor}AUTOSAR_TPS_ManifestSpecification

> 9. 清单规格说明[]{#\_bookmark332 .anchor}AUTOSAR_TPS_ManifestSpecification

10. Specification of SW-C End-to-End Communication Protection Library AUTOSAR_SWS_E2ELibrary

> 10. AUTOSAR_SWS_E2ELibrary 端到端通信保护库的规范

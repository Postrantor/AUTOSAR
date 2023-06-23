# **Contents**

# 1. [] {#_bookmark0 .anchor}**Introduction**

This explanatory document provides detailed technical description of the software ar- chitecture of the AUTOSAR Adaptive Platform standard with the main focus on the architecture model.

## 1. [] {#_bookmark1 .anchor}**Objectives**

This document is an architecture description of the AUTOSAR Adaptive Platform in accordance to \[[1](#_bookmark323), ISO/IEC 42010\] and has the following main objectives:

- Identify the **stakeholders** of the AUTOSAR Adaptive Platform and their **con- cerns**.
- Identify the **system scope** and provide **overview information** of the AUTOSAR Adaptive Platform.
- Provide definitions for all used **architecture viewpoints** and a **mapping of all stakeholder concerns to those viewpoints**.
- Provide an **architecture view** and its **architecture models** for each architecture viewpoint used in this architecture description.
- Provide **correspondence rules** and **correspondences** among the contents of this architecture description.
- Provide an **architecture rationale** (explanation, justification, reasoning for de- cisions made) on a high level. A more in-depth documentation of decisions is provided in \[[2](#_bookmark324), EXP_SWArchitecturalDecisions\].
- Provide a **record of known inconsistencies and gaps** among the architecture description.

There is some potential for ambiguity about the term \"architecture\". Association with this term is quite different e.g., for a mass production project in contrast with Adap- tive Platform standardization. For system development of an automotive embedded computer the software architecture usually defines the details of the structural and the behavioral architecture views down to module level. In contrast the architecture of AU- TOSAR Adaptive Platform lacks such details deliberately to provide more degrees of freedom for stack vendors in their solution design.

Beyond the specification of APIs the term \"architecture\" for Adaptive Platform refers to guidelines how to apply the standard to concrete development projects.

This document describes the original architectural design of the AUTOSAR Adaptive Platform including details how the building blocks should interact with each other. It is an example how an implementation of the standard should work internally. However, a stack vendor is free to choose another design as long as it complies with the binding AUTOSAR Adaptive Platform standard.

1. []{#_bookmark2 .anchor}**Scope**

This explanatory document applies to the AUTOSAR Adaptive Platform. It is recom- mended to get an overview of the AUTOSAR Adaptive Platform for all members of the working groups, stack vendors, and application developers.

2. []{#_bookmark3 .anchor}**Document Structure**

This document is organized as follows. Section [4](#_bookmark8) provides an overview of the main requirements for the AUTOSAR Adaptive Platform, the top quality goals of its architec- ture, and a list of stakeholders that are affected by it. Section [5](#_bookmark12) lists requirements that constrain design and implementation decisions or decisions about the development process.

Section [6](#_bookmark15) is the base for discovering trade-offs and sensitivity points in the architecture of the AUTOSAR Adaptive Platform by introducing a quality attribute tree followed by the most important quality scenarios. The system context in which the AUTOSAR Adaptive Platform is intended to be used is outlined in section [7](#_bookmark21). Section [8](#_bookmark40) summarizes the fundamental decisions and solution strategies, that shape the architecture of the AUTOSAR Adaptive Platform such as technology decisions or architectural patterns to be used.

Sections [9](#building-block-view) to [12](#_bookmark293) explain the software architecture from different view points. First, sec- tion [9](#building-block-view) explains the decomposition of the AUTOSAR Adaptive Platform into Functional Clusters and their interdependencies. Then, section [11](#runtime-view) demonstrates how the main use cases are realized using the Functional Clusters in the AUTOSAR Adaptive Plat- form. Section [12](#_bookmark293) shows different scenarios how applications based on the AUTOSAR Adaptive Platform may be deployed.

Section [13](#cross-cutting-concepts) provides an overview of concepts and patterns used by the AUTOSAR Adaptive Platform. Section [14](#risks-and-technical-debt) lists and rates risks associated with the architecture of the AUTOSAR Adaptive Platform and technical debt.

2. []{#_bookmark4 .anchor}**Definition of Terms and Acronyms**

   1. []{#_bookmark5 .anchor}**Acronyms and Abbreviations**

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

2. []{#_bookmark6 .anchor}**Definition of Terms**

This section lists terms that are specific to this document. A list of general terms for AUTOSAR is provided in the \[[3](#_bookmark325), glossary\].

```
```

3. []{#_bookmark7 .anchor}**Related Documentation**

This document provides a high-level overview of the AUTOSAR Adaptive Platform ar- chitecture. It is closely related to general requirements for AUTOSAR Adaptive Plat- form specified in \[[4](#_bookmark326), RS_Main\] and \[[5](#_bookmark327), RS_General\], and the architectural decisions documented in \[[2](#_bookmark324), EXP_SWArchitecturalDecisions\].

The individual building blocks of the architecture (Functional Clusters) are spec- ified in separate documents. Each Functional Cluster defines one or more requirements specification(s) (RS document), one or more software specification(s) (SWS document) and one or more explanatory document(s) (EXP document). Please refer to these documents for any details on the AUTOSAR Adaptive Platform standard.

4. []{#_bookmark8 .anchor}**Overview and Goals**

In conventional automotive systems ECUs are used to replace or augment electro- mechanical systems. Those resource constrained, deeply-embedded ECUs typically perform basic control functions by creating electrical output signals (e.g. for actors) based on input signals (e.g. from sensors) and information from other ECUs con- nected to the vehicle network. Much of the control software is specifically designed and implemented for the target vehicle and does not change significantly during vehi- cle lifetime. The AUTOSAR Classic Platform standard addresses the needs of these deeply-embedded systems.

Recent and future vehicle functions, such as highly automated driving, will introduce complex and computing resource demanding software that shall fulfill strict safety, in- tegrity and security requirements. Such software performs for example, environment perception and behavior planning, and interacts with external backend and infrastruc- ture systems. The software in the vehicle regularly needs to be updated during the life-cycle of the vehicle, due to evolving external systems, improved or added function- ality, or security problems. The AUTOSAR Classic Platform standard cannot fulfill the needs of such systems. Therefore, AUTOSAR specifies a second software platform, the AUTOSAR Adaptive Platform. It provides high-performance computing and com- munication mechanisms as well as a flexible software configuration, for example, to support software update over-the-air. Features that are specifically defined for the AU- TOSAR Classic Platform, such as access to electrical signals and automotive specific bus systems, can be integrated into the AUTOSAR Adaptive Platform but is not in the focus of standardization.

1. []{#_bookmark9 .anchor}**Requirements Overview**

This section provides an overview of the basic requirements for the AUTOSAR Adap- tive Platform that impact its architecture. The corresponding requirement identifiers are provided in square brackets. Please refer to \[[4](#_bookmark326), RS_Main\] and \[[5](#_bookmark327), RS_General\] for any details, rationale or intended use-cases of these requirements.

**Support of state-of-the-art Technology**

The AUTOSAR Adaptive Platform aims to support resource-intensive (memory, cpu) applications on state-of-the-art hardware. Therefore, the AUTOSAR Adaptive Platform shall support high performance computing platforms \[RS_Main_00002\] as well as vir- tualized environments \[RS_Main_00511\]. The AUTOSAR Adaptive Platform shall be able to run multiple applications in parallel \[RS_Main_00049\], each with concurrent application internal control flows \[RS_Main_00050\].

**Software Update and Configuration**

The AUTOSAR Adaptive Platform shall support a flexible (configuration) data and soft- ware update. Hereby, AUTOSAR Adaptive Platform shall support up- and download of such update packages \[RS_Main_00650\] and change of communication and applica- tion software at runtime \[RS_Main_00503\].

AUTOSAR shall provide a unified way to describe software systems deployed to Adaptive and / or Classic platforms \[RS_Main_00161\]. That kind of description shall also support the deployment and reallocation of AUTOSAR Application Software \[RS_Main_00150\], and shall provide means to describe interfaces of the entire system \[RS_Main_00160\].

**Security**

The AUTOSAR Adaptive Platform shall support the development of secure systems \[RS_Main_00514\] with secure access to ECU data and services \[RS_Main_00170\], and secure onboard communication \[RS_Main_00510\].

**Safety**

The AUTOSAR Adaptive Platform shall support the development of safety related systems \[RS_Main_00010\] that are reliable \[RS_Main_00011\] and highly available \[RS_Main_00012\]. The AUTOSAR Adaptive Platform specifications shall be analyz- able and support methods to demonstrate the achievement of safety related properties accordingly \[RS_Main_00350\].

**Reuse and Interoperability**

The AUTOSAR Adaptive Platform shall support standardized interoperability with non-AUTOSAR software \[RS_Main_00190\] as well as (source code) portability for AUTOSAR Adaptive Applications across different implementations of the platform \[RS_AP_00111\]. Hereby, the AUTOSAR Adaptive Platform shall provide means to describe a component model for application software \[RS_Main_00080\], and support bindings for different programming languages \[RS_Main_00513\].

**Communication**

The AUTOSAR Adaptive Platform shall support standardized automotive communica- tion protocols \[RS_Main_00280\] for intra ECU communication \[RS_Main_01001\] with different network topologies \[RS_Main_00230\].

**Diagnostics**

The AUTOSAR Adaptive Platform shall provide diagnostics means during runtime for production and services purposes \[RS_Main_00260\].

2. []{#_bookmark10 .anchor}**Quality Goals**

This section will list the top quality goals for the architecture whose fulfillment is of highest importance to the major stakeholders in a future version of this document. Please refer to the currently un-prioritized list of Quality Attributes in Section [6.1](#_bookmark16).

3. []{#_bookmark11 .anchor}**Stakeholders**

This section lists the stakeholders of the AUTOSAR Adaptive Platform architecture and their main expectations.

```

```

**Table 4.1: Stakeholder table with roles and expectations**

5. []{#_bookmark12 .anchor}**Architecture Constraints**

AUTOSAR is a worldwide development partnership of vehicle manufacturers, suppli- ers, service providers and companies from the automotive electronics, semiconductor and software industry. AUTOSAR standardizes the AUTOSAR Adaptive Platform au- tomotive middleware. The AUTOSAR Adaptive Platform is not a concrete implemen- tation. The AUTOSAR Adaptive Platform standard leaves a certain degree of freedom to implementers of the standard, as most standards do. On the one hand, more free- dom enables competition among the different implementations and a broader choice of properties for users of the AUTOSAR Adaptive Platform. On the other hand, a more strict standardization makes the different implementations compatible and exchange- able (within the standardized scope). Naturally, those attributes are in conflict. It is usually a choice of the standardization organization to evaluate the attributes and de- fine the desired level of strictness.

The AUTOSAR Classic Platform is rather strict in that sense by specifying a detailed layered software architecture imposing many constraints on its implementations. The AUTOSAR Adaptive Platform launched with a less strict approach. That less strict approach puts constraints on the AUTOSAR Adaptive Platform architecture as outlined below.

1. []{#_bookmark13 .anchor}**Internal Interfaces**

An important architectural constraint is that only interfaces that are intended to be used by applications or interfaces that are used to extend the functionality of the AUTOSAR Adaptive Platform shall be standardized. Internal interfaces between the building blocks of the AUTOSAR Adaptive Platform shall not be standardized. This approach leaves a lot of freedom to design and optimize the internals of an AUTOSAR Adaptive Platform stack. However, it also imposes constraints on how the AUTOSAR Adaptive Platform architecture can be defined and described in this document. Also, this means that it might not be possible to use different functional clusters from different AUTOSAR Adaptive Platform stack vendors.

First, the existence of internal interfaces and their usage by other building blocks is in most cases a recommendation and reflects the original design approach of the authors of the standard. The same applies to any interactions described in this document that make use of such internal interfaces.

Second, some quality attributes may be hard to ensure in general by the architec- ture of the standard. Additional measures like security or safety considerations lack well-defined inputs such as data flows or specifications of interdependencies. Con- sequently, a more thorough design phase is required when an AUTOSAR Adaptive Platform stack is implemented.

2. []{#_bookmark14 .anchor}**Distributed Work**

Standardization of the AUTOSAR Adaptive Platform is a worldwide distributed effort. The individual building blocks are specified by dedicated working groups in separate documents to be able to scale in that distributed setup. This impacts the way the AUTOSAR Adaptive Platform architecture is described in this document.

First, this document shows interfaces on an architectural level only. This document does not specify details of interfaces such as individual operations. This keeps redun- dancies and thus dependencies between this document and the documents actually specifying the individual building blocks manageable. Another consequence is that the interactions shown in this document are not based on actual operations specified in the interfaces but rather on an architectural level as well.

Second, this document aims to provide guidance for the working groups in specify- ing the individual building blocks by defining patterns and concepts to solve common problems. This guidance should help to build a uniform and consistent standard from ground up.

6. []{#_bookmark15 .anchor}**Quality Requirements**

Quality requirements define the expectations of AUTOSAR Adaptive Platform stake- holders for the quality and the attributes of the AUTOSAR Adaptive Platform standard that indicate whether the quality factors are satisfied or not. Section [6.1](#_bookmark16) starts by list- ing the quality attributes that, in the end, are used to assess whether the AUTOSAR Adaptive Platform and its software architecture satisfies the expected quality factors or not. Section [6.2](#_bookmark20) then provides quality scenarios that operationalize quality attributes and turn them into measurable quantities by describing the reaction of the system to a stimulus in a certain situation.

1. []{#_bookmark16 .anchor}**Quality Attributes**

The AUTOSAR Adaptive Platform has many stakeholders with different concerns. Thus, this document uses the following three quality attribute categories that corre- spond to the three main stakeholder groups in order to make the requirements and their impact on the architecture more comprehensible:

- **AUTOSAR Adaptive Platform Standard:** Quality requirements for the AU- TOSAR standard itself. These requirements may directly affect the architecture of the AUTOSAR Adaptive Platform.
- **AUTOSAR Adaptive Platform Stack:** Quality requirements for an implementa- tion of the AUTOSAR standard as an AUTOSAR stack. These requirements may indirectly affect the architecture of the AUTOSAR Adaptive Platform.
- **AUTOSAR Adaptive Application:** Quality requirements for an application based on an AUTOSAR stack. These requirements may transitively affect the architec- ture of the AUTOSAR Adaptive Platform.

The quality attributes are organized according to the Architecture Tradeoff Analysis Method (ATAM) \[[6](#_bookmark328)\] as a tree, one for each of the quality attribute categories. The leafs of those trees are the individual quality attributes.

1. []{#_bookmark17 .anchor}**AUTOSAR Adaptive Platform Standard**

- Functional suitability

  - The software architecture shall reflect the project objectives (POs) and be the consistent source for all specifications (here: completeness with respect to the PO; see also usability below).
  - The standard shall not contain elements that are not traceable to POs, change requests (CRs), or concepts.
  - The standard shall contain at least one element derived from each PO, CR, or concept.
- Performance efficiency

  - The specification shall allow for a run-time efficient implementation. Run- time efficiency refers to all resource consumption, CPU, RAM, ROM.
- Compatibility

  - The standard shall retain older versions of its elements in the face of change.
  - The standard shall be interoperable with pre-existing standards, especially the AUTOSAR Classic Platform. Pre-existing standards means network pro- tocols and the like.
  - The standard shall adopt new versions of pre-existing standards only after an impact analysis.
- Usability

  - The use of the standard shall be as easy as possible for suppliers and appli- cation developers. Easy means: not much material and resources required.
  - The holistic approach shall not be broken (avoid different approaches in one standard).
  - The standard shall contain application sample code for all its elements.
  - The standard shall contain documentation of the use cases for its elements.
  - The standard shall document the semantics of its elements.
  - The standard shall document its decisions, consequences, and implemen- tation restrictions (both for stack & apps) including their rationale.
  - The standards elements shall be easy to use and hard to misuse.
  - The standard shall stick to pre-existing standards, as far as no functional requirements are compromised.
  - The standard shall be as stable as possible.
  - AUTOSAR standards shall not change disruptive but rather evolve evolution- ary (for example, backward-compatibility can be a help).
  - The software architecture shall reflect the PO and be the consistent source for all specifications (here: consistency; see also functional suitability above).
- Reliability

  - The standard shall classify its elements with respect to safety relevance (that is, functional clusters shall be marked if they participate in safety critical operations of the platform).
  - The standard shall specify control flow restrictions between its elements in order to achieve freedom from interference.
  - The standard shall contain use case driven argumentation for safety sce- narios that can be used to build a safety case. (This should help the stack implementers in getting a certification, if they follow the standard.)
- Security

  - The standard shall specify data flow restrictions between its elements, and between applications.
  - The standard shall classify its elements with respect to security sensitivity (that is, functional clusters shall be marked if they handle sensitive data.)
  - The standard shall contain use case driven argumentation for security sce- narios that can be used to build a security case. (This should help the stack implementers in getting a certification, if they follow the standard.)
- Maintainability

  - It shall be possible in an efficient way to maintain AUTOSAR Adaptive Plat- form without preventing the introduction of new technologies (efficient in terms of effort on the modification of the standard).
  - The impact set of a change shall be available.
  - The standard shall be structured in a way that minimizes change impact.
  - It shall be possible to drop/deprecate elements of the standard.
  - It shall be easy to add new features/needs without breaking the maintain- ability or the need to redesign the software architecture. Easy means quick, with low effort, local changes only and no heavy side effects.
  - The maturity of parts of the standard shall be visible.
  - The process shall enforce an architectural impact analysis in a very early stage of the change process.
  - The process shall enforce minimizing changes, that is not adding similar functionality multiple times.
- Portability

  - Applications shall be portable between different stack implementations and different machines.
  - It shall be possible to scale the software architecture to the given project needs.

    1. []{#_bookmark18 .anchor}**AUTOSAR Adaptive Platform Stack**

```{=html}
<!-- -->
```

- Compatibility

  - An AUTOSAR Adaptive Platform stack implementation shall be capable to offer multiple versions of the same service.
  - An instance of an AUTOSAR Adaptive Platform stack implementation shall be able to co-exist with other instances on different machines, within the same vehicle.
- Usability

  - An AUTOSAR Adaptive Platform stack implementation shall explicitly doc- ument restrictions on the application development that go beyond the stan- dard.
- Maintainability

  - An AUTOSAR Adaptive Platform stack implementation shall be traceable to the contents of the standard.
  - An AUTOSAR Adaptive Platform stack implementation shall support multiple versions of the same service.
- Portability

  - An AUTOSAR Adaptive Platform stack shall be portable to a different custom hardware.
  - An AUTOSAR Adaptive Platform stack shall provide mechanisms to replace parts.

    1. []{#_bookmark19 .anchor}**AUTOSAR Adaptive Application**

```{=html}
<!-- -->
```

- Usability

  - *No Goal:* An application developer shall be able to supply custom implemen- tation for pre-defined platform functionality.
- Maintainability

  - An application shall explicitly state which parts of the standard it uses.
- Portability

  - An application entirely based on AUTOSAR Adaptive Platform (i.e. with- out custom extensions) shall be portable to another AUTOSAR Adaptive Platform stack of the same version without modifications to the application source code itself (source code compatibility).

  1. []{#_bookmark20 .anchor}**Quality Scenarios**

There are currently no quality scenarios defined for the AUTOSAR Adaptive Platform.

7. []{#_bookmark21 .anchor}**System Scope and Context**

This chapter provides an overview of the AUTOSAR Adaptive Platform system context by separating the AUTOSAR Adaptive Platform and its communication partners (e.g., external systems). Considering Figure [7.1](#_bookmark22), there are three categories of communica- tion partners for the AUTOSAR Adaptive Platform.

![](./media/image1.png)
![](./media/image2.png)
![](./media/image1.png)
**Figure 7.1:** []{#_bookmark22 .anchor}**Overview of AUTOSAR Adaptive Platform and its context**

The AUTOSAR Adaptive Platform is conceptually a middleware. AUTOSAR Adaptive Platform provides services to [Adaptive Application](#_bookmark24)s beyond those available from the underlying operating system, drivers, and extensions (cf. Section [7.2](#_bookmark25)). Section

[7.3](#_bookmark31) describes the third category that are external systems communicating with (an

[Adaptive Application](#_bookmark24) via) AUTOSAR Adaptive Platform.

1. []{#_bookmark23 .anchor}**Adaptive Application**

[]{#_bookmark24 .anchor}[Adaptive Application](#_bookmark24)s are built on the functionality provided by the AUTOSAR Adaptive Platform. They directly use the various interfaces provided by the individual building blocks of AUTOSAR Adaptive Platform described in more detail in chapter [9](#building-block-view).

2. []{#_bookmark25 .anchor}**Dependencies**

   1. []{#_bookmark26 .anchor}**Crypto Provider**

Crypto Provider is a component that provides implementations of cryptographic routines and hash functions to the AUTOSAR Adaptive Platform.

2. []{#_bookmark27 .anchor}**Operating System**

[]{#_bookmark28 .anchor}The [Operating System](#_bookmark28) is the main component that AUTOSAR Adaptive Plat- form uses to provide its services. The [Operating System](#_bookmark28) controls processes and threads, and provides inter-process communication facilities. The [Operating Sys-](#_bookmark28) [tem](#_bookmark28) also provides access to network interfaces, protocols like TCP/IP, and access to non-volatile storage.

3. []{#_bookmark29 .anchor}**Watchdog**

[]{#_bookmark30 .anchor}The [Watchdog](#_bookmark30) is a component to control the hardware watchdog of the machine an AUTOSAR Adaptive Platform runs on.

3. []{#_bookmark31 .anchor}**External Systems**

![](./media/image3.png)

**Figure 7.2: Overview of the AUTOSAR Adaptive Platform and external systems**

The AUTOSAR Adaptive Platform supports applications that are operated in heteroge- neous environments. This section lists the external systems that AUTOSAR Adaptive Platform is intended to interface.

1. []{#_bookmark32 .anchor}**AUTOSAR Adaptive Application**

There may be many [Adaptive Application](#_bookmark24)s deployed in a vehicle on different Ma- chines. An [Adaptive Application](#_bookmark24) that does not run on the current instance of the AUTOSAR Adaptive Platform is therefore an external system to the AUTOSAR Adap- tive Platform. Such [Adaptive Application](#_bookmark24)s may exchange data such as sensor or status information by means of ara::com service interfaces.

2. []{#_bookmark33 .anchor}**AUTOSAR Classic Platform**

[]{#_bookmark34 .anchor}The [AUTOSAR Classic Platform](#_bookmark34) is the main platform for deeply-embedded appli- cations such as sensor/actor systems. [Adaptive Application](#_bookmark24)s may require ac- cess for example to sensor data provided by an [AUTOSAR Classic Platform](#_bookmark34) ECU and vice versa.

3. []{#_bookmark35 .anchor}**Third-party Platform**

Besides the both platforms (AUTOSAR Adaptive Platform and [AUTOSAR Classic](#_bookmark34) [Platform](#_bookmark34)) provided by AUTOSAR, there may be ECUs in a vehicle and other sys- tems that are built on different platforms that need to communicate with an [Adaptive](#_bookmark24) [Application](#_bookmark24) via AUTOSAR Adaptive Platform.

4. []{#_bookmark36 .anchor}**Diagnostic Client**

[]{#_bookmark37 .anchor}A [Diagnostic Client](#_bookmark37) uses the diagnostic services provided by the AUTOSAR Adaptive Platform.

5. []{#_bookmark38 .anchor}**Backend**

[]{#_bookmark39 .anchor}A [Backend](#_bookmark39) system provides Software Packages for download and controls the update process via [Update and Configuration Management](#_bookmark200).

8. []{#_bookmark40 .anchor}**Solution Strategy**

The AUTOSAR Adaptive Platform is a standard for an automotive middleware. It is not a concrete implementation. The AUTOSAR Adaptive Platform standard leaves a certain degree of freedom to its implementers by defining requirements and software specifications that need to be fulfilled without specifying how.

1. []{#_bookmark41 .anchor}**Architectural Approach**

To support the complex applications, while allowing maximum flexibility and scalabil- ity in processing distribution and compute resource allocations, AUTOSAR Adaptive Platform follows the concept of a service-oriented architecture (SOA). In a service- oriented architecture a system consists of a set of services, in which one may use another in turn, and applications that use one or more of the services depending on its needs. Often service-oriented architectures exhibit system-of-system characteris- tics, which AUTOSAR Adaptive Platform also has. A service, for instance, may reside on a local ECU that an application also runs, or it can be on a remote ECU, which is also running another instance of AP. The application code is the same in both cases - the communication infrastructure will take care of the difference providing transparent communication. Another way to look at this architecture is that of distributed comput- ing, communicating over some form of message passing. At large, all these represent the same concept. This message passing, communication-based architecture can also benefit from the rise of fast and high-bandwidth communication such as Ethernet.

2. []{#_bookmark42 .anchor}**Decomposition Strategy**

The building blocks of the AUTOSAR Adaptive Platform architecture are refined step- by-step in this document according to the model depicted in figure [8.1](#_bookmark43). The top-level categories are chosen to give an overview from a users perspective what kind of func- tionality the AUTOSAR Adaptive Platform provides. A category contains one or more Functional Clusters. The Functional Clusters of the AUTOSAR Adaptive Platform are defined to group a specific coherent technical functionality. Functional Clusters themselves specify a set of interfaces and components to provide and real- ize that technical functionality. The building block view also contains information of the Functional Clusters interdependencies based on interfaces from other Func- tional Clusters they use. However, note that these interdependencies are recom- mendations rather than strict specifications because they would constrain implementa- tions.

![](./media/image8.png)![](./media/image9.png)![](./media/image10.png)1..\*

**Figure 8.1:** []{#_bookmark43 .anchor}**Type model of building blocks**

3. []{#_bookmark44 .anchor}**UML Profile**

The UML diagrams presented in this document use a UML profile to provide a more precise semantics of the elements and relationships. Table [8.1](#_bookmark45) provides an overview of the stereotypes in that profile and their semantics. The names of all stereotypes that are specific to the AUTOSAR architecture are prefixed with *aap* (short for AUTOSAR Architecture Profile) to make them easily distinguishable from standard UML stereo- types and keywords.

```
```

**Table 8.1: Overview of Stereotypes**

4. []{#_bookmark46 .anchor}**Technology**

   1. ### Implementation Language

C++ is the programming language of choice for the AUTOSAR Adaptive Platform and [Adaptive Application](#_bookmark24)s. C++ was chosen due to its safer programming model (compared to C) and availability of certified compilers that produce highly optimized machine code. Such properties are especially important for safety- and performance- critical, real-time applications (such as typical [Adaptive Application](#_bookmark24)s) where C++ has become more and more popular in the software industry and academics.

### Parallel Processing

Although the design for AUTOSAR Adaptive Platform as a service-oriented architecture inherently leverages parallel processing, the advancement of (heterogeneous) many-

core processors offers additional opportunities. The AUTOSAR Adaptive Platform is designed to scale its functionality and performance as (heterogeneous) many-core technologies advance. Hardware and platform interface specifications are one part of that equation. However, advancements in operating system and hypervisor tech- nologies as well as development tools (for example automatic parallelization) are also crucial and are to be fulfilled by AUTOSAR Adaptive Platform providers, the software industry, and academics.

## Design Principles

The architecture of the AUTOSAR Adaptive Platform is based on several design prin- ciples that are outlined below.

### Leveraging existing standards

AUTOSAR Adaptive Platform aims to leverage existing standards and specifications wherever possible. For example, AUTOSAR Adaptive Platform ist built on the existing and open C++ standard (cf. Section [8.4.1](#implementation-language)) to facilitate a faster development of the AUTOSAR Adaptive Platform itself and benefiting from the eco-systems of such stan- dards. It is, therefore, a critical focus in developing the AUTOSAR Adaptive Platform specification not to casually introduce a new replacement functionality that an existing standard already offers. For instance, no new interfaces are casually introduced just because an existing standard provides the functionality required but the interface is superficially hard to understand.

### SOLID principles

The SOLID principles \[[7](#_bookmark329)\] are a central part of the design principles of AUTOSAR. While these five principles are all valid, only the Single-responsibility Principle, the Interface Segregation Principle and the Dependency Inversion Principle are relevant on the ab- straction level of this document. Therefore, they are elaborated in the following.

1. **Single-responsibility Principle**

The single-responsibility principle (SRP,SWEBOK3) \[[7](#_bookmark329)\] states that a component or class should be responsible for a single part of the overall functionality provided by the soft- ware. That responsibility should be encapsulated by the component or class. The services provided by the component or class (via its interface(s)) should be closely aligned with its responsibility.

The single-responsibility principle minimizes the reasons (i.e. a change to the single responsibility) that require a change to its interface. Thus, it minimizes impact on clients of such an interface and leads to a more maintainable architecture (or code).

2. **Interface Segregation Principle**

The interface segregation principle (ISP) \[[7](#_bookmark329)\], \[[8](#_bookmark330)\] states that clients should not be forced to depend on methods that they don't use. As a consequence of the interface segre- gation principle, interfaces should be split up to reflect different roles of clients.

Similar to the single-responsibility principle, the segregation of interfaces reduce the impact of a change to an interface to the clients and suppliers of an segregated inter- face.

3. **Dependency Inversion Principle**

The dependency inversion principle (DIP) \[[7](#_bookmark329)\], \[[8](#_bookmark330)\] states that high-level building blocks should not depend on low-level building blocks. Both should depend on abstractions (e.g. interfaces). Furthermore, the dependency inversion principle states that abstrac- tions (e.g. interfaces) should not depend on details. Details (e.g. a concrete imple- mentation) should depend on abstractions.

The dependency inversion principle results in a decoupling of the implementations of building blocks. This is important to scale implementation efforts (cf. Section [5.2](#_bookmark14)) and to perform proper integration tests.

### Acyclic Dependencies Principle

The acyclic dependencies principle (ADP) \[[7](#_bookmark329)\], \[[8](#_bookmark330)\] states that dependencies between building blocks should form a directed acyclic graph.

The acyclic dependencies principle helps to identify participating building blocks and reason about error propagation and freedom from interference. In general, it also re- duces the extend of building blocks to consider during activities such as test, build and deployment.

## Deployment

The AUTOSAR Adaptive Platform supports the incremental deployment of applica- tions, where resources and communications are managed dynamically to reduce the effort for software development and integration, enabling short iteration cycles. Incre- mental deployment also supports explorative software development phases. For prod- uct delivery, the AUTOSAR Adaptive Platform allows the system integrator to carefully

limit dynamic behavior to reduce the risk of unwanted or adverse effects allowing safety qualification. Dynamic behavior of an application will be limited by constraints stated in the Execution Manifest (cf. Section [13.8](#execution-manifest)), for example, dynamic allocation of resources and communication paths are only possible in defined ways, within config- ured ranges. Implementations of an AUTOSAR Adaptive Platform may further remove dynamic capabilities from the software configuration for production use. Examples of reduced behavioral dynamics might be:

- Pre-determination of the service discovery process
- Restriction of dynamic memory allocation to the startup phase only
- Fair scheduling policy in addition to priority-based scheduling
- Fixed allocation of processes to CPU cores
- Access to pre-existing files in the file-system only
- Constraints for AUTOSAR Adaptive Platform API usage by applications
- Execution of authenticated code only

  1. ## Verification and Validation

The AUTOSAR Adaptive Platform standard uses a dedicated implementation of the standard (AUTOSAR Adaptive Platform Demonstrator) to validate the requirements and to verify the (still abstract) software design imposed by the individual software specifications.

# Building Block View

This chapter provides an overview of the static structure of the AUTOSAR Adaptive Platform by describing the high-level building blocks and their inter-dependencies. Please note that the use of interfaces between Functional Clusters in the AU- TOSAR Adaptive Platform is currently not standardized. Some aspects, for example, access management, are also not yet fully incorporated and standardized in all Func- tional Clusters.

## Overview

Figure [9.1](#_bookmark57) provides an overview of the different categories of building blocks available in the AUTOSAR Adaptive Platform. The categories are explained in more detail in the subsequent sections.

**Figure 9.1:** []{#_bookmark57 .anchor}**Overview of the AUTOSAR Adaptive Platform and its building block cate- gories**

### Description pattern

The description of all building blocks (FunctionalClusters) in this section uses the same pattern. Each FunctionalCluster is described in a separate section of the document. Such a section starts with an overview of the responsibilities of the FunctionalCluster followed by a sub-section called \"Defined interfaces\". The sub- section \"Defined interfaces\" lists all architectural interfaces specified in the namespace of the FunctionalCluster. Each interface is detailed in a separate table.

The subsection \"Provided interfaces\" then lists all interfaces provided by the Func- tionalCluster (i.e. it is fully implemented by the FunctionalCluster) to other FunctionalClusters.

The last subsection \"Required interfaces\" lists all interfaces required by the Func- tionalCluster from other FunctionalClusters and external components like the operating system.

## Runtime

![](./media/image11.png)![](./media/image12.png)![](./media/image13.png)![](./media/image14.png)![](./media/image15.png)

**Figure 9.2: Functional Clusters in category Runtime**

### Execution Management

```
```

1. **Defined interfaces**

The interfaces of [Execution Management](#_bookmark61) are categorized into interfaces for state reporting (see Section [9.2.1.1.1](#_bookmark62)), interfaces for the deterministic execution (see Section [9.2.1.1.2](#_bookmark65)), and interfaces for [State Management](#_bookmark76) (see Section [9.2.1.1.3](#_bookmark69)).

1. []{#_bookmark62 .anchor}**Interfaces for state reporting**

All processes started by [Execution Management](#_bookmark61) (i.e. all processes of the AU- TOSAR Adaptive Platform and all processes of Adaptive Applications) shall report their execution state back to [Execution Management](#_bookmark61) via the [ExecutionClient](#_bookmark64) interface (cf. Figure [9.3](#_bookmark63)).

![](./media/image16.png)
![](./media/image17.png)

**Figure 9.3:** []{#_bookmark63 .anchor}**Interfaces for state reporting**

```
```

2. []{#_bookmark65 .anchor}**Interfaces for deterministic execution**

The [DeterministicClient](#_bookmark67) API (cf. Figure [9.4](#_bookmark66)) provides operations to perform determin- istic execution of tasks.

![](./media/image18.png)
**Figure 9.4:** []{#_bookmark66 .anchor}**Interfaces for deterministic execution**

```
```

3. []{#_bookmark69 .anchor}**Interfaces for State Management**

![](./media/image20.png)The [StateClient](#_bookmark71) API (cf. Figure [9.5](#_bookmark70)) provides operations to control [FunctionGroup](#_bookmark74)s and their [FunctionGroupState](#_bookmark73)s.

![](./media/image21.png)

**Figure 9.5:** []{#_bookmark70 .anchor}**Interfaces for State Management**

```
```

2. **Provided interfaces**

![](./media/image20.png) ![](./media/image22.png) ![](./media/image23.png) ![](./media/image24.png) ![](./media/image25.png)

![](./media/image26.png)
![](./media/image20.png)**Figure 9.6: Users of the ExecutionClient interface**
![](./media/image27.png)

**Figure 9.7: Users of the State Management interfaces**

```
```

**Table 9.1: Interfaces provided by Execution Management to other Functional Clusters**

3. **Required interfaces**

![](./media/image28.png)
![](./media/image29.png)
![](./media/image21.png) ![](./media/image30.png) ![](./media/image31.png)

**Figure 9.8: Interfaces required by Execution Management**

**Table 9.2: Interfaces required by Execution Management**

### State Management

```
```

1. **Defined interfaces**

The interfaces of [State Management](#_bookmark76) are categorized into interfaces for triggering state changes (see Section [9.2.2.1.1](#_bookmark77)), interfaces for diagnostic reset (see Section [9.2.2.1.2](#_bookmark79)), interfaces for requesting a Power Mode (see Section [9.2.2.1.3](#_bookmark83)), and inter- faces for interaction with [Update and Configuration Management](#_bookmark200) (see Section [9.2.2.1.4](#_bookmark87)).

1. []{#_bookmark77 .anchor}**Interfaces for triggering state changes**

[State Management](#_bookmark76) provides several interface blueprints to get and set its internal state (cf. Figure [9.9](#_bookmark78)).

![](./media/image32.png)

![](./media/image33.png)

**Figure 9.9:** []{#_bookmark78 .anchor}**Interfaces for triggering state changes**

```
```

2. []{#_bookmark79 .anchor}**Interfaces for requesting a diagnostic reset**

The [DiagnosticReset](#_bookmark80) interface propagates a diagnostic reset request ([DiagnosticRe-](#_bookmark82) [set::message()](#_bookmark82)) to all affected Processes. These Processes then shall answer the diagnostic reset request by calling [DiagnosticReset::event()](#_bookmark81).

![](./media/image34.png) ![](./media/image35.png)

![](./media/image36.png)

**Figure 9.10: Interface for handling a diagnostic reset**

```
```

3. []{#_bookmark83 .anchor}**Interfaces for requesting a Power Mode**

The [PowerMode](#_bookmark84) interface propagates a diagnostic Power Mode request ([Power-](#_bookmark86) [Mode::message()](#_bookmark86)) to all running Processes. These Processes then shall answer the Power Mode request by calling [PowerMode::event()](#_bookmark85).

![](./media/image37.png)

![](./media/image38.png)

**Figure 9.11: Interface for handling a Power Mode request**

4. []{#_bookmark87 .anchor}**Interfaces for interaction with Update and Configuration Management**

![](./media/image39.png)

![](./media/image40.png)

**Figure 9.12: Interface for software update handling**

2. ![](./media/image41.png)**Provided interfaces**

![](./media/image42.png)![](./media/image43.png)

![](./media/image44.png)

**Figure 9.13: Users of the State Management interfaces**

```
```

**Table 9.3: Interfaces provided by State Management to other Functional Clusters**

3. **Required interfaces**

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

### Log and Trace

```

```

1. **Defined interfaces**

The entry point to the Log and Trace framework is the [CreateLogger()](#_bookmark93) operation that constructs a new [Logger](#_bookmark91) context. Afterwards, new messages can be constructed using the [LogStream](#_bookmark94) that is returned by the operations in [Logger](#_bookmark91), for example [LogInfo](#_bookmark92) [()](#_bookmark92).

![](./media/image51.png)

![](./media/image52.png)

**Figure 9.16: Interfaces of Log and Trace**

```
```

2. **Provided interfaces**

![](./media/image28.png) ![](./media/image53.png) ![](./media/image55.png) ![](./media/image56.png)
![](./media/image58.png)![](./media/image59.png)![](./media/image59.png)
![](./media/image20.png)
![](./media/image24.png)![](./media/image60.png)![](./media/image22.png)**Figure 9.17: Users of the Log and Trace interfaces**

```
```

**Table 9.5: Interfaces provided by Log and Trace to other Functional Clusters**

3. **Required interfaces**

![](./media/image61.png)

![](./media/image62.png)![](./media/image63.png)**Figure 9.18: Interfaces required by LogAndTrace**

```

```

**Table 9.6: Interfaces required by Log and Trace**

### Core

```

```

1. **Defined interfaces**

![](./media/image64.png)

**Figure 9.19: Interfaces of Core**

1. **Interfaces for initialization and de-initialization**

The AUTOSAR Adaptive Platform for Applications needs to be initialized by an appli- cation before it is used (using [Initialize()](#_bookmark98)) and de-initialized after it is no longer used (using [Deinitialize()](#_bookmark97)).

```

```

2. **Interfaces for process termination**

The AUTOSAR Adaptive Platform for Applications provides an explicit abnormal termi- nation facility using [Abort()](#_bookmark99).

```

```

2. **Provided interfaces**

[Core](#_bookmark96) currently provides no interfaces to other Functional Clusters.

3. **Required interfaces**

[Core](#_bookmark96) currently requires no interfaces.

### Operating System Interface

```

```

1. **Defined interfaces**

![](./media/image16.png)

![](./media/image17.png)

**Figure 9.20: Interfaces defined by Operating System Interface**

```

```

2. **Provided interfaces**

![](./media/image65.png)

![](./media/image66.png)

**Figure 9.21: Users of the OperatingSystemInterface interfaces**

```

```

**Table 9.7: Interfaces provided by Operating System Interface to other Functional Clus- ters**

3. **Required interfaces**

![](./media/image67.png)

![](./media/image68.png)

**Figure 9.22: Interfaces required by Operating System Interface**

```

```

**Table 9.8: Interfaces required by Operating System Interface**

## Communication

![](./media/image69.png)![](./media/image69.png)![](./media/image70.png)

**Figure 9.23: Functional Clusters in category Communication**

### Communication Management

***Responsibilities:***   [Communication Management](#_bookmark105) is responsible for all levels of service-oriented and raw communication between applications in a distributed real-time embedded environment. That is, intra-process communication, inter-process communication and inter-machine communication. The latter is also possible with AUTOSAR Classic Platforms and third-party platforms. Communication paths can be established at design-, start-up-, and run-time. [Communication Management](#_bookmark105) consists of a generic part that handles brokering and configuration as well as generated skeletons for service providers and respective proxies for service consumers.

1. **Defined interfaces**

The interfaces of [Communication Management](#_bookmark105) are categorized into interfaces for raw data streams (see Section [9.3.1.1.1](#_bookmark106)), interfaces for SecOC (see Section [9.3.1.1.2](#_bookmark108)), and interfaces freshness value management (see Section [9.3.1.1.3](#_bookmark109)). Please note that a implementation of [Communication Management](#_bookmark105) will generate additional inter- faces for each modeled Service, e.g. a Proxy and a Skeleton interface. However, these generated interfaces are not covered in this document.

1. ![](./media/image2.png)[]{#_bookmark106 .anchor}**Interfaces for raw data streams**

![](./media/image30.png)

**Figure 9.24: Interfaces for raw data streams**

2. []{#_bookmark108 .anchor}**Interfaces for SecOC**

![](./media/image72.png)

**Figure 9.25: Interfaces for SecOC**

3. []{#_bookmark109 .anchor}**Interfaces for freshness value management**

![](./media/image73.png)

**Figure 9.26: Interfaces for freshness value management**

2. **Provided interfaces**

[Communication Management](#_bookmark105) currently provides no interfaces to other Func- tional Clusters.

3. **Required interfaces**

![](./media/image74.png)

![](./media/image75.png)![](./media/image76.png)![](./media/image77.png)![](./media/image21.png) ![](./media/image78.png)

**Figure 9.27: Interfaces required by Communication Management**

**Table 9.9: Interfaces required by Communication Management**

### Network Management

1. **Defined interfaces**

![](./media/image20.png)

![](./media/image79.png)

**Figure 9.28: Interfaces for time base providers**

2. **Provided interfaces**

![](./media/image20.png)

![](./media/image80.png)

**Figure 9.29: Users of Network Management interfaces**

**Table 9.10: Interfaces provided by Network Management to other Functional Clusters**

3. **Required interfaces**

![](./media/image81.png)

![](./media/image82.png)

![](./media/image83.png)**Figure 9.30: Interfaces required by Network Management**

**Table 9.11: Interfaces required by Network Management**

### Time Synchronization

1. **Defined interfaces**

The interfaces of [Time Synchronization](#_bookmark115) are categorized into interfaces for provid- ing time information (see Section [9.3.3.1.1](#_bookmark116)) and interfaces for consuming time informa- tion (see Section [9.3.3.1.2](#_bookmark119)).

1. []{#_bookmark116 .anchor}**Interfaces for time base providers**

![](./media/image34.png)[Time Synchronization](#_bookmark115) defines the [SynchronizedTimeBaseProvider](#_bookmark117) and [Offset-](#_bookmark118) [TimeBaseProvider](#_bookmark118) interfaces to provide time information for a synchronized time base.

![](./media/image84.png)

**Figure 9.31: Interfaces for time base providers**

2. []{#_bookmark119 .anchor}**Interfaces for time base consumers**

[Time Synchronization](#_bookmark115) defines the [SynchronizedTimeBaseConsumer](#_bookmark120) interface to retrieve time information for a synchronized time base. [SynchronizedTimeBaseStatus](#_bookmark121) is used to determine the status of a synchronized time base.

![](./media/image85.png)![](./media/image86.png)

**Figure 9.32: Interfaces for time base consumers**

2. ![](./media/image87.png)![](./media/image88.png)**Provided interfaces**

![](./media/image89.png)

**Figure 9.33: Users of Time Synchronization interfaces**

**Table 9.12: Interfaces provided by Time Synchronization to other Functional Clusters**

3. **Required interfaces**

![](./media/image91.png)

![](./media/image92.png) ![](./media/image93.png) ![](./media/image94.png)

**Figure 9.34: Interfaces required by Time Synchronization**

**Table 9.13: Interfaces required by Time Synchronization**

## Storage

![](./media/image95.png)

**Figure 9.35: Functional Clusters in category Storage**

### Persistency

1. **Defined interfaces**

The interfaces of [Persistency](#_bookmark124) are categorized into interfaces for file access (see Section [9.4.1.1.1](#_bookmark125)), interfaces for a key-value-based data access (see Section [9.4.1.1.2](#_bookmark136)) and interfaces for general management of persistent data (see Section [9.4.1.1.3](#_bookmark145)).

1. []{#_bookmark125 .anchor}**Interfaces for file storage**

[Persistency](#_bookmark124) provides read and write access to plain files by means of a [FileStor-](#_bookmark130) [age](#_bookmark130) (cf. Figure [9.36](#_bookmark126)). A [FileStorage](#_bookmark130) has to be opened using [OpenFileStorage()](#_bookmark129). A [FileStorage](#_bookmark130) then provides access to several files using their name.

![](./media/image96.png)

![](./media/image97.png)«aapAPI,aapNativeInterface» Persistency

**Figure 9.36:** []{#_bookmark126 .anchor}**Interfaces for file storage**

2. []{#_bookmark136 .anchor}**Interfaces for key-value storage**

[Persistency](#_bookmark124) provides read and write access to data structured as key-value pairs by means of the [KeyValueStorage](#_bookmark141) API (cf. Figure [9.37](#_bookmark137)). A [KeyValueStorage](#_bookmark141) has to be created by calling [OpenKeyValueStorage()](#_bookmark140). A [KeyValueStorage](#_bookmark141) then provides access to data stored for individual keys using the [GetValue()](#_bookmark142) and [SetValue()](#_bookmark143) operations.

![](./media/image47.png)**Figure 9.37:** []{#_bookmark137 .anchor}**Interfaces for key-value-based data storage**

3. []{#_bookmark145 .anchor}**Interfaces for general persistency handling**

[Persistency](#_bookmark124) provides operations for handling and recovery of persistent data of a

Process (cf. Figure [9.38](#_bookmark146)).

![](./media/image2.png)

![](./media/image100.png)

**Figure 9.38:** []{#_bookmark146 .anchor}**Interfaces for general persistency handling**

2. ![](./media/image101.png)**Provided interfaces**

![](./media/image102.png)

![](./media/image103.png)

![](./media/image104.png)![](./media/image102.png)**Figure 9.39: Users of the FileStorage interfaces**

![](./media/image105.png)

**Figure 9.40: Users of the KeyValueStorage interfaces**

**Table 9.14: Interfaces provided by Persistency to other Functional Clusters**

3. **Required interfaces**

![](./media/image90.png)

![](./media/image107.png)

![](./media/image108.png)![](./media/image109.png)![](./media/image110.png)**Figure 9.41: Interfaces required by Persistency**

**Table 9.15: Interfaces required by Persistency**

## Security

![](./media/image111.png)![](./media/image112.png)![](./media/image113.png)![](./media/image114.png)

**Figure 9.42: Functional Clusters in category Security**

### Cryptography

1. **Defined interfaces**

   1. []{#_bookmark151 .anchor}**Common interfaces**

The main entry point for using the [Cryptography](#_bookmark150) API are the factory functions [Load-](#_bookmark152) [CryptoProvider()](#_bookmark152) for using cryptographic routines, [LoadKeyStorageProvider()](#_bookmark153) for ac- cess to the key store, and [LoadX509Provider()](#_bookmark154) for X.509 certificate handling.

![](./media/image99.png)

![](./media/image115.png)

**Figure 9.43: Common Interfaces of Cryptography**

2. **General cryptography interfaces**

The [CryptoProvider](#_bookmark157) interface provides access to various cryptographic routines. Each of those routines is managed by specializations of the [CryptoContext](#_bookmark158) interface.

![](./media/image99.png)

![](./media/image116.png)

**Figure 9.44: General Cryptography Interfaces**

3. **Cryptography context interfaces**

![](./media/image37.png)

![](./media/image117.png)

**Figure 9.45: BlockService and CryptoContext Interfaces**

**Figure 9.46: CryptoService and CryptoContext Interfaces**

![](./media/image51.png)

![](./media/image119.png)

**Figure 9.47: DigestService and CryptoContext Interfaces**

**Table 10.16: Use-Case Report Security Event**

# Runtime View

This chapter shows the original design approach of the AUTOSAR Adaptive Platform for implementing selected use cases. The presented use cases currently cover just a small part of the functionality of the AUTOSAR Adaptive Platform. More use cases will be added in future versions of this document. Please note that individual imple- mentations of the AUTOSAR Adaptive Platform may always choose a different design internally. Thus, interaction partners, the type of messages, and their order may differ.

1. []{#_bookmark258 .anchor}**Runtime**

   1. []{#_bookmark259 .anchor}**Execution Management**

      1. **Start Adaptive Platform**

         1. **Scenario: Start Platform with Supervision of Applications**

![](./media/image251.png)

**Figure 11.1:** []{#_bookmark261 .anchor}**Scenario: Start Platform with Supervision of Applications**

Figure [11.1](#_bookmark261) shows a scenario of for [Start Adaptive Platform](#_bookmark242) with an supervi- sion of Adaptive Applications. It therefore includes the startup of [Platform Health](#_bookmark186) [Management](#_bookmark186) that performs supervision and the startup of an Adaptive Application that is supervised as part of the Startup Machine Function Group State.

During the preceding startup of the Machine the [Operating System](#_bookmark28) performs ini- tialization steps in an implementation-specific way. These steps include starting any middleware related to the [Operating System](#_bookmark28), including device-drivers and services handling low-level middleware. The AUTOSAR Adaptive Platform demands that the

[Watchdog](#_bookmark30) is enabled prior to the startup of the AUTOSAR Adaptive Platform, for ex- ample, the [Watchdog](#_bookmark30) could already be enabled by the Bootloader or the [Operat-](#_bookmark28) [ing System](#_bookmark28).

[Execution Management](#_bookmark61) is started by the [Operating System](#_bookmark28) as the first process of the AUTOSAR Adaptive Platform. [Execution Management](#_bookmark61) then controls the startup of the AUTOSAR Adaptive Platform by activating the standardized Function Group State called Startup of the Machine Function Group State. This trig- gers the start of additional processes that are configured to run in the Startup state. It is mandatory that [State Management](#_bookmark76) is part of the Startup state. Other processes of the AUTOSAR Adaptive Platform, for example [Platform Health Management](#_bookmark186) and application processes may also be part of the Startup state (see Figure [11.1](#_bookmark261)).

[Platform Health Management](#_bookmark186) is responsible to service the [Watchdog](#_bookmark30). Thus, the time between enabling the [Watchdog](#_bookmark30) during the start of the Machine and the start of [Platform Health Management](#_bookmark186) needs to be less than the [Watchdog](#_bookmark30) timeout. The integrator needs to fulfill this constraint.

After the Startup state has been reached, [State Management](#_bookmark76) takes over control to determine the desired Function Group States.

2. **Shutdown Adaptive Platform**

   1. **Scenario: Shutdown Platform with Supervision of Applications**

![](./media/image254.png)

**Figure 11.2:** []{#_bookmark263 .anchor}**Scenario: Shutdown Platform with Supervision of Applications**

[]{#_bookmark264 .anchor}Figure [11.2](#_bookmark263) shows a scenario for [Shutdown Adaptive Platform](#_bookmark243) with a super- vision of Adaptive Applications. It therefore includes the shutdown of [Platform](#_bookmark186) [Health Management](#_bookmark186) that performs supervision.

The shutdown is triggered by [State Management](#_bookmark76) by requesting the standardized Machine Function Group State called Shutdown. In general, it is assumed that the only processes configured to run in the Shutdown state are [State Management](#_bookmark76) and an application that issues a shutdown request towards the [Operating System](#_bookmark28) (shutdownApp in Figure [11.2](#_bookmark263)). [Execution Management](#_bookmark61) will therefore perform an orderly shutdown of the other running application and platform processes (including [Platform Health Management](#_bookmark186)) before starting the application process that issues a shutdown request towards the [Operating System](#_bookmark28). The [Operating System](#_bookmark28) terminates the remaining processes (i.e. [State Management](#_bookmark76), [Execution Man-](#_bookmark61) [agement](#_bookmark61)) of the AUTOSAR Adaptive Platform and shuts down the Machine in an implementation-specific way.

3. **Change Function Group State**

   1. **Scenario: Change Function Group State**

![](./media/image255.png)

**Figure 11.3:** []{#_bookmark265 .anchor}**Scenario: Regular change of a Function Group State**

Figure [11.3](#_bookmark265) shows a scenario for changing a Function Group State. The sce- nario is triggered by [State Management](#_bookmark76). [Execution Management](#_bookmark61) will terminate all processes that are not part of the requested target Function Group State or that have a different StateDependentStartupConfig.

Just before terminating a process (with a SIGTERM signal), [Execution Manage-](#_bookmark61) [ment](#_bookmark61) notifies [Platform Health Management](#_bookmark186) that will stop all supervisions of the process. Consequently, [State Management](#_bookmark76) will not receive any information about failed supervisions during the shutdown of the process. The shutdown is monitored by [Execution Management](#_bookmark61) by means of StartupConfig.timeout configured in the Manifest.

Afterwards, [Execution Management](#_bookmark61) starts the processes of the target Function Group State in the order imposed by their StateDependentStartupConfig. When a processes reports its execution state as kRunning, [Execution Manage-](#_bookmark61) [ment](#_bookmark61) notifies [Platform Health Management](#_bookmark186) to start Alive Supervision for

[]{#_bookmark269 .anchor}that process. Other kinds of supervisions (Deadline Supervision, and Logical Supervision) are started when the first checkpoint is reported for them.

2. []{#_bookmark266 .anchor}**State Management**

   1. **Change System State**

      1. **Scenario: Accept Trigger Input**

![](./media/image259.png)![](./media/image261.png){width="8.172025371828522e-2in" height="0.227665135608049in"}[]{#_bookmark267 .anchor}«aapFunctionalClust\...

**Figure 11.4:** []{#_bookmark268 .anchor}**Scenario: Accept Trigger Input**

Figure [11.4](#_bookmark268) shows the default scenario for changing the system state. An [Adaptive](#_bookmark24) [Application](#_bookmark24) changes a field in the TriggerIn\_{StateGroup} service interface. Alternatively, the TriggerInOut\_{StateGroup} may be used (not shown). Based on the new input data, [State Management](#_bookmark76) determines a new desired system state, that is a set of desired Function Group States, and requests these Function Group States from [Execution Management](#_bookmark61) by calling [SetState()](#_bookmark72).

After the new system state has been reached, [State Management](#_bookmark76) updates the fields in the TriggerOut\_{StateGroup} (and TriggerInOut\_{StateGroup}, not shown) interfaces accordingly.

2. **Scenario: Reject Trigger Input**

![](./media/image262.png){width="8.23928258967629e-2in" height="0.22916666666666666in"}

![](./media/image263.png)app: Adaptive Application

**Figure 11.5:** []{#_bookmark270 .anchor}**Scenario: Reject Trigger Input**

Figure [11.5](#_bookmark270) shows an alternate scenario. An [Adaptive Application](#_bookmark24) changes a field in the TriggerIn\_{StateGroup} (alternatively TriggerI- nOut\_{StateGroup}) service interface. Despite the new input data, [State Man-](#_bookmark76) [agement](#_bookmark76) determines that the current system state is still the desired system state. Therefore, no further action is taken by [State Management](#_bookmark76).

2. **Recover from Supervision Failure**

   1. **Scenario: Successful Recovery**

![](./media/image265.png)

**Figure 11.6:** []{#_bookmark272 .anchor}**Scenario: Successful Recovery**

Figure [11.6](#_bookmark272) shows the scenario for performing successful recovery after a supervision failure has been detected by [Platform Health Management](#_bookmark186). [Platform Health](#_bookmark186) [Management](#_bookmark186) notifies [State Management](#_bookmark76) by invoking the call-back method [Recov-](#_bookmark194) [eryHandler()](#_bookmark194). [State Management](#_bookmark76) then determines a new desired state (which may be the same as the current state) and requests corresponding Function Group State transitions from [Execution Management](#_bookmark61).

2. []{#_bookmark273 .anchor}**Storage**

   1. []{#_bookmark274 .anchor}**Persistency**

      1. **Read Persistent Data from File**

         1. ![](./media/image267.png){width="8.225721784776903e-2in" height="0.22916666666666666in"}![](./media/image268.png){width="8.225503062117236e-2in" height="0.22916666666666666in"}**Scenario: Read Data from File Successfully**

![](./media/image269.png)

**Figure 11.7:** []{#_bookmark276 .anchor}**Scenario: Read Data from File Successfully**

Figure [11.7](#_bookmark276) shows the scenario for successfully reading data from a file successfully. The [Adaptive Application](#_bookmark24) needs to open a [FileStorage](#_bookmark130) by calling [OpenFileStor-](#_bookmark129) [age()](#_bookmark129). Afterwards, the [Adaptive Application](#_bookmark24) needs to open an individual file by calling [OpenFileReadOnly()](#_bookmark131) or [OpenFileReadWrite()](#_bookmark132) depending if the [Adaptive Ap-](#_bookmark24) [plication](#_bookmark24) needs to write data to the file as well. Then, the [Adaptive Applica-](#_bookmark24) [tion](#_bookmark24) can read data via the methods provided by [ReadAccessor](#_bookmark134) either as binary data or text data.

If enabled in the Manifest, [Persistency](#_bookmark124) will detect and try to correct data errors when reading from a file. If the file or [FileStorage](#_bookmark130) is configured to use encryption, the contents of the file will be transparently decrypted during read.

2. []{#_bookmark279 .anchor}**Read Persistent Data with Unique ID**

   1. **Scenario: Read Data with Unique ID Successfully**

![](./media/image273.png){width="8.225831146106737e-2in" height="0.22916666666666666in"}![](./media/image274.png){width="8.225612423447069e-2in" height="0.22916666666666666in"}

[]{#_bookmark277 .anchor}:Adaptive Application :Operating System

![](./media/image275.png)**Figure 11.8:** []{#_bookmark278 .anchor}**Scenario: Read Data with Unique ID Successfully**

Figure [11.8](#_bookmark278) shows the scenario for successfully reading data by providing a unique identifier (key). The [Adaptive Application](#_bookmark24) needs to open a [KeyValueStorage](#_bookmark141) by calling [OpenKeyValueStorage()](#_bookmark140). Then, the [Adaptive Application](#_bookmark24) can read data associated to a key by calling [GetValue()](#_bookmark142).

If enabled in the Manifest, [Persistency](#_bookmark124) will detect and try to correct data errors when reading data. If the individual key or [KeyValueStorage](#_bookmark141) is configured to use en- cryption, data will be transparently decrypted during read.

3. **Store Persistent Data to File**

   1. **Scenario: Store Data to File Successfully**

**Figure 11.9:** []{#_bookmark280 .anchor}**Scenario: Store Data to File Successfully**

Figure [11.9](#_bookmark280) shows a scenario for storing data to a file successfully. The [Adaptive](#_bookmark24) [Application](#_bookmark24) needs to open a [FileStorage](#_bookmark130) by calling [OpenFileStorage()](#_bookmark129). Afterwards, the [Adaptive Application](#_bookmark24) needs to open an individual file for writing by calling [OpenFileWriteOnly()](#_bookmark133) or [OpenFileReadWrite()](#_bookmark132) depending if the [Adaptive Applica-](#_bookmark24) [tion](#_bookmark24) needs to read data from the file as well. Then, the [Adaptive Application](#_bookmark24) can store data via the methods provided by [ReadWriteAccessor](#_bookmark135) either as binary data or text data.

If enabled in the Manifest, [Persistency](#_bookmark124) stores redundant data to detect and cor- rect errors when reading from a file later. If the file or [FileStorage](#_bookmark130) is configured to use encryption, data will be encrypted before it is written to the underlying storage.

4. **Store Persistent Data with Unique ID**

   1. **Scenario: Store Data with Unique ID Successfully**

![](./media/image283.png){width="8.225831146106737e-2in" height="0.22916666666666666in"}
![](./media/image282.png){width="8.08442694663167e-2in" height="0.22916666666666666in"}

**Figure 11.10:** []{#_bookmark282 .anchor}**Scenario: Store Persistent Data with a Unique ID Successfully**

Figure [11.10](#_bookmark282) shows a scenario for storing data associated with a unique identifier (key) successfully. The [Adaptive Application](#_bookmark24) needs to open a [KeyValueStorage](#_bookmark141) by calling [OpenKeyValueStorage()](#_bookmark140). Then, the [Adaptive Application](#_bookmark24) can store data associated to a key by calling [SetValue()](#_bookmark143). The data is updated in memory by calling [SetValue()](#_bookmark143) but not written to persistent storage. The [Adaptive Application](#_bookmark24) needs to call [SyncToStorage()](#_bookmark144) to write one or more such changes to persistent storage.

If enabled in the Manifest, [Persistency](#_bookmark124) stores redundant data to detect and cor- rect errors when reading from a [KeyValueStorage](#_bookmark141) later. If the key or [KeyValueStorage](#_bookmark141) is configured to use encryption, data will be encrypted before it is written to the under- lying storage.

5. **Get Storage Size**

   1. **Scenario: File Store**

![](./media/image286.png){width="8.226159230096237e-2in" height="0.22916666666666666in"}![](./media/image287.png){width="8.084645669291339e-2in" height="0.22916666666666666in"}

[]{#_bookmark283 .anchor}:Adaptive Application :Operating System

**Figure 11.11:** []{#_bookmark284 .anchor}**Scenario for determining the size of a FileStorage**

Figure [11.11](#_bookmark284) shows the scenario for monitoring the storage space of a [FileStorage](#_bookmark130). The [Adaptive Application](#_bookmark24) needs to call [GetCurrentFileStorageSize()](#_bookmark128) to determine the current size.

2. **Scenario: Key Value Store**

![](./media/image288.png){width="8.226159230096237e-2in" height="0.22916666666666666in"}![](./media/image287.png){width="8.084645669291339e-2in" height="0.22916666666666666in"}

[]{#_bookmark285 .anchor}:Adaptive Application :Operating System

GetCurrentKeyValueStorageSize()

**Figure 11.12:** []{#_bookmark286 .anchor}**Scenario for determining the size of a KeyValueStorage**

Figure [11.12](#_bookmark286) shows the scenario for monitoring the storage space of a [KeyValueStor-](#_bookmark141) [age](#_bookmark141). The [Adaptive Application](#_bookmark24) needs to call [GetCurrentKeyValueStorageSize()](#_bookmark139) to determine the current size.

3. []{#_bookmark287 .anchor}**Security**

   1. []{#_bookmark288 .anchor}**Firewall**

      1. **Switch Firewall State**

         1. **Scenario: Switch Firewall State Successfully**

![](./media/image289.png){width="8.226049868766404e-2in" height="0.22916666666666666in"}![](./media/image290.png){width="8.084536307961505e-2in" height="0.22916666666666666in"}

[]{#_bookmark289 .anchor}:Adaptive Application :Operating System

**Figure 11.13:** []{#_bookmark290 .anchor}**Scenario: Switch Firewall State Successfully**

Figure [11.13](#_bookmark290) shows the scenario for successfully switching the state of the [Firewall](#_bookmark182). The [Adaptive Application](#_bookmark24) triggers the state switch by calling [SwitchFirewallState](#_bookmark183) [()](#_bookmark183). The [Firewall](#_bookmark182) will then apply the FirewallRules configured for the request state

in an implementation-specific way (e.g., using tools provided with the TCP/IP stack of the [Operating System](#_bookmark28)).

2. **Report Security Event**

   1. **Scenario: Report Security Event Successfully**

**Figure 11.14:** []{#_bookmark292 .anchor}**Scenario: Report Security Event Successfully**

Figure [11.14](#_bookmark292) shows the scenario for successfully reporting a Security Event to [Adaptive Intrusion Detection System Manager](#_bookmark178). The [Operating System](#_bookmark28) (or another component that implements the actual firewall) reports that a packet has been blocked by a specific rule to the [Firewall](#_bookmark182). If a Security Event has been configured for that rule in the Manifest, the [Firewall](#_bookmark182) will create a correspond- ing Security Event and report it to [Adaptive Intrusion Detection System](#_bookmark178) [Manager](#_bookmark178) by calling [ReportEvent()](#_bookmark180). [Adaptive Intrusion Detection System](#_bookmark178) [Manager](#_bookmark178) will then handle the Security Event accordingly.

12. []{#_bookmark293 .anchor}**Deployment View**

This chapter provides an overview of exemplary deployment scenarios for an AU- TOSAR Adaptive Platform. Since the AUTOSAR Adaptive Platform is highly config- urable in its deployment, this section rather provides constraints on supported deploy- ments and a selection of relevant deployment scenarios.

## Vehicle Software Deployment

![](./media/image294.png)

**Figure 12.1: Exemplary vehicle software update scenario**

[Update and Configuration Management](#_bookmark200) allows to install and update software on the AUTOSAR Adaptive Platform and AUTOSAR Classic Platform. For the AU- TOSAR Adaptive Platform, [Update and Configuration Management](#_bookmark200) also al- lows to remove software. The software packages can be received either from a Di- agnostic Client or from a specific Backend System for over-the-air updates. In a vehicle, one [Adaptive Application](#_bookmark24) takes the role of a master that controls the update process in the vehicle and distributes individual software packages to the Ma- chines and ECUs within a vehicle.

## ![](./media/image300.png)Deployment of Software Packages on a Machine

![](./media/image301.png)

**Figure 12.2:** []{#_bookmark296 .anchor}**Exemplary deployment of Software Packages on a Machine**

[Update and Configuration Management](#_bookmark200) manages the software installed on a Machine using one or more Software Packages. The configuration of the contents of a Software Package is done in the Manifest by means of a Software Clus- ter. Software Cluster defines the enumeration attribute category with the val- ues APPLICATION, PLATFORM, and PLATFORM_CORE. Some rules apply on the use of the Software Cluster category and corresponding Software Packages which are outlined in the following.

For a Machine there shall exist exactly one Software Cluster with category PLATFORM_CORE. The corresponding Platform Core Package needs to include all required core components provided by the Platform Vendor and Machine Vendor, for example the operating system, device drivers, and the required Func- tional Clusters of the Adaptive Platform (see Figure [12.2](#_bookmark296)). It is assumed that at least the Functional Clusters [Execution Management](#_bookmark61), [State Management](#_bookmark76), and [Update and Configuration Management](#_bookmark200) are part of the Platform Core Package since they are required to install any additional Software Packages. How- ever, the concrete extend of a Platform Core Package is vendor and/or project specific. A Platform Core Package cannot be removed. The Software Clus- ter with category PLATFORM_CORE needs to be self-contained and therefore shall not have dependencies to other Software Clusters.

Optional Functional Clusters of the Adaptive Platform may be distributed as part of any number of additional Software Clusters with category PLATFORM within Platform Packages. Such Software Clusters may depend on the the

Software Cluster with category PLATFORM_CORE (see Figure [12.2](#_bookmark296)). Platform Packages may be installed and removed as needed.

Application components should be distributed as part of additional Software Clus- ters with category APPLICATION within Application Packages. Such Soft- ware Clusters may depend on the on Software Clusters with any kind of cat- egory (see Figure [12.2](#_bookmark296)). Application Packages may be installed and removed as needed.

The Platform Core Package and Platform Packages shall include all required Functional Cluster daemons and their respective configuration (e.g., startup con- figuration). This frees applications (distributed as Application Packages) from tak- ing care of the configuration of the platform.

# Cross-cutting Concepts

This section provides an overview of cross-cutting concepts and patterns used in the AUTOSAR Adaptive Platform.

## Overview of Platform Entities

The AUTOSAR Adaptive Platform defines design entities that several Functional Clusters depend on. Figure [13.1](#_bookmark299) provides an overview of these entities, their logical relationships, and the Functional Clusters that depend on them. For the sake of brevity, this overview uses simplifications and abstractions over the actual specifica- tions in the \[[9](#_bookmark331), manifest specification\].

![](./media/image205.png)

**Figure 13.1:** []{#_bookmark299 .anchor}**Overview of platform entities and their logical relationships**

A Software Package is a digitally signed package that can be installed/uninstalled via [Update and Configuration Management](#_bookmark200). A Software Package contains exactly one Software Cluster (see Section [13.4](#software-cluster) for details). A Software Clus- ter refers to a set of Executables (and other files). The corresponding executable file then holds the executable code for the Machine that the AUTOSAR Adaptive Plat- form runs on.

Additionally, a Software Cluster configuration collects a set of Processes (cf. Section [13.4](#software-cluster)) and related entities. A Process refers to an Executable and provides different Startup Configuration values, for example parameters, a scheduling

priority, and resource constraints. A Startup Configuration of a Process ap- plies to one or more Function Group States. Function Group States belong to a Function Group.

During runtime, [State Management](#_bookmark76) requests to enter a Function Group State from [Execution Management](#_bookmark61). [Execution Management](#_bookmark61) then terminates and starts the Processes accordingly using the underlying [Operating System](#_bookmark28).

For safety-critical systems, [Platform Health Management](#_bookmark186) performs supervision of Processes according to rules (logical sequence, deadlines) defined in PhmSuper- visions. A PhmSupervision refers to a number of Supervision Checkpoints. During runtime, a process reports whenever it has reached such a checkpoint in its control flow.

## Function Group

A Function Group is (logically) made up a set of modeled Processes that provide a certain functionality. For example, a Function Group could be an application, or a service. A special Function Group is the Machine State that groups the Process of the AUTOSAR Adaptive Platform itself. A Function Group contains a set of Function Group States.

## Function Group State

A Function Group State defines which Processes of a Function Group with what configuration parameters shall be running or not. The Machine State (that refers to the Processes of the AUTOSAR Adaptive Platform itself) defines at least the following Function Group States: Off, Startup, Shutdown, and Restart.

## Software Cluster

A Software Cluster configuration refers to a set of modeled Processes. Those Processes are (transitively) used by one or more Function Group(s). Hereby, a Function Group and its associated entities shall be part of only one Software Cluster. In other words, Function Groups that span several Software Clus- ters are invalid. A Software Cluster is packaged into one Software Package

\- the atomic installable/updateable unit managed by Update and Configuration Management. A Software Cluster may depend on other Software Clusters. Such dependencies are expressed by version constraints. A Software Cluster may also specify structural dependencies to Sub Software Clusters in order to build larger installable units. The top of such a structural dependency hierarchy is called a Root Software Cluster. Please note that a Software Cluster is only used to configure deployment aspects. A Software Cluster is not a runtime entity.

A Root Software Cluster may specify a diagnostic configuration, in particular, a diagnostic address. In contrast, a Sub Software Cluster may depend on a diag- nostic configuration of its Root Software Cluster. The diagnostic configuration applies to Processes that are (transitively) contained in a Root Software Clus- ter and its Sub Software Cluster(s). That means, at runtime, any diagnostic event produced by those Processes will be associated with the diagnostic address. Please refer to Section [13.11](#diagnostics-deployment) for further details on the diagnostic deployment.

An exemplary Software Cluster during application design is shown in Figure [13.2](#_bookmark303). The application Software Cluster(s) are modeled/configured in the same way as the platform Software Cluster by defining Function Groups with Function Group States and associating StartupConfigurations of Processes to them.

A Software Cluster serves as a grouping entity during application design. As a result, entities within a Software Cluster, in particular the Function Groups, do not need to have a unique (simple) name within the overall model because their path is still unique. This allows to design Software Clusters independently, for example, by external suppliers.

![](./media/image263.png)

**Figure 13.2:** []{#_bookmark303 .anchor}**Exemplary Software Cluster during application design**

From such a standardized model, an equivalent implementation-specific configura- tion for [Execution Management](#_bookmark61) is derived that is used during runtime (see Figure [13.3](#_bookmark304)). That configuration advises [Execution Management](#_bookmark61) to start and configure processes accordingly when a Function Group State is requested. Hereby, [Ex-](#_bookmark61) [ecution Management](#_bookmark61) (logically) merges configurations contributed by all installed Software Packages. Other Functional Clusters that depend on configuration provided in the Manifests merge the configurations contributed by all installed Soft- ware Packages in the same way. Please also note that there is no corresponding runtime entity for a Software Cluster (see Figure [13.3](#_bookmark304)).

![](./media/image318.png)

**Figure 13.3:** []{#_bookmark304 .anchor}**Impact of exemplary Software Cluster during runtime**

All Processes related to the Functional Clusters of the AUTOSAR Adaptive Platform should be referenced only in Software Clusters of category PLAT- FORM_CORE or PLATFORM. This allows for platform-independent development of Software Clusters of category APPLICATION_LAYER.

In case a Functional Cluster may need multiple logical instances (for example, Diagnostic Management has a logical instance per diagnostic address), an imple- mentation of the Functional Cluster should still use a single physical (daemon) process.

An AUTOSAR Adaptive Platform vendor may deviate from this design guide but should provide additional countermeasures to keep [Adaptive Application](#_bookmark24)s portable.

## Machine

The AUTOSAR Adaptive Platform regards hardware it runs on as a Machine. The ra- tionale behind that is to achieve a consistent platform view regardless of any virtualiza- tion technology which might be used. The Machine might be a real physical machine, a fully-virtualized machine, a para-virtualized OS, an OS-level-virtualized container or any other virtualized environment.

On hardware, there can be one or more Machine, and only a single instance of AU- TOSAR Adaptive Platform runs on a machine. It is generally assumed that this hard- ware includes a single chip, hosting a single or multiple Machines. However, it is also possible that multiple chips form a single Machine if the AUTOSAR Adaptive Platform implementation allows it.

## Manifest

A Manifest represents a piece of AUTOSAR model description that is created to support the configuration of an AUTOSAR Adaptive Platform product and which is up- loaded to the AUTOSAR Adaptive Platform product, potentially in combination with other artifacts (like binary files) that contain executable code to which the Manifest applies. Please note that a typical [Adaptive Application](#_bookmark24) will make use of several distinct but interrelated Manifests. Hereby, the individual Manifests contribute in- formation to the complete application model. For example, each Software Cluster may contribute a self-contained set of Manifests to configure its functionality.

The usage of a Manifest is limited to the AUTOSAR Adaptive Platform. This does not mean, however, that all ARXML produced in a development project that targets the AUTOSAR Adaptive Platform is automatically considered a Manifest. In fact, the AUTOSAR Adaptive Platform is usually not exclusively used in a vehicle project. A typical vehicle will most likely be also equipped with a number of ECUs developed on the AUTOSAR Classic Platform and the system design for the entire vehicle will, therefore, have to cover both, ECUs built on top of the AUTOSAR Classic Platform and Machines created on top of the AUTOSAR Adaptive Platform.

In principle, the term Manifest could be defined such that there is conceptually just one \"Manifest\" and every deployment aspect would be handled in this context. This does not seem appropriate because it became apparent that Manifest-related model- elements exist that are relevant in entirely different phases of a typical development project.

This aspect is taken as the main motivation that next to the application design it is necessary to subdivide the definition of the term Manifest in three different partitions:

**Application Design** This kind of description specifies all design-related aspects that apply to the creation of application software for the AUTOSAR Adaptive Platform. It is not necessarily required to be deployed to the adaptive platform machine, but the application design aids the definition of the deployment of application software in the

Execution Manifest and Service Instance Manifest. See Section [13.7](#application-design) for details.

**Execution Manifest** This kind of Manifest is used to specify the deployment-related information of applications running on the AUTOSAR Adaptive Platform. An Execu- tion Manifest is bundled with the actual executable code to support the integration of the executable code onto the machine. See Section [13.8](#execution-manifest) for details.

**Service Instance Manifest** This kind of Manifest is used to specify how service- oriented communication is configured in terms of the requirements of the underlying transport protocols. A Service Instance Manifest is bundled with the actual executable code that implements the respective usage of service-oriented communi- cation. See Section [13.9](#service-instance-manifest) for details.

**Machine Manifest** This kind of Manifest is supposed to describe deployment-related content that applies to the configuration of just the underlying machine (i.e. without any applications running on the machine) that runs an AUTOSAR Adaptive Platform. A Machine Manifest is bundled with the software taken to establish an instance of the AUTOSAR Adaptive Platform. See Section [13.10](#machine-manifest) for details.

The temporal division between the definition (and usage) of different kinds of Mani- fest leads to the conclusion that in most cases different physical files will be used to store the content of the three kinds of Manifest. In addition to the Application Design and the different kinds of Manifest, the AUTOSAR Methodology supports a Sys- tem Design with the possibility to describe Software Components of both AUTOSAR Platforms that will be used in a System in one single model. The Software Compo- nents of the different AUTOSAR platforms may communicate in a service-oriented way with each other. But it is also possible to describe a mapping of Signals to Services to create a bridge between the service-oriented communication and the signal-based communication.

## Application Design

The application design describes all design-related modeling that applies to the cre- ation of application software for the AUTOSAR AP. Application Design focuses on the following aspects:

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
- Description of client and server capabilities
- Grouping of applications in order to ease the deployment of software.

The artifacts defined in the application design are independent of a specific deployment of the application software and thus ease the reuse of application implementations for different deployment scenarios.

## Execution Manifest

The purpose of the execution manifest is to provide information that is needed for the actual deployment of an application onto the AUTOSAR AP. The general idea is to keep the application software code as independent as possible from the deployment scenario to increase the odds that the application software can be reused in different deployment scenarios. With the execution manifest the instantiation of applications is controlled, thus it is possible to

- instantiate the same application software several times on the same machine, or to
- deploy the application software to several machines and instantiate the applica- tion software per machine.

The Execution manifest focuses on the following aspects:

- Startup configuration to define how the application instance shall be started. The startup includes the definition of startup options and access roles. Each startup may be dependent on machines states and/or function group states.
- Resource Management, in particular resource group assignments.

  1. ## Service Instance Manifest

The implementation of service-oriented communication on the network requires con- figuration which is specific to the used communication technology (e.g. SOME/IP). Since the communication infrastructure shall behave the same on the provider and the requesters of a service, the implementation of the service shall be compatible on both sides.

The Service Instance Manifest focuses on the following aspects:

- Service interface deployment to define how a service shall be represented on the specific communication technology.
- Service instance deployment to define for specific provided and required service instances the required credentials for the communication technology.
- The configuration of E2E protection
- The configuration of Security protection
- The configuration of Log and Trace

  1. ## Machine Manifest

The machine manifest allows to configure the actual adaptive platform instance running on specific hardware (machine).

The Machine Manifest focuses on the following aspects:

- Configuration of the network connection and defining the basic credentials for the network technology (e.g. for Ethernet this involves setting of a static IP address or the definition of DHCP).
- Configuration of the service discovery technology (e.g. for SOME/IP this involves the definition of the IP port and IP multi-cast address to be used).
- Definition of the used machine states.
- Definition of the used function groups.
- Configuration of the adaptive platform functional cluster implementations (e.g. the operating system provides a list of OS users with specific rights).
- The configuration of the Crypto platform Module.
- The configuration of Platform Health Management.
- The configuration of Time Synchronization.
- Documentation of available hardware resources (e.g. how much RAM is avail- able; how many processor cores are available).

  1. ## Diagnostics deployment

A diagnostic configuration, in particular a diagnostic address, may only be assigned to a Root Software Cluster in the Manifest. Nevertheless, the mapped Diag- nosticContributionSet(s) may be distributed across several Software Clus- ters. This concept provides a lot of flexibility in assignment of a single diagnostic address to Software Clusters. For example, in one extreme this allows to use a single diagnostic address for the whole Machine (see Figure [13.4](#_bookmark312)), in another extreme

a single diagnostic address per Software Cluster could be used (see Figure [13.5](#_bookmark313)). Deployment scenarios in between those extremes are also possible.

![](./media/image323.png)![](./media/image263.png)

**Figure 13.4:** []{#_bookmark312 .anchor}**Example defining a single diagnostic address for the whole Machine**

![](./media/image323.png)

**Figure 13.5:** []{#_bookmark313 .anchor}**Example using one diagnostic address for each Software Cluster**

![](./media/image324.png)In the case of a distributed DiagnosticContributionSet, each Software Clus- ter shall include its related diagnostic configuration objects (for example, the Data Identifier configuration). The merge of such a split DiagnosticContribution- Set is done internally by the AUTOSAR Adaptive Platform (e.g. during installation or during start up the Diagnostic Management daemon).

## Error Handling

Proper handling of errors during runtime is an important aspect to build safe and se- cure systems. The AUTOSAR Adaptive Platform does provide means for raising and handling of such errors on different levels in the platform.

[Platform Health Management](#_bookmark186) detects errors (errors in the logical control flow, missed deadlines, and missed liveness reporting) at the level of Processes and performs recovery actions (for example, degradation) according to rules defined in the Manifest. [Execution Management](#_bookmark61) detects unexpected termination of Pro- cesses and reports to [State Management](#_bookmark76) for handling of such errors.

During execution of a Process of an [Adaptive Application](#_bookmark24), different abnormal conditions might be detected and need to be handled and/or reported. The follow- ing types of unsuccessful operations are distinguished within the AUTOSAR Adaptive Platform:

- An Error is the inability of an AUTOSAR Runtime for Adaptive Applications API function to fulfill its specified purpose. An Error it is often a consequence of invalid and/or unexpected input data. An Error is considered to be recoverable and therefore shall be handled by applications.
- A Violation is the consequence of failed pre- or post-conditions of internal state of the AUTOSAR Runtime for Adaptive Applications. A Violation is con- sidered to be non-recoverable.
- A Corruption is the consequence of the corruption of a system resource, e.g. stack or heap overflow, or a hardware memory flaw (for example, a detected bit flip). A Corruption is considered to be non-recoverable.
- A failed default allocation is the inability of the AUTOSAR Runtime for Adaptive Applications's default memory allocation mechanism to satisfy an allo- cation request (for example, there is not enough free memory available).

It is expected that a Violation or Corruption will not be experienced by a user of the AUTOSAR Adaptive Platform (i.e. an application developer), unless there is some- thing seriously wrong in the overall system. For example, faulty hardware may lead to a Corruption. A Violation may occur if basic assumptions about resource require- ments are violated, or the user runs the AUTOSAR Runtime for Adaptive Applications in a configuration that is not supported by its vendor.

## Trusted Platform

To guarantee the correct function of the system, it is crucial to ensure that the code ex- ecuted on the AUTOSAR Adaptive Platform is unaltered (integrity) and has legitimate origin (authenticity). Keeping this property allows the integrator to build a Trusted Platform. A key property of a system that implements a Trusted Platform is a Trust Anchor (also called Root of Trust). A Trust Anchor is often realized

as a public key that is stored in a secure environment, e.g. in non-modifiable persistent memory or in an Hardware Security Module. A system designer is responsible to ensure that the system starts beginning with a Trust Anchor and that the chain of trust is kept until the [Execution Management](#_bookmark61) is launched. Depending on the mech- anism that is chosen by the system designer to establish the chain of trust, the integrity and authenticity of the entire system (including all executables) may be checked during system start-up. Alternatively, the system designer might only ensure that the already executed software has been checked regarding integrity and authenticity and [Execu-](#_bookmark61) [tion Management](#_bookmark61) takes over responsibility on continuing the chain of trust when it takes over control of the system. In the latter case, the system integrator is responsible to ensure that the [Execution Management](#_bookmark61) is configured accordingly.

Passing trust requires that a trusted entity checks (using trusted functionality) that the entity down the chain is authentic. The Trust Anchor (the first entity in the chain) is authentic by definition. An example of such a chain of trust could look like this: The Trust Anchor authenticates the bootloader before the bootloader is being started. In each subsequent step in the boot process, the to-be-started executable shall be au- thenticated first, for example by the executable started previously or by some external entity like an Hardware Security Module. After the relevant parts of the [Operat-](#_bookmark28) [ing System](#_bookmark28) have been authentically started, it shall launch [Execution Manage-](#_bookmark61) [ment](#_bookmark61) as one of its first processes in the same manner passing trust to the AUTOSAR Adaptive Platform. Then, [Execution Management](#_bookmark61) takes over the responsibility of authenticating [Adaptive Application](#_bookmark24)s before launching them.

As stated above, if authenticity is not checked by the functionality of the Trust An- chor itself, which is authentic by definition, the functionality that shall be applied to verify authenticity of an executable has to be authenticated as well before it is applied. For instance, if the Crypto Functional Cluster shall be used to verify authentic- ity of executables, the Crypto Functional Cluster itself shall be authenticated by some trusted entity before it is used.

## Secure Communication

AUTOSAR supports different protocols that provide communication security over a net- work. Integrity of messages can be ensured by the end-to-end protection offered by the \[[10](#_bookmark332), AUTOSAR E2E library\]. End-to-end protection assumes that safety- and security- related data exchange shall be protected at runtime against the effects of faults within the communication link. Such faults include random hardware faults (e.g. corrupt regis- ters of a transceiver), interference (e.g. electromagnetic interference), and systematic faults in the communication stack. The configuration of end-to-end-protection is done via Service Instance Manifest on level of Service events, methods, and fields (notifier, get, and set methods). Confidentiality and authenticity of messages can be ensured by dedicated configurations for the individual transport protocols (e.g. TLS, SecOC) in the Service Instance Manifest on level of Service events, meth- ods, and fields (notifier, get, and set methods).

# Risks and Technical Debt

This chapter lists and rates risks associated with the overall architecture of the AU- TOSAR Adaptive Platform in Section [14.1](#risks). These risks usually might cause that some of the quality attributes of the AUTOSAR Adaptive Platform are not (fully) meat. Sec- tion [14.2](#technical-debt) lists technical debt of the AUTOSAR Adaptive Platform that may impact its maintainability.

1. ## Risks

   1. ### Risk Assessment

This document categorizes risks according to their severity. The severity is a function of the probability and the impact of a risk. The probabilities are categorized as follows:

- **very low** - probability is less than 1 thousandth
- **low** - probability is between 1 thousandth and 1 percent
- **medium** - probability is between 1 percent and 10 percent
- **high** - probability is between 10 percent and 50 percent
- **very high** - probability is more than 50 percent The impact of a risk is categorized as follows:
- **very low** - at most one quality scenario will take additional significant effort to be satisfied
- **low** - more than one quality scenario will take additional significant effort to be satisfied
- **medium** - at most one quality scenario is not satisfied with small gaps
- **high** - at most one quality scenario is not satisfied with big gaps
- **very high** - more than one quality scenario is not satisfied with big gaps The final severity of a risk is then calculated according to table [14.1](#_bookmark320).

[]{#_bookmark320 .anchor}**Probability**

**Table 14.1: Risk Severity Matrix**

### Risk List

No architectural risks were identified yet.

## Technical Debt

No technical debt has been identified yet.

# References

1. []{#_bookmark323 .anchor}ISO 42010:2011 -- Systems and software engineering -- Architecture description []{#_bookmark324 .anchor}[http://www.iso.org](http://www.iso.org/)
2. Explanation of Adaptive and Classic Platform Software Architectural Decisions []{#_bookmark325 .anchor}AUTOSAR_EXP_SWArchitecturalDecisions
3. Glossary []{#_bookmark326 .anchor}AUTOSAR_TR_Glossary
4. Main Requirements []{#_bookmark327 .anchor}AUTOSAR_RS_Main
5. General Requirements specific to Adaptive Platform []{#_bookmark328 .anchor}AUTOSAR_RS_General
6. ATAMSM: Method for Architecture Evaluation [https://resources.sei.cmu.edu/asset_files/TechnicalReport/2000_005_001](https://resources.sei.cmu.edu/asset_files/TechnicalReport/2000%5Chskip%200em%7B%7D_005%5Chskip%200em%7B%7D_001%5Chskip%200em%7B%7D_13706.pdf)

[]{#_bookmark329 .anchor}[\_13706.pdf](https://resources.sei.cmu.edu/asset_files/TechnicalReport/2000%5Chskip%200em%7B%7D_005%5Chskip%200em%7B%7D_001%5Chskip%200em%7B%7D_13706.pdf)

7. []{#_bookmark330 .anchor}Agile Software Development: Principles, Patterns, and Practices
8. Guide to the Software Engineering Body of Knowledge, Version 3.0 []{#_bookmark331 .anchor}[www.swebok.org](http://www.swebok.org/)
9. Specification of Manifest []{#_bookmark332 .anchor}AUTOSAR_TPS_ManifestSpecification
10. Specification of SW-C End-to-End Communication Protection Library AUTOSAR_SWS_E2ELibrary

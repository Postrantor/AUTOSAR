# Contents

1. [Preface](#preface) 9
2. [Acronyms and Abbreviations](#acronyms-and-abbreviations) 10
3. [Introduction](#introduction) 13

   1. [Approach](#approach) 13
   2. [API Design Visions and Guidelines](#api-design-visions-and-guidelines) 15
4. [Fundamentals](#fundamentals) 17

   1. [Proxy/Skeleton Architecture](#proxyskeleton-architecture) 17
   2. [Means of Communication](#means-of-communication) 18
   3. [ara::com Event and Trigger based communication](#aracom-event-and-trigger-based-communication) 18
   4. [ara::com Method based communication](#aracom-method-based-communication) 19
   5. [ara::com Field based communication](#aracom-field-based-communication) 20
   6. [Data Type Abstractions](#data-type-abstractions) 21
   7. [Error Handling](#error-handling) 22
   8. [Service Connection Approach](#service-connection-approach) 22

      1. [Instance Identifiers and Instance Specifiers](#instance-identifiers-and-instance-specifiers) 22
      2. [When to use InstanceIdentifier versus InstanceSpecifier](#when-to-use-instanceidentifier-versus-instancespecifier) 25

         1. [Transfer of an InstanceIdentifier](#transfer-of-an-instanceidentifier) 26
5. [Detailed API description](#detailed-api-description) 27

   1. [High Level API Structure](#high-level-api-structure) 27
   2. [API Elements](#api-elements) 27
   3. [Proxy Class](#proxy-class) 29

      1. [Proxy Class API's](#proxy-class-apis) 30
      2. [RadarService Proxy Class Example](#radarservice-proxy-class-example) 30
      3. [Constructor and Handle Concept](#constructor-and-handle-concept) 33
      4. [Finding Services](#finding-services) 34

         1. [Auto Update Proxy instance](#auto-update-proxy-instance) 35
      5. [Events](#events) 38

         1. [Event Subscription and Local Cache](#event-subscription-and-local-cache) 41
         2. [Monitoring Event Subscription](#monitoring-event-subscription) 42
         3. [Accessing Event Data --- aka Samples](#accessing-event-data-aka-samples) 45
         4. [Event Sample Management via SamplePtrs](#event-sample-management-via-sampleptrs) 46
         5. [Event-Driven vs Polling-Based access](#event-driven-vs-polling-based-access) 47
         6. [Buffering Strategies](#buffering-strategies) 49
      6. [Methods](#methods) 52

         1. [One-Way aka Fire-and-Forget Methods](#one-way-aka-fire-and-forget-methods) 54
         2. [Event-Driven vs Polling access to method results](#event-driven-vs-polling-access-to-method-results) 55
         3. [Canceling Method Result](#canceling-method-result) 59
      7. [Fields](#fields) 60
      8. [Triggers](#triggers) 63
   4. [Skeleton Class](#skeleton-class) 63

      1. [Skeleton Class API's](#skeleton-class-apis) 64
      2. [RadarService Skeleton Class Example](#radarservice-skeleton-class-example) 64
      3. [Instantiation (Constructors)](#instantiation-constructors) 67
      4. [Offering Service instance](#offering-service-instance) 68
      5. [Polling and event-driven processing modes](#polling-and-event-driven-processing-modes) 69

         1. [Polling Mode](#polling-mode) 70
         2. [Event-Driven Mode](#event-driven-mode) 71
      6. [Methods](#methods-1) 73

         1. [One-Way aka Fire-and-Forget Methods](#one-way-aka-fire-and-forget-methods-1) 76
         2. [Raising Application Errors](#raising-application-errors) 76
      7. [Events](#events-1) 78
      8. [Fields](#fields-1) 81

         1. [Registering Getters](#registering-getters) 82
         2. [Registering Setters](#registering-setters) 83
         3. [Ensuring existence of "SetHandler"](#ensuring-existence-of-sethandler) 84
         4. [Ensuring existence of valid Field values](#ensuring-existence-of-valid-field-values) 84
         5. [Access to current field value from Get/SetHandler](#access-to-current-field-value-from-getsethandler) 84
      9. [Triggers](#triggers-1) 84
   5. [Data Types on Service Interface level](#data-types-on-service-interface-level) 85

      1. [Optional data elements](#optional-data-elements) 85
   6. [Raw Data Streaming Interface](#raw-data-streaming-interface) 88

      1. [Introduction](#introduction-1) 88
      2. [Functional description](#functional-description) 89
      3. [Class and Model](#class-and-model) 89

         1. [Class and signatures](#class-and-signatures) 89
         2. [Destructor](#destructor) 90
         3. [Manifest Model](#manifest-model) 90
      4. [Methods of class RawDataStream](#methods-of-class-rawdatastream) 91

         1. [Timeout parameter](#timeout-parameter) 91
         2. [Methods](#methods-2) 91
      5. [Security](#security) 93
      6. [Safety](#safety) 93
      7. [Hints for implementers](#hints-for-implementers) 93
   7. [Communication Groups](#communication-groups) 94

      1. [Objective](#objective) 94
      2. [Realization](#realization) 94
      3. [Usage Scope](#usage-scope) 95
      4. [Special Topics](#special-topics) 96

         1. [Architecture](#5.7.4.1_Architecture) 96
         2. [Remote Connection](#remote-connection) 97
         3. [Service Versioning](#service-versioning) 97
6. [Tutorials](#tutorials) 98

   1. [Usage of Service Interfaces](#usage-of-service-interfaces) 98

      1. [Service Interface Deployment](#service-interface-deployment) 98
      2. [Service Instance Deployment](#service-instance-deployment) 99
      3. [Service Implementation](#service-implementation) 103
   2. [Usage of InstanceSpecifier](#usage-of-instancespecifier) 104

      1. [Modeling and configuration/mapping over Manifest from user](#modeling-and-configurationmapping-over-manifest-from-user-perspective) [perspective](#modeling-and-configurationmapping-over-manifest-from-user-perspective) 106
      2. [Instance IDs only for provided Services](#instance-ids-only-for-provided-services) 109
   3. [Usage in context of MultiBinding](#usage-in-context-of-multibinding) 109
   4. [Usage of RawDataStreaming](#usage-of-rawdatastreaming) 114

      1. [Sequence diagrams](#sequence-diagrams) 114
      2. [Usage](#usage) 116

         1. [Example of usage as server](#example-of-usage-as-server) 116
         2. [Example of usage as client](#example-of-usage-as-client) 117
   5. [Usage of CommunicationGroups](#usage-of-communicationgroups) 118

      1. [Setup](#setup) 118

         1. [Service Interface Description Generation](#service-interface-description-generation) 118
         2. [Proxy and Skeleton Generation](#proxy-and-skeleton-generation) 120
      2. [Example](#example) 121
7. [Appendix](#appendix) 125

   1. [Serialization](#serialization) 125

      1. [Zero-Copy implications](#zero-copy-implications) 126
   2. [Service Discovery Implementation Strategies](#service-discovery-implementation-strategies) 126

      1. [Central vs Distributed approach](#central-vs-distributed-approach) 127
   3. [Multi-Binding implications](#multi-binding-implications) 130

      1. [Simple Multi-Binding use case](#simple-multi-binding-use-case) 130
      2. [Local/Network Multi-Binding use case](#localnetwork-multi-binding-use-case) 133
      3. [Typical SOME/IP Multi-Binding use case](#typical-someip-multi-binding-use-case) 134
   4. [ara::com and AUTOSAR meta-model relationship](#aracom-and-autosar-meta-model-relationship) 136

      1. [Connection to AUTOSAR_TR_AdaptiveMethodology](#connection-to-autosar_tr_adaptivemethodology) 137
      2. [Service Interface](#service-interface) 137
      3. [Software Component](#software-component) 138
      4. [Adaptive Application/Executables and Processes](#adaptive-applicationexecutables-and-processes) 140
      5. [Usage of meta-model identifiers within ara::com based appli-](#usage-of-meta-model-identifiers-within-aracom-based-application-code) [cation code](#usage-of-meta-model-identifiers-within-aracom-based-application-code) 141
   5. [Abstract Protocol Network Binding Examples](#abstract-protocol-network-binding-examples) 143

**References**

1. []{#_bookmark0 .anchor}Specification of Communication Management []{#_bookmark1 .anchor}AUTOSAR_SWS_CommunicationManagement
2. Specification of Manifest []{#_bookmark2 .anchor}AUTOSAR_TPS_ManifestSpecification
3. Specification of Adaptive Platform Core []{#_bookmark3 .anchor}AUTOSAR_SWS_AdaptivePlatformCore
4. Specification of State Management []{#_bookmark4 .anchor}AUTOSAR_SWS_StateManagement
5. Software Component Template []{#_bookmark5 .anchor}AUTOSAR_TPS_SoftwareComponentTemplate
6. Specification of RTE Software []{#_bookmark6 .anchor}AUTOSAR_SWS_RTE
7. Middleware for Real-time and Embedded Systems []{#_bookmark7 .anchor}[http://doi.acm.org/10.1145/508448.508472](http://doi.acm.org/10.1145/508448.508472)
8. Patterns, Frameworks, and Middleware: Their Synergistic Relationships []{#_bookmark8 .anchor}[http://dl.acm.org/citation.cfm?id=776816.776917](http://dl.acm.org/citation.cfm?id=776816.776917)
9. SOME/IP Protocol Specification []{#_bookmark9 .anchor}AUTOSAR_PRS_SOMEIPProtocol
10. E2E Protocol Specification []{#_bookmark10 .anchor}AUTOSAR_PRS_E2EProtocol
11. Serialization and Unserialization []{#_bookmark11 .anchor}[https://isocpp.org/wiki/faq/serialization](https://isocpp.org/wiki/faq/serialization)
12. Copying and Comparing: Problems and Solutions []{#_bookmark12 .anchor}[http://dx.doi.org/10.1007/3-540-45102-1_11](http://dx.doi.org/10.1007/3-540-45102-1_11)
13. SOME/IP Service Discovery Protocol Specification AUTOSAR_PRS_SOMEIPServiceDiscoveryProtocol

# Preface

Typically, reading formal specifications isn't the easiest way to learn and understand a certain technology. This especially holds true for the Communication Management API ([ara::com](#_bookmark15)) in the AUTOSAR Adaptive Platform.

Therefore this document shall serve as an entry point not only for the developer of software components for the Adaptive Platform, who will use the [ara::com](#_bookmark15) API to interact with other application or service components, but also for Adaptive Platform product vendors, who are going to implement an optimized[IPC](#_bookmark70)binding for the [ara::-](#_bookmark15) [com](#_bookmark15) API on their platform.

We strongly encourage both groups of readers to read this document at hand before going into the formal details of the related SWS.

# Acronyms and Abbreviations

The glossary below includes acronyms and abbreviations relevant to the explanation of ara::com API.

+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| []{#_bookmark15 .anchor}**Abbreviation / Acronym:**  | **Description:**                                                                                                                                                 |           |    |          |
+======================================================+==================================================================================================================================================================+===========+====+==========+
| ara::com                                             | C++ namespace of functional cluster Communication Manage-                                                                                                        |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | []{#_bookmark16 .anchor}ment                                                                                                                                     |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| ara::com::raw                                        | C++ namespace of Raw Data Stream API according to \[SWS\_-                                                                                                       |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | []{#_bookmark17 .anchor}CM_10481\] of \[[1](#_bookmark0)\]                                                                                                       |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| ara::com::raw::RawDataStreamClient                   | RawDataStreamClient class according to \[SWS_CM_10481\] of                                                                                                       |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | []{#_bookmark18 .anchor}\[[1](#_bookmark0)\]                                                                                                                     |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| ara::com::raw::RawDataStreamServer                   | RawDataStreamServer class according to \[SWS_CM_11311\] of                                                                                                       |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | []{#_bookmark19 .anchor}\[[1](#_bookmark0)\]                                                                                                                     |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| []{#_bookmark20 .anchor}RawDataStreamMapping         | RawDataStreamMapping according to \[TPS_MANI_01287\] of \[[2](#_bookmark1)\]                                                                                     |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| EthernetRawDataStreamMapping                         | EthernetRawDataStreamMapping in accordance to \[TPS\_-                                                                                                           |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | []{#_bookmark21 .anchor}MANI_01355\] of \[[2](#_bookmark1)\]                                                                                                     |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| COMMUNICATION_GROUP_SERVER                           | COMMUNICATION_GROUP_SERVER                                                                                                                                       | according | to | \[TPS\_- |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | []{#_bookmark22 .anchor}MANI_03628\] of \[[2](#_bookmark1)\]                                                                                                     |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| COMMUNICATION_GROUP_CLIENT                           | COMMUNICATION_GROUP_CLIENT                                                                                                                                       | according | to | \[TPS\_- |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | []{#_bookmark23 .anchor}MANI_03628\] of \[[2](#_bookmark1)\]                                                                                                     |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| []{#_bookmark24 .anchor}ctor                         | C++ constructor                                                                                                                                                  |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| []{#_bookmark25 .anchor}dtor                         | C++ destructor                                                                                                                                                   |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| std::future                                          | C++ std::future provides a mechanism to access the result of                                                                                                     |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | []{#_bookmark26 .anchor}asynchronous operations                                                                                                                  |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| std::promise                                         | C++ std::promise provides a facility to store a value or an excep-                                                                                               |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | tion that is later acquired asynchronously via a std::future object []{#_bookmark27 .anchor}created by the std::promise object                                   |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| Error                                                | Recoverable Errors according to \[SWS_CORE_00020\] of \[[3](#_bookmark2)\].                                                                                      |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | Defined for [ara::com](#_bookmark15) functions using ara::Core::Error- []{#_bookmark28 .anchor}Codes, e.g. according to \[SWS_CM_10432\] of \[[1](#_bookmark0)\] |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| []{#_bookmark29 .anchor}ara::core::ErrorCode         | ara::core::ErrorCode according to \[SWS_CORE_00501\] of \[[3](#_bookmark2)\]                                                                                     |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| []{#_bookmark30 .anchor}Violation                    | Violation according to \[SWS_CORE_00021\] of \[[3](#_bookmark2)\]                                                                                                |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| []{#_bookmark31 .anchor}Corruption                   | Corruption according to \[SWS_CORE_00022\] of \[[3](#_bookmark2)\]                                                                                               |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| []{#_bookmark32 .anchor}ara::com::InstanceIdentifier | ara::com Instance Identifier according to \[SWS_CM_00302\] of \[[1](#_bookmark0)\]                                                                               |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| ara::com::InstanceIdentifierContainer                | ara::com Instance Identifier Container according to \[SWS_CM\_-                                                                                                  |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | []{#_bookmark33 .anchor}00319\] of \[[1](#_bookmark0)\]                                                                                                          |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| ara::com::ComErrorDomain                             | ara::com::ComErrorDomain according to \[SWS_CM_10432\] of                                                                                                        |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | []{#_bookmark34 .anchor}\[[1](#_bookmark0)\]                                                                                                                     |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| ara::com::e2e::E2EErrorDomain                        | ara::com::e2e::E2EErrorDomain according to \[SWS_CM_10474\]                                                                                                      |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | []{#_bookmark35 .anchor}of \[[1](#_bookmark0)\]                                                                                                                  |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| []{#_bookmark36 .anchor}ara::core::Result            | Returned result object according to \[SWS_CORE_00701\] of \[[3](#_bookmark2)\]                                                                                   |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| []{#_bookmark37 .anchor}ara::core::Future            | Returned future object according to \[SWS_CORE_00322\] of \[[3](#_bookmark2)\]                                                                                   |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| ara::core::Promise                                   | Returned promise object according to \[SWS_CORE_00341\] of                                                                                                       |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | []{#_bookmark38 .anchor}\[[3](#_bookmark2)\]                                                                                                                     |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| ara::core::Optional                                  | Provides access to optional record elements according to                                                                                                         |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | []{#_bookmark39 .anchor}\[SWS_CORE_01033\] of \[[3](#_bookmark2)\]                                                                                               |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| []{#_bookmark40 .anchor}ara::core::GetResult         | GetResult according to \[SWS_CORE_00336\] of \[[3](#_bookmark2)\]                                                                                                |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| []{#_bookmark41 .anchor}ara::com SubscriptionState   | SubscriptionState according to \[SWS_CM_00310\] of \[[1](#_bookmark0)\]                                                                                          |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| ara::com MethodCallProcessingMode                    | MethodCallProcessingMode according to \[SWS_CM_00301\] of                                                                                                        |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | []{#_bookmark42 .anchor}\[[1](#_bookmark0)\]                                                                                                                     |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+
| ara::core::InstanceSpecifier                         | ara::core Instance Specifier according to \[SWS_CORE_08001\]                                                                                                     |           |    |          |
|                                                      |                                                                                                                                                                  |           |    |          |
|                                                      | and following of \[[3](#_bookmark2)\]                                                                                                                            |           |    |          |
+------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------+----+----------+

+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark43 .anchor}**Abbreviation / Acronym:**      | **Description:**                                                                   |
+==========================================================+====================================================================================+
| ara::com::HandleType                                     | ara::com HandleType according to \[SWS_CM_00312\] and follow-                      |
|                                                          |                                                                                    |
|                                                          | []{#_bookmark44 .anchor}ing of \[[1](#_bookmark0)\]                                |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| ara::com::FindServiceHandle                              | ara::com FindServiceHandle according to \[SWS_CM_00303\]                           |
|                                                          |                                                                                    |
|                                                          | []{#_bookmark45 .anchor}and following of \[[1](#_bookmark0)\]                      |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| ara::com::FindServiceHandler                             | ara::com FindServiceHandler according to \[SWS_CM_00383\]                          |
|                                                          |                                                                                    |
|                                                          | and following of \[[1](#_bookmark0)\]                                              |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| ara::com::SamplePtr                                      | ara::com::SamplePtr according to \[SWS_CM_00702\] and follow-                      |
|                                                          |                                                                                    |
|                                                          | ing of \[[1](#_bookmark0)\]                                                        |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| ara::com::SampleAllocateePtr                             | ara::com::SampleAllocateePtr according to \[SWS_CM_00308\]                         |
|                                                          |                                                                                    |
|                                                          | []{#_bookmark46 .anchor}and \[SWS_CM_00306\] and following of \[[1](#_bookmark0)\] |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Proxy::Event::Subscribe                                  | EventSubscribe according to \[SWS_CM_00141\] of \[[1](#_bookmark0)\]               |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark47 .anchor}Proxy::Trigger::Subscribe        | TriggerEventSubscribe according to \[SWS_CM_00723\] of \[[1](#_bookmark0)\]        |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Proxy::Event::Unsubscribe                                | EventUnsubscribe according to \[SWS_CM_00151\] of \[[1](#_bookmark0)\]             |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark48 .anchor}Proxy::Trigger::Unsubscribe      | TriggerUnsubscribe according to \[SWS_CM_00151\] of \[[1](#_bookmark0)\]           |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark49 .anchor}Proxy::GetSubscriptionState      | GetSubscriptionState according to \[SWS_CM_00316\] of \[[1](#_bookmark0)\]         |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Proxy::SetSubscriptionStateHandler                       | GetSubscriptionState according to \[SWS_CM_00333\] of \[[1](#_bookmark0)\]         |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Proxy::SetSubscriptionStateHandler with Ex-              | SetSubscriptionState with ExecutorT according to \[SWS_CM\_-                       |
|                                                          |                                                                                    |
| []{#_bookmark50 .anchor}ecutorT                          | 11354\] of \[[1](#_bookmark0)\]                                                    |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Proxy::UnsetSubscriptionStateChangeHandler               | UnsetSubscriptionStateChangeHandler according to \[SWS\_-                          |
|                                                          |                                                                                    |
|                                                          | []{#_bookmark51 .anchor}CM_00334\] of \[[1](#_bookmark0)\]                         |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Proxy::GetNewSamples                                     | GetNewSamples according to \[SWS_CM_00701\] of \[[1](#_bookmark0)\]                |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Proxy::GetNewSamples with ExecutorT                      | GetNewSamples with ExecutorT according to \[SWS_CM_11358\]                         |
|                                                          |                                                                                    |
|                                                          | []{#_bookmark52 .anchor}of \[[1](#_bookmark0)\]                                    |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark53 .anchor}Proxy::GetFreeSampleCount        | GetFreeSampleCount according to \[SWS_CM_00705\] of \[[1](#_bookmark0)\]           |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Proxy::SetReceiveHandler                                 | SetReceiveHandler according to \[SWS_CM_00181\] of \[[1](#_bookmark0)\]            |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Proxy::SetReceiveHandler with ExecutorT                  | SetReceiveHandler with ExecutorT according to \[SWS_CM\_-                          |
|                                                          |                                                                                    |
|                                                          | 11356\] of \[[1](#_bookmark0)\]                                                    |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark54 .anchor}Proxy::Trigger SetReceiveHandler | TriggerSetReceiveHandler according to \[SWS_CM_00249\] of \[[1](#_bookmark0)\]     |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark55 .anchor}Proxy::UnsetReceiveHandler       | UnsetReceiveHandler according to \[SWS_CM_00183\] of \[[1](#_bookmark0)\]          |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark56 .anchor}Proxy::ResolveInstanceIDs        | ResolveInstanceIDs according to \[SWS_CM_00118\] of \[[1](#_bookmark0)\]           |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark57 .anchor}Proxy::Field Get                 | FieldGet according to \[SWS_CM_00112\] of \[[1](#_bookmark0)\]                     |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark58 .anchor}Proxy::Field Set                 | FieldSet according to \[SWS_CM_00113\] of \[[1](#_bookmark0)\]                     |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Proxy::FindService                                       | FindService according to \[SWS_CM_00622\] of \[[1](#_bookmark0)\]                  |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Proxy::FindService with Instance Specifier               | FindService with Instance Specifier according to \[SWS_CM\_-                       |
|                                                          |                                                                                    |
|                                                          | []{#_bookmark59 .anchor}00623\] of \[[1](#_bookmark0)\]                            |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Proxy::StartFindService                                  | StartFindService according to \[SWS_CM_00123\] of \[[1](#_bookmark0)\]             |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Proxy::StartFindService with ExecutorT                   | StartFindService with ExecutorT according to \[SWS_CM_11352\]                      |
|                                                          |                                                                                    |
|                                                          | []{#_bookmark60 .anchor}of \[[1](#_bookmark0)\]                                    |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark61 .anchor}Proxy::StopFindService           | StopFindService according to \[SWS_CM_00125\] of \[[1](#_bookmark0)\]              |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark62 .anchor}Skeleton::OfferService           | OfferService according to \[SWS_CM_00101\] of \[[1](#_bookmark0)\]                 |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Skeleton::StopOfferService                               | StopOfferService according to \[SWS_CM_00111\] of \[[1](#_bookmark0)\]             |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark63 .anchor}Skeleton::Trigger Send           | Trigger::Send according to \[SWS_CM_00721\] of \[[1](#_bookmark0)\]                |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark64 .anchor}Skeleton::Event::Send            | Event::Send according to \[SWS_CM_00162\] of \[[1](#_bookmark0)\]                  |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| []{#_bookmark65 .anchor}Skeleton::Allocate               | Allocate according to \[SWS_CM_90438\] of \[[1](#_bookmark0)\]                     |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Skeleton::Send with SampleAllocateePtr                   | Send with SampleAllocateePtr according to \[SWS_CM_90437\]                         |
|                                                          |                                                                                    |
|                                                          | []{#_bookmark66 .anchor}of \[[1](#_bookmark0)\]                                    |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Skeleton::ProcessNextMethodCall                          | ProcessNextMethodCall according to \[SWS_CM_00199\] of \[[1](#_bookmark0)\]        |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| > Skeleton::ProcessNextMethodCall with Ex-               | ProcessNextMethodCall with ExecutorT according to \[SWS\_-                         |
|                                                          |                                                                                    |
| []{#_bookmark67 .anchor}ecutorT                          | CM_11350\] of \[[1](#_bookmark0)\]                                                 |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Skeleton::RegisterGetHandler                             | RegisterGetHandler according to \[SWS_CM_00114\] of \[[1](#_bookmark0)\]           |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Skeleton::RegisterGetHandler with Execu-                 | RegisterGetHandler with ExecutorT according to \[SWS_CM\_-                         |
|                                                          |                                                                                    |
| []{#_bookmark68 .anchor}torT                             | 11360\] of \[[1](#_bookmark0)\]                                                    |
+----------------------------------------------------------+------------------------------------------------------------------------------------+
| Skeleton::RegisterSetHandler                             | RegisterSetHandler according to \[SWS_CM_00116\] of \[[1](#_bookmark0)\]           |
+----------------------------------------------------------+------------------------------------------------------------------------------------+

+------------------------------------------------+----------------------------------------------------------------------------+
| **Abbreviation / Acronym:**                    | **Description:**                                                           |
+================================================+============================================================================+
| Skeleton::RegisterSetHandler with Executort    | RegisterSetHandler with Executor according to \[SWS_CM\_-                  |
|                                                |                                                                            |
|                                                | []{#_bookmark69 .anchor}11362\] of \[[1](#_bookmark0)\]                    |
+------------------------------------------------+----------------------------------------------------------------------------+
| []{#_bookmark70 .anchor}Skeleton::Field Update | Update according to \[SWS_CM_00119\] of \[[1](#_bookmark0)\]               |
+------------------------------------------------+----------------------------------------------------------------------------+
| IPC                                            | Inter Process Communication                                                |
+------------------------------------------------+----------------------------------------------------------------------------+
| []{#_bookmark71 .anchor}RT                     | Realtime                                                                   |
+------------------------------------------------+----------------------------------------------------------------------------+
| SI                                             | Service Interface                                                          |
+------------------------------------------------+----------------------------------------------------------------------------+
| []{#_bookmark72 .anchor}WET                    | Worst Case Execution Time                                                  |
+------------------------------------------------+----------------------------------------------------------------------------+
| []{#_bookmark73 .anchor}PowerMode              | PowerMode according to \[SWS_SM_91020\] of \[[4](#_bookmark3)\]            |
+------------------------------------------------+----------------------------------------------------------------------------+
| []{#_bookmark74 .anchor}DiagnosticReset        | DiagnosticReset according to \[SWS_SM_91015\] of \[[4](#_bookmark3)\]      |
+------------------------------------------------+----------------------------------------------------------------------------+
| []{#_bookmark75 .anchor}FieldSenderComSpec     | FieldSenderComSpec according to \[TPS_MANI_03211\] of \[[2](#_bookmark1)\] |
+------------------------------------------------+----------------------------------------------------------------------------+
| []{#_bookmark76 .anchor}PPortPrototype         | PPortPrototype according to \[TPS_SWCT_01111\] of \[[5](#_bookmark4)\]     |
+------------------------------------------------+----------------------------------------------------------------------------+
| CppImplementationDataType                      | CppImplementationDataType according to \[TPS_MANI_01166\]                  |
|                                                |                                                                            |
|                                                | of \[[2](#_bookmark1)\]                                                    |
+------------------------------------------------+----------------------------------------------------------------------------+

+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **Terms:**            | **Description:**                                                                                                                                                                                                       |
+=======================+========================================================================================================================================================================================================================+
| Binding               | This typically describes the realization of some abstract concept                                                                                                                                                      |
|                       |                                                                                                                                                                                                                        |
|                       | with a specific implementation or technology.                                                                                                                                                                          |
|                       |                                                                                                                                                                                                                        |
|                       | In AUTOSAR, for instance, we have an abstract data type and interface model described in the methodology.                                                                                                              |
|                       |                                                                                                                                                                                                                        |
|                       | Mapping it to a concrete programming language is called *lan- guage binding*. In the AUTOSAR Adaptive Platform for instance we do have a C++ language binding.                                                         |
|                       |                                                                                                                                                                                                                        |
|                       | In this explanatory document we typically use the tech term *bind- ing* to refer to the implementation of the abstract (technology in- dependent) ara::com API to a concrete communication transport                   |
|                       |                                                                                                                                                                                                                        |
|                       | []{#_bookmark77 .anchor}technology like for instance sockets, pipes, shared memory, \...                                                                                                                               |
+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Callable              | In the context of C++ a Callable is defined as: A Callable type is a                                                                                                                                                   |
|                       |                                                                                                                                                                                                                        |
|                       | type for which the INVOKE operation (used by, e.g., std::function, std::bind, and std::thread::thread) is applicable. This operation may be performed explicitly using the library function std::invoke. (since C++17) |
+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

3. # Introduction

   1. ## Approach

Why did AUTOSAR invent yet another communication middleware API/technology, while there are dozens on the market --- the more so as one of the guidelines of Adap- tive Platform was to reuse existing and field proven technology?

Before coming up with a new middleware design, we did evaluate existing technologies, which --- at first glance --- seemed to be valid candidates. Among those were:

- ROS API
- DDS API
- CommonAPI (GENIVI)
- DADDY API (Bosch)

The final decision to come up with a new and AUTOSAR-specific Communication Man- agement API was made due to the fact, that not all of our key requirements were met by existing solutions:

- We need a Communication Management, which is NOT bound to a concrete network communication protocol. It has to support the SOME/IP protocol but there has to be flexibility to exchange that.
- The AUTOSAR service model, which defines services as a collection of provided methods, events and fields shall be supported naturally/straight forward.
- The API shall support an event-driven and a polling model to get access to com- municated data equally well. The latter one is typically needed by real-time ap- plications to avoid unnecessary context switches, while the former one is much more convenient for applications without real-time requirements.
- Possibility for seamless integration of end-to-end protection to fulfill ASIL require- ments.
- Support for static (preconfigured) and dynamic (runtime) selection of service in- stances to communicate with.

So in the final [ara::com](#_bookmark15) API specification, the reader will find concepts (which we will describe in-depth in the upcoming chapters), which might be familiar for him from technologies, we have evaluated or even from the existing Classic Platform:

- Proxy (or Stub)/Skeleton approach (CORBA, Ice, CommonAPI, Java RMI, \...)
- Protocol independent API (CommonAPI, Java RMI)
- Queued communication with configurable receiver-side caches (DDS, DADDY, Classic Platform)
- Zero-copy capable API with possibility to shift memory management to the mid- dleware (DADDY)
- Data reception filtering (DDS, DADDY)

Now that we have established the introduction of a new middleware API, we go into the details of the API in the following chapters.

The following statement is the basis for basically all AUTOSAR AP specifications, but should be explicitly pointed out here again:

[ara::com](#_bookmark15) only defines the API signatures and its behavior visible to the appli- cation developer. Providing an implementation of those APIs and the underlying middleware transport layer is the responsibility of the AUTOSAR AP vendor.

For a rough parallel with the AUTOSAR Classic Platform, [ara::com](#_bookmark15) can be seen as fulfilling functional requirements in the Adaptive Platform similar to those covered in the Classic Platform by the RTE APIs \[[6](#_bookmark5)\] such as Rte_Write, Rte_Read, Rte_Send, Rte_Receive, Rte_Call, Rte_Result.

Overview of Modeling elements and how they are related to each other: [SI](#_bookmark71), Deploy- ment, Actual generation dependant from provided Deployment Information (E.g. also [SI](#_bookmark71) Elements that will be generated later and connection to Service Instance Manifest)

AUTOSAR Adaptive Platform methodology explains the process aspects necessary to build an Adaptive AUTOSAR system and how they relate to each other \[TR_AMETH\_- 00100\]. It defines activities and work products delivered or consumed \[TR_AMETH\_- 00102\] and the Roles performed by OEMs and suppliers.

Major steps involved in the development of Adaptive Software are

- Architecture and Design
- Adaptive Software Development
- Integration and Deployment

Adaptive applications run on top of ARA layer and exchanges the information using [SI](#_bookmark71)s and Ports. Important contribution for [ara::com](#_bookmark15) API work performed during the Inte- gration and Deployment step of Adaptive Methodology. It supports the generation of [SI](#_bookmark71) Description ARXML file, which aggregates the [SI](#_bookmark71)s and ports. [SI](#_bookmark71)s for service-oriented communication defined by Events, Methods and Fields \[ [5.1](#_bookmark100)\]. This is done independent of Software components or Transport layer used for underlying communication.

Adaptive Platform supports two types of ports namely Provided and Required. [SI](#_bookmark71) along with Provided port details used for the generation of the Service Skeleton class and Required port details used for the generation of Proxy classes \[[Figure](#_bookmark117) [5.2](#_bookmark117)\]. Proxy and Skeleton classes use [ara::com](#_bookmark15) API to communicate with other Adaptive Platform clusters and Adaptive Applications.

Service instances are configured, notably the binding of the [SI](#_bookmark71)s to a chosen transport layer, whether a specific service instance is either Provided or Required and whether

there is a mapping to a dedicated Machine. The configurations of the service instance are manifested in the Service Instance Manifest.

Executable of an Adaptive Software are instantiated by means of the Execution Man- ifest. Instantiation here means to bind the executables to the context of specific pro- cesses of the operating system. Each process may start with a different start-up con- figuration depending on a machine mode. Further on, the Execution Manifest also defines Software process dependencies.

## API Design Visions and Guidelines

One goal of the API design was to have it as lean as possible. Meaning, that it should only provide the minimal set of functionality needed to support the service based com- munication paradigm consisting of the basic mechanisms: methods, events and fields.

Our definition of the notion \"as lean as possible\" in this context means: Essentially the API shall only deal with the functionality to handle method, field and event communica- tion on service consumer and service provider implementation side.

If we decided to provide a bit more than just that, then the reason generally was *\"If solving a certain communication-related problem ABOVE our API could not be done efficiently, we provide the solution as part of* [*ara::com*](#_bookmark15) *API layer.\"*

Consequently, [ara::com](#_bookmark15) does not provide any kind of component model or frame- work, which would take care of things like component life cycle, management of pro- gram flow or simply setting up [ara::com](#_bookmark15) API objects according to the formal compo- nent description of the respective application.

All this could be easily built on top of the basic [ara::com](#_bookmark15) API and needs not be standardized to support typical collaboration models.

During the design phase of the API we constantly challenged each part of our drafts, whether it would allow for efficient [IPC](#_bookmark70) implementations from AP vendors, since we were aware, that you could easily break it already on the API abstraction level, making it hard or almost impossible to implement a well performing binding.

One of the central design points was --- as already stated in the introduction --- to support polling and event-driven programming paradigms equally well.

So you will see in the later chapters, that the application developer, when using [ara:-](#_bookmark15)

[:com](#_bookmark15) is free to chose the approach, which fits best to his application design, inde- pendent whether he implements the service consumer or service provider side of a communication relation.

This allows for support of strictly real-time scheduled applications, where the appli- cation requires total control of what (amount) is done when and where unnecessary context switches are most critical.

On the other hand the more relaxed event based applications, which simply want to get notified whenever the communication layer has data available for them is also fully supported.

The decision within AUTOSAR to genuinely support C++11/C++14 for AP was a very good fit for the [ara::com](#_bookmark15) API design.

For enhanced usability, comfort and a breeze of elegance [ara::com](#_bookmark15) API exploits C++ features like smart pointers, template functions and classes, proven concepts for asyn- chronous operations and reasonable operator overloading.

4. # Fundamentals

   1. ## Proxy/Skeleton Architecture

If you've ever had contact with middleware technology from a programmer's perspec- tive, then the approach of a Proxy/Skeleton architecture might be well known to you.

Looking at the number of middleware technologies using the Proxy/Skeleton (some- times even called Stub/Skeleton) paradigm, it is reasonable to call it the \"classic ap- proach\".

So with [ara::com](#_bookmark15) we also decided to use this classical Proxy/Skeleton architectural pattern and also name it accordingly.

![](./media/image1.png)

**Figure 4.1: Proxy Skeleton Pattern**

The basic idea of this pattern is, that from a formal service definition two code artifacts are generated:

- Service Proxy: This code is - from the perspective of the service consumer, which wants to use a possibly remote service - the facade that represents this service on code level.

In an object-oriented language binding, this typically is an instance of a generated class, which provides methods for all functionalities the service provides. So the service consumer side application code interacts with this local facade, which then knows how to propagate these calls to the remote service implementation and back.

- Service Skeleton: This code is - from the perspective of the service implementa- tion, which provides functionalities according to the service definition - the code, which allows to connect the service implementation to the Communication Man-

agement transport layer, so that the service implementation can be contacted by distributed service consumers.

In an object-oriented language binding, this typically is an instance of a gener- ated class. Usually the service implementation from the application developer is connected with this generated class via a subclass relationship.

So the service side application code interacts with this middleware adapter either by implementing abstract methods of the generated class or by calling methods of that generated class.

Further details regarding the structure of [ara::com](#_bookmark15) Proxies and Skeletons are shown in section [section](#proxy-class) [5.3](#proxy-class) and [section](#skeleton-class) [5.4](#skeleton-class). Regarding this design pattern in general and its role in middleware implementations, see \[[7](#_bookmark6)\] and \[[8](#_bookmark7)\].

## Means of Communication

Now, that we've talked about the Proxy/Skeleton Architecture, let us continue to talk about how to communicate between proxies and skeletons.

ara::com defines four different mechanisms to communicate between a server and a client

- Methods
- Events
- Fields
- Triggers

Before any of these mechanisms can be used, a service must be instantiated and the server must offer itself to the system ([OfferService()](#_bookmark61)). Then a client needs to find and connect to the service instance using the Proxy ([FindService()](#_bookmark58) or [StartFindService()](#_bookmark59) ).

## ara::com Event and Trigger based communication

When a client application has connected to a server, it can subscribe ([Subscribe()](#_bookmark46)) to events in the service that is offered by the server, as described in figure [Figure](#_bookmark85) [4.2](#_bookmark85).

When data is available for an event, the server application sends the event data to communication management middleware, that notifies all subscribing client applica- tions. The subscribers can then fetch the event samples, using [GetNewSamples()](#_bookmark51), either directly or via a callback (defined by [SetReceiveHandler()](#_bookmark53)) that is triggered by the notification.

Triggers are used by the server to notify when a specific condition occurs. It does not transfer any data. It uses the same subscription and notification mechanisms as events.

![](./media/image4.png){width="5.104912510936133in" height="4.97875in"}

**Figure 4.2:** []{#_bookmark85 .anchor}**ara::com event based communication**

## ara::com Method based communication

With method based communication a client application calls a method that is executed on the remote server. This is shown in figure [Figure](#_bookmark87) [4.3](#_bookmark87). The method may, or may not return a value to the client. If a return value is provided, the [ara::core::Future](#_bookmark36) and [ara::core::Promise](#_bookmark37) pattern is used to give a possibility of a non-blocking behavior for the communication. See chapter [5.3.6](#methods) for details.

The server can be configured for different processing modes of method invocations. The options are

- **Event-driven, concurrent** (kEvent): Incoming service method calls are pro- cessed in an event based manner.
- **Event-driven, sequential** (kEventSingleThread): Same as kEvent on sin- gle thread basis.
- **Polling** (KPoll): Incoming service method calls need to be explicitly processed in polling manner by calling [ProcessNextMethodCall](#_bookmark66).

![](./media/image5.png){width="4.797502187226597in" height="6.2075in"}

**Figure 4.3:** []{#_bookmark87 .anchor}**ara::com method based communication**

## ara::com Field based communication

With field based communication a server can provide a value for some data that a client can access or update at any time. The functionality of a field can be viewed as a combination of event and methods:

- Like an event the client can subscribe to changes of the value. The client will be notified using the same notification mechanisms as for events (defined by [SetReceiveHandler()](#_bookmark53)).
- Using methods, the client can retrieve the value by calling a get-operation ([Get()](#_bookmark56)

), or update the value by calling a set-operation for the field in the proxy ([Set()](#_bookmark57)).

On the server side, the field is handled in the skeleton implementation by

- Defining a callback that is called when the value is updated by a client (defined by [RegisterSetHandler()](#_bookmark68)).
- Calling an update-method when a new value shall be published to the clients ( [Update()](#_bookmark69)).

  1. ## Data Type Abstractions

[ara::com](#_bookmark15) API introduces specific data types, which are used throughout its various interfaces. They can roughly be divided into the following classes:

- Pointer types: for pointers to data transmitted via middleware
- Collection types: for collections of data transmitted via middleware.
- Types for async operation result management: [ara::com](#_bookmark15) relies on AUTOSAR AP specific data types (see \[[3](#_bookmark2)\]), which are specific versions of C++ [std::fu-](#_bookmark25) [ture](#_bookmark25)/[std::promise](#_bookmark26)
- Function wrappers: for various application side callback or handler functions to be called by the middleware

[ara::com](#_bookmark15) defines signature and expected behavior of those types, but does not pro- vide an implementation. The idea of this approach is, that platform vendors could easily come up with their own optimized implementation of those types.

This is obvious for collection and pointer types as one of the major jobs of an [IPC](#_bookmark70) implementation has to deal with memory allocation for the data which is exchanged between middleware users.

Being able to provide their own implementations allows to optimize for their chosen memory model.

For most of the types [ara::com](#_bookmark15) provides a default mapping to existing C++ types in ara/com/types.h. The default mapping of the types provided by \[[3](#_bookmark2)\] can be found in,

e.g. ara/core/future.h or ara/core/promise.h. This default mapping decision could be reused by an AP product vendor.

The default mapping provided by [ara::com](#_bookmark15) even has a real benefit for a product vendor, who wants to implement its own variant: He can validate the functional behavior of his own implementation against the implementation of the default mapping.

## Error Handling

[ara::com](#_bookmark15) API follows the concepts of error handling described in chapter \"Error han- dling\" in \[[3](#_bookmark2)\]. Recoverable [Error](#_bookmark27)s will be returned via an ara::Core::ErrorCode embedded into a [ara::core::Result](#_bookmark35), which either holds a valid return value or the ara::Core::ErrorCode.

For each function in the [ara::com](#_bookmark15) API a set of predefined ara::Core::Error- Codes from the error domain [ara::com::ComErrorDomain](#_bookmark33), (or from [ara::com:-](#_bookmark34)

[:e2e::E2EErrorDomain](#_bookmark34) for E2E checks) are defined. These errors should be han- dled by the application that is using the API. Besides these a stack vendor may also define additional error codes, that might need to be handles as well.

Application Errors within [ara::com](#_bookmark15) API can only occur in the context of a call of a [SI](#_bookmark71) method and is therefore fully covered in subsection [subsection](#methods) [5.3.6](#methods) and sub- section [subsection](#methods-1) [5.4.6](#methods-1).

Exceptions in the [ara::com](#_bookmark15) API are only used in case of [Violation](#_bookmark29)s or [Corrup-](#_bookmark30) [tion](#_bookmark30)s. These are non-recoverable and should normally not be handled by the appli- cation developer.

2. ## Service Connection Approach

   1. ### Instance Identifiers and Instance Specifiers

Instance identifiers, which get used at proxy and as well at skeleton side, are such a central concept, that their explanation is drawn here --- before the detailed description of [ara::com](#_bookmark15) proxies and skeletons in upcoming chapters.

Instance identifiers are used within [ara::com](#_bookmark15), on client/proxy side, when a specific instance of a service shall be searched for or --- at the server/skeleton side --- when a specific instance of a service is created.

At [ara::com](#_bookmark15) API level the instance identifier is generally a technical binding specific identifier.

Therefore the concrete content/structure of which such an instance identifier consists, is totally technology specific: So f.i. SOME/IP is using 16 bit unsigned integer identifiers to distinguish different instances of the same service type, while DDS (DDS-RPC) uses *string\<256\>* as service_instance_name.

Independant of the binding technology the abstract facade of any concrete instance identifier shall apply to this signature at [ara::com](#_bookmark15) API level in namespace [ara::-](#_bookmark15) [com](#_bookmark15):

```

class InstanceIdentifier {

public:

static ara::core::Result\<InstanceIdentifier\>

Create(StringView serializedFormat) noexcept;

explicit InstanceIdentifier

(ara::core::StringView serializedFormat);

ara::core::StringView ToString() const;

bool operator==(const InstanceIdentifier& other) const;

bool operator\<(const InstanceIdentifier& other) const;

InstanceIdentifier& operator=(const InstanceIdentifier& other);

};

```

**Listing 4.1: InstanceIdentifier class**

As you can see the instance identifier interface [ara::com::InstanceIdentifier](#_bookmark31) provides a [ctor](#_bookmark23) taking a string, which means it can be constructed from a string rep- resentation. It also provides a ToString() method, which allows to get a stringified representation of the technology specific [ara::com::InstanceIdentifier](#_bookmark31).

This pair of [ctor](#_bookmark23) taking a string representation and the possibility to write out the string representation makes the [ara::com::InstanceIdentifier](#_bookmark31) \"serializable\". This allows it to be transferred, persisted, later re-used, \... (more on potential use cases later).

Introspection into this string (trying to interpret the content) makes no sense for the user of [ara::com](#_bookmark15). As mentioned: The content will be highly middleware product/binding specific!

Since it is a core feature, that the technical binding used by an [ara::com](#_bookmark15) based appli- cation is defined/specified by the integrator during deployment any expectations from an [ara::com](#_bookmark15) software developer regarding its content/structure are typically invalid. Logging it/tracing it out to a log channel might be helpful for debug analysis however.

Then, where does the software-developer get such a highly binding specific [ara::-](#_bookmark31) [com::InstanceIdentifier](#_bookmark31) to be used in [ara::com](#_bookmark15) API calls?

The answer is: By an [ara::com](#_bookmark15) provided functionality, which translates a logical local name used typically by the software developer in his realm into the technology/bind- ing specific [ara::com::InstanceIdentifier](#_bookmark31). This indirection masters both chal- lenges:

- developer using [ara::com](#_bookmark15) does not need to know anything about bindings and their specifics
- Integrators can adapt bindings in deployments

The local name from which the [ara::com::InstanceIdentifier](#_bookmark31) is constructed comes basically from the AUTOSAR meta-model, describing your software component model.

The requirement for this local name --- we will call it \"instance specifier\" from now on

--- is, that it is unambiguous within an executable. It has basically the form:

\<context 0\>/\<context 1\>/\.../\<context N\>/\<port name\>

The C++ representation of such an \"instance specifier\" is the class [ara::core::In-](#_bookmark42) [stanceSpecifier](#_bookmark42). Structurally it looks similar to the [ara::com::InstanceIden-](#_bookmark31) [tifier](#_bookmark31):

```

[]{#_bookmark93 .anchor}class InstanceSpecifier final

{

public:

// ctor to build specifier from AUTOSAR short name identifier

// with '/' as separator between package names

static Result\<InstanceSpecifier\> Create(StringView metaModelIdentifier);

explicit InstanceSpecifier(StringView metaModelIdentifier);

InstanceSpecifier(const InstanceSpecifier& other);

InstanceSpecifier(InstanceSpecifier&& other) noexcept;

InstanceSpecifier& operator=(const InstanceSpecifier& other);

InstanceSpecifier& operator=(InstanceSpecifier&& other);

\~InstanceSpecifier() noexcept;

StringView ToString() const noexcept;

bool operator==(const InstanceSpecifier& other) const noexcept;

bool operator==(StringView other) const noexcept;

bool operator!=(const InstanceSpecifier& other) const noexcept;

bool operator!=(StringView other) const noexcept;

bool operator\<(const InstanceSpecifier& other) const noexcept;

};

```

**Listing 4.2: InstanceSpecifier class**

If the unambiguousness is ensured, the integrator/deployer can assign a dedicated technical binding with its specific instance IDs to those \"instance specifier\" via a \"man- ifest file\", which is specifically used for a distinct instantiation/execution of the exe- cutable.

This explicitly allows, to start the same executable N times, each time with a different manifest, which maps the same [ara::core::InstanceSpecifier](#_bookmark42) differently.

Details about the [ara::com](#_bookmark15) relation to the meta-model and the nature of nested con- texts can be read more detailed in [section](#aracom-and-autosar-meta-model-relationship) [7.4](#aracom-and-autosar-meta-model-relationship).

The API [ara::com](#_bookmark15) provides the following function, to do the translation from the [ara::core::InstanceSpecifier](#_bookmark42) (local name in the software developers realm) to the technical [ara::com::InstanceIdentifier](#_bookmark31):

```

[]{#_bookmark94 .anchor}namespace ara {

namespace com {

namespace runtime {

ara::core::Result\<ara::com::InstanceIdentifierContainer\> ResolveInstanceIDs (ara::core::InstanceSpecifier modelName);

}

}

}

```

**Listing 4.3: InstanceSpecifier Resolution**

Why this API does return an [ara::com::InstanceIdentifierContainer](#_bookmark32), which represents a collection of [ara::com::InstanceIdentifier](#_bookmark31) is in need of explana- tion: AUTOSAR supports, that the integrator may configure multiple technical bindings behind one abstract identifier visible to the software component developer.

This feature is called multi-binding and referred to at different parts in this document (you find a more detailed explanation in [section](#multi-binding-implications) [7.3](#multi-binding-implications)).

Using multi-binding on the skeleton/server side is a common use case, since it simply allows different clients to use their preferred binding, when contacting the server.

Contrary using multi-binding on the proxy/client side is a rather exotic one. E.g. it could be used to support some fail-over approaches (if binding A does not work, fall back on binding B).

So the possible returns for a call of [ResolveInstanceIDs()](#_bookmark55) are:

- empty list: The integrator failed to provide a mapping for the abstract identifier. This most likely is a configuration error.
- list with one element: The common case. Mapping to one concrete instance id of one concrete technical binding.
- list with more than one element: Mapping to multiple technical instances with possibly multiple technical bindings.

Technically the middleware implementation of [ResolveInstanceIDs()](#_bookmark55)does a lookup of the [ara::core::InstanceSpecifier](#_bookmark42) from the service instance manifest bundled within the process.

Therefore the [ara::core::InstanceSpecifier](#_bookmark42) must be unambiguous within the bundled service instance manifest.

### When to use InstanceIdentifier versus InstanceSpecifier

According to the previous explanations, the impression may have arisen that a soft- ware developer always has to resolve [ara::core::InstanceSpecifier](#_bookmark42) to [ara:-](#_bookmark31)

[:com::InstanceIdentifier](#_bookmark31) manually (by a call to [ResolveInstanceIDs()](#_bookmark55)) first, be-

fore using [ara::com](#_bookmark15) APIs, which need instance identifier information.

This would be indeed a bit awkward as we already mentioned, that the \"typical\" ap- proach for a software developer, which implements an Adaptive AUTOSAR SWC, is to use abstract \"instance specifiers\" from the realm of the software component model.

As you will see in the upcoming chapters, which detail the APIs on the proxy and skele- ton side, [ara::com](#_bookmark15) provides typically function overloads, which either take [ara::-](#_bookmark31) [com::InstanceIdentifier](#_bookmark31) OR [ara::core::InstanceSpecifier](#_bookmark42), freeing the developer in the most common use cases, where he simply uses [ara::core::In-](#_bookmark42) [stanceSpecifier](#_bookmark42) from explicitly calling [ResolveInstanceIDs()](#_bookmark55).

This means, that the direct use of [ara::com::InstanceIdentifier](#_bookmark31) and manual resolution of [ara::core::InstanceSpecifier](#_bookmark42) is intended more for power users with rather specific/exotic use cases. Some examples will be given in the chapters, where the corresponding [ara::com](#_bookmark15) API overrides at proxy/skeleton side are dis- cussed.

The fundamental difference between the two variants is this: An [ara::com::In-](#_bookmark31) [stanceIdentifier](#_bookmark31) can be exchanged more easily between Adaptive Application- s/processes!

As they already exactly contain all the technology specific information and do not need any further resolution via content of a service instance manifest such a se- rialized [ara::com::InstanceIdentifier](#_bookmark31) can be reconstructed within a different process and be used as long as his process has access to the same binding technol- ogy the [ara::com::InstanceIdentifier](#_bookmark31) is based upon.

### Transfer of an InstanceIdentifier

As discussed before the [ara::com::InstanceIdentifier](#_bookmark31) should only be used for \"power users\" since its format is stack vendor dependent and it contains technology binding information. The transfer or the storage of an [ara::com::InstanceIden-](#_bookmark31) [tifier](#_bookmark31) may be very risky, therefore. As the transfer binding may not exist anymore after the transfer or re-storing or the [ara::com::InstanceIdentifier](#_bookmark31) of stack vendor A may be interpreted by an application using the stack of vendor B.

5. # Detailed API description

   1. ## High Level API Structure

[ara::com](#_bookmark15) provides an API that supports the AUTOSAR service model. The services have methods, events, fields and triggers.

- **Methods**: Execute a function in the Service Application which can also return a value (e.g. Calibrate method).
- **Events**: The Service Application sends an event (may also include a value) when specific conditions occur (e.g. Brake event). A Client Application can subscribe to events.
- **Fields**: Have a value at any time, like a status value. Can be read using Get or modified using Set (e.g. UpdateRate field). A Client Application can be notified when a Field value changes.
- **Triggers**: The Service Application sends a trigger when specific conditions occur. A Client Application can subscribe to triggers.

As described in [section](#proxyskeleton-architecture) [4.1](#proxyskeleton-architecture), Client and Service Application communicate with each other and therefore the API supports methods, events and fields in both sides. This means that the API defines interfaces for sending and receiving events, provides and calls service methods, register handlers for field setters and getters amongst others.

The [ara::com](#_bookmark15) API also defines ctors/dtors to create and destroy instances for Proxy and Skeleton classes.

Finally, the [ara::com](#_bookmark15) API also provides methods to offer / find services and subscribe

/ unsubscribe to events.

## API Elements

The following subchapters will guide through the different API elements, which [ara::-](#_bookmark15) [com](#_bookmark15) defines. Since we will give code examples for various artifacts and provide sample code how to use those APIs from a developer perspective, it is a good idea to have some uniformity in our examples.

So we will use a virtual service (interface) called \"RadarService\". The following is a kind of a semi-formal description, which should give you an impression of what this \"RadarService\" provides/does and might be easier to read than a formal AUTOSAR ARXML service description:

```
[]{#_bookmark100 .anchor}RadarService {

// types used within service

type RadarObjects {

active : bool

objects : array {

size: variable

}

}

+---------+--------------------+--------------------------------------+
| 10      |                    |                                      |
+=========+====================+======================================+
| 11      | type               | Position {                           |
+---------+--------------------+--------------------------------------+
| 12      | x:                 | uint32                               |
+---------+--------------------+--------------------------------------+
| 13      | y:                 | uint32                               |
+---------+--------------------+--------------------------------------+
| 14      | z:                 | uint32                               |
+---------+--------------------+--------------------------------------+
| 15      | > }                |                                      |
+---------+--------------------+--------------------------------------+
| 16      |                    |                                      |
+---------+--------------------+--------------------------------------+

// events provided by service

event BrakeEvent {

type:RadarObjects

}

// fields provided by service

field UpdateRate {

type:uint32

get: true

set: true

}

error CalibrationFailed {

errorCode : 1

errorContext {

failureText : string

}

}

error InvalidConfigString {

errorCode : 2

errorContext {

invalidConfig : string

currentValidConfig : string

}

}

// methods provided by service

method Calibrate {

param configuration {

type: string

direction: in

}

param result {

type: bool

direction: out

}

raises {

CalibrationFailed

InvalidConfigString

}

}

method Adjust {

param target_position {

+-----+-----+----------------------------------------------------------+
| 63  |     | > direction: in                                          |
+=====+=====+==========================================================+
| 64  |     | }                                                        |
+-----+-----+----------------------------------------------------------+
| 65  |     | param success {                                          |
+-----+-----+----------------------------------------------------------+
| 66  |     | > type: bool                                             |
+-----+-----+----------------------------------------------------------+
| 67  |     | > direction: out                                         |
+-----+-----+----------------------------------------------------------+
| 68  |     | }                                                        |
+-----+-----+----------------------------------------------------------+
| 69  |     | param effective_position {                               |
+-----+-----+----------------------------------------------------------+
| 70  |     | > type: Position                                         |
+-----+-----+----------------------------------------------------------+
| 71  |     | > direction: out                                         |
+-----+-----+----------------------------------------------------------+
| 72  |     | }                                                        |
+-----+-----+----------------------------------------------------------+
| 73  | > } |                                                          |
+-----+-----+----------------------------------------------------------+
| 74  |     |                                                          |
+-----+-----+----------------------------------------------------------+

oneway method LogCurrentState {}

}
```

**Listing 5.1: RadarService Definition**

So the example service RadarService provides an event "BrakeEvent", which con- sists of a structure containing a flag and a variable length array of uint8 (as extra pay- load).

Then it provides a field "UpdateRate", which is of uint32 type and supports get and set calls and finally it provides three methods.

Method "Adjust", to position the radar, which contains a target position as in-parameter and two out-parameters. One to signal the success of the positioning and one to report the final (maybe deviating) effective position.

The method "Calibrate" to calibrate the radar, getting an configuration string as in- parameter and returning a success indicator as out-parameter. This method may raise two different application errors, in case the calibration failed: "CalibrationFailed" and "InvalidConfigString".

The method "LogCurrentState" is a one way method, which means, that no feedback is returned to the caller, if the method is executed at all and with which outcome. It instructs the service RadarService to output its current state into its local log files.

## Proxy Class

The Proxy class is generated from the [SI](#_bookmark71) description of the AUTOSAR meta model.

[ara::com](#_bookmark15) does standardize the interface of the generated Proxy class.The toolchain of an AP product vendor will generate a Proxy implementation class exactly implement- ing this interface.

Note: Since the interfaces the Proxy class has to provide are defined by [ara::com](#_bookmark15), a generic (product independent) generator could generate an abstract class or a mock class against which the application developer could implement his service consumer application. This perfectly suits the platform vendor independent development of Adap- tive AUTOSAR SWCs.

[ara::com](#_bookmark15) expects proxy related artifacts inside a namespace \"proxy\". This name- space is typically included in a namespace hierarchy deduced from the service defini- tion and its context.

### Proxy Class API's

- [FindService()](#_bookmark58)
- [StartFindService()](#_bookmark59)
- [StopFindService()](#_bookmark60)
- [Subscribe()](#_bookmark46)
- [Unsubscribe()](#_bookmark47)
- [GetSubscriptionState()](#_bookmark48)
- [SetSubscriptionStateChangeHandler()](#_bookmark49)
- [UnsetSubscriptionStateChangeHandler()](#_bookmark50)
- [GetNewSamples()](#_bookmark51)
- GetResult()
- [GetFreeSampleCount()](#_bookmark52)
- [SetReceiveHandler()](#_bookmark53)
- [UnsetReceiveHandler()](#_bookmark54)
- [ResolveInstanceIDs()](#_bookmark55)
- [Field::Get()](#_bookmark56)
- [Field::Set()](#_bookmark57)

  1. ### RadarService Proxy Class Example

```
[]{#_bookmark104 .anchor}class RadarServiceProxy {

public:

/\*\*

\* \\brief Implementation is platform vendor specific

\*

\* A HandleType must contain the information that is needed to create

\* a proxy.

\*

\* This information shall be hidden.

\* Since the platform vendor is responsible for creation of handles, the

\* ctor signature is not given as it is not of interest to the user.

class HandleType {

/\*\*

\* \\brief Two ServiceHandles are considered equal if they represent

\* the same service instance.

\*

\* \\param other

\*

\* \\return bool

\*/

inline bool operator==(const HandleType &other) const;

const ara::com::InstanceIdentifier &GetInstanceId() const;

};

/\*\*

\* StartFindService does not need an explicit version parameter as this

\* is internally available in ProxyClass.

\* That means only compatible services are returned.

\*

\* \\param handler this handler gets called any time the service

\* availability of the services matching the given

\* instance criteria changes. If you use this variant of

\* FindService, the Communication Management has to

\* continuously monitor the availability of the services

\* and call the handler on any change.

\*

\* \\param instanceId which instance of the service type defined

\* by T shall be searched/found.

\*

\* \\return a handle for this search/find request, which shall

\* be used to stop the availability monitoring and related

\* firing of the given handler. (\\see StopFindService())

\*/

static ara::core::Result\<ara::com::FindServiceHandle\> StartFindService(

ara::com::FindServiceHandler\<RadarServiceProxy::HandleType\> handler,

ara::com::InstanceIdentifier instanceId);

/\*\*

\* This is an overload of the StartFindService method using an

\* instance specifier, which gets resolved via service instance

\* manifest.

\* \\param instanceSpec instance specifier

\*/

static ara::core::Result\<ara::com::FindServiceHandle\> StartFindService

 (

ara::com::FindServiceHandler\<RadarServiceProxy::HandleType\> handler,

ara::core::InstanceSpecifier instanceSpec);

/\*\*

\* Method to stop finding service request (see above)

\*/

static void StopFindService(ara::com::FindServiceHandle handle);

/\*\*

\* Opposed to StartFindService(handler, instance) this version

\* is a \"one-shot\" find request, which is:

\* and a result list of matching service instances is

\* available. (list may be empty, if no matching service

\* instances currently exist)

\* - does reflect the availability at the time of the method

\* call. No further (background) checks of availability are

\* done.

\*

\* \\param instanceId which instance of the service type defined

\* by T shall be searched/found.

\*

\*/

static ara::core::Result\<ara::com::ServiceHandleContainer

\<RadarServiceProxy::HandleType\>\>

FindService(ara::com::InstanceIdentifier instanceId);

/\*\*

\* This is an overload of the FindService method using an

\* instance specifier, which gets resolved via service instance

\* manifest.

\*/

static ara::core::Result\<ara::com::ServiceHandleContainer

\<RadarServiceProxy::HandleType\>\>

FindService(ara::core::InstanceSpecifier instanceSpec);

/\*\*

\* \\brief The proxy can only be created using a specific

\* handle which identifies a service.

\*

\* This handle can be a known value which is defined at

\* deployment or it can be obtained using the

\* ProxyClass::FindService method.

\*

\* \\param handle The identification of the service the

\* proxy should represent.

\*/

explicit RadarServiceProxy(HandleType &handle);

/\*\*

\* proxy instances are not copy constructible.

\*/

RadarServiceProxy(RadarServiceProxy &other) = delete;

/\*\*

\* proxy instances are not copy assignable

\*/

RadarServiceProxy& operator=(const RadarServiceProxy &other) = delete;

/\*\*

\* \\brief Public member for the BrakeEvent

\*/

events::BrakeEvent BrakeEvent;

/\*\*

\* \\brief Public Field for UpdateRate

\*/

/\*\*

\* \\brief Public member for the Calibrate method

\*/

methods::Calibrate Calibrate;

/\*\*

\* \\brief Public member for the Adjust method

\*/

methods::Adjust Adjust;

/\*\*

\* \\brief Public member for the LogCurrentState fire-and-forget method

\*/

methods::LogCurrentState LogCurrentState;

};
```

**Listing 5.2: RadarService Proxy**

### Constructor and Handle Concept

As you can see in the Listing [5.2](#_bookmark104) [ara::com](#_bookmark15) prescribes the Proxy class to provide a constructor. This means, that the developer is responsible for creating a proxy instance to communicate with a possibly remote service.

The [ctor](#_bookmark23) takes a parameter of type RadarServiceProxy::HandleType --- an inner class of the generated proxy class. Probably the immediate question then is: *\"What is this handle and how to create it/where to get it from?\"*

What it is, should be straightforward: After the call to the [ctor](#_bookmark23) you have a proxy instance, which allows you to communicate with the service, therefore the handle has to contain the needed addressing information, so that the Communication Management binding implementation is able to contact the service.

What exactly this address information contains is totally dependent on the binding im- plementation/technical transport layer!

That already partly answers the question *\"how to create/where to get it\"*: Really creat- ing is not possible for an application developer as he is --- according to AUTOSAR core concepts --- implementing his application AP product and therefore Communication Management independent.

The solution is, that [ara::com](#_bookmark15) provides the application developer with an API to find service instances, which returns such handles.

This part of the API is described in detail here: [subsection](#finding-services) [5.3.4](#finding-services). The co-benefit from this approach --- that proxy instances can only be created from handles, which are the result of a \"FindService\" API --- is, that you are only able to create proxies, which are really backed by an existing service instance.

So the question which probably might come up here: Why this indirection, that an application developer first has to call some [ara::com](#_bookmark15) provided functionality, to get a

handle, which I then have to use in a [ctor](#_bookmark23) call? [ara::com](#_bookmark15) could have given back directly a proxy instance instead of a handle from \"FindService\" functionality.

The reason for that could be better understood, after reading how [ara::com](#_bookmark15) handles the access to events ([subsection](#events) [5.3.5](#events)). But what is sufficient to say at this point is, that a proxy instance contains certain state.

And because of this there are use cases, where the application developer wants to use different instances of a proxy, all \"connected\" to the same service instance.

So if you just accept, that there are such cases, the decision for this indirection via han- dles becomes clear: [ara::com](#_bookmark15) cannot know, whether an application developer wants always the same proxy instance (explicitly sharing state) or always a new instance each time he triggers some \"FindService\" functionality, which returns a proxy for exactly the same service instance.

So by providing this indirection/decoupling the decision is in the hands of the [ara::-](#_bookmark15) [com](#_bookmark15) user.

Instances of the Proxy class on the other hand are neither copy constructible nor copy assignable! This is an explicit design decision, which complements the idea of forcing the construction via [HandleType](#_bookmark43).

The instances of a proxy class might be very resource intensive because of owning event/field caches, registered handlers, complex state,\... and so on. Thus, when al- lowing copy construction/copy assignment, there is a risk that such copies are done unintended.

So --- in a nutshell --- forcing the user to go the route via [HandleType](#_bookmark43) for Proxy creation shall sensitize him, that this decision shall be well thought out.

### Finding Services

The Proxy class provides class (static) methods to find service instances, which are compatible with the Proxy class.

Since the availability of service instances is dynamic by nature, as they have a life cycle, [ara::com](#_bookmark15) provides two different ways to do a "FindService" for convenience in general:

- [StartFindService](#_bookmark59) is a class method, which starts a continuous "FindService" ac- tivity in the background, which notifies the caller via a given callback anytime the availability of instances of the service changes.
- [FindService](#_bookmark58) is a one-off call, which returns available instances at the point in time of the call.

Both of those methods come in two different overrides, depending on the instance identifier approach taken (see [subsection](#instance-identifiers-and-instance-specifiers) [4.8.1](#instance-identifiers-and-instance-specifiers)):

- one taking an [ara::com::InstanceIdentifier](#_bookmark31)
- one taking an [ara::core::InstanceSpecifier](#_bookmark42)

Note that only technical bindings will be used for finding/searching, which are config- ured for the corresponding [SI](#_bookmark71) within the service instance manifest in the form of a [SI](#_bookmark71) deployment.

The synchronous one-off variant [FindService](#_bookmark58) returns a container of handles (see [sub-](#constructor-and-handle-concept) [section](#constructor-and-handle-concept) [5.3.3](#constructor-and-handle-concept)) for the matching service instances, which might also be empty, if no matching service instance is currently available.

Opposed to that, the [StartFindService](#_bookmark59) returns a [FindServiceHandle](#_bookmark44), which can be used to stop the ongoing background activity of monitoring service instance availability via call to [StopFindService](#_bookmark60).

The first (and specific for this variant) parameter to [StartFindService](#_bookmark59) is a user provided handler function with the following signature:

using FindServiceHandler = std::function\<void(ServiceHandleContainer\<T

\>, FindServiceHandle)\>;

Any time the binding detects, that the availability of service instances matching the given instance criteria in the call to [StartFindService](#_bookmark59) has changed, it will call the user provided handler with an updated list of handles of the now available service instances.

Right after being called, [StartFindService](#_bookmark59) behaves similar to [FindService](#_bookmark58) in the sense, that it will fire the user provided handler function with the currently available service instances, which might be also an empty handle list.

After that initial callback, it will call the provided handler again in case of changes of this initial service availability.

*Note*, that it is explicitly allowed, that the [ara::com](#_bookmark15) user/developer does call [StopFind-](#_bookmark60) [Service](#_bookmark60) within the user provided handler.

For this purpose, the handler explicitly gets the [FindServiceHandle](#_bookmark44) argument. The handler needs not to be re-entrant. This means, that the binding implementer has to care for serializing calls to the user provided handler function.

*Note*, that ServiceHandleContainer can be implemented as an allocating or non- allocating container, when used either as a return value of [FindService](#_bookmark58) or as a pa- rameter to [FindServiceHandler](#_bookmark45), as long as it fulfils general and sequence container requirements of the C++ programming language.

### Auto Update Proxy instance

Regardless whether you use the one-off [FindService](#_bookmark58) or the [StartFindService](#_bookmark59) variant, in both cases you get a handle identifying the --- possibly remote --- service instance, from which you then create your proxy instance.

But what happens if the service instance goes down and later comes up again e.g. due to some life cycle state changes? Can the existing proxy instance at the service consumer side still be re-used later, when the service instance gets available again?

The good news is: The [ara::com](#_bookmark15) design team decided to require this re-use possibil- ity from the binding implementation as it eases the typical task of implementing service consumers.

In the service based communication universe it is expected, that during the life time of the entire system (e.g. vehicle) service provider and consumer instances are starting up and going down again due to their own life cycle concepts frequently.

To deal with that, there is the service discovery infrastructure, where the life cycle of service providers and consumers is monitored in terms of service offerings and service (re)subscriptions!

If a service consumer application has instantiated a service proxy instance from a handle returned from some of the Find Service variants, the sequence which might possibly occur is shown in the figure below.

![](./media/image6.png)T0

![](./media/image7.png)T1

![](./media/image7.png)T2

![](./media/image8.png)T3

![](./media/image9.png)

**Figure 5.1:** []{#_bookmark108 .anchor}**Auto Updating of Proxy Instance**

Explanation of figure [5.1](#_bookmark108):

- **T0**: The service consumer may successfully call a service method of that proxy (and [GetSubscriptionState()](#_bookmark48) on subscribed events will return kSubscribed ac- cording to [5.3.5.2](#monitoring-event-subscription)).
- **T1**: The service instance goes down, correctly notified via service discovery.
- **T2**: A call of a service method on that proxy will lead to a kServiceNotAvail- able error, since the targeted service instance of the call does not exist any- more. Correspondingly [GetSubscriptionState()](#_bookmark48) on any subscribed event will re- turn kSubscriptionPending (see also [5.3.5.2](#monitoring-event-subscription)) at this point even if the event has been successfully subscribed (kSubscribed) before.
- **T3**: The service instance comes up again, notified via service discovery infras- tructure. The Communication Management at the proxy side will be notified and will silently update the proxy object instance with a possibly changed transport layer addressing information. This is illustrated in the figure with transport layer part of the proxy, which changed the color from blue to rose.
- **T4**: Consequently service method calls on that proxy instance will succeed again and [GetSubscriptionState()](#_bookmark48) on events which the service consumer had sub- scribed before, will return kSubscribed again.

This convenience behavior of a proxy instance saves the implementer of a service consumer from either:

- polling via [GetSubscriptionState()](#_bookmark48) on events, which indicates that service in- stance has gone down
- re-triggering a one-off [FindService](#_bookmark58) to get a new handle.

or:

- registering a [FindServiceHandler](#_bookmark45), which gets called in case service instance gets down or up with a new handle.

and then to recreate a proxy instance from the new handle (and redo needed event subscribe calls).

*Note*, in case you have registered a [FindServiceHandler](#_bookmark45), then the binding implemen- tation must assure, that it does the "auto updating" of existing proxy instances **before** it calls the registered [FindServiceHandler](#_bookmark45)!

The reason for this is: It shall be supported, that the application developer can interact successfully with an existing proxy instance within the [FindServiceHandler](#_bookmark45), when the handle of the proxy instance is given in the call, signaling, that the service instance is up again.

This expectation is shown in the following code snippet:

```
/\*\*

\* Reference to radar instance, we work with,

\* initialized during startup

\*/

RadarServiceProxy \*myRadarProxy;

void radarServiceAvailabilityHandler(ServiceHandleContainer\< RadarServiceProxy::HandleType\> curHandles, FindServiceHandle handle) {

for (RadarServiceProxy::HandleType handle : curHandles) {

if (handle.GetInstanceId() == myRadarProxy-\>GetHandle(). GetInstanceId()) {

/\*\*

\* This call on the proxy instance shall NOT lead to an exception,

\* regarding service instance not reachable, since proxy instance

\* should be already auto updated at this point in time.

\*/

+------+---+-----+----------------------------------------------------------------------+
| 15   |   |     | > ara::core::Future\<Calibrate::Output\> out =                       |
+======+===+=====+======================================================================+
| 16   |   |     | > myRadarProxy-\>Calibrate(\"test\");                                |
+------+---+-----+----------------------------------------------------------------------+
| 17   |   |     | > // \... do something with out.                                     |
|      |   |     |                                                                      |
| 18   |   |     |                                                                      |
+------+---+-----+----------------------------------------------------------------------+
| 19   |   | > } |                                                                      |
+------+---+-----+----------------------------------------------------------------------+
| 20   | } |     |                                                                      |
|      |   |     |                                                                      |
| 21 } |   |     |                                                                      |
+------+---+-----+----------------------------------------------------------------------+
|      |   |     | **Listing 5.3: Access to proxy instance within FindService handler** |
+------+---+-----+----------------------------------------------------------------------+

```

### Events

For each event the remote service provides, the proxy class contains a member of a event specific wrapper class. In our example the member has the name BrakeEvent and is of type events::BrakeEvent.

As you see in [5.2](#_bookmark104) all the event classes needed for the proxy class are generated inside a specific namespace events, which is contained inside the proxy namespace.

The member in the proxy is used to access events/event data, which are sent by the service instance our proxy is connected to. Let's have a look at the generated event class for our example:

```

/\*\*

\* \\brief Shortcut for the events data type.

\*/

using SampleType = RadarObjects;

/\*\*

\* \\brief The application expects the CM to subscribe the event.

\*

\* The Communication Management shall try to subscribe and resubscribe

\* until \\see Unsubscribe() is called explicitly.

\* The error handling shall be kept within the Communication Management

 .

\*

\* The function returns immediately. If the user wants to get notified,

\* when subscription has succeeded, he needs to register a handler

\* via \\see SetSubscriptionStateChangeHandler(). This handler gets

\* then called after subscription was successful.

\*

\* \\param maxSampleCount maximum number of samples, which can be held.

\*/

ara::core::Result\<void\> Subscribe(size_t maxSampleCount);

/\*\*

\* \\brief Query current subscription state.

\*

\* \\return Current state of the subscription.

\*/

ara::com::SubscriptionState GetSubscriptionState() const;

/\*\*

\* \\brief Unsubscribe from the service.

\*/

void Unsubscribe();

/\*\*

\* \\brief Get the number of currently free/available sample slots.

\*

\* \\return number from 0 - N (N = count given in call to Subscribe())

\* or an ErrorCode in case of number of currently held samples

\* already exceeds the max number given in Subscribe().

\*/

size_t GetFreeSampleCount() const noexcept;

/\*\*

\* Setting a receive handler signals the Communication Management

\* implementation to use event style mode.

\* I.e. the registered handler gets called asynchronously by the

\* Communication Management as soon as new event data arrives for

\* that event. If the user wants to have strict polling behavior,

\* where no handler is called, NO handler should be registered.

\*

\* Handler may be overwritten anytime during runtime.

\*

\* Provided Handler needs not to be re-entrant since the

\* Communication Management implementation has to serialize calls

\* events arrived since the last call to GetNewSamples().

\*

\* When application calls GetNewSamples() again in the context of the

\* receive handler, MW must - in case new events arrived in the

\* meantime - defer next call to receive handler until after

\* the previous call to receive handler has been completed.

\*/

ara::core::Result\<void\> SetReceiveHandler(ara::com::EventReceiveHandler

 handler);

/\*\*

\* Remove handler set by SetReceiveHandler()

\*/

ara::core::Result\<void\> UnsetReceiveHandler();

/\*\*

\* Setting a subscription state change handler, which shall get

\* called by the Communication Management implementation as soon

\* as the subscription state of this event has changed.

\*

\* Communication Management implementation will serialize calls

\* to the registered handler. If multiple changes of the

\* subscription state take place during the runtime of a

\* previous call to a handler, the Communication Management

\* aggregates all changes to one call with the last/effective

\* state.

\*

\* Handler may be overwritten during runtime.

\*/

ara::core::Result\<void\> SetSubscriptionStateChangeHandler(

ara::com::SubscriptionStateChangeHandler handler);

/\*\*

\* Remove handler set by SetSubscriptionStateChangeHandler()

\*/

void UnsetSubscriptionStateChangeHandler();

/\*\*

\* \\brief Get new data from the Communication Management

\* buffers and provide it in callbacks to the given callable f.

\*

\* \\pre BrakeEvent::Subscribe has been called before

\* (and not be withdrawn by BrakeEvent::Unsubscribe)

\*

\* \\param f

\* \\parblock

\* callback, which shall be called with new sample.

\*

\* This callable has to fulfill signature

\* void(ara::com::SamplePtr\<SampleType const\>)

\* \\parblockend

\*

\* \\param maxNumberOfSamples

\* \\parblock

\* upper bound of samples to be fetched from middleware buffers.

+-----+-------------------------------------------------------------------------+
| 112 | > \* are fetched as long as there are free sample slots.                |
+=====+=========================================================================+
| 113 | > \* \\parblockend                                                      |
+-----+-------------------------------------------------------------------------+
| 114 | > \*                                                                    |
+-----+-------------------------------------------------------------------------+
| 115 | > \* \\return Result, which contains the number of samples,             |
+-----+-------------------------------------------------------------------------+
| 116 | > \* which have been fetched and presented to user via calls to f or an |
+-----+-------------------------------------------------------------------------+
| 117 | > \* ErrorCode in case of error (e.g. precondition not fullfilled)      |
+-----+-------------------------------------------------------------------------+
| 118 | > \*/                                                                   |
+-----+-------------------------------------------------------------------------+

template \<typename F\>

ara::core::Result\<size_t\> GetNewSamples(

F&& f,

size_t maxNumberOfSamples = std::numeric_limits\<size_t\>::max());

};

```

**Listing 5.4: Proxy side BrakeEvent Class**

The data type of the event data in our example event is RadarObjects (see [5.1](#_bookmark100)). The first you encounter is the using-directive which assigns the generic name SampleType to the concrete type, which is then used throughout the interface.

### Event Subscription and Local Cache

The mere fact, that there exists a member of the event wrapper class inside the proxy instance does not mean, that the user gets instant access to events raised/sent out by service instance.

First you have to "subscribe" for the event, in order to tell the Communication Manage- ment, that you are now interested in receiving events.

For that purpose the event wrapper class of [ara::com](#_bookmark15) provides the method

```
/\*\*

\* \\brief The application expects the CM to subscribe the event.

\*

\* \....

\*

\* \\param maxSampleCount maximum number of samples, which can be held.

\*/

ara::core::Result\<void\> Subscribe(size_t maxSampleCount);

```

This method expects a parameter maxSampleCount, which basically informs Com- munication Management implementation, how many event samples the application in- tends to hold at maximum. Therefore --- with calling this method, you not only tell the Communication Management, that you now are interested in receiving event updates, but you are at the same time setting up a \"local cache\" for those events bound to the event wrapper instance with the given maxSampleCount.

This cache is allocated and filled by the Communication Management implementation, which hands out smartpointers to the application for accessing the event sample data. How that works in detail is described in [subsubsection](#accessing-event-data-aka-samples) [5.3.5.3](#accessing-event-data-aka-samples)).

### Monitoring Event Subscription

The call to the Subscribe() method is asynchronous by nature. This means that at the point in time Subscribe() returns, it is just the indication, that the Communication Management has accepted the order to care for subscription.

The subscription process itself may (most likely, but depends on the underlying [IPC](#_bookmark70) implementation) involve the event provider side. Contacting the possibly remote service for setting up the subscription might take some time.

So the binding implementation of the subscribe is allowed to return immediately after accepting the subscribe, even if for instance the remote service instance has not yet acknowledged the subscription (in case the underlying [IPC](#_bookmark70) would support mechanism like acknowledgment at all). If the user --- after having called Subscribe() --- wants to get feedback about the success of the subscription, he might call:

```
/\*\*

\* \\brief query current subscription state.

\*

\* \\return current state of the subscription.

\*/

ara::com::SubscriptionState GetSubscriptionState() const;

```

In the case the underlying [IPC](#_bookmark70) implementation uses some mechanism like a subscrip- tion acknowledge from the service side, then an immediate call to [GetSubscriptionState](#_bookmark48) [()](#_bookmark48) after Subscribe() may return [kSubscriptionPending](#_bookmark40), if the acknowledge has not yet arrived.

Otherwise --- in case the underlying [IPC](#_bookmark70) implementation gets instant feedback, which is very likely for local communication --- the call might also already return [kSubscribed](#_bookmark40).

If the user needs to monitor the subscription state, he has two possibilities:

- Polling via [GetSubscriptionState()](#_bookmark48)
- Registering a handler, which gets called, when the subscription state changes

The first possibility by using [GetSubscriptionState()](#_bookmark48) we have already described above. The second possibility relies on using the following method on the event wrapper in- stance:

```
/\*\*

\* Setting a subscription state change handler, which shall get called

\* by the Communication Management implementation as soon as the

\* subscription state of this event has changed.

\*

\* Handler may be overwritten during runtime.

\*/

ara::core::Result\<void\> SetSubscriptionStateChangeHandler

(ara::com::SubscriptionStateChangeHandler handler);

```

Here the user may register a handler function, which has to fulfill the following signa- ture:

```
enum class SubscriptionState { kSubscribed, kNotSubscribed, kSubscriptionPending };

using SubscriptionStateChangeHandler = std::function\<void( SubscriptionState)\>;
```

Anytime the subscription state changes, the Communication Management implemen- tation calls the registered handler. A typical usage pattern for an application developer, who wants to get notified about latest subscription state, would be to register a handler **before** the first call to Subscribe().

After having accepted the "subscribe order" the Communication Management imple- mentation will call the handler first with argument [SubscriptionState.kSubscription-](#_bookmark40) [Pending](#_bookmark40) and later --- as it gets acknowledgment from the service side --- it will call the handler with argument [SubscriptionState.kSubscribed](#_bookmark40).

Again the note: If the underlying implementation does not support a subscribe ac- knowledgment from the service side, the implementation could also skip the first call to the handler with argument [SubscriptionState.kSubscriptionPending](#_bookmark40) and **directly** call it with argument [SubscriptionState.kSubscribed](#_bookmark40).

Calls to the registered "subscription state change" handler are done fully asyn- chronous. That means, they can even happen, while the call to Subscribe() has not yet returned. The user has to be aware of this!

Once the user has registered such a "subscription state change" handler for a cer- tain event, he may receive multiple calls to this handler. Not only initially, when the state changes from [SubscriptionState.kNotSubscribed](#_bookmark40) to [SubscriptionState.kSub-](#_bookmark40) [scribed](#_bookmark40) (eventually via an intermediate step [SubscriptionState.kSubscriptionPending](#_bookmark40)), but also anytime later as the service providing this event may have a certain life-cycle (maybe bound to certain vehicle modes).

The service might therefore toggle between availability and (temporarily) unavailability or it might even unexpectedly crash and restart. Those changes of the availability of the service instance providing the event may be visible to the proxy side Communication Management implementation.

The Communication Management therefore will fire the registered "subscription state change" handler, whenever it detects such changes, which have influence on the event subscription state.

Additionally (and maybe even more important) --- the Communication Management implementation takes care of renewing/updating event subscriptions done by the user, whenever needed.

This mechanism is closely coupled with the "Auto Update Proxy instance" mechanism already described above ([5.3.4.1](#auto-update-proxy-instance)): Since the Communication Management implemen- tation monitors the availability of the service instances, the service proxies are con- nected to it automatically once the service is available.

The mechanism does not only "auto-update" its proxies if needed, but also "silently" re-subscribes any event subscription already done by the user, after it has updated a proxy instance.

This can be roughly seen as a very useful comfort feature --- without this "re-subscribe after update", the "auto-update" alone seemed to be a halfhearted approach.

With registration of a "subscription state change" handler, the user has now another possibility to monitor the current availability of a service! Beside the possibility to reg- ister a [FindServiceHandler](#_bookmark45) as described in [5.3.4](#finding-services), the user, who has registered a "sub- scription state change" handler, can monitor the service availability indirectly by calls to his handler.

In case the service instance, the proxy is connected to, goes down, the Communication Management calls the handler with argument [SubscriptionState.kSubscriptionPending](#_bookmark40). As soon as the "re-subscribe after update" was successful, the Communication Man- agement calls the handler with argument [SubscriptionState.kSubscribed](#_bookmark40).

An [ara::com](#_bookmark15) compliant Communication Management implementation has to serialize calls to the user registered handler. I.e.: If a new subscription state change happens, while the user provided handler from a previous call of a state change is still running, the Communication Management implementation has to postpone the next call until the previous has returned.

Several subscription state changes, which happen during the runtime of a user reg- istered state change handler, shall be aggregated to one call to the user registered handler with the effective/last state.

### Accessing Event Data --- aka Samples

So, after you successfully subscribed to an event according to the previous chapters, how is the access to received event data samples achieved? The event data, which is sent from the event emitter (service provider) to subscribing proxy instances is --- in typical[IPC](#_bookmark70) implementations --- accumulated/queued in some buffers (e.g. kernel buffers, special[IPC](#_bookmark70)implementation controlled shared memory regions, \...). So there has to be taken an **explicit** action, to get/fetch those event samples from those buffers, eventually deserialze it and and then put them into the event wrapper class instance specific cache in form of a correct SampleType. The API to trigger this action is [GetNewSamples()](#_bookmark51).

```
/\*\*

\* \\brief Get new data from the Communication Management

\* buffers and provide it in callbacks to the given callable f.

\*

\* \....

\*/

template \<typename F\>

ara::core::Result\<size_t\> GetNewSamples(

F&& f,

size_t maxNumberOfSamples = std::numeric_limits\<size_t\>::max());

```

As you can see, the API is a function template, due to the fact, that the first parameter f is a very flexible user provided [Callable](#_bookmark77), which has to fulfill the following singnature requirement: void(ara::com::SamplePtr\<SampleType const\>).

The second argument of type size_t controls the maximum number of event samples, that shall be fetched/deserialized from the middleware buffers and then presented to the application in form of a call to f.

On a call to [GetNewSamples()](#_bookmark51), the [ara::com](#_bookmark15) implementation checks first, whether the number of event samples held by the application already exceeds the maximum number, which it had committed in the previous call to Subscribe(). If so, an ara::Core::ErrorCode is returned. Otherwise [ara::com](#_bookmark15) implementation checks, whether underlying buffers contain a new event sample and --- if it's the case --- deseri- alizes it into a sample slot and then calls the application provided f with a SamplePtr pointing to this new event sample. This processing (checking for further samples in the buffer and calling back the application provided callback f) is repeated until either:

- there aren't any new samples in the buffers
- there are further samples in the buffers, but the application provided maxNum- berOfSamples argument in call to [GetNewSamples()](#_bookmark51) has been reached.
- there are further samples in the buffers, but the application already exceeds its

maxSampleCount, which it had committed in Subscribe().

Within the implementation of callback f, which the application/user provides, it can be decided, what to do with the passed SamplePtr argument (i.e. by eventually doing a deep inspection of the event data): Shall the new sample be \"thrown away\", because it

of event samples means, the semantics of the SamplePtr, which is the access/entry point to the event sample data has to be fully understood.

The following chapter shall clarify this.

The returned [ara::core::Result](#_bookmark35) contains either an ErrorCode or --- in the suc- cess case --- the number of calls to f, which have been done in the context of the [GetNewSamples()](#_bookmark51) call.

### Event Sample Management via SamplePtrs

A SamplePtr, which is handed over from the [ara::com](#_bookmark15) implementation to applica- tion/user layer is --- from a semantical perspective --- a unique-pointer (very similar to a std::unique_ptr): When the [ara::com](#_bookmark15) implementation hands it over an own- ership transfer takes place. From now on the application/user is responsible for the lifetime management of the underlying sample. As long as the user doesn't free the sample by destroying the SamplePtr or by calling explicit assignment-ops/modifiers on the SamplePtr instance, the [ara::com](#_bookmark15) implementation can not reclaim the mem- ory slot occupied by this sample.

Those memory-slots, in which the event sample data reside, are allocated by the [ara::com](#_bookmark15) implementation. This typically takes place in the context of the call to Sub- scribe(), where the user/application defines by parameter maxSampleCount, what maximum number of event data samples it wants to have concurrently accessible. Within later [GetNewSamples()](#_bookmark51) calls, the [ara::com](#_bookmark15) implementation then populates/- fills such a \"sample slot\" (if one is free) and passes a SamplePtr pointing to it in the user/application callback f.

In the callback implementation the user/application decides then, what to do with this passed in SamplePtr. If it wants to keep the sample for later access (i.e. after the return of the callback, it will make a copy at some outer scope location, where it fits in its software component architecture. The decission, whether to copy it (i.e. keep it) might simply depend on the properties/values of the event sample data. In this case the callback implementation is basically applying a \"filter\" on the received event samples. Since we stated, that the SamplePtr behaves like a std::unique_ptr), the above statement has to be slightly corrected: The implementation --- when deciding to keep that event sample --- is obviously not copying that passed in SamplePtr, but moving it to a outer scope location.

The small example in [5.5](#_bookmark115) shows --- beside other things --- in method handleBra- keEventReception() how such a callback implementation could realize simple fil- tering and moving of samples to a global storage with a \"LastN\" semantic for later use/processing.

### Event-Driven vs Polling-Based access

As already promised, we fully support event-driven and polling approaches to access new data. For the polling approach no other APIs are needed than those, which we have discussed up to this point. The typical use case is, that you have an application, which is cyclically triggered to do some processing and provide its output to certain deadlines. This is the typical pattern of a regulator/control algorithm --- the cyclic acti- vation might additionally be driven by a real-time timer, which assures a minimal jitter.

In such a setup you call [GetNewSamples()](#_bookmark51) in each activation cycle and then use those updated cache data as input for the current processing iteration. Here it is fully suffi- cient to get the latest data to process at the time the processing algorithm is scheduled.

It would be counterproductive, if the Communication Management would notify your application anytime new data is available: This would just mean unnecessary context switches to your application process, since at the time you get the notification you do not want to process that new data as it is not time for it.

However, there are other use cases as well. If your application does not have such a cyclical, deadline driven approach, but shall simply react in case certain events occur, then setting up cyclical alarms and poll for new events via calls to [GetNewSamples()](#_bookmark51) is a bit off and vastly inefficient.

In this case you explicitly want the Communication Management to notify your appli- cation thereby issuing asynchronous context switches to your application process. We do support this flavor with the following API mechanism:

ara::core::Result\<void\> SetReceiveHandler(ara::com::EventReceiveHandler handler);

This API allows you to register a user defined callback, which the Communication Management has to call in case new event data is available since the last call to [GetNewSamples()](#_bookmark51). The registered function needs NOT to be re-entrant as the Com- munication Management has to serialize calls to the registered callback.

It is explicitly allowed to call [GetNewSamples()](#_bookmark51) from within the registered callback!

Note, that the user can alter the behavior between event-driven and polling style any- time as he also has the possibility to withdraw the user specific "receive handler" with the UnsetReceiveHandler() method provided by the event wrapper.

The following short code snippet is a simple example of how to work with events on proxy/client side. In this sample a proxy instance of type RadarService is created within main and a reception handler is registered, which gets called by the [ara::com](#_bookmark15) implementation any time new BrakeEvent events get received. This means, that in this example we are using the \"Event-Driven\" approach.

In our sample receive handler, we update our local cache with newly received events, thereby filtering out all BrakeEvent events, which do not fulfill a certain property. After- wards we call a processing function, which processes the samples, we have decided

```
[]{#_bookmark115 .anchor}#include \"RadarServiceProxy.hpp\"

#include \<memory\>

#include \<deque\>

using namespace com::mycompany::division::radarservice;

using namespace ara::com;

/\*\*

\* our radar proxy - initially the unique ptr is invalid.

\*/

std::unique_ptr\<proxy::RadarServiceProxy\> myRadarProxy;

/\*\*

\* a storage for BrakeEvent samples in fifo style

\*/

std::deque\<SamplePtr\<const proxy::events::BrakeEvent::SampleType\>\>

 lastNActiveSamples;

/\*\*

\* \\brief application function, which processes current set of BrakeEvent

\* samples.

\* \\param samples

\*/

void processLastBrakeEvents(

std::deque\<SamplePtr\<const proxy::events::BrakeEvent::SampleType\>\>& samples) {

// do whatever with those BrakeEvent samples \...

}

/\*\*

\* \\brief event reception handler for BrakeEvent events, which we register to get informed about new events.

\*/

void handleBrakeEventReception() {

/\*\*

\* we get newly arrived BrakeEvent events into our process space.

\* For each sample we get passed in, we check for a certain property

\* \"active\" and if it fulfills the check, we move it into our Last10- storage.

\* So this few lines basically implement filtering and a LastN policy.

\*/

myRadarProxy-\>BrakeEvent.GetNewSamples(

\[\](SamplePtr\<proxy::events::BrakeEvent::SampleType\> samplePtr) {

if(samplePtr-\>active) {

lastNActiveSamples.push_back(std::move(samplePtr));

if (lastNActiveSamples.size() \> 10)

lastNActiveSamples.pop_front();

}

});

// \... now process those samples \...

processLastBrakeEvents(lastNActiveSamples);

}

int main(int argc, char\*\* argv) {

/\* Instance Specifier from model \*/

ara::core::InstanceSpecifier instspec {\...}

auto handles = proxy::RadarServiceProxy::FindService(instspec);

if (!handles.empty()) {

/\* we have at least one valid handle - we are not very particular

\* here and take the first one to create our proxy \*/

myRadarProxy = std::make_unique\<proxy::RadarServiceProxy\>(handles

 \[0\]);

/\* we are interested in receiving the event \"BrakeEvent\" - so we

\* subscribe for it. We want to access up to 10 events, since our

\* sample algo averages over at most 10.\*/

myRadarProxy-\>BrakeEvent.Subscribe(10);

/\* whenever new BrakeEvent events come in, we want be called, so we

\* register a callback for it!

\* Note: If the entity we would subscribe to, would be a field

\* instead of an event, it would be crucial, to register our

\* reception handler BEFORE subscribing, to avoid race conditions.

\* After a field subscription, you would get instantly so called

\* \"initial events\" and to be sure not to miss them, you should care

\* for that your reception handler is registered before.\*/

myRadarProxy-\>BrakeEvent.SetReceiveHandler(

 handleBrakeEventReception);

}

// \... wait for application shutdown trigger by application exec mgmt.

}
```

**Listing 5.5: Sample Code how to access Events**

### Buffering Strategies

The following figure sketches a simple deployment, where we have a service providing an event, for which two different local adaptive SWCs have subscribed through their respective [ara::com](#_bookmark15) proxies/event wrappers.

As you can see in the picture both proxies have a local event cache. This is the cache, which gets filled via [GetNewSamples()](#_bookmark51). What this picture also depicts is, that the ser- vice implementation sends its event data to a Communication Management buffer, which is apparently outside the process space of the service implementation --- the picture here assumes, that this buffer is owned by kernel or it is realized as a shared memory between communicating proxies and skeleton or owned by a separate binding implementation specific "demon" process.

![](./media/image10.png)ECU with AP product

**Figure 5.2:** []{#_bookmark117 .anchor}**Event Buffering Approaches**

The background of those assumptions made in the figure is the following: Adap- tive applications are realized as processes with separated/protected memory/address spaces.

Event Data sent out by the service implementation (via the skeleton) cannot be buffered inside the service/skeleton process private address space: If that would be the case, event data access by the proxies would typically lead to context switches to the service application process.

Something, which we want to have total control over on service side via the [Method-](#_bookmark41) [CallProcessingMode](#_bookmark41) (see [subsection](#polling-and-event-driven-processing-modes) [5.4.5](#polling-and-event-driven-processing-modes)) and should therefore not be triggered by the communication behavior of arbitrary service consumers. Now let's have a rough look at the three different places, where the buffer, which is target for the "send event" might be located:

- Kernel Space: Data is sent to a memory region not mapped directly to an ap- plication process. This is typically the case, when binding implementation uses [IPC](#_bookmark70)primitives like pipes or sockets, where data written to such a primitive ends up in kernel buffer space.
- Shared Memory: Data is sent to a memory region, which is also directly readable from receivers/proxies. Writing/reading between different parties is synchronized specifically (lightweight with mem barriers or with explicit mutexes).
- IPC-Daemon Space: Data is sent to an explicit non-application process, which acts as a kind of demon for the IPC/binding implementation. Note, that techni- cally this approach might be built on an[IPC](#_bookmark70)primitive like communication via kernel space or shared memory to get the data from service process to demon process.

Each of those approaches might have different pros and cons regarding flexibility/size of buffer space, efficiency in terms of access speed/overhead and protection against malicious access/writing of buffers. Therefore consideration of different constraints in an AP product and its use might lead to different solutions.

What shall be emphasized here in this example, is, that the AP product vendor is explic- itly encouraged to use a reference based approach to access event data: The [ara:-](#_bookmark15)

[:com](#_bookmark15) API of event wrapper intentionally models the access via SamplePtr, which are

passed to the callbacks and not the value!

In those rather typical scenarios of 1:N event communication, this would allow to have inside the "Local Event Cache" not the event data values itself but pointers/references to the data contained in a central Communication Management buffer. Updating the local cache via [GetNewSamples()](#_bookmark51) could then be implemented not as a value copy but as reference updates.

To be honest: This is obviously a coarse grained picture of optimization possibilities regarding buffer usage! As hinted here ([section](#serialization) [7.1](#serialization)) data transferred to application processes must typically be de-serialized latest before first application access.

Since de-serialization has to be specific to the alignment of the consuming application the central sharing of an already de-serialized representation might be tricky. But at least you get the point, that the API design for event data access on the proxy/service consumer side gives room to apply event data sharing among consumers.

### Methods

For each method the remote service provides, the proxy class contains a member of a method specific wrapper class.

In our example, we have three methods and the corresponding members have the name Calibrate (of type methods::Calibrate), Adjust (of type methods::- Adjust) and LogCurrentState (of type methods::LogCurrentState). Just like the event classes the needed method classes of the proxy class are generated inside a specific namespace methods, which is contained inside the proxy namespace.

The method member in the proxy is used to call a method provided by the possibly remote service instance our proxy is connected to.

Let's have a look at the generated method class for our example --- we pick out the

Adjust method here:

```
class Adjust {

public:

/\*\*

\* For all output and non-void return parameters

\* an enclosing struct is generated, which contains

\* non-void return value and/or out parameters.

\*/

struct Output {

bool success;

Position effective_position;

};

/\*\*

\* \\brief Operation will call the method.

\*

\* Using the operator the call will be made by the Communication

\* Management and a future returned, which allows the caller to

\* get access to the method result.

\*

\* \\param\[in\] target_position See service description.

\*

\* \\return A future containing Output struct

\*/

ara::core::Future\<Output\> operator()(const Position &target_position);

};
```

**Listing 5.6: Proxy side Adjust Method Class**

So the method wrapper class is not that complex. It just consists of two parts: An inner structure definition, which aggregates all OUT-/INOUT-parameters of the method, and a bracket operator, which is used to call the service method.

The operator contains all of the service methods IN-/INOUT-parameters as IN- parameters. That means INOUT-parameters in the abstract service method description are split in a pair of IN and OUT parameters in the [ara::com](#_bookmark15) API.

The return value of a call to a service method, which is **not** a "one-way method" is an [ara::core::Future](#_bookmark36), where the template parameter is of the type of the inner struct, which aggregates all OUT-parameters of the method. More about this [ara::core::Future](#_bookmark36) in the following subsection.

### One-Way aka Fire-and-Forget Methods

Before proceeding with the functionalities provided for "normal" methods, we briefly introduce "one-way methods" here as we already referred to this term in the previous section. [ara::com](#_bookmark15) supports a special flavor of a method, which we call "one-way" or "fire-and-forget". Technically this is a method with only IN-params --- no OUT-params and no raising of errors allowed. There is also no hand-shaking/synchronisation pos- sible with the server! The client/caller therefore gets no feedback at all, whether the server/callee has processed a "one-way" call or not.

There are communication patterns, where such a best-effort approach is fully suffi- cient. In this case such a "one-way/fire-and-forget" semantics is very light-weight from a resource perspective. If we look at the signature of such a method, we see, that it is simpler, than that from a regular method:

```

class LogCurrentState {

public:

/\*\*

\* \\brief Operation will call the method.

\*

\* Using the operator the call will be made by the Communication

\* Management.

\*

\* It is a one-way method, so no feedback (return value/out-parameter)

\* is given.

\*/

void operator()();

};

```

**Listing 5.7: Proxy side LogCurrentState Method Class**

### Event-Driven vs Polling access to method results

Similar to the access to event data described in the previous section ([subsection](#events) [5.3.5](#events)), we provide API support for an event-driven and polling-based approach also for ac- cessing the results of a service method call.

The magic of differentiation between both approaches lies in the returned [ara::core::-](#_bookmark36) [Future](#_bookmark36): [ara::core::Future](#_bookmark36) is basically an extended version of the C++11/C++14 [std:-](#_bookmark25)

[:future](#_bookmark25) class; see \[[3](#_bookmark2)\] for details.

Like in the event data access, event-driven here means, that the caller of the method (the application with the proxy instance) gets notified by the Communication Manage- ment implementation as soon as the method call result has arrived.

For a Communication Management implementation of [ara::com](#_bookmark15) this means, it has to setup some kind of waiting mechanism (WaitEvent) behind the scene, which gets woken up as soon as the method result becomes available, to notify the [ara::com](#_bookmark15) user. So how do the different usage patterns of the [ara::core::Future](#_bookmark36) work then?

Let's have a deeper look at our [ara::core::Future](#_bookmark36) and the interfaces it provides:

```

enum class future_status : uint8_t

{

ready, ///\< the shared state is ready

timeout, ///\< the shared state did not become ready before the specified timeout has passed

};

template \<typename T, typename E = ErrorCode\>

class Future {

public:

Future() noexcept = default;

\~Future();

Future(const Future&) = delete;

Future& operator=(const Future&) = delete;

Future(Future&& other) noexcept;

Future& operator=(Future&& other) noexcept;

/\*\*

\* \@brief Get the value.

\*

\* This function shall behave the same as the corresponding std::future

\* function.

\*

\* \@returns value of type T

\* \@error Domain:error the error that has been put into the

\* corresponding Promise via Promise::SetError

\*

\*/

T get();

\* \@brief Get the result.

\*

\* Similar to get(), this call blocks until the value or an error is

\* available. However, this call will never throw an exception.

\*

\* \@returns a Result with either a value or an error

\* \@error Domain:error the error that has been put into the

\* corresponding Promise via Promise::SetError

\*

\*/

Result\<T, E\> GetResult() noexcept;

/\*\*

\* \@brief Checks if the Future is valid, i.e. if it has a shared state.

\*

\* This function shall behave the same as the corresponding std::future

\* function.

\*

\* \@returns true if the Future is usable, false otherwise

\*/

bool valid() const noexcept;

/\*\*

\* \@brief Wait for a value or an error to be available.

\*

\* This function shall behave the same as the corresponding std::future

\* function.

\*/

void wait() const;

/\*\*

\* \@brief Wait for the given period, or until a value or an error is

\* available.

\*

\* This function shall behave the same as the corresponding std::future

\* function.

\*

\* \@param timeoutDuration maximal duration to wait for

\* \@returns status that indicates whether the timeout hit or if a value

\* is available

\*/

template \<typename Rep, typename Period\>

future_status wait_for(std::chrono::duration\<Rep, Period\> const& timeoutDuration) const;

/\*\*

\* \@brief Wait until the given time, or until a value or an error is

\* available.

\*

\* This function shall behave the same as the corresponding std::future

\* function.

\*

\* \@param deadline latest point in time to wait

\* \@returns status that indicates whether the time was reached or if a

\* value is available

template \<typename Clock, typename Duration\>

future_status wait_until(const std::chrono::time_point\<Clock, Duration

 \>& deadline) const;

/\*\*

\* \@brief Register a callable that gets called when the Future becomes

\* ready.

\*

\* When \@a func is called, it is guaranteed that get() and GetResult()

\* will not block.

\*

\* \@a func may be called in the context of this call or in the context

\* of Promise::set_value() or Promise::SetError() or somewhere else.

\*

\* The return type of \@a then depends on the return type of \@a func

\* (aka continuation).

\*

\* Let U be the return type of the continuation (i.e. a type equivalent

\* to std::result_of_t\<std::decay_t\<F\>(Future\<T,E\>)\>).

\* - If U is Future\<T2,E2\> for some types T2, E2, then the return

\* type of \@a then() is Future\<T2,E2\>. This is known as implicit

\* Future unwrapping.

\* - If U is Result\<T2,E2\> for some types T2, E2, then the return

\* type of \@a then() is Future\<T2,E2\>. This is known as implicit

\* Result unwrapping.

\* - Otherwise it is Future\<U,E\>.

\*

\* \@param func a callable to register

\* \@returns a new Future instance for the result of the continuation

\*/

template \<typename F\>

auto then(F&& func) -\> Future\<SEE_COMMENT_ABOVE\>;

/\*\*

\* \@brief Return whether the asynchronous operation has finished.

\*

\* If this function returns true, get(), GetResult() and the wait calls

\* are guaranteed not to block.

\*

\* The behavior of this function is undefined if valid() returns false.

\*

\* \@returns true if the Future contains a value or an error, false

\* otherwise

\*/

bool is_ready() const;

};

```

**Listing 5.8: ara::core::Future Class**

[ara::core::GetResult()](#_bookmark39) returns Result or an Error inside an [ara::core::Future](#_bookmark36) object and throws no exception. get() returns the corresponding ara::core::Future and / or throws exception.

See \[[3](#_bookmark2)\] chapter \"Error handling\" for detailed documentation of the error handling ap- proaches in the Addaptive Platform.

Below is the sample of using \"exception-based\" approach to synchronously call a method:

```

using namespace ara::com;

int main() {

// some code to acquire a handle

// \...

RadarServiceProxy service(handle);

Future\<Calibrate::Output\> callFuture = service.Calibrate( myConfigString);

/\*\*

\* Now we do a blocking get(), which will return in case the result

\* (valid or exception) is received.

\*

\* If Calibrate could throw an exception and the service has set one,

\* it would be thrown by get()

\*/

Calibrate::Output callOutput = callFuture.get();

// process callOutput \...

return 0;

}

```

**Listing 5.9: Synchronous method call sample**

In a nutshell: A synchronous call (from the viewpoint of the application developer) to a service method, simply consists of the ()-operator call-syntax with a subsequent blocking get() call on the returned future.

There are other ways for the user to get a notification from the Communication Man- agement implementation as soon as the method result is available beside resuming execution from a blocking call to get():

- The variants of "wait" , which the [ara::core::Future](#_bookmark36) has taken over from [std::fu-](#_bookmark25) [ture](#_bookmark25). They basically provide the functionality of a blocking wait for the fulfillment of the future.
- Registering a callback method via then(). This is one of the extensions to the

[std::future](#_bookmark25); see \[[3](#_bookmark2)\] for details.

The plain parameterless wait() variant has the same blocking semantics like get()

--- i.e. blocks till the future has a valid result (value or exception).

The variants of "wait", where you either give a duration (wait_for()) or a target point in time (wait_until()) will return either if the future has a valid result or in case the timeout/deadline restriction has been met --- therefore they both return fu- ture_status to allow distinction between those cases.

The last possibility to get notification of the result of the future (valid or exception) is by registering a callback method via then(). This is one of the extensions to the [ara::core::Future](#_bookmark36) over [std::future](#_bookmark25).

As you can see, all the possibilities to get access to the future's method result we have discussed (and partly showed in examples) up to now --- blocking "get", all "wait" variants and "then" --- are **event-driven**. I.e. the event of the arrival of the method result (or an error) leads to either resuming of a blocked user thread or call to a user provided function!

There are of course cases, where the [ara::com](#_bookmark15) users does not want his applica- tion (process) getting activated by some method-call return event at all! Think for a typical RT (real time) application, which must be in total control of its execution. We discussed this RT/polling use case already in the context of event data access already ( [subsubsection](#accessing-event-data-aka-samples) [5.3.5.3](#accessing-event-data-aka-samples)). For method calls the same approach applies!

So we did foresee the following usage pattern with regards to [ara::core::Future](#_bookmark36): After you have called the service method via the ()-operator, you just use ara::core::- Future::is_ready() to poll, whether the method call has been finished. This call is defined to be **non-blocking**. Sure, it might involve some syscall/context-switch (for instance to look into some kernel buffers), which is not for free, but it does not block!

After ara::core::Future::is_ready() has returned true, it is guaranteed that the next call to ara::core::Future::get() will NOT block, but immediately return either the valid value or throw an exception in case of error.

### Canceling Method Result

There may be cases, where you already have called a service method via the ()- operator, which returned you an [ara::core::Future](#_bookmark36), but you are not interested in the result anymore.

It could even be the case, that you already have registered a callback via ara::- core::Future::then() for it. Instead of just let things go and "ignore" the callback, you should tell the Communication Management explicitly.

This might free resources and avoid unnecessary processing load on the binding im- plementation level. Telling that you are not interested in the method call result anymore is simply done by letting the [ara::core::Future](#_bookmark36) go out of scope, so that its destructor gets called.

Call of the [dtor](#_bookmark24) of the [ara::core::Future](#_bookmark36) is a signal to the binding implementation, that any registered callback for this future shall not be called anymore, reserved/allocated memory for the method call result might be freed and event waiting mechanisms for the method result shall be stopped.

To trigger the call to the [dtor](#_bookmark24) you could obviously let the future go out of scope. De- pending on the application architecture this might not be feasible, as you already might

To solve this, the [ara::core::Future](#_bookmark36) is default-constructible. Therefore you simply over- write the returned [ara::core::Future](#_bookmark36) in the variable with a default constructed instance as is shown in the example below:

```

using namespace ara::com;

Future\<Calibrate::Output\> calibrateFuture;

int main() {

// some code to acquire handle

// \...

RadarServiceProxy service(handle);

calibrateFuture = service.Calibrate(myConfigString);

/\*\* \....

\* Some state changes happened, which render the calibrate method

\* result superfluous \...

\*

\* We force deletion by resetting our variable to a new default

\* constructed Future.

\*/

calibrateFuture = Future\<Calibrate::Output\>();

// go on doing something \...

return 0;

}

```

**Listing 5.10: Example of discarding a future**

### Fields

Conceptually a field has --- unlike an event --- a certain value at any time. That results in the following additions compared to an event:

- if a subscription to a field has been done, "immediately" current values are sent back to the subscriber in an event-like notification pattern.
- the current field value can be queried via a call to a [Get()](#_bookmark56) method or could be updated via a [Set()](#_bookmark57) method.

Note, that all the features a field provides are optionally: In the configuration (IDL) of your field, you decide, whether it has "on-change-notification", [Get()](#_bookmark56) or [Set()](#_bookmark57). In our example field (see below), we have all three mechanisms configured.

For each field the remote service provides, the proxy class contains a member of a field specific wrapper class. In our example the member has the name UpdateRate (of type fields::UpdateRate).

Just like the event and method classes the needed field classes of the proxy class are generated inside a specific namespace fields, which is contained inside the proxy namespace.

The explanation of fields has been intentionally put after the explanation of events and methods, since the field concept is roughly an aggregation of an event with correlated get()/set() methods. Therefore technically we also implement the [ara::com](#_bookmark15) field rep- resentation as a combination of [ara::com](#_bookmark15) event and method.

Consequently the field member in the proxy is used to

- call [Get()](#_bookmark56) or [Set()](#_bookmark57) methods of the field with exactly the same mechanism as reg- ular methods
- access field update notifications in the form of events/event data, which are sent by the service instance our proxy is connected to with exactly the same mecha- nism as regular events

Let's have a look at the generated field class for our example UpdateRate field here:

```

class UpdateRate {

/\*\*

\* \\brief Shortcut for the events data type.

\*/

using FieldType = uint32_t;

/\*\*

\* \\brief See Events for details, as a field contains the possibility

\* for notifications the details of the interfaces described there.

\*/

ara::core::Result\<void\> Subscribe(size_t maxSampleCount);

size_t GetFreeSampleCount() const noexcept;

ara::com::SubscriptionState GetSubscriptionState() const;

void Unsubscribe();

ara::core::Result\<void\> SetReceiveHandler(ara::com::EventReceiveHandler handler);

ara::core::Result\<void\> UnsetReceiveHandler();

ara::core::Result\<void\> SetSubscriptionStateChangeHandler(ara::com:: SubscriptionStateChangeHandler handler);

void UnsetSubscriptionStateChangeHandler();

template \<typename F\>

ara::core::Result\<size_t\> GetNewSamples(

+-------+-----------------------------------------------------------------------+-----+
| 21    | > F&& f,                                                              |     |
+=======+=======================================================================+=====+
| 22    | > size_t maxNumberOfSamples = std::numeric_limits\<size_t\>::max());  |     |
+-------+-----------------------------------------------------------------------+-----+
| 23    |                                                                       |     |
+-------+-----------------------------------------------------------------------+-----+
| 24    | /\*\*                                                                 |     |
+-------+-----------------------------------------------------------------------+-----+
| 25    | > \* The getter allows to request the actual value of the service     |     |
+-------+-----------------------------------------------------------------------+-----+
| 26    | > \* provider.                                                        |     |
+-------+-----------------------------------------------------------------------+-----+
| 27    | > \*                                                                  |     |
+-------+-----------------------------------------------------------------------+-----+
| 28    | > \* For a description of the future, see the method.                 |     |
+-------+-----------------------------------------------------------------------+-----+
| 29    | > \* It should behave like a Method.                                  |     |
+-------+-----------------------------------------------------------------------+-----+
| 30    | > \*/                                                                 |     |
+-------+-----------------------------------------------------------------------+-----+
| 31    | ara::core::Future\<FieldType\> Get();                                 |     |
+-------+-----------------------------------------------------------------------+-----+
| 32    |                                                                       |     |
+-------+-----------------------------------------------------------------------+-----+
| 33    | /\*\*                                                                 |     |
+-------+-----------------------------------------------------------------------+-----+
| 34    | > \* The setter allows to request the setting of a new value.         |     |
+-------+-----------------------------------------------------------------------+-----+
| 35    | > \* It is up to the Service Provider ro accept the request or modify | it. |
+-------+-----------------------------------------------------------------------+-----+
| 36    | > \* The new value shall be sent back to the requester as response.   |     |
+-------+-----------------------------------------------------------------------+-----+
| 37    | > \*                                                                  |     |
+-------+-----------------------------------------------------------------------+-----+
| 38    | > \* For a description of the future, see the method.                 |     |
+-------+-----------------------------------------------------------------------+-----+
| 39    | > \* It should behave like a Method.                                  |     |
+-------+-----------------------------------------------------------------------+-----+
| 40    | > \*/                                                                 |     |
+-------+-----------------------------------------------------------------------+-----+
| 41    | ara::core::Future\<FieldType\> Set(const FieldType& value);           |     |
+-------+-----------------------------------------------------------------------+-----+
| 42 }; |                                                                       |     |
+-------+-----------------------------------------------------------------------+-----+
|       | > **Listing 5.11: Proxy side UpdateRate Field Class**                 |     |
+-------+-----------------------------------------------------------------------+-----+

```

There is nothing more to be described here. For documentation of the mechanisms of event-like part of the field have a look at [subsection](#events) [5.3.5](#events) and for documentation of the method-like part of the field have a look at [subsection](#methods) [5.3.6](#methods).

### Triggers

Triggers are simply a class of dataless events. Which means that all the documen- tation in [subsection](#events) [5.3.5](#events) is also applicable for Triggers, except for the data related part, which is described in this section.

From Proxy point of view, subscribing to a Trigger is the same as described in [subsubsection](#event-subscription-and-local-cache) [5.3.5.1](#event-subscription-and-local-cache) without the local cache part.

```

/\*\*

\* \\brief The application expects the CM to subscribe the event.

\*/

ara::core::Result\<void\> Subscribe();

```

A *Subscribe()* call will inform Communication Management for receiving Trigger up- dates.

The other subscription capabilities (e.g. *SubscribeChangeSetSubscriptionHandler()*, *Unsubscribe()*) are the same as for Events.

A big difference from Events is receiving Trigger updates.

In contrary to Events, where we were interested in the recieved data, for Triggers we are only interested in the number of Triggers received since last check. Therefore *GetNewTriggers()* is more simple than *GetNewSamples()*:

```
/\*\*

\* \\brief Get number of triggeres if any recieved.

\*

\* \\return Result, which indicates the number of new triggers

\* (zero means no new trigger has been recieved).

\*/

size_t GetNewTriggers();

```

Where the return value has the number of received Triggers that took place since the last call to *GetNewTriggers()*.

Polling-based and Event-driven access, as mentioned in [subsubsection](#event-driven-vs-polling-based-access) [5.3.5.5](#event-driven-vs-polling-based-access), is also supported for Triggers

## Skeleton Class

The Skeleton class is generated from the [SI](#_bookmark71) description of the AUTOSAR meta model. [ara::com](#_bookmark15) does standardize the interface of the generated Skeleton class. The toolchain of an AP product vendor will generate a Skeleton implementation class exactly implementing this interface.

The generated Skeleton class is an abstract class. It cannot be instantiated directly, because it does not contain implementations of the service methods, which the service shall provide. Therefore the service implementer has to subclass the skeleton and

Note: Equal to the Proxy class the interfaces the Skeleton class has to provide are defined by [ara::com](#_bookmark15), a generic (product independent) generator could generate an abstract class or a mock class against which the application developer could implement his service provider application. This perfectly suits the platform vendor independent development of Adaptive AUTOSAR SWCs.

[ara::com](#_bookmark15) expects skeleton related artifacts inside a namespace \"skeleton\". This namespace is typically included in a namespace hierarchy deduced from the service definition and its context.

### Skeleton Class API's

- [OfferService()](#_bookmark61)
- [StopOfferService()](#_bookmark62)
- [Send()](#_bookmark63)
- [Allocate()](#_bookmark64)
- [ProcessNextMethodCall()](#_bookmark66)
- [RegisterGetHandler()](#_bookmark67)
- [RegisterSetHandler()](#_bookmark68)
- [Field::Update()](#_bookmark69)

  1. ### RadarService Skeleton Class Example

```

[]{#_bookmark127 .anchor}class RadarServiceSkeleton {

public:

/\*\*

\* Ctor taking instance identifier as parameter and having default

\* request processing mode kEvent.

\*/

RadarServiceSkeleton(ara::com::InstanceIdentifier instanceId,

ara::com::MethodCallProcessingMode mode =

ara::com::MethodCallProcessingMode::kEvent);

/\*\*

\* Exception-less ctor taking instance identifier as parameter

\* and having default request processing mode kEvent.

\*/

static ara::core::Result\<RadarServiceSkeleton\> Create(

const ara::core::InstanceIdentifier &instanceID,

ara::com::MethodCallProcessingMode mode =

ara::com::MethodCallProcessingMode::kEvent) noexcept;

/\*\*

\* Ctor taking instance identifier container as parameter and having

\* default request processing mode kEvent.

\* This specifically supports multi-binding.

\*/

RadarServiceSkeleton(ara::com::InstanceIdentifierContainer instanceIds,

ara::com::MethodCallProcessingMode mode =

ara::com::MethodCallProcessingMode::kEvent);

/\*\*

\* Exception-less ctor taking instance identifier container as parameter

\* and having default request processing mode kEvent.

\*/

static ara::core::Result\<RadarServiceSkeleton\> Create(

const ara::core::InstanceIdentifierContainer &instanceIDs,

ara::com::MethodCallProcessingMode mode =

ara::com::MethodCallProcessingMode::kEvent) noexcept;

/\*\*

\* Ctor taking instance specifier as parameter and having default

\* request processing mode kEvent.

\*/

RadarServiceSkeleton(ara::core::InstanceSpecifier instanceSpec,

ara::com::MethodCallProcessingMode mode =

ara::com::MethodCallProcessingMode::kEvent);

/\*\*

\* Exception-less ctor taking instance specifier as parameter and having default

\* request processing mode kEvent.

\*/

static ara::core::Result\<RadarServiceSkeleton\> Create(

const ara::core::InstanceSpecifier &instanceSpec,

ara::com::MethodCallProcessingMode mode =

ara::com::MethodCallProcessingMode::kEvent) noexcept;

/\*\*

\* skeleton instances are nor copy constructible.

\*/

RadarServiceSkeleton(const RadarServiceSkeleton& other) = delete;

/\*\*

\* skeleton instances are nor copy assignable.

\*/

RadarServiceSkeleton& operator=(const RadarServiceSkeleton& other) =

 delete;

/\*\*

\* The Communication Management implementer should care in his dtor

\* implementation, that the functionality of StopOfferService()

\* is internally triggered in case this service instance has

\* been offered before. This is a convenient cleanup functionality.

\*/

\~RadarServiceSkeleton();

/\*\*

\* method is idempotent - could be called repeatedly.

\*/

ara::core::Result\<void\> OfferService();

/\*\*

\* Stop Offering the service instance.

\* method is idempotent - could be called repeatedly.

\*

\* If service instance gets destroyed - it is expected that the

\* Communication Management implementation calls StopOfferService()

\* internally.

\*/

void StopOfferService();

/\*\*

\* For all output and non-void return parameters

\* an enclosing struct is generated, which contains

\* non-void return value and/or out parameters.

\*/

struct CalibrateOutput {

bool result;

};

/\*\*

\* For all output and non-void return parameters

\* an enclosing struct is generated, which contains

\* non-void return value and/or out parameters.

\*/

struct AdjustOutput {

bool success;

Position effective_position;

};

/\*\*

\* This fetches the next call from the Communication Management

\* and executes it. The return value is a ara::core::Future.

\* In case of an Application Error, an ara::core::ErrorCode is stored

\* in the ara::core::Promise from which the ara::core::Future

\* is returned to the caller.

\* Only available in polling mode.

\*/

ara::core::Future\<bool\> ProcessNextMethodCall();

/\*\*

\* \\brief Public member for the BrakeEvent

\*/

events::BrakeEvent BrakeEvent;

/\*\*

\* \\brief Public member for the UpdateRate

\*/

fields::UpdateRate UpdateRate;

/\*\*

\* The following methods are pure virtual and have to be implemented

virtual ara::core::Future\<CalibrateOutput\> Calibrate(

std::string configuration) = 0;

virtual ara::core::Future\<AdjustOutput\> Adjust(

const Position& position) = 0;

virtual void LogCurrentState() = 0;

};

```

**Listing 5.12: RadarService Skeleton**

### Instantiation (Constructors)

As you see in the example code of the RadarServiceSkeleton above, the skeleton class, from which the service implementer has to subclass his service implementa- tion, provides three different [ctor](#_bookmark23) variants, which basically differ in the way, how the instance identifier to be used is determined.

Since you could deploy many different instances of the same type (and therefore same skeleton class) it is straightforward, that you have to give an instance identifier upon creation. This identifier has to be unique. In the exception-less creation of a service Skeleton using the named constructor approach, a static member function, Create(), checks if the provided identifier is not unique, or other errors. If an error is discovered, an error code is set in the returned ara::core::Result. Otherwise the created Skeleton instance is returned.

If a new instance shall be created with the same identifier, the existing instance needs to be destroyed before.

Exactly for this reason the skeleton class (just like the proxy class) does neither support copy construction nor copy assignment! Otherwise two \"identical\" instances would exist for some time with the same instance identifier and routing of method calls would be non-deterministic.

The different variants of [ctor](#_bookmark23)s regarding instance identifier definition reflect their dif- ferent natures, which are described in [subsection](#instance-identifiers-and-instance-specifiers) [4.8.1](#instance-identifiers-and-instance-specifiers).

- variant with [ara::com::InstanceIdentifier](#_bookmark31): Service instance will be cre- ated with exactly one binding specific instance identifier.
- variant with [ara::com::InstanceIdentifierContainer](#_bookmark32): Service instance will be created with bindings to multiple distinct instance identifiers. This is men- tioned as \"multi-binding\" throughout this document and also explained in more detail in [section](#multi-binding-implications) [7.3](#multi-binding-implications)
- variant with [ara::core::InstanceSpecifier](#_bookmark42): Service instance will be cre- ated with bindings to the instance identifier(s) found after \"service manifest\" lookup with the given [ara::core::InstanceSpecifier](#_bookmark42). Note, that this could also imply a \"multi-binding\" as the integrator could have mapped the given [ara:-](#_bookmark42)

[:core::InstanceSpecifier](#_bookmark42) to multiple technical/binding specific instance identifiers within the \"service manifest\".

The second parameter of the [ctor](#_bookmark23)s of type ara::com::MethodCallProcessing-

Note: Directly after creation of an instance of the subclass implementing the skeleton, this instance will not be visible to potential consumers and therefore no method will be called on it. This is only possible after the service instance has been made visible with the OfferService API (see below).

### Offering Service instance

The skeleton provides the method [OfferService()](#_bookmark61). After you --- as application developer for the service provider side --- have instantiated your custom service implementation class and initialized/set up your instance to a state, where it is now able to serve re- quests (method calls) and provide events to subscribing consumers, you will call this OfferService() method on your instance.

From this point in time, where you call it, method calls might be dispatched to your service instance --- even if the call to [OfferService()](#_bookmark61) has not yet returned.

If you decide at a certain point (maybe due to some state changes), that you do not want to provide the service anymore, you call [StopOfferService()](#_bookmark62) on your instance. The contract here is: After [StopOfferService()](#_bookmark62) has returned no further method calls will be dispatched to your service instance.

For sanity reasons [ara::com](#_bookmark15) has the requirement for the AP vendors implementation of the skeleton [dtor](#_bookmark24), that it internally does a [StopOfferService()](#_bookmark62) too, if the instance is currently offered.

So --- "stop offer" needs only be called on an instance which lives on, and during its lifetime it switches between states where it is visible and provides its service, and states where it does not provide the service.

```

using namespace ara::com;

/\*\*

\* Our implementation of the RadarService -

\* subclass of RadarServiceSkeleton

\*/

class RadarServiceImpl;

int main(int argc, char\*\* argv) {

// read instanceId from commandline

ara::core::string_view instanceIdStr(argv\[1\]);

RadarServiceImpl myRadarService(InstanceIdentifier(instanceIdStr));

// do some service specific initialization here \....

myRadarService.init();

// now service instance is ready -\> make it visible/available

myRadarService.OfferService();

// go into some wait state in main thread - waiting for AppExecMgr

// signals or the like \....

return 0;

}

```

**Listing 5.13: Example of RadarService Init and Offer**

### Polling and event-driven processing modes

Now let's come to the point, where we deliver on the promise to support event-driven and polling behavior also on the service providing side. From the viewpoint of the service providing instance --- here our skeleton/skeleton subclass instance --- requests (service method or field getter/setter calls) from service consumers may come in at arbitrary points in time.

In a purely event-driven setup, this would mean, that the Communication Management generates corresponding call events and transforms those events to concrete method calls to the service methods provided by the service implementation.

The consequences of this setup are clear:

- general reaction to a service method call might be fast, since the latency is only restricted by general machine load and intrinsic[IPC](#_bookmark70)mechanism latency.
- rate of context switches to the OS process containing the service instance might be high and non-deterministic, decreasing overall throughput.

As you see --- there are pros and cons for an event-driven processing mode at the service provider side. However, we do support such a processing mode with [ara:-](#_bookmark15)

[:com](#_bookmark15). The other bookend we do support, is a pure polling style approach. Here

the application developer on the service provider side explicitly calls an [ara::com](#_bookmark15)

provided API to process explicitly **one** call event.

With this approach we again support the typical RT-application developer. His applica- tion gets typically activated due to a low jitter cyclical alarm.

When his application is active, it checks event queues in a non-blocking manner and decides explicitly how many of those accumulated (since last activation time) events it is willing to process. Again: Context switches/activations of the application process are only accepted by specific (RT) timers. Asynchronous communication events shall **not** lead to an application process activation.

So how does [ara::com](#_bookmark15) allow the application developer to differentiate between those processing modes? The behavior of a skeleton instance is controlled by the second parameter of its [ctor](#_bookmark23), which is of type ara::com::MethodCallProcessingMode.

```

/\*\*

\* Request processing modes for the service implementation side

\* (skeleton).

\*

\* \\note Should be provided by platform vendor exactly like this.

\*/

```

That means the processing mode is set for the entire service instance (i.e. all its provided methods are affected) and is fix for the whole lifetime of the skeleton instance. The default value in the [ctor](#_bookmark23) is set to kEvent, which is explained below.

### Polling Mode

If you set it to kPoll, the Communication Management implementation will not call any of the provided service methods asynchronously!

If you want to process the next (assume that there is a queue behind the scenes, where incoming service method calls are stored) pending service-call, you have to call the following method on your service instance:

```
/\*\*

\* This fetches the next call from the Communication Management

\* and executes it.

\* Only available in polling mode.

\*/

ara::core::Future\<bool\> ProcessNextMethodCall();

```

We are using the mechanism of [ara::core::Future](#_bookmark36) again to return a result, which will be fulfilled in the future. What purpose does this returned [ara::core::Future](#_bookmark36) serve? It allows you to get notified, when the "next request" has been processed. That might be helpful to chain service method calls one after the other. A simple use case for a typical RT application could be:

- RT application gets scheduled.
- it calls ProcessNextMethodCall and registers a callback with ara::core:-

:Future::then()

- the callback is invoked after the service method called by the middleware corre- sponding to the outstanding request has finished.
- in the callback the RT application decides, if there is enough time left for serving a subsequent service method. If so, it calls another ProcessNextMethodCall.

Sure - this simple example assumes, that the RT application knows worst case runtime of its service methods (and its overall time slice), but this is not that unlikely!

The bool value of the returned [ara::core::Future](#_bookmark36) is set to true by the Communication Management in case there really was an outstanding request in the queue, which has been dispatched, otherwise it is set to false.

This is a somewhat comfortable indicator to the application developer, not to call re- peatedly ProcessNextMethodCall although the request queue is empty. So calling ProcessNextMethodCall directly after a previous call returned an [ara::core::Future](#_bookmark36) with the result set to false might most likely do nothing (except that incidentally in this minimal time frame a new request came in).

Please note polling mode has implications on AP products based on typical operating systems. Ruling out context switches to a process (containing a service implementa- tion) caused by Communication Management events (incoming service method calls) means also: There are constraints for the location of the queue, which has to collect the service method call requests until they are consumed by the polling service imple- mentation.

The queue must be realized either outside of the address space of the service provider application or it must be located in a shared memory like location, so that the sending part is able to write directly into the queue. In comparison to a shared memory solution the access from the polling service provider to below queue locations might come with higher costs/latency. Typical solutions of placing the queue outside of the service provider address space would be:

- Kernel space: If the binding implementation would use socket or pipe mecha- nisms, the kernel buffers being the target of the write-call would resemble the queue. Adapting/configuring maximal sizes of those buffers might in typical OS mean recompiling the kernel.
- User address space of a different binding/Communication Management demon- application: Buffer space allocation for queues allocated within user space could typically be done more dynamic/flexible

  1. ### Event-Driven Mode

If you set the processing mode to kEvent or kEventSingleThread, the Communi- cation Management implementation will dispatch events asynchronously to the service method implementations at the time the service call from the service consumer comes in.

Opposed to the kPoll mode, here the service consumer implicitly controls/triggers service provider process activations with their method calls!

What is then the difference between kEvent and kEventSingleThread? kEvent means, that the Communication Management implementation may call the service method implementations concurrently.

That means for our example: If --- at the same point in time --- one call to method Cal- ibrate and two calls to method Adjust arrive from different service consumers, the Communication Management implementation is allowed to take three threads from its internal thread-pool and do those three calls for the two service methods concurrently.

On the contrary the mode kEventSingleThread assures, that on the service in- stance only one service method at a time will be called by the Communication Man- agement implementation.

That means, Communication Management implementation has to queue incoming ser- vice method call events for the same service instance and dispatch them one after the

Why did we provide those two variants? From a functional viewpoint only kEvent would have been enough! A service implementation, where certain service methods could not run concurrently, because of shared data/consistency needs, could simply do its synchronization (e.g. via std::mutex) on its own!

The reason is "efficiency". If you have a service instance implementation, which has extensive synchronization needs, i.e. would synchronize almost all service method calls anyways, it would be a total waste of resources, if the Communication Manage- ment would "spend" N threads from its thread-pool resources, which directly after get a hard sync, sending N-1 of it to sleep.

For service implementations which lie in between --- i.e. some methods can be called concurrently without any sync needs, some methods need at least partially synchro- nization --- the service implementer has to decide, whether he uses kEvent and does synchronization on top on his own (possibly optimizing latency, responsiveness of his service instance) or whether he uses kEventSingleThread, which frees him from synchronizing on his own (possibly optimizing ECU overall throughput).

### Methods

Service methods on the skeleton side are abstract methods, which have to be overwrit- ten by the service implementation sub-classing the skeleton. Let's have a look at the Adjust method of our service example:

```

/\*\*

\* For all output and non-void return parameters

\* an enclosing struct is generated, which contains

\* non-void return value and/or out parameters.

\*/

struct AdjustOutput {

bool success;

Position effective_position;

};

virtual ara::core::Future\<AdjustOutput\> Adjust(

const Position& position) = 0;

```

**Listing 5.14: Skeleton side Adjust method**

The IN-parameters from the abstract definition of the service method are directly mapped to method parameters of the skeletons abstract method signature.

In this case it's the position argument from type Position, which is --- as it is a non- primitive type --- modeled as a "const ref"[1](#_bookmark134).

The interesting part of the method signature is the return type. The implementation of the service method has to return our extensively discussed [ara::core::Future](#_bookmark36).

The idea is simple: We do not want to force the service method implementer to signal the finalization of the service method with the simple return of this "entry point" method!

Maybe the service implementer decides to dispatch the real processing of the service call to a central worker-thread pool! This would then be really ugly, when the "entry point" methods return would signal the completion of the service call to the Communi- cation Management.

Then --- in our worker thread pool scenario --- we would have to block into some kind of wait point inside the service method and wait for some notification from the worker thread, that he has finished and only then we would return from the service method.

In this scenario we would have a blocked thread inside the service-method! From the viewpoint of efficient usage of modern multi-core CPUs this is not acceptable.

The returned [ara::core::Future](#_bookmark36) contains a structure as template parameter, which ag- gregates all the OUT-parameters of the service call.

The following two code examples show two variants of an implementation of Adjust. In the first variant the service method is directly processed synchronously in the method

1[]{#_bookmark134 .anchor}The referenced object is provided by the Communication Management implementation until the service method call has set its promise (valid result or error). If the service implementer needs the

body, so that an [ara::core::Future](#_bookmark36) with an already set result is returned, while in the sec- ond example, the work is dispatched to an asynchronous worker, so that the returned [ara::core::Future](#_bookmark36) may not have a set result at return.

```

using namespace ara::com;

/\*\*

\* Our implementation of RadarService

\*/

class RadarServiceImpl : public RadarServiceSkeleton {

public:

Future\<AdjustOutput\> Adjust(const Position& position)

{

ara::core::Promise\<AdjustOutput\> promise;

// calling synchronous internal adjust function, which delivers results

struct AdjustOutput out = doAdjustInternal(

position,

&out.effective_position);

promise.set_value(out);

// we return a future from an already set promise\...

return promise.get_future();

}

private:

AdjustOutput doAdjustInternal(const Position& position) {

// \... implementation

}

}

```

**Listing 5.15: Example of returning Future with already set result**

As you see in the example above: Inside the body of the service method an internal method is called, which does the work synchronously. I.e. after the return of "doAd- justInternal" in out the attributes, which resemble the service methods out-params are set. Then this out value is set at the [ara::core::Promise](#_bookmark37) and then the [Future](#_bookmark36) created from the [Promise](#_bookmark37) is returned.

This has the effect that the caller, who gets this [Future](#_bookmark36) as return, can immediately call

Future::get(), which would not block, but immediately return the AdjustOutput.

Now let's have a look at the asynchronous worker thread variant:

```

using namespace ara::com;

/\*\*

\* Our implementation of the RadarService

\*/

class RadarServiceImpl : public RadarServiceSkeleton {

public:

Future\<AdjustOutput\> Adjust(const Position& position)

{

ara::core::Promise\<AdjustOutput\> promise;

auto future = promise.get_future();

// asynchronous call to internal adjust function in a new Thread

std::thread t(

\[this\] (const Position& pos, ara::core::Promise prom) {

prom.set_value(doAdjustInternal(pos));

},

std::cref(position), std::move(promise)).detach();

// we return a future, which might be set or not at this point\...

return future;

}

private:

AdjustOutput doAdjustInternal(const Position& position) {

// \... implementation

}

}
```

**Listing 5.16: Example of returning Future with possibly unset result**

In this example, "doAdjustInternal" is called within a different asynchronous thread. In this case we wrapped the call to "doAdjustInternal" inside a small lambda, which does the job of setting the value to the [Promise](#_bookmark37).

### One-Way aka Fire-and-Forget Methods

"One-way/fire-and-forget" methods on the server/skeleton side do have (like on the proxy side) a simpler signature compared to normal methods. Since there is no feed- back possible/needed towards the caller it is a simple void method:

virtual void LogCurrentState() = 0;

### Raising Application Errors

Whenever on the implementation side of a service method, an ApplicationError

--- according to the interface description --- is detected, the [ErrorCode](#_bookmark28) representing

this ApplicationError simply has to be stored into the [Promise](#_bookmark37), from which the [Future](#_bookmark36) is returned to the caller:

```

using namespace ara::com;

using namespace com::mycompany::division::radarservice;

/\*\*

Our implementation of the RadarService

\*/

class RadarServiceImpl : public RadarServiceSkeleton {

public:

Future\<CalibrateOutput\> Calibrate(const std::string& configuration)

{

ara::core::Promise\<CalibrateOutput\> promise;

auto future = promise.get_future();

// we check the given configuration arg

if (!checkConfigString(configuration))

{ // given arg is invalid:

// assume that in ARXMLs we have ErrorDomain with name SpecificErrors

// which contains InvalidConfigString error.

// Note that numeric error code will be casted to ara::core::ErrorCode

// implicitly.

promise.SetError(SpecificErrorsErrc::InvalidConfigString);

}

else

{ \... }

// we return a future with a potentially set exception

return future;

}

private:

bool checkConfigString(const std::string& config);

std::string curValidConfig\_;

}

```

**Listing 5.17: Returning Future with possibly set exception**

In this example, the implementation of "Calibrate" detects, that the given configuration string argument is invalid and sets the corresponding exception to the [Promise](#_bookmark37).

### Events

On the skeleton side the service implementation is in charge of notifying about occur- rence of an event. As shown in [5.12](#_bookmark127) the skeleton provides a member of an event wrapper class per each provided event. The event wrapper class on the skeleton/event provider side looks obviously different than on the proxy/event consumer side.

On the service provider/skeleton side the service specific event wrapper classes are defined within the namespace event directly beneath the namespace skeleton. Let's have a deeper look at the event wrapper for our example event BrakeEvent:

```

class BrakeEvent {

public:

/\*\*

\* Shortcut for the events data type.

\*/

using SampleType = RadarObjects;

ara::core::Result\<void\> Send(const SampleType &data);

ara::core::Result\<ara::com::SampleAllocateePtr\<SampleType\>\> Allocate();

/\*\*

\* After sending data you loose ownership and can't access

\* the data through the SampleAllocateePtr anymore.

\* Implementation of SampleAllocateePtr will be with the

\* semantics of std::unique_ptr (see types.h)

\*/

ara::core::Result\<void\> Send(ara::com::SampleAllocateePtr\<SampleType\>

 data);

};
```

**Listing 5.18: Skeleton side of BrakeEvent class**

The using directive --- analogue to the Proxy side --- just introduces the common name SampleType for the concrete data type of the event. We provide two different variants of a "Send" method, which is used to send out new event data. The first one takes a reference to a SampleType.

This variant is straight forward: The event data has been allocated somewhere by the service application developer and is given via reference to the binding implementation of [Send()](#_bookmark63).

After the call to send returns, the data might be removed/altered on the caller side. The binding implementation will make a copy in the call.

The second variant of 'Send' also has a parameter named "data", but this is now of a different type [ara::com::SampleAllocateePtr\<SampleType\>](#_bookmark65). According to our general approach to only provide abstract interfaces and eventually provide a proposed map- ping to existing C++ types (see [section](#data-type-abstractions) [4.6](#data-type-abstractions)), this pointer type that we introduce here, shall behave like a std::unique_ptr\<T\>.

That roughly means: Only one party can hold the pointer - if the owner wants to give it away, he has to explicitly do it via std::move. So what does this mean here? Why do we want to have std::unique_ptr\<T\> semantics here?

To understand the concept, we have to look at the third method within the event wrapper class first:

```

ara::com::SampleAllocateePtr\<SampleType\> Allocate();

```

The event wrapper class provides us here with a method to allocate memory for one sample of event data. It returns a smart pointer [ara::com::SampleAllocateePtr\<Sam-](#_bookmark65) [pleType\>](#_bookmark65), which points to the allocated memory, where we then can write an event data sample to. And this returned smart pointer we can then give into an upcoming call to the second version of "Send".

So --- the obvious question would be --- why should I let the binding implementation do the memory allocation for event data, which I want to notify/send to potential con- sumers? The answer simply is: Possibility for optimization of data copies.

The following "over-simplified" example makes things clearer: Let's say the event, which we talk about here (of type RadarObjects), could be quite big, i.e. it contains a vector, which can grow very large (say hundreds of kilobytes). In the first variant of "Send", you would allocate the memory for this event on your own on the heap of your own application process.

Then --- during the call to the first variant of "Send" --- the binding implementation has to copy this event data from the (private) process heap to a memory location, where it would be accessible for the consumer. If the event data to copy is very large and the frequency of such event occurrences is high, the sheer runtime of the data copying might hurt.

The idea of the combination of [Allocate()](#_bookmark64) and the second variant to send event data ( [Send(SampleAllocateePtr\<SampleType\>)](#_bookmark65)) is to eventually avoid this copy!

A smart binding implementation might implement the [Allocate()](#_bookmark64) in a way, that it al- locates memory at a location, where writer (service/event provider) and reader (ser- vice/event consumer) can both directly access it! So an [ara::com::SampleAllocateePtr](#_bookmark65)

[\<SampleType\>](#_bookmark65) is a pointer, which points to memory nearby the receiver.

Such locations, where two parties can both have direct access to, are typically called "shared memory". The access to such regions should --- for the sake of data consis- tency --- be synchronized between readers and writers.

This is the reason, that the [Allocate()](#_bookmark64) method returns such a smart pointer with the aspects of single/solely user of the data, which it points to: After the potential writer (service/event provider side) has called [Allocate()](#_bookmark64), he can access/write the data pointed to as long as he hands it over to the second send variant, where he explicitly gives away ownership!

This is needed, because after the call, the readers will access the data and need a consistent view of it.

```

[]{#_bookmark138 .anchor}using namespace ara::com;

// our implementation of RadarService - subclass of RadarServiceSkeleton

RadarServiceImpl myRadarService;

/\*\*

\* Handler called at occurrence of a BrakeEvent

\*/

void BrakeEventHandler() {

// let the binding allocate memory for event data\...

SampleAllocateePtr\<BrakeEvent::SampleType\> curSamplePtr =

myRadarService.BrakeEvent.Allocate();

// fill the event data \...

curSamplePtr-\>active = true;

fillVector(curSamplePtr-\>objects);

// Now notify event to consumers \...

myRadarService.BrakeEvent.Send(std::move(curSamplePtr));

// Now any access to data via curSamplePtr would fail -

// we've given up ownership!

}

```

**Listing 5.19: Event Allocate/Send sample**

### Fields

On the skeleton side the service implementation is in charge of

- updating and notifying about changes of the value of a field.
- serving incoming [Get()](#_bookmark56) calls.
- serving incoming [Set()](#_bookmark57) calls.

As shown in [5.12](#_bookmark127) the skeleton provides a member of a field wrapper class per each provided field. The field wrapper class on the skeleton/field provider side looks obvi- ously different than on the proxy/field consumer side.

On the service provider/skeleton side the service specific field wrapper classes are de- fined within the namespace fields directly beneath the namespace skeleton. Let's have a deeper look at the field wrapper in case of our example event UpdateRate:

```

class UpdateRate {

public:

using FieldType = uint32_t;

/\*\*

\* Update equals the send method of the event. This triggers the

\* transmission of the notify (if configured) to

\* the subscribed clients.

\*

\* In case of a configured Getter, this has to be called at least

\* once to set the initial value.

\*/

ara::core::Result\<void\> Update(const FieldType& data);

/\*\*

\* Registering a GetHandler is optional. If registered the function

\* is called whenever a get request is received.

\*

\* If no Getter is registered ara::com is responsible for responding

\* to the request using the last value set by update.

\*

\* This implicitly requires at least one call to update after

\* initialization of the Service, before the service

\* is offered. This is up to the implementer of the service.

\*

\* The get handler shall return a future.

\*/

ara::core::Result\<void\> RegisterGetHandler(std::function\<ara::core::

 Future\<FieldType\>()\> getHandler);

/\*\*

\* Registering a SetHandler is mandatory, if the field supports it.

\* The handler gets the data the sender requested to be set.

\* It has to validate the settings and perform an update of its

\* internal data. The new value of the field should than be set

\* in the future.

\* The returned value is sent to the requester and is sent via notification to all subscribed entities.

\*/

ara::core::Result\<void\> RegisterSetHandler(std::function\<ara::core::

 Future\<FieldType\>(const FieldType& data)\> setHandler);

};

```

**Listing 5.20: Skeleton side UpdateRate Class**

The using directive --- again as in the Event Class and on the Proxy side --- just intro- duces the common name FieldType for the concrete data type of the field.

We provide an [Update](#_bookmark69) method by which the service implementer can update the cur- rent value of the field.

It is very similar to the simple/first variant of the [Send](#_bookmark63) method of the event class: The field data has been allocated somewhere by the service application developer and is given via reference to the binding implementation of [Update](#_bookmark69). After the call to [Update](#_bookmark69) returns, the data might be removed/altered on the caller side.

The binding implementation will make a (typically serialized) copy in the call.

In case "on-change-notification" is configured for the field, notifications to subscribers of this field will be triggered by the binding implementation in the course of the [Update](#_bookmark69) call.

### Registering Getters

The [RegisterGetHandler](#_bookmark67) method provides the possibility to register a method imple- mentation by the service implementer, which gets then called by the binding imple- mentation on an incoming [Get()](#_bookmark56) call from any proxy instance.

The [RegisterGetHandler](#_bookmark67) method in the generated skeleton does **only** exist in case availability of "field getter" has been configured for the field in the IDL!

Registration of such a "GetHandler" is fully optional! Typically there is no need for a service implementer to provide such a handler. The binding implementation always has access to the latest value, which has been set via [Update](#_bookmark69). So any incoming [Get()](#_bookmark56) call can be served by the Communication Management implementation standalone.

A theoretical reason for a service implementer to still provide a "GetHandler" could be: Calculating the new/current value of a field is costly/time consuming. Therefore the service implementer/field provider wants to defer this process until there is really need for that value (indicated by a getter call). In this case he could calculate the new field value within its "GetHandler" implementation and give it back via the known [ara::com](#_bookmark15) promise/future pattern.

If you look at the bigger picture, then such a setup with the discussed intention, where the service implementer provides and registers a "GetHandler" will not really make sense, if the field is configured with "on-change-notification", too.

In this case, new subscribers will get potentially outdated field values on subscription, since updating of the field value is deferred to the explicit call of a "GetHandler".

You also have to keep in mind: In such a setup, with enabled "on-change-notification" together with a registered "GetHandler" the Communication Management implemen- tation will **not** automatically care for, that the value the developer returns from the "GetHandler" will be synchronized with value, which subscribers get via "on-change- notification" event!

If the implementation of "GetHandler" does not internally call [Update()](#_bookmark69) with the same value, which it will deliver back via [ara::com](#_bookmark15) promise, then the field value delivered via "on-change-notification" event will differ from the value returned to the [Get()](#_bookmark56) call.

I.e. the Communication Management implementation will not automatically/internally call [Update()](#_bookmark69) with the value the "GetHandler" returned.

Bottom line: Using [RegisterGetHandler](#_bookmark67) is rather an exotic use case and developers should be aware of the intrinsic effect.

Additionally a user provided "GetHandler", which only returns the current value, which has already been updated by the service implementation via [Update()](#_bookmark69), is typically very inefficient! The Communication Management then has to call to user space and to additionally apply field serialization of the returned value at any incoming [Get()](#_bookmark56) call.

Both things could be totally "optimized away" if the developer does not register a "GetH- andler" and leaves the handling of [Get()](#_bookmark56) calls entirely to the Communication Manage- ment implementation.

### Registering Setters

Opposed to the [RegisterGetHandler](#_bookmark67) the [RegisterSetHandler](#_bookmark68) API has to be called by the service implementer in case it exists (i.e. field has been configured with setter support).

The reason, that we decided to make the registration of a "SetHandler" mandatory is simple: We expect, that the server implementation will always need to check the validity of a new/updated field values set by any anonymous client.

A look at the signature of the "SetHandler" std::function\<ara::core::Fu- ture\<FieldType\>(const FieldType& data)\> reveals that the registered han- dler does get the new value as input argument and is expected to return also a value. The semantic behind this is: In case the "SetHandler" always has to return the effec- tive (eventually replaced/corrected) value. This allows the service side implementer to validate/overrule the new field value provided by a client.

The effective field value returned by the "SetHandler" is implicitly taken over by the Communication Management implementation as if the service implementer had called [Update()](#_bookmark69) explicitly with the effective value on its own. That means: An explicit [Update()](#_bookmark69) call within the "SetHandler" is superfluous as the Communication Management would

### Ensuring existence of "SetHandler"

The existence of a registered "SetHandler" is ensured by an [ara::com](#_bookmark15) compliant im- plementation by returning a recoverable error: If a developer calls [OfferService()](#_bookmark61) on a skeleton implementation and had not yet registered a "SetHandler" for each of its fields, which has setter enabled, the Communication Management implementation shall re- turn an [Error](#_bookmark27) (ComErrc::kSetHandlerNotSet) indicating this error in the [ara::-](#_bookmark35) [core::Result](#_bookmark35).

### Ensuring existence of valid Field values

Since the most basic guarantee of a field is, that it has a valid value at any time, [ara::com](#_bookmark15) has to somehow ensure, that a service implementation providing a field has to provide a value **before** the service (and therefore its field) becomes visible to potential consumers, which --- after subscription to the field --- expect to get initial value notification event (if field is configured with notification) or a valid value on a Get call (if getter is enabled for the field).

An [ara::com](#_bookmark15) Communication Management implementation needs therefore behave in the following way: If a developer calls [OfferService()](#_bookmark61) on a skeleton implementation and had not yet called [Update()](#_bookmark69) on any field, which

- has notification enabled
- or has getter enabled but not yet a "GetHandler" registered

the Communication Management implementation shall return an [Error](#_bookmark27) (ComErrc::- kFieldValueIsNotValid) indicating this error in the [ara::core::Result](#_bookmark35).

Note: The AUTOSAR meta-model supports the definition of such initial values for a field in terms of a so called [FieldSenderComSpec](#_bookmark74) of a [PPortPrototype](#_bookmark75). So this model element should be considered by the application code calling [Update()](#_bookmark69).

### Access to current field value from Get/SetHandler

Since the underlying field value is only known to the middleware, the current field value is not accessible from the "Get/SetHandler" implementation, which are on ap- plication level. If the "Get/SetHandler" needs to read the current field value, the skeleton implementation must provide a field value replica accessible from applica- tion level.

### Triggers

As in [subsection](#triggers) [5.3.8](#triggers), Triggers are based on Events, but without containing any data. Focusing on the difference from Skeleton side, only [Send()](#_bookmark63) is different from

Events. Other Event APIs aren't necessary as they relate to data which is not present for Triggers.

```
ara::core::Result\<void\> Send();

```

This will simply send out a Trigger.

No allocation is necessary due to the fact that Triggers have no data.

## Data Types on Service Interface level

The following chapter describes the C++ language mapping in [ara::com](#_bookmark15) of the [SI](#_bookmark71) specific (\"user defined\") data types. \"user defined\" here means, that those data types aren't defined/mandated by [ara::com](#_bookmark15) API itself like e.g. [InstanceIdentifier](#_bookmark31), Find- ServiceHandle, ServiceHandleContainer or any other data type defined by [ara::com](#_bookmark15) in its own namespace, but are specifically provided by the user defined [SI](#_bookmark71) description (IDL).

In the AUTOSAR Meta-Model (\[[2](#_bookmark1)\]) [CppImplementationDataType](#_bookmark76)s have been intro- duced to support the specifics of the C++14 data type system appropriately.

### Optional data elements

Record elements inside a StructureImplementationDataType can be defined as optional inside the meta-model, see \[[2](#_bookmark1)\].

This optionality is represented in the [ara::com](#_bookmark15) API by the template class [ara::core::-](#_bookmark38) [Optional](#_bookmark38). The serialization of such record elements is based on the Tag-Length-Value principle whereas StructureImplementationDataTypes without optional record elements do not have to make use of tags.

Details on how this serialization works is specified in \[[9](#_bookmark8)\].

The [ara::core::Optional](#_bookmark38) template parameter has the ImplementationDataType

(also ApplicationDataTypes are possible) of the record element e.g. uint32.

Optional record elements can be used in structures for every [SI](#_bookmark71) element (e.g. Fields, Events and Methods). This optionality is defined on the [SI](#_bookmark71) level.

The structure in [5.21](#_bookmark148) has the optional declared elements current and health. These elements are not mandatory present.

The consuming application has to check whether the optional elements contain a value or not during runtime. If an optional element contains a value or not depends on the providing application.

The providing application may set the value or not for this specific instance. The feature of optional contained elements provides forward and backward compatibility of the [SI](#_bookmark71)

```

[]{#_bookmark148 .anchor}/\*\*

\* \\brief Data structure with optional contained values.

\*/

struct BatteryState {

Voltage_t voltage;

Temperature_t temperature;

ara::core::Optional\<Current_t\> current;

ara::core::Optional\<Health\> health;

};

```

**Listing 5.21: Definition of BatteryState**

The Skeleton implementation in [5.22](#_bookmark149) provides the BatteryState structure defined in [5.21](#_bookmark148).

The implementation is aware of the optional labeled element current but not of the optional labeled element health due to a new version of the [SI](#_bookmark71). Therefore health is not set by the Skeleton implementation.

```

[]{#_bookmark149 .anchor}using namespace ara::com;

class BatteryStateImpl : public BatteryStateSkeleton {

public:

Future\<BatteryState\> GetBatteryState() {

// no asynchronous call for simplicity

ara::core::Promise\<BatteryState\> promise;

// fill the data structure

BatteryState state;

state.voltage = 14;

state.temperature = 35;

state.current = 0;

// state.health is not set and therefore it is not transmitted

promise.set_value(state);

auto future = promise.get_future();

return future;

}

}

```

**Listing 5.22: Handling of optional data elements on Skeleton side**

The Proxy in [5.23](#_bookmark150) consumes the BatteryState structure defined in [5.21](#_bookmark148).

The implementation is aware of both optional labeled elements current and health. Before accessing the value of the optional elements the implementation has to check whether there is really a value contained. Therefore the optional API provides two methods: The operator bool and the has_value method.

```

[]{#_bookmark150 .anchor}using namespace ara::com;

int main() {

// some code to acquire handle

// \...

BatteryStateProxy bms_service(handle);

Future\<BatteryState\> stateFuture = bms_service.GetBatteryState();

// Receive BatteryState

BatteryState state = stateFuture.get();

// Check the optional contained elements for presence

if(state.current) {

//Access the value of the optional element with the optional::operator\*

if(\*state.current \>= MAX_CURRENT) {

// do something with this information

}

}

// Check with optional::has_value() method

if(state.health.has_value()){

// Access the value of the optional element with the optional::value() method

if(state.health.value() \>= BAD_HEALTH) {

// do something with this information

}

}

}

```

**Listing 5.23: Handling of optional data elements on Proxy side**

2. ## Raw Data Streaming Interface

   1. ### Introduction

The Adaptive AUTOSAR Communication Management is based on Service Oriented communication. This is good for implementing platform independent and dynamic ap- plications with a service-oriented design.

For ADAS applications, it is important to be able to transfer raw binary data streams over Ethernet efficiently between applications and sensors, where service oriented communication (e.g. SOME/IP, DDS) either creates unnecessary overhead for efficient communication, or the sensors do not even have the possibility to send anything but raw binary data.

The Raw Data Binary Stream API provides a way to send and receive Raw Binary Data Streams, which are sequences of bytes, without any data type. They enable efficient communication with external sensors in a vehicle (e.g. sensor delivers video and map data in \"Raw data\" format). The communication is performed over a network using sockets.

From the ara::com architecture point of view, Raw Data Streaming API is static, i.e. its is not generated. It is part of the ara::com namespace, but is independent of the ara::com middleware services.

### Functional description

The Raw Data Binary Stream API can be used in both the client or the server side. The functionality of both client and server allow to send and receive. The only difference is that the server can wait for connections but cannot actively connect to a client. On the other side, the client can connect to a server (that is already waiting for connections) but the client cannot wait for connections.

The usage of the Raw Data Binary Streams API from Adaptive Autosar must follow this sequence:

- As client

  1. Connect: Establishes connection to sensor (not needed for UDP)
  2. ReadData/WriteData: Receives or sends data
  3. Shutdown: Connection is closed.
- As server

  1. WaitForConnection: Waits for incoming connections from clients (not needed for UDP)
  2. ReadData/WriteData: Receives or sends data
  3. Shutdown: Connection is closed and stops waiting for connections.

     1. ### Class and Model

        1. ### Class and signatures

The class [ara::com::raw](#_bookmark16) defines a RawDataStream class for reading and writing binary data streams over a network connection using sockets. The client side is an object of the class [ara::com::raw::RawDataStreamClient](#_bookmark17) and the server side is [ara::com::raw::-](#_bookmark18) [RawDataStreamServer](#_bookmark18)

### Constructor

The constructor takes as input the instance specifier qualifying the network binding and parameters for the instance.

```
 RawDataStreamClient(const ara::com::InstanceSpecifier\\& instance); RawDataStreamServer(const ara::com::InstanceSpecifier\\& instance);
```

### Destructor

Destructor of RawDataStream. If the connection is still open, it will be shut down before destroying the RawDataStream object.Destructor of RawDataStream. If the connection is still open, it will be shut down before destroying the RawDataStream object.

```
 \~RawDataStreamClient();

 \~RawDataStreamServer();

```

### Manifest Model

The manifest defines the parameters of the Raw Data Stream deployment on the net- work.

The [RawDataStreamMapping](#_bookmark19) defines the actual transport that raw data uses in the sub-classes of [EthernetRawDataStreamMapping](#_bookmark20). It also defines which local- and re- mote network endpoints (IP addresses) and ports to use for the communication, and if unicast or multicast is used.

In principle, Raw Data Streaming can use any transport protocol but currently only TCP and UDP are supported.

The local IP address is defined in the attribute communicationConnector (type EthernetCommunicationConnector), and the protocol and port is defined in the following attributes of the sub-class [EthernetRawDataStreamMapping](#_bookmark20) with type Pos- itiveInteger:

- localTcpPort
- localUdpPort

At least one of the two previous attributes has to be defined. The socketOption attribute allows to specify non-formal socket options that might only be valid for specific platforms. This is defined as an array of strings and the possible values are platform and vendor specific.

Remote credentials for the different use cases are defined in attributes RawDataS- treamUdpCredentials and RawDataStreamUdpTcpCredentials. See TPS Manifest \[[2](#_bookmark1)\] for details.

The [EthernetRawDataStreamMapping](#_bookmark20) also has an attribute regarding security, where TLS secure communication properties for the Raw Data Stream connection can be defined:

- tlsSecureComProps

  1. ### Methods of class RawDataStream

Detailed information about the methods of [ara::com::raw::RawDataStream](#_bookmark16) can be found in chapter Raw Data Stream API of \[[1](#_bookmark0)\].

### Timeout parameter

All Connect/WaitForConnection/Read/Write methods of RawDataStream clients and servers have an optional input parameter for the timeout. This argument defines the timeout of the method in milliseconds. The type is std::chrono::milliseconds.

If timeout is 0 or not specified the operation will block until it returns.

If timeout is specified is \> 0 the method call will return a timeout error if the time to perform the operation exceeds the timeout limit.

### Methods

The API methods are synchronous, so they will block until the method returns or until timeout is reached.

### WaitForConnection

This method is available only in the server side of the Raw Data Stream.

The server side of the Raw Data Stream is ready to be connected from a client. No connection from clients can be established until this method is called in the server. It is only used if TCP is used. For UDP this operation will do nothing.

### Connect

This method is available only in the client side of the Raw Data Stream.

This method initializes the socket and establishes a connection to the TCP server. In the case of UDP, no connection needs to be established, and the operation will do nothing. Incoming and outgoing packets are restricted to the specified local and remote

The socket configurations are specified in the manifest which is accessed through the InstanceSpecifer provided in the constructor.

```
 ara::core:Result\<void\> Connect();

 ara::core:Result\<void\> Connect(std::chrono::milliseconds timeout);
```

### Shutdown

This method shuts down communication. It is available from both client and server sides of the Raw Data Stream.

```
 ara::core:Result\<void\> Shutdown();
```

### ReadData

This method reads bytes from the socket connection. The maximum number of bytes to read is provided with the parameter length. The timeout parameter is optional.

```

 ara::core::Result\<ReadDataResult\> ReadData(size_t length); ara::core::Result\<ReadDataResult\> ReadData(

 size_t length, std::chrono::milliseconds timeout);

```

If the operation worked, it returns a struct with a pointer to the memory containing the read data and the actual number of read bytes.

```

 struct ReadDataResult{

 std::unique_ptr\<ara::core::Byte\[\]\> data; size_t numberOfBytes;

 }

```

In case of an error it retuns an ara::Core::ErrorCode from ara::com::RawEr- rorDomain:

- Stream Not Connected: If the connection is not yet established (TCP only).
- Interrupted By Signal: The operation was interrupted by the system.
- Communication Timeout: No data was read until the timeout expiration.

  1. ### WriteData

This method writes bytes to the socket connection. The data is provided as a buffer with the data parameter. The number of bytes to write is provided in the length parameter. An optional timeout parameter can also be used.

ara::core:Result\<size_t\> WriteData( std::unique_ptr\<ara::core::Byte\[\]\> data, size_t length);

ara::core:Result\<size_t\> WriteData( std::unique_ptr\<ara::core::Byte\[\]\> data, size_t length, std::chrono::milliseconds timeout);

If the operation worked, it will return the actual number of bytes written. In case of an error, it will return a ara::Core::ErrorCode:

- Stream Not Connected: If the connection is not yet established (TCP only).
- Interrupted By Signal: The operation was interrupted by the system.
- Communication Timeout: No data was written until the timeout expiration.

### Security

Raw Data Stream communication can be transported using TCP and UDP. Therefore different security mechanisms have to be available to secure the stream communica- tion. Currently the security protocols TLS, DTLS, IPSec and MACsec are available.

Access control to Raw Data Streams can also be defined by the IAM.

All security functions are configurable in the deployment and mapping model of Raw Data Streaming Interface.

If sensor data must fulfill security requirements, security extensions have to be used.

### Safety

The RawDataStream interface only transmits raw data without any data type informa- tion. Therefore Raw Data Stream interface cannot provide any data protection, such as E2E protection. If it is required it must be implemented in the application that uses the RawDataStream interface.

### Hints for implementers

Implementation of Raw Data Streaming interface should be independent from the un- derlying Sockets API (e.g. POSIX Sockets).

1. ## Communication Groups

   1. ### Objective

The Communication Group (CG) is a composite service template defined by AUTOSAR. It provides a communciation framework which allows to communicate peer to peer and in broadcast mode between AUTOSAR applications. The Communication Group has one server and multiple clients. The server sends messages to the clients in peer to peer and or in broadcast mode. The clients can response to a message. The server of a Communication Groups knows all clients connected to the Communication Group by any time. Therefore, the server can directly communicate to a certain client.

![](./media/image13.png)

**Figure 5.3: Communication Group Abstract for State Management**

### Realization

The Communication Group provides two ServiceInterfaces.

- A dedicated Server ServiceInterface with the category value [COMMUNI-](#_bookmark21) [CATION_GROUP_SERVER](#_bookmark21), implemented as Skeleton.
- A dedicated Client ServiceInterface with the category value [COMMUNI-](#_bookmark22) [CATION_GROUP_CLIENT](#_bookmark22), implemented as Proxy.

A Communcation Group server connects to the Communcation Group using the Ser- vice Proxy of the Server ServiceInterface and a Communcation Group client con- nects to the Communication Group using the Service Skeleton of the Client Servi- ceInterface. See also the figure below.

![](./media/image27.png)

**Figure 5.4: Communication Group**

Note: Message types of a Communciation Group are defined with the Communciation Group meta-model, see also following chapters.

### Usage Scope

The initial usage of the Communcation Group has been Adaptive State Management applications. The SWS_StateManagement \[[4](#_bookmark3)\] specification has defined two Com- munication Groups, named: [PowerMode](#_bookmark72) and [DiagnosticReset](#_bookmark73). The usage scope of the State Management Communication Groups are applications within a machine only. But from design point of view, a Communication Group supports the connection of local and remote applications (CP and AP). The figure below presents a local and remote scenarios for Communication Groups.

![](./media/image28.png){width="5.2858967629046365in" height="2.487082239720035in"}

**Figure 5.5: Communication Group within a Vehicle**

2. ### Special Topics

   1. []{#5.7.4.1_Architecture .anchor}**Architecture**

As before described the Communcation Group contains

- only one Service Skeleton instantiation of type Communication Group server ( ServiceInterface with the category value [COMMUNICATION_GROUP\_-](#_bookmark21) [SERVER](#_bookmark21)).

Note: Today there is the constraint that only one Communication server can con- nect to the Communication Group server ServiceInterface.

- multiple Service Proxy instantiations of type Communication Group client( ServiceInterface with the category value [COMMUNICATION_GROUP\_-](#_bookmark22) [CLIENT](#_bookmark22)).

Note: The number of Service Proxy instantiations is implementation and use case dependent. The theoretical limit (not considering for memory space re- quirements) is the available number of Communication client *Client_IDs*. On the other side there might be Safety requirements which force the design to support a limited known number of Communication Group clients.

### Remote Connection

As mentioned before the Communication Group server or clients can be remote from the Communication Group instance. This is supported since the Communication Group is designed as composite service. Therefore also no limit in terms of AUTOSAR Classic and Adaptive platforms.

### Service Versioning

Service contract versioning is supported by the Communication Group by the according

ServiceInterfaces.

# Tutorials

This selection of tutorials shows some minimal examples on how to use the fundamen- tals and features of ara::com.

## Usage of Service Interfaces

The [ara::com](#_bookmark15) model elements related to both design and deployment are included in the Manifest. Since not all the model elements are relevant in all the development phases, the Manifest can be divided in different partitions:

- **Machine Manifest:** Specifies where the Adaptive AUTOSAR Software Stack is running. In the MachineDesign the Communication System structure is speci- fied. This includes CommunicationConnectors and NetworkEndpoints.
- [**SI**](#_bookmark71) **Manifest:** Specifies the events, methods and fields that a Service provides.
- **Execution Manifest:** Specifies the information related to the deployment of the applications. This includes Executables and Processes. The executable refer- ences an rootSwComponentPrototype.
- **RPortPrototypes and PPortPrototypes:** The rootSwComponentPrototype has an Application Type that defines PPortPrototypes and RPortProto- types and they reference the corresponding [SI](#_bookmark71)

For all the details about the manifest specification please see the \[[2](#_bookmark1)\].

Assuming that the previously mentioned partitions of the Manifest exist, the following sections describe the deployment of [SI](#_bookmark71) and ServiceInstance. Finally the most relevant aspects related with the implementation are also introduced.

### Service Interface Deployment

The [SI](#_bookmark71) Deployment describes how the [SI](#_bookmark71) will communicate over the network. The following information must be provided:

- Reference to the network binding used in the [SI](#_bookmark71) Deployment (e.g. SOME/IP, DDS)
- [SI](#_bookmark71) ID
- Deployment information for the Events, Methods and Fields. This includes IDs and any Network Binding specific information (e.g. Transport Protocol)

```

 **\<AR-PACKAGE\>**

 **\<SHORT-NAME\>**ServiceInterfaceDeployments**\</SHORT-NAME\>**

 **\<ELEMENTS\>**

 **\<SOMEIP-SERVICE-INTERFACE-DEPLOYMENT\>**

 **\<EVENT-DEPLOYMENTS\>**

 **\<SOMEIP-EVENT-DEPLOYMENT\>**

 **\<SHORT-NAME\>**Counter_SOMEIP**\</SHORT-NAME\>**

 **\<EVENT-REF DEST=**\"VARIABLE-DATA-PROTOTYPE\"**\>**/myExample/

 ServiceInterfaces/myInterface/Counter**\</EVENT-REF\>**

 **\<EVENT-ID\>**1**\</EVENT-ID\>**

 **\<TRANSPORT-PROTOCOL\>**UDP**\</TRANSPORT-PROTOCOL\>**

 **\</SOMEIP-EVENT-DEPLOYMENT\>**

 **\</EVENT-DEPLOYMENTS\>**

 **\<SERVICE-INTERFACE-REF DEST=**\"SERVICE-INTERFACE\"**\>**/myExample/

 ServiceInterfaces/myInterface**\</SERVICE-INTERFACE-REF\>**

 **\<SERVICE-INTERFACE-ID\>**99**\</SERVICE-INTERFACE-ID\>**

 **\<SERVICE-INTERFACE-VERSION\>**

 **\<MAJOR-VERSION\>**1**\</MAJOR-VERSION\>**

 **\<MINOR-VERSION\>**0**\</MINOR-VERSION\>**

 **\</SERVICE-INTERFACE-VERSION\>**

 **\</SOMEIP-SERVICE-INTERFACE-DEPLOYMENT\>**

 **\</ELEMENTS\>**

 **\</AR-PACKAGE\>**

 **Listing 6.1: Example Service Interface Deployment**

```

![](./media/image29.png)![](./media/image29.png)+methodDeployment

![](./media/image30.png)![](./media/image33.png)+fieldDeployment

![](./media/image34.png)+eventDeployment

![](./media/image35.png)0..\*

**Figure 6.1:** []{#_bookmark175 .anchor}**SOME/IP Service Insterface Deployment**

### Service Instance Deployment

The Service Instance Deployment consists of Service Instance mapping to Application Endpoints and to Machine.

The mapping to ApplicationEndpoints connects a ServiceInstance to a

PortPrototype and Process.

```

 **\<AR-PACKAGE\>**

 **\<SHORT-NAME\>**ServiceInstanceToPortPrototypeMappings**\</SHORT-NAME\>**

 **\<ELEMENTS\>**

 **\<SERVICE-INSTANCE-TO-PORT-PROTOTYPE-MAPPING\>**

 **\<SHORT-NAME\>**ProvidedServiceInstance_toPort**\</SHORT-NAME\>**

 **\<PORT-PROTOTYPE-IREF\>**

 **\<CONTEXT-ROOT-SW-COMPONENT-PROTOTYPE-REF DEST=**\"ROOT-SW-COMPONENT-

 PROTOTYPE\"**\>**/myExample/Executables/myExecutable/ mySwComponentPrototype**\</CONTEXT-ROOT-SW-COMPONENT-PROTOTYPE-REF\>**

 **\<TARGET-PORT-PROTOTYPE-REF DEST=**\"P-PORT-PROTOTYPE\"**\>**/apd/

 AdaptiveApplicationSwComponentTypes/Publisher/myInterface_PPort**\<**

 **/TARGET-PORT-PROTOTYPE-REF\>**

 **\</PORT-PROTOTYPE-IREF\>**

 **\<PROCESS-REF DEST=**\"PROCESS\"**\>**/apd/Machines/PublisherMachine/ Processes/myProcess**\</PROCESS-REF\>**

 **\<SERVICE-INSTANCE-REF DEST=**\"PROVIDED-SOMEIP-SERVICE-INSTANCE\"**\>**/

 myExample/Machines/myMachine/ServiceInstances/ ProvidedSomeipServiceInstance**\</SERVICE-INSTANCE-REF\>**

 **\</SERVICE-INSTANCE-TO-PORT-PROTOTYPE-MAPPING\>**

 **\</ELEMENTS\>**

 **\</AR-PACKAGE\>**

 **Listing 6.2: Example Service Interface Manifest**

 +portPrototype

 «instanceRef,atpUriDef»

 0..1

 +processDesign

«atpUriDef»

 0..1

 0..1

+serviceInstance

0..1

+serviceInterfaceDeployment

0..1

 **Figure 6.2: Service Instance to Port Prototype Mapping**

 The mapping to a Machine connects the ServiceInstance to a Communication- Connector.

 **\<AR-PACKAGE\>**

 **\<SHORT-NAME\>**ServiceInstanceToMachineMappings**\</SHORT-NAME\>**

 **\<ELEMENTS\>**

 **\<SOMEIP-SERVICE-INSTANCE-TO-MACHINE-MAPPING\>**

 **\<SHORT-NAME\>**ProvidedServiceInstance_toMachine**\</SHORT-NAME\>**

 **\<COMMUNICATION-CONNECTOR-REF DEST=**\"ETHERNET-COMMUNICATION-CONNECTOR

 \"**\>**/myExample/MachineDesigns/myMachineDesign/myConnector**\</ COMMUNICATION-CONNECTOR-REF\>**

 **\<SERVICE-INSTANCE-REFS\>**

 **\<SERVICE-INSTANCE-REF DEST=**\"PROVIDED-SOMEIP-SERVICE-INSTANCE\"**\>**/

 myExample/Machines/myMachine/ServiceInstances/ ProvidedSomeipServiceInstance**\</SERVICE-INSTANCE-REF\>**

 **\</SERVICE-INSTANCE-REFS\>**

 **\</SOMEIP-SERVICE-INSTANCE-TO-MACHINE-MAPPING\>**

 **\</ELEMENTS\>**

 **\</AR-PACKAGE\>**

 **Listing 6.3: Example Service Instance to Machine Mapping**

![](./media/image32.png)

+serviceInstance

0..\*

+serviceInterfaceDeployment

0..1

 **Figure 6.3: Service InstanceToMachineMapping**

 The CommunicationConnector references a NetworkEndpoint that includes Ad- dress, Network Mask and Gateway.

 **\<AR-PACKAGE\>**

 **\<SHORT-NAME\>**CommunicationClusters**\</SHORT-NAME\>**

 **\<ELEMENTS\>**

 **\<ETHERNET-CLUSTER\>**

 **\<SHORT-NAME\>**myNet**\</SHORT-NAME\>**

 **\<ETHERNET-CLUSTER-VARIANTS\>**

 **\<ETHERNET-CLUSTER-CONDITIONAL\>**

 **\<PHYSICAL-CHANNELS\>**

 **\<ETHERNET-PHYSICAL-CHANNEL\>**

 **\<SHORT-NAME\>**myChannel**\</SHORT-NAME\>**

 **\<COMM-CONNECTORS\>**

 **\<COMMUNICATION-CONNECTOR-REF-CONDITIONAL\>**

 **\<COMMUNICATION-CONNECTOR-REF DEST=**\"ETHERNET-COMMUNICATION-

 CONNECTOR\"**\>**/myExample/MachineDesigns/myMachineDesign/ myConnector**\</COMMUNICATION-CONNECTOR-REF\>**

 **\</COMMUNICATION-CONNECTOR-REF-CONDITIONAL\>**

 **\</COMM-CONNECTORS\>**

 **\<NETWORK-ENDPOINTS\>**

 **\<NETWORK-ENDPOINT\>**

 **\<SHORT-NAME\>**myMachineEndpoint**\</SHORT-NAME\>**

 **\<FULLY-QUALIFIED-DOMAIN-NAME/\>**

 **\<NETWORK-ENDPOINT-ADDRESSES\>**

 **\<IPV-4-CONFIGURATION\>**

 **\<DEFAULT-GATEWAY\>**192.168.7.1**\</DEFAULT-GATEWAY\>**

 **\<IPV-4-ADDRESS\>**192.168.7.2**\</IPV-4-ADDRESS\>**

 **\<NETWORK-MASK\>**255.255.255.0**\</NETWORK-MASK\>**

 **\</IPV-4-CONFIGURATION\>**

 **\</NETWORK-ENDPOINT-ADDRESSES\>**

 **\</NETWORK-ENDPOINT\>**

 **\<SHORT-NAME\>**mySDEndpoint**\</SHORT-NAME\>**

 **\<FULLY-QUALIFIED-DOMAIN-NAME/\>**

 **\<NETWORK-ENDPOINT-ADDRESSES\>**

 **\<IPV-4-CONFIGURATION\>**

 **\<IPV-4-ADDRESS\>**224.244.224.245**\</IPV-4-ADDRESS\>**

 **\</IPV-4-CONFIGURATION\>**

 **\</NETWORK-ENDPOINT-ADDRESSES\>**

 **\</NETWORK-ENDPOINT\>**

 **\</NETWORK-ENDPOINTS\>**

 **\</ETHERNET-PHYSICAL-CHANNEL\>**

 **\</PHYSICAL-CHANNELS\>**

 **\</ETHERNET-CLUSTER-CONDITIONAL\>**

 **\</ETHERNET-CLUSTER-VARIANTS\>**

 **\</ETHERNET-CLUSTER\>**

 **\</ELEMENTS\>**

 **\</AR-PACKAGE\>**

 ![](./media/image38.png){width="0.154086832895888in" height="7.999890638670167e-2in"}**Listing 6.4: Example Service Interface Manifest**

+----------------------------------------------+---------------------------+------------------------------------------------------------+
| *AtpStructureElement*                        | > +communicationConnector | > *Identifiable*                                           |
|                                              |                           | >                                                          |
| *FibexElement*                               |                           | > *CommunicationConnector*                                 |
|                                              |                           |                                                            |
| > MachineDesign                              |                           |                                                            |
+==============================================+===========================+============================================================+
|                                              |                           | \+ createEcuWakeupSource: Boolean \[0..1\]                 |
|                                              |                           |                                                            |
|                                              |                           | \+ pncFilterArrayMask: PositiveInteger \[0..\*\] {ordered} |
+----------------------------------------------+---------------------------+------------------------------------------------------------+
| \+ accessControl: AccessControlEnum \[0..1\] | > «atpSplitable» 0..\*    |                                                            |
|                                              |                           |                                                            |
| \+ pncPrepareSleepTimer: TimeValue \[0..1\]  |                           |                                                            |
|                                              |                           |                                                            |
| \+ pnResetTimer: TimeValue \[0..1\]          |                           |                                                            |
+----------------------------------------------+---------------------------+------------------------------------------------------------+

 ![](./media/image39.png)![](./media/image43.png)EthernetCommunicationConnector

 \+ maximumTransmissionUnit: PositiveInteger \[0..1\]

 \+ neighborCacheSize: PositiveInteger \[0..1\]

 \+ pathMtuEnabled: Boolean \[0..1\]

 \+ pathMtuTimeout: TimeValue \[0..1\]

 ![](./media/image44.png)«atpVariation,atpSplitable»

 +physicalChannel 1..\*

 *Identifiable*

+unicastNetworkEndpoint

NetworkEndpoint

 0..\*

 *Identifiable*

*PhysicalChannel*

 \+ fullyQualifiedDomainName: String \[0..1\]

 \+ priority: PositiveInteger \[0..1\]

0..\*

 +networkEndpoint

 «atpSplitable»

 +networkEndpointAddress 1..\*

 EthernetPhysicalChannel *NetworkEndpointAddress*

Ipv4Configuration

 \+ assignmentPriority: PositiveInteger \[0..1\]

 \+ defaultGateway: Ip4AddressString \[0..1\]

 \+ dnsServerAddress: Ip4AddressString \[0..\*\]

 \+ ipAddressKeepBehavior: IpAddressKeepEnum \[0..1\]

 \+ ipv4Address: Ip4AddressString \[0..1\]

 \+ ipv4AddressSource: Ipv4AddressSourceEnum \[0..1\]

 \+ networkMask: Ip4AddressString \[0..1\]

 \+ ttl: PositiveInteger \[0..1\]

 Ipv6Configuration

 \+ assignmentPriority: PositiveInteger \[0..1\]

 \+ defaultRouter: Ip6AddressString \[0..1\]

 \+ dnsServerAddress: Ip6AddressString \[0..\*\]

 \+ enableAnycast: Boolean \[0..1\]

 \+ hopCount: PositiveInteger \[0..1\]

 \+ ipAddressKeepBehavior: IpAddressKeepEnum \[0..1\]

 \+ ipAddressPrefixLength: PositiveInteger \[0..1\]

 \+ ipv6Address: Ip6AddressString \[0..1\]

 \+ ipv6AddressSource: Ipv6AddressSourceEnum \[0..1\]

 **Figure 6.4: Network Connection**

```

### Service Implementation

Services are implemented in an application layer and are also used by the other applications. To enable the communication be- tween both applications the Service Discovery protocol is used.

**Figure 6.5: Service Discovery**

The Communication Management provides a method in the Service Skeleton class to offer the service:

```
 ara::core::Result\<void\> OfferService();
```

After the method OfferService() has been called, the service can be found by the applications. The Communication Management provides in the Service Proxy class a methods to find a service according to the [InstanceIdentifier](#_bookmark31) or InstanceSpecifier:

```

 static ara::core::Result\<ara::com::ServiceHandleContainer\<

 \<ProxyClassName\>::HandleType\>\> FindService(ara::com::InstanceIdentifier instance);

 static ara::core::Result\<ara::com::ServiceHandleContainer\<

 \<ProxyClassName\>::HandleType\>\> FindService(ara::core::InstanceSpecifier instance);

```

These methods return a ServiceHandleContainer that can have different number of elements:

- Empty: No Service Instance was found
- One: A single Service instance was found
- Several: Multiple Service instances were found

The example in [5.5](#_bookmark115) (lines 52 - 60) shows how to create a Service Proxy using

FindService().

A Service Handler gives access to all the events, methods and fields of the service. For the events, the application has to subscibe to the events using the corresponding method setting also the size of the cache for this event :

```

 ara::core:Result\<void\> Event::Subscribe(size_t maxSampleCount);

```

To unsubscribe to an event the Unsubscribe method must be used:

```

 void Event::Unsubscribe();

```

The example in [5.5](#_bookmark115) (lines 62 - 64) shows how to subscribe for an event.

The application code for the Service Proxy and Skeleton is generated according to the [SI](#_bookmark71) defined in the Manifest. An example of the generated code for the Proxy Class can be found in the [5.2](#_bookmark104) and for the Skeleton Class in [5.12](#_bookmark127)

## Usage of InstanceSpecifier

InstanceSpecifier is a core concept defined in \[[3](#_bookmark2)\], representing a \"/\"-separated list of shortNames of model elements conforming an absolute path to an specific model element. In less formal terms, Instance Specifiers bridge Adaptive Platform models and applications, allowing application code to unequivocally reference resource instances defined by the system model.

The instances referenced by Instance Specifiers may be of many different kinds: pro- vided or required service instances, key/value or file stores, or cryptographic resources, to name a few.

In the C++ language binding of the Adaptive Platform, the InstanceSpecifier class has several common traits:

- It is **not** default constructible.
- It is copiable and movable.
- It is comparable against StringView and other InstanceSpecifier objects.
- It is explicitly convertible to StringView.

See listing [4.2](#_bookmark93) in chapter [subsection](#instance-identifiers-and-instance-specifiers) [4.8.1](#instance-identifiers-and-instance-specifiers) for more detailed information.

Considering these characteristics, the only way to create a new InstanceSpecifier object that's not a copy or a move of an existing one is to do so from a StringView object.

In practice, the contents of such StringView are syntactically but not semantically checked upon construction. This means that construction succeeds as long as the source StringView object contains a \"/\"-separated list of names conformed only of

from which the application derives, is something that will be checked by the different functional clusters when attempting to access or instantiate resources pointed by the InstanceSpecifier in question.

The following examples show the way in which, according to \[[1](#_bookmark0)\], InstanceSpeci- fiers might be used to instantiate and access services via skeleton and proxy classes.

Instance specifiers point to instances of port prototypes associated with a service. Therefore multiple instance specifiers for each PortPrototype can be created. In the examples below, *SwComponentInstance_0* and *SwComponentInstance_1* are 2 instantiations of the the same SwComponentPrototype, containing the RPortPro- totype *RPort_3*:

```

#include \"ara/core/instance_specifier.h\"

#include \"ara/com/sample/tire_skeleton.h\"

class TireSkeletonImplementation : public ara::com::sample::skeleton:: TireSkeleton

{

using TireSkeleton::TireSkeleton;

// Implement service interface methods, if any

};

int main()

{

const ara::core::InstanceSpecifier tire0_Instance{\"/ServerExe/ RootSWCP_0/Comp_Lvl1/Comp_Lvl2/SwComponentInstance_0/PPort_3\"};

const ara::core::InstanceSpecifier tire1_Instance{\"/ServerExe/ RootSWCP_0/Comp_Lvl1/Comp_Lvl2/SwComponentInstance_1/PPort_3\"};

TireSkeletonImplementation tire0(tire0_Instance);

TireSkeletonImplementation tire1(tire1_Instance);

// Sleep while Skeleton instances run, process requests, etc.

return 0;

}

 **Listing 6.5: Example Usage of Instance Specifiers with Skeletons**

#include \"ara/core/instance_specifier.h\"

#include \"ara/com/sample/tire_proxy.h\"

int main()

{

using Proxy = ara::com::sample::proxy::TireProxy;

const ara::core::InstanceSpecifier tire0_Instance{\"/ClientExe/ RootSWCP_0/Comp_Lvl1/Comp_Lvl2/SwComponentInstance_0/RPort_3\"};

const ara::core::InstanceSpecifier tire1_Instance{\"/ClientExe/ RootSWCP_0/Comp_Lvl1/Comp_Lvl2/SwComponentInstance_1/RPort_3\"};

auto tire0_handles = Proxy::FindService(tire0_Instance).ValueOrThrow();

auto tire1_handles = Proxy::FindService(tire1_Instance).ValueOrThrow();

Proxy tire0(tire0_handles\[0\]);

Proxy tire1(tire1_handles\[0\]);

// Call methods, subscribe to events, etc.

return 0;

}

```

**Listing 6.6: Example Usage of Instance Specifiers with Proxies**

In these examples the AUTOSAR Adaptive implementation manages process-specific manifests with isolated contexts. These can be dictated on process startup via e.g. command line arguments, environment variables, working directory contents or any other implementation-specific means.

### Modeling and configuration/mapping over Manifest from user perspective

The InstanceSpecifier used for finding a service maps to the particular instance of the port associated with that service.

```

#include \"ara/core/instance_specifier.h\"

#include \"ara/com/sample/radar_proxy.h\"

 4

int main() {

using Proxy = ara::com::sample::proxy::radarProxy;

// \...

ara::core::InstanceSpecifier portSpecifier{\"fusionExe/fusion/ radar_RPort\"};

auto res = Proxy::FindService(portSpecifier);

//\....

}

```

**Listing 6.7: CPP Example Usage with FindService**

In the Application Design, the Executable node specifies its RootSwCompo- nentPrototype. In turn the SwComponentPrototype defines one or more Port- Prototype.

```

 **\<?xml version=**\"1.0\" **encoding=**\"UTF-8\"**?\>**

 **\<AUTOSAR xmlns=**[\"http://autosar.org/schema/r4.0\"](http://autosar.org/schema/r4.0) **xmlns:xsi=**\"http://www.w3. org/2001/XMLSchema-instance\" **xsi:schemaLocation=**[\"http://autosar.org/](http://autosar.org/) schema/r4.0 AUTOSAR_00049.xsd\"**\>**

 **\<AR-PACKAGES\>**

 **\<AR-PACKAGE\>**

 **\<AR-PACKAGE\>**

 **\<SHORT-NAME\>**apd**\</SHORT-NAME\>**

 **\<AR-PACKAGE\>**

 **\<SHORT-NAME\>**da**\</SHORT-NAME\>**

 **\<ELEMENTS\>**

 **\<EXECUTABLE\>**

 **\<SHORT-NAME\>**fusionExe**\</SHORT-NAME\>**

 **\<CATEGORY\>**APPLICATION_LEVEL**\</CATEGORY\>**

 **\<SHORT-NAME\>**fusion**\</SHORT-NAME\>**

 **\<APPLICATION-TYPE-TREF DEST=**\"ADAPTIVE-APPLICATION-SW- COMPONENT-TYPE\"**\>**/apd/da/fusion**\</APPLICATION-TYPE-TREF\>**

 **\</ROOT-SW-COMPONENT-PROTOTYPE\>**

 **\</EXECUTABLE\>**

 **\<ADAPTIVE-APPLICATION-SW-COMPONENT-TYPE\>**

 **\<SHORT-NAME\>**fusion**\</SHORT-NAME\>**

 **\<PORTS\>**

 **\<R-PORT-PROTOTYPE\>**

 **\<SHORT-NAME\>**radar_RPort**\</SHORT-NAME\>**

 **\<REQUIRED-INTERFACE-TREF DEST=**\"SERVICE-INTERFACE\"**\>**/apd/da

 /radar**\</REQUIRED-INTERFACE-TREF\>**

 **\</R-PORT-PROTOTYPE\>**

 **\</PORTS\>**

 **\</ADAPTIVE-APPLICATION-SW-COMPONENT-TYPE\>**

 **\<SOMEIP-SERVICE-INTERFACE-DEPLOYMENT\>**

 **\<SHORT-NAME\>**radar_Someip**\</SHORT-NAME\>**

 **\<!*\-- \...\... \--*\>**

 **\</SOMEIP-SERVICE-INTERFACE-DEPLOYMENT\>**

**\</ELEMENTS\>**

**\</AR-PACKAGE\>**

 **\</AR-PACKAGE\>**

 **\</AR-PACKAGE\>**

 **\</AR-PACKAGES\>**

 **\</AUTOSAR\>**

 **Listing 6.8: Path towards port instance**

```

See [Figure](#_bookmark175) [6.1](#_bookmark175) for the SOME/IP Service Interface Deployment.

The mapping between a RequiredServiceInstance and an InstanceSpeci- fier is done via the *Service Instance Manifest*. In the Service Instance Man- ifest the ServiceInstanceToPortPrototypeMapping defines which *Service Instance* is associated with a certain port inside a specific RootSwComponentProto- type. The RequiredServiceInstance specifies the InstanceId as Require- ServiceInstanceId, in the example below this value is 19.

```

 **\<?xml version=**\"1.0\" **encoding=**\"UTF-8\"**?\>**

 **\<AUTOSAR xmlns=**[\"http://autosar.org/schema/r4.0\"](http://autosar.org/schema/r4.0) **xmlns:xsi=**\"http://www.w3. org/2001/XMLSchema-instance\" **xsi:schemaLocation=**[\"http://autosar.org/](http://autosar.org/) schema/r4.0 AUTOSAR_00049.xsd\"**\>**

 **\<AR-PACKAGES\>**

 **\<AR-PACKAGE\>**

 **\<AR-PACKAGE\>**

 **\<SHORT-NAME\>**apd**\</SHORT-NAME\>**

 **\<AR-PACKAGE\>**

 **\<SHORT-NAME\>**da**\</SHORT-NAME\>**

 **\<AR-PACKAGE\>**

 **\<ELEMENTS\>**

 **\<SHORT-NAME\>**instance**\</SHORT-NAME\>**

 **\<SHORT-NAME\>**radar_RequiredServiceInstance_toMachine**\</ SHORT-NAME\>**

 **\<COMMUNICATION-CONNECTOR-REF DEST=**\"ETHERNET-

 COMMUNICATION-CONNECTOR\"**\>**/apd/da/fusionMachineDesign

 /fusionCommunicationConnector**\</COMMUNICATION- CONNECTOR-REF\>**

 **\<SERVICE-INSTANCE-REFS\>**

 **\<SERVICE-INSTANCE-REF DEST=**\"REQUIRED-SOMEIP-SERVICE-

 INSTANCE\"**\>**/apd/da/instance/ radar_RequiredSomeipServiceInstance**\</SERVICE- INSTANCE-REF\>**

 **\</SERVICE-INSTANCE-REFS\>**

 **\<UDP-PORT\>**33111**\</UDP-PORT\>**

 **\</SOMEIP-SERVICE-INSTANCE-TO-MACHINE-MAPPING\>**

 **\<SERVICE-INSTANCE-TO-PORT-PROTOTYPE-MAPPING\>**

 **\<SHORT-NAME\>**radar_RequiredServiceInstance_toPort**\</SHORT**

 **-NAME\>**

 **\<PORT-PROTOTYPE-IREF\>**

 **\<CONTEXT-ROOT-SW-COMPONENT-PROTOTYPE-REF DEST=**\"ROOT-

 SW-COMPONENT-PROTOTYPE\"**\>**/apd/da/fusionExe/fusion**\</ CONTEXT-ROOT-SW-COMPONENT-PROTOTYPE-REF\>**

 **\<TARGET-PORT-PROTOTYPE-REF DEST=**\"R-PORT-PROTOTYPE\"**\>**/

 apd/da/fusion/radar_RPort**\</TARGET-PORT-PROTOTYPE- REF\>**

 **\</PORT-PROTOTYPE-IREF\>**

 **\<PROCESS-REF DEST=**\"PROCESS\"**\>**/apd/da/fusion_instance1**\</ PROCESS-REF\>**

 **\<SERVICE-INSTANCE-REF DEST=**\"REQUIRED-SOMEIP-SERVICE-

 INSTANCE\"**\>**/apd/da/instance/ radar_RequiredSomeipServiceInstance**\</SERVICE- INSTANCE-REF\>**

 **\</SERVICE-INSTANCE-TO-PORT-PROTOTYPE-MAPPING\>**

 **\<REQUIRED-SOMEIP-SERVICE-INSTANCE\>**

 **\<SHORT-NAME\>**radar_RequiredSomeipServiceInstance**\</SHORT- NAME\>**

 **\<SERVICE-INTERFACE-DEPLOYMENT-REF DEST=**\"SOMEIP-SERVICE-

 INTERFACE-DEPLOYMENT\"**\>**/apd/da/deployment/ radar_Someip**\</SERVICE-INTERFACE-DEPLOYMENT-REF\>**

 **\<!*\-- \...\... \--*\>**

 **\<REQUIRED-MINOR-VERSION\>**0**\</REQUIRED-MINOR-VERSION\>**

 **\<REQUIRED-SERVICE-INSTANCE-ID\>**19**\</REQUIRED-SERVICE- INSTANCE-ID\>**

 **\</REQUIRED-SOMEIP-SERVICE-INSTANCE\>**

**\</ELEMENTS\>**

**\</AR-PACKAGE\>**

 **\</AR-PACKAGE\>**

 **\</AR-PACKAGE\>**

 **\</AR-PACKAGES\>**

 **\</AUTOSAR\>**

```

**Listing 6.9: Service Instance Manifest specification of RequiredServiceInstance**

![](./media/image45.png)

![](./media/image49.png)**Figure 6.6: SOME/IP Required Service Instance Deployment**

**Note**: An executable can be started multiple times. Each of the processes is started with a different Service Instance Manifest, therefore the mapping between an In- stanceSpecifier and a RequiredServiceInstance will be different between the separate processes.

### Instance IDs only for provided Services

The InstanceSpecifier and the [InstanceIdentifier](#_bookmark31) can be used to uniquely identify a provided service. This means that clients know which particular service instance they are communicating with. This information is lacking for provided services. Clients can't be uniquely identified with an [InstanceIdentifier](#_bookmark31), therefore the server can't know for sure with which client it communicates with. For most cases this is not a problem, however we envision that for safety this can be a problem. For these cases we recommend using the E2E parameter dataID of the method E2E_check (see \[PRS_E2E_00323\] of \[[10](#_bookmark9)\]).

## Usage in context of MultiBinding

The following section revamps the example shown in [6.2.1](#modeling-and-configurationmapping-over-manifest-from-user-perspective), depicting how multiple network bindings for a single PPortPrototype can be defined in the Application and Instance Manifests without altering the Adaptive Application's source code. In this case, we will add an additional DDS-based instatiation of the /apd/da/radar [SI](#_bookmark71).

To begin with, the Application Manifest is extended with an DdsServiceInter- faceDeployment, named radar_Dds, portraying DDS-specific deployment ele- ments of the [SI](#_bookmark71):

```

 **\<?xml version=**\"1.0\" **encoding=**\"UTF-8\"**?\>**

 **\<AUTOSAR xmlns=**[\"http://autosar.org/schema/r4.0\"](http://autosar.org/schema/r4.0) **xmlns:xsi=**\"http://www.w3. org/2001/XMLSchema-instance\" **xsi:schemaLocation=**[\"http://autosar.org/](http://autosar.org/) schema/r4.0 AUTOSAR_00049.xsd\"**\>**

 **\<AR-PACKAGES\>**

 **\<AR-PACKAGE\>**

 **\<AR-PACKAGE\>**

 **\<SHORT-NAME\>**apd**\</SHORT-NAME\>**

 **\<AR-PACKAGE\>**

 **\<SHORT-NAME\>**da**\</SHORT-NAME\>**

 **\<ELEMENTS\>**

 **\<EXECUTABLE\>**

 **\<SHORT-NAME\>**fusionExe**\</SHORT-NAME\>**

 **\<CATEGORY\>**APPLICATION_LEVEL**\</CATEGORY\>**

 **\<ROOT-SW-COMPONENT-PROTOTYPE\>**

 **\<SHORT-NAME\>**fusion**\</SHORT-NAME\>**

 **\<APPLICATION-TYPE-TREF DEST=**\"ADAPTIVE-APPLICATION-SW- COMPONENT-TYPE\"**\>**/apd/da/fusion**\</APPLICATION-TYPE-TREF\>**

 **\</ROOT-SW-COMPONENT-PROTOTYPE\>**

 **\</EXECUTABLE\>**

 **\<ADAPTIVE-APPLICATION-SW-COMPONENT-TYPE\>**

 **\<SHORT-NAME\>**fusion**\</SHORT-NAME\>**

 **\<PORTS\>**

 **\<P-PORT-PROTOTYPE\>**

 **\<SHORT-NAME\>**radar_PPort**\</SHORT-NAME\>**

 **\<PROVIDED-INTERFACE-TREF DEST=**\"SERVICE-INTERFACE\"**\>**/apd/da

 /radar**\</PROVIDED-INTERFACE-TREF\>**

 **\</P-PORT-PROTOTYPE\>**

 **\</PORTS\>**

 **\</ADAPTIVE-APPLICATION-SW-COMPONENT-TYPE\>**

 **\<SOMEIP-SERVICE-INTERFACE-DEPLOYMENT\>**

 **\<SHORT-NAME\>**radar_Someip**\</SHORT-NAME\>**

 **\<!*\-- \...\... \--*\>**

 **\</SOMEIP-SERVICE-INTERFACE-DEPLOYMENT\>**

 **\<DDS-SERVICE-INTERFACE-DEPLOYMENT\>**

 **\<SHORT-NAME\>**radar_Dds**\</SHORT-NAME\>**

 **\<!*\-- \...\... \--*\>**

 **\</DDS-SERVICE-INTERFACE-DEPLOYMENT\>**

**\</ELEMENTS\>**

**\</AR-PACKAGE\>**

 **\</AR-PACKAGE\>**

 **\</AR-PACKAGE\>**

 **\</AR-PACKAGES\>**

 **\</AUTOSAR\>**

```

**Listing 6.10: Path towards port instance**

See [Figure](#_bookmark175) [6.1](#_bookmark175) for the SOME/IP Service Interface Deployment.

![](./media/image50.png)+fieldDeployment

![](./media/image51.png)![](./media/image52.png)![](./media/image53.png)+eventDeployment

0..\*

![](./media/image54.png){width="8.022747156605424e-2in" height="0.15312445319335083in"}

```

 +fieldTopicsAccessRule

 +eventTopicAccessRule 0..1

0..1

```

**Figure 6.7: DDS Service Interface Deployment**

In the Instance Manifest, separate sets of ServiceInstanceToMachineMap- ping, ServiceInstanceToPortPrototypeMapping and ProvidedService- Instance are listed, each defining SOME/IP and DDS-specific deployment param- eters.

```

 **\<?xml version=**\"1.0\" **encoding=**\"UTF-8\"**?\>**

 **\<AUTOSAR xmlns=**[\"http://autosar.org/schema/r4.0\"](http://autosar.org/schema/r4.0) **xmlns:xsi=**\"http://www.w3. org/2001/XMLSchema-instance\" **xsi:schemaLocation=**[\"http://autosar.org/](http://autosar.org/) schema/r4.0 AUTOSAR_00049.xsd\"**\>**

 **\<AR-PACKAGES\>**

 **\<AR-PACKAGE\>**

 **\<AR-PACKAGE\>**

 **\<SHORT-NAME\>**apd**\</SHORT-NAME\>**

 **\<AR-PACKAGE\>**

 **\<SHORT-NAME\>**da**\</SHORT-NAME\>**

 **\<AR-PACKAGE\>**

 **\<SHORT-NAME\>**instance**\</SHORT-NAME\>**

 **\<ELEMENTS\>**

 **\<!*\-- For SOME/IP \--*\>**

 **\<SOMEIP-SERVICE-INSTANCE-TO-MACHINE-MAPPING\>**

 **\<SHORT-NAME\>**

 radar_ProvidedServiceInstance_toMachine_Someip**\</ SHORT-NAME\>**

 **\<COMMUNICATION-CONNECTOR-REF DEST=**\"ETHERNET-

 COMMUNICATION-CONNECTOR\"**\>**/apd/da/fusionMachineDesign

 /fusionCommunicationConnector**\</COMMUNICATION- CONNECTOR-REF\>**

 **\<SERVICE-INSTANCE-REFS\>**

 **\<SERVICE-INSTANCE-REF DEST=**\"PROVIDED-SOMEIP-SERVICE-

 INSTANCE\"**\>**/apd/da/instance/ radar_ProvidedSomeipServiceInstance**\</SERVICE- INSTANCE-REF\>**

 **\</SERVICE-INSTANCE-REFS\>**

 **\<UDP-PORT\>**33111**\</UDP-PORT\>**

 **\</SOMEIP-SERVICE-INSTANCE-TO-MACHINE-MAPPING\>**

 **\<SERVICE-INSTANCE-TO-PORT-PROTOTYPE-MAPPING\>**

 **\<SHORT-NAME\>**radar_ProvidedServiceInstance_toPort_Someip

 **\</SHORT-NAME\>**

 **\<PORT-PROTOTYPE-IREF\>**

 **\<CONTEXT-ROOT-SW-COMPONENT-PROTOTYPE-REF DEST=**\"ROOT-

 SW-COMPONENT-PROTOTYPE\"**\>**/apd/da/fusionExe/fusion**\</ CONTEXT-ROOT-SW-COMPONENT-PROTOTYPE-REF\>**

 **\<TARGET-PORT-PROTOTYPE-REF DEST=**\"P-PORT-PROTOTYPE\"**\>**/

 apd/da/fusion/radar_PPort**\</TARGET-PORT-PROTOTYPE- REF\>**

 **\</PORT-PROTOTYPE-IREF\>**

 **\<PROCESS-REF DEST=**\"PROCESS\"**\>**/apd/da/fusion_instance1**\</ PROCESS-REF\>**

 **\<SERVICE-INSTANCE-REF DEST=**\"PROVIDED-SOMEIP-SERVICE-

 INSTANCE\"**\>**/apd/da/instance/ radar_ProvidedSomeipServiceInstance**\</SERVICE- INSTANCE-REF\>**

 **\</SERVICE-INSTANCE-TO-PORT-PROTOTYPE-MAPPING\>**

 **\<SOMEIP-PROVIDED-SERVICE-INSTANCE\>**

 **\<SHORT-NAME\>**radar_ProvidedSomeipServiceInstance**\</SHORT- NAME\>**

 **\<SERVICE-INTERFACE-DEPLOYMENT-REF DEST=**\"SOMEIP-SERVICE-

 INTERFACE-DEPLOYMENT\"**\>**/apd/da/deployment/ radar_Someip**\</SERVICE-INTERFACE-DEPLOYMENT-REF\>**

 **\<!*\-- \...\... \--*\>**

 **\<SERVICE-INSTANCE-ID\>**19**\</SERVICE-INSTANCE-ID\>**

 **\</SOMEIP-PROVIDED-SERVICE-INSTANCE\>**

 **\<!*\-- For DDS \--*\>**

 **\<DDS-SERVICE-INSTANCE-TO-MACHINE-MAPPING\>**

 **\<SHORT-NAME\>**radar_ProvidedServiceInstance_toMachine_Dds

 **\</SHORT-NAME\>**

 **\<COMMUNICATION-CONNECTOR-REF DEST=**\"ETHERNET-

 COMMUNICATION-CONNECTOR\"**\>**/apd/da/fusionMachineDesign

 /fusionCommunicationConnector**\</COMMUNICATION- CONNECTOR-REF\>**

 **\<SERVICE-INSTANCE-REFS\>**

 **\<SERVICE-INSTANCE-REF DEST=**\"DDS-PROVIDED-SERVICE-

 INSTANCE\"**\>**/apd/da/instance/ radar_ProvidedSomeipServiceInstance**\</SERVICE- INSTANCE-REF\>**

 **\</SERVICE-INSTANCE-REFS\>**

 **\</DDS-SERVICE-INSTANCE-TO-MACHINE-MAPPING\>**

 **\<SERVICE-INSTANCE-TO-PORT-PROTOTYPE-MAPPING\>**

 **\<SHORT-NAME\>**radar_ProvidedServiceInstance_toPort_Dds**\</**

 **\<PORT-PROTOTYPE-IREF\>**

 **\<CONTEXT-ROOT-SW-COMPONENT-PROTOTYPE-REF DEST=**\"ROOT-

 SW-COMPONENT-PROTOTYPE\"**\>**/apd/da/fusionExe/fusion**\</ CONTEXT-ROOT-SW-COMPONENT-PROTOTYPE-REF\>**

 **\<TARGET-PORT-PROTOTYPE-REF DEST=**\"P-PORT-PROTOTYPE\"**\>**/

 apd/da/fusion/radar_PPort**\</TARGET-PORT-PROTOTYPE- REF\>**

 **\</PORT-PROTOTYPE-IREF\>**

 **\<PROCESS-REF DEST=**\"PROCESS\"**\>**/apd/da/fusion_instance1**\</ PROCESS-REF\>**

 **\<SERVICE-INSTANCE-REF DEST=**\"PROVIDED-DDS-SERVICE-

 INSTANCE\"**\>**/apd/da/instance/ radar_ProvidedDdsServiceInstance**\</SERVICE-INSTANCE- REF\>**

 **\</SERVICE-INSTANCE-TO-PORT-PROTOTYPE-MAPPING\>**

 **\<DDS-PROVIDED-SERVICE-INSTANCE\>**

 **\<SHORT-NAME\>**radar_ProvidedDdsServiceInstance**\</SHORT- NAME\>**

 **\<SERVICE-INTERFACE-DEPLOYMENT-REF DEST=**\"DDS-SERVICE-

 INTERFACE-DEPLOYMENT\"**\>**/apd/da/deployment/radar_Dds**\</ SERVICE-INTERFACE-DEPLOYMENT-REF\>**

 **\<!*\-- \...\... \--*\>**

 **\<SERVICE-INSTANCE-ID\>**19**\</SERVICE-INSTANCE-ID\>**

 **\</DDS-PROVIDED-SERVICE-INSTANCE\>**

**\</ELEMENTS\>**

**\</AR-PACKAGE\>**

 **\</AR-PACKAGE\>**

 **\</AR-PACKAGE\>**

 **\</AR-PACKAGES\>**

 **\</AUTOSAR\>**

 **Listing 6.11: Service Instance Manifest specification of ProvidedServiceInstance**

![](./media/image55.png)

 **Figure 6.8: SOME/IP Provided Service Instance Deployment**

![](./media/image33.png)+serviceInterfaceDeployment

![](./media/image60.png)![](./media/image61.png)0..1

 +event

0..1

 ![](./media/image33.png)+field 0..1

 0..\*

```

**Figure 6.9: DDS Provided Service Instance Deployment**

Adaptive Applications looking to bind against instances of the /apd/da/radar [SI](#_bookmark71) will now have to properly configure ServiceInstanceToMachineMapping, Servi- ceInstanceToPortPrototypeMapping and ProvidedServiceInstance sub- classes in their Instance Manifests, according to their Network Binding (DDS or SOME/IP) preference.

## Usage of RawDataStreaming

This chapter describes how RawDataStreams can be used in an AUTOSAR Adaptive application.

RawDataStreaming currently supports four use cases regarding configuration of uni- cast/multicast and UDP/TCP connections. These use cases are described in chapter Raw Data Streaming of \[[1](#_bookmark0)\].

The most common use case is \"'1:1 TCP unicast\"', so that is used as example in this tutorial.

### Sequence diagrams

The diagram [6.10](#_bookmark184) shows the sequence when using the Raw Data Streaming API on the client side.

![](./media/image63.png){width="3.040363079615048in" height="3.8228116797900262in"}

**Figure 6.10:** []{#_bookmark184 .anchor}**Client sequence diagram**

The diagram [6.11](#_bookmark185) shows the sequence when using the Raw Data Streaming API on the server side.

![](./media/image64.png){width="3.030624453193351in" height="3.81875in"}

**Figure 6.11:** []{#_bookmark185 .anchor}**Client sequence diagram**

Note that the sequences with a client that sends data and a server that reads data are also valid.

### Usage

Since the Raw Data Streaming provides an API it is required to have the instances of the RawDataStreamServer or RawDataStreamClient and call the methods according to the sequences described in [6.4.1](#sequence-diagrams)

### Example of usage as server

The code [6.12](#_bookmark188) shows how to use the RawDataStreamServer for sending and receiving data.

```

[]{#_bookmark188 .anchor}// NOTE! For simplicity the example does not use ara::core::Result.

#include \"ara/core/instance_specifier.h\"

#include \"raw_data_stream.h\"

int main() {

size_t rval;

ara::com::raw::RawDataStream::ReadDataResult result;

// Instance Specifier from model

ara::core::InstanceSpecifier instspec

{\...}

// Create RawDataStream Server instance

ara::com::raw::RawDataStreamServer server{instspec};

// Wait for incoming connections

server.WaitForConnection();

// Read data from the RawData stream in chunks of 10 bytes

do{

result = server.ReadData(10);

rval = result.numberOfBytes;

if (rval \> 0) {

// assumes the data is printable

std::cout \<\< \"\--\>\" \<\< result.data.get() \<\< std::endl;

}

} while (rval \> 0);

// Write data to the RawData stream in chunks of 16 bytes

int i=0;

do{

std::unique_ptr\<uint8_t\> write_buf (new uint8_t\[1024\] \\{. });

rval = server.WriteData(std::move(write_buf), 16);

++i;

}while (i\<1000);

// Shutdown RawDataStream connection

server.Shutdown(); return 0;

}

 **Listing 6.12: Example of usage as server**

### Example of usage as client

 The code [6.13](#_bookmark190) shows how to use the RawDataStreamClient for sending and receiving data.

[]{#_bookmark190 .anchor}// NOTE! For simplicity the example does not use ara::core::Result.

#include \"ara/core/instance_specifier.h\"

#include \"raw_data_stream.h\"

int main() {

size_t rval;

ara::com::raw::RawDataStream::ReadDataResult result;

// Instance Specifier from model

ara::core::InstanceSpecifier instspec

{\...}

// Create a RawDataStreamClient instance

ara::com::raw::RawDataStreamClient client {instspec};

// Connect to RawDataStream Server

client.Connect();

// Write data to RawData stream in chunks of 40 bytes

int i=0;

do {

std::unique_ptr\<uint8_t\> write_buf (new uint8_t\[1024\]{. });

rval = client.WriteData(std::move(write_buf), 40);

++i;

} while (i\<1000);

// Read data from the RawData stream in chunks of 4 bytes

do {

result = client.ReadData(4);

rval = result.numberOfBytes;

if (rval \> 0){

// assumes the data is printable

std::cout \<\< \"\--\>\" \<\< result.data.get() \<\< std::endl;

}

} while (rval \> 0);

// Shutdown RawDataStream connection

client.Shutdown(); return 0;

}

```

**Listing 6.13: Example of usage as client**

3. ## Usage of CommunicationGroups

   1. ### Setup

This section describes the configuration steps to define a Communication Group by using the Communication Group Template (category = COMMUNICA- TION_GROUP). There are three items which need to be specified to define a Com- munication Group:

- The name of the Communication Group = SHORT-NAME.
- The data type of messages sent to the clients.
- The data type of response message sent by the clients.

The figure below presents the Communication Group Template.

![](./media/image65.jpeg)

response message definition

**Figure 6.12: CG Template Service Interface Descritpion, example PowerMode**

### Service Interface Description Generation

To create Communication Group server and client ServiceInterface description files, the Communication Group Template need to be setup (see chapter be- fore). Based on the Communication Group Template the ServiceInterface description files of the Communication Group server and client can be generated. See figures below.

Note: The Communication Group Template is a ServiceInterface which is only used for generation of Communication Group ServiceInterfaces and it has else no usage.

\<\<derive\>\>

**Figure 6.13: Communication Group Service Interfaces Relationship**

![](./media/image67.png){width="6.238988407699038in" height="2.410311679790026in"}

**Figure 6.14: Communication Group Service Interfaces Generation**

### Proxy and Skeleton Generation

Using the ServiceInterface descriptions for the Communication Group server and client the according Proxy and Skeleton Service classes can be genrated (hint: stan- dard ara::com [SI](#_bookmark71) generation flow). See figures below.

![](./media/image68.jpeg)

**Figure 6.15: CG Server Service Interface Description, example PowerMode**

![](./media/image69.jpeg)

**Figure 6.16: CG Client Service Interface Description, example PowerMode**

### Example

The following chapter outlines the steps to define and create the Communication Group [PowerMode](#_bookmark72).

- Define the CG name and add this name as SHORT-NAME into the ServiceIn- terface description of the Communication Group Template.

\+ SHORT-NAME = [PowerMode](#_bookmark72)

- Define the message data type for peer to peer and broadcast message according to \[SWS_CM_99001\], \[SWS_CM_99002\], \[SWS_CM_99008\] and edit it into the ServiceInterface description of the Communication Group Template.

```

 \+ message definition \<typename T\>

 PowerModeMsg = \[On, Off, Suspend\] according to \[SWS_SM_91011\] background info:

 sample CG code for \[SWS_CM_99001\]:

 template \<typename T\>

 ara::core::Future\<void\> broadcast (const T& msg);

 sample CG code for \[SWS_CM_99002\]:

 template \<typename T\>

 ara::core::Future\<void\> message (uint32_t clientID, const T& msg);

 sample CG code for \[SWS_CM_99008\]:

 template \<typename T\>

 ara::core::Future\<void\> message (const T& msg);

```

- Define the response message data type according to \[SWS_CM_99014\], \[SWS\_- CM_99009\] and edit it into the ServiceInterface description of the Commu- nication Group Template.

```

 \+ response message definition \<typename R\>

 PowerModeRspMsg = \[Done, Failed, Busy, NotSupported\] accord- ing to \[SWS_SM_91012\]

 background info:

 sample CG code for \[SWS_CM_99014\]:

 template \<typename R\> struct Response {

 uint32_t clientID;

 const R& responseMsg }

 sample CG code for \[SWS_CM_99009\]:

 template \<typename R\> const R& responseMsg;

```

- Generate the Server and Client ServiceInterface descriptions out of the setup Communication Group Template.
- Generate the Server and Client ServiceInterface Proxy and Skeleton Ser- vice class templates.
- Instatiate the Communication Group Server and Client Proxy and Skeleton Ser- vice classes into the application code. See examples below.

![](./media/image71.png){width="4.173254593175853in" height="3.429757217847769in"}**Figure 6.17: Usage Example Communication Group PowerMode**

Confidential C

![](./media/image72.png){width="6.222201443569554in" height="3.158124453193351in"}

**Figure 6.18: Usage Example 2 x Communication Groups diagnosticReset**

![](./media/image73.png)

**Figure 6.19: Usage Example Communication Group PowerMode and diagnosticReset**

7. # Appendix

   1. ## Serialization

Serialization (see \[[11](#_bookmark10)\]) is the process of transforming certain data structures into a standardized format for exchange between a sender and a (possibly different) receiver. You typically have this notion if you transfer data from one network node to another. When putting data on the wire and reading it back, you have to follow exact, agreed-on rules to be able to correctly interpret the data on the receiver side. For the network communication use case the need for a defined approach to convert an in-process data representation into a wire-format and back is very obvious: The boxes doing the communication might be based on different micro-controllers with different endianness and different data-word sizes (16-bit, 32-bit, 64-bit) and therefore employing totally different alignments. In the AUTOSAR CP serialization typically plays no role for platform internal/node internal communication! Here the internal in-memory data representation can be directly copied from a sender to a receiver. This is possible, because three assumptions are made in the typical CP product:

- Endianness is identical among all local SWCs.
- Alignment of certain data structures is homogeneous among all local SWCs.
- Data structures exchanged are contiguous in memory.

The first point is maybe a bit pathological as it is most common, that "internal" com- munication generally means communication on a single- or multi-core MCU or even a multi-processor system, where endianness is identical everywhere. Only if we look at a system/node composed of CPUs made of different micro-controller families this assumption may be invalid, but then you are already in the discussion, whether this communication is still "internal" in the typical sense. The second assumption is valid/ac- ceptable for CP as here a static image for the entire single address space system is built from sources and/or object files, which demands that compiler settings among the different parts of the image are somewhat aligned anyway. The third one is also as- sured in CP. It is not allowed/possible to model non contiguous data types, which get used in inter-SWC communication.

For the AP things look indeed different. Here the loading of executables during run- time, which have been built independently at different times and have been uploaded to an AP ECU at different times, is definitely a supported use case. The chance, that compiler settings for different [ara::com](#_bookmark15) applications were different regarding align- ment decisions is consequently high. Therefore an AP product (more concrete its [IPC](#_bookmark70)binding implementation) has to use/support serialization of exchanged event/field-

/method data. How serialization for AP internal[IPC](#_bookmark70)is done (i.e. to what generalized format) is fully up to the AP vendor. Also regarding the 3rd point, the AP is less re- strictive. So for example the AP supports exchange of std::map data types or record like datatypes, which contain variable-length members. These datatypes are generally NOT contiguous in-memory (depending on the allocation strategy). So even if the data

copy (meaning collecting contained elements and their references from various mem- ory regions --- see \[[12](#_bookmark11)\]) must be done during transfer. Of course the product vendor could apply optimization strategies to get rid of the serialization and de-serialization stages within a communication path:

- Regarding alignment issues, the most simple one could be to allow the integrator of the system to configure, that alignment for certain communication relations can be considered compatible (because he has the needed knowledge about the involved components).
- Another approach common to middleware technology is to verify, whether align- ment settings on both sides are equal by exchanging a check-pattern as kind of a init-sequence before first [ara::com](#_bookmark15) communication call.
- The problem regarding need for deep-copying because of non-contiguous mem- ory allocation could be circumvented by providing vector implementations which care for continuity.

  1. ### Zero-Copy implications

One thing which typically is at the top of the list of performance optimizations in IPC/middleware implementations is the avoidance of unnecessary copies between sender and the receiver of data. So the buzzword "zero-copy" is widely used to de- scribe this pattern. When we talk about AP, where we have architectural expectations like applications running in separate processes providing memory protection, the typi- cal communication approach needs at least ONE copy of the data from source address space to target address space. Highly optimizing middleware/IPC implementations could even get rid of this single copy step by setting up shared memory regions be- tween communicating [ara::com](#_bookmark15) components. If you look at [5.19](#_bookmark138), you see, that we directly encourage such implementation approaches in the API design. But the not so good news is, that if the product vendor does NOT solve the serialization problem, he barely gets benefit from the shared memory approach: If conversions (aka de/se- rialization) have to be done between communication partners, copying must be done anyhow --- so tricky shared memory approaches to aim for "zero-copy" do not pay.

## Service Discovery Implementation Strategies

As laid out in the preceding chapters, [ara::com](#_bookmark15) expects the functionality of a ser- vice discovery being implemented by the product vendor. As the service discovery functionality is basically defined at the API level with the methods for FindService, OfferService and StopOfferService, the protocol and implementation details are partially open.

When an AP node (more concretely an AP SWC) offers a service over the network or requires a service from another network node, then service discovery/service registry

obviously takes place over the wire. The protocol for service discovery over the wire needs to be completely specified by the used communication protocol. For SOME/IP, this is done in the SOME/IP Service Discovery Protocol Specification \[[13](#_bookmark12)\]. But if an [ara::com](#_bookmark15) application wants to communicate with another [ara::com](#_bookmark15) application on the same node within the AP of the same vendor there has to be a local variant of a ser- vice discovery available. Here the only difference is, that the protocol implementation for service discovery taking place locally is totally up to the AP product vendor.

### Central vs Distributed approach

From an abstract perspective a AP product vendor could choose between two ap- proaches: The first one is a centralist approach, where the vendor decides to have one central entity (f.i. a daemon process), which:

- maintains a registry of all service instances together with their location informa- tion
- serves all FindService, OfferService and StopOfferService re- quests from local [ara::com](#_bookmark15) applications, thereby either updating the registry (OfferService, StopOfferService) or querying the registry ( FindSer- vice)
- serves all SOME/IP SD messages from the network either updating its registry (SOME/IP Offer Service received) or querying the registry (SOME/IP Find Service received)
- propagates local updates to its registry to the network by sending out SOME/IP SD messages.

The following figure roughly sketches this approach.

![](./media/image74.png)ECU with AP/CP product

**Figure 7.1: Centralized discovery approach**

A slightly different --- more distributed --- approach would be, to distribute the service registry information (availability and location information) among the [ara::com](#_bookmark15) appli- cations within the node. So for the node local communication use case no prominent discovery demon would be needed. That could be technically reached by having a broadcast-like communication. That means any service offering and finding is prop- agated to all local [ara::com](#_bookmark15) applications, so that each application has a local (in process) view of the service registry. There might be a benefit with this approach as local communication might be more flexible/stable as it is not dependent from a single registry demon. However, for the service discovery communication to/from the network a single responsible instance is needed anyhow. Here the distributed approach is not feasible as SOME/IP SD requires a fixed/defined set of ports, which just can be pro- vided (in typical operating systems / with typical network stacks) by a single application process.

At the end we also do have a singleton/central instance, with the slight difference, that it is responsible for taking the role as a service discovery protocol bridge between node local discovery protocol and network SOME/IP SD protocol. On top of that --- since registry is duplicated/distributed among all [ara::com](#_bookmark15) applications within the node --- this bridge also holds a local registry.

![](./media/image74.png)ECU with AP/CP product

**Figure 7.2: Distributed discovery approach**

## Multi-Binding implications

As shortly discussed in [subsection](#instantiation-constructors) [5.4.3](#instantiation-constructors) Multi-Binding describes the solution to support setups, where the technical transport/connection between different instances of a certain proxy class/skeleton class are different. There might be various technical reasons for that:

- proxy class uses different transport/IPC to communicate with different skeleton instances. Reason: Different service instances support different transport mech- anisms because of deployment decisions.
- symmetrically it may also be the case, that different proxy instances for the same skeleton instance uses different transport/IPC to communicate with this instance: The skeleton instance supports multiple transport mechanisms to get contacted.

  1. ### Simple Multi-Binding use case

The following figure depicts an obvious and/or rather simple case. In this example, which only deals with node local (inside one AP product/ECU) communication between service consumers (proxy) and service providers (skeleton), there are two instances of the same proxy class on the service consumer side. You see in the picture, that the service consumer application has triggered a "FindService" first, which returned two handles for two different service instances of the searched service type. The service consumer application has instantiated a proxy instance for each of those handles. Now in this example the instance 1 of the service is located inside the same adaptive ap- plication (same process/address space) as the service consumer (proxy instance 1), while the service instance 2 is located in a different adaptive application (different pro- cess/address space).

ECU with AP product

![](./media/image80.png)

**Figure 7.3: Simple Multi-Binding intra AP example**

The line symbolizing the transport layer between proxies and skeletons are colored differently in this picture: The instance of the proxy class for instance 1 has a red colored transport layer (binding implementation), while the transport layer for instance 2 is colored blue. They are colored differently because the used technology will be different already on the level of the proxy implementation. At least if you expect that the AP product vendor (in the role as[IPC](#_bookmark70)binding implementer) strives for a well performing product!

The communication between proxy instance 1 and the service instance 1 (red) should in this case be optimized to a plain method call, since proxy instance and skeleton instance 1 are contained in ONE process.

The communication between proxy instance 2 and the service instance 2 (blue) is a real IPC. So the actions taken here are of much higher costs involving most likely a variety of syscalls/kernel context switches to transfer calls/data from process of ser- vice consumer application to service application (typically using basic technologies like pipes, sockets or shared mem with some signaling on top for control).

So from the service consumer side application developer it is totally transparent: From the vendors ProxyClass::FindService implementation he gets two opaque han- dles for the two service instances, from which he creates two instances of the same

proxy class. But "by magic" both proxies behave totally different in the way, they con- tact their respective service instances. So --- somehow there must be some information contained inside this handle, from which the proxy class instance knows which tech- nical transport to choose. Although this use case looks simple at the first look it isn't on the second \... The question is: *Who* writes *When* into the handle, that the proxy in- stance created from it shall use a direct method/function call instead of a more complex [IPC](#_bookmark70)mechanism or vice versa?

At the point in time when instance 1 of the service does register itself via Skele- tonClass::OfferService at the registry/service discovery, this cannot be decided! Since it depends on the service consumer which uses it later on. So most likely the SkeletonClass::OfferService implementation of the AP vendor takes the needed information from the argument (skeleton generated by the AP vendor) and no- tifies via AP vendor specific[IPC](#_bookmark70)the registry/service discovery implementation of the AP vendor. The many "AP vendor" in the preceding sentence were intentional. Just show- ing, that all those mechanisms going on here are not standardized and can therefore deliberately designed and optimized by the AP vendors. However, the basic steps will remain. So what typically will be communicated from the service instance side to the registry/discovery in the course of SkeletonClass::OfferService is the technical addressing information, how the instance could be reached via the AP products local [IPC](#_bookmark70)implementation.

Normally there will be only ONE IPC-mechanism used inside one AP product/AP node! If the product vendor already has implemented a highly optimized/efficient local [IPC](#_bookmark70)implementation between adaptive applications, which will then be generally used. So --- in our example let"s say the underlying IPC-mechanism is unix domain sockets

--- the skeleton instance 1 would get/create some file descriptor to which its socket endpoint is connected and would communicate this descriptor to the registry/service discovery during SkeletonClass::OfferService. Same goes for the skeleton in- stance 2, just the descriptor is different. When later on the service consumer applica- tion part does a ProxyClass::FindService, the registry will send the addressing information for both service instances to the service consumer, where they are visible as two opaque handles.

So in this example obviously the handles look exactly the same --- with the small dif- ference, that the contained filedescriptor values would be different as they reference distinctive unix domain sockets. So in this case it somehow has to be detected inside the proxy for instance 1, that there is the possibility to optimize for direct method/func- tion calls. One possible trivial trick could be, that inside the addressing information, which skeleton instance 1 gives to the registry/discovery, also the ID of the process (pid) is contained; either explicitly or by including it into the socket descriptor filename. So the service consumer side proxy instance 1 could simply check, whether the PID inside the handle denotes the same process as itself and could then use the optimized path. By the way: Detection of process local optimization potential is a triviality, which almost every existing middleware implementation does today --- so no further need to stress this topic.

Now, if we step back, we have to realize, that our simple example here does NOT fully reflect what Multi-Binding means. It does indeed describe the case, where two instances of the same proxy class use different transport layers to contact the service instance, but as the example shows, this is NOT reflected in the handles denoting the different instances, but is simply an optimization! In our concrete example, the service consumer using the proxy instance 1 to communicate with the service instance 1 could have used also the Unix domain socket transport like the proxy instance 2 without any functional losings --- only from a non-functional performance viewpoint it would be obviously bad. Nonetheless this simple scenario was worth being mentioned here as it is a real-world scenario, which is very likely to happen in many deployments and therefore must be well supported!

### Local/Network Multi-Binding use case

After we have seen a special variant of Multi-Binding in the preceding section, we now look at a variant, which can also be considered as being a real-world case. Let"s suppose, we have have a setup quite similar to the one of the preceding chapter. The only difference is now, that the instance 2 of the service is located on a different ECU attached to the same Ethernet network as our ECU with the AP product, where the service consumer (with its proxies for instance 1 and 2) resides. As the standard protocol on Ethernet for AP is SOME/IP, it is expected, that the communication between both ECUs is based on SOME/IP. For our concrete example this means, that proxy 1 talks to service 1 via unix domain sockets (which might be optimized for process local communication to direct method calls, if the AP vendor/IPC implementer did his homework), while the proxy 2 talks to service 2 via network sockets in a SOME/IP compliant message format.

*Before someone notes, that this is not true for the typical SOME/IP deployment, be- cause there adaptive SWCs will not directly open network socket connections to remote nodes: We will cover this in more detail here (* [subsection](#typical-someip-multi-binding-use-case) [7.3.3](#typical-someip-multi-binding-use-case)*), but for now suppose, that this is a realistic scenario. (For other network protocols it might indeed be realistic)*

![](./media/image82.png)ECU with AP product

**Figure 7.4: Multi-Binding local and network example**

So in this scenario the registry/service discovery demon on our AP ECU has seen a service offer of instance 2 and this offer contained the addressing information on IP network endpoint basis. Regarding the service offer of the instance 1 nothing changed: This offer is still connected with some Unix domain socket name, which is essentially a filename. In this example the two handles for instance 1 and 2 returned from ProxyClass::FindService internally look very different: Handle of instance 1 contains the information, that it is a Unix domain socket and a name, while han- dle 2 contains the information, that it is a network socket and an IP address and port number. So --- in contrast to our first example ([subsection](#simple-multi-binding-use-case) [7.3.1](#simple-multi-binding-use-case)) here we do really have a full blown Multi-Binding, where our proxy class [ctor](#_bookmark23) instantiates/creates two completely different transport mechanisms from handle 1 and handle 2! How this dynamic decision, which transport mechanism to use, made during call of the [ctor](#_bookmark23), is technically solved is --- again --- up to the middleware implementer: The generated proxy class implementation could already contain any supported mechanism and the information contained in the handle is just used to switch between different behavior or the needed transport functionality aka binding could be loaded during runtime after a certain need is detected from the given handle via shared library mechanisms.

### Typical SOME/IP Multi-Binding use case

In the previous section we briefly mentioned, that in a typical deployment scenario with SOME/IP as network protocol, it is highly unlikely that an adaptive SWC (i.e. the language and network binding which runs in its context) opens socket connections itself to communicate with a remote service. Why is it unlikely? Because SOME/IP was explicitly designed to use as few ports as possible. The reason for that requirement

comes from low power/low resources embedded ECUs: Managing a huge amount of IP sockets in parallel means huge costs in terms of memory (and runtime) resources. So somehow our AUTOSAR CP siblings which will be main communication partner in an inside vehicle network demand this approach, which is uncommon, compared to non-automotive IT usage pattern for ports.

Typically this requirement leads to an architecture, where the entire SOME/IP traffic of an ECU / network endpoint is routed through one IP port! That means SOME/IP messages originating from/dispatched to many different local applications (service providers or service consumers) are (de)multiplexed to/from one socket connection. In Classic AUTOSAR (CP) this is a straight forward concept, since there is already a shared communication stack through which the entire communication flows. The multiplexing of different upper layer PDUs through one socket is core functionality inte- grated in CPs SoAd basic software module. For a typical POSIX compatible OS with POSIX socket API, multiplexing SOME/IP communication of many applications to/from one port means the introduction of a separate/central (demon) process, which man- ages the corresponding port. The task of this process is to bridge between SOME/IP network communication and local communication and vice versa.

![](./media/image85.png)ECU with AP product

**Figure 7.5: SOME/IP Bridge**

In the above figure you see, that the service proxy within our [ara::com](#_bookmark15) enabled appli- cation communicates through (green line) a SOME/IP Bridge with the remote service instance 2. Two points which may pop out in this figure:

- we intentionally colored the part of the communication route from app to bridge (green) differently than the part from the bridge to the service instance 2 (blue).
- we intentionally drew a box around the function block service discovery and SOME/IP bridge.

The reason for coloring first part of the route differently from the second one is simple: Both parts use a different transport mechanism. While the first one (green) between the proxy and the bridge uses a fully vendor specific implementation, the second one (blue) has to comply with the SOME/IP specification. "Fully vendor specific" here means, that the vendor not only decides which technology he uses (pipes, sockets, shared mem, \...), but also which serialization format (see [section](#serialization) [7.1](#serialization)) he employs on that path. Here we obviously dive into the realm of optimizations: In an optimized AP product, the vendor would not apply a different (proprietary) serialization format for the path denoted with the green line. Otherwise it would lead to an inefficient runtime behavior. First the proxy within the service consumer app would employ a proprietary serialization of the data before transferring it to the bridge node and then the bridge would have to de-serialize and re-serialize it to SOME/IP serialization format! So even if the AP product vendor has a much more efficient/refined serialization approach for local communication, using it here does not pay, since then the bridge is not able to simply copy the data through between internal and external side. The result is, that for our example scenario we eventually do have a Multi-Binding setup. So even if the technical transport (pipes, unix domain sockets, shared mem, \...) for communication to other local [ara::com](#_bookmark15) applications and to the bridge node is the same, the serialization part of the binding differs.

Regarding the second noticeable point in the figure: We drew a box around the ser- vice discovery and SOME/IP bridge functionality since in product implementations it is very likely, that it is integrated into one component/running within one (demon) pro- cess. Both functionalities are highly related: The discovery/registry part also consists of parts local to the ECU (receiving local registrations/offers and serving local Find- Service requests) and network related functions (SOME/IP service discovery based offers/finds) , where the registry has to arbitrate. This arbitration in its core is also a bridging functionality.

## ara::com and AUTOSAR meta-model relationship

Throughout this document we paid attention to explain ara::com API ideas and mechanisms **without** relating to the concrete/specific AP meta-model (the manifest parts of it), which is the basis to formally describe the [SI](#_bookmark71) signature (and partially the behavior) from which the ara::com API artifacts like ProxyClass and Skeleton- Class and data types used in the communication are generated/created. In [5.1](#_bookmark100) we even introduced an oversimplified/synthetic IDL, just to shield the reader from complex- ities of the real meta-model/IDL, which wouln't have added any value at that point.

This chapter shall by no means serve as a thorough explanation of the AUTOSAR meta-model, which is fully described in its own document, but it shall shed some light on the relation between [ara::com](#_bookmark15) and the meta-model parts described in \[[2](#_bookmark1)\]. So bear in mind, that the following parts are still somewhat high level and try to give a basic understanding of the relationship.

### Connection to AUTOSAR_TR_AdaptiveMethodology

Overview of Modeling elements and how they are related to each other: [SI](#_bookmark71), Deploy- ment, Actual generation dependant from provided Deployment Information (E.g. also [SI](#_bookmark71) Elements that will be generated later and connection to Service Instance Manifest)

AUTOSAR Adaptive Platform methodology explains the process aspects necessary to build an Adaptive AUTOSAR system and how they relate to each other \[TR_AMETH\_- 00100\]. It defines activities and work products delivered or consumed \[TR_AMETH\_- 00102\] and the Roles performed by OEMs and suppliers.

Major steps involved in the development of Adaptive Software are

- Architecture and Design
- Adaptive Software Development
- Integration and Deployment

Adaptive applications run on top of ARA layer and exchanges the information using [SI](#_bookmark71)s and Ports. Important contribution for [ara::com](#_bookmark15) API work performed during the Inte- gration and Deployment step of Adaptive Methodology. It supports the generation of [SI](#_bookmark71) Description ARXML file, which aggregates the [SI](#_bookmark71)s and ports. [SI](#_bookmark71)s for service-oriented communication defined by Events, Methods and Fields \[ [5.1](#_bookmark100)\]. This is done independent of Software components or Transport layer used for underlying communication.

Adaptive Platform supports two types of ports namely Provided and Required. [SI](#_bookmark71) along with Provided port details used for the generation of the Service Skeleton class and Required port details used for the generation of Proxy classes \[[Figure](#_bookmark117) [5.2](#_bookmark117)\]. Proxy and Skeleton classes use [ara::com](#_bookmark15) API to communicate with other Adaptive Platform clusters and Adaptive Applications.

Service instances are configured, notably the binding of the [SI](#_bookmark71)s to a chosen transport layer, whether a specific service instance is either Provided or Required and whether there is a mapping to a dedicated Machine. The configurations of the service instance are manifested in the Service Instance Manifest.

Executable of an Adaptive Software are instantiated by means of the Execution Man- ifest. Instantiation here means to bind the executables to the context of specific pro- cesses of the operating system. Each process may start with a different start-up con- figuration depending on a machine mode. Further on, the Execution Manifest also defines Software process dependencies.

### Service Interface

The most important meta-model element from the [ara::com](#_bookmark15) perspective is the [SI](#_bookmark71). Most important, because it defines everything signaturewise of an [ara::com](#_bookmark15) proxy or skeleton. The [SI](#_bookmark71) describes the methods, fields and the methods a [SI](#_bookmark71) consists of and how the signatures of those elements (arguments and data types) look like. So the

[5.1](#_bookmark100) is basically a simplification of meta-model [SI](#_bookmark71) and the real meta-model data type system.

The relationship between the meta-model element [SI](#_bookmark71) and [ara::com](#_bookmark15) is therefore clear:

[ara::com](#_bookmark15) proxy and skeleton classes get generated from [SI](#_bookmark71).

### Software Component

With software components, the AUTOSAR methodology defines a higher order ele- ment than just interfaces. The idea of a software component is to describe a reusable part of software with well defined interfaces. For this the AUTOSAR manifest spec- ification defines a model element SoftwareComponentType, which is an abstract element with several concrete subtypes, of which the subtype AdaptiveApplica- tionSwComponentType is the most important one for Adaptive Application software developers. A SoftwareComponentType model element is realized by C++ code. Which [SI](#_bookmark71)s such a component \"provides to\" or \"requires from\" the outside is expressed by ports. Ports are typed by [SI](#_bookmark71)s. P-ports express that the [SI](#_bookmark71), which types the port, is provided, while R-ports express, that the [SI](#_bookmark71), which types the port, is required by the SoftwareComponentType.

The figure [Figure](#_bookmark209) [7.6](#_bookmark209) gives a coarse idea, how the model view relates to the code implementation.

![](./media/image88.png)

**Figure 7.6:** []{#_bookmark209 .anchor}**meta-model to Implementation**

For both of the different SoftwareComponentTypes A and B from the example in the upper part (meta-model level) a concrete implementation exists on implementation level (lower part in the figure). The realization/implementation of R-Port of Soft- wareComponentType A is based on an instance of [ara::com](#_bookmark15) proxy class on imple- mentation level, while the P-Port implementation of SoftwareComponentType B is using an instance of [ara::com](#_bookmark15) skeleton class. Proxy and skeleton class are gener- ated from the [SI](#_bookmark71) definition [SI](#_bookmark71), which is referenced by the corresponding ports. In this example it is the [SI](#_bookmark71) \"RadarService\", which we already use throughout the document.

Such a code fragment, which realizes a SoftwareComponentType can obviously be re-used. On C++ implementation level an implementation of an AdaptiveAppli- cationSwComponentType typically boils down to one or several C++ classes. So re-use simply means instantiating this class/those classes in different contexts multiple times. Here we can basically distinguish the following cases:

- Explicit multiple instantiation of the C++ class(es) within Code.
- Implicit multiple instantiation by starting/running the same executable multiple times.

The first case still belongs to the realm of \"implementation level\".

![](./media/image89.png)

**Figure 7.7: Multiple Instantiation in Implementation Contexts**

The figure above shows an arbitrary example, where the implementations of A and B are instantiated in different contexts. On the lower left side there is an Executable 1, which directly uses two instances of As impl and one instance of Bs impl. Opposed to that, the right side shows an Executable 2, which \"directly\" (i.e. on its top most level) uses one instance of Bs impl and an instance of a composite software component, which itself \"in its body\" again instantiates one instance of As and Bs impl. Note: This natural implementation concept of composing software components from other compo- nents to a bigger/composite artefact is fully reflected in the AUTOSAR meta-model in the form of a CompositionSwComponentType, which itself is a SoftwareCompo- nentType and allows arbitrary recursive nesting/compositing of software components.

The second case on the other hand belongs to the realm of \"deployment level\" and shall be clarified in the following sub-chapter.

### Adaptive Application/Executables and Processes

Deployable software units within AP are so called Adaptive Applications (the corre- sponding meta-model element is AdaptiveAutosarApplication). Such an Adap- tive Application consists of 1..n executeables, which are in turn built up by instantiating CompositionSwComponentType (with arbitrary nesting) as described in the previ- ous chapter. Typically integrators then decide, which Adaptive Applications in the form of its 1..n executables they start at all and how many times they start a certain Adaptive

![](./media/image94.png)Application/its associated executables. That means for those kind of implicit instanti- ation no specific code has to be written! Integrators rather have to deal with machine configuration, to configure how many times Applications get started. A started Adaptive Application then turns into 1..n processes (depending on the number of executables it is made of). We call this then the \"deployment level\".

**Figure 7.8: Instantiation of Adaptive Applications in Deployment**

The figure above shows a simple example, where we have two Adaptive Applications, where each of those exactly consists of one executable. Adaptive Application 1 with Executable 1 is deployed twice, leading to Process 1 and Process 2 after executable start, where Application 2, which consists of Executable 2 is deployed once leading to Process 3 after start.

### Usage of meta-model identifiers within ara::com based application code

The explanations of meta-model/[ara::com](#_bookmark15) relation up to this point should help to understand the structure of instance specifiers used in ResolveInstanceIDs described in [4.3](#_bookmark94). As described in the previous chapter and depicted in [Figure](#_bookmark209) [7.6](#_bookmark209) the instance specifiers relate in a certain way to the corresponding port in the model of the SoftwareComponentType. If you followed the previous chapters the **port name** of the model alone isn't sufficient to clearly identify it in its final instantiation, where the same component implementation might be instantiated multiple times in the code and then eventually started multiple times in different processes. Instance IDs obviously have to be assigned to objects, which finally have a distinct identity in an deployment.

![](./media/image101.png)Process specific Service Instance Manifest

**Figure 7.9: InstanceIds in Deployment**

The figure above outlines the \"problem\" with a simple example. Within Executable 2 there are three instantiations of SoftwareComponentType B implementation in different contexts (nesting levels). All instances do provide a specific instance of SI RadarService. The integrator, who applies the Service Instance Manifest for Process 2 has to do the technical mapping on [ara::com](#_bookmark15) level. I.e. he has to de- cide, which technical transport binding is to be used in each of the B instantiations and subsequently also, which technical transport binding specific instance ID. In our example, the integrator wants to provide the SI RadarService via SOME/IP binding and an SOME/IP specific instance ID \"1\" in the context of the B instantiation, which is nested inside the composite component on the right side, while he decides to pro- vide the SI RadarService via local[IPC](#_bookmark70)(Unix domain socket) binding and a Unix domain socket specific instance ID \"/tmp/Radar/3\" and \"/tmp/Radar/4\" in the context of the B instantiations on the left side, which are not nested (they are instantiated at \"top-level\" of the executable). Here it gets obvious, that within the Service Instance Manifest, which allows to specify the mapping of port instantiations within a Process to techni- cal bindings and their concrete instance IDs, the sole usage of the **port name** from the model isn't sufficient to differentiate. To get unique identifiers within an executable (and therefore a process), the nature of nested instantiation and re-use of SoftwareCom- ponentTypes has to be considered. Every time a SoftwareComponentType gets instantiated, its instantiation gets a unique name within its instantiation context. This concept applies to both: C++ implementation level and AUTOSAR meta-model level! In our concrete example this means:

- B instantiations on top level get unique names on their level: \"B_Inst_1\" and \"B_Inst_2\"
- B instantiation within the Composite Component Type gets unique name on this level: \"B_Inst_1\"
- Composite Component instantiation on top level gets unique name on its level: \"Comp_Inst_1\"
- From the perspective of the executable/process, we therefore have unique iden- tifiers for all instances of B:

  - \"B_Inst_1\"
  - \"B_Inst_2\"
  - \"Comp_Inst_1::B_Inst_1\"

For an Adaptive Software Component developer this then means in a nutshell:

If you construct an instance specifier to be transormed via ResolveInstan- ceIDs() into an [ara::com::InstanceIdentifier](#_bookmark31) or used directly with Find- Service() (R-port side from model perspective) or as [ctor](#_bookmark23) parameter for a skeleton (P-port side from model perspective), it shall look like:

\<context identifier\>/\<port name\>

Port name is to be taken from the model, which describes the AdaptiveApplica- tionSwComponentType to be developed. Since you are not necessarily the person who decides where and how often your component gets deployed, you should fore- see, that your AdaptiveApplicationSwComponentType implementation can be handed over a stringified \<context identifier\>, which you

- either use directly, when constructing [ara::core::InstanceSpecifier](#_bookmark42) to instantiate proxies/skeleton, which reflect your own component ports.
- \"hand over\" to other AdaptiveApplicationSwComponentType implementa- tions, which you instantiate from your own AdaptiveApplicationSwCompo- nentType implementation (that is creating a new nesting level)

**Note**: Since AUTOSAR AP does **not** prescribe, how the component model on meta- model level shall be translated to (C++) implementation level, component instantiation (nesting of components) and \"handing over\" of the \<context identifier\> is up to the implementer! It might be a \"natural\" solution, to solve this by a \<context iden- tifier\> ctor parameter for multi instantiable AdaptiveApplicationSwCompo- nentTypes.

## Abstract Protocol Network Binding Examples

This chapter presents Abstract Protocol Network Bindings expamples using an In- stanceSpecifier.

![](./media/image107.jpeg){width="6.114093394575678in" height="2.4010411198600177in"}

**Figure 7.10: Find Service using abstract network binding**

![](./media/image108.jpeg){width="6.18in" height="2.715in"}

**Figure 7.11: Find Service using abstract network binding - ANY**

![](./media/image109.jpeg){width="6.24in" height="2.29in"}

**Figure 7.12: Skeleton creation using abstract network bindings**

![](./media/image110.jpeg){width="6.255in" height="2.01in"}

**Figure 7.13: Multiple usage of the same service instance manifest for an abstract binding**

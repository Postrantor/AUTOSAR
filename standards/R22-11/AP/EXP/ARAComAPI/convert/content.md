---
tip: translate by openai@2023-06-27 13:26:40
...

1. [Preface](#preface) 9

> [前言](#preface) 9

2. [Acronyms and Abbreviations](#acronyms-and-abbreviations) 10

> 2.[首字母缩略词和缩写](#acronyms-and-abbreviations) 10

3. [Introduction](#introduction) 13

> 3. [介绍](#introduction) 13

   1. [Approach](#approach) 13

> 1. [方法](#approach) 13

   2. [API Design Visions and Guidelines](#api-design-visions-and-guidelines) 15

> 2. [API 设计愿景和准则](#api-design-visions-and-guidelines) 15

4. [Fundamentals](#fundamentals) 17

> 4. [基础](#fundamentals) 17

   1. [Proxy/Skeleton Architecture](#proxyskeleton-architecture) 17

> 1. [代理/骨架架构](#proxyskeleton-architecture) 17

   2. [Means of Communication](#means-of-communication) 18

> 2.[通信方式](#means-of-communication) 18

   3. [ara::com Event and Trigger based communication](#aracom-event-and-trigger-based-communication) 18

> 3. [ara::com 事件和触发基于通信](#aracom-event-and-trigger-based-communication) 18

   4. [ara::com Method based communication](#aracom-method-based-communication) 19

> 4. [ara::com基于方法的通信](#aracom-method-based-communication) 19

   5. [ara::com Field based communication](#aracom-field-based-communication) 20

> 5. [ara::com基于字段的通信](#aracom-field-based-communication) 20

   6. [Data Type Abstractions](#data-type-abstractions) 21

> 6. [数据类型抽象](#data-type-abstractions) 21

   7. [Error Handling](#error-handling) 22

> 7. [错误处理](#error-handling) 22

   8. [Service Connection Approach](#service-connection-approach) 22

> 8. [服务连接方法](#service-connection-approach) 22
      1. [Instance Identifiers and Instance Specifiers](#instance-identifiers-and-instance-specifiers) 22
      2. [When to use InstanceIdentifier versus InstanceSpecifier](#when-to-use-instanceidentifier-versus-instancespecifier) 25
         1. [Transfer of an InstanceIdentifier](#transfer-of-an-instanceidentifier) 26

5. [Detailed API description](#detailed-api-description) 27

> 5. [详细的API描述](#detailed-api-description) 27

   1. [High Level API Structure](#high-level-api-structure) 27

> [高级API结构](#high-level-api-structure) 27

   2. [API Elements](#api-elements) 27

> 2. [API 元素](#api-elements) 27

   3. [Proxy Class](#proxy-class) 29

> 3. [代理类](#proxy-class) 29
      1. [Proxy Class API's](#proxy-class-apis) 30
      2. [RadarService Proxy Class Example](#radarservice-proxy-class-example) 30
      3. [Constructor and Handle Concept](#constructor-and-handle-concept) 33
      4. [Finding Services](#finding-services) 34
         1. [Auto Update Proxy instance](#auto-update-proxy-instance) 35
      5. [Events](#events) 38
         1. [Event Subscription and Local Cache](#event-subscription-and-local-cache) 41
         2. [Monitoring Event Subscription](#monitoring-event-subscription) 42
         3. [Accessing Event Data --aka Samples](#accessing-event-data-aka-samples) 45
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

> 4. [骨架类](#skeleton-class) 63
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

> 5. [服务接口层的数据类型](#data-types-on-service-interface-level) 85
      1. [Optional data elements](#optional-data-elements) 85

   6. [Raw Data Streaming Interface](#raw-data-streaming-interface) 88

> 6. [原始数据流接口](#raw-data-streaming-interface) 88
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

> 7. [通讯组](#communication-groups) 94
      1. [Objective](#objective) 94
      2. [Realization](#realization) 94
      3. [Usage Scope](#usage-scope) 95
      4. [Special Topics](#special-topics) 96
         1. [Architecture](#5.7.4.1_Architecture) 96
         2. [Remote Connection](#remote-connection) 97
         3. [Service Versioning](#service-versioning) 97

6. [Tutorials](#tutorials) 98

> 6. [教程](#tutorials) 98

   1. [Usage of Service Interfaces](#usage-of-service-interfaces) 98

> 使用服务接口（#使用服务接口）98
      1. [Service Interface Deployment](#service-interface-deployment) 98
      2. [Service Instance Deployment](#service-instance-deployment) 99
      3. [Service Implementation](#service-implementation) 103

   2. [Usage of InstanceSpecifier](#usage-of-instancespecifier) 104

> 2.[实例规范器的使用](#usage-of-instancespecifier) 104
      1. [Modeling and configuration/mapping over Manifest from user perspective](#modeling-and-configurationmapping-over-manifest-from-user-perspective) 106
      2. [Instance IDs only for provided Services](#instance-ids-only-for-provided-services) 109

   3. [Usage in context of MultiBinding](#usage-in-context-of-multibinding) 109

> 3.[多绑定的上下文中的使用](#usage-in-context-of-multibinding) 109

   4. [Usage of RawDataStreaming](#usage-of-rawdatastreaming) 114

> 4. [使用RawDataStreaming](#usage-of-rawdatastreaming) 114
      1. [Sequence diagrams](#sequence-diagrams) 114
      2. [Usage](#usage) 116
         1. [Example of usage as server](#example-of-usage-as-server) 116
         2. [Example of usage as client](#example-of-usage-as-client) 117

   5. [Usage of CommunicationGroups](#usage-of-communicationgroups) 118

> 5. [使用 CommunicationGroups](#usage-of-communicationgroups) 118
      1. [Setup](#setup) 118
         1. [Service Interface Description Generation](#service-interface-description-generation) 118
         2. [Proxy and Skeleton Generation](#proxy-and-skeleton-generation) 120
      2. [Example](#example) 121

7. [Appendix](#appendix) 125

> 7. [附录](#附录) 125

   1. [Serialization](#serialization) 125

> 1. [序列化](#serialization) 125
      1. [Zero-Copy implications](#zero-copy-implications) 126

   2. [Service Discovery Implementation Strategies](#service-discovery-implementation-strategies) 126

> 2. [服务发现实施策略](#service-discovery-implementation-strategies) 126
      1. [Central vs Distributed approach](#central-vs-distributed-approach) 127

   3. [Multi-Binding implications](#multi-binding-implications) 130

> 3. [多重绑定的影响](#multi-binding-implications) 130
      1. [Simple Multi-Binding use case](#simple-multi-binding-use-case) 130
      2. [Local/Network Multi-Binding use case](#localnetwork-multi-binding-use-case) 133
      3. [Typical SOME/IP Multi-Binding use case](#typical-someip-multi-binding-use-case) 134

   4. [ara::com and AUTOSAR meta-model relationship](#aracom-and-autosar-meta-model-relationship) 136

> 4.[ara::com和AUTOSAR元模型关系](#aracom-and-autosar-meta-model-relationship) 136
      1. [Connection to AUTOSAR_TR_AdaptiveMethodology](#connection-to-autosar_tr_adaptivemethodology) 137
      2. [Service Interface](#service-interface) 137
      3. [Software Component](#software-component) 138
      4. [Adaptive Application/Executables and Processes](#adaptive-applicationexecutables-and-processes) 140
      5. [Usage of meta-model identifiers within ara::com based appli-](#usage-of-meta-model-identifiers-within-aracom-based-application-code) [cation code](#usage-of-meta-model-identifiers-within-aracom-based-application-code) 141

   5. [Abstract Protocol Network Binding Examples](#abstract-protocol-network-binding-examples) 143

> 5. [抽象协议网络绑定示例](#abstract-protocol-network-binding-examples) 143

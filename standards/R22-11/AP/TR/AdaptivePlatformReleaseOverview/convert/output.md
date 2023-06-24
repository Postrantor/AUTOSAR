---
tip: translate by openai@2023-06-24 11:29:05
...

# Contents

```
1 Introduction 6
  1.1 Scope of this document . . . . . . . . . . . . . . . . . . . . . . . . . . 6
  1.2 Terminology and Licenses . . . . . . . . . . . . . . . . . . . . . . . . . 6
    1.2.1 Terminology statement . . . . . . . . . . . . . . . . . . . . . 6
    1.2.2 Usage of W3C XML schema . . . . . . . . . . . . . . . . . . 6
  1.3 AUTOSAR Standards . . . . . . . . . . . . . . . . . . . . . . . . . . . . 7
    1.3.1 Introduction . . . . . . . . . . . . . . . . . . . . . . . . . . . . 7
    1.3.2 Definition . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 7
    1.3.3 Overview on AUTOSAR’s Standards . . . . . . . . . . . . . . 8
      1.3.3.1 Adaptive Platform . . . . . . . . . . . . . . . . . . . . 8
      1.3.3.2 Classic Platform . . . . . . . . . . . . . . . . . . . . 8
      1.3.3.3 Foundation . . . . . . . . . . . . . . . . . . . . . . . 8
    1.3.4 Naming scheme for files and specification items . . . . . . . 8
    1.3.5 Dependencies between Standards . . . . . . . . . . . . . . . 9
    1.3.6 Dependencies to other Standards . . . . . . . . . . . . . . . 9
  1.4 Release Numbering and Life Cycle . . . . . . . . . . . . . . . . . . . . 10
    1.4.1 Release life cycle of a major release . . . . . . . . . . . . . . 10
    1.4.2 Life cycle states of specification items and requirements . . . 10
    1.4.3 Platform release number . . . . . . . . . . . . . . . . . . . . 11
    1.4.4 Internal release number . . . . . . . . . . . . . . . . . . . . . 11
    1.4.5 Overview of AUTOSAR releases and corresponding AUTOSAR schema versions . . . . . . . . . . . . . . . . . . 11
  1.5 Introduction to the Adaptive Platform . . . . . . . . . . . . . . . . . . . 12
    1.5.1 Release strategy . . . . . . . . . . . . . . . . . . . . . . . . . 12
    1.5.2 Parallel validation of specification via implementation . . . . 13
    1.5.3 Specification depth . . . . . . . . . . . . . . . . . . . . . . . 14
  1.6 Content of chapters . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14

2 Summary of changes 15
  2.1 Release R22-11 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
    2.1.1 Concepts . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
      2.1.1.1 Introduced Concepts . . . . . . . . . . . . . . . . . . 15
      2.1.1.2 Impact of Concepts . . . . . . . . . . . . . . . . . . . 16
      2.1.1.3 Validated Concepts . . . . . . . . . . . . . . . . . . . 18
    2.1.2 Specifications . . . . . . . . . . . . . . . . . . . . . . . . . . 18
      2.1.2.1 New Specifications . . . . . . . . . . . . . . . . . . . 18
      2.1.2.2 Migrated Specifications . . . . . . . . . . . . . . . . 19
      2.1.2.3 Obsolete Specifications . . . . . . . . . . . . . . . . 19
      2.1.2.4 Removed Specifications . . . . . . . . . . . . . . . . 19
      2.1.2.5 Reworked Specifications . . . . . . . . . . . . . . . . 19
      2.1.2.6 Moved Specification parts . . . . . . . . . . . . . . . 19
      2.1.2.7 Renamed Specifications . . . . . . . . . . . . . . . . 19
      2.1.2.8 Life Cycle State of Metamodel . . . . . . . . . . . . . 20
    2.1.3 Release Documentation . . . . . . . . . . . . . . . . . . . . . 20
  2.2 History information in AUTOSAR . . . . . . . . . . . . . . . . . . . . . 20

3 Specification overview 21

4 Remarks to known technical deficiencies 24
  4.1 Specification of Platform Health Management (UID 851, SWS) . . . . 24
  4.2 Specification of Time Synchronization (UID 880, SWS) . . . . . . . . . 26
  4.3 Specification of Update and Configuration Management (UID 888, SWS) 27
  4.4 Specification of State Management (UID 908, SWS) . . . . . . . . . . 27
  4.5 Specification of Language Binding for modeled AP data types (UID
  994, SWS) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28

5 Release history 29
  5.1 Release R22-11 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
```

# 1. Introduction

## 1. Scope of this document

This document provides an overview of the AUTOSAR standard Adaptive Platform release R22-11.

> 这份文件概述了 AUTOSAR 标准自适应平台发布 R22-11。

## 2. Terminology and Licenses

### 1. Terminology statement

AUTOSAR has identified a use of previously common terminology that can be considered oppressive or racist, such as master/slave and black/white list, or in other contexts such as gender or age as harmful connotations. AUTOSAR has started a discussion with all the working groups to replace these terms. AUTOSAR is committed to provide all specification documents without these terminology in the coming and future releases. Nevertheless, it may take several releases before the terms are completely replaced, as AUTOSAR has to continue its operations and thousands of pages of existing specifications have to be reviewed and updated in parallel.

> AUTOSAR 已经发现，**以前常用的术语可能具有压迫性或种族歧视性，比如主/从和黑/白名单**，或者在其他诸如性别或年龄的上下文中具有有害的内涵。AUTOSAR 已经开始与所有工作组进行讨论，以替换这些术语。AUTOSAR 致力于在未来的发布版本中提供没有这些术语的所有规范文件。但是，**在完全替换这些术语之前，可能需要几个发布版本**，因为 AUTOSAR 必须继续运行，而且必须同时审查和更新数千页现有规范。

### Usage of W3C chat

The AUTOSAR XML Schema requires the XML namespace definition file xml.xsd.

> AUTOSAR XML 模式需要 XML 命名空间定义文件 xml.xsd。

There are several occurrences of the \"xml.xsd\" file within this release. For all occurrences the W3C license applies which can be found on [https://www.w3.org/](https://www.w3.org/Consortium/Legal/2015/copyright-software-and-document) [Consortium/Legal/2015/copyright-software-and-document](https://www.w3.org/Consortium/Legal/2015/copyright-software-and-document).

> 在这次发布中有几个"xml.xsd"文件的出现。对于所有出现的情况，W3C 许可证适用，可以在[Consortium/Legal/2015/copyright-software-and-document]上找到。

By obtaining and/or copying this work, you (the licensee) agree that you have read, understood, and will comply with the following terms and conditions.

> 通过获取和/或复制本作品，您(许可人)同意您已阅读、理解并将遵守以下条款和条件。

Permission to copy, modify, and distribute this work, with or without modification, for any purpose and without fee or royalty is hereby granted, provided that you include the following on ALL copies of the work or portions thereof, including modifications:

> 本作品的复制、修改和发布权，无论是否修改，均无需付费或支付版税，并且允许任何用途，特此授权。在所有复制、修改或部分复制、修改的作品上，包括修改后的作品，均须标明以下内容：

The full text of this NOTICE in a location viewable to users of the redistributed or derivative work. Any pre-existing intellectual property disclaimers, notices, or terms and conditions. If none exist, the W3C Software and Document Short Notice should be included. Notice of any changes or modifications, through a copyright statement on the new code or document such as "This software or document includes material copied from or derived from [title and URI of the W3C document]. Copyright *⃝*c (MIT, ERCIM, Keio, Beihang)."

> 此通知的完整文本应在重新分发或衍生作品的用户可见的位置上发布。任何预先存在的知识产权免责声明、通知或条款和条件。如果没有，应包括 W3C 软件和文档简短通知。有关任何更改或修改的通知，应在新代码或文档上发布版权声明，如“此软件或文档包括从[W3C 文档的标题和 URI]拷贝或派生的材料。版权*⃝*c(MIT、ERCIM、Keio、Beihang)。”

THIS WORK IS PROVIDED "AS IS," AND COPYRIGHT HOLDERS MAKE NO REPRESENTATIONS OR WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO, WARRANTIES OF MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE OR THAT THE USE OF THE SOFTWARE OR DOCUMENT WILL NOT INFRINGE ANY THIRD PARTY PATENTS, COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS.

> 这项工作按“原样”提供，版权持有人不作任何明示或暗示的陈述或担保，包括但不限于商业适售性或适用于特定用途的担保，或者使用软件或文档不侵犯任何第三方专利，版权，商标或其他权利。

COPYRIGHT HOLDERS WILL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF ANY USE OF THE SOFTWARE OR DOCUMENT.

> 版权持有人不就任何使用本软件或文档而引起的任何直接、间接、特殊或间接损害负责。

The name and trademarks of copyright holders may NOT be used in advertising or publicity pertaining to the work without specific, written prior permission. Title to copyright in this work will at all times remain with copyright holders.

> 版权持有人的名称和商标不得在与作品有关的广告或宣传中使用，除非事先取得书面特别授权。本作品的版权将始终由版权持有人拥有。

## 3. AUTOSAR Standards

### 1. Introduction

AUTOSAR addresses a wide range of use cases in automotive software development with its standards. These use cases have different requirements and lead to different technical solutions.

> AUTOSAR 通过其标准，解决汽车软件开发的各种用例。这些用例有不同的要求，从而导致不同的技术解决方案。

Packaging its deliverables into different \"standards\"

- eases the access to AUTOSAR solutions for users and
- allows AUTOSAR to scale with market needs.

> [!NOTE]@gpt-3.5
> 在 AUTOSAR 中，“Packaging its deliverables into different \"standards\"” 表示将 AUTOSAR 软件组件或其他交付成果，**按照不同的标准或标准化形式进行打包**。这些标准可以是 AUTOSAR 自身定义的标准，也可以是行业内其他组织或标准机构制定的标准。例如，AUTOSAR 标准中定义了不同的软件组件接口规范，不同的软件模块规范等，这些都是 AUTOSAR 内部的标准。此外，AUTOSAR 标准还可以与其他行业标准（如 ISO、IEC）或厂商标准（如 Bosch、Continental）进行对接，共同制订推广的标准。
>
> 这种打包方式可以使 AUTOSAR 的解决方案更易于用户使用，因为用户可以按照自身具体需求，选择符合自身需要的标准化形式，而不需要自己进行自定义的处理。同时，AUTOSAR 的打包方式也能够随着市场需求的变化而发生变化，使得 AUTOSAR 可以更好地扩展和适应市场的变化。例如，随着新的技术和应用领域出现，AUTOSAR 可以与行业内的其他组织或标准机构合作，制订新的标准或升级既有的标准，以切实满足市场的需求。

### 2. Definition

An AUTOSAR standard is a consistent set of AUTOSAR deliverables, which are released at the same time. AUTOSAR deliverables can, but are not limited to be of the following kinds:

- textual explanations
- textual specifications
- test specifications
- source code
- other formal or semi-formal textual formats (e.g., ARXML, UML models, XML Schemata)

At the time of release, AUTOSAR ensures that dependencies are fulfilled.

> AUTOSAR 标准是由一系列 AUTOSAR 可交付物（或成果物）组成的一致集合，这些可交付物一般都会在同一时间发布。这些可交付物包括但不限于以下几个方面：
>
> - 文本解释说明：用文字方式阐述 AUTOSAR 标准的相关内容，可以是技术文档、说明文档、白皮书等形式。
> - 文本规格说明：用文字方式定义 AUTOSAR 标准的相关规范，可以包括软件架构、数据模型、接口定义等。
> - 测试规格说明：用文字说明、测试用例等方式测试实现 AUTOSAR 标准的软件或系统。
> - 源代码：实现 AUTOSAR 标准的相关源代码，可用于开发和构建 AUTOSAR 系统或软件。
> - 其他形式的正式或半正式文本格式：例如 ARXML、UML 模型、XML 模式等。
>
> 在发布可交付物的同时，AUTOSAR 还确保所有的依赖关系都得到了满足，以保证各个可交付物能够相互配合、相互兼容，构成一个完整的 AUTOSAR 标准。

### Overview on AUTOSAR's Standards

AUTOSAR delivers the following standards:

### Adaptive Platform

The Adaptive Platform is AUTOSAR's solution for high-performance computing ECUs to build safety-related systems for use cases such as highly automated and autonomous driving.

> <font color=Red><b>AUTOSAR 的自适应平台是高性能计算 ECU 构建安全相关系统的解决方案，用于高度自动化和自主驾驶等用例。</b></font>

### Classic Platform

The Classic Platform is AUTOSAR's solution for embedded systems with hard real-time and safety constraints.

> 经典平台(Classic Platform)是 AUTOSAR 为嵌入式系统提供的**硬实时和安全约束**的解决方案。

### Foundation

The purpose of the Foundation standard is to enforce interoperability between the AUTOSAR platfoms.

> 标准基金会的**目的是强制 AUTOSAR 平台之间的 <font color=red><b>互操作性</b></font>**。

Foundation contains the generic artifacts that are common for AP and CP to ensure compatibility between

> 基金会包含 AP 和 CP 之间的兼容性所必需的通用工件：

- Classicand Adaptive Platform
- Non-AUTOSAR platforms to AUTOSAR platforms

  ### 1. Naming scheme for files and specification items

AUTOSAR is in the course of extending the naming scheme for files and specification items. The objective is to consistently include the AUTOSAR Standard to which the file or specification item belongs in the name. This addition also provides namespaces for the three AUTOSAR Standards and avoids conflicting names for specifications on the same topic in different AUTOSAR Standards. According to the new naming scheme, the abbreviation of the AUTOSAR Standard (AP, CP or FO) is added as first part of specification item IDs and as second part of file names. For details, please refer to [1](#_bookmark0).

> AUTOSAR 正在拓展文件和规范项目的命名方案。其目的是一致地将所属的 AUTOSAR 标准包括在名称中。这个添加也为三个 AUTOSAR 标准提供了命名空间，避免了不同 AUTOSAR 标准中同一个主题的规范出现冲突的名称。根据新的命名方案，**<font color=red><b>AUTOSAR 标准的缩写(AP，CP 或 FO)</b></font>**将作为规范项目 ID 的第一部分，以及文件名的第二部分。有关详细信息，请参见[1]。

> [!NOTE]@gpt-3.5
> [](E:\Download\Documents\ChatGPT\dialogue\autosat\tr_20230624.md)
> 当提到 "AUTOSAR 标准" 时，其实指的是 AUTOSAR 基础软件（BSW）的不同版本，因为 AUTOSAR 的标准主要是关于 BSW 的。不同的版本号会被区分，用缩写来表示，以便于更好地管理和防止不同版本之间的混淆。 根据命名方案，可以使用以下缩写：
>
> - AP: AUTOSAR Platform, 表示 AUTOSAR 平台标准
> - CP: AUTOSAR Classic Platform, 表示 AUTOSAR 经典平台标准
> - FO: AUTOSAR Flexible Platform, 表示 AUTOSAR 弹性平台标准
>
> 这三个缩写分别指代 AUTOSAR 不同的标准版本，其中，AP 标准是 AUTOSAR 4.x 版本的标准，CP 标准是早期 AUTOSAR 软件的标准，是它的先前版本。FO 标准是 AUTOSAR Adaptive Platform 的一部分，是针对更现代、更高级的车载应用程序设计而设计的。使用不同的缩写可以避免命名冲突，同时也能更好地区分和管理不同的标准。
>
> @Q:
> 可以对 FO 标准进一步介绍吗
> @A:
> FO 标准是 AUTOSAR 弹性平台的标准。相比于传统的 AUTOSAR Classic Platform（CP）和 AUTOSAR Platform（AP）标准，FO 标准更加灵活多样，能够适应更广泛的应用场景。主要区别如下：
>
> 1. 架构：FO 弹性平台标准采用了基于 API 的服务架构，这样做的好处是开发者可以利用和整合平台提供的服务，而不必了解底层实现。
> 2. 运行时环境：FO 弹性平台提供了一种适应不同硬件和网络的运行时环境，使得执行 AUTOSAR 应用程序的硬件和网络更加灵活。
> 3. 安全性：FO 弹性平台要求系统必须具有一定的安全性能力，以防止跨车和跨领域攻击，所以被设计成支持安全通信。
>    FO 标准的出现，是为了应对越来越多的现代、高级的车载应用程序设计需求，包括自动驾驶、车联网等。基于 FO 标准的 AUTOSAR Adaptive Platform 可以更好地支持这些应用程序，并更好地促进了 AUTOSAR 技术的发展。

From R22-11 onwards, specification items in newly introduced specifications follow the new naming scheme. In R22-11, file names are not yet changed.
From R23-11 onwards, the names of all files that are part of the release will follow the new naming scheme.

> 从 R22-11 开始，新引入的规格中的规格项目遵循新的命名方案。在 R22-11 中，文件名尚未更改。
> 从 R23-11 开始，所有属于发行的文件的名称都将遵循新的命名方案。

The IDs of existing specification items are not changed to avoid issues and migrations for AUTOSAR Partners that use these IDs internally.

> 现有规范项目的 ID 不会改变，以避免 AUTOSAR 合作伙伴在内部使用这些 ID 时出现问题和迁移问题。

### Dependencies between Standards

Each release of Classic and Adaptive Platform relies on a dedicated version of Foundation. The specific dependency is documented in chapter [1.4.5](#overview-of-autosar-releases-and-corresponding-autosar-schema-versions).

> 每个 Classic 和 Adaptive 平台的发行版都依赖于一个专门的 Foundation 版本。具体的依赖关系在[1.4.5]章节中有文档说明。

> ![](./media/fig_1.1.png)
> .**Figure 1.1: Dependencies of AUTOSAR Standards**

### Dependencies to other Standards

This release of the Adaptive Platform depends on the standard Foundation in release R22-11, which

- defines protocols implemented by Adaptive Platform
- contains the project objectives and the common requirements from which the features of the Adaptive Platform are derived
- contains common specification parts which apply to both, the Adaptive Platform and the Classic Platform

These dependencies are refined in the trace information of the requirements in the respective specifications.

> [!NOTE]@gpt-3.5
> 上述内容是指 Autosar 规范中的自适应平台 Release 版本依赖于 R22-11 版本的标准 Foundation（即基础规范）。该 Foundation 规范中定义了自适应平台实现的协议，包含项目目标以及公共要求，这些要求是自适应平台功能的来源，并且包含适用于自适应平台和经典平台的公共规范部分。**在各自规范中的需求跟踪信息中详细说明了这些依赖关系。**
>
> 具体来说，自适应平台是在 Autosar 基础规范的基础上进行开发的，因此必须遵守基础规范中定义的协议和规则。而该规范版本 R22-11 除了定义自适应平台需要遵守的基础规范外，还定义了自适应平台的协议和项目要求，以及适用于两种平台的公共规范部分。自适应平台的各种功能要求都要在基础规范和 R22-11 中进行跟踪，以确保其满足规范中的所有要求。

## Release Numbering and Life Cycle

### Release life cycle of a major release

Each major release goes through four consecutive steps within its life cycle (examples based on the internal release numbering scheme):

> 每个主要版本在其生命周期内都会经历四个连续步骤(基于内部发布编号方案的示例)：

1. Development: Between start of life cycle and the initial release (e.g., R4.0.1)
2. Evolution: Following the initial release with zero, one or several minor releases and/or revisions (e.g., R4.0.2, R4.1.1)
3. Maintenance: No new content is added to a major release but only maintenance of the existing content with zero, one or several revisions (e.g., R3.2.2) is provided
4. Issue Notice: No more revisions but zero, one or several issue notices, i.e., updates of the list of known issues until end of life cycle.

> 1. 开发：从生命周期开始到初始发布(例如 R4.0.1)
> 2. 进化：在最初发布后，可以进行零、一个或多个小版本和/或修订(例如 R4.0.2、R4.1.1)
> 3. 维护：不会向主版本添加新内容，只会对现有内容进行零、一或多次修订(例如，R3.2.2)的维护。
> 4. 发布通知：不再进行修订，但可以发布零、一或多个发布通知，即在整个生命周期结束前更新已知问题列表。

> ![](./media/fig_1.2.png)
> .**Figure 1.2: Life cycle model of AUTOSAR standards**

### Life cycle states of specification items and requirements

The life cycle state of a specification item is found after the specification item ID surrounded by curly brackets. The states are:

> 规格项目的生命周期状态是由大括号括起来的规格项目 ID 后面发现的。状态有：

- {Valid}: This indicates that the related entity is a valid part of the document. This is the default and also applies if no dedicated life cycle status is annotated for the related entity.

> 这表明相关实体是文档的有效部分。这是默认设置，如果没有为相关实体注释专用生命周期状态，也适用。

- {Draft}: This indicates that the related entity is newly introduced but still experimental. This information is published but is subject to change without backward compatibility guarantee.

> 这表明相关实体是新引入的，但仍处于试验阶段。此信息已发布，但可能会更改，而无需向后兼容性保证。

- {Obsolete}: This indicates that the related entity is subject to be removed in one of the following releases without further notice.

> 这表明相关实体在接下来的发布版本中可能会被删除，而不再另行通知。

The life cycle state of a requirement is found in the attribute \"type\". The states are the same as the specification item states.

> "要求的生命周期状态可以在属性“类型”中找到。状态与规格项状态相同。"

### Platform release number

AUTOSAR applies a four-digit numbering scheme Ryy-mm to identify releases. The identifiers "yy" and "mm" depict the year and month of the release date, e.g., R20-11 for the November 2020 release.

> AUTOSAR 采用四位数的编号方案 Ryy-mm 来识别发布版本。标识符"yy"和"mm"描述发布日期的年份和月份，例如，2020 年 11 月的发布版本为 R20-11。

### Internal release number

AUTOSAR additionally maintains an internal release number for different purposes (e.g., usage in BSW modules in Classic Platform).

> AUTOSAR 除此之外，还为不同的目的维护了一个内部发布号(例如，在 Classic Platform 中的 BSW 模块中使用)。

The internal release number is used for all platforms and follows up on the Classic Platform release number. In Adaptive Platform this is newly introduced. In Foundation this leads to a discontinuation of the former numbering pattern (e.g., R1.5.0).

> **内部发行号用于所有平台，并跟踪经典平台发行号。** 在自适应平台上，这是新引入的。在基础上，这导致了以前的编号模式(例如 R1.5.0)的中断。

A mapping list between Platform Releases and corresponding internal release numbers can be found in chapter [1.4.5](#overview-of-autosar-releases-and-corresponding-autosar-schema-versions). The internal release number uses a three-digit numbering scheme `R\<major\>.\<minor\>.\<revision\>` to identify releases. Its primary purpose is to identify a release as

> 在[1.4.5]章节可以找到平台发行版和对应的内部发行号之间的映射列表。内部发行号使用三位数字编号 `R\<major\>.\<minor\>.\<revision\>`来标识发行版本。它的主要目的是标识一个发行版本。

- a major release: Valid and draft specification parts may be changed backward incompatibly.
- a minor release: Valid specification parts may only be changed backward compatibly. Draft specification parts may be changed backward incompatibly.
- a revision: Does not contain extensions but only backward compatible bugfixes.

> - 一个主要的版本发布: 可有效和草案规范的部分**可能会发生不向后兼容的更改**。
> - 一个次要的版本发布: 可有效规范的部分只能进行向后兼容的更改。 草案规范的部分**可能会发生不向后兼容的更改**。
> - 修订版本: 不包含扩展，只包含向后兼容的错误修正。

### Overview of AUTOSAR releases and corresponding AUTOSAR schema versions

Until the Releases CP R4.4.0 and AP R19-03, AUTOSAR released the platforms separately where a Foundation release went along with each platform release. Since compatibility between the platforms is essential to be able to have AP and CP ECUs within one vehicle project, an XML schema needs to be available that works with the different releases. The following table gives an overview about the different schema versions and the corresponding platform releases they can be used for.

> 直到发布 CP R4.4.0 和 AP R19-03，AUTOSAR 分别发布了平台。每个平台发布都伴随着一个基础发布。由于平台之间的兼容性对于在一个车辆项目中拥有 AP 和 CP ECU 至关重要，因此需要一个可以用于不同发布的 XML 模式可用。下表概述了不同模式版本及其可用于的相应平台发布。

The AUTOSAR schema does not have an impact on the Foundation. The Foundation releases are mentioned for the sake of completeness.

> AUTOSAR 架构不会对 Foundation 产生影响。 为了完整性，仍然提及 Foundation 发布版本。

```
---
Schema Version    Classic Platform release   Adaptive Platform release   Foundation release
---
AUTOSAR_00042     R4.3.0                     R17-03                      R1.1.0
AUTOSAR_00043     R4.3.0                     R17-10                      R1.2.0
AUTOSAR_00044     R4.3.1                     R17-10                      R1.3.0
AUTOSAR_00045     R4.3.1                     R18-03                      R1.4.0
AUTOSAR_00046     R4.4.0                     R18-10                      R1.5.0
AUTOSAR_00047     R4.4.0                     R19-03                      R1.5.1
-------------------------------------------------------------------------------
```

Starting with release R19-11, all platforms are released as one AUTOSAR release and therefore come along with one schema version.

> 从发行版 R19-11 开始，所有平台都以一个 AUTOSAR 发行版发布，因此携带一个模式版本。

```
---
Schema Version          Platform release        Internal release number
---
AUTOSAR_00048           R19-11                  R4.5.0
AUTOSAR_00049           R20-11                  R4.6.0
AUTOSAR_00050           R21-11                  R4.7.0
**AUTOSAR_00051**       **R22-11**              **R4.8.0**
----------------------------------------------
```

According to the release life cycle of AUTOSAR the release R22-11 is a minor release.

> 根据 AUTOSAR 的发布生命周期，**R22-11 是一个次要发布**。

## Introduction to the Adaptive Platform

The AUTOSAR Adaptive Platform is the standardized platform for microprocessorbased ECUs supporting use cases like highly automated driving as well as high speed on-board and off-board communication.

> <font color=red><b>AUTOSAR 自适应平台是用于支持高度自动驾驶以及高速车载和车外通信等用例的微处理器基础 ECU 的标准化平台。</b></font>

The Adaptive Platform differs in a number of aspects from the standardization approach of the Classic Platform:

> 适应性平台在许多方面与经典平台的标准化方法不同。

- Parallel validation of specification via software implementation
- Specification of functional clusters instead of modules

> - 通过软件实施对规范的平行验证
> - 功能簇的规格而不是模块

### Release strategy

The Adaptive Platform has changed its life cycle state to \"Evolution\" according to AUTOSAR's life cycle model for its standards (as depicted in chapter [1.4.1](#release-life-cycle-of-a-major-release)). Since R19-11, AUTOSAR releases the Adaptive Platform together with the Classic Platform and Foundation in a yearly cycle. The life cycle state "Evolution" implies that users of the Adaptive Platform have a guarantee on backward compatibility for certain parts of the specifications. The differentiation is handled by the life cycle state of the requirements and specification items according to chapter [1.4.2](#life-cycle-states-of-specification-items-and-requirements).

> 适应性平台根据 AUTOSAR 的生命周期模型，已将其生命周期状态更改为“演变”(如第[1.4.1]节所示)。自 R19-11 以来，**AUTOSAR 每年发布适应性平台，并与经典平台和基础架构一起发布**。“演变”的生命周期状态意味着适应性平台的用户可以对规范的某些部分保证向后兼容性。根据第[1.4.2]节，要求和规范项的生命周期状态可以进行区分。

### Parallel validation of specification via implementation

The Adaptive Platform is partially validated through an AUTOSAR-internal implementation: the Adaptive Platform Demonstrator. The Demonstrator release is available to all the partners and can provide further details to understand the underlying concepts of the Adaptive Platform. The Adaptive Platform Demonstrator is an exemplary implementation of the Adaptive Platform specifications. All further usage based on the Demonstrator (e.g. in production) will become the responsibility of the respective partner. For legal constraints see the dedicated paragraphs in the Development Agreement.

> 适应性平台部分通过 AUTOSAR 内部实现进行验证：适应性平台演示器。演示器版本对所有合作伙伴都可用，可以提供更多细节来了解适应性平台的基本概念。适应性平台演示器是适应性平台规范的一个示范实现。所有基于演示器的进一步使用(例如在生产中)将成为各自合作伙伴的责任。有关法律限制，请参见开发协议中的相关段落。

For the current releases, the Demonstrator software implementation has undergone only informal reviews with no strict quality assurance. AUTOSAR is increasing the quality assurance significantly to ensure the quality criteria given by the project.

> 对于当前发行版，演示软件实现只经历了非正式审查，没有严格的质量保证。AUTOSAR 正大大提高质量保证，以确保项目给出的质量标准。

The Demonstrator comes with traceability up to the specifications to document the validation aspect.

> 演示者带来了可追溯到规格的能力，以文档化验证方面的需求。

Additionally AUTOSAR develops System Test specifications and implementation to support the test of the demonstrator implementation against the AUTOSAR requirements. These tests are also part of the release.

> 此外，<font color=red><b>AUTOSAR 还开发了系统测试规范和实现，以支持对 AUTOSAR 要求的演示实现的测试</b></font>。这些测试也是发布的一部分。

> ![](./media/fig_1.3.jpeg)
> .**Figure 1.3: Overview of the AUTOSAR Adaptive Platform Demonstrator**

### Specification depth

Based on the development history of the Classic Platform, AUTOSAR has decided to specify functional clusters instead of a specific software architecture to provide the implementers with options to find efficient solutions for the standardized features.

> 根据 Classic 平台的发展历史，<font color=red><b>AUTOSAR 决定指定功能群，而不是特定的软件架构，为实施者提供选择，以便为标准功能找到有效的解决方案</b></font>。

## Content of chapters

This document is structured as follows:

- Chapter [1](#introduction) provides an introduction to AUTOSAR's release strategy, the Adaptive Platform and its standardization approach.
- Chapter [2](#summary-of-changes) provides a summary of changes since the previous release of the Adaptive Platform.
- Chapter [3](#specification-overview) contains the overview of specifications comprising the release R22-11. This chapter is structured according to the clusters of AUTOSAR release R22-11.
- Chapter [4](#remarks-to-known-technical-deficiencies) contains remarks about known technical deficiencies.
- Chapter 5 contains the detailed release history of all released specifications.

> 第 1 章提供了对 AUTOSAR 发布策略、自适应平台及其标准化方法的介绍。
> 第 2 章提供了自上一次发布自适应平台以来的变化摘要。
> 第 3 章包含发布 R22-11 的规格概述。本章根据 AUTOSAR 发布 R22-11 的群集结构组织。
> 第 4 章包含有关已知技术缺陷的评论。
> 第 5 章包含所有发布规格的详细发布历史记录。

# Summary of changes

This chapter contains a summary of changes which have been implemented since the previous release R22-11.

> 本章节包含了自上一个发布版本 R22-11 以来实施的变更摘要。

## Release R22-11

Several concepts affecting the Adaptive Platform have been introduced with release R22-11 thereby adding functionality to the platform.

Additionally one concept targets the Classic and Adaptive Platform, strengthening the interaction between the two platforms.

> 已经发布了 R22-11 版本，引入了几个影响自适应平台的概念，从而为平台增添了功能。
> 此外，一个**概念旨在加强经典和自适应平台之间的交互，以增强两个平台之间的联系**。

### Concepts

1. []{#\_bookmark31 .anchor}**Introduced Concepts**

The following concepts in [2.1.1.1.1](#macsec) [2.1.1.1.5](#someip-harmonization) have been introduced.

> 以下概念已经介绍了[2.1.1.1.1](#macsec) [2.1.1.1.5](#someip-harmonization)。

### MACsec

Media Access Controller Security (MACsec) and MACsec Key Agreement (MKA) protocols:

> 媒体访问控制器安全(MACsec)和 MACsec 密钥协商(MKA)协议

The concept defines and includes in AUTOSAR the Modules needed for using and configuring the security protocol in Layer 2 MACsec and its related Key Agreement Protocol MKA.

> 概念定义并将 AUTOSAR 中所需的模块包括在内，用于使用和配置 Layer 2 MACsec 的安全协议及其相关的密钥协商协议 MKA。

Focuses on the authentication method, secret keys agreement protocol (MKA), as well as the methods, rules, and configuration related to the protected communication (extra Header (SecTAG), extra Check Value (ICV), cryptography sets (Cypher Suites), bypass rules (VLAN-ID, EthTyp)).

> 重点关注认证方法、秘密钥协议(MKA)以及与受保护通信相关的方法、规则和配置(附加头(SecTAG)、附加检查值(ICV)、加密集(Cypher Suites)、绕过规则(VLAN-ID、EthTyp))。

### CAN XL

The CAN XL concept adds the improved capabilities of the next generation of CAN to AUTOSAR, e.g., a data rate up to 20MBit/s, increased frame size of up to 2048 Bytes, the introduction of a virtual separation with a Virtual CAN ID (VCID) similar to a VLAN and the possibility to transmit Ethernet frames over a physical CAN network.

> 汽车应用软件开发架构(AUTOSAR)中的 **CAN XL 概念增加了下一代 CAN 的改进功能，例如最高数据传输速率可达 20MBit/s，最大帧尺寸可达 2048 字节，引入了类似 VLAN 的虚拟 CAN ID(VCID)，以及可以在物理 CAN 网络上传输以太网帧的可能性**。

### Firewall

The concept introduces a firewall to inspect and filter Ethernet traffic based on predefined firewall rules. The firewall supports stateless packet inspection, stateful packet inspection and deep packet inspection as well as rate-based filtering of network packets. Furthermore, the firewall supports also the Intrusion Detection System by raising Security Events to the IdsM.

> 概念引入了**防火墙来检查和过滤基于预定义防火墙规则的以太网流量**。防火墙支持无状态数据包检查、有状态数据包检查和深度数据包检查以及基于速率的网络数据包过滤。此外，防火墙还支持入侵检测系统，将安全事件上报至 IdsM。

### Service Oriented Vehicle Diagnostics

SOVD (Service-oriented Vehicle Diagnostics) allows the usage of the \"ASAM SOVD\" standard in the context of AUTOSAR Adaptive. This covers the use cases for HCP diagnostics as well as the UDS adapter to access ECUs using AUTOSAR Classic.

> SOVD(服务导向车辆诊断)允许在 AUTOSAR Adaptive 的上下文中使用“ASAM SOVD”标准。这涵盖了 HCP 诊断的用例以及使用 AUTOSAR Classic 访问 ECU 的 UDS 适配器。

### SOME/IP Harmonization

The concept SOME/IP Harmonization will clean-up the SOME/IP specification for all AUTOSAR Platforms (FO, CP, AP), by removing duplicate content and aligning contradicting specifications related documents. The current concept part is harmonizing the documents PRS_SOMEIPServiceDiscoveryProtocol and SWS_CommunicationManagement.

> 概念 **SOME / IP Harmonization** 将**清理所有 AUTOSAR 平台(FO，CP，AP)的 SOME / IP 规范**，通过删除重复内容并对齐相互矛盾的规范相关文件。目前的概念部分是协调文件 **PRS_SOMEIPServiceDiscoveryProtocol** 和 **SWS_CommunicationManagement**。

### Impact of Concepts

The introduced concepts had impact on several specifications. The following table provides a detailed overview.
Please note that some of the specifications are marked by special text formatting:

> 引入的概念对多个规范产生了影响。下表提供了详细的概览。
> 请注意，有些规格用特殊文本格式标记：

- Specifications in **bold** font are completely new specifications originating from the particular concept.
- Specifications in _italic_ font are affected indirectly as they provide artifacts for the actually impacted specifications.

> - 以**粗体**字体标明的规格完全来自于特定概念的新规格。
> - 被*斜体*字体标记的规格间接受到影响，因为它们为实际受影响的规格提供了工件。

> .**Table 2.1: Impact of Concepts**

### Validated Concepts

The following concepts have been validated:

- CAN XL

  1. ### Specifications

     1. []{#\_bookmark37 .anchor}**New Specifications**

The following new specifications have been introduced via concepts:

- Specification of Firewall in Adaptive Platform (UID 1063, SWS)
- Explanation of Service Oriented Vehicle Diagnostics (UID 1064, EXP)

In addition to the above listed new specifications, the following documents have been added with R22-11:

> 此外，随着 R22-11，以下文件也被添加了：

- none

  1. ### Migrated Specifications

With this release, the following specifications have been moved from AUTOSAR Adaptive Platform to the AUTOSAR Foundation standard:

> 随着这次发布，以下规格已从 AUTOSAR 自适应平台移动到 AUTOSAR 基础标准：

- Explanation of Safety Overview (UID 895, EXP)

  1. ### Obsolete Specifications

The following specification has been set to status \"obsolete\" in this release:

> 此版本中，以下规格已被设置为“过时”状态：

- Guidelines for the use of the C++14 language in critical and safety-related systems (UID 839, RS)

> 指南：在关键和安全相关系统中使用 C++14 语言(UID 839，RS)

1. ### Removed Specifications

The following specification has been set to status \"removed\" in this release:

> 此版本中，以下规格已被设置为“已删除”的状态：

- Specification of RESTful Communication (UID 876, SWS)

  1. ### Reworked Specifications

The following specifications have been changed fundamentally in R22-11

- none

  1. ### Moved Specification parts

The following specification parts have been moved to other documents in R22-11.

> 以下规范部分已被移动到 R22-11 的其他文档中。

- Requirements on Security Management for Adaptive Platform (UID 881, RS) to Explanation of Security Overview (UID 1077, EXP)

> 要求安全管理的自适应平台(UID 881，RS)到安全概览的解释(UID 1077，EXP)

- Explanation of Adaptive Platform Software Architectural Decisions (UID 983, EXP) to Explanation of Adaptive and Classic Platform Software Architectural Decisions (UID 1078, EXP)

> 解释自适应和经典平台软件架构决策(UID 1078，EXP)

1. ### Renamed Specifications

The following specification has been renamed in this release:

- none

  1. ### Life Cycle State of Metamodel

The life cycle of several Adaptive Platform elements in the Metamodel were kept in \"draft\" until release R21-11. Due to increasing market demands to keep AUTOSAR's XML schema stable, these parts of the model have been set to \"valid\" in this release. This has an impact on the TPS_Manifest specification [2](#_bookmark1).

> 在发布 R21-11 之前，Metamodel 中的几个自适应平台元素的生命周期一直保持在“草稿”状态。由于市场要求保持 AUTOSAR 的 XML 模式的稳定性日益增加，这个版本的模型中这些部分已经设置为“有效”。这对 TPS_Manifest 规范有影响[2](#_bookmark1)。

Please be aware that according to [1](#_bookmark0), only the life cycle states \"valid\" and \"candidate\" are used within the Metamodel.

> 请注意，根据[1]](#\_bookmark0)，只有生命周期状态“有效”和“候选”在元模型中使用。

### Release Documentation

There are no major changes in the Release Documentation.

## History information in AUTOSAR

The following diagram shows the location of documentation of changes.

The Change Documentation is also available for Adaptive Platform since release R2011.

> 文档更改自 R2011 发布以来也适用于自适应平台。

**Figure 2.1: History information in AUTOSAR**

# Specification overview

The published specifications are divided into the clusters

- Release Documentation
- Adaptive Foundation
- Adaptive Services
- General
- Methodology and Manifests

The assignment of the specifications to these clusters is shown below.

**Table 3.1: Specification Overview**

# Remarks to known technical deficiencies

The technical deficiencies per specification are if applicable mentioned inside the respective specification in a chapter \"Known Limitations\" located after the table of contents.

> 按照规范所涉及的技术缺陷，如果适用，会在相应规范的目录之后的“已知限制”章节中提及。

The following technical deficiencies are to be mentioned, where clicking on the section reference will bring you to the respective document:

> 以下技术缺陷需要提及，点击相关节可以带您至相应文件：

```

---

Document UID   Long Name                                                     Document Type   Section Reference

---

851            Specification of Platform Health Management                   SWS             [4.1](#specification-of-platform-health-management-uid-851-sws)

880            Specification of Time Synchronization                         SWS             [4.2](#specification-of-time-synchronization-uid-880-sws)

888            Specification of Update and Configuration Management          SWS             [4.3](#specification-of-update-and-configuration-management-uid-888-sws)

908            Specification of State Management                             SWS             [4.4](#specification-of-state-management-uid-908-sws)

994            Specification of Language Binding for modeled AP data types   SWS             [4.5](#specification-of-language-binding-for-modeled-ap-data-types-uid-994-sws)
------------------------------------------------------------------------------------------------

```

## Specification of Platform Health Management (UID 851, SWS)

- Daisy chaining (i.e. forwarding Supervision Status, Checkpoint or Health Channel information to an entity external to PHM or another PHM instance) is currently not supported in this document release

> 目前本文档发布版本不支持代芽链接(即将监督状态、检查点或健康通道信息转发到 PHM 之外的实体或另一个 PHM 实例)。

- Interface with the Diagnostic Manager is not specified in this release

- The configuration attribute for the alive notification cycle time (with respect to PHM sending AliveNotification to watchdog interface) is not specified for this release.

> 针对 PHM 向看门狗界面发送 AliveNotification 的存活通知周期的配置属性未在本次发布中指定。

- A change in the value of Supervision (Alive/Deadline/Logical) configuration parameters between two Function Group states wherein the process being supervised continues to execute on switching between these states is not considered. The Supervision continues as per configuration in the Supervision Mode corresponding to old Function Group state.

> 在两个功能组状态之间改变监督(Alive/Deadline/Logical)配置参数的值，其中在切换这些状态时正在监督的进程继续执行，不被认为是一种改变。监督继续按照旧功能组状态对应的监督模式进行配置。

- Similar to above limitation, dynamic change between Supervision exclusion (disable) and Supervision inclusion (enable) on Function Group state change wherein the process under consideration continues to execute on change in Function Group state is not supported. Supervision exclusion or inclusion can be applied starting with the Function Group state in which execution of the process begins and the same is applied until termination of the process

> 类似于上述限制，当考虑的过程继续执行功能组状态变更时，不支持动态地在监督排除(禁用)和监督包括(启用)之间切换。监督排除或包括可以从过程开始的功能组状态开始应用，并一直应用到过程终止。

- Currently specified mechanism of Notifying State Management on Global Supervision Status reaching state kStopped is insufficient in case of multiple failures. It could happen that the Global Supervision Status remains in state kStopped without further notification to State Management about successive failures. Thereby the recovery might be hindered

> 当全局监督状态达到 kStopped 状态时，目前指定的通知状态管理的机制不足以应对多次故障。可能会发生全局监督状态保持在 kStopped 状态而没有进一步通知状态管理关于连续故障的情况，从而可能会阻碍恢复。

- \"PowerMode\" dependent Supervision configuration is not supported in this release

- Supervision is not supported for non-reporting processes. Rationale: Supervision depends on process states. Non-reporting process is not expected to report its Execution State to Execution Management. Hence, Platform Health Management cannot be informed about the necessary process states by Execution Management

> 监督不支持非报告过程。理由：监督取决于过程状态。不报告过程不预计向执行管理报告其执行状态。因此，平台健康管理无法从执行管理获知必要的过程状态。

- Handling of multiple hardware watchdog instances is up to implementation and not standardized in the specification.

> 处理多个硬件看门狗实例由实现决定，而不是在规范中标准化。

- State machine of Elementary Supervision Status is not specified for inter process supervisions (inter process Deadline Supervision and Logical Supervision) in this release.

> 在本次发布中，尚未为进程间监督(进程间期限监督和逻辑监督)指定基本监督状态机。

- The feature Health Channels (HealthChannelExternalStatus) will remain as \"obsolete\" in this release.

> 这个发布中，健康频道(HealthChannelExternalStatus)的功能将保持为“过时”。

Note: It is not intended to remove this feature from AUTOSAR Adaptive Platform overall (due to clear industry use cases). Rather, it is an architectural question (to which Functional Cluster this feature belongs to) that is expected to be resolved for the next release:

> 注意：这不是为了从 AUTOSAR Adaptive Platform 整体上移除此功能(由于清晰的行业用例)。而是一个架构问题(此功能属于哪个功能集群)，预计将在下一个版本中解决：

**--** SWS_PHM_00010

**--** SWS_PHM_01328

**--** SWS_PHM_01329

**--** SWS_PHM_01330

**--** SWS_PHM_00102

**--** SWS_PHM_01113

**--** SWS_PHM_01114

**--** SWS_PHM_01115

**--** SWS_PHM_01118

**--** SWS_PHM_01119

**--** SWS_PHM_01129

**--** SWS_PHM_01122

**--** SWS_PHM_01139

**--** SWS_PHM_00457

**--** SWS_PHM_01222

**--** SWS_PHM_01224

**--** SWS_PHM_01128

**--** SWS_PHM_01221

**--** SWS_PHM_01223

**--** SWS_PHM_01225

**--** SWS_PHM_01231

**--** SWS_PHM_01233

**--** SWS_PHM_01234

**--** SWS_PHM_01235

**--** SWS_PHM_01236

**--** SWS_PHM_01232

**--** SWS_PHM_01237

**--** SWS_PHM_01238

**--** SWS_PHM_01239

## Specification of Time Synchronization (UID 880, SWS)

Known limitations

The Time Synchronization module is bound to Adaptive Platform Systems.

- Configuration

Please refer to the corresponding model elements.

- Time Gateway

Time Gateway functionality is currently not in scope of the Time Synchronization module for the Adaptive Platform.

> 功能时间网关目前不在自适应平台的时间同步模块的范围内。

- Out of Scope

Errors, which occurred during Global Time establishment and which are not caused by the module itself (i.e. loss of PTP global time is not an issue of the TS but of the TSP modules) are out of the scope of this module.

> 错误，发生在全球时间建立期间，而不是由模块本身引起的(即 PTP 全球时间的丢失不是 TS 的问题，而是 TSP 模块的问题)，不在本模块的范围之内。

- Security

Secured Time Synchronization using the AUTOSAR Sub-TLV: Time Authenticated (see PRS-TimeSync [1]) is currently not supported for the Adaptive Platform.

> 不支持使用 AUTOSAR 子 TLV：时间认证(参见 PRS-TimeSync [1])进行安全的时间同步的自适应平台。

Note: Secured Time Synchronization messages received in AP ECUs works without verifying the security measures (i.e., AUTOSAR Sub-TLV:Time Authenticated is ignored).

> 注意：AP ECU 接收到的安全时间同步消息不验证安全措施(即忽略 AUTOSAR Sub-TLV：Time Authenticated)。

## Specification of Update and Configuration Management (UID 888, SWS)

UCM is not responsible to initiate the update process. UCM realizes a service interface to achieve this operation. The user of this service interface is responsible to verify that the vehicle is in a updatable state before executing a software update procedure on demand. It is also in the responsibility of the user to communicate with other AUTOSAR Adaptive Platforms or AUTOSAR Classic Platforms within the vehicle. The UCM receives a locally available software package for processing. The software package is usually downloaded from the OEM backend. The download of the software packages has to be done by another application, i.e. UCM does not manage the connection to the OEM backend. Prior to triggering their processing, the software packages have to be transferred to UCM by using the provided ara::com interface. The UCM update process is designed to cover updates on use case with single AUTOSAR Adaptive Platform. UCM can update Adaptive Applications, the AUTOSAR Adaptive Platform itself, including all functional clusters and the underlying OS.

> UCM 不负责启动更新过程。UCM 提供服务接口来实现此操作。此服务接口的用户负责在执行软件更新程序之前验证车辆是否处于可更新状态。用户也负责与车辆内的其他 AUTOSAR Adaptive Platforms 或 AUTOSAR Classic Platforms 进行通信。UCM 接收本地可用的软件包进行处理。软件包通常从 OEM 后端下载。下载软件包必须由另一个应用程序完成，即 UCM 不管理连接到 OEM 后端。在触发处理之前，必须使用提供的 ara :: com 接口将软件包传输到 UCM。UCM 更新过程旨在覆盖单个 AUTOSAR Adaptive Platform 的更新用例。UCM 可以更新 Adaptive Applications，包括所有功能集群和基础 OS 的 AUTOSAR Adaptive Platform 本身。

The UCM is not responsible for enforcing authentication and access control to the provided interfaces. The document currently does not provide any mechanism for the confidentiality protection as well as measures against denial of service attacks. The assumption is that the platform preserves the integrity of parameters exchanged between UCM and its user.

> UCM 不负责对提供的接口进行认证和访问控制。该文档目前不提供任何机制来保护机密性以及防止拒绝服务攻击。假设平台能够保持 UCM 和其用户之间交换的参数的完整性。

The possibility to restart a specific application instead of a Machine reboot depends of the kind of update and application, is therefore implementation specific and is defined in the Software Package manifest.

> 取决于更新和应用程序的类型，重新启动特定应用程序而不是重新启动机器的可能性，因此是实现特定的，并在软件包清单中定义。

UCM does only support updates of ARA::COM and UDS (ISO-14229) compliant ECUs. UCM is not controlling any action done by diagnostic tool directly updating a Classic platform. For instance UCM cannot protect against downgrading of a Software Cluster in a Classic platform by a diagnostic tool.

> UCM 只支持 ARA :: COM 和 UDS(ISO-14229)兼容的 ECU 的更新。 UCM 不会直接控制诊断工具对经典平台进行的任何操作。例如，UCM 无法防止诊断工具在经典平台上降级软件集群。

## Specification of State Management (UID 908, SWS)

The State Machine API is a subject for rework in a future release.

## Specification of Language Binding for modeled AP data types (UID 994, SWS)

Although future versions of this specification may add further Language Bindings, the primary focus of the AP (and therefore this specification) is a binding to the C++ language.

> 虽然未来的版本可能会添加更多的语言绑定，但 AP(因此本规范)的主要重点是对 C++语言的绑定。

```

```

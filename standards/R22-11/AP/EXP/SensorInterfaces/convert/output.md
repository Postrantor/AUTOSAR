---
tip: translate by openai@2023-06-23 16:26:57
...

# Contents

**Known Limitations**

This explanatory document may contain assumptions, exemplary items, like exemplary reference models, use-cases, scenarios, and/or references to exemplary technical so- lutions, devices, processes or software. Any such assumptions or exemplary items are contained in this document for illustration purposes only, and they themselves are not part of the AUTOSAR standard. Neither their presence in such specifications, nor any later documentation of AUTOSAR conformance of products actually implementing such exemplary items, imply that intellectual property rights covering such exemplary items or assumptions are licensed under the same rules as applicable to the AUTOSAR standard.

> 此解释性文件可能包含假设、示例项目，如示例参考模型、用例、场景和/或对示例技术解决方案、设备、流程或软件的引用。任何此类假设或示例项目仅用于说明目的，本身不是 AUTOSAR 标准的一部分。其出现在此类规范中，或者随后有关实际实施此类示例项目的 AUTOSAR 一致性的文档，都不意味着涵盖此类示例项目或假设的知识产权受到与适用于 AUTOSAR 标准的相同规则的许可。

List of limitations:

- the list of use cases contains the stable and relevant use cases from the devel- opment so far, further use cases will be added if needed

> 列出的用例包含从开发过程中稳定且相关的用例，如果需要，还会添加其他用例。

- detailed architecture and interface design is still in development

- this document will be extended with the chapter \"Interface Design\" which explains the rationale and design choices of the sensor interface

> 本文档将增加一个名为“接口设计”的章节，用于解释传感器接口的基本原理和设计选择。

- the description of interface usage is scheduled for later releases

# Introduction and functional overview

A key point to meet the challenges of developing automated driving functions, espe- cially SAE J3016 automation level 3-5, is standardization: There is a huge potential in reducing development and validation costs by standardizing subsections of the com- plex hardware and software setup for automated driving functions. Sensors for detect- ing the vehicle environment and its connected environmental models are considered major enablers for automated driving. The current focus is on the standardization of sensor interfaces that serve as an input to environmental models or data fusion algo- rithms which in turn serve as the input for automated driving functions equal or greater than SAE level 3. Specifically, the focus is on interfaces for on-board sensors that can independently perceive their environment for performing safety critical tasks, e.g. camera, radar, lidar and ultrasonic sensors. This includes the actual measurement data as well as dynamically changing sensor performance values such as the currently estimated detection range. Other information sources like Car2X and maps are consid- ered as potential extensions. With the resulting standardized sensor interfaces, OEMs, suppliers, service providers and tool providers can reduce their costs and time for the development and validation of automated driving functions.

> 一个关键点，以应对开发自动驾驶功能（尤其是 SAE J3016 自动级别 3-5）的挑战，是标准化：通过标准化复杂硬件和软件设置的子部分，可以大大降低开发和验证成本。检测车辆环境及其连接的环境模型的传感器被认为是自动驾驶的主要推动力。目前的重点是标准化传感器接口，作为环境模型或数据融合算法的输入，进而作为自动驾驶功能（至少等于 SAE 级别 3）的输入。具体而言，重点是用于独立感知其环境以执行安全关键任务的机载传感器的接口，例如摄像头、雷达、激光雷达和超声波传感器。这包括实际的测量数据以及动态变化的传感器性能值，如当前估计的检测范围。其他信息源，如 Car2X 和地图，被认为是潜在的扩展。通过实现标准化的传感器接口，OEM、供应商、服务提供商和工具提供商可以降低开发和验证自动驾驶功能的成本和时间。

Automated driving functions in general are highly complex. To overcome the com- plexity, one way is to design the function for a specific use case, scenario or driving condition. For instance, an Autonomous Emergency Braking (AEB) system could be limited to operate only on highways with no oncoming or crossing traffic. Another AEB system could be designed to operate in urban environments as well which would in- clude oncoming and crossing traffic. In contrast to the highway-only AEB, the urban AEB could require an additional classification indicator from the sensor, e.g. to dis- tinguish between vehicles and pedestrians to better detect and track cross traffic. In general, many driving functions require similar or identical information from a sensor,

> 自动驾驶功能通常非常复杂。为了克服复杂性，一种方法是为特定的用例、场景或行驶条件设计功能。例如，自动紧急制动（AEB）系统可以限制仅在没有来往或交叉交通的高速公路上运行。另一个 AEB 系统可以设计为在城市环境中运行，其中包括来往和交叉交通。与仅限高速公路的 AEB 相比，城市 AEB 可能需要传感器提供额外的分类指示器，例如区分车辆和行人，以更好地检测和跟踪交叉交通。总的来说，许多驾驶功能需要传感器提供相似或相同的信息。

e.g. the sensor's mounting position. However, most driving functions additionally have specific requirements for the data and signals provided by the sensor.

> 传感器的安装位置。然而，大多数驾驶功能还对传感器提供的数据和信号有特定的要求。

Currently, the interfaces of sensors for automated driving functions are proprietary and differ between suppliers. Thus, the integration of a new sensor requires a lot of effort as both the semantic as well as the logical interface need to be specified and developed according to functional safety requirements. There is an ongoing standardization of the semantic interfaces in the ISO 23150\[[1](#_bookmark23)\], i.e. the ISO defines which sensor data or signals are mandatory or optional and how are they defined, e.g. in terms of coordinate systems and units. The standard defined by the ISO is used as the basis to specify logical sensor interfaces within AUTOSAR. From these interfaces, sensors and data fusion systems can be directly implemented.

> 目前，用于自动驾驶功能的传感器接口是专有的，并且在供应商之间有所不同。因此，新传感器的集成需要大量努力，因为语义以及逻辑接口都需要根据功能安全要求进行规定和开发。ISO 23150\[[1](#_bookmark23)\]正在进行语义接口的标准化，即 ISO 定义了哪些传感器数据或信号是强制性的或可选的，以及它们如何定义，例如坐标系和单位。ISO 定义的标准被用作在 AUTOSAR 中指定逻辑传感器接口的基础。基于这些接口，可以直接实现传感器和数据融合系统。

For each sensor type like radar, lidar or camera, the ISO standard will contain lots of optional sensor data or signals in addition to the required signals, e.g. the classification of an object might be optional. During development of a driving function or data fusion system, a specific set of optional signals is selected by the function or data fusion developer according to the requirements of the driving function. To reduce develop- ment costs, especially in terms of functional safety, the set of optionals and thus the

> 对于每种传感器类型，如雷达、激光雷达或摄像头，ISO 标准将包含大量可选的传感器数据或信号，除了必需的信号，例如物体的分类可能是可选的。在开发驾驶功能或数据融合系统时，功能或数据融合开发人员根据驾驶功能的要求选择特定的可选信号集。为了降低开发成本，特别是在功能安全方面，可选集和因此可选集的开发成本也会相应降低。

resulting logical sensor interface are required to be fixed during design-time, i.e. the specified sensor signals must not suddenly disappear from the interface of the sensor during runtime of the system so that a data fusion system can rely on the presence of the specified signals. Vice versa, a sensor interface must not add additional signals during runtime, e.g. to not risk an unintentional behavior change due to the increased bandwidth requirements. There will be a specification within AUTOSAR to handle and specify the optional sensor data and signals during design-time.

> 结果的逻辑传感器接口需要在设计时固定，即指定的传感器信号在系统运行期间不能突然消失，以便数据融合系统可以依靠指定信号的存在。反之，传感器接口不能在运行时添加其他信号，以免因带宽要求增加而导致意外行为变化。在 AUTOSAR 中将有一个规范来处理和指定设计时的可选传感器数据和信号。

## Intended audience

The document shall explain the motivation behind the standardization of the Sensor interface for autonomous driving for the AUTOSAR Adaptive platform as well as the usage and limitations of the interface. As this interface is an essential connection be- tween different stakeholders in future vehicle architecture and software, this document is intended for the users of the AUTOSAR Adaptive platform and people involved in system development with sensors for autonomous driving.

> 文件将解释自动驾驶 AUTOSAR Adaptive 平台传感器接口标准化背后的动机，以及接口的使用和局限性。由于该接口是未来车辆架构和软件之间的重要连接，本文档旨在为 AUTOSAR Adaptive 平台的用户和参与自动驾驶传感器系统开发的人员提供参考。

More specifically different roles and their motivation behind a sensor standardization for the AUTOSAR Adaptive platform is described in the following, structured by main technical aspects.

> 具体来说，AUTOSAR Adaptive 平台上的传感器标准化的不同角色及其背后的动机，将按主要技术方面结构化描述如下。

### System Designer

From a System Designer perspective including rapid prototyping, the expectation to- wards the sensor standardization is to rely on a comparable and extendable interface for different sensor types.

> 从系统设计者的角度出发，包括快速原型设计，对传感器标准化的期望是能够为不同的传感器类型提供可比较和可扩展的接口。

### System Engineer

From a System Designer and System Engineer perspective, the reuse of standardized communication protocols enables exchangability and compatibility between sensors from different suppliers and the target sensor fusion platform.

> 从系统设计师和系统工程师的角度来看，重用标准化的通信协议可以实现不同供应商的传感器与目标传感器融合平台之间的互换性和兼容性。

### System Integrator

From an Integrator and Application Developer perspective, the standardized descrip- tion of the interface and configuration is required for the generic, testable software implementation as well as the interoperability between implementations. Further AP Developers rely on the usable interface description for efficient fusion and algorithm implementation.

> 从集成和应用开发者的角度来看，为了实现通用的可测试的软件实施以及实施之间的互操作性，需要对接口和配置进行标准化描述。此外，应用开发者还依赖可用的接口描述来实现有效的融合和算法实施。

### Safety and Security Engineer

From a Safety and Security Engineer perspective, the interface has to be compatible to the standardized mechanisms and can be validated during development.

> 从安全与安保工程师的角度来看，接口必须与标准机制兼容，并可在开发过程中进行验证。

## Relation to other standards

The currently ongoing standardization of the international standard ISO 23150 \[[1](#_bookmark23)\] \"Road vehicles - Data communication between sensors and data fusion unit for au- tomated driving functions - Logical interface\" will be applicable to road vehicles with automated driving functions. It specifies the logical interface between smart in-vehicle sensors that sense the environment (e.g. camera, lidar, radar, ultrasonic, etc.) and the vehicle fusion unit. The interface is described in a modular, semantic representation allowing different types of sensor technologies and fusion concepts.

> 目前正在进行的国际标准 ISO 23150 \[[1](#_bookmark23)\]“道路车辆 - 传感器和数据融合单元之间的数据通信 - 逻辑接口”将适用于具有自动驾驶功能的道路车辆。它指定了智能车载传感器（例如摄像头、激光雷达、雷达、超声波等）与车辆融合单元之间的逻辑接口。该接口以模块化、语义表示的形式描述，允许不同类型的传感器技术和融合概念。

The \"Open Simulation Interface\" (OSI) is a generic software interface for the environmental perception of automated driving functions in virtual scenarios ([https://github.com/OpenSimulationInterface/open-simulation-interface)](https://github.com/OpenSimulationInterface/open-simulation-interface)). OSI ensures modularity, integrability and interchangeability of the individual components. These can be environment simulation models, sensor models, logical models for the detected en- vironment or sensor fusion and models for automated driving functions. Additional in- formations can be found on [https://opensimulationinterface.github.io/open-simulation](https://opensimulationinterface.github.io/open-simulation)- interface/.

> "开放仿真接口（OSI）是一种用于虚拟场景中自动驾驶功能环境感知的通用软件接口（https://github.com/OpenSimulationInterface/open-simulation-interface）。OSI确保各个组件的模块性、可集成性和可互换性。这些可以是环境仿真模型、传感器模型、检测到的环境或传感器融合的逻辑模型以及自动驾驶功能的模型。更多信息可以在https://opensimulationinterface.github.io/open-simulation-interface/上找到。

![](./media/image1.png)

**Figure 1.1: Overall approach for Sensor Interface Standardization considers different Standardization Levels**

The Open Simulation Interface and the Autosar ADI will support the ISO 23150 \[[1](#_bookmark23)\].

> 开放式仿真接口和 Autosar ADI 将支持 ISO 23150 [[1]](#\_bookmark23)。

# Acronyms and Abbreviations

The glossary below includes acronyms and abbreviations relevant to the explanation of ara::adi.

> 以下词汇表包含与 ara::adi 解释相关的缩写和缩略语。

# Automated Driving Sensor Use Cases

The following sections describe the main use case for the automated driving sensor standardization from the perspective of different stakeholders within the described pro- cess. Chapter [3.1](#use-case-1-sensor-supplier-interface) describes the main use case in detail and following use cases in chapters [3.2](#use-case-2-standardized-sensor-api) to [3.5](#use-case-5-sensor-implementation-testing) further detail the intention and restriction of scope for different stakeholders. Use case 6 in chapter [3.6](#use-case-6-sensor-simulation) extends the focus area to virtual sensor simu- lation.

> 以下部分描述了描述的流程中不同利益相关者对自动驾驶传感器标准化的主要用例。第 3.1 节详细描述了主要用例，从第 3.2 节到第 3.5 节进一步详细说明了不同利益相关者的意图和范围限制。第 3.6 节的第 6 个用例将焦点扩展到虚拟传感器模拟。

## Use Case 1: "Sensor Supplier Interface"

**Table 3.1: Characteristic Information of UC1 "Sensor Supplier Interface"**

> 表 3.1：UC1“传感器供应商接口”的特征信息

## Use Case 2: "Standardized Sensor API"

**Table 3.2: Characteristic Information of UC2 "Standardized Sensor API"**

> 表 3.2：UC2“标准传感器 API”的特征信息

## Use Case 3: "Sensor Fusion Algorithm"

**Table 3.3: Characteristic Information of UC3 "Sensor Fusion Algorithm"**

> 表 3.3：UC3“传感器融合算法”的特征信息

## Use Case 4: "Sensor Fusion Integration"

**Table 3.4: Characteristic Information of UC4 "Sensor Fusion Integration"**

> 表 3.4：UC4“传感器融合集成”的特征信息

## Use Case 5: "Sensor Implementation Testing"

**Table 3.5: Characteristic Information of UC5 "Sensor Implementation Tester"**

> 表 3.5：UC5“传感器实施测试者”的特征信息

## Use Case 6: "Sensor Simulation"

**Table 3.6: Characteristic Information of UC6 "Virtual Sensor Simulation"**

> 表 3.6：UC6“虚拟传感器仿真”的特征信息

# Scope of Sensor Interface Standardization

The standardization of sensor interfaces aims at creating a well accepted specifica- tion, that builds on and is compliant to the sensor interface specification released by the International Organization for Standardization (ISO). While the ISO specification mainly focuses on the semantic definition of interfaces for different sensors, the ADI specification of the AUTOSAR Adaptive platform covers all additional aspects to make it fully compliant to the Adaptive platform. This includes all syntactic elements for the implementation as well as additional functionalities like sensor configuration.

> 标准化传感器接口的目的是创建一个受欢迎的特定规范，它基于国际标准化组织（ISO）发布的传感器接口规范并且符合其要求。虽然 ISO 规范主要关注不同传感器的接口语义定义，但 AUTOSAR Adaptive 平台的 ADI 规范涵盖所有额外的方面，使其完全符合 Adaptive 平台。这包括实施的所有句法元素以及额外的功能，如传感器配置。

The following figure provides a high level view of the sensor interface standardization scope:

> 下图提供了传感器接口标准化范围的高级视图：

![](./media/image4.jpeg){width="6.164243219597551in" height="2.7354166666666666in"}

**Figure 4.1: Scope of Sensor Interface Standardization**

The following aspects of sensor interfaces are intentionally excluded from the specifi- cation, to not impose constraints:

> 以下传感器接口方面的内容有意被排除在规范之外，以免施加限制：

- Mechanical and electrical interface
- Raw data level interface

For reading and writing Raw Data Streams an API for Adaptive applications is defined in SWS Communication Management.

> 为了读写原始数据流，SWS 通信管理中定义了一个用于自适应应用程序的 API。

The main boundary condition of the specification is that sensors are connected over a service interface to the AUTOSAR Adaptive computing unit.

> 主要规范的边界条件是传感器通过服务接口连接到 AUTOSAR 自适应计算单元。

The following figures show the basic sensor setups with the sensors directly connected to the AUTOSAR Adaptive ECU. The selection of sensors and connection interfaces is only given as an example.

> 以下图表展示了将传感器直接连接到 AUTOSAR 自适应 ECU 的基本传感器设置。 仅给出传感器和连接接口的选择作为示例。

![](./media/image5.png){width="6.3190616797900265in" height="6.0225in"}

**Figure 4.2: AD sensors directly connected to ECU**

In addition, it shall be possible to provide sensor data from one Adaptive ECU to an- other one as shown in the following scenario.

> 此外，可以根据以下场景，从一个自适应 ECU 提供传感器数据到另一个自适应 ECU。

![](./media/image6.png){width="6.325in" height="4.09in"}

**Figure 4.3: AD sensors connected via a second AUTOSAR AP ECU**

# Sensor Interface API Design

This chapter outlines the rationale about the current Interface API design proposal for Smart Sensors.

> 本章节概述了关于智能传感器当前接口 API 设计建议的理由。

## Sensor Interface realization as a Service

The decision has been taken to realize the Sensor Interface as a Service. The principal reason for this is to universally offer Sensor services within a vehi- cle deployed on different AUTOSAR platforms (Classic and Adaptive). This sup- ports the major future sensor architectures as presented in the figure below.

> 决定已经做出，将传感器接口作为一项服务来实现。主要原因是为了在部署在不同 AUTOSAR 平台（经典和自适应）上的车辆中普遍提供传感器服务。这支持下图所示的主要未来传感器架构。

![](./media/image7.jpeg){width="5.7575in" height="2.9246872265966752in"}

**Figure 5.1: Future Architectures for Smart Sensor APIs**

NB: this figure does not present a valid scenario in which a Classic platform may run ADAS/AD applications.

> NB：此图不代表一个可以运行 ADAS / AD 应用程序的经典平台的有效情景。

## ISO mapping to Sensor Services

ISO has defined the syntax and content of Smart Sensors. These are object level lists for tracking, roadmark and landmark independent from the sensor technology. In addition, there is a sensor technology dependent feature list for detection. The Sensor Service design directly maps this structure. Therefore each Smart Sensor offers a tracking, roadmark and landmark service plus a detection service dependent on the sensor technology. The figure below presents the ISO lists mapping to Sensor services.

> ISO 已经定义了智能传感器的语法和内容。这些是物体级别的列表，用于跟踪、路标和地标，独立于传感器技术。此外，还有一个依赖于传感器技术的特征列表用于检测。传感器服务设计直接映射此结构。因此，每个智能传感器都提供跟踪、路标和地标服务以及依赖于传感器技术的检测服务。下图展示了 ISO 列表映射到传感器服务的情况。

![](./media/image8.jpeg){width="6.06in" height="1.8699989063867017in"}

**Figure 5.2: ISO mapping to Smart Sensors Services**

## Sensor Service Template

The individual Service template design of Smart Sensors has faced the challenge that the ISO lists contain a lot of optional elements. This means a service template has mandatory and optional elements. The key assumption here is that the optional ele- ments are known and fixed at design time by Sensor providers and users.

> 智能传感器的个别服务模板设计面临 ISO 列表包含大量可选元素的挑战。这意味着服务模板具有强制性和可选性元素。关键假设是可选元素在设计时由传感器提供商和用户知晓且固定不变。

There is a service capability vector indicating which optional element is provided by the Sensor. In addition, the same type of sensor may have different performance, i.e. also possible to use different data type resolutions with the same capability setting. This means a service template has different profiles e.g. Low and High profile. The figure below presents the conceptual view of this service template with capability vector and service profiles.

> 有一个服务能力向量，指示传感器提供哪些可选元素。此外，同一类型的传感器可能具有不同的性能，即可以使用相同的能力设置和不同的数据类型分辨率。这意味着服务模板有不同的配置文件，例如低和高配置文件。下图展示了此服务模板的概念视图，包括能力向量和服务配置文件。

![](./media/image9.png)ISO optionals : A B C D E F H

**Figure 5.3: Service Template with Capability vector and service profiles**

The service compatibility between sensor service provider and users are checked ei- ther by the integrator in the deployment phase or by the user during the service discov- ery phase. The sequence diagram below outlines the vector capability checking during the service discovery phase. After the service provider has offered its service, the user will register to it. Then the user will request the capability vector from the provider to check that the required optional elements are provided by service of the sensor. If the required optional elements are supported (provided), the client will subscribe to the service and process the data package according to the setting of the capability vector. The Service Provider and User Code does not check optional status after the checking in the initialization phase.

> 服务提供者和用户之间的服务兼容性在部署阶段由集成商检查，或者在服务发现阶段由用户检查。下面的序列图概述了服务发现阶段的向量能力检查。服务提供者提供服务后，用户将注册该服务。然后，用户将从提供者请求能力矢量，以检查传感器服务是否提供所需的可选元素。如果支持所需的可选元素（提供），客户端将订阅该服务，并根据能力矢量的设置处理数据包。服务提供者和用户代码在初始化阶段检查后不再检查可选状态。

![](./media/image11.png)CAP = 1101

**Figure 5.4: Service Registering flow for capability vector checking**

## Interface stability

One of the driving factors for autonomous driving is the availability of suitable sensors for an affordable price. Out of this reason the research and development in this area is huge. New sensors, new accuracy possibilities or just higher sampling rates make it hard to define an interface that lasts a very long time.

> 一个驱动自动驾驶的因素是可以以合理的价格获得合适的传感器。出于这个原因，该领域的研究和开发是巨大的。新的传感器、新的精度可能性或更高的采样率使得很难定义一个可以持续很长时间的接口。

## Interface configuration

The configuration of the sensor interface connectivity can happen at three different times:

> 传感器接口连接的配置可以在三个不同的时间发生：

- Design time

An architect or developer specifies the whole system and configures all connec- tions. Then the interface bindings are generated and the whole software is com- piled and flashed to the complete environment. This might also require software updates of sensors.

> 建筑师或开发人员指定整个系统并配置所有连接。然后生成接口绑定，并将整个软件编译到完整的环境中。这可能还需要传感器的软件更新。

- Connection time

When the system is specified and the connections are configured, it is possible to specify more than one interface version for a connection. In other words the configuration is not complete at 'design time'. This implies that a service might have to implement several versions of an interface. If the system is powering up, the client initiates a handshake and determines the most suitable interface version for the connection. When this process is finished, the system initiates a final check to validate the complete configuration. Then, the same safety level can be reached as with the design time approach.

> 当系统被指定并且连接被配置时，可以为一个连接指定多个接口版本。换句话说，在“设计时”配置并不完整。这意味着一个服务可能需要实现几个接口版本。如果系统正在启动，客户端会发起握手，并确定最适合的接口版本。当这个过程完成后，系统会进行最后一次检查来验证完整的配置。然后，可以像设计时方法一样达到相同的安全级别。

- Runtime

Clients can connect to any available interface during runtime of the system. This creates a huge amount of flexibility but also the deterministic behaviour of the system decreases. For example the bandwidth usage of a connection cannot be guaranteed without additional countermeasures. This complicates the safety analysis as more configuration variants have to be evaluated.

> 客户可以在系统运行期间连接到任何可用的接口。这提供了巨大的灵活性，但也降低了系统的确定性行为。例如，没有额外的对策，无法保证连接的带宽使用情况。这使得安全分析更加复杂，因为必须评估更多的配置变体。

The conclusion is that the runtime approach is not suitable for an autonomous system as the safety analysis will get too complex and the costs will increase significantly.

> 结论是运行时方法不适用于自主系统，因为安全分析将变得太复杂，成本也会大大增加。

Design time configuration was used over decades and a lot of experience exists to create safe systems. Nevertheless, due to the fact that the interfaces might experience a high amount of changes during the next years, more flexibility is appreciated. If this is not introduced in the overall design, workarounds will be created to overcome this limitation.

> 设计时配置已经使用了几十年，有大量的经验可以用来创建安全的系统。尽管如此，由于接口在未来几年可能会经历很大的变化，更多的灵活性是受欢迎的。如果这不能在总体设计中引入，就会创建一些变通方法来克服这种局限性。

Therefore the idea is to use connection time configuration to provide the flexibility that is mandatory to simplify the development and to avoid workarounds.

> 因此，我们的想法是使用连接时间配置来提供必要的灵活性，以简化开发，避免出现工作绕路。

Here are some potential future use-cases that show the necessity for flexibility:

> 这里有一些潜在的未来用例，显示出灵活性的必要性：

- A new sensor supports additionally the last generation interface to act as a space part.

- A new interface can be added to a sensor without affection the existing system. This is especially useful during development time when a new interface shall be tested in a working environment.

> 新的接口可以在不影响现有系统的情况下添加到传感器中。在开发时间，当需要在工作环境中测试新的接口时，这尤其有用。

- Several new interfaces can be tested in parallel or in tight schedule without re- compilation and re-flashing of the whole system.

> 几个新的界面可以在不重新编译和重新刷新整个系统的情况下并行或紧密安排测试。

There might also be new features for a sensor that might affect the interface. One example could be the ultrasonic sensor. Currently the sensor has one beam and the interface provides the distance to the object. This is used e.g. in the park distance control. In future, there might be sensors that support more beams. The interface will

> 可能还会有新的传感器功能可能会影响界面。一个例子可能是超声波传感器。目前，传感器有一束光束，界面提供到物体的距离。这被用于例如停车距离控制。未来，可能会有支持更多光束的传感器。界面将会改变。

be adapted to provide the beam directions and the corresponding distances. Then, it might be a good idea to calculate a virtual single beam out of the multi beam informa- tion and to provide this information with the old interface. Then, the sensor supports the new and the old interface in parallel. A modern automatic parking software will be adapted to the new interface to use the full capabilities but the park distance control can still use the old interface and does not need to be changed. In addition the new sensor might act as replace part for already developed systems.

> 该传感器可以被调整以提供束的方向和相应的距离。然后，可以从多束信息中计算出一个虚拟的单束信息，并使用旧的接口提供该信息。这样，传感器就可以同时支持新的和旧的接口。现代的自动停车软件将被调整以使用全部功能，但是停车距离控制仍然可以使用旧的接口，不需要更改。此外，新的传感器可以用作已开发系统的替换部件。

# References

[]{#\_bookmark23 .anchor}\[1\] ISO-23150 Road vehicles--Data communication between sensors and data fusion unit for automated driving functions--Logical interface

> 道路车辆--自动驾驶功能的传感器和数据融合单元之间的数据通信--逻辑接口[1] ISO-23150

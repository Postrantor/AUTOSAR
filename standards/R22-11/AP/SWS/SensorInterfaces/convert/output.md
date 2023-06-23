---
tip: translate by openai@2023-06-23 17:41:47
...
1.  ## Limitations

    1.  ### ISO Optionals


All the ISO optionals are supported in the service defintiion, but the presence of an optional signal is decided during the design time. The optional signal presence is indicated by a capability vector. There is no change of optional presence during the run time.

> 所有ISO可选项都在服务定义中受支持，但可选信号的存在是在设计时期决定的。可选信号的存在由能力向量指示。在运行时不会改变可选信号的存在。

### Sensor Control Interfaces


Sensor control interfaces are not supported, e.g. actions like reset, initialization, and calibration.

> 传感器控制接口不受支持，例如重置、初始化和校准等操作。

### Sensor Capabilities


The configuration of sensor capabilities is not supported, e.g. sensor opening angle and detection range.

> 传感器功能的配置不受支持，例如传感器的开启角度和检测范围。

## Applicability to car domains


AUTOSAR Sensor Interfaces are used as service interfaces between dedicated sen- sors for enviroment precesion and the AUTOSAR Adaptive applications.

> AUTOSAR传感器接口被用作环境精确度专用传感器和AUTOSAR自适应应用之间的服务接口。

# Dependencies to other modules


The Automated Driving Interfaces serve as common interfaces for the AUTOSAR Adaptive applications. The sensor information is provided by a non-platform service.The sensor interfaces are exposed to client applications via the ara::com middleware. Communication Management,\[5\] uses Identity and Access Management

> 自动驾驶界面作为AUTOSAR自适应应用程序的公共接口。传感器信息由非平台服务提供。通过ara :: com中间件将传感器接口公开给客户端应用程序。通信管理\[5\]使用身份和访问管理。


\[6\] to validate the authorization of requests made to the specific service interfaces, i.e. the Communication Management shall check if the invoker is allowed to access the re- quested service interface of a specific sensor. The following Figure shows a radar and camera sensor instance which provide sensor information to a Data Fusion instance consuming sensor data.

> 为了验证对特定服务接口所做的请求的授权，即通信管理应检查调用者是否被允许访问所请求的传感器的服务接口。下图显示了一个雷达和摄像头传感器实例，它们向数据融合实例提供传感器信息。

![](./media/image1.png){width="5.733333333333333in" height="2.0083333333333333in"}

**Figure 5.1: Sensor Interfaces dependencies to other AUTOSAR Adaptive Applica- tions.**


For each sensor type like radar, lidar, USS or camera, the ISO standard will contain lots of optional sensor data or signals in addition to the required signals, e.g. the classification of an object might be optional. During development of a driving function or data fusion system, a specific set of optional signals is selected by the function or data fusion developer according to the requirements of the driving function. To reduce development costs, especially in terms of functional safety, the set of optionals and thus the resulting logical sensor interface are required to be fixed during design-time, i.e. the specified sensor signals must not suddenly disappear from the interface of the sensor during runtime of the system so that a data fusion system can rely on the presence of the specified signals. Vice versa, a sensor interface must not add additional signals during runtime, e.g. not to risk an unintentional behavior change due to the increased bandwidth requirements.

> 对于像雷达、激光雷达、超声波或摄像头等每种传感器，ISO标准将包含大量可选择的传感器数据或信号，除了必需的信号，例如对象的分类可能是可选的。在开发驾驶功能或数据融合系统时，功能或数据融合开发人员根据驾驶功能的要求选择特定的可选信号集。为了降低开发成本，尤其是在功能安全方面，必须在设计时间固定可选集和因此产生的逻辑传感器接口，即在系统运行期间指定的传感器信号不能突然从传感器的接口消失，以便数据融合系统可以依赖指定信号的存在。反之，传感器接口在运行期间不能添加额外的信号，例如不要冒险因带宽要求增加而导致意外行为变化。


7.  # Functional Specification

> 功能规格说明

    1.  ## Outline

        1.  ### Goals and scope


The specification is to provide well-defined sensor interfaces which is compliant to the sensor interface specification \[1\]. The ISO document covers just semantic definitions of interfaces whereas this specification aims to cover all aspects of the interfaces to make them fully compliant to the AUTOSAR Adaptive platform.

> 指定的内容是提供符合传感器接口规范[1]的定义清晰的传感器接口。ISO文件只涵盖了接口的语义定义，而本规范旨在涵盖接口的所有方面，使其完全符合AUTOSAR Adaptive平台。


The specification shall enable the compatibility of sensors and data fusion algorithms independently of the supplier. To ensure the compatibility between sensors the inter- faces are provided on implementation data type level.

> 规范应使传感器和数据融合算法在供应商独立的情况下可兼容。为了确保传感器之间的兼容性，提供了基于实施数据类型级别的接口。


The Automated Driving Interfaces serve as common interfaces for the AUTOSAR Adaptive applications. Consumers of the interfaces are AUTOSAR Adaptive applications containing functional elements as sensor data receivers, sensor data processors, data fusion applications, and automated driving functions. The sensor in- formation is provided by a non-platform service.The non-platform service consumer is running in the apdative platfom as an AUTOSAR adaptive application, where the sensor could be deployed on different AUTOSAR platforms (Classic and Adaptive) as shown in the following figure.

> 自动驾驶界面作为AUTOSAR自适应应用程序的公共接口。界面的消费者是包含功能元素的AUTOSAR自适应应用程序，如传感器数据接收器、传感器数据处理器、数据融合应用程序和自动驾驶功能。传感器信息由非平台服务提供。非平台服务消费者在自适应平台上运行，作为AUTOSAR自适应应用程序，其中传感器可以部署在不同的AUTOSAR平台（Classic和Adaptive）上，如下图所示。

![](./media/image2.png){width="4.7134087926509185in" height="3.3709372265966753in"}

**Figure 7.1: Functional elements communicating via ADI**


Apart from the Automated Driving Interfaces (ADI), the other relevent elements are defined as follows :

> 除了自动驾驶界面（ADI），其他相关元素的定义如下：


- Sensor Data Reception: A functional element which receives or reads sensor data from a sensor. Such an element can provide raw sensor data. Raw sensor data means that it provides the actual data a sensor can measure. There is no processing of the sensor data. There are no data streams provided.

> 接收传感器数据：一个功能元素，可以从传感器接收或读取传感器数据。这样的元素可以提供原始传感器数据。原始传感器数据意味着它提供传感器可以测量的实际数据。没有对传感器数据进行处理。没有提供数据流。


- Sensor Data Processing: This element which usually processes raw sensor data, provides pre-processed and post-processed sensor data. It provides data a sen- sor cannot directly measure but needs a processing stage for.

> 这个元素通常用于处理原始传感器数据，提供预处理和后处理传感器数据。它提供传感器无法直接测量但需要处理阶段的数据。


- Sensor Fusion Application: The data fusion algorithm is an application which col- lects sensor data and fuses it to provide a unified environmental model. Data fusion applications are typical consumers of sensor data. They provide their out- put to Automated Driving Functions.

> 传感器融合应用：数据融合算法是一种收集传感器数据并将其融合以提供统一环境模型的应用程序。数据融合应用程序是典型的传感器数据消费者。它们将输出提供给自动驾驶功能。

- Automated Driving Function: Automated Driving Functions can also directly use the interfaces.


The Automated Driving interfaces can be used in following usages to enable the in- teroperability between different players and improve the efficiency for the development and validation of automated driving functions :

> 自动驾驶界面可用于以下用途，以实现不同参与者之间的互操作性，并改善自动驾驶技术开发和验证的效率：


- Sensor Supplier Interface: The automated driving use case defines the require- ments to the fusion algorithm and the used sensors. The OEM wants to rely on a standardized interface which provides well defined sensor information which are defined by the ISO-23150 and on an AUTOSAR standardized interface. The scope shall be the data format between a sensor and a computing unit running an AUTOSAR Adaptive application.

> 传感器供应商接口：自动驾驶用例定义了融合算法和使用的传感器的要求。 OEM希望依赖标准化的接口，提供由ISO-23150定义的良好定义的传感器信息，以及AUTOSAR标准化的接口。范围应为传感器和运行AUTOSAR自适应应用程序的计算单元之间的数据格式。


- Standardized Sensor API: Sensor developers need well described and standard- ized interfaces to provide an implementation which can be used by automated driving applications and data fusion algorithms. So, the same information is pro- vided to all potential consumers of the data.

> 标准化传感器API：传感器开发者需要拥有描述清晰的标准化接口，以便提供可由自动驾驶应用程序和数据融合算法使用的实现。因此，所有潜在的数据消费者都会收到相同的信息。


- Sensor Fusion Algorithm: To combine information from different sensors and to develop sensor fusion algorithms for automated driving a detailed description of all signals provided is needed.

> 需要详细描述所提供的所有信号，以便结合不同传感器的信息，开发用于自动驾驶的传感器融合算法。


- Sensor Fusion Integration: Sensor fusion algorithms shall be integrated on a high-performance computing platform within an Adaptive Application as the cen- tral unit of automated driving functions.

> 传感器融合集成：传感器融合算法将在自适应应用程序作为自动驾驶功能的核心单元，在高性能计算平台上集成。


- Sensor Implementation Testing: Testing is performed at each stage of the de- velopment of the sensor system. To create a test specification for the system testable implementations are needed which are based on well-defined interfaces and descriptions.

> 测试传感器实施：在传感器系统开发的每个阶段都进行测试。为了创建系统可测试的实施，需要基于明确的接口和描述。


- Sensor Simulation: By simulating the sensor fusion algorithms before actual tar- get integration, it is possible to ensure smooth integration during the design, de- velopment, test and safeguarding steps. This ensures compatibility of algorithm integration into AUTOSAR Adaptive ECUs.

> 模拟传感器：通过在实际目标集成之前模拟传感器融合算法，可以确保设计、开发、测试和保障步骤的顺利集成。这确保了算法集成到AUTOSAR自适应ECU中的兼容性。


- Sensor Data Record and Replay: To be able to test and debug sensor fusion algorithms offline it is necessary to replay sensor data recorded in real world sce- narios. This enables sensor fusion designers to reproduce failures and determine faults.

> 录制和重放传感器数据：为了能够离线测试和调试传感器融合算法，有必要回放在真实世界场景中记录的传感器数据。这使得传感器融合设计师能够重现故障并确定故障。


  1.  ### Relation to other standards

> ### 与其他标准的关系


The currently ongoing standardization of the international standard ISO 23150 \"Road vehicles - Data communication between sensors and data fusion unit for automated driving functions - Logical interface\" will be applicable to road ve- hicles with automated driving functions. It specifies the logical interface be- tween smart in-vehicle sensors that sense the environment (e.g. camera, li- dar, radar, ultrasonic, etc.) and the vehicle fusion unit. The interface is de- scribed in a modular, semantic representation allowing different types of sen- sor technologies and fusion concepts. The \"Open Simulation Interface\" (OSI) is a generic software interface for the environmental perception of automated driv- ing functions in virtual scenarios (https://github.com/OpenSimulationInterface/open- simulation-interface). OSI ensures modularity, integrability and interchangeabil- ity of the individual components. These can be environment simulation mod- els, sensor models, logical models for the detected environment or sensor fusion and models for automated driving functions. Additional informations can be found on https://opensimulationinterface.github.io/open-simulation-interface/.

> 当前正在进行的国际标准ISO 23150“道路车辆-自动驾驶功能的传感器和数据融合单元之间的数据通信-逻辑接口”的标准化将适用于具有自动驾驶功能的道路车辆。它指定了智能车载传感器（例如摄像头、激光雷达、雷达、超声波等）和车辆融合单元之间的逻辑接口。该接口以模块化、语义表示的形式描述，允许不同类型的传感器技术和融合概念。“开放式仿真接口”（OSI）是用于虚拟场景中自动驾驶功能环境感知的通用软件接口（https://github.com/OpenSimulationInterface/open-simulation-interface）。OSI确保各个组件的模块化、可集成性和可互换性。这些可以是环境仿真模型、传感器模型、检测到的环境或传感器融合的逻辑模型以及自动驾驶功能的模型。更多信息可以在https://opensimulationinterface.github.io/open-simulation-interface/找到。

![](./media/image3.png)

**Figure 7.2: Scope of Standardization**


The Open Simulation Interface and the Autosar ADI will support the ISO 23150.

> 开放仿真接口和Autosar ADI将支持ISO 23150。


1.  ## AD Sensor Service Design

> ## 传感器服务设计

    1.  ### ISO mapping to Sensor Services

        1.  ### Sensor Types


To comply with the ISO 23150, the specific service is defined with different sensor types. Currently, Camera, Lidar, Radar, and Ultrasonic sercives are supported in the specification. The new service will be introduced along with the evolution of \[1\].

> 为了符合ISO 23150，特定服务已经使用不同的传感器类型进行定义。目前，摄像头、激光雷达、雷达和超声波服务已经在规范中支持。随着\[1\]的发展，将会引入新的服务。


**\[SWS_ADI_00001\]**{DRAFT} **The Camera Sensor Data periodical Transmission** *\[*A Camera senor with Automated Driving interfaces shall provide the camera sensor data periodically to the Adaptive Applications*♩(RS_ADI_00001)*

> **[SWS_ADI_00001]**{草案} **摄像头传感器数据定期传输** *\[*具有自动驾驶界面的摄像头传感器应定期向自适应应用程序提供摄像头传感器数据*♩(RS_ADI_00001)*


**\[SWS_ADI_00002\]**{DRAFT} **The Lidar Sensor Data periodical Transmission** *\[*A Lidar sensor with Automated Driving interfaces shall provide the lidar sensor data pe- riodically to the Adaptive Applications*♩(RS_ADI_00002)*

> **\[SWS_ADI_00002\]**{草案} **激光雷达传感器数据定期传输** *\[*具有自动驾驶界面的激光雷达传感器应定期向自适应应用程序提供激光雷达传感器数据*♩(RS_ADI_00002)*


**\[SWS_ADI_00003\]**{DRAFT} **The Radar Sensor Data periodical Transmission** *\[*A radar sensor with Automated Driving interfaces shall be able to provide the radar sen- sor data periodically to the Adaptive Applications*♩(RS_ADI_00003)*

> **[SWS_ADI_00003]**{草案} **雷达传感器数据定期传输** *\[*具有自动驾驶界面的雷达传感器应能够定期向自适应应用程序提供雷达传感器数据*♩(RS_ADI_00003)*


**\[SWS_ADI_00004\]**{DRAFT} **The Ultrasonic Sensor Data periodical Transmission** *\[*A ultrasonic sensor with Automated Driving interfaces shall be able to provide the ul- trasonic sensor data periodically to the Adaptive Applications*♩(RS_ADI_00004)*

> **\[SWS_ADI_00004\]**{草稿} **超声波传感器数据周期性传输** *\[*一个具有自动驾驶界面的超声波传感器应能够定期向自适应应用程序提供超声波传感器数据*♩(RS_ADI_00004)*


**\[SWS_ADI_00005\]**{DRAFT} **Receving periodical sensor data** *\[*The Adaptive Ap- plications as the sevice consumer shall process the sensor data according to the timestamp in the package, not the package arrival time. The most recent data is always the highest priority for processing._♩(RS_ADI_00018)_

> **[SWS_ADI_00005]**{草案} **接收定期传感器数据** *\[*自适应应用程序作为服务消费者应根据包中的时间戳处理传感器数据，而不是包到达时间。最新的数据总是处理优先级最高。_♩(RS_ADI_00018)_

### Sensor Data level


In ISO 23150, there are three ISO logic interface levels to support different levels of fusion: object level, feature level and detection level:

> 在ISO 23150中，有三个ISO逻辑接口层次来支持不同级别的融合：对象层次、特征层次和检测层次。


- Object level interface: Potentially moving object interface, Road object interface and Static object interface;

> - 对象级接口：潜在移动对象接口、道路对象接口和静态对象接口。

- Feature level interface: Camera feature interface and USS feature interface;


- Detection level interface: Radar detection interface,Lidar detection interface, Camera detection interface and USS detection interface.

> 探测水平界面：雷达探测界面、激光雷达探测界面、摄像头探测界面和超声波探测界面。


A sensor could provide several ISO logical interfaces, and shall provide at least one ISO interface either on object, feature, or detection level.

> 传感器可以提供多种ISO逻辑接口，并且至少在对象、特征或检测级别上提供一个ISO接口。


**\[SWS_ADI_00006\]**{DRAFT} **Sensor specific services for different level ISO inter- faces** *\[*To allow the flexibility of service providing by a sensor, each ISO interface shall

> **\[SWS_ADI_00006\]**{草案} **不同级别ISO接口的传感器特定服务** *\[*为了允许传感器提供服务的灵活性，每个ISO接口应该

> be mapped to a propriate ara::com means like events. The service interface shall support the defintions of ISO signals.The services for new types of sensors shall be added along with the evolution of \[1\]. The follwing AP services are defined in this specification:


- Camera,Lidar,Radar,Ultrasonic: Potentially moving object service, road object service, static object service

> 可能移动物体服务、道路物体服务和静态物体服务：摄像头、激光雷达、雷达和超声波。

- Camera: Camera features service, camera detections service;

- Lidar: Lidar detections service;

- Radar: Radar detections service;

- Ultrasonic: Ultrasonic features service, Ultrasonic detection service.


_♩(RS_ADI_00012, RS_ADI_00013, RS_ADI_00014, RS_ADI_00019, RS_ADI_00005)_

> _♩(RS_ADI_00012，RS_ADI_00013，RS_ADI_00014，RS_ADI_00019，RS_ADI_00005)_

### Supportive Sensor interfaces


In ISO, there are two supportive senor interfaces for the Adaptive Applications process the reliability of the used measurement method or data, which are also used to the implementation of safety concept. The two supportive sensor interfaces are sensor technology indepedent, i.e. common to camera, lidar, radar and ultrasonic sensor, but with sensor technology specific data.

> 在ISO中，有两种支持性传感器接口可用于自适应应用程序处理所使用的测量方法或数据的可靠性，也用于安全概念的实施。这两个支持性传感器接口是与传感器技术无关的，即通用于摄像头、激光雷达、雷达和超声波传感器，但具有传感器技术特定的数据。


**\[SWS_ADI_00007\]**{DRAFT} **Sensor independent supportive services** *\[*The sup- portive interfaces shall be mapped to two sensor indpendent AP services and support the defintions of ISO signals.The follwing services are defined in this specification:

> **\[SWS_ADI_00007\]**{草案} **传感器独立支持服务** *\[*支持接口应映射到两个传感器独立的应用程序服务，并支持ISO信号的定义。本规范定义了以下服务：

- Sensor Performance service;

- Sensor Health information service.


_♩(RS_ADI_00012, RS_ADI_00013, RS_ADI_00014, RS_ADI_00019)_

> _♩(RS_ADI_00012，RS_ADI_00013，RS_ADI_00014，RS_ADI_00019)_

♩(RS_ADI_00012、RS_ADI_00013、RS_ADI_00014、RS_ADI_00019)

### Service Optional Elements


An individual Sensor Service design faces the challenge that each ISO interface con- tains a lot of optional elements. The optional elements are known and fixed at design time by service providers and service users. The present of optional elements shall not be changed during run time.

> 单个传感器服务设计面临的挑战是，每个ISO接口都包含许多可选元素。可选元素在设计时由服务提供者和服务使用者确定，不能在运行时改变。


**\[SWS_ADI_00010\]**{DRAFT} **Capability Vector** *\[*A service capability vector indicates which optional element is provided by the Service provider. The optional elements indicated by the capability vector shall be always sent during the runtime of the service. The service consumer should check the vector at the initialization time and subcribe the service if it includes all the optional elements that the consumer requires.The consumer

> **[SWS_ADI_00010]**{草案} **能力向量** *[*服务能力向量指示服务提供者提供哪些可选元素。能力向量指示的可选元素在服务运行期间应始终发送。服务消费者应在初始化时检查向量，如果它包括消费者所需的所有可选元素，则订阅该服务。消费者


may ignore the optional elements, if these elements are not required._♩(RS_ADI_00006, RS_ADI_00015, RS_ADI_00016, RS_ADI_00017)_

> 可以忽略可选元素，如果这些元素不是必需的。♩（RS_ADI_00006，RS_ADI_00015，RS_ADI_00016，RS_ADI_00017）


**\[SWS_ADI_00011\]**{DRAFT} **Service Profiles** *\[*In different use cases, there are dif- ferent requirements on the sensor data i.e.for different data Types, behavior, content, performance, resolution, etc. Different Service Profiles for a Sensor Type enables the flexiblity of the corresponding sensor service for different use cases. In this re- lease, only one profile is supported and more profiles should be considered in future releases._♩(RS_ADI_00007)_

> **[SWS_ADI_00011]**{草案} **服务配置文件** *[*在不同的使用场景中，传感器数据有不同的要求，例如不同的数据类型、行为、内容、性能、分辨率等。传感器类型的不同服务配置文件可以为不同的使用场景提供灵活的传感器服务。在本次发布中，只支持一个配置文件，未来的版本应该考虑添加更多的配置文件。_♩(RS_ADI_00007)_


**\[SWS_ADI_00012\]**{DRAFT} **Service Versioning** *\[*Service Versioning covers different configurations, i.e. optionals, additional data representation, etc. The same services with different service versioning, but with the same profile, shall be backward compati- ble._♩(RS_ADI_00006, RS_ADI_00015, RS_ADI_00016, RS_ADI_00017)_

> **\[SWS_ADI_00012\]**{草案} **服务版本** *\[*服务版本涵盖不同的配置，例如可选项、附加数据表示等。具有相同配置的不同服务版本应具有向后兼容性。_♩(RS_ADI_00006, RS_ADI_00015, RS_ADI_00016, RS_ADI_00017)_

# API specification


There are no APIs defined in this release.

> 在这个版本中没有定义任何API。

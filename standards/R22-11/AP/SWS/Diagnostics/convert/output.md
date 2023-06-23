---
tip: translate by openai@2023-06-23 18:18:00
...
# Contents

## Diagnostic interface


Since release R19-03 a C++ interface was introduced for diagnostics as a replacement for the former ara::com based service interface.

> 自R19-03版本发布以来，为了取代前一个ara::com基础服务接口，引入了一个C++接口用于诊断。

## AUTOSAR Diagnostic Extract Template (DEXT)


The AUTOSAR Diagnostic Extract Template (DEXT) [[3](#_bookmark10)] is the configuration input to the DM.

> AUTOSAR诊断提取模板（DEXT）[[3](#_bookmark10)]是DM的配置输入。

## Software Cluster


The AUTOSAR adaptive platform is able to be extended with new software packages without re-flashing the entire ECU. The individual software packages are described by SoftwareClusters. To support the current approaches of diagnostic management (like software updates), each SoftwareCluster have its own DiagnosticAddresses.

> AUTOSAR自适应平台可以通过添加新的软件包而无需重新烧录整个ECU来扩展。个别软件包由SoftwareClusters描述。为了支持当前的诊断管理方法（如软件更新），每个SoftwareCluster都有自己的DiagnosticAddresses。


The DM is intended to support an own diagnostic server instance per installed SofwareCluster. All diagnostic server instances share a single TransportLayer instance (e.g. DoIP on TCP/IP port 13400).

> DM旨在为每个安装的软件集群支持一个自己的诊断服务器实例。所有诊断服务器实例共享单个传输层实例（例如DoIP在TCP / IP端口13400上）。

### Diagnostic Server


The Diagnostic Communication Management response handling basically rsembles the functionality of the Dcm BSW module of the AUTOSAR Classic platform.

> 诊断通信管理响应处理基本上类似于AUTOSAR经典平台的Dcm BSW模块的功能。


I.e. it is responsible for processing/dispatching of diagnostic services according to ISO 14229-1[[1](#_bookmark8)] and SOVD services as per Service-Oriented Vehicle Diagnostics standard Specification [[2](#_bookmark9)]. That means:

> 它负责按照ISO 14229-1[[1](#_bookmark8)]和SOVD服务根据服务型车辆诊断标准规范[[2](#_bookmark9)]处理/调度诊断服务。也就是说：

- Receiving UDS diagnostic request messages from the network layer.
- Receiving SOVD HTTP/REST requests from network layer.
- Extracting transport layer independent UDS information from it.

- Processing and extracting the request, SOVD entity path and resource informtion. Dispatching the request towards the Diagnostic Server instances depending on target address and target address type (physical or functional) of received UDS request message.

> 处理和提取请求，SOVD实体路径和资源信息。根据收到的UDS请求消息的目标地址和目标地址类型（物理或功能）将请求调度到诊断服务器实例。

- Dispatching the SOVD request towards the Diagnostic Server instances depening on the addressed SOVD entity and its path in the URI.

> 将SOVD请求派发到诊断服务器实例，取决于URI中涉及的SOVD实体及其路径。
- Correlating the diagnostic request to an existing UDS session (if already exists).
- Checking whether the diagnostic request is allowed within current session and security settings.
- Authorization and validation of SOVD client requests and grant access to the rquested resources.

- Handling modes and locks for the requested SOVD entity by SOVD client and prtect access to the resources (e.g., operations).

> 处理SOVD客户端请求的SOVD实体的模式和锁定，并保护对资源（例如操作）的访问权限。

- If diagnostic request is NOT allowed, generate negative UDS response and send it to the network layer.

> 如果不允许诊断请求，则生成负UDS响应并将其发送到网络层。

- If SOVD request is NOT allowed, generate corresponding SOVD error codes and send it as HTTP error responses.

> 如果不允许SOVD请求，生成相应的SOVD错误代码，并将其作为HTTP错误响应发送出去。

- If diagnostic (UDS and SOVD) request is allowed, depending on DM's configuration and request type,

> 如果根据DM的配置和请求类型允许诊断（UDS和SOVD）请求，


either process the service internally within Diagnostic Communication Management function block of DM

> 在DM的诊断通信管理功能块内部处理服务
or process the service internally within Diagnostic Event Management function block of DM

- or hand it over for processing to an (external to DM) Adaptive Application


The figure below depicts those processing steps and functional blocks of DM's Dianostic Communication Management part.

> 下图描绘了DM的诊断通信管理部分的处理步骤和功能模块。

![](./media/image1.png)**Figure 1.1: Architecture Diagnostic Communication Management**

### Diagnostic Managers external dependencies

![](./media/image10.png){width="6.353721566054244in" height="3.2343744531933507in"}
**Figure 1.2: Diagnostic Managers external dependencies**


3. # Related documentation

> #相关文档


   1. ## Input documents & related standards and norms

> ## 输入文件及相关标准和规范

```{=html}
<!-->
```


1. []{#_bookmark8 .anchor}Unified diagnostic services (UDS) Part 1: Application layer (Release 2020-02) []{#_bookmark9 .anchor}[http://www.iso.org](http://www.iso.org/)

> 统一诊断服务（UDS）第1部分：应用层（2020-02版）[http://www.iso.org](http://www.iso.org/)

2. ASAM SOVD Service-Oriented Vehicle DiagnosticsAPI Specification V1.0.0 []{#_bookmark10 .anchor}[http://www.asam.net](http://www.asam.net/)

> 2. ASAM SOVD服务导向的车辆诊断API规范V1.0.0[]{#_bookmark10 .anchor}[http://www.asam.net](http://www.asam.net/)

3. Diagnostic Extract Template AUTOSAR_TPS_DiagnosticExtractTemplate

> 3. AUTOSAR_TPS诊断提取模板

4. Glossary []{#_bookmark11 .anchor}AUTOSAR_TR_Glossary

> 4. 词汇表 []{#_bookmark11 .anchor}AUTOSAR_TR_Glossary

5. Road vehicles Diagnostic communication over Internet Protocol (DoIP) Part 2: Network and transport layer requirements and services (Release 2019-12) []{#_bookmark12 .anchor}[http://www.iso.org](http://www.iso.org/)

> 5. 道路车辆诊断通信协议（DoIP）第2部分：网络和传输层要求和服务（发布2019-12）[http://www.iso.org](http://www.iso.org/)

6. Specification of Adaptive Platform Core []{#_bookmark13 .anchor}AUTOSAR_SWS_AdaptivePlatformCore

> 6. 自适应平台核心规范[]{#_bookmark13 .anchor}AUTOSAR_SWS_AdaptivePlatformCore

7. Specification of Execution Management []{#_bookmark14 .anchor}AUTOSAR_SWS_ExecutionManagement

> 7. 执行管理的规格AUTOSAR_SWS_ExecutionManagement

8. Specification of Log and Trace []{#_bookmark15 .anchor}AUTOSAR_SWS_LogAndTrace

> 8. 日志和跟踪规范[]{#_bookmark15 .anchor}AUTOSAR_SWS_LogAndTrace

9. Specification of Persistency []{#_bookmark16 .anchor}AUTOSAR_SWS_Persistency

> 9. 持久性规范[]{#_bookmark16 .anchor}AUTOSAR_SWS_Persistency

10. Specification of Cryptography AUTOSAR_SWS_Cryptography

> 10. AUTOSAR_SWS_加密的规范

11. Requirements on Diagnostics []{#_bookmark17 .anchor}AUTOSAR_RS_Diagnostics

> 要求的診斷AUTOSAR_RS_診斷

12. Road vehicles Diagnostics on Controller Area Networks (CAN) Part2: Network []{#_bookmark18 .anchor}layer services

> 12. 控制器区域网络（CAN）上的道路车辆诊断：网络层服务 Part2

13. Specification of Manifest []{#_bookmark19 .anchor}AUTOSAR_TPS_ManifestSpecification

> 13. 清单规范[]{#_bookmark19 .anchor}AUTOSAR_TPS_ManifestSpecification

14. Unified diagnostic services (UDS)Part 2: Session layer services (Release 2020-02\)

> 14. 统一诊断服务（UDS）第二部分：会话层服务（2020-02发布）

15. Unified diagnostic services (UDS) Part 1: Application layer (Release 2013-03) [http://www.iso.org](http://www.iso.org/)

> 15. 统一诊断服务（UDS）第1部分：应用层（发布2013-03）[http://www.iso.org](http://www.iso.org/)

    1. ## Further applicable specification


AUTOSAR provides a core specification [[6](#_bookmark12)] which is also applicable for Diagnostic Management. The chapter \"General requirements for all FunctionalClusters\" of this specification shall be considered as an additional and required specification for implmentation of Diagnostic Management.

> AUTOSAR提供一个核心规范[[6](#_bookmark12)]，也适用于诊断管理。该规范的“所有功能簇的通用要求”章节应被视为实施诊断管理的附加和必要的规范。


4. # Constraints and assumptions

> 4. # 约束和假设


   1. ## Known Limitations

> ## 已知限制


This chapter describes known limitation of the DM in respect to general claimed goals of the module. The nature of constraints can be a general exclusion of a certain dmain / functionality or it can be that the provided standard has not yet integrated this functionality and will do so in future releases.

> 本章节描述了DM在实现模块的一般宣称目标方面所存在的已知限制。这些限制的性质可以是一般性地排除某个领域/功能，也可以是提供的标准尚未整合这些功能，而将在未来的版本中进行整合。

- Only scheduler type 1 from [[1](#_bookmark8)] is supported for service 0x2A
- Subfunction defineByMemoryAddress for service 0x2C is not supported
- OBD ISO 15031 and WWH OBD ISO 27145 is not supported by the DM.

- *Software Cluster* /*Diagnostic Server instances* are supported by DM interfaces but are not specified in detail.

> 软件集群/诊断服务器实例受DM接口支持，但未详细说明。
- *DoIP edge node* is not supported by the DM.
- The following UDS services are not implemented by the DM:

```
 0x23 ReadMemoryByAddress
 0x24 ReadScalingDataByIdentifier
 0x2F InputOutputControlByIdentifier
 0x38 RequestFileTransfer
 0x3D WriteMemoryByAddress
 0x83 AccessTimingParameter
 0x84 SecuredDataTransmission
 0x87 LinkControl
```


- Sub-functions of UDS services are implemented according to ISO 14229-1[[1](#_bookmark8)] unless explicitly stated.

> 子功能的UDS服务根据ISO 14229-1[[1](#_bookmark8)]实施，除非另有明确说明。
- The UDS mirror event memory is not supported by the DM. As a result of this, the


DM does not support the UDS service

> DM不支持UDS服务

- 0x19 with subfunction 0x0F (reportMirrorMemoryDTCByStatusMask)
- 0x19 with subfunction 0x10 (reportMirrorMemoryDTCExtDataRecordBDTCNumber)
- 0x19 with subfunction 0x11 (reportNumberOfMirrorMemoryDTCByStatuMask)

```{=html}
<!-->
```


- The OBD/WWH OBD is not supported by the DM. As a result of this, the DM does not support the UDS service

> OBD/WWH OBD不受DM的支持。因此，DM不支持UDS服务。


  0x19 with subfunction 0x05 (reportDTCStoredDataByRecordNumber)

> 0x19，子功能0x05（按记录号报告存储的DTC数据）

  0x19 with subfunction 0x12 (reportNumberOfEmissionsOBDDTCByStatuMask)

> 0x19，带有子功能0x12（报告通过状态掩码OBDDTC的排放次数）

  0x19 with subfunction 0x13 (reportEmissionsOBDDTCByStatusMask)

> 0x19，子功能0x13（reportEmissionsOBDDTCByStatusMask）

  0x19 with subfunction 0x42 (reportWWHOBDDTCByMaskRecord)

> 0x19 与子功能 0x42（reportWWHOBDDTCByMaskRecord）

  0x19 with subfunction 0x55 (reportWWHOBDDTCWithPermanentStatus)

> 0x19，子功能0x55（报告WWHOBDDTC与永久状态）
- The following general UDS services of ReadDTCInformation are not suported:


  0x19 with subfunction 0x08 (reportDTCBySeverityMaskRecord)

> 0x19 带有子功能 0x08（reportDTCBySeverityMaskRecord）

  0x19 with subfunction 0x09 (reportSeverityInformationOfDTC)

> 0x19，带有子功能0x09（报告故障码的严重程度信息）

  0x19 with subfunction 0x0B (reportFirstTestFailedDTC)

> 0x19，子功能0x0B（报告第一次测试失败的故障码）

  0x19 with subfunction 0x0C (reportFirstConfirmedDTC)

> 0x19，具有子功能0x0C（报告第一次确认的DTC）

  0x19 with subfunction 0x0D (reportMostRecentTestFailedDTC)

> 0x19，带有子功能0x0D（报告最近测试失败的DTC）

  0x19 with subfunction 0x0E (reportMostRecentConfirmedDTC)

> 0x19，具有子功能0x0E（报告最近确认的DTC）

  0x19 with subfunction 0x15 (reportDTCWithPermanentStatus)

> 0x19，具有子功能0x15（reportDTCWithPermanentStatus）

  0x19 with subfunction 0x16 (reportDTCExtDataRecordByRecordNumber)

> 0x19，带有子功能0x16（按记录号报告DTC扩展数据记录）
- Event Memory: Variant handling at runtime for events/DTCs is not supported.
- Event Memory: Details for combined events are not specified.

- Persistent Storage of failed attempts to change security level : After each incrment of the attempt counter, it shall be persisted to survive accidental or intended resets. Here the option to select the persistent storage is mandatory in Adaptive Autosar.

> 持久性存储更改安全级别失败的尝试：每次尝试计数器增加后，都应持久化以防止意外或有意重置。在Adaptive Autosar中，这里必须选择持久性存储选项。
- Only Subfunction 0x01 (ON) and Subfunction 0x02 (OFF) is supported for service 0x85.
- For the UDS service 0x86 ResponseOnEvent the following applies:


Queuing of events is not supported.

> 不支持事件的排队。

Regarding the request message parameter eventWindowTime (refer to B.2 in [[1](#_bookmark8)]), the only values supported are infiniteTimeToResponse and poweWindowTime.

> 关于请求消息参数eventWindowTime（参见[[1](#_bookmark8)] B.2），唯一支持的值是infiniteTimeToResponse和poweWindowTime。


- The Diagnostic Manager only implements the UDS Service Authentication (0x29) via PKI certificate exchange. Authentication with challenge-response (ACR) is currently out of scope of the Diagnostic Manager.

> 诊断管理器只通过PKI证书交换实施UDS服务认证（0x29）。目前，使用挑战-响应（ACR）进行认证不在诊断管理器的范围之内。

- Manufacturer and Supplier specific service checks according to \"Figure 6Geeral server response behavior for request messages with SubFunction paramter\" of ISO 14229-1[[1](#_bookmark8)] are not supported.

> 不支持根据ISO 14229-1[1]中“图6：请求消息带有SubFunction参数的一般服务器响应行为”的制造商和供应商特定服务检查。

- OEM-specific error codes are by intention not part of the AUTOSAR standardiztion but can be added platform vendor specific as an additional ErrorDomain.

> OEM特定错误代码不是AUTOSAR标准的一部分，但可以作为额外的ErrorDomain添加到平台供应商特定的。


For SOVD[[2](#_bookmark9)] the following limitations apply:

> 对于SOVD[[2](#_bookmark9)]，以下限制适用：

- The SOVD entities area, app and function are not supported.
- SOVD bulk-data are not supported.
- SOVD updates are not supported.
- SOVD logs are not supported.

- Custom SOVD modes are not supported. Only standardized SOVD modes commnication_control (section 7.6.3.5.7) and control_dtc_settings (section 7.6.3.5.8) are supported

> 不支持自定义的SOVD模式，只支持标准化的SOVD模式通信控制（第7.6.3.5.7节）和控制DTC设置（第7.6.3.5.8节）。
- For executions of SOVD operations custom capabilites are not supported.
- For SOVD operations the attribute modes is not supported.
- For SOVD configurations the usage of bulk data for read and write of is not suported.
- SOVD locks cannot be acquired on component level. Acquiring SOVD locks


is only possible on sub-component level.

> 只能在子组件级别实现。

# Dependencies to other modules


As any other process started by Execution Management [[7](#_bookmark13)], DM needs to interact with the Execution Management. The DM may use ara::log ([[8](#_bookmark14)], Log and Trace) for logging and tracing purposes. DM may use ara::per ([[9](#_bookmark15)], Persistency) to store non-volatile data. DM may use ara::crypto ([[10](#_bookmark16)], Cryptography) to handle TLS for ASAM SOVD[[2](#_bookmark9)].

> 作为由执行管理启动的其他进程[[7](#_bookmark13)]，DM需要与执行管理进行交互。 DM可以使用ara :: log（[[8](#_bookmark14)]，日志和跟踪）进行日志记录和跟踪。 DM可以使用ara :: per（[[9](#_bookmark15)]，持久性）来存储非易失性数据。 DM可以使用ara :: crypto（[[10](#_bookmark16)]，密码学）来处理ASAM SOVD [[2](#_bookmark9)]的TLS。

# Functional specification


The functionality of DM is split into two layers: the UDS Transport Layer and the Applcation Layer. On the UDS Transport Layer, DM handles connections to Diagnostic Clients via standardized or user defined UDS Transport Protocols, see section [7.4](#uds-transport-layer) for details. The subcomponent of DM implementing a particular Transport Protocol is called a Transport Protocol Handler.

> DM的功能分为两层：UDS传输层和应用层。在UDS传输层，DM通过标准或用户定义的UDS传输协议与诊断客户端建立连接，详情请参见[7.4节](#uds-transport-layer)。实现特定传输协议的DM子组件称为传输协议处理程序。


Besides UDS Transport Layer also communication via SOVD is supported according to [[2](#_bookmark9)]. The SOVD Transport Layer is covered in section [7.5](#sovd-transport-layer) "[SOVD Transport Layer](#sovd-transport-layer)".

> 除了UDS传输层，根据[[2](#_bookmark9)]还支持通过SOVD进行通信。 SOVD传输层在第7.5节"[SOVD传输层](#sovd-transport-layer)"中进行了说明。


On the Application Layer, DM implements the two main building blocks of diagnotics: Diagnostic Event Management and Diagnostic Communication Maagement, both according to UDS ISO 14229-1[[1](#_bookmark8)] and SOVD[[2](#_bookmark9)]. On AUTOSAR adative platform the Application Layer can be split into multiple SoftwareClusters, each with its own diagnostic address. Accordingly, DM instantiates for each SofwareCluster a Diagnostic Server that implements diagnostics with scope given by this SoftwareCluster, see section [7.6](#diagnostic-server-1). In context of SOVD the diagnostic address corresponds to an SOVD subcomponent, see section [7.6](#diagnostic-server-1) "[Diagnostic Server](#diagnostic-server-1)".

> 在应用层，DM实现了诊断的两个主要构建模块：根据UDS ISO 14229-1[[1](#_bookmark8)]和SOVD[[2](#_bookmark9)]的诊断事件管理和诊断通信管理。在AUTOSAR自适应平台上，应用层可以分为多个软件集群，每个软件集群都有自己的诊断地址。因此，DM为每个软件集群实例化一个诊断服务器，用于实现由该软件集群给出的范围的诊断，请参见[7.6](#diagnostic-server-1)节。在SOVD的上下文中，诊断地址对应于SOVD子组件，请参见[7.6](#diagnostic-server-1)节“[诊断服务器](#diagnostic-server-1)”。


The link between the UDS Transport Layer and the Application Layer is implemented by the Transport Protocol Manager ( see subsection B.1.4 "UdsTransportProtcolMgr Class".), which dispatches UDS messages in both directions: UDS requests from Diagnostic Clients are forwarded to the respective responsible Diagnostic Server instance, and UDS responses created by Diagnostic Server istances are dispatched towards the respective Transport Protocol Handler ( see subsection B.1.3 "UdsTransportProtocolHandler Class".) that handles the connetion to the Diagnostic Client. Accordingly, the dispatching between SOVD Tranport Layer and different SOVD subcomponents need to be handled.

> 连接UDS传输层和应用层的实现是由传输协议管理器（参见B.1.4节“UdsTransportProtcolMgr类”）完成的，它可以双向分发UDS消息：来自诊断客户端的UDS请求被转发到相应的负责诊断服务器实例，而由诊断服务器实例创建的UDS响应被分发到相应的传输协议处理器（参见B.1.3节“UdsTransportProtocolHandler类”），用于处理与诊断客户端的连接。因此，需要处理SOVD传输层和不同SOVD子组件之间的分发。


A broad subcomponent view on DM is given as follows:

> 以下是对DM的宽泛子组件视图：

![](./media/image11.png)**Figure 7.1:** []{#_bookmark25 .anchor}**Component view on Diagnostic Management**

## Functional cluster life-cycle

No content.

## Startup

No content.

## Shutdown

No content.

## UDS Transport Layer


Since there exist standardized as well as OEM specific UDS Transport Layers, the DM supports a standardized C++ API (called Transport Protocol API), where diffeent kinds of UDS Transport Layers can be connected. Currently the Adaptive Platform only provides a detailed description of Ethernet-based network technologies, which mandates support of DoIP [[5](#_bookmark11)]. It is very likely, that upcoming releases of the DM will

> 由于存在标准化和OEM特定的UDS传输层，DM支持标准化的C++ API（称为传输协议API），其中可以连接不同类型的UDS传输层。目前，自适应平台仅提供基于以太网的网络技术的详细描述，这就要求支持DoIP [[5](#_bookmark11)]。很可能，DM的即将发布的版本将提供更多支持。


also detail CAN, CAN-FD, FR, \... networks. The Transport Protocol API allows for extensions of DM towards not-yet-detailed and proprietary UDS Transport Protocols.

> 也详细介绍CAN、CAN-FD、FR等网络。传输协议API允许对尚未详细说明和专有的UDS传输协议进行扩展。


[]{#_bookmark30 .anchor}**[SWS_DM_00342]**{DRAFT} **Indication of UDS message reception** *[*UDS Tranport Protocol implementation shall call ara::diag::uds_transport:UdsTransportProtocolMgr::IndicateMessage on its ara::diag::uds\transport::UdsTransportProtocolMgr reference ((see [[SWS_DM_00330](#_bookmark33)])), as soon as it has at least the following information of an incoming UDS request avaiable:

> **[SWS_DM_00342]**{草案} **UDS消息接收指示** *[*UDS传输协议实现应调用ara::diag::uds_transport:UdsTransportProtocolMgr::IndicateMessage，以其ara::diag::uds\transport::UdsTransportProtocolMgr引用（参见[[SWS_DM_00330](#_bookmark33)])，只要它有至少以下信息的传入UDS请求可用：

- UDS source address of the request.
- UDS target address of the request.
- Type of the UDS target address (physical or functional)
- Size of the entire UDS message starting from SID

- If the UDS payload is larger than 1 byte, at least two bytes are received and shall be forwarded in the parameter payloadInfo

> 如果UDS有效负载大于1字节，至少接收到两个字节，并应在参数有效负载信息中转发。

*♩(RS_Diag_04168)*


The UDS Transport Protocol (TP) implementation can optionally provide the so far rceived UDS message content in payloadInfo. It is up to the TP implementation to decide how much of the so far received data is provided. It is recommended to provide at least the first two bytes of the received message. The DM is then able to detect a functional received tester present (UDS bypass logic) and accept this message, even the DM is currently processing a physical request. If the TP does not provide any data in payloadInfo, the DM will not be able to detect the functional TP and will reject the message reception in ara::diag::uds_transport::UdsTransportProtcolMgr::IndicateMessage (see also [[SWS_DM_00386](#_bookmark37)]). This might or might not result to failures on the TP. E.g. DoIP provides 'Negative Acknowledge' (NACK) codes in that case, while CAN (Controller Area Network) does not have any TP failures.

> UDS传输协议（TP）实现可以可选地在payloadInfo中提供到目前为止收到的UDS消息内容。由TP实现决定提供多少收到的数据。建议至少提供收到消息的前两个字节。DM然后可以检测到功能接收的测试者存在（UDS旁路逻辑）并接受该消息，即使DM当前正在处理物理请求。如果TP没有在payloadInfo中提供任何数据，DM将无法检测到功能TP并且将在ara :: diag :: uds_transport :: UdsTransportProtcolMgr :: IndicateMessage中拒绝消息接收（另见[[SWS_DM_00386]（#_bookmark37）））。这可能会或可能不会导致TP上的故障。例如，DoIP在这种情况下提供“否定确认”（NACK）代码，而CAN（控制器区域网络）没有任何TP故障。

### Support of proprietary UDS Transport Layer


The UDS Transport Protocol API is formally described in section B.1. This section dscribes the required interaction of the components using this API. Each (proprietary) UDS Transport Protocol implementation subclasses the abstract class ara:diag::uds_transport::UdsTransportProtocolHandler, which shall be prvided by DM according to [SWS_DM_00315].

> API UDS传输协议在B.1节中有正式描述。本节描述了使用此API的组件之间所需的交互。每个（专有的）UDS传输协议实现都是抽象类ara：diag：：uds_transport：：UdsTransportProtocolHandler的子类，根据[SWS_DM_00315]，DM应提供这个类。

### Initialization, Starting and Stopping of a proprietary UDS TransportLayer


**[SWS_DM_00329]**{DRAFT} **Lifecycle management of an UDS Transport Prtocol implementation** *[*The lifecycle of an UDS Transport Protocol implemetation shall be managed by the DM in the following order:

> **[SWS_DM_00329]**{草案} **UDS传输协议实施的生命周期管理** *[*UDS传输协议实施的生命周期由DM以以下顺序管理：


- Creation of the UDS Transport Protocol implementation by calling its constructor ara::diag::uds_transport::UdsTransportProtocolHadler::UdsTransportProtocolHandler.

> 创建UDS传输协议实现，通过调用其构造函数ara::diag::uds_transport::UdsTransportProtocolHadler::UdsTransportProtocolHandler。

- Initializing of the UDS Transport Protocol implementation by calling ara::diag::uds_transport::UdsTransportProtocolHandler::Intialize.

> 初始化UDS传输协议实现，通过调用ara :: diag :: uds_transport :: UdsTransportProtocolHandler :: Intialize。

- Starting of the UDS Transport Protocol implementation by calling ara:diag::uds_transport::UdsTransportProtocolHandler::Start.

> 开始UDS传输协议的实现，通过调用ara：diag::uds_transport::UdsTransportProtocolHandler::Start。

- Stopping of the UDS Transport Protocol implementation by calling ara:diag::uds_transport::UdsTransportProtocolHandler::Stop.

> 停止UDS传输协议实现，通过调用ara:diag::uds_transport::UdsTransportProtocolHandler::Stop。

*♩(RS_Diag_04168)*


[]{#_bookmark33 .anchor}**[SWS_DM_00330]**{DRAFT} **Construction of an UDS Transport Protocol implmentation** *[*The DM shall call the specific constructor of the UDS Transport Prtocol implementation, where the argument handlerId is unique among all by DM instantiated UDS Transport Protocol implementations and the argument tranportProtocolMgr is set to the reference of the instance of ara::diag::uds\transport::UdsTransportProtocolMgr provided by DM.*♩(RS_Diag_04168)*

> DM 应调用 UDS 传输协议实现的特定构造函数，其中参数 handlerId 在 DM 实例化的所有 UDS 传输协议实现中是唯一的，参数 tranportProtocolMgr 设置为 DM 提供的 ara::diag::uds\transport::UdsTransportProtocolMgr 实例的引用。


**[SWS_DM_00331]**{DRAFT} **Initialization of an UDS Transport Protocol iplementation** *[*The DM shall call the ara::diag::uds_transport::UdsTranportProtocolHandler::Initialize method of the UDS Transport Protcol implementation during startup/initialization phase, before reporting ApplictionState.kRunning to the execution management.*♩(RS_Diag_04168)*

> **[SWS_DM_00331]**{草案} **UDS传输协议实施的初始化** *[*在启动/初始化阶段，DM应调用ara :: diag :: uds_transport :: UdsTranportProtocolHandler :: Initialize方法来实施UDS传输协议，然后再将ApplictionState.kRunning报告给执行管理。*♩(RS_Diag_04168)*


**[SWS_DM_00332]**{DRAFT} **Starting of an UDS Transport Protocol implmentation** *[*The DM shall call the ara::diag::uds_transport::UdsTranportProtocolHandler::Start method of the UDS Transport Protocol iplementation during startup/initialization phase, before reporting ApplicatioState.kRunning to the execution management and after call to ara:diag::uds_transport::UdsTransportProtocolHandler::Initialize has returned.*♩(RS_Diag_04168)*

> **[SWS_DM_00332]**{草案} **开始UDS传输协议实现** *[*DM 在启动/初始化阶段，在向执行管理报告ApplicatioState.kRunning之前，应调用ara :: diag :: uds_transport :: UdsTranportProtocolHandler :: Start方法来实现UDS传输协议，并在调用ara：diag :: uds_transport :: UdsTransportProtocolHandler :: Initialize之后返回。*♩(RS_Diag_04168)*


**[SWS_DM_00333]**{DRAFT} **Stopping of an UDS Transport Protocol implmentation** *[*The DM shall call the ara::diag::uds_transport::UdsTransporProtocolHandler::Stop method of each UDS Transport Protocol implemetation it has started, if it is switching to state ApplicationState.kTerminating.*♩ (RS_Diag_04168)*

> **[SWS_DM_00333]**{草案} **停止UDS传输协议实现** *[*DM应调用ara::diag::uds_transport::UdsTransporProtocolHandler::Stop方法，如果它正在切换到ApplicationState.kTerminating状态，则应调用其已启动的每个UDS传输协议实现。*♩ (RS_Diag_04168)*


**[SWS_DM_00340]**{DRAFT} **Waiting for Stop confirmation** *[*After having called ara::diag::uds_transport::UdsTransportProtocolHandler::Stop

> **[SWS_DM_00340]**{草案} **等待停止确认** *[*在调用ara::diag::uds_transport::UdsTransportProtocolHandler::Stop之后


method of any UDS Transport Protocol implementation, it shall wait for the corresponding ara::diag::uds_transport::UdsTransportProtocolMgr:HandlerStopped callback with the related handlerId, before it finally terminates the process.*♩(RS_Diag_04168)*

> 任何UDS传输协议实现的方法，它应该等待相关的ara :: diag :: uds_transport :: UdsTransportProtocolMgr：HandlerStopped回调，带有相关的处理程序ID，然后才最终终止该过程。*♩（RS_Diag_04168）*

### UDS message reception on a proprietary UDS TransportLayer


[]{#_bookmark35 .anchor}**[SWS_DM_00347]**{DRAFT} **Channel identification in Indication** *[*UDS Transport Protocol implementation shall determine a distinct identifier to identify the network specific channel over which the UDS request has been received, which can be later used to deliver the UDS response to the source of the UDS request.*♩(RS_Diag_04168)*

> UDS传输协议实施应确定一个独特的标识符来标识接收到UDS请求的特定网络信道，以便以后可以将UDS响应发送到UDS请求的源头。(RS_Diag_04168)


Note: A diagnostic client has basically two address parts which together serve for its unique identification:

> 注意：诊断客户端基本上有两个地址部分，它们共同为其提供唯一标识。


- The UDS source address (SA) in the clients/testers request which represent a technology/transport layer independent part.

> 客户/测试者请求中的UDS源地址（SA）代表一种技术/传输层独立的部分。

- The technology/transport layer specific/dependent network endpoint source adress, from which the request from the client originates. In Ethernet-based neworks this typically is an IP-address/port number pair, while in CAN networks it is the CAN identifier of the CAN-TP message used by the client. In UDS on CAN (ISO ISO-15765-2[[12](#_bookmark17)]) contrary to DoIP, the SA is not explicitly transmitted, but directly deduced from the CAN identifier of the CAN-TP message. That means on CAN we do not have two separate address parts, only the network endpoint source address part is used for identification.

> 这是一种技术/传输层特定/依赖的网络端点源地址，客户端的请求源自此。在基于以太网的网络中，这通常是一个IP地址/端口号对，而在CAN网络中，它是客户端使用的CAN-TP消息的CAN标识符。在CAN上的UDS（ISO ISO-15765-2[[12]（#_bookmark17）]）与DoIP相反，SA不会明确传输，而是直接从CAN-TP消息的CAN标识符推断出来。这意味着在CAN上，我们没有两个独立的地址部分，只有网络端点源地址部分用于标识。


The side effect of this is that from the viewpoint of Diagnostic Server, which supports parallel Diagnostic Clients, it is a perfectly valid scenario that two Diagnostic Clients with the same UDS SA can be active in parallel if they originate from different/distiguishable network endpoints.

> 这样的结果是，从支持并行诊断客户端的诊断服务器的角度来看，如果两个具有相同UDS SA的诊断客户端来自不同/可区分的网络端点，那么它们可以并行活动，这是完全有效的场景。


[]{#_bookmark36 .anchor}**[SWS_DM_00385]**{DRAFT} **Acceptance of UDS message reception** *[*If the DM is able to process the indicated request, ara::diag::uds_transport::UdsTranportProtocolMgr::IndicateMessage shall return a std::pair with ara:diag::uds_transport::UdsTransportProtocolMgr::IndicationResult set to kIndicationOk and a ara::diag::uds_transport::UdsMessagePtr, which owns a valid ara::diag::uds_transport::UdsMessage object, with a capacity of so many bytes, the DM wants to process of the indicated request. The minimum size of the ara::diag::uds_transport::UdsMessage object shall be one byte.*♩(RS_Diag_04168)*

> 如果DM能够处理指定的请求，ara :: diag :: uds_transport :: UdsTranportProtocolMgr :: IndicateMessage将返回一个std :: pair，其中ara：diag :: uds_transport :: UdsTransportProtocolMgr :: IndicationResult设置为kIndicationOk，并且ara :: diag :: uds_transport :: UdsMessagePtr拥有一个有效的ara :: diag :: uds_transport :: UdsMessage对象，其容量是DM想要处理的指示请求的字节数。 ara :: diag :: uds_transport :: UdsMessage对象的最小大小应为一个字节。 ♩(RS_Diag_04168)


Note: For details about std::pair see [SWS_DM_00309].

> 注意：有关std::pair的详细信息，请参阅[SWS_DM_00309]。


**[SWS_DM_00392]**{DRAFT} **Properties of returned UdsMessage** *[*If the DM acepted the UDS message reception, the returned ara::diag::uds_transport::UdsMessage owned by ara::diag::uds_transport::UdsMessagePtr shall

> **[SWS_DM_00392]**{草案} **UdsMessage 的属性** *[*如果 DM 接受了 UDS 消息接收，由 ara::diag::uds_transport::UdsMessagePtr 所拥有的 ara::diag::uds_transport::UdsMessage 返回的应该


return a ara::diag::uds_transport::ByteVector from ara::diag::uds\transport::UdsMessage::GetPayload, which shall be empty (i.e. empty() rturns true, size() returns 0).*♩(RS_Diag_04168)*

> 从ara::diag::uds_transport::UdsMessage::GetPayload返回一个ara::diag::uds_transport::ByteVector，它应该是空的（即empty()返回true，size()返回0）。


Note: In the normal case, where DM accepts the complete UDS request for procesing, it will provide a std::pair with ara::diag::uds_transport::UdsTranportProtocolMgr::IndicationResult set to kIndicationOk and a ara::diag::uds_transport::UdsMessagePtr, which owns a valid ara::diag:uds_transport::UdsMessage object, with the capacity equal (or greater) to paraeter size indicated by the UDS Transport Protocol implementation. There are use cases (typically for negative responses), where the DM does NOT need the entire UDS request message data to generate the UDS response and therefore might return a ara::diag::uds_transport::UdsMessagePtr, which owns a valid ara:diag::uds_transport::UdsMessage object, with a capacity smaller than the idicated parameter size. E.g. this is useful e.g. in the case, where DM is busy and wants to ignore/reject a second parallel request. For declining a second request WITH sending a negative response according to [[SWS_DM_00049](#_bookmark71)], the DM would return an ara::diag::uds_transport::UdsMessagePtr with only enough capacity to be able to construct a valid negative response.

> 注意：在正常情况下，DM接受完整的UDS请求进行处理，它将提供一个std :: pair，ara :: diag :: uds_transport :: UdsTranportProtocolMgr :: IndicationResult设置为kIndicationOk，以及一个ara :: diag :: uds_transport :: UdsMessagePtr，它拥有一个有效的ara :: diag：uds_transport :: UdsMessage对象，其容量等于（或大于）UDS传输协议实施指示的参数大小。有些情况（通常是负响应），DM不需要整个UDS请求消息数据来生成UDS响应，因此可能会返回ara :: diag :: uds_transport :: UdsMessagePtr，它拥有一个有效的ara :: diag :: uds_transport :: UdsMessage对象，其容量小于指示的参数大小。例如，这在DM忙碌时并想忽略/拒绝第二个并行请求的情况下很有用。对于拒绝第二个请求并发送负响应，根据[[SWS_DM_00049](#_bookmark71)]，DM将返回一个ara :: diag :: uds_transport :: UdsMessagePtr，其容量仅足以构建有效负响应。


[]{#_bookmark37 .anchor}**[SWS_DM_00386]**{DRAFT} **Ignoring UDS message reception because DM is busy** *[*If the Transport Protocol Manager is calling ara::diag::uds_tranport::UdsTransportProtocolMgr::IndicateMessage and the DM is busy due to the active processing of a service from the same Tester Present conversation and the Tester Present request is not a functional request with the optional provided paloadInfo '0x3E 0x80', the DM shall return a std::pair with ara::diag::uds\transport::UdsTransportProtocolMgr::IndicationResult set to kIndcationOccupied and a ara::diag::uds_transport::UdsMessagePtr equal to nullptr.*♩(RS_Diag_04168)*

> 如果传输协议管理器调用ara :: diag :: uds_tranport :: UdsTransportProtocolMgr :: IndicateMessage，而DM由于从同一个Tester Present会话中活动处理服务而忙碌，并且Tester Present请求不是具有可选提供的paloadInfo '0x3E 0x80'的功能请求，则DM应返回一个std :: pair，其中ara :: diag :: uds \ transport :: UdsTransportProtocolMgr :: IndicationResult设置为kIndcationOccupied，ara :: diag :: uds_transport :: UdsMessagePtr等于nullptr。 ♩（RS_Diag_04168）


Functional TesterPresents (compare [[SWS_DM_00126](#_bookmark177)]) with suppressPosspMsgIndicationBit = TRUE are exceptional requests in UDS and valid at any point in time. Therefore the DM allows to check for functional received TesterPresent request in the ara::diag::uds_transport::UdsTransportProtocolMgr:IndicateMessage. For handling of the functional TesterPresent, see chapter [7.6.2.8.20](#service-0x3e-testerpresent).

> 功能测试员提出（比较[[SWS_DM_00126](#_bookmark177)])，当 suppressPosspMsgIndicationBit 为 TRUE 时，UDS 中的请求是特殊的，并且在任何时间点都有效。因此，DM 允许在 ara::diag::uds_transport::UdsTransportProtocolMgr:IndicateMessage 中检查功能收到的 TesterPresent 请求。有关处理功能 TesterPresent 的详细信息，请参阅[7.6.2.8.20](#service-0x3e-testerpresent)章节。


Note: For details about std::pair see [SWS_DM_00309].

> 注意：有关std::pair的详细信息，请参阅[SWS_DM_00309]。


Note: For declining/ignoring a second request without sending a negative response according to [[SWS_DM_00290](#_bookmark72)], the DM would choose this behavior.

> 根据[[SWS_DM_00290](#_bookmark72)]，为了拒绝/忽略第二次请求而不发送负面回复，DM会选择这种行为。


[]{#_bookmark38 .anchor}**[SWS_DM_00387]**{DRAFT} **Ignoring UDS message reception because DM has no (memory) ressources** *[*If the DM is not able to process the indicated UDS rquest, because it has not enough (memory) resources to hold the indicated UDS request, it shall return a std::pair with ara::diag::uds_transport::UsTransportProtocolMgr::IndicationResult set to kIndicationOverflow and a ara::diag::uds_transport::UdsMessagePtr equal to UdsMessagePtr (nullptr).*♩(RS_Diag_04168)*

> 如果DM无法处理指定的UDS请求，因为它没有足够的（内存）资源来保存指定的UDS请求，它应该返回一个std :: pair，ara :: diag :: uds_transport :: UsTransportProtocolMgr :: IndicationResult设置为kIndicationOverflow，ara :: diag :: uds_transport :: UdsMessagePtr等于UdsMessagePtr（nullptr）。♩（RS_Diag_04168）


Note: For details about std::pair see [SWS_DM_00309].

> 注意：有关std :: pair的详细信息，请参阅[SWS_DM_00309]。


Note: There might exist UDS Transport Protocol implementations, which make NO distinction between [[SWS_DM_00386](#_bookmark37)] and [[SWS_DM_00387](#_bookmark38)]. I.e. regardless, whether the DM returns a kIndicationOverflow or kIndicationOccupied, the behavior on transport layer level is the same. But, for instance, a CanTP UDS Tranport Protocol implementation, would explicitly react on a kIndicationOveflow with sending a FC.OFLW on CanTP level to the UDS request sender.

> 注意：可能存在不区分[[SWS_DM_00386](#_bookmark37)]和[[SWS_DM_00387](#_bookmark38)]的UDS传输协议实现。也就是说，无论DM返回kIndicationOverflow还是kIndicationOccupied，在传输层面的行为都是相同的。但是，例如，CanTP UDS传输协议实现会明确地对kIndicationOveflow发送CanTP层面的FC.OFLW给UDS请求发送者。


**[SWS_DM_00487]**{DRAFT} **Ignoring UDS message reception because of uknown target address** *[*If the DM is not able to process the indicated UDS request, because the indicated target address is unknown to DM, it shall return a std::pair with ara::diag::uds_transport::UdsTransportProtocolMgr::IdicationResult set to kIndicationUnknownTargetAddress and a ara:diag::uds_transport::UdsMessagePtr equal to UdsMessagePtr(nullptr)

> **[SWS_DM_00487]**{草案} **由于未知的目标地址，忽略UDS消息接收** *[*如果DM无法处理指定的UDS请求，因为指定的目标地址对DM未知，它应该返回一个std::pair，其中ara :: diag :: uds_transport :: UdsTransportProtocolMgr :: IdicationResult设置为kIndicationUnknownTargetAddress，ara：diag :: uds_transport :: UdsMessagePtr等于UdsMessagePtr（nullptr）

.*♩(RS_Diag_04168)*


Note: For details about std::pair see [SWS_DM_00309].

> 注意：有关std::pair的详细信息，请参阅[SWS_DM_00309]。


**[SWS_DM_00388]**{DRAFT} **Filling provided UdsMessage** *[*If the DM returned kIndicationOk from the ara::diag::uds_transport::UdsTransportPrtocolMgr::IndicateMessage, the UDS Transport Protocol implementation shall fill the ara::diag::uds_transport::UdsMessage owned by ara::diag::uds_transport::UdsMessagePtr from the received UDS request starting from SID up to either ara::diag::uds_transport::UdsMessage full capacity or up to the entire received UDS request message, whatever happens first.*♩(RS_Diag_04168)*

> 如果DM从ara::diag::uds_transport::UdsTransportPrtocolMgr::IndicateMessage返回了kIndicationOk，则UDS传输协议实现应从收到的UDS请求开始填充由ara::diag::uds_transport::UdsMessagePtr拥有的ara::diag::uds_transport::UdsMessage，直到ara::diag::uds_transport::UdsMessage容量满或整个收到的UDS请求消息，以先发生的为准（RS_Diag_04168）。


[]{#_bookmark39 .anchor}**[SWS_DM_00345]**{DRAFT} **Forwarding of UDS message** *[*If the UDS Transport Protocol implementation has filled the payload of the returned ara::diag::uds\transport::UdsMessagePtr, it shall call ara::diag::uds_transport::UsTransportProtocolMgr::HandleMessage on its ara::diag::uds_tranport::UdsTransportProtocolMgr reference ((see [[SWS_DM_00330](#_bookmark33)]) with the returned ara::diag::uds_transport::UdsMessagePtr as argument.*♩(RS\Diag_04168)*

> 如果UDS传输协议实现已填充了返回的ara::diag::uds_transport::UdsMessagePtr的有效负载，则应在其ara::diag::uds_transport::UdsTransportProtocolMgr引用上调用ara::diag::uds_transport::UsTransportProtocolMgr::HandleMessage（参见[[SWS_DM_00330](#_bookmark33)），将返回的ara::diag::uds_transport::UdsMessagePtr作为参数。(RS\Diag_04168)


**[SWS_DM_00389]**{DRAFT} **Skipping Forwarding of UDS message** *[*If the DM rturned a ara::diag::uds_transport::UdsTransportProtocolMgr::IndcationResult NOT equal to kIndicationOk from the ara::diag::uds_tranport::UdsTransportProtocolMgr::IndicateMessage, the UDS Transport Protocol implementation shall NOT call ara::diag::uds_transport::UsTransportProtocolMgr::HandleMessage.*♩(RS_Diag_04168)*

> **[SWS_DM_00389]**{草案} **跳过UDS消息的转发** *[*如果DM从ara :: diag :: uds_transport :: UdsTransportProtocolMgr :: IndcationResult返回的结果不等于kIndicationOk，UDS传输协议实现不得调用ara :: diag :: uds_transport :: UsTransportProtocolMgr :: HandleMessage。*♩(RS_Diag_04168)*


**[SWS_DM_00346]**{DRAFT} **Aborting of UDS message** *[*If the UDS Transport Protocol implementation has already called ara::diag::uds_transport:UdsTransportProtocolMgr::IndicateMessage (see [[SWS_DM_00342](#_bookmark30)]), but is not willing to call ara::diag::uds_transport::UdsTransportProtocolMgr::HandleMessage (maybe due to errors receiving the entire/remaining UDS request),

> **[SWS_DM_00346]**{草案} **中止UDS消息** *[*如果UDS传输协议实现已经调用ara::diag::uds_transport:UdsTransportProtocolMgr::IndicateMessage（参见[[SWS_DM_00342](#_bookmark30)），但不愿意调用ara::diag::uds_transport::UdsTransportProtocolMgr::HandleMessage（可能是由于接收整个/剩余UDS请求出错），


it shall notify DM by calling ara::diag::uds_transport::UdsTransportPrtocolMgr::NotifyMessageFailure on its ara::diag::uds_transport:UdsTransportProtocolMgr reference ((see [[SWS_DM_00330](#_bookmark33)]) with the returned ara::diag::uds_transport::UdsMessagePtr as argument.*♩(RS_Diag_04168)*

> 它应该通过调用ara::diag::uds_transport::UdsTransportPrtocolMgr::NotifyMessageFailure来通知DM，其参考ara::diag::uds_transport:UdsTransportProtocolMgr（参见[[SWS_DM_00330](#_bookmark33)），并以返回的ara::diag::uds_transport::UdsMessagePtr为参数。 ♩(RS_Diag_04168)

### UDS message transmission on a proprietary UDS TransportLayer


[]{#_bookmark41 .anchor}**[SWS_DM_00348]**{DRAFT} **Transmission of UDS response message** *[*DM shall send a diagnostic response UDS message to the same UDS Transport Prtocol implementation, where it has received the UDS request message (see [[SWS_DM_00345](#_bookmark39)]) by calling the ara::diag::uds_transport::UdsTranportProtocolHandler::Transmit method of the UDS Transport Protocol implementation.*♩(RS_Diag_04168)*

> DM 应该通过调用 UDS 传输协议实现的 ara::diag::uds_transport::UdsTranportProtocolHandler::Transmit 方法，将诊断响应 UDS 消息发送到接收 UDS 请求消息的相同 UDS 传输协议实现（参见[[SWS_DM_00345](#_bookmark39)])。♩(RS_Diag_04168)


**[SWS_DM_00349]**{DRAFT} **Reuse channel identifier of Indication** *[*DM shall set the argument channelId in the ara::diag::uds_transport::UdsTransportPrtocolHandler::Transmit call to the same value as in the Indication of the corrsponding UDS request message (see [[SWS_DM_00347](#_bookmark35)]).*♩(RS_Diag_04168)*

> **[SWS_DM_00349]**{草稿} **重用指示的信道标识符** *[*DM 在ara::diag::uds_transport::UdsTransportPrtocolHandler::Transmit调用中应将channelId参数设置为与相应UDS请求消息的指示相同的值（请参阅[[SWS_DM_00347](#_bookmark35)]）。*♩（RS_Diag_04168）*


[]{#_bookmark42 .anchor}**[SWS_DM_00350]**{DRAFT} **Confirmation of UDS message transmission** *[*When the UDS Transport Protocol implementation has a final feedback of the network layer, whether the UDS message triggered for transmission (see [[SWS_DM_00348](#_bookmark41)]) could be sent on the network or not, it shall notify DM by caling ara::diag::uds_transport::UdsTransportProtocolMgr::TransmiConfirmation ((see [[SWS_DM_00330](#_bookmark33)]) setting the message argument to the message parameter of the ara::diag::uds_transport::UdsTransportPrtocolHandler::Transmit call ([[SWS_DM_00348](#_bookmark41)]).*♩(RS_Diag_04168)*

> 当UDS传输协议实现对网络层有最终反馈，即传输触发的UDS消息（参见SWS_DM_00348）是否能够发送到网络上，DM将通过调用ara :: diag :: uds_transport :: UdsTransportProtocolMgr :: TransmiConfirmation（参见SWS_DM_00330）来通知，将消息参数设置为ara :: diag :: uds_transport :: UdsTransportPrtocolHandler :: Transmit调用（参见SWS_DM_00348）的消息参数。（RS_Diag_04168）


**[SWS_DM_00351]**{DRAFT} **Confirmation Result** *[*When the the network layer was able to send the UDS response message to the network, the result argument in the ara::diag::uds_transport::UdsTransportProtocolMgr::TransmiConfirmation shall be set to kTransmitOk, otherwise to kTransmitFailed.*♩ (RS_Diag_04168)*

> **[SWS_DM_00351]**{草案} **确认结果** *[*当网络层能够将UDS响应消息发送到网络时，ara :: diag :: uds_transport :: UdsTransportProtocolMgr :: TransmiConfirmation中的结果参数应设置为kTransmitOk，否则设置为kTransmitFailed。*♩ (RS_Diag_04168)*

### Channel Notifications


Each incoming UDS request message is assigned an exact UDS Transport Prtocol implementation specific Channel. With the normal request/reply paradigm in diagnostics, the UDS response message is sent out at the same Channel, from which the UDS request has been received. Therefore the Channel identifier is given to the DM in ara::diag::uds_transport::UdsTransportProtocolMgr::IndcateMessage in the form of parameter globalChannelId. The Channel part from this parameter is then used in the corresponding response in ara::diag::uds\transport::UdsTransportProtocolHandler::Transmit.

> 每个传入的UDS请求消息都会被分配一个精确的UDS传输协议实现的特定通道。在诊断中，使用正常的请求/回复范式，UDS响应消息将从接收到UDS请求的同一通道发出。因此，通道标识符将以ara::diag::uds_transport::UdsTransportProtocolMgr::IndcateMessage中的参数globalChannelId的形式给出给DM。然后，在相应的响应中使用ara::diag::uds\transport::UdsTransportProtocolHandler::Transmit中的通道部分。


There are use cases, where a diagnostic request might be answered deferred after the restart of the DM. The UDS service for ECU reset is a candidate for such a requirement. The upcoming requirements shall cover this use case.

> 有些使用案例，在DM重新启动后，诊断请求可能会被推迟回答。ECU重置的UDS服务是这样一个要求的候选者。即将到来的要求将涵盖这种使用案例。


[]{#_bookmark44 .anchor}**[SWS_DM_00356]**{DRAFT} **Requesting Notification of a channel reestablishment** *[*The DM shall call the ara::diag::uds_transport::UdsTransportProtocoHandler::NotifyReestablishment method of a UDS Transport Protocol implementation, with the parameter channelId set to the identifier of the Channel, where it needs a re-establishment notification.*♩(RS_Diag_04168)*

> DM 应调用 ara::diag::uds_transport::UdsTransportProtocoHandler::NotifyReestablishment 方法，将参数 channelId 设置为通道的标识符，以获得重新建立通知。（RS_Diag_04168）


**[SWS_DM_00357]**{DRAFT} **Validity/lifetime of a Notification Request** *[*A notifiction request registered at a UDS Transport Protocol implementation according to [[SWS_DM_00356](#_bookmark44)] is valid only for the next call to ara::diag::uds_tranport::UdsTransportProtocolHandler::Start until the following call to ara::diag::uds_transport::UdsTransportProtocolHandler::Stop of this UDS Transport Protocol implementation.*♩(RS_Diag_04168)*

> **[SWS_DM_00357]**{草案} **通知请求的有效期/生命周期** *[*根据[[SWS_DM_00356](#_bookmark44)]在UDS传输协议实现中注册的通知请求仅在下一次调用ara :: diag :: uds_tranport :: UdsTransportProtocolHandler :: Start有效，直到该UDS传输协议实现的下一次调用ara :: diag :: uds_transport :: UdsTransportProtocolHandler :: Stop。*♩（RS_Diag_04168）*


**[SWS_DM_00358]**{DRAFT} **Notification of a channel reestablishment** *[*UDS Transport Protocol implementation shall call ara::diag::uds_transport::UdsTransportProtocolMgr::ChannelReestablished on its UdsTranportProtocolMgr reference ((see [[SWS_DM_00330](#_bookmark33)]) setting the globalChanelId argument to the tuple consisting of its own handlerIdent and the ChanelID it has received in NotifyReestablishment (see [[SWS_DM_00356](#_bookmark44)]) once, in case it detects, that the underlying network Channel represented by ChannelID is getting available again.*♩(RS_Diag_04168)*

> **[SWS_DM_00358]**{草案} **重新建立通道的通知** *[*UDS传输协议实现应该在其UdsTranportProtocolMgr引用上调用ara :: diag :: uds_transport :: UdsTransportProtocolMgr :: ChannelReestablished（参见[[SWS_DM_00330](#_bookmark33)])，将全局ChanelId参数设置为由其自身的handlerIdent和NotifyReestablishment中接收的ChanelID组成的元组（参见[[SWS_DM_00356](#_bookmark44)])，一旦检测到由ChannelID表示的底层网络通道又可用了。*♩（RS_Diag_04168）*


**[SWS_DM_00359]**{DRAFT} **Persistent Storage of Notification Request** *[*UDS Transport Protocol implementation shall store the notification request (see [[SWS_DM_00356](#_bookmark44)]) persistently, to be able to fulfill the notification even after a DM restart.*♩(RS_Diag_04168)*

> **[SWS_DM_00359]**{草案} **持久化存储通知请求** *[*UDS传输协议实现应持久化存储通知请求（参见[[SWS_DM_00356](#_bookmark44)])，以便即使DM重新启动也能够实现通知。*♩(RS_Diag_04168)*

### DoIP


**[SWS_DM_00005]**{DRAFT} **DoIP Support** *[*The DM shall implement/provide a UDS Transport Layer implementation on Ethernet compliant with ISO-13400-2[[5](#_bookmark11)], also called DoIP.*♩(SRS_Eth_00083)*

> **[SWS_DM_00005]**{草案} **DoIP 支持** *[*DM 应实现/提供一个符合 ISO-13400-2[[5](#_bookmark11)] 的 Ethernet 上的 UDS 传输层实现，也称为 DoIP。*♩(SRS_Eth_00083)*


**[SWS_DM_00475]**{DRAFT} **DoIP Version** *[*The DM shall support DoIP ISO 13400-2[[5](#_bookmark11)] specification.*♩(RS_Diag_04242)*

> **[SWS_DM_00475]**{草案} **DoIP版本** *[*DM应支持DoIP ISO 13400-2[[5](#_bookmark11)]规范。*♩(RS_Diag_04242)*


Note: According to the ISO 13400-2[[5](#_bookmark11)] specification, the DoIP entity supports protocol version = 0xFF in the vehicle identification request message.

> 根据ISO 13400-2[[5](#_bookmark11)]规范，DoIP实体在车辆识别请求消息中支持协议版本= 0xFF。


[]{#_bookmark46 .anchor}**[SWS_DM_00449]**{DRAFT} **Supported DoIP message types** *[*The DM shall suport the DoIP message types listed in Table [7.1](#_bookmark47).*♩(SRS_Eth_00026, SRS_Eth_00080, SRS_Eth_00082, SRS_Eth_00083, SRS_Eth_00084, SRS_Eth_00027)*

> SWS_DM_00449（草案）支持的DoIP消息类型：DM应支持表7.1中列出的DoIP消息类型（SRS_Eth_00026、SRS_Eth_00080、SRS_Eth_00082、SRS_Eth_00083、SRS_Eth_00084和SRS_Eth_00027）。


**Table 7.1: Supported DoIp message types**

> 表7.1：支持的DoIp消息类型


**[SWS_DM_00855]**{DRAFT} **Providing the VIN in DoIP protocol messages** *[*DM shall retrieve the VIN required in some DoIP messages by reading the data from the DID with DiagnosticDataIdentifier.representsVin set to TRUE.*♩(SRS_Eth_00026)*

> **[SWS_DM_00855]**{草案} **在DoIP協議消息中提供VIN** *[*DM應該從具有DiagnosticDataIdentifier.representsVin設置為TRUE的DID中讀取一些DoIP消息中所需的VIN。*♩(SRS_Eth_00026)*


**[SWS_DM_00814]**{DRAFT} **Providing the PowerMode in DoIP protocol messages** *[*If the DM needs to know the PowerMode to be able to react or answer on any DoIP message, it shall obtain it by calling the method ara::diag::DoIPPowerMode:GetDoIPPowerMode.*♩(SRS_Eth_00026, SRS_Eth_00080)*

> **[SWS_DM_00814]**{草案} **在DoIP协议消息中提供PowerMode** *[*如果DM需要知道PowerMode以便能够对任何DoIP消息作出反应或回答，它应通过调用ara :: diag :: DoIPPowerMode：GetDoIPPowerMode方法来获取它。*♩（SRS_Eth_00026，SRS_Eth_00080）*


**[SWS_DM_01525]**{DRAFT} **ara::diag::DoIPPowerMode not yet offered when client requests DoIP PowerMode** *[*If a client requests the DoIP power mode infomation, the DM shall send a DoIP power mode information response with power mode value 0 (\"Not ready\") as long as the Offer function of the ara::diag::DoIPPoweMode interface is not called yet by the Adaptive Application that provides it (as defined in the ISO 13400-2:2012 specification).*♩(SRS_Eth_00080)*

> 如果客户端请求DoIP功率模式信息，只要提供该接口的自适应应用程序尚未调用ara :: diag :: DoIPPoweMode接口的Offer功能（如ISO 13400-2：2012规范中定义），DM将发送DoIP功率模式信息响应，其功率模式值为0（“未准备就绪”）。（SRS_Eth_00080）


**[SWS_DM_00813]**{DRAFT} **Providing the GID in DoIP protocol messages** *[*If the DM needs to know the GID and the status of the GID to be able to react or answer on any DoIP message, it shall obtain it by calling the method ara::diag::DoIGroupIdentification::GetGidStatus.*♩(SRS_Eth_00026)*

> **[SWS_DM_00813]**{草案} **在DoIP协议消息中提供GID** *[*如果DM需要知道GID和GID的状态以便能够对任何DoIP消息作出反应或回复，它应通过调用ara :: diag :: DoIGroupIdentification :: GetGidStatus方法获得它。*♩(SRS_Eth_00026)*


**[SWS_DM_01527]**{DRAFT} **ara::diag::DoIPGroupIdentification not yet ofered when DM needs to retrieve GID** *[*If the DM shall send the GID while the Offer function of the ara::diag::DoIPGroupIdentification interface was not called yet by the Adaptive Application that provides it, the DM shall send a GID value equal to 0x00 0x00 0x00 0x00 0x00 0x00 or 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF (\"value not set\"), as defined in Table 5 and Table 1 in the ISO 13400-2:2012 specification.*♩(SRS\Eth_00026)*

> **[SWS_DM_01527]**{草案} **ara :: diag :: DoIPGroupIdentification 当DM需要检索GID时尚未提供** *[*如果DM在提供ara :: diag :: DoIPGroupIdentification接口的自适应应用程序尚未调用报价功能时，DM应发送GID值等于0x00 0x00 0x00 0x00 0x00 0x00或0xFF 0xFF 0xFF 0xFF 0xFF 0xFF（“值未设置”），如ISO 13400-2：2012规范中的表5和表1所定义。*♩（SRS \ Eth_00026）*


**[SWS_DM_00815]**{DRAFT} **When to send Vehicle announcement messages on interfaces without activation line control** *[*The DM gets notified, when to send out vehicle announcement messages on a network interface without activation line cotrol (isActivationLineDependent == FALSE) by a call to method ara::diag:DoIPTriggerVehicleAnnouncement::TriggerVehicleAnnouncement, which DM has to provide. The method call contains the network interface identified via neworkInterfaceId on which the announcement shall be sent.*♩(RS_Diag_04242)*

> **[SWS_DM_00815]**{草案} **在没有激活线控制的接口上发送车辆公告消息何时** *[*当DM需要发出在没有激活线控制（isActivationLineDependent == FALSE）的网络接口上的车辆公告消息时，DM会收到通知。DM需要调用ara :: diag：DoIPTriggerVehicleAnnouncement :: TriggerVehicleAnnouncement方法来发送此消息，该方法调用中包含通过neworkInterfaceId识别的网络接口，其上将发送公告。*♩（RS_Diag_04242）*


**[SWS_DM_00816]**{DRAFT} **Notification of activation line status change on actvation line controlled network interfaces** *[*The DM gets notified, when the activation line status changes for activation line controlled network interfaces (isActivatioLineDependent == TRUE) via software components providing an instance of DianosticDoIPActivationLineInterface. The DM shall identify for which network interface an instance of DiagnosticDoIPActivationLineInterface is providing the activation line status via call to method ara::diag::DoIPActivationLine::GetNetworkInterfaceId. Whenever the status of the activation line of the rlated network interface changes, the application calls ara::diag::DoIPActivtionLine::UpdateActivationLineState.*♩(RS_Diag_04242)*

> **[SWS_DM_00816]**{草稿} **关于激活线控制网络接口的激活线状态更改的通知** *[*当激活线控制的网络接口（isActivatioLineDependent == TRUE）的激活线状态发生变化时，DM会通过提供DianosticDoIPActivationLineInterface实例的软件组件收到通知。 DM应该通过调用ara :: diag :: DoIPActivationLine :: GetNetworkInterfaceId方法来识别哪个网络接口提供激活线状态。 无论相关网络接口的激活线状态发生何种变化，应用程序都会调用ara :: diag :: DoIPActivtionLine :: UpdateActivationLineState。*♩（RS_Diag_04242）*


The DM needs to instantiate a singleton of ara::diag::DoIPTriggerVehcleAnnouncement only. The ara::diag::DoIPTriggerVehicleAnnouncment::TriggerVehicleAnnouncement method gets the according networInterfaceId passed, to which the DoIP Vehicle Announcement Message (see [[SWS_DM_00449](#_bookmark46)]) shall be sent. Different AAs monitoring the DoIP Activation Line will inform the DM about an Activation Line toggle on its monitoring networkIntefaceId.

> DM需要仅实例化ara::diag::DoIPTriggerVehcleAnnouncement的单例。ara::diag::DoIPTriggerVehicleAnnouncment::TriggerVehicleAnnouncement方法获取相应的networInterfaceId，以发送DoIP车辆公告消息（参见[[SWS_DM_00449](#_bookmark46)]）。不同的AA监视DoIP激活线会通知DM关于它监视的networkIntefaceId上的激活线切换。


**[SWS_DM_01526]**{DRAFT} **ara::diag::DoIPActivationLine not yet offered on activation line controlled network interfaces** *[*As long as the Offer function of the ara::diag::DoIPActivationLine interface is not called by some Adaptive Applcation for a given activation line controlled network interface (DoIpNetworkConfiuration.isActivationLineDependent == TRUE) the DoIP communication shall not be started on the related network interface, since the DoIP Activation Line state cannot be sensed by the DM (according to the ISO 13400-2:2012 specification).*♩()*

> **[SWS_DM_01526]**{草案} **ara :: diag :: DoIPActivationLine尚未提供激活线控制的网络接口** *[*只要Adaptive Applcation没有调用ara :: diag :: DoIPActivationLine接口的Offer功能，就不会在相关网络接口上启动DoIP通信，因为DM无法感知DoIP激活线状态（根据ISO 13400-2:2012规范）。*♩（）*


**[SWS_DM_01361]**{DRAFT} **Providing the EID in DoIP protocol messages** *[*If the DM needs to know the EID to be able to react or answer on any DoIP message , it shall obtain it by calling the method ara::diag::DoIPEntityIdentification::GetEntityId if configured according to [TPS_MANI_03294].*♩(SRS_Eth_00026)*

> **[SWS_DM_01361]**{草案} **在DoIP协议消息中提供EID** *[*如果DM需要知道EID以便能够对任何DoIP消息做出反应或回答，则应根据[TPS_MANI_03294]进行配置，并调用ara :: diag :: DoIPEntityIdentification :: GetEntityId方法获取它。*♩(SRS_Eth_00026)*


**[SWS_DM_01528]**{DRAFT} **ara::diag::DoIPEntityIdentification not yet offered when DM needs to retrieve EID from Application** *[*If the DM shall send the EID while the Offer function of the ara::diag::DoIPEntityIdentification iterface was not called yet by the Adaptive Application that provides it, the DM shall send a EID value equal to 0x00 0x00 0x00 0x00 0x00 0x00 or 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF (\"value not set\"), as defined in Table 5 and Table 1 in the ISO 13400-2:2012 specification.*♩(SRS_Eth_00026)*

> 如果DM需要从应用程序检索EID，而ara :: diag :: DoIPEntityIdentification接口的Offer功能尚未被提供，则DM应发送EID值等于0x00 0x00 0x00 0x00 0x00 0x00或0xFF 0xFF 0xFF 0xFF 0xFF 0xFF（“值未设置”），如ISO 13400-2：2012规范中的表5和表1所定义。♩（SRS_Eth_00026）

![](./media/image17.png){width="6.353305993000875in" height="3.5859372265966756in"}

**Figure 7.2: Example Sequence Diagram for Activation Line and Vehicle Announcement API use case**

### Dispatching of UDS Requests


The Transport Protocol Manager has to dispatch the UDS-messages between the Transport Protocol Handler and the Diagnostic Server instances. To do this the Transport Protocol Manager uses the following information as provided by the Transport Protocol Handler indication function on received UDS requests:

> 传输协议管理器必须在传输协议处理程序和诊断服务器实例之间分派UDS消息。 为此，传输协议管理器使用传输协议处理程序指示功能提供的以下信息：接收到的UDS请求：

- Target Address
- Target Address Type (phys / func)


In transmit direction the Transport Protocol Manager provides the UDS mesage from the Diagnostic Server and calls the Transmit method from the Transport Protocol Handler.

> 在传输方向上，传输协议管理器从诊断服务器提供UDS消息，并调用传输协议处理器的传输方法。


[]{#_bookmark49 .anchor}**[SWS_DM_00390]**{DRAFT} **Dispatching physical Request** *[*DM shall dispatch each UDS physical request to the Diagnostic Server instance responsible for the SoftwareCluster with diagnosticAddress matching the TargetAddress of the received UDS request and addressSemantics set to physicalAddress.*♩(RS\Diag_04216)*

> [SWS_DM_00390]{DRAFT} 分派物理请求 *[*DM 应将每个UDS物理请求分派给负责与接收到的UDS请求的TargetAddress匹配的SoftwareCluster的诊断服务器实例，并将addressSemantics设置为physicalAddress。*♩(RS\Diag_04216)*


[]{#_bookmark50 .anchor}**[SWS_DM_00391]**{DRAFT} **Dispatching functional Request** *[*DM shall dispatch each UDS functional request to all Diagnostic Server instances responsible for those SoftwareClusters with a diagnosticAddress matching the TargetAddress of the received UDS request and addressSemantics set to functionalAddress.*♩ (RS_Diag_04216)*

> DM 必须将每个UDS功能请求分派给所有负责这些软件集群的诊断服务器实例，其诊断地址与接收到的UDS请求的目标地址匹配，并且地址语义设置为功能地址。（RS_Diag_04216）

## SOVD Transport Layer


Beside the opportunity to perform diagnostic communication between a diagnostic client and the Diagnostic Manager via DoIP, the DM will provide further communcation interfaces for SOVD-based communication. Therefore, the DM requires one or more socket connections including port and IP address to be able to establish a HTTP resp. HTTPS connection.

> 除了通过DoIP进行诊断客户端和诊断管理器之间的诊断通信的机会外，DM还将提供进一步的基于SOVD的通信接口。因此，DM需要一个或多个包括端口和IP地址的套接字连接，以便能够建立HTTP或HTTPS连接。


**[SWS_DM_01369]**{DRAFT} **DM as SOVD Server** *[*The DM shall act as SOVD Server as specified by ASAM SOVD[[2](#_bookmark9)] according to the configuration referenced by SovdModulInstantiation.communicationConnector.*♩(RS_Diag_04256)*

> **[SWS_DM_01369]**{草案} **DM 作为 SOVD 服务器** *[*DM 应按照 ASAM SOVD[[2](#_bookmark9)] 指定的方式作为 SOVD 服务器，根据 SovdModulInstantiation.communicationConnector 所引用的配置。*♩(RS_Diag_04256)*


**[SWS_DM_01370]**{DRAFT} **DNS-Based Service Discovery and Multicast DNS for SOVD** *[*The DM shall support DNS-SD (DNS-Based Service Discovery) and mDNS (Muticast DNS) as specified by ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04256)*

> **[SWS_DM_01370]**{草稿} **SOVD的基于DNS的服务发现和多播DNS** *[*DM应支持ASAM SOVD[[2](#_bookmark9)]中指定的DNS-SD（基于DNS的服务发现）和mDNS（多播DNS）。*♩(RS_Diag_04256)*


**[SWS_DM_01371]**{DRAFT} **Secure Communication for SOVD using TLS** *[*The DM shall secure its HTTP connections using TLS according to the configuration referenced by SovdModuleInstantiation.securePropsForTcp.*♩(RS_Diag_04256)*

> **[SWS_DM_01371]**{草稿} **SOVD 使用 TLS 的安全通信** *[*DM 应根据 SovdModuleInstantiation.securePropsForTcp 引用的配置使用 TLS 来保护其 HTTP 连接。*♩(RS_Diag_04256)*


**[SWS_DM_01372]**{DRAFT} **Representation of DM by SOVD component** *[*The DM shall be represented by an SOVD component that shall be a child of the SOVD Server in the role components. The corresponding component-identifier shall be derived from the SovdServerInstantiation.*♩(RS_Diag_04256)*

> **[SWS_DM_01372]**{草案} **DM的SOVD组件表示** *[*DM必须由SOVD组件代表，该组件必须作为角色组件的SOVD服务器的子组件。相应的组件标识应从SovdServerInstantiation派生。*♩(RS_Diag_04256)*


**[SWS_DM_01373]**{DRAFT} **Representation of Diagnostic Server instance by SOVD subcomponents** *[*Each Diagnostic Server instance shall be reprsented by one corresponding SOVD component that shall be a child of the SOVD coponent representing the DM in the role subcomponent. The corresponding componenidentifier shall be derived from the SoftwareClusterSovdAddress.*♩(RS_Diag\04256)*

> **[SWS_DM_01373]**{草案} **诊断服务器实例的 SOVD 子组件表示** *[*每个诊断服务器实例都应由一个相应的 SOVD 组件表示，该组件应是表示 DM 在角色子组件中的一个子组件。相应的组件标识符应从SoftwareClusterSovdAddress中派生。*♩(RS_Diag\04256)*


**[SWS_DM_01374]**{DRAFT} **Dispatching of SOVD requests/responses** *[*Within the DM SOVD requests and responses shall be dispatched to and from the Diagnostic Server instances based on the SOVD path.*♩(RS_Diag_04256)*

> **[SWS_DM_01374]**{草稿} **发送SOVD请求/响应** *[*根据SOVD路径，DM中的SOVD请求和响应应该从和发送到诊断服务器实例。*♩(RS_Diag_04256)*

## Diagnostic Server


The AUTOSAR adaptive platform is able to be extended with new software packages without re-flashing the entire ECU. The individual software packages are described by

> AUTOSAR 自适应平台可以通过添加新的软件包来扩展，而无需重新烧录整个 ECU。各个软件包由描述。


SoftwareClusters. To support the current approaches of diagnostic management (like software updates), two architecture approaches are possible:

> 为了支持当前的诊断管理方法（如软件更新），可以采用两种架构方法：SoftwareClusters。

- Each SoftwareCluster has its own diagnosticAddress and DiagnoticContributionSet.
- Multiple SoftwareCluster share the diagnosticAddress and also the DagnosticContributionSet.


For details on the semantics and precise configuration of SoftwareClusters, see [[13](#_bookmark18)].

> 详细了解SoftwareClusters的语义和精确配置，请参见[[13](#_bookmark18)]。


DM is intended to support an own Diagnostic Server instance per DiagnoticContributionSet. All Diagnostic Server instances share the same UDS TransportLayer (see Figure [7.1](#_bookmark25)) and each Diagnostic Server manages its own resources.

> DM旨在为每个DiagnosticContributionSet支持自己的诊断服务器实例。所有诊断服务器实例共享相同的UDS传输层（参见图7.1），每个诊断服务器管理自己的资源。


[]{#_bookmark53 .anchor}**[SWS_DM_00420]**{DRAFT} **Instantiation of Diagnostic Server** *[*DM shall instantiate an independent Diagnostic Server per DiagnosticContributionSet, which is reerenced by one or multiple SoftwareClusters in the role of diagnosticExtract, with dedicated resources and functionality configured by this DiagnosticContrbutionSet.*♩(RS_Diag_04216)*

> DM应为每个DiagnosticContributionSet实例化一个独立的诊断服务器，该服务器以诊断提取的角色被一个或多个软件集参考，并且具有由此DiagnosticContrbutionSet配置的专用资源和功能。♩（RS_Diag_04216）


Details on required configuration items are described in section [7.6.5](#required-configuration).

> 详细的必要配置项目信息描述在[7.6.5](#required-configuration)节中。


This chapter focuses on requirements concerning a single Diagnostic Server, hence we assume that

> 本章节重点关注单一诊断服务器的要求，因此我们假定


- requests from Diagnostic Clients are already dispatched towards this Diagnostic Server according to [[SWS_DM_00390](#_bookmark49)] and [[SWS_DM_00391](#_bookmark50)],

> 根据[[SWS_DM_00390](#_bookmark49)]和[[SWS_DM_00391](#_bookmark50)]，诊断客户端的请求已经被转发到该诊断服务器上。

- DEXT configuration elements used in a requirement are meant to be part of the DiagnosticContributionSet associated to the Diagnostic Server according to [[SWS_DM_00420](#_bookmark53)].

> 配置元素使用在要求中的DEXT，应该根据[[SWS_DM_00420](#_bookmark53)]成为与诊断服务器相关联的DiagnosticContributionSet的一部分。


In particular, we note that requests addressing different Diagnostic Server istances shall be processed independently by the respective Diagnostic Servers.

> 特别需要指出的是，针对不同诊断服务器实例的请求应由各自的诊断服务器独立处理。


**[SWS_DM_01345]**{DRAFT} **Lifetime of MetaInfo** *[*For each method called from DM to application with a MetaInfo as parameter, the DM shall limit the guaranteed life time of the MetaInfo object only to the time that function call is active.*♩(RS_Diag_04170)*

> **[SWS_DM_01345]**{草案} **MetaInfo的生命周期** *[*DM从应用程序调用的每个方法都使用MetaInfo作为参数，DM应将MetaInfo对象的保证生命周期仅限于该函数调用处于活动状态时。*♩（RS_Diag_04170）*


Note: An example of a method call with MetaInfo as parameter is [SWS_DM_00618]. In general the callee is not supposed to store or reuse the MetaInfo object after the DM function has returned. This would result in undefined behavior.

> 注意：以MetaInfo作为参数的方法调用的一个例子是[SWS_DM_00618]。一般来说，被调用者在DM函数返回后不应该存储或重复使用MetaInfo对象。这将导致未定义的行为。

### Interaction between DM and applications


This chapter introduces ara::diag and provides general information on how these intefaces behave and how they shall be used.

> 本章介绍ara::diag，并提供有关这些接口的行为以及如何使用它们的一般信息。


Most interaction between DM and application is realized by instances of ara::diag classes. The application instantiates the ara::diag objects and uses the provided iterface to interact with the DM. The application itself can be deployed anywhere. They can run in the local SoftwareCluster, but also remote on other SoftwareCluters or even other hardware is possible.

> 大多数DM和应用程序之间的交互是通过ara::diag类的实例实现的。应用程序实例化ara::diag对象，并使用提供的接口与DM进行交互。该应用程序本身可以部署在任何地方。它们可以运行在本地软件集群中，也可以远程运行在其他软件集群或其他硬件上。


**[SWS_DM_01529]**{DRAFT} **Behavior on failed ara::diag instantiation** *[*If a client application instantiates an ara::diag interface with an invalid instance specifier in the constructor, the DM shall treat it as a violation according to [SWS_CORE_90006] .*♩ (RS_AP_00149)*

> **[SWS_DM_01529]**{草案} **失败的ara :: diag实例化的行为** *[*如果客户端应用程序在构造函数中使用无效的实例说明符实例化ara :: diag接口，则DM应按照[SWS_CORE_90006]处理它。*♩ (RS_AP_00149)*


Note: There are various reasons why an instantiation of an ara::diag interface can fail. Constructing the object requires valid PortPrototype, valid mapping and valid deploment configuration in the model. This needs to be checked in the constructor.

> 注意：ara :: diag接口实例化失败的原因有很多。构造对象需要有效的PortPrototype、有效的映射和模型中的有效部署配置。这需要在构造函数中进行检查。

### Diagnostic Communication Management


A central element in the handling of diagnostic communication is the term Diagnotic Conversation, which is described in section [7.6.2.1](#diagnostic-conversations). A UDS request is always processed in the context of a Diagnostic Conversation. A single Diagnostic Server can handle multiple Diagnostic Conversations in parallel.

> 中央元素在诊断通信的处理中是诊断对话，在[7.6.2.1]（＃诊断对话）节中有描述。 UDS请求总是在诊断对话的背景下处理。单个诊断服务器可以同时处理多个诊断对话。

### Diagnostic Conversations


A Diagnostic Conversation depicts a conversation between a distinct Diagnotic Client and a Diagnostic Server instance. In contrast to CP, on AP the details of connections between Diagnostic Clients and Diagnostic Server instances are not statically configured, but a Diagnostic Conversation is dnamically allocated during run-time of the Diagnostic Server instance.

> 一次诊断对话描述了一个特定的诊断客户端与诊断服务器实例之间的对话。与CP相比，在AP中，诊断客户端与诊断服务器实例之间的连接细节不是静态配置的，而是在诊断服务器实例的运行时动态分配的诊断对话。


For an incoming UDS request, the Diagnostic Server instance is idetified via the target address of the UDS request (see [[SWS_DM_00390](#_bookmark49)], [[SWS_DM_00391](#_bookmark50)]), whereas the identification of the Diagnostic Client is tranport layer specific.

> 对于传入的UDS请求，通过UDS请求的目标地址（参见[[SWS_DM_00390](#_bookmark49)]，[[SWS_DM_00391](#_bookmark50)）可以识别出诊断服务器实例，而诊断客户端的识别则是特定于传输层的。


**[SWS_DM_00421]**{DRAFT} **Identification of a Diagnostic Client** *[*The Dianostic Server instance shall identify a Diagnostic Client by means of the tuple of sourceAddr and globalChannelId provided by the TP Layer on call of ara::diag::uds_transport::UdsTransportProtocolMgr::IndcateMessage, see [[SWS_DM_00347](#_bookmark35)].*♩(RS_Diag_04005)*

> **[SWS_DM_00421]**{草案} **诊断客户端的识别** *[*在调用ara::diag::uds_transport::UdsTransportProtocolMgr::IndcateMessage时，诊断服务器实例应通过TP层提供的sourceAddr和globalChannelId元组来识别诊断客户端，见[[SWS_DM_00347](#_bookmark35)]。*♩(RS_Diag_04005)*


**[SWS_DM_00046]**{DRAFT} **Each Diagnostic Conversation has its own sesion resources** *[*The Diagnostic Server instance shall provide each Dianostic Conversation with its own and independently managed diagnostic session, which can be any valid UDS session type.*♩(RS_Diag_04119, RS_Diag_04006)*

> **[SWS_DM_00046]**{草案} **每个诊断对话都有自己的会话资源** *[*诊断服务器实例应为每个诊断对话提供自己独立管理的诊断会话，可以是任何有效的UDS会话类型。*♩(RS_Diag_04119，RS_Diag_04006)*


**[SWS_DM_00047]**{DRAFT} **Each Diagnostic Conversation has its own security-level resources** *[*The Diagnostic Server instance shall provide each Diagnostic Conversation with its own and independently managed securitlevel.*♩(RS_Diag_04005)*

> **[SWS_DM_00047]**{草案}**每个诊断对话都有其自己的安全级别资源** *[*诊断服务器实例应为每个诊断对话提供其自己独立管理的安全级别。*♩(RS_Diag_04005)*

### [SWS_DM_01259] {DRAFT} Validation of Security Level Locked in


**ara::diag::Conversation::GetDiagnosticSecurityLevelShortName**

> **ara::diag::Conversation::取得诊断安全级别简称**


*[*If the application calls the ara::diag::Conversation::GetDiagnosticSecrityLevelShortName with the parameter securityLevel set to kLocked, the Diagnostic Server instance shall return error code kInvalidArgument.*♩ (RS_Diag_04005)*

> 如果应用程序调用ara::diag::Conversation::GetDiagnosticSecrityLevelShortName，并将参数securityLevel设置为kLocked，则诊断服务器实例将返回错误代码kInvalidArgument。

### [SWS_DM_01260] {DRAFT} Validation of Invalid Security Level in


**ara::diag::Conversation::GetDiagnosticSecurityLevelShortName**

> **ara::diag::Conversation::GetDiagnosticSecurityLevelShortName**：获取诊断安全级别简称


*[*If the application calls ara::diag::Conversation::GetDiagnosticSecrityLevelShortName with the parameter securityLevel set to value that is not equal to any ((DiagnosticSecurityAccess.requestSeedId + 1) / 2) in the DiagnosticContributionSet, the Diagnostic Server instance shall return error code kInvalidArgument.*♩(RS_Diag_04005)*

> 如果应用程序调用ara::diag::Conversation::GetDiagnosticSecrityLevelShortName，并将参数securityLevel设置为与DiagnosticContributionSet中任何(DiagnosticSecurityAccess.requestSeedId + 1) / 2不相等的值，诊断服务器实例将返回错误代码kInvalidArgument。♩（RS_Diag_04005）


**[SWS_DM_01261]**{DRAFT} **Validation of Invalid Session Level in ara::diag::Conversation::GetDiagnosticSessionShortName** *[*If the application calls ara::diag::Conversation::GetDiagnosticSessionShorName with the parameter session set to a value that is not equal to any configured DiagnosticSession in the DiagnosticContributionSet, the Diagnostic Server instance shall return error code kInvalidArgument.*♩(RS_Diag_04005)*

> **[SWS_DM_01261]**{草案} **ara :: diag :: Conversation :: GetDiagnosticSessionShortName中无效会话级别的验证** *[*如果应用程序使用参数session调用ara :: diag :: Conversation :: GetDiagnosticSessionShorName，而该参数的值不等于DiagnosticContributionSet中配置的任何DiagnosticSession，则诊断服务器实例应返回错误代码kInvalidArgument。*♩(RS_Diag_04005)*

### Parallel Client Handling


The DM is capable of parallel processing of client requests, as long as all clients are in the default session. If one client switches to a non-default session, the DM will process only diagnostic requests from the conversation of that tester which has requested the non-default session. The DM itself distinguishes between two kinds of parallel procesing in default session: Fully parallel processing and sequential processing, where a concurrent access can be denied with an NRC '0x21 (busyRepeatRequest)' or an iternal wait. In full parallel processing all application functions called from the DM would require a full reentrancy capability. Re-entrant software development is often by far more complex than non-reentrant software. The DM respects this situation and leaves it up to the application software developer to decide if a given application can be called re-entrant. A vehicle manufacturer may require that certain applications are supporing re-entrant functionality. The DM needs to evaluate the information of supported re-entrancy and behave accordingly. All required 'ara::diag' ports have a constructor parameter to tell the DM if a certain port allows re-entrant calls or not.

> DM可以并行处理客户端请求，只要所有客户端都在默认会话中。如果一个客户端切换到非默认会话，DM将只处理该请求非默认会话的测试者会话中的诊断请求。DM本身区分两种在默认会话中的并行处理：完全并行处理和顺序处理，其中可以使用NRC '0x21（busyRepeatRequest）'或内部等待来拒绝并发访问。在完全并行处理中，所有从DM调用的应用程序功能都需要完全可重入性。重入式软件开发通常远比非重入式软件复杂得多。DM尊重这种情况，并由应用程序软件开发人员决定给定的应用程序是否可以重新调用。汽车制造商可能要求某些应用程序支持可重入功能。DM需要评估支持可重入性的信息，并相应地采取行动。所有所需的“ara :: diag”端口都有一个构造函数参数，用于告诉DM某个端口是否允许重入调用。


**Pseudo Parallel Mode** In pseudo parallel mode, the DM is capable of parallel procesing of client requests, as long as all clients are in the default session. If one client switches to a non-default session, the DM will process only diagnostic requests

> **伪并行模式** 在伪并行模式下，DM能够并行处理客户端请求，只要所有客户端都处于默认会话中。如果一个客户端切换到非默认会话，DM将只处理诊断请求。


from the conversation of that tester which has requested the non-default session. The DM itself distinguishes between two kinds of parallel processing in default session: Fully parallel processing and sequential processing, where a concurrent access can be denied with an NRC '0x21 (busyRepeatRequest)' or an internal wait. In full parallel processing all application functions called from the DM would require a full reentrancy capability. Re-entrant software development is often by far more complex than non-reentrant software. The DM respects this situation and leaves it up to the application software developer to decide if a given application can be called re-entrant. A vehicle manufacturer may require that certain applictions are supporting re-entrant functionality. The DM needs to evaluate the infomation of supported re-entrancy and behave accordingly. All required 'ara::diag' ports have a constructor parameter to tell the DM if a certain port allows re-entrant calls or not.

> 从请求非默认会话的测试者的对话中，DM本身区分了两种默认会话中的并行处理：完全并行处理和顺序处理，其中可以通过NRC '0x21（busyRepeatRequest）'或内部等待来禁止并发访问。在完全并行处理中，从DM调用的所有应用程序功能都需要完全可重入的能力。重入式软件开发通常远比非重入式软件复杂得多。DM尊重这种情况，并由应用程序软件开发人员决定给定的应用程序是否可以被重新调用。汽车制造商可能要求某些应用程序支持重入功能。DM需要评估支持重入的信息，并相应地做出反应。所有需要的'ara：diag'端口都有一个构造函数参数来告诉DM某个端口是否允许重入调用。


**Impact of SOVD** With the introduction of SOVD[[2](#_bookmark9)] not only parallel handling of multple UDS(ISO 14229-1) clients needs to be considered but also SOVD must be taken into account. The SOVD lock mechanism needs to be treated specially here. The SOVD lock mechanism allows to gain exclusive access to a Diagnotic server. Thus, if a SOVD lock was acquired from any client, parallel access with multiple UDS (ISO 14229-1) or SOVD clients shall not be possible. For SOVD requests without an SOVD lock the same parallel execution rules as for ISO 14229-1 apply. Further details regarding parallel handling for SOVD are discussed in section 7.6.3.1.

> 随着SOVD[[2](#_bookmark9)]的引入，不仅需要考虑多个UDS（ISO 14229-1）客户端的并行处理，还必须考虑SOVD。这里必须特别处理SOVD锁定机制。SOVD锁定机制允许获得对诊断服务器的独家访问权。因此，如果任何客户端获得了SOVD锁，则无法使用多个UDS（ISO 14229-1）或SOVD客户端进行并行访问。对于没有SOVD锁的SOVD请求，应遵循与ISO 14229-1相同的并行执行规则。关于SOVD的并行处理的更多细节可参见第7.6.3.1节。


**[SWS_DM_00940]**{DRAFT} **Re-entrant ara::diag interface calls for service prcessing** *[*The DM shall only call a method on an interface for service processing in a re-entrant way, if the DM is

> **[SWS_DM_00940]**{草案} **重入式ara :: diag接口调用服务处理** *[*DM只有在DM重入方式下才能调用接口上的方法进行服务处理

- in default session and
- multiple conversation requests are being processed simultaneously and

- the requested diagnostic service requires that the DM is calling the same required port for different clients and

> 要求的诊断服务需要DM为不同的客户呼叫相同的必要端口。
- the interface constructor parameter typed by ara::diag::ReentrancyType

and

- the value of this parameter is set to kFully.

*♩(RS_Diag_04166)*


In any other case, the DM will not call a method re-entrant and behave according to ISO 14229-1. There are various ways how a DM can handle concurrent requests to the same resource. It is implementation specific, which solution is chosen. One of the options is to return an NRC '0x21 (busyRepeatRequest)', but also other means such as delaying the request might be used. The DM does explicitly provide the possibility to implement project specific solutions to meet the vehicle manufacturers diagnostic requirements.

> 在其他任何情况下，DM都不会调用可重入方法，而是根据ISO 14229-1行事。DM处理对同一资源的并发请求有多种方式，具体由实现决定。其中一种选择是返回NRC '0x21 (busyRepeatRequest)'，也可以使用其他方法，如延迟请求。DM明确提供了实现项目特定解决方案的可能性，以满足汽车制造商的诊断要求。


[]{#_bookmark58 .anchor}**[SWS_DM_00941]**{DRAFT} **Re-entrant ara::diag interface calls for DID read prcessing** *[*The DM shall only call a read DID processing method on an interface for service processing in a re-entrant way if it is:

> **[SWS_DM_00941]**{草案} **重入式ara :: diag接口调用用于DID读取处理** *[*DM仅在以下情况下重入方式调用接口上的读取DID处理方法以进行服务处理：

- in default session and
- multiple conversation requests are being processed simultaneously and

- the requested diagnostic service requires that the DM is calling methods on class Namespace1OfPortInterface::Namespace2OfPortInterface::ShortnameOfDIPortInterface or ara::diag::GenericDataIdentfier and the same required port for different clients and

> 所请求的诊断服务需要DM调用Namespace1OfPortInterface::Namespace2OfPortInterface::ShortnameOfDIPortInterface或ara::diag::GenericDataIdentfier类的方法，以及为不同客户端提供相同的所需端口。
- the interface constructor has the parameter ara::diag::DataIdentifieReentrancyType and
- the value of read is set to kFully.

*♩(RS_Diag_04166)*


[]{#_bookmark59 .anchor}**[SWS_DM_00942]**{DRAFT} **Re-entrant ara::diag interface calls for DID write prcessing** *[*The DM shall only call a write DID processing method on an interface for service processing in a re-entrant way if it is:

> **[SWS_DM_00942]**{DRAFT} **重入式ara :: diag接口调用用于DID写入处理** *[*DM只有在服务处理中以重入方式调用接口的写入DID处理方法时才能：

- in default session and
- multiple conversation requests are being processed simultaneously and

- the requested diagnostic service requires that the DM is calling methods on class Namespace1OfPortInterface::Namespace2OfPortInterface::ShortnameOfDIPortInterface or ara::diag::GenericDataIdentfier and the same required port for different clients and

> 要求的诊断服务需要DM调用Namespace1OfPortInterface::Namespace2OfPortInterface::ShortnameOfDIPortInterface或ara::diag::GenericDataIdentfier类的方法，并且不同客户端需要相同的端口。
- the interface constructor has the parameter ara::diag::DataIdentifieReentrancyType and
- the value of write is set to kFully.

*♩(RS_Diag_04166)*


[]{#_bookmark60 .anchor}**[SWS_DM_00943]**{DRAFT} **Re-entrant ara::diag interface calls for DID read and write processing** *[*The DM shall only call a write and read DID processing method on an interface for service processing in a re-entrant way if it is:

> **[SWS_DM_00943]**{草案} **重入式ara :: diag接口调用用于DID读写处理** *[*DM只有在以下情况下才能以重入方式调用接口上的写入和读取DID处理方法进行服务处理：

- in default session and
- multiple conversation requests are being processed simultaneously and

- the requested diagnostic service requires that the DM is calling methods on class Namespace1OfPortInterface::Namespace2OfPortInterface::ShortnameOfDIPortInterface or ara::diag::GenericDataIdentfier and the same required port for different clients and

> 要求的诊断服务需要DM调用Namespace1OfPortInterface::Namespace2OfPortInterface::ShortnameOfDIPortInterface或ara::diag::GenericDataIdentfier类的方法，以及为不同客户端提供相同的所需端口。
- the interface constructor has the parameter ara::diag::DataIdentifieReentrancyType and
- the value readWrite is set to kFully.

*♩(RS_Diag_04166)*


**[SWS_DM_00944]**{DRAFT} **Validity of re-entrant ara::diag interface calls for DID processing** *[*If the DM is requested to perform a parallel call to a DID interface accoring to [[SWS_DM_00941](#_bookmark58)], [[SWS_DM_00942](#_bookmark59)] or [[SWS_DM_00943](#_bookmark60)] and the conditions for the parallel call are not fulfilled, the DM shall not call any method on that interface until any other call from the DM has returned.*♩(RS_Diag_04166)*

> **[SWS_DM_00944]**{草案} **DID处理的ara :: diag接口重入有效性** *[*如果DM被要求根据[[SWS_DM_00941](#_bookmark58)], [[SWS_DM_00942](#_bookmark59)] 或[[SWS_DM_00943](#_bookmark60)]执行并行调用DID接口，而不满足并行调用的条件，则DM在任何其他来自DM的调用返回之前，不得调用该接口上的任何方法。*♩(RS_Diag_04166)*


Note: The term \"pseudo parallel concept\" is already defined in ISO 14229-1, Annex J, and this possibility is explicitly limited to OBD in parallel with UDS protocol. The \"pseudo parallel mode\" allows other protocol combination can be processed in parallel. Particularly the use case of parallel processing of two or more UDS protocol requests.

> 注意：“伪并行概念”的术语已经在ISO 14229-1附录J中定义，并且这种可能性被明确限制为OBD与UDS协议并行。“伪并行模式”允许其他协议组合可以并行处理。特别是两个或多个UDS协议请求的并行处理用例。


**[SWS_DM_01375]**{DRAFT} **Behavior on locked SOVD** *[*If a service cannot be peformed or a session change is not possible due to SOVD lock, NRC 22 (conditiosNotCorrect) shall be returned.*♩(RS_Diag_04256)*

> **[SWS_DM_01375]**{草稿} **锁定SOVD时的行为** *[*如果由于SOVD锁定而无法执行服务或无法进行会话更改，则应返回NRC 22（conditiosNotCorrect）。*♩（RS_Diag_04256）*

### Life-cycle of a Diagnostic Conversation


The life-cycle of a Diagnostic Conversation starts with the first reception of a UDS request from the given Diagnostic Client to the Diagnostic Server istance and ends either if it is canceled (see section [7.6.2.9](#cancellation-of-a-diagnostic-conversation)) or if **all** of the following conditions are satisfied:

> 诊断对话的生命周期从给定诊断客户端向诊断服务器实例发送的第一个UDS请求开始，并在满足以下所有条件时结束：（参见[7.6.2.9]（#取消诊断对话））或取消：

- UDS request processing is finished by either


sending positive or final negative response and processing ara::diag:uds_transport::UdsTransportProtocolMgr::TransmitConfimation call from TP-layer according to [[SWS_DM_00350](#_bookmark42)],

> 发送正面或最终负面反馈，并根据[[SWS_DM_00350](#_bookmark42)]处理ara::diag:uds_transport::UdsTransportProtocolMgr::TransmitConfimation调用从TP层。

suppressing positive response,

> 抑制积极反应

suppressing negative response,

> 抑制负面反应

suppressing any response according to [[SWS_DM_00860](#_bookmark96)].

> 根据[[SWS_DM_00860](#_bookmark96)]抑制任何响应。

- associated Session is the Default Session.


Note: A Diagnostic Conversation in Non-Default Session is kept alive, as long as no Session time-out occurred. In this case, possibly multiple UDS requests are processed within this Lifecycle.

> 注意：在非默认会话中，诊断会话将一直保持活动状态，只要没有会话超时发生。在这种情况下，可能会在此生命周期内处理多个UDS请求。

### Diagnostic Conversation Service Interface


In some cases, the current state of a Diagnostic Conversation needs to be known by some Adaptive Applications. For this purpose, the Diagnostic Server instance provides instances of the Service Interface ara::diag::Conversation.

> 在某些情况下，有些自适应应用需要知道诊断对话的当前状态。为此，诊断服务器实例提供ara :: diag :: Conversation服务接口的实例。

### [SWS_DM_00840] {DRAFT} Instantiation of Diagnostic Conversation Interface


*[*The Diagnostic Server instance shall provide as many instances of ara::diag::Conversation class ([SWS_DM_00693])as the number of potential paralel Diagnostic Clients is configured by maxTesterConnections.*♩(RS_Diag\04166)*

> 诊断服务器实例应提供ara::diag::Conversation类（[SWS_DM_00693]）的实例数量，这些实例数量由maxTesterConnections配置的潜在并行诊断客户端的数量决定。


**[SWS_DM_00841]**{DRAFT} **Assignment of Diagnostic Conversation to Service Instances** *[*On establishment of a new Diagnostic Conversation, the Dianostic Server instance shall assign this Diagnostic Conversation to an inactive ara::diag::Conversation class Instance, i.e. the field value of ara:diag::ActivityStatusType is set to kInactive. After assignment, the fields of the ara::diag::Conversation class Instance shall be updated according to the state of the given Diagnostic Conversation, i.e.,

> **[SWS_DM_00841]**{草案} **将诊断对话分配给服务实例** *[*在建立新的诊断对话时，诊断服务实例应将此诊断对话分配给非活动的ara :: diag :: Conversation类实例，即ara: diag :: ActivityStatusType的字段值设置为kInactive。 分配后，根据给定诊断对话的状态更新ara :: diag :: Conversation类实例的字段。

- ara::diag::ActivityStatusType set to kActive,

- ara::diag::Conversation::ConversationIdentifierType matcing the values of ara::diag::uds_transport::UdsTransportPrtocolMgr::IndicateMessage call, that initiated the creation of this Diagnostic Conversation (see [[SWS_DM_00347](#_bookmark35)]),

> - 与ara::diag::uds_transport::UdsTransportPrtocolMgr::IndicateMessage调用中的值匹配，该调用启动了此诊断会话的创建（参见[[SWS_DM_00347](#_bookmark35)]），ara::diag::Conversation::ConversationIdentifierType

- a call to ara::diag::Conversation::GetDiagnosticSession will return the Diagnostic Session of this Diagnostic Conversation,

> 一个调用ara::diag::Conversation::GetDiagnosticSession的呼叫将会返回这个诊断对话的诊断会话。
- a call to ara::diag::Conversation::GetDiagnosticSecurityLevel


will return the Diagnostic Security Level of this Diagnostic Conversation.

> 返回此诊断会话的诊断安全级别。

*♩(RS_Diag_04166)*


**[SWS_DM_00844]**{DRAFT} **Updating DiagnosticConversation Service Instance fields** *[*During the life-cycle of a Diagnostic Conversation, the Diagnostic Server instance shall update the fields of the assigned ara::diag::Converstion class instance according to any change of the state of the Diagnostic Coversation.*♩(RS_Diag_04166)*

> **[SWS_DM_00844]**{草稿} **更新诊断会话服务实例字段** *[*在诊断会话的生命周期中，诊断服务器实例应根据诊断会话的状态变化更新分配的ara :: diag :: Converstion类实例的字段。*♩（RS_Diag_04166）*


[]{#_bookmark63 .anchor}**[SWS_DM_00843]**{DRAFT} **Reset Service Instance fields on end of Diagnostic Conversation** *[*If the life-cycle of a Diagnostic Conversation ends, the Dianostic Server instance shall reset

> 如果诊断对话的生命周期结束，诊断服务器实例应重置服务实例字段。

- the session reported with ara::diag::Conversation::GetDiagnostiSession to kDefaultSession
- the security level reported with ara::diag::Conversation::GetDiagnoticSecurityLevel to kLocked


of the assigned ara::diag::Conversation class instance.*♩(RS_Diag_04166)*

> 实例分配的ara::diag::Conversation类。♩（RS_Diag_04166）


Besides the described informative character of the ara::diag::Conversation class Interface, it also provides methods for interaction with the state of a Diagnostic Conversation.

> 除了描述ara :: diag :: Conversation类接口的信息性质外，它还提供了与诊断对话状态交互的方法。


**[SWS_DM_00842]**{DRAFT} **Default session change trigger from AAs** *[*If ara::diag::Conversation::ResetToDefaultSession method is called, the Dagnostic Server instance shall complete the latest ongoing request and then switch the Diagnostic Session of this Diagnostic Conversation to Default Sesion.*♩(RS_Diag_04006)*

> **[SWS_DM_00842]**{草案} **AAs的默认会话更改触发器** *[*如果调用ara::diag::Conversation::ResetToDefaultSession方法，则诊断服务器实例应完成最新的正在进行的请求，然后将此诊断会话的诊断会话切换到默认会话。*♩（RS_Diag_04006）*


**[SWS_DM_01355]**{DRAFT} **Consecutive registration of notifier with SetActivtyNotifier()** *[*In case of a consecutive call of ara::diag::Conversation::SetAtivityNotifier of the corresponding ara::diag::Conversation instance, DM module shall overwrite the previous registered notifier.*♩(RS_Diag_04169)*

> **[SWS_DM_01355]**{草案}**使用SetActivtyNotifier()连续注册通知者** *[*如果对应的ara::diag::Conversation实例连续调用ara::diag::Conversation::SetAtivityNotifier，DM模块将覆盖先前注册的通知者。*♩(RS_Diag_04169)*


**[SWS_DM_01356]**{DRAFT} **Consecutive registration of notifier with SetDiagnoticSessionNotifier()** *[*In case of a consecutive call of ara::diag::Converstion::SetDiagnosticSessionNotifier of the corresponding ara::diag:Conversation instance, DM module shall overwrite the previous registered notifier.*♩ (RS_Diag_04169, RS_Diag_04208)*

> **[SWS_DM_01356]**{草案}**使用SetDiagnoticSessionNotifier()连续注册通知者** *[*如果对应ara::diag:Conversation实例的ara::diag::Converstion::SetDiagnosticSessionNotifier连续调用，DM模块应覆盖先前注册的通知者。*♩ (RS_Diag_04169, RS_Diag_04208)*


**[SWS_DM_01357]**{DRAFT} **Consecutive registration of notifier with SetSecrityLevelNotifier()** *[*In case of a consecutive call of ara::diag::Conversation:SetSecurityLevelNotifier of the corresponding ara::diag::Conversation instance, DM module shall overwrite the previous registered notifier.*♩(RS_Diag_04169, RS_Diag_04208)*

> **[SWS_DM_01357]**{草案}**使用SetSecrityLevelNotifier()连续注册通知者** *[*如果对应的ara::diag::Conversation实例连续调用ara::diag::Conversation:SetSecurityLevelNotifier，DM模块应覆盖先前注册的通知者。*♩(RS_Diag_04169, RS_Diag_04208)*

### Assignment of UDS requests to Diagnostic Conversations


A UDS request is always processed within the context of a Diagnostic Converstion. On reception, the Diagnostic Server instance has to choose from the following three options:

> UDS请求总是在诊断会话的上下文中处理。接收后，诊断服务器实例必须从以下三个选项中进行选择：

- assign the UDS request to an existing Diagnostic Conversation,

- establish a new Diagnostic Conversation and assign the UDS request to this Diagnostic Conversation,

> 建立一个新的诊断对话并将UDS请求分配给此诊断对话。
- reject the UDS request.


The evaluation which option to choose involves several steps that are summarized in Figure [7.3](#_bookmark65). The following requirements provide the details.

> 评估选择哪个选项涉及几个步骤，如图7.3所示。以下要求提供了详细信息。

![](./media/image18.png)![](./media/image29.png)![](./media/image31.png)***[SWS_DM_00426]{.underline}:***


*Assigning a UDS request toan existing Diagnostic Conversation*

> 分配UDS请求到现有的诊断对话

![](./media/image32.png)Is the existing Diagnostic Conversation busy?


Process received UDS request in context of assigned DiagnosticConversation

> 处理在指定的诊断会话上下文中接收到的UDS请求

**Figure 7.3:** []{#_bookmark65 .anchor}**UDS request assignment to a Diagnostic Conversation and Prioritization**


**[SWS_DM_00425]**{DRAFT} **Procedure to assign UDS requests to Diagnostic Coversations** *[*The Diagnostic Server instance shall handle a newly received UDS request as specified in Figure [7.3](#_bookmark65).*♩(RS_Diag_04166)*

> **[SWS_DM_00425]**{草案} **分配UDS请求到诊断会话的程序** *[*诊断服务器实例应按照图[7.3]（#_bookmark65）中的规定处理新收到的UDS请求。*♩(RS_Diag_04166)*


**[SWS_DM_00426]**{DRAFT} **Assigning a UDS request to an existing Diagnostic Conversation** *[*If a UDS request is received and there already exists a Diagnostic Conversation associated to the transmitting Diagnostic Client, then the Diagnostic Server instance shall assign this UDS request to the same Diagnostic Coversation.*♩(RS_Diag_04166)*

> 如果收到UDS请求，并且与传输诊断客户端相关联的诊断对话已经存在，那么诊断服务器实例应将此UDS请求分配给相同的诊断对话。♩（RS_Diag_04166）


Note that the assignment of a UDS request to a Diagnostic Conversation does not necessarily mean that the UDS request is actually processed, see [[SWS_DM_00433](#_bookmark70)].

> 注意，将UDS请求分配给诊断会话并不一定意味着UDS请求实际上被处理，请参见[[SWS_DM_00433](#_bookmark70)]。

### Prioritization


If the Diagnostic Server instance lacks resources for new Diagnostic Convesations, a prioritization of the requested Diagnostic Conversation against existing Dagnostic Conversations shall take place. For a Diagnostic Server instance , prioritization is required in case of an existing Diagnostic Conversation in non-default session.

> 如果诊断服务器实例缺乏资源以进行新的诊断会话，则需要对请求的诊断会话与现有诊断会话进行优先级排序。对于诊断服务器实例，如果存在非默认会话中的现有诊断会话，则需要优先级排序。


**[SWS_DM_00427]**{DRAFT} **Priority of a Diagnostic Conversation** *[*The Diagnotic Server instance shall take as the priority of a Diagnostic Conversation the respective value provided by ara::diag::uds_transport::UdsTransporProtocolMgr::IndicateMessage that established the Diagnostic Converstion.*♩(RS_Diag_04166)*

> **[SWS_DM_00427]**{草案} **诊断对话的优先级** *[*诊断服务器实例应将诊断对话的优先级设置为ara::diag::uds_transport::UdsTransporProtocolMgr::IndicateMessage提供的相应值，以建立诊断会话。*♩（RS_Diag_04166）*


**[SWS_DM_00428]**{DRAFT} **Treatment of priority values** *[*The Diagnostic Server instance shall consider a lower value as higher priority and vice versa. In particular, priority value 0 represents highest priority.*♩(RS_Diag_04166)*

> **[SWS_DM_00428]**{草案} **优先级值的处理** *[*诊断服务器实例应将较低的值视为较高的优先级，反之亦然。特别是，优先级值0表示最高优先级。*♩(RS_Diag_04166)*


**[SWS_DM_00429]**{DRAFT} **Prioritization in active non-default session** *[*If a Dianostic Conversation is in non-default session, the Diagnostic Server shall copare the priority of the requested Diagnostic Conversation against the priority of the given Diagnostic Conversation in non-default session. If the priority of the rquested Diagnostic Conversation is higher than the priority of the Diagnostic Conversation in non-default Session, the Diagnostic Server instance shall replace the Diagnostic Conversation in nodefault session by the requested Diagnostic Conversation according to [[SWS_DM_00431](#_bookmark68)] and assign the UDS request to the newly established Diagnostic Conversation.*♩(RS_Diag_04166)*

> **[SWS_DM_00429]**{草稿} **活动非默认会话中的优先级** *[*如果诊断会话在非默认会话中，诊断服务器应比较请求的诊断会话的优先级与给定的诊断会话的优先级。如果请求的诊断会话的优先级高于非默认会话中的诊断会话的优先级，诊断服务器实例应根据[[SWS_DM_00431](#_bookmark68)]替换非默认会话中的诊断会话，并将UDS请求分配给新建立的诊断会话。*♩(RS_Diag_04166)*


**[SWS_DM_00430]**{DRAFT} **Prioritization against all Diagnostic Conversations in active default session** *[*On prioritization, the Diagnostic Server instance shall compare the priority of the requested Diagnostic Conversation against the prorities of the existing Diagnostic Conversations:

> **[SWS_DM_00430]**{草案} **在活动默认会话中对所有诊断对话进行优先级排序** *[*关于优先级，诊断服务器实例应比较请求的诊断对话的优先级与现有诊断对话的优先级：


- If all priorities of the existing Diagnostic Conversations are higher or equal to the priority of the requested Diagnostic Conversation, the Dagnostic Server instance shall refuse the UDS request according to [[SWS_DM_00049](#_bookmark71)] and [[SWS_DM_00290](#_bookmark72)].

> 如果现有的诊断会话的优先级高于或等于所请求的诊断会话的优先级，根据[[SWS_DM_00049]（＃_bookmark71）]和[[SWS_DM_00290]（＃_bookmark72）]，诊断服务器实例应拒绝UDS请求。

- If some priority of the existing Diagnostic Conversations is lower than the priority of the requested Diagnostic Conversation, the Diagnotic Server instance shall replace the Diagnostic Conversation of lowest priority by the requested Diagnostic Conversation according to [[SWS_DM_00431](#_bookmark68)] and assign the UDS request to the newly established Dagnostic Conversation.

> 如果现有诊断对话的优先级低于所请求的诊断对话的优先级，根据[[SWS_DM_00431]]，诊断服务器实例应替换最低优先级的诊断对话，并将UDS请求分配给新建立的诊断对话。

*♩(RS_Diag_04166)*

### Replacement of Diagnostic Conversations and initial values


[]{#_bookmark68 .anchor}**[SWS_DM_00431]**{DRAFT} **Replacement of Diagnostic Conversations** *[*On rplacement of a given Diagnostic Conversation by a requested Diagnotic Conversation, the Diagnostic Server instance shall cancel the given Diagnostic Conversation according to [[SWS_DM_00277](#_bookmark185)], [[SWS_DM_00278](#_bookmark186)], [[SWS_DM_00279](#_bookmark187)], [[SWS_DM_00280](#_bookmark188)], [[SWS_DM_00847](#_bookmark189)] and establish a new Dagnostic Conversation as requested.*♩(RS_Diag_04167)*

> 在更换给定的诊断对话为所请求的诊断对话时，诊断服务器实例应根据[[SWS_DM_00277](#_bookmark185)], [[SWS_DM_00278](#_bookmark186)], [[SWS_DM_00279](#_bookmark187)], [[SWS_DM_00280](#_bookmark188)], [[SWS_DM_00847](#_bookmark189)]取消该给定的诊断对话，并建立一个新的诊断对话，如所请求的*♩（RS_Diag_04167）*。


**[SWS_DM_00856]**{DRAFT} **Initial values for Diagnostic Conversation** *[*For a newly established Diagnostic Conversation, the Diagnostic Server instance shall use the following initial values:

> **[SWS_DM_00856]**{草案} **诊断对话的初始值** *[*对于新建立的诊断对话，诊断服务器实例应使用以下初始值：


- Session set to Default Session (kDefaultSession), which is synonymous with returning an according ara::diag::SessionControlType when ara::diag::Conversation::GetDiagnosticSession is called and

> 会话设置为默认会话(kDefaultSession)，这与调用ara::diag::Conversation::GetDiagnosticSession时返回ara::diag::SessionControlType相同。

- Security Level set to status Locked (kLocked), which is synonymous with rturning an according ara::diag::SecurityLevelType when ara::diag::Conversation::GetDiagnosticSecurityLevel is called .

> 安全级别设置为锁定状态（kLocked），这与调用ara :: diag :: Conversation :: GetDiagnosticSecurityLevel时返回ara :: diag :: SecurityLevelType相同。

*♩(RS_Diag_04166)*

### Refusal of incoming diagnostic request


[]{#_bookmark70 .anchor}**[SWS_DM_00433]**{DRAFT} **Refusal of diagnostic request due to busy Diagnotic Conversation** *[*If a UDS request is assigned to a Diagnostic Conversation that has not finished processing of a formerly assigned UDS request, then the Diagnostic Server instance shall ignore the new UDS request according to [[SWS_DM_00386](#_bookmark37)].*♩(RS_Diag_04020)*

> 如果UDS请求被分配给尚未处理先前分配的UDS请求的诊断会话，那么诊断服务器实例应根据[[SWS_DM_00386]](#_bookmark37)忽略新的UDS请求，**[SWS_DM_00433]**{草案} **拒绝诊断请求由于繁忙的诊断会话** ♩(RS_Diag_04020)。


[]{#_bookmark71 .anchor}**[SWS_DM_00049]**{DRAFT} **Refusal of diagnostic request due to prioritization with BusyRepeatRequest** *[*If prioritization demands refusal of an incoming UDS request and the configuration parameter DiagnosticCommonProps.responseOSecondDeclinedRequest is TRUE, the Diagnostic Server instance shall accept this request according to [[SWS_DM_00385](#_bookmark36)] without further processing and a negative response with NRC 0x21 (BusyRepeatRequest) shall be issued for this rquest.*♩(RS_Diag_04167)*

> 如果优先级要求拒绝传入的UDS请求，并且配置参数DiagnosticCommonProps.responseOSecondDeclinedRequest为TRUE，根据[[SWS_DM_00385](#_bookmark36)]，诊断服务器实例应该接受此请求而不进行进一步处理，并且为此请求发出负响应，NRC为0x21（BusyRepeatRequest）。♩（RS_Diag_04167）


[]{#_bookmark72 .anchor}**[SWS_DM_00290]**{DRAFT} **Refusal of diagnostic request due to prioritization without response** *[*If prioritization demands refusal of an incoming UDS request and the configuration parameter DiagnosticCommonProps.responseOnSeconDeclinedRequest is FALSE, the Diagnostic Server instance shall ignore this request according to [[SWS_DM_00386](#_bookmark37)] without further processing and no rsponse shall be issued.*♩(RS_Diag_04167)*

> 如果优先性要求拒绝传入的UDS请求，并且配置参数DiagnosticCommonProps.responseOnSeconDeclinedRequest为FALSE，根据[SWS_DM_00386]，诊断服务器实例应忽略此请求，不进行进一步处理，也不会发出响应（RS_Diag_04167）。

### Handling Authentication State and DynamicAccessLists


This chapter describes the interfaces available to the application for handling of the Authentication States of the Diagnostic Clients and their corresponding DynamicAcessLists. The parts specified in this chapter are independent of the parts specified for the UDS Service Authentication (0x29), and may be used also with custom methods for authentication of clients.

> 本章节描述了应用程序用于处理诊断客户端的认证状态及其相应的DynamicAcessLists的可用接口。本章节指定的部分独立于为UDS服务认证（0x29）指定的部分，也可以用于客户端自定义认证方法。

### ExternalAuthentication


In AUTOSAR Adaptive, a major part of the client authentication process is handled in the Application. It is therefore necessary for the application to convey the Authentiction state to the Diagnostic Server instance of the DM. Since the Diagnostic Server instance must handle the Authentication States and Roles independently for each Diagnostic Client, the Application must first receive a ClientAuthentiction instance from the DM. This can be done using the class ara::diag::ExtenalAuthentication.

> 在AUTOSAR Adaptive中，客户端认证过程的主要部分由应用程序处理。因此，应用程序必须将认证状态传递给DM的诊断服务器实例。由于诊断服务器实例必须为每个诊断客户端单独处理认证状态和角色，因此应用程序必须先从DM接收ClientAuthentiction实例。这可以使用类ara：：diag：ExtenalAuthentication来完成。


**[SWS_DM_01202]**{DRAFT} **Get ClientAuthentication Instance** *[*If the application calls any of the overloaded methods ara::diag::ExternalAuthentication::Get of the class ara::diag::ExternalAuthentication, the Diagnostic Maager shall return an instance of the ara::diag::ClientAuthentication class that is handling the Authentication State of the passed metaInfo or Diagnostic Client Address.*♩(RS_Diag_04240)*

> 如果应用程序调用ara::diag::ExternalAuthentication类的任何重载方法ara::diag::ExternalAuthentication::Get，诊断管理器应该返回一个处理传入的metaInfo或诊断客户端地址的身份验证状态的ara::diag::ClientAuthentication类的实例。


**[SWS_DM_01203]**{DRAFT} **GetAll ClientAuthentication Instance** *[*If the application calls the method ara::diag::ExternalAuthentication::GetAll of the class ara::diag::ExternalAuthentication, the Diagnostic Server instance shall return all the existing instances of the ara::diag::ClientAuthentication class.*♩(RS_Diag_04240)*

> 如果应用程序调用ara::diag::ExternalAuthentication类的ara::diag::ExternalAuthentication::GetAll方法，诊断服务器实例应返回ara::diag::ClientAuthentication类的所有现有实例。♩(RS_Diag_04240)

### ClientAuthentication


Once the Application has received an instance of the ara::diag::ClientAuthetication class, it may pass the Authentication State and Authentication Roles to the Diagnostic Manager using this instance. The Diagnostic Server instance maintains the Authentication State and Authentication Role for each Diagnostic Conversation.

> 一旦应用程序收到ara::diag::ClientAuthetication类的实例，它可以使用此实例将身份验证状态和身份验证角色传递给诊断管理器。诊断服务器实例为每个诊断会话维护身份验证状态和身份验证角色。


[]{#_bookmark76 .anchor}**[SWS_DM_01204]**{DRAFT} **Default Authentication Role** *[*The DiagnosticAutRole(s) with attribute "isDefault" set to TRUE shall be considered by the Diagnostic Server instance as the Default Authentication Role(s) of clients in the Authentiction State kDeAuthenticated.*♩(RS_Diag_04240)*

> SWS_DM_01204]{DRAFT} **默认身份验证角色** *[*具有“isDefault”属性设置为TRUE的DiagnosticAutRole(s)被诊断服务器实例视为认证状态kDeAuthenticated的客户端的默认身份验证角色(s)。*♩(RS_Diag_04240)*


**[SWS_DM_01205]**{DRAFT} **Default Authentication State** *[*On startup, the default Authentication state for a client shall be 'kDeAuthenticated'.*♩(RS_Diag_04240)*

> **[SWS_DM_01205]**{草案} **默认认证状态** *[*启动时，客户端的默认认证状态应为“kDeAuthenticated”。*♩(RS_Diag_04240)*


[]{#_bookmark77 .anchor}**[SWS_DM_01206]**{DRAFT} **Set AuthenticationRole** *[*If the application calls the ara::diag::ClientAuthentication::Authenticate method of the class ara::diag::ClientAuthentication, the Diagnostic Server instance shall set the Authentication State of the ara::diag::ClientAuthentication istance to kAuthenticated and the Authentication Role of the ara::diag::ClietAuthentication instance to the user role(s) that are passed in the method call. The Diagnostic Server Instance shall return an instance of the ara::diag::ClietAuthenticationHandle to the application.*♩(RS_Diag_04240)*

> 如果应用程序调用ara::diag::ClientAuthentication类的ara::diag::ClientAuthentication::Authenticate方法，则诊断服务器实例应将ara::diag::ClientAuthentication实例的认证状态设置为kAuthenticated，并将ara::diag::ClietAuthentication实例的认证角色设置为传递给该方法调用的用户角色。诊断服务器实例应将ara::diag::ClietAuthenticationHandle的实例返回给应用程序。（RS_Diag_04240）


**[SWS_DM_01207]**{DRAFT} **Get Authentication State** *[*If the application calls the ara::diag::ClientAuthentication::GetState method of the class ara:diag::ClientAuthentication, the Diagnostic Server instance shall rturn the current Authentication State of the Client.*♩(RS_Diag_04240)*

> 如果应用程序调用ara::diag::ClientAuthentication类的ara::diag::ClientAuthentication::GetState方法，诊断服务器实例应当返回客户端的当前认证状态。


**[SWS_DM_01208]**{DRAFT} **Authentication State Change Notifier** *[*If the appliction calls the method ara::diag::ClientAuthentication::SetNotifier of the class ara::diag::ClientAuthentication, the Diagnostic Server istance shall call the passed notifier-function whenever there is a change in the Athentication State of the client.*♩(RS_Diag_04240)*

> 如果应用程序调用ara::diag::ClientAuthentication类的ara::diag::ClientAuthentication::SetNotifier方法，则每当客户端的认证状态发生变化时，诊断服务器实例都将调用传递的通知程序功能。


[]{#_bookmark78 .anchor}**[SWS_DM_01209]**{DRAFT} **Temporarily change Default Roles** *[*If the client is in kDeAuthenticated state and the application calls the method ara::diag:ClientAuthentication::OverrideDefaultRoles of the class ara::diag::ClientAuthentication, the Diagnostic Server instance shall change the default roles of the client to the passed 'defaultRoles' for a time period passed in the prameter 'timeout'. On successful execution of this method, the Diagnostic Server instance shall return an instance of the ara::diag::ClientAuthenticatioHandle to the application.*♩(RS_Diag_04239)*

> 如果客户端处于kDeAuthenticated状态，并且应用程序调用ara :: diag：ClientAuthentication :: OverrideDefaultRoles类的方法，诊断服务器实例将将客户端的默认角色更改为传递的“defaultRoles”，有效期为参数“timeout”中传递的时间段。在成功执行此方法后，诊断服务器实例将向应用程序返回ara :: diag :: ClientAuthenticatioHandle的实例。 ♩（RS_Diag_04239）


[]{#_bookmark79 .anchor}**[SWS_DM_01210]**{DRAFT} **DeAuthenticate due to client inactivity** *[*In Default Sesion, if a client is in kAuthenticated state, and no diagnostic request is received from the client for a time period DiagnosticAuthentication.authenticatioTimeout, the Diagnostic Server instance shall set the Authentication State of the client to kDeAuthenticated.*♩(RS_Diag_04240)*

> 在默认会话中，如果客户端处于kAuthenticated状态，并且在DiagnosticAuthentication.authenticatioTimeout的时间段内没有收到来自客户端的诊断请求，诊断服务器实例将把客户端的认证状态设置为kDeAuthenticated。


**[SWS_DM_01211]**{DRAFT} **Transition to DeAuthenticated state on S3server timout** *[*On an S3 Server timeout, the Diagnostic Server instance shall reset the Authentication State of all clients to kDeAuthenticated.*♩(RS_Diag_04240)*

> 在S3服务器超时时，诊断服务器实例应将所有客户端的认证状态重置为kDeAuthenticated。


[]{#_bookmark80 .anchor}**[SWS_DM_01212]**{DRAFT} **Transition from Authenticated to DeAuthenticated State** *[*If the Authentication State of a Client changes from kAuthenticated to kDeAuthenticated, the Diagnostic Server instance shall

> 如果客户端的认证状态从kAuthenticated更改为kDeAuthenticated，诊断服务器实例应该从认证状态到未认证状态进行转换。


- set the Authentication Role of the Client to the default roles as defined in [[SWS_DM_01204](#_bookmark76)]

> 将客户端的身份验证角色设置为在[[SWS_DM_01204](#_bookmark76)]中定义的默认角色。
- clear all DynamicAccessList entries associated with the Client

*♩(RS_Diag_04240)*


**[SWS_DM_01360]**{DRAFT} **Consecutive registration of notifier with ClientAuthetication::SetNotifier()** *[*In case of a consecutive call of ara::diag::ClientAthentication::SetNotifier of the corresponding ara::diag::ClientAthentication instance, DM module shall overwrite the previous registered notifier.*♩ (RS_Diag_04251)*

> **[SWS_DM_01360]**{草案} **使用ClientAuthentication::SetNotifier()连续注册通知者** *[*如果对应的ara::diag::ClientAuthentication实例连续调用ara::diag::ClientAuthentication::SetNotifier，DM模块应覆盖先前注册的通知者。*♩ (RS_Diag_04251)*

### ClientAuthenticationHandle


A ara::diag::ClientAuthenticationHandle instance is provided to the aplication by the Diagnostic Server instance, when either an ara::diag::ClientAuthentication::OverrideDefaultRoles method or an ara:diag::ClientAuthentication::Authenticate method is successfully copleted.

> 一个ara::diag::ClientAuthenticationHandle实例由诊断服务器实例提供给应用程序，当ara::diag::ClientAuthentication::OverrideDefaultRoles方法或ara:diag::ClientAuthentication::Authenticate方法成功完成时。


The Diagnostic Manager maintains a "DynamicAccessList" for every client that is athenticated. The DynamicAccessList may provide additional access of Diagnostic Rsources to an authenticated client apart from the configurations described in the Dagnostic Extract. The DynamicAccessList and the Authentication Status may be cotrolled by the application using the ara::diag::ClientAuthenticationHandle.

> 诊断管理器为每个认证的客户端维护一个“DynamicAccessList”。除了诊断提取中描述的配置之外，DynamicAccessList可以为认证客户端提供额外的诊断资源访问权限。DynamicAccessList和认证状态可以通过使用ara :: diag :: ClientAuthenticationHandle的应用程序来控制。


[]{#_bookmark82 .anchor}**[SWS_DM_01213]**{DRAFT} **Set DynamicAccessList** *[*If the application calls the

> **[SWS_DM_01213]**{草案} **设置动态访问列表** *[*如果应用程序调用


ara::diag::ClientAuthenticationHandle::Set method of the class ara::diag::ClientAuthenticationHandle, the Diagnostic Server instance shall replace the DynamicAccessList of the authenticated client with the DynamicAcessList passed by the application.*♩(RS_Diag_04240)*

> ara::diag::ClientAuthenticationHandle::Set 方法，诊断服务器实例应用程序传入的DynamicAcessList替换已认证客户端的DynamicAccessList。（RS_Diag_04240）


**[SWS_DM_01214]**{DRAFT} **Default DynamicAccessList** *[*On startup, the DynamcAccessList of all clients shall be empty.*♩(RS_Diag_04240)*

> **[SWS_DM_01214]**{草案} **默认动态访问列表** *[*在启动时，所有客户端的DynamcAccessList应为空。*♩(RS_Diag_04240)*


**[SWS_DM_01215]**{DRAFT} **Extend the DynamicAccessList** *[*If the application calls the ara::diag::ClientAuthenticationHandle::Append method of the class ara::diag::ClientAuthenticationHandle, the Diagnostic Server instance shall extend the DynamicAccessList of the authenticated client with the DynamicAccessList passed by the application.*♩(RS_Diag_04240)*

> 如果应用程序调用类ara::diag::ClientAuthenticationHandle的ara::diag::ClientAuthenticationHandle::Append方法，诊断服务器实例将使用应用程序传递的DynamicAccessList扩展已认证客户端的DynamicAccessList。


**[SWS_DM_01216]**{DRAFT} **Revoke an authentication** *[*If the application calls the ara::diag::ClientAuthenticationHandle::Revoke method of the class ara::diag::ClientAuthenticationHandle, the Diagnostic Server istance shall set the Authentication State of the client to 'kDeAuthenticated'.*♩(RS\Diag_04240)*

> 如果应用程序调用类ara::diag::ClientAuthenticationHandle的ara::diag::ClientAuthenticationHandle::Revoke方法，则诊断服务实例应将客户端的认证状态设置为“kDeAuthenticated”。


**[SWS_DM_01217]**{DRAFT} **Refresh timeouts** *[*If an application calls the method ara::diag::ClientAuthenticationHandle::Refresh of the class ara:diag::ClientAuthenticationHandle, the Diagnostic Server instance shall perform one of the following:

> 如果应用程序调用ara::diag::ClientAuthenticationHandle类的ara::diag::ClientAuthenticationHandle::Refresh方法，诊断服务器实例应执行以下操作之一：


- If the ara::diag::ClientAuthenticationHandle was returned by the ara::diag::ClientAuthentication::OverrideDefaultRoles

> 如果ara::diag::ClientAuthenticationHandle由ara::diag::ClientAuthentication::OverrideDefaultRoles返回，


method, refresh the time period for which the OverrideDefaultRoles is valid. Refer [[SWS_DM_01209](#_bookmark78)].

> 重新设置OverrideDefaultRoles的有效时间段。参考[[SWS_DM_01209](#_bookmark78)]。


- If the ara::diag::ClientAuthenticationHandle was returned by the ara::diag::ClientAuthentication::Authenticate method, refresh the client inactivity time period. Refer [[SWS_DM_01210](#_bookmark79)].

> 如果ara::diag::ClientAuthenticationHandle由ara::diag::ClientAuthentication::Authenticate方法返回，请刷新客户端不活动时间段。参见[[SWS_DM_01210](#_bookmark79)]。

*♩(RS_Diag_04240)*

### DynamicAccessList Creation and Update


The Diagnostic Manager provides an interface to allow the application to build a DnamicAccessList. The DynamicAccessList is a series of diagnostic request patterns that provide additional access of diagnostic resources to an authenticated client. The DynamicAccessList may be created by the application using the C++ methods dscribed in this chapter.

> 管理器提供一个界面，允许应用程序构建动态访问列表。动态访问列表是一系列诊断请求模式，为认证客户端提供额外的诊断资源访问。应用程序可以使用本章节中描述的C++方法创建动态访问列表。


**[SWS_DM_01218]**{DRAFT} **Building a new DynamicAccessList** *[*If any of the oveloads of the method ara::diag::DiagnosticServiceDynamicAccessList::MakeServiceBuilder of the class ara::diag::DiagnosticServiceDynaicAccessList is called by the application, the Diagnostic Server instance shall create a new DynamicAccessList beginning with the single-byte or byte-string patern passed by the application. The Diagnostic Server instance shall return an instance of the class ara::diag::DynamicAccessListDiagServiceBuilder to the application.*♩(RS_Diag_04240)*

> 如果应用程序调用ara::diag::DiagnosticServiceDynamicAccessList::MakeServiceBuilder方法的任何超载，诊断服务器实例将创建一个新的DynamicAccessList，从应用程序传递的单字节或字节字符串模式开始。诊断服务器实例将返回ara::diag::DynamicAccessListDiagServiceBuilder类的实例给应用程序。


**[SWS_DM_01219]**{DRAFT} **Adding patterns to a DynamicAccessList** *[*If any of the overloads of the method ara::diag::DynamicAccessListDiagServicBuilder::Add of the class ara::diag::DynamicAccessListDiagServicBuilder are called by the application, the Diagnostic Server instance shall add the requested pattern to the DynamicAccessList of the client and return an istance of the same ara::diag::DynamicAccessListDiagServiceBuilder oject to the application.*♩(RS_Diag_04240)*

> 如果应用程序调用ara::diag::DynamicAccessListDiagServicBuilder类的Add方法的任何重载，诊断服务器实例将向客户端的DynamicAccessList添加所请求的模式，并将相同的ara::diag::DynamicAccessListDiagServiceBuilder对象实例返回给应用程序。(RS_Diag_04240)


The returned instance of the same object may be used by the application to further add patterns to the DynamicAccessList.

> 实例的返回可以被应用程序用来向动态访问列表中添加更多的模式。


**[SWS_DM_01220]**{DRAFT} **Adding wildcards to a DynamicAccessList** *[*If the method ara::diag::DynamicAccessListDiagServiceBuilder::Any of the class ara::diag::DynamicAccessListDiagServiceBuilder is called by the application, the Diagnostic Server instance shall add the passed number of bytes to the DynamicAccessList, but shall not consider them during pattern matching.*♩ (RS_Diag_04240)*

> 如果应用程序调用ara::diag::DynamicAccessListDiagServiceBuilder类的ara::diag::DynamicAccessListDiagServiceBuilder::Any方法，诊断服务器实例将向动态访问列表添加传递的字节数，但在模式匹配时不考虑它们。 (RS_Diag_04240)


For Example, 22F1XX could be used in the pattern to add all ReadDataByIdentifier Requests for DIDs beginning with 0xF1 to the DynamicAccessList.

> 例如，22F1XX 可以用来模式添加以 0xF1 开头的 DID 的所有 ReadDataByIdentifier 请求到 DynamicAccessList 中。


**[SWS_DM_01221]**{DRAFT} **End patterns of a DynamicAccessList** *[*If any of the overloads of the method ara::diag::DynamicAccessListDiagServicBuilder::EndsWith of the class ara::diag::DynamicAccessListDiagSeviceBuilder are called by the application, the Diagnostic Server instance shall add the requested pattern to the end of the DynamicAccessList.*♩(RS_Diag\04240)*

> 如果应用程序调用ara::diag::DynamicAccessListDiagServicBuilder::EndsWith方法的任何重载，诊断服务器实例应将请求的模式添加到动态访问列表的末尾。


**[SWS_DM_01222]**{DRAFT} **Finalize a DynamicAccessList** *[*If the method ara:diag::DynamicAccessListDiagServiceBuilder::Build of the class ara::diag::DynamicAccessListDiagServiceBuilder is called by the application, the Diagnostic Server instance shall finalize the DynamicAccessList.*♩(RS\Diag_04240)*

> 如果应用程序调用类ara::diag::DynamicAccessListDiagServiceBuilder的ara:diag::DynamicAccessListDiagServiceBuilder::Build方法，诊断服务器实例应该完成动态访问列表。


After successful execution of this method, the application may use the created DynaicAccessList as described in [[SWS_DM_01213](#_bookmark82)].

> 在执行本方法成功后，应用程序可以按照[[SWS_DM_01213](#_bookmark82)]中所述使用已创建的DynaicAccessList。

### Diagnostic Service Authentication checks


The UDS service Authentication (0x29) is used by the ECU as a means to identify the client and provide the relevant access to diagnostic resources, based on the client's 'role'. Depending on the authenticated role and the access-list, a dynamic set of dagnostic services is available to the client. The Diagnostic Server instance verifies if a received diagnostic service is accessible to the client or not.

> 服务认证（0x29）是ECU用来根据客户端的“角色”来识别客户端并提供相关访问诊断资源的手段。根据认证角色和访问列表，客户端可以访问动态设置的诊断服务。诊断服务器实例验证接收到的诊断服务是否可供客户端使用。


[]{#_bookmark85 .anchor}**[SWS_DM_01223]**{DRAFT} **Diagnostic service role verification** *[*The Diagnostic Server instance shall check if a diagnostic service execution is permitted in the current Authentication State and Authentication Role (Refer [[SWS_DM_01206](#_bookmark77)]). The roles that are allowed to execute the diagnostic services are configured with the prameter DiagnosticAccessPermission.DiagnosticAuthRole. The Diagnotic Server instance shall perform the following checks in the order given below. If a check grants access to a service, the remaining checks are skipped and the service is processed by the Diagnostic Server instance.

> 诊断服务角色验证（草案）
诊断服务器实例应检查当前身份验证状态和身份验证角色（参见SWS_DM_01206）是否允许执行诊断服务。允许执行诊断服务的角色由参数DiagnosticAccessPermission.DiagnosticAuthRole配置。诊断服务器实例应按下列顺序执行以下检查。如果一个检查授予服务访问权限，则跳过其余检查，并由诊断服务器实例处理该服务。

- Checks on service ID level
- Checks on service ID and sub-function level
- Checks for services with one or multiple DIDs
- Check on dynamically defined DIDs
- Checks on service 0x31 per sub-function
- Checks on service 0x19 parameter MemorySelection

*♩(RS_Diag_04233)*


[]{#_bookmark86 .anchor}**[SWS_DM_01224]**{DRAFT} **Diagnostic service dynamic access-rights verification** *[*If the check in [[SWS_DM_01223](#_bookmark85)] is unsuccessful, the Diagnostic Server istance shall additionally check if the requested Diagnostic Service is allowed by the client DynamicAccessList (Refer [[SWS_DM_01213](#_bookmark82)]).*♩(RS_Diag_04233)*

> 如果[[SWS_DM_01223](#_bookmark85)]中的检查不成功，诊断服务器实例还应检查客户端DynamicAccessList是否允许请求的诊断服务（参见[[SWS_DM_01213](#_bookmark82)]）。♩（RS_Diag_04233）


**[SWS_DM_01225]**{DRAFT} **Response behavior of services without access rights** *[*If the service execution verification fails due to a failed check in scope of [[SWS_DM_01223](#_bookmark85)] and [[SWS_DM_01224](#_bookmark86)], the Diagnostic Server instance shall send a negative Response with NRC '0x34 (authenticationRequired)' and stop the service processing.*♩(RS_Diag_04233)*

> **[SWS_DM_01225]**{草案} **没有访问权限的服务的响应行为** *[*如果由于[[SWS_DM_01223](#_bookmark85)]和[[SWS_DM_01224](#_bookmark86)]中的检查失败而导致服务执行验证失败，则诊断服务器实例应发送具有NRC“0x34（authenticationRequired）”的负响应，并停止服务处理。*♩（RS_Diag_04233）*


**[SWS_DM_01376]**{DRAFT} **Response behavior of SOVD services without access rights** *[*If the request is an SOVD request and the service execution verification fails due to a failed check in scope of [[SWS_DM_01223](#_bookmark85)], the Diagnostic Server istance shall send a HTTP response status code 401 (Unauthorized) and error_code set to insufficient-access-rights and stop the service processing.*♩(RS_Diag_04256)*

> 如果请求是SOVD请求，并且由于[[SWS_DM_01223](#_bookmark85)]的范围内的检查失败而导致服务执行验证失败，则诊断服务器实例应发送HTTP响应状态码401（未授权）和error_code设置为insufficient-access-rights，并停止服务处理。♩（RS_Diag_04256）

### UDS request Validation/Verification


[]{#_bookmark88 .anchor}**[SWS_DM_00096]**{DRAFT} **Validation Steps and Order** *[*The Diagnostic Server instance shall execute the request validation, negative response code determination and processing according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04196, RS_Diag_04203)*

> 鉴定服务器实例应根据ISO 14229-1[[1](#_bookmark8)]执行请求验证、负响应代码确定和处理的验证步骤和顺序。(RS_Diag_04196，RS_Diag_04203)


ISO 14229-1[[1](#_bookmark8)] describes a common processing for all requests in "Figure 5 General server response behavior". There are further optional SID specific processing squences. This document describes the Diagnostic Server instance behavior for certain types of checks:

> ISO 14229-1[[1](#_bookmark8)]描述了“图5常规服务器响应行为”中所有请求的通用处理。还有其他可选的SID特定处理序列。本文档描述了某些类型检查的诊断服务器实例行为：


- **manufacturer specific failure detected?** Decision by applying manufacturer specific checks according to section [7.6.2.5.4](#manufacturer-and-supplier-permission-checks-and-confirmation)

> 检测到制造商特定的失败？根据第7.6.2.5.4节的规定，通过应用制造商特定的检查来做出决定。
- **SID supported?** Decision according to section [7.6.2.5.2](#supported-service-checks)

- **SID supported in active session?** Decision according to section [7.6.2.5.3](#session-and-security-checks)

> -**活动会话中是否支持SID？**根据[7.6.2.5.3](#session-and-security-checks)节的决定。

- **SID security check o.k.?** Decision according to section [7.6.2.5.3](#session-and-security-checks)

> 安全检查SID确定？根据第7.6.2.5.3节的决定。

- **supplier-specific failure detected?** Decision by applying supplier-specific checks according to section [7.6.2.5.4](#manufacturer-and-supplier-permission-checks-and-confirmation)

> 检测到供应商特定的失败？根据第7.6.2.5.4节（制造商和供应商权限检查和确认）进行供应商特定的检查，并作出决定。


**[SWS_DM_00097]**{DRAFT} **Abort on failed verification step** *[*Whenever one of the verification steps fails, further processing of the request shall be aborted and a negative response shall be sent back.*♩(RS_Diag_04196)*

> **[SWS_DM_00097]**{草案}**在失败的验证步骤上终止** *[*每当其中一个验证步骤失败时，将终止请求的进一步处理，并发送负面响应。*♩(RS_Diag_04196)*


The negative response code to be used will be defined in each step described in the following sections.

> 在以下各节中描述的每一步中将定义要使用的负响应代码。

### UDS request format checks


**[SWS_DM_00098]**{DRAFT} **UDS message checks** *[*The Diagnostic Server istance shall check, whether the diagnostic request is syntactically correct. I.e. whether it conforms to ISO 14229-1 message format specification. If it does not coform, the Verification shall be considered as failed and the negative response code shall be 0x13 (incorrectMessageLengthOrInvalidFormat).*♩(RS_Diag_04203)*

> **[SWS_DM_00098]**{草案} **UDS消息检查** *[*诊断服务器实例应检查诊断请求是否语法正确。即它是否符合ISO 14229-1消息格式规范。如果不符合，验证将被视为失败，负响应代码应为0x13（incorrectMessageLengthOrInvalidFormat）。*♩（RS_Diag_04203）*

### Supported service checks


**[SWS_DM_00099]**{DRAFT} **Supported Service SID level checks** *[*The Diagnostic Server instance shall check, whether there is a configured internal or external service processor for the incoming diagnostic request. If there is no service processor on SID level, the Verification shall be considered as failed and the negative response code shall be 0x11 (serviceNotSupported).*♩(RS_Diag_04203)*

> **[SWS_DM_00099]**{草稿} **支持服务SID级别检查** *[*诊断服务器实例应检查是否为传入的诊断请求配置了内部或外部服务处理程序。如果SID级别上没有服务处理程序，则验证将被视为失败，并且负响应代码为0x11（serviceNotSupported）。*♩(RS_Diag_04203)*


[]{#_bookmark91 .anchor}**[SWS_DM_00100]**{DRAFT} **Supported Service subfunction level checks** *[*The Dagnostic Server instance shall check, whether there is a configured internal or external service processor for the incoming diagnostic request. If there exists a service processor on SID level, but not for the subfunction of the request, the Verfication shall be considered as failed and the negative response code shall be 0x12 (subFunctionNotSupported).*♩(RS_Diag_04203)*

> 诊断服务器实例应检查是否为传入的诊断请求配置了内部或外部服务处理器。如果存在SID级别的服务处理器，但不是请求的子功能，则认为验证失败，负响应代码为0x12（subFunctionNotSupported）。

### Session and Security Checks


[]{#_bookmark93 .anchor}**[SWS_DM_00101]**{DRAFT} **Session Access SID level Permission** *[*The Diagnotic Server instance shall check, whether the service processor (DiagnostiServiceInstance), which is assigned to handle the service has the permission to process the service in the current Diagnostic Session according to its DiagnosticAcessPermission.diagnosticSession. If DiagnosticServiceInstance has no access permissions in the current Diagnostic Session and:

> [SWS_DM_00101]{DRAFT}会话访问SID级别权限*[*诊断服务器实例应检查分配处理服务的服务处理器（DiagnostiServiceInstance）是否具有根据其DiagnosticAcessPermission.diagnosticSession在当前诊断会话中处理服务的权限。如果DiagnosticServiceInstance在当前诊断会话中没有访问权限，并且：

- either the SID of the service has no subfunction
- or all other sub-functions also have no access permissions in the current Dianostic Session,


the Verification shall be considered as failed and the negative response code shall be 0x7F (serviceNotSupportedInActiveSession).*♩(RS_Diag_04203, RS_Diag\04006)*

> 验证将被视为失败，并且负响应代码为0x7F（serviceNotSupportedInActiveSession）。（RS_Diag_04203，RS_Diag_04006）


**[SWS_DM_00102]**{DRAFT} **Session Access subfunction level Permission** *[*The Diagnostic Server instance shall check, whether the service processor (DagnosticServiceInstance), which is assigned to handle the service has the pemission to process the service in the current Diagnostic Session according to its

> **[SWS_DM_00102]**{草案} **会话访问子功能级别权限** *[*诊断服务器实例应检查，分配用于处理服务的服务处理器（DagnosticServiceInstance）是否根据其当前诊断会话有权处理该服务。


DiagnosticAccessPermission.diagnosticSession. If DiagnosticServceInstance has no access permissions in the current Diagnostic Session and:

> 如果DiagnosticServceInstance在当前诊断会话中没有访问权限，则DiagnosticAccessPermission.diagnosticSession。

- the SID of the service has subfunctions
- and at least one other sub-functions has access permissions in the current Dianostic Session,


the Verification shall be considered as failed and the negative response code shall be 0x7E (subFunctionNotSupportedInActiveSession).*♩(RS_Diag_04203, RS\Diag_04006)*

> 验证将被视为失败，负响应代码为0x7E（当前会话不支持的子功能）。（RS_Diag_04203，RS_Diag_04006）


[]{#_bookmark94 .anchor}**[SWS_DM_00103]**{DRAFT} **Security Access level Permission** *[*The Diagnostic Server instance shall check, whether the service processor (DiagnosticServceInstance), which is assigned to handle the service has the permission to process the service in the current Security-Level according to its DiagnosticAccessPemission.securityLevel. If DiagnosticServiceInstance has no access pemissions in the current Security-Level, the Verification shall be considered as failed and the negative response code shall be 0x33 (securityAccessDenied).*♩(RS\Diag_04203, RS_Diag_04005)*

> 诊断服务器实例应检查分配用于处理服务的服务处理器（DiagnosticServceInstance）是否根据其DiagnosticAccessPemission.securityLevel具有在当前安全级别中处理服务的权限。如果DiagnosticServiceInstance在当前安全级别中没有访问权限，则验证将被视为失败，负响应代码为0x33（securityAccessDenied）。


**[SWS_DM_00450]**{DRAFT} **Security Access subfunction level Permission** *[*The Diagnostic Server instance shall check, whether the service processor (DagnosticServiceInstance), which is assigned to handle the service has the pemission to process the service in the current Security Level according to its DiagnoticAccessPermission.securityLevel. If DiagnosticServiceInstance has no access permissions in the current Security Level and:

> **[SWS_DM_00450]**{草案} **安全访问子功能级权限** *[*诊断服务器实例应检查，分配用于处理服务的服务处理器（DagnosticServiceInstance）是否根据其DiagnoticAccessPermission.securityLevel有权处理当前安全级别的服务。如果DiagnosticServiceInstance在当前安全级别中没有访问权限，且:

- the SID of the service has subfunctions
- and at least one other sub-functions has access permissions in the current Scurity Level,


the Verification shall be considered as failed and the negative response code shall be 0x33 (securityAccessDenied).*♩(RS_Diag_04203)*

> 验证将被视为失败，并且负响应代码为0x33（securityAccessDenied）。♩（RS_Diag_04203）

### Manufacturer and Supplier Permission Checks and Confirmation


To allow manufacturer specific UDS service pre-processing or filtering, ISO 14229-1[[1](#_bookmark8)] defines manufacturer and supplier specific callouts. There are various use cases for these callouts, among them are:

> 为了允许制造商特定的UDS服务预处理或过滤，ISO 14229-1[[1](#_bookmark8)]定义了制造商和供应商特定的呼叫。这些呼叫的用例有很多，其中包括：

- UDS message filtering
- Adding project or customer specific diagnostic service processing


UDS and the DM allows multiple of these callouts and the result of each of the callout can be one of:

> UDS和DM允许多次这样的呼叫，每次呼叫的结果可以是：

- Continue to process the service by the DM
- Discarding the received diagnostic message without further response
- Forcing a certain NRC to be send


Both, manufacturer and suppliers specific service callouts, are realized by ara:diag::ServiceValidation::Validate according to its modeled instance given by [TPS_MANI_01352] and [constr_10063].

> 两者，制造商和供应商的特定服务呼叫，都由ara:diag :: ServiceValidation :: Validate根据其模型实例[TPS_MANI_01352]和[constr_10063]来实现。


**[SWS_DM_01252]**{DRAFT} **Support of manufacturer service validations** *[*The DM shall support manufacturer specific service validation checks according to ISO 14221[[1](#_bookmark8)] by calling ara::diag::ServiceValidation::Validate for each configured manufacturer service check.*♩(RS_Diag_04199)*

> **[SWS_DM_01252]**{草案} **支持制造商服务验证** *[*DM必须按照ISO 14221[[1](#_bookmark8)]的规定，为每个配置的制造商服务检查调用ara :: diag :: ServiceValidation :: Validate进行支持特定制造商服务验证检查。*♩(RS_Diag_04199)*


**[SWS_DM_01253]**{DRAFT} **Support of supplier service validations** *[*The DM shall support supplier specific service validation checks according to ISO 14229-1[[1](#_bookmark8)] by caling ara::diag::ServiceValidation::Validate for each configured supplier service check.*♩(RS_Diag_04199)*

> **[SWS_DM_01253]**{草案} **支持供应商服务验证** *[*根据ISO 14229-1[[1](#_bookmark8)]，DM应支持每个配置的供应商服务检查，通过调用ara :: diag :: ServiceValidation :: Validate进行验证。*♩(RS_Diag_04199)*


**[SWS_DM_01254]**{DRAFT} **Continue service processing after validation** *[*If a call to ara::diag::ServiceValidation::Validate returns without an error, the Diagnostic Server instance shall continue to process the service according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04199)*

> 如果调用ara::diag::ServiceValidation::Validate没有出现错误，诊断服务器实例应根据ISO 14229-1[[1](#_bookmark8)]继续处理服务。


**[SWS_DM_01255]**{DRAFT} **NRC after failed service validation** *[*If a call to ara:diag::ServiceValidation::Validate returns any error code except kNoPrcessingNoResponse, the validation is be considered as failed and a negative rsponse code equal to the value of the error code according to [SWS_DM_00547] shall be sent as response.*♩(RS_Diag_04199)*

> 如果调用ara：diag :: ServiceValidation :: Validate返回任何错误代码，除了kNoPrcessingNoResponse，则认为验证失败，并根据[SWS_DM_00547]将负响应代码等于错误代码的值发送作为响应。(RS_Diag_04199)


**[SWS_DM_00859]**{DRAFT} **Confirmation of service processing** *[*The Diagnostic Server instance shall call the method ara::diag::ServiceValidation:Confirmation on every service instances for which ara::diag::ServiceVaidation::Validate was called. If message handling results in sending a poitive or negative response, the ara::diag::ServiceValidation::Confirmtion call shall be deferred after reception of ara::diag::uds_transport::UsTransportProtocolMgr::TransmitConfirmation. In any other case, it shall be the last step of request processing.*♩(RS_Diag_04019, RS_Diag_04172)*

> **[SWS_DM_00859]**{草案} **服务处理确认** *[*诊断服务器实例应对每个调用了ara :: diag :: ServiceValidation：Validate的服务实例调用ara :: diag :: ServiceValidation：Confirmtion方法。 如果消息处理结果是发送正面或负面回应，则在接收到ara :: diag :: uds_transport :: UsTransportProtocolMgr :: TransmitConfirmation后延迟调用ara :: diag :: ServiceValidation :: Confirmtion。 在任何其他情况下，它都将是请求处理的最后一步。*♩（RS_Diag_04019，RS_Diag_04172）*


[]{#_bookmark96 .anchor}**[SWS_DM_00860]**{DRAFT} **No service processing** *[*If any ara::diag::ServicValidation::Validate returns kNoProcessingNoResponse, the Diagnostic Server instance shall discard the message of received diagnostic request.*♩(RS\Diag_04196, RS_Diag_04199)*

> 如果ara :: diag :: ServicValidation :: Validate返回kNoProcessingNoResponse，诊断服务器实例将丢弃接收的诊断请求消息（RS \ Diag_04196，RS_Diag_04199）。

### Condition checks


In some cases, diagnostic functionality shall only be executed if the vehicle is in a certain state. An example is the condition that the vehicle is stopped (vehicle speed equals 0).

> 在某些情况下，只有当车辆处于特定状态时，诊断功能才能执行。例如，车辆停止（车速等于0）的条件。


[]{#_bookmark98 .anchor}**[SWS_DM_00111]**{DRAFT} **Configurable environment condition checks** *[*The Dagnostic Server instance shall perform a condition check when the ISO 14221[[1](#_bookmark8)] mentions a service specific \"Condition check\" in the defined NRC handling for a given diagnostic service. The Diagnostic Server instance shall send the cofigured NRC value (see [[SWS_DM_00289](#_bookmark103)]) if the condition is not fulfilled.*♩(RS_Diag\04199)*

> 诊断服务器实例在ISO 14221[[1]（#_bookmark8）]提到特定服务的“条件检查”时，应执行条件检查。如果条件未满足，诊断服务器实例应发送配置的NRC值（参见[[SWS_DM_00289]（#_bookmark103）]）。


[]{#_bookmark99 .anchor}**[SWS_DM_00112]**{DRAFT} **Condition check definition** *[*The Diagnostic Server instance shall execute a condition check according to [[SWS_DM_00111](#_bookmark98)] by the preence of a DiagnosticEnvironmentalCondition referenced in the role enviromentalCondition by the processed DiagnosticServiceInstance.*♩(RS_Diag\04199)*

> 诊断服务器实例应根据[SWS_DM_00111]（参见书签98）执行条件检查，通过处理的DiagnosticServiceInstance中引用的DiagnosticEnvironmentalCondition的存在。♩（RS_Diag\04199）


[]{#_bookmark100 .anchor}**[SWS_DM_00286]**{DRAFT} **Configurable environmental condition check exection** *[*The Diagnostic Server instance shall execute an environmental condtion check before executing the requested service if defined. (see DiagnosticEnvronmentalCondition element from DEXT [[3](#_bookmark10)]).*♩(RS_Diag_04199)*

> 诊断服务器实例在执行请求的服务之前应该执行环境状况检查，如果定义了。（参见DEXT中的DiagnosticEnvironmentalCondition元素[3]）。


[]{#_bookmark101 .anchor}**[SWS_DM_00287]**{DRAFT} **Configurable environmental condition check criteria** *[*The environmental condition check shall be done by evaluation of the configured DiagnosticEnvConditionFormula.*♩(RS_Diag_04199)*

> 配置的环境条件检查准则将通过评估配置的DiagnosticEnvConditionFormula来完成。（RS_Diag_04199）


The DiagnosticEnvConditionFormula may reference a DiagnosticDataElment by a DiagnosticEnvDataCondition with a logical operator given as DianosticEnvCompareCondition.

> 诊断环境条件公式可以通过诊断环境数据条件以及作为诊断环境比较条件给出的逻辑运算符引用诊断数据元素。


**[SWS_DM_00288]**{DRAFT} **Configurable environmental condition check evalates to TRUE** *[*If the computation of the DiagnosticEnvConditionFormula evalated to TRUE, the Diagnostic Server instance shall execute the requested sevice.*♩(RS_Diag_04199)*

> **[SWS_DM_00288]**{草案} **可配置的环境条件检查评估为TRUE** *[*如果DiagnosticEnvConditionFormula的计算结果评估为TRUE，诊断服务器实例将执行请求的服务。*♩(RS_Diag_04199)*


[]{#_bookmark102 .anchor}**[SWS_DM_00970]**{DRAFT} **Behavior of failed data element retrieval** *[*If the retrieval of the dataElement failed due to an external processor has an error of ara:diag::DiagUdsNrcErrorDomain, the DM shall treat the DiagnosticEnvCondtionFormulaPart as condition not fulfilled and trigger a Log and Trace message.*♩ (RS_Diag_04199)*

> 如果由于外部处理器有ara:diag::DiagUdsNrcErrorDomain的错误而导致数据元素检索失败，DM应将DiagnosticEnvCondtionFormulaPart视为条件未满足，并触发日志和跟踪消息。 (RS_Diag_04199)


[]{#_bookmark103 .anchor}**[SWS_DM_00289]**{DRAFT} **Configurable environmental condition check evalates to FALSE** *[*The Diagnostic Server instance shall send the NRC defined in nrcValue, if the computation of the DiagnosticEnvConditionFormula evaluated to FALSE. If nrcValue does not define a NRC, the Diagnostic Server instance shall send NRC 0x22 (ConditionsNotCorrect).*♩(RS_Diag_04199)*

> 如果计算DiagnosticEnvConditionFormula的结果为FALSE，诊断服务器实例应发送NRC定义在nrcValue中的NRC。如果nrcValue未定义NRC，诊断服务器实例应发送NRC 0x22（ConditionsNotCorrect）。

### UDS response handling


**[SWS_DM_01258]**{DRAFT} **Response handling** *[*The Diagnostic Server istance shall process diagnostic responses according to ISO 14229-1[[1](#_bookmark8)]. This icludes sending of positive and negative responses, as well as suppression of negative or positive responses.*♩(RS_Diag_04196, RS_Diag_04020)*

> **[SWS_DM_01258]**{草案} **响应处理** *[*诊断服务器实例应按照ISO 14229-1[[1](#_bookmark8)]处理诊断响应。这包括发送正面和负面响应，以及抑制负面或正面响应。*♩(RS_Diag_04196, RS_Diag_04020)*

诊断服务器实例应按照ISO 14229-1处理诊断响应，包括发送正面和负面响应，以及抑制负面或正面响应。


**[SWS_DM_00368]**{DRAFT} **DM takes care of Response Pending Messages** *[*If the processing of a diagnostic service requires more time than allowed by the P2/P2\* timer of the current session, the Diagnostic Server instance shall send a negative response with NRC 0x78 (requestCorrectlyReceivedResponsePending) according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04016)*

> **[SWS_DM_00368]**{草案} **DM 负责处理待响应消息** *[*如果诊断服务的处理需要比当前会话的P2/P2\*计时器允许的时间更长，则诊断服务器实例应根据ISO 14229-1[[1](#_bookmark8)]发送带有NRC 0x78（requestCorrectlyReceivedResponsePending）的负响应。*♩（RS_Diag_04016）*


**[SWS_DM_00369]**{DRAFT} **Maximum number of busy responses** *[*If the nuber of negative responses for a requested diagnostic request reaches the value dfined in the configuration parameter maxNumberOfRequestCorrectlyReceivdResponsePending, the Diagnostic Server instance module shall cancel the processing of the active diagnostic internal or external request processing, according to [[SWS_DM_00277](#_bookmark185)], [[SWS_DM_00278](#_bookmark186)] and send a negative response with NRC 0x10 (generalReject).*♩(RS_Diag_04016)*

> 如果请求的诊断请求的负面响应数量达到配置参数maxNumberOfRequestCorrectlyReceivdResponsePending中定义的值，则根据[[SWS_DM_00277](#_bookmark185)]，[[SWS_DM_00278](#_bookmark186)]，诊断服务器实例模块将取消活动诊断内部或外部请求处理，并发送具有NRC 0x10（generalReject）的负面响应。♩（RS_Diag_04016）


**[SWS_DM_01257]**{DRAFT} **ResourceTemporarilyNotAvailable NRC handling** *[*If the DM is processing a diagnostic service using a ara::diag interface, that requires the offer(), and if this interface is not offered yet or not offered any more, the DM shall return an NRC 0x94 (ResourceTemporarilyNotAvailable).*♩()*

> 如果DM正在使用ara::diag接口处理诊断服务，并且该接口尚未提供或不再提供offer()，则DM应返回NRC 0x94（ResourceTemporarilyNotAvailable）。

### Keep track of active non-default sessions


**[SWS_DM_00380]**{DRAFT} **Support for S3 timer** *[*The Diagnostic Server istance shall provide support for S3~Server~ (session timeout) with a fixed value of 5 seconds. The timer handling shall be implemented according to ISO 14229-2[[14](#_bookmark19)].*♩ (RS_Diag_04006)*

> **[SWS_DM_00380]**{草稿} **支持S3定时器** *[*诊断服务实例应提供S3~Server~（会话超时）的支持，超时值为5秒。定时器处理应按照ISO 14229-2[[14](#_bookmark19)]实现。*♩（RS_Diag_04006）*


**[SWS_DM_00381]**{DRAFT} **Session timeout** *[*Whenever a non-default session is ative and when the session timeout (S3~Server~) is reached without receiving any diagnostic request, the Diagnostic Server instance shall reset to the default session state. Diagnostic Server instance internal states for service processing shall be reset according to ISO 14229-2[[14](#_bookmark19)].*♩(RS_Diag_04006)*

> **[SWS_DM_00381]**{草稿} **会话超时** *[*当非默认会话处于活动状态，并且在未收到任何诊断请求的情况下到达会话超时（S3~Server~）时，诊断服务器实例应重置为默认会话状态。根据ISO 14229-2[[14](#_bookmark19)]重置诊断服务器实例内部状态以进行服务处理。*♩(RS_Diag_04006)*


**[SWS_DM_00382]**{DRAFT} **Session timeout start** *[*The session timeout timer (S3~server~) shall be started on

> **[SWS_DM_00382]**{草案} **会话超时开始** *[*会话超时计时器（S3~服务器~）将在


- Completion of any final response message or an error indication during sending of the response ([SWS_DM_00312])

> 完成响应发送过程中的任何最终响应消息或错误指示（[SWS_DM_00312]）

- Completion of the requested action in case no response message (positive and negative) is required / allowed.

> 完成要求的行动，如果不需要/不允许回复消息（正面和负面）。
- In case of an error during the reception of a multi-frame request message ([SWS_DM_00310])


Start of S3~Server~ means reset the timer and start counting from the beginning.*♩(RS\Diag_04006)*

> S3~Server~的开始意味着重置计时器并从头开始计数。*♩(RS\Diag_04006)*


**[SWS_DM_00383]**{DRAFT} **Session timeout stop** *[*The session timeout timer (S3~Server~) shall be stopped when the reception of an UDS message was indicated ([SWS_DM_00309]).*♩(RS_Diag_04006)*

> **[SWS_DM_00383]**（草案）**会话超时停止** *[*当收到UDS消息时，会话超时计时器（S3~Server~）应停止（[SWS_DM_00309]）。*♩（RS_Diag_04006）*


**[SWS_DM_00812]**{DRAFT} **Re-enabling on transition to default session** *[*If DTC setting is disabled and DM is transitioning into default session, then DM shall enable the DTC setting again.*♩(RS_Diag_04006)*

> **[SWS_DM_00812]**{草案} **在转换到默认会话时重新启用** *[*如果DTC设置已禁用，而DM正在转换到默认会话，那么DM应该再次启用DTC设置。*♩(RS_Diag_04006)*

### UDS service processing


This chapter describes the UDS service processing behavior of the Diagnostic Server instance.

> 本章节描述了诊断服务器实例的UDS服务处理行为。


**[SWS_DM_00127]**{DRAFT} **Availability of diagnostic service processors** *[*The Dagnostic Server instance shall provide a service processor on SID level for all services by existence of a DiagnosticServiceClass referenced by a DiagnoticServiceInstance.serviceClass.*♩(RS_Diag_04196)*

> **[SWS_DM_00127]**{草案} **诊断服务处理器的可用性** *[*诊断服务器实例应通过DiagnoticServiceInstance.serviceClass引用的DiagnosticServiceClass为所有服务提供SID级服务处理器。*♩(RS_Diag_04196)*

### Supported UDS Services


The Diagnostic Server instance shall support the following listed UDS services:

> 诊断服务器实例应支持以下列出的UDS服务：


**Table 7.2: UDS Services supported by Diagnostic Server instance**

> 表7.2：诊断服务器实例支持的UDS服务

Note:


- UDS services which are not supported by DM, are documented in the section [Known Limitations](#known-limitations).

> 不受DM支持的UDS服务被记录在[已知限制](＃已知限制)部分。

- Support Type Internally means, that the service with the given SID can be completely processed internally within the Diagnostic Server instance without relying on external functionalitytypically in form of an AA. Support Type Externally means, that the Diagnostic Server instance needs to call an external function, to be able to process the service with the given SID. The mixed support Type \"Internally & Externally\" means, that for the service with the given SID partially calls to an external function have to be done, but it partially could be also handled internally.

> 支持类型内部意味着，该服务可以在诊断服务器实例内完全处理，而不依赖于外部功能，通常以AA的形式存在。支持类型外部意味着，诊断服务器实例需要调用外部函数才能处理具有给定SID的服务。混合支持类型“内部和外部”意味着，对于具有给定SID的服务，部分调用外部函数必须完成，但部分也可以在内部处理。


  1. ### Common service processing items

> ### 常见的服务处理项目


This chapter contains rules for service processors, shared among multiple services.

> 这一章节包含了服务处理器的规则，被多个服务共享。


Memory related UDS services (such as 0x34 RequestDownload) use the request prameter addressAndLengthFormatIdentifier to identify the number of bytes transmitted on the bus for memory address and size. Regardless of the wire representation of address and length information, within the Diagnostic Server instance and eternal service processors all addresses and data length information are mapped to a uint64 datatype.

> 内存相关的UDS服务（如0x34 RequestDownload）使用请求参数addressAndLengthFormatIdentifier来识别总线上传输的内存地址和大小的字节数。无论地址和长度信息的线表示如何，在诊断服务器实例和外部服务处理器中，所有的地址和数据长度信息都映射到uint64数据类型。


**[SWS_DM_00129]**{DRAFT} **Supported addressAndLengthFormatIdentifier** *[*The Diagnostic Server instance shall support for each nibble of the addressAdLengthFormatIdentifier a value between 1 and 8.*♩(RS_Diag_04120)*

> **[SWS_DM_00129]**{草案} **支持的地址和长度格式标识符** *[*诊断服务器实例应支持地址和长度格式标识符的每个半字节的值介于1到8之间。*♩(RS_Diag_04120)*


**[SWS_DM_00130]**{DRAFT} **Not supported addressAndLengthFormatIdentifier** *[*The Diagnostic Server instance shall send the negative response 0x31 (rquestOutOfRange), if an addressAndLengthFormatIdentifier with a value outside the range between 1 and 8 is received.*♩(RS_Diag_04120)*

> **[SWS_DM_00130]**{草案} **不支持的地址和长度格式标识符** *[*如果接收到值在1和8之间的地址和长度格式标识符，诊断服务器实例将发送负响应0x31（rquestOutOfRange）。*♩（RS_Diag_04120）*

### Service 0x10 DiagnosticSessionControl


The UDS service DiagnosticSessionControl is used to enable different diagnostic sessions in the server.

> 服务器中使用UDS服务DiagnosticSessionControl来启用不同的诊断会话。


[]{#_bookmark111 .anchor}**[SWS_DM_00226]**{DRAFT} **Support of UDS service DiagnosticSessionControl** *[*The Diagnostic Server instance shall provide the UDS service 0x10 DiagnoticSessionControl according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04198)*

> 诊断服务器实例应根据ISO 14229-1[[1](#_bookmark8)]提供UDS服务0x10 DiagnoticSessionControl。


**[SWS_DM_00227]**{DRAFT} **Check for supported sessions** *[*If the Subfunction adressed by the DiagnosticSessionControl according to [[SWS_DM_00226](#_bookmark111)] is not suported by the configuration, i.e., there is no DiagnosticSession configured with

> **[SWS_DM_00227]**{草案} **检查支持的会话** *[*如果根据[[SWS_DM_00226](#_bookmark111)]由DiagnosticSessionControl地址的子功能不受配置支持，即没有配置DiagnosticSession，


id matching the requested Subfunction value, the Diagnostic Server instance

> 符合所请求的子功能值的ID，诊断服务器实例


shall return a NRC 0x12 (SubFunctionNotSupported).*♩(RS_Diag_04196)*

> 将返回NRC 0x12（SubFunctionNotSupported）。*♩（RS_Diag_04196）*


In the context of parallel clients, a DiagnosticSessionControl may lead to negative rsponses even for supported Subfunctions with positive permission checks.

> 在并行客户端的情况下，即使对于支持的具有正权限检查的子功能，诊断会话控制也可能导致负面反应。


**[SWS_DM_00228]**{DRAFT} **Switch to requested Diagnostic Session** *[*On positive evaluation of a DiagnosticSessionControl request, the Diagnostic Server istance shall send the positive response message. After the response message is sent, the Diagnostic Server shall internally switch to the DiagnosticSession with id matching the requested Subfunction value, and shall set new timing parameters acording to the associated parameters p2ServerMax and p2StarServerMax.*♩(RS\Diag_04198)*

> **[SWS_DM_00228]**{草案}**切换到请求的诊断会话** *[*在诊断会话控制请求的正面评估后，诊断服务器实例应发送正面响应消息。发送响应消息后，诊断服务器应在内部切换到与所请求的子功能值匹配的诊断会话，并根据相关参数p2ServerMax和p2StarServerMax设置新的定时参数。*♩(RS\Diag_04198)*

简体中文：**[SWS_DM_00228]**{草案}**切换到请求的诊断会话** *[*在诊断会话控制请求的正面评估后，诊断服务器实例应发送正面响应消息。发送响应消息后，诊断服务器应内部切换到与所请求的子功能值匹配的诊断会话，并根据相关参数p2ServerMax和p2StarServerMax设置新的定时参数。*♩(RS\Diag_04198)*


**[SWS_DM_00845]**{DRAFT} **Notification about session change** *[*If the Diagnostic Server instance did successfully change the session of a conversation, it shall update the diagnostic session of the according ara::diag::Conversation class instance internally.*♩(RS_Diag_04208)*

> **[SWS_DM_00845]**{草案} **关于会话更改的通知** *[*如果诊断服务器实例成功更改了会话，它应该在内部更新ara :: diag :: 会话类实例的诊断会话。*♩（RS_Diag_04208）*

### Service 0x11 ECUReset


The term ECUReset originates in the Classic Platform world and ISO 14229-1[[1](#_bookmark8)]. Rgarding the Adaptive Platform, an ECUReset does not necessarily affect the whole ECU or machine, but must be interpreted in the context of the diagnostic address etity it targets, e. g. a platform or application level SoftwareCluster. Because the service name ECUReset is well known in diagnostics, it was decided to keep using the term throughout the affected Adaptive Platform specifications.

> 术语ECUReset起源于Classic Platform世界和ISO 14229-1[[1](#_bookmark8)]。关于Adaptive Platform，ECUReset不一定影响整个ECU或机器，但必须根据其目标的诊断地址实体来解释，例如平台或应用程序级软件集群。由于服务名称ECUReset在诊断中众所周知，因此决定在受影响的Adaptive Platform规范中继续使用这一术语。


**[SWS_DM_00234]**{DRAFT} **Support of UDS service ECUReset** *[*The Diagnostic Server instance shall provide the UDS service 0x11 ECU Reset according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04196)*

> **[SWS_DM_00234]**{草稿} **支持UDS服务ECUReset** *[*诊断服务器实例应根据ISO 14229-1[[1](#_bookmark8)]提供UDS服务0x11 ECU Reset。*♩(RS_Diag_04196)*


**[SWS_DM_00235]**{DRAFT} **ECUReset service processing** *[*The Diagnostic Server instance shall first call the method ara::diag::EcuResetRequest::RequestReset of the ara::diag::EcuResetRequest class instance to process an ECU Reset except for Enable-/DisableRapidPowerShutdown services.*♩(RS_Diag\04196)*

> **[SWS_DM_00235]**{草案} **ECU重置服务处理** *[*除了Enable-/DisableRapidPowerShutdown服务之外，诊断服务器实例首先应调用ara::diag::EcuResetRequest类实例的ara::diag::EcuResetRequest::RequestReset方法来处理ECU重置。*♩(RS_Diag\04196)*


**[SWS_DM_01018]**{DRAFT} **ECUReset ara::diag::ResetRequestType check** *[*The sub-function value shall be checked against the value of the DiagnosticcuReset. category and passed in resetType parameter.*♩(RS_Diag_04196)*

> **[SWS_DM_01018]**{草案} **ECUReset ara::diag::ResetRequestType 检查** *[*子功能值应与DiagnosticcuReset.类别的值进行比较，并在resetType参数中传递。*♩(RS_Diag_04196)*


**[SWS_DM_01019]**{DRAFT} **Custom ara::diag::ResetRequestType procesing** *[*If the resetType is set to kCustomReset, the id shall be equal to the customer reset value of the request.*♩(RS_Diag_04196)*

> **[SWS_DM_01019]**{草稿} **自定义ara :: diag :: ResetRequestType处理** *[*如果resetType设置为kCustomReset，则id应等于请求的客户重置值。*♩(RS_Diag_04196)*


**[SWS_DM_01020]**{DRAFT} **EnableRapidPowerShutdown processing** *[*If EnableapidPowerShutdown request is received, the DM shall trigger a call of ara::diag:EcuResetRequest::EnableRapidShutdown with enable set to TRUE if it is cofigured as per [[SWS_DM_00100](#_bookmark91)].*♩(RS_Diag_04196)*

> **[SWS_DM_01020]**{草案} **启用快速电源关闭处理** *[*如果收到启用快速电源关闭请求，DM 应该触发调用 ara::diag:EcuResetRequest::EnableRapidShutdown，将 enable 设置为 TRUE，如果它按照 [[SWS_DM_00100](#_bookmark91)] 配置。*♩(RS_Diag_04196)*


**[SWS_DM_01092]**{DRAFT} **EnableRapidPowerShutdown Positive Response** *[*If a positive response for subfunction 'EnableRapidPowerShutdown' shall be sent, the DM shall put the configured value of SoftwareClusterDiagnosticDeploymenProps.powerDownTime in its positive response.*♩(RS_Diag_04196)*

> **[SWS_DM_01092]**{草案} **启用快速关机正面响应** *[*如果要发送对子功能“启用快速关机”的正面响应，则DM应将SoftwareClusterDiagnosticDeploymenProps.powerDownTime的配置值放入其正面响应中。*♩(RS_Diag_04196)*


**[SWS_DM_01021]**{DRAFT} **DisableRapidPowerShutdown processing** *[*If DisableapidPowerShutdown request is received, the DM shall trigger a call of ara::diag::EcuResetRequest::EnableRapidShutdown with enable set to FALSE if it is configured as per [[SWS_DM_00100](#_bookmark91)].*♩(RS_Diag_04196)*

> **[SWS_DM_01021]**{草案} **禁用快速断电处理** *[*如果收到禁用快速断电请求，如果按照[[SWS_DM_00100](#_bookmark91)]配置，DM将触发调用ara :: diag :: EcuResetRequest :: EnableRapidShutdown，enable设置为FALSE。*♩(RS_Diag_04196)*


[]{#_bookmark113 .anchor}**[SWS_DM_00268]**{DRAFT} **EcuReset positive response processing before reset** *[*If the external processor did NOT raise an ApApplicationError, the Diagnotic Server instance shall return a positive response before the actual reset, in case the parameter DiagnosticEcuResetClass.respondToReset is either not present or present and set to DiagnosticResponseToEcuResetEnum.responBeforeReset.*♩(RS_Diag_04019)*

> 如果外部处理器没有引发ApApplicationError，则在实际复位之前，诊断服务器实例应在参数DiagnosticEcuResetClass.respondToReset不存在或存在且设置为DiagnosticResponseToEcuResetEnum.responBeforeReset的情况下返回正面响应。


**[SWS_DM_01023]**{DRAFT} **Calling ExecuteReset() if positive response shall be sent before reset** *[*If the parameter DiagnosticEcuResetClass.respondToRset is either not present or present and set to respondBeforeReset and the Dianostic Server instance has sent the positive response according to [[SWS_DM_00268](#_bookmark113)], the Diagnostic Server instance shall call ara::diag::EcuResetRequest::ExcuteReset.*♩(RS_Diag_04196)*

> **[SWS_DM_01023]**{草案} **如果需要在重置前发送正面响应，则调用ExecuteReset()** *[*如果参数DiagnosticEcuResetClass.respondToRset不存在或存在并设置为respondBeforeReset，且诊断服务器实例已经根据[[SWS_DM_00268](#_bookmark113)]发送了正面响应，则诊断服务器实例应调用ara :: diag :: EcuResetRequest :: ExcuteReset。*♩(RS_Diag_04196)*


[]{#_bookmark114 .anchor}**[SWS_DM_00360]**{DRAFT} **EcuReset positive response processing after reset** *[*If the external processor did NOT raise an ApApplicationError, and ara::diag::uds_transport::UdsTransportProtocolMgr::ChannelReestablished was called and the parameter DiagnosticEcuResetClass.respondToReset is set to DiagnosticResponseToEcuResetEnum.respondAfterReset, the diagnostic Server instance shall send a positive response.*♩(RS_Diag_04196)*

> 如果外部处理器没有引发ApApplicationError，并且调用了ara :: diag :: uds_transport :: UdsTransportProtocolMgr :: ChannelReestablished，并且参数DiagnosticEcuResetClass.respondToReset设置为DiagnosticResponseToEcuResetEnum.respondAfterReset，诊断服务器实例应发送正面响应。(RS_Diag_04196)


Note: The information, that the reset shall be transmitted after the ara::diag:uds_transport::UdsTransportProtocolHandler::NotifyReestablisment method is called can be stored by a flag in non-volatile memory.

> 注意：当调用ara::diag:uds_transport::UdsTransportProtocolHandler::NotifyReestablisment方法后，可以通过非易失性存储器中的一个标志来存储重置信息。


**[SWS_DM_01346]**{DRAFT} **Handling negative return values of ara::diag::EcuResetRequest::ExecuteReset** *[*If ara::diag::EcuResetRquest::ExecuteReset returns any of the defined error codes in [SWS_DM_01014], the Diagnostic Server instance shall return a Negative Response with NRC equal to the returned error code, if a final response to the request was not sent yet.*♩ (RS_Diag_04196)*

> 如果ara::diag::EcuResetRquest::ExecuteReset返回[SWS_DM_01014]中定义的任何错误代码，如果尚未发送对该请求的最终响应，则诊断服务器实例应返回带有NRC等于所返回错误代码的负响应（RS_Diag_04196）。


**[SWS_DM_01347]**{DRAFT} **Handling unspecified negative return values of ara::diag::EcuResetRequest::ExecuteReset** *[*If ara::diag::EcuResetRquest::ExecuteReset returns any error code other than the defined error codes

> **[SWS_DM_01347]**{草案} **处理ara::diag::EcuResetRequest::ExecuteReset的未指定的负返回值** *[*如果ara::diag::EcuResetRequest::ExecuteReset返回任何错误代码，而不是定义的错误代码


in [SWS_DM_01014], the Diagnostic Server instance shall return a Negative Response with NRC equal to 0x10 (generalReject), if a final response to the request was not sent yet.*♩(RS_Diag_04196)*

> 在[SWS_DM_01014]中，如果尚未发送对请求的最终响应，诊断服务器实例将返回NRC等于0x10（generalReject）的负响应（RS_Diag_04196）。


Note: Additionally, the FunctionalCluster or Application processing the reset should trigger a Log and Trace message giving the detailed cause for the error code(e.g. sequence error: RequestReset has not been called before ExecuteReset for the corresponding instance).

> 注意：此外，处理重置的功能集群或应用程序应触发一条日志和跟踪消息，提供错误码的详细原因（例如，序列错误：在对应实例执行重置之前未调用RequestReset）。


**[SWS_DM_01090]**{DRAFT} **Calling ExecuteReset() if positive response shall be sent after reset** *[*If the parameter DiagnosticEcuResetClass.respondToReset is set to respondAfterReset, the Diagnostic Server instance shall directly call ara::diag::EcuResetRequest::ExecuteReset without sending the positive rsponse according to [[SWS_DM_00268](#_bookmark113)].*♩(RS_Diag_04196)*

> **[SWS_DM_01090]**{草稿} **如果重置后应发送正面响应，则调用ExecuteReset（）** *[*如果参数DiagnosticEcuResetClass.respondToReset设置为respondAfterReset，则诊断服务器实例应直接调用ara :: diag :: EcuResetRequest :: ExecuteReset，而不按照[[SWS_DM_00268](#_bookmark113)]发送正面响应。*♩（RS_Diag_04196）*

简体中文：**[SWS_DM_01090]**{草案} **如果重置后应发送正面响应，则调用ExecuteReset（）** *[*如果参数DiagnosticEcuResetClass.respondToReset设置为respondAfterReset，则诊断服务器实例应直接调用ara :: diag :: EcuResetRequest :: ExecuteReset，而不发送根据[[SWS_DM_00268](#_bookmark113)]的正面响应。*♩（RS_Diag_04196）*


Note: Sending the positive response after the reset is handled by [[SWS_DM_00360](#_bookmark114)].

> 注意：重置后发送正面响应由[[SWS_DM_00360](#_bookmark114)]处理。


**[SWS_DM_00269]**{DRAFT} **Reaction on Unsupported Subfunction** *[*The Diagnostic Server instance shall send a negative response 0x12 (SubFunctionNotSupported), if the requested subfunction value is neither in configured range of default subfunction values (requestType, see ISO 14229-1[[1](#_bookmark8)]) nor in range of the configured DiagnosticEcuReset.customSubFunctionNumber in the ECU.*♩(RS_Diag_04196)*

> **[SWS_DM_00269]**{草案} **对不支持的子功能的反应** *[*如果所请求的子功能值既不在配置的默认子功能值范围（请求类型，参见ISO 14229-1[[1](#_bookmark8)]）中，也不在ECU中配置的DiagnosticEcuReset.customSubFunctionNumber范围内，则诊断服务器实例应发送负响应0x12（SubFunctionNotSupported）。*♩(RS_Diag_04196)*

简体中文：**[SWS_DM_00269]**{草案} **对不支持的子功能的反应** *[*如果请求的子功能值既不在配置的默认子功能值范围（请求类型，参见ISO 14229-1[[1](#_bookmark8)]）中，也不在ECU中配置的DiagnosticEcuReset.customSubFunctionNumber范围内，诊断服务器实例应发送负响应0x12（SubFunctionNotSupported）。*♩(RS_Diag_04196)*


[]{#_bookmark115 .anchor}**[SWS_DM_01022]**{DRAFT} **Block requests after ara::diag::EcuResetRequest::RequestReset called** *[*If the reset request is accepted , the Diagnostic Server instance that received the EcuReset request shall ignore further incoming UDS requests.*♩(RS_Diag_04196)*

> 如果重置请求被接受，接收到EcuReset请求的诊断服务器实例将忽略更多传入的UDS请求，在ara :: diag :: EcuResetRequest :: RequestReset调用后阻止请求。


**[SWS_DM_01309]**{DRAFT} **Unblock requests after ara::diag::EcuResetRequest::ExecuteReset completed** *[*If UDS rquests are blocked due to [[SWS_DM_01022](#_bookmark115)] and the ara::core::Future\<void\> returned from the call of ara::diag::EcuResetRequest::ExecuteReset, the DM shall accept incoming UDS requests again.*♩(RS_Diag_04196)*

> **[SWS_DM_01309]**{草稿} **在ara::diag::EcuResetRequest::ExecuteReset完成后解除请求阻塞** *[*如果由于[[SWS_DM_01022](#_bookmark115)]而阻止UDS请求，并且从调用ara::diag::EcuResetRequest::ExecuteReset返回ara::core::Future\<void\>，DM应该再次接受传入的UDS请求。*♩(RS_Diag_04196)*

### Service 0x14 ClearDiagnosticInformation


The UDS service ClearDiagnosticInformation is used to clear the ECUs fault memory.

> 服务ClearDiagnosticInformation用于清除ECU的故障存储器。


[]{#_bookmark117 .anchor}**[SWS_DM_00090]**{DRAFT} **Support of UDS service ClearDiagnosticInformation** *[*The Diagnostic Server instance shall provide the UDS service 0x14 CleaDiagnosticInformation according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04180, RS_Diag\04196)*

> 诊断服务器实例应根据ISO 14229-1[[1](#_bookmark8)]提供UDS服务0x14 ClearDiagnosticInformation。(RS_Diag_04180，RS_Diag_04196)


**[SWS_DM_00091]**{DRAFT} **Evaluation of ClearDiagnosticInformation parameters** *[*The Diagnostic Server instance shall determine the DTC group or single DTC to clear from the 'groupOfDTC' parameter of the UDS request.*♩(RS_Diag_04180, RS_Diag_04117)*

> **[SWS_DM_00091]**{草案} **清除诊断信息参数的评估** *[*诊断服务器实例应从UDS请求的“groupOfDTC”参数确定要清除的DTC组或单个DTC。*♩（RS_Diag_04180，RS_Diag_04117）*


[]{#_bookmark118 .anchor}**[SWS_DM_00092]**{DRAFT} **Parameter range check for groupOfDTC request parameter** *[*The Diagnostic Server instance shall reply with an NRC 0x31 (RequestOutOfRange) if the requested 'groupOfDTC' has no matching configured DTC group according to [[SWS_DM_00064](#_bookmark253)] or configured DTC by DiagnosticTrobleCodeUds.udsDtcValue.*♩(RS_Diag_04180, RS_Diag_04117)*

> 诊断服务器实例应回复NRC 0x31（请求超出范围），如果根据[[SWS_DM_00064](#_bookmark253)]或配置的DiagnosticTrobleCodeUds.udsDtcValue所请求的'groupOfDTC'没有匹配的配置DTC组。（RS_Diag_04180，RS_Diag_04117）


**[SWS_DM_00113]**{DRAFT} **Positive response for UDS service 0x14** *[*If the Dagnostic Server instance has cleared the requested 'groupOfDTC', the Dianostic Server instance shall send a positive response.*♩(RS_Diag_04196)*

> **[SWS_DM_00113]**{草案} **对 UDS 服务 0x14 的正面回复** *[*如果诊断服务器实例已清除所请求的“groupOfDTC”，诊断服务器实例应发送正面响应。*♩(RS_Diag_04196)*


The DTC clearing behavior is described in detail in section [7.6.4.5.5](#clearing-dtcs). It consists of resetting the DTC status and deleting snapshot records and extended data records.

> DTC清除行为在第7.6.4.5.5节中详细描述。它包括重置DTC状态并删除快照记录和扩展数据记录。


**[SWS_DM_00115]**{DRAFT} **Memory error handling while clearing DTCs** *[*The Diagnostic Server instance shall return a negative response NRC 0x72 (generalProgrammingFailure) if it encounters an error in the non-volatile meory while clearing the DTCs.*♩(RS_Diag_04180)*

> **[SWS_DM_00115]**{草案} **清除DTC时的内存错误处理** *[*如果在清除DTC时遇到非易失性存储器中的错误，诊断服务器实例应返回负响应NRC 0x72（generalProgrammingFailure）。*♩（RS_Diag_04180）*


The definition of a failure of the non-volatile memory is hardware and project spcific. In general if the clear DTC operation could not delete the snapshot records, extended data records and if it could not reset the UDS DTC status byte bcause the underlying storage system reported and error, a non-volatile memory error can be assumed.

> 定义非易失性存储器失败是硬件和项目特定的。一般来说，如果清除DTC操作无法删除快照记录，扩展数据记录，如果它无法重置UDS DTC状态字节，因为底层存储系统报告了错误，可以假定非易失性存储器出现了错误。


[]{#_bookmark119 .anchor}**[SWS_DM_00122]**{DRAFT} **UDS response behavior on not allowed clear oerations** *[*If a DTC clear operation is requested and the DTC clear operation shall clear a DTC with a forbidden clear allowance according to [[SWS_DM_00896](#_bookmark282)], the Diagnostic Server instance shall send a negative response 0x22 (conditionsNotCorrect) in the following situations:

> **[SWS_DM_00122]**{草案} **UDS 对不允许的清除操作的响应行为** *[*如果请求DTC清除操作，并且根据[[SWS_DM_00896](#_bookmark282)]，DTC清除操作将清除一个禁止清除允许的DTC，则在以下情况下，诊断服务器实例应发送负响应0x22（conditionsNotCorrect）：


- it was requested to clear a single DTC and the DTC could not be cleared accoring to [[SWS_DM_00896](#_bookmark282)]

> 根据[[SWS_DM_00896](#_bookmark282)]，要求清除单个DTC，但无法清除DTC。

- it was requested to clear a DTC group and all the DTCs of the DTC group could not be cleared according to [[SWS_DM_00896](#_bookmark282)]

> 根据[[SWS_DM_00896](#_bookmark282)]，要求清除DTC组，但无法清除该DTC组中的所有DTC。


(This doesn't apply when one or more DTC are allowed to be cleared.)

> (当允许清除一个或多个DTC时，此规则不适用。)

*♩(RS_Diag_04117)*


**[SWS_DM_00159]**{DRAFT} **Allow only to clear GroupOfAllDTCs** *[*If the configration DiagnosticMemoryDestination.clearDtcLimitation is set to cleaAllDtcs, the Diagnostic Server instance shall only allow to clear all DTCs via the GroupOfAllDTC as defined in [[SWS_DM_00065](#_bookmark254)]. In case a different value is given in groupOfDTC request parameter, the Diagnostic Server instance shall return a negative response 0x31 (RequestOutOfRange).*♩(RS_Diag_04117)*

> **[SWS_DM_00159]**{草案} **仅允许清除GroupOfAllDTCs** *[*如果配置DiagnosticMemoryDestination.clearDtcLimitation设置为cleaAllDtcs，则诊断服务器实例仅允许通过[[SWS_DM_00065](#_bookmark254)中定义的GroupOfAllDTC清除所有DTC。如果在groupOfDTC请求参数中给出不同的值，则诊断服务器实例将返回负响应0x31（RequestOutOfRange）。*♩(RS_Diag_04117)*


**[SWS_DM_00160]**{DRAFT} **Allow to clear single DTCs** *[*If the configuration DagnosticMemoryDestination.clearDtcLimitation is set to allSupporteDtcs, the Diagnostic Server instance shall allow to clear single DTCs or DTGroups. [[SWS_DM_00092](#_bookmark118)] defines the possible and refused values.*♩(RS_Diag\04117)*

> **[SWS_DM_00160]**{草案}**允许清除单一故障码** *[*如果配置DiagnosticMemoryDestination.clearDtcLimitation设置为allSupporteDtcs，诊断服务器实例应允许清除单一故障码或DTGroups。 [[SWS_DM_00092](#_bookmark118)] 定义了可能和拒绝的值。*♩(RS_Diag\04117)*


**[SWS_DM_00162]**{DRAFT} **Point in time for positive response for ClearDTC** *[*The Diagnostic Server instance shall send a positive response for a ClearDiagnoticInformation service after all memory is cleared in the server. This is regardless how the Diagnostic Server instance memory is organized (splitted, volatile, novolatile).*♩(RS_Diag_04180, RS_Diag_04196)*

> **[SWS_DM_00162]**{草案} **清除故障码的正面响应时间** *[*服务器实例在服务器中的所有内存清除后，应发送正面响应以清除诊断信息服务。无论诊断服务器实例的内存如何组织（拆分，易失性，非易失性），均应如此。*♩（RS_Diag_04180，RS_Diag_04196）*


[]{#_bookmark120 .anchor}**[SWS_DM_00163]**{DRAFT} **Definition of a inhibited clear operation on single DTC** *[*If it is requested to clear a single DTC and a DiagnosticClearCondition referenced from this DTC (via DiagnosticTroubleCodeUdsToClearConditioGroupMapping) is not fulfilled, the Diagnostic Server instance shall send a negative response 0x22 (conditionsNotCorrect).*♩(RS_Diag_04180)*

> 如果请求清除单个DTC，并且从该DTC（通过DiagnosticTroubleCodeUdsToClearConditioGroupMapping）引用的DiagnosticClearCondition未得到满足，则诊断服务器实例应发送负响应0x22（conditionsNotCorrect）。♩（RS_Diag_04180）


**[SWS_DM_00164]**{DRAFT} **Definition of a inhibited clear operation for a group of DTCs** *[*If it is requested to clear a group of DTCs, the Diagnostic Server instance shall send a negative response 0x22 (conditionsNotCorrect) if all DTCs of that group of DTC forbid the clearance according to [[SWS_DM_00163](#_bookmark120)] or [[SWS_DM_00896](#_bookmark282)].*♩(RS_Diag_04180)*

> 如果要求清除一组DTC，如果根据[[SWS_DM_00163]]或[[SWS_DM_00896]]，所有DTC禁止清除，则诊断服务器实例应发送负响应0x22（conditionsNotCorrect）。

### Clearing user-defined fault memory


According to [[SWS_DM_00090](#_bookmark117)] the Diagnostic Server instance implements an ISO 14229-1[[1](#_bookmark8)] compatible UDS service ClearDiagnosticInformation.

> 根据[[SWS_DM_00090](#_bookmark117)]，诊断服务器实例实现了一个兼容ISO 14229-1[[1](#_bookmark8)]的UDS服务ClearDiagnosticInformation。


The upcoming subchapter refers to ISO 14229-1:2020 [[1](#_bookmark8)].

> 下一节将参考ISO 14229-1:2020 [[1](#_bookmark8)]。


The clearance of a user-defined fault memory has the same behavior as the clearing of the primary fault memory. All requirements that are provided to clear the primary fault memory also apply to a clear of a user-defined fault memory.

> 用户定义故障存储器的清除与清除主要故障存储器的行为相同。清除主要故障存储器所提供的所有要求也适用于清除用户定义的故障存储器。


[]{#_bookmark122 .anchor}**[SWS_DM_00193]**{DRAFT} **Support of a user-defined fault memory clear request** *[*If the Diagnostic Server instance receives a a UDS service 0x14 ClearDianosticInformation with a length of 5 bytes, the Diagnostic Server instance shall interpret this request as a request to clear user-defined fault memory.*♩(RS\Diag_04197)*

> 如果诊断服务器实例接收到长度为5字节的UDS服务0x14 ClearDianosticInformation，诊断服务器实例应将其解释为清除用户定义故障存储器的请求。


[]{#_bookmark123 .anchor}**[SWS_DM_00194]**{DRAFT} **Definition of the user-defined fault memory nuber for ClearDiagnosticInformation** *[*If the Diagnostic Server instance rceives a UDS request to clear user-defined fault memory according to [[SWS_DM_00193](#_bookmark122)], the DM shall get the number of user-defined fault memory to be cleared from the fifth byte in the request.*♩(RS_Diag_04197)*

> 如果诊断服务器实例接收到UDS请求，根据[SWS_DM_00193]清除用户定义的故障存储器，DM应从请求的第五个字节获取要清除的用户定义故障存储器的编号。(RS_Diag_04197)


**[SWS_DM_00195]**{DRAFT} **Clearing a user-defined memory** *[*If the Diagnostic Server instance is requested to clear the user-defined fault memory acording to [[SWS_DM_00193](#_bookmark122)] and an DiagnosticMemoryDestinationUserDfined.memoryId exists with the requested user-defined memory number according to [[SWS_DM_00194](#_bookmark123)], the Diagnostic Server instance shall clear the requested user-defined fault memory.*♩(RS_Diag_04197)*

> **[SWS_DM_00195]**{草案} **清除用户定义的存储器** *[*如果根据[[SWS_DM_00193](#_bookmark122)]要求诊断服务器实例清除用户定义的故障存储器，并根据[[SWS_DM_00194](#_bookmark123)]中的DiagnosticMemoryDestinationUserDfined.memoryId存在请求的用户定义的内存号，诊断服务器实例应清除请求的用户定义的故障存储器。*♩(RS_Diag_04197)*


For details about the fault memory clearing process please also refer to section [7.6.4.5.5](#clearing-dtcs).

> 详情关于故障记忆清除过程，请参考[7.6.4.5.5](#clearing-dtcs)节。


**[SWS_DM_00208]**{DRAFT} **Validation of the requested user-defined memory number** *[*If the Diagnostic Server instance is requested to clear the usedefined fault memory according to [[SWS_DM_00193](#_bookmark122)] and no DiagnosticMemorDestinationUserDefined.memoryId exists with the requested user-defined meory number according to [[SWS_DM_00194](#_bookmark123)], the Diagnostic Server instance shall return a NRC 0x31 (RequestOutOfRange).*♩(RS_Diag_04197)*

> **[SWS_DM_00208]**{草案} **验证所请求的用户定义的存储器编号** *[*如果按照[[SWS_DM_00193](#_bookmark122)]要求诊断服务器实例清除用户定义的故障存储器，并且根据[[SWS_DM_00194](#_bookmark123)]没有找到具有所请求的用户定义的存储器编号的DiagnosticMemorDestinationUserDefined.memoryId，诊断服务器实例应返回NRC 0x31（RequestOutOfRange）。*♩(RS_Diag_04197)*

### Service 0x19 ReadDTCInformation


Some UDS responses for the Service "0x19 ReadDTCInformation" use the parameter "DTCFormatIdentifier" as part of the response PDU. The Diagnostic Server istance obtains the value used from the global configuration item DiagnosticMemryDestinationPrimary.typeOfDtcSupported. To provide the correct UDS vaues, the following mapping is used:

> 对于服务“0x19 ReadDTCInformation”，部分UDS响应使用参数“DTCFormatIdentifier”作为响应PDU的一部分。诊断服务器实例从全局配置项DiagnosticMemryDestinationPrimary.typeOfDtcSupported获取所使用的值。为了提供正确的UDS值，使用以下映射：


[]{#_bookmark125 .anchor}**[SWS_DM_00062]**{DRAFT} **Mapping between ISO 14229-1 and Autosar Diagnostic Extract Template of the DTCFormatIdentifier** *[*If a positive response for service 0x19 with the ISO 14229-1[[1](#_bookmark8)] parameter "DTCFormatIdentifier" is sent, the Diagnotic Server instance shall derive the value from DiagnosticMemoryDestnationPrimary.typeOfDtcSupported applying the following mapping rule:*♩(RS\Diag_04180, RS_Diag_04157, RS_Diag_04067)*

> 如果对服务0x19使用ISO 14229-1[[1](#_bookmark8)]参数“DTCFormatIdentifier”发送正面回应，诊断服务器实例应该根据下面的映射规则从DiagnosticMemoryDestnationPrimary.typeOfDtcSupported中派生出值：♩（RS_Diag_04180，RS_Diag_04157，RS_Diag_04067）。

+-----------------------------------+-----------------------------------+
| > typeOfDtcSupported              | > "DTCFormatIdentifier"           |
+===================================+===================================+
| > iso11992_4                      | > 0x03                            |
+-----------------------------------+-----------------------------------+
| > iso14229_1                      | > 0x01                            |
+-----------------------------------+-----------------------------------+
| > saeJ2012_da                     | > 0x00                            |
+-----------------------------------+-----------------------------------+


**[SWS_DM_00966]**{DRAFT} **Reporting of DTCStatusAvailabilityMask** *[*For all postive response for service 0x19 with DTCStatusAvailabilityMask in the response, the DM shall use the configured value from dtcStatusAvailabilityMask.*♩(RS\Diag_04180, RS_Diag_04157, RS_Diag_04067)*

> **[SWS_DM_00966]**{草案} **报告DTCStatusAvailabilityMask** *[*对于服务0x19的所有正面回应，其中包含DTCStatusAvailabilityMask的回应，DM应使用dtcStatusAvailabilityMask配置的值。*♩(RS\Diag_04180，RS_Diag_04157，RS_Diag_04067)*

### SF 0x01 reportNumberOfDTCByStatusMask


**[SWS_DM_00244]**{DRAFT} **Support of UDS service ReadDTCInformtion, Subfunction 0x01** *[*The Diagnostic Server instance shall suport Subfunction 0x01 (reportNumberOfDTCByStatusMask) of the UDS service 0x19 ReadDTCInformation according to ISO 14229-1[[1](#_bookmark8)], provided the cofiguration contains a DiagnosticReadDTCInformation of category 'RPORT_NUMBER_OF_DTC_BY_STATUS_MASK'.*♩(RS_Diag_04180, RS_Diag\04157, RS_Diag_04067)*

> **[SWS_DM_00244]**{草案} **支持UDS服务ReadDTCInformtion，子功能0x01** *[*如果配置包含类别为“RPORT_NUMBER_OF_DTC_BY_STATUS_MASK”的DiagnosticReadDTCInformation，诊断服务器实例应根据ISO 14229-1[[1](#_bookmark8)]支持UDS服务0x19 ReadDTCInformation的子功能0x01（reportNumberOfDTCByStatusMask）。*♩(RS_Diag_04180, RS_Diag\04157, RS_Diag_04067)*


**[SWS_DM_00061]**{DRAFT} **Providing rule for DTCFormatIdentifier in positive rsponse ReadDTCInformation.reportNumberOfDTCByStatusMask** *[*While sending the positive response for ReadDTCInformation.reportNumberOfDTCByStatusMask, the Diagnostic Server instance shall set the response PDU "DTCFormatIdetifier" according to the mapping of [[SWS_DM_00062](#_bookmark125)].*♩(RS_Diag_04157, RS_Diag\04067)*

> 在发送ReadDTCInformation.reportNumberOfDTCByStatusMask的正面响应时，诊断服务器实例应根据[[SWS_DM_00062](#_bookmark125)]的映射设置响应PDU“DTCFormatIdetifier”。♩（RS_Diag_04157，RS_Diag\04067）

### SF 0x02 reportDTCByStatusMask


**[SWS_DM_00245]**{DRAFT} **Support of UDS service ReadDTCInformation, Sufunction 0x02** *[*The Diagnostic Server instance shall support Subfunction 0x02 (reportDTCByStatusMask) of the UDS service 0x19 ReadDTCInformation acording to ISO 14229-1[[1](#_bookmark8)], provided the configuration contains a DiagnosticReaDTCInformation of category 'REPORT_DTC_BY_STATUS_MASK'.*♩(RS_Diag\04180, RS_Diag_04157, RS_Diag_04067)*

> **[SWS_DM_00245]**{草案} **支持UDS服务ReadDTCInformation，Sufunction 0x02** *[*如果配置包含一个类别为“REPORT_DTC_BY_STATUS_MASK”的DiagnosticReaDTCInformation，诊断服务器实例应根据ISO 14229-1[[1](#_bookmark8)]支持UDS服务0x19 ReadDTCInformation的Subfunction 0x02（reportDTCByStatusMask）。*♩（RS_Diag \ 04180，RS_Diag_04157，RS_Diag_04067）*

### SF 0x03 reportDTCSnapshotIdentification


**[SWS_DM_01256]**{DRAFT} **Support of UDS service ReadDTCInformtion, Subfunction 0x03** *[*The Diagnostic Server instance shall suport Subfunction 0x03 (reportDTCSnapshotIdentification) of the UDS service 0x19 ReadDTCInformation according to ISO 14229-1[[1](#_bookmark8)], provided the cofiguration contains a DiagnosticReadDTCInformation of category 'RPORT_DTC_SNAPSHOT_IDENTIFICATION'.*♩(RS_Diag_04180, RS_Diag_04157,*

> **[SWS_DM_01256]**{草案} **支持UDS服务ReadDTCInformtion，子功能0x03** *[*如果配置包含类别为“RPORT_DTC_SNAPSHOT_IDENTIFICATION”的DiagnosticReadDTCInformation，诊断服务器实例应根据ISO 14229-1[[1](#_bookmark8)]支持UDS服务0x19 ReadDTCInformation的子功能0x03 (reportDTCSnapshotIdentification)。*♩(RS_Diag_04180，RS_Diag_04157，*

*RS_Diag_04067)*

### SF 0x04 reportDTCSnapshotRecordByDTCNumber


**[SWS_DM_00246]**{DRAFT} **Support of UDS service ReadDTCInformation, Subfunction 0x04** *[*The Diagnostic Server instance shall support Sufunction 0x04 (reportDTCSnapshotRecordByDTCNumber) of the UDS service 0x19 ReadDTCInformation according to ISO 14229-1[[1](#_bookmark8)], provided the cofiguration contains a DiagnosticReadDTCInformation of category 'RPORT_DTC_SNAPSHOT_RECORD_BY_DTC_NUMBER'.*♩(RS_Diag_04180, RS\_-*

> **[SWS_DM_00246]**{草案} **支持UDS服务ReadDTCInformation，子功能0x04** *[*如果配置包含类别为“RPORT_DTC_SNAPSHOT_RECORD_BY_DTC_NUMBER”的DiagnosticReadDTCInformation，则按照ISO 14229-1[[1](#_bookmark8)]，诊断服务器实例应支持UDS服务0x19 ReadDTCInformation的Sufunction 0x04（reportDTCSnapshotRecordByDTCNumber）。*♩（RS_Diag_04180，RS\_-*


*Diag_04157, RS_Diag_04067)*

> *Diag_04157，RS_Diag_04067)*

*Diag_04157，RS_Diag_04067)*

### SF 0x06 reportDTCExtDataRecordByDTCNumber


**[SWS_DM_00370]**{DRAFT} **Support of UDS service ReadDTCInformation, Subfunction 0x06** *[*The Diagnostic Server instance shall support Sufunction 0x06 (reportDTCExtDataRecordByDTCNumber) of the UDS service

> **[SWS_DM_00370]**{草案} **支持UDS服务ReadDTCInformation，子功能0x06** *[*诊断服务器实例应支持UDS服务的Sufunction 0x06（reportDTCExtDataRecordByDTCNumber）


0x19 ReadDTCInformation according to ISO 14229-1[[1](#_bookmark8)], provided the cofiguration contains a DiagnosticReadDTCInformation of category 'RPORT_DTC_EXT_DATA_RECORD_BY_DTC_NUMBER'.*♩(RS_Diag_04180, RS\_-*

> 读取DTC信息根据ISO 14229-1[[1](#_bookmark8)]，如果配置包含一个DTC读取信息的类别为'RPORT_DTC_EXT_DATA_RECORD_BY_DTC_NUMBER'。*♩(RS_Diag_04180, RS\_-*


*Diag_04157, RS_Diag_04067)*

> *Diag_04157，RS_Diag_04067*（诊断04157，复发性诊断04067）

### SF 0x07 reportNumberOfDTCBySeverityMaskRecord


**[SWS_DM_00247]**{DRAFT} **Support of UDS service ReadDTCInformation, Subfunction 0x07** *[*The Diagnostic Server instance shall support Sufunction 0x07 (reportNumberOfDTCBySeverityMaskRecord) of the UDS service 0x19 ReadDTCInformation according to ISO 14229-1[[1](#_bookmark8)], provided the cofiguration contains a DiagnosticReadDTCInformation of category 'RPORT_NUMBER_OF_DTC_BY_SEVERITY_MASK_RECORD'.*♩(RS_Diag_04180,*

> **[SWS_DM_00247]**{草案} **支持UDS服务ReadDTCInformation，子功能0x07** *[*根据ISO 14229-1[[1](#_bookmark8)]，如果配置包含类别为“RPORT_NUMBER_OF_DTC_BY_SEVERITY_MASK_RECORD”的DiagnosticReadDTCInformation，诊断服务器实例应支持UDS服务0x19 ReadDTCInformation的子功能0x07（reportNumberOfDTCBySeverityMaskRecord）。*♩(RS_Diag_04180，*

简体中文：**[SWS_DM_00247]**{草案} **支持UDS服务ReadDTCInformation，子功能0x07** *[*根据ISO 14229-1[[1](#_bookmark8)]，如果配置包含类别为“RPORT_NUMBER_OF_DTC_BY_SEVERITY_MASK_RECORD”的DiagnosticReadDTCInformation，诊断服务器实例应支持UDS服务0x19 ReadDTCInformation的子功能0x07（reportNumberOfDTCBySeverityMaskRecord）。*♩(RS_Diag_04180，*

*RS_Diag_04157)*


**[SWS_DM_00063]**{DRAFT} **Providing rule for DTCFormatIdentifier in positive response ReadDTCInformation.reportNumberOfDTCBySeverityMaskRecord** *[*While sending the positive response for ReadDTCInformtion.reportNumberOfDTCBySeverityMaskRecord, the Diagnostic Server istance shall set the response PDU "DTCFormatIdentifier" according to the mapping of [[SWS_DM_00062](#_bookmark125)].*♩(RS_Diag_04157, RS_Diag_04067)*

> **[SWS_DM_00063]**{草案} **为ReadDTCInformation.reportNumberOfDTCBySeverityMaskRecord的正响应提供DTCFormatIdentifier规则** *[*在发送ReadDTCInformtion.reportNumberOfDTCBySeverityMaskRecord的正响应时，诊断服务器实例应根据[[SWS_DM_00062](#_bookmark125)]的映射设置响应PDU“DTCFormatIdentifier”。*♩(RS_Diag_04157, RS_Diag_04067)*

### SF 0x0A reportSupportedDTC


**[SWS_DM_00967]**{DRAFT} **Support of UDS service ReadDTCInformation, Subfunction 0x0A** *[*If a DiagnosticReadDTCInformation of category 'RPORT_SUPPORTED_DTCS' exists, the Diagnostic Server instance shall suport subfunction 0x0A (reportSupportedDTCs) of the UDS service 0x19 ReadDTCInfomation according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04180, RS_Diag_04157, RS_Diag\04067)*

> **[SWS_DM_00967]**{草稿} **支持UDS服务ReadDTCInformation的子功能0x0A** *[*如果存在类别'RPORT_SUPPORTED_DTCS'的DiagnosticReadDTCInformation，则根据ISO 14229-1[[1](#_bookmark8)]，Diagnostic Server实例应支持UDS服务0x19 ReadDTCInfomation的子功能0x0A（reportSupportedDTCs）。*♩（RS_Diag_04180，RS_Diag_04157，RS_Diag\04067）*


**[SWS_DM_00968]**{DRAFT} **Reporting of DTCAndStatusRecord parameter** *[*The *DTCAndStatusRecord* parameter according to ISO 14229-1[[1](#_bookmark8)] as part of the response shall consist of pairs of DTC number and its according DTC status of all supported DTCs of the DMs primary memory with no fixed and specified order.*♩(RS_Diag_04180, RS_Diag_04157, RS_Diag_04067)*

> [SWS_DM_00968]{草案}**报告DTCAndStatusRecord参数** *[*根据ISO 14229-1[[1](#_bookmark8)]的规定，响应中的DTCAndStatusRecord参数应包含DM主存储器支持的所有DTC的DTC编号和相应的DTC状态的配对，顺序不固定且无特定要求。*♩(RS_Diag_04180, RS_Diag_04157, RS_Diag_04067)*

### SF 0x14 reportDTCFaultDetectionCounter


**[SWS_DM_00371]**{DRAFT} **Support of UDS service ReadDTCInformtion, Subfunction 0x14** *[*The Diagnostic Server instance shall suport Subfunction 0x14 (reportDTCFaultDetectionCounter) of the UDS service

> **[SWS_DM_00371]**{草稿} **支持UDS服务ReadDTCInformtion，子功能0x14** *[*诊断服务器实例应支持UDS服务的子功能0x14（reportDTCFaultDetectionCounter）。


0x19 ReadDTCInformation according to ISO 14229-1[[1](#_bookmark8)], provided the cofiguration contains a DiagnosticReadDTCInformation of category 'RPORT_DTC_FAULT_DETECTION_COUNTER'.*♩(RS_Diag_04180, RS_Diag_04157,*

> 根据ISO 14229-1[[1](#_bookmark8)]，如果配置包含类别为“RPORT_DTC_FAULT_DETECTION_COUNTER”的DiagnosticReadDTCInformation，则0x19 ReadDTCInformation。♩（RS_Diag_04180、RS_Diag_04157，

*RS_Diag_04067)*

### SF 0x17 reportUserDefMemoryDTCByStatusMask


**[SWS_DM_00372]**{DRAFT} **Support of UDS service ReadDTCInformation, Subfunction 0x17** *[*The Diagnostic Server instance shall support Sufunction 0x17 (reportUserDefMemoryDTCByStatusMask) of the UDS service 0x19 ReadDTCInformation according to ISO 14229-1[[1](#_bookmark8)], provided the cofiguration contains a DiagnosticReadDTCInformation of category 'RPORT_USER_DEF_MEMORY_DTC_BY_STATUS_MASK'.*♩(RS_Diag_04180, RS\_-*

> **[SWS_DM_00372]**{草案} **支持UDS服务ReadDTCInformation，子功能0x17** *[*如果配置包含类别为'RPORT_USER_DEF_MEMORY_DTC_BY_STATUS_MASK'的DiagnosticReadDTCInformation，则根据ISO 14229-1[[1](#_bookmark8)]，诊断服务实例应该支持UDS服务0x19 ReadDTCInformation的Sufunction 0x17 (reportUserDefMemoryDTCByStatusMask)。*♩(RS_Diag_04180, RS\_-*

简体中文：**[SWS_DM_00372]**{草案} **支持UDS服务ReadDTCInformation，子功能0x17** *[*如果配置包含类别为'RPORT_USER_DEF_MEMORY_DTC_BY_STATUS_MASK'的DiagnosticReadDTCInformation，则根据ISO 14229-1[[1](#_bookmark8)]，诊断服务实例应该支持UDS服务0x19 ReadDTCInformation的Sufunction 0x17 (reportUserDefMemoryDTCByStatusMask)。*♩(RS_Diag_04180, RS\_-*


*Diag_04157, RS_Diag_04067)*

> *Diag_04157，RS_Diag_04067*

### SF 0x18 reportUserDefMemoryDTCSnapshotRecordByDTCNuber


**[SWS_DM_00373]**{DRAFT} **Support of UDS service ReadDTCInformation, Subfunction 0x18** *[*The Diagnostic Server instance shall support Sufunction 0x18 (reportUserDefMemoryDTCSnapshotRecordByDTCNumber) of the UDS service 0x19 ReadDTCInformation according to ISO 14229-1[[1](#_bookmark8)], provided the configuration contains a DiagnosticReadDTCInformation of category 'RPORT_USER_DEF_MEMORY_DTC_SNAPSHOT_RECORD_BY_DTC_NUMBER'.*♩*

> **[SWS_DM_00373]**{草案} **支持UDS服务ReadDTCInformation，子功能0x18** *[*如果配置包含类别为“RPORT_USER_DEF_MEMORY_DTC_SNAPSHOT_RECORD_BY_DTC_NUMBER”的DiagnosticReadDTCInformation，则诊断服务器实例应根据ISO 14229-1[[1](#_bookmark8)]支持UDS服务0x19 ReadDTCInformation的Sufunction 0x18（reportUserDefMemoryDTCSnapshotRecordByDTCNumber）。*♩*


*(RS_Diag_04180, RS_Diag_04157, RS_Diag_04067)*

> *(RS_Diag_04180，RS_Diag_04157，RS_Diag_04067)* 
简体中文：RS_Diag_04180，RS_Diag_04157，RS_Diag_04067

### SF 0x19 reportUserDefMemoryDTCExtDataRecordByDTCNumber


**[SWS_DM_00374]**{DRAFT} **Support of UDS service ReadDTCInformation, Subfunction 0x19** *[*The Diagnostic Server instance shall support Sufunction 0x19 (reportUserDefMemoryDTCExtDataRecordByDTCNumber) of the UDS service 0x19 ReadDTCInformation according to ISO 14229-1[[1](#_bookmark8)], provided the configuration contains a DiagnosticReadDTCInformation of category 'RPORT_USER_DEF_MEMORY_DTC_EXT_DATA_RECORD_BY_DTC_NUMBER'.*♩*

> **[SWS_DM_00374]**{草案} **支持UDS服务ReadDTCInformation，子功能0x19** *[*如果配置包含类别为'RPORT_USER_DEF_MEMORY_DTC_EXT_DATA_RECORD_BY_DTC_NUMBER'的诊断读取DTC信息，诊断服务器实例应根据ISO 14229-1[[1](#_bookmark8)]支持UDS服务0x19 ReadDTCInformation的Sufunction 0x19（reportUserDefMemoryDTCExtDataRecordByDTCNumber）。*♩*


*(RS_Diag_04180, RS_Diag_04157, RS_Diag_04067)*

> *(RS_Diag_04180，RS_Diag_04157，RS_Diag_04067)*

瑞士诊断04180、瑞士诊断04157、瑞士诊断04067

### Service 0x22 ReadDataByIdentifier


The processing of a UDS Service ReadDataByIdentifier (0x22) is described in ISO 14229-1[[1](#_bookmark8)], see in particular the evaluation sequence in Figure 15. On processing,

> ISO 14229-1[[1]](#_bookmark8)描述了UDS服务ReadDataByIdentifier（0x22）的处理，特别是图15中的评估序列。在处理时


the Diagnostic Server instance needs to perform various checks. The folloing requirements determine the relation between the input data to be checked and the configuration provided to the Diagnostic Server instance via DEXT parameters.

> 诊断服务器实例需要执行各种检查。以下要求确定要检查的输入数据与通过DEXT参数提供给诊断服务器实例的配置之间的关系。


**[SWS_DM_00170]**{DRAFT} **Realisation of UDS service ReadDataByIdentifier (0x22)** *[*The Diagnostic Server instance shall implement the diagnostic sevice 0x22 ReadDataByIdentifier according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04196)*

> **[SWS_DM_00170]**{草案} **实现UDS服务ReadDataByIdentifier（0x22）** *[*按照ISO 14229-1[[1](#_bookmark8)]，诊断服务器实例应实施诊断服务0x22 ReadDataByIdentifier。*♩(RS_Diag_04196)*


**[SWS_DM_00412]**{DRAFT} **Check requested number of DataIdentifiers** *[*On recetion of the UDS Service ReadDataByIdentifier (0x22), the Diagnostic Server istance shall check the number of the requested DataIdentifiers within one message. In case a UDS Service ReadDataByIdentifier (0x22) request contains more DataIdentfiers than defined by maxDidToRead, the request shall be rejected with NRC (0x13).*♩ (RS_Diag_04203)*

> **[SWS_DM_00412]**{草案} **检查请求的数据标识符数量** *[*收到UDS服务ReadDataByIdentifier（0x22）后，诊断服务实例应检查一条消息中请求的数据标识符的数量。如果UDS服务ReadDataByIdentifier（0x22）请求包含的数据标识符超过maxDidToRead定义的数量，则请求应使用NRC（0x13）被拒绝。*♩（RS_Diag_04203）*


[]{#_bookmark138 .anchor}**[SWS_DM_00409]**{DRAFT} **Check supported DataIdentifier** *[*On reception of the UDS Service ReadDataByIdentifier (0x22), a requested DataIdentifier shall be consiered as supported if and only if there exists a DiagnosticDataIdentifier with id matching the DataIdentifier and this DiagnosticDataIdentifier is referenced by a DiagnosticReadDataByIdentifier.*♩(RS_Diag_04203)*

> 当收到UDS服务ReadDataByIdentifier（0x22）时，如果存在具有与数据标识符匹配的诊断数据标识符，并且该诊断数据标识符由诊断读取数据标识符引用，则请求的数据标识符应被视为受支持。（RS_Diag_04203）


[]{#_bookmark139 .anchor}**[SWS_DM_00413]**{DRAFT} **Check supported DataIdentifier in active session** *[*On reception of the UDS Service ReadDataByIdentifier (0x22), a requested DataIdentfier shall be considered as supported in active session if and only if the DataIdentifier is supported according to [[SWS_DM_00409](#_bookmark138)] and the DiagnosticDataByIdentfier.accessPermission references by its DiagnosticAccessPermission.dagnosticSession the active diagnostic session in the DM.*♩(RS_Diag_04203)*

> 当接收到UDS服务ReadDataByIdentifier（0x22）时，只有当请求的DataIdentfier按照[[SWS_DM_00409]（#_bookmark138）]和DiagnosticDataByIdentfier.accessPermission通过其DiagnosticAccessPermission.dagnosticSession引用活动诊断会话（DM）时，才会被认为是活动会话中支持的。♩（RS_Diag_04203）


[]{#_bookmark140 .anchor}**[SWS_DM_00414]**{DRAFT} **Check supported DataIdentifier on active security level** *[*On reception of the UDS Service ReadDataByIdentifier (0x22), a requested DataIdentifier shall be considered as supported on active security level if and only if the DataIdentifier is supported according to [[SWS_DM_00409](#_bookmark138)] and the DiagnoticDataByIdentifier.accessPermission references by its DiagnosticAcessPermission.securityLevel the active security level in the DM.*♩(RS_Diag\04203)*

> 接收UDS服务ReadDataByIdentifier（0x22）时，如果所请求的DataIdentifier按照[[SWS_DM_00409](#_bookmark138)]和DiagnoticDataByIdentifier.accessPermission所引用的DiagnosticAcessPermission.securityLevel与DM中的活动安全级别相匹配，则该DataIdentifier被视为在活动安全级别上支持。


**[SWS_DM_00570]**{DRAFT} **Retrieving data for requested DataIdentifier** *[*On rception of the UDS Service ReadDataByIdentifier (0x22), the Diagnostic Server instance shall retrieve the mapped data for that DataIdentifier.

> 当接收到UDS服务ReadDataByIdentifier（0x22）时，诊断服务器实例应检索为该数据标识符映射的数据。


There are various ways how DID data retrieving is modeled. Among them are:

> 有多种方式模拟DID数据检索。其中包括：

- received entire DID via ara::diag interface [SWS_DM_00601] or [SWS_DM_00607]
- received data for data elements via ara::diag interface [SWS_DM_00603]
- generic UDS service processing [SWS_DM_00602]
- internal data [[SWS_DM_00393](#_bookmark301)]

*♩(RS_Diag_04097)*


Note: Also, a DiagnosticDataIdentifier's single dataElement (referenced by a meta-class DiagnosticDataElement) can be accessed from the associated RPortPrototype. Refer to chapters [7.6.6.2.1](#supported-diagnostic-mappings) and [7.6.6.2.2](#reading-diagnostic-data-identifier) for more details.

> 注意：此外，可以从关联的RPortPrototype访问DiagnosticDataIdentifier的单个数据元素（由meta-class DiagnosticDataElement引用）。有关更多详细信息，请参阅[7.6.6.2.1](#supported-diagnostic-mappings)和[7.6.6.2.2](#reading-diagnostic-data-identifier)章节。


**[SWS_DM_00571]**{DRAFT} **Reaction on ApplicationError** *[*The Diagnostic Server instance shall derive negative response code based on the definition of ISO 14221[[1](#_bookmark8)] from ara::diag::DiagUdsNrcErrorDomain.*♩(RS_Diag_04196)*

> **[SWS_DM_00571]**{草案} **对应用程序错误的反应** *[*根据ISO 14221[[1](#_bookmark8)]的定义，诊断服务器实例应从ara::diag::DiagUdsNrcErrorDomain中派生出负响应代码。*♩(RS_Diag_04196)*


Note: The presence of an ara::diag::DiagUdsNrcErrorDomain in the Result already indicates a negative result of the external diagnostic processor. Especially for multi DID requests a single failure might still lead to a positive response if at least one DID is supported in the active session.

> 注意：如果结果中出现ara::diag::DiagUdsNrcErrorDomain，就表明外部诊断处理器的结果为否定。特别是对于多个DID请求，即使有一个失败，只要活动会话中至少支持一个DID，也可能得到一个正面的回应。

### Service 0x27 SecurityAccess


**[SWS_DM_00236]**{DRAFT} **Realization of UDS service 0x27 SecurityAccess** *[*The Diagnostic Server instance shall implement the diagnostic service 0x27 SecrityAccess according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04196, RS_Diag_04005)*

> **[SWS_DM_00236]**{草案} **实现UDS服务0x27 SecurityAccess** *[*根据ISO 14229-1[[1](#_bookmark8)]，诊断服务器实例应实现诊断服务0x27 SecrityAccess。*♩(RS_Diag_04196, RS_Diag_04005)*


**[SWS_DM_00863]**{DRAFT} **Checking Supported Subfunction for RequestSeed** *[*On reception of a request for UDS Service SecurityAccess (0x27), the Diagnostic Server instance shall call ara::diag::SecurityAccess::GetSeed if the rquested subfunction value (securityAccessType) matches to the value of the istance of DiagnosticSecurityAccess with requestSeedId. The securityAcessDataRecord parameter shall be filled with the securityAccessDataRecord provided by the Diagnostic Client. If no data is provided by the Diagnostic Client, the securityAccessDataRecord parameter shall be empty.*♩(RS_Diag\04203)*

> 当收到UDS服务SecurityAccess（0x27）的请求时，如果请求的子功能值（securityAccessType）与具有requestSeedId的DiagnosticSecurityAccess的值相匹配，则诊断服务器实例将调用ara :: diag :: SecurityAccess :: GetSeed。securityAcessDataRecord参数应填充来自诊断客户端的securityAccessDataRecord。如果诊断客户端未提供数据，则securityAccessDataRecord参数应为空。


Note: The static seed mechanism, as specified in ISO 14229-1[[1](#_bookmark8)]annex I.2 table I.1, needs to be done by the application with the implementation of ara::diag::SecrityAccess::GetSeed and ara::diag::SecurityAccess::CompareKey.

> 注意：根据ISO 14229-1[[1](#_bookmark8)]附录I.2表I.1中指定的静态种子机制，应用程序需要通过实现ara：diag：SecrityAccess：GetSeed和ara：diag：SecurityAccess：CompareKey来完成。


**[SWS_DM_00507]**{DRAFT} **Length check on UDS Service 0x27 request with Sufunction for RequestSeed** *[*On reception of a request for UDS Service SecurityAccess (0x27) with subfunction value matching the requestSeedId of a configured DagnosticSecurityAccess, the Diagnostic Server instance shall perform the message length check against the optionally configured accessDataRecorSize of the related DiagnosticSecurityLevel. A non-present parameter acessDataRecordSize results in a check against 0 additional request bytes. If the length check fails, the Diagnostic Server instance shall send NRC 0x13 (IncorectMessageLengthOrInvalidFormat).*♩(RS_Diag_04203)*

> 当收到请求UDS服务SecurityAccess（0x27），其子功能值与配置的DagnosticSecurityAccess的请求种子ID匹配时，诊断服务器实例应对相关的DiagnosticSecurityLevel的可选配置的accessDataRecorSize执行消息长度检查。未提供参数acessDataRecordSize将检查附加请求字节数为0。如果长度检查失败，诊断服务器实例应发送NRC 0x13（IncorectMessageLengthOrInvalidFormat）。


**[SWS_DM_00864]**{DRAFT} **Checking Supported Subfunction for CopareKey** *[*The Diagnostic Server instance shall call ara::diag::SecurityAccess::CompareKey when the requested subfunction value (securityAccessType)1 (to get the corresponding requestSeed) is equal to

> **[SWS_DM_00864]**{草案}**检查CompareKey的支持子功能** *[*当请求的子功能值（securityAccessType）1（以获取相应的requestSeed）等于时，诊断服务器实例应调用ara :: diag :: SecurityAccess :: CompareKey。


the value of instance of DiagnosticSecurityAccess with requestSeedId.*♩*

> 值与诊断安全访问实例具有请求种子ID。

*(RS_Diag_04203)*


**[SWS_DM_00363]**{DRAFT} **Unsupported Subfunction** *[*If the requested subfuntion value is not configured (no instances of DiagnosticSecurityAccess with requestSeedId, as well as the corresponding CompareKey values), a negative rsponse 0x12 (SubFunctionNotSupported) shall be returned.*♩(RS_Diag_04196)*

> **[SWS_DM_00363]**{草案} **不受支持的子功能** *[*如果请求的子功能值未配置（没有请求种子ID的DiagnosticSecurityAccess实例以及相应的CompareKey值），则应返回负响应0x12（SubFunctionNotSupported）。*♩(RS_Diag_04196)*


**[SWS_DM_00846]**{DRAFT} **Notification about security-level change** *[*If the Dianostic Server instance did successfully change the security-level of a convesation, it shall update the security level of according ara::diag::Conversation class instance internally. Whether a security level is applicable by the DiagnostiSecurityAccess is defined by securityLevel.*♩(RS_Diag_04208)*

> **[SWS_DM_00846]**{草案} **关于安全级别更改的通知** *[*如果诊断服务器实例成功更改了对话的安全级别，它应该在内部更新ara :: diag :: Conversation类实例的安全级别。安全级别是否可以由DiagnostiSecurityAccess定义，取决于安全级别。*♩(RS_Diag_04208)*


[]{#_bookmark142 .anchor}**[SWS_DM_00270]**{DRAFT} **Counting of attempts to change security level** *[*The Diagnostic Server instance shall count the number of failed attempts to change a requested security level. The Counter shall be reset if the security level change has passed successfully.*♩(RS_Diag_04005)*

> 诊断服务器实例应计算尝试更改所请求安全级别的失败次数。如果安全级别更改成功，计数器将被重置。(RS_Diag_04005)


[]{#_bookmark143 .anchor}**[SWS_DM_00271]**{DRAFT} **Evaluate the number of failed security level change attempts** *[*The Diagnostic Server instance shall compare the number of failed DiagnosticSecurityLevel changes with threshold value numFailedSecuritAccess after each failed attempt.

> 诊断服务器实例应在每次失败尝试后，将失败的诊断安全级别更改次数与阈值值numFailedSecurityAccess进行比较。


If the number of failed attempts is below the threshold value numFailedSecuritAccess the Diagnostic Server instance shall send a negative response with NRC 0x35 (InvalidKey).

> 如果失败尝试的次数低于阈值numFailedSecuritAccess，诊断服务器实例将发送带有NRC 0x35（InvalidKey）的负响应。


If the number of failed attempts reaches the threshold value numFailedSecurityAcess the Diagnostic Server instance shall start a delay timer configured with value securityDelayTime (see [[SWS_DM_00272](#_bookmark144)]) and send a negative response with NRC 0x36 (exceededNumberOfAttempts).

> 如果失败尝试的次数达到阈值numFailedSecurityAcess，诊断服务器实例将启动一个配置为securityDelayTime值的延迟定时器（参见[[SWS_DM_00272](#_bookmark144)])，并发送NRC 0x36（exceededNumberOfAttempts）的负响应。


In both cases a DiagnosticSecurityLevel change must not be done if the attempt failed before.*♩(RS_Diag_04005)*

> 在这两种情况下，如果尝试失败，则不应更改DiagnosticSecurityLevel（RS_Diag_04005）。


The delay timer represents the required minimum time between security access atempts, after one time negative response with NRC 0x36 (exceededNumberOfAttempts) was sent out.

> 延迟定时器表示在发出NRC 0x36（超出尝试次数）的负面响应后，安全访问尝试之间所需的最小时间。


[]{#_bookmark144 .anchor}**[SWS_DM_00272]**{DRAFT} **Expiration of the delay timer** *[*As long as the delay timer (see [[SWS_DM_00271](#_bookmark143)]) configured with threshold value securityDelayTime has not expired, all requests for DiagnosticSecurityLevel change with subfunction value (access type) requestSeed shall be responded with NRC 0x37 (requiredTimeDlayNotExpired).

> 配置了阈值安全延迟时间的延迟定时器（参见[[SWS_DM_00271](#_bookmark143)）尚未到期，对于使用子功能值（访问类型）requestSeed的诊断安全级别更改的所有请求，将响应NRC 0x37（requiredTimeDlayNotExpired）。

*♩(RS_Diag_04005)*


**[SWS_DM_00478]**{DRAFT} **Persistent Storage of failed attempts to change secrity level** *[*The Diagnostic Server instance shall store the number of failed atempts persistently for every security access type separately. (see [[SWS_DM_00270](#_bookmark142)])*♩ (RS_Diag_04005)*

> **[SWS_DM_00478]**{草案}**更改安全级别失败尝试的持久存储** *[*诊断服务器实例应将每种安全访问类型的失败尝试次数持久地存储起来（参见[[SWS_DM_00270](#_bookmark142)])*♩ (RS_Diag_04005)*


**[SWS_DM_00479]**{DRAFT} **Blocking Timer for security access on Restart or Power downpower up cycle** *[*The Diagnostic Server instance shall restart the security delay timer with the higher value of DiagnosticCommonProps.secrityDelayTimeOnBoot / DiagnosticSecurityLevel.securityDelayTime of the according DiagnosticSecurityLevel if at least one of the stored numbers of failed attempts are greater or equal than the threshold value DiagnosticSecrityLevel. numFailedSecurityAccess. The behavior is equal to the behavior on runtime [[SWS_DM_00272](#_bookmark144)]) In case failed attempts are lower than the threshold value, the handling is equal to the behavior on runtime. (see [[SWS_DM_00270](#_bookmark142)] and [[SWS_DM_00271](#_bookmark143)])*♩(RS_Diag_04005)*

> **[SWS_DM_00479]**{草案} **在重新启动或断电重新上电周期中安全访问的阻塞计时器** *[*如果存储的失败尝试次数中至少有一个大于或等于阈值值DiagnosticSecrityLevel. numFailedSecurityAccess，则诊断服务器实例应以DiagnosticCommonProps.secrityDelayTimeOnBoot / DiagnosticSecurityLevel.securityDelayTime中的较高值重新启动安全延迟计时器。行为等同于运行时行为[[SWS_DM_00272](#_bookmark144)])。如果失败尝试次数低于阈值，处理方式等同于运行时行为。(参见[[SWS_DM_00270](#_bookmark142)]和[[SWS_DM_00271](#_bookmark143)])*♩(RS_Diag_04005)*

简体中文：**[SWS_DM_00479]**{草案} **重启或断电重新上电周期中安全访问的阻塞计时器** *[*如果存储的失败尝试次数中至少有一个大于或等于阈值值DiagnosticSecrityLevel. numFailedSecurityAccess，则诊断服务器实例应以DiagnosticCommonProps.secrityDelayTimeOnBoot / DiagnosticSecurityLevel.securityDelayTime中的较高值重新启动安全延迟计时器。行为与运行时行为相同[[SWS_DM_00272](#_bookmark144)])。如果失败尝试次数低于阈值，处理方式与运行时行为相同。(参见[[SWS_DM_00270](#_bookmark142)]和[[SWS_DM_00271](#_bookmark143)])*♩(RS_Diag_04005)*


**[SWS_DM_00480]**{DRAFT} **Security Access Blocking Timer** *[*If DiagnosticScurityAccessClass.sharedTimer exists and is set to true, a shared delay timer instance and shared value DiagnosticSecurityLevel. securityDelayTime shall be used for all security levels. As long as the blocking timer is running and not expired, all requests for every DiagnosticSecurityLevel change with subfunction value (access type) requestSeed shall be responded with NRC 0x37 (requiredTimeDlayNotExpired). (see [[SWS_DM_00272](#_bookmark144)]) If DiagnosticSecurityAccessClass. sharedTimer does not exist or is set to false, an independent timer instance and timer value shall be used for each security level.*♩(RS_Diag_04005)*

> **[SWS_DM_00480]**{草案} **安全访问阻止定时器** *[*如果DiagnosticScurityAccessClass.sharedTimer存在且设置为true，则所有安全级别都将使用共享延迟定时器实例和共享值DiagnosticSecurityLevel. securityDelayTime。只要阻止定时器正在运行且未过期，则对每个DiagnosticSecurityLevel更改的子功能值（访问类型）requestSeed的所有请求都将响应NRC 0x37（requiredTimeDlayNotExpired）。 （参见[[SWS_DM_00272](#_bookmark144)])如果DiagnosticSecurityAccessClass. sharedTimer不存在或设置为false，则每个安全级别都将使用独立的定时器实例和定时器值。*♩(RS_Diag_04005)*

简体中文：**[SWS_DM_00480]**{草案} **安全访问阻挡定时器** *[*如果DiagnosticScurityAccessClass.sharedTimer存在且设置为true，则所有安全级别都将使用共享延迟定时器实例和共享值DiagnosticSecurityLevel. securityDelayTime。只要阻挡定时器正在运行且未过期，则对每个DiagnosticSecurityLevel更改的子功能值（访问类型）requestSeed的所有请求都将响应NRC 0x37（requiredTimeDlayNotExpired）。（参见[[SWS_DM_00272](#_bookmark144)])如果DiagnosticSecurityAccessClass. sharedTimer不存在或设置为false，则每个安全级别都将使用独立的定时器实例和定时器值。*♩(RS_Diag_04005)*


**[SWS_DM_CONSTR_00208]**{DRAFT} **Delay time value for sharedTimer** *[*If DianosticSecurityAccessClass.sharedTimer exists and is set to true, the value DiagnosticSecurityLevel. securityDelayTime shall be identical for all cofigured security levels.*♩(RS_Diag_04005)*

> **[SWS_DM_CONSTR_00208]**{草案} **共享定时器的延迟时间值** *[*如果DianosticSecurityAccessClass.sharedTimer存在且设置为true，那么DiagnosticSecurityLevel.securityDelayTime对于所有配置的安全级别应该是相同的。*♩(RS_Diag_04005)*

### Service 0x28 CommunicationControl


**[SWS_DM_00140]**{DRAFT} **Realisation of UDS service 0x28 CommunicationCotrol** *[*The Diagnostic Server instance shall implement the diagnostic service 0x28 CommunicationControl according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04196)*

> **[SWS_DM_00140]**{草稿} **实现UDS服务0x28 CommunicationControl** *[*根据ISO 14229-1[[1](#_bookmark8)]，诊断服务器实例应实现诊断服务0x28 CommunicationControl。*♩(RS_Diag_04196)*


**[SWS_DM_00252]**{DRAFT} **Reaction on Unsupported Subfunction** *[*The Dianostic Server instance shall check, whether the Subfunction addressed by the CommunicationControl is supported by an existing DiagnosticComControl.catgory in the configuration and allow further processing. If the Subfunction addressed by the CommunicationControl is not supported by an existing DiagnosticComControl. category in the configuration a negative response 0x12 (SubFunctionNotSupported) shall be returned.*♩(RS_Diag_04203)*

> **[SWS_DM_00252]**{草稿} **对不受支持的子功能的反应** *[*诊断服务器实例应检查通信控制所指定的子功能是否由配置中的现有DiagnosticComControl.catgory支持，并允许进一步处理。如果通信控制所指定的子功能不受现有DiagnosticComControl.category配置的支持，则应返回负响应0x12（SubFunctionNotSupported）。*♩(RS_Diag_04203)*

译：诊断服务器实例应检查通信控制所指定的子功能是否由配置中的现有DiagnosticComControl.catgory支持，如果不支持，则应返回负响应0x12（SubFunctionNotSupported）。


**[SWS_DM_00865]**{DRAFT} **Communication control service processing** *[*The Dagnostic Server instance shall call the method ara::diag::CommunictionControl::CommCtrlRequest to process a communication control service.*♩ (RS_Diag_04169)*

> **[SWS_DM_00865]**{草案} **通信控制服务处理** *[*Dagnostic服务器实例应调用方法ara::diag::CommunictionControl::CommCtrlRequest来处理通信控制服务。*♩ (RS_Diag_04169)*


**[SWS_DM_00866]**{DRAFT} **Negative Response processing** *[*If the external procesor raised an error according to ara::diag::DiagUdsNrcErrc, the Diagnostic

> **[SWS_DM_00866]**{草案} **负面响应处理** *[*如果外部处理器根据ara::diag::DiagUdsNrcErrc引发错误，则诊断


Server instance shall return a negative response with the value of that error code.*♩*

> 服务器实例应返回一个带有该错误码值的负响应。

*(RS_Diag_04196)*


**[SWS_DM_00199]**{DRAFT} **Positive Response processing** *[*If the external procesor did raise no ApApplicationError, the Diagnostic Server instance shall return a positive response.*♩(RS_Diag_04196)*

> **[SWS_DM_00199]**{草案} **正面响应处理** *[*如果外部处理器没有引发任何ApApplicationError，诊断服务器实例应返回正面响应。*♩(RS_Diag_04196)*

### Service 0x29 Authentication


The UDS service Authentication (0x29) is used by the ECU as a means to identify the client and provide the relevant access to diagnostic resources, based on the client's 'role'. The access to these diagnostic resources can be limited in time, or, bound to certain vehicles or ECUs. The specifications of this chapter are based on the UDS Specifications ISO 14229-1:2020 [[1](#_bookmark8)]. The specifications of this chapter are a sub-set of the service 0x29 specifications of ISO 14229-1:2020 [[1](#_bookmark8)], and the Diagnostic Manager may only implement the specifications of this chapter.

> 服务认证（0x29）是ECU用来识别客户并根据客户的“角色”提供相关的诊断资源的一种手段。对这些诊断资源的访问可能会受到时间限制，或者受到某些车辆或ECU的限制。本章节的规范基于UDS规范ISO 14229-1:2020[[1（#_bookmark8）]]。本章节的规范是ISO 14229-1:2020[[1（#_bookmark8）]]服务0x29规范的子集，诊断管理器只能实施本章节的规范。


**[SWS_DM_01226]**{DRAFT} **Support of UDS service authentication** *[*If configured, the Diagnostic Server instance shall provide the UDS service 0x29 Authentcation with the subfunctions.

> **[SWS_DM_01226]**{草案} **支持UDS服务认证** *[*如果配置，诊断服务器实例应提供UDS服务0x29认证，具有子功能。

- deAuthenticate
- verifyCertificateUnidirectional
- verifyCertificateBidirectional
- proofOfOwnership
- transmitCertificate
- authenticationConfiguration


according to ISO 14229-1:2020 [[1](#_bookmark8)].*♩(RS_Diag_04251)*

> 根据ISO 14229-1:2020 [[1]](#_bookmark8)。♩（RS_Diag_04251）


Note: The Diagnostic Manager only implements the authentication via PKI certificate exchange. Authentication with challenge-response (ACR) is currently out of scope of the Diagnostic Manager.

> 注意：诊断管理器只实施通过PKI证书交换的认证。目前挑战-响应（ACR）认证不在诊断管理器的范围之内。


**[SWS_DM_01227]**{DRAFT} **Configuration of authentication types** *[*If the sub funtion DiagnosticProofOfOwnership of the DiagnosticAuthentication DiagnoticServiceInstance is configured, the Diagnostic Manager shall mandatorily rquire one of the following sub functions to be configured as well:

> **[SWS_DM_01227]**{草案} **认证类型的配置** *[*如果DiagnosticAuthentication DiagnoticServiceInstance的子功能DiagnosticProofOfOwnership被配置，诊断管理器必须要求配置以下其中一个子功能：

- DiagnosticVerifyCertificateUnidirectional
- DiagnosticVerifyCertificateBidirectional

*♩(RS_Diag_04251)*


**[SWS_DM_01228]**{DRAFT} **Mandatory sub functions** *[*If one of the following sub functions of DiagnosticAuthentication, DiagnosticServiceInstance is configured:

> **[SWS_DM_01228]**{草案} **强制性子功能** *[*如果下列DiagnosticAuthentication，DiagnosticServiceInstance的子功能之一被配置：

- DiagnosticVerifyCertificateUnidirectional
- DiagnosticVerifyCertificateBidirectional
- DiagnosticProofOfOwnership


the Diagnostic Manager shall mandatorily require the following sub functions to be configured as well:

> 诊断管理器必须要求以下子功能也必须配置：

- DiagnosticDeAuthenticate
- DiagnosticAuthenticationConfiguration

*♩(RS_Diag_04251)*


**[SWS_DM_01229]**{DRAFT} **Support for authentication per Diagnostic Converstion** *[*The Diagnostic Server instance shall support the Authentication service independently for every Diagnostic Conversation.*♩(RS_Diag_04251)*

> 诊断服务器实例应为每个诊断对话独立支持身份验证服务。（RS_Diag_04251）


NOTE : The authentication status on one Diagnostic Conversation shall not ifluence the access restrictions on a different Diagnostic Connection.

> 注意：一个诊断会话的身份验证状态不会影响另一个诊断连接的访问限制。

### VerifyCertificateUnidirectional [SWS_DM_01230] {DRAFT} Processing the verifyCertificateUnidirectional request


*[*On reception of an Authentication (0x29) service with sub-function equal to verfyCertificateUnidirectional, if all checks described in [[SWS_DM_00096](#_bookmark88)] are succesfully completed, the Diagnostic Server instance shall call the method ara::diag::Authentication::VerifyCertificateUnidirectional of the class ara::diag::Authentication. The Diagnostic Server instance shall pass the received communicationConfiguration (COCO), certificateClient (CECL) and chalengeClient (CHCL) to the application in the parameters CommunicationConfiguration, ClientCertificate and ClientChallenge of the method respectively.*♩(RS_Diag_04251)*

> 收到认证（0x29）服务，其子功能等于verfyCertificateUnidirectional，如果所有检查都按照[[SWS_DM_00096](#_bookmark88)]中描述的成功完成，诊断服务器实例将调用ara :: diag :: Authentication类的ara :: diag :: Authentication :: VerifyCertificateUnidirectional方法。诊断服务器实例将接收到的通信配置（COCO），客户端证书（CECL）和客户端挑战（CHCL）分别传递给该方法中的CommunicationConfiguration，ClientCertificate和ClientChallenge参数。*♩（RS_Diag_04251）*


**[SWS_DM_01231]**{DRAFT} **Handling Negative return values of ara::diag::Authentication::VerifyCertificateUnidirectional method** *[*If the method called in [[SWS_DM_01230](#verifycertificateunidirectional-sws_dm_01230draft-processing-the-verifycertificateunidirectional-request)] returns any of the defined error codes in [SWS_DM_01126], the Diagnostic Server instance shall return a Negative Response with NRC equal to the returned error code.*♩(RS_Diag_04251)*

> **[SWS_DM_01231]**{草案} **处理ara::diag::Authentication::VerifyCertificateUnidirectional方法的负返回值** *[*如果在[[SWS_DM_01230](#verifycertificateunidirectional-sws_dm_01230draft-processing-the-verifycertificateunidirectional-request)中调用的方法返回[SWS_DM_01126]中定义的任何错误代码，则诊断服务器实例应返回具有NRC等于返回的错误代码的负响应。*♩(RS_Diag_04251)*

简体中文：**[SWS_DM_01231]**{草案} **处理ara::diag::Authentication::VerifyCertificateUnidirectional方法的负返回值** *[*如果在[[SWS_DM_01230](#verifycertificateunidirectional-sws_dm_01230draft-processing-the-verifycertificateunidirectional-request)中调用的方法返回[SWS_DM_01126]中定义的任何错误代码，则诊断服务器实例应返回具有NRC等于返回的错误代码的负响应。*♩(RS_Diag_04251)*


**[SWS_DM_01232]**{DRAFT} **Handling unspecified negative return values of ara::diag::Authentication::VerifyCertificateUnidirectional method** *[*If the method called in [[SWS_DM_01230](#verifycertificateunidirectional-sws_dm_01230draft-processing-the-verifycertificateunidirectional-request)] returns any error code other than the defined error codes in [SWS_DM_01126], the Diagnostic Server istance shall return a Negative Response with NRC equal to 0x10 (generalReject).*♩ (RS_Diag_04251)*

> 如果在[[SWS_DM_01230](#verifycertificateunidirectional-sws_dm_01230draft-processing-the-verifycertificateunidirectional-request)]中调用的方法返回任何错误代码，而不是[SWS_DM_01126]中定义的错误代码，则诊断服务实例应返回NRC等于0x10（generalReject）的负响应。（RS_Diag_04251）


**[SWS_DM_01233]**{DRAFT} **Successful verification of verifyCertificateUnidiretional** *[*If the method called in [[SWS_DM_01230](#verifycertificateunidirectional-sws_dm_01230draft-processing-the-verifycertificateunidirectional-request)] executes successfully and returns no error code, the Diagnostic Server instance shall return a Positive Response to the tester. The field lengthOfChallengeServer (LOCHSE) and lengthOfEphemealPublicKeyServer (LOEPKSE) shall be derived by the Diagnostic Server istance from the returned Challenge and filled in the Positive Response. The Dagnostic Server instance shall copy the returned Challenge into the response field challengeServer (CHSE) and the returned Ephemeral Public Key into the rsponse field ephemeralPublicKeyServer (EPKSE). The Diagnostic Server istance shall set the parameter authenticationReturnParameter (RV) to 0x11 (CertifcateVerified, OwnershipVerificationNecessary) in the positive Response.*♩(RS_Diag\04251)*

> 如果在[[SWS_DM_01230](#verifycertificateunidirectional-sws_dm_01230draft-processing-the-verifycertificateunidirectional-request)中调用的方法执行成功并且没有返回错误代码，诊断服务器实例将向测试人员返回正面响应。字段lengthOfChallengeServer（LOCHSE）和lengthOfEphemealPublicKeyServer（LOEPKSE）将由诊断服务器实例从返回的挑战中推断出来，并填入正面响应中。诊断服务器实例将返回的挑战复制到响应字段challengeServer（CHSE）中，将返回的临时公钥复制到响应字段ephemeralPublicKeyServer（EPKSE）中。诊断服务器实例将参数authenticationReturnParameter（RV）设置为0x11（CertifcateVerified，OwnershipVerificationNecessary），在正面响应中。（RS_Diag\04251）


**[SWS_DM_01234]**{DRAFT} **Unexpected verifyCertificateUnidirectional from a diferent client** *[*The method ara::diag::Authentication::VerifyCertificteUnidirectional shall be re-entrant to requests from different clients.*♩(RS_Diag\04251)*

> **[SWS_DM_01234]**{草稿} **来自不同客户端的意外verifyCertificateUnidirectional** *[*ara::diag::Authentication::VerifyCertificteUnidirectional方法应该对来自不同客户端的请求重新进入。*♩(RS_Diag\04251)*


NOTE: The Diagnostic Server instance shall treat each verifyCertificateUndirectional sub function request individually and shall not keep track of previously received verifyCertificateUnidirectional sub function requests. For E.g., when multple verifyCertificateUnidirectional requests are received without the proofOfOwnership sub-function request.

> 注意：诊断服务器实例应将每个verifyCertificateUnidirectional子功能请求单独处理，不应跟踪以前收到的verifyCertificateUnidirectional子功能请求。例如，当收到多个verifyCertificateUnidirectional请求而没有proofOfOwnership子功能请求时。

### VerifyCertificateBidirectional


[]{#_bookmark150 .anchor}**[SWS_DM_01235]**{DRAFT} **Processing the verifyCertificateBidirectional request** *[*On reception of an Authentication (0x29) service with sub-function equal to verfyCertificateBidirectional, if all checks described in [[SWS_DM_00096](#_bookmark88)] are succesfully completed, the Diagnostic Server instance shall call the method ara::diag::Authentication::VerifyCertificateBidirectional of the class ara::diag::Authentication. The Diagnostic Server instance shall pass the received communicationConfiguration(COCO), certificateClient (CECL) and chalengeClient (CHCL) to the application in the parameters CommunicationConfiguration, ClientCertificate and ClientChallenge of the method respectively.*♩(RS_Diag_04251)*

> 当收到一个子功能等于verfyCertificateBidirectional的认证（0x29）服务时，如果所有在[[SWS_DM_00096](#_bookmark88)]中描述的检查都成功完成，则诊断服务器实例应调用类ara :: diag :: Authentication的ara :: diag :: Authentication :: VerifyCertificateBidirectional方法。诊断服务器实例应将接收到的通信配置（COCO）、客户端证书（CECL）和客户端挑战（CHCL）分别传递给方法中的CommunicationConfiguration、ClientCertificate和ClientChallenge参数。（RS_Diag_04251）


**[SWS_DM_01236]**{DRAFT} **Handling Negative return values of ara::diag::Authentication::VerifyCertificateBidirectional method** *[*If the method called in [[SWS_DM_01235](#_bookmark150)] returns any of the defined error codes in [SWS_DM_01127], the Diagnostic Server instance shall return a Negative Response with NRC equal to the returned error code.*♩(RS_Diag_04251)*

> 如果在[[SWS_DM_01235](#_bookmark150)]中调用的方法返回[SWS_DM_01127]中定义的任何错误代码，则诊断服务器实例应返回NRC等于所返回错误代码的负响应。


**[SWS_DM_01237]**{DRAFT} **Handling unspecified negative return values of ara::diag::Authentication::VerifyCertificateBidirectional method** *[*If the method called in [[SWS_DM_01235](#_bookmark150)] returns any error code other

> **[SWS_DM_01237]**{草案} **处理ara :: diag :: Authentication :: VerifyCertificateBidirectional方法的未指定的负返回值** *[*如果[[SWS_DM_01235](#_bookmark150)中调用的方法返回任何错误代码


than the defined error codes in [SWS_DM_01127], the Diagnostic Server istance shall return a Negative Response with NRC equal to 0x10 (generalReject).*♩ (RS_Diag_04251)*

> 除了[SWS_DM_01127]中定义的错误代码，诊断服务实例应返回NRC等于0x10（generalReject）的负响应。（RS_Diag_04251）


**[SWS_DM_01238]**{DRAFT} **Successful verification of verifyCertificateBidiretional** *[*If the method called in [[SWS_DM_01235](#_bookmark150)] executes successfully and returns no error code, the Diagnostic Manager shall return a Positive Response to the tester. The fields lengthOfChallengeServer (LOCHSE), lengthOfCertificateServer (LOCESE) and lengthOfProofOfOwnershipServer (LPOWNSE) and lengthOfEphemeralPubliceyServer(LOEPKSE) shall be derived by the Diagnostic Server instance from the returned Challenge, Certificate, ProofOfOwnership and EphemeralPublicKey and filled in the Positive Response. The Diagnostic Server instance shall copy the returned Challenge into the response field challengeServer (CHSE), the returned Certificate into the response field certificateServer (CESE), the returned ProofOfOwership into the response field proofOfOwnershipServer (POWNSE) and the returned Ephemeral Public Key into the response field ephemeralPublicKeyServer (EPKSE). The Diagnostic Server instance shall set the parameter authenticationReturParameter (RV) to 0x11 (CertificateVerified, OwnershipVerificationNecessary) in the positive Response.*♩(RS_Diag_04251)*

> 如果在[SWS_DM_01235](#_bookmark150)中调用的方法执行成功，并且没有返回错误代码，诊断管理器将向测试人员返回正面回应。字段lengthOfChallengeServer（LOCHSE），lengthOfCertificateServer（LOCESE），lengthOfProofOfOwnershipServer（LPOWNSE）和lengthOfEphemeralPubliceyServer（LOEPKSE）将由诊断服务器实例从返回的挑战，证书，所有权证明和临时公钥中推断出来，并填入正面回应中。诊断服务器实例将返回的挑战复制到响应字段challengeServer（CHSE）中，返回的证书复制到响应字段certificateServer（CESE）中，返回的所有权证明复制到响应字段proofOfOwnershipServer（POWNSE）中，返回的临时公钥复制到响应字段ephemeralPublicKeyServer（EPKSE）中。诊断服务器实例将参数authenticationReturParameter（RV）设置为0x11（CertificateVerified，OwnershipVerificationNecessary），以在正面回应中使用。（RS_Diag_04251）


**[SWS_DM_01239]**{DRAFT} **Unexpected verifyCertificateBidirectional from a diferent client** *[*If the method ara::diag::Authentication::VerifyCertifcateBidirectional shall be re-entrant to requests from different clients.*♩(RS\Diag_04251)*

> **[SWS_DM_01239]**{草稿} **来自不同客户端的意外verifyCertificateBidirectional** *[*如果ara :: diag :: Authentication :: VerifyCertifcateBidirectional方法应该重新处理来自不同客户端的请求。*♩(RS\Diag_04251)*


NOTE: The Diagnostic Server instance shall treat each verifyCertificateBidrectional sub function request individually and shall not keep track of previously rceived verifyCertificateBidirectional sub function requests. For E.g, when multiple verifyCertificateBidirectional requests are received without the proofOfOwnership sufunction request

> 注意：诊断服务器实例应单独处理每个verifyCertificateBidrectional子功能请求，并且不应跟踪以前收到的verifyCertificateBidrectional子功能请求。例如，当多个verifyCertificateBidrectional请求接收到时，没有proofOfOwnership子功能请求。

### ProofOfOwnership


[]{#_bookmark152 .anchor}**[SWS_DM_01240]**{DRAFT} **Processing the proofOfOwnership request** *[*On recetion of an Authentication (0x29) service with sub-function equal to proofOfOwnership, if all checks described in [[SWS_DM_00096](#_bookmark88)] are successfully completed, the Diagnotic Server instance shall call the method ara::diag::Authentication:VerifyOwnership of the class ara::diag::Authentication. The Diagnostic Server instance shall pass the received proofOfOwnershipClient (POWNCL) and ephemeralPublicKeyClient (EPKCL) to the application in the parameters ClientPOWN and ClientEphemeralPublicKey of the method respectively.*♩(RS_Diag_04251)*

> 当收到Authentication（0x29）服务的子功能等于proofOfOwnership时，如果按照[[SWS_DM_00096](#_bookmark88)]中描述的所有检查都成功完成，诊断服务器实例应调用类ara :: diag :: Authentication的ara :: diag :: Authentication：VerifyOwnership方法。诊断服务器实例应将接收到的proofOfOwnershipClient（POWNCL）和ephemeralPublicKeyClient（EPKCL）分别传递给方法的ClientPOWN和ClientEphemeralPublicKey参数中的应用程序。♩（RS_Diag_04251）


**[SWS_DM_01241]**{DRAFT} **Handling Negative return values of ara::diag::Authentication::VerifyOwnership method** *[*If the method called in [[SWS_DM_01240](#_bookmark152)] returns any of the defined error codes in [SWS_DM_01128], the Diagnostic Server instance shall return a Negtive Response with NRC equal to the returned error code.*♩(RS_Diag_04251)*

> 如果在[[SWS_DM_01240](#_bookmark152)]中调用的方法返回[SWS_DM_01128]中定义的任何错误代码，则诊断服务器实例应返回NRC等于返回的错误代码的负响应。(RS_Diag_04251)


**[SWS_DM_01242]**{DRAFT} **Handling unspecified negative return values of ara::diag::Authentication::VerifyOwnership method** *[*If the method called in [[SWS_DM_01240](#_bookmark152)] returns any error code other than the defined error codes in [SWS_DM_01128], the Diagnostic Server instance shall return a Negative Response with NRC equal to 0x10 (generalReject).*♩(RS_Diag_04251)*

> **[SWS_DM_01242]**{草案} **处理ara :: diag :: Authentication :: VerifyOwnership方法的未指定的负返回值** *[*如果在[[SWS_DM_01240](#_bookmark152)]中调用的方法返回的任何错误代码都不是[SWS_DM_01128]中定义的错误代码，则诊断服务器实例将返回具有NRC等于0x10（generalReject）的负响应。*♩(RS_Diag_04251)*


**[SWS_DM_01243]**{DRAFT} **Successful verification of Client proofOfOwnership** *[*If the method called in [[SWS_DM_01240](#_bookmark152)] executes successfully and returns no eror code, the Diagnostic Server instance shall return a Positive Response to the tester. The fields lengthOfSessionKeyInfo (LOSKI), shall be derived by the Dianostic Server instance from the returned SessionKeyInfo and filled in the Poitive Response The Diagnostic Server instance shall copy the returned SesionKeyInfo into the response field sessionKeyInfo (SKI). The Diagnostic Server instance shall set the parameter authenticationReturnParameter (RV) to 0x12 (OwershipVerified,AuthenticationComplete) in the positive Response.*♩(RS_Diag_04251)*

> 如果在[[SWS_DM_01240](#_bookmark152)]中调用的方法执行成功并且没有返回错误代码，诊断服务器实例将向测试人员返回正面回应。字段lengthOfSessionKeyInfo（LOSKI）将由诊断服务器实例从返回的SessionKeyInfo中派生，并填入正面回应中。诊断服务器实例将将返回的SesionKeyInfo复制到响应字段sessionKeyInfo（SKI）中。诊断服务器实例将参数authenticationReturnParameter（RV）设置为0x12（OwershipVerified，AuthenticationComplete），以在正面回应中。♩（RS_Diag_04251）


Once a positive or negative response has been sent to the tester for a proofOfOwneship sub-function request, the authentication sequence shall be deemed to be coplete, by the Diagnostic Server instance. A new authentication sequence must be started with a verifyCertificateUnidirectional or verifyCertificateBidirectional sub function request.

> 一旦对ProofOfOwneship子功能请求发送了正面或负面回复，诊断服务器实例即视为认证序列已完成。必须通过verifyCertificateUnidirectional或verifyCertificateBidirectional子功能请求启动新的认证序列。

### DeAuthenticate


[]{#_bookmark154 .anchor}**[SWS_DM_01244]**{DRAFT} **Processing the deAuthenticate request** *[*On reception of an Authentication (0x29) service with sub-function equal to deAuthenticate, if all checks described in [[SWS_DM_00096](#_bookmark88)] are successfully completed, the Diagnostic Server instance shall perform the steps described in [[SWS_DM_01212](#_bookmark80)].*♩(RS\Diag_04251)*

> 当接收到子功能等于取消认证的认证（0x29）服务时，如果按照[[SWS_DM_00096](#_bookmark88)]中描述的所有检查都成功完成，诊断服务器实例应执行[[SWS_DM_01212](#_bookmark80)]中描述的步骤。♩（RS\Diag_04251）


**[SWS_DM_01245]**{DRAFT} **Successful completion of deAuthenticate** *[*If the rquirement in [[SWS_DM_01244](#_bookmark154)] is executed successfully, the Diagnostic Server instance shall return a Positive Response to the tester. The Diagnostic Server instance shall set the parameter authenticationReturnParameter (RV) to 0x10 (Deauthentication Successful) in the positive Response.*♩(RS_Diag_04251)*

> **[SWS_DM_01245]**{草案} **DeAuthenticate 成功完成** *[*如果[[SWS_DM_01244](#_bookmark154)]中的要求执行成功，则诊断服务器实例将向测试人员发送正面响应。诊断服务器实例将在正面响应中将参数authenticationReturnParameter (RV)设置为0x10（认证成功）。*♩（RS_Diag_04251）*

简体中文：**[SWS_DM_01245]**{草案} **取消认证成功完成** *[*如果[[SWS_DM_01244](#_bookmark154)]中的要求执行成功，则诊断服务器实例将向测试人员发送正面响应。诊断服务器实例将在正面响应中将参数authenticationReturnParameter (RV)设置为0x10（取消认证成功）。*♩（RS_Diag_04251）*

### AuthenticationConfiguration


**[SWS_DM_01246]**{DRAFT} **Processing the authenticationConfiguration request** *[*On reception of an Authentication (0x29) service with sub-function equal to autheticationConfiguration, if all checks described in [[SWS_DM_00096](#_bookmark88)] are successfully completed, the Diagnostic Server instance shall return a positive response. The Diagnostic Server instance shall set the parameter authenticationReturParameter (RV) to 0x02 (AuthenticationConfiguration APCE) in the positive Response.*♩ (RS_Diag_04251)*

> 当接收到具有子功能等于AuthenticationConfiguration的认证（0x29）服务时，如果所有检查都按照[[SWS_DM_00096]（#_bookmark88）]中描述的成功完成，诊断服务器实例将返回正面回应。诊断服务器实例将在正面响应中将authenticationReturParameter（RV）参数设置为0x02（AuthenticationConfiguration APCE）。（RS_Diag_04251）

### TransmitCertificate


[]{#_bookmark157 .anchor}**[SWS_DM_01247]**{DRAFT} **Validation of the transmitCertificate certificateEvalationId** *[*On reception of an Authentication (0x29) service with sub-function equal to transmitCertificate, if all checks described in [[SWS_DM_00096](#_bookmark88)] are successfully copleted, the Diagnostic Server instance shall validate if the received request prameter certificateEvaluationId (CEID) is supported by the DiagnosticAuthTransmitCetificate.DiagnosticAuthCertificateEvaluation.evaluationId configuration. If the paramter is not supported, the Diagnostic Server instance shall send a Negative Rsponse with NRC 0x31 (Request outOfRange).*♩(RS_Diag_04251)*

> 当收到以传输证书为子功能的认证（0x29）服务时，如果所有在[[SWS_DM_00096](#_bookmark88)]中描述的检查都成功完成，诊断服务器实例将验证接收到的请求参数certificateEvaluationId（CEID）是否由DiagnosticAuthTransmitCetificate.DiagnosticAuthCertificateEvaluation.evaluationId配置支持。如果参数不受支持，诊断服务器实例将发送带有NRC 0x31（请求超出范围）的负响应。♩（RS_Diag_04251）


[]{#_bookmark158 .anchor}**[SWS_DM_01248]**{DRAFT} **Processing the transmitCertificate request** *[*If the checks described in [[SWS_DM_01247](#_bookmark157)] are successfully completed, the Diagnotic Server instance shall call the method ara::diag::Authentication::TransmitCertificate of the class ara::diag::Authentication. The Dagnostic Server instance shall pass the received certificateData (CEDA) in the parameter CertificateData of the method.*♩(RS_Diag_04251)*

> 如果成功完成了[[SWS_DM_01247](#_bookmark157)]中描述的检查，诊断服务器实例应调用ara :: diag :: Authentication :: TransmitCertificate类的方法。诊断服务器实例应将接收到的证书数据（CEDA）传递给方法的CertificateData参数（RS_Diag_04251）。


**[SWS_DM_01249]**{DRAFT} **Handling Negative return values of ara::diag::Authentication::TransmitCertificate method** *[*If the method called in [[SWS_DM_01248](#_bookmark158)] returns any of the defined error codes in [SWS_DM_01129], the Diagnostic Server instance shall return a Negative Response with NRC equal to the returned error code.*♩(RS_Diag_04251)*

> 如果在[[SWS_DM_01248](#_bookmark158)]中调用的方法返回[SWS_DM_01129]中定义的任何错误代码，则诊断服务器实例应返回NRC等于返回的错误代码的负响应。(RS_Diag_04251)


**[SWS_DM_01250]**{DRAFT} **Handling unspecified negative return values of ara::diag::Authentication::TransmitCertificate method** *[*If the method called in [[SWS_DM_01248](#_bookmark158)] returns any error code other than the defined error codes in [SWS_DM_01129], the Diagnostic Server instance shall return a Negative Response with NRC equal to 0x10 (generalReject).*♩(RS_Diag_04251)*

> 如果在[[SWS_DM_01248](#_bookmark158)]中调用的方法返回的错误代码不是[SWS_DM_01129]中定义的错误代码，诊断服务器实例应当返回一个NRC等于0x10（generalReject）的负响应。


**[SWS_DM_01251]**{DRAFT} **Successful verification of transmitCertificate** *[*If the method called in [[SWS_DM_01248](#_bookmark158)] executes successfully and returns no error code, the Diagnostic Server instance shall return a Positive Response to the tester. The Diagnostic Server instance shall set the parameter authenticationReturParameter (RV) to 0x13 (CertificateVerified) in the positive Response.*♩(RS_Diag\04251)*

> **[SWS_DM_01251]**{草案} **传输证书验证成功** *[*如果在[[SWS_DM_01248](#_bookmark158)]中调用的方法成功执行并且没有返回错误代码，诊断服务器实例应向测试人员返回正面回应。诊断服务器实例应在正面回应中将参数authenticationReturParameter（RV）设置为0x13（CertificateVerified）。*♩(RS_Diag\04251)*

### Service 0x2A ReadDataByPeriodicIdentifier


The processing of a UDS Service ReadDataByPeriodicIdentifier (0x2A) is described in ISO 14229-1[[1](#_bookmark8)]. On processing, the Diagnostic Server instance needs to peform various checks. The following requirements determine the relation between the input data to be checked and the configuration provided to the Diagnostic Server instance via DEXT parameters.

> 处理UDS服务ReadDataByPeriodicIdentifier（0x2A）的过程在ISO 14229-1[[1]]（#_bookmark8）中有描述。在处理过程中，诊断服务器实例需要执行各种检查。以下要求确定了输入数据与通过DEXT参数提供给诊断服务器实例的配置之间的关系。


**[SWS_DM_01040]**{DRAFT} **Realization of UDS service ReadDataByPeriodicIdetifier(0x2A)** *[*The Diagnostic Server instance shall implement the diagnostic

> **[SWS_DM_01040]**{草稿} **实现UDS服务ReadDataByPeriodicIdetifier(0x2A)** *[*诊断服务器实例应实现诊断


service 0x2A ReadDataByPeriodicIdentifier according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag\04215)*

> 服务 0x2A 根据 ISO 14229-1[[1](#_bookmark8)]定期读取数据*♩(RS_Diag\04215)*


**[SWS_DM_01041]**{DRAFT} **Check requested number of periodic DataIdentifiers** *[*If the DM receives the UDS Service ReadDataByPeriodicIdentifier (0x2A) and the number of the requested PeriodicDataIdentifiers is larger than DiagnosticReaDataByPeriodicIDClass.maxPeriodicDidToRead, the DM shall return NRC 0x13 (incorrectMessageLengthOrInvalidFormat).*♩(RS_Diag_04215)*

> 如果DM收到UDS服务ReadDataByPeriodicIdentifier（0x2A），且所请求的PeriodicDataIdentifiers数量大于DiagnosticReaDataByPeriodicIDClass.maxPeriodicDidToRead，DM应返回NRC 0x13（incorrectMessageLengthOrInvalidFormat）。


**[SWS_DM_01042]**{DRAFT} **Minimum length check for ReadDataByPeriodicIdetifier** *[*On reception of the UDS Service ReadDataByPeriodicIdentifier (0x2A), the DM shall check the request minimum length. If length of the request is less than 3 bytes for subfunctions different to 'stopSending' or less than 2 bytes, the DM shall respond with NRC 0x13 (incorrectMessageLengthOrInvalidFormat).*♩(RS_Diag_04215)*

> 当收到UDS服务ReadDataByPeriodicIdentifier（0x2A）时，DM应检查请求的最小长度。如果请求的长度小于子功能不同于“stopSending”的3字节或小于2字节，DM应回复NRC 0x13（incorrectMessageLengthOrInvalidFormat）。


**[SWS_DM_01043]**{DRAFT} **Check supported periodic DataIdentifier** *[*On recetion of the UDS Service ReadDataByPeriodicIdentifier (0x2A), the DM shall consider a requested PeriodicDataIdentifier as supported if and only if there exists a DiagnostiDataIdentifier in the range between 0xF200 and 0xF2FF with id matching the PerioicDataIdentifier. If none of the requested Periodic DIDs are supported, the DM shall respond with NRC 0x31 (requestOutOfRange).*♩(RS_Diag_04215)*

> **[SWS_DM_01043]**{草稿}**检查支持的周期数据标识符** *[*当收到UDS服务ReadDataByPeriodicIdentifier（0x2A）时，DM只有在范围0xF200到0xF2FF内存在与PerioicDataIdentifier匹配的DiagnostiDataIdentifier时，才认为请求的PeriodicDataIdentifier是受支持的。如果所请求的Periodic DID都不受支持，DM应响应NRC 0x31（请求超出范围）。*♩(RS_Diag_04215)*

简体中文：**[SWS_DM_01043]**{草案}**检查支持的周期数据标识符** *[*当接收到UDS服务ReadDataByPeriodicIdentifier（0x2A）时，DM只有在范围0xF200到0xF2FF内存在与PerioicDataIdentifier匹配的DiagnostiDataIdentifier时，才认为请求的PeriodicDataIdentifier是受支持的。如果所请求的Periodic DID都不受支持，DM应响应NRC 0x31（请求超出范围）。*♩(RS_Diag_04215)*


**[SWS_DM_01044]**{DRAFT} **Check Transmission Mode** *[*On reception of the UDS Service ReadDataByPeriodicIdentifier (0x2A) and if the requested transmission mode is different to a configured DiagnosticPeriodicRate.periodicRateCategory or to 'stopSending' , the DM shall respond with NRC 0x31 (requestOutOfRange).*♩(RS\Diag_04215)*

> **[SWS_DM_01044]**{草案} **检查传输模式** *[*接收到UDS服务ReadDataByPeriodicIdentifier（0x2A）时，如果所请求的传输模式与配置的DiagnosticPeriodicRate.periodicRateCategory不同，或者为“stopSending”，则DM应响应NRC 0x31（请求超出范围）。*♩（RS \ Diag_04215）*


**[SWS_DM_01045]**{DRAFT} **Check Scheduler Availability** *[*If the UDS Service ReaDataByPeriodicIdentifier (0x2A) with transmissionMode different than 0x04 'stopSening' is received, and the number existing PDIDs and the new PDIDs from the request is larger than DiagnosticReadDataByPeriodicIDClass.schedulerMaxNumber , the DM shall respond with NRC 0x31(requestOutOfRange).*♩(RS_Diag_04215)*

> **[SWS_DM_01045]**{草案} **检查调度器可用性** *[*如果收到传输模式不为0x04 ‘stopSening’ 的UDS服务ReaDataByPeriodicIdentifier (0x2A)，并且现有PDID和请求中的新PDID数量大于DiagnosticReadDataByPeriodicIDClass.schedulerMaxNumber，DM应响应NRC 0x31（请求超出范围）。*♩(RS_Diag_04215)*


[]{#_bookmark160 .anchor}**[SWS_DM_01046]**{DRAFT} **Check supported DataIdentifier in active session** *[*On reception of the UDS Service ReadDataByPeriodicIdentifier (0x2A) with transmissioMode different than 'stopSending', a requested Periodic DataIdentifier shall be cosidered as supported if and only if the active session passes the execution pemission check according to [[SWS_DM_00413](#_bookmark139)] else process next periodic DID. If Session not supported for none of the periodic DIDs DM shall respond with NRC 0x31(requestOutOfRange).*♩(RS_Diag_04215)*

> 当收到UDS服务ReadDataByPeriodicIdentifier（0x2A），其传输模式不是“stopSending”时，如果活动会话通过根据[SWS_DM_00413]（#_bookmark139）的执行权限检查，则请求的周期数据标识符被视为受支持，否则处理下一个周期DID。如果会话对所有周期DID都不受支持，DM应响应NRC 0x31（requestOutOfRange）。♩（RS_Diag_04215）


[]{#_bookmark161 .anchor}**[SWS_DM_01047]**{DRAFT} **Check supported DataIdentifier on active security level** *[*On reception of the UDS Service ReadDataByPeriodicIdentifier (0x2A) with transmission-Mode different than stopSending, a requested PeriodicDataIdentifier shall be considered as supported on active security level if and only if the DataIdentfier the active security level passes the execution permission check according to [[SWS_DM_00414](#_bookmark140)] else the DM shall respond with NRC 0x33 (securityAccessDenied).*♩ (RS_Diag_04215)*

> 当收到UDS服务ReadDataByPeriodicIdentifier（0x2A），传输模式不是stopSending时，如果活动安全级别的数据标识符通过执行权限检查，则请求的周期性数据标识符将被视为在活动安全级别上支持，否则DM将以NRC 0x33（securityAccessDenied）响应。（RS_Diag_04215）


[]{#_bookmark162 .anchor}**[SWS_DM_01048]**{DRAFT} **Check DataIdentifier for environmental conditions** *[*On reception of the UDS Service ReadDataByPeriodicIdentifier (0x2A) with transmissioMode different than stopSending, a requested PeriodicDataIdentifier shall be consiered as supported if and only if the DataIdentifiers environmentalCondition allow an execution according to [[SWS_DM_00112](#_bookmark99)] else the DM shall respond with the NRC acording to [[SWS_DM_00289](#_bookmark103)].*♩(RS_Diag_04215)*

> 当接收到传输模式不是停止发送的UDS服务ReadDataByPeriodicIdentifier（0x2A）时，如果请求的PeriodicDataIdentifier的DataIdentifiers环境条件允许按照[SWS_DM_00112]（#_bookmark99）执行，则认为该数据标识符受支持，否则DM应按照[SWS_DM_00289]（#_bookmark103）响应NRC。♩（RS_Diag_04215）


**[SWS_DM_01049]**{DRAFT} **Checks Dynamically Defined DIDs in ReadDataByPriodicIdentifier** *[*If DiagnosticDynamicallyDefineDataIdentifierClass. checkPerSourceId is set to true and the UDS Service ReadDataByPeriodicIdentifier (0x2A) is received with transmissioMode different than stopSending, if verification has been successfully done according to [[SWS_DM_01046](#_bookmark160)], [[SWS_DM_01047](#_bookmark161)] and [[SWS_DM_01048](#_bookmark162)] and if the request contains one or more dynamically defined DID(s), the DM shall do the session, security checks and environmental condition checks for all source data.*♩(RS_Diag_04215)*

> **[SWS_DM_01049]**{草稿} **检查通过周期性标识符读取数据时的动态定义的数据标识符** *[*如果DiagnosticDynamicallyDefineDataIdentifierClass. checkPerSourceId被设置为true，并且收到UDS服务ReadDataByPeriodicIdentifier (0x2A)，传输模式与stopSending不同，如果根据[[SWS_DM_01046](#_bookmark160)], [[SWS_DM_01047](#_bookmark161)]和[[SWS_DM_01048](#_bookmark162)]成功地完成了验证，并且如果请求包含一个或多个动态定义的DID，DM应该为所有源数据进行会话，安全检查和环境条件检查。*♩(RS_Diag_04215)*

简体中文：**[SWS_DM_01049]**{草案} **检查通过周期性标识符读取数据时的动态定义的数据标识符** *[*如果DiagnosticDynamicallyDefineDataIdentifierClass.checkPerSourceId设置为true，并且收到UDS服务ReadDataByPeriodicIdentifier（0x2A），传输模式不同于stopSending，如果根据[[SWS_DM_01046](#_bookmark160)], [[SWS_DM_01047](#_bookmark161)]和[[SWS_DM_01048](#_bookmark162)]成功地完成了验证，并且如果请求包含一个或多个动态定义的DID，DM应该为所有源数据进行会话，安全检查和环境条件检查。*♩(RS_Diag_04215)*


**[SWS_DM_01050]**{DRAFT} **Periodic DID length check** *[*On reception of the UDS Service ReadDataByPeriodicIdentifier (0x2A) with transmission-Mode different than stopSending, the DM shall check if the length of each requested PeriodiDataIdentifier is smaller or equal than the value provided by the periodic tranmission handler ara::diag::uds_transport::UdsTransportProtocolPerodicHandler::GetMaxPayloadLength and if the size is exceeded for one or more PeriodicDataIdentifier, the DM shall return NRC 0x14 (responseTooLong).*♩(RS_Diag\04215)*

> 当接收到UDS服务ReadDataByPeriodicIdentifier（0x2A）并且传输模式不是stopSending时，DM应检查每个请求的PeriodiDataIdentifier长度是否小于或等于由定期传输处理程序ara :: diag :: uds_transport :: UdsTransportProtocolPerodicHandler :: GetMaxPayloadLength提供的值，如果一个或多个PeriodicDataIdentifier的大小超过了，DM应返回NRC 0x14（responseTooLong）。♩（RS_Diag\04215）


**[SWS_DM_01051]**{DRAFT} **DM behavior on transmission Mode stopSending without periodicDataIdentifier in the request** *[*On reception of the UDS Service ReadDataByPeriodicIdentifier (0x2A) with transmissionMode set to 'stopSending' and no periodicDataIdentifier in the request, the DM shall stop all scheduled periodiDataIdentifier transmissions.*♩(RS_Diag_04215)*

> 在收到UDS服务ReadDataByPeriodicIdentifier（0x2A），其中传输模式设置为“stopSending”，而请求中没有periodicDataIdentifier时，DM应停止所有计划的periodiDataIdentifier传输。


**[SWS_DM_01052]**{DRAFT} **DM behavior on transmission Mode stopSending with supported periodicDataIdentifier in the request** *[*On reception of the UDS Service ReadDataByPeriodicIdentifier (0x2A) with transmissionMode set to 'stopSending' and more than one supported periodicDataIdentifier is in the request, the DM shall stop the supported scheduled periodic data transmissions for all requested periodicDataIdentfiers.*♩(RS_Diag_04215)*

> 当接收到UDS服务ReadDataByPeriodicIdentifier（0x2A），其传输模式设置为“停止发送”，且请求中包含多个支持的周期数据标识符时，DM应停止所有请求的定期数据传输的支持定期传输。


**[SWS_DM_01053]**{DRAFT} **DM behavior on transmission Mode stopSending with not supported periodicDataIdentifier in the request** *[*On reception of the UDS Sevice ReadDataByPeriodicIdentifier (0x2A) with transmissionMode set to 'stopSending' and none of the periodicDataIdentifiers of the request is supported, the DM shall return NRC 0x31 (requestOutOfRange).*♩(RS_Diag_04215)*

> **[SWS_DM_01053]**{草案} **在请求中使用不支持的周期数据标识符时，DM的传输模式stopSending的行为** *[*接收到设置为“stopSending”的UDS服务ReadDataByPeriodicIdentifier（0x2A），但请求中的周期数据标识符都不受支持时，DM应返回NRC 0x31（请求超出范围）。*♩（RS_Diag_04215）*

简体中文：**[SWS_DM_01053]**{草案} **在请求中使用不支持的周期数据标识符时，DM的传输模式stopSending的行为** *[*接收到设置为“stopSending”的UDS服务ReadDataByPeriodicIdentifier（0x2A），但请求中的周期数据标识符都不受支持时，DM应返回NRC 0x31（请求超出范围）。*♩（RS_Diag_04215）*


**[SWS_DM_01054]**{DRAFT} **Starting to transmit PDIDs after positive response** *[*After the positive response of the UDS Service ReadDataByPeriodicIdentifier (0x2A) with transmissionMode different than stopSending was sent, the DM shall start to send the periodic DIDs.*♩(RS_Diag_04215)*

> **[SWS_DM_01054]**{草案} **在收到积极响应后开始传输PDID** *[*在发送UDS服务ReadDataByPeriodicIdentifier（0x2A）并且传输模式不是stopSending的积极响应后，DM应该开始发送周期性的DID。*♩（RS_Diag_04215）*

简体中文：**[SWS_DM_01054]**{草案}**收到积极响应后开始传输PDID** *[*发送UDS服务ReadDataByPeriodicIdentifier（0x2A），传输模式不是stopSending的积极响应后，DM应开始发送周期性的DID。*♩（RS_Diag_04215）*


**[SWS_DM_01055]**{DRAFT} **Reaction on ApplicationError** *[*If an external processor to read the DID data raises an error of ara::diag::DiagUdsNrcErrorDomain, the DM shall skip the scheduled periodic response for the periodic DataIdentifier.*♩(RS\Diag_04215)*

> **[SWS_DM_01055]**{草案} **对应用程序错误的反应** *[*如果一个外部处理器读取DID数据引发ara::diag::DiagUdsNrcErrorDomain的错误，DM应该跳过定期数据标识符的定期响应。*♩（RS\ Diag_04215）*


**[SWS_DM_01056]**{DRAFT} **Optional condition checks for sending periodic DIDs** *[*If DiagnosticDynamicallyDefineDataIdentifierClass.checkPeSourceId is set to TRUE, the DM shall transmit the PDID only if the session, security and mode checks were executed successfully.*♩(RS_Diag_04215)*

> **[SWS_DM_01056]**{草案} **定期发送DID的可选条件检查** *[*如果DiagnosticDynamicallyDefineDataIdentifierClass.checkPeSourceId设置为TRUE，则DM仅在会话、安全和模式检查成功后才传输PDID。*♩(RS_Diag_04215)*


**[SWS_DM_01057]**{DRAFT} **Optional stopping PDIDs after session change** *[*If DagnosticDynamicallyDefineDataIdentifierClass.checkPerSourceId is set to TRUE and the DM is changing the diagnostic session, the DM shall remove all PDIDs from the list of scheduled PDIDs that are not allowed to be read in the new session.*♩(RS_Diag_04215)*

> 如果DagnosticDynamicallyDefineDataIdentifierClass.checkPerSourceId设置为TRUE，且DM正在更改诊断会话，DM应从计划的PDID列表中删除所有在新会话中不允许读取的PDID。


**[SWS_DM_01058]**{DRAFT} **Optional stopping PDIDs after security level change** *[*If DiagnosticDynamicallyDefineDataIdentifierClass.checPerSourceId is set to TRUE and the DM is changing the security level session, the DM shall remove all PDIDs from the list of scheduled PDIDs that are not allowed to be read in the new security level.*♩(RS_Diag_04215)*

> 如果DiagnosticDynamicallyDefineDataIdentifierClass.checPerSourceId设置为TRUE，并且DM正在更改安全级别会话，则DM应从计划PDID列表中删除不允许在新安全级别中读取的所有PDID。


**[SWS_DM_01059]**{DRAFT} **No periodic DIDs in default session** *[*When the dianostic session changes to or is in the DefaultSession, the DM shall stop all scheduled periodic DIDs.*♩(RS_Diag_04215)*

> 当诊断会话更改为或处于默认会话时，DM应停止所有计划的定期DID。

### Scheduler Periodic Transmission


ISO 14229-1[[1](#_bookmark8)] defines two distinct scheduler types for ReadDataByPeriodicIdentfier. The DM uses only scheduler type 1 as transmission strategy and NumPerodicAddr is identical to DiagnosticReadDataByPeriodicIDClass.scheduleMaxNumber. This means that with each scheduler call, all the configured PDIDs for that scheduler rate are transmitted.

> ISO 14229-1[[1](#_bookmark8)]定义了两种不同的调度器类型用于ReadDataByPeriodicIdentfier。DM仅使用调度器类型1作为传输策略，NumPerodicAddr与DiagnosticReadDataByPeriodicIDClass.scheduleMaxNumber相同。这意味着每次调度调用，所有配置的PDID都会被传输。


**[SWS_DM_01060]**{DRAFT} **Support of Scheduler type 1** *[*The DM shall support the scheduling of PDIDs based on scheduler type 1 as defined in ISO 14229-1[[1](#_bookmark8)].*♩(RS\Diag_04215)*

> **[SWS_DM_01060]**{草稿} **支持类型1调度器** *[*DM应按照ISO 14229-1[[1](#_bookmark8)]中定义的类型1调度器来调度PDID。*♩（RS\Diag_04215）*


**[SWS_DM_01061]**{DRAFT} **Trigger all scheduled PDIDs per scheduler** *[*When a periodic scheduler elapses for a requested transmission rate, the DM shall trigger the transmission of all scheduled PDIDs assigned to this transmission rate.*♩(RS_Diag\04215)*

> 当定期调度程序为请求的传输速率终止时，DM应触发分配给此传输速率的所有计划PDID的传输。（RS_Diag\04215）


**[SWS_DM_01062]**{DRAFT} **Transmission of all PDIDs on the periodic connection** *[*If the PDID transmission is triggered for a requested transmission rate, the DM shall transmit all PDIDs on the periodic transmission on the periodic connection starting with the first PDID in the list of scheduled PDIDs.*♩(RS_Diag_04215)*

> **[SWS_DM_01062]**{草案} **定期连接上的所有PDID的传输** *[*如果触发了PDID传输，为了请求的传输速率，DM应在定期传输开始时，在定期连接上传输所有PDID，从计划PDID列表中的第一个PDID开始。*♩(RS_Diag_04215)*


**[SWS_DM_01063]**{DRAFT} **Transmission error behavior** *[*In case of a PDID tranmission error, the DM shall use always the same order of periodicDIDs per client. Tranmission errors shall not influence this order, the DM shall continue to retry the tranmission and start the next PDID only after the PDID was transmitted successfully.*♩ (RS_Diag_04215)*

> **[SWS_DM_01063]**{草稿} **传输错误行为** *[*如果发生PDID传输错误，DM应始终使用相同的客户端周期性DID顺序。传输错误不应影响此顺序，DM应继续重试传输，并仅在PDID成功传输后才开始下一个PDID。*♩（RS_Diag_04215）*

### Service 0x2C DynamicallyDefineDataIdentifier [SWS_DM_01070] {DRAFT} Support of UDS service 0x2C in Adaptive AUTOSAR


**DM** *[*The Diagnostic Server instance shall implement the diagnostic service

> 诊断服务器实例应实现诊断服务


0x2C DynamicallyDefineDataIdentifier with subfunctions 0x01 (defineByIdentifier) and 0x03 (clearDynamicallyDefinedDataIdentifier) according to ISO 14229-1[[1](#_bookmark8)].*♩(RS\Diag_04246)*

> 0x2C 根据ISO 14229-1[[1](#_bookmark8)]动态定义数据标识符，具有子功能0x01（按标识符定义）和0x03（清除动态定义的数据标识符）。♩(RS\Diag_04246)


The support of subfunction 0x02 (defineByMemoryAddress) is not appropriate in an AUTOSAR Adaptive system. These systems have mostly more virtual address spaces. Therefore, this subfunction is not supported.

> 不适用于AUTOSAR Adaptive系统的子功能0x02（defineByMemoryAddress）的支持。这些系统大多具有更多的虚拟地址空间。因此，不支持此子功能。


All testers share the same DDID. In default session the last defined DDID will be used. The client can switch to a non-default session ensure that no other testers interfere with it's DDIDs.

> 所有测试人员共享相同的DDID。在默认会话中，将使用最后定义的DDID。客户端可以切换到非默认会话，以确保没有其他测试人员干扰其DDID。


**[SWS_DM_01071]**{DRAFT} **No persistency of defined DDIDs** *[*If DiagnosticDnamicallyDefineDataIdentifierClass.configurationHandling is set to volatile, the DM shall initialize all DDIDs as not present at DM Initialization.*♩(RS_Diag\04246)*

> **[SWS_DM_01071]**{草案} **定义的 DDID 无持久性** *[*如果DiagnosticDnamicallyDefineDataIdentifierClass.configurationHandling设置为易失性，DM 在 DM 初始化时应将所有 DDID 初始化为不存在。*♩(RS_Diag\04246)*


**[SWS_DM_01072]**{DRAFT} **Persistency of defined DDIDs** *[*If DiagnosticDynaicallyDefineDataIdentifierClass.configurationHandling is set to noVolatile, the DM shall persist DDIDs configured by the UDS service 0x2C and restore the DDDID definition from Non-Volatile Memory at DM Initialization.*♩(RS_Diag_04246)*

> **[SWS_DM_01072]**{草案}**定义的DDID的持久性** *[*如果DiagnosticDynaicallyDefineDataIdentifierClass.configurationHandling设置为noVolatile，DM应持久化由UDS服务0x2C配置的DDID，并在DM初始化时从非易失性存储器恢复DDDID定义。*♩(RS_Diag_04246)*


**[SWS_DM_01073]**{DRAFT} **DM behavior for subfunction 'defineByIdentifier'** *[*On reception of service 'DynamicallyDefineDataIdentifier' with subfunction 'defineByIdentfier' the DM shall activate this new DID and append the associated information received from the diagnostic request: DID source, position and size.*♩(RS_Diag_04246)*

> **[SWS_DM_01073]**{草案} **子功能“defineByIdentifier”的DM行为** *[*收到具有子功能“defineByIdentfier”的服务“DynamicallyDefineDataIdentifier”时，DM应激活此新DID并附加从诊断请求接收的相关信息：DID源，位置和大小。*♩（RS_Diag_04246）*


**[SWS_DM_01074]**{DRAFT} **Only static DIDs as sourceDataIdentifier** *[*If the DM is receiving the service 'DynamicallyDefineDataIdentifier' with subfunction 'defineByIdetifier' and one or more of the sourceDataIdentifier are itself a active dynamically defined data identifier, the DM shall return an NRC 0x31 (requestOutOfRange).*♩(RS_Diag\04246)*

> **[SWS_DM_01074]**{草案} **仅使用静态 DID 作为源数据标识符** *[*如果 DM 接收到服务 'DynamicallyDefineDataIdentifier' 的子功能 'defineByIdetifier' 并且其中一个或多个源数据标识符本身是一个活动的动态定义的数据标识符，DM 应返回 NRC 0x31（请求超出范围）。*♩(RS_Diag\04246)*


**[SWS_DM_01075]**{DRAFT} **Maximum number of sourceDataIdentifiers in the rquest** *[*If the DM receives the UDS service 'DynamicallyDefineDataIdentifier' (0x2C) and the number of sourceDataIdentifiers in the request is larger than the configured DianosticDynamicallyDefineDataIdentifier.maxSourceElement, the DM shall send NRC 0x31 (requestOutOfRange).*♩(RS_Diag_04246)*

> **[SWS_DM_01075]**{草稿} **请求中的源数据标识符的最大数量** *[*如果DM接收到UDS服务'DynamicallyDefineDataIdentifier'（0x2C），而请求中的源数据标识符数量大于配置的DianosticDynamicallyDefineDataIdentifier.maxSourceElement，DM应发送NRC 0x31（requestOutOfRange）。*♩(RS_Diag_04246)*


**[SWS_DM_01076]**{DRAFT} **Clearing all configured DDIDs** *[*On reception of sevice 'DynamicallyDefineDataIdentifier' with subfunction 0x03 clearDynamicallyDefineDataIdentifier and no dynamicallyDefinedDataIdentifier in the request, the DM shall clear all the configured DDIDs.*♩(RS_Diag_04246)*

> **[SWS_DM_01076]**{草稿} **清除所有配置的DDID** *[*在接收到具有子功能0x03 clearDynamicallyDefineDataIdentifier和请求中无动态定义的数据标识符的服务'DynamicallyDefineDataIdentifier'后，DM应清除所有配置的DDID。*♩（RS_Diag_04246）*


**[SWS_DM_01077]**{DRAFT} **Clearing individual configured DDIDs** *[*On reception of service 'DynamicallyDefineDataIdentifier' with subfunction 0x03 clearDynamicallyDfinedDataIdentifier and one ore more dynamicallyDefinedDataIdentifier in the request, the DM shall clear all the DDIDs from the request.*♩(RS_Diag_04246)*

> **[SWS_DM_01077]**{草稿} **清除个人配置的DDID** *[*当接收到具有子功能0x03 clearDynamicallyDfinedDataIdentifier以及请求中一个或多个dynamicallyDefinedDataIdentifier的服务“DynamicallyDefineDataIdentifier”时，DM应从请求中清除所有DDID。*♩(RS_Diag_04246)*


A cleared DDIDs is considered as not configured. A request to read such a DDID is treated in the same way as a request to a static DID that is not configured.

> 清除的DDID被视为未配置。 对这种DDID的读取请求与对未配置的静态DID的请求一样处理。


**[SWS_DM_01078]**{DRAFT} **Clear DDIDs on session change** *[*If DiagnosticDnamicallyDefineDataIdentifierClass.checkPerSourceId is set to true and a diagnostic session change occurs, the DM shall clear all defined DDIDs that have sourceDataIdentifiers that are no longer supported in the new session and security level.*♩(RS_Diag_04246)*

> 如果DiagnosticDnamicallyDefineDataIdentifierClass.checkPerSourceId被设置为true，并且发生诊断会话更改，DM应清除所有已定义的DDID，其中sourceDataIdentifiers在新会话和安全级别中不再受支持。


**[SWS_DM_01079]**{DRAFT} **Session check for DDID** *[*On reception of service 'DnamicallyDefineDataIdentifier' with subfunction 'defineByIdentifier', the DM shall check if the DDID can be defined in the current session according to [[SWS_DM_00413](#_bookmark139)]. If the DDID cannot be defined in the current session, the DM shall return an NRC 0x31 (requestOutOfRange).*♩(RS_Diag_04246)*

> **[SWS_DM_01079]**{草案} **会话检查为DDID** *[*接收到服务“DnamicallyDefineDataIdentifier”，具有子功能“defineByIdentifier”时，DM应检查DDID是否可以根据[[SWS_DM_00413](#_bookmark139)]在当前会话中定义。如果DDID无法在当前会话中定义，DM应返回NRC 0x31（requestOutOfRange）。*♩（RS_Diag_04246）*


**[SWS_DM_01080]**{DRAFT} **Security level check for DDID** *[*On reception of sevice 'DynamicallyDefineDataIdentifier' with subfunction 'defineByIdentifier', the DM shall check if the DDDID can be defined in the security level according to [[SWS_DM_00414](#_bookmark140)]. If the DDID cannot be defined in the current security level, the DM shall return an NRC 0x31 (requestOutOfRange).*♩(RS_Diag_04246)*

> **[SWS_DM_01080]**{草稿} **DDID安全级别检查** *[*收到服务“DynamicallyDefineDataIdentifier”的子功能“defineByIdentifier”时，DM应检查DDID是否可以根据[[SWS_DM_00414](#_bookmark140)]定义在安全级别中。如果DDID无法在当前安全级别中定义，则DM应返回NRC 0x31（requestOutOfRange）。*♩(RS_Diag_04246)*


**[SWS_DM_01081]**{DRAFT} **Session check for sourceDataIdentifier** *[*On rception of service 'DynamicallyDefineDataIdentifier' with subfunctiondefineByIdentfier and if DiagnosticDynamicallyDefineDataIdentifierClass.checkPeSourceId is set to true, the DM shall check if the sourceDataIdentifier can be defined in the current session according to [[SWS_DM_00413](#_bookmark139)]. If the DDID cannot be defined in the current session, the DM shall return an NRC 0x31 (requestOutOfRange).*♩(RS\Diag_04246)*

> **[SWS_DM_01081]**{草案} **会话检查源数据标识** *[*接收到服务'DynamicallyDefineDataIdentifier'，其子功能定义ByIdentfier，如果DiagnosticDynamicallyDefineDataIdentifierClass.checkPeSourceId设置为true，DM应检查当前会话中是否可以根据[[SWS_DM_00413](#_bookmark139)]定义源数据标识符。如果DDID无法在当前会话中定义，DM应返回NRC 0x31（请求超出范围）。*♩(RS\Diag_04246)*

简体中文：**[SWS_DM_01081]**{草案} **会话检查源数据标识** *[*接收到服务'DynamicallyDefineDataIdentifier'，其子功能定义ByIdentfier，如果DiagnosticDynamicallyDefineDataIdentifierClass.checkPeSourceId设置为true，DM应检查当前会话中是否可以根据[[SWS_DM_00413](#_bookmark139)]定义源数据标识符。如果DDID无法在当前会话中定义，DM应返回NRC 0x31（请求超出范围）。*♩(RS\Diag_04246)*


**[SWS_DM_01082]**{DRAFT} **Security level check for sourceDataIdentifier** *[*On rception of service 'DynamicallyDefineDataIdentifier' with subfunction 'defineByIdentfier' and if DiagnosticDynamicallyDefineDataIdentifierClass.checkPeSourceId is set to TRUE, the DM shall check if the sourceDataIdentifier can be dfined in the current security level according to [[SWS_DM_00414](#_bookmark140)]. If the DDID cannot be defined in the current security level, the DM shall return an NRC 0x33 (securityAcessDenied).*♩(RS_Diag_04246)*

> **[SWS_DM_01082]**{草案} **源数据标识符的安全级别检查** *[*接收服务'DynamicallyDefineDataIdentifier'和子功能'defineByIdentfier'时，如果DiagnosticDynamicallyDefineDataIdentifierClass.checkPeSourceId设置为TRUE，DM必须检查源数据标识符是否可以根据[[SWS_DM_00414](#_bookmark140)]定义在当前安全级别中。如果DDID无法在当前安全级别中定义，DM必须返回NRC 0x33（安全访问被拒绝）。*♩(RS_Diag_04246)*


The DM does further session and security checks for all source DIDs if DiagnostiDynamicallyDefineDataIdentifierClass.checkPerSourceId is set to TRUE when the DDID is requested with UDS service 0x22 or 0x2A.

> 当使用UDS服务0x22或0x2A请求DDID时，如果DiagnostiDynamicallyDefineDataIdentifierClass.checkPerSourceId设置为TRUE，DM将对所有源DID进行进一步的会话和安全检查。


**[SWS_DM_01083]**{DRAFT} **Use of configured DID ports to get DDID data** *[*If a DDID read operation is requested, the DM shall retrieve the data for the dataRecord of the DDID by using the configuration of the contained DIDs.*♩(RS_Diag_04246)*

> 如果请求了DDID读取操作，DM应该通过使用包含的DID的配置来检索DDID数据记录的数据。

### Service 0x2E WriteDataByIdentifier


The processing of a UDS Service WriteDataByIdentifier (0x2E) is described in ISO 14229-1[[1](#_bookmark8)], see in particular the evaluation sequence in Figure 21. On processing, the Diagnostic Server instance needs to perform various checks. The following requirements determine the relation between the input data to be checked and the configuration provided to the Diagnostic Server instance via DEXT parameters.

> 处理UDS服务WriteDataByIdentifier（0x2E）的过程描述在ISO 14229-1[[1](#_bookmark8)]中，特别是21号图中的评估序列。在处理时，诊断服务器实例需要执行各种检查。以下要求确定输入数据与通过DEXT参数提供给诊断服务器实例的配置之间的关系。


**[SWS_DM_00186]**{DRAFT} **Realisation of UDS service WriteDataByIdentifier (0x2E)** *[*The Diagnostic Server instance shall implement the diagnostic sevice 0x2E WriteDataByIdentifier according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04196)*

> **[SWS_DM_00186]**{草案} **实现UDS服务WriteDataByIdentifier（0x2E）** *[*诊断服务器实例应根据ISO 14229-1[[1](#_bookmark8)]来实现诊断服务0x2E WriteDataByIdentifier。*♩（RS_Diag_04196）*


[]{#_bookmark165 .anchor}**[SWS_DM_00415]**{DRAFT} **Check supported DataIdentifier** *[*On reception of the UDS Service WriteDataByIdentifier (0x2E), a requested DataIdentifier shall be consiered as supported if and only if there exists a DiagnosticDataIdentifier with id matching the DataIdentifier and this DiagnosticDataIdentifier is referenced by a DiagnosticWriteDataByIdentifier.*♩(RS_Diag_04203)*

> 当接收到UDS服务WriteDataByIdentifier（0x2E）时，如果存在具有与数据标识符匹配的诊断数据标识符并且该诊断数据标识符由诊断WriteDataByIdentifier引用，则所请求的数据标识符将被视为受支持。♩（RS_Diag_04203）


**[SWS_DM_00416]**{DRAFT} **Check supported DataIdentifier in active session** *[*On reception of the UDS Service WriteDataByIdentifier (0x2E), a requested DataIdentifier shall be considered as supported in active session if and only if the DataIdentifier is supported according to [[SWS_DM_00415](#_bookmark165)] and the active session passes the execution permission check as per [[SWS_DM_00101](#_bookmark93)].*♩(RS_Diag_04203)*

> 当收到UDS服务WriteDataByIdentifier（0x2E）时，如果支持的DataIdentifier根据[[SWS_DM_00415]（＃_bookmark165）]并且活动会话通过执行权限检查按照[[SWS_DM_00101]（＃_bookmark93）]，则请求的DataIdentifier将被视为活动会话中支持的。 ♩（RS_Diag_04203）


**[SWS_DM_00417]**{DRAFT} **Check supported DataIdentifier on active security level** *[*On reception of the UDS Service WriteDataByIdentifier (0x2E), a requested DataIdentifier shall be considered as supported on active security level if and only if the DataIdentifier is supported according to [[SWS_DM_00415](#_bookmark165)] and the active security level passes the execution permission check as per [[SWS_DM_00103](#_bookmark94)].*♩(RS_Diag\04203)*

> 当接收UDS服务WriteDataByIdentifier（0x2E）时，如果按照[SWS_DM_00415]（# _bookmark165）支持所请求的DataIdentifier，并且根据[SWS_DM_00103]（# _bookmark94）的执行权限检查，激活的安全级别通过，则认为该DataIdentifier在激活的安全级别上是受支持的。～（RS_Diag\04203）


**[SWS_DM_00572]**{DRAFT} **Writing data for requested DataIdentifier** *[*On recetion of the UDS Service WriteDataByIdentifier (0x2E) the Diagnostic Server istance shall provide the data for a DataIdentifier to the mapped RPortPrototypes.*♩ (RS_Diag_04097)*

> **[SWS_DM_00572]**{草案} **根据请求的数据标识符写入数据** *[*接收UDS服务WriteDataByIdentifier（0x2E）时，诊断服务器实例应将映射到RPortPrototypes的数据标识符的数据提供给。♩（RS_Diag_04097）*


**[SWS_DM_00573]**{DRAFT} **Reaction on ApplicationError** *[*If the *ara::core::Result* of external processor has an error of ara::diag::DiagUdsNrcErrorDomain, the Diagnostic Server instance shall return a negative response with the value of that error code.*♩(RS_Diag_04196)*

> **[SWS_DM_00573]**{草稿} **对应用程序错误的反应** *[*如果外部处理器的ara::core::Result有ara::diag::DiagUdsNrcErrorDomain的错误，则诊断服务器实例应返回带有该错误代码值的负响应。*♩(RS_Diag_04196)*

### Service 0x31 RoutineControl


**[SWS_DM_00201]**{DRAFT} **Realization of UDS service RoutineControl (0x31)** *[*The Diagnostic Server instance shall implement the diagnostic service RotineControl (0x31) according to ISO 14229-1[[1](#_bookmark8)] for subFunctions startRoutine, stopRoutine and requestRoutineResults.*♩(RS_Diag_04196, RS_Diag_04224)*

> **[SWS_DM_00201]**{草稿} **实现UDS服务RoutineControl（0x31）** *[*根据ISO 14229-1[[1](#_bookmark8)]，诊断服务器实例应实现诊断服务RotineControl（0x31），用于startRoutine、stopRoutine和requestRoutineResults子功能。*♩（RS_Diag_04196，RS_Diag_04224）*


**[SWS_DM_00202]**{DRAFT} **Check for Supported RoutineIdentifier and Reaction** *[*The Diagnostic Server instance shall check, whether the RoutineIdentifier adressed by the UDS Service RoutineControl (0x31) is supported by an existing DagnosticRoutine with a matching id in the configuration. If the RoutineIdentifier addressed by the UDS Service RoutineControl (0x31) is not supported a negative response with NRC 0x31 (requestOutOfRange) shall be returned.*♩(RS_Diag_04203, RS_Diag_04224)*

> **[SWS_DM_00202]**{草稿} **检查受支持的例行标识符和反应** *[*诊断服务器实例应检查UDS服务例行控制（0x31）所地址的例行标识符是否由具有匹配ID的现有DagnosticRoutine支持。如果UDS服务例行控制（0x31）所地址的例行标识符不受支持，则应返回具有NRC 0x31（requestOutOfRange）的负响应。*♩（RS_Diag_04203，RS_Diag_04224）*


**[SWS_DM_00448]**{DRAFT} **Check supported RoutineIdentifier in active session** *[*On reception of the UDS Service RoutineControl (0x31), the DM shall check if the DiagnosticAccessPermission referenced by the DiagnosticRoutine has pemissions to be executed in the current session and send a NRC 0x31 if the permissions are not given.*♩(RS_Diag_04203, RS_Diag_04224)*

> 当接收到UDS服务例程控制（0x31）时，DM应检查诊断例程引用的诊断访问权限是否允许在当前会话中执行，如果不允许，则发送NRC 0x31。（RS_Diag_04203, RS_Diag_04224）


**[SWS_DM_00437]**{DRAFT} **Security Level check for RoutineIdentifier** *[*On recetion of the UDS Service RoutineControl (0x31), the DM shall check if the DiagnoticAccessPermission referenced by the DiagnosticRoutine has permissions to be executed with the current security level and send a NRC 0x33 (Security access denied) if the permissions are not given.*♩(RS_Diag_04203, RS_Diag_04224)*

> 当收到UDS服务例行控制（0x31）时，DM应检查由诊断例程引用的DiagnosticAccessPermission是否具有以当前安全级别执行的权限，如果没有给出权限，则发送NRC 0x33（安全访问被拒绝）。（RS_Diag_04203，RS_Diag_04224）


**[SWS_DM_00203]**{DRAFT} **Check for Supported Subfunction and Reaction** *[*The Diagnostic Server instance shall check, whether the Subfunction addressed by the UDS Service RoutineControl (0x31) is supported by checking the existence of the corresponding attributes start or stop or requestResult in the related DianosticRoutine configuration. If the Subfunction addressed by the UDS Service RotineControl (0x31) is not supported by the configuration a negative response NRC 0x12 (SubFunctionNotSupported) shall be returned.*♩(RS_Diag_04203, RS_Diag_04224)*

> **[SWS_DM_00203]**{草案} **检查支持的子功能和反应** *[*诊断服务器实例应通过检查相关诊断例程配置中的start或stop或requestResult属性的存在来检查UDS服务例程控制（0x31）所指的子功能是否受支持。如果UDS服务例程控制（0x31）所指的子功能不受配置支持，则应返回负响应NRC 0x12（SubFunctionNotSupported）。*♩（RS_Diag_04203，RS_Diag_04224）*


**[SWS_DM_00574]**{DRAFT} **UDS Service RoutineControl (0x31) startRoutine prcessing with generic interface** *[*The Diagnostic Server instance shall call the ara::diag::GenericRoutine::Start according to the mapped diagnostic inteface [TPS_MANI_01326] and [constr_10062] to process the subfunction startRotine.*♩(RS_Diag_04196, RS_Diag_04224)*

> **[SWS_DM_00574]**{草案} **UDS 服务例程控制（0x31）开始例程处理，使用通用接口** *[*诊断服务器实例应根据映射的诊断接口[TPS_MANI_01326]和[constr_10062]调用ara :: diag :: GenericRoutine :: Start来处理子功能startRotine。*♩（RS_Diag_04196，RS_Diag_04224）*


**[SWS_DM_00575]**{DRAFT} **UDS Service RoutineControl (0x31) requestRotineResults processing with generic interface** *[*The Diagnostic Server istance shall call ara::diag::GenericRoutine::RequestResults according to the mapped diagnostic interface [TPS_MANI_01326] and [constr_10062] to process the subfunction requestRoutineResults.*♩(RS_Diag_04196, RS_Diag_04224)*

> **[SWS_DM_00575]**{草稿} **UDS服务例程控制（0x31）请求例程结果处理的通用接口** *[*根据映射的诊断接口[TPS_MANI_01326]和[constr_10062]，诊断服务实例应调用ara :: diag :: GenericRoutine :: RequestResults来处理子功能RequestRoutineResults. *♩（RS_Diag_04196，RS_Diag_04224）*


**[SWS_DM_00576]**{DRAFT} **UDS Service RoutineControl (0x31) stopRoutine prcessing with generic interface** *[*The Diagnostic Server instance shall call

> **[SWS_DM_00576]**{草稿} **UDS服务例程控制（0x31）使用通用接口停止例程处理** *[*诊断服务器实例应调用


ara::diag::GenericRoutine::Stop according to the mapped diagnostic inteface [TPS_MANI_01326] and [constr_10062] to process the subfunction stopRotine.*♩(RS_Diag_04196, RS_Diag_04224)*

> 根据映射的诊断接口[TPS_MANI_01326]和[constr_10062]，处理子功能stopRotine的ara :: diag :: GenericRoutine :: Stop。♩(RS_Diag_04196, RS_Diag_04224)


**[SWS_DM_01270]**{DRAFT} **UDS Service RoutineControl (0x31) startRotine processing with typed interface** *[*The Diagnostic Server instance shall utilize the associated RPortPrototype if it is typed by the Namspace1OfPortInterface::Namespace2OfPortInterface::ShortnamOfRIPortInterface class and call its Namespace1OfPortInterface::Namspace2OfPortInterface::ShortnameOfRIPortInterface::Start function to process the subfunction startRoutine.*♩(RS_Diag_04196, RS_Diag_04224)*

> **[SWS_DM_01270]**{草案} **UDS服务例程控制（0x31）使用类型接口开始例程处理** *[*如果诊断服务器实例被Namspace1OfPortInterface::Namespace2OfPortInterface::ShortnamOfRIPortInterface类型化，则应使用关联的RPortPrototype，并调用其Namespace1OfPortInterface::Namspace2OfPortInterface::ShortnameOfRIPortInterface::Start函数来处理子功能startRoutine。♩（RS_Diag_04196，RS_Diag_04224）*

简体中文：**[SWS_DM_01270]**{草案} **UDS服务例程控制（0x31）使用类型接口开始例程处理** *[*如果诊断服务器实例被Namspace1OfPortInterface::Namespace2OfPortInterface::ShortnamOfRIPortInterface类型化，则应使用关联的RPortPrototype，并调用其Namespace1OfPortInterface::Namspace2OfPortInterface::ShortnameOfRIPortInterface::Start函数来处理子功能startRoutine。♩（RS_Diag_04196，RS_Diag_04224）*


**[SWS_DM_01271]**{DRAFT} **UDS Service RoutineControl (0x31) stopRotine processing with typed interface** *[*The Diagnostic Server instance shall utilize the associated RPortPrototype if it is typed by the Namspace1OfPortInterface::Namespace2OfPortInterface::ShortnamOfRIPortInterface class and call its Namespace1OfPortInterface::Namspace2OfPortInterface::ShortnameOfRIPortInterface::Stop function to process the subfunction stopRoutine.*♩(RS_Diag_04196, RS_Diag_04224)*

> **[SWS_DM_01271]**{草案} **UDS服务例程控制（0x31）通过类型接口停止例程处理** *[*如果Diagnostic Server实例被Namspace1OfPortInterface::Namespace2OfPortInterface::ShortnamOfRIPortInterface类型化，则它应该利用相关的RPortPrototype并调用其Namespace1OfPortInterface::Namspace2OfPortInterface::ShortnameOfRIPortInterface::Stop函数来处理子功能stopRoutine。*♩（RS_Diag_04196，RS_Diag_04224）*

简体中文：**[SWS_DM_01271]**{草案} **UDS服务例程控制（0x31）通过类型接口停止例程处理** *[*如果Diagnostic Server实例被Namspace1OfPortInterface::Namespace2OfPortInterface::ShortnamOfRIPortInterface类型化，则它应该利用相关的RPortPrototype并调用其Namespace1OfPortInterface::Namspace2OfPortInterface::ShortnameOfRIPortInterface::Stop函数来处理子功能stopRoutine。*♩（RS_Diag_04196，RS_Diag_04224）*


**[SWS_DM_01272]**{DRAFT} **UDS Service RoutineControl (0x31) requestRotineResults processing with typed interface** *[*The Diagnostic Server instance shall utilize the associated RPortPrototype if it is typed by the Namespace1OfPortInterface::Namespace2OfPortInterface::ShornameOfRIPortInterface class and call its Namespace1OfPortInterface::Namespace2OfPortInterface::ShortnameOfRIPortInterface::RquestResults function to process the subfunction requestRoutineResults.*♩ (RS_Diag_04196, RS_Diag_04224)*

> **[SWS_DM_01272]**{草案}**UDS服务例程控制（0x31）请求例程结果处理带有类型接口** *[*诊断服务器实例应该利用相关的RPortPrototype如果它被Namespace1OfPortInterface::Namespace2OfPortInterface::ShornameOfRIPortInterface类型化，并调用它的Namespace1OfPortInterface::Namespace2OfPortInterface::ShortnameOfRIPortInterface::RquestResults函数来处理子功能请求例程结果。 ♩（RS_Diag_04196，RS_Diag_04224）*


**[SWS_DM_01273]**{DRAFT} **Namespace for typed UDS Service RoutineControl (0x31)** *[*If the typed RoutineControl interface is used, it shall fulfill [SWS_DM_00510] also.*♩(RS_Diag_04196, RS_Diag_04224)*

> **[SWS_DM_01273]**{草稿} **类型化UDS服务例程控制（0x31）的命名空间** *[*如果使用类型化的例程控制界面，它也必须满足[SWS_DM_00510]。*♩（RS_Diag_04196，RS_Diag_04224）*

### Service 0x34 RequestDownload


**[SWS_DM_00128]**{DRAFT} **Realization of UDS service RequestDownload (0x34)** *[*The Diagnostic Server instance shall implement the UDS service RequesDownload (0x34) according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04196, RS_Diag_04033)*

> **[SWS_DM_00128]**{草案} **实现UDS服务RequestDownload（0x34）** *[*根据ISO 14229-1[[1]](#_bookmark8)，诊断服务器实例应实现UDS服务RequestDownload（0x34）。*♩（RS_Diag_04196，RS_Diag_04033）*


**[SWS_DM_00867]**{DRAFT} **UDS service RequestDownload (0x34) processing** *[*The Diagnostic Server instance shall call ara::diag::DownloadSevice::RequestDownload to process an UDS service RequestDownload (0x34).*♩ (RS_Diag_04196)*

> **[SWS_DM_00867]**{草案} **UDS 服务 RequestDownload (0x34) 的处理** *[*诊断服务器实例应调用ara::diag::DownloadSevice::RequestDownload来处理UDS服务RequestDownload (0x34)。*♩ (RS_Diag_04196)*

### Service 0x35 RequestUpload


**[SWS_DM_00134]**{DRAFT} **Realization of UDS service RequestUpload (0x35)** *[*The Diagnostic Server instance shall implement the UDS service RequestUpload (0x35) according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04196)*

> **[SWS_DM_00134]**{草案} **实现UDS服务RequestUpload（0x35）** *[*按照ISO 14229-1[[1](#_bookmark8)]，诊断服务器实例应实现UDS服务RequestUpload（0x35）。*♩(RS_Diag_04196)*


**[SWS_DM_00868]**{DRAFT} **UDS service RequestUpload (0x35) processing** *[*The Diagnostic Server instance shall call ara::diag::UploadService::RquestUpload to process a UDS service RequestUpload (0x35).*♩(RS_Diag_04033)*

> **[SWS_DM_00868]**{草案}**UDS服务RequestUpload（0x35）处理** *[*诊断服务器实例应调用ara :: diag :: UploadService :: RquestUpload来处理UDS服务RequestUpload（0x35）。*♩（RS_Diag_04033）*

### Service 0x36 TransferData


**[SWS_DM_00137]**{DRAFT} **Realization of UDS service TransferData (0x36)** *[*The Diagnostic Server instance shall implement the UDS service TransferData (0x36) according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04196)*

> **[SWS_DM_00137]**{草案} **实现UDS服务TransferData（0x36）** *[*诊断服务器实例应根据ISO 14229-1[[1](#_bookmark8)]实现UDS服务TransferData（0x36）。*♩(RS_Diag_04196)*


[]{#_bookmark170 .anchor}**[SWS_DM_00869]**{DRAFT} **UDS service TransferData (0x36) download procesing** *[*To download data via the UDS service TransferData, the Diagnostic Server instance shall call ara::diag::DownloadService::DownloadData to process the service.*♩(RS_Diag_04033)*

> 通过UDS服务TransferData下载数据，诊断服务器实例应调用ara :: diag :: DownloadService :: DownloadData来处理该服务。(RS_Diag_04033)


ISO 14229-1[[1](#_bookmark8)] provides a UDS service TransferData (0x36) specific NRC evaluation sequence. This sequence has checks that in rotating order needs to be done by the Diagnostic Server instance and by the service processor itself. Therefore bfore actually running the service processor, the service processor needs means to do a certain verification step. As the "GenericUDSService class" has only one single method this is not possible for the "GenericUDSService class". As a result of this, the entire service specific NRC handling is inside the "GenericUDSService class" for UDS service TransferData (0x36).

> ISO 14229-1[[1](#_bookmark8)]提供了UDS服务TransferData（0x36）的特定NRC评估序列。此序列具有检查，需要由诊断服务器实例和服务处理器本身以轮流的顺序执行。因此，在实际运行服务处理器之前，服务处理器需要执行某种验证步骤。由于“GenericUDSService类”只有一个单独的方法，因此对于“GenericUDSService类”来说，这是不可能的。因此，UDS服务TransferData（0x36）的整个特定NRC处理都在“GenericUDSService类”中完成。


[]{#_bookmark171 .anchor}**[SWS_DM_01096]**{DRAFT} **UDS service TransferData (0x36) upload processing** *[*To upload data via the UDS service TransferData, the Diagnostic Server istance shall call ara::diag::UploadService::UploadData to process the sevice.*♩(RS_Diag_04033)*

> 通过UDS服务TransferData上传数据，诊断服务器实例应调用ara :: diag :: UploadService :: UploadData来处理服务（RS_Diag_04033）。


Besides the NRC checking according to [[SWS_DM_00101](#_bookmark93)] and [[SWS_DM_00103](#_bookmark94)] the DM does not further service validation. All other NRC checks required by ISO 14221[[1](#_bookmark8)] for UDS service TransferData have to be implemented in the application called in [[SWS_DM_00869](#_bookmark170)] and [[SWS_DM_01096](#_bookmark171)].

> 除了根据[[SWS_DM_00101](#_bookmark93)]和[[SWS_DM_00103](#_bookmark94)]进行NRC检查之外，DM不进行进一步的服务验证。根据ISO 14221[[1](#_bookmark8)]对UDS服务TransferData所需的所有其他NRC检查都必须在[[SWS_DM_00869](#_bookmark170)]和[[SWS_DM_01096](#_bookmark171)]中调用的应用程序中实现。

### Service 0x37 RequestTransferExit


**[SWS_DM_00141]**{DRAFT} **Realization of UDS service RequestTransferExit (0x37)** *[*The Diagnostic Server instance shall implement the UDS service RequesTransferExit (0x37) according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04196)*

> **[SWS_DM_00141]**{草案} **实现UDS服务RequestTransferExit（0x37）** *[*根据ISO 14229-1[[1](#_bookmark8)]，诊断服务器实例应实现UDS服务RequestTransferExit（0x37）。*♩(RS_Diag_04196)*


[]{#_bookmark173 .anchor}**[SWS_DM_00871]**{DRAFT} **UDS service RequestTransferExit (0x37) download processing** *[*The Diagnostic Server instance shall call ara::diag::DowloadService::RequestDownloadExit to process a UDS service RequestTranferExit (0x37) for a download.*♩(RS_Diag_04033)*

> 诊断服务器实例应调用ara :: diag :: DowloadService :: RequestDownloadExit来处理UDS服务RequestTranferExit（0x37）的下载。（RS_Diag_04033）


[]{#_bookmark174 .anchor}**[SWS_DM_01097]**{DRAFT} **UDS service RequestTransferExit (0x37) upload prcessing** *[*The Diagnostic Server instance shall call ara::diag::UploaService::RequestUploadExit to process a UDS service RequestTransferExit (0x37) for an upload.*♩(RS_Diag_04033)*

> 诊断服务器实例应调用ara :: diag :: UploaService :: RequestUploadExit来处理UDS服务RequestTransferExit（0x37）的上传。


Besides the NRC checking according to [[SWS_DM_00101](#_bookmark93)] and [[SWS_DM_00103](#_bookmark94)] the DM does not further service validation. All other NRC checks required by ISO 14221[[1](#_bookmark8)] for UDS service TransferExit have to be implemented in the application called in [[SWS_DM_00871](#_bookmark173)] and [[SWS_DM_01097](#_bookmark174)].

> 除了根据[[SWS_DM_00101](#_bookmark93)]和[[SWS_DM_00103](#_bookmark94)]进行NRC检查外，DM不再进行进一步的服务验证。根据ISO 14221[[1](#_bookmark8)]，UDS服务TransferExit所需的所有其他NRC检查必须在在[[SWS_DM_00871](#_bookmark173)]和[[SWS_DM_01097](#_bookmark174)]中调用的应用程序中实现。

### Service 0x38 RequestFileTransfer


This chapter describes the definition and use of the UDS service RequestFileTransfer. The API design had the goal to allow a maximum level of flexibility to efficiently echange data or even very large data over process bounds in an AUTOSAR Adaptive system. An application developer of the ara::diag::FileTransferService iterface can choose between various ways to transfer the data. Some possible ways to do so are:

> 本章节描述了UDS服务RequestFileTransfer的定义和使用。API设计的目标是允许在AUTOSAR Adaptive系统中有效地交换数据或大量数据跨过进程边界。ara::diag::FileTransferService接口的应用程序开发人员可以选择多种传输数据的方式。一些可能的方法是：


- Simple: Copy the data between the adaptive application and the Diagnostic Maagement. This approach scales well enough for smaller file sizes and the implmentation is simple.

> 复制数据以在自适应应用程序和诊断管理之间进行交换。 这种方法对较小的文件大小具有良好的可伸缩性，实施简单。

- Zero Copy: The data is not copied between the adaptive application and the Diagnostic Management. This approach is resources efficient and has a good runtime behavior, especially for larger data transfers.

> 零复制：自适应应用程序和诊断管理之间的数据不会被复制。这种方法资源高效，尤其是对于较大的数据传输，具有良好的运行时行为。

- OS File System Handle: No data needs to be copied between the adaptive aplication and the Diagnostic Management. The application provides a file handle that is used in scope of another process. Data is not copied, but stronger depedencies on the OS exist.

> 没有需要在自适应应用程序和诊断管理之间复制数据。该应用程序提供一个文件句柄，用于另一个进程的范围。不复制数据，但对操作系统的依赖性更强。


In general, the design is open to implement further strategies that meet the individual project requirements.

> 一般而言，設計可以實現更多符合個別項目要求的策略。


**[SWS_DM_01310]**{DRAFT} **Realization of UDS service RequestFileTransfer (0x38)** *[*The Diagnostic Server instance shall implement the UDS service RequesFileTransfer (0x38) according to ISO 14229-1[[1](#_bookmark8)]. Besides the NRC checking according to [[SWS_DM_00101](#_bookmark93)] and [[SWS_DM_00103](#_bookmark94)] the DM does no further service validation. All other NRC checks required by ISO 14229-1[[1](#_bookmark8)] for UDS service RequestFileTransfer have to be implemented in the adaptive application.*♩(RS_Diag_04135)*

> 诊断服务器实例应根据ISO 14229-1[[1](#_bookmark8)]实现UDS服务RequestFileTransfer（0x38）。除了根据[[SWS_DM_00101](#_bookmark93)]和[[SWS_DM_00103](#_bookmark94)]进行NRC检查之外，DM不再进行其他服务验证。根据ISO 14229-1[[1](#_bookmark8)]对UDS服务RequestFileTransfer所需的所有其他NRC检查都必须在自适应应用程序中实现。*♩（RS_Diag_04135）*


**[SWS_DM_01311]**{DRAFT} **Realization of modeOfOperation AddFile (0x01)** *[*If a service RequestFileTransfer with modeOfOperation equal to AddFile (0x01) is rceived, the Diagnostic Server instance shall call ara::diag::FileTranferService::RequestWriteFile with WriteFileMode equal to kAdd.*♩(RS_Diag\04135)*

> **[SWS_DM_01311]**{草稿} **实现modeOfOperation AddFile (0x01)** *[*如果收到modeOfOperation等于AddFile (0x01)的服务RequestFileTransfer，则诊断服务器实例应调用ara::diag::FileTranferService::RequestWriteFile，其WriteFileMode等于kAdd。♩(RS_Diag\04135)*


**[SWS_DM_01312]**{DRAFT} **Realization of modeOfOperation DeleteFile (0x02)** *[*If a service RequestFileTransfer with modeOfOperation equal to DeleteFile (0x02) is rceived, the Diagnostic Server instanceshall call ara::diag::FileTranferService::DeleteFile.*♩(RS_Diag_04135)*

> 如果收到一个请求文件传输的服务，其modeOfOperation等于DeleteFile（0x02），诊断服务器实例应调用ara :: diag :: FileTranferService :: DeleteFile。


**[SWS_DM_01313]**{DRAFT} **Realization of modeOfOperation ReplaceFile (0x03)** *[*If a service RequestFileTransfer with modeOfOperation equal to ReplaceFile (0x03) is rceived, the Diagnostic Server instance shall call ara::diag::FileTranferService::RequestWriteFile with WriteFileMode equal to kReplace.*♩(RS\Diag_04135)*

> **[SWS_DM_01313]**{草案}**实现modeOfOperation ReplaceFile (0x03)** *[*如果接收到具有modeOfOperation等于ReplaceFile (0x03)的服务RequestFileTransfer，则诊断服务器实例应调用ara :: diag :: FileTranferService :: RequestWriteFile，其中WriteFileMode等于kReplace.♩(RS\Diag_04135)*


**[SWS_DM_01314]**{DRAFT} **Realization of modeOfOperation ReadFile (0x04)** *[*If a service RequestFileTransfer with modeOfOperation equal to ReadFile (0x04) is rceived, the Diagnostic Server instance shall call ara::diag::FileTranferService::RequestReadFile.*♩(RS_Diag_04135)*

> **[SWS_DM_01314]**{草案} **实现modeOfOperation ReadFile (0x04)** *[*如果收到modeOfOperation等于ReadFile (0x04)的服务RequestFileTransfer，诊断服务器实例应调用ara::diag::FileTranferService::RequestReadFile。♩(RS_Diag_04135)*


**[SWS_DM_01315]**{DRAFT} **Realization of modeOfOperation ReadDir (0x05)** *[*If a service RequestFileTransfer with modeOfOperation equal to ReadDir (0x05) is rceived, the Diagnostic Server instance shall call ara::diag::FileTranferService::RequestReadDirectory.*♩(RS_Diag_04135)*

> 如果收到具有modeOfOperation等于ReadDir（0x05）的服务RequestFileTransfer，则诊断服务器实例应调用ara :: diag :: FileTranferService :: RequestReadDirectory。


**[SWS_DM_01316]**{DRAFT} **Realization of modeOfOperation ResumeFile (0x06)** *[*If a service RequestFileTransfer with modeOfOperation equal to ResumeFile (0x06) is rceived, the Diagnostic Server instance shall call ara::diag::FileTranferService::RequestResumeWriteFile.*♩(RS_Diag_04135)*

> 如果接收到modeOfOperation等于ResumeFile (0x06)的服务RequestFileTransfer，诊断服务器实例应调用ara :: diag :: FileTranferService :: RequestResumeWriteFile（RS_Diag_04135）。


The ara::diag::FileTransferService methods to process a RequestFileTranfer (0x38) all return a DataTransferReadSession or DataTransferWriteSession object. This object is the connection of processing the RequestFileTransfer (0x38) and the consecutive following TransferData (0x36) services. The 0x36 service that is used to actually transfer the files data stream is done within the ara::diag::DataTranferReadSession or ara::diag::DataTransferWriteSession. Within these objects various overloaded template constructors exist, that allow that the actual iplementation can be inside the handler objects that are part of these template costructors. This allows any custom implementation with different levels of optimization adapted for what is required by the ECU project.

> ara :: diag :: FileTransferService 方法处理RequestFileTranfer（0x38）所有返回DataTransferReadSession或DataTransferWriteSession对象。此对象是处理RequestFileTransfer（0x38）和连续的TransferData（0x36）服务的连接。用于实际传输文件数据流的0x36服务是在ara :: diag :: DataTranferReadSession或ara :: diag :: DataTransferWriteSession中完成的。在这些对象中存在各种重载模板构造函数，允许实际的实现可以在这些模板构造函数的一部分处理程序对象中。这允许任何自定义实现，具有不同级别的优化，适应ECU项目所需。


The connection between RequestFileTransfer (0x38) and TransferData (0x36) is done using the corresponding DataTransferReadSession or DataTransferWriteSession prvided by a successful processing of the RequestFileTransfer in the ara::diag:FileTransferService. This data transfer session is used to abstract between the individual selected strategies to handle the TransferData (0x36) data exchange btween the UDS protocol and the final destination of the data. This design allows various

> RequestFileTransfer（0x38）和TransferData（0x36）之间的连接是通过ara :: diag：FileTransferService中对RequestFileTransfer的成功处理提供的相应DataTransferReadSession或DataTransferWriteSession完成的。此数据传输会话用于抽象处理TransferData（0x36）数据交换的各个选定策略之间的关系，以及UDS协议和数据最终目的地之间的关系。此设计允许各种不同的策略来处理数据交换。


handler objects to be used. AUTOSAR provides a set of handlers to be choose by the application developer that fits best to the induvial needs (e.g. shared memory or not). The design is also open to provide further handler implementation in future AUTOSAR releases as well as platform vendor specific extensions by adding further template constructors for these handlers in the session objects.

> AUTOSAR提供一组处理程序供应用开发者选择，以满足个人需求（例如共享内存或不共享）。此设计也可以在未来的AUTOSAR版本中提供更多的处理程序实现，以及平台供应商特定的扩展，通过在会话对象中添加更多的模板构造函数来实现。


**[SWS_DM_01317]**{DRAFT} **Realization of TransferData (0x36) in context of RquestFileTransfer** *[*If a TransferData (0x36) in context of RequestFileTransfer is rceived, the Diagnostic Server instance shall call (depending on the data drection read/write) the corresponding Read or Write methods of the handler classes registered via the template constructors of DataTransferReadSession or DataTransfeWriteSession.*♩(RS_Diag_04135)*

> 如果接收到RequestFileTransfer上下文中的TransferData（0x36），则诊断服务器实例应根据数据方向（读/写）调用通过DataTransferReadSession或DataTransfeWriteSession模板构造函数注册的处理程序类的相应读取或写入方法（参见RS_Diag_04135）。


**[SWS_DM_01318]**{DRAFT} **Realization of RequestTransferExit (0x37) in context of RequestFileTransfer** *[*If a RequestTransferExit (0x37) in context of RequestFilTransfer is received, the Diagnostic Server instance shall call (depending on the data direction read/write) the Exit method of the handler classes registered via the template constructors of DataTransferReadSession or DataTransferWriteSession.*♩ (RS_Diag_04135)*

> 如果在RequestFileTransfer上下文中收到RequestTransferExit（0x37），诊断服务器实例应根据数据方向（读/写）调用通过DataTransferReadSession或DataTransferWriteSession模板构造函数注册的处理程序类的Exit方法。（RS_Diag_04135）


**[SWS_DM_01319]**{DRAFT} **Consecutive registration of notifier with ReleasHandler::SetNotifier()** *[*In case of a consecutive call of ara::diag::ReleasHandler::SetNotifier of the corresponding ara::diag::ReleaseHandler istance, the DM shall overwrite the previous registered notifier.*♩(RS_Diag_04135)*

> **[SWS_DM_01319]**{草案}**使用ReleasHandler::SetNotifier()连续注册通知者** *[*如果对应的ara::diag::ReleaseHandler实例连续调用ara::diag::ReleasHandler::SetNotifier，DM应该覆盖前面注册的通知者。*♩(RS_Diag_04135)*

### Security and Rights Management


UDS and DEXT allow only a very coarse use of the DiagnosticAccessPermission on service RequestFileTransfer level. A DiagnosticAccessPermission on file level would require a static definition of filenames in DEXT, which is against the nature of a generic file system. This is a difference to the handling of DIDs or RIDs that are defined in DEXT.

> UDS和DEXT仅允许在服务请求文件传输级别上使用非常粗略的诊断访问权限。在文件级别上使用诊断访问权限需要在DEXT中定义文件名的静态定义，这与通用文件系统的本质相悖。这与在DEXT中定义的DID或RID的处理方式有所不同。


As further level a filesystem has a rights management implemented inside the OS and therefore outside the scope of the Diagnostic Server instance. This means that rights management for file access needs to be done in scope of the adaptive application implementing the ara::diag::FileTransferService.

> 随着文件系统的进一步发展，操作系统内部实现了权限管理，因此超出了诊断服务器实例的范围。这意味着文件访问的权限管理需要在实现ara :: diag :: FileTransferService的自适应应用程序的范围内完成。

### Service 0x3E TesterPresent


[]{#_bookmark177 .anchor}**[SWS_DM_00126]**{DRAFT} **Realisation of UDS service 0x3E TesterPresent** *[*The Diagnostic Server instance shall internally implement the diagnostic service 0x3E TesterPresent according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04196)*

> 诊断服务器实例应根据ISO 14229-1[1]内部实现诊断服务0x3E TesterPresent。

### Service 0x85 ControlDTCSetting


The UDS service ControlDTCSetting is used by a client to stop or resume the updating of DTC status bits in the server.

> 客户端使用UDS服务ControlDTCSetting来停止或恢复服务器中DTC状态位的更新。


[]{#_bookmark179 .anchor}**[SWS_DM_00229]**{DRAFT} **Support of UDS service ControlDTCSetting (0x85)** *[*The Diagnostic Server instance shall provide the UDS service ControlDTCSetting (0x85) according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04180, RS_Diag_04159)*

> 支持UDS服务ControlDTCSetting（0x85）**[SWS_DM_00229]**{草案}
诊断服务器实例应根据ISO 14229-1[[1]（#_bookmark8）]提供UDS服务ControlDTCSetting（0x85）*[*。♩（RS_Diag_04180，RS_Diag_04159）*]


**[SWS_DM_00444]**{DRAFT} **Check Support of UDS service ControlDTCSetting (0x85) in active session** *[*On reception of the UDS service ControlDTCSetting (0x85), a requested subfunction shall be considered as supported in active session if and only if the active session passes the execution permission check as per [[SWS_DM_00101](#_bookmark93)].*♩ (RS_Diag_04203)*

> **[SWS_DM_00444]**{草稿} **检查活动会话中UDS服务ControlDTCSetting (0x85)的支持** *[*收到UDS服务ControlDTCSetting (0x85)时，如果活动会话通过[[SWS_DM_00101](#_bookmark93)中的执行权限检查，则请求的子功能应被视为活动会话中受支持。*♩ (RS_Diag_04203)*


**[SWS_DM_00445]**{DRAFT} **Check Support of UDS service ControlDTCSetting (0x85) on active security level** *[*On reception of the UDS service ControlDTCSetting (0x85), a requested subfunction shall be considered as supported on active security level if and only if the active security level passes the execution permission check as per [[SWS_DM_00103](#_bookmark94)].*♩(RS_Diag_04203)*

> **[SWS_DM_00445]**{草案} **在活动安全级别上检查UDS服务ControlDTCSetting（0x85）的支持** *[*在接收UDS服务ControlDTCSetting（0x85）时，如果活动安全级别通过了[[SWS_DM_00103](#_bookmark94)]中的执行权限检查，则所请求的子功能将被视为在活动安全级别上受支持。*♩(RS_Diag_04203)*


**[SWS_DM_00230]**{DRAFT} **Check for supported subfunctions** *[*If the Sufunction addressed by the UDS service ControlDTCSetting (0x85) according to [[SWS_DM_00229](#_bookmark179)] is not Subfunction 0x01 (ON) or Subfunction 0x02 (OFF), then the Diagnostic Server instance shall return a NRC 0x12 (SubFunctionNotSuported).*♩(RS_Diag_04203)*

> **[SWS_DM_00230]**{草稿}**检查受支持的子功能** *[*如果根据[[SWS_DM_00229](#_bookmark179)] UDS服务ControlDTCSetting（0x85）所指的子功能不是子功能0x01（ON）或子功能0x02（OFF），那么诊断服务器实例应返回NRC 0x12（SubFunctionNotSuported）。*♩（RS_Diag_04203）*


**[SWS_DM_00231]**{DRAFT} **Invalid value for optional request parameter** *[*If the Dagnostic Server instance receives a UDS service ControlDTCSetting (0x85) rquest with DTCSettingControlOptionRecord != 0xFFFFFF, the Diagnostic Server instance shall send a NRC 0x31 (RequestOutOfRange).*♩(RS_Diag_04203, RS\Diag_04115)*

> **[SWS_DM_00231]**{草案} **可选请求参数的值无效** *[*如果诊断服务器实例接收到具有DTCSettingControlOptionRecord！= 0xFFFFFF的UDS服务ControlDTCSetting（0x85）请求，则诊断服务器实例应发送NRC 0x31（RequestOutOfRange）。*♩（RS_Diag_04203，RS\ Diag_04115）*


**[SWS_DM_00909]**{DRAFT} **Support of Subfunction 0x01 (ON)** *[*If the Diagnotic Server instance receives a valid UDS service ControlDTCSetting (0x85) with Subfunction 0x01 (ON) and optionally with DTCSettingControlOptionRecord of value 0xFFFFFF, the Diagnostic Server instance shall:

> **[SWS_DM_00909]**{草稿}**支持子功能0x01（开）** *[*如果诊断服务器实例收到有效的UDS服务ControlDTCSetting（0x85），其中子功能为0x01（开），可选地带有DTCSettingControlOptionRecord值为0xFFFFFF，诊断服务器实例应：

- enable the update of the UDS DTC status bytes in the primary event meory
- enable the storage in the primary event memory
- update ara::diag::ControlDtcStatusType to kDTCSettingOn


*♩(RS_Diag_04180, RS_Diag_04159)*

> *♩(RS_Diag_04180，RS_Diag_04159)*


[]{#_bookmark180 .anchor}**[SWS_DM_00910]**{DRAFT} **Support of Subfunction 0x02 (OFF)** *[*If the Diagnotic Server instance receives a valid UDS service ControlDTCSetting (0x85) with Subfunction 0x02 (OFF) and optionally with DTCSettingControlOptionRecord of value 0xFFFFFF, the Diagnostic Server instance shall:

> 如果诊断服务器实例收到有效的UDS服务ControlDTCSetting（0x85），其子功能为0x02（OFF），可选择DTCSettingControlOptionRecord的值为0xFFFFFF，诊断服务器实例应该：

- disable the update of the UDS DTC status bytes in the primary event meory
- disable the storage in the primary event memory
- update ara::diag::ControlDtcStatusType to kDTCSettingOff


*♩(RS_Diag_04180, RS_Diag_04159)*

> *♩(RS_Diag_04180，RS_Diag_04159)*


**[SWS_DM_00811]**{DRAFT} **Re-enabling of ControlDTCSetting by Diagnostic Aplication** *[*In case the DTCSetting is disabled and the Diagnostic Server receives a call to ara::diag::DTCInformation::EnableControlDtc function from the aplication the Diagnostic Server instance shall:

> **[SWS_DM_00811]**{草案} **诊断应用程序重新启用ControlDTCSetting** *[*如果DTCSetting被禁用，并且诊断服务器收到来自应用程序的ara :: diag :: DTCInformation :: EnableControlDtc函数的调用，诊断服务器实例应该：

- enable the update of the UDS DTC status byte
- enable the storage in event memory
- update ara::diag::ControlDtcStatusType to kDTCSettingOn


*♩(RS_Diag_04159, RS_Diag_04211, RS_Diag_04067)*

> *♩(RS_Diag_04159，RS_Diag_04211，RS_Diag_04067)*


Hint: The monitoring application is responsible for the re-enabling of ControlDTCSeting in case some conditions or states demands so. For this purpose the appliction can use the interface ara::diag::DTCInformation with the function ara:diag::DTCInformation::EnableControlDtc.

> 监控应用程序负责在某些条件或状态需要时重新启用ControlDTCSeting。为此，该应用程序可以使用ara：diag：DTCInformation接口，并使用ara：diag：DTCInformation：EnableControlDtc功能。


**[SWS_DM_01353]**{DRAFT} **Consecutive registration of notifier with SetCotrolDtcStatusNotifier()** *[*In case of a consecutive call of ara::diag::DTCInfomation::SetControlDtcStatusNotifier of the corresponding ara::diag:DTCInformation instance, DM module shall overwrite the previous registered notfier.*♩(RS_Diag_04159)*

> **[SWS_DM_01353]**{草案} **使用SetCotrolDtcStatusNotifier()连续注册通知者** *[*如果对应的ara::diag:DTCInformation实例连续调用ara::diag::DTCInfomation::SetControlDtcStatusNotifier，DM模块应覆盖先前注册的通知者。*♩(RS_Diag_04159)*

### Service 0x86 ResponseOnEvent


With the UDS Service ResponseOnEvent (0x86), a tester requests an ECU to start or stop transmission of responses initiated by a specified event. Upon registering an event for transmission, the tester also specifies the corresponding service to respond to (e.g: UDS Service ReadDataByIdentifier 0x22).

> 随着UDS服务ResponseOnEvent（0x86），测试人员要求ECU开始或停止响应由指定事件启动的响应。在注册传输事件时，测试人员还指定相应的服务来响应（例如：UDS服务ReadDataByIdentifier 0x22）。


**Table 7.3: Supported sub function of ResponseonEvent (0x86)**

> 表7.3：响应事件（0x86）支持的子功能


The Diagnostic Server instance supports one active ResponseOnEvent logic per session (the default session or a non-default session) as specified by [[1](#_bookmark8)]. In geeral, the Diagnostic Client that starts ResponseOnEvent owns the whole RsponseOnEvent logic. This means that a Diagnostic Client can take over the ResponseOnEvent logic set up previously by another Diagnostic Client.

> 服务器实例按照[[1](#_bookmark8)]支持每个会话（默认会话或非默认会话）中的一个活动响应事件逻辑。通常，启动响应事件的诊断客户端拥有整个响应事件逻辑。这意味着诊断客户端可以接管先前由另一个诊断客户端设置的响应事件逻辑。


**[SWS_DM_00491]**{DRAFT} **Realisation of UDS service 0x86 ResponseOnEvent** *[*The Diagnostic Server instance shall implement the diagnostic service 0x86 ResponseOnEvent according to ISO 14229-1:2020 [[1](#_bookmark8)].

> 诊断服务器实例应根据ISO 14229-1:2020[[1]]（#_bookmark8）实现诊断服务0x86 ResponseOnEvent。


The implementation rules mentioned in [[1](#_bookmark8)], chapter 10.9.1 Service description shall be adhered to.*♩(RS_Diag_04160)*

> 请遵守[[1](#_bookmark8)]中第10.9.1节所述的实施规则。


**[SWS_DM_00493]**{DRAFT} **Reestablishing of Client Server communiction** *[*In case of a canceled diagnostic conversation this client receives the serviceToRespondTo-responses after a successful reestablishing of a diagnostic coversation.*♩(RS_Diag_04160)*

> **[SWS_DM_00493]**{草稿} **重新建立客户端服务器通信** *[*如果诊断会话被取消，此客户在成功重新建立诊断会话后，将收到serviceToRespondTo-responses响应。*♩(RS_Diag_04160)*


**[SWS_DM_00494]**{DRAFT} **Supported sub functions of ResponseOnEvent sevice** *[*The Diagnostic Server instance shall support the sub functions of dianostic service 0x86 ResponseOnEvent as listed in Table [7.3](#_bookmark182) Supported sub function of Response on Event (0x86).*♩(RS_Diag_04160)*

> **[SWS_DM_00494]**{草案} **响应事件服务的支持子功能** *[*诊断服务器实例应支持表[7.3](#_bookmark182)中列出的响应事件服务（0x86）的子功能。*♩(RS_Diag_04160)*


**[SWS_DM_01098]**{DRAFT} **Starting ResponseOnEvent in single and multiple client scenarios** *[*If the ResponseOnEvent sub function startResponseOnEvent is rquested by a client, the Diagnostic Server instance shall start the ResposeOnEvent logic and send all the serviceToRespondTo messages on the transmission channel of that client.*♩(RS_Diag_04160)*

> **[SWS_DM_01098]**{草稿} **在单客户端和多客户端场景中启动ResponseOnEvent** *[*如果客户端请求startResponseOnEvent子功能，诊断服务器实例将启动ResposeOnEvent逻辑，并在该客户端的传输通道上发送所有serviceToRespondTo消息。*♩(RS_Diag_04160)*


Note: This means that two or more clients can set up the ResponseOnEvent logic, but only the client that calls startResponseOnEvent receives the messages.

> 注意：这意味着可以设置多个客户端来响应事件，但只有调用startResponseOnEvent的客户端才能收到消息。


**[SWS_DM_01117]**{DRAFT} **Support of eventWindowTime values for ResposeOnEvent** *[*The Diagnostic Server instance shall support the event window times as configured by the value of the DEXT parameter DiagnosticResponseOEvent.eventWindow.eventWindowTime.*♩(RS_Diag_04160)*

> 诊断服务器实例应支持由DEXT参数DiagnosticResponseOEvent.eventWindow.eventWindowTime配置的事件窗口时间。


**[SWS_DM_01118]**{DRAFT} **Support of DEXT parameter DiagnosticResposeOnEventClass.responseOnEventSchedulerRate** *[*The Diagnostic Server instance shall map the DEXT parameter DiagnosticResponseOnEventClass. responseOnEventSchedulerRate to the ISO 14229-1[[1](#_bookmark8)] parameter responseOEventSchedulerRate.*♩(RS_Diag_04160)*

> **[SWS_DM_01118]**{草案} **支持DEXT参数DiagnosticResposeOnEventClass.responseOnEventSchedulerRate** *[*诊断服务器实例应将DEXT参数DiagnosticResponseOnEventClass.responseOnEventSchedulerRate映射到ISO 14229-1[[1](#_bookmark8)]参数responseOEventSchedulerRate。*♩(RS_Diag_04160)*


**[SWS_DM_01119]**{DRAFT} **Support of DEXT parameter DiagnosticResponseOEventClass.maxNumChangeOfDataIdentfierEvents** *[*The Diagnostic Server instance shall map the DEXT parameter DiagnosticResponseOnEvenClass.maxNumChangeOfDataIdentfierEvents to the ISO 14229-1[[1](#_bookmark8)] parameter maxNumChangeOfDataIdentfierEvents.*♩(RS_Diag_04160)*

> **[SWS_DM_01119]**{草案} **支持DEXT参数DiagnosticResponseOEventClass.maxNumChangeOfDataIdentfierEvents** *[*诊断服务器实例应将DEXT参数DiagnosticResponseOnEvenClass.maxNumChangeOfDataIdentfierEvents映射到ISO 14229-1[[1](#_bookmark8)]参数maxNumChangeOfDataIdentfierEvents。*♩(RS_Diag_04160)*


**[SWS_DM_01120]**{DRAFT} **Support of DEXT parameter DiagnosticResponseOEventClass.maxNumComparisionOfValueEvents** *[*The Diagnostic Server instance shall map the DEXT parameter DiagnosticResponseOnEventClass. maxNumComparisionOfValueEvents to the ISO 14229-1[[1](#_bookmark8)] parameter MaxNuComparisionOfValueEvents.*♩(RS_Diag_04160)*

> **[SWS_DM_01120]**{草案} **支持 DEXT 参数 DiagnosticResponseOnEventClass.maxNumComparisionOfValueEvents** *[*诊断服务器实例应将 DEXT 参数 DiagnosticResponseOnEventClass.maxNumComparisionOfValueEvents 映射到 ISO 14229-1[[1](#_bookmark8)]参数 MaxNuComparisionOfValueEvents。*♩(RS_Diag_04160)*


**[SWS_DM_01121]**{DRAFT} **Support of DEXT parameter DiagnosticResponseOEventClass.maxSupportedDIDLength** *[*The Diagnostic Server instance shall map the DEXT parameter DiagnosticResponseOnEventClass.maxSuportedDIDLength to the ISO 14229-1[[1](#_bookmark8)] parameter maxSupportedDIDLength.*♩ (RS_Diag_04160)*

> **[SWS_DM_01121]**{草案} **支持DEXT参数DiagnosticResponseOEventClass.maxSupportedDIDLength** *[*诊断服务器实例应将DEXT参数DiagnosticResponseOnEventClass.maxSuportedDIDLength映射到ISO 14229-1[[1](#_bookmark8)]参数maxSupportedDIDLength。*♩ (RS_Diag_04160)*


**[SWS_DM_01122]**{DRAFT} **Support of DEXT parameter DiagnosticResponseOEventClass.maxNumberOfStoredDTCStatusChangedEvents** *[*The Diagnostic Server instance shall map the DEXT parameter DiagnosticResponseOEventClass.maxNumberOfStoredDTCStatusChangedEvents to the ISO 14221[[1](#_bookmark8)] parameter maxNumberOfStoredDTCStatusChangedEvents.*♩(RS_Diag_04160)*

> **[SWS_DM_01122]**{草案} **支持DEXT参数DiagnosticResponseOEventClass.maxNumberOfStoredDTCStatusChangedEvents** *[*诊断服务器实例必须将DEXT参数DiagnosticResponseOEventClass.maxNumberOfStoredDTCStatusChangedEvents映射到ISO 14221[[1](#_bookmark8)]参数maxNumberOfStoredDTCStatusChangedEvents。*♩(RS_Diag_04160)*


**[SWS_DM_01262]**{DRAFT} **No storage of RoE events** *[*If DiagnosticResposeOnEventClass.storeEventEnabled is set to FALSE and a RoE service with the storeState bit (Bit6) set to true is received, the DM shall deny the request according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04160)*

> 如果DiagnosticResposeOnEventClass.storeEventEnabled设置为FALSE，并且收到具有storeState位（位6）设置为true的RoE服务，根据ISO 14229-1[[1]](#_bookmark8)，DM应拒绝该请求。♩（RS_Diag_04160）


**[SWS_DM_01263]**{DRAFT} **Storage of RoE events** *[*If DiagnosticResponseOEventClass.storeEventEnabled is set to TRUE, the DM shall support the funtionaltiy of the RoE service with the storeState bit (Bit6) set to true according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04160)*

> 如果DiagnosticResponseOEventClass.storeEventEnabled设置为TRUE，根据ISO 14229-1[[1](#_bookmark8)]，DM应支持RoE服务的功能，并将storeState位（位6）设置为true。（RS_Diag_04160）

### Custom Diagnostic Services


In addition to supported UDS diagnostic services, as shown in [Table](#_bookmark108) [7.2](#_bookmark108), an OEM or system supplier may have a need for a diagnostic service which is not the part of the services standardized in ISO 14229-1[[1](#_bookmark8)].

> 除了支持的UDS诊断服务，如[表7.2](#_bookmark108)所示，OEM或系统供应商可能需要一种ISO 14229-1[[1](#_bookmark8)]中未标准化的诊断服务。


**[SWS_DM_00502]**{DRAFT} **Support for Custom Diagnostic Services** *[*The Dianostic Server instance shall provide a service processor on SID level for a cutom services request (defined by DiagnosticCustomServiceInstance), which is specified by a system supplier.*♩(RS_Diag_04177)*

> **[SWS_DM_00502]**{草案} **支持自定义诊断服务** *[*诊断服务器实例应为SID级提供一个服务处理器，以处理由系统供应商指定的自定义服务请求（由DiagnosticCustomServiceInstance定义）。*♩（RS_Diag_04177）*


**[SWS_DM_00983]**{DRAFT} **Processing of Custom Diagnostic Services** *[*The Dagnostic Server instance shall call ara::diag::GenericUDSService:HandleMessage to process a custom UDS service by the given SID.*♩(RS_Diag\04177)*

> **[SWS_DM_00983]**{草案} **处理定制诊断服务** *[*诊断服务器实例应调用ara::diag::GenericUDSService:HandleMessage来处理给定SID的定制UDS服务。*♩(RS_Diag\04177)*


Meta-class DiagnosticCustomServiceInstance can be used to define the istance of a Custom Service. Modeling of Custom Diagnostic Services is described in the TPS Manifest Specification [ [[13](#_bookmark18)]].

> 元类DiagnosticCustomServiceInstance可用于定义自定义服务的实例。自定义诊断服务的建模描述在TPS清单规范[[13]]中。


Note: SID range for custom service requests is defined in Table 2 of ISO 14229-1[[1](#_bookmark8)].

> 注意：自定义服务请求的SID范围定义在ISO 14229-1的表2中[[1](#_bookmark8)]。

### Cancellation of a Diagnostic Conversation


The cancellation of Diagnostic Conversations and external processors is implmented by a CancellationHandler instance. CancellationHandler instance may be part of a service processor implementation also.

> 取消诊断对话和外部处理器的实现由取消处理器实例来完成。取消处理器实例也可能是服务处理器实现的一部分。


The following is the root cause for the cancellation of a Diagnostic Conversation:

> 以下是取消诊断对话的根本原因：


- Replacement by a newly requested Diagnostic Conversation according to [[SWS_DM_00431](#_bookmark68)].

> 根据[[SWS_DM_00431](#_bookmark68)]，更换新请求的诊断对话。


This section describes the actions to be performed on cancellation of a Diagnostic Conversation.

> 这一节描述了在取消诊断对话时要执行的操作。


Cancellation of a Diagnostic Conversation is performed according to the folloing requirements.

> 取消诊断对话的执行必须符合以下要求。


[]{#_bookmark185 .anchor}**[SWS_DM_00277]**{DRAFT} **Cancellation of a Diagnostic Conversation in case of External Service Processing** *[*On Cancellation of a Diagnostic Conversation in case a diagnostic request is currently processed in context of this Diagnostic Coversation by a service processor external to the Diagnostic Server instance, the Diagnostic Server instance shall notify this external service processor, that the processing for this service shall be canceled according to [[SWS_DM_00577](#_bookmark190)].*♩ (RS_Diag_04167)*

> 在外部服务处理器当前正在诊断会话上下文中处理诊断请求的情况下，如果取消诊断会话，诊断服务器实例应通知该外部服务处理器，根据[[SWS_DM_00577](#_bookmark190)]取消该服务的处理。（RS_Diag_04167）


[]{#_bookmark186 .anchor}**[SWS_DM_00278]**{DRAFT} **Cancellation of a Diagnostic Conversation in case of Internal Processing** *[*On Cancellation of a Diagnostic Conversation in case a diagnostic request is currently processed in context of this protocol internally within

> 取消在此协议内部处理诊断请求的情况下的诊断会话


the Diagnostic Server instance, the Diagnostic Server instance shall abort the started activity as far as possible.*♩(RS_Diag_04167)*

> 服务器实例，服务器实例应尽可能地中止已启动的活动（RS_Diag_04167）。


[]{#_bookmark187 .anchor}**[SWS_DM_00279]**{DRAFT} **Cancellation of a Diagnostic Conversation before Rsponse Transmission** *[*On Cancellation of a Diagnostic Conversation in case a diagnostic request is currently processed in context of this protocol and response tranmission has not yet been started, the Diagnostic Server instance shall abort all service processing and skip sending any response, which implies **not** to call ara:diag::uds_transport::UdsTransportProtocolHandler::Transmit of the respective UDS Transport Protocol Handler.*♩(RS_Diag_04167)*

> 如果当前正在根据本协议处理诊断请求，并且尚未开始响应传输，诊断服务器实例应中止所有服务处理，并跳过发送任何响应，这意味着**不**调用相应的UDS传输协议处理程序的ara：diag :: uds_transport :: UdsTransportProtocolHandler :: Transmit。


[]{#_bookmark188 .anchor}**[SWS_DM_00280]**{DRAFT} **Cancellation of a Diagnostic Conversation at Rsponse Transmission** *[*On Cancellation of a Diagnostic Conversation in case a diagnostic request is currently processed in context of this Diagnostic Converstion and ara::diag::uds_transport::UdsTransportProtocolHandler::Transmit of the UDS TransportLayer was already called, nothing has to be done by the Diagnostic Server instance. This implies a sent out response.*♩(RS_Diag\04167)*

> 如果当前在此诊断会话上下文中正在处理诊断请求，并且UDS TransportLayer的ara :: diag :: uds_transport :: UdsTransportProtocolHandler :: Transmit已经被调用，取消诊断会话时不需要诊断服务器实例做任何事情。这意味着发出了响应。(RS_Diag\04167)


[]{#_bookmark189 .anchor}**[SWS_DM_00847]**{DRAFT} **Reinitialization of Service Instance on Cancellation of a Diagnostic Conversation** *[*On Cancellation of a Diagnostic Conversation, the Diagnostic Server instance shall reset the values of the fields of the associated ara::diag::Conversation class Instance according to [[SWS_DM_00843](#_bookmark63)].*♩(RS\Diag_04167)*

> 在取消诊断对话时，诊断服务器实例应根据[[SWS_DM_00843](#_bookmark63)]重置与ara :: diag :: Conversation类实例相关的字段的值。 ♩（RS\ Diag_04167）


[]{#_bookmark190 .anchor}**[SWS_DM_00577]**{DRAFT} **Canceling external service processors** *[*On Cancelation of a Diagnostic Conversation in case a diagnostic request is currently processed within an external service processor, the supporting ara::diag::CacellationHandler shall trigger all notifiers registered via ara::diag::CancelationHandler::SetNotifier.*♩(RS_Diag_04167)*

> 在外部服务处理器中当前处理诊断请求时取消诊断对话，支持ara::diag::CacellationHandler应触发通过ara::diag::CancelationHandler::SetNotifier注册的所有通知器。♩(RS_Diag_04167)


**[SWS_DM_00984]**{DRAFT} **Return of cancellation status** *[*A call to ara::diag::CancellationHandler::IsCanceled shall return false if the corresponding Dagnostic Conversation is not canceled within its current processing state. On Cancellation of this Diagnostic Conversation ara::diag::CancellatioHandler::IsCanceled shall return true until the ara::diag::CancellatioHandler is destructed.*♩(RS_Diag_04167)*

> [SWS_DM_00984]{草案} **取消状态的返回** *[*调用ara::diag::CancellationHandler::IsCanceled应该在其当前处理状态下返回false，如果诊断会话被取消，ara::diag::CancellatioHandler::IsCanceled应该返回true，直到ara::diag::CancellatioHandler被销毁。*♩(RS_Diag_04167)*


**[SWS_DM_01348]**{DRAFT} **Consecutive registration of notifier with CancelltionHandler::SetNotifier()** *[*In case of a consecutive call of ara::diag::CancelationHandler::SetNotifier of the corresponding ara::diag::CancelltionHandler instance, the DM shall overwrite the previous registered notifier.*♩(RS\Diag_04167)*

> **[SWS_DM_01348]**{草案} **使用CancelltionHandler::SetNotifier()进行连续注册的通知者** *[*如果对应的ara::diag::CancelltionHandler实例进行连续调用ara::diag::CancelationHandler::SetNotifier，DM应该覆盖先前注册的通知者。*♩(RS\Diag_04167)*


1. ### Diagnostic SOVD Management

> ### 诊断 SOVD 管理


   1. ### SOVD Conversations and UDS Interplay

> ### SOVD会话与UDS相互作用


With the introduction of SOVD new challenges need to be met regarding parallel client handling. For exclusive client access UDS (ISO 14229-1) uses the extended session mechanism and accordingly SOVD uses the SOVD lock mechanism. Therefore, only one client (UDS or SOVD) with exclusive client access mechanism (extended session or SOVD lock) can have access at a time. For UDS clients in default session respectively SOVD clients without a lock the same parallel client handling rules as described in section [7.6.2.1.1](#parallel-client-handling) apply. Especially since SOVD aims on using the same port instances as UDS (ISO 14229-1) the same preconditions regarding re-entrant interfaces apply for parallel client access.

> 随着SOVD的引入，需要应对关于并行客户端处理的新挑战。为了独家客户端访问，UDS（ISO 14229-1）使用扩展会话机制，因此SOVD使用SOVD锁定机制。因此，一次只能有一个客户端（UDS或SOVD）具有独家客户端访问机制（扩展会话或SOVD锁定）。对于默认会话中的UDS客户端或没有锁定的SOVD客户端，具有相同的并行客户端处理规则，如[7.6.2.1.1]（#parallel-client-handling）中所述。特别是由于SOVD旨在使用与UDS（ISO 14229-1）相同的端口实例，因此关于并行客户端访问的相同预先条件也适用。


**[SWS_DM_01477]**{DRAFT} **SOVD lock in UDS extended session** *[*Acquiring a SOVD lock shall only be possible if no UDS (ISO 14229-1) client is in extended session.*♩ (RS_Diag_04256, RS_Diag_04264)*

> **[SWS_DM_01477]**{草案}**SOVD锁定在UDS扩展会话中** *[*只有在没有UDS（ISO 14229-1）客户端处于扩展会话状态时，才能获得SOVD锁定。*♩（RS_Diag_04256，RS_Diag_04264）*


**[SWS_DM_01476]**{DRAFT} **Parallel SOVD client handling** *[*The DM shall treat a SOVD client without a lock like a UDS (ISO 14229-1) client regarding parallel client handling.*♩ (RS_Diag_04256, RS_Diag_04264)*

> **[SWS_DM_01476]**{草案} **并行 SOVD 客户端处理** *[*DM 应该把没有锁定的 SOVD 客户端当作 UDS（ISO 14229-1）客户端处理并行客户端处理。*♩ (RS_Diag_04256, RS_Diag_04264)*

### SOVD Request Validation and Verification


**[SWS_DM_01475]**{DRAFT} **DM shall allow only one lock per SOVD entity** *[*DM shall not allow a SOVD client to acquire a lock on the SOVD entity (or SOVD sub entity) if another SOVD client has locked the same SOVD entity for accessing or operating on the SOVD entity resource and return error code.*♩(RS_Diag_04256, RS_Diag_04264)*

> **[SWS_DM_01475]**{草案} **DM 应只允许每个 SOVD 实体一把锁** *[*DM 不应允许 SOVD 客户端获取 SOVD 实体（或 SOVD 子实体）的锁，如果另一个 SOVD 客户端已锁定相同的 SOVD 实体以访问或操作 SOVD 实体资源，则应返回错误代码。*♩(RS_Diag_04256，RS_Diag_04264)*


**[SWS_DM_01474]**{DRAFT} **DM shall allow access only to unlocked SOVD entities** *[*DM shall not allow a SOVD client to access a SOVD entity which requires a lock, but the client has not acquired the lock before, and will send HTTP status code 409 as a response.*♩(RS_Diag_04256, RS_Diag_04264)*

> **[SWS_DM_01474]**{草案} **DM 只允许访问未锁定的 SOVD 实体** *[*DM 不允许 SOVD 客户端访问需要锁定的 SOVD 实体，但客户端尚未获得锁定，并将发送 HTTP 状态码 409 作为响应。*♩(RS_Diag_04256, RS_Diag_04264)*

简体中文：**[SWS_DM_01474]**{草案} **DM 仅允许访问未锁定的 SOVD 实体** *[*DM 不允许 SOVD 客户端访问需要锁定的 SOVD 实体，但客户端尚未获得锁定，并将发送 HTTP 状态码 409 作为响应。*♩(RS_Diag_04256, RS_Diag_04264)*


**[SWS_DM_01473]**{DRAFT} **DM shall lock SOVD entity after time expiration** *[*DM shall terminate all resources associated with the lock as well as temporary resources when expiration time for the acquired lock times out. DM shall return HTTP status code 409 as response when SOVD client tries to further access the deleted resources once the lock times out.*♩(RS_Diag_04256, RS_Diag_04264)*

> **[SWS_DM_01473]**{草案} **DM 在时间到期后应锁定 SOVD 实体** *[*DM 在获取的锁到期时，应终止与锁相关的所有资源以及临时资源。当 SOVD 客户端尝试访问锁到期后已删除的资源时，DM 应返回 HTTP 状态码 409 作为响应。*♩(RS_Diag_04256，RS_Diag_04264)*


**[SWS_DM_01472]**{DRAFT} **Redirection to authorization endpoint** *[*If the SOVD server receives a request for the resource for Verifying SOVD Client Credetials at the Vehicle then the DM shall call the method ara::diag::SovdAthorization::GetAuthorizationUrl on the application port mapped via maping to the SoftwareCluster with category PLATFORM and respond with a HTTP sttus code 307 Temporary Redirect and the Location header set to the URL that is returned from the method call.*♩(RS_Diag_04256, RS_Diag_04267)*

> **[SWS_DM_01472]** {草案} **重定向到授权端点** *[*如果SOVD服务器收到验证SOVD客户凭据在车辆上的资源请求，则DM应通过映射到具有类别PLATFORM的SoftwareCluster的应用端口调用ara :: diag :: SovdAthorization :: GetAuthorizationUrl方法，并以HTTP sttus代码307临时重定向和Location头设置为从该方法调用返回的URL做出响应。*♩（RS_Diag_04256，RS_Diag_04267）*

简体中文：**[SWS_DM_01472]**{草案} **重定向到授权端点** *[*如果SOVD服务器收到验证SOVD客户凭据在车辆上的资源请求，则DM应通过映射到具有类别PLATFORM的SoftwareCluster的应用端口调用ara :: diag :: SovdAthorization :: GetAuthorizationUrl方法，并以HTTP sttus代码307临时重定向和Location头设置为从该方法调用返回的URL做出响应。*♩（RS_Diag_04256，RS_Diag_04267）*


**[SWS_DM_01471]**{DRAFT} **Redirection to token endpoint** *[*If the SOVD server rceives a request for the resource for Requesting a Token then the DM shall call the method ara::diag::SovdAuthorization::GetTokenUrl on the application port mapped via mapping to the SoftwareCluster with category PLATFORM and respond with a HTTP status code 307 Temporary Redirect and the Location header set to the URL that is returned from the method call.*♩(RS_Diag_04256, RS\Diag_04267)*

> **[SWS_DM_01471]**{草案} **重定向到令牌端点** *[*如果SOVD服务器接收到请求令牌的资源请求，则DM应调用ara :: diag :: SovdAuthorization :: GetTokenUrl在通过映射到具有类别PLATFORM的SoftwareCluster映射的应用程序端口上，并以HTTP状态代码307临时重定向和设置为从方法调用返回的URL的Location标头响应。*♩（RS_Diag_04256，RS \ Diag_04267）*

简体中文：**[SWS_DM_01471]**{草案} **重定向到令牌端点** *[*如果SOVD服务器接收到请求令牌的资源请求，则DM应调用ara :: diag :: SovdAuthorization :: GetTokenUrl在通过映射到具有类别PLATFORM的SoftwareCluster映射的应用程序端口上，并以HTTP状态码307临时重定向和设置为从方法调用返回的URL的Location标头响应。*♩（RS_Diag_04256，RS \ Diag_04267）*


**[SWS_DM_01470]**{DRAFT} **Authorization validation** *[*If an Authorization HTTP header is included in the request of the SOVD client and the content (token) is not idetical to a token where the validation is still valid, then the Diagnostic Server istance shall call the method ara::diag::SovdAuthorization::ValidateAthorization on the application port mapped via mapping, passing the contents of the Authorization HTTP header of the request as parameter token, and a ara::diag::ClientAuthentication object.*♩(RS_Diag_04256)*

> **[SWS_DM_01470]**{草稿} **授权验证** *[*如果SOVD客户端请求中包含Authorization HTTP标头，并且内容（令牌）与仍有效的令牌不同，则诊断服务器实例应通过映射映射的应用端口调用ara :: diag :: SovdAuthorization :: ValidateAthorization方法，将请求的Authorization HTTP标头的内容作为参数令牌传递，以及ara :: diag :: ClientAuthentication对象。*♩（RS_Diag_04256）*

简体中文：**[SWS_DM_01470]**{草案}**授权验证** *[*如果SOVD客户端请求中包含Authorization HTTP标头，并且内容（令牌）与仍有效的令牌不同，则诊断服务器实例应通过映射映射的应用端口调用ara :: diag :: SovdAuthorization :: ValidateAthorization方法，将请求的Authorization HTTP标头的内容作为参数令牌传递，以及ara :: diag :: ClientAuthentication对象。*♩（RS_Diag_04256）*


**[SWS_DM_01469]**{DRAFT} **Validity period of authenticated roles** *[*If the call to ara::diag::SovdAuthorization::ValidateAuthorization returns a value, then the Diagnostic Server instance shall treat any roles that the application has set as authenticated via the clientAuthentication parameter as authentcated for the current request and may also treat the same roles as authenticated for any further request that is processed no later than the time_point returned from the ara::diag::SovdAuthorization::ValidateAuthorization and where the authrization token is identical.*♩(RS_Diag_04256)*

> 如果调用ara::diag::SovdAuthorization::ValidateAuthorization返回一个值，那么诊断服务器实例应将应用程序通过clientAuthentication参数设置的任何角色视为当前请求的验证，并且也可以将相同的角色视为通过ara::diag::SovdAuthorization::ValidateAuthorization返回的time_point之前处理的任何进一步请求的验证，其中授权令牌相同。


[]{#_bookmark194 .anchor}**[SWS_DM_01468]**{DRAFT} **Check of Environmental Conditions before execuing SOVD methods** *[*Before executing a SOVD method, the Diagnostic Server instance shall evaluate the associated Environmental Conditions according to [[SWS_DM_00111](#_bookmark98)], [[SWS_DM_00112](#_bookmark99)], [[SWS_DM_00286](#_bookmark100)], [[SWS_DM_00287](#_bookmark101)] and [[SWS_DM_00970](#_bookmark102)].*♩(RS_Diag_04256)*

> 在执行SOVD方法之前，诊断服务器实例应根据[[SWS_DM_00111](#_bookmark98)], [[SWS_DM_00112](#_bookmark99)], [[SWS_DM_00286](#_bookmark100)], [[SWS_DM_00287](#_bookmark101)]和[[SWS_DM_00970](#_bookmark102)]来评估相关的环境条件。♩（RS_Diag_04256）


**[SWS_DM_01467]**{DRAFT} **Environmental Condition Check for SOVD evalated to TRUE** *[*If the evaluation of the Environmental Condition according to [[SWS_DM_01468](#_bookmark194)] evaluates to TRUE, the Diagnostic Server instance shall execute the corresponding SOVD method.*♩(RS_Diag_04256)*

> 如果根据[[SWS_DM_01468](#_bookmark194)]的环境条件评估为TRUE，则诊断服务器实例应执行相应的SOVD方法。


**[SWS_DM_01466]**{DRAFT} **Environmental Condition Check for SOVD evalated to FALSE** *[*If the evaluation of the Environmental Condition according to

> **[SWS_DM_01466]**{草案} **SOVD 的环境条件检查评估为假** *[*如果根据环境条件的评估是假的，


[[SWS_DM_01468](#_bookmark194)] evaluates to FALSE, the Diagnostic Server instance shall not execute the corresponding SOVD method and return status code 503.*♩(RS_Diag\04256)*

> [[SWS_DM_01468](#_bookmark194)]的评估结果为FALSE，诊断服务器实例不应执行相应的SOVD方法并返回状态码503。*♩（RS_Diag\04256）*

### SOVD Data Conversion


The exchange of data from a SOVD Client to a SOVD Server and vice versa takes place on an interpreted physical level, whereas internally (as well as for UDS ISO 14220-1 [[1](#_bookmark8)]) the data is expressed by internal data types. To express this transformation SDataDefProps were introduced in Diagnostic Extract Template[[3](#_bookmark10)]. This section dscribes how these transformations shall be interpreted for SOVD and how the subset of a JSON schema that represents a DiagnosticDataElement shall be derived based on Diagnostic Extract Template[[3](#_bookmark10)] so that the Diagnostic Server instance can offer consistent ASAM SOVD [[2](#_bookmark9)] APIs.

> 数据从SOVD客户端到SOVD服务器以及反之交换是在一个被解释的物理层上进行的，而内部（以及UDS ISO 14220-1[[1](#_bookmark8)]）的数据是用内部数据类型表示的。为了表达这种转换，SDataDefProps被引入到诊断提取模板[[3](#_bookmark10)]中。本节描述了这些转换应该如何被SOVD解释，以及如何基于诊断提取模板[[3](#_bookmark10)]派生出表示诊断数据元素的JSON模式的子集，以便诊断服务器实例可以提供一致的ASAM SOVD[[2](#_bookmark9)]API。


**[SWS_DM_01465]**{DRAFT} **SOVD data representation of atomic numeric data** *[*The atomic subset of a SOVD request or response body matching a DiagnosticDataElment with baseTypeEncoding NONE or 2C and a compuMethod of category IDETICAL, LINEAR, SCALE_LINEAR, RAT_FUNC or SCALE_RAT_FUNC as defined in Di-

> **[SWS_DM_01465]**{草案} **SOVD 数据表示原子数字数据** *[*符合DiagnosticDataElment基础类型编码NONE或2C，以及compuMethod为category IDETICAL、LINEAR、SCALE_LINEAR、RAT_FUNC或SCALE_RAT_FUNC的SOVD请求或响应体的原子子集


agnostic Extract Template[[3](#_bookmark10)] shall be of type integer or number and shall derive the JSON schema properties type, minimum, maximum and multipleOf based on baseTypeEncoding, baseTypeSize, dataConstr and compuMethod of the coresponding SwDataDefProps.*♩(RS_Diag_04256)*

> 模板抽取的agnostic应为整数或数字类型，并根据相应SwDataDefProps的baseTypeEncoding、baseTypeSize、dataConstr和compuMethod派生JSON模式属性类型、最小值、最大值和multipleOf。♩(RS_Diag_04256)


**[SWS_DM_01464]**{DRAFT} **SOVD data representation of TEXTTABLE** *[*The atomic subset of a SOVD request or response body matching a DiagnosticDataElement with baseTypeEncoding NONE or 2C and a compuMethod of category TEXTTABLE as defined in Diagnostic Extract Template[[3](#_bookmark10)] shall be of type string with JSON proerty enum. For each compuScale (ordered) one entry of the enum property shall be derived from the vt of the compuConst.*♩(RS_Diag_04256)*

> **[SWS_DM_01464]**{草案} **SOVD 文本表格数据表示** *[*符合基本类型编码为 NONE 或 2C，计算方法为 TEXTTABLE 的诊断数据元素的 SOVD 请求或响应体的原子子集，如诊断提取模板[[3](#_bookmark10)]所定义，应为字符串类型，具有 JSON 属性枚举。对于每个 compuScale（有序），应从 compuConst 的 vt 中派生出一个枚举属性。♩(RS_Diag_04256)*


**[SWS_DM_01463]**{DRAFT} **SOVD data representation of atomic scaled nmeric data with texttable** *[*The atomic subset of a SOVD request or rsponse body matching a DiagnosticDataElement with baseTypeEncoding NONE or 2C and a compuMethod of category SCALE_LINEAR_AND_TEXTTABLE, SCALE_RAT_AND_TEXTTABLE as defined in Diagnostic Extract Template[[3](#_bookmark10)] shall be of type [number, string] or [integer, string], shall derive the JSON schema prameter type, minimum, maximum and multipleOf based on baseTypeEncoing, baseTypeSize, dataConstr, numeric part of the compuMethod and shall derive the JSON schema parameter pattern from the texttable part of the compuMethod.*♩ (RS_Diag_04256)*

> **[SWS_DM_01463]**{草案} **SOVD 数据表示原子规模的数值数据和文本表** *[*符合DiagnosticDataElement的基本编码NONE或2C，以及compuMethod为category SCALE_LINEAR_AND_TEXTTABLE，SCALE_RAT_AND_TEXTTABLE的SOVD请求或响应体的原子子集，应为[number, string]或[integer, string]类型，应从基本编码、基本类型大小、dataConstr和数字部分compuMethod中派生出JSON模式参数类型、最小值、最大值和multipleOf，应从文本表部分compuMethod中派生出JSON模式参数模式。*♩ (RS_Diag_04256)*


**[SWS_DM_01462]**{DRAFT} **SOVD data representation of TAB_NOINTP** *[*The atomic subset of a SOVD request or response body matching a DiagnosticDataElement with baseTypeEncoding NONE or 2C and a compuMethod of category TAB_NOINTP as defined in Diagnostic Extract Template[[3](#_bookmark10)] shall be of type number or integer with

> **[SWS_DM_01462]**{草案} **SOVD 数据表示法 TAB_NOINTP** *[*符合 DiagnosticDataElement 的原子子集的 SOVD 请求或响应体，其基本类型编码为 NONE 或 2C，而 compuMethod 为 Diagnostic Extract Template[[3](#_bookmark10)] 中定义的 TAB_NOINTP 类别，应为数字或整数类型。


a enum property. For each CompuScale an entry of the enum property shall be derived from the vf of the CompuConst.*♩(RS_Diag_04256)*

> 对于每个CompuScale，枚举属性的条目应从CompuConst的vf中派生。♩（RS_Diag_04256）


**[SWS_DM_01461]**{DRAFT} **SOVD data representation of BITFIELD_TEXTTABLE** *[*The atomic subset of a SOVD request or response body matching a DiagnostiDataElement with baseTypeEncoding NONE or 2C and a compuMethod of caegory BITFIELD_TEXTTABLE as defined in Diagnostic Extract Template[[3](#_bookmark10)] shall be of type object and shall derive one entry of type string with property enum per disjunct interval.*♩(RS_Diag_04256)*

> **[SWS_DM_01461]**{草稿} **SOVD 数据表示 BITFIELD_TEXTTABLE** *[*符合DiagnostiDataElement的SOVD请求或响应体的原子子集，其基本类型编码为NONE或2C，计算方法为caegory BITFIELD_TEXTTABLE，如Diagnostic Extract Template[[3](#_bookmark10)] 中所定义，应为对象类型，并且应派生出一个类型为字符串的条目，具有每个不相交区间的枚举属性。*♩(RS_Diag_04256)*


**[SWS_DM_01460]**{DRAFT} **SOVD data representation of baseTypeEncoding IEEE754** *[*The atomic subset of a SOVD request or response body matching a DianosticDataElement with baseTypeEncoding IEEE754 as defined in Diagnostic Extract Template[[3](#_bookmark10)] shall be of type number.*♩(RS_Diag_04256)*

> **[SWS_DM_01460]**{草案} **SOVD 的基础类型编码 IEEE754 的数据表示** *[*与 DiagnosticDataElement 定义的基础类型编码 IEEE754 相匹配的 SOVD 请求或响应体的原子子集，其格式应为数字，参见诊断提取模板[[3](#_bookmark10)]。♩(RS_Diag_04256)*


**[SWS_DM_01459]**{DRAFT} **SOVD data representation of textual Strings** *[*The atomic subset of a SOVD request or response body matching a DiagnosticDataElment with baseTypeEncoding of ISO-8859-1, ISO-8859-2, WINDOWS-1252, UTF-8, UTF-16 or UCS-2 as defined in Diagnostic Extract Template[[3](#_bookmark10)] shall be of type string and the Diagnostic Server instance shall make the conversion based on the encodings to match the charset defined by ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04256)*

> **[SWS_DM_01459]**{草案} **SOVD 文本字符串的数据表示** *[*根据诊断提取模板[[3](#_bookmark10)]中定义的ISO-8859-1、ISO-8859-2、WINDOWS-1252、UTF-8、UTF-16或UCS-2的基础类型编码，SOVD请求或响应体的原子子集匹配的诊断数据元素应为字符串类型，诊断服务器实例应根据编码转换为与ASAM SOVD[[2](#_bookmark9)]定义的字符集匹配。*♩(RS_Diag_04256)*


**[SWS_DM_01458]**{DRAFT} **SOVD data representation of units** *[*The atomic subset of a SOVD request or response body matching a DiagnosticDataElement with a unit referenced as defined in Diagnostic Extract Template[[3](#_bookmark10)] shall include the unit in JSON schema according to ASAM SOVD.*♩(RS_Diag_04256)*

> **[SWS_DM_01458]**{草案} **SOVD 数据表示单位** *[*与定义在诊断提取模板[[3](#_bookmark10)]中引用的单位相匹配的SOVD请求或响应体的原子子集应按 ASAM SOVD 将单位包含在JSON模式中。*♩(RS_Diag_04256)*


**[SWS_DM_01457]**{DRAFT} **SOVD data representation of arrays** *[*The subset of a SOVD request and response body matching a DiagnosticDataElement fulfilling [TPS_DEXT_01001] shall be of type array with content type derived accordingly to the atomic data definition. The JSON property maxItems shall be derived from maxNumberOfElements of the DiagnosticDataElement.*♩(RS_Diag_04256)*

> **[SWS_DM_01457]**{草稿} **SOVD 数组的数据表示** *[*符合[TPS_DEXT_01001]的SOVD请求和响应体的子集应为数组类型，其内容类型应根据原子数据定义相应地派生。JSON属性maxItems应根据DiagnosticDataElement的maxNumberOfElements派生。*♩(RS_Diag_04256)*


4. ### Standardized APIs

> ### 标准化的API

   1. ### Docs


Docs is a standardized resource providing an Online Capability description in form of fully specified, self-contained OpenAPI specification file. The description cotains information which refers to the creation, reading, updating or deleting of the rspective element and its direct child elements as defined by the SOVD standard. The resource docs can be created for the entities SOVD server, Area, Component, App and Function.

> 文档是一种标准化资源，提供形式为完整指定的自包含开放API规范文件的在线能力描述。该描述包含按照SOVD标准定义的相应元素及其直接子元素的创建、读取、更新或删除的信息。可以为SOVD服务器、区域、组件、应用和功能创建文档资源。


**[SWS_DM_01456]**{DRAFT} **SOVD method Query an Online Capability Dscription** *[*Each SOVD entity shall support the SOVD method Query an Oline Capability Description according to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04257)*

> **[SWS_DM_01456]**{草案} **SOVD 方法查询在线能力描述** *[*每个SOVD实体应根据ASAM SOVD[[2](#_bookmark9)]支持SOVD方法查询在线能力描述。*♩(RS_Diag_04257)*

### Version-Info


The SOVD API uses URI based versioning. SOVD clients can determine which vesion is supported by an SOVD server by utilization of the resource version-info and querying the respective URI https://\<SOVD-Server-Host\>/\<OEM specific\>

> API SOVD 使用基于URI的版本控制。SOVD客户端可以通过使用资源版本信息并查询相应的URI https://\<SOVD-Server-Host\>/\<OEM specific\>来确定SOVD服务器支持哪个版本。

/version-info.


**[SWS_DM_01455]**{DRAFT} **SOVD method for SOVD API Versioning** *[*On SOVD Server level the DM shall support the SOVD method to access SOVD version-info according to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04256)*

> **[SWS_DM_01455]**{草案} **SOVD 方法用于 SOVD API 版本控制** *[*在 SOVD 服务器层面，DM 应支持根据 ASAM SOVD[[2](#_bookmark9)]访问 SOVD 版本信息的 SOVD 方法。*♩(RS_Diag_04256)*


**[SWS_DM_01454]**{DRAFT} **Query to the SOVD API version** *[*Querying the SOVD API

> **[SWS_DM_01454]**{草案} **查询SOVD API版本** *[*查询SOVD API


version shall only be supported by SOVD entity SOVD Server.*♩(RS_Diag_04256)*

> 只有 SOVD 实体 SOVD 服务器才支持此版本。♩（RS_Diag_04256）


**[SWS_DM_01453]**{DRAFT} **path to version-info** *[*The path to the resource version-info shall remain the same for this and all future versions of the SOVD API.*♩(RS_Diag_04256)*

> **[SWS_DM_01453]**{草案} **路径到版本信息** *[*SOVD API 的此版本和所有未来版本的资源版本信息路径应保持不变。♩(RS_Diag_04256)*


**[SWS_DM_01452]**{DRAFT} **Mismatching versions** *[*If an SOVD client uses a version not supported by the SOVD server, the server shall respond with HTTP status code 404-Not found.*♩(RS_Diag_04256)*

> **[SWS_DM_01452]**{草案} **版本不匹配** *[*如果SOVD客户端使用的版本不受SOVD服务器支持，服务器将响应HTTP状态码404-未找到。*♩(RS_Diag_04256)*


**[SWS_DM_01451]**{DRAFT} **SOVDInfo type** *[*The resource version-info shall be of type SOVDInfo.*♩(RS_Diag_04256)*

> **[SWS_DM_01451]**{草稿} **SOVDInfo 类型** *[*资源版本信息应为 SOVDInfo 类型。*♩(RS_Diag_04256)*


**[SWS_DM_01450]**{DRAFT} **SOVDInfo type content** *[*The type SOVDInfo shall cotain attributes base_uri and version.*♩(RS_Diag_04256)*

> **[SWS_DM_01450]**{草稿} **SOVDInfo 类型内容** *[*SOVDInfo 类型应包含属性base_uri和version。*♩(RS_Diag_04256)*

### Data-categories


An SOVD client can read and write various kinds of data values from and to a SOVD entity. Available standard data-categories used within data resource collections are identifications, measurements, parameters and system information.

> 一个SOVD客户端可以从SOVD实体读取和写入各种类型的数据值。在数据资源集合中使用的可用标准数据类别包括标识、测量、参数和系统信息。


**[SWS_DM_01449]**{DRAFT} **SOVD method Retrieve Categories Supported by a Data Resource Collection** *[*If a SOVD entity support SOVD data the SOVD method Retrieve Categories Supported by a Data Resource Collection shall be support according to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04256, RS\Diag_04260)*

> 如果SOVD实体支持SOVD数据，根据ASAM SOVD[[2](#_bookmark9)]，应该支持SOVD方法检索数据资源集合支持的类别。（RS_Diag_04256，RS\Diag_04260）


**[SWS_DM_01448]**{DRAFT} **Standard resource Data categories** *[*The standarized resource Data categories shall be supported by the entities SOVD server, Components and Apps.*♩(RS_Diag_04256, RS_Diag_04260)*

> **[SWS_DM_01448]**{草案}**标准资源数据类别** *[*实体SOVD服务器、组件和应用都应支持标准化的资源数据类别。*♩(RS_Diag_04256, RS_Diag_04260)*


**[SWS_DM_01447]**{DRAFT} **Data categories type** *[*The resource datcategories shall be of type DataCategory.*♩(RS_Diag_04256, RS_Diag_04260)*

> **[SWS_DM_01447]**{草稿} **数据类别类型** *[*资源数据类别应为DataCategory类型。*♩(RS_Diag_04256, RS_Diag_04260)*

### Data-groups


Data groups are used to structure data in a specific way (e.g., engine performance related, \...) and are associated with a category.

> 数据组用于以特定方式组织数据（例如，与发动机性能相关的...），并与一个类别相关联。


**[SWS_DM_01446]**{DRAFT} **SOVD method Retrieve Groups Supported by a Data Resource Collection** *[*If a SOVD entity support SOVD data and if the SOVD has at least one SOVD data-group configured, the SOVD method Retrieve Groups Supported by a Data Resource Collection shall be supported acording to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04256, RS_Diag_04260)*

> 如果SOVD实体支持SOVD数据，并且SOVD至少配置了一个SOVD数据组，则应根据ASAM SOVD[[2](#_bookmark9)]支持SOVD方法检索数据资源集支持的组。（RS_Diag_04256，RS_Diag_04260）


**[SWS_DM_01445]**{DRAFT} **Data-groups type** *[*The resource data-groups shall be of type ValueGroup.*♩(RS_Diag_04256, RS_Diag_04260)*

> **[SWS_DM_01445]**{草案} **数据组类型** *[*资源数据组的类型应为ValueGroup。♩(RS_Diag_04256，RS_Diag_04260)*


**[SWS_DM_01444]**{DRAFT} **Data-groups type content** *[*The ValueGroup type shall contain attributes id and category.*♩(RS_Diag_04256, RS_Diag_04260)*

> **[SWS_DM_01444]**{草案} **数据组类型内容** *[*ValueGroup类型应包含属性id和category。*♩(RS_Diag_04256, RS_Diag_04260)*

### Locks


**[SWS_DM_01443]**{DRAFT} **SOVD method for locking** *[*The DM shall support SOVD locks on Diagnostic Server instance level according to ASAM SOVD[[2](#_bookmark9)].*♩(RS\Diag_04256, RS_Diag_04264)*

> **[SWS_DM_01443]**{草稿} **SOVD 方法进行锁定** *[*DM 应根据 ASAM SOVD[[2](#_bookmark9)] 在诊断服务器实例级别支持 SOVD 锁。*♩(RS\Diag_04256, RS_Diag_04264)*

### Configurable APIs


This section describes how the Diagnostic Server instance provides confiurable SOVD APIs as specified in ASAM SOVD[[2](#_bookmark9)] based on the modelling in Diagnostic Extract Template[[3](#_bookmark10)]. Generally, this section aims to provide SOVD APIs for existing UDS Services introduced for ISO 14229-1[[1](#_bookmark8)] and reuse the existing configuration patterns, e.g., a DiagnosticDataIdentifier with Service ReadByIdentifier (0x22) of ISO 14221[[1](#_bookmark8)] configured according to Diagnostic Extract Template[[3](#_bookmark10)] shall also offer the method SOVD GET data request using the same interface instance for data querying. Currently supported configurable SOVD methods are available for:

> 本节介绍了诊断服务器实例如何提供根据诊断提取模板[[3](#_bookmark10)]指定的可配置SOVD API[[2](#_bookmark9)]。通常，本节旨在为ISO 14229-1[[1](#_bookmark8)]引入的现有UDS服务提供SOVD API，并重用现有的配置模式，例如，根据诊断提取模板[[3](#_bookmark10)]配置的ISO 14221[[1](#_bookmark8)]的Service ReadByIdentifier（0x22）的诊断数据标识符也可以使用相同的接口实例提供SOVD GET数据请求方法。目前支持的可配置SOVD方法可用于：

- SOVD data
- SOVD configuration (parameter only)
- SOVD faults
- SOVD operations


Additionally, two predefined SOVD modes for CommunicationControl and CotrolDTCSetting services are specified.

> 此外，还为CommunicationControl和CotrolDTCSetting服务指定了两种预定义的SOVD模式。

### Data


**[SWS_DM_01442]**{DRAFT} **SOVD method Retrieve List of All Data Prvided by the Entity** *[*If at least one SOVD data is configured according to Diagnostic Extract Template[[3](#_bookmark10)] the Diagnostic Server instance shall provide the SOVD method Retrieve List of All Data Provided by the Entity acording to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04260)*

> **[SWS_DM_01442]**{草案} **SOVD 方法检索实体提供的所有数据列表** *[*如果根据诊断提取模板[[3](#_bookmark10)]至少配置了一个SOVD数据，诊断服务器实例应根据ASAM SOVD[[2](#_bookmark9)]提供SOVD方法检索实体提供的所有数据列表。*♩(RS_Diag_04260)*


**[SWS_DM_01441]**{DRAFT} **SOVD data attribute id** *[*The SOVD attribute id of a SOVD data shall be derived from the shortName of the corresponding DiagnostiDataElement.*♩(RS_Diag_04260)*

> **[SWS_DM_01441]**{草案} **SOVD 数据属性ID** *[*SOVD 数据的 SOVD 属性 ID 应该从相应的 DiagnostiDataElement 的简称中派生出来。♩(RS_Diag_04260)*


**[SWS_DM_01440]**{DRAFT} **SOVD data attribute name** *[*The SOVD attribute name of a SOVD data shall be derived from the longName of the corresponding DiagnostiDataElement.*♩(RS_Diag_04260)*

> **[SWS_DM_01440]**{草稿} **SOVD数据属性名称** *[*SOVD数据的SOVD属性名称应该从相应的DiagnostiDataElement的longName中派生。*♩(RS_Diag_04260)*


**[SWS_DM_01439]**{DRAFT} **SOVD data attribute category** *[*The SOVD attribute caegory of a SOVD data shall be modelled using a SDG on the DiagnosticDataElment with semantics as defined in [SovdSdgExample.arxml](#_bookmark204).*♩(RS_Diag_04260)*

> **[SWS_DM_01439]**{草案} **SOVD 数据属性类别** *[*SOVD 数据的属性类别应使用[SovdSdgExample.arxml](#_bookmark204)中定义的语义在 DiagnosticDataElement 上建模。*♩(RS_Diag_04260)*


**Listing 7.1: SovdSdgExample.arxml. SDG class for category of SOVD data. Including SDG-CLASS definition and an example.**

> 列表7.1：SovdSdgExample.arxml。SOVD数据类别的SDG类。包括SDG-CLASS定义和一个示例。


**[SWS_DM_01438]**{DRAFT} **SOVD data attribute group** *[*The SOVD group of a SOVD data shall be derived as described in Diagnostic Extract Template[[3](#_bookmark10)].*♩(RS_Diag\04260)*

> **[SWS_DM_01438]**{草案} **SOVD 数据属性组** *[*SOVD 数据的 SOVD 组应按照诊断提取模板[[3](#_bookmark10)]中的描述进行派生。*♩(RS_Diag\04260)*


**[SWS_DM_01437]**{DRAFT} **SOVD group category uniqueness** *[*The aggregated SOVD data within one SOVD group shall all be of the same SOVD category.*♩(RS\Diag_04260)*

> **[SWS_DM_01437]**{草案} **SOVD 组别的唯一性** *[*SOVD 组内的聚合 SOVD 数据必须属于同一 SOVD 类别。*♩(RS\Diag_04260)*


**[SWS_DM_01436]**{DRAFT} **SOVD group attribute category** *[*The SOVD attribute category of a SOVD group shall be derived by the category of the SOVD data within the SOVD group.*♩(RS_Diag_04260)*

> **[SWS_DM_01436]**{草案} **SOVD 组属性类别** *[*SOVD 组的 SOVD 属性类别应根据 SOVD 组中 SOVD 数据的类别派生出来。*♩(RS_Diag_04260)*


**[SWS_DM_01435]**{DRAFT} **SOVD group id** *[*The SOVD attribute id of a SOVD group shall be derived from the shortName of the corresponding collection.*♩(RS_Diag\04260)*

> **[SWS_DM_01435]**{草案} **SOVD 组 ID** *[*SOVD 属性 ID 必须来自对应集合的简称。*♩(RS_Diag\04260)*


**[SWS_DM_01434]**{DRAFT} **SOVD data attribute data of internal structure** *[*The SOVD attribute data of a SOVD data shall be represented by a JSON object literal with one entry per DiagnosticParameter of the corresponding DiagnostiDataIdentifier. The key of each entry shall be derived from the shortName of the corresponding DiagnosticDataElement.*♩(RS_Diag_04260)*

> **[SWS_DM_01434]**{草案} **SOVD 数据属性数据的内部结构** *[*SOVD 数据的属性数据应以一个 JSON 对象文字表示，每个与相应的 DiagnostiDataIdentifier 相关的 DiagnosticParameter 都有一个条目。每个条目的键应由相应的 DiagnosticDataElement 的 shortName 派生而来。*♩(RS_Diag_04260)*


**[SWS_DM_01433]**{DRAFT} **SOVD method Read Single Data Value from an Entity** *[*For each SOVD data with Service ReadDataByIdentifier (0x22) configured acording to Diagnostic Extract Template[[3](#_bookmark10)] the Diagnostic Server instance shall provide the SOVD method Read Single Data Value from an Entity accoring to ASAM SOVD [[2](#_bookmark9)].*♩(RS_Diag_04260)*

> **[SWS_DM_01433]**{草案} **SOVD 方法从实体中读取单个数据值** *[*根据诊断提取模板[[3](#_bookmark10)]配置的每个SOVD数据和服务ReadDataByIdentifier (0x22)，诊断服务器实例应按照ASAM SOVD [[2](#_bookmark9)]提供SOVD方法从实体中读取单个数据值。*♩(RS_Diag_04260)*


**[SWS_DM_01432]**{DRAFT} **SOVD method Read Single Data Value from an Entity data query** *[*The SOVD attribute data in the response body of the SOVD method Read Single Data Value from an Entity shall be queried analog to Service ReadDataByIdentifier (0x22) of ISO 14229-1[[1](#_bookmark8)] using the same instance of the data querying mechanism.*♩(RS_Diag_04260)*

> **[SWS_DM_01432]**{草稿} **SOVD 方法从实体数据查询中读取单个数据值** *[*SOVD 属性数据应该按照ISO 14229-1[[1](#_bookmark8)]的Service ReadDataByIdentifier (0x22) 使用相同的数据查询机制实例查询SOVD方法从实体中读取单个数据值的响应体中的数据。*♩(RS_Diag_04260)*


**[SWS_DM_01431]**{DRAFT} **SOVD method Write a Data Value to an Entity** *[*For each SOVD data with Service WriteDataByIdentifier (0x2E) configured according to Diagnostic Extract Template[[3](#_bookmark10)] the Diagnostic Server Instance shall provide the SOVD method Write Single Data Value from an Entity according to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04260)*

> **[SWS_DM_01431]**{草稿} **将数据值写入实体的SOVD方法** *[*对于按照诊断提取模板[[3](#_bookmark10)]配置的每个SOVD数据使用Service WriteDataByIdentifier (0x2E)，诊断服务器实例应按照ASAM SOVD[[2](#_bookmark9)]提供SOVD方法从实体中写入单个数据值。*♩(RS_Diag_04260)*


**[SWS_DM_01430]**{DRAFT} **SOVD method Write a Data Value to an Entity data processing** *[*The SOVD attribute data in the request body of the SOVD method Write a Data Value to an Entity shall be processed analog to Service WritDataByIdentifier (0x2E) of ISO 14229-1[[1](#_bookmark8)] using the same instance of the processing mechanism.*♩(RS_Diag_04260)*

> **[SWS_DM_01430]**{草案} **SOVD 方法将数据值写入实体数据处理** *[*SOVD方法写入数据值到实体的请求体中的SOVD属性数据将按照ISO 14229-1[[1](#_bookmark8)]的Service WritDataByIdentifier (0x2E) 的方式使用相同的处理机制实例进行处理。*♩(RS_Diag_04260)*

### Configuration


**[SWS_DM_01429]**{DRAFT} **SOVD method Retrieve List of All Configurtions Provided by the Entity** *[*If at least one SOVD configuration is configured according to Diagnostic Extract Template[[3](#_bookmark10)] the Diagnostic Server instance shall provide the SOVD method Retrieve List of All Configurations Prvided by the Entity according to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04261)*

> **[SWS_DM_01429]**{草案} **SOVD 方法检索实体提供的所有配置列表** *[*如果按照诊断提取模板[[3](#_bookmark10)]至少配置了一个SOVD配置，诊断服务器实例应按照ASAM SOVD[[2](#_bookmark9)]提供SOVD方法检索实体提供的所有配置列表。*♩(RS_Diag_04261)*


**[SWS_DM_01428]**{DRAFT} **SOVD configuration attribute id** *[*The SOVD attribute id of a SOVD configuration shall be derived from the shortName of the corresponding DiagnosticDataElement.*♩(RS_Diag_04261)*

> **[SWS_DM_01428]**{草案} **SOVD 配置属性 ID** *[*SOVD 配置的属性 ID 应从相应的 DiagnosticDataElement 的 shortName 中派生。*♩(RS_Diag_04261)*


**[SWS_DM_01427]**{DRAFT} **SOVD configuration attribute name** *[*The SOVD attribute name of a SOVD configuration shall be derived from the longName of the corresponding DiagnosticDataElement.*♩(RS_Diag_04261)*

> **[SWS_DM_01427]**{草稿} **SOVD 配置属性名称** *[*SOVD 配置的属性名称应当从相应的诊断数据元素的 longName 中派生而来。♩(RS_Diag_04261)*


**[SWS_DM_01426]**{DRAFT} **SOVD configuration attribute type** *[*The SOVD attribute type of a SOVD configuration shall be a constant of type string with value parameter.*♩ (RS_Diag_04261)*

> **[SWS_DM_01426]**{草案} **SOVD 配置属性类型** *[*SOVD 配置的 SOVD 属性类型应为具有值参数的字符串类型的常量。♩ (RS_Diag_04261)*


**[SWS_DM_01425]**{DRAFT} **SOVD configuration attribute version and cotent_type** *[*The SOVD attribute version and content_type of a SOVD configration shall not be supported.*♩(RS_Diag_04261)*

> **[SWS_DM_01425]**{草案} **SOVD 配置属性版本和内容类型** *[*不支持SOVD配置的SOVD属性版本和内容类型。*♩(RS_Diag_04261)*


**[SWS_DM_01424]**{DRAFT} **SOVD method Read Configuration as Paramters** *[*For each SOVD configuration with Service ReadDataByIdentifier (0x22) cofigured according to Diagnostic Extract Template[[3](#_bookmark10)] the Diagnostic Server istance shall provide the SOVD method Read Configuration as Parameters according to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04261)*

> **[SWS_DM_01424]**{草案} **SOVD 方法读取配置作为参数** *[*根据诊断提取模板[[3](#_bookmark10)]配置的每个SOVD配置的服务ReadDataByIdentifier (0x22)，诊断服务实例应根据ASAM SOVD[[2](#_bookmark9)]提供SOVD方法读取配置作为参数。*♩(RS_Diag_04261)*


**[SWS_DM_01423]**{DRAFT} **SOVD method Read Configuration as Paramters data query** *[*The SOVD attribute data in the response body of the SOVD method Read Configuration as Parameters shall be queried analog to Service ReaDataByIdentifier (0x22) of ISO 14229-1[[1](#_bookmark8)] using the same instance of the data querying mechanism.*♩(RS_Diag_04261)*

> **[SWS_DM_01423]**{草稿} **SOVD 方法读取配置作为参数数据查询** *[*SOVD属性数据应使用相同的数据查询机制的实例，按照ISO 14229-1[[1](#_bookmark8)]的Service ReaDataByIdentifier (0x22)的方式查询SOVD方法读取配置作为参数的响应体中的数据。*♩(RS_Diag_04261)*


**[SWS_DM_01422]**{DRAFT} **SOVD method Write Configuration as Paramters** *[*For each SOVD data with Service WriteDataByIdentifier (0x2E) configured acording to Diagnostic Extract Template[[3](#_bookmark10)] the Diagnostic Server instance shall provide the SOVD method Write Configuration as Parameters according to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04261)*

> **[SWS_DM_01422]**{草稿} **SOVD 方法写入配置作为参数** *[*对于使用服务WriteDataByIdentifier (0x2E) 根据诊断提取模板[[3](#_bookmark10)] 配置的每个SOVD数据，诊断服务实例应按照ASAM SOVD[[2](#_bookmark9)]提供SOVD方法写入配置作为参数。*♩(RS_Diag_04261)*


**[SWS_DM_01421]**{DRAFT} **SOVD method Write Configuration as Paramters data processing** *[*The SOVD attribute data in the request body of the SOVD method Write Configuration as Parameters shall be processed analog to Service WriteDataByIdentifier (0x2E) of ISO 14229-1[[1](#_bookmark8)] using the same instance of the processing mechanism.*♩(RS_Diag_04261)*

> **[SWS_DM_01421]**{草稿} **SOVD 方法将配置作为参数数据处理** *[*SOVD 属性数据在SOVD方法Write Configuration as Parameters的请求体中应按照ISO 14229-1[[1](#_bookmark8)]的Service WriteDataByIdentifier (0x2E)使用相同的处理机制实例进行处理。*♩(RS_Diag_04261)*

### Data-list


**[SWS_DM_01420]**{DRAFT} **SOVD data-list** *[*The Diagnostic Server instance shall provide the SOVD methods Retrieve List of All Data-Lists Prvided by the Entity, Creating a Data List for Reading Multiple Data Values at Once from an Entity, Read Multiple Data Values at Once from an Entity Using a Data List and Delete an Existing Data List according ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04260)*

> **[SWS_DM_01420]**{草案} **SOVD 数据列表** *[*诊断服务器实例应提供 SOVD 方法，从实体处获取所有数据列表列表，创建用于一次读取多个数据值的数据列表，使用数据列表一次从实体处读取多个数据值，以及根据ASAM SOVD[[2](#_bookmark9)]删除现有数据列表。*♩(RS_Diag_04260)*


**[SWS_DM_01419]**{DRAFT} **SOVD method Read Multiple Data Values at Once from an Entity Using a Data List** *[*The response body for SOVD method Read Multiple Data Values at Once from an Entity Using a Data List shall be queried analog to SOVD method Read Single Data Value from an Entity.*♩(RS_Diag_04260)*

> **[SWS_DM_01419]**{草案} **SOVD 方法一次从实体中读取多个数据值** *[*SOVD 方法从实体中读取单个数据值的响应体应该按照 SOVD 方法查询。♩（RS_Diag_04260）*

**[SWS_DM_01419]**{草案} **SOVD 方法一次从实体中读取多个数据值** *[*SOVD 方法从实体中读取单个数据值的响应体应该按照 SOVD 方法查询。♩（RS_Diag_04260）*

### Faults


**[SWS_DM_01418]**{DRAFT} **SOVD faults** *[*Each DiagnosticTroubleCodeUds cofigured according to Diagnostic Extract Template[[3](#_bookmark10)] shall express a SOVD fault.*♩(RS\Diag_04259)*

> **[SWS_DM_01418]**{草稿} **SOVD 故障** *[*根据诊断提取模板[[3](#_bookmark10)]配置的每个DiagnosticTroubleCodeUds都应表达一个SOVD故障*♩(RS\Diag_04259)*


**[SWS_DM_01417]**{DRAFT} **SOVD method Read Faults from an Entity** *[*If at least one SOVD fault is configured the Diagnostic Server instance shall provide the SOVD method Read Faults from an Entity according to ASAM SOVD[[2](#_bookmark9)].*♩ (RS_Diag_04259)*

> **[SWS_DM_01417]**{草稿} **SOVD 方法从实体读取故障** *[*如果至少配置了一个 SOVD 故障，诊断服务器实例应按照 ASAM SOVD[[2](#_bookmark9)] 提供 SOVD 方法从实体读取故障。*♩ (RS_Diag_04259)*


**[SWS_DM_01416]**{DRAFT} **SOVD method Read Details for a Fault** *[*For each SOVD fault configured the Diagnostic Server instance shall provide the SOVD method Read Details for a Fault according to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag\04259)*

> **[SWS_DM_01416]**{草案} **SOVD 方法读取故障详细信息** *[*对于每个配置的SOVD故障，诊断服务器实例应根据ASAM SOVD[[2](#_bookmark9)]提供SOVD方法读取故障详细信息。*♩(RS_Diag\04259)*


**[SWS_DM_01415]**{DRAFT} **SOVD fault general attributes** *[*The SOVD attributes code, scope, display_code, fault_name, severity of a SOVD fault shall be derived from Diagnostic Extract Template[[3](#_bookmark10)] according to [Table](#_bookmark208) [7.4](#_bookmark208).*♩(RS_Diag_04259)*

> **[SWS_DM_01415]**{草稿} **SOVD 故障一般属性** *[*SOVD 属性代码、范围、显示代码、故障名称和严重性应根据诊断提取模板[[3](#_bookmark10)]按照[表](#_bookmark208) [7.4](#_bookmark208)获得。*♩(RS_Diag_04259)*


**Table 7.4: Response Body for SOVD fault attributes**

> 表7.4：SOVD故障属性的响应体


**[SWS_DM_01414]**{DRAFT} **SOVD fault attribute status** *[*The SOVD attribute status of a SOVD fault shall be a JSON object literal with entries according to the DTC Status Mask as specified by ISO 14229-1.*♩(RS_Diag_04259)*

> **[SWS_DM_01414]**{草案} **SOVD故障属性状态** *[*SOVD故障的SOVD属性状态应该是根据ISO 14229-1规定的DTC状态掩码拥有条目的JSON对象文字。*♩(RS_Diag_04259)*


**[SWS_DM_01413]**{DRAFT} **SOVD fault attribute symptom** *[*The SOVD attribute symtom of a SOVD fault shall be modelled using a SDG on the DiagnosticTrobleCodeUds with semantics as defined in [SovdSdgExample1.arxml](#_bookmark209).*♩(RS_Diag\04259)*

> **[SWS_DM_01413]**{草稿} **SOVD 故障属性症状** *[*使用SDG在DiagnosticTrobleCodeUds上建模SOVD故障的SOVD属性症状，语义如[SovdSdgExample1.arxml](#_bookmark209)中定义。*♩(RS_Diag\04259)*


**Table 7.5: Response Body for SOVD fault environment_data**

> 表7.5：SOVD故障环境数据的响应体

*♩(RS_Diag_04259)*


**[SWS_DM_01409]**{DRAFT} **SOVD method Delete All Faults of an Entity** *[*If at least one SOVD fault is configured the Diagnostic Server instance shall provide the SOVD method Delete All Faults of an Entity according to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04259)*

> **[SWS_DM_01409]**{草案} **SOVD 方法删除实体的所有故障** *[*如果至少配置了一个SOVD故障，诊断服务器实例应按照ASAM SOVD[[2](#_bookmark9)]提供SOVD方法删除实体的所有故障。*♩(RS_Diag_04259)*


**[SWS_DM_01408]**{DRAFT} **SOVD method Delete All Faults of an Entity with scope** *[*On request of SOVD method Delete All Faults of an Entity with query parameter scope the Diagnostic Server instance shall match the

> **[SWS_DM_01408]**{草稿} **SOVD 方法删除实体的所有故障，范围** *[*根据 SOVD 方法删除实体的所有故障的请求，诊断服务器实例必须与查询参数范围匹配


[]{#_bookmark212 .anchor}query parameter scope to the shortName of all MemoryDestinations. If the prameter matches a MemoryDestination, all DiagnosticTroubleCodeUds in the MemoryDestination shall be cleared analog to Service ClearDiagnosticInformation (0x14) of ISO 14229-1[[1](#_bookmark8)], else the processing shall return status code 400.*♩(RS\Diag_04259)*

> 如果参数与MemoryDestination匹配，则按照ISO 14229-1[1]中的服务ClearDiagnosticInformation（0x14）清除所有MemoryDestination中的DiagnosticTroubleCodeUds，否则处理将返回状态码400。♩（RS\Diag_04259）


**[SWS_DM_01407]**{DRAFT} **SOVD method Delete All Faults of an Entity without scope** *[*On request of SOVD method Delete All Faults of an Etity without the query parameter scope the Diagnostic Server instance shall clear all DiagnosticTroubleCodeUds analog to Service ClearDiagnosticInformtion (0x14) of ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04256, RS_Diag_04259)*

> **[SWS_DM_01407]**{草案} **SOVD方法删除实体的所有故障，而无需范围** *[*在无查询参数范围的SOVD方法删除实体的请求下，诊断服务器实例应清除类似于ISO 14229-1[[1](#_bookmark8)]的Service ClearDiagnosticInformtion（0x14）的所有DiagnosticTroubleCodeUds。*♩（RS_Diag_04256，RS_Diag_04259）*


**[SWS_DM_01406]**{DRAFT} **SOVD method Delete Single Fault of an Etity** *[*For each SOVD fault configured the Diagnostic Server instance shall provide the SOVD method Delete Single Fault of an Entity according to ASAM SOVD[[2](#_bookmark9)] and clear the corresponding DiagnosticTroubleCodeUds analog to Service ClearDiagnosticInformation (0x14) of ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04259)*

> **[SWS_DM_01406]**{草稿} **SOVD 方法删除单个实体的故障** *[*对于每个配置的SOVD故障，诊断服务器实例应根据ASAM SOVD[[2](#_bookmark9)]提供SOVD方法删除单个实体，并清除相应的DiagnosticTroubleCodeUds，类似于ISO 14229-1[[1](#_bookmark8)]的Service ClearDiagnosticInformation（0x14）。*♩（RS_Diag_04259）*

### Operations


**[SWS_DM_01405]**{DRAFT} **SOVD operations** *[*Each DiagnosticRoutine confiured according to Diagnostic Extract Template[[3](#_bookmark10)] shall express a SOVD operation.*♩ (RS_Diag_04262)*

> **[SWS_DM_01405]**{草案} **SOVD操作** *[*每个按照诊断提取模板[[3](#_bookmark10)]配置的诊断例程应表达一个SOVD操作。*♩ (RS_Diag_04262)*


**[SWS_DM_01404]**{DRAFT} **SOVD method Retrieve List of All Available Operations from an Entity** *[*If at least one SOVD operation is configured the Diagnostic Server instance shall provide the SOVD method Retrieve List of All Available Operations from an Entity according to ASAM SOVD[[2](#_bookmark9)].*♩ (RS_Diag_04262)*

> **[SWS_DM_01404]**{草稿} **SOVD 方法从实体中检索所有可用操作的列表** *[*如果至少配置了一个SOVD操作，则诊断服务器实例根据ASAM SOVD[[2](#_bookmark9)]提供SOVD方法从实体中检索所有可用操作的列表。*♩(RS_Diag_04262)*


**[SWS_DM_01403]**{DRAFT} **SOVD method Get Details of a Single Opertion** *[*For each SOVD operation configured the Diagnostic Server instance shall provide the SOVD method Get Details of a Single Operation accoring to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04262)*

> **[SWS_DM_01403]**{草稿} **SOVD 方法获取单个操作的详细信息** *[*根据ASAM SOVD[[2](#_bookmark9)]，诊断服务器实例应提供配置的每个SOVD操作的SOVD方法获取单个操作的详细信息。*♩(RS_Diag_04262)*


**[SWS_DM_01402]**{DRAFT} **SOVD operation attribute id** *[*The SOVD attribute id of a SOVD operation shall be derived from the shortName of the corresponding DiagnoticRoutine.*♩(RS_Diag_04262)*

> **[SWS_DM_01402]**{草案} **SOVD操作属性ID** *[*SOVD操作的SOVD属性ID应从相应的DiagnoticRoutine的shortName派生。*♩(RS_Diag_04262)*


**[SWS_DM_01401]**{DRAFT} **SOVD operation attribute name** *[*The SOVD attribute name of a SOVD operation shall be derived from the longName of the corresponding DianosticRoutine.*♩(RS_Diag_04262)*

> **[SWS_DM_01401]**{草稿} **SOVD操作属性名称** *[*SOVD操作的属性名称应从相应的DianosticRoutine的longName中派生。*♩(RS_Diag_04262)*


**[SWS_DM_01400]**{DRAFT} **SOVD operation attribute proxiity_proof_required** *[*The SOVD attribute proximity_proof_required of a SOVD operation shall be modelled using a SDG on the DiagnosticRoutine with semantics as defined in [SovdSdgExample2.arxml](#_bookmark212)*♩(RS_Diag_04262)*

> **[SWS_DM_01400]**{草案} **SOVD 操作属性proxiity_proof_required** *[*SOVD 操作的proxiity_proof_required属性应使用SDG在DiagnosticRoutine上建模，其语义如[SovdSdgExample2.arxml](#_bookmark212)中定义*♩(RS_Diag_04262)*


**Listing 7.3: SovdSdgExample2.arxml. SDG class for proximity_proof_required of SOVD operations. Including SDG-CLASS definition and an example.**

> **列表7.3：SovdSdgExample2.arxml。SOVD操作的接近证明要求的SDG类。包括SDG-CLASS定义和一个例子。**


**[SWS_DM_01399]**{DRAFT} **SOVD operation attribute asynchronous_execution** *[*If the DiagnosticRoutine only has a DiagnosticStartRoutine and no DianosticStopRoutine and no DiagnosticRequestRoutineResults configured, the attribute asynchronous_execution of the corresponding SOVD operation shall be false, else the attribute shall be true.*♩(RS_Diag_04262)*

> **[SWS_DM_01399]**{草案} **SOVD操作属性asynchronous_execution** *[*如果DiagnosticRoutine只有DiagnosticStartRoutine而没有DianosticStopRoutine和DiagnosticRequestRoutineResults配置，则相应SOVD操作的属性asynchronous_execution应为false，否则应为true。*♩(RS_Diag_04262)*

简体中文：**[SWS_DM_01399]**{草案} **SOVD操作属性asynchronous_execution** *[*如果DiagnosticRoutine只有DiagnosticStartRoutine而没有DianosticStopRoutine和DiagnosticRequestRoutineResults配置，则相应SOVD操作的属性asynchronous_execution应为false，否则应为true。*♩(RS_Diag_04262)*


**[SWS_DM_01398]**{DRAFT} **SOVD operation proximity_challenge** *[*If the SOVD attribute proximity_proof_required of a SOVD operation is true the Diagnostic Server Instance shall return the attribute proximity_challenge in the response body of SOVD method Get Details of a Single Operation using ara:diag::SovdProximityChallenge::GetChallenge, else the attribute proxiity_challenge shall not be supported in the response body.*♩(RS_Diag_04262)*

> 如果SOVD操作的proximity_proof_required属性为true，诊断服务器实例将使用ara：diag :: SovdProximityChallenge :: GetChallenge在SOVD方法Get Details of a Single Operation的响应体中返回proximity_challenge属性，否则在响应体中不支持proxiity_challenge属性。(RS_Diag_04262)


**[SWS_DM_01397]**{DRAFT} **SOVD operation mode** *[*The SOVD attribute modes of a

> **[SWS_DM_01397]**{草案} **SOVD 操作模式** *[*SOVD 属性模式


SOVD operation shall not be supported.*♩(RS_Diag_04262)*

> 不支持SOVD操作。


**[SWS_DM_01396]**{DRAFT} **SOVD method Start Execution of an Operation** *[*For each SOVD operation configured the Diagnostic Server Instance shall provide the SOVD method Start Execution of an Operation according to ASAM SOVD[[2](#_bookmark9)]. The Diagnostic Server Instance shall execute the method analog to Service RotineControl (0x31) with SubFunction Start (0x01) of ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04262)*

> **[SWS_DM_01396]**{草案} **SOVD 方法开始执行操作** *[*每个配置的SOVD操作，诊断服务器实例应根据ASAM SOVD[[2](#_bookmark9)]提供SOVD方法开始执行操作。诊断服务器实例应根据ISO 14229-1[[1](#_bookmark8)]的服务RotineControl（0x31）和子功能Start（0x01）来执行该方法。*♩(RS_Diag_04262)*


**[SWS_DM_01395]**{DRAFT} **SOVD method Start Execution of an Operation proximity_response** *[*The proximity_reponse in the request body of SOVD method Start Execution of an Operation shall be validated using ara:diag::SovdProximityChallenge::GetChallenge.*♩(RS_Diag_04262)*

> **[SWS_DM_01395]**{草案} **SOVD方法启动操作的近距离响应** *[*使用ara:diag::SovdProximityChallenge::GetChallenge来验证SOVD方法启动操作的请求体中的近距离响应。*♩(RS_Diag_04262)*


**[SWS_DM_01394]**{DRAFT} **SOVD method Get Executions of an Operation** *[*For each SOVD operation supporting asynchronous_execution the Diagnostic Server instance shall support the SOVD method Get Executions of an Oeration according to SOVD SOVD[[2](#_bookmark9)].*♩(RS_Diag_04262)*

> **[SWS_DM_01394]**{草案} **SOVD 方法获取操作的执行** *[*对于每个支持异步执行的SOVD操作，诊断服务器实例应根据SOVD SOVD[[2](#_bookmark9)]支持SOVD方法获取操作的执行。*♩(RS_Diag_04262)*


**[SWS_DM_01393]**{DRAFT} **SOVD method Get the Status of an Operation Execution** *[*For each DiagnosticRoutine with DiagnosticRequestRotineResults the SOVD Server Instance shall provide the SOVD method Get the Status of an Operation Execution according to SOVD SOVD[[2](#_bookmark9)]. The Dianostic Server instance shall execute the method analog to Service RoutineCotrol (0x31) with RequestResults (0x03) of ISO 14229-1[[1](#_bookmark8)] using the same instance of the processing mechanism.*♩(RS_Diag_04262)*

> **[SWS_DM_01393]**{草案} **SOVD 方法获取操作执行状态** *[*对于每个具有DiagnosticRequestRotineResults的DiagnosticRoutine，SOVD服务器实例应根据SOVD SOVD[[2](#_bookmark9)]提供SOVD方法获取操作执行状态。 Dianostic服务器实例应使用相同的处理机制实例执行ISO 14229-1[[1](#_bookmark8)]的Service RoutineCotrol（0x31）和RequestResults（0x03）方法。*♩(RS_Diag_04262)*


**[SWS_DM_01392]**{DRAFT} **SOVD method Stop the Execution of an Opeation** *[*For each DiagnosticRoutine with DiagnosticStopRoutine the SOVD Server Instance shall provide the SOVD method Stop the Execution of an Oeration according to SOVD SOVD[[2](#_bookmark9)]. The Diagnostic Server instance shall execute the method analog to Service RoutineControl (0x31) with Stop (0x02) of ISO 14229-1[[1](#_bookmark8)] using the same instance of the processing mechanism.*♩(RS_Diag_04262)*

> **[SWS_DM_01392]**{草稿} **SOVD 方法停止操作的执行** *[*对于每个具有DiagnosticStopRoutine的DiagnosticRoutine，SOVD服务器实例应根据SOVD SOVD[[2](#_bookmark9)]提供SOVD方法停止操作的执行。诊断服务器实例应使用相同的处理机制实例执行类似于ISO 14229-1[[1](#_bookmark8)]的Service RoutineControl（0x31）的Stop（0x02）方法。*♩(RS_Diag_04262)*


**[SWS_DM_01391]**{DRAFT} **SOVD method Stop the Execution of an Oeration proximity_response** *[*The proximity_reponse in the request body of SOVD method Stop the Execution of an Operation shall be vaidated using ara::diag::SovdProximityChallenge::ValidateResponse.*♩ (RS_Diag_04262)*

> **[SWS_DM_01391]**{草案} **SOVD方法停止操作的近距离响应** *[*SOVD方法停止操作的请求正文中的proximity_response应使用ara :: diag :: SovdProximityChallenge :: ValidateResponse进行验证。*♩ (RS_Diag_04262)*


**[SWS_DM_01390]**{DRAFT} **SOVD operations request and response parameters** *[*The values for the key parameters in the request body and response body of the SOVD methods Start Execution of an Operation, Stop the Execution of an Operation, Get the Status of an Operation Execution shall be reprsented as JSON object literal. The literal shall have one entry per DiagnosticParaeter configured in the corresponding role according to Diagnostic Extract Template[[3](#_bookmark10)] with key derived from the shortName of the correspoding DiagnosticDataElment.*♩(RS_Diag_04262)*

> **[SWS_DM_01390]**{草案} **SOVD 操作请求和响应参数** *[*SOVD 方法Start Execution of an Operation，Stop the Execution of an Operation，Get the Status of an Operation Execution 的请求体和响应体中的关键参数的值应表示为JSON对象字面量。该字面量应按照Diagnostic Extract Template[[3](#_bookmark10)]中相应角色配置的每个DiagnosticParaeter具有一个条目，其键源自相应DiagnosticDataElment的shortName。*♩(RS_Diag_04262)*

### Modes


**[SWS_DM_01389]**{DRAFT} **SOVD method Retrieve List of All Supported Modes of an Entity** *[*If at least one SOVD mode is configured the Diagnostic Server instance shall provide the SOVD method Retrieve List of All Suported Modes of an Entity according to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04263)*

> **[SWS_DM_01389]**{草案} **SOVD 方法检索实体的所有支持模式列表** *[*如果至少配置了一个SOVD模式，诊断服务器实例应根据ASAM SOVD[[2](#_bookmark9)]提供SOVD方法检索实体的所有支持模式列表。*♩(RS_Diag_04263)*

### CommunicationControl


**[SWS_DM_01388]**{DRAFT} **SOVD mode communication_control** *[*If at least one DiagnosticComControl is configured according to Diagnostic Extract Template[[3](#_bookmark10)], the Diagnostic Server instance shall offer a SOVD mode comunication_control with SOVD methods Get Details of a Single Mode of an Entity and Explicit Control of Entity States via Their Dfined Modes according to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04263)*

> **[SWS_DM_01388]**{草稿} **SOVD 模式通信控制** *[*如果按照诊断提取模板[[3](#_bookmark10)]至少配置了一个诊断通信控制，诊断服务器实例应提供一种 SOVD 模式的通信控制，按照 ASAM SOVD[[2](#_bookmark9)]的要求，支持 SOVD 方法获取单个实体模式的详细信息以及通过定义的模式显式控制实体状态。*♩(RS_Diag_04263)*


**[SWS_DM_01387]**{DRAFT} **SOVD mode communication_control name** *[*The SOVD attribute name of the SOVD mode communication_control shall be a costant string with value communication_control.*♩(RS_Diag_04263)*

> **[SWS_DM_01387]**{草案} **SOVD 模式通信控制名称** *[*SOVD 模式通信控制的 SOVD 属性名称应是具有值“通信控制”的常量字符串。♩(RS_Diag_04263)*


**[SWS_DM_01386]**{DRAFT} **SOVD mode communication_control value schema** *[*The SOVD attribute value of SOVD mode communication_control shall be a JSON enum. For each DiagnosticComControl one possible enum value shall be derived from the category of the corresponding DiagnosticComControl.*♩(RS\Diag_04263)*

> **[SWS_DM_01386]**{草案}**SOVD模式通信控制值架构** *[*SOVD模式通信控制的SOVD属性值应为一个JSON枚举。对于每个DiagnosticComControl，应从相应的DiagnosticComControl类别中派生出一个可能的枚举值。*♩(RS\Diag_04263)*


**[SWS_DM_01385]**{DRAFT} **SOVD mode communication_control get value** *[*The SOVD attribute value in the response body of SOVD method Get Details of a Single Mode of an Entity of SOVD mode communication_control shall rturn the current state of the Diagnostic Server instance according to Service CommunicationControl (0x28) of ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04263)*

> **[SWS_DM_01385]**{草案} **SOVD 模式通信控制获取值** *[*SOVD 方法Get Details of a Single Mode of an Entity of SOVD 模式通信控制在响应体中的SOVD 属性值应根据ISO 14229-1[[1](#_bookmark8)]的服务通信控制(0x28)返回诊断服务器实例的当前状态。*♩(RS_Diag_04263)*


**[SWS_DM_01384]**{DRAFT} **SOVD mode communication_control set value** *[*The SOVD method Explicit Control of Entity States via Their Dfined Modes of SOVD mode communication_control with valid value in the request body shall be processed analog to Service CommunicationControl (0x28) of ISO 14229-1[[1](#_bookmark8)] using the same instance of the processing mechanism.*♩(RS_Diag\04263)*

> **[SWS_DM_01384]**{草案} **SOVD模式通信控制设置值** *[*SOVD方法通过其定义的模式显式控制实体状态，请求体中的有效值应按照ISO 14229-1[[1](#_bookmark8)]的Service CommunicationControl（0x28）处理，使用相同的处理机制实例。*♩（RS_Diag\04263）*

### ControlDTCSetting


**[SWS_DM_01383]**{DRAFT} **SOVD mode control_dtc_setting** *[*If a DagnosticControlDTCSetting is configured according to Diagnostic Extract Template[[3](#_bookmark10)], the Diagnostic Server instance shall offer a SOVD mode control_dtc_setting with SOVD methods Get Details of a Single Mode of an Entity and Explicit Control of Entity States via Their Dfined Modes according to ASAM SOVD[[2](#_bookmark9)].*♩(RS_Diag_04263)*

> 如果根据诊断提取模板[[3](#_bookmark10)]配置了DiagnosticControlDTCSetting，则根据ASAM SOVD[[2](#_bookmark9)]，诊断服务器实例应提供SOVD模式控制_dtc_setting，其中包括获取实体单个模式的详细信息以及通过定义模式显式控制实体状态♩（RS_Diag_04263）。


**[SWS_DM_01382]**{DRAFT} **SOVD mode control_dtc_setting name** *[*The SOVD attribute name of the SOVD mode control_dtc_setting shall be a constant string with value control_dtc_setting.*♩(RS_Diag_04263)*

> **[SWS_DM_01382]**{草稿} **SOVD 模式控制 DTC 设置名称** *[*SOVD 模式控制 DTC 设置的 SOVD 属性名称应为常量字符串，值为 control_dtc_setting。*♩（RS_Diag_04263）*

### [SWS_DM_01381] {DRAFT} SOVD mode control_dtc_setting value schema


*[*The SOVD attribute value of SOVD mode control_dtc_setting shall be a JSON

> SOVD模式控制_dtc_设置的SOVD属性值应为JSON


enum with possible values off and on. These value shall be mapped to the subfuntion parameter of Service ControlDTCSetting (0x85) of ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag\04263)*

> 枚举可能的值为开和关，这些值将映射到ISO 14229-1[1]中Service ControlDTCSetting (0x85)的子功能参数(RS_Diag\04263)。


**[SWS_DM_01380]**{DRAFT} **SOVD mode control_dtc_setting get value** *[*The SOVD attribute value in the response body of SOVD method Get Details of a Single Mode of an Entity of SOVD mode control_dtc_setting shall return the current state of the Diagnostic Server instance according to Service CotrolDTCSetting (0x85) of ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04263)*

> **[SWS_DM_01380]**{草稿} **SOVD模式控制_dtc_设置获取值** *[*SOVD方法Get Details of a Single Mode of an Entity of SOVD模式控制_dtc_设置的响应体中的SOVD属性值应根据ISO 14229-1的Service CotrolDTCSetting（0x85）返回诊断服务器实例的当前状态[[1](#_bookmark8)]。*♩(RS_Diag_04263)*


**[SWS_DM_01379]**{DRAFT} **SOVD mode control_dtc_setting set value** *[*The SOVD method Explicit Control of Entity States via Their Defined Modes of SOVD mode control_dtc_setting with valid value in the request body shall be processed analog to Service Service ControlDTCSetting (0x85) of ISO 14221[[1](#_bookmark8)].*♩(RS_Diag_04263)*

> **[SWS_DM_01379]**{草稿} **SOVD模式控制_dtc_设置设置值** *[*通过它们定义的SOVD模式控制_dtc_设置的显式控制实体状态，请求体中的有效值应类似于ISO 14221的Service Service ControlDTCSetting（0x85）[[1](#_bookmark8)]。*♩(RS_Diag_04263)*


1. ### Diagnostic Event Management

> ### 诊断事件管理


   1. ### Caching of application call for event processing

> ### 应用程序调用的事件处理缓存


There is a difference between diagnostic service processing and diagnostic event maagement. Diagnostic services processing is always triggered by the DM as reaction of a received diagnostic request. For diagnostic event management the application is caling DM functions at any point in time and independent for a diagnostic service request. For the application calling such a function it is unknown if the DM is actually currently available. Typical examples are:

> 在诊断服务处理和诊断事件管理之间存在差异。诊断服务处理总是由DM作为收到诊断请求的反应而被触发。对于诊断事件管理，应用程序可以在任何时间点、独立于诊断服务请求调用DM功能。对于调用此类功能的应用程序，不知道DM是否实际可用。典型的例子有：

- At startup the application is up and running and reporting information but the DM


is not yet started and likely be up shortly after the call

> 尚未启动，通话结束后很快就会启动。

- The communication between the ara::diag interface and the DM itself is temporaily interrupted


If the application would need to handle these situations to react on the not available DM, they would get very complex. Furthermore, each and every application would need to implement a complex strategy. To avoid this and to ease the interaction between application and DM for these functions, the ara::diag methods where the application calling the DM outside of service processing, the DM caches the relevant information and forwards this data to the DM instance once it is available. The application itself can simply concentrate on its function. Examples where this is applied are:

> 如果应用程序需要处理这些情况以响应不可用的DM，它们将变得非常复杂。此外，每个应用程序都需要实现一个复杂的策略。为了避免这种情况，并为这些功能简化应用程序和DM之间的交互，ara :: diag方法是应用程序在服务处理之外调用DM，DM缓存相关信息并在可用时将此数据转发给DM实例。应用程序本身只需专注于其功能即可。应用此方法的示例如下：

- Reporting states for enabled conditions
- Reporting state for clear DTC conditions
- Reporting state for monitor results


A detailed description of APIs that cache the function and also about what is cached, can be found in the individual chapters where these APIs are described.

> 详细描述缓存函数的API以及缓存的内容可以在描述这些API的各个章节中找到。


1. ### Diagnostic Events

> ### 诊断事件

   1. ### Definition

![](./media/image33.png)Diagnostic events are used by applications to report the state of a monitored entity to the DM. An event uniquely identifies the monitored entity in the system. The DM receives event notifications from the applications and performs defined actions such as DTC status changes or capturing and storage of extended data records or snapshot records. In other words, events are the input source for the Diagnostic Event Management unit of the DM.

**Figure 7.4: Example of diagnostic event usage**


An event represents a specific diagnostic monitoring performed which is unique within the system and DM only supports notifications for a certain event from one single source. This implies that only one application can report a certain event and the event reporting interface is explicitly not re-entrant.

> 事件代表某个特定的诊断监测，在系统中是唯一的，DM只支持来自一个源的特定事件的通知。这意味着只有一个应用程序可以报告某个事件，事件报告接口明确不支持重入。


The available events are derived from DiagnosticEvent.

> 可用事件来自诊断事件。

### Monitors


A diagnostic monitor is a routine running inside an AA entity determining the proper functionality of a component. This monitoring function identifies a specific fault

> 诊断监视器是AA实体内部运行的例行程序，用于确定组件的正确功能。此监视功能可识别特定故障。


type (e.g. short-circuit to ground, missing signal, etc.) for a monitoring path. A monitoing path represents the physical system or a circuit, that is being monitored (e.g. sensor input). Each monitoring path is associated with exactly one diagnostic event.

> 监控路径的类型（例如短路到地、缺失信号等）。监控路径代表正在监控的物理系统或电路（例如传感器输入）。每个监控路径与一个诊断事件相关联。


In general diagnostic monitors are independent from the DM. Once the ECU is started and initialized they are permanently monitoring a part of the system and reporing the state to the DM. There are use cases, where it might not be required to continue to monitor the system part and the monitor could stop its task until a certain situation arises.

> 一般来说，诊断监视器独立于DM。一旦ECU启动并初始化，它们将永久监视系统的一部分并将状态报告给DM。有一些使用情况，可能不需要继续监视系统部分，监视器可以停止其任务，直到某种情况出现。


Besides the reporting direction of the monitors (AAs report the monitoring status towards the DM), there is also a connection in the opposite direction: The DM uses the

> 除了监控器（AA向DM报告监控状态）的报告方向外，还有相反的连接：DM使用

- initMonitor (for Monitors with Monitor-internal debouncing)
- initMonitor (for Monitors with counter-based debouncing)
- initMonitor (for Monitors with time-based debouncing)


notifier to trigger a (re-)initialization of diagnostic monitors in the AA. The above listed notifier methods are registered by one of the ara::diag::Monitor constructors.

> 触发AA中诊断监视器(重新)初始化的通知者。上述列出的通知方法由ara :: diag :: Monitor构造函数之一注册。


**[SWS_DM_00562]**{DRAFT} **Monitor initialization for clearing reason** *[*If an assciated DTC, belonging to the current monitoring path, was actually cleared, the DM shall call one of the registered notifier methods ara::diag::Monitor::Monitor::initMonitor with the parameter ara::diag::InitMonitorReason set to kClear.*♩(RS_Diag\04185)*

> **[SWS_DM_00562]**{草案} **监测初始化的清除原因** *[*如果当前监测路径中的关联DTC实际被清除，DM将使用参数ara :: diag :: InitMonitorReason设置为kClear调用注册的通知者方法ara :: diag :: Monitor :: Monitor :: initMonitor之一。*♩(RS_Diag\04185)*


**[SWS_DM_00563]**{DRAFT} **Monitor initialization for operation cycle restart reson** *[*If a diagnostic event was (re)started by calling the method ara::diag::OperationCycle::RestartOperationCycle, the DM shall call one of the reistered notifier methods ara::diag::Monitor::Monitor::initMonitor with the parameter ara::diag::InitMonitorReason set to kRestart.*♩(RS_Diag_04186)*

> **[SWS_DM_00563]**{草案} **监控初始化以重新启动操作周期的原因** *[*如果调用ara::diag::OperationCycle::RestartOperationCycle重新启动诊断事件，DM应调用注册的通知方法ara::diag::Monitor::Monitor::initMonitor，并将参数ara::diag::InitMonitorReason设置为kRestart。*♩(RS_Diag_04186)*


**[SWS_DM_01094]**{DRAFT} **Monitor initialization for enable condition re-enabling reason and ControlDTCSetting set to On** *[*In case an enable condition mapped to the diagnostic event was changed to fulfilled and in this way all related enable conditions of the event were fulfilled and DTC-setting is re-enabled via the UDS service request ControlDTCSetting0x85 set to On (see ISO 14229-1[[1](#_bookmark8)]), the DM shall call one of the registered notifier methods ara::diag::Monitor::Monitor::initMonitor with the parameter ara::diag::InitMonitorReason set to kReenabled.*♩(RS\Diag_04125, RS_Diag_04159)*

> **[SWS_DM_01094]**{草案} **监视器初始化以启用条件重新启用的原因和ControlDTCSetting设置为On** *[*如果将与诊断事件映射的启用条件更改为已满足，并以此方式满足该事件的所有相关启用条件，并通过UDS服务请求ControlDTCSetting0x85设置为On（参见ISO 14229-1[[1](#_bookmark8)]），DM应调用具有参数ara :: diag :: InitMonitorReason设置为kReenabled的注册通知者方法ara :: diag :: Monitor :: Monitor :: initMonitor之一。*♩（RS \ Diag_04125，RS_Diag_04159）*

简体中文：**[SWS_DM_01094]**{草案} **监视器初始化以启用条件重新启用的原因和ControlDTCSetting设置为On** *[*如果将与诊断事件映射的启用条件更改为已满足，并以此方式满足该事件的所有相关启用条件，并通过UDS服务请求ControlDTCSetting0x85设置为On（参见ISO 14229-1[1]），DM应调用具有参数ara :: diag :: InitMonitorReason设置为kReenabled的注册通知者方法ara :: diag :: Monitor :: Monitor :: initMonitor之一。*♩（RS \ Diag_04125，RS_Diag_04159）*


**[SWS_DM_01095]**{DRAFT} **Monitor initialization for enable condition not fulfilled or ControlDTCSetting set to Off** *[*In case an enable condition mapped to the diagnostic event was changed to not fulfilled or DTC-setting is disabled via the UDS service request ControlDTCSetting0x85 set to Off (see ISO 14229-1[[1](#_bookmark8)]), the DM shall call one of the registered notifier methods ara::diag::Monitor::Monitor::initMonitor with the parameter ara::diag::InitMoitorReason set to kDisabled.*♩(RS_Diag_04125, RS_Diag_04192, RS_Diag\04159)*

> **[SWS_DM_01095]**{草案} **监视器初始化未满足使能条件或ControlDTCSetting设置为关闭** *[*如果与诊断事件映射的使能条件被更改为不满足或通过UDS服务请求ControlDTCSetting0x85设置为关闭（参见ISO 14229-1[[1](#_bookmark8)]），DM应调用其中一个注册的通知程序ara :: diag :: Monitor :: Monitor :: initMonitor，参数ara :: diag :: InitMoitorReason设置为kDisabled。* ♩（RS_Diag_04125，RS_Diag_04192，RS_Diag\04159）*

简体中文：**[SWS_DM_01095]**{草案} **监视器初始化未满足使能条件或ControlDTCSetting设置为关闭** *[*如果与诊断事件映射的使能条件被更改为不满足或通过UDS服务请求ControlDTCSetting0x85设置为关闭（参见ISO 14229-1[[1](#_bookmark8)]），DM应调用其中一个注册的通知程序ara :: diag :: Monitor :: Monitor :: initMonitor，参数ara :: diag :: InitMoitorReason设置为kDisabled。* ♩（RS_Diag_04125，RS_Diag_04192，RS_Diag\04159）*


Per diagnostic monitor an instance of the class ara::diag::Monitor is crated by the application. Diagnostic results are reported to the DM via the method ara::diag::Monitor::ReportMonitorAction. The method ara::diag:Monitor::ReportMonitorAction calculates the update of the corresponding istance of ara::diag::Event (from DiagnosticEvent) and the UDS DTC sttus byte as well as the storage in the event memory and the capturing of DTC related data.

> 为了进行诊断监测，应用程序创建了ara :: diag :: Monitor类的一个实例。诊断结果通过ara :: diag :: Monitor :: ReportMonitorAction方法报告给DM。ara :: diag：Monitor :: ReportMonitorAction方法计算相应的ara :: diag :: Event（来自DiagnosticEvent）实例的更新以及UDS DTC状态字节以及存储在事件存储器中以及捕获DTC相关数据。


The connection between the ara::diag::Monitor interface and the DM might be not active, when ara::diag::Monitor::ReportMonitorAction is called. A tyical situation is the start up phase of the ECU, the DM process might be up and running after the application is started. In that case, the DM provides means to cache the action provided with ara::diag::Monitor::ReportMonitorAction to bridge the timspan until the DM is up and running and the connection between ara::diag::Moitor and the DM is established. Also in case the connection is lost and reestablished, the caching is used.

> 检测到ara::diag::Monitor::ReportMonitorAction被调用时，ara::diag::Monitor接口和DM之间的连接可能不活动。一个典型的情况是ECU的启动阶段，应用程序启动后DM进程可能已经启动并运行。在这种情况下，DM提供了一些缓存功能来桥接ara::diag::Monitor和DM之间连接建立的时间间隔。当连接丢失并重新建立时，也会使用缓存。


**[SWS_DM_00965]**{DRAFT} **Caching of monitor results** *[*If the function ara:diag::Monitor::ReportMonitorAction is called and the DM is currently not ready to process reported event qualification, the DM shall cache at least one qualfied PASSED and qualified FAILED result and process the qualified FAILED/PASSED, when the daemon connection is (re-)established.*♩(RS_Diag_04179)*

> 如果调用ara:diag::Monitor::ReportMonitorAction函数，而DM当前尚未准备处理报告的事件资格，则DM应至少缓存一个合格的PASSED和合格的FAILED结果，并在守护进程连接（重新）建立时处理合格的FAILED/PASSED（参见RS_Diag_04179）。


Note: The debouncing is executed independently of this caching. Only the event quaification trigger is stored in the cache (e.g. no snapshot data included).

> 注意：去抖动是独立于缓存执行的。只有事件触发器会被存储在缓存中（例如，不包括快照数据）。

### Event Combination


Event combination defines the ability of the DM to map several events to one DTC. It is used to adapt different monitor results to one significant fault, which is clearly evaluable in a service-station. The essential part of implementing a combined DTC is the calculation of its status information. The combined DTC status byte results from a bitwise logical operation of all associated events.

> 事件组合定义了DM将多个事件映射到一个DTC的能力。它用于将不同的监测结果适配到在服务站中可以清楚评估的一个重要故障。实施组合DTC的基本部分是计算其状态信息。组合DTC状态字节是由所有相关事件的按位逻辑运算结果得出的。


The DM supports the following event combination types:

> DM支持以下事件组合类型：

- Combination on storage: The combined DTC is stored and updated in a single


event memory entry. Event related data is stored only for one event.

> 记录事件记忆。只存储与事件相关的数据。

- Combination on retrieval: Each event is stored in a separate event memory


location. The event related data for all stored events are reported for a DTC.

> 位置。所有存储事件的相关数据都报告给DTC。


Event combination is enabled by setting DiagnosticCommonProps.typeOfEvenCombinationSupported to one of the supported event combination types. Event combination types have a direct impact on UDS response messages and therefore are available individually per event memory.

> 启用事件组合可以通过将DiagnosticCommonProps.typeOfEvenCombinationSupported设置为支持的事件组合类型之一来实现。事件组合类型直接影响UDS响应消息，因此每个事件存储器可以单独提供。


**[SWS_DM_01106]**{DRAFT} **Applicability of Event Combination** *[*The DM shall apply event combination for a DTC if more than one DiagnosticEventToTrobleCodeUdsMapping refer the same DiagnosticTroubleCodeUds.*♩(RS_Diag\04200)*

> **[SWS_DM_01106]**{草案} **事件组合的适用性** *[*如果多个DiagnosticEventToTrobleCodeUdsMapping指向同一个DiagnosticTroubleCodeUds，DM应该对DTC应用事件组合。*♩(RS_Diag\04200)*


[Table](#_bookmark222) [7.6](#_bookmark222) shows an example configuration with event combination in place. Several events are mapped to the same DTC. The combination on storage is represented by the DTC[1]. The DTC[2] shows an example of the combination on retrieval. The freeze frame data is stored individually for each event.

> 表7.6示范了一个使用事件组合的配置示例。几个事件映射到同一个DTC。存储上的组合由DTC[1]表示。DTC[2]显示了检索组合的示例。冻结帧数据是为每个事件单独存储的。


**Table 7.6: Example of a configuration table including combined DTCs**

> 表7.6：包括组合DTCs的配置表的示例


**[SWS_DM_01107]**{DRAFT} **DTC Status Byte calculation** *[*If DiagnosticCommoProps.typeOfEventCombinationSupported is configured, the DM shall calculate the UDS DTC status byte according to [Table](#_bookmark223) [7.7](#_bookmark223) for all events with event cobination that are mapped to DTCs in that DiagnosticCommonProps.*♩(RS_Diag\04200)*

> 如果配置了DiagnosticCommoProps.typeOfEventCombinationSupported，DM应根据表7.7为所有映射到诊断常见属性中的事件组合计算UDS DTC状态字节。


The ara::diag::EventStatusBit type does not define all UDS DTC status bits for an Event. Some of the Event status bits for the calculation in [Table](#_bookmark223)

> ara::diag::EventStatusBit 类型不定义所有UDS DTC状态位用于事件。在[表](#_bookmark223)中计算的一些事件状态位。


[7.7](#_bookmark223) need to be derived by the Diagnostic Manager. The Derived Event Status of an individual event will be calculated as if it were a UDS DTC status byte as specified in [7.6.4.5.2](#uds-dtc-status) "[UDS DTC Status](#uds-dtc-status)". The Derived event status is not available outside of the Diagnostic Manager.

> [7.7](#_bookmark223) 需要由诊断管理器派生。每个事件的派生事件状态将按照[7.6.4.5.2](#uds-dtc-status)中指定的 UDS DTC 状态字节计算。派生事件状态仅在诊断管理器内可用。


**Table 7.7: Calculation of UDS status byte**

> 表7.7：UDS状态字计算


In table [Table](#_bookmark223) [7.7](#_bookmark223) the following logical operators are used:

> 在表7.7中使用了以下逻辑运算符：

- ! = logical negation (NOT)
- *\|* = logical bitwise OR-operation
- & logical bitwise AND-operation


The calculation of the EventStatusByte is not affected by any event combination (i.e. EventStatusByte always represents the status of the corresponding event).

> 事件状态字节的计算不受任何事件组合的影响（即，事件状态字节总是表示相应事件的状态）。


Event combination has no effect on clearing DTCs.

> 事件组合对清除DTC没有影响。


**[SWS_DM_01108]**{DRAFT} **Clear all DTCs event with event combination** *[*If the DM is performing a clearDTC operation, the DM shall clear all related events indepedently if the event combination is used or not.*♩(RS_Diag_04200)*

> **[SWS_DM_01108]**{草案}**使用事件组合清除所有DTC事件** *[*如果DM正在执行clearDTC操作，无论是否使用事件组合，DM都应独立清除所有相关事件。*♩(RS_Diag_04200)*


**[SWS_DM_01109]**{DRAFT} **UDS DTC status update for combined DTCs** *[*Each time the status of an event is updated, the DM shall calculate the combined DTC status.*♩ (RS_Diag_04200)*

> **[SWS_DM_01109]**{草案} **UDS DTC 状态更新给组合DTCs** *[*每次事件状态更新时，DM 应计算组合DTC的状态。*♩ (RS_Diag_04200)*


**[SWS_DM_01110]**{DRAFT} **Callbacks for combined UDS DTC status change** *[*Each time the combined DTC status has changed, the DM shall call all configured callbacks.*♩ (RS_Diag_04200)*

> **[SWS_DM_01110]**{草案} **组合UDS DTC状态更改的回调** *[*每次组合DTC状态发生更改时，DM都应调用所有配置的回调。*♩ (RS_Diag_04200)*


The DTC fault detection counter is a signed value in the range between -128 and +127. A positive value represents the situation that an event has been reported as failed debouncing of a qualified failed is in place. For event combination the scenario that an event is about to be qualified failed gets a higher priority than the scenario that an event is about to be qualified passed.

> DTC故障检测计数器是一个带符号的值，范围在-128到+127之间。正值表示事件已被报告为未通过合格失败的情况。对于事件组合，即将被认定为失败的情况优先于即将被认定为通过的情况。


**[SWS_DM_01111]**{DRAFT} **Fault detection counter for combined events** *[*If event combination is used for the events of an DTC, the DM shall calculate the fault detection counter (FDC) of that DTC by taking the greatest fault detection counter value of the sub-events.*♩(RS_Diag_04200)*

> **[SWS_DM_01111]**{草案} **组合事件的故障检测计数器** *[*如果DTC的事件使用事件组合，DM应该通过取子事件的最大故障检测计数器值来计算该DTC的故障检测计数器。*♩(RS_Diag_04200)*


**[SWS_DM_01269]**{DRAFT} **Requesting DTC number for events without DTC** *[*If ara::diag::Event::GetDTCNumber is called and no DiagnosticEvenToTroubleCodeUdsMapping exists between the event and UDS DTC, the DM shall return the error code kNoSuchDTC.*♩(RS_Diag_04200)*

> **[SWS_DM_01269]**{草稿} **请求没有DTC的事件的DTC号** *[*如果调用ara::diag::Event::GetDTCNumber，并且在事件和UDS DTC之间没有DiagnosticEvenToTroubleCodeUdsMapping，DM应返回错误码kNoSuchDTC。*♩(RS_Diag_04200)*

### Combination On Storage


For event combination on storage, the DM stores event related data only for one single event per DTC. The reporting of the event related data via UDS behaves in the same way as only one event would be assigned for this DTC.

> 对于存储上的事件组合，DM仅为每个DTC存储一个事件相关的数据。通过UDS报告事件相关数据的行为与只为该DTC分配一个事件相同。


**[SWS_DM_01112]**{DRAFT} **Event memory entry for events with the combintion on storage** *[*If DiagnosticCommonProps.typeOfEventCombinationSuported is set to eventCombinationOnStorage, then, the DM shall use the cobined UDS DTC status bit transitions as trigger source for the allocation of the event memory entry, collection or update of the event related data.*♩(RS_Diag\04200)*

> **[SWS_DM_01112]**{草案}**事件存储器条目的事件组合存储** *[*如果DiagnosticCommonProps.typeOfEventCombinationSuported设置为eventCombinationOnStorage，那么DM应使用组合UDS DTC状态位转换作为触发源，以分配事件存储器条目、收集或更新与事件相关的数据。*♩(RS_Diag\04200)*


**[SWS_DM_01113]**{DRAFT} **Aging counter for combined events** *[*If DiagnostiCommonProps.typeOfEventCombinationSupported is set to eventCombintionOnStorage, the DM shall calculate the aging counter based on the combined DTC status.*♩(RS_Diag_04200)*

> **[SWS_DM_01113]**{草稿} **组合事件的老化计数器** *[*如果DiagnostiCommonProps.typeOfEventCombinationSupported设置为eventCombintionOnStorage，DM应基于组合DTC状态计算老化计数器。*♩(RS_Diag_04200)*

### Combination On Retrieval


For event combination on retrieval, the DM allocates the stored data per event in the same way as if no event combination is used. The event combination is done on data retrieval while reporting the event related data via UDS. The positive response message for ReadDTCInformation contains the data of all stored events concatenated. Thus, the length of the response message increases with each event that has stored data for this DTC.

> 對於事件組合檢索，DM將按照不使用事件組合的方式將存儲的數據分配給每個事件。事件組合是在資料檢索時通過UDS報告事件相關數據時完成的。讀取DTC信息的正響應消息包含所有存儲事件的數據串聯。因此，回應消息的長度隨著為此DTC存儲數據的事件增加而增加。


**[SWS_DM_01114]**{DRAFT} **Data storage for event combination on retrieval** *[*If DagnosticCommonProps.typeOfEventCombinationSupported is set to evenCombinationOnRetrieval, the DM shall trigger the collection, update and storage of event related data per event.*♩(RS_Diag_04200, RS_Diag_04067)*

> **[SWS_DM_01114]**{草稿} **事件组合检索的数据存储** *[*如果DagnosticCommonProps.typeOfEventCombinationSupported设置为evenCombinationOnRetrieval，DM将按照事件触发收集、更新和存储事件相关数据。*♩(RS_Diag_04200，RS_Diag_04067)*

简体中文：**[SWS_DM_01114]**{草案} **事件组合检索的数据存储** *[*如果DagnosticCommonProps.typeOfEventCombinationSupported设置为evenCombinationOnRetrieval，DM将按照事件触发收集、更新和存储事件相关数据。*♩(RS_Diag_04200，RS_Diag_04067)*


**[SWS_DM_01115]**{DRAFT} **Data reporting for event combination on retrieval** *[*If DiagnosticCommonProps.typeOfEventCombinationSupported is set to eventCombinationOnRetrieval, the DM shall return the event related data of all assigned events to UDS by concatenating the data of all events into one response for the same DTC.*♩(RS_Diag_04200, RS_Diag_04067)*

> **[SWS_DM_01115]**{草案} **事件组合检索的数据报告** *[*如果DiagnosticCommonProps.typeOfEventCombinationSupported设置为eventCombinationOnRetrieval，DM应将所有分配事件的事件相关数据连接成一个响应，并将其发送给UDS以获取同一个DTC的数据。*♩(RS_Diag_04200, RS_Diag_04067)*

简体中文：**[SWS_DM_01115]**{草案} **事件组合检索的数据报告** *[*如果DiagnosticCommonProps.typeOfEventCombinationSupported设置为eventCombinationOnRetrieval，DM应将所有分配事件的事件相关数据连接起来，以一个响应的形式将其发送给UDS，以获取同一个DTC的数据。*♩(RS_Diag_04200, RS_Diag_04067)*


The aging and displacement of DTC with event combination on retrieval is done in the same way as for DTCs with only one assigned event.

> 随着事件组合的检索，DTC的衰老和替换与只分配一个事件的DTC完全相同。


With event combination on retrieval the positive response of a UDS request to rtrieve snapshot records or extended data records contains the same record mutiple times. In [[SWS_DM_01116](#_bookmark226)] there is an optional definition for a reporting order. Chronological order is based on the time the event was initially stored in the server. The event storage is not the storage of the record, as an event entry store multiple records and only a chronological order of events not of the individual records is prvided.

> 在检索中，UDS请求的正面响应可以组合事件，以检索快照记录或扩展数据记录，其中同一记录可能多次出现。在[[SWS_DM_01116](#_bookmark226)]中，有一个可选的报告顺序定义。按照事件最初存储在服务器中的时间，按时间顺序排列。事件存储不是记录的存储，因为事件条目存储多个记录，只提供事件的时间顺序，而不是单个记录的时间顺序。


[]{#_bookmark226 .anchor}**[SWS_DM_01116]**{DRAFT} **Reporting order of snapshot and extended data records** *[*If DiagnosticCommonProps.typeOfEventCombinationSupported is set to eventCombinationOnRetrieval and DiagnosticCommonProps. eventCombinationReportingBehavior is set to reportingInChronloicalOrderOldestFirst and the DM is reporting snapshot records or extended data

> 如果DiagnosticCommonProps.typeOfEventCombinationSupported设置为eventCombinationOnRetrieval，并且DiagnosticCommonProps.eventCombinationReportingBehavior设置为reportingInChronloicalOrderOldestFirst，如果DM报告快照记录或扩展数据记录，则报告顺序为最早的先报告。


records and for one record number multiple events have data, the DM shall report the stored event data in chronological order of the event data storage with the oldest entry first.*♩(RS_Diag_04200)*

> 记录中，对于一个记录号有多个事件有数据，DM应按照事件数据存储的先后顺序报告存储的事件数据，其中最早的条目放在最前面。*♩(RS_Diag_04200)*

### EnableConditions


The DM provides also Enable Conditions to ignore a certain call of ara::diag::Monitor::ReportMonitorAction in required situations.

> DM也提供启用条件，以在必要情况下忽略ara::diag::Monitor::ReportMonitorAction的某些调用。


DiagnosticEnableConditions are mapped to DiagnosticEvents by DianosticEventToEnableConditionGroupMappings.

> 诊断启用条件通过DianosticEventToEnableConditionGroupMappings映射到诊断事件。


Enable Conditions are controlled via the function ara::diag::Condition::SetCondition. There current corresponding status, either ' kConditionFalse' or kConditionTrue can be retrieved via 'ara::diag::Condition::GetCondtion'.

> 启用条件可通过函数ara :: diag :: Condition :: SetCondition控制。当前相应状态，即'kConditionFalse'或kConditionTrue可通过'ara :: diag :: Condition :: GetCondtion'获取。


[]{#_bookmark228 .anchor}**[SWS_DM_00568]**{DRAFT} **Handling of enable conditions** *[*If the function ara::diag::Monitor::ReportMonitorAction is called and one or more of the event assigned enable conditions are not fulfilled, the DM shall ignore the reported monitor result.*♩(RS_Diag_04192)*

> 如果调用ara::diag::Monitor::ReportMonitorAction函数，并且一个或多个分配的启用条件未达到，DM应忽略报告的监视结果（RS_Diag_04192）。


Note: For a regular processing of ara::diag::Monitor::ReportMonitorAtion **all** of the enable conditions mapped to the corresponding event have to be fulfilled.

> 注意：为了正常处理ara::diag::Monitor::ReportMonitorAtion，所有映射到相应事件的启用条件都必须满足。

### Debouncing


Debouncing of reported events is the capability of the DM to filter out undesirable noise reported by monitors. This is used to mature the result of the monitor.

> 报告事件的去抖动是DM过滤掉不需要的噪音的能力。这用于提高监视器的结果。


Debouncing means that a report from a monitor does not immediately lead to a change of the UDS DTC status bit \"kTestFailed\" but that a delaying thresold value must be reached before. This results in the states for ara::diag:Event::DebouncingState. If this threshold value is reached (FDC-equivalent is

> 脉冲节流意味着，监视器的报告不会立即导致UDS DTC状态位“kTestFailed”的改变，而是必须达到延迟阈值才能改变。这就导致了ara :: diag：Event :: DebouncingState的状态。如果达到了这个阈值（FDC等效物）

+127 (FDC~max~) or -128 (FDC~min~)), the ara::diag::Event::DebouncingState is either kFinallyDefective or kFinallyHealed. This finally also leads than to a change of the UDS DTC status bit \"kTestFailed\".


There are two kind of different debounce algorithms implemented by the DM:

> 在DM中实现了两种不同的去抖算法。


- Counter-based debouncing ( see [7.6.4.2.5.1](#counter-based-debouncing) "[Counter-based debouncing](#counter-based-debouncing)"))

> 反向基于计数器的去抖动（参见7.6.4.2.5.1“基于计数器的去抖动”）

- Time-based debouncing ( see [7.6.4.2.5.2](#time-based-debouncing) "[Time-based debouncing](#time-based-debouncing)"))

> 基于时间的去抖（参见[7.6.4.2.5.2]（#time-based-debouncing）“[基于时间的去抖]（#time-based-debouncing）”）


Besides the here described debouncing algorithms within the DM implementation, there is also the possibility to do the debouncing monitor-internal within the AA (compare

> 除了在DM实现中描述的去抖算法外，AA中还有可能在内部进行去抖（参见）


[SWS_DM_00548]). But since this functionality is not part of the DM, this document just describes this use case in [7.6.4.2.5.3](#monitor-internal-debouncing) "[Monitor-internal debouncing](#monitor-internal-debouncing)").

> [SWS_DM_00548]不是DM的一部分，本文档只在[7.6.4.2.5.3]("监视器内部去抖")中描述了此用例。


If the FDC for an event with monitor-internal debouncing is needed, the regitered function parameter getFaultDetectionCounter from the constructor ara::diag::Monitor::Monitor needs to be used.

> 如果需要为具有内部去抖动的事件获取FDC，则需要使用构造函数ara :: diag :: Monitor :: Monitor中的注册功能参数getFaultDetectionCounter。


Which algorithm is used can be configured on a per event basis.

> 可以在每个事件基础上配置使用哪种算法。


If an event is not referenced by any DiagnosticEventToDebounceAlgoritmMapping.diagnosticEvent, the DM does not use a debounce algorithm for this event.

> 如果一个事件没有被DiagnosticEventToDebounceAlgoritmMapping.diagnosticEvent引用，DM不会为这个事件使用去抖动算法。


A monitoring application will call the method ara::diag::Monitor::ReportMoitorAction with the parameter action set to kPrepassed or kPrefailed for events, that are debounced by the DM.

> 一个监控应用程序将调用ara::diag::Monitor::ReportMoitorAction方法，其参数action设置为kPrepassed或kPrefailed，以处理由DM去抖动的事件。


**[SWS_DM_00874]**{DRAFT} **Reporting kPrepassed or kPrefailed for events witout an assigned debouncing algorithm** *[*If ara::diag::Monitor::ReportMoitorAction is called with the parameter action set to kPrepassed or kPrfailed for a diagnostic event without assigned counter-based, time-based or monitor-internal debouncing algorithm, the DM shall trigger a Log and Trace message and ignore the reported values.*♩(RS_Diag_04068)*

> **[SWS_DM_00874]**{草案} **对于没有分配计数器、时间或监视器内部去抖动算法的事件报告kPrepassed或kPrefailed** *[*如果使用参数action设置为kPrepassed或kPrfailed调用ara::diag::Monitor::ReportMoitorAction，对于没有分配计数器、时间或监视器内部去抖动算法的诊断事件，DM应触发日志和跟踪消息，并忽略报告的值。*♩(RS_Diag_04068)*


For debouncing configuration values associated with diagnostic events, two sources can be referenced1) DEXT, 2) Monitor constructor. The debouncing configuration provided to the Monitor constructor is considered as default and is overwritten if a debouncing configuration is provided in DEXT. As a consequence, any debouncing configuration in DEXT needs to have a meaningful value.

> 对于与诊断事件相关联的去抖配置，可以参考两个来源：1）DEXT，2）Monitor构造函数。提供给Monitor构造函数的去抖配置被视为默认配置，如果在DEXT中提供了去抖配置，则会覆盖默认配置。因此，DEXT中的任何去抖配置都必须具有有意义的值。


**[SWS_DM_01099]**{DRAFT} **Debouncing parameters from DEXT** *[*If Debouncing prameters are present in DEXT and Debouncing Algorithm is fitting (i.e. Timer Based or Counter based), DM shall refer to the DEXT values as given in the requirements below and ignore any values derived from Monitor Constructors.*♩(RS_Diag_04068)*

> **[SWS_DM_01099]**{草稿} **从DEXT中获取去抖参数** *[*如果DEXT中存在去抖参数并且去抖算法适用（即基于定时器或计数器），DM应参照下面给出的要求中的DEXT值，而忽略监视器构造器中派生的任何值。*♩(RS_Diag_04068)*


**[SWS_DM_01100]**{DRAFT} **Debouncing Algorithm not fitting** *[*If Debouncing prameters are present in DEXT and Debouncing Algorithm is not fitting (Timer or Counter based method is not configured appropriately), DM shall treat this as a Violation with the following error message: \"Mismatching Debounce Algorithm in DEXT {modelledAgorithm} and runtime {ctorAlogrithm}\". {modelledAlgorithm} is the mapped debounce algorithm according to DiagnosticEventToDebounceAlgorithmMapping, {ctorAlogrithm} is the algorithm that is chosen in the ctor.*♩(RS_Diag_04068)*

> 如果在DEXT中存在去抖参数，但去抖算法未能适配（定时器或计数器方法未被适当配置），DM将将此作为违规处理，并显示以下错误消息：“DEXT中的去抖算法（modelledAlgorithm）与运行时（ctorAlogrithm）不匹配”。modelledAlgorithm是根据DiagnosticEventToDebounceAlgorithmMapping映射的去抖算法，ctorAlogrithm是构造函数中选择的算法。（RS_Diag_04068）


**[SWS_DM_01101]**{DRAFT} **Debouncing parameters from Monitor Constructor** *[*If Debouncing parameters and methods are not present in DEXT, DM shall use the Monitor Constructor values and Algorithm, as provided. In these instances, debouncing relvant DEXT parameters in the following requirements shall be replaced by the Monitor Constructor values.*♩(RS_Diag_04068)*

> **[SWS_DM_01101]**{草案} **从监控构造器中获取去抖参数** *[*如果DEXT中没有去抖参数和方法，DM应使用监控构造器提供的值和算法。在这些情况下，以下要求中与去抖相关的DEXT参数将被监控构造器的值所取代。*♩(RS_Diag_04068)*

### Counter-based debouncing


Counter-based debouncing is done on a per event based counting policy of reported kPrepassed or kPrefailed from diagnostic monitors. Per event an internal debounce counter is used. Passed or failed event states for events are calculated by evaluating configured thresholds of the internal debounce counter.

> 计数器基于延迟处理是根据从诊断监视器报告的kPrepassed或kPrefailed的每个事件计数策略进行的。对于每个事件，都使用一个内部延迟计数器。通过评估内部延迟计数器的配置阈值来计算事件的通过或失败状态。


**[SWS_DM_00014]**{DRAFT} **Use of counter-based debouncing for events** *[*A DagnosticEvent shall be subject to counter-based debouncing if the DiagnoticEvent is referenced in the role diagnosticEvent by a DiagnosticEvenToDebounceAlgorithmMapping, where the referenced debounceAlgorithm agregates a DiagEventDebounceCounterBased in the role debounceAlgorithm.*♩ (RS_Diag_04068)*

> **[SWS_DM_00014]**{草案} **事件的计数器去抖动的使用** *[*如果一个DiagnosticEvent在role diagnosticEvent中被一个DiagnosticEvenToDebounceAlgorithmMapping引用，则该DiagnosticEvent应受到计数器去抖动的约束，其中引用的debounceAlgorithm在role debounceAlgorithm中聚集了一个DiagEventDebounceCounterBased。*♩ (RS_Diag_04068)*


**[SWS_DM_00018]**{DRAFT} **Internal debounce counter init** *[*Upon start-up, the DM

> **[SWS_DM_00018]**{草稿} **内部去抖计数器初始化** *[*启动时，DM


shall initialize the event's internal debounce counter to '0'.*♩(RS_Diag_04068)*

> 应将事件的内部去抖计数器初始化为'0'。♩（RS_Diag_04068）


[]{#_bookmark231 .anchor}**[SWS_DM_00017]**{DRAFT} **Calculation of the FDC based on the internal dbounce counter** *[*The DM shall calculate the FDC according to UDS, based on the value and range of the internal debounce counter by linear mapping in order to achieve a value range of -128 \... +127.*♩(RS_Diag_04125, RS_Diag_04190)*

> SWS_DM_00017 {DRAFT} 依据内部反弹计数器计算FDC。*[*根据UDS，DM应该根据内部反弹计数器的值和范围，通过线性映射来计算FDC，以达到-128到+127的值范围。*♩（RS_Diag_04125，RS_Diag_04190）*


[]{#_bookmark232 .anchor}**[SWS_DM_00875]**{DRAFT} **Internal debounce counter incrementation** *[*The DM shall increment the event's internal debounce counter by the configured step-size value of DiagEventDebounceCounterBased.counterIncrementStepSize, when the related monitor calls the method ara::diag::Monitor::ReportMonitorAtion with the parameter action set to kPrefailed. If after the incrementation the debounce counter value is greater than the threshold DiagEventDebounceCouterBased.counterFailedThreshold, the DM shall set the debounce counter value equal to the threshold.*♩(RS_Diag_04125, RS_Diag_04068)*

> SWS_DM_00875{草稿} 内部减震计数器增量  当相关监视器调用ara::diag::Monitor::ReportMonitorAtion并将参数action设置为kPrefailed时，DM应按配置的DiagEventDebounceCounterBased.counterIncrementStepSize步长值增加事件的内部减震计数器。如果在增量后，减震计数器的值大于DiagEventDebounceCouterBased.counterFailedThreshold的阈值，DM应将减震计数器的值设置为阈值。(RS_Diag_04125，RS_Diag_04068)


**[SWS_DM_00024]**{DRAFT} **Qualified failed event using counter-based debouning** *[*If the internal debounce counter is greater or equal to DiagEventDebouncCounterBased.counterFailedThreshold the DM shall process the event as kFnallyDefective.*♩(RS_Diag_04125, RS_Diag_04068)*

> **[SWS_DM_00024]**{草稿} **使用计数器基础去抖动的合格失败事件** *[*如果内部去抖动计数器大于或等于DiagEventDebouncCounterBased.counterFailedThreshold，DM应将事件处理为kFnallyDefective。*♩(RS_Diag_04125, RS_Diag_04068)*


[]{#_bookmark233 .anchor}**[SWS_DM_00876]**{DRAFT} **Internal debounce counter decrementation** *[*The DM shall decrement the event's internal debounce counter by the configured stesize value of DiagEventDebounceCounterBased.counterDecrementSteSize, when the related monitor calls the method ara::diag::Monitor::RportMonitorAction with the parameter action set to kPrepassed. If after the decrementation the debounce counter value is lower than the threshold DiagEvenDebounceCounterBased.counterPassedThreshold, the DM shall set the dbounce counter value equal to the threshold.*♩(RS_Diag_04125, RS_Diag_04068)*

> SWS_DM_00876{草案} 内部去抖计数器减少 *[*当相关监视器调用ara::diag::Monitor::RportMonitorAction，并将参数action设置为kPrepassed时，DM应按照DiagEventDebounceCounterBased.counterDecrementSteSize的配置步长减少事件的内部去抖计数器。如果在减少后，去抖计数器的值低于DiagEvenDebounceCounterBased.counterPassedThreshold的阈值，DM应将去抖计数器的值设置为阈值。*♩(RS_Diag_04125, RS_Diag_04068)*

简体中文：SWS_DM_00876{草案} 内部去抖计数器减少 *[*当相关监视器调用ara::diag::Monitor::RportMonitorAction，并将参数action设置为kPrepassed时，DM应按照DiagEventDebounceCounterBased.counterDecrementSteSize的配置步长减少事件的内部去抖计数器。如果在减少后，去抖计数器的值低于DiagEvenDebounceCounterBased.counterPassedThreshold的阈值，DM应将去抖计数器的值设置为阈值。*♩(RS_Diag_04125, RS_Diag_04068)*


**[SWS_DM_00025]**{DRAFT} **Qualified passed event using counter-based dbouncing** *[*If the internal debounce counter is less or equal to DiagEventDebouncCounterBased.counterPassedThreshold the DM shall process the event as kFnallyHealed.*♩(RS_Diag_04125, RS_Diag_04068)*

> **[SWS_DM_00025]**{草案} **使用计数器基础去抖动的合格通过事件** *[*如果内部去抖动计数器小于等于DiagEventDebouncCounterBased.counterPassedThreshold，DM应处理该事件为最终治愈。*♩(RS_Diag_04125，RS_Diag_04068)*


**[SWS_DM_00021]**{DRAFT} **Direct failed qualification of counter-based events** *[*If the monitor reports kFailed, the DM shall set the internal debounce counter to the value DiagEventDebounceCounterBased.counterFailedThreshold and prcess the event as kFinallyDefective.*♩(RS_Diag_04125, RS_Diag_04068)*

> **[SWS_DM_00021]**{草案} **反基于计数器的事件直接失败资格** *[*如果监视器报告kFailed，DM应将内部去抖计数器设置为DiagEventDebounceCounterBased.counterFailedThreshold的值，并将事件处理为kFinallyDefective。*♩(RS_Diag_04125，RS_Diag_04068)*

简体中文：**[SWS_DM_00021]**{草案} **反基于计数器的事件直接失败资格** *[*如果监视器报告kFailed，DM应将内部去抖计数器设置为DiagEventDebounceCounterBased.counterFailedThreshold的值，并将事件处理为kFinallyDefective。*♩(RS_Diag_04125，RS_Diag_04068)*


**[SWS_DM_00029]**{DRAFT} **Direct passed qualification of counter-based events** *[*If the monitor reports kPassed, the DM shall set the internal debounce counter to the value DiagEventDebounceCounterBased.counterPassedThreshold and prcess the event as kFinallyHealed.*♩(RS_Diag_04125, RS_Diag_04068)*

> **[SWS_DM_00029]**{草稿}**计数器事件的直接通过资格** *[*如果监视器报告kPassed，DM应将内部去抖计数器设置为DiagEventDebounceCounterBased.counterPassedThreshold的值，并将事件处理为kFinallyHealed。*♩(RS_Diag_04125，RS_Diag_04068)*` 简体中文：**[SWS_DM_00029]**{草案}**计数器事件的直接通过资格** *[*如果监视器报告kPassed，DM应将内部去抖计数器设置为DiagEventDebounceCounterBased.counterPassedThreshold的值，并将事件处理为kFinallyHealed。*♩(RS_Diag_04125，RS_Diag_04068)*`


**[SWS_DM_00022]**{DRAFT} **Internal debounce counter jump up behavior** *[*If DagEventDebounceCounterBased.counterJumpUp is set to true for an event, the DM shall set the event's internal debounce counter to DiagEventDebounceCouterBased.counterJumpUpValue if kPrefailed is reported for this event and the current internal debounce counter value is less than DiagEventDebounceCounteBased.counterJumpUpValue. After setting the internal debounce counter to DagEventDebounceCounterBased.counterJumpUpValue the processing accoring to [[SWS_DM_00875](#_bookmark232)] shall be done.*♩(RS_Diag_04068)*

> **[SWS_DM_00022]**{草稿} **内部去抖计数器跳跃行为** *[*如果DagEventDebounceCounterBased.counterJumpUp设置为true，则当报告kPrefailed时，如果当前内部去抖计数器值小于DiagEventDebounceCounteBased.counterJumpUpValue，DM将设置事件的内部去抖计数器为DiagEventDebounceCouterBased.counterJumpUpValue。在将内部去抖计数器设置为DagEventDebounceCounterBased.counterJumpUpValue之后，根据[[SWS_DM_00875](#_bookmark232)]执行处理。*♩(RS_Diag_04068)*


**[SWS_DM_00023]**{DRAFT} **Internal debounce counter jump down behavior** *[*If kPrepassed is reported for an event and the current internal debounce counter value is greater than DiagEventDebounceCounterBased.counterJumpDowValue and counterJumpDown is set to true for this event, the DM shall set the event's internal debounce counter to DiagEventDebounceCounterBased.couterJumpDownValue. After setting the internal debounce counter to DiagEvenDebounceCounterBased.counterJumpDownValue the processing according to [[SWS_DM_00876](#_bookmark233)] shall be done.*♩(RS_Diag_04068)*

> **[SWS_DM_00023]**{草案} **内部去抖计数器跳跃下降行为** *[*如果kPrepassed被报告为一个事件，而当前的内部去抖计数器值大于DiagEventDebounceCounterBased.counterJumpDowValue，并且counterJumpDown被设置为true，DM应将事件的内部去抖计数器设置为DiagEventDebounceCounterBased.couterJumpDownValue。设置内部去抖计数器为DiagEvenDebounceCounterBased.counterJumpDownValue后，根据[[SWS_DM_00876](#_bookmark233)]的处理应该被完成。*♩(RS_Diag_04068)*

![](./media/image40.png)FAILED

**Figure 7.5: Counter-based debouncing**

### Time-based debouncing


Time-based debouncing is done on a per event based counting policy of reported kPrepassed or kPrefailed from diagnostic monitors. Per event an internal debounce timer value is used. Passed or failed event states for events are calculated by evaluating configured thresholds of the internal debounce counter.

> 基于时间的去抖动是基于从诊断监视器报告的kPrepassed或kPrefailed的每个事件计数策略完成的。对于每个事件，都使用内部去抖动定时器值。通过评估内部去抖动计数器的配置阈值来计算事件的通过或失败状态。


**[SWS_DM_00015]**{DRAFT} **Use of timer based debouncing for events** *[*The exitence of a DiagnosticEventToDebounceAlgorithmMapping with an aggregation

> **[SWS_DM_00015]**{草案} **使用基于定时器的去抖动处理事件** *[*存在一个DiagnosticEventToDebounceAlgorithmMapping，具有聚合


of DiagEventDebounceTimeBased by the referenced DiagnosticDebounceAgorithmProps.debounceAlgorithm shall activate a time-based debouncing for this event.*♩(RS_Diag_04225)*

> 根据引用的DiagnosticDebounceAgorithmProps.debounceAlgorithm，DiagEventDebounceTimeBased将为此事件激活基于时间的去抖动（RS_Diag_04225）。


**[SWS_DM_00085]**{DRAFT} **Internal debounce counter init** *[*The DM shall initialize the event's internal debounce counter to '0' upon start-up.*♩(RS_Diag_04225)*

> **[SWS_DM_00085]**{草稿} **内部去抖计数器初始化** *[*DM应在启动时将事件的内部去抖计数器初始化为“0”。*♩(RS_Diag_04225)*


Note: debounceCounterStorage is not supported for time-based debouncing.

> 注意：debounceCounterStorage不支持基于时间的去抖动。


[]{#_bookmark235 .anchor}**[SWS_DM_00030]**{DRAFT} **Calculation of the FDC based on the internal dbounce timer** *[*The DM shall calculate the FDC according to UDS, based on the value and range of the internal debounce timer by linear mapping in order to achieve a value range of -128 \... +127.*♩(RS_Diag_04225, RS_Diag_04190)*

> []{#_bookmark235 .anchor}**[SWS_DM_00030]**{草案} **根据内部去抖定时器计算FDC** *[*DM根据UDS，根据内部去抖定时器的值和范围，通过线性映射来实现-128 \... +127的值范围。*♩(RS_Diag_04225, RS_Diag_04190)*


The internal debounce counter is used to count upon a kPrefailed towards the quaified failed and upon a kPrepassed towards a qualified passed.

> 内部去抖计数器用于计算kPrefailed对应的合格失败，以及kPrepassed对应的合格通过。


**[SWS_DM_00877]**{DRAFT} **Starting time-based event debouncing for failed** *[*The DM module shall start the debounce timer when the related monitor calls the method ara::diag::Monitor::ReportMonitorAction with the parameter action set to kPrefailed to qualify the reported event as kFinallyDefective only when the following conditions are met:

> **[SWS_DM_00877]**{草案} **对失败的事件启动基于时间的事件抖动** *[*当满足以下条件时，DM模块应该在相关监控器调用ara :: diag :: Monitor :: ReportMonitorAction方法，将参数action设置为kPrefailed以将报告的事件视为kFinallyDefective时启动抖动定时器：

- The debounce timer for the event is not already counting towards kFinallyDfective.
- The event is not already qualified as kFinallyDefective.

*♩(RS_Diag_04225)*


**[SWS_DM_00033]**{DRAFT} **Debounce timer behavior upon reported failed** *[*If the monitor reports kFailed, the DM shall set the debounce timer value to DiagEvenDebounceTimeBased.timeFailedThreshold and process the event as kFinalyDefective.*♩(RS_Diag_04225)*

> 如果监控报告kFailed，DM应将去抖定时器值设置为DiagEvenDebounceTimeBased.timeFailedThreshold，并将事件处理为kFinalyDefective.♩（RS_Diag_04225）


**[SWS_DM_00878]**{DRAFT} **Starting time-based event debouncing for passed** *[*The DM module shall start the debounce timer when the related monitor calls the method ara::diag::Monitor::ReportMonitorAction with the parameter ation set to kPrepassed to qualify the reported event as kFinallyHealed only when the following conditions are met:

> **[SWS_DM_00878]**{草稿}**开始基于时间的事件去抖动，以确认已通过** *[*当满足以下条件时，DM模块应调用ara :: diag :: Monitor :: ReportMonitorAction方法，并将参数ation设置为kPrepassed，以将报告的事件资格化为kFinallyHealed，以启动去抖动定时器：

- The debounce timer for the event is not already counting towards kFinallHealed.
- The event is not already qualified as kFinallyHealed.

*♩(RS_Diag_04225)*


**[SWS_DM_00036]**{DRAFT} **Debounce timer behavior upon reported passed** *[*If the monitor reports kPassed, the DM shall set the debounce timer value to DagEventDebounceTimeBased.timePassedThreshold and process the event as kFinallyHealed.*♩(RS_Diag_04225)*

> **[SWS_DM_00036]**{草案}**当报告通过时，去抖定时器行为** *[*如果监视器报告kPassed，DM应将去抖定时器值设置为DagEventDebounceTimeBased.timePassedThreshold，并按kFinallyHealed处理事件。*♩(RS_Diag_04225)*

![](./media/image45.png)**Figure 7.6: Timer based debouncing**


**[SWS_DM_00880]**{DRAFT} **Debounce time freeze request** *[*If the ara::diag:Monitor::ReportMonitorAction method of a ara::diag::Monitor instance is called with the parameter action set to kFreezeDebouncing, the DM shall freeze the related debounce timer of the corresponding event.*♩(RS_Diag_04068, RS_Diag\04225)*

> **[SWS_DM_00880]**{草案} **去抖时间冻结请求** *[*如果将ara::diag:Monitor::ReportMonitorAction方法应用于ara::diag::Monitor实例，并将参数action设置为kFreezeDebouncing，DM应该冻结相关的事件去抖定时器。*♩(RS_Diag_04068, RS_Diag\04225)*


Freezing of the timer is only supported for events with DiagEventDebounceTimBased debouncing.

> 只有在使用基于DiagEventDebounceTim的事件时，才支持定时器的冻结。


**[SWS_DM_00038]**{DRAFT} **Continuing a frozen debounce timer** *[*If a debounce timer is frozen (i.e. the corresponding monitor has called ara::diag::Monitor::ReportMonitorAction with the parameter action set to kFreezeDebouncing) and a new kPrepassed or kPrefailed is reported for this event, the DM module shall continue running the debounce timer starting with the frozen value.*♩(RS_Diag_04225)*

> **[SWS_DM_00038]**{草案} **继续冻结的去抖定时器** *[*如果去抖定时器被冻结（即相应的监视器已经调用了ara :: diag :: Monitor :: ReportMonitorAction，其参数action设置为kFreezeDebouncing），并且为此事件报告了新的kPrepassed或kPrefailed，DM模块应继续运行去抖定时器，从冻结的值开始。*♩（RS_Diag_04225）*

### Monitor-internal debouncing


Monitor-internal debouncing is completely left to the diagnostic monitor AA which just reports the final debouncing results by calling ara::diag::Monitor::ReportMoitorAction on a per event base. Consequently, there is no DM-internal debouning logic for these events. Monitor-internal events are modeled in DEXT by DiagnoticEvents referenced in the role diagnosticEvent by a DiagnosticEventToDbounceAlgorithmMapping, where the referenced debounceAlgorithm aggrgates a DiagEventDebounceMonitorInternal in the role debounceAlgorithm. The DM processes these events according to [[SWS_DM_01025](#_bookmark241)] and the below requirment(s) apply additionally.

> 内部监视器的去抖完全由诊断监视器AA处理，该监视器通过调用ara :: diag :: Monitor :: ReportMoitorAction来报告每个事件的最终去抖结果。因此，这些事件没有DM内部去抖逻辑。内部事件在DEXT中由角色诊断事件引用的DiagnoticEvents模型化，其中引用的去抖算法aggrgates一个角色debounceAlgorithm中的DiagEventDebounceMonitorInternal。 DM根据[[SWS_DM_01025]]（#_bookmark241）处理这些事件，并且额外适用下列要求。


**[SWS_DM_01267]**{DRAFT} **Reporting kFdcThresholdReached for monitor iternal debouncing** *[*If ara::diag::Monitor::ReportMonitorAction is called with the parameter action set to kFdcThresholdReached, the DM shall allocate an event memory entry and trigger or update the storage of snapshot records and/or extended data records, if the corresponding DiagnosticExtendeDataRecord.trigger and/or DiagnosticFreezeFrame.trigger attribute is/are set to fdcThreshold, as specified in [[SWS_DM_01085](#_bookmark271)], [[SWS_DM_01086](#_bookmark272)] and [[SWS_DM_00895](#_bookmark274)].*♩(RS_Diag_04127)*

> 如果ara::diag::Monitor::ReportMonitorAction以kFdcThresholdReached参数被调用，DM应该分配一个事件内存条目，并且触发或更新快照记录和/或扩展数据记录的存储，如果相应的DiagnosticExtendeDataRecord.trigger和/或DiagnosticFreezeFrame.trigger属性被设置为fdcThreshold，如[[SWS_DM_01085](#_bookmark271)]，[[SWS_DM_01086](#_bookmark272)]和[[SWS_DM_00895](#_bookmark274)]所规定。(RS_Diag_04127)


**[SWS_DM_01268]**{DRAFT} **Value of FaultDetectionCounter in case of monitor iternal debouncing** *[*The DM shall use the value returned in ara::diag::Event::GetFaultDetectionCounter as FDC of this event in case of internal debouning, which means, that this event maps per DiagnosticEventToDebounceAgorithmMapping to DiagnosticDebounceAlgorithmProps.debounceAlgrithm*♩(RS_Diag_04068)*

> **[SWS_DM_01268]**{草案} **在监控内部去抖的情况下，FaultDetectionCounter的值** *[*DM应该使用ara :: diag :: Event :: GetFaultDetectionCounter返回的值作为此事件的FDC，这意味着，该事件根据DiagnosticEventToDebounceAgorithmMapping映射到DiagnosticDebounceAlgorithmProps.debounceAlgrithm*♩(RS_Diag_04068)*

### Debounce algorithm reset


In some situations the application might want to reset the debouncing or to freeze it. The DM provides the parameter action with value kResetDebouncing or kFreezeDebouncing for the method ara::diag::Monitor::ReportMontorAction of class ara::diag::Monitor to provide some means of external cotrol of the internal debounce counter.

> 在某些情况下，应用程序可能需要重置去抖动或冻结它。DM为ara :: diag :: Monitor :: ReportMontorAction类提供了具有值kResetDebouncing或kFreezeDebouncing的参数动作，以提供外部控制内部去抖动计数器的一些手段。


**[SWS_DM_00040]**{DRAFT} **Definition of internal debounce counter reset** *[*To reset the internal debounce counter of an event, the DM shall set the corresponding internal debounce counter to zero. For time-based debouncing the debounce timer shall be stopped as well.*♩(RS_Diag_04068, RS_Diag_04225)*

> **[SWS_DM_00040]**{草案} **内部去抖计数器重置的定义** *[*为了重置事件的内部去抖计数器，DM应将相应的内部去抖计数器设置为零。对于基于时间的去抖，去抖定时器也应该停止。*♩(RS_Diag_04068, RS_Diag_04225)*


Only on the next call of ara::diag::Monitor::ReportMonitorAction with the parameter action set to kPrepassed or to kPrefailed the debouncing shall start over again.

> 只有在下一次调用ara::diag::Monitor::ReportMonitorAction且参数action设置为kPrepassed或kPrefailed时，去抖才会重新开始。


**[SWS_DM_00879]**{DRAFT} **Application resetting the internal debounce counter** *[*If the ara::diag::Monitor::ReportMonitorAction method of a ara:diag::Monitor instance is called with the parameter action set to kResetDbouncing, the DM shall reset the internal debounce counter or timer of the corrsponding event.*♩(RS_Diag_04068, RS_Diag_04225)*

> **[SWS_DM_00879]**{草案}**重置内部去抖计数器的应用** *[*如果将ara::diag::Monitor::ReportMonitorAction方法传递给ara:diag::Monitor实例，并将参数action设置为kResetDbouncing，DM将重置相应事件的内部去抖计数器或定时器。*♩(RS_Diag_04068，RS_Diag_04225)*


While resetting a timer based internal debounce counter, it is regardless if the timer is counting towards a failed or passed.

> 在重置基于计时器的内部去抖计数器时，无论计时器是向失败还是通过计数都是一样的。


**[SWS_DM_00039]**{DRAFT} **Resetting the internal debounce counter upon restaring an operation cycle** *[*If an operation cycle is restarted, the DM shall reset the iternal debounce counter for all events referenced by DiagnosticEventToOpertionCycleMapping.diagnosticEvent and referencing the restarted operation ccle by DiagnosticEventToOperationCycleMapping.operationCycle.*♩(RS\Diag_04068, RS_Diag_04225)*

> 如果重新启动操作周期，DM应重置由DiagnosticEventToOpertionCycleMapping.diagnosticEvent引用的所有事件的内部去抖计数器，并通过DiagnosticEventToOperationCycleMapping.operationCycle引用重新启动的操作周期。（RS\Diag_04068，RS_Diag_04225）


**[SWS_DM_00086]**{DRAFT} **Resetting the internal debounce counter after clearing DTC** *[*If the DM executes a ClearDTC command, the DM shall reset the internal debounce counter for all events that have a DiagnosticEventToTroubleCodeUdsMapping to one of the cleared DTCs.*♩(RS_Diag_04068, RS_Diag_04225)*

> **[SWS_DM_00086]**{草案} **清除DTC后重置内部去抖计数器** *[*如果DM执行ClearDTC命令，DM应重置具有DiagnosticEventToTroubleCodeUdsMapping到被清除DTC之一的所有事件的内部去抖计数器。*♩（RS_Diag_04068，RS_Diag_04225）*

### Dependencies to enable conditions


As described in section [7.6.4.2.4](#enableconditions) enable conditions are used to suppress the rsult of reported event status information. Enable Conditions have also effect on the debouncing behavior of the DM.

> 根据[7.6.4.2.4](#enableconditions)节所述，启用条件用于抑制报告的事件状态信息的结果。启用条件也会影响DM的去抖动行为。


**[SWS_DM_00881]**{DRAFT} **Enable condition influence on debouncing behavior (freeze)** *[*If the enable conditions are not fulfilled for an event according to [[SWS_DM_00568](#_bookmark228)] and the debounce algorithm referenced by that event has the DagnosticDebounceAlgorithmProps.debounceBehavior set to freeze, the DM shall freeze the according debounce timer or counter for the time the enable coditions are not fulfilled. This means that the debounce timer or counter remains unchanged.*♩(RS_Diag_04192, RS_Diag_04125)*

> **[SWS_DM_00881]**{草稿} **启用条件对去抖行为（冻结）的影响** *[*如果根据[[SWS_DM_00568](#_bookmark228)]为事件设定的启用条件未能得到满足，并且该事件引用的去抖算法的DagnosticDebounceAlgorithmProps.debounceBehavior设置为冻结，DM应该在启用条件未满足的时间内冻结相应的去抖定时器或计数器。这意味着去抖定时器或计数器保持不变。*♩(RS_Diag_04192, RS_Diag_04125)*

简体中文：**[SWS_DM_00881]**{草案} **启用条件对去抖行为（冻结）的影响** *[*如果根据[[SWS_DM_00568](#_bookmark228)]为事件设定的启用条件未能得到满足，并且该事件引用的去抖算法的DagnosticDebounceAlgorithmProps.debounceBehavior设置为冻结，DM应该在启用条件未满足的时间内冻结相应的去抖定时器或计数器。这意味着去抖定时器或计数器保持不变。*♩(RS_Diag_04192, RS_Diag_04125)*


**[SWS_DM_00882]**{DRAFT} **Enable condition influence on debouncing behaior (reset)** *[*If the enable conditions are not fulfilled for an event according to [[SWS_DM_00568](#_bookmark228)] and the debounce algorithm referenced by that event has the DagnosticDebounceAlgorithmProps.debounceBehavior set to reset, the DM shall reset the according internal debounce counter or timer and freeze it for the time the enable conditions are not fulfilled.*♩(RS_Diag_04192, RS_Diag_04125)*

> **[SWS_DM_00882]**{草案} **启用条件对去抖动行为（复位）的影响** *[*如果根据[[SWS_DM_00568](#_bookmark228)]的事件不满足启用条件，并且该事件引用的去抖动算法的DagnosticDebounceAlgorithmProps.debounceBehavior设置为复位，DM应重置相应的内部去抖动计数器或定时器，并在不满足启用条件的时间内将其冻结。*♩(RS_Diag_04192, RS_Diag_04125)*

简体中文：**[SWS_DM_00882]**{草案} **启用条件对去抖动行为（复位）的影响** *[*如果根据[[SWS_DM_00568](#_bookmark228)]的事件不满足启用条件，并且该事件引用的去抖动算法的DagnosticDebounceAlgorithmProps.debounceBehavior设置为复位，DM应重置相应的内部去抖动计数器或定时器，并在不满足启用条件的时间内将其冻结。*♩(RS_Diag_04192, RS_Diag_04125)*

### Dependencies to UDS service 0x85 ControlDTCSettings


**[SWS_DM_00088]**{DRAFT} **ControlDTCSetting influence (freeze)** *[*If ControlDTSetting is set to disabled according to [[SWS_DM_00910](#_bookmark180)] and the debounce algorithm

> **[SWS_DM_00088]**{草稿} **控制DTC设置的影响（冻结）** *[*如果根据[[SWS_DM_00910](#_bookmark180)]将ControlDTSetting设置为禁用，并且减震算法


referenced has the DiagnosticDebounceAlgorithmProps.debounceBehavior set to freeze, the DM shall freeze the according internal debounce counter or timer for the time the ControlDTCSetting is set to disabled. This means that the internal debounce counter or timer remains unchanged.*♩(RS_Diag_04159, RS_Diag_04125)*

> 如果引用了DiagnosticDebounceAlgorithmProps.debounceBehavior设为freeze，DM应当为ControlDTCSetting被设置为disabled的时间冻结相应的内部去抖计数器或定时器。这意味着内部去抖计数器或定时器保持不变（RS_Diag_04159，RS_Diag_04125）。


**[SWS_DM_00378]**{DRAFT} **ControlDTCSetting influence (reset)** *[*If ControlDTCSeting is set to disabled according to [[SWS_DM_00910](#_bookmark180)] and the debounce algorithm referenced has the DiagnosticDebounceAlgorithmProps.debounceBehavior set to reset, the DM shall reset the according internal debounce counter or timer and freeze it for the time the ControlDTCSetting is set to disabled.*♩(RS_Diag_04159, RS\Diag_04125)*

> **[SWS_DM_00378]**{草案}**控制DTC设置影响（重置）** *[*如果根据[[SWS_DM_00910](#_bookmark180)]将ControlDTCSeting设置为禁用，并且引用的去抖算法具有DiagnosticDebounceAlgorithmProps.debounceBehavior设置为重置，DM应该重置相应的内部去抖计数器或定时器，并在ControlDTCSetting设置为禁用的时间冻结它。*♩（RS_Diag_04159，RS\ Diag_04125）*

### Event Status processing


The 'Event Status processing' is the DMs ability to record and retain Events, Event status and associated data.

> 事件状态处理是DM能够记录和保留事件、事件状态及其相关数据的能力。


The DM provides means to other SW parts in order to control the Event status bits and is therefore the first processing step after the monitors reporting.

> DM为其他软件部件提供控制事件状态位的手段，因此是监视器报告之后的第一个处理步骤。


**[SWS_DM_01024]**{DRAFT} **Event Status processing** *[*The DM shall process the eisting Event status bits ([SWS_DM_00643]) like the processing of the corresponing UDS DTC status bits as specified by the ISO 14229-1 [[1](#_bookmark8)] standard.*♩(RS\Diag_04151)*

> **[SWS_DM_01024]**{草案} **事件状态处理** *[*DM 应该像按照 ISO 14229-1 [[1](#_bookmark8)] 标准处理相应的 UDS DTC 状态位一样处理现有的事件状态位（[SWS_DM_00643]）。*♩（RS\Diag_04151）*


ISO 14229-1 Annex D generally defines UDS DTC status byte handling and the corresponding triggerings for them. The three corresponding Event status bits are handled in the same way. The following requirements map interfaces and configuration parameters of the DM to generic Event status bit transition descriptions.

> ISO 14229-1附件D通常定义UDS DTC状态字节处理以及相应的触发。三个相应的事件状态位以相同的方式处理。以下要求将DM的接口和配置参数映射到通用事件状态位转换描述。


[]{#_bookmark241 .anchor}**[SWS_DM_01025]**{DRAFT} **Event status bit transitions triggered by test results** *[*The DM shall process the Event status bits triggered by the test results (kPassed or kFailed) reported via the function ara::diag::Monitor::ReportMonitorAction of the corresponding ara::diag::Monitor instance. Here, kPassed shall be used as \"*TestResult [Passed]* \" and kFailed as \"*TestResult [Failed]* \" as described in [ISO 14229-1] Annex D.2.*♩(RS_Diag_04151)*

> SWS_DM_01025]{DRAFT} 事件状态位由测试结果触发的转换 
DM 应处理由相应 ara::diag::Monitor 实例的 ara::diag::Monitor::ReportMonitorAction 报告的测试结果（kPassed 或 kFailed）触发的事件状态位。在这里，kPassed 应作为“TestResult [Passed]”，kFailed 应作为“TestResult [Failed]”，如 [ISO 14229-1] 附录 D.2 所述。♩（RS_Diag_04151）


Note that if debouncing for an event is configured, kPrepassed or kPrefailed reported via ara::diag::Monitor::ReportMonitorAction, trigger debounce mechanisms (see section [7.6.4.2.5](#debouncing)). These status reports do not have direct impact on the Event status bits. If the status of an event gets fully qualified after debouncing (i.e. kFinallyHealed or kFinallyDefective ), this information has the same ipact on the Event status bits as if kPassed or kFailed would have been reported via ara::diag::Monitor::ReportMonitorAction.

> 如果配置了某个事件的去抖动，通过ara::diag::Monitor::ReportMonitorAction报告的kPrepassed或kPrefailed会触发去抖动机制（参见[7.6.4.2.5]部分）。这些状态报告不会直接影响事件状态位。如果事件在去抖动之后获得完全资格（即kFinallyHealed或kFinallyDefective），此信息对事件状态位的影响与通过ara::diag::Monitor::ReportMonitorAction报告的kPassed或kFailed一样。


**[SWS_DM_01026]**{DRAFT} **Resetting the status of an Event** *[*If the parameter

> **[SWS_DM_01026]**{草稿} **重置事件的状态** *[*如果参数


action in the function ara::diag::Monitor::ReportMonitorAction is set to

> 动作在ara::diag::Monitor::ReportMonitorAction函数中被设置为


kResetTestFailed, the DM shall update the Event status by setting **only** the \"

> DM 必须通过仅设置"kResetTestFailed"来更新事件状态。


kTestFailed\" bit to FALSE and leave all other bits unchanged.*♩(RS_Diag_04151)*

> 将"kTestFailed"位设置为FALSE，其余位保持不变。♩(RS_Diag_04151)


Rationale: This is an AUTOSAR-specific additional reset condition for the 'kTesFailed' bit of the Event status bits.

> 理由：这是一个AUTOSAR特定的针对'kTesFailed'位的事件状态位的额外复位条件。


**[SWS_DM_01027]**{DRAFT} **Event status bit transitions triggered by oeration cycle restarting** *[*If the function ara::diag::OperationCycle:RestartOperationCycle is called, the DM shall reset the Event status bits:

> **[SWS_DM_01027]**{草案} **由操作周期重新启动触发的事件状态位转换** *[*如果调用ara :: diag :: OperationCycle：RestartOperationCycle函数，DM应重置事件状态位：

- kTestFailedThisOperationCycle = 0;
- kTestNotCompletedThisOperationCycle = 1;


for all events having a DiagnosticEventToOperationCycleMapping to the restarted operation cycle.*♩(RS_Diag_04178, RS_Diag_04182)*

> 对于所有具有DiagnosticEventToOperationCycleMapping的事件，重新启动操作周期（RS_Diag_04178，RS_Diag_04182）。


**[SWS_DM_01028]**{DRAFT} **Event status bit transitions triggered by ClearDianosticInformation UDS service** *[*If the clearing of a DTC is triggered by the UDS service 0x14 *ClearDiagnosticInformation*, the DM shall reset the Event status bits to:

> **[SWS_DM_01028]**{草案}**清除诊断信息UDS服务触发的事件状态位转换** *[*如果由UDS服务0x14 *ClearDiagnosticInformation*触发故障码清除，DM应将事件状态位重置为：

- kTestFailed = 0;
- kTestFailedThisOperationCycle = 0;
- kTestNotCompletedThisOperationCycle = 1;

*♩(RS_Diag_04180)*

### Event status change notifications


**[SWS_DM_00886]**{DRAFT} **Observability of the Event status byte** *[*If an AA calls the function ara::diag::Event::GetEventStatus, the DM shall provide the current status of this event from the corresponding ara::diag::Event instance.*♩ (RS_Diag_04183)*

> 如果AA调用ara::diag::Event::GetEventStatus函数，DM应该从相应的ara::diag::Event实例提供此事件的当前状态。（RS_Diag_04183）


**[SWS_DM_01029]**{DRAFT} **Notification about Event status changes** *[*If the AA has registered for a Event status change notification via the function ara:diag::Event::SetEventStatusChangedNotifier of the corresponding ara::diag::Event instance, the DM shall call this notifier for each status change of this

> **[SWS_DM_01029]**{草案} **关于事件状态更改的通知** *[*如果AA通过相应ara：diag：：Event：：SetEventStatusChangedNotifier功能注册了事件状态更改通知，则DM应为此事件的每个状态更改调用此通知程序。


Event.*♩(RS_Diag_04183)*

> 事件.*♩(RS_Diag_04183)*

### Event occurrence


Event occurrence is defined as the number of repetitions of the same error. An occurence counter exists per event memory entry as part of the event related datas to that entry. The event occurrence counter is expected to have a size of one byte.

> 事件发生定义为同一错误的重复次数。每个事件内存条目都有一个发生计数器作为与该条目相关的事件数据的一部分。预期事件发生计数器的大小为一个字节。


**[SWS_DM_00945]**{DRAFT} **Occurrence Counter initial value** *[*If a new event meory entry is created, the DM module shall initialize the associated occurrence counter with the value '1'.*♩(RS_Diag_04067)*

> **[SWS_DM_00945]**{草案} **发生计数器初始值** *[*如果创建了一个新的事件记忆条目，DM模块应将相关的发生计数器初始化为值“1”。*♩(RS_Diag_04067)*


**[SWS_DM_00946]**{DRAFT} **Occurrence Counter increment strategy 'testFailedonly** *[*If the configuration parameter DiagnosticCommonProps.occurrenceCouterProcessing is set to testFailedBit and a certain event is already stored in the event memory, for each transition of UDS DTC status bit \"kTestFailed\" from '0' to '1', the DM module shall trigger the increment of the associated occurrence counter by one, regardless of UDS DTC status bit \"kConfirmedDTC\" state.*♩ (RS_Diag_04067)*

> 如果配置参数DiagnosticCommonProps.occurrenceCouterProcessing设置为testFailedBit，并且某个事件已存储在事件存储器中，则对于UDS DTC状态位“kTestFailed”从“0”转换到“1”的每次转换，DM模块都应触发相关发生计数器增加1，而不管UDS DTC状态位“kConfirmedDTC”的状态如何。（RS_Diag_04067）


**[SWS_DM_00947]**{DRAFT} **Occurrence Counter increment strategy 'confirmeDtcBit'** *[*If the configuration parameter DiagnosticCommonProps.occurrencCounterProcessing is set to confirmedDtcBit and a certain event is already stored in the event memory and the UDS DTC status bit \"kConfirmedDTC\" is equal to '1', for each transition of UDS DTC status bit \"kTestFailed\" from '0' to '1', the DM module shall trigger the increment of the associated occurrence counter by one.*♩(RS_Diag_04105)*

> **[SWS_DM_00947]**{草案} **确认DTC位的发生计数器增量策略** *[*如果配置参数DiagnosticCommonProps.occurrencCounterProcessing设置为confirmedDtcBit，并且某个事件已经存储在事件存储器中，并且UDS DTC状态位“kConfirmedDTC”等于“1”，则对于UDS DTC状态位“kTestFailed”从“0”变为“1”的每次变化，DM模块应触发相关发生计数器增加1。*♩(RS_Diag_04105)*


**[SWS_DM_00948]**{DRAFT} **Occurrence Counter upper limit** *[*If an occurrence counter has reached its maximum value of 255 and the conditions to increment this occurrence counter are met, the DM module shall latch this occurrence counter at its maximum value.*♩(RS_Diag_04125)*

> **[SWS_DM_00948]**{草案} **发生计数器上限** *[*如果发生计数器已达到其最大值255，并且满足增加该发生计数器的条件，DM模块应该将该发生计数器锁定在其最大值上。*♩(RS_Diag_04125)*


A rollover of the occurrence counter byte from 255 to 0 must be avoided.

> 应避免发生计数字节从255到0的滚动。


**[SWS_DM_01349]**{DRAFT} **Consecutive registration of notifier with SetEventSttusChangedNotifier()** *[*In case of a consecutive call of ara::diag::Event:SetEventStatusChangedNotifier of the corresponding ara::diag::Event istance, DM module shall overwrite the previous registered notifier.*♩(RS_Diag_04125)*

> **[SWS_DM_01349]**{草案} **用SetEventSttusChangedNotifier()连续注册通知者** *[*如果对应ara::diag::Event实例的ara::diag::Event:SetEventStatusChangedNotifier连续调用，DM模块应覆盖先前注册的通知者。♩(RS_Diag_04125)*

### Condition Mangement


The DM supports the use of conditions in situations where the processing of event or clearing DTCs is not desired. For that purpose the ara::diag::Condition is used. Examples for the use of conditions are:

> DM支持在不希望处理事件或清除DTC的情况下使用条件。为此，ara :: diag :: Condition被使用。条件的使用示例如下：

- EnableConditions ( see [7.6.4.2.4](#enableconditions) "[EnableConditions](#enableconditions)")
- ClearDTCConditions ( see [7.6.4.5.5.2](#clearconditions) "[ClearConditions](#clearconditions)")


At the time the application calls the ara::diag::Condition::SetCondition method, the connection between the interface and the DM might not be active. Tyical situations are startup or communication interruptions. To ensure that no crucial data is lost, the conditions interface is caching the result and bridges the time-span, until the connection to the DM is up and running again.

> 在应用程序调用ara::diag::Condition::SetCondition方法的时候，接口和DM之间的连接可能尚未激活。典型的情况是启动或通信中断。为了确保不会丢失任何重要数据，条件接口会缓存结果，并在连接到DM重新恢复运行之前桥接时间跨度。


**[SWS_DM_01093]**{DRAFT} **Caching of conditions** *[*If the function SetCondition() is called and the DM is currently not ready to process the reported condition state, the DM shall cache the latest reported condition and evaluate it when the connection to the DM is (re-)established.*♩(RS_Diag_04192)*

> **[SWS_DM_01093]**{草案} **条件缓存** *[*如果调用SetCondition()函数，而DM当前尚未准备好处理报告的条件状态，则DM应该缓存最新报告的条件，并在与DM的连接（重新）建立时评估它。*♩（RS_Diag_04192）*

### Operation Cycles Management


The DM supports operation cycles according to ISO 14229-1[[1](#_bookmark8)]. Operation cycles have direct effect on the UDS DTC status byte and the event memory behavior.

> DM根据ISO 14229-1[[1](#_bookmark8)]支持操作周期。操作周期直接影响UDS DTC状态字节和事件内存行为。


Examples of typical operation cycles are:

> 例子中典型的操作周期有：

- Ignition on/off cycles
- Power up/power down cycle
- Accumulated operating time cycles
- \...


Operation cycles are managed by the AA, the DM is notified about the restart of an oeration cycle by using the API interface function ara::diag::OperationCcle::RestartOperationCycle.

> 操作周期由AA管理，DM可以通过使用API接口功能ara :: diag :: OperationCcle :: RestartOperationCycle来获知操作周期的重新启动。


**[SWS_DM_01103]**{DRAFT} **Caching of RestartOperationCycle** *[*If the function ara::diag::OperationCycle::RestartOperationCycle is called and the DM is currently not ready to process the reported restart of the operation cycle, the DM shall cache one reported operation cycle restart and evaluate it when the conection to the DM is (re-)established.*♩(RS_Diag_04178, RS_Diag_04182)*

> **[SWS_DM_01103]**{草案} **重新启动操作周期的缓存** *[*如果调用ara::diag::OperationCycle::RestartOperationCycle函数，而DM当前尚未准备好处理报告的操作周期重新启动，则DM应缓存一个报告的操作周期重新启动，并在与DM的连接（重新）建立时评估它。*♩(RS_Diag_04178, RS_Diag_04182)*


**[SWS_DM_01104]**{DRAFT} **Operation Cycle restart** *[*The DM shall only restart oeration cycles after the previous restart has been fully processed. In other words this means that there is no operation cycle restart queue.*♩(RS_Diag_04178)*

> **[SWS_DM_01104]**{草案} **操作周期重启** *[*DM 只有在上次重启完全处理完毕后才能重启操作周期。换句话说，这意味着没有操作周期重启队列。*♩(RS_Diag_04178)*


**[SWS_DM_01105]**{DRAFT} **Restart OperationCycle during the processing of prvious call** *[*If the DM is still processing the previous ara::diag::OperationCcle::RestartOperationCycle call of the same operation cycle, the DM shall ignore the current method call.*♩(RS_Diag_04178)*

> **[SWS_DM_01105]**{草案}**在处理前一次调用时重新启动OperationCycle** *[*如果DM仍在处理相同操作周期的ara::diag::OperationCcle::RestartOperationCycle调用，DM应忽略当前方法调用。*♩(RS_Diag_04178)*

简体中文：**[SWS_DM_01105]**{草案}**在处理前一次调用时重新启动OperationCycle** *[*如果DM仍在处理相同操作周期的ara::diag::OperationCcle::RestartOperationCycle调用，DM应忽略当前方法调用。*♩(RS_Diag_04178)*


**[SWS_DM_01358]**{DRAFT} **Consecutive registration of notifier with OpertionCycle::SetNotifier()** *[*In case of a consecutive call of ara::diag::OpertionCycle::SetNotifier of the corresponding ara::diag::OperationCycle instance, DM module shall overwrite the previous registered notifier.*♩(RS_Diag_04178, RS_Diag_04186)*

> **[SWS_DM_01358]**{草稿}**使用OpertionCycle::SetNotifier()连续注册通知者** *[*如果对应的ara::diag::OperationCycle实例连续调用ara::diag::OpertionCycle::SetNotifier，DM模块应覆盖先前注册的通知者。*♩(RS_Diag_04178, RS_Diag_04186)*

### Event memory


The event memory is the database for faults detected by the system. It stores status information for events, DTCs and DTC related data.

> 事件记忆是系统检测到的故障的数据库。它存储事件、DTC和DTC相关数据的状态信息。


The term \"event memory\", wherever used in this specification, refers to the term \"fault memory\" as specified in ISO 14229-1 [[1](#_bookmark8)]. The DM \"event memory\" is copliant to the \"fault memory\" in ISO.

> 本规范中使用的“事件存储器”一词，指的是ISO 14229-1[[1](#_bookmark8)]规定的“故障存储器”。DM“事件存储器”与ISO中的“故障存储器”兼容。


There can be multiple event memories handled by the DM.

> 可以由DM处理多个事件记忆。


**[SWS_DM_00055]**{DRAFT} **Supported event memories** *[*The DM shall support the

> **[SWS_DM_00055]**{草案} **支持的事件记忆** *[*DM 应支持

- primary event memory
- up to 256 user-defined event memories


according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04214, RS_Diag_04150)*

> 根据ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04214，RS_Diag_04150)


**[SWS_DM_00911]**{DRAFT} **Instances of DTCInformation interface** *[*The DM shall link each instance of the ara::diag::DTCInformation class with the mapped DiagnosticMemoryDestination referenced by the corresponding DiagnoticMemoryDestinationPortMapping.*♩(RS_Diag_04214, RS_Diag_04150)*

> **[SWS_DM_00911]**{草案} **DTCInformation接口的实例** *[*DM应将ara::diag::DTCInformation类的每个实例与相应DiagnosticMemoryDestinationPortMapping引用的映射的DiagnosticMemoryDestination相关联。*♩(RS_Diag_04214, RS_Diag_04150)*


[]{#_bookmark247 .anchor}**[SWS_DM_00056]**{DRAFT} **Availability of the primary event memory** *[*The DM shall support the primary event memory if a DTC exists having a DiagnosticMemorDestinationPrimary referenced by its DiagnosticTroubleCodeProps.memryDestination.*♩(RS_Diag_04150)*

> DM 必须支持主事件存储器，如果存在具有通过其 DiagnosticTroubleCodeProps.memryDestination 引用的 DiagnosticMemorDestinationPrimary 的 DTC。


[]{#_bookmark248 .anchor}**[SWS_DM_00057]**{DRAFT} **Availability of a user-defined event memory** *[*The DM shall support the user-defined event memory with the number DiagnoticMemoryDestinationUserDefined.memoryId if a DTC exists having a DagnosticMemoryDestinationUserDefined with that user-defined number refeenced by its DiagnosticTroubleCodeProps.memoryDestination.*♩(RS_Diag\04214)*

> DM必须支持用户定义的事件内存，其编号为DiagnoticMemoryDestinationUserDefined.memoryId，如果存在具有该用户定义编号的DTC，并且由DiagnosticTroubleCodeProps.memoryDestination引用。


The size of the different event memories is configurable by the DM configuration parameters.

> 大小不同的事件记忆可以通过DM配置参数进行配置。


**[SWS_DM_00920]**{DRAFT} **Configuration of the event memory size** *[*The DM shall provide event memories of a size according to the configuration parameter DagnosticMemoryDestination.maxNumberOfEventEntries, where each single event memory entry is to be understood as the complete data set that belongs to a DTC, including counters, cycles, snapshot records and extended data records.*♩ (RS_Diag_04064)*

> **[SWS_DM_00920]**{草案} **事件内存大小的配置** *[*DM应根据配置参数DagnosticMemoryDestination.maxNumberOfEventEntries提供合适大小的事件内存，其中每个单独的事件内存条目需理解为与DTC相关的完整数据集，包括计数器、周期、快照记录和扩展数据记录。*♩ (RS_Diag_04064)*


If there are limitations to the event memory size, an overflow can occur as a consquence. Therefore the DM provides an overflow indication in case the event memory overflow occurs and a displacement strategy.

> 如果事件内存大小有限制，则可能会发生溢出。因此，DM在发生事件内存溢出时提供溢出指示，并提供位移策略。

### DTC Introduction


A diagnostic trouble code (DTC) defines a unique identifier mapped to a diagnostic event via DiagnosticEventToTroubleCodeUdsMapping. The DTC is used by diagnostics, including e.g. UDS communication with an external tester, to uniquely identify data within the event memory database.

> 诊断故障码（DTC）定义了通过DiagnosticEventToTroubleCodeUdsMapping映射到诊断事件的唯一标识符。DTC被诊断工具，包括例如与外部测试仪的UDS通信，用于唯一标识事件存储数据库中的数据。


**[SWS_DM_00060]**{DRAFT} **Set of supported DTCs** *[*The existence of a DiagnoticTroubleCodeUds indicates that the DM shall support this DTC.*♩(RS_Diag_04201)*

> **[SWS_DM_00060]**{草案} **受支持的DTC集** *[*如果存在DiagnoticTroubleCodeUds，则说明DM应该支持此DTC。*♩(RS_Diag_04201)*


Note: Due to DM restrictions the 'DiagnosticTroubleCodeObd' and 'DiagnosticTroublCodeJ1939' are not supported.

> 由于DM限制，不支持'DiagnosticTroubleCodeObd'和'DiagnosticTroublCodeJ1939'。

### Format


The DTC itself is a 3 byte value, that could have different interpretations.

> DTC本身是一个3字节的值，可以有不同的解释。


[]{#_bookmark251 .anchor}**[SWS_DM_00058]**{DRAFT} **DTC interpretation format** *[*The DM shall use one internal DTC format interpretation that is defined in DiagnosticMemoryDestinationPrmary.typeOfDtcSupported.*♩(RS_Diag_04157)*

> []{#_bookmark251 .anchor}**[SWS_DM_00058]**{草案} **DTC 解释格式** *[*DM 应使用定义在DiagnosticMemoryDestinationPrmary.typeOfDtcSupported中的一种内部 DTC 格式解释。*♩(RS_Diag_04157)*


Note: Refers to [TPS_DEXT_01008] in [[3](#_bookmark10)].

> 注：参见[[3](#_bookmark10)]中的TPS_DEXT_01008。


**[SWS_DM_CONSTR_00059]**{DRAFT} **Restriction on supported DTC format** *[*The DM shall support the following literals from interpreted DiagnosticMemoryDestintionPrimary.typeOfDtcSupported (see also [[SWS_DM_00058](#_bookmark251)])

> **[SWS_DM_CONSTR_00059]**{草稿} **对支持的DTC格式的限制** *[*DM应支持从解释的DiagnosticMemoryDestintionPrimary.typeOfDtcSupported中获取的以下文字（另见[[SWS_DM_00058](#_bookmark251)）]

- iso11992_4
- iso14229_1
- saeJ2012_da


Further information about the format mapping is defined in [[SWS_DM_00062](#_bookmark125)]. The following literals are **not** supported by the DM:

> 更多有关格式映射的信息可在[[SWS_DM_00062](#_bookmark125)]中找到。以下文字不受DM支持：

- iso15031_6
- saeJ1939_73

*♩(RS_Diag_04201)*

### Groups


Besides the term DTC, diagnostics uses DTC groups to address a range of single DTCs. A DTC group is defined by using a dedicated DTC value out of the range of valid DTCs to identify the group of DTCs.

> 除了DTC术语之外，诊断还使用DTC组来处理一系列单个DTC。 DTC组是通过使用有效DTC范围中的专用DTC值来定义的。


A definition of valid DTC groups is provided by ISO 14229-1 [[1](#_bookmark8)]Annex D.1. The DTC group is used in diagnostic just as any other DTC value, the DM internally resolves the DTC group and applies the requested operation to all DTCs of that group. The most common DTC group is the group of all DTCs, assigned to the DTC value 0xFFFFFF.

> 一个有效的DTC组的定义由ISO 14229-1 [[1]](#_bookmark8)附录D.1提供。DTC组在诊断中与任何其他DTC值一样使用，DM内部解析DTC组并对该组的所有DTC应用请求的操作。最常见的DTC组是分配给DTC值0xFFFFFF的所有DTC组。


[]{#_bookmark253 .anchor}**[SWS_DM_00064]**{DRAFT} **Definition of DTC groups** *[*The existence of a DianosticTroubleCodeGroup shall define the existence of the DTC group with the DTC identifier DiagnosticTroubleCodeGroup.groupNumber*♩(RS_Diag_04117, RS_Diag_04115)*

> [SWS_DM_00064]{DRAFT} 定义 DTC 组*[*诊断故障码组的存在将定义具有 DTC 标识符 DiagnosticTroubleCodeGroup.groupNumber 的 DTC 组的存在*♩(RS_Diag_04117，RS_Diag_04115)*


Note: Refers to [TPS_DEXT_03014] in [[3](#_bookmark10)].

> 注意：参见[[3](#_bookmark10)]中的TPS_DEXT_03014。


[]{#_bookmark254 .anchor}**[SWS_DM_00065]**{DRAFT} **Always supported availability of the group of all DTCs** *[*The DM shall provide by default the DTC group 'GroupOfAllDTCs' assigned to the DTC group identifier 0xFFFFFF. This DTC group contains always all configured DTCs.*♩ (RS_Diag_04117)*

> DM 默认提供分配给DTC组标识符0xFFFFFF的DTC组“GroupOfAllDTCs”。该DTC组始终包含所有配置的DTC。(RS_Diag_04117)


**[SWS_DM_CONSTR_00082]**{DRAFT} **Restriction on the configuration of the DTC group GroupOfAllDTCs** *[*The DM shall ignore any configuration of a DiagnostiTroubleCodeGroup.groupNumber with a value of 0xFFFFFF.*♩(RS_Diag_04117)*

> **[SWS_DM_CONSTR_00082]**{草案} **对DTC组GroupOfAllDTCs的配置有限制** *[*DM应忽略任何将DiagnostiTroubleCodeGroup.groupNumber设置为0xFFFFFF的配置。*♩(RS_Diag_04117)*


A configuration of the DTC group 0xFFFFFF via DiagnosticTroubleCodeGroup. groupNumber is not required. Within the DM basically all services and diagnostic requests having a DTC as input parameter accept also DTC group. As result of this, the operation is applied on all DTCs of that DTC group. To provide the reader a clear understanding if the DTC also can be a DTC group, it is explicitly mentioned in this specification. In case a DTC group is also valid, the DTC group definition of this chapter applies.

> 配置DTC组0xFFFFFF通过DiagnosticTroubleCodeGroup。组号不是必需的。在DM中，所有服务和诊断请求都接受DTC作为输入参数，也可以接受DTC组。由此，该操作将应用于该DTC组的所有DTC。为了让读者清楚地理解DTC是否也可以是DTC组，本规范中明确提到了这一点。如果DTC组也有效，则本章节的DTC组定义适用。

### Priority


DTC priority is defined as a ranking based upon the level of importance. It is used to determine which entry may be removed from the event memory in case the nuber of already stored events exceeds the maximum number of memory entries (event memory is full) ([7.6.4.5.10](#event-memory-entry-displacement)).

> 优先级的定义是基于重要程度的排序。它用于确定哪个条目可能从事件存储器中删除，如果已存储的事件数量超过最大存储条目数（事件存储器已满）([7.6.4.5.10](#event-memory-entry-displacement))。


It is also used for internal DiagnosticDataElements connected to a DTCs etended data record.

> 它也用于与DTCs扩展数据记录相关的内部诊断数据元素。


Each supported DTC has a priority assigned to it: DiagnosticTroubleCodeProps. priority;

> 每个支持的DTC都分配了一个优先级：DiagnosticTroubleCodeProps。优先级;


[]{#_bookmark256 .anchor}**[SWS_DM_00916]**{DRAFT} **Priority values** *[*If a DTC has a priority value of 1 and displacement needs to be applied, the DM shall consider this as the highest priority. A higher value shall define a lower priority.*♩(RS_Diag_04118, RS_Diag_04071)*

> 如果DTC具有优先级值1，并且需要进行位移，DM应将其视为最高优先级。更高的值将定义较低的优先级（参见RS_Diag_04118，RS_Diag_04071）。


**[SWS_DM_CONSTR_00961]**{DRAFT} **Limits of priority values** *[*The DM shall only support DiagnosticTroubleCodeProps.priority values in the range of 1..255.*♩ (RS_Diag_04118, RS_Diag_04071)*

> **[SWS_DM_CONSTR_00961]**{草案} **优先值的限制** *[*DM只支持DiagnosticTroubleCodeProps.priority值的范围为1..255。*♩ (RS_Diag_04118, RS_Diag_04071)*

2. ### UDS DTC Status


   1. ### Status processing

> ### 处理状态


The 'UDS DTC Status processing' is the DMs ability to record and retain UDS status and associated interactions with other SW parts.

> UDS DTC状态处理是DM能够记录和保留UDS状态及其与其他软件部件的相关交互的能力。


Thus the 'UDS Status processing' is an essential part of the DM functionality and is the second processing step after the Event status handling, as defined in [7.6.4.2.6](#event-status-processing). The DM provides means to other SW parts in order to control the UDS DTC status bits.

> 因此，“UDS状态处理”是DM功能的重要组成部分，是按照[7.6.4.2.6]（#事件状态处理）中定义的事件状态处理之后的第二个处理步骤。DM为其他软件部件提供控制UDS DTC状态位的手段。


**[SWS_DM_00213]**{DRAFT} **DTC status processing** *[*The DM shall process the UDS DTC status byte harmonizing with the ISO 14229-1[[1](#_bookmark8)] standard.*♩(RS_Diag\04067)*

> **[SWS_DM_00213]**{草案} **DTC 状态处理** *[*DM 应按照 ISO 14229-1[[1](#_bookmark8)] 标准处理 UDS DTC 状态字节。*♩(RS_Diag\04067)*


ISO 14229-1 Annex D generally defines UDS DTC status byte handling and the corresponding triggerings for them. The following requirements map interfaces and configuration parameters of the DM to generic UDS DTC status bit transition dscriptions.

> ISO 14229-1附件D通常定义UDS DTC状态字节处理及其相应的触发。 以下要求将DM的接口和配置参数映射到通用UDS DTC状态位转换描述。


**[SWS_DM_00883]**{DRAFT} **UDS DTC status bit transitions triggered by test results** *[*The DM shall process the UDS DTC status byte based on the Event status bits.*♩(RS_Diag_04067)*

> **[SWS_DM_00883]**{草案} **UDS DTC 状态位根据测试结果触发的转换** *[*DM 应根据事件状态位处理 UDS DTC 状态字节。*♩(RS_Diag_04067)*


**[SWS_DM_00217]**{DRAFT} **UDS DTC status bit transitions triggered by CleaDiagnosticInformation UDS service** *[*If the clearing of a DTC is triggered by the UDS service 0x14 *ClearDiagnosticInformation*, the DM shall process the UDS DTC status byte according to ISO 14229-1[[1](#_bookmark8)].*♩(RS_Diag_04180, RS_Diag_04067)*

> **[SWS_DM_00217]**{草案} **UDS DTC 状态位的转换受UDS服务“ClearDiagnosticInformation”触发** *[*如果由UDS服务0x14“ClearDiagnosticInformation”触发DTC清除，DM应根据ISO 14229-1[[1](#_bookmark8)]处理UDS DTC状态字节。*♩(RS_Diag_04180, RS_Diag_04067)*


[]{#_bookmark259 .anchor}**[SWS_DM_00218]**{DRAFT} **kConfirmedDTC (Bit3) calculation** *[*If the kTesFailed bit (Bit0) of the UDS DTC status bit has a transition from 0 to 1, the DM shall set the kConfirmedDTC bit (Bit3), in case a DiagnosticEvent.confimationThreshold is configured and the trip counter is equal to confirmatioThreshold-1.*♩(RS_Diag_04136, RS_Diag_04067, RS_Diag_04151)*

> 如果UDS DTC状态位的kTesFailed位（Bit0）从0变为1，且配置了DiagnosticEvent.confimationThreshold，且行程计数器等于confirmatioThreshold-1，DM将设置kConfirmedDTC位（Bit3）。（RS_Diag_04136，RS_Diag_04067，RS_Diag_04151）


The trip counter is processed according to ISO 14229-1[[1](#_bookmark8)], Annex D2. The trip counter is always increased by one at the end of any operation cycle with kTesFailedThisOperationCycle (Bit1) set to 1. Or in other words, a confirmatioThreshold value of 1 or no configured value confirms the DTC at the same time, the test failed bit is set to 1.

> 计数器的处理按照ISO 14229-1[[1](#_bookmark8)]，附件D2进行。如果kTesFailedThisOperationCycle（位1）设置为1，计数器总是在任何操作周期结束时增加1。换句话说，确认阈值为1或没有配置值会同时确认故障码，并将测试失败位设置为1。


If Aging is supported for a DTC, the status is handled according to [[SWS_DM_00243](#_bookmark286)].

> 如果DTC支持老化，状态将按照[[SWS_DM_00243](#_bookmark286)]处理。


If there is an indicator mapped to the DTC, the \"kWarningIndicatorRequested\" bit is handled as described in section [7.6.4.5.2.4](#indicators).

> 如果有一个指示符映射到DTC，则按照[7.6.4.5.2.4]（#指示符）中所述处理“kWarningIndicatorRequested”位。


**[SWS_DM_01037]**{DRAFT} **Behavior of not configured DiagnosticEvent.cofirmationThreshold** *[*If the optional parameter DiagnosticEvent.confirmtionThreshold is not configured, the DM shall use a default value of '1' for that parameter.*♩(RS_Diag_04067)*

> 如果可选参数DiagnosticEvent.confirmtionThreshold未配置，DM将使用默认值“1”对该参数进行设置。（RS_Diag_04067）


This means that a confirmedDTC is set to '1' along with a reported kFailed monitor action result.

> 这意味着确认的DTC被设置为“1”，同时报告了kFailed监视器动作结果。

### UDS DTC Status change notifications


**[SWS_DM_01030]**{DRAFT} **Observability of the UDS DTC status byte** *[*If an AA calls the function ara::diag::DTCInformation::GetCurrentStatus( dtc), the DM shall provide the current status of the given dtc ID from within the corresponding ara::diag::DTCInformation instance.*♩(RS_Diag_04183)*

> 如果AA调用ara::diag::DTCInformation::GetCurrentStatus(dtc)函数，DM应提供相应ara::diag::DTCInformation实例中给定dtc ID的当前状态。（RS_Diag_04183）


**[SWS_DM_01031]**{DRAFT} **Notification about UDS DTC status changes** *[*If the AA has registered for a UDS DTC status change notification via the function ara:diag::DTCInformation::SetDTCStatusChangedNotifier of the corresponing ara::diag::DTCInformation instance, the DM shall call this notifier on any UDS DTC status change for every single DTC mapped to this fault memory.*♩(RS\Diag_04183)*

> **[SWS_DM_01031]**{草案} **关于UDS DTC状态更改的通知** *[*如果AA已通过相应的ara :: diag :: DTCInformation实例的ara：diag :: DTCInformation :: SetDTCStatusChangedNotifier功能注册了UDS DTC状态更改通知，DM应在任何UDS DTC状态更改时调用此通知器，以便为与此故障存储器映射的每个DTC。*♩（RS \ Diag_04183）*


**[SWS_DM_01350]**{DRAFT} **Consecutive registration of notifier with SetDTCSttusChangedNotifier()** *[*In case of a consecutive call of ara::diag::DTCInfomation::SetDTCStatusChangedNotifier of the corresponding ara::diag:DTCInformation instance, DM module shall overwrite the previous registered notfier.*♩(RS_Diag_04183)*

> **[SWS_DM_01350]**{草案} **使用SetDTCSttusChangedNotifier()连续注册通知者** *[*如果对应ara::diag:DTCInformation实例的ara::diag::DTCInfomation::SetDTCStatusChangedNotifier连续调用，DM模块应该覆盖先前注册的通知者。*♩(RS_Diag_04183)*

### Suppress DTC reporting


This chapter describes the dynamic suppression of DTC during runtime. A suppressed DTC is not visible for any tester and also not for internal AAs. The Diagnostic Server instance will not stop internal processing of a suppressed DTC. An uscase could be to hide a DTC in a certain market by an AA at run time.

> 本章介绍了在运行时动态抑制DTC的方法。被抑制的DTC对任何测试人员和内部AA都不可见。诊断服务器实例不会停止被抑制的DTC的内部处理。一个使用场景可能是在运行时由AA在某个市场隐藏DTC。


**[SWS_DM_01308]**{DRAFT} **Functionality of DTCInformtion::SetDtcSuppression** *[*If ara::diag::DTCInformation::SetDtSuppression is called for a DTC and the UDS DTC status byte of that DTC is pendingDTC = 0 and confirmedDTC = 0, the Diagnostic Server instance shall set the suppression status of the selected DTC to value of the parameter suppressionStatus.*♩(RS_Diag_04220)*

> 如果调用ara::diag::DTCInformation::SetDtSuppression为某个DTC，并且该DTC的UDS DTC状态字节为pendingDTC=0和confirmedDTC=0，诊断服务器实例将根据参数suppressionStatus设置所选DTC的抑制状态。(RS_Diag_04220)


**[SWS_DM_01307]**{DRAFT} **Precondition for suppression** *[*If ara::diag:DTCInformation::SetDtcSuppression with suppressionStatus = kDTSuppressionOn is called for a DTC and the UDS DTC status byte of that DTC is pendingDTC = 1 or confirmedDTC = 1, the suppression status shall remain unchanged and respond with kSuppressionIgnored.*♩(RS_Diag_04220)*

> **[SWS_DM_01307]**{草案} **抑制的前提条件** *[*如果调用ara::diag:DTCInformation::SetDtcSuppression，其中suppressionStatus = kDTSuppressionOn，且该DTC的UDS DTC状态字节为pendingDTC = 1或confirmedDTC = 1，则抑制状态应保持不变，并响应kSuppressionIgnored。*♩(RS_Diag_04220)*


**[SWS_DM_01306]**{DRAFT} **Functionality of DTCInformtion::GetDtcSuppression** *[*If ara::diag::DTCInformation::GetDtSuppression is called, the Diagnostic Server instance shall return the

> 如果调用ara :: diag :: DTCInformation :: GetDtSuppression，诊断服务器实例将返回DTCInformtion :: GetDtcSuppression的功能。


DTC suppression status. A value of kDTCSuppressionOn means that the DTC is suppressed. A value of kDTCSuppressionOff means, that the DTC is currently not suppressed.*♩(RS_Diag_04220)*

> 状态抑制DTC。值kDTCSuppressionOn表示DTC已被抑制。值kDTCSuppressionOff表示DTC当前未被抑制。♩（RS_Diag_04220）


ara::diag::DTCInformation::GetDtcSuppression and ara::diag:DTCInformation::SetDtcSuppression can be used on suppressed DTCs too.

> ara::diag::DTCInformation::GetDtcSuppression和ara::diag::DTCInformation::SetDtcSuppression也可以用于已抑制的DTCs。


**[SWS_DM_01305]**{DRAFT} **Behavior of services ReadDTCInformation with DTC mask record for suppressed DTCs** *[*In all sub functions of service 0x19 = ReaDTCInformation with DTC mask record ( 0x01, 0x02, x0x07, 0x0A or 0x17) the Dagnostic Server instance shall count or report only DTCs which are not supressed.*♩(RS_Diag_04220)*

> **[SWS_DM_01305]**{草案} **服务ReadDTCInformation的DTC掩码记录的行为对于抑制的DTC** *[*在服务0x19 = ReaDTCInformation的所有子功能中，具有DTC掩码记录（0x01，0x02，x0x07，0x0A或0x17）的诊断服务器实例只应计算或报告未被抑制的DTC。*♩(RS_Diag_04220)*


**[SWS_DM_01304]**{DRAFT} **Behavior of services ReadDTCInformation for EtendedData and SnapshotData for suppressed DTCs** *[*All sub functions of service 0x19 = ReadDTCInformation with implicit DTCs status request ( 0x03, 0x04, 0x06, 0x18 or 0x19 ) on a suppressed DTC the Diagnostic Server instance shall send a negative response (NRC 0x31).*♩(RS_Diag_04220)*

> **[SWS_DM_01304]**{草案} **对于被抑制的DTC，服务ReadDTCInformation的行为对于扩展数据和快照数据** *[*对于使用隐式DTC状态请求（0x03，0x04，0x06，0x18或0x19）的服务0x19=ReadDTCInformation的所有子功能，诊断服务器实例应发送负响应（NRC 0x31）。*♩（RS_Diag_04220）*

简体中文：**[SWS_DM_01304]**{草案} **对于被抑制的DTC，服务ReadDTCInformation的行为对于扩展数据和快照数据** *[*对于使用隐式DTC状态请求（0x03，0x04，0x06，0x18或0x19）的服务0x19=ReadDTCInformation的所有子功能，诊断服务器实例应发送负响应（NRC 0x31）。*♩（RS_Diag_04220）*


**[SWS_DM_01303]**{DRAFT} **Behavior of Diagnostic Client services ClearDianosticInformation for suppressed DTCs** *[*If the Diagnostic Server instance receives a ClearDiagnosticInformation (0x14) request with a groupOfDTC DTC group that is suppressed and different to any configured value of DiagnosticTroublCodeGroup.groupNumber and has a value less than 0xFFFF00 (defined range for functional group identifier), the Diagnostic Server instance shall send a negtive response with NRC 0x31 (requestOutOfRange).*♩(RS_Diag_04220)*

> **[SWS_DM_01303]**{草案}**诊断客户端服务ClearDianosticInformation对于抑制的DTC的行为** *[*如果诊断服务器实例接收到一个ClearDiagnosticInformation（0x14）请求，其中的DTC组是被抑制的，且与DiagnosticTroublCodeGroup.groupNumber的任何配置值不同，并且其值小于0xFFFF00（功能组标识符的定义范围），诊断服务器实例应发送带有NRC 0x31（requestOutOfRange）的负响应。*♩（RS_Diag_04220）*


**[SWS_DM_01302]**{DRAFT} **Behavior of Diagnostic Client services ClearDianosticInformation for suppressed DTCs inside a group** *[*Any request with a group of DTCs that is a DTC group (including GroupOfAllDTCs) containing a suppressed DTC shall clear this suppressed DTC.*♩(RS_Diag_04220)*

> **[SWS_DM_01302]**{草案} **诊断客户服务ClearDianosticInformation对组内抑制的DTC的行为** *[*任何包含抑制DTC的DTC组（包括GroupOfAllDTCs）的请求都应清除此抑制DTC。*♩(RS_Diag_04220)*


There is no further influence of suppressed DTCs on the execution of service CleaDiagnosticInformation described in chapter [7.6.2.8.5](#service-0x14-cleardiagnosticinformation) "[Service 0x14 ClearDiagnos-](#service-0x14-cleardiagnosticinformation) [ticInformation](#service-0x14-cleardiagnosticinformation)".

> 没有被抑制的DTC对第7.6.2.8.5节中描述的服务ClearDiagnosticInformation的执行有进一步的影响。


**[SWS_DM_01301]**{DRAFT} **Behavior of ara::diag::Event class methods for suppressed DTCs** *[*A suppressed DTC shall be treated like not configured for the inteface ara::diag::Event with function ara::diag::Event::GetDTCNumber and shall return kNoSuchDTC.*♩(RS_Diag_04220)*

> **[SWS_DM_01301]**{草稿}**ara::diag::Event 类方法对于抑制的DTC的行为** *[*抑制的DTC应该被当作未配置对于ara::diag::Event 接口，使用ara::diag::Event::GetDTCNumber 函数，并且应该返回kNoSuchDTC。*♩(RS_Diag_04220)*


All other functions of class ara::diag::Event are not affected by suppressed DTCs.

> 所有ara::diag::Event类的其他功能不受抑制的DTCs的影响。


**[SWS_DM_01300]**{DRAFT} **Behavior of the ara::diag::DTCInformation class for suppressed DTCs** *[*A suppressed DTC shall be treated like not configured for the following functions of the class ara::diag::DTCInformation:

> **[SWS_DM_01300]**{草案} **ara::diag::DTCInformation类的抑制DTC的行为** *[*抑制DTC应该像未配置一样对待该类ara::diag::DTCInformation的以下功能：

- ara::diag::DTCInformation::GetCurrentStatus shall return kNSuchDTC.
- ara::diag::DTCInformation::GetNumberOfStoredEntries shall only count non suppressed DTCs.
- ara::diag::DTCInformation::Clear with parameter DTCGroup


is set to DTC group (including GroupOfAllDTCs) containing a suppressed DTC shall clear this suppressed DTC

> 设置为DTC组（包括GroupOfAllDTCs），其中包含被抑制的DTC，应清除此被抑制的DTC。

which is suppressed and different to any configured value of DiagnostiTroubleCodeGroup.groupNumber and has a value less than 0xFFFF00 (defined range for functional group identifier), the DM shall trigger the error kWrongDtc.

> 如果抑制的值不同于DiagnostiTroubleCodeGroup.groupNumber的任何配置值，而且值小于0xFFFF00（功能组标识符的定义范围），DM将触发错误kWrongDtc。

*♩(RS_Diag_04220)*


**[SWS_DM_01299]**{DRAFT} **Enabling of the notification ara::diag::DTCInformation::SetDTCStatusChangedNotifier for supressed DTCs** *[*If ara::diag::DTCInformation::SetDTCStatusChangedNtifier is called to enable the notification and the requested DTC is a suppressed DTC, the DM shall return kNoSuchDTC.*♩(RS_Diag_04220)*

> **[SWS_DM_01299]**{草案} **启用ara :: diag :: DTCInformation :: SetDTCStatusChangedNotifier用于抑制的DTC** *[*如果调用ara :: diag :: DTCInformation :: SetDTCStatusChangedNtifier来启用通知，而请求的DTC是一个抑制的DTC，DM应返回kNoSuchDTC。*♩（RS_Diag_04220）*


**[SWS_DM_01298]**{DRAFT} **Behavior of DTCInformtion::SetDTCStatusChangedNotifier for suppressed DTCs** *[*If a notification on status change is enabled and is caused by a suppressed DTC this notification shall be suppressed.*♩(RS_Diag_04220)*

> **[SWS_DM_01298]** {草案} **DTCInformtion::SetDTCStatusChangedNotifier 的抑制 DTC 的行为** *[*如果状态变化的通知被启用，并且是由一个抑制的DTC引起的，那么这个通知将被抑制。*♩(RS_Diag_04220)*


**[SWS_DM_01297]**{DRAFT} **Behavior of DTCInformtion::SetNumberOfStoredEntriesNotifier for suppressed DTCs** *[*If a notification on number of stored fault memory entries change is enabled, a suppressed DTC shall not release a notification triggered by suppressing or unsuppressing a DTC.*♩ (RS_Diag_04220)*

> **[SWS_DM_01297]**{草案} **抑制DTC的DTCInformtion::SetNumberOfStoredEntriesNotifier行为** *[*如果启用了存储故障存储条目数量变化的通知，则抑制或取消抑制DTC不会发出由此触发的通知。♩ (RS_Diag_04220)*


All other functions of interface ara::diag::DTCInformation are not affected by a suppressed DTC.

> 所有其他ara::diag::DTCInformation接口的功能都不受被抑制的DTC的影响。


**[SWS_DM_01296]**{DRAFT} **Behavior of service ResponseOnEvent with subfuntion onDTCStatusChange for suppressed DTCs** *[*Suppressed DTCs shall not lead to serviceToRespondTo messages for service ResponseOnEvent(0x86) with subfunction onDTCStatusChange(0x01).*♩(RS_Diag_04220)*

> **[SWS_DM_01296]**{草稿} **服务ResponseOnEvent的子功能onDTCStatusChange对抑制的DTC的行为** *[*抑制的DTC不应对服务ResponseOnEvent(0x86)的子功能onDTCStatusChange(0x01)发送serviceToRespondTo消息。*♩(RS_Diag_04220)*

简体中文：**[SWS_DM_01296]**{草案} **服务ResponseOnEvent的子功能onDTCStatusChange对抑制的DTC的行为** *[*抑制的DTC不应对服务ResponseOnEvent(0x86)的子功能onDTCStatusChange(0x01)发送serviceToRespondTo消息。*♩(RS_Diag_04220)*

### Indicators


Indicators can be associated with a particular DiagnosticEvent. Indicators or 'waring outputs' may consist of lamp(s), displayed text information or similar vendor specific expressions. There can be various DiagnosticEvents per indicator and one DiagnoticEvent can have zero, one or more different indicators assigned.

> 指标可以与特定的诊断事件相关联。指标或“警告输出”可以由灯泡、显示文本信息或类似的供应商特定表达式组成。每个指标可以有多个诊断事件，一个诊断事件可以有零个、一个或多个不同的指标分配。


The indicators are activated and deactivated based on the configured failure and heaing cycles per Event.

> 指标根据每个事件配置的失效和恢复周期而被激活和停用。


**[SWS_DM_00221]**{DRAFT} **Handling indicator status** *[*The DM shall handle the sttus of indicators assigned to events by the DiagnosticConnectedIndicator configuration item.*♩(RS_Diag_04204)*

> **[SWS_DM_00221]**{草案} **处理指示状态** *[*DM必须处理由DiagnosticConnectedIndicator配置项分配给事件的指示状态。*♩(RS_Diag_04204)*


**[SWS_DM_00888]**{DRAFT} **Observability of indicator status** *[*The DM shall provide the status of an indicator via the function ara::diag::Indicator::GetIndictor of the corresponding ara::diag::Indicator instance.*♩(RS_Diag_04204)*

> **[SWS_DM_00888]**{草案} **指示灯状态的可观察性** *[*DM 应通过相应 ara::diag::Indicator 实例的 ara::diag::Indicator::GetIndictor 功能提供指示灯的状态。*♩(RS_Diag_04204)*


Note that the status of an indicator is determined by all the status information votes provided by events assigned to the corresponding indicator.

> 注意，指标的状态取决于分配给相应指标的事件提供的所有状态信息投票。


**[SWS_DM_00223]**{DRAFT} **Handling of 'warningIndicatorRequested' bit** *[*The DM shall process the \"kWarningIndicatorRequested\" bit of DTCs in accordance with the status vote for the assigned indicator. The \"kWarningIndicatorRequested\" bit shall be set in case the status gets confirmed and consequently the events shall vote positively for setting the connected indicators.*♩(RS_Diag_04204)*

> **[SWS_DM_00223]**{草案} **处理“warningIndicatorRequested”位** *[*DM应根据分配指示器的状态投票处理DTC的“kWarningIndicatorRequested”位。如果状态得到确认，则应设置“kWarningIndicatorRequested”位，因此事件应积极投票以设置连接的指示器。*♩（RS_Diag_04204）*

简体中文：**[SWS_DM_00223]**{草案} **处理“warningIndicatorRequested”位** *[*DM应根据分配指示器的状态投票处理DTC的“kWarningIndicatorRequested”位。如果状态得到确认，则应设置“kWarningIndicatorRequested”位，因此事件应积极投票以设置连接的指示器。*♩（RS_Diag_04204）*


For confirmation check [[SWS_DM_00218](#_bookmark259)].

> 请参阅[[SWS_DM_00218](#_bookmark259)]以进行确认。


**[SWS_DM_01032]**{DRAFT} **Handling of 'WIR' bit without connected indicators** *[*If there exists no DiagnosticConnectedIndicator configuration item for a DianosticEvent and therefore no indicators are assigned to an event and the status for this event gets confirmed, the DM shall always keep the UDS DTC status bit \" kWarningIndicatorRequested\" at value '0'.*♩(RS_Diag_04204)*

> **[SWS_DM_01032]**{草稿} **处理没有连接指示器的“WIR”位** *[*如果一个诊断事件没有DiagnosticConnectedIndicator配置项，因此没有指示器分配给该事件，并且该事件的状态被确认，那么DM应始终将UDS DTC状态位“kWarningIndicatorRequested”的值保持为“0”。*♩（RS_Diag_04204）*


The DM process the indicator healing based on the DiagnosticConnectedIndictor.healingCycleCounterThreshold configuration parameter of the corrsponing indicator assigned to an event via DiagnosticConnectedIndicator.indictor.

> DM根据通过DiagnosticConnectedIndicator.indictor分配给事件的相应指标的DiagnosticConnectedIndictor.healingCycleCounterThreshold配置参数处理指标治疗。


[]{#_bookmark263 .anchor}**[SWS_DM_00224]**{DRAFT} **Indicator healing** *[*If the number of cycles (DiagnoticConnectedIndicator.healingCycle) in which the status was reported, but not failed, reaches the threshold and no user controlled WIR-bit request was set via the function ara::diag::Event::SetLatchedWIRStatus() for this event, the DM shall set the UDS DTC status bit \"kWarningIndicatorRequested\" to 0 and the event shall vote negatively for the activation of the indicator.*♩(RS_Diag_04204)*

> 如果报告状态，但未失败的周期（DiagnoticConnectedIndicator.healingCycle）达到阈值，且未通过ara :: diag :: Event :: SetLatchedWIRStatus（）函数设置用户控制的WIR位请求，则DM应将UDS DTC状态位“kWarningIndicatorRequested”设置为0，并且该事件将以负面投票激活指示器。（RS_Diag_04204）


**[SWS_DM_01266]**{DRAFT} **Warning Indicator Request Activation** *[*The DM shall set the kWarningIndicatorRequested of the DTC status always in the same time when the kConfirmedDTC bit is set to 1.*♩(RS_Diag_04204)*

> **[SWS_DM_01266]**{草稿} **警告指示器请求激活** *[*当kConfirmedDTC位被设置为1时，DM应始终设置DTC状态的kWarningIndicatorRequested。*♩(RS_Diag_04204)*


This means that the DiagnosticConnectedIndicator.indicatorFailureCcleCounterThreshold is not evaluated by the DM.

> 这意味着DM不会对DiagnosticConnectedIndicator.indicatorFailureCcleCounterThreshold进行评估。


**[SWS_DM_01359]**{DRAFT} **Consecutive registration of notifier with Indictor::SetNotifier()** *[*In case of a consecutive call of ara::diag::Indicator::SeNotifier of the corresponding ara::diag::Indicator instance, DM module shall overwrite the previous registered notifier.*♩(RS_Diag_04204)*

> **[SWS_DM_01359]**{草稿} **使用Indictor::SetNotifier()连续注册通知者** *[*如果对应的ara::diag::Indicator实例连续调用ara::diag::Indicator::SeNotifier，DM模块应该覆盖先前注册的通知者。*♩(RS_Diag_04204)*

### User controlled WarningIndicatorRequest-bit


In some cases (e.g. controlling a failsafe reaction in an application) the WIR-bit (WarningIndicatorRequest-bit) of a corresponding event in DM shall be set/reset by a dedicated \"fail-safe AA\".

> 在某些情况下（例如在应用程序中控制失效保护反应），相应事件的DM中的WIR-bit（WarningIndicatorRequest-bit）应由专用的“失效保护AA”设置/复位。


The \"failsafe AA\" has to ensure a proper status of the WIR-bit (e.g. regarding to IS14229-1[2] or manufacture specific requirements).

> "可靠性AA"必须确保WIR-bit的正确状态（例如根据IS14229-1[2]或制造商特定要求）。


The failsafe AA shall report the required WIR-status to DM (via the function ara::diag::Event::SetLatchedWIRStatus of the corresponding ara::diag:Event instance) and has to ensure that the current WIR-status of an event (in DM) fits to the current fail-safe-status in the application:

> 失效安全AA将向DM报告所需的WIR状态（通过相应ara :: diag :: Event :: SetLatchedWIRStatus函数），并确保DM中事件的当前WIR状态与应用程序中的当前故障安全状态相匹配：

- fail-safe reaction active: WIR-bit shall be set to \"1\"
- fail-safe reaction not active: WIR-bit shall be set to \"0\"


The fail-safe AA has to report the status after every change of its fail-safe state.

> 失效保护AA必须在每次更改其失效保护状态后报告状态。


Therefore the DM provides the function ara::diag::Event::SetLatchedWIRSttus to set or reset the UDS DTC status bit \"kWarningIndicatorRequested\" of the related DTC.

> 因此，DM提供了ara :: diag :: Event :: SetLatchedWIRSttus函数来设置或重置相关DTC的UDS DTC状态位“kWarningIndicatorRequested”。


Each invocation of the function ara::diag::Event::SetLatchedWIRStatus of an ara::diag::Event instance updates the WIR-bit for the corresponding DTC

> 每次调用ara::diag::Event::SetLatchedWIRStatus函数，ara::diag::Event实例就会更新相应DTC的WIR位。


Due to not storing the Status-Bit 7 ('warningIndicatorRequested' bit) on Shutdown, the fail-safe AA has to ensure that the 'warningIndicatorRequest' bit of a DTC fits to the current failsafe status after initialization of the DM.

> 由于在关机时不存储状态位7（“警告指示器请求”位），故障安全AA必须确保DTC的“警告指示器请求”位在DM初始化后符合当前的故障安全状态。


Setting the WIR-bit of a DTC can be controlled via SetLatchedWIRStatus() OR by the DM internal WIR-bit handling. (OR-Operation).

> 设置DTC的WIR位可以通过SetLatchedWIRStatus()或DM内部WIR位处理（或运算）来控制。


**[SWS_DM_01033]**{DRAFT} **User controlled set of WIR-bit** *[*If the function ara:diag::Event::SetLatchedWIRStatus is called with parameter status = TRUE, the DM shall set the WIR-bit of the corresponding DTC to \"1\".*♩(RS_Diag_04204)*

> 如果使用参数状态=TRUE调用ara：diag :: Event :: SetLatchedWIRStatus功能，DM应将相应DTC的WIR位设置为“1”。


**[SWS_DM_01034]**{DRAFT} **User controlled reset of WIR-bit** *[*If the function ara:diag::Event::SetLatchedWIRStatus is called with parameter status = FALSE and the DM internal WIR-bit handling is also not requesting it, the DM shall reset the WIR-bit of the corresponding event to \"0\".*♩(RS_Diag_04204)*

> 如果ara：diag :: Event :: SetLatchedWIRStatus被调用时参数status为FALSE，并且DM内部的WIR-bit处理也不需要它，DM应将相应事件的WIR-bit重置为“0”。


**[SWS_DM_01035]**{DRAFT} **User controlled WIR-bit handling and ControlDTCSeting** *[*If ControlDTCSetting is set to disabled according to [[SWS_DM_00910](#_bookmark180)] and the function ara::diag::Event::SetLatchedWIRStatus is called, the DM shall not change the status of the WIR-bit and the function shall return kReportIgnored.*♩ (RS_Diag_04204)*

> **[SWS_DM_01035]**{草案}**用户控制的WIR位处理和ControlDTCSeting** *[*如果根据[[SWS_DM_00910](#_bookmark180)]设置ControlDTCSetting为禁用，并且调用ara :: diag :: Event :: SetLatchedWIRStatus函数，DM不得更改WIR位的状态，该函数应返回kReportIgnored。*♩ (RS_Diag_04204)*

### Destination


Each DTC is stored in one of the supported event memories according to [[SWS_DM_00056](#_bookmark247)] and [[SWS_DM_00057](#_bookmark248)].

> 每个DTC根据[[SWS_DM_00056](#_bookmark247)]和[[SWS_DM_00057](#_bookmark248)]存储在支持的事件存储器之一中。


**[SWS_DM_00083]**{DRAFT} **Event memory destination of an DTC** *[*The exitence of DiagnosticTroubleCodeProps.memoryDestination shall assign all DTCs referencing this DiagnosticTroubleCodeProps to the event memory reerenced by DiagnosticTroubleCodeProps.memoryDestination.*♩(RS_Diag\04150, RS_Diag_04214)*

> **[SWS_DM_00083]**{草案} **DTC的事件记忆目的地** *[*DiagnosticTroubleCodeProps.memoryDestination的存在应将所有引用此DiagnosticTroubleCodeProps的DTC分配到由DiagnosticTroubleCodeProps.memoryDestination引用的事件记忆中。*♩（RS_Diag \ 04150，RS_Diag_04214）*


**[SWS_DM_CONSTR_00084]**{DRAFT} **Each DTC shall be assigned to an event memory destination** *[*The DM shall only support DTCs with a configured DianosticTroubleCodeProps.memoryDestination.*♩(RS_Diag_04150, RS_Diag\04214)*

> **[SWS_DM_CONSTR_00084]**{草案} **每个DTC都应分配给一个事件内存目标** *[*DM仅支持配置了DianosticTroubleCodeProps.memoryDestination的DTC。*♩（RS_Diag_04150，RS_Diag\04214）*

### DTC related data


The following sections deal with the DTC related data, what includes the triggering and location of freeze frames and extended data records to be stored to. Freeze frames consist of a set of DIDs and extended data records consist of a set of data elments, which shall be stored in configuration dependent situations.

> 以下部分讨论与DTC相关的数据，其中包括冻结帧的触发和位置以及要存储的扩展数据记录。冻结帧由一组DID组成，扩展数据记录由一组数据元素组成，在配置相关的情况下应存储。


**[SWS_DM_00148]**{DRAFT} **Persistent storage of event memory entries** *[*The DM shall be able to persistently store the status of all DTCs and for maxNumberOfEvetEntries per event memory the DTC related data:

> **[SWS_DM_00148]**{草稿} **事件记忆条目的持久存储** *[*DM必须能够持久存储所有DTC的状态，并且对于每个事件记忆的maxNumberOfEvetEntries，存储与DTC相关的数据：


- snapshot data if configured (at least one corresponding DiagnosticTroublCodeProps.freezeFrame reference exists in the configuration)

> 如果配置了，则快照数据（配置中至少存在一个对应的DiagnosticTroublCodeProps.freezeFrame引用）

- extended data if configured (at least one corresponding DiagnosticTroublCodeProps.extendedDataRecord reference exists in the configuration)

> 如果配置，则可提供扩展数据（配置中至少存在一个对应的DiagnosticTroublCodeProps.extendedDataRecord引用）


*♩(RS_Diag_04211, RS_Diag_04105)*

> *♩(RS_Diag_04211，RS_Diag_04105)*


**[SWS_DM_00969]**{DRAFT} **Padding in case of failed data capturing** *[*If duing data collection due to [[SWS_DM_01276](#_bookmark269)], [[SWS_DM_01277](#_bookmark270)], [[SWS_DM_01085](#_bookmark271)], [[SWS_DM_01086](#_bookmark272)] or [[SWS_DM_00895](#_bookmark274)] an external processor has an error of any source, the DM shall fill the missing data with the padding value 0xFF and trigger a Log and Trace LogError() message.*♩(RS_Diag_04205)*

> **[SWS_DM_00969]**（草案）**由于数据收集失败而进行填充** *[*如果由于[[SWS_DM_01276](#_bookmark269)], [[SWS_DM_01277](#_bookmark270)], [[SWS_DM_01085](#_bookmark271)], [[SWS_DM_01086](#_bookmark272)]或[[SWS_DM_00895](#_bookmark274)]外部处理器由于任何原因出现错误，DM应使用填充值0xFF填充缺失的数据，并触发Log和Trace LogError（）消息。*♩（RS_Diag_04205）*

### Triggering for data storage


**[SWS_DM_00150]**{DRAFT} **Primary trigger for event memory entry storage** *[*Creating and storing memory entries (incl. collecting DTC-related data) shall be triggered according to the DiagnosticMemoryDestination.memoryEntryStoageTrigger configuration parameter (see [[3](#_bookmark10)]).*♩(RS_Diag_04211, RS_Diag_04105)*

> **[SWS_DM_00150]**{草案} **事件记忆条目存储的主要触发器** *[*根据DiagnosticMemoryDestination.memoryEntryStoageTrigger配置参数（参见[[3](#_bookmark10)）创建和存储记忆条目（包括收集DTC相关数据）。*♩（RS_Diag_04211，RS_Diag_04105）*


Note that for updating snapshot record and extended data information record spcific configuration options are available. For details check the following sections.

> 注意，有特定配置选项可用于更新快照记录和扩展数据信息记录。有关详细信息，请查看以下部分。

### Storage of snapshot record data


**[SWS_DM_00151]**{DRAFT} **snapshot record numeration** *[*In case DiagnoticMemoryDestination.typeOfFreezeFrameRecordNumeration is set to calculated, the DM shall store freeze frames numbered consecutively starting with 1 in their chronological order. If the parameter is set to configured, the DM shall store the records based on the DiagnosticFreezeFrame.recordNumber configuration parameters of the respective freeze frames.*♩(RS_Diag_04205, RS_Diag_04189)*

> 【SWS_DM_00151】{草案} **快照记录编号** *[*如果DiagnoticMemoryDestination.typeOfFreezeFrameRecordNumeration被设置为calculated，DM将按照其时间顺序以1开始依次编号存储冻结帧。如果该参数被设置为configured，DM将根据各自冻结帧的DiagnosticFreezeFrame.recordNumber配置参数存储记录。♩(RS_Diag_04205，RS_Diag_04189)*


**[SWS_DM_00152]**{DRAFT} **Number of snapshot records for a DTC** *[*In case DagnosticMemoryDestination.typeOfFreezeFrameRecordNumeration is set to calculated, the number of snapshot record the DM is able to store for a DTC shall be determined by the DiagnosticTroubleCodeProps.maxNumberFreezFrameRecords configuration parameter. In case DiagnosticMemoryDestintion.typeOfFreezeFrameRecordNumeration is set to configured, the nuber of snapshot recordss is determined by the number of DiagnosticFreezFrames configured for a DTC.*♩(RS_Diag_04205, RS_Diag_04190)*

> 如果将DiagnosticMemoryDestination.typeOfFreezeFrameRecordNumeration设置为calculated，DM能够为DTC存储的快照记录数由DiagnosticTroubleCodeProps.maxNumberFreezFrameRecords配置参数决定。如果将DiagnosticMemoryDestintion.typeOfFreezeFrameRecordNumeration设置为configured，快照记录数由为DTC配置的DiagnosticFreezFrames数决定（RS_Diag_04205，RS_Diag_04190）。


Note that different snapshot records represent different snapshots collected in diferent points in time.

> 注意，不同的快照记录代表不同时间点收集的不同快照。


[]{#_bookmark269 .anchor}**[SWS_DM_01276]**{DRAFT} **Triggering for snapshot record storage (calclated, maxNumberFreezeFrameRecords = 1)** *[*If DiagnosticMemoryDestintion.typeOfFreezeFrameRecordNumeration is set to calculated and DianosticTroubleCodeProps.maxNumberFreezeFrameRecords is configured to 1, the DM shall collect and store the snapshot record only for the first transition of UDS DTC status bit 'testFailed' from '0' to '1'.*♩(RS_Diag_04205, RS_Diag_04127)*

> 如果DiagnosticMemoryDestintion.typeOfFreezeFrameRecordNumeration被设置为计算，并且DianosticTroubleCodeProps.maxNumberFreezeFrameRecords被配置为1，DM应只收集并存储UDS DTC状态位“testFailed”从“0”到“1”的第一次转换的快照记录。(RS_Diag_04205，RS_Diag_04127)


[]{#_bookmark270 .anchor}**[SWS_DM_01277]**{DRAFT} **Triggering for snapshot record storage (calclated, maxNumberFreezeFrameRecords \> 1)** *[*If DiagnosticMemoryDestintion.typeOfFreezeFrameRecordNumeration is set to calculated and DianosticTroubleCodeProps.maxNumberFreezeFrameRecords is configured to a value greater than 1, the DM shall collect and store the snapshot record on trasition of UDS DTC status bit 'testFailed' from '0' to '1' consecutively in the snashot records and in case all snapshot records are occupied only update the most recent snapshot record.*♩(RS_Diag_04205, RS_Diag_04127)*

> 如果DiagnosticMemoryDestintion.typeOfFreezeFrameRecordNumeration被设置为计算，并且DianosticTroubleCodeProps.maxNumberFreezeFrameRecords被配置为大于1的值，DM将在UDS DTC状态位'testFailed'从'0'转换到'1'时连续地收集和存储快照记录，如果所有快照记录都被占用，则仅更新最近的快照记录（RS_Diag_04205，RS_Diag_04127）。


[]{#_bookmark271 .anchor}**[SWS_DM_01085]**{DRAFT} **Triggering for snapshot record storage (configured, without update)** *[*If DiagnosticMemoryDestination.typeOfFreezeFrameRcordNumeration is set to configured, DiagnosticFreezeFrame.update is set to 'False', the configured DiagnosticFreezeFrame.trigger is fulfilled and the snapshot is not yet stored, the DM shall collect and store the snapshot record.*♩ (RS_Diag_04205, RS_Diag_04127)*

> 如果DiagnosticMemoryDestination.typeOfFreezeFrameRcordNumeration被设置为配置，DiagnosticFreezeFrame.update被设置为“False”，配置的DiagnosticFreezeFrame.trigger得到满足，快照尚未存储，DM应收集并存储快照记录。（RS_Diag_04205，RS_Diag_04127）


[]{#_bookmark272 .anchor}**[SWS_DM_01086]**{DRAFT} **Triggering for snapshot record storage (cofigured, with update)** *[*If DiagnosticMemoryDestination.typeOfFreezFrameRecordNumeration is set to configured, DiagnosticFreezeFrame.udate is set to 'True' and the configured DiagnosticFreezeFrame.trigger is fufilled, the DM shall collect and store, respectively update the snapshot record.*♩ (RS_Diag_04205, RS_Diag_04127)*

> 如果DiagnosticMemoryDestination.typeOfFreezFrameRecordNumeration被设置为配置，DiagnosticFreezeFrame.udate被设置为“True”并且配置的DiagnosticFreezeFrame.trigger得到满足，DM应收集并存储，或者更新快照记录（RS_Diag_04205，RS_Diag_04127）。


**[SWS_DM_01087]**{DRAFT} **Snapshot record layout** *[*If any snapshot record storage trigger occures, the DM shall capture the data defined by DiagnostiTroubleCodeProps.snapshotRecordContent. Each referenced DiagnostiDataIdentifier shall be captured via the PortPrototype configured for these DIDs.*♩(RS_Diag_04205)*

> **[SWS_DM_01087]**{草案} **快照记录布局** *[*如果发生任何快照记录存储触发器，DM应捕获由DiagnostiTroubleCodeProps.snapshotRecordContent定义的数据。每个引用的DiagnostiDataIdentifier应通过为这些DID配置的PortPrototype捕获。*♩(RS_Diag_04205)*


**[SWS_DM_00894]**{DRAFT} **Notification event upon snapshot record updates** *[*After the DM has captured and stored a new snapshot record or overwritten an existing snapshot record with new data and there is a registered update notifcation via the function ara::diag::DTCInformation::SetSnapshotRecordUdatedNotifier, the DM shall call this notifier for each snapshot record update.*♩ (RS_Diag_04148)*

> **[SWS_DM_00894]**{草稿} **快照记录更新时的通知事件** *[*当DM捕获和存储了一个新的快照记录或用新的数据覆盖了现有的快照记录，并且通过函数ara :: diag :: DTCInformation :: SetSnapshotRecordUdatedNotifier注册了更新通知，DM应该为每个快照记录更新调用此通知程序。*♩ (RS_Diag_04148)*

In case of

- deletion ([7.6.4.5.5](#clearing-dtcs))
- aging ([7.6.4.5.6](#aging))
- displacement ([7.6.4.5.10](#event-memory-entry-displacement))


the DM doesn't trigger the notification calls for updates.

> DM不触发通知更新的电话。


**[SWS_DM_01351]**{DRAFT} **Consecutive registration of notifier with SetSnashotRecordUpdatedNotifier()** *[*In case of a consecutive call of ara::diag:DTCInformation::SetSnapshotRecordUpdatedNotifier of the corresponing ara::diag::DTCInformation instance, DM module shall overwrite the previous registered notifier.*♩(RS_Diag_04183)*

> **[SWS_DM_01351]**{草案}**使用SetSnashotRecordUpdatedNotifier()连续注册通知者** *[*如果对应的ara::diag::DTCInformation实例连续调用ara::diag:DTCInformation::SetSnapshotRecordUpdatedNotifier，DM模块应该覆盖先前注册的通知者。*♩(RS_Diag_04183)*

### Storage of extended data


This section describes the configuration of and the access to extended data for a DTC.

> 这一节描述了DTC的扩展数据的配置和访问。


**[SWS_DM_00154]**{DRAFT} **Number of extended data for a DTC** *[*The DM shall store zero or one extended data for a DTC. Extended data consists of extended data records. If at least one DiagnosticTroubleCodeProps.extendedDataRecord is configured for the corresponding DTC, the extended data shall be present in the event memory entry.*♩(RS_Diag_04206, RS_Diag_04190)*

> **[SWS_DM_00154]**{草案} **DTC的扩展数据数量** *[*DM应存储DTC的零个或一个扩展数据。扩展数据由扩展数据记录组成。如果为相应的DTC配置了至少一个DiagnosticTroubleCodeProps.extendedDataRecord，则事件存储器条目中应包含扩展数据。*♩(RS_Diag_04206, RS_Diag_04190)*


Note that contrary to snapshot records, extended data records do not neessarily represent data collected in different points in time. Extended data consists of a configurable number of extended data records, which are all collected when the respective memory entry is created in the event memory. The update mechanism of extended data records is configurable.

> 注意，与快照记录相反，扩展数据记录不一定代表在不同时间点收集的数据。扩展数据由可配置的扩展数据记录组成，这些记录都是在事件存储器中创建相应内存条目时收集的。扩展数据记录的更新机制可配置。


An extended data record typically contains DM internal data information. This is represented as DiagnosticDataElement referenced from DiagnosticPrvidedDataMapping, where the dataProvider defines the content of the intenal data. Such data elements can only be used within the scope of an extended data records. The DEXT limits a use in other DiagnosticDataElement such as from snapshot records or DiagnosticDataElement from DIDs.

> 一个扩展数据记录通常包含DM内部数据信息。这由DiagnosticDataElement参考自DiagnosticPrvidedDataMapping表示，其中数据提供者定义了内部数据的内容。这些数据元素只能在扩展数据记录范围内使用。 DEXT限制在其他诊断数据元素（如快照记录或DID中的诊断数据元素）中的使用。


**[SWS_DM_00155]**{DRAFT} **Extended data record numeration** *[*Extended data record numbers shall always be determined by the configuration. The DianosticExtendedDataRecord.recordNumber configuration parameter defines the record number for each extended data record.*♩(RS_Diag_04206, RS_Diag\04189)*

> **[SWS_DM_00155]**{草稿} **扩展数据记录编号** *[*扩展数据记录的编号应始终由配置确定。 DianosticExtendedDataRecord.recordNumber 配置参数定义每条扩展数据记录的记录号。*♩(RS_Diag_04206, RS_Diag\04189)*


[]{#_bookmark274 .anchor}**[SWS_DM_00895]**{DRAFT} **Triggering for extended data record storage and updates** *[*The data collection and storage of the extended data record shall be triggered by the DiagnosticExtendedDataRecord.trigger. Updating extended data records after being first stored, shall be configurable with the DianosticExtendedDataRecord.update configuration parameter. The data layout of extended data record is defined by the order of DiagnosticExtendeDataRecord.recordElement. Each DiagnosticDataElement shall be captured in its order via the corresponding read function instance for Typed DataElement: Namespace1OfPortInterface::Namespace2OfPortInterface::ShornameOfDEPortInterface::Read.*♩(RS_Diag_04206, RS_Diag_04127)*

> [SWS_DM_00895]{DRAFT} 触发扩展数据记录存储和更新 *[*扩展数据记录的数据收集和存储应由DiagnosticExtendedDataRecord.trigger触发。在首次存储后更新扩展数据记录应配置为DianosticExtendedDataRecord.update配置参数。扩展数据记录的数据布局由DiagnosticExtendeDataRecord.recordElement的顺序定义。每个DiagnosticDataElement应按其相应的Typed DataElement读取函数实例顺序捕获：Namespace1OfPortInterface::Namespace2OfPortInterface::ShornameOfDEPortInterface::Read.*♩(RS_Diag_04206, RS_Diag_04127)*

### Internal statistical data elements in EDRs


The DM module provides the ability to map internal data elements, like e.g. aging counter, occurrence counter, \... (see Table [7.9](#_bookmark300) for the full list) to a specific dataElement contained in a DiagnosticExtendedDataRecord.

> 模块DM提供了将内部数据元素（例如老化计数器、发生计数器等，参见表7.9以获取完整列表）映射到特定的DiagnosticExtendedDataRecord中的数据元素的能力。


If a DMinternal DiagnosticDataElement is mapped to an extended data record by configuration, this information can be requested by the UDS service 0x19 ReadDTCInformationSubFunction 0x06 reportDTCExtendedDataRecordBDTCNumber ([7.6.2.8.6.5](#sf-0x06-reportdtcextdatarecordbydtcnumber)).

> 如果通过配置将DMinternal诊断数据元素映射到扩展数据记录，则可以通过UDS服务0x19 ReadDTCInformationSubFunction 0x06 reportDTCExtendedDataRecordBDTCNumber（[7.6.2.8.6.5]（#sf-0x06-reportdtcextdatarecordbydtcnumber））请求此信息。


The internal data elements with context \"DEM\" in Table [7.9](#_bookmark300) are not additionally stored or frozen in the extended data record when the event memory storage is triggered.

> 内部数据元素在表7.9中以“DEM”的上下文不会在事件存储触发时另外存储或冻结在扩展数据记录中。


**[SWS_DM_00949]**{DRAFT} **Generation and usage of internal DiagnosticDataElments** *[*If an internal DiagnosticDataElement with context \"DEM\" gets used when the error memory is read out via diagnostic communication, the DM shall use the current value of that internal data element at the time when the error memory is read out.*♩(RS_Diag_04127, RS_Diag_04190)*

> 如果通过诊断通信读取错误存储器时使用具有上下文“DEM”的内部诊断数据元素，则DM应在读取错误存储器时使用该内部数据元素的当前值（RS_Diag_04127，RS_Diag_04190）。


**[SWS_DM_00950]**{DRAFT} **Configuration of DTC priority as extended data record** *[*If the configuration parameter DiagnosticProvidedDataMapping.daaProvider of the corresponding DiagnosticParameter.dataElement is set to DEM_PRIORITY, the DM shall set the value of this internal data element to the DTC priority assigned by DiagnosticTroubleCodeProps.priority for this DTC. The length of this internal data element is one byte.*♩(RS_Diag_04190)*

> **[SWS_DM_00950]**{草案} **将DTC优先级配置为扩展数据记录** *[*如果相应的DiagnosticParameter.dataElement的配置参数DiagnosticProvidedDataMapping.daaProvider设置为DEM_PRIORITY，DM应将此内部数据元素的值设置为由DiagnosticTroubleCodeProps.priority为此DTC分配的DTC优先级。此内部数据元素的长度为一个字节。*♩(RS_Diag_04190)*

将DTC优先级配置为扩展数据记录：如果相应的DiagnosticParameter.dataElement的配置参数DiagnosticProvidedDataMapping.daaProvider设置为DEM_PRIORITY，DM应将此内部数据元素的值设置为由DiagnosticTroubleCodeProps.priority为此DTC分配的DTC优先级，该内部数据元素的长度为一个字节。


**[SWS_DM_00921]**{DRAFT} **Configuration of Error Memory Overflow Indiction as extended data record** *[*If the configuration parameter DiagnosticPrvidedDataMapping.dataProvider of the corresponding DiagnosticParamter.dataElement is set to DEM_OVFLIND, the DM shall set the value of this iternal data element to the DM-internal value for event memory overflow to which the related DTC belongs to and map it:

> **[SWS_DM_00921]**{草案} **错误存储器溢出指示的配置作为扩展数据记录** *[*如果相应的DiagnosticParamter.dataElement的配置参数DiagnosticPrvidedDataMapping.dataProvider设置为DEM_OVFLIND，DM应将此内部数据元素的值设置为与相关DTC所属的DM内部事件存储器溢出的值，并进行映射：

- \"0\" = False, in case no event memory overflow was detected.
- \"1\" = True, in case an event memory overflow was detected.


The length of this internal DiagnosticDataElement is one byte.*♩(RS_Diag\04093, RS_Diag_04190)*

> 这个内部诊断数据元素的长度为一个字节。（RS_Diag 93，RS_Diag 04190）


For more details, see also [7.6.4.5.9](#event-memory-overflow) "[Event memory overflow](#event-memory-overflow)".

> 详情请参见[7.6.4.5.9](#event-memory-overflow)“[事件内存溢出](#event-memory-overflow)”。


**[SWS_DM_00951]**{DRAFT} **Configuration of DTC \"current FDC\" as extended data record** *[*If the configuration parameter DiagnosticProvidedDataMapping.daaProvider of the corresponding DiagnosticParameter.dataElement is set to DEM_CURRENT_FDC, the DM shall report the internal value of the current Fault Dtection Counter of the contextual DTC in the respective DiagnosticExtendeDataRecord's DiagnosticDataElement.

> **[SWS_DM_00951]**{草案} **将DTC的“当前FDC”配置为扩展数据记录** *[*如果相应的DiagnosticParameter.dataElement的配置参数DiagnosticProvidedDataMapping.daaProvider设置为DEM_CURRENT_FDC，DM应在相应的DiagnosticExtendeDataRecord的DiagnosticDataElement中报告上下文DTC的当前故障检测计数器的内部值。


The length of this internal data element is one byte.*♩(RS_Diag_04190)*

> 这个内部数据元素的长度为一个字节。♩（RS_Diag_04190）


The value translation from the internal debouncing mechanisms to the FDC is defined in [[SWS_DM_00017](#_bookmark231)] and [[SWS_DM_00030](#_bookmark235)].

> 内部去抖机制到FDC的值转换定义在[[SWS_DM_00017](#_bookmark231)]和[[SWS_DM_00030](#_bookmark235)]中。


**[SWS_DM_00952]**{DRAFT} **Configuration of DTC \"max. FDC since clear\" as extended data record** *[*If the configuration parameter DiagnosticPrvidedDataMapping.dataProvider of the corresponding DiagnosticParamter.dataElement is set to DEM_MAX_FDC_SINCE_LAST_CLEAR, the DM shall report the internal value of the current maximum Fault Detection Counter since last clear of the contextual DTC in the respective DiagnosticExtendedDataRecord's DianosticDataElement.

> **[SWS_DM_00952]**{草稿} **配置DTC“max. FDC自清除”作为扩展数据记录** *[*如果相应DiagnosticPrvidedDataMapping.dataProvider的DiagnosticParamter.dataElement设置为DEM_MAX_FDC_SINCE_LAST_CLEAR，DM应在相应的DiagnosticExtendedDataRecord的DianosticDataElement中报告上下文DTC的当前最大故障检测计数器自上次清除以来的内部值。


The length of this internal data element is one byte.*♩(RS_Diag_04068, RS_Diag\_-*

> 这个内部数据元素的长度是一个字节。

*04190)*


**[SWS_DM_00953]**{DRAFT} **Configuration of DTC \"max. FDC current ccle\" as extended data record** *[*If the configuration parameter DiagnosticPrvidedDataMapping.dataProvider of the corresponding DiagnosticParamter.dataElement is set to DEM_MAX_FDC_DURING_CURRENT_CYCLE, the DM shall report the internal value of the current maximum Fault Detection Counter during the current operation cycle of the contextual DTC in the respective DiagnosticEtendedDataRecord's DiagnosticDataElement.

> **[SWS_DM_00953]**{草案} **配置DTC“最大FDC电流循环”作为扩展数据记录** *[*如果相应的DiagnosticPrvidedDataMapping.dataProvider的DiagnosticParamter.dataElement设置为DEM_MAX_FDC_DURING_CURRENT_CYCLE，DM应在相应的DiagnosticEtendedDataRecord的DiagnosticDataElement中报告上下文DTC在当前操作周期内的当前最大故障检测计数器的内部值。


The length of this internal data element is one byte.*♩(RS_Diag_04127, RS_Diag\_-4190)*

> 这个内部数据元素的长度为一个字节。


**[SWS_DM_00954]**{DRAFT} **Configuration of DTC \"occurrence counter\" as extended data record** *[*If the configuration parameter DiagnosticProvideDataMapping.dataProvider of the corresponding DiagnosticParameter. dataElement is set to DEM_OCCCTR, the DM shall report the internal value of the current occurrence counter of the contextual DTC in the respective DiagnosticEtendedDataRecord's DiagnosticDataElement.

> **[SWS_DM_00954]**{草案} **将DTC“发生计数器”配置为扩展数据记录** *[*如果相应DiagnosticParameter的DiagnosticProvideDataMapping.dataProvider参数设置为DEM_OCCCTR，DM应在相应的DiagnosticEtendedDataRecord的DiagnosticDataElement中报告上下文DTC的当前发生计数器的内部值。


The length of this internal data element is one byte.*♩(RS_Diag_04190)*

> 这个内部数据元素的长度为一个字节。♩(RS_Diag_04190)


For Event occurrence see [7.6.4.2.8](#event-occurrence).

> 查看事件发生情况，请参阅[7.6.4.2.8](#event-occurrence)。


**[SWS_DM_00955]**{DRAFT} **Configuration of DTC \"aging counter up/down\" as extended data record** *[*If the configuration parameter DiagnosticPrvidedDataMapping.dataProvider of the corresponding DiagnosticParamter.dataElement is set to DEM_AGINGCTR_UPCNT or to DEM_AGINGCTR_DOWNCNT, the DM shall report the internal value of the current aging counter of the contextual DTC in the respective DiagnosticExtendedDataRecord's DiagnosticDataElement based on [[SWS_DM_00956](#_bookmark276)] or [[SWS_DM_00957](#_bookmark277)].*♩(RS_Diag_04190)*

> **[SWS_DM_00955]**{草案} **配置 DTC “老化计数器上/下”作为扩展数据记录** *[*如果相应的 DiagnosticParamter.dataElement 的配置参数 DiagnosticPrvidedDataMapping.dataProvider 设置为 DEM_AGINGCTR_UPCNT 或 DEM_AGINGCTR_DOWNCNT，DM 将根据 [[SWS_DM_00956](#_bookmark276)] 或 [[SWS_DM_00957](#_bookmark277)]，在相应的 DiagnosticExtendedDataRecord 的 DiagnosticDataElement 中报告上下文 DTC 的当前老化计数器的内部值。*♩(RS_Diag_04190)*

简体中文：**[SWS_DM_00955]**{草案} **配置 DTC “老化计数器上/下”作为扩展数据记录** *[*如果相应的 DiagnosticParamter.dataElement 的配置参数 DiagnosticPrvidedDataMapping.dataProvider 设置为 DEM_AGINGCTR_UPCNT 或 DEM_AGINGCTR_DOWNCNT，DM 将根据 [[SWS_DM_00956](#_bookmark276)] 或 [[SWS_DM_00957](#_bookmark277)]，在相应的 DiagnosticExtendedDataRecord 的 DiagnosticDataElement 中报告上下文 DTC 的当前老化计数器的内部值。*♩(RS_Diag_04190)*


For Aging see [7.6.4.5.6](#aging).

> 对于老化，请参见[7.6.4.5.6](#aging)。


[]{#_bookmark276 .anchor}**[SWS_DM_00956]**{DRAFT} **Configuration of DTC \"aging counter up\" as extended data record** *[*If the configuration parameter DiagnosticProvidedDataMapping. dataProvider is set to DEM_AGINGCTR_UPCNT, the DM shall map the internal aging counter in such a way that a counting-up mode from '0' to the DiagnosticAging. threshold value is created according to ISO 14229-1[[1](#_bookmark8)], Annex D.*♩(RS_Diag_04190)*

> 如果配置参数DiagnosticProvidedDataMapping.dataProvider设置为DEM_AGINGCTR_UPCNT，则根据ISO 14229-1 [[1]（#_bookmark8）]，附件D，DM应将内部老化计数器映射为从“0”到DiagnosticAging.阈值的计数模式。


[]{#_bookmark277 .anchor}**[SWS_DM_00957]**{DRAFT} **Configuration of DTC \"aging counter down\" as extended data record** *[*If the configuration parameter DiagnosticProvideDataMapping.dataProvider is set to DEM_AGINGCTR_DOWNCNT, the DM shall map the internal aging counter in such a way that a counting-down mode from the DianosticAging.threshold value to '0' is created.*♩(RS_Diag_04190)*

> 如果配置参数DiagnosticProvideDataMapping.dataProvider被设置为DEM_AGINGCTR_DOWNCNT，则DM应将内部老化计数器映射为从DiagnosticAging.threshold值到'0'的倒计时模式。


**[SWS_DM_00958]**{DRAFT} **Default value for DTC \"aging counter up\" if aging is not allowed** *[*If the element DiagnosticTroubleCodeProps.aging does not exist and the configuration parameter DiagnosticProvidedDataMapping.daaProvider of the corresponding DiagnosticParameter.dataElement is set to DEM_AGINGCTR_UPCNT, the DM shall set the respective DiagnosticExtendeDataRecord's DiagnosticDataElement value to '0'.*♩(RS_Diag_04190)*

> **[SWS_DM_00958]**{草案} **如果不允许老化，DTC“老化计数器上升”的默认值** *[*如果元素DiagnosticTroubleCodeProps.aging不存在，并且相应DiagnosticParameter.dataElement的配置参数DiagnosticProvidedDataMapping.daaProvider设置为DEM_AGINGCTR_UPCNT，DM应将相应的DiagnosticExtendeDataRecord的DiagnosticDataElement值设置为'0'。*♩(RS_Diag_04190)*

简体中文：**[SWS_DM_00958]**{草案} **如果不允许老化，DTC“老化计数器上升”的默认值** *[*如果元素DiagnosticTroubleCodeProps.aging不存在，并且相应DiagnosticParameter.dataElement的配置参数DiagnosticProvidedDataMapping.daaProvider设置为DEM_AGINGCTR_UPCNT，DM应将相应的DiagnosticExtendeDataRecord的DiagnosticDataElement值设置为'0'。*♩(RS_Diag_04190)*


**[SWS_DM_00959]**{DRAFT} **Default value for DTC \"aging counter down\" if aging is not allowed** *[*If the element DiagnosticTroubleCodeProps.aging does not exist and the configuration parameter DiagnosticProvidedDataMapping.daaProvider of the corresponding DiagnosticParameter.dataElement is set to

> **[SWS_DM_00959]**{草案} **如果不允许老化，DTC“老化计数器下降”的默认值** *[*如果元素DiagnosticTroubleCodeProps.aging不存在，并且相应的DiagnosticParameter.dataElement的配置参数DiagnosticProvidedDataMapping.daaProvider设置为


DEM_AGINGCTR_DOWNCNT, the DM shall set the respective DiagnosticExtendeDataRecord's DiagnosticDataElement value to DiagnosticAging.thresold if configured or '255' otherwise.*♩(RS_Diag_04190)*

> 如果配置了，DM应将各个DiagnosticExtendeDataRecord的DiagnosticDataElement值设置为DiagnosticAging.thresold，否则设置为'255'（RS_Diag_04190）。

### [SWS_DM_CONSTR_00960] {DRAFT} No support for


**DEM_AGINGCTR_UPCNT_FIRST_ACTIVE** *[*\"DEM_AGINGCTR_UPCNT_FIRST_ACTIVE\"

> \"DEM_AGINGCTR_UPCNT_FIRST_ACTIVE\"：首次活跃老化控制器计数


for the configuration parameter DiagnosticProvidedDataMapping.daaProvider of a DiagnosticParameter.dataElement shall not be supported by the DM.*♩(RS_Diag_04133)*

> 对于诊断参数的数据元素，不支持DiagnosticProvidedDataMapping.daaProvider配置参数（RS_Diag_04133）。


**[SWS_DM_00961]**{DRAFT} **Configuration of a DTCs significance as extended data record** *[*If the configuration parameter DiagnosticProvidedDataMapping. dataProvider of the corresponding DiagnosticParameter.dataElement is set to DEM_SIGNIFICANCE, the DM shall set the value of this internal data element to the DTCs significance assigned by DiagnosticTroubleCodeProps.signifcance for this DTC and map it:

> **[SWS_DM_00961]**{草案} **将DTC的重要性配置为扩展数据记录** *[*如果配置参数DiagnosticProvidedDataMapping.dataProvider的相应DiagnosticParameter.dataElement设置为DEM_SIGNIFICANCE，DM应将此内部数据元素的值设置为由DiagnosticTroubleCodeProps.signifcance分配给此DTC的DTC的重要性，并对其进行映射：

- \"0\" = occurence.
- \"1\" = fault.


The length of this internal DiagnosticDataElement is one byte.*♩(RS_Diag\04190)*

> 这个内部诊断数据元素的长度为一个字节。（RS_Diag\04190）


**[SWS_DM_00962]**{DRAFT} **Configuration of a DTCs Failed Operation Ccles as extended data record** *[*If the configuration parameter DiagnosticPrvidedDataMapping.dataProvider of the corresponding DiagnosticParamter.dataElement is set to DEM_FAILED_CYCLES, the DM shall report the internal value of the current Failed Operation Cycles Counter of the contextual DTC in the rspective DiagnosticExtendedDataRecord's DiagnosticDataElement.

> **[SWS_DM_00962]**{草稿} **配置失败操作次数计数器作为扩展数据记录** *[*如果相应的DiagnosticParameter.dataElement的配置参数DiagnosticProvidedDataMapping.dataProvider设置为DEM_FAILED_CYCLES，DM将在相应的DiagnosticExtendedDataRecord的DiagnosticDataElement中报告上下文DTC的当前失败操作次数计数器的内部值。


The length of this internal data element is one byte.*♩(RS_Diag_04190)*

> 这个内部数据元素的长度是一个字节。♩（RS_Diag_04190）


**[SWS_DM_00963]**{DRAFT} **Configuration of a DTCs failed operation Cycles Since First Failed as extended data record** *[*If the configuration parameter DiagnoticProvidedDataMapping.dataProvider of the corresponding DiagnosticPrameter.dataElement is set to DEM_CYCLES_SINCE_FIRST_FAILED, the DM shall report the internal value of the current Operation Cycles Since First Failed Counter of the contextual DTC in the respective DiagnosticExtendedDataRecord's DianosticDataElement.

> **[SWS_DM_00963]**{草案} **配置DTCs失效操作循环计数器作为扩展数据记录** *[*如果相应的DiagnosticPrameter.dataElement的DiagnoticProvidedDataMapping.dataProvider参数设置为DEM_CYCLES_SINCE_FIRST_FAILED，DM应该在相应的DiagnosticExtendedDataRecord的DianosticDataElement中报告上下文DTC的当前操作循环计数器的内部值。

简体中文：**[SWS_DM_00963]**{草案} **配置DTCs失效操作循环计数器作为扩展数据记录** *[*如果相应的DiagnosticPrameter.dataElement的DiagnoticProvidedDataMapping.dataProvider参数设置为DEM_CYCLES_SINCE_FIRST_FAILED，DM应当在相应的DiagnosticExtendedDataRecord的DianosticDataElement中报告上下文DTC的当前操作循环计数器的内部值。


The length of this internal data element is one byte.*♩(RS_Diag_04190)*

> 这个内部数据元素的长度为一个字节。♩(RS_Diag_04190)


**[SWS_DM_00964]**{DRAFT} **Configuration of a DTCs failed operation Cycles Since Last Failed as extended data record** *[*If the configuration parameter DiagnoticProvidedDataMapping.dataProvider of the corresponding DiagnosticPrameter.dataElement is set to DEM_CYCLES_SINCE_LAST_FAILED, the DM shall report the internal value of the current Operation Cycles Since Last Failed Counter of the contextual DTC in the respective DiagnosticExtendedDataRecord's DianosticDataElement.

> 如果相应的DiagnosticParameter.dataElement的DiagnoticProvidedDataMapping.dataProvider参数设置为DEM_CYCLES_SINCE_LAST_FAILED，那么DM将在相应的DiagnosticExtendedDataRecord的DianosticDataElement中报告上下文DTC的当前Operation Cycles Since Last Failed Counter的内部值。


The length of this internal data element is one byte.*♩(RS_Diag_04190)*

> 这个内部数据元素的长度为一个字节。♩(RS_Diag_04190)

### Clearing DTCs


Clearing a DTC or a DTC group is the ability of the DM to reset the UDS DTC sttus byte of each DTC and deleting DTC assigned snapshot records, extended data records and further DTC-related data.

> 清除DTC或DTC组是DM重置UDS DTC状态字节和删除分配的快照记录、扩展数据记录以及其他与DTC相关数据的能力。


**[SWS_DM_00116]**{DRAFT} **Clearing a DTC group** *[*When the DM is about to clear a DTC group it shall apply the same clear operation process as for a single DTC on all the DTCs of the DTC group which is cleared.*♩(RS_Diag_04117)*

> **[SWS_DM_00116]**{草案} **清除故障码组** *[*当DM要清除故障码组时，应将相同的清除操作过程应用于所清除的故障码组的所有故障码。*♩(RS_Diag_04117)*


**[SWS_DM_00117]**{DRAFT} **Clearing a DTC** *[*When the DM is about to clear a DTC it shall reset the event and UDS DTC status byte and clear the snapshot records and extended data records stored for this DTC and its DTC-related data.*♩(RS\Diag_04117)*

> **[SWS_DM_00117]**{草案} **清除故障码** *[*当DM准备清除故障码时，它将重置事件和UDS故障码状态字节，并清除为该故障码及其相关数据存储的快照记录和扩展数据记录。*♩(RS\Diag_04117)*

### Locking of the DTC clearing process by a client


The DM supports more than one Diagnostic Clients as described in section

> DM可支持按照本节所述支持多个诊断客户端。


[7.6.2.1.1](#parallel-client-handling). All configured clients can simultaneously send a ClearDTC diagnostic rquest. This chapter describes the DM behavior in this situations.

> 所有配置的客户端可以同时发送ClearDTC诊断请求。本章节描述了在这种情况下DM的行为。


[]{#_bookmark280 .anchor}**[SWS_DM_00144]**{DRAFT} **Parallel clearing DTCs in different DiagnosticMemryDestination** *[*The DM shall support parallel clearing of DTCs if the target of the clear DTC operation is a different DiagnosticMemoryDestination.*♩(RS_Diag\04117)*

> [SWS_DM_00144]{草案} 并行清除不同诊断记忆目标的DTCs  *[*如果清除DTC操作的目标是不同的诊断记忆目标，DM应支持并行清除DTCs。*♩(RS_Diag\04117)*


**[SWS_DM_00145]**{DRAFT} **Allow only one simultaneous clear DTC operation for one DiagnosticMemoryDestination** *[*If a Diagnostic Client is clearing the DTCs of a DiagnosticMemoryDestination the DM shall lock the clear DTC opertion for all other clients requesting to clear the DTCs of the same DiagnosticMemryDestination.*♩(RS_Diag_04117)*

> **[SWS_DM_00145]**{草案}**只允许一个诊断存储器目的地同时进行一次清除DTC操作** *[*如果诊断客户端正在清除诊断存储器目的地的DTC，则DM应锁定其他要求清除同一诊断存储器目的地DTC的客户端的清除DTC操作。*♩（RS_Diag_04117）*


**[SWS_DM_00146]**{DRAFT} **Unlock clear DTC operation for one DiagnosticMemryDestination** *[*After the DM has finished the clear DTC operation, it shall unlock the clear DTC operation for this DiagnosticMemoryDestination.*♩(RS_Diag_04117)*

> **[SWS_DM_00146]**{草案}**解锁清除DTC操作一个诊断存储器目标** *[*在DM完成清除DTC操作后，它应该解锁这个诊断存储器目标的清除DTC操作。*♩(RS_Diag_04117)*


**[SWS_DM_00147]**{DRAFT} **Behavior while trying to clear DTCs on a locked DagnosticMemoryDestination** *[*If the DM is requested to clear DTCs of a DianosticMemoryDestination and the DM has locked this DiagnosticMemoryDetination for clearing DTCs according to [[SWS_DM_00144](#_bookmark280)], the DM shall refuse the second clear DTC operation and shall return a NRC 0x22 (ConditionsNotCorrect).*♩ (RS_Diag_04117)*

> 如果DM被要求清除DiagnosticMemoryDetination的DTC，而DM已经根据[SWS_DM_00144]（# _bookmark280）锁定了该DiagnosticMemoryDetination以进行清除DTC操作，则DM应拒绝第二次清除DTC操作，并返回NRC 0x22（ConditionsNotCorrect）。（RS_Diag_04117）

### ClearConditions


In certain situations it is desirable to avoid that a DTC is cleared from the event meory. DiagnosticClearConditions are mapped to DTCs by DiagnosticTrobleCodeUdsToClearConditionGroupMappings.

> 在某些情况下，最好避免从事件内存中清除DTC。DiagnosticClearConditions通过DiagnosticTrobleCodeUdsToClearConditionGroupMappings映射到DTC。


[]{#_bookmark282 .anchor}**[SWS_DM_00896]**{DRAFT} **Handling of DiagnosticClearConditions** *[*If any of the clear conditions mapped to the DTC to be cleared are not fulfilled by a call of the function ara::diag::Condition::SetCondition with the value kConditioFalse, the clear is forbidden. Otherwise (all of the clear conditions mapped to the DTC are fulfilled) the clear is allowed.*♩(RS_Diag_04117)*

> 如果通过调用ara :: diag :: Condition :: SetCondition（值为kConditioFalse）未满足要清除的DTC映射的任何清除条件，则禁止清除。 否则（映射到DTC的所有清除条件都得到满足）允许清除。♩（RS_Diag_04117）


The effect of a forbidden clear DTC operation is described in the requirements below:

> 下面的要求描述了禁止清除DTC操作的效果：


**[SWS_DM_00123]**{DRAFT} **Block clearing of UDS DTC status byte during a clear DTC operation** *[*If the DM is requested to clear a DTC with a forbidden clear according to [[SWS_DM_00896](#_bookmark282)] and a DiagnosticEventToTroubleCodeUdsMaping exists with a mapping from this DTC to an event and the event has DianosticEvent.clearEventAllowedBehavior set to noStatusByteChange, the DM shall not change the UDS DTC status byte.*♩(RS_Diag_04117)*

> **[SWS_DM_00123]**{草案} **在清除故障码操作期间，禁止清除UDS故障码状态字节** *[*如果DM被要求根据[[SWS_DM_00896](#_bookmark282)]清除禁止清除的故障码，并且存在从此故障码映射到事件的DiagnosticEventToTroubleCodeUdsMaping，且该事件具有DianosticEvent.clearEventAllowedBehavior设置为noStatusByteChange，那么DM不得更改UDS故障码状态字节。*♩(RS_Diag_04117)*


**[SWS_DM_00124]**{DRAFT} **Limited clearing of UDS DTC status byte during a clear DTC operation** *[*If the DM is requested to clear a DTC with a forbidden clear according to [[SWS_DM_00896](#_bookmark282)] and a DiagnosticEventToTroubleCodeUdsMaping exists with a mapping from this DTC to an event and the event has DianosticEvent.clearEventAllowedBehavior set to onlyThisCycleAndReadness, the DM shall set the following UDS DTC status bits:

> **[SWS_DM_00124]**{草案} **清除DTC操作期间UDS DTC状态字节的有限清除** *[*如果DM被要求根据[[SWS_DM_00896](#_bookmark282)]清除一个禁止清除的DTC，并且DiagnosticEventToTroubleCodeUdsMaping存在将此DTC映射到一个事件，并且该事件具有DianosticEvent.clearEventAllowedBehavior设置为onlyThisCycleAndReadness，DM应设置以下UDS DTC状态位：

- Bit 1 TestFailedThisOperationCycle to '0'
- Bit 4 TestNotCompletedSinceLastClear to '1'
- Bit 5 TestFailedSinceLastClear to '0'

- Bit 6 TestNotCompletedThisOperationCycle to '1' and leave all other bits unchanged.*♩(RS_Diag_04117)*

> 将位6的TestNotCompletedThisOperationCycle设置为'1'，其余位保持不变。♩（RS_Diag_04117）


**[SWS_DM_00121]**{DRAFT} **Forbidden clearing of snapshot records and etended data records** *[*If the DM is requested to clear a DTC with a forbidden clear according to [[SWS_DM_00896](#_bookmark282)] the DM shall leave all snapshot records and etended data records for this DTC unchanged.*♩(RS_Diag_04117)*

> **[SWS_DM_00121]**{草案} **禁止清除快照记录和扩展数据记录** *[*如果根据[[SWS_DM_00896](#_bookmark282)]要求DM执行禁止清除的DTC清除操作，DM应保持该DTC的所有快照记录和扩展数据记录不变。*♩(RS_Diag_04117)*

### DTC clearing triggered by application


Besides the UDS request ClearDiagnosticInformation according to section [7.6.2.8.5.1](#clearing-user-defined-fault-memory) the DM supports the use case that the fault memory is cleared by an application call. One of the use cases is clearing of user-defined event memory. This could be realized using a dedicated diagnostic routine service, whose application is in charge of the clearing process.

> 除了根据[7.6.2.8.5.1](#clearing-user-defined-fault-memory)节中的UDS请求ClearDiagnosticInformation外，DM还支持应用程序调用来清除故障记忆的用例。其中一个用例是清除用户定义的事件记忆。这可以通过专用的诊断例程服务来实现，该应用负责清除过程。


The clear DTC operation itself is semantically identical, independent if triggered via diagnostic service or application method call. All requirements for clear DTC apply in either case.

> 清除DTC操作本身在语义上是相同的，无论是通过诊断服务还是应用程序方法调用触发。清除DTC的所有要求在任何情况下均适用。


**[SWS_DM_00897]**{DRAFT} **Usage of ClearDTC Interface** *[*If the function ara::diag::DTCInformation::Clear is called, the DM shall clear the DTC or DTC group provided in the functions parameter DTCGroup. The clear DTC shall clear the fault memory associated to the instance of the ara::diag::DTCInformation class only.*♩(RS_Diag_04194)*

> **[SWS_DM_00897]**{草稿} **ClearDTC接口的使用** *[*如果调用ara :: diag :: DTCInformation :: Clear函数，DM应清除函数参数DTCGroup中提供的DTC或DTC组。 Clear DTC将仅清除与ara :: diag :: DTCInformation类的实例相关联的故障记忆。*♩(RS_Diag_04194)*


**[SWS_DM_00898]**{DRAFT} **ClearDTC call on invalid DTC or DTC group** *[*If the funtion ara::diag::DTCInformation::Clear is called and the functions parameter DTCGroup has no matching configured DTC group according to [[SWS_DM_00064](#_bookmark253)] or has no matching configured DTC by DiagnosticTroubleCodeUds.udsDtcValue, the DM shall trigger the error kWrongDtc for that function call and the DM shall return without any further action.*♩(RS_Diag_04194)*

> **[SWS_DM_00898]**{草案} **无效DTC或DTC组的ClearDTC调用** *[*如果调用ara :: diag :: DTCInformation :: Clear函数，并且该函数的参数DTCGroup没有与[[SWS_DM_00064](#_bookmark253)]中配置的DTC组匹配，或者没有与DiagnosticTroubleCodeUds.udsDtcValue配置的DTC匹配，DM应触发该函数调用的错误kWrongDtc，并且DM应在没有任何进一步操作的情况下返回。*♩(RS_Diag_04194)*


**[SWS_DM_00899]**{DRAFT} **ClearDTC called while another clear operation is in progress** *[*If the function ara::diag::DTCInformation::Clear is called and aother clear DTC operation is currently in progress, the DM shall trigger the error kBusy.*♩ (RS_Diag_04194)*

> **[SWS_DM_00899]**{草案} **在另一个清除操作正在进行时调用ClearDTC** *[*如果调用ara :: diag :: DTCInformation :: Clear函数，并且另一个清除DTC操作正在进行，DM应触发错误kBusy。*♩ (RS_Diag_04194)*


**[SWS_DM_00900]**{DRAFT} **ClearDTC processing in case of memory errors** *[*If the function ara::diag::DTCInformation::Clear is called and the DM receives physical memory errors upon its access to the Non-volatile Memory and thus canot guarantee that the clear operation was done successfully, the DM shall trigger the error kMemoryError.*♩(RS_Diag_04194)*

> 如果调用ara :: diag :: DTCInformation :: Clear函数，并且DM在访问非易失性存储器时收到物理内存错误，因此无法保证清除操作是否成功完成，则DM应触发kMemoryError错误。(RS_Diag_04194)


**[SWS_DM_00901]**{DRAFT} **Possible failure of ClearDTC** *[*If the function ara:diag::DTCInformation::Clear is called and the clear operation fails due to the reasons according to [[SWS_DM_00122](#_bookmark119)], the DM shall trigger the error kFailed.*♩ (RS_Diag_04194)*

> **[SWS_DM_00901]**{草稿} **可能的ara:diag::DTCInformation::Clear清除失败** *[*如果调用ara:diag::DTCInformation::Clear函数，由于根据[[SWS_DM_00122](#_bookmark119)的原因而导致清除操作失败，DM应触发错误kFailed。*♩ (RS_Diag_04194)*

### Aging


A stored DTC can age in terms of reaching a threshold value of passed operation cycles, specified by the vendor, where no failed tests have been reported by a moitoring application. The amount of operation cycles, where these non-failed rports occur is called the Aging counter. After the threshold is reached, the DTC is cleared from the event memory.

> 存储的DTC可以随着达到供应商指定的通过操作周期的阈值而老化，其中没有监控应用程序报告失败的测试。发生这些无失败报告的操作周期数量称为老化计数器。达到阈值后，DTC将从事件存储器中清除。


**[SWS_DM_00237]**{DRAFT} **Aging** *[*The DM shall only support Aging for DTCs, if the corresponding configuration parameter DiagnosticTroubleCodeProps.aging exists.*♩(RS_Diag_04133)*

> **[SWS_DM_00237]**{草案} **老化** *[*DM 只有在对应的配置参数DiagnosticTroubleCodeProps.aging存在时，才能支持 DTC 的老化。*♩(RS_Diag_04133)*


[]{#_bookmark285 .anchor}**[SWS_DM_00238]**{DRAFT} **Aging and healing** *[*If an indicator is configured for the corresponding event, the process of Aging (counting of Aging counter) shall

> 如果为相应事件配置了指示器，则老化（计数老化计数器）的过程和恢复（清除老化计数器）的过程应该符合以下要求：SWS_DM_00238 《衰老与恢复》（草案）。


be started only after the healing (according to [[SWS_DM_00224](#_bookmark263)]) is completed ('warningIndicatorRequested' bit is set to 0).*♩(RS_Diag_04133)*

> 只有在治疗完成（根据[[SWS_DM_00224](#_bookmark263)）后，才能启动（'warningIndicatorRequested'位设置为0）。♩（RS_Diag_04133）


**[SWS_DM_00239]**{DRAFT} **Aging counter** *[*The DM shall support an Aging counter for each event memory entry.*♩(RS_Diag_04133)*

> **[SWS_DM_00239]**{草案} **老化计数器** *[*DM 应为每个事件记忆条目支持一个老化计数器。*♩(RS_Diag_04133)*


Note that this counter shall be available as internal data element of extended data records.

> 注意，这个计数器将作为扩展数据记录的内部数据元素可用。


The implementation of the internal aging counter mechanism is indepedent from the configuration parameter DiagnosticProvidedDataMapping.daaProvider of the corresponding DiagnosticParameter.dataElement set to DEM_AGINGCTR_UPCNT or to DEM_AGINGCTR_DOWNCNT. Only for reading the intenal data element, a mapping as defined in [[SWS_DM_00956](#_bookmark276)] and [[SWS_DM_00957](#_bookmark277)] is applied.

> 内部老化计数器机制的实施与相应的DiagnosticParameter.dataElement设置为DEM_AGINGCTR_UPCNT或DEM_AGINGCTR_DOWNCNT的配置参数DiagnosticProvidedDataMapping.daaProvider无关。只有在读取内部数据元素时，才会应用[[SWS_DM_00956](#_bookmark276)]和[[SWS_DM_00957](#_bookmark277)]中定义的映射。


**[SWS_DM_00240]**{DRAFT} **Processing the Aging counter** *[*The DM shall only alow processing the Aging counter if the related DTC is stored in the event memory, the status is qualified as passed ('testFailed' bit is set to 0) and healing, according to [[SWS_DM_00238](#_bookmark285)], is fulfilled.*♩(RS_Diag_04133)*

> **[SWS_DM_00240]**{草案} **处理老化计数器** *[*如果相关的DTC存储在事件存储器中，状态被认定为通过（“testFailed”位设置为0）并且根据[[SWS_DM_00238](#_bookmark285)]满足治愈，DM只允许处理老化计数器。*♩(RS_Diag_04133)*


**[SWS_DM_00241]**{DRAFT} **Aging cycle and threshold** *[*The Aging shall be caculated based on the referred DiagnosticOperationCycle via the reference DiagnoticAging.agingCycle.*♩(RS_Diag_04133)*

> **[SWS_DM_00241]**{草案}**老化周期和阈值** *[*老化应根据通过参考DiagnoticAging.agingCycle引用的DiagnosticOperationCycle来计算。♩(RS_Diag_04133)*


**[SWS_DM_01264]**{DRAFT} **DiagnosticAging.threshold reached** *[*The DianosticAging.threshold defines the number of Aging cycles until Aging. If the threshold is reached, the event memory entry shall be deleted (aged) from the event memory including the snapshot records and extended data records beloning to that aged DTC.*♩(RS_Diag_04133)*

> **[SWS_DM_01264]**{草案} **诊断老化。阈值已达到** *[*诊断老化的阈值定义了老化的周期数。如果达到阈值，则事件存储器条目将从事件存储器中删除（老化），包括属于该老化DTC的快照记录和扩展数据记录。♩（RS_Diag_04133）*

简体中文：**[SWS_DM_01264]**{草案} **诊断老化。阈值已达到** *[*诊断老化的阈值定义了老化的周期数。如果达到阈值，则事件存储器条目将从事件存储器中删除（老化），包括属于该老化DTC的快照记录和扩展数据记录。♩（RS_Diag_04133）*


**[SWS_DM_01265]**{DRAFT} **Aging requires tested cycles only** *[*If DiagnoticMemoryDestination.agingRequiresTestedCycle is set, the cycle shall only be considered in which the status was reported but not failed ('testNotCompleedThisOperationCycle' bit and 'testFailedThisOperationCycle' bit are set to 0).*♩(RS\Diag_04133)*

> 如果DiagnoticMemoryDestination.agingRequiresTestedCycle被设置，只有当状态被报告，但没有失败（“testNotCompleedThisOperationCycle”位和“testFailedThisOperationCycle”位被设置为0）时，才会考虑该周期。♩（RS \ Diag_04133）


[]{#_bookmark286 .anchor}**[SWS_DM_00243]**{DRAFT} **Aging-related UDS DTC status byte processing** *[*As a consequence of Aging, the DM shall set the following UDS DTC status bits to 0:

> 由于衰老，DM 应将以下 UDS DTC 状态位设置为 0：SWS_DM_00243]{草案}**衰老相关的 UDS DTC 状态字节处理**

- 'confirmedDTC' unconditionally

- 'testFailedSinceLastClear' conditionally, if statusBitHandlingTesFailedSinceLastClear is set to statusBitAgingAndDisplacement

> 如果statusBitHandlingTesFailedSinceLastClear设置为statusBitAgingAndDisplacement，则有条件地测试失败。

*♩(RS_Diag_04140)*


**[SWS_DM_00242]**{DRAFT} **Re-occurrence after Aging** *[*The DM shall treat the roccurrence of previously aged events like new events, since they were previously deleted from the event memory by Aging. This corresponds to all DTC-related data (i.e. counters, thresholds, etc.) being reset to their initial values.*♩(RS_Diag_04133)*

> **[SWS_DM_00242]**{草案} **老化后的再次发生** *[*DM 应将以前老化的事件视为新事件，因为它们已经被老化从事件记忆中删除。这对应于所有 DTC 相关的数据（即计数器、阈值等）被重置为其初始值。*♩(RS_Diag_04133)*

简体中文：**[SWS_DM_00242]**{草案} **老化后再次发生** *[*DM 应将先前老化的事件视为新事件，因为它们已被老化从事件记忆中删除。这对应于所有 DTC 相关的数据（即计数器、阈值等）被重置为其初始值。*♩(RS_Diag_04133)*

### NumberOfStoredEntries


**[SWS_DM_00902]**{DRAFT} **NumberOfStoredEntries** *[*If the function ara::diag::DTCInformation::GetNumberOfStoredEntries is called, the DM shall return the number of event memory entries (DTCs) currently stored in this event memory. An update notification shall be sent to the function registered via ara::diag:DTCInformation::SetNumberOfStoredEntriesNotifier whenever the value of NumberOfStoredEntries has changed.*♩(RS_Diag_04109)*

> **[SWS_DM_00902]**{草稿} **NumberOfStoredEntries** *[*如果调用ara::diag::DTCInformation::GetNumberOfStoredEntries函数，DM将返回当前存储在此事件存储器中的事件存储条目（DTC）的数量。每当NumberOfStoredEntries的值发生变化时，将向通过ara::diag:DTCInformation::SetNumberOfStoredEntriesNotifier注册的函数发送更新通知。*♩(RS_Diag_04109)*


**[SWS_DM_01352]**{DRAFT} **Consecutive registration of notifier with SetNuberOfStoredEntriesNotifier()** *[*In case of a consecutive call of ara::diag:DTCInformation::SetNumberOfStoredEntriesNotifier of the corresponing ara::diag::DTCInformation instance, DM module shall overwrite the previous registered notifier.*♩(RS_Diag_04109)*

> **[SWS_DM_01352]**{草案} **使用SetNumberOfStoredEntriesNotifier()进行连续注册通知** *[*如果对应的ara::diag::DTCInformation实例连续调用ara::diag:DTCInformation::SetNumberOfStoredEntriesNotifier，DM模块应覆盖先前注册的通知。*♩(RS_Diag_04109)*

### Active / Passive Status of Events


If an event gets qualified as failed, it becomes \"active\". If the event gets qualfied as passed, it becomes \"passive\". This status can be derived from the UDS DTC status byte. As the behavior for the UDS DTC status bit 0 / 'TestFailed' is cofigurable whether it is persistently stored or not (see DiagnosticMemoryDestintion.statusBitStorageTestFailed), also the meaning of \"active\" / \"passive\" is influenced:

> 如果事件被视为失败，它就会变成“活动”状态。如果事件被视为通过，它就会变成“被动”状态。这种状态可以从UDS DTC状态字节中获得。由于UDS DTC状态位0/'TestFailed'的行为是可配置的（请参见DiagnosticMemoryDestintion.statusBitStorageTestFailed），所以“活动”/“被动”的含义也受到影响。


- If the 'TestFailed' bit is stored non-volatile, \"**event active**\" equals to 'TestFailed = 1' and \"**event passive**\" equals to 'TestFailed = 0'.

> 如果'TestFailed'位存储在非易失性存储器中，“**活动事件**”等于'TestFailed = 1'，而“**被动事件**”等于'TestFailed = 0'。

- If the 'TestFailed' bit is only stored volatile, additionally the information, if the event was already tested/ reported this power cycle, is required. As long, as this information is not present, the \"active/passive\" status is \"**undefined**\".

> 如果只存储了TestFailed位，那么还需要额外的信息，来表明此事件本次电源循环是否已经测试/报告过。只要没有这个信息，“主动/被动”状态就是“**未定义**”的。


  1. ### Event memory overflow

> 事件内存溢出


An event memory is considered to be full in case that already \<DiagnosticMemryDestination.maxNumberOfEventEntries\> are stored in this event memory. If in this situation a new event needs to be stored in this event memory, an event memory overflow occurs and error information got lost.

> 事件记忆被认为是满的情况下，已经存储在此事件记忆\<DiagnosticMemryDestination.maxNumberOfEventEntries\>。如果在这种情况下，一个新的事件需要存储在此事件记忆，事件记忆溢出发生，错误信息丢失。


An event memory overflow can happen to primary and user-defined event memories.

> 事件存储器溢出可能发生在主存储器和用户定义的事件存储器中。


**[SWS_DM_00922]**{DRAFT} **Persistent storage for event memory overflow infomation** *[*The DM module shall store and provide the event memory overflow iformation persistently for each of the configured event memories separately.*♩(RS\Diag_04093)*

> **[SWS_DM_00922]**{草案} **持久存储事件内存溢出信息** *[*DM模块需要为每个配置的事件内存分别持久存储和提供事件内存溢出信息。*♩(RS\Diag_04093)*


[]{#_bookmark290 .anchor}**[SWS_DM_00923]**{DRAFT} **Event memory overflow set condition** *[*If there exists already \<maxNumberOfEventEntries\> in one of the configured DM event meories and there is an attempt to store an additional entry to this event memory, the DM module shall from then on return true on calling the function ara::diag:DTCInformation::GetEventMemoryOverflow for this event memory instance of ara::diag::DTCInformation.*♩(RS_Diag_04093)*

> 如果配置的DM事件存储器中已经存在<maxNumberOfEventEntries>，并且有尝试将额外的条目存储到该事件存储器中，则DM模块从此以后在调用ara :: diag：DTCInformation :: GetEventMemoryOverflow函数时，对于该事件存储器实例ara :: diag :: DTCInformation将返回true。(RS_Diag_04093)


This overflow indication can be used to trigger further internal behavior of the DM moule (e.g. displacement strategy). Furthermore, it can be used for additional fault analysis in workshops in case this overflow information is used in a DTC extended data record.

> 这种溢出指示可用于触发DM模块的进一步内部行为（例如位移策略）。此外，如果将此溢出信息用于DTC扩展数据记录中，还可以用于车间的其他故障分析。


**[SWS_DM_00924]**{DRAFT} **Event memory overflow reset condition** *[*If there never happened an overflow before (compare to [[SWS_DM_00923](#_bookmark290)]) or if the clear of all DTCs was executed for a specific event memory, the DM shall from then on return false on calling the function ara::diag::DTCInformation::GetEventMemoryOverflow for this event memory instance.*♩(RS_Diag_04093)*

> **[SWS_DM_00924]**{草案} **事件存储器溢出重置条件** *[*如果以前从未发生过溢出（与[[SWS_DM_00923](#_bookmark290)进行比较），或者如果已经对特定事件存储器执行了所有DTC的清除，则从那时起，调用ara :: diag :: DTCInformation :: GetEventMemoryOverflow函数时，DM将返回此事件存储器实例的false。*♩（RS_Diag_04093）*


In case of aging and deleting single DTCs, the overflow indication of the event meory is not reset.

> 如果单独的DTC老化和删除，事件存储器的溢出指示不会被重置。


**[SWS_DM_00925]**{DRAFT} **Event memory overflow notifier on occurence** *[*If there exists already \<maxNumberOfEventEntries\> in one of the configured DM event memories and there is an attempt to store an additional entry to this event memory, the DM shall each time call the corresponding overflow notification function for that event memory, which was registered via the function ara::diag::DTCInformtion::SetEventMemoryOverflowNotifier for this event memory instance of ara::diag::DTCInformation, with the parameter value set to true.*♩(RS_Diag\04093)*

> **[SWS_DM_00925]**{草案} **发生时的事件内存溢出通知** *[*如果在配置的DM事件存储器中已经存在\<maxNumberOfEventEntries\>，并且尝试存储额外的条目到该事件存储器，则DM每次都应调用为该事件存储器实例ara::diag::DTCInformation注册的相应溢出通知功能，参数值设置为true。*♩(RS_Diag\04093)*

简体中文：**[SWS_DM_00925]**{草案} **发生时的事件内存溢出通知** *[*如果在配置的DM事件存储器中已经存在<maxNumberOfEventEntries>，并且尝试存储额外的条目到该事件存储器，则DM每次都应调用为该事件存储器实例ara::diag::DTCInformation注册的相应溢出通知功能，参数值设置为true。*♩(RS_Diag\04093)*


**[SWS_DM_00926]**{DRAFT} **Event memory overflow notifier on clear** *[*If an overflow has occurred, as specified in [[SWS_DM_00923](#_bookmark290)]), for a particular event memory, the DM shall, after the next execution of clear all DTCs for that particular event memory, call the corresponding overflow notification function for that event memory, which was registered via the function ara::diag::DTCInformation::SetEventMemryOverflowNotifier for this event memory instance, with the parameter value set to false.*♩(RS_Diag_04093)*

> **[SWS_DM_00926]**{草稿} **事件内存溢出通知器在清除时** *[*如果发生了溢出，如[[SWS_DM_00923](#_bookmark290)]中所指定的，对于特定的事件内存，在下一次执行清除该特定事件内存的所有DTC后，将调用为该事件内存实例注册的相应溢出通知函数，并将参数值设置为false。*♩(RS_Diag_04093)*

简体中文：**[SWS_DM_00926]**{草案} **清除时的事件内存溢出通知器** *[*如果发生了溢出，如[[SWS_DM_00923](#_bookmark290)]中所指定的，对于特定的事件内存，在下一次执行清除该特定事件内存的所有DTC后，将调用为该事件内存实例注册的相应溢出通知函数，并将参数值设置为false。*♩(RS_Diag_04093)*


**[SWS_DM_01354]**{DRAFT} **Consecutive registration of notifier with SetEvenMemoryOverflowNotifier()** *[*In case of a consecutive call of ara::diag::DTCIformation::SetEventMemoryOverflowNotifier of the corresponding ara:diag::DTCInformation instance, DM module shall overwrite the previous registered notifier.*♩(RS_Diag_04093)*

> **[SWS_DM_01354]**{草案}**使用SetEventMemoryOverflowNotifier()连续注册通知者** *[*如果连续调用相应ara::diag::DTCInformation实例的ara::diag::DTCInformation::SetEventMemoryOverflowNotifier，DM模块应覆盖先前注册的通知者。*♩(RS_Diag_04093)*

### Event memory entry displacement


Displacement is applied in case the event memory has already reached the maxmum allowed number of stored entries and a further new event memory entry shall be stored.

> 当事件记忆已达到允许存储的最大条目数，并且需要存储另一个新的事件记忆条目时，就会应用位移。


In this case the decision between

> 在这种情况下，决定

- displacing an already earlier stored event memory entry

or

- discarding the new reported event

needs to be taken.


Displacement means, that the least significant, already existing event memory entry is replaced by a new reported and more significant event, which needs to be stored. During displacement, the least significant entry gets lost.

> 位移意味着，最不重要的已有事件记忆条目被新报告的更重要的事件所取代，这需要被存储。在位移过程中，最不重要的条目会丢失。


If there is no maximum allowed number of entries for a specific event memory or if the maximum allowed number is configured to cover all possible events, no diplacement will occur.

> 如果特定事件记忆没有最大允许数量的限制，或者最大允许数量被设置为覆盖所有可能的事件，则不会发生位移。


In the following, the expression \"overflow situation\" is used for the condition that the event memory was already full, i.e. \<maxNumberOfEventEntries\> were already stored in that event memory and now a new entry needs to be added to that event memory.

> 以下，"溢出情况"一词用于指事件存储已满的情况，即<maxNumberOfEventEntries>已存储在该事件存储中，而现在需要向该事件存储中添加新条目。


**[SWS_DM_00927]**{DRAFT} **Disabled displacement** *[*If DiagnosticMemoryDetination.eventDisplacementStrategy selects none and an overflow situation occurred in that particular event memory, the DM shall discard the new reported event.*♩(RS_Diag_04118)*

> **[SWS_DM_00927]**{草稿} **失效位移** *[*如果DiagnosticMemoryDetination.eventDisplacementStrategy选择无，并且该特定事件存储器发生溢出情况，DM应丢弃新报告的事件。*♩(RS_Diag_04118)*


[]{#_bookmark292 .anchor}**[SWS_DM_00928]**{DRAFT} **Priority and occurrence based displacement** *[*If DiagnosticMemoryDestination.eventDisplacementStrategy selects proOcc and an overflow situation occurred in that particular event memory, the DM shall

> 如果DiagnosticMemoryDestination.eventDisplacementStrategy选择proOcc，并且该特定事件存储器中发生了溢出情况，则DM必须按优先级和发生频率进行位移。

- **step 1**: search through that event memory for entries that


have the lowest priority value in that event memory

> 在该事件记忆中拥有最低的优先级值

AND

- have a lower priority than the new entry.

```{=html}
<!-->
```


- **step 2**: Out of that list the DM shall select the chronologically oldest occurred memory entry for the displacement operation.

> **步骤2**：DM应从该列表中选择时间上最早发生的位移操作的记忆条目。


*♩(RS_Diag_04118, RS_Diag_04105)*

> *♩(RS_Diag_04118，RS_Diag_04105)*


For strategy prioOcc there is no displacement for equal or higher priority event memory entries. The UDS DTC status bits are also not considered.

> 对于策略prioOcc，相同或更高优先级事件存储条目没有位移。UDS DTC状态位也不被考虑。


[]{#_bookmark293 .anchor}**[SWS_DM_00929]**{DRAFT} **Displacement strategy \"full\"** *[*If DiagnosticMemorDestination.eventDisplacementStrategy selects full and an overflow sitution occurred in that particular event memory, the DM module shall perform the folowing selection sequence by combination of the different displacement criteria, listed by their descending importance:

> SWS_DM_00929{草案}「完全」位移策略*如果DiagnosticMemorDestination.eventDisplacementStrategy选择“完全”，并且该特定事件记忆中发生溢出情况，DM模块应按照不同位移标准的降序组合执行以下选择序列：

- **1) Priority** (compare [[SWS_DM_00916](#_bookmark256)]): search through that event memory


for entries that have the lowest priority value in that event memory.

> 对于在该事件记忆中具有最低优先级值的条目。


- **2) Active / Passive Status**: out of the above filtered selection from 1): search for events in the following order:

> **2）主动/被动状态：** 从上述1）中筛选出的结果中：按如下顺序搜索事件：


**a.)**: If the lowest priority in the event memory is less than the priority of the new event:

> 如果事件内存中的最低优先级小于新事件的优先级：


*∗* **i.)**: In the first place, the DM shall select Passive events .

> 首先，DM应选择被动事件。


*∗* **ii.)**: In case no Passive events are available, the DM shall select all events from the above filtered criteria (independent from the UDS DTC status bits).

> 如果没有可用的被动事件，DM应该从上述筛选条件中选择所有事件（与UDS DTC状态位无关）。

- **b.)**: If the lowest priority in the event memory is equal to the priority of the new event:


*∗* **i.)**: In the first place, the DM shall select Passive events.

> 首先，DM应选择被动事件。


*∗* **ii.)**: In case no Passive events are available, the DM shall select events with UDS DTC status bit \"TestNotCompletedThisOperationCycle\" is set.

> 如果没有可用的被动事件，DM应选择具有UDS DTC状态位“TestNotCompletedThisOperationCycle”设置的事件。


- **3) Oldest entry**: If the selection from the above criteria results in one or more event entries, the DM shall select the chronologically oldest occurred event meory entry for the displacement operation.

> 如果上述标准结果产生一个或多个事件条目，DM应选择按时间顺序发生的最早的事件记忆条目进行位移操作。


*♩(RS_Diag_04118, RS_Diag_04105)*

> *♩(RS_Diag_04118，RS_Diag_04105)*


Details about Active / Passive Status are specified in [7.6.4.5.8](#active-passive-status-of-events) "[Active / Passive Status](#active-passive-status-of-events) [of Events](#active-passive-status-of-events)"

> 详细关于主动/被动状态的信息可在[7.6.4.5.8](#active-passive-status-of-events)「[事件的主动/被动状态](#active-passive-status-of-events)」中查阅。


For strategy full there is no displacement for active (testCompletedThisOpertionCycle) event memory entries with equal priority or for higher priority event memory entries.

> 对于策略完全，对具有相同优先级或更高优先级的(testCompletedThisOpertionCycle)事件记忆条目没有位移。

![](./media/image57.png)

**Figure 7.7: Combined displacement criteria processing**


**[SWS_DM_00930]**{DRAFT} **Displacement operation** *[*If an event memory entry for displacement is identified as specified in [[SWS_DM_00928](#_bookmark292)] or [[SWS_DM_00929](#_bookmark293)], the DM module shall remove this old event memory entry from the event memory and add the new reported event to the memory.*♩(RS_Diag_04118)*

> **[SWS_DM_00930]**{草案} **位移操作** *[*如果根据[[SWS_DM_00928](#_bookmark292)]或[[SWS_DM_00929](#_bookmark293)]指定的事件记忆项位移被识别，DM模块应从事件记忆中移除这个旧的事件记忆项，并将新报告的事件添加到记忆中。*♩(RS_Diag_04118)*


**[SWS_DM_00932]**{DRAFT} **UDS DTC status bit 3 / 'ConfirmedDTC' after displacement** *[*If an event memory entry was removed during displacement AND the configuration parameter DiagnosticCommonProps.resetConfirmeBitOnOverflow is set to \"true\", the DM module shall reset the UDS DTC status bit 3 / 'ConfirmedDTC' to '0'.*♩(RS_Diag_04067, RS_Diag_04118)*

> **[SWS_DM_00932]**{草稿} **行驶里程变化后的UDS DTC状态位3/“确认DTC”** *[*如果在行驶里程变化期间移除了事件记忆条目，并且配置参数DiagnosticCommonProps.resetConfirmeBitOnOverflow设置为“true”，DM模块应将UDS DTC状态位3/“确认DTC”重置为“0”。*♩(RS_Diag_04067, RS_Diag_04118)*

简体中文：**[SWS_DM_00932]**{草案} **行驶里程变化后的UDS DTC状态位3/“确认DTC”** *[*如果在行驶里程变化期间移除了事件记忆条目，并且配置参数DiagnosticCommonProps.resetConfirmeBitOnOverflow设置为“true”，DM模块应将UDS DTC状态位3/“确认DTC”重置为“0”。*♩(RS_Diag_04067, RS_Diag_04118)*


**[SWS_DM_00933]**{DRAFT} **UDS DTC status bit 5 / 'testFailedSinceLastClear' after displacement** *[*If an event memory entry was removed during displacment AND the configuration parameter DiagnosticMemoryDestination.statuBitHandlingTestFailedSinceLastClear is set to statusBitAgingAndDiplacement AND DiagnosticCommonProps.resetConfirmedBitOnOverflow is set to \"true\", the DM shall reset the UDS DTC status bit 5 / 'testFailedSincLastClear' to '0'.*♩(RS_Diag_04067, RS_Diag_04118)*

> **[SWS_DM_00933]**{草稿} **移位后的UDS DTC状态位5/“自上次清零以来失败的测试”** *[*如果在移位期间删除了事件记忆条目，并且配置参数DiagnosticMemoryDestination.statuBitHandlingTestFailedSinceLastClear设置为statusBitAgingAndDiplacement，并且DiagnosticCommonProps.resetConfirmedBitOnOverflow设置为“true”，DM应将UDS DTC状态位5/“自上次清零以来失败的测试”重置为“0”。*♩(RS_Diag_04067，RS_Diag_04118)*


**[SWS_DM_00934]**{DRAFT} **Condition for discarding the new event** *[*If an oveflow situation occurred and no event memory entry for displacement was identified as specified in [[SWS_DM_00928](#_bookmark292)] and [[SWS_DM_00929](#_bookmark293)], the DM module shall discard the storage request for the new reported event.*♩(RS_Diag_04118)*

> **[SWS_DM_00934]**{草案} **新事件被丢弃的条件** *[*如果发生溢出情况，并且根据[[SWS_DM_00928](#_bookmark292)]和[[SWS_DM_00929](#_bookmark293)]未能识别出位移事件的存储条目，DM模块应该丢弃存储新报告事件的请求。*♩(RS_Diag_04118)*

### Reporting order of event memory entries


[]{#_bookmark295 .anchor}**[SWS_DM_00981]**{DRAFT} **Conditions of status based reporting order** *[*Upon rquests of the following sub-functions from UDS service ID 0x19 as shown in table

> **[SWS_DM_00981]**{草案} **状态基于报告顺序的条件** *[*根据表中UDS服务ID 0x19的以下子功能的请求


[7.8](#_bookmark296) , the DM module shall report DTCs in the chronological order of the event storage (compare memoryEntryStorageTrigger), if:

> [7.8](#_bookmark296)，如果，DM 模块应该按照事件存储的时间顺序报告 DTC（与 memoryEntryStorageTrigger 比较）：


- the DTCStatusMask parameter in the UDS request message has the UDS DTC status bit 'pending DTC' or 'confirmed DTC' bit or both bits set and

> DTCStatusMask参数在UDS请求消息中具有UDS DTC状态位“待定DTC”或“确认DTC”位或两者位都设置。
- all other UDS DTC status bits of the DTCStatusMask parameter in the UDS


request message are set to false and

> 请求消息被设置为 false。

- resetConfirmedBitOnOverflow is set to true.


**Table 7.8: Subfunctions of 0x19 / ReadDTCInformation with chronolicical reporting order**

> 表7.8：0x19/ReadDTCInformation的子功能按时间顺序报告


**[SWS_DM_00982]**{DRAFT} **Reporting order direction** *[*If the DM module is requested to report in chronological order as specified in [[SWS_DM_00981](#_bookmark295)], the most recent event memory entry shall be reported at first.*♩(RS_Diag_04195)*

> **[SWS_DM_00982]**{草案} **报告顺序指示** *[*如果DM模块被要求按[[SWS_DM_00981](#_bookmark295)指定的时间顺序报告，最近的事件记忆条目应先进行报告。*♩(RS_Diag_04195)*

### Required Configuration


The Autosar Diagnostic Extract Template (DEXT) [[3](#_bookmark10)] is used for the DM configuration. By design this format is made as exchange format between the tools in the diagnotic workflow, in different steps data is added. To accommodate the fact that data is incomplete and refined in a later step, the DEXT [[3](#_bookmark10)] allows most of the elements to be optional and added at a later point in time. However at the point in time, when the DEXT [[3](#_bookmark10)] is used to configure the DM, a certain minimum content is required. In this chapter a loose list of DEXT [[3](#_bookmark10)] constraints is given. The mentioned elements need to be present so that the DM can be configured. Also the reaction on such missing elements is implementation specific, it is stated that the DM will not be able to behave as described in the document. A possible but not mandatory reaction is to refuse the DM generation at all and forcing the user to provide complete data.

> 汽车应用软件体系结构（AUTOSAR）诊断提取模板（DEXT）[[3（#_bookmark10）]]用于DM配置。根据设计，该格式用作诊断工作流中的工具之间的交换格式，在不同的步骤中添加数据。为了适应数据不完整且在稍后步骤中得到改进的事实，DEXT [[3（#_bookmark10）]]允许大多数元素可选，并在以后的时间点添加。但是，在使用DEXT [[3（#_bookmark10）]]配置DM的时候，需要一定的最低内容。在本章中，给出了一个松散的DEXT [[3（#_bookmark10）]]约束列表。需要存在这些提到的元素，以便配置DM。此外，对这些缺失元素的反应是具体实现的，文档中指出DM无法按预期行为。一种可能但不强制的反应是拒绝DM生成，并强制用户提供完整的数据。


**[SWS_DM_CONSTR_00168]**{DRAFT} **Required operation cycles for diagnostic events** *[*Each DiagnosticEvent requires exactly one DiagnosticEventToOpeationCycleMapping referencing the diagnosticEvent and one DiagnostiOperationCycle.*♩(RS_Diag_04178)*

> **[SWS_DM_CONSTR_00168]**{草案} **诊断事件所需的操作周期** *[*每个诊断事件都需要一个引用诊断事件和一个诊断操作周期的DiagnosticEventToOpeationCycleMapping。♩（RS_Diag_04178）*


**[SWS_DM_CONSTR_00206]**{DRAFT} **Supported format for data identifier for VIDataIdentifier** *[*A DiagnosticDataIdentifier with representsVin set to true, requires that it aggregates only one DiagnosticParameter which itself aggregates a DiagnosticDataElement having a 17 byte uint8 array as baseType.*♩(SRS_Eth\00026)*

> **[SWS_DM_CONSTR_00206]**{草案} **VIDataIdentifier 支持的数据格式** *[*如果一个DiagnosticDataIdentifier的representsVin设置为true，它只能聚合一个DiagnosticParameter，这个DiagnosticParameter自身聚合一个DiagnosticDataElement，它的基础类型是一个17字节的uint8数组。*♩(SRS_Eth\00026)*

### Diagnostic Data Management


In various situations, the Diagnostic Server instance facilitates reading or wriing of particular diagnostic data. One needs to distinguish between internal and eternal diagnostic data. By definition, internal data is managed by the Diagnostic Server instance itself, and external data is managed by external applications. In the latter case, communication between Diagnostic Server instance and the external application takes place via Service Interfaces. There are several Service Iterfaces defined concerning diagnostic data.

> 在不同的情况下，诊断服务器实例可以方便地读取或写入特定的诊断数据。需要区分内部和外部诊断数据。按照定义，内部数据由诊断服务器实例本身管理，外部数据由外部应用程序管理。在后一种情况下，诊断服务器实例与外部应用程序之间的通信是通过服务接口实现的。关于诊断数据定义了几个服务接口。


The purpose of this chapter is to describe the supported use-cases for handling dianostic data and the way how to configure each use-case within the DEXT.

> 本章的目的是描述支持的诊断数据处理用例以及如何在DEXT中配置每个用例。


Recall that a DiagnosticDataIdentifier is composed of DiagnosticParameters each of which aggregates a single DiagnosticDataElement. In different use cases, it is required to manage diagnostic data either on the level of DiagnosticDataIdetifier or on the fine granular level of DiagnosticDataElements.

> 回想一下，诊断数据标识符由每个汇总单个诊断数据元素的诊断参数组成。在不同的使用场景中，需要以诊断数据标识符的级别或诊断数据元素的细粒度级别管理诊断数据。

### Internal and External Diagnostic Data Elements


A DiagnosticDataElement is called internal if there exists a DiagnosticPrvidedDataMapping referencing this DiagnosticDataElement, otherwise it is called an external DiagnosticDataElement.

> 一个诊断数据元素如果存在一个引用这个诊断数据元素的诊断提供数据映射，则称为内部的，否则称为外部的诊断数据元素。


Table [7.9](#_bookmark300) gives a list of the supported internal DiagnosticDataElements, where

> 表7.9（#_bookmark300）列出了支持的内部诊断数据元素的列表。


**Data Provider** refers to the NameToken defined by the attribute dataProvider of the associated DiagnosticProvidedDataMapping,

> **数据提供者**指的是由相关的DiagnosticProvidedDataMapping的dataProvider属性定义的NameToken。


**Content** describes the actual content of the data,

> 内容描述数据的实际内容。


**Format** describes the data format of the DiagnosticDataElement.

> **格式** 描述了诊断数据元素的数据格式。


**Context** defines the exclusive context in which this DiagnosticDataElement is dfined (if applicable). For \"DEM\" see Diagnostic Event Management. For \"DCM\" see Diagnostic Communication Management.

> 上下文定义了此诊断数据元素的独特上下文（如果适用）。“DEM”指诊断事件管理，“DCM”指诊断通信管理。


**Table 7.9: Supported internal DiagnosticDataElements**

> 表7.9：支持的内部诊断数据元


[]{#_bookmark301 .anchor}**[SWS_DM_00393]**{DRAFT} **Retrieving data for internal DiagnosticDataElments** *[*If DM requires to provide or store data configured as internal DiagnoticDataElement which is supported by the Diagnostic Server instance acording to Table [7.9](#_bookmark300), then DM shall use the respective internally managed data value as defined in Table [7.9](#_bookmark300).*♩(RS_Diag_04097)*

> 如果DM需要提供或存储作为内部DiagnoticDataElement配置的数据，而该数据又是根据表7.9所支持的诊断服务器实例，那么DM应该使用表7.9中定义的相应的内部管理数据值。


**[SWS_DM_CONSTR_00394]**{DRAFT} **Internal DiagnosticDataElements are read-only** *[*A DiagnosticDataIdentifier referenced by a DiagnosticWritDataByIdentifier service shall not contain any internal DiagnostiDataElement.*♩(RS_Diag_04097)*

> **[SWS_DM_CONSTR_00394]**{草案} **内部诊断数据元只读** *[*被DiagnosticWritDataByIdentifier服务引用的DiagnosticDataIdentifier不应包含任何内部DiagnostiDataElement.*♩(RS_Diag_04097)*


An internal DiagnosticDataElement is called DCM-exclusive resp. DEexclusive if the context of the name token described in Table [7.9](#_bookmark300) is set accordingly. The implicit restriction of such DiagnosticDataElements to the context in which they are defined is made explicit in the following requirements. These requirements are formulated in a way that Table [7.9](#_bookmark300) might in future be extended by internal DiagnoticDataElements not restricted to exclusive use within a DCM resp. DEM context.

> 一个内部的DiagnosticDataElement被称为DCM-exclusive，或者DEexclusive，如果表7.9中描述的名称令牌的上下文被相应地设置。这种DiagnosticDataElements对它们定义的上下文的隐式限制被明确表达在下面的要求中。这些要求以一种方式被表达，以便表7.9未来可以被不受DCM或DEM上下文限制的内部DiagnoticDataElements扩展。


**[SWS_DM_CONSTR_00395]**{DRAFT} **Restriction on DEM-exclusive DiagnostiDataElements** *[*A DiagnosticParameter containing a DEM-exclusive internal DiagnosticDataElement shall not be contained in a DiagnosticDataIdentfier referenced by a DiagnosticReadDataByIdentifier, nor shall it be cotained in a realization of DiagnosticRoutineSubfunction.*♩(RS_Diag_04097)*

> [SWS_DM_CONSTR_00395]{草稿} **关于DEM专用诊断数据元的限制** *[*一个包含DEM专用内部诊断数据元的诊断参数不应该包含在由诊断读取数据识别符引用的诊断数据识别符中，也不应该包含在诊断例程子功能的实现中。*♩(RS_Diag_04097)*


**[SWS_DM_CONSTR_00396]**{DRAFT} **Restriction on DCM-exclusive DiagnostiDataElements** *[*A DiagnosticParameter containing a DCM-exclusive internal DiagnosticDataElement shall not be contained in a DiagnosticDataIdentfier referenced by a DiagnosticDataIdentifierSet which is referenced by some DiagnosticTroubleCodeProps in the role of snapshotRecordContent, nor shall it be contained in a DiagnosticExtendedDataRecord.*♩(RS_Diag_04097)*

> **[SWS_DM_CONSTR_00396]**{草案} **DCM专有诊断数据元素的限制** *[*包含DCM专有内部诊断数据元素的诊断参数不应包含在以快照记录内容角色引用的诊断数据标识符集中引用的诊断数据标识符中，也不应包含在诊断扩展数据记录中。*♩(RS_Diag_04097)*


Note: The notion of internal and external is exclusively defined for DiagnostiDataElements and does not apply to DiagnosticDataIdentifier.

> 注意：内部和外部的概念专门针对DiagnostiDataElements定义，不适用于DiagnosticDataIdentifier。


[]{#_bookmark302 .anchor}**[SWS_DM_00905]**{DRAFT} **Retrieving data for external DiagnosticDataElments** *[*If the Diagnostic Server instance is required to read data configured as external DiagnosticDataElement, then the Diagnostic Server instance shall utilize the associated RPortPrototype typed by the Namespace1OfPortInterface::Namespace2OfPortInterface::ShornameOfDEPortInterface class and call its Namespace1OfPortInterface:Namespace2OfPortInterface::ShortnameOfDEPortInterface::Read funtion.*♩(RS_Diag_04097)*

> 如果需要诊断服务器实例读取配置为外部诊断数据元素的数据，那么诊断服务器实例应该利用关联的RPortPrototype类型，由Namespace1OfPortInterface::Namespace2OfPortInterface::ShornameOfDEPortInterface类提供，并调用它的Namespace1OfPortInterface:Namespace2OfPortInterface::ShortnameOfDEPortInterface::Read函数（RS_Diag_04097）。


Note: In general, there are multiple instances of Namespace1OfPortInterface::Namespace2OfPortInterface::ShortnameOfDEPortInterface class avaiable in the running system. Which instance to choose for the given request to read an external DiagnosticDataElement is part of system integration. Support for this integration is provided by DiagnosticMappings described in section [7.6.6.2.1](#supported-diagnostic-mappings).

> 注意：通常情况下，运行系统中有多个Namespace1OfPortInterface::Namespace2OfPortInterface::ShortnameOfDEPortInterface类的实例可用。为了读取外部诊断数据元，选择哪个实例是系统集成的一部分。[7.6.6.2.1](#supported-diagnostic-mappings)节描述的诊断映射提供了此集成的支持。


**[SWS_DM_01275]**{DRAFT} **Namespace for typed DiagnosticDataElements iterface** *[*If the typed DiagnosticDataElements interface is used, it shall fulfill [SWS_DM_00510] also.*♩(RS_Diag_04097)*

> **[SWS_DM_01275]**{草稿} **类型化的诊断数据元接口的命名空间** *[*如果使用类型化的诊断数据元接口，则还应满足[SWS_DM_00510]。*♩(RS_Diag_04097)*

### Reading and Writing Diagnostic Data Identifier


The Diagnostic Server instance supports multiple ways to read or write dianostic data defined as DiagnosticDataIdentifier:

> 诊断服务器实例支持多种方式读取或写入定义为DiagnosticDataIdentifier的诊断数据。


- reading each DiagnosticDataElement contained in the DiagnostiDataIdentifier independently as described in section [7.6.6.1](#internal-and-external-diagnostic-data-elements),

> 阅读位于[7.6.6.1](#internal-and-external-diagnostic-data-elements)中描述的DiagnosticDataIdentifier中的每个DiagnosticDataElement，独立地。

- reading or writing the DiagnosticDataIdentifier as a whole via the DataIdentifier diagnostic interface,

> 通过DataIdentifier诊断接口整体读取或写入DiagnosticDataIdentifier。

- reading or writing the DiagnosticDataIdentifier as a whole via the GeneicService diagnostic interface.

> 通过通用服务诊断接口整体读取或写入诊断数据标识符。


The method to choose between these ways of data handling is by configuration of DiagnosticMappings referring to the DiagnosticDataIdentifier. This chapter describes the supported DiagnosticMappings and provides requirements on reading and writing DiagnosticDataIdentifier reflecting the short description above.

> 选择这些数据处理方式的方法是通过配置指向诊断数据标识符的诊断映射。本章节描述了支持的诊断映射，并提供了读取和写入反映上述简要描述的诊断数据标识符的要求。

### Supported Diagnostic Mappings


Details regarding the modeling of diagnostic mappings can be found in the TPS Manfest Specification [[13](#_bookmark18)].

> 诊断映射的建模细节可以在TPS Manfest规范[[13](#_bookmark18)]中找到。

### Reading Diagnostic Data Identifier


[]{#_bookmark306 .anchor}**[SWS_DM_00401]**{DRAFT} **Reading Diagnostic Data Identifier on Data Element level** *[*If the Diagnostic Server instance is required to read data confiured as DiagnosticDataIdentifier and at least one of the DiagnosticDataElments aggregated in this DiagnosticDataIdentifier is referenced by some DiagnosticMapping, then Diagnostic Server instance shall retrieve the data by reading data from each DiagnosticDataElement separately according to [[SWS_DM_00393](#_bookmark301)] and [[SWS_DM_00905](#_bookmark302)].*♩(RS_Diag_04097)*

> 如果需要诊断服务器实例读取配置为DiagnosticDataIdentifier的数据，并且该DiagnosticDataIdentifier聚合的至少一个DiagnosticDataElments被某个DiagnosticMapping引用，则诊断服务器实例应根据[[SWS_DM_00393](#_bookmark301)]和[[SWS_DM_00905](#_bookmark302)]分别从每个DiagnosticDataElement检索数据来检索数据。♩(RS_Diag_04097)


[]{#_bookmark307 .anchor}**[SWS_DM_00848]**{DRAFT} **Reading Diagnostic Data Identifier by typed DataIdetifier interface** *[*If the Diagnostic Server instance is required to read data configured as DiagnosticDataIdentifier which is referenced by a DianosticDataPortMapping, then the Diagnostic Server instance shall use the Namespace1OfPortInterface::Namespace2OfPortInterface::ShornameOfDIPortInterface class and associated to the DiagnosticDataIdentfier for reading the data.*♩(RS_Diag_04097)*

> 如果诊断服务器实例需要读取通过DiagnosticDataPortMapping引用的配置为DiagnosticDataIdentifier的数据，则诊断服务器实例应使用Namespace1OfPortInterface::Namespace2OfPortInterface::ShornameOfDIPortInterface类并与DiagnosticDataIdentfier相关联以读取数据(RS_Diag_04097)。


**[SWS_DM_01038]**{DRAFT} **Reading Diagnostic Data Identifier by ara::diag::GenericDataIdentifier interface** *[*If the Diagnostic Server instance is required to read data configured as DiagnosticDataIdentfier which is referenced by a DiagnosticServiceGenericMapping, then the Diagnostic Server instance shall use the ara::diag::GenericDataIdetifier instance according to its PortPrototype mapping.*♩(RS_Diag_04097)*

> 如果诊断服务器实例需要读取配置为DiagnosticDataIdentfier的数据，并且该数据被DiagnosticServiceGenericMapping引用，则诊断服务器实例应根据其PortPrototype映射使用ara :: diag :: GenericDataIdetifier实例。


[]{#_bookmark308 .anchor}**[SWS_DM_00849]**{DRAFT} **Reading Diagnostic Data Identifier by GenericUDSSevice interface** *[*If the Diagnostic Server instance is required to read data cofigured as DiagnosticDataIdentifier which is referenced by a DiagnostiServiceGenericMapping , then the Diagnostic Server instance shall use the instance of the ara::diag::GenericUDSService class referenced by the DagnosticServiceGenericMapping and call its ara::diag::GenericUDSSevice::HandleMessage method with sid parameter set to 0x22 and requestData parameter set to the id of the DiagnosticDataIdentifier.*♩(RS_Diag_04097)*

> 如果需要诊断服务器实例读取作为诊断数据标识符配置的数据，该数据由诊断服务通用映射引用，则诊断服务器实例应使用ara::diag::GenericUDSService类的实例引用DagnosticServiceGenericMapping，并调用其ara::diag::GenericUDSSevice::HandleMessage方法，其中sid参数设置为0x22，requestData参数设置为诊断数据标识符的ID。(RS_Diag_04097)


The application realizing the ara::diag::GenericUDSService::HandleMesage is in the responsibility of a serialization/deserialization of UDS parameters. That means no data typed elements are provided as UDS input/output parameters.

> 应用程序实现ara::diag::GenericUDSService::HandleMesage负责UDS参数的序列化/反序列化。这意味着没有数据类型元素作为UDS输入/输出参数提供。


[]{#_bookmark309 .anchor}**[SWS_DM_00850]**{DRAFT} **Default Service Interface for reading DiagnostiDataIdentifier** *[*If the Diagnostic Server instance is required to read data configured as DiagnosticDataIdentifier and none of the requirements [[SWS_DM_00401](#_bookmark306)], [[SWS_DM_00848](#_bookmark307)], [[SWS_DM_00849](#_bookmark308)] applies, then the Dianostic Server instance shall utilize the associated RPortPrototype typed by the Namespace1OfPortInterface::Namespace2OfPortInterface::ShornameOfDIPortInterface and call its Namespace1OfPortInterface::Namspace2OfPortInterface::ShortnameOfDIPortInterface::Read function.*♩ (RS_Diag_04097)*

> 如果诊断服务器实例需要读取配置为DiagnosticDataIdentifier的数据，并且不符合[[SWS_DM_00401](#_bookmark306)]、[[SWS_DM_00848](#_bookmark307)]、[[SWS_DM_00849](#_bookmark308)]的要求，那么诊断服务器实例应该使用由Namespace1OfPortInterface::Namespace2OfPortInterface::ShornameOfDIPortInterface类型化的RPortPrototype，并调用其Namespace1OfPortInterface::Namspace2OfPortInterface::ShortnameOfDIPortInterface::Read函数。（RS_Diag_04097）


Note: The default configuration as described in [[SWS_DM_00850](#_bookmark309)] assumes, that there is a single instance of PPortPrototype defined in the system, matching the RPortPrototype associated to the requested DiagnosticDataIdentifier. In this case, it is part of integration step to link these two ports.

> 注意：[[SWS_DM_00850](#_bookmark309)]中描述的默认配置假定系统中定义了与所请求的DiagnosticDataIdentifier关联的RPortPrototype相匹配的单个PPortPrototype实例。在这种情况下，将这两个端口链接起来是集成步骤的一部分。


**[SWS_DM_01274]**{DRAFT} **Namespace for typed DiagnosticDataIdentifier iterface** *[*If the typed DiagnosticDataIdentifier interface is used, it shall fulfill [SWS_DM_00510] also.*♩(RS_Diag_04097)*

> **[SWS_DM_01274]**{草案} **类型化的诊断数据标识符接口的命名空间** *[*如果使用类型化的诊断数据标识符接口，则还应满足[SWS_DM_00510]。*♩(RS_Diag_04097)*

### Writing Diagnostic Data Identifier


[]{#_bookmark311 .anchor}**[SWS_DM_00906]**{DRAFT} **Writing Diagnostic Data Identifier by DataIdentifier interface** *[*If the Diagnostic Server instance is required to write data confiured as DiagnosticDataIdentifier which is referenced by a DiagnosticDaaPortMapping, then the Diagnostic Server instance shall use the ara:diag::GenericDataIdentifier instance and associated to the DiagnostiDataIdentifier for writing the data.*♩(RS_Diag_04097)*

> 如果需要诊断服务器实例通过DataIdentifier接口编写由DiagnosticDataPortMapping引用的诊断数据标识符，则诊断服务器实例应使用ara：diag：GenericDataIdentifier实例并关联到DiagnostiDataIdentifier以编写数据。♩（RS_Diag_04097）


**[SWS_DM_01039]**{DRAFT} **Writing Diagnostic Data Identifier by DataIdentifier interface** *[*If the Diagnostic Server instance is required to write data cofigured as DiagnosticDataIdentifier which is referenced by a DiagnostiServiceGenericMapping, then the Diagnostic Server instance shall use the Namespace1OfPortInterface::Namespace2OfPortInterface::ShornameOfDIPortInterface according to its PortPrototype mapping.*♩(RS_Diag\04097)*

> **[SWS_DM_01039]**{草稿} **通过DataIdentifier接口编写诊断数据标识符** *[*如果诊断服务器实例需要编写配置为诊断数据标识符的数据，该诊断数据标识符由DiagnostiServiceGenericMapping引用，则根据其PortPrototype映射，诊断服务器实例应使用Namespace1OfPortInterface::Namespace2OfPortInterface::ShornameOfDIPortInterface。*♩(RS_Diag\04097)*


[]{#_bookmark312 .anchor}**[SWS_DM_00908]**{DRAFT} **Writing Diagnostic Data Identifier by GenericUDSSevice interface** *[*If the Diagnostic Server instance is required to write data cofigured as DiagnosticDataIdentifier which is referenced by a DiagnostiServiceGenericMapping, then the Diagnostic Server instance shall use the instance of the ara::diag::GenericUDSService class referenced by the DagnosticServiceGenericMapping and call its ara::diag::GenericUDSSevice::HandleMessage with sid set to 0x2E and requestData set to the id of this DiagnosticDataIdentifier followed by the data to be written to this DiagnoticDataIdentifier.*♩(RS_Diag_04097)*

> 如果需要诊断服务器实例写入配置为DiagnosticDataIdentifier的数据，该数据参考了DiagnostiServiceGenericMapping，那么诊断服务器实例应使用ara :: diag :: GenericUDSService类的实例，该实例由DagnosticServiceGenericMapping引用，并调用其ara :: diag :: GenericUDSSevice :: HandleMessage，其sid设置为0x2E，requestData设置为此DiagnosticDataIdentifier的ID，然后是要写入此DiagnoticDataIdentifier的数据。♩（RS_Diag_04097）


[]{#_bookmark313 .anchor}**[SWS_DM_00907]**{DRAFT} **Default Service Interface for writing DiagnoticDataIdentifier** *[*If the Diagnostic Server instance is required to write data configured as DiagnosticDataIdentifier and none of the rquirements [[SWS_DM_00906](#_bookmark311)], [[SWS_DM_00908](#_bookmark312)] applies, then the Diagnotic Server instance shall utilize the associated RPortPrototype typed by the Namespace1OfPortInterface::Namespace2OfPortInterface:ShortnameOfDIPortInterface and call Namespace1OfPortInterface:Namespace2OfPortInterface::ShortnameOfDIPortInterface::Write.*♩ (RS_Diag_04097)*

> 如果诊断服务器实例需要编写配置为DiagnosticDataIdentifier的数据，并且无法满足[[SWS_DM_00906](#_bookmark311)]，[[SWS_DM_00908](#_bookmark312)]的要求，那么诊断服务器实例应该利用关联的RPortPrototype类型，由Namespace1OfPortInterface::Namespace2OfPortInterface:ShortnameOfDIPortInterface提供，并调用Namespace1OfPortInterface:Namespace2OfPortInterface::ShortnameOfDIPortInterface::Write。（RS_Diag_04097）


Note: The default configuration as described in [[SWS_DM_00907](#_bookmark313)] assumes, that there is a single instance of PPortPrototype defined in the system matching the RPortPrototype associated to the requested DiagnosticDataIdentifier. In this case, it is part of integration step to link these two ports.

> 注意：[[SWS_DM_00907](#_bookmark313)]中所述的默认配置假定系统中有与所请求的DiagnosticDataIdentifier关联的RPortPrototype匹配的单个PPortPrototype实例。在这种情况下，将这两个端口链接起来是集成步骤的一部分。

# API specification


This chapter lists all provided and required C++ API interfaces of the DM. The C++ API interfaces are divided into two parts:

> 本章节列出DM所提供和需要的所有C++ API接口。C++ API接口分为两部分：

- UDS Transportlayer interface


A plug-in interface to extend the DM by own transport layers

> 一个插件接口，可以通过自己的传输层来扩展DM。

- Diagnostic Application interface


A DiagnosticPortInterfaces is representing a corresponding code istance. The deployment is simplified due to a direct mapping to DiagnosticObject in DEXT.

> 一个DiagnosticPortInterfaces代表一个相应的代码实例，由于与DEXT中的DiagnosticObject的直接映射，部署变得更加简单。

## C++ language binding \<sub component\>

No content.


2. ## API Common Data Types

> 2. ## 常用的API数据类型


   1. ### C++ Diagnostic Error Types

> ### C++诊断错误类型


**[SWS_DM_00544]**{DRAFT} **Use of general ara::diag errors** *[*Any Checked Error of a service interface shall be reported via the return type as specified in [[6](#_bookmark12)].*♩(RS\AP_00128)*

> **[SWS_DM_00544]**{草稿} **使用通用ara :: diag错误** *[*任何服务接口的检查错误都应按照[[6](#_bookmark12)]中指定的返回类型报告。*♩(RS\AP_00128)*


In ara::diag, there are the following types of Checked Errors:

> 在ara::diag中，有以下类型的已检查错误：


1. Offer ara::diag errors: These errors can occur in a call of a any Offer interface method. They are defined in the error domain ara::diag::DiagErrorDmain.

> 提供ara::diag错误：这些错误可以在调用任何Offer接口方法时发生。它们在ara::diag::DiagErrorDmain中定义。

2. Reporting ara::diag errors: These errors can occur in a call of a ReportMonitorAtion interface method. They are defined in the error domain ara::diag::DagErrorDomain.

> 报告ara::diag错误：这些错误可能会在调用ReportMonitorAtion接口方法时发生。它们定义在错误域ara::diag::DagErrorDomain中。

3. UDS NRC ara::diag errors: These errors can be returned by the skeletons. They are defined in the error domain ara::diag::DiagUdsNrcErrorDomain.

> 3. UDS NRC ara::diag 错误：这些错误可以由骨架返回。它们在错误域ara::diag::DiagUdsNrcErrorDomain中定义。


Note: Beside the AUTOSAR defined error domains, platform vendors can optionally define their own vendor specific error domains.

> 注意：除了AUTOSAR定义的错误域之外，平台供应商可以选择性地定义自己的供应商特定错误域。

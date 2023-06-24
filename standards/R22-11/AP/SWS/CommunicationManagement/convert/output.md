If not successful, Send() shall return an ara::core::ErrorCode from the ara::com::ComErrorDomain indicating the error. The following errors are possible:

- ComErrc::kServiceNotOffered: Service not offered.
- ComErrc::kCommunicationLinkError: Communication link is broken.
- ComErrc::kCommunicationStackError: Communication Stack Error, e.g. network stack, network binding, or communication framework reports an error.

_♩(RS_CM_00201, RS_AP_00114, RS_AP_00120, RS_AP_00121)_

**[SWS_CM_00012]**{DRAFT} **Re-entrancy and thread-safety Send** *[*Send shall be re-entrant and thread-safe for _different_ Event class instances. When called re-entrant or concurrently on the same Event class instance, the behavior is undefined._♩(RS_CM_00201, RS_AP_00114, RS_AP_00120, RS_AP_00121)_

### [SWS_CM_90438] Allocate data when Communication Management is responsible for the data _[_

The Allocate method of the specific Event class is used to allocate memory for the event data when Communication Management is responsible for the data.

ara::core::Result\<ara::com::SampleAllocateePtr\<SampleType\>\> Event::Allocate();

There are two error codes that shall be returned in the Result of the Allocate method of the specific Event class:

- ComErrc::kSampleAllocationFailure: If the allocation of the shared memory fails (i.e., failure to retrieve/allocate a shared slot for a sample).
- ComErrc::kIllegalUseOfAllocate: If the allocation is done via custom allocator (i.e., not via shared memory allocation).The error shall be logged.

_♩(RS_CM_00201, RS_AP_00114, RS_AP_00115, RS_AP_00120)_

See [[SWS_CM_00308](#_bookmark480)] for the type definition of SampleAllocateePtr and ARAComAPI explanatory document [1] for more details on the behavior.

**[SWS_CM_00013]**{DRAFT} **Re-entrancy and thread-safety Allocate** *[*Allocate

shall be re-entrant and thread-safe for _different_ Event class instances. When called

re-entrant or concurrently on the same Event class instance, the behavior is undefined._♩(RS_CM_00201, RS_AP_00114, RS_AP_00115, RS_AP_00120)_

### Send Trigger

Inside the specific Trigger class belonging to the specific ServiceSkeleton class a Send method shall be provided to initiate sending the corresponding trigger.

**[SWS_CM_00721]**{DRAFT} **Send trigger** *[*The Send method of the specific Trigger class send trigger to all subscribed applications.

ara::core::Result\<void\> Trigger::Send();

If not successful, Send() shall return an ara::core::ErrorCode from the ara::com::ComErrorDomain indicating the error. The following errors are possible:

- ComErrc::kServiceNotOffered: Service not offered.
- ComErrc::kCommunicationLinkError: Communication link is broken.
- ComErrc::kCommunicationStackError: Communication Stack Error, e.g. network stack, network binding, or communication framework reports an error.

_♩(RS_CM_00201, RS_AP_00114, RS_AP_00120, RS_AP_00121)_

**[SWS_CM_00722]**{DRAFT} **Re-entrancy and thread-safety Send** *[*Send shall be re-entrant and thread-safe for different Trigger class instances. When called reentrant or concurrently on the same Trigger class instance, the behavior is undefined._♩(RS_CM_00201, RS_AP_00114, RS_AP_00120, RS_AP_00121)_

### Provide a service method

**[SWS_CM_00191]**{DRAFT} **Provision of method** *[*A pure virtual method shall be defined inside the specific ServiceSkeleton class for each provided method of the service.

The name of this method and its parameters are derived from the signature of the provided service method.

The service method input parameters shall become input parameters of the respective method defined inside the ServiceSkeleton class.

An Output type combining the possible output parameters shall be provided inside the ServiceSkeleton class.

The method shall return an ara::core::Future object wrapping the output parameters as result.

A corresponding subclass providing implementations for the methods shall be created to implement the methods of a respective ServiceSkeleton.

```
struct Method1Output { TypeOutputParameter1 output1;

TypeOutputParameter2 output2;

\...

};

virtual ara::core::Future \<Method1Output\> Method1( TypeInputParameter1 input1,

TypeInputParameter2 input2,

\...

) = 0;
```

_♩(RS_CM_00211, RS_AP_00114, RS_AP_00138, RS_AP_00128, RS_AP_00127, RS_AP_00138)_

**[SWS_CM_90434]**{DRAFT} **Provision of a Fire and Forget method** *[*A pure virtual method shall be defined inside the specific ServiceSkeleton class for each provided Fire and Forget method of the service.

The name of this method and its parameters are derived from the signature of the provided Fire and Forget method.

The Fire and Forget method input parameters shall become input parameters of the respective method defined inside the ServiceSkeleton class. The Fire and Forget method shall have no return values.

A corresponding subclass providing implementations for the Fire and Forget methods shall be created to implement the Fire and Forget method of a respective ServiceSkeleton.

```
virtual void FireForgetMethod1( TypeInputParameter1 input1, TypeInputParameter2 input2,

\...

) = 0;
```

_♩(RS_CM_00225, RS_AP_00114)_

**[SWS_CM_00017]**{DRAFT} **Re-entrancy and thread-safety ServiceSkeleton method implementation** *[*The ServiceSkeleton method implementation shall be re-entrant and thread-safe in case the ServiceSkeleton instance has been created in event-driven concurrent mode(kEvent). The ServiceSkeleton method implementation may be non-re-entrant and non-thread-safe otherwise (i.e., in eventdriven sequential mode (kEventSingleThread) and in polling mode (kPoll))._♩ (RS_CM_00211, RS_AP_00114, RS_AP_00138, RS_AP_00128, RS_AP_00127, RS_AP_00138)_

### Processing of service methods

For the functional description of the processing of service methods API, see chapter [7.9.4](#processing-of-service-methods).

### [SWS_CM_00198] {DRAFT} Set service method processing mode _[_

With the instantiation of a specific ServiceSkeleton class, the mode for processing service method invocations is set by providing an ara::com::MethodCallProcessingMode as a parameter of the constructor. The data type representing the processing modes is defined by [[SWS_CM_00301](#_bookmark487)].

The following processing modes shall be supported:

- **Polling** (enumeration element kPoll)
- **Event-driven, concurrent** (enumeration element kEvent)
- **Event-driven, sequential** (enumeration element kEventSingleThread)

_♩(RS_CM_00211, RS_AP_00114, RS_AP_00115, RS_AP_00120)_

### [SWS_CM_00199] Process Service method invocation _[_

Inside the specific ServiceSkeleton class, a ProcessNextMethodCall method shall be provided.

The method shall return an ara::core::Future object wrapping a bool parameter as return value. A returned value true indicates that there is at least one pending invocation, returning false indicates the opposite. The returned ara::core::Future becomes ready, after the service method (see [[SWS_CM_00191](#_bookmark537)] or [[SWS_CM_90434](#_bookmark538)]) invoked due to ProcessNextMethodCall() has completed.

ara::core::Future\<bool\> ProcessNextMethodCall();

_♩(RS_CM_00211, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP_00127, RS_AP_00138)_

### [SWS_CM_11350] {DRAFT} Execution Context for process service method invocation _[_

For the ProcessNextMethodCall method described in [[SWS_CM_00199](#sws_cm_00199-process-service-method-invocation)], a second overload with an additional input parameter shall be provided. This parameter shall provide an executioner object in which any asynchronous computation spawn by ProcessNextMethodCall shall be invoked. The minimum behavior of the Execution Context is defined in [[SWS_CM_11364](#_bookmark34)]. For the first overload without an execution context argument, an implementation defined default execution context (like in previous AUTOSAR releases) shall be used.

```
template\<typename ExecutorT\>

ara::core::Future\<bool\> ProcessNextMethodCall(ExecutorT &&executor);
```

_♩(RS_CM_00211, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP_00127, RS_AP_00138)_

**[SWS_CM_11351]**{DRAFT} **Error behaviour of provided Execution Context for process service method invocation** *[*In case a ProcessNextMethodCall() cannot be executed with the provided executor (e.g. because of resource problem) an

ComErrc::kCouldNotExecute error shall be raised in all cases._♩(RS_CM_00211, RS_CM_00212, RS_CM_00213, RS_CM_00214, RS_AP_00114, RS_AP_00119, RS_AP_00127)_

**[SWS_CM_10362]**{DRAFT} **Raising checked errors for application errors** *[*Whenever on the skeleton side of a service method an ApApplicationError -according to the interface description in the Manifest -is detected, the corresponding ara::core::ErrorCode representing this ApApplicationError (see [[SWS_CM_11266](#_bookmark500)]) shall be stored into the ara::core::Promise object, from which the ara::core::Future is returned to the caller._♩(RS_CM_00211, RS_CM_00212, RS_CM_00213, RS_CM_00214, RS_AP_00114, RS_AP_00119, RS_AP_00127)_

### Registering get handlers for fields

For the functional description of the registering get handlers for fields API, see chapter [7.9.5](#registering-get-handlers-for-fields).

**[SWS_CM_00114] Registering Getters** *[*Inside the specific Field class belonging to the specific ServiceSkeleton class a RegisterGetHandler method shall be provided to give the possibility to register a GetHandler.

ara::core::Result\<void\> RegisterGetHandler( std::function\<ara::core::Future\<FieldType\>(

)\> getHandler);

_♩(RS_CM_00218, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP_00127)_

**[SWS_CM_11360]**{DRAFT} **Execution Context for registering Getters** *[*For the RegisterGetHandler method described in [[SWS_CM_00114](#_bookmark543)] a second overload with an additional input parameter shall be provided. This parameter shall provide an executioner object in which any asynchronous computation spawn by RegisterGetHandler shall be invoked. The minimum behavior of the Execution Context is defined in [[SWS_CM_11364](#_bookmark34)].

template\<typename ExecutorT\> ara::core::Result\<void\> RegisterGetHandler(

std::function\<ara::core::Future\<FieldType\>(

)\> getHandler, ExecutorT&& executor);

For the first overload without an execution context argument an implementation defined default execution context (like in previous AUTOSAR releases) shall be used._♩ (RS_CM_00211, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP_00127, RS_AP_00138)_

**[SWS_CM_11361]**{DRAFT} **Error behaviour of provided Execution Context for registering Getters** *[*In case a RegisterGetHandler() cannot be executed with

the provided executor (e.g. because of resource problem) a ComErrc::kCouldNotExecute error shall be raised in all cases._♩(RS_CM_00211, RS_CM_00212, RS_CM_00213, RS_CM_00214, RS_AP_00114, RS_AP_00119, RS_AP_00127)_

**[SWS_CM_00115]**{DRAFT} **Existence of RegisterGetHandler method** *[*The existence of RegisterGetHandler as part of the Field class shall be controlled by Field.hasGetter._♩(RS_CM_00218, RS_AP_00114)_

**[SWS_CM_00014]**{DRAFT} **Re-entrancy and thread-safety RegisterGetHandler** *[*RegisterGetHandler shall be re-entrant and thread-safe for _different_ Field class instances. When called re-entrant or concurrently on the same Field class instance, the behavior is undefined._♩(RS_CM_00218, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP_00127)_

### Registering set handlers for fields

For the functional description of the registering set handlers for fields API, see chapter [7.9.6](#registering-set-handlers-for-fields).

**[SWS_CM_00116] Registering Setters** *[*Inside the specific Field class belonging to the specific ServiceSkeleton class a RegisterSetHandler function shall be provided to give the possibility to register a SetHandler.

ara::core::Result\<void\> RegisterSetHandler( std::function\<ara::core::Future\<FieldType\>(

const FieldType& value)\> setHandler);

_♩(RS_CM_00218, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP_00127)_

**[SWS_CM_11362]**{DRAFT} **Execution Context for registering Setters** *[*For the RegisterSetHandler method described in [[SWS_CM_00116](#_bookmark546)] a second overload with an additional input parameter shall be provided. This parameter shall provide an executioner object in which any asynchronous computation spawn by RegisterSetHandler shall be invoked. The minimum behavior of the Execution Context is defined in [[SWS_CM_11364](#_bookmark34)].

template\<typename ExecutorT\> ara::core::Result\<void\> RegisterSetHandler(

std::function\<ara::core::Future\<FieldType\>(

const FieldType& value)\> setHandler, ExecutorT&& executor);

For the first overload without an execution context argument an implementation defined default execution context (like in previous AUTOSAR releases) shall be used._♩ (RS_CM_00211, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP_00127, RS_AP_00138)_

**[SWS_CM_11363]**{DRAFT} **Error behaviour of provided Execution Context for registering Setters** *[*In case a RegisterGetHandler() cannot be executed with

the provided executor (e.g. because of resource problem) a ComErrc::kCouldNotExecute error shall be raised in all cases._♩(RS_CM_00211, RS_CM_00212, RS_CM_00213, RS_CM_00214, RS_AP_00114, RS_AP_00119, RS_AP_00127)_

**[SWS_CM_00117]**{DRAFT} **Existence of the RegisterSetHandler method** *[*The existence of RegisterSetHandler as part of the Field class shall be controlled by Field.hasSetter._♩(RS_CM_00218, RS_AP_00114)_

**[SWS_CM_00015]**{DRAFT} **Re-entrancy and thread-safety RegisterSetHandler** *[*RegisterSetHandler shall be re-entrant and thread-safe for _different_ Field class instances. When called re-entrant or concurrently on the same Field class instance, the behavior is undefined._♩(RS_CM_00218, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP_00127)_

**[SWS_CM_00119]**{DRAFT} **Update Function** *[*Inside the specific Field class belonging to the specific ServiceSkeleton class an Update function shall be provided to initiate the transmission of updated field data to the subscribers. See [[SWS_CM_00162](#sws_cm_00162-send-event-where-application-is-responsible-for-the-data)] for the required behavior. The Update method shall look as follows:

ara::core::Result\<void\> Field::Update(const FieldType &value);

It shall return void if the connection is successful, or an ara::core::ErrorCode

from the ara::com::ComErrorDomain indicating the error if not successful. The following errors from the ara::core::ComErrorDomain are possible:

- **kServiceNotOffered:** Service not offered.
- **kCommunicationLinkError:** Communication link is broken.
- **kCommunicationStackError:** Communication Stack Error, e.g. network stack, network binding, or communication framework reports an error

The Update function shall also update the field's internal value, if:

- If Field.hasGetter is true (according to [[SWS_CM_00132](#_bookmark589)] and
- no custom Getter has been registered

An update notification shall be sent, if hasNotification is true (in accordance to [[SWS_CM_00120](#_bookmark440)]._♩(RS_CM_00218, RS_AP_00114, RS_AP_00120, RS_AP_00121)_

**[SWS_CM_00016]**{DRAFT} **Re-entrancy and thread-safety Update** *[*Update shall be re-entrant and thread-safe for _different_ Field class instances. When called reentrant or concurrently on the same Field class instance, the behavior is undefined._♩ (RS_CM_00218, RS_AP_00114, RS_AP_00120, RS_AP_00121)_

### Find service

For the functional description of the find service API, see chapter [7.9.7](#find-service).

The Communication Management shall provide FindService methods as part of the ServiceProxy class to enable applications to find services. To support event-based and time-triggered systems the FindService methods shall be provided in a handler registration and a immediately returned request style.

**[SWS_CM_00122]**{DRAFT} **Find service with immediately returned request using Instance ID** *[*The FindService method of the ServiceProxy class with immediately returned request takes an instance ID qualifying the wanted instance of the service as input parameter.

It shall return a result struct encapsulating a container of handles for all matching service instances, or an ara::core::ErrorCode from the ara::com::ComErrorDomain indicating the error if not successful.

There is one FindService method for using a specified InstanceIdentifier.

static ara::core::Result\<ara::com::ServiceHandleContainer\<

\<ProxyClassName\>::HandleType\>\> FindService(ara::com::InstanceIdentifier instance);

where \<ProxyClassName\> is the name of the ServiceProxy class as defined in [[SWS_CM_00004](#_bookmark516)].

The following errors from ara::com::ComErrorDomain are possible:

- kNetworkBindingFailure: Local failure has been detected by the network binding.
- kGrantEnforcementError: Request was refused by Grant enforcement layer.
- kPeerIsUnreachable: Transport Layer Security handshake failed.

InstanceIdentifier validation errors or allocation failures of the ServiceHandleContainer shall be treated as Violations. ([SWS_CORE_00003], [SWS_CORE_00005])_♩(RS_CM_00102, RS_AP_00114, RS_AP_00115, RS_AP_00120, RS_AP_00121, RS_AP_00119)_

For the definition of the types used in the FindService signature, see:

- [[SWS_CM_00304](#_bookmark475)] for ServiceHandleContainer,
- [[SWS_CM_00312](#_bookmark471)] for HandleType,
- [[SWS_CM_00302](#sws_cm_00302draft-instance-identifier-class)] for InstanceIdentifier.

**[SWS_CM_00622]**{DRAFT} **Find service with immediately returned request using Instance Specifier** *[*The FindService method of the ServiceProxy class with immediately returned request takes an instance Specifier qualifying the wanted Abstract Network Binding for the instance.

It shall return a result struct encapsulating a container of handles for all matching service instances, or an ara::core::ErrorCode from the ara::com::ComErrorDomain indicating the error if not successful.

static ara::core::Result\<ara::com::ServiceHandleContainer\<

\<ProxyClassName\>::HandleType\>\> FindService(ara::core::InstanceSpecifier instance);

where \<ProxyClassName\> is the name of the ServiceProxy class as defined in [[SWS_CM_00004](#_bookmark516)].

The following errors from ara::com::ComErrorDomain are possible:

- kNetworkBindingFailure: Local failure has been detected by the network binding.
- kGrantEnforcementError: Request was refused by Grant enforcement layer.
- kPeerIsUnreachable: Transport Layer Security handshake failed.

InstanceSpecifier validation errors, or allocation failures of the ServiceHandleContainer shall be treated as Violations. ([SWS_CORE_00003], [SWS_CORE_00005])_♩(RS_CM_00102, RS_AP_00114, RS_AP_00115, RS_AP_00121, RS_AP_00119, RS_AP_00127, RS_AP_00137)_

For the definition of the types used in the FindService signature, see:

- [[SWS_CM_00304](#_bookmark475)] for ServiceHandleContainer,
- [[SWS_CM_00312](#_bookmark471)] for HandleType,
- [SWS_CORE_08001] for InstanceSpecifier.

**[SWS_CM_00018]**{DRAFT} **Re-entrancy and thread-safety FindService** *[*FindService is neither re-entrant nor thread-safe. When called re-entrant or concurrently, the behavior is undefined._♩(RS_CM_00102, RS_AP_00114, RS_AP_00115, RS_AP_00121, RS_AP_00119, RS_AP_00127, RS_AP_00137)_

**[SWS_CM_00123]**{DRAFT} **Find service with handler registration using Instance ID** *[*The StartFindService method of the ServiceProxy class with handler registration takes as input parameters a FindServiceHandler, fitting for the corresponding ServiceProxy class which gets called upon detection of a matching service, and an instance ID qualifying the wanted instance of the service. The return value is a result struct encapsulating a FindServiceHandle for this search/find request, or an ara::core::ErrorCode from the ara::com::ComErrorDomain indicating the error if not successful. The FindServiceHandle is needed to stop the service availability monitoring and related firing of the given handler.

There is one StartFindService method for using a specified InstanceIdentifier.

```
static ara::core::Result\<ara::com::FindServiceHandle\> StartFindService( ara::com::FindServiceHandler\<\<ProxyClassName\>::HandleType\> handler, ara::com::InstanceIdentifier instance);
```

where \<ProxyClassName\> is the name of the ServiceProxy class as defined in [[SWS_CM_00004](#_bookmark516)].

The following errors from ara::com::ComErrorDomain are possible:

- kNetworkBindingFailure: Local failure has been detected by the network binding.
- kGrantEnforcementError: Request was refused by Grant enforcement layer.
- kPeerIsUnreachable: Transport Layer Security handshake failed.

InstanceIdentifier validation errors or allocation failures of the ServiceHandleContainer shall be treated as Violations. ([SWS_CORE_00003], [SWS_CORE_00005])

_♩(RS_CM_00102, RS_AP_00114, RS_AP_00115, RS_AP_00120, RS_AP_00121, RS_AP_00119)_

For the definition of the types used in the StartFindService signature, see:

- [[SWS_CM_00303](#_bookmark470)] for FindServiceHandle,
- [[SWS_CM_00383](#_bookmark476)] for FindServiceHandler,
- [[SWS_CM_00312](#_bookmark471)] for HandleType,
- [[SWS_CM_00302](#sws_cm_00302draft-instance-identifier-class)] for InstanceIdentifier.

Note: StartFindService is an asynchronous indication of availability and not to be abused for liveness monitoring.

**[SWS_CM_11352]**{DRAFT} **Execution Context for finding service with handler registration using Instance ID** *[*For the StartFindService method described in [[SWS_CM_00123](#_bookmark552)] a second overload with an additional input parameter shall be provided. This parameter shall provide an executioner object in which any asynchronous computation spawn by StartFindService shall be invoked. The minimum behavior of the Execution Context is defined in [[SWS_CM_11364](#_bookmark34)].

template\<typename ExecutorT\>

static ara::com::FindServiceHandle StartFindService( ara::com::FindServiceHandler\<\<ProxyClassName\>::HandleType\> handler, ara::com::InstanceIdentifier instance, ExecutorT&& executor);

For the first overload without an execution context argument an implementation defined default execution context (like in previous AUTOSAR releases) shall be used._♩ (RS_CM_00102, RS_AP_00114, RS_AP_00115, RS_AP_00120, RS_AP_00121, RS_AP_00119)_

**[SWS_CM_11353]**{DRAFT} **Error behavior of provided Execution Context for finding service with handler registration using Instance ID** *[*In case a StartFindService() cannot be executed with the provided executor (e.g. because of resource problem) an ComErrc::kCouldNotExecute error shall be raised in all cases._♩(RS_CM_00211, RS_CM_00212, RS_CM_00213, RS_CM_00214, RS_AP_00114, RS_AP_00119, RS_AP_00127)_

**[SWS_CM_00623]**{DRAFT} **Find service with handler registration using Instance Specifier** *[*The StartFindService method of the ServiceProxy class with handler registration takes as input parameters a FindServiceHandler, fitting for the corresponding ServiceProxy class which gets called upon detection of a matching service, and an instance Specifier qualifying the wanted Abstract Network Binding of the instance of the service. The return value is a result struct encapsulating a FindServiceHandle for this search/find request, or an ara::core::ErrorCode from the ara::com::ComErrorDomain indicating the error if not successful. The FindServiceHandle is needed to stop the service availability monitoring and related firing of the given handler.

```
static ara::core::Result\<ara::com::FindServiceHandle\> StartFindService( ara::com::FindServiceHandler\<\<ProxyClassName\>::HandleType\> handler, ara::core::InstanceSpecifier instance);
```

where \<ProxyClassName\> is the name of the ServiceProxy class as defined in [[SWS_CM_00004](#_bookmark516)].

The following errors from ara::com::ComErrorDomain are possible:

- kNetworkBindingFailure: Local failure has been detected by the network binding.
- kGrantEnforcementError: Request was refused by Grant enforcement layer.
- kPeerIsUnreachable: Transport Layer Security handshake failed.

InstanceSpecifier validation errors, or allocation failures of the ServiceHandleContainer should be treated as Violations. ([SWS_CORE_00003], [SWS_CORE_00005])_♩(RS_CM_00102, RS_AP_00114, RS_AP_00115, RS_AP_00121, RS_AP_00119, RS_AP_00127, RS_AP_00137)_

For the definition of the types used in the StartFindService signature, see:

- [[SWS_CM_00303](#_bookmark470)] for FindServiceHandle,
- [[SWS_CM_00383](#_bookmark476)] for FindServiceHandler,
- [[SWS_CM_00312](#_bookmark471)] for HandleType,
- [SWS_CORE_08001] for InstanceSpecifier.

Note: StartFindService is an asynchronous indication of availability and not to be abused for liveness monitoring.

### [SWS_CM_00019] {DRAFT} Re-entrancy and thread-safety StartFindService

*[*StartFindService is neither re-entrant nor thread-safe. When called re-entrant or concurrently, the behavior is undefined._♩(RS_CM_00102, RS_AP_00114, RS_AP_00115, RS_AP_00121, RS_AP_00119, RS_AP_00127, RS_AP_00137)_

**[SWS_CM_00125]**{DRAFT} **Stop find service** *[*To stop receiving further notifications the ServiceProxy class shall provide a StopFindService method. The FindServiceHandle returned by the FindService method with handler registration has to be provided as input parameter.

```
void StopFindService(ara::com::FindServiceHandle handle)
```

_♩(RS_CM_00102, RS_AP_00114, RS_AP_00120, RS_AP_00121)_

See [[SWS_CM_00303](#_bookmark470)] for the type definition of FindServiceHandle.

**[SWS_CM_00020]**{DRAFT} **Re-entrancy and thread-safety StopFindService** *[*StopFindService shall be re-entrant and thread-safe for _different_ ara::com::FindServiceHandles. When called re-entrant or concurrently with the same ara::com::FindServiceHandle, the behavior is undefined._♩(RS*CM_00102, RS_AP*-_

_00114, RS_AP_00120, RS_AP_00121)_

### Service proxy creation

For the functional description of the service proxy creation API, see chapter [7.9.8](#service-proxy-creation).

**[SWS_CM_00131]**{DRAFT} **Creation of service proxy** *[*The Communication Management shall provide a constructor for each specific ServiceProxy class taking a handle returned by any FindService method of the ServiceProxy class to get a valid ServiceProxy based on the handles returned by FindService.

explicit ServiceProxy::ServiceProxy(const HandleType &handle);

_♩(RS_CM_00102, RS_AP_00114, RS_AP_00121, RS_AP_00145)_

**[SWS_CM_10438]**{DRAFT} **Exception-less creation of service proxy** *[*The Communication Management shall provide a non-throwing constructor for each specific ServiceProxy class using the Named Constructor idiom according to [[SWS_CM_11326](#_bookmark520)]. The Named Constructor shall be called Create() and shall take a handle returned by any FindService method of the ServiceProxy class as argument.

static ara::core::Result\<ServiceProxy\> Create( const HandleType &handle) noexcept;

In case the handle returned from FindService is corrupt, an error code kErroneousFileHandle shall be returned in the Result.

In case of a Grant enforcement failure, an error code ComErrc::kGrantEnforcementError shall be returned in the Result. See [[SWS_CM_90006](#_bookmark294)].

_♩(RS_CM_00102, RS_AP_00114, RS_AP_00121, RS_AP_00139, RS_AP_00128, RS_AP_00132, RS_AP_00127, RS_AP_00139, RS_AP_00145)_

**[SWS_CM_10383]**{DRAFT} **GetHandle function to return the proxy instance creation handle** *[*The Communication Management shall provide a GetHandle method for each specific ServiceProxy class to get the handle from which the ServiceProxy instance has been created.

HandleType ServiceProxy::GetHandle() const;

_♩(RS_CM_00107, RS_AP_00114, RS_AP_00119)_

See [[SWS_CM_00312](#_bookmark471)] for the type definition of HandleType.

**[SWS_CM_00021]**{DRAFT} **Re-entrancy and thread-safety GetHandle** *[*GetHandle shall be re-entrant and thread-safe irrespective of the ServiceProxy class instance. i.e. GetHandle shall be re-entrant and thread-safe for the same ServiceProxy class instance and for _different_ ServiceProxy class instances._♩ (RS_CM_00107, RS_AP_00114, RS_AP_00119)_

**[SWS_CM_00136]**{DRAFT} **Copy semantics of service proxy class** *[*The Communication Management shall disable the generation of the copy constructor and the copy assignment operator for each specific ServiceProxy class.

ServiceProxy(const ServiceProxy&) = delete; ServiceProxy& operator=(const ServiceProxy&) = delete;

_♩(RS_CM_00102, RS_AP_00114, RS_AP_00145, RS_AP_00147)_

**[SWS_CM_00137]**{DRAFT} **Move semantics of service proxy class** *[*The Communication Management shall provide the possibility to move construct and move assign a ServiceProxy instance from another instance.

ServiceProxy(ServiceProxy &&); ServiceProxy& operator=(ServiceProxy &&);

_♩(RS_CM_00102, RS_AP_00114, RS_AP_00145, RS_AP_00147)_

**[SWS_CM_00821]**{DRAFT} **Service location scenarios** *[*Service proxy creation shall react according to the location of the service provided by the handle type class information, these scenarios are:

- The found service is located on a different node on the network
- The found service is located within a different application on the same node (within the same AP infrastructure)
- The found service is located within the same process and allow multiple scenarios at the same time.

_♩()_

### Service event subscription

For the functional description of the service event subscription API, see chapter [7.9.10](#service-event-subscription).

**[SWS_CM_00141] Method to subscribe to a service event** *[*Inside the specific Event class belonging to the specific ServiceProxy class a Subscribe method shall be provided to start subscription of the corresponding event. As input parameter the cacheSize of the subscription needs to be specified.

ara::core:Result\<void\> Event::Subscribe( std::size_t maxSampleCount

);

If the Event is already subscribed to at the time of the call, and the provided maxSampleCount value is the same as for the current subscription, Subscribe() shall return silently without any action.

If the Event is already subscribed to at the time of the call, and the provided maxSampleCount value is different from the value for the current subscription, Subscribe () shall return the error code ComErrc::kMaxSampleCountNotRealizable in the Result._♩(RS_CM_00103, RS_AP_00114, RS_AP_00120)_

**[SWS_CM_00022]**{DRAFT} **Re-entrancy and thread-safety Subscribe** *[*Subscribe shall be re-entrant and thread-safe for _different_ Event class instances. When called re-entrant or concurrently on the same Event class instance, the behavior is undefined._♩(RS_CM_00103, RS_AP_00114, RS_AP_00120)_

**[SWS_CM_00151] Method to unsubscribe from a service event** *[*Inside the specific Event class belonging to the specific ServiceProxy class a Unsubscribe method shall be provided to allow for unsubscribing from previously subscribed events.

void Event::Unsubscribe();

If the Event is not subscribed to at the time of the call, Unsubscribe() shall return silently without any action._♩(RS_CM_00104, RS_AP_00114, RS_AP_00120)_

**[SWS_CM_00023]**{DRAFT} **Re-entrancy and thread-safety Unsubscribe** *[*Unsubscribe shall be re-entrant and thread-safe for _different_ Event class instances. When called re-entrant or concurrently on the same Event class instance, the behavior is undefined._♩(RS_CM_00104, RS_AP_00114, RS_AP_00120)_

**[SWS_CM_00316] Query Subscription State** *[*The Communication Management shall provide an API GetSubscriptionState which returns the subscription state of an event. The conditions for the Subscription state being returned by GetSubscriptionState shall be the same as for the SubscriptionStateChangeHandler described in [[SWS_CM_00311](#_bookmark483)], [[SWS_CM_00313](#_bookmark425)] and [[SWS_CM_00314](#_bookmark426)].

1 ara::com::SubscriptionState GetSubscriptionState() const;

_♩(RS_CM_00106, RS_AP_00114, RS_AP_00115, RS_AP_00120, RS_AP_00119)_

**[SWS_CM_00024]**{DRAFT} **Re-entrancy and thread-safety GetSubscriptionState** *[*GetSubscriptionState shall be re-entrant and thread-safe for _different_ Event class instances. When called re-entrant or concurrently on the same Event class instance, the behavior is undefined._♩(RS_CM_00106, RS_AP_00114, RS_AP_00115, RS_AP_00120, RS_AP_00119)_

### [SWS_CM_00333] Set Subscription State change handler _[_

The Communication Management shall provide an API SetSubscriptionStateChangeHandler to give the possibility to set a subscription state change handler.

1 ara::core::Result\<void\> SetSubscriptionStateChangeHandler(ara::com:: SubscriptionStateChangeHandler handler);

_♩(RS_CM_00106, RS_AP_00114, RS_AP_00120, RS_AP_00121)_

**[SWS_CM_11354]**{DRAFT} **Execution Context for setting Subscription State change handler** *[*For the SetSubscriptionStateChangeHandler method described in [[SWS_CM_00333](#sws_cm_00333-set-subscription-state-change-handler)] a second overload with an additional input parameter shall be provided. This parameter shall provide an executioner object in which any asynchronous computation spawn by SetSubscriptionStateChangeHandler shall be invoked. The minimum behavior of the Execution Context is defined in [[SWS_CM_11364](#_bookmark34)].

template\<typename ExecutorT\>

ara::core::Result\<void\> SetSubscriptionStateChangeHandler( ara::com::SubscriptionStateChangeHandler handler, ExecutorT&& executor);

For the first overload without an execution context argument an implementation defined default execution context (like in previous AUTOSAR releases) shall be used._♩ (RS_CM_00211, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP_00127, RS_AP_00138)_

**[SWS_CM_11355]**{DRAFT} **Error behaviour of provided Execution Context for setting Subscription State change handler** *[*In case a SetSubscriptionStateChangeHandler() cannot be executed with the provided executor (e.g. because of resource problem) an ComErrc::kCouldNotExecute error shall be raised in all cases._♩(RS_CM_00211, RS_CM_00212, RS_CM_00213, RS_CM_00214, RS_AP_00114, RS_AP_00119, RS_AP_00127)_

**[SWS_CM_00025]**{DRAFT} **Re-entrancy and thread-safety SetSubscriptionStateChangeHandler** *[*SetSubscriptionStateChangeHandler shall be reentrant and thread-safe for _different_ Event class instances. When called re-entrant or concurrently on the same Event class instance, the behavior is undefined._♩(RS_CM_00106, RS_AP_00114, RS_AP_00120, RS_AP_00121)_

**[SWS_CM_00334] Unset Subscription State change handler** *[*The Communication Management shall provide an API UnsetSubscriptionStateChangeHandler to give the possibility to unset the subscription state change handler.

1 void UnsetSubscriptionStateChangeHandler();

_♩(RS_CM_00106, RS_AP_00114, RS_AP_00120)_

**[SWS_CM_00026]**{DRAFT} **Re-entrancy and thread-safety UnsetSubscriptionStateChangeHandler** *[*UnsetSubscriptionStateChangeHandler shall be re-entrant and thread-safe for _different_ Event class instances. When called reentrant or concurrently on the same Event class instance, the behavior is undefined._♩ (RS_CM_00106, RS_AP_00114, RS_AP_00120)_

### Receive event

For the functional description of the event receiving API, see chapter [7.9.11](#receive-event).

Inside the specific Event class belonging to the specific ServiceProxy class, a GetNewSamples and a GetFreeSampleCount method shall be provided to allow for access of received events.

**[SWS_CM_00701] Method to update the event cache** *[*The Communication Management shall provide an GetNewSamples method as part of the Event class to update the event cache with the meanwhile received data samples. As input parameters the GetNewSamples method expects a Callable f and allows to specify a maxNumberOfSamples to restrict the number of received data samples being processed in this call.

template \<typename F\> ara::core::Result\<std::size_t\> GetNewSamples(

F&& f,

std::size_t maxNumberOfSamples = std::numeric_limits\<std::size_t\>::max());

_♩(RS_CM_00202, RS_AP_00114, RS_AP_00120, RS_AP_00121, RS_AP_00139, RS_AP_00128, RS_AP_00127, RS_AP_00139)_

**[SWS_CM_00702] Signature of Callable f** *[*The user provided Callable f has to comply with the following signature:

void(ara::com::SamplePtr\<SampleType const\>)

For the definition of the types used in the signature of f, see:

- [[SWS_CM_00306](#_bookmark478)] for SamplePtr.

_♩(RS_CM_00202, RS_AP_00114)_

**[SWS_CM_00704]**{DRAFT} **Return Value** *[*The returned ara::core::Result either contains a

- size_t indicating the total number of data samples passed to f in the context of the GetNewSamples call.

or

- a ara::core::ErrorCode (see [SWS_CORE_00501]) where the error domain is set to ara::com::ComErrorDomain with the value kMaxSamplesExceeded indicating, that applications SamplePtrs count has been exceeded. This means that all SamplePtrs are currently held by the application and no more samples can be delivered.

_♩(RS_CM_00202, RS_AP_00114, RS_AP_00119, RS_AP_00127)_

Note: This means that maxSampleCount, which is given in the Subscribe() method is exceeded

**[SWS_CM_11358]**{DRAFT} **Execution Context to update the event cache** *[*For the GetNewSamples method described in [[SWS_CM_00701](#_bookmark570)] a second overload with an additional input parameter shall be provided. This parameter shall provide an executioner object in which any asynchronous computation spawn by GetNewSamples shall be invoked. The minimum behavior of the Execution Context is defined in [[SWS_CM_11364](#_bookmark34)].

template \<typename F, typename ExecutorT\>

ara::core::Result\<std::size_t\> GetNewSamples(F&& f, ExecutorT&& executor, std::s

For the first overload without an execution context argument an implementation defined default execution context (like in previous AUTOSAR releases) shall be used._♩ (RS_CM_00211, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP_00127, RS_AP_00138)_

**[SWS_CM_11359]**{DRAFT} **Error behaviour of provided Execution Context to update the event cache** *[*In case a GetNewSamples() cannot be executed with the provided executor (e.g. because of resource problem) an ComErrc::kCouldNotExecute error shall be raised in all cases._♩(RS_CM_00211, RS_CM_00212, RS_CM_00213, RS_CM_00214, RS_AP_00114, RS_AP_00119, RS_AP_00127)_

**[SWS_CM_00714] Re-entrancy and thread-safety GetNewSamples** *[*GetNewSamples shall be re-entrant and thread-safe for _different_ Event class instances. When called re-entrant or concurrently on the same Event class instance, the behavior is undefined. (If required, the application shall implement the locks)._♩ (RS_CM_00202, RS_AP_00114)_

**[SWS_CM_00705] Query Free Sample Slots** *[*The Communication Management shall provide a GetFreeSampleCount method as part of the Event class to query the number of free/unused slots for event sample data.

std::size_t GetFreeSampleCount() const noexcept;

_♩(RS_CM_00202, RS_AP_00114, RS_AP_00120, RS_AP_00139, RS_AP_00128, RS_AP_00132, RS_AP_00127, RS_AP_00139)_

**[SWS_CM_00706] Return Value of GetFreeSampleCount** *[*The returned size*t indicates the number of free/unused slots for event sample data in the local cache.*♩ (RS*CM_00202, RS_AP_00114, RS_AP_00119, RS_AP_00139, RS_AP_00128, RS_AP_00127)*

**[SWS_CM_00027]**{DRAFT} **Re-entrancy and thread-safety GetFreeSampleCount** *[*GetFreeSampleCount shall be re-entrant and thread-safe irrespective of the Event class instance i.e. GetFreeSampleCount shall be re-entrant and thread-safe for the same Event class instance and for _different_ Event class instances._♩(RS_CM_00202, RS_AP_00114, RS_AP_00120, RS_AP_00139, RS_AP_00128, RS_AP_00132, RS_AP_00127, RS_AP_00139)_

### Receive event by getting triggered

For the functional description of the receive event by getting triggered API, see chapter [7.9.11.2](#receive-event-by-getting-triggered).

**[SWS_CM_00181]**{DRAFT} **Enable service event trigger** *[*To enable that applications get triggered upon receiving of an event inside the specific Event class belonging to the specific ServiceProxy class a SetReceiveHandler method shall be provided to allow for specifying the function to call upon event arrival. Therefore, it takes as input parameter handler a pointer to the respective function.

ara::core::Result\<void\> Event::SetReceiveHandler( ara::com::EventReceiveHandler handler);

The EventReceiveHandler constitutes a function without parameters and has to use the GetNewSamples method of the specific Event class to access the retrieved event data. See [[SWS_CM_00309](#_bookmark481)] for its definition.

In case SetReceiveHandler() fails, ComErrc::kSetHandlerNotSet shall be returned in the Result._♩(RS_CM_00203, RS_AP_00114, RS_AP_00120, RS_AP_00121)_

**[SWS_CM_11356]**{DRAFT} **Execution Context for enabling service event trigger** *[*For the SetReceiveHandler method described in [[SWS_CM_00181](#_bookmark573)] a second overload with an additional input parameter shall be provided. This parameter shall provide an executioner object in which any asynchronous computation spawn by SetReceiveHandler shall be invoked. The minimum behavior of the Execution Context is defined in [[SWS_CM_11364](#_bookmark34)].

template\<typename ExecutorT\> ara::core::Result\<void\> Event::SetReceiveHandler(

ara::com::EventReceiveHandler handler, ExecutorT&& executor);

For the first overload without an execution context argument an implementation defined default execution context (like in previous AUTOSAR releases) shall be used._♩ (RS_CM_00211, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP_00127, RS_AP_00138)_

**[SWS_CM_11357]**{DRAFT} **Error behaviour of provided Execution Context for enabling service event trigger** *[*In case a SetReceiveHandler() cannot be executed with the provided executor (e.g. because of resource problem) an ComErrc::kCouldNotExecute error shall be raised in all cases._♩(RS*CM_00211, RS_CM_00212, RS_CM_00213, RS_CM_00214, RS_AP_00114, RS_AP_00119, RS_AP*-_

_00127)_

**[SWS_CM_00028]**{DRAFT} **Re-entrancy and thread-safety SetReceiveHandler** *[*SetReceiveHandler shall be re-entrant and thread-safe for _different_ Event class instances. When called re-entrant or concurrently on the same Event class instance, the behavior is undefined._♩(RS_CM_00203, RS_AP_00114, RS_AP_00120, RS_AP_00121)_

**[SWS_CM_00183]**{DRAFT} **Disable service event trigger** *[*To disable the triggering of the application upon receiving of an event inside the specific Event class belonging to the specific ServiceProxy class an UnsetReceiveHandler method shall be provided to allow for disabling of triggering the application.

ara::core::Result\<void\> Event::UnsetReceiveHandler();

In case UnsetReceiveHandler() fails, ComErrc::kUnsetFailure shall be returned in the Result.

_♩(RS_CM_00203, RS_AP_00114, RS_AP_00120)_

**[SWS_CM_00029]**{DRAFT} **Re-entrancy and thread-safety UnsetReceiveHandler** *[*UnsetReceiveHandler shall be re-entrant and thread-safe for _different_ Event class instances. When called re-entrant or concurrently on the same Event class instance, the behavior is undefined._♩(RS_CM_00203, RS_AP_00114, RS_AP_00120)_

### Service Trigger subscription

For the functional description of the service trigger subscription API, see chapter [7.9.12](#service-trigger-subscription).

**[SWS_CM_00723]**{DRAFT} **Method to subscribe to a service trigger** *[*Inside the specific Trigger class belonging to the specific ServiceProxy class a Subscribe method shall be provided to start subscription of the corresponding trigger.

ara::core::Result\<void\> Trigger::Subscribe();

If the Trigger is already subscribed to at the time of the call, and Subscribe() is invoked, it shall return silently without any action._♩(RS_CM_00103, RS_AP_00114, RS_AP_00120)_

**[SWS_CM_00724]**{DRAFT} **Re-entrancy and thread-safety Subscribe** *[*Subscribe shall be re-entrant and thread-safe for different Trigger class instances. When called re-entrant or concurrently on the same Trigger class instance, the behavior is undefined._♩(RS_CM_00103, RS_AP_00114, RS_AP_00120)_

**[SWS_CM_00810]**{DRAFT} **Method to unsubscribe from a service trigger** *[*Inside the specific Trigger class belonging to the specific ServiceProxy class a Unsubscribe method shall be provided to allow for unsubscribing from previously subscribed triggers.

void Trigger::Unsubscribe();

If the Trigger is not subscribed to at the time of the call, Unsubscribe() shall return silently without any action._♩(RS_CM_00104, RS_AP_00114, RS_AP_00120)_

**[SWS_CM_00035]**{DRAFT} **Re-entrancy and thread-safety Unsubscribe** *[*Unsubscribe shall be re-entrant and thread-safe for different Trigger class instances. When called re-entrant or concurrently on the same Trigger class instance, the behavior is undefined._♩(RS_CM_00104, RS_AP_00114, RS_AP_00120)_

### Receive Trigger

For the functional description of the trigger receiving API, see chapter [7.9.13](#receive-trigger).

Inside the specific Trigger class belonging to the specific ServiceProxy class, a

GetNewTriggers method shall be provided to allow for access of received triggers.

**[SWS_CM_00226]**{DRAFT} **Method to update the trigger counter** *[*The Communication Management shall provide an GetNewTriggers method as part of the Trigger class to update the trigger counter.

std::size_t GetNewTriggers();

_♩(RS_CM_00202, RS_AP_00114, RS_AP_00120, RS_AP_00121, RS_AP_00139, RS_AP_00128, RS_AP_00127, RS_AP_00139)_

**[SWS_CM_00228]**{DRAFT} **Return Value** *[*The returned size*t indicates the number of triggers occurred since the last call to GetNewTriggers (Zero value means that there is no new triggers received).*♩(RS*CM_00202, RS_AP_00114, RS_AP_00119, RS_AP_00127)*

**[SWS_CM_11251]**{DRAFT} **Re-entrancy and thread-safety GetNewTriggers** *[*GetNewTriggers shall be re-entrant and thread-safe for different Trigger class instances. When called concurrently on the same Trigger class instance, the behavior is undefined._♩(RS_CM_00202, RS_AP_00114)_

### Receive trigger by getting triggered

For the functional description of the receive trigger by getting triggered API, see [[SWS_CM_00182](#_bookmark431)] and chapter [7.9.13.1](#receive-trigger-by-getting-triggered).

**[SWS_CM_00249]**{DRAFT} **Enable service Trigger trigger** *[*To enable that applications get triggered upon receiving of a trigger inside the specific Trigger class

belonging to the specific ServiceProxy class a SetReceiveHandler method shall be provided to allow for specifying the function to call upon trigger arrival. Therefore, it takes as input parameter handler a pointer to the respective function.

ara::core::Result\<void\> Trigger::SetReceiveHandler( ara::com::TriggerReceiveHandler handler);

The TriggerReceiveHandler constitutes a function without parameters and has to use the GetNewTriggers method of the specific Trigger class to access the retrieved trigger counter. See [[SWS_CM_00351](#_bookmark485)] for its definition. In case SetReceiveHandler() fails, ComErrc::kSetHandlerNotSet shall be returned in the Result._♩(RS_CM_00203, RS_AP_00114, RS_AP_00120, RS_AP_00121)_

### Call a service method

For the functional description of the call a service method API, see chapter [7.9.14](#call-a-service-method).

**[SWS_CM_00196]**{DRAFT} **Initiate a method call** *[*For each service method (i.e., ServiceInterface.method with ClientServerOperation.fireAndForget set to false) of a ServiceInterface a specific Method class named by the ServiceInterface.method.shortName shall be provided inside the specific ServiceProxy class of the ServiceInterface.

Within this Method class, a dedicated method Output type combining the possible output parameters (ClientServerOperation.arguments with ArgumentDataPrototype.direction set to out or inout) shall be provided.

Additionally the operator() shall be provided inside the specific Method class to allow the call of a method provided by a server.

As input parameters, the operator() shall take the respective input parameters ( ClientServerOperation.arguments with ArgumentDataPrototype.direction set to in or inout) of the provided method.

The operator() shall return an ara::core::Future object wrapping the dedicated method Output type.

class Method { struct Output {

TypeOutputParameter1 output1; TypeOutputParameter2 output2;

\...

};

ara::core::Future\<Output\> operator()( TypeInputParameter1 input1, TypeInputParameter2 input2,

\...

);

};

_♩(RS_CM_00212, RS_CM_00213, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP_00127, RS_AP_00138)_

The method call according to [[SWS_CM_00196](#_bookmark586)] will return immediately. The caller's selection of a synchronous or asynchronous behavior to get the method output is achieved by the use of the returned ara::core::Future object which is used to query for method completion and result including possible error.

**[SWS_CM_00032]**{DRAFT} **Re-entrancy and thread-safety Method call operator** *[*operator() shall be re-entrant and thread-safe irrespective of the Method class instance i.e. operator() shall be re-entrant and thread-safe for the same Method class instance and for _different_ Method class instances._♩(RS*CM_00212, RS_CM_00213, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP*-_

_00127, RS_AP_00138)_

**[SWS_CM_90435]**{DRAFT} **Initiate a Fire and Forget method call** *[*For each fire and forget service method (i.e., ServiceInterface.method with ClientServerOperation.fireAndForget set to true) of a ServiceInterface a specific FireAndForgetMethod class named by the ServiceInterface. method.shortName shall be provided inside the specific ServiceProxy class of the ServiceInterface.

Within this FireAndForgetMethod class, the operator() shall be provided to allow the call of a fire and forget method provided by a server.

As input parameters, the operator() shall take the respective input parameters ( ClientServerOperation.arguments with ArgumentDataPrototype.direction set to in) of the provided fire and forget method.

The operator() shall not have return values.

class FireAndForgetMethod { void operator()(

TypeInputParameter1 input1, TypeInputParameter2 input2,

\...

);

};

_♩(RS_CM_00225, RS_AP_00114, RS_AP_00120)_

### Get method for fields

**[SWS_CM_00112] Method to get the value of a field** *[*The Communication Management shall provide a Get method as part of the Field class to offer a service to request the current value of the service provider.

ara::core::Future\<FieldType\> Get();

_♩(RS_CM_00218, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP_00127, RS_AP_00138)_

**[SWS_CM_00132]**{DRAFT} **Existence of getter method** *[*The existence of the Get method as part of the Field class shall be controlled by Field.hasGetter._♩(RS_CM_00218, RS_AP_00114)_

**[SWS_CM_00030]**{DRAFT} **Re-entrancy and thread-safety Get** *[*Get shall be reentrant and thread-safe irrespective of the Field class instance i.e. Get shall be reentrant and thread-safe for the same Field class instance and for _different_ Field class instances._♩(RS_CM_00218, RS_AP_00114, RS_AP_00120, RS_AP_00138, RS_AP_00128, RS_AP_00127, RS_AP_00138)_

### Set method for fields

**[SWS_CM_00113] Method to set the value of a field** *[*The Communication Management shall provide a Set method as part of the Field class to offer a service to the applications to request the setting of a new value within the service provider.

ara::core::Future\<FieldType\> Set(const FieldType& value);

_♩(RS_CM_00217, RS_AP_00114, RS_AP_00120, RS_AP_00121, RS_AP_00138, RS_AP_00138, RS_AP_00127, RS_AP_00138)_

**[SWS_CM_00133]**{DRAFT} **Existence of the set method** *[*The existence of the set method as part of the Field class shall be controlled by Field.hasSetter._♩(RS_CM_00218, RS_AP_00114)_

**Note:** There is no need to have Get method itself return [Application Errors] errors when getting a field value (as there are no errors possible when getting a field value). The Set-Method may return [Application Errors], but does so via returning a value different from the one passed in the request parameter.

**[SWS_CM_00031]**{DRAFT} **Re-entrancy and thread-safety Set** *[*Set shall be reentrant and thread-safe irrespective of the Field class instance i.e. Set shall be reentrant and thread-safe for the same Field class instance and for _different_ Field class instances._♩(RS_CM_00217, RS_AP_00114, RS_AP_00120, RS_AP_00121, RS_AP_00138, RS_AP_00138, RS_AP_00127, RS_AP_00138)_

### Instance Specifier Translation

For the functional description of the Instance Specifier Translation API, see chapter [7.9.16](#instance-specifier-translation).

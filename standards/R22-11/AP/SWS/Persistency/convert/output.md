# Contents

```
1. Introduction and Functional Overview 9
2. Acronyms and Abbreviations 10
3. Related Documentation 12

   1. Input Documents & Related Standards and Norms 12
   2. Further Applicable Specifications 12
4. [Constraints and Assumptions](#constraints-and-assumptions) 13

   1. [Known Limitations](#known-limitations) 13
   2. [Constraints on Configuration](#constraints-on-configuration) 13
   3. [Direct Access to Storage Hardware](#direct-access-to-storage-hardware) 13
5. [Dependencies to Other Functional Clusters](#dependencies-to-other-functional-clusters) 14

   1. [Protocol Layer Dependencies](#protocol-layer-dependencies) 14
6. Requirements Tracing 15
7. [Functional Specification](#functional-specification) 28

   1. [The Architecture of Persistency](#the-architecture-of-persistency) 28

      1. [Persistency in the Manifest](#persistency-in-the-manifest) 28
      2. [Key-Value Storages in the Manifest](#key-value-storages-in-the-manifest) 30
      3. [File Storages in the Manifest](#file-storages-in-the-manifest) 30
   2. [General Features of Persistency](#general-features-of-persistency) 32

      1. [Functional Cluster Lifecycle](#functional-cluster-lifecycle) 32

         1. [Initialization and Shutdown of Persistency](#initialization-and-shutdown-of-persistency) 32
      2. [Error Handling](#error-handling) 33

         1. [Handling of General Errors](#handling-of-general-errors) 33
      3. [Parallel Access to Persistent Data](#parallel-access-to-persistent-data) 36
      4. [Security Concepts](#security-concepts) 38
      5. [Redundancy Concepts](#redundancy-concepts) 41

         1. [Redundancy Types](#redundancy-types) 45
      6. [Installation and Update of Persistent Data](#installation-and-update-of-persistent-data) 48

         1. [Installation of Persistent Data](#installation-of-persistent-data) 51

            1. [Installation of Key-Value Storage](#installation-of-key-value-storage) 51
            2. [Installation of File Storage](#installation-of-file-storage) 52
         2. [Update of Persistent Data](#update-of-persistent-data) 53

            1. [Update of Key-Value Storage](#update-of-key-value-storage) 54
            2. [Update of File Storage](#update-of-file-storage) 56
         3. [Finalization of Persistent Data after Successful Update](#finalization-of-persistent-data-after-successful-update) 57
         4. [Roll-Back of Persistent Data after Failed Update](#roll-back-of-persistent-data-after-failed-update) 57
         5. [Removal of Persistent Data](#removal-of-persistent-data) 57
      7. [Resource Management Concepts](#resource-management-concepts) 59
   3. [Key-Value Storage specific Features](#key-value-storage-specific-features) 61

      1. [Supported Data Types in Key-Value Storages](#supported-data-types-in-key-value-storages) 63
   4. [File Storage specific Features](#file-storage-specific-features) 65

      1. [Access to Additional Information about Files](#access-to-additional-information-about-files) 70
8. [API Specification](#api-specification) 72

   1. [General Features of Persistency](#general-features-of-persistency-1) 72

      1. [ara::core Types](#aracore-types) 72
      2. Installation and Update of Persistent Data 73

         1. RegisterApplicationDataUpdateCallback 73
         2. UpdatePersistency 74
         3. ResetPersistency 75
      3. Redundancy Handling 76

         1. RecoveryReportKind 76
         2. RegisterRecoveryReportCallback 77
      4. Handle Classes 79

         1. SharedHandle Class 79

            1. SharedHandle::SharedHandle 79
            2. SharedHandle::operator= 80
            3. SharedHandle::operator bool 81
            4. SharedHandle::Operator-\81
            5. SharedHandle::Operator\* 82
         2. UniqueHandle Class 83

            1. UniqueHandle::UniqueHandle 83
            2. UniqueHandle::operator= 84
            3. UniqueHandle::operator bool 85
            4. UniqueHandle::Operator-\85
            5. UniqueHandle::Operator\* 86
      5. Errors 87

         1. PerErrc 87
         2. GetPerDomain 88
         3. MakeErrorCode 88
         4. PerException Class 89

            1. PerException::PerException 89
         5. PerErrorDomain Class 89

            1. PerErrorDomain::Errc 90
            2. PerErrorDomain::Exception 90
            3. PerErrorDomain::PerErrorDomain 91
            4. PerErrorDomain::Name 91
            5. PerErrorDomain::Message 91
            6. PerErrorDomain::ThrowAsException 92
   2. Key-Value Storage 93

      1. OpenKeyValueStorage 93
      2. RecoverKeyValueStorage 94
      3. ResetKeyValueStorage 95
      4. GetCurrentKeyValueStorageSize 96
      5. KeyValueStorage Class 96

         1. KeyValueStorage::KeyValueStorage 97
         2. KeyValueStorage::operator= 98
         3. KeyValueStorage::\~KeyValueStorage 98
         4. KeyValueStorage::GetAllKeys 99
         5. KeyValueStorage::KeyExists 99
         6. KeyValueStorage::GetCurrentValueSize 100
         7. KeyValueStorage::GetValue 101
         8. KeyValueStorage::SetValue 102
         9. KeyValueStorage::RemoveKey 103
         10. KeyValueStorage::RecoverKey 104
         11. KeyValueStorage::ResetKey 105
         12. KeyValueStorage::RemoveAllKeys 106
         13. KeyValueStorage::SyncToStorage 107
         14. KeyValueStorage::DiscardPendingChanges 107
   3. File Storage 109

      1. OpenFileStorage 109
      2. RecoverAllFiles 110
      3. ResetAllFiles 111
      4. GetCurrentFileStorageSize 112
      5. OpenMode 112
      6. operator\| for FileStorage::OpenMode 113
      7. operator\|= for FileStorage::OpenMode 113
      8. FileCreationState 114
      9. FileModificationState 114
      10. FileInfo 115

          1. FileInfo.creationTime 115
          2. FileInfo.modificationTime 115
          3. FileInfo.accessTime 116
          4. FileInfo.fileCreationState 116
          5. FileInfo.fileModificationState 116
      11. FileStorage Class 117

          1. FileStorage::FileStorage 117
          2. FileStorage::operator= 118
          3. FileStorage::\~FileStorage 118
          4. FileStorage::GetAllFileNames 119
          5. FileStorage::DeleteFile 119
          6. FileStorage::FileExists 120
          7. FileStorage::RecoverFile 121
          8. FileStorage::ResetFile 122
          9. FileStorage::GetCurrentFileSize 123
          10. FileStorage::GetFileInfo 123
          11. FileStorage::OpenFileReadWrite 124
          12. FileStorage::OpenFileReadOnly 127
          13. FileStorage::OpenFileWriteOnly 129
      12. Origin 132
      13. ReadAccessor Class 132

          1. ReadAccessor::ReadAccessor 133

```

4. # Constraints and Assumptions

5. ## Known Limitations

- Although a Key-Value Storage and File Storage can be configured as write-only, the current API always allows read access. Read access is even possible when a file has been opened with ara::per::FileStorage::OpenFileWriteOnly.

6. ## Constraints on Configuration

There are several constraints on the Persistency configuration that need to be observed by the tooling which creates/processes this part of the Execution Manifest. These constraints are defined in [3].

## Direct Access to Storage Hardware

Modern embedded controllers use flash memory and similar hardware to store data. These devices have the intrinsic problem that the signal that can be read from each memory cell is reduced over time, mainly influenced by the number of write accesses. In the end, the cell will produce arbitrary values on each read access.

Unfortunately, the distribution of write accesses in typical systems is very uneven. Some parameters might be updated a few times a second, while some code may stay untouched for the whole life time of the ECU. To avoid early read errors, wear leveling should be deployed, such that frequent updates of single data elements are distributed over the whole memory area.

On the other hand, most operating systems include a file system or at least a flash driver that takes care of wear leveling, such that a typical implementation of the Persistency will not have to care about the wear leveling. This use case is therefore not described in any detail in this specification.

5. # Dependencies to Other Functional Clusters

   1. ## Protocol Layer Dependencies

The Persistency is (at least partially) compiled as part of an Executable of an Adaptive Application, and therefore also executed as part of a Process, which creates an implicit dependency on the Execution Management [4].

For the implementation of redundancy and security purposes, the Persistency accesses services of the Cryptography [5].

For the installation, update, and deletion of persisted data, the Persistency interacts with the Update and Configuration Management [6].

7. # Functional Specification

   1. ## The Architecture of Persistency

The Persistency offers two different mechanisms to access persistent memory: Key-Value Storages offer access to a set of keys with associated values (similar to a database), while File Storages offer access to a set of files (similar to a directory of a file system).

The typical usage of the Persistency within an Adaptive Application is depicted in [Figure](#_bookmark8) [7.1](#_bookmark8). As shown there, an Adaptive Application can use a combination of multiple Key-Value Storages and multiple File Storages. Of course, the same applies to other functional clusters using Persistency.

![](./media/image1.png)

**Figure 7.1:** []{#\_bookmark8 .anchor}**Typical usage of Persistency within an Adaptive Application**

Persistency can also be used directly by other Functional Clusters without involvement of the application. The library part of these Functional Clusters will use dedicated deployment information of Persistency, while Daemons of Functional Clusters can be modeled similarly to Adaptive Applications.

### Persistency in the Manifest

The Persistency usage of an Adaptive Application is modeled in the Execution Manifest (furtheron simply referred to as the "manifest") as part of the

AdaptiveApplicationSwComponentTypes of an Executable. The model has two principal parts: The application design information, aggregated by the PersistencyKeyValueStorageInterface and the PersistencyFileStorageInterface, and the deployment information, aggregated by the PersistencyKeyValueStorage and the PersistencyFileStorage. The latter is also used when the Persistency is accessed directly by another Functional Cluster.

The API specification holds the classes ara::per::KeyValueStorage and ara::per::FileStorage for access to a Key-Value Storage or a File Storage, respectively. The global functions of these classes receive either the identifier (the fully qualified shortName path) of a PortPrototype typed by a PersistencyInterface, or the shortName path of a FunctionalClusterInteractsWithPersistencyDeploymentMapping. Both are then used as an ara::core::InstanceSpecifier input parameter (see subsection 8.2.1 and subsection 8.3.1). Depending on the nature of the PortPrototype or on the value of FunctionalClusterInteractsWithPersistencyDeploymentMapping.persistencyAccess, the Key-Value Storage or File Storage will be accessible as:

**Read Only** if the PortPrototype is instantiated as RPortPrototype or FunctionalClusterInteractsWithPersistencyDeploymentMapping. persistencyAccess is read, or

**Read/Write** if the PortPrototype is instantiated as PRPortPrototype or FunctionalClusterInteractsWithPersistencyDeploymentMapping. persistencyAccess is readWrite, or

**Write Only** if the PortPrototype is instantiated as PPortPrototype or FunctionalClusterInteractsWithPersistencyDeploymentMapping. persistencyAccess is write.

In case of application access to Persistency, the manifest contains separate deployment data for each Process that references the Executable. The Process is bound to the deployment data by specialization of the class PersistencyPortPrototypeToDeploymentMapping, which refers to a PortPrototype typed by a PersistencyInterface, a PersistencyDeployment, and the Process.

### Key-Value Storages in the Manifest

Every Key-Value Storage is either represented by a PortPrototype typed by a PersistencyKeyValueStorageInterface in the application design for the respective AdaptiveApplicationSwComponentType, or by a FunctionalClusterInteractsWithPersistencyDeploymentMapping, and in both cases by a PersistencyKeyValueStorage containing deployment information. Every Key-

-Value Storage can hold multiple key-value pairs. Key-value pairs can be added and removed at run-time by the Adaptive Application or Functional Cluster using the Persistency API (see subsubsection 8.2.5.8 and subsubsection 8.2.5.9).

A Key-Value Storage with predefined key-value pairs can be deployed with default data during installation or update of an Adaptive Application or Functional Cluster. This operation is (indirectly) triggered by the Update and Configuration Management [6] during installation or update using the deployment information and data provided by the software package of the Adaptive Application or Functional Cluster. See [subsection](#installation-and-update-of-persistent-data) [7.2.6](#installation-and-update-of-persistent-data).

The link between application design and deployment information of a Key-

-Value Storage is represented by PersistencyPortPrototypeToKeyValueStorageMapping, which refers to a PortPrototype typed by a PersistencyKeyValueStorageInterface, the corresponding PersistencyKeyValueStorage, and a Process.

### File Storages in the Manifest

Every File Storage is represented by a PortPrototype typed by a PersistencyFileStorageInterface in the application design for the respective AdaptiveApplicationSwComponentType, or by a FunctionalClusterInteractsWithPersistencyDeploymentMapping, and in both cases by a PersistencyFileStorage containing deployment information. Every File Storage can hold multiple files as described in [3]. Similar to the key-value pairs mentioned above, files can be created and deleted at run-time by the Adaptive Application or Functional Cluster using the Persistency API (see subsubsection 8.3.11.11, subsubsection 8.3.11.13, and subsubsection 8.3.11.5).

A File Storage with predefined files with initial content can be deployed during installation or update. This operation is also (indirectly) triggered by the Update and Configuration Management [6]. All needed deployment information

and files come with the software package of the Adaptive Application or

Functional Cluster. See [subsection](#installation-and-update-of-persistent-data) [7.2.6](#installation-and-update-of-persistent-data).

The link between application design and deployment information of a File Storage is represented by PersistencyPortPrototypeToFileStorageMapping, which refers to a PortPrototype typed by a PersistencyFileStorageInterface, the corresponding PersistencyFileStorage, and a Process.

## General Features of Persistency

**[SWS_PER_00002]** *[*All specified classes within the Persistency shall reside within the C++ namespace ara::per._♩(RS_AP_00115)_

1. ### Functional Cluster Lifecycle

   1. ### Initialization and Shutdown of Persistency

Using ara::core::Initialize and ara::core::Deinitialize, the application can start and shut down all functional clusters with direct ARA interfaces (i.e. the Adaptive Platform Foundation).

[]{#\_bookmark15 .anchor}**[SWS_PER_00408]** *[*When ara::core::Initialize is called, the Persistency

shall read in the manifest information and prepare the access structures to all Key-

-Value Storages and File Storages that are defined in the manifest._♩(RS_PER_00018)_

**[SWS_PER_00409]** *[*When ara::core::Deinitialize is called, the Persistency shall implicitly ensure that all open files of all File Storages are persisted as though ara::per::ReadWriteAccessor::SyncToFile was called and closed as though the ara::per::UniqueHandles were destructed, and that not persisted values in all Key-Value Storages are dropped as though ara::per::KeyValueStorage::DiscardPendingChanges was called. Afterwards, all access structures shall be freed._♩(RS_PER_00018)_

The application is expected not to call any API of Persistency (directly or indirectly through other functional clusters) before ara::core::Initialize or after ara::core::Deinitialize, but Persistency needs to protect itself against such eventualities.

[]{#\_bookmark16 .anchor}**[SWS_PER_00410]**{DRAFT} *[*All functions of Persistency and all methods of its classes shall call ara::core::Abort when they are called after static initialization but before ara::core::Initialize was called or after ara::core::Deinitialize was called._♩(RS_PER_00018)_

### Error Handling

Error handling in Persistency is aligned with the guidelines described in [2]. To this end, the Persistency has to implement a set of standard classes and APIs, which are described in this section.

**[SWS_PER_00472]** *[*Persistency shall use the error codes defined in ara::per::PerErrc to report problems to the calling application via ara::core::Result. Vendors of Persistency may add their own errors to ara::per::PerErrc, using codes above 255._♩(RS_AP_00128)_

ara::per::PerErrc belongs to the ara::per::PerErrorDomain, which can be used by an application to classify returned errors.

**[SWS_PER_00473]** *[*ara::per::GetPerDomain shall return the global ara::per::PerErrorDomain object._♩(RS_AP_00128)_

To create its own Persistency error codes, the application may use ara::per::MakeErrorCode.

**[SWS_PER_00474]** *[*ara::per::MakeErrorCode shall return an ara::core::ErrorCode when called with an error code from ara::per::PerErrc._♩(RS_AP_00128)_

> **[SWS_PER_00353]** *[*ara::per::PerErrorDomain::Name shall return the NULterminated string "Per"._♩(RS_AP_00128)_
>
> **[SWS_PER_00475]** *[*ara::per::PerErrorDomain::Message shall return the error message associated with the passed ara::core::ErrorCode._♩(RS_AP_00128)_

The whole Persistency API has been designed to be exception-less. If an application prefers to use exceptions, it may use ara::per::PerErrorDomain::ThrowAsException, or simply ara::core::ErrorCode::ThrowAsException.

**[SWS_PER_00476]** *[*ara::per::PerErrorDomain::ThrowAsException shall throw an ara::per::PerException that is created from the passed error code._♩ (RS_AP_00128)_

### Handling of General Errors

**[SWS_PER_00536]** *[*When a function or method of Persistency encounters a problem with the hardware or the underlaying operating system services during the access to a storage or an element of a storage, Persistency shall return the error kPhysicalStorageFailure._♩(RS_AP_00128)_

When kPhysicalStorageFailure occurs, the application cannot access the affected storage any more. Depending on the system, a reboot might restore the access.

**[SWS_PER_00537]** *[*When a method of Persistency would modify the underlying storage, but the storage is configured as read-only (the PortPrototype that is typed by the corresponding PersistencyInterface is instantiated as RPortPrototype), Persistency shall return the error kIllegalWriteAccess._♩(RS_AP_00128)_

**[SWS_PER_00538]** *[*When a function of Persistency is called with an ara::core::InstanceSpecifier that is not available in the manifest, Persistency shall return the error kStorageNotFound._♩(RS_AP_00128)_

The two previous errors (kIllegalWriteAccess and kStorageNotFound) occur when the configuration does not match the implemented access to a storage. An application might be implemented to be aware of this possibility and react accordingly to the error by avoiding (write) accesses to the storage. If the application depends on (write) access to the storage, these errors would hint at an incorrect configuration of the storage.

**[SWS_PER_00539]** *[*When a function or method of Persistency detects a fundamental problem in the structure of the storage that prevents accessing the storage, Persistency shall return the error kIntegrityCorrupted._♩(RS_AP_00128)_

The application can restore a corrupted storage by calling ara::per::RecoverKeyValueStorage, ara::per::ResetKeyValueStorage, ara::per::RecoverAllFiles, or ara::per::ResetAllFiles. When the kIntegrityCorrupted is reported for an element of a storage, integrity can be restored by calling ara::per::KeyValueStorage::RecoverKey, ara::per::KeyValueStorage::ResetKey, ara::per::FileStorage::RecoverFile, or ara::per::FileStorage::ResetFile.

When Persistency detects insufficient or broken redundancy, it will report kValidationFailed as described in [[SWS_PER_00221](#_bookmark22)].

**[SWS_PER_00540]** *[*When encryption or decryption of persistent data fails within a function or method of Persistency, Persistency shall return the error kEncryptionFailed._♩(RS_AP_00128)_

**[SWS_PER_00564]** *[*When the calculation or verification of the MAC of persistent data fails within a function or method of Persistency, Persistency shall return the error kAuthenticationFailed._♩(RS_AP_00128)_

The two previous errors can occur when the configured cryptographic keys or algorithms are not available at run time, or when the storage or the element of a storage is corrupted. The latter case could be detected or even avoided by configuring redundancy.

**[SWS_PER_00541]** *[*When a method of Persistency tries to read data from a file, but the position is already at the end, Persistency shall return the error kIsEof._♩ (RS_AP_00128)_

This error can typically be dealt with by the application, and can be avoided by using ara::per::ReadAccessor::IsEof.

**[SWS_PER_00542]** *[*When a function or method of Persistency would create a file, but the number of existing files already equals the configured PersistencyFileStorageInterface.maxNumberOfFiles of the corresponding File Storage, Persistency shall return the error kTooManyFiles._♩(RS_AP_00128)_

This error might occur when a new file is opened for writing, or when a File Storage is updated or when it is recovered after an error. An application seeing this error might delete some files to be able to create the new file (or files), or reset the File Storage to the initial state using ara::per::ResetAllFiles or ara::per::ResetPersistency.

**[SWS_PER_00543]** *[*When a function or method of Persistency would increase the size of a storage or an element of a storage such that the total storage size would exceed the configured PersistencyDeployment.maximumAllowedSize of the storage, Persistency shall return the error kQuotaExceeded._♩(RS_AP_00128)_

This error means that the application tried to store data that exceeds the configured quota of a storage. The application has to be able to deal with this situation, and either write less data to the affected storage or remove outdated data from this storage, or reset the affected element/storage with a call to ara::per::ResetKeyValueStorage, ara::per::ResetAllFiles, ara::per::KeyValueStorage::ResetKey, ara::per::FileStorage::ResetFile, or even ara::per::ResetPersistency.

**[SWS_PER_00544]** *[*When a function or method of Persistency cannot increase the size of a storage because the physical storage is not sufficient (e.g. file system quoata exceeded or partition full), Persistency shall return the error kOutOfStorageSpace._♩(RS_AP_00128)_

This error means that some other storage or even a completely independent process occupies so much physical storage that Persistency cannot store additional data. This can only happen if PersistencyDeployment.maximumAllowedSize is configured to a higher value than PersistencyDeployment.minimumSustainedSize. The application has to be able to deal with this situation, and either write less data to the affected storage or remove outdated data from this or another storage, or reset this or another element/storage with a call to ara::per::ResetKeyValueStorage, ara::per::ResetAllFiles, ara::per::KeyValueStorage::ResetKey, ara::per::FileStorage::ResetFile, or even ara::per::ResetPersistency.

### Parallel Access to Persistent Data

According to [9], the persistent data is local to one Process. Therefore, Persistency will never share persistent data between two (or more) Processes, even of the same Executable. The background of this decision is that Persistency should not provide an additional communication path for applications besides the mechanisms provided by the functional cluster Communication Management (e.g. using ara::com).

**[SWS_PER_00309]** *[*Persistent data shall always be local to one Process._♩_

> _(RS_PER_00001)_

If persistent data needs to be accessed by multiple Processes (of the same or different applications), it is the duty of the application designer to provide Service Interfaces for communication.

Persistency is, on the other hand, prepared to handle concurrent access from multiple threads of the same application, running in the context of the same Process. To create shared access to a Key-Value Storage or File Storage, either the ara::per::SharedHandle returned by ara::per::OpenKeyValueStorage and ara::per::OpenFileStorage can be passed on (i.e. copied) to another thread, or ara::per::OpenKeyValueStorage and ara::per::OpenFileStorage can be called in independent threads for the same Key-Value Storage or File Storage, respectively. All operations of the Key-Value Storage and File Storage support concurrent access from multiple threads, though operations like ara::per::RecoverKeyValueStorage and ara::per::ResetKeyValueStorage or ara::per::RecoverAllFiles and ara::per::ResetAllFiles will only succeed when the corresponding Key-Value Storage or File Storage is not opened.

**[SWS_PER_00545]** *[*When a function of Persistency that modifies a storage is called while another function that modifies the same storage is being executed, Persistency shall return the error kResourceBusy._♩(RS_AP_00128)_

This restriction also applies to global functions like ara::per::UpdatePersistency, which will only succeed if no storage is open, and no other thread is currently modifying a storage with functions like ara::per::RecoverKeyValueStorage or ara::per::ResetAllFiles.

Access to single key-value pairs of a Key-Value Storage is possible from multiple threads at the same time, because the operation of ara::per::KeyValueStorage::GetValue and ara::per::KeyValueStorage::SetValue are atomic, as are those of ara::per::KeyValueStorage::RemoveKey, ara::per::KeyValueStorage::RemoveAllKeys, ara::per::KeyValueStorage::SyncToStorage, and ara::per::KeyValueStorage::DiscardPendingChanges.

Access to single files of a File Storage cannot be shared between multiple threads, because it would be impossible to synchronize read and write accesses and the corresponding change of the seek position in a file. Accordingly, the ara::-

per::UniqueHandle returned by the OpenFile\* APIs can only be moved to another thread, and trying to open an already opened file will fail. Likewise, operations like ara::per::FileStorage::DeleteFile, ara::per::FileStorage::RecoverFile, and ara::per::FileStorage::ResetFile will also not be possible on open files.

**[SWS_PER_00546]** *[*When a method of ara::per::FileStorage that opens or modifies a file is called while the same file is currently open or being modified by another method, Persistency shall return the error kResourceBusy._♩(RS_AP_00128)_

Files are implicitly closed when their ara::per::UniqueHandle goes out of scope, or when the File Storage to which they belong is closed.

**[SWS_PER_00425]** *[*When a File Storage is closed, because all related ara::per::SharedHandles go out of scope, any files which are still open are also closed._♩(RS_PER_00001)_

Accessing a ara::per::UniqueHandle of a file of a closed File Storage will result in undefined behavior.

### Security Concepts

The Persistency supports protection of the authenticity and confidentiality of data stored in a Key-Value Storage or File Storage. Which kind of protection is applied and the used algorithms are decided at deployment time. The application is not aware of this fact.

If confidentiality of data shall be protected, a storage or an element of a storage are encrypted after the creation of the storage and when the storage is saved, and are decrypted when a storage is opened. Therefore, only encrypted data is stored persistently. In case of a read-only storage, encryption is done only once during installation, decryption is done every time the storage is opened.

If authenticity of data shall be protected, a message authentication code (MAC) is generated after the creation of a storage and when the storage is saved, and verified when the storage is opened. Therefore, unauthorized modifications to the storage can be detected.

In case of a read-only storage, it is also possible to protect the authenticity of the storage(or an element therein) by calculating a hash value of the data to be protected and comparing this calculated value to a hash value provided in the manifest. This assumes that the authenticity of the processed manifest is protected using other mechanisms (like secure boot).

If authenticity and confidentiality shall be protected, authenticated encryption schemes (like AES GCM) can be used.

**[SWS_PER_00210]** *[*If a PersistencyDeploymentToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentToCryptoKeySlotMapping.keySlotUsage is set to encryption, the Persistency shall encrypt all data related to the storage using the algorithm specified by PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString before storing it to the persistent memory._♩(RS_PER_00005, RS_PER_00010)_

**[SWS_PER_00464]** *[*If a PersistencyDeploymentElementToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentElementToCryptoKeySlotMapping.keySlotUsage is set to encryption, the Persistency shall encrypt the element data using the algorithm specified by PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString before storing it to the persistent memory._♩(RS_PER_00005, RS_PER_00010)_

**[SWS_PER_00211]** *[*If a PersistencyDeploymentToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentToCryptoKeySlotMapping.keySlotUsage is set to encryption, the Persistency shall decrypt all data related to the storage using the algorithm specified by PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString after reading it from persistent memory._♩(RS_PER_00005, RS_PER_00010)_

**[SWS_PER_00465]** *[*If a PersistencyDeploymentElementToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentElementTo-

CryptoKeySlotMapping.keySlotUsage is set to encryption, the Persistency shall decrypt the element data using the algorithm specified by PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString after reading it from persistent memory._♩(RS_PER_00005, RS_PER_00010)_

**[SWS_PER_00449]** *[*If a PersistencyDeploymentToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentToCryptoKeySlotMapping.keySlotUsage is set to verification, the Persistency shall create and store a message authentication code (MAC) for all data related to the storage using the algorithm specified by PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString when storing it to the persistent memory._♩(RS_PER_00005, RS_PER_00010)_

**[SWS_PER_00466]** *[*If a PersistencyDeploymentElementToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentElementToCryptoKeySlotMapping.keySlotUsage is set to verification, the Persistency shall create and store a message authentication code (MAC) for the element data using the algorithm specified by PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString when storing it to the persistent memory._♩(RS_PER_00005, RS_PER_00010)_

**[SWS_PER_00450]** *[*If a PersistencyDeploymentToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentToCryptoKeySlotMapping.keySlotUsage is set to verification, the Persistency shall verify the MAC of all data related to the storage using the algorithm specified by PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString after reading it from persistent memory._♩(RS_PER_00005, RS_PER_00010)_

**[SWS_PER_00467]** *[*If a PersistencyDeploymentElementToCryptoKeySlotMapping exists in the manifest, and PersistencyDeploymentElementToCryptoKeySlotMapping.keySlotUsage is set to verification, the Persistency shall verify the MAC of the element data using the algorithm specified by PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString after reading it from persistent memory._♩(RS_PER_00005, RS_PER_00010)_

**[SWS_PER_00451]** *[*If PersistencyDeploymentToCryptoKeySlotMapping. verificationHash is available, the Persistency shall calculate a hash value over all data related to the storage using the hash algorithm specified by PersistencyDeploymentToCryptoKeySlotMapping.cryptoAlgorithmString and verify that the calculated hash value matches PersistencyDeploymentToCryptoKeySlotMapping.verificationHash._♩(RS_PER_00005, RS_PER_00010)_

**[SWS_PER_00468]** *[*If PersistencyDeploymentElementToCryptoKeySlotMapping.verificationHash is available, the Persistency shall calculate a hash value over the element data using the hash algorithm specified by PersistencyDeploymentElementToCryptoKeySlotMapping.cryptoAlgorithmString and verify that the calculated hash value matches PersistencyDeployment-

ElementToCryptoKeySlotMapping.verificationHash._♩(RS_PER_00005, RS_PER_00010)_

The Persistency will use the services of the Cryptography [5] for all cryptographic operations.

### Redundancy Concepts

The Persistency shall take care of the integrity of the stored data, both for safety purposes and to prevent data loss. This can be achieved by calculating CRCs or hash values of the stored data, and by creating redundant copies. All these measures effectively create some redundancy for the stored data. The concrete measures to be taken are configurable: The application designer can use PersistencyInterface. redundancy to request redundancy (by setting it to redundant or redundantPerElement), or use PersistencyInterface.redundancyHandling to preselect the actual measures to be taken. During deployment, the integrator can define the actual measures taken to ensure data integrity using PersistencyDeployment.redundancyHandling. If PersistencyInterface.redundancyHandling is configured, the integrator shall use it as a guidance, but may also choose other, more appropriate measures based on superior knowledge of the final system.

**[SWS_PER_00317]** *[*The Persistency shall store redundant information for every storage represented by a PersistencyDeployment where PersistencyDeployment.redundancyHandling is configured._♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

The actual handling of the redundancy configured during deployment is described in the following sections, see also [[SWS_PER_00318](#_bookmark34)], [[SWS_PER_00319](#_bookmark35)], and [[SWS_PER_00447](#_bookmark36)].

[]{#\_bookmark22 .anchor}**[SWS_PER_00221]** *[*Persistency shall check the redundant data when accessing stored data. When the stored data is corrupted, Persistency shall try to restore it using the available redundancy. If Persistency is not able to recover using the redundancy, it shall report kValidationFailed._♩(RS_PER_00008)_

Depending on the actual implementation, Persistency might access the stored data at different times, e.g. when ara::core::Initialize is called, when a Key-

-Value Storage is opened, or when a file is accessed. The question whether the redundancy is sufficient for recovery is also implementation specific and can only be safely assumed for PersistencyRedundancyMOutOfN.

When the recovery failed, the application can choose to use ara::per::RecoverKeyValueStorage, ara::per::KeyValueStorage::RecoverKey, ara::per::RecoverAllFiles, or ara::per::FileStorage::RecoverFile to recover as much as possible and set the corresponding Key-Value Storage or File Storage again into a consistent state.

**[SWS_PER_00452]** *[*When ara::per::RecoverKeyValueStorage is called, Persistency shall restore the Key-Value Storage to a consistent state, including redundancy. First, the infrastructure of the whole Key-Value Storage shall be restored, then Persistency shall try to recover all key-value pairs available in the Key-Value Storage as described in [[SWS_PER_00453](#_bookmark23)]. Depending on available information, the whole Key-Value Storage might be reset to the initial state as described in [[SWS_PER_00456](#_bookmark25)], losing all updated values of its key-value pairs, or may contain outdated key-value pairs after the operation._♩(RS_PER_00009)_

**[SWS_PER_00547]** *[*When ara::per::KeyValueStorage::RecoverKey is called, Persistency shall first check whether the key-value pair is present in any instance of the Key-Value Storage, and otherwise return directly with kKeyNotFound._♩(RS_AP_00128)_

[]{#\_bookmark23 .anchor}**[SWS_PER_00453]** *[*When ara::per::KeyValueStorage::RecoverKey is called for an existing key-value pair, Persistency shall try to restore the given key to a consistent state, including redundancy. Depending on available information, the key might be removed, reset to the initial value as described in [[SWS_PER_00477](#_bookmark26)], or might contain an outdated value after the operation._♩ (RS_PER_00009)_

**[SWS_PER_00454]** *[*When ara::per::RecoverAllFiles is called, Persistency shall restore the File Storage to a consistent state, including redundancy. First, the infrastructure of the whole File Storage shall be restored as described in [[SWS_PER_00478](#_bookmark27)], then Persistency shall try to recover all currently available files as described in [[SWS_PER_00455](#_bookmark24)]. Depending on available information, the whole File Storage might be reset to the initial state, losing all updated content of its files, or may contain outdated files after the operation._♩(RS_PER_00009)_

**[SWS_PER_00548]** *[*When ara::per::FileStorage::RecoverFile is called, Persistency shall first check whether the file is present in the File Storage, and otherwise return directly with kFileNotFound._♩(RS_AP_00128)_

[]{#\_bookmark24 .anchor}**[SWS_PER_00455]** *[*When ara::per::FileStorage::RecoverFile is called for an existing file, Persistency shall try to restore the given file to a consistent state, including redundancy. Depending on available information, the file might be removed, reset to the initial state as described in [[SWS_PER_00479](#_bookmark28)], or might contain outdated content after the operation._♩(RS_PER_00009)_

Of course the application has to validate the restored data in this case.

Or it can use ara::per::ResetPersistency (see [[SWS_PER_00556](#_bookmark41)]), ara::per::ResetKeyValueStorage, ara::per::KeyValueStorage::ResetKey, ara::per::ResetAllFiles, or ara::per::FileStorage::ResetFile to reset the corrupted item to the initial state according to the current manifest.

[]{#\_bookmark25 .anchor}**[SWS_PER_00456]** *[*When ara::per::ResetKeyValueStorage is called, Persistency shall reset the Key-Value Storage to the state it would have after installation of the application using the current manifest information._♩(RS_PER_00009)_

[]{#\_bookmark26 .anchor}**[SWS_PER_00477]** *[*When ara::per::KeyValueStorage::ResetKey is called, Persistency shall reset the given key to the state it would have after installation of the application using the current manifest information. If the key is not available in the manifest, the call shall fail with kInitValueNotAvailable._♩(RS_PER_00009)_

[]{#\_bookmark27 .anchor}**[SWS_PER_00478]** *[*When ara::per::ResetAllFiles is called, Persistency shall reset the File Storage to the state it would have after installation of the application using the current manifest information._♩(RS_PER_00009)_

[]{#\_bookmark28 .anchor}**[SWS_PER_00479]** *[*When ara::per::FileStorage::ResetFile is called, Persistency shall reset the given file to the state it would have after installation of the application using the current manifest information. If the file is not available in the manifest, the call shall fail with kInitValueNotAvailable._♩ (RS_PER_00009)_

The application may want to monitor its storages for any problem detected by redundancy, even if Persistency is able to recover by itself. This might be required to e.g. get an early indication of hardware problems or for safety critical applications. This monitoring is supported by Persistency, which will trigger a callback function of the application in case of any problems with the storages. To activate this monitoring, the application has to register that callback function using ara::per::RegisterRecoveryReportCallback.

**[SWS_PER_00480]** *[*When ara::per::RegisterRecoveryReportCallback is called, Persistency shall register the provided function and enable reporting of redundancy problems in all storages of this application._♩(RS_PER_00008)_

Persistency may check redundancy at different places, e.g. when ara::core::Initialize is called, when a storage is opened, or when elements of the storage are accessed. Whenever a problem is detected with redundancy, independently of the situation in which the problem appeared or whether the problem could be handled, Persistency will inform the application about these problems via the registered callback, stating kKeyValueStorageRecovered, kKeyRecovered, kFileStorageRecovered, or kFileRecovered when recovery of a Key-

-Value Storage, a File Storage, a key-value pair, or a file was possible, and kKeyValueStorageRecoveryFailed, kKeyRecoveryFailed, kFileStorageRecoveryFailed, or kFileRecoveryFailed if not. The callback also reports the affected storage, the affected elements, and how many copies of these elements were affected (the latter only in case PersistencyRedundancyMOutOfN is configured).

**[SWS_PER_00481]** *[*When a Key-Value Storage is accessed, and a redundancy problem affecting the whole Key-Value Storage is detected that cannot be handled by Persistency (i.e. kValidationFailed is returned), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the Key-Value Storage, recoveryReportKind set to kKeyValueStorageRecoveryFailed, an empty ara::core::Vector for reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the Key-Value Storage in reportedInstances._♩(RS_PER_00008)_

**[SWS_PER_00482]** *[*When a Key-Value Storage is accessed, and a redundancy problem affecting the whole Key-Value Storage is detected that can be handled by Persistency (i.e. the operation succeeds), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the Key-

-Value Storage, recoveryReportKind set to kKeyValueStorageRecovered, an empty ara::core::Vector for reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the Key-Value Storage in reportedInstances._♩(RS_PER_00008)_

**[SWS_PER_00483]** *[*When a File Storage is accessed, and a redundancy problem affecting the whole File Storage is detected that cannot be handled by Persistency (i.e. kValidationFailed is returned), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the File Storage, recoveryReportKind set to kFileStorageRecoveryFailed, an empty ara::core::Vector for reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the File Storage in reportedInstances._♩(RS_PER_00008)_

**[SWS_PER_00484]** *[*When a File Storage is accessed, and a redundancy problem affecting the whole File Storage is detected that can be handled by Persistency (i.e. the operation succeeds), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the File Storage, recoveryReportKind set to kFileStorageRecovered, an empty ara::core::Vector for reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the File Storage in reportedInstances._♩ (RS_PER_00008)_

[]{#\_bookmark29 .anchor}**[SWS_PER_00485]** *[*When a Key-Value Storage or one of its keys is accessed, and a redundancy problem affecting a set of keys is detected that cannot be handled by Persistency (i.e. kValidationFailed is returned), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the Key-Value Storage, recoveryReportKind set to kKeyRecoveryFailed, an ara::core::Vector with the affected keys in reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the keys in reportedInstances._♩(RS_PER_00008)_

[]{#\_bookmark30 .anchor}**[SWS_PER_00486]** *[*When a Key-Value Storage or one of its keys is accessed, and a redundancy problem affecting a set of keys is detected that can be handled by Persistency (i.e. the operation succeeds), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the Key-Value Storage, recoveryReportKind set to kKeyRecovered, an ara::core::Vector with the affected keys in reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the keys in reportedInstances._♩(RS_PER_00008)_

**[SWS_PER_00487]** *[*When a redundancy problem of single keys is reported according to [[SWS_PER_00485](#_bookmark29)] or [[SWS_PER_00486](#_bookmark30)], Persistency shall in general ensure that each entry in reportedElements matches an entry in reportedInstances at the same positions, the two ara::core::Vectors shall have the same size. If several instances of a key are affected, the key may appear several times in reportedElements. As an optimization, if only one key is affected, reportedElements may contain the affected key as single entry, related to all entries of

reportedInstances._♩(RS_PER_00008)_

[]{#\_bookmark31 .anchor}**[SWS_PER_00488]** *[*When a File Storage or one of its files is accessed, and a redundancy problem affecting a set of files is detected that cannot be handled by Persistency (i.e. kValidationFailed is returned), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the File Storage, recoveryReportKind set to kFileRecoveryFailed, an ara::core::Vector with the affected files in reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the files in reportedInstances._♩(RS_PER_00008)_

[]{#\_bookmark32 .anchor}**[SWS_PER_00489]** *[*When a File Storage or one of its files is accessed, and a redundancy problem affecting a set of files is detected that can be handled by Persistency (i.e. the operation succeeds), Persistency shall call the registered callback with storage set to the ara::core::InstanceSpecifier of the File Storage, recoveryReportKind set to kFileRecovered, an ara::core::Vector with the affected files in reportedElements, and an ara::core::Vector with the indices of the affected redundant instances of the files in reportedInstances._♩(RS_PER_00008)_

**[SWS_PER_00490]** *[*When a redundancy problem of single file is reported according to [[SWS_PER_00488](#_bookmark31)] or [[SWS_PER_00489](#_bookmark32)], Persistency shall in general ensure that each entry in reportedElements matches an entry in reportedInstances at the same positions, the two ara::core::Vectors shall have the same size. If several instances of a file are affected, the file may appear several times in reportedElements. As an optimization, if only one file is affected, reportedElements may contain the affected file as single entry, related to all entries of reportedInstances._♩(RS_PER_00008)_

### Redundancy Types

The type of redundancy that is applied by the Persistency is defined by the set of PersistencyRedundancyHandling classes aggregated as PersistencyDeployment.redundancyHandling. The level to which redundancy is applied is defined by the possible values of the PersistencyRedundancyHandlingScopeEnum, which are persistencyRedundancyHandlingScopeStorage and persistencyRedundancyHandlingScopeElement for a Key-Value Storage and its key-value pairs, or a File Storage and its files, respectively.

[]{#\_bookmark34 .anchor}**[SWS_PER_00318]** *[*In case a PersistencyRedundancyHandling aggregated as PersistencyDeployment.redundancyHandling is derived as PersistencyRedundancyCrc, the Persistency shall calculate a CRC value when persisting the storage or an element of the storage (depending on PersistencyDeployment.redundancyHandling.scope), and shall use this CRC to check the storage or the element when it is read back._♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

**[SWS_PER_00439]** *[*Persistency shall calculate the CRC value using the algorithm defined by PersistencyRedundancyCrc.algorithmFamily with the bit width defined by PersistencyRedundancyCrc.length._♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

[]{#\_bookmark35 .anchor}**[SWS_PER_00319]** *[*In case a PersistencyRedundancyHandling aggregated as PersistencyDeployment.redundancyHandling is derived as PersistencyRedundancyMOutOfN, the Persistency shall store N copies when persisting the storage or an element of the storage (depending on PersistencyDeployment. redundancyHandling.scope), and shall check that at least M of the N copies of the storage or the element are identical when it is read back. N is defined by n, and M is defined by m._♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

It is possible to configure more than one PersistencyDeployment.deploymentUri for a storage that uses PersistencyRedundancyMOutOfN. In this case, the copies will be distributed over the different locations. The existence of multiple URIs for a single storage is limited to this case by [constr_10366].

**[SWS_PER_00555]** *[*In case multiple PersistencyDeployment.deploymentUris exist, and PersistencyDeployment.redundancyHandling.scope is persistencyRedundancyHandlingScopeStorage, Persistency shall store the copies of the storage in the different locations as follows:

**2** The first location contains the main copy, the second location contains all other copies.

**n** (== PersistencyRedundancyMOutOfN.n) Each copy is placed in a separate location.

_♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

[]{#\_bookmark36 .anchor}**[SWS_PER_00447]**{DRAFT} *[*In case a PersistencyRedundancyHandling aggregated as PersistencyDeployment.redundancyHandling is derived as PersistencyRedundancyHash, the Persistency shall calculate a hash value when persisting the storage or an element of the storage (depending on PersistencyDeployment.redundancyHandling.scope), and shall use this hash value to check the storage or the element when it is read back._♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

**[SWS_PER_00448]**{DRAFT} *[*Persistency shall calculate the hash value using the algorithm defined by PersistencyRedundancyHash.algorithmFamily with the bit width defined by PersistencyRedundancyHash.length. If PersistencyRedundancyHash.initializationVectorLength is configured, an initialization vector of this length shall be calculated containing random data and passed to the hash algorithm._♩(RS_PER_00008, RS_PER_00009, RS_PER_00010)_

A possible approach to calculate the hash value and the random data would be to use the Cryptography [5]. The integration will have to take care that the configured PersistencyRedundancyHash.length and PersistencyRedundancy-

Hash.initializationVectorLength are supported by the configured PersistencyRedundancyHash.algorithmFamily.

### Installation and Update of Persistent Data

The Update and Configuration Management [6] handles the life cycle of Adaptive Applications with the following phases:

- Installation of new software
- Update of already installed software
- Finalization of updated software after the update succeeded
- Roll-back of updated software after the update failed
- Removal of installed software

For all these phases, persistent data needs to be handled alongside the application. The Adaptive Application may trigger this handling explicitly by calling ara::per::UpdatePersistency during the verification phase that follows the installation or update, or rely on the Persistency to do this implicitly when persistent data is accessed (ara::per::OpenKeyValueStorage/ara::per::OpenFileStorage). In both cases, the Persistency will compare the stored manifest version against the current manifest version, and perform the required action.

Persistency stores information about already installed storages together with version information in a central location.

**[SWS_PER_00463]**{DRAFT} *[*Persistency shall store information about the installed Key-Value Storages and File Storages in the location denoted by ProcessToMachineMapping.persistencyCentralStorageURI of the ProcessToMachineMapping that refers to the Process that is referenced by PersistencyPortPrototypeToDeploymentMappings. It shall also store the current manifest version in this location._♩(RS_PER_00010, RS_PER_00012, RS_PER_00013, RS_PER_00014, RS_PER_00016)_

**[SWS_PER_00469]** *[*When ara::per::UpdatePersistency is called, the Persistency shall follow [[SWS_PER_00382](#_bookmark43)] (for installation), [[SWS_PER_00386](#_bookmark56)] and [[SWS_PER_00387](#_bookmark57)] (for update), or [[SWS_PER_00396](#_bookmark63)] (for roll-back) for each storage configured as PersistencyDeployment in the deployment data._♩(RS_PER_00010, RS_PER_00012, RS_PER_00013, RS_PER_00014)_

**[SWS_PER_00470]** *[*When a Key-Value Storage is opened by the application using ara::per::OpenKeyValueStorage, the Persistency shall follow [[SWS_PER_00382](#_bookmark43)] (for installation), [[SWS_PER_00386](#_bookmark56)] and [[SWS_PER_00387](#_bookmark57)] (for update), [[SWS_PER_00446](#_bookmark61)] (for finalization), or [[SWS_PER_00396](#_bookmark63)] (for roll-back) for this Key-Value Storage configured as PersistencyKeyValueStorage in the deployment data._♩(RS_PER_00010, RS_PER_00012, RS_PER_00013, RS_PER_00014, RS_PER_00016)_

**[SWS_PER_00471]** *[*When a File Storage is opened by the application using ara::per::OpenFileStorage, the Persistency shall follow [[SWS_PER_00382](#_bookmark43)] (for installation), [[SWS_PER_00386](#_bookmark56)] and [[SWS_PER_00387](#_bookmark57)] (for update), [[SWS_PER_00446](#_bookmark61)] (for finalization), or [[SWS_PER_00396](#_bookmark63)] (for roll-back) for each File Storage configured as PersistencyFileStorage in the deployment data._♩(RS_PER_00010, RS_PER_00012, RS_PER_00013, RS_PER_00014, RS_PER_00016)_

**[SWS_PER_00378]** *[*Persistency shall extract the Executable.version and the PersistencyDeployment.version from the manifest, and store them persistently in the location denoted by ProcessToMachineMapping.persistencyCentralStorageURI._♩(RS_PER_00010, RS_PER_00013, RS_PER_00014)_

The Executable.version is used by Persistency to detect a change of the application (see [[SWS_PER_00387](#_bookmark57)]), while the PersistencyDeployment.version is used to detect a change of the deployed persistent data (see [[SWS_PER_00386](#_bookmark56)] and [[SWS_PER_00396](#_bookmark63)]).

**[SWS_PER_CONSTR_00001]**{DRAFT} *[*When the Executable.version is increased, the PersistencyDeployment.version needs to be increased, too._♩(RS_PER_00010, RS_PER_00012)_

The PersistencyDeployment.version and Executable.version are StrongRevisionLabelStrings. These strings consists of a MajorVersion, a MinorVersion, a PatchVersion, and additional labels for pre-release versions and build information. It is assumed that at least one of the first three will be incremented when the version is changed, while the additional labels might be arbitrary.

**[SWS_PER_CONSTR_00002]**{DRAFT} *[*When the PersistencyDeployment. version or Executable.version is increased, the MajorVersion, MinorVersion, or PatchVersion have to be incremented._♩(RS_PER_00010, RS_PER_00012)_

After installation of the Adaptive Application, the Persistency will install predefined persistent data from the manifest. There are different possibilities how this persistent data can be defined in the manifest:

- Persistent data can be defined by an application designer within PersistencyKeyValueStorageInterface or PersistencyFileStorageInterface.
- Persistent data that was defined by an application designer can be changed and fine-tuned by an integrator within PersistencyKeyValueStorage or PersistencyFileStorage.
- Persistent data can be directly defined by an integrator within PersistencyKeyValueStorage or PersistencyFileStorage.

[]{#\_bookmark38 .anchor}**[SWS_PER_00379]** *[*Elements defined in the deployment data (PersistencyDeploymentElement) shall always be preferred over the elements defined in the application design (PersistencyInterfaceElement). The latter shall only be used if the former does not exist._♩(RS_PER_00010, RS_PER_00012, RS_PER_00013)_

After an update of the Adaptive Application or the manifest, the Persistency will create a backup of the persistent data, and then update the existing persistent data using one of the following strategies:

- Existing persistent data is kept unchanged (keepExisting).
- Existing persistent data is replaced (overwrite).
- Existing persistent data is removed (delete).
- New persistent data is added (keepExisting and overwrite).

The update strategy can be set during application design or deployment, and can be defined for the whole Key-Value Storage or File Storage (PersistencyCollectionLevelUpdateStrategyEnum -keepExisting or delete) and for a single key-value pair or file (PersistencyElementLevelUpdateStrategyEnum -keepExisting, overwrite, or delete).

[]{#\_bookmark39 .anchor}**[SWS_PER_00251]** *[*An update strategy defined in the deployment data (PersistencyDeploymentElement.updateStrategy) shall always be preferred over the update strategy defined in the application design (PersistencyInterfaceElement.updateStrategy). The latter shall only be used if the former does not exist._♩ (RS_PER_00010, RS_PER_00012, RS_PER_00013)_

PersistencyDeployment.updateStrategy is a mandatory attribute and therefore PersistencyInterface.updateStrategy is just a recommendation for the deployment and never used by Persistency.

[]{#\_bookmark40 .anchor}**[SWS_PER_00380]** *[*An update strategy defined for a single element (PersistencyDeploymentElement.updateStrategy, PersistencyInterfaceElement. updateStrategy) shall always be preferred over the update strategy defined for the enclosing storage (PersistencyDeployment.updateStrategy, PersistencyInterface.updateStrategy). The latter shall only be used if the former does not exist._♩(RS_PER_00010, RS_PER_00012, RS_PER_00013)_

When the update succeeded, the Update and Configuration Management will finalize the new Adaptive Application. The Persistency will free the resources allocated by the last backup when it is opened the first time after the update succeeded.

When the update failed, the Update and Configuration Management will revert to the old Adaptive Application and/or manifest. The Persistency will then replace the currently used persistent data by the backup created during the update.

The application can always reset its storages or elements of the storages to their initial state, using ara::per::ResetPersistency, ara::per::ResetKeyValueStorage (see [[SWS_PER_00456](#_bookmark25)]), ara::per::KeyValueStorage::ResetKey (see [[SWS_PER_00477](#_bookmark26)]), ara::per::ResetAllFiles (see [[SWS_PER_00478](#_bookmark27)]), or ara::per::FileStorage::ResetFile (see [[SWS_PER_00479](#_bookmark28)]).

[]{#\_bookmark41 .anchor}**[SWS_PER_00556]** *[*When ara::per::ResetPersistency is called, Persistency shall reset all Key-Value Storages and File Storages to the state they would have after installation of the application using the current manifest information._♩(RS_PER_00010, RS_PER_00012)_

Finally, when the Adaptive Application is removed, the Update and Configuration Management is responsible to remove the related persistent data as well.

### Installation of Persistent Data

[]{#\_bookmark43 .anchor}**[SWS_PER_00382]** *[*When a storage is opened by the application, the Persistency shall check for the existence of any persistent data of this Process. If no persistent data is found, the Persistency shall initialize the persistent data._♩(RS_PER_00010, RS_PER_00012)_

Initialization of persistent data is described in [paragraph](#installation-of-key-value-storage) [7.2.6.1.1](#installation-of-key-value-storage) and [paragraph](#installation-of-file-storage) [7.2.6.1.2](#installation-of-file-storage).

To be able to update Persistency with changed redundancy, Persistency stores the information about the used redundancy measures within the meta data of each storage. The same applies to the used keys and algorithms for encryption and authentication.

**[SWS_PER_00558]** *[*When a new storage is installed, Persistency shall store the information about the used redundancy in the meta data of the storage._♩(RS_PER_00008, RS_PER_00010, RS_PER_00012)_

> **[SWS_PER_00559]** *[*When a new storage is installed, Persistency shall store the information about keys and algorithms used for encryption and authentication in the meta data of the storage._♩(RS_PER_00005, RS_PER_00010, RS_PER_00012)_

### Installation of Key-Value Storage

[]{#\_bookmark45 .anchor}**[SWS_PER_00383]** *[*Persistency shall create a Key-Value Storage for each PortPrototype typed by a PersistencyKeyValueStorageInterface that is found in the manifest of a newly installed Adaptive Application._♩(RS_PER_00010, RS_PER_00012)_

The Key-Value Storages created by [[SWS_PER_00383](#_bookmark45)] are identified at runtime by the shortName path of the PortPrototype, passed as ara::core::InstanceSpecifier to ara::per::OpenKeyValueStorage.

[]{#\_bookmark46 .anchor}**[SWS_PER_00252]** *[*Persistency shall create an entry in the Key-Value Storage for each PersistencyKeyValueStorageInterface.dataElement and PersistencyKeyValueStorage.keyValuePair that is found in the manifest of a newly installed or updated Adaptive Application, and for which the update strategy is not delete._♩(RS_PER_00010, RS_PER_00012)_

Key-Value Storage entries are identified by the key. An entry with identical key might be defined both in the PersistencyKeyValueStorageInterface as dataElement and the PersistencyKeyValueStorage as keyValuePair, in which case [[SWS_PER_00379](#_bookmark38)] applies. The update strategy is determined according to [[SWS_PER_00251](#_bookmark39)] and [[SWS_PER_00380](#_bookmark40)].

[]{#\_bookmark47 .anchor}**[SWS_PER_00253]** *[*Entries in the Key-Value Storage shall use the shortName of the PersistencyDataElement and/or PersistencyKeyValuePair as key._♩ (RS_PER_00010, RS_PER_00012)_

[]{#\_bookmark48 .anchor}**[SWS_PER_00254]** *[*Entries in the Key-Value Storage shall be created with the data type defined by the CppImplementationDataType which types the PersistencyDataElement and/or by the CppImplementationDataType referenced as PersistencyKeyValuePair.valueDataType._♩(RS_PER_00010, RS_PER_00012)_

[]{#\_bookmark49 .anchor}**[SWS_PER_00384]** *[*Entries in the Key-Value Storage shall be created with the value taken from the PersistencyKeyValuePair.initValue or, if that does not exist, from the PersistencyDataRequiredComSpec.initValue._♩(RS_PER_00010, RS_PER_00012)_

**[SWS_PER_CONSTR_00003]** *[*A manifest is not valid if the value or data type of any PersistencyKeyValuePair or PersistencyDataElement cannot be determined, or if the determined data types are conflicting._♩(RS_PER_00010, RS_PER_00012)_

Invalid manifests should be rejected by the tooling.

### Installation of File Storage

[]{#\_bookmark51 .anchor}**[SWS_PER_00385]** *[*Persistency shall create a File Storage for each PortPrototype typed by a PersistencyFileStorageInterface that is found in the manifest of a newly installed Adaptive Application._♩(RS_PER_00010, RS_PER_00012)_

The File Storages created by [[SWS_PER_00385](#_bookmark51)] are identified at run-time by the shortName path of the PortPrototype, passed as ara::core::InstanceSpecifier to ara::per::OpenFileStorage.

[]{#\_bookmark52 .anchor}**[SWS_PER_00265]** *[*Persistency shall create a file in the File Storage for each PersistencyFileStorageInterface.fileElement and PersistencyFileStorage.file that is found in the manifest of a newly installed or updated Adaptive Application, and for which the update strategy is not delete._♩(RS_PER_00010, RS_PER_00012)_

The files within a File Storage are identified by their file name. A file with the same file name might be defined both in the PersistencyFileStorageInterface as fileElement and the PersistencyFileStorage as file, in which case [[SWS_PER_00379](#_bookmark38)] applies. The update strategy is determined according to [[SWS_PER_00251](#_bookmark39)] and [[SWS_PER_00380](#_bookmark40)].

[]{#\_bookmark53 .anchor}**[SWS_PER_00266]** *[*Files in the File Storage shall use the file name identified by PersistencyFileElement.fileName and/or PersistencyFile.fileName._♩(RS_PER_00010, RS_PER_00012)_

[]{#\_bookmark54 .anchor}**[SWS_PER_00267]** *[*Files in the File Storage shall be created with the content taken from the resource (within the installed SoftwarePackage) that is addressed by PersistencyFile.contentUri or, if that does not exist, by PersistencyFileElement.contentUri. If that does not exist either, an empty file shall be created._♩(RS_PER_00010, RS_PER_00012)_

**[SWS_PER_CONSTR_00004]** *[*A manifest is invalid if the shortNames of a PersistencyFileElement and a PersistencyFile with the same file name differs._♩(RS_PER_00010, RS_PER_00012)_

Invalid manifests should be rejected by the tooling.

### Update of Persistent Data

[]{#\_bookmark56 .anchor}**[SWS_PER_00386]** *[*When a storage is opened by the application, the Persistency shall compare the PersistencyDeployment.version in the manifest against the stored version. If the version in the manifest is higher than the stored version, the Persistency shall first create a backup of all the persistent data of this Process and then update the data._♩(RS_PER_00010, RS_PER_00013)_

Only one set of backup data needs to be kept at any time. When a new update is performed, old backup data could be overwritten. Update of persistent data is described in [paragraph](#update-of-key-value-storage) [7.2.6.2.1](#update-of-key-value-storage) and [paragraph](#update-of-file-storage) [7.2.6.2.2](#update-of-file-storage).

[]{#\_bookmark57 .anchor}**[SWS_PER_00387]** *[*If the application registered a function using ara::per::RegisterApplicationDataUpdateCallback, and if the Persistency had to update at least one of its storages according to [[SWS_PER_00386](#_bookmark56)], it shall compare the Executable.version in the manifest against the stored version. If the version in the manifest is higher than the stored version, the Persistency shall call the registered function for each storage that was updated according to [[SWS_PER_00386](#_bookmark56)]._♩ (RS_PER_00010, RS_PER_00013)_

The function registered by the application using ara::per::RegisterApplicationDataUpdateCallback can be used by the application to update elements of a storage manually. The storage is identified by the ara::core::InstanceSpecifier provided to this function. The application might then, based on the Executable.version of the stored data provided as second argument to the

function, read in the stored data in the old format or with the old type, convert the data, and store it again with the new format or new type expected by the current version.

Example: Version 1 of the application stored the maximum speed in _mph_ as uint8, but version 2 expects the maximum speed in _km/h_ as uint16. The update callback function will then see that a Key-Value Storage from version 1 of the Executable has been updated to the current version, and can read in the old maximum speed by ara::per::KeyValueStorage::GetValue as uint8, convert it, and store it as uint16 with ara::per::KeyValueStorage::SetValue after removing the old value with ara::per::KeyValueStorage::RemoveKey.

In case the redundancy configuration or the configuration of encryption and authentication of the updated manifest differs from the old manifest, special care has to be taken to keep the data consistent and readable.

**[SWS_PER_00560]** *[*During the update, when the old storage is read, Persistency shall check the redundancy according to the information stored in the meta data of the storage._♩(RS_PER_00008, RS_PER_00010, RS_PER_00013)_

> **[SWS_PER_00561]** *[*When the storage is persisted after the update, Persistency shall use the redundancy configured in the manifest, and store the information about the used redundancy in the meta data of the storage._♩(RS_PER_00008, RS_PER_00010, RS_PER_00013)_

Please note that this means that in some situations redundant information might become obsolete and can be removed, e.g. when the new manifest has a lower n for PersistencyRedundancyMOutOfN.

**[SWS_PER_00562]** *[*During the update, when the old storage is read, Persistency shall decrypt and verify the signature of the storage or the elements of the storage according to the information stored in the meta data of the storage._♩ (RS_PER_00005, RS_PER_00010, RS_PER_00013)_

**[SWS_PER_00563]** *[*When the storage is persisted after the update, Persistency shall encrypt and sign the storage or the elements of the storage as configured in the manifest, and store the information about the used keys and algorithms in the meta data of the storage._♩(RS_PER_00005, RS_PER_00010, RS_PER_00013)_

### Update of Key-Value Storage

**[SWS_PER_00388]** *[*When a new PortPrototype typed by a PersistencyKeyValueStorageInterface is detected in an updated manifest, the Persistency shall create a Key-Value Storage as specified in [[SWS_PER_00383](#_bookmark45)]._♩(RS_PER_00010, RS_PER_00013)_

> **[SWS_PER_00389]** *[*When a PortPrototype typed by a PersistencyKeyValueStorageInterface is missing in an updated manifest, the Persistency shall remove the corresponding Key-Value Storage._♩(RS_PER_00010, RS_PER_00013)_

**[SWS_PER_00390]** *[*When a PersistencyKeyValueStorageInterface. dataElement and/or a PersistencyKeyValueStorage.keyValuePair with a new key is detected in an updated manifest for which the update strategy is not delete, the Persistency shall create a new entry in the Key-Value Storage as specified in [[SWS_PER_00252](#_bookmark46)], [[SWS_PER_00253](#_bookmark47)], [[SWS_PER_00254](#_bookmark48)], and [[SWS_PER_00384](#_bookmark49)]._♩(RS_PER_00010, RS_PER_00013)_

**[SWS_PER_00391]** *[*When an existing key-value pair cannot be associated with any PersistencyKeyValueStorageInterface.dataElement or PersistencyKeyValueStorage.keyValuePair in an updated manifest, and the update strategy of the PersistencyKeyValueStorage corresponding to the Key-Value Storage is delete, the Persistency shall remove that key-value pair from the Key-Value Storage._♩(RS_PER_00010, RS_PER_00013)_

The update strategy is determined according to [[SWS_PER_00251](#_bookmark39)].

**[SWS_PER_00275]** *[*When an existing key-value pair can be associated with a PersistencyKeyValueStorageInterface.dataElement or PersistencyKeyValueStorage.keyValuePair in an updated manifest, and the update strategy is overwrite, the Persistency shall replace that key-value pair with the new type and value as specified in [[SWS_PER_00254](#_bookmark48)] and [[SWS_PER_00384](#_bookmark49)]._♩ (RS_PER_00010, RS_PER_00013)_

An entry with identical key might be defined both in the PersistencyKeyValueStorageInterface and the PersistencyKeyValueStorage, in which case [[SWS_PER_00379](#_bookmark38)] applies. The update strategy is determined according to [[SWS_PER_00251](#_bookmark39)] and [[SWS_PER_00380](#_bookmark40)].

**[SWS_PER_00277]** *[*When an existing key-value pair can be associated with a PersistencyKeyValueStorageInterface.dataElement or PersistencyKeyValueStorage.keyValuePair in an updated manifest, and the update strategy is delete, the Persistency shall remove that key-value pair from the Key-Value Storage._♩(RS_PER_00010, RS_PER_00013)_

Updated key-value pairs with the update strategy keepExisting will not be touched during an update. Persistency will neither check the value nor the type of the existing entry.

To support the conversion from one CppImplementationDataType to another (or to a different version of the same type) in the function registered using ara::per::RegisterApplicationDataUpdateCallback, Persistency provides the ability to read data types from a storage that are no longer used by the application. These types are configured in the manifest as previousDataType of a PersistencyKeyValueDataTypeMapping that references a currently used type as currentDataType.

There are two scenarios in which such a conversion is necessary:

1. An existing data type has been modified for the new application. The data type still uses the same identifier.
2. A new data type was introduced that replaces a data type that is no longer used in the new application. The two data types have different identifiers.

**[SWS_PER_CONSTR_00005]** *[*In case an existing data type is changed in a new application, Persistency expects PersistencyKeyValueDataTypeMappings referring to a copy of the old data type as previousDataType and the new data type as currentDataType. The name of the old data type shall be formed as follows:

\<PersistencyKeyValueDataTypeMapping.currentDataType.shortName\>\_\< PersistencyKeyValueDataTypeMapping.previousExecutableVersion\>._♩ (RS_PER_00010, RS_PER_00013)_

### Update of File Storage

**[SWS_PER_00392]** *[*When a new PortPrototype typed by a PersistencyFileStorageInterface is detected in an updated manifest, the Persistency shall create a File Storage as specified in [[SWS_PER_00385](#_bookmark51)]._♩(RS_PER_00010, RS_PER_00013)_

> **[SWS_PER_00393]** *[*When a PortPrototype typed by a PersistencyFileStorageInterface is missing in an updated manifest, the Persistency shall remove the corresponding File Storage._♩(RS_PER_00010, RS_PER_00013)_

**[SWS_PER_00394]** *[*When a PersistencyFileStorageInterface.fileElement and/or PersistencyFileStorage.file with a new file name is detected in an updated manifest for which the update strategy is not delete, the Persistency shall create a new file in the File Storage as specified in [[SWS_PER_00265](#_bookmark52)], [[SWS_PER_00266](#_bookmark53)], and [[SWS_PER_00267](#_bookmark54)]._♩(RS_PER_00010, RS_PER_00013)_

**[SWS_PER_00395]** *[*When an existing file cannot be associated with any PersistencyFileStorageInterface.fileElement or PersistencyFileStorage.file in an updated manifest, and the update strategy of the PersistencyFileStorage corresponding to the File Storage is delete, the Persistency shall remove that file from the File Storage._♩(RS_PER_00010, RS_PER_00013)_

The update strategy is determined according to [[SWS_PER_00251](#_bookmark39)].

**[SWS_PER_00281]** *[*When an existing file can be associated with a PersistencyFileStorageInterface.fileElement or PersistencyFileStorage.file in an updated manifest, and the update strategy is overwrite, the Persistency shall replace the content of that file with the new content as specified in [[SWS_PER_00267](#_bookmark54)]._♩(RS_PER_00010, RS_PER_00013)_

A file with the same file name might be defined both in the PersistencyFileStorageInterface and the PersistencyFileStorage, in which case [[SWS_PER_00379](#_bookmark38)] applies. The update strategy is determined according to [[SWS_PER_00251](#_bookmark39)] and [[SWS_PER_00380](#_bookmark40)].

**[SWS_PER_00283]** *[*When an existing file can be associated with a PersistencyFileStorageInterface.fileElement or PersistencyFileStorage.file in an updated manifest, and the update strategy is delete, the Persistency shall remove that file from the File Storage._♩(RS_PER_00010, RS_PER_00013)_

Updated files with the update strategy keepExisting will not be touched during an update. Persistency will not check the content of the existing file.

### Finalization of Persistent Data after Successful Update

After installation and update, Persistency will usually be called with ara::per::UpdatePersistency within the verification phase of the application. When this succeeded, the application will be finalized by Update and Configuration Management and then started again in normal execution mode. In this case, Persistency should remove any backups that were created during a preceding update.

[]{#\_bookmark61 .anchor}**[SWS_PER_00446]** *[*When a storage is opened by the application, and ara::per::UpdatePersistency has not been called since Persistency was initialized, the Persistency shall compare the PersistencyDeployment.version in the manifest against the stored version. If the two versions are identical, the Persistency shall remove all backup data of the storage._♩(RS_PER_00016)_

Update of persistent data is described in [subsubsection](#update-of-persistent-data) [7.2.6.2](#update-of-persistent-data).

### Roll-Back of Persistent Data after Failed Update

[]{#\_bookmark63 .anchor}**[SWS_PER_00396]** *[*When a storage is opened by the application, the Persistency shall compare the PersistencyDeployment.version in the manifest against the stored version. If the version in the manifest is lower than the stored version, the Persistency shall compare the version in the manifest against the version stored in backup data. If the versions match, the Persistency shall restore the backup. Otherwise, it shall remove all storages, and re-install the persistent data from the manifest._♩(RS_PER_00014)_

Initialization of persistent data is described in [subsubsection](#installation-of-persistent-data) [7.2.6.1](#installation-of-persistent-data).

### Removal of Persistent Data

Persistency is not able to remove its own data when the Update and Configuration Management removes an application, because the application will not be executed in this case, and therefore Persistency does not run. On the other hand, the Update and Configuration Management may use the information in the manifest (ProcessToMachineMapping.persistencyCentralStorageURI

and PersistencyDeployment.deploymentUri) to obtain the locations of persistent data, and, if it has access to the locations, remove it.

### Resource Management Concepts

The Persistency supports configuration of both an upper and a lower limit for the resources used by a Key-Value Storage or a File Storage.

The lower limit may already be defined by the application developer using PersistencyInterface.minimumSustainedSize.

During deployment, the integrator may update the lower limit using PersistencyDeployment.minimumSustainedSize and add an upper limit using PersistencyDeployment.maximumAllowedSize.

**[SWS_PER_00320]** *[*The Persistency shall ensure that the space configured by PersistencyDeployment.minimumSustainedSize is always available for the storage._♩(RS_PER_00010, RS_PER_00011)_

One possibility to achieve this would be to initially allocate the minimum size during deployment, and never reduce the size below this value when persistent data is removed. But the implementation of the Persistency is free to chose other appropriate measures.

**[SWS_PER_00321]** *[*The Persistency shall ensure that the space actually allocated by a storage never surpasses the amount configured by PersistencyDeployment.maximumAllowedSize._♩(RS_PER_00010, RS_PER_00011)_

This could be ensured by supervising all write accesses to persistent data. But again, the implementation of the Persistency is free to chose other appropriate measures.

The application can also poll the amount of storage space currently occupied by a complete Key-Value Storage or File Storage by using ara::per::GetCurrentKeyValueStorageSize or ara::per::GetCurrentFileStorageSize, respectively. Naturally, the returned values will not drop below a configured minimum size (PersistencyDeployment.minimumSustainedSize) or rise above a configured maximum size (PersistencyDeployment.maximumAllowedSize).

**[SWS_PER_00491]** *[*ara::per::GetCurrentKeyValueStorageSize shall return the total size of the storage space currently allocated to a Key-Value Storage, including administrative data (apart from data stored in ProcessToMachineMapping.persistencyCentralStorageURI), redundant data, and backup data. The reported size may be inaccurate if the Key-Value Storage is currently open, or if another operation is currently being executed on the same storage._♩(RS_PER_00011)_

The inaccuracy is mainly due to the fact that meta data of the storage is only updated when the storage is fully synchronized, and predicting the meta data size is sometimes very difficult.

[]{#\_bookmark66 .anchor}**[SWS_PER_00492]** *[*ara::per::GetCurrentFileStorageSize shall return the total size of the storage space currently allocated to a File Storage, including administrative data (apart from data stored in ProcessToMachineMapping.persistencyCentralStorageURI), all its files, redundant data, and backup data. The

reported size may be inaccurate if the File Storage is currently open, or if another operation is currently being executed on the same storage._♩(RS_PER_00011)_

## Key-Value Storage specific Features

To access a Key-Value Storage, the application has to call ara::per::OpenKeyValueStorage with the ara::core::InstanceSpecifier derived from the manifest (a shortName path from the Executable to a PortPrototype or a mapping derived from FunctionalClusterInteractsWithFunctionalClusterMapping). This call will return an ara::per::SharedHandle of an ara::per::KeyValueStorage. The Key-Value Storage is closed when the ara::per::SharedHandle and all of its copies go out of scope, or when ara::core::Deinitialize is called.

**[SWS_PER_00506]** *[*When ara::per::OpenKeyValueStorage is called, and Persistency is properly initialized as described in [[SWS_PER_00408](#_bookmark15)], Persistency shall create a temporary storage that provides access to the Key-Value Storage identified by the ara::core::InstanceSpecifier, and shall create and return an ara::per::SharedHandle of an ara::per::KeyValueStorage._♩ (RS_PER_00002)_

If ara::per::OpenKeyValueStorage is called without proper initialization, [[SWS_PER_00410](#_bookmark16)] applies.

All operations on a Key-Value Storage will be done in a temporary storage created during the call to ara::per::OpenKeyValueStorage, which the application can persist using ara::per::KeyValueStorage::SyncToStorage, or reset to the last stored state with ara::per::KeyValueStorage::DiscardPendingChanges.

Therefore, if the Key-Value Storage is just destructed (also implicitly when the Process terminates), the Key-Value Storage is not updated, and the next time the Key-Value Storage is accessed, the application will see the last saved state.

**[SWS_PER_00331]** *[*Modifications of a Key-Value Storage that have not been persisted with a call to ara::per::KeyValueStorage::SyncToStorage shall be discarded when the Key-Value Storage is closed or the system is restarted, just as if ara::per::KeyValueStorage::DiscardPendingChanges had been called._♩ (RS_PER_00003)_

Changes done by any thread (using a copy of the ara::per::SharedHandle) will be immediately visible in all other threads. This also applies to ara::per::KeyValueStorage::DiscardPendingChanges, which resets the key-value pairs in all threads, and to ara::per::KeyValueStorage::SyncToStorage, which persists all changes done by any thread.

**[SWS_PER_00494]** *[*When ara::per::KeyValueStorage::SyncToStorage is called, Persistency shall store all changes permanently that have been done to the Key-Value Storage since the last call to this method or since the Key-Value Storage was opened. Persistency shall also update any configured redundancy within this call._♩(RS_PER_00001)_

The handling of redundancy is described in detail in [subsection](#redundancy-concepts) [7.2.5](#redundancy-concepts).

**[SWS_PER_00495]** *[*When ara::per::KeyValueStorage::DiscardPendingChanges is called, Persistency shall reset the Key-Value Storage to the last persisted state, which is the state after the last call to ara::per::KeyValueStorage::SyncToStorage or after opening the Key-Value Storage._♩ (RS_PER_00001)_

Single key-value pairs of the Key-Value Storage are accessed using ara::per::KeyValueStorage::GetValue and ara::per::KeyValueStorage::SetValue. ara::per::KeyValueStorage::SetValue may also be used to create a key-value pair.

**[SWS_PER_00496]** *[*When ara::per::KeyValueStorage::GetValue is called, Persistency shall first check whether the key-value pair is present in the temporary storage, and otherwise return directly with kKeyNotFound._♩(RS_PER_00002, RS_PER_00003)_

**[SWS_PER_00497]** *[*When ara::per::KeyValueStorage::GetValue is called for an existing key-value pair, Persistency shall check whether the templated data type matches the stored data type, and otherwise return directly with kDataTypeMismatch._♩(RS_PER_00002, RS_PER_00003)_

**[SWS_PER_00498]** *[*When ara::per::KeyValueStorage::GetValue is called for an existing key-value pair with the correct templated data type, Persistency shall return the stored value of the key-value pair, or, if the value was recently changed by ara::per::KeyValueStorage::SetValue (also in another thread), this new temporary value._♩(RS_PER_00002, RS_PER_00003)_

**[SWS_PER_00499]** *[*When ara::per::KeyValueStorage::SetValue is called for an existing key-value pair, Persistency shall check whether the templated data type matches the stored data type, and otherwise return directly with kDataTypeMismatch._♩(RS_PER_00001, RS_PER_00003)_

**[SWS_PER_00534]** *[*When ara::per::KeyValueStorage::SetValue is called for an existing key-value pair with the correct templated data type, Persistency shall store the new value of the key-value pair in the temporary storage._♩(RS_PER_00001, RS_PER_00003)_

**[SWS_PER_00501]** *[*When ara::per::KeyValueStorage::SetValue is called, and the key-value pair does not exist in the temporary storage, Persistency shall create the key-value pair with the templated data type and the provided value in the temporary storage._♩(RS_PER_00001, RS_PER_00003)_

To remove a single key-value pair, the application may use ara::per::KeyValueStorage::RemoveKey, while ara::per::KeyValueStorage::RemoveAllKeys empties the Key-Value Storage. The type of a key-value pair may be changed by first removing it, and then creating it with the new type.

**[SWS_PER_00502]** *[*When ara::per::KeyValueStorage::RemoveKey is called, Persistency shall first check whether the key-value pair is present in the temporary storage, and otherwise return directly with kKeyNotFound._♩_

_(RS_PER_00001, RS_PER_00003)_

> **[SWS_PER_00535]** *[*When ara::per::KeyValueStorage::RemoveKey is called for an existing key-value pair, Persistency shall remove the key-value pair from the temporary storage._♩(RS_PER_00001, RS_PER_00003)_

**[SWS_PER_00503]** *[*When ara::per::KeyValueStorage::RemoveAllKeys is called, Persistency shall remove all key-value pairs from the temporary storage, resulting in an empty Key-Value Storage._♩(RS_PER_00001)_

Finally, the application can check for the existence of a single key with ara::per::KeyValueStorage::KeyExists, check the current size of a value using ara::per::KeyValueStorage::GetCurrentValueSize, and acquire a list of all currently available keys using ara::per::KeyValueStorage::GetAllKeys.

**[SWS_PER_00504]** *[*ara::per::KeyValueStorage::KeyExists shall return true if the key is present in the temporary storage, otherwise it shall return false._♩ (RS_PER_00003)_

**[SWS_PER_00565]** *[*When ara::per::KeyValueStorage::GetCurrentValueSize is called, Persistency shall first check whether the key-value pair is present in the temporary storage, and otherwise return directly with kKeyNotFound._♩(RS_PER_00003)_

**[SWS_PER_00566]** *[*When ara::per::KeyValueStorage::GetCurrentValueSize is called for an existing key-value pair, Persistency shall return the current size of its value._♩(RS_PER_00003)_

**[SWS_PER_00505]** *[*ara::per::KeyValueStorage::GetAllKeys shall return an ara::core::Vector of ara::core::String, containing all the keys that are present in the temporary storage. If the temporary storage is empty, an empty ara::core::Vector shall be returned._♩(RS_PER_00003)_

### Supported Data Types in Key-Value Storages

The Persistency supports the following classes of data types in the functions ara::per::KeyValueStorage::GetValue (templated via T), ara::per::KeyValueStorage::GetValue with out parameter (templated via T), and ara::per::KeyValueStorage::SetValue (templated via T) of a Key-Value Storage.

**[SWS_PER_00302]** *[*The Persistency shall be able to store all data types described in [10] in a Key-Value Storage._♩(RS_PER_00001)_

**[SWS_PER_00303]** *[*The Persistency shall be able to store serialized binary data in a Key-Value Storage. Persistency shall accept serialized binary data in the form of an ara::core::Vector of ara::core::Byte or an ara::core::Span of ara::core::Byte._♩(RS_PER_00001)_

This allows the application to store custom data types.

Please note that an ara::core::Span of ara::core::Byte cannot be returned by ara::per::KeyValueStorage::GetValue. It can only be passed in to ara::per::KeyValueStorage::SetValue and ara::per::KeyValueStorage::GetValue with out parameter.

**[SWS_PER_00304]** *[*The Persistency shall be able to store all CppImplementationDataTypes referenced by PersistencyKeyValueStorageInterface.dataTypeForSerialization or as PersistencyKeyValueStorageInterface.dataElement in the application design of a PersistencyKeyValueStorage in the corresponding Key-Value Storage._♩(RS_PER_00001, RS_PER_00010)_

The definitions of these data types are generated as described in [11]. Typically,

Persistency will generate serializers and deserializers for these types.

## File Storage specific Features

To access a File Storage, the application has to call ara::per::OpenFileStorage with the ara::core::InstanceSpecifier derived from the manifest (a shortName path from the Executable to a PortPrototype or a mapping derived from FunctionalClusterInteractsWithFunctionalClusterMapping). This call will return an ara::per::SharedHandle of an ara::per::FileStorage. The File Storage is closed when the ara::per::SharedHandle and all of its copies go out of scope, or when ara::core::Deinitialize is called.

**[SWS_PER_00507]** *[*When ara::per::OpenFileStorage is called, and Persistency is properly initialized as described in [[SWS_PER_00408](#_bookmark15)], Persistency shall create the necessary structures to access the File Storage identified by the ara::core::InstanceSpecifier, and create and return an ara::per::SharedHandle of an ara::per::FileStorage._♩(RS_PER_00004)_

If ara::per::OpenFileStorage is called without proper initialization, [[SWS_PER_00410](#_bookmark16)] applies.

To check for the existence of a single file, the application may call ara::per::FileStorage::FileExists, and ara::per::FileStorage::GetAllFileNames will return a list of all currently available files of the File Storage.

**[SWS_PER_00508]** *[*ara::per::FileStorage::FileExists shall return true if the file is present in the File Storage, otherwise it shall return false._♩(RS_PER_00004)_

**[SWS_PER_00509]** *[*ara::per::FileStorage::GetAllFileNames shall return an ara::core::Vector of ara::core::String, containing the file names of all the files that are present in the File Storage. If the File Storage is empty, an empty ara::core::Vector shall be returned._♩(RS_PER_00004)_

Files may be have been installed with the application or may have been created during an update. To create new files, the application may use ara::per::FileStorage::OpenFileReadWrite or ara::per::FileStorage::OpenFileWriteOnly, and it can use ara::per::FileStorage::DeleteFile to remove any file.

**[SWS_PER_00510]** *[*When ara::per::FileStorage::DeleteFile is called, Persistency shall first check whether the file is present in the File Storage, and otherwise return directly with kFileNotFound._♩(RS_PER_00004)_

**[SWS_PER_00511]** *[*When ara::per::FileStorage::DeleteFile is called for an existing file, Persistency shall remove the file from the File Storage._♩ (RS_PER_00004)_

To access a file of a File Storage, the application has to call ara::per::FileStorage::OpenFileReadWrite, ara::per::FileStorage::OpenFileReadOnly, or ara::per::FileStorage::OpenFileWriteOnly with the file

name of the file. These calls will return an ara::per::UniqueHandle of an

ara::per::ReadAccessor or ara::per::ReadWriteAccessor.

**[SWS_PER_00551]** *[*When ara::per::FileStorage::OpenFileReadOnly (or one of the overloaded versions ara::per::FileStorage::OpenFileReadOnly with ara::per::OpenMode or ara::per::FileStorage::OpenFileReadOnly with ara::per::OpenMode and separate buffer) is called, Persistency shall first check whether the file is present in the File Storage, and otherwise return directly with kFileNotFound._♩(RS_AP_00128)_

**[SWS_PER_00552]** *[*When ara::per::FileStorage::OpenFileReadOnly with ara::per::OpenMode (or the overloaded version ara::per::FileStorage::OpenFileReadOnly with ara::per::OpenMode and separate buffer) is called, Persistency shall first check whether the provided mode consists only of either kAtTheBeginning or kAtTheEnd, and otherwise return directly with kInvalidOpenMode._♩(RS_AP_00128)_

**[SWS_PER_00512]** *[*When ara::per::FileStorage::OpenFileReadOnly (or one of the overloaded versions ara::per::FileStorage::OpenFileReadOnly with ara::per::OpenMode or ara::per::FileStorage::OpenFileReadOnly with ara::per::OpenMode and separate buffer) is called for an existing file and with a valid ara::per::OpenMode, Persistency shall create the necessary structures to access the file identified by the file name, and create and return an ara::per::UniqueHandle of an ara::per::ReadAccessor._♩(RS_PER_00004)_

**[SWS_PER_00553]** *[*When ara::per::FileStorage::OpenFileReadWrite with ara::per::OpenMode or ara::per::FileStorage::OpenFileWriteOnly with ara::per::OpenMode (or one of the overloaded versions ara::per::FileStorage::OpenFileReadWrite with ara::per::OpenMode and separate buffer or ara::per::FileStorage::OpenFileWriteOnly with ara::per::OpenMode and separate buffer) is called, Persistency shall first check whether the provided mode contains either kAtTheBeginning, possibly combined with kTruncate and kAppend, or kAtTheEnd, possibly combined with kAppend, or only kTruncate. Otherwise, the call shall return directly with kInvalidOpenMode._♩ (RS_AP_00128)_

**[SWS_PER_00513]** *[*When ara::per::FileStorage::OpenFileReadWrite or ara::per::FileStorage::OpenFileWriteOnly (or one of their overloaded versions ara::per::FileStorage::OpenFileReadWrite with ara::per::OpenMode, ara::per::FileStorage::OpenFileReadWrite with ara::per::OpenMode and separate buffer, ara::per::FileStorage::OpenFileWriteOnly with ara::per::OpenMode, or ara::per::FileStorage::OpenFileWriteOnly with ara::per::OpenMode and separate buffer) are called with a valid ara::per::OpenMode, Persistency shall create the necessary structures to access the file identified by the file name, and create and return an ara::per::UniqueHandle of an ara::per::ReadWriteAccessor._♩ (RS_PER_00004)_

The file is closed when the ara::per::UniqueHandle goes out of scope, or when

ara::core::Deinitialize is called.

**[SWS_PER_00457]** *[*When a file is closed, Persistency shall ensure that all changes to the file are persisted. This does not need to be done immediately like when ara::per::ReadWriteAccessor::SyncToFile is called, but may happen at a later time, latest when the file is opened again, or ara::core::Deinitialize is called._♩(RS_PER_00004)_

Some of the overloads of the file opening functions receive an ara::per::OpenMode as an argument. OpenModes can be combined using the operators "\|" and "\|=".

**[SWS_PER_00514]** *[*ara::per::operator "\|" and ara::per::operator "\|=" take two ara::per::OpenMode arguments and return the combined ara::per::OpenMode._♩(RS_PER_00004)_

All files of Persistency are implicitly readable, even when opened as \"write only\", which is expressed by ara::per::ReadWriteAccessor inheriting from ara::per::ReadAccessor. The ara::per::ReadAccessor class consequently also offers the methods related to file positions.

**[SWS_PER_00515]** *[*ara::per::ReadAccessor::SetPosition shall set the file position to the provided position. If the provided position is located outside of the current content of the file (including the position at the end of the file), ara::per::ReadAccessor::SetPosition shall keep the previous file position and return kInvalidPosition._♩(RS_PER_00004)_

**[SWS_PER_00516]** *[*ara::per::ReadAccessor::MovePosition shall move the file position to offset bytes according to the provided origin. If the new position would be located outside of the current content of the file (including the position at the end of the file), ara::per::ReadAccessor::MovePosition shall keep the previous file position and return kInvalidPosition._♩(RS_PER_00004)_

**[SWS_PER_00517]** *[*ara::per::ReadAccessor::GetPosition shall return the current read/write position in the file. In the case of an empty file, the position shall be returned as 0._♩(RS_PER_00004)_

**[SWS_PER_00518]** *[*ara::per::ReadAccessor::IsEof shall return true if the position is the last possible position in the file, i.e. the position directly after the last character in the file, or 0 in case the file is empty._♩(RS_PER_00004)_

ara::per::ReadAccessor::IsEof will return true if the current position corresponds to the total file size, which can be obtained separately using ara::per::ReadAccessor::GetSize.

**[SWS_PER_00519]** *[*ara::per::ReadAccessor::GetSize shall return the current total size of the file._♩(RS_PER_00004)_

Persistency does not care whether the content of a file is text or some binary data, and therefore offers separate methods to access the file content as text or as

binary data. To read content from a text file, the application may use one of the following methods of the ara::per::ReadAccessor class:

**[SWS_PER_00520]** *[*ara::per::ReadAccessor::PeekChar shall return the character at the current file position without changing the position._♩(RS_PER_00004)_

**[SWS_PER_00521]** *[*ara::per::ReadAccessor::GetChar shall return the character at the current file position and advance the position by one._♩(RS_PER_00004)_

**[SWS_PER_00522]** *[*ara::per::ReadAccessor::ReadText shall read the text from the current position to the end of the file and return it as an ara::core::String. The position shall be set to the end of the file._♩(RS_PER_00004)_

**[SWS_PER_00523]** *[*ara::per::ReadAccessor::ReadText shall read the n characters of text from the current position and return them as an ara::core::String. The position shall be incremented by n. In case the end of the file is reached during this operation, the available characters shall be returned, and the position shall be set to the end of the file._♩(RS_PER_00004)_

**[SWS_PER_00524]** *[*ara::per::ReadAccessor::ReadLine shall read all characters until the delimiter (defaulting to the newline character) or the end of the file is reached, and return them as a ara::core::String. The delimiter shall not be included in the returned ara::core::String. The position shall be set to the character following the delimiter or the end of the file._♩(RS_PER_00004, RS_AP_00136)_

All these methods return characters with a size of eight bits, which are just so-called code units in case of UTF-8, not code points. Therefore, these methods might return incomplete code points. Persistency itself does not change or interpret the content of a file when accessing it in text mode. It is assumed, though, that files in the File Storage are encoded as UTF-8 (see [RS_AP_00136]). It is also assumed that line endings are handled according to UNIX conventions, i.e. just LF (\"\\n\").

**[SWS_PER_CONSTR_00006]** *[*If a CppImplementationDataType with category equal to STRING is used as PersistencyDataElement, then the encoding of this string data type is expected to be UTF-8._♩(RS_PER_00003, RS_PER_00004, RS_AP_00136)_

This means that a CppImplementationDataType can only be mapped to an ApplicationDataType of category STRING where attribute swDataDefProps. swTextProps.baseType.baseTypeDefinition.baseTypeEncoding is set to the value UTF-8 as defined by [constr_5035]. If a CppImplementationDataType without an ApplicationDataType is used there is no formal description about the UTF8 encoding in the ServiceInterface description.

The following methods of the ara::per::ReadAccessor class can be used by an

application to read binary content from a file:

**[SWS_PER_00525]** *[*ara::per::ReadAccessor::PeekByte shall return the byte at the current file position without changing the position._♩(RS_PER_00004)_

**[SWS_PER_00526]** *[*ara::per::ReadAccessor::GetByte shall return the byte at the current file position and advance the position by one._♩(RS_PER_00004)_

**[SWS_PER_00527]** *[*ara::per::ReadAccessor::ReadBinary shall read binary data from the current position to the end of the file and return it as an ara::core::Vector of ara::core::Byte. The position shall be set to the end of the file._♩_

_(RS_PER_00004)_

**[SWS_PER_00528]** *[*ara::per::ReadAccessor::ReadBinary shall read the n characters of text from the current position and return them as an ara::core::Vector of ara::core::Byte. The position shall be incremented by n. In case the end of the file is reached during this operation, the available bytes shall be returned, and the position shall be set to the end of the file._♩(RS_PER_00004)_

To write text to files, the application may use the ara::per::ReadWriteAccessor::WriteText method or the ara::per::ReadWriteAccessor::operator\<\< of the ara::per::ReadWriteAccessor class, which treat text in the same way as described above for e.g. ara::per::ReadAccessor::ReadText.

[]{#\_bookmark70 .anchor}**[SWS_PER_00557]** *[*If the file was opened with ara::per::OpenMode set to kAppend, Persistency shall always set the current position to the end of the file before writing data to the file according to [[SWS_PER_00529](#_bookmark71)], [[SWS_PER_00530](#_bookmark72)], or [[SWS_PER_00531](#_bookmark73)]._♩(RS_PER_00004)_

[]{#\_bookmark71 .anchor}**[SWS_PER_00529]** *[*ara::per::ReadWriteAccessor::WriteText shall write the characters provided as ara::core::StringView to the file at the current position, possibly overwriting current content and advancing the end of the file if necessary. The position shall be set to the character following the last character that was written during this operation, or to the end of the file._♩(RS_PER_00004)_

[]{#\_bookmark72 .anchor}**[SWS_PER_00530]** *[*ara::per::ReadWriteAccessor::operator\<\< shall write the characters provided as ara::core::StringView to the file at the current position, possibly overwriting current content and advancing the end of the file if necessary. The position shall be set to the character following the last character that was written during this operation, or to the end of the file. If an error occurs during this operation, the file content might be partially updated and the resulting file position might not be as expected._♩(RS_PER_00004)_

To write binary data to a file, the application may use the method ara::per::ReadWriteAccessor::WriteBinary of the ara::per::ReadWriteAccessor

class. See also [[SWS_PER_00557](#_bookmark70)] for ara::per::OpenMode kAppend.

[]{#\_bookmark73 .anchor}**[SWS_PER_00531]** *[*ara::per::ReadWriteAccessor::WriteBinary shall write the bytes provided as ara::core::Span of ara::core::Byte to the file at the current position, possibly overwriting current content and advancing the end of the file if necessary. The position shall be set to the byte following the last byte that was written during this operation, or to the end of the file._♩(RS_PER_00004)_

The application may use ara::per::ReadWriteAccessor::SetFileSize to explicitly set the file size to a defined value in order to truncate a file or to empty

it. Enlarging files is not supported by ara::per::ReadWriteAccessor::SetFileSize.

**[SWS_PER_00532]** *[*ara::per::ReadWriteAccessor::SetFileSize shall set the file size to the provided value. The read/write position shall be set to the end of the file if the current position is higher than the new file size. If the provided value is larger than the current file size, ara::per::ReadWriteAccessor::SetFileSize shall return kInvalidSize._♩(RS_PER_00004)_

When the application changed a file, Persistency will ensure that these changes are persisted. This can happen at any time, and latest when the file is closed. To trigger an additional synchronization of the file content to the persistent storage, the application may call ara::per::ReadWriteAccessor::SyncToFile.

**[SWS_PER_00533]** *[*When ara::per::ReadWriteAccessor::SyncToFile is called, Persistency shall start writing the content of the file to the persistent storage. The actual update of the persistent storage may still be ongoing or may not even have started when this call returns._♩(RS_PER_00004)_

### Access to Additional Information about Files

To gain information about stored files, the Persistency provides the methods ara::per::FileStorage::GetCurrentFileSize and ara::per::FileStorage::GetFileInfo.

The application can poll the amount of storage space currently occupied by a single file using ara::per::FileStorage::GetCurrentFileSize of an open File Storage.

**[SWS_PER_00549]** *[*When ara::per::FileStorage::GetCurrentFileSize is called, Persistency shall first check whether the file is present in the File Storage, and otherwise return directly with kFileNotFound._♩(RS_AP_00128)_

**[SWS_PER_00493]** *[*When ara::per::FileStorage::GetCurrentFileSize is called for an existing file, Persistency shall return the current size of the passed file. This size shall reflect only the data contained in the file. In case the file is currently open, Persistency shall return the current size of the file, which might differ from the size of the file in the storage if the last changes are not yet synchronized. Otherwise, if the file is not open, Persistency shall return the size of any existing instance of the file without checking the consistency/validity of the file._♩ (RS_PER_00011)_

Please note that administrative and redundant information is not included in the file size reported by ara::per::FileStorage::GetCurrentFileSize, while it is included in the total size of the File Storage returned by ara::per::GetCurrentFileStorageSize (see [[SWS_PER_00492](#_bookmark66)]).

Using ara::per::FileStorage::GetFileInfo, the application can acquire information about the time the file was created (creationTime), last modified ( modificationTime), and last accessed (accessTime), and how and by whom it was created (fileCreationState) and last modified (fileModificationState).

**[SWS_PER_00550]** *[*When ara::per::FileStorage::GetFileInfo is called, Persistency shall first check whether the file is present in the File Storage, and otherwise return directly with kFileNotFound._♩(RS_AP_00128)_

**[SWS_PER_00440]** *[*When ara::per::FileStorage::GetFileInfo is called for an existing file, Persistency shall gather the required information into a ara::per::FileInfo struct and return it to the application._♩(RS_PER_00004)_

In case the Persistency uses a file system of the underlying OS, part of that information (like the creation or access time) can be obtained from the file system. This information might not be accurate if the file is currently open.

**[SWS_PER_00458]** *[*If creationTime, modificationTime, or accessTime are not available, they shall be set to 0._♩(RS_PER_00004)_

As an example, the accessTime is not available for a read-only File Storage, and would therefore be reported as "midnight 1970-01-01".

# API Specification

The APIs for accessing File Storages and Key-Value Storage are completely separate, and therefore divided into separate sections. Additional sections describe common functionality.

The API of Persistency is designed around the ara::per::SharedHandle and

ara::per::UniqueHandle, which are returned by factory functions like ara::per::OpenKeyValueStorage or ara::per::FileStorage::OpenFileReadWrite. The classes defined in this chapter cannot be constructed directly by the Adaptive Application, and consequently the default constructors are considered to be not publicly accessible (i.e. to be deleted, private, or protected).

1. ## General Features of Persistency

   1. ### ara::core Types

The ara::per API is based heavily on the ara::core types defined in [2].

ara::core::Result is used wherever possible, and because of this, most methods are defined as noexcept.

Consequently, in situations where memory cannot be allocated for new objects, the Persistency shall terminate the process by calling ara::core::Abort (see [2]).

# **Contents**

1. # Introduction

   1. ## Scope of this document

This document provides guidelines for IPsec implementation in the AUTOSAR Adaptive Platform.

## Relation to other standards

This document is relevant to AUTOSAR Adaptive Platform only.

2. # The Basics of IPsec Protocol

   1. ## IPsec protocol - network security standard

IPsec is a network layer protocol suite that secures network connections by encrypting or authenticating IP packets. It constitutes a part of IP protocol suite.

IPsec consists of three elementary components:

- Internet Key Exchange - most widely used module for key management
- Authentication Header - (IP protocol 51) for integrity
- Encapsulating Security Payload - (IP protocol 50) for integrity and confidentiality

It is an open network standard, maintained by IETF since 1995 and commonly used in network equipment as well as server and desktop operating systems.

The IPsec can be implemented in the IP stack of an operating system, which requires modification of the source code. This method of implementation is done for many host and security gateway operating systems.

IPsec works in two basic modes of operation:

- Transport mode
- Tunnel mode

The following drawings explain packet structure of Authentication Header and Encap- sulating Security Payload.

![](./media/image1.png){width="6.365624453193351in" height="3.0493744531933507in"}

**Figure 2.1: Authentication Header (AH) frame**

![](./media/image2.png){width="6.077395013123359in" height="2.8272911198600177in"}

**Figure 2.2: Encapsulating Security Payload (ESP) frame**

## Internet Key Exchange operation

In order to create session keys necessary for the network traffic protection IKE starts key exchange and stores Security Associations. A Security Association (SA) is the formation of shared security elements between two network nodes in order to support secure communication. It may include attributes such as: cryptographic algorithm and mode, traffic encryption key, and parameters for the network data to be passed over the connection. They are usually stored in Security Associations Database.

Usually, a Security Association consists of at least the following parameters:

- Destination IP address
- Security Parameter Index (SPI)
- IPsec protocol identifier (AH / ESP)
- Mode (transport / tunnel)
- Key and algorithms used
- Lifetime

The following drawing explains the meaning of IKE module, security associations and security policies databases for securing IPsec network communication.

![](./media/image3.png){width="5.941666666666666in" height="2.8625in"}

**Figure 2.3: SA creation with IKE for network traffic protection**

# Objective

The objective of IPsec protocol implementation in AUTOSAR Adaptive Platform is pro- viding secure communication channels in the in-vehicle IP network.

Implementing IPsec in AUTOSAR Adaptive Platform would provide options for secur- ing communication between network nodes with confidentiality, integrity or both guar- anteed.

IPsec, as a standard network security protocol provides means for secure communica- tion, while supporting multi-vendor stack interoperability.

4. # Primary recommendations

   1. ## Prerequisites

As IPsec is a subset of IP protocol suite and is fully dependent on IP stack functionality, a fully useful IP stack enables IP network packet flow, necessary for IPsec protocol service.

## Implementation of IPsec in AUTOSAR AP stack

Adaptive Platform does not specify any operating system for an Electronic Control Unit (ECU) and as of that, implementing state-of-the-art IPsec functionality along with best practices, it is the stack vendor responsibility.

This goal can be achieved without engaging any higher network stack level, i.e. com- munication channel established with IPsec would be fully transparent for AUTOSAR Adaptive Platform Communication Management functional cluster, thus for Adaptive Applications as well.

The following picture outlines the design of the AUTOSAR Adaptive stack. The func- tionality of the stack, presented below Communication Management there, is defined in AUTOSAR Adaptive Platform documentation only in the Specification of Manifest \[17\], what is represented as 'IKE config' and 'IPsec config' here.

### This is only an example, based on Linux architecture and might require some modifications for other operating systems.

![](./media/image4.png){width="6.32625in" height="4.403437226596675in"}

**Figure 4.1: Communication with IPsec in AUTOSAR Adaptive Platform**

## Operating System kernel with an IP stack

As mentioned above, IPsec requires OS usage of an IP stack, usually located in the kernel area. Being just a subset of the IP protocol suite, and a part of the IP stack in the end, IPsec would need to be integrated with the bare IP stack. That would be routinely obtained with compiling OS kernel along with IP stack and IPsec modules.

## Kernel IPsec module

Most of current operating systems offer modern IP stack modules, extensible with IPsec functionality. They should be applied along with filtering modules (like e.g. the XFRM Framework in Linux), allowing packet management according to IPsec rules, as described in Specification of Manifest \[17\].

IPconfig part defined in Specification of Manifest would be typically represented as security policies, forming security policies database, but it depends on implementation in the end.

## IKE module

In order to make IPsec operative an Internet Key Exchange (IKE) module is needed. Typically, it would not be a part of the kernel space and require separated integration.

For AUTOSAR Adaptive Platform IKE version 2 should be used. IKEv2 provides mod- ern security options and is eventually easier to implement.

IKE config would usually stand for a configuration file.

IKE module needs to be initialised during boot process in order to make sure all nec- essary security associations would be ready before the node starts communication.

# Detailed requirements for IPsec implementation

While integrating IPsec in AUTOSAR Adaptive Platform, the following requirements should be met. That would ensure compatibility and superior security posture.

1. ## IPsec shall be implemented based on the following standards:

   - \"Security Architecture for the Internet Protocol\" \[2\]
   - \"Authentication Header (AH)\" \[3\]
   - \"Encapsulating Security Payload (ESP)\" \[4\]
    - 500/UDP: IKEv2 packets
    - 4500/UDP: IKEv2 packets
    - 6801/TCP: Diagnostics

```{=html}
<!-- -->
```

6. # Further guidance

   1. ## Multicast communication

Multicast communication secured with IPsec is currently not planned for AUTOSAR Adaptive Platform, what simplifies key management and reduces the risk of a key dis- closure.

These benefits for smaller networks, like in-vehicle network, would usually prevail.

## Retry for key update

If the peer ECU is not available when keys shall be updated, the ECU retries, whether the peer ECU is available again. That way security association can be obtained despite a temporary node unavailability.

## Backward Compatibility

Electronic Control Units with IPsec support shall allow integration into vehicles, in which their communication partners do not support IPsec. Configuration options for either IP or IPsec communication for specific peers shall be available.

## Filtering with IPsec rules

The ECU shall support that certain application sockets - IP address, protocol, and port number - can only be connected using IPsec.

## Patch Management

It is highly recommended to check, if there is an update available for libraries integrated in the IPsec kernel module or IKE module, and apply them whenever possible.

## Security Functions Development

When there is a new cryptographic function available, like e.g. new encryption algo- rithm, it would make sense to introduce it. It would work reasonable, however, only when performed based on approved RFC documents.

# Supplementary information

The above mentioned requirements should not be regarded as exhaustive, and the final implementation does not need to be restricted to them.

In particular, documentation specific to software packets picked out for integration with the operating system stack should be taken into consideration.

# Related documentation

\[1 \] AUTOSAR Specifications in general \[2 \] RFC 4301
\[16 \] Specification of Manifest

# Acronyms and Abbreviations

The glossary below includes acronyms and abbreviations relevant to the explanation of IPsec implementation in AUTOSAR Adaptive Platform.

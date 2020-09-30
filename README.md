# Ninayo Mimi: Concept Note

## Goal
Provide shareable, reliable identities that can be trusted across organisations.
## Role Players
1. Consumers: Consumers identify themselves in a range of scenarios from KYC, to crop delivery. Veracity of identity will vary wildly.
2. Data Capturers: Capture profile information and transactions that (may) augment our understanding of individual consumers. Capturers belong to organisations.
3. Organisations: Provide the context in which a customer exists. Own any data.

## Identifiers
All role players are identified by a collection of identifiers, and identity strings. For example:

1. An MNO name and MSISDN.
1. A country identification document name, and the identity number. For example, “ZA Identity Number” and “7208094087086”.
1. A Kenyan Drivers License: “Kenyan Drivers License” and “WLX165”.
1. An email address: “Email” and “joe@example.com”.

Mimi managed reference numbers will be of the form: “Mimi” and a UUID: “81e124dc-0729-4e89-a918-c9d1a37c52cd”.

## Transactions

### Data Submission
Submitted data can be considered in three broad categories:
- Registration. For example:
  - Farmer is registered by a field worker employed by Ninayo (or by a partner, or approved company). Basic details are captured.
  - A farmer dials a USSD short code and their interaction triggers a registration.
  - A previously unknown farmer can make a delivery. In which case, they are automatically registered.

- Deposits: transactions in which value transfers from the customer, to the business registering the transaction. These transactions are expensive for the consumer and, as such, imply a relatively high degree of certainty that the consumer will identify themselves). For example:
  - Crop deliveries
  - Deposit payments
- Withdrawals: transactions in which value transfers from a business, to the consumer. These transactions are implicitly less certain than deposit transactions. For example:
  - A loan disbursal
  - Input delivery

Note that technically, these transactions are identical. We label them independently so that we can assess the veracity of the transactions. In all cases the transaction content is identical: data is submitted, and an identifier is returned.

### Requested Data
Customer data will either be requested by an independent, public source. Or, by the organisational custodian of the data.

A request for “public” data will receive a name, photo and region. In contrast, an organisation will receive back a JSON structure reflecting all the data submitted by that organisation.
### Other Operations
A range of other operations will be required:

1. Merge (to consolidate profiles)
1. Organisation registration (to create an organisation to own submitted data) can be done with the core customer registration API.
1. Delete (either an identifier associated to a profile, or an entire profile).
1. Audit trail: Get a complete, blockchain backed, history of all actions associated with a profile.

## Model
![Overview](/model.png?raw=true)

### Consumer Identifiers
#### Merge Operations
Inevitably, profiles will turn out to reflect the same person. In this case, they will need to be merged. By implication, multiple consumer identifiers will need to map to a single profile.

#### Uniqueness
Consumer identifiers are specific to a business. Thus a business will be able to access KYC documents that they uploaded. They will not be able to access KYC documents that another business uploaded.

To make this practical, each customer will have a unique identifier, but the business will be able to access the data they have uploaded using their identifier.

## Conceptual API Requests

### Register, deposit and withdraw
> Registers new customers, and returns an identifier.
`submission`
#### Inputs
1. Business UUID (Required)
1. The capturer UUID (organisations will need to register users; required).
1. Customer identifier pair (eg MNO name and MSISDN)
1. A JSON object of customer detail (name = ‘Fred’ etc), or MIME encoded  documents (such as photos).

#### Outputs
1. A UUID uniquely identifying the submission
1. A UUID identifying the customer
1. A UUID identifying the transactiontr

Note: The customer UUID will be specific to the organisational source.

### Merge
> Merges a collection of customer identifiers.

Flags a collection of profiles as belonging to a single entity. Data will be merged, with the most recent data prevailing. However, the UUIDs and other identifiers identifying a customer to a source will not change.

### Lookup
> A publicly accessible API that returns publicly accessible data.

#### Inputs
1. Customer or transaction UUID.
#### Outputs
- A JSON object comprising of:
  - Customer full name
  - Primary photo (or selfie)
  - Region

If the referenced UUID refers to a transaction, the returned JSON structure will include an assessment of the confidence of this identity.

### Profile
> Returns the entire customer profile.

#### Inputs
1. The business and customer UUIDs (required).

#### Outputs
1. A JSON document detailing all known parameters.

### Delete
> Returns the deleted data.

#### Inputs
1. Business UUID (required)
1. Deleter UUID (required)
1. Customer identifier pair (eg MNO name and MSISDN)

### Audit
> Returns a complete history of this profile read from the blockchain.
>
#### Inputs
1. The business and customer UUIDs (required).

#### Returns
1. A JSON all changes to the profile.




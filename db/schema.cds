namespace incident_management;

using { sap.common.CodeList } from '@sap/cds/common';

entity Incidents
{
    key ID : UUID;
    title : String(100);
    customer : Association to one Customers;
    conversations : Composition of many Conversations on conversations.incidents = $self;
    status : Association to one Status;
    urgency : Association to one Urgency;
}

entity Customers : CodeList
{
    key ID : UUID;
    FirstName : String(100);
    LastName : String(100);
    Email : String(100);
    Phone : String(100);
    incidents : Association to many Incidents on incidents.customer = $self;
}

entity Conversations : CodeList
{
    key ID : UUID
        @Core.Computed;
    timestamp : DateTime
        @cds.on.insert : $now;
    author : String(100)
        @cds.on.insert : $user;
    message : String(100);
    incidents : Association to one Incidents;
}

entity Status : CodeList
{
    key code : StatusCode;
    criticality : Integer;
}

entity Urgency : CodeList
{
    key code : UrgencyCode;
}

type StatusCode : String enum
{
    new = 'N';
    assigned = 'A';
    in_process = 'I';
    on_hold = 'H';
    resolved = 'R';
    closed = 'C';
}

type UrgencyCode : String enum
{
    high = 'H';
    Medium = 'M';
    Low = 'L';
}

using { incident_management as my } from '../db/schema.cds';

@path : '/service/incident_managementService'
service incident_managementService
{
    @odata.draft.enabled
    entity Incidents as
        projection on my.Incidents;

    entity Customers as
        projection on my.Customers
        {
            *,
            FirstName || ' ' || LastName as name : String
        };

    entity Conversations as
        projection on my.Conversations;

    entity Status as
        projection on my.Status;

    entity Urgency as
        projection on my.Urgency;
}

annotate incident_managementService with @requires :
[
    'authenticated-user'
];

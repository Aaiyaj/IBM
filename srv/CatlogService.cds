using { aaiyaj.db.master, aaiyaj.db.transaction } from '../db/dataModel';
using { cappo.cds } from '../db/CDSViews';

//service CatlogService @(path:'CatlogService' ){

//entity EmplyoeeSet as projection on master.employees;
   

//}
extend aaiyaj.db.transaction.purchaseorder with {
    virtual PRIORITY : String(10);
};

service CatalogService @(path:'CatalogService') {

    @Capabilities : { Insertable, Deletable: false }
    entity BusinessPartnerSet as projection on  master.businesspartner;
    entity AddressSet as projection on master.address;
    //@readonly
    entity ProductSet as projection on master.product;
    entity EmployeeSet as projection on master.employees;
    entity PurchaseOrderItems as projection on transaction.poitems;
    entity POs @(odata.draft.enabled:true) as projection on transaction.purchaseorder{
        *,
        //round(GROSS_AMOUNT) as GROSS_AMOUNT: Decimal(10,2),
        case OVERALL_STATUS
        when 'P' then 'Paid'
        when 'N' then 'New'
        when 'X' then 'Rejected'
        when 'A' then 'Approved'
        end as ovralstatus: String(10),
         case OVERALL_STATUS
        when 'P' then '3'
        when 'N' then '2'
        when 'X' then '1'
        when 'A' then '3'
        end as iconColor: Integer,
        Items: redirected to PurchaseOrderItems
    }actions{
        action boost() returns POs;
        //function largestOrder() returns array of POs;
    };
    function largestOrder() returns POs;
   // entity CProductValuesView as projection on cds.CDSViews.CProductValuesView;

}
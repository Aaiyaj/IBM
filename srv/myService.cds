using { aaiyaj.db.master } from '../db/dataModel';

service MyService @(path: 'MyService') {

    function hello(name:String) returns String;

  entity EmployeeSrv as projection on master.employees;

}
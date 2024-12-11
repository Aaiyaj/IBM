module.export = (srv)=> {

    srv.on('hello', (req) => {
        let myName = req.data.name;
        return "Hello " +myName;
    
    });

    const { employees } = cds.entities("aaiyaj.db.master");

    srv.on('READ', EmployeeSrv, async (req) => {
        const tx = cds.tx(req);
        var data = await tx.run(SELECT.from(employees).where({
            "Currency_Code":"USD"
        }).limit(3));
        data.push({
            "ID": "AYZ",
            "firstName":"Aaiyaj",
            "lastName":"Pathan"
        });
        return data;
    });
};
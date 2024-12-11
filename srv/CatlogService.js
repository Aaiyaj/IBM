module.exports = cds.service.impl( async function() {

    const { EmployeeSet, POs } = this.entities;

    this.before('UPDATE', EmployeeSet, (req) => { 

        if(req.data.salaryAmount >= 10000){
            req.error(500,"Dude,this is too much salary");
        }
    });
    

this.on('boost', async (req, res) => {
    try {
        const ID = req.params[0];
        console.log("Hey your purchase order with id "+JSON.stringify(ID) + " will be boosted" );
        const tx = cds.tx(req);
        await tx.update(POs).with({
            GROSS_AMOUNT: { '+=' : 20000 }
        }).where(ID);
        var myData = tx.read(POs).where(ID);
        return myData;
    } catch (error) { 
        return "error " + error.toString();
        
    }
    
});
const setPriority = (data) => {
    if(data){
        data.map( (record) => {
            if(parseInt(record.TAX_AMOUNT) > 500){
                record.PRIORITY = "HIGH";
            }
            else {
                record.PRIORITY = "LOW";
            }
        });
    }
}
this.after('READ', POs, (data) => {
    setPriority(data);
});
this.on('largestOrder', async (req, res) => {
    try {
        const tx = cds.tx(req);

        const reply = await tx.read(POs).orderBy({
            GROSS_AMOUNT: 'desc'
        }).limit(1);
        return reply;
    } catch (error) { 
        return "error " + error.toString();
    }  
    
})
});
namespace mycapapp.commons;

type Guid : String(40);

aspect address {
    houseNo  : Integer;
    landMark : String(80);
    city     : String(80);
    country  : String(2);
}

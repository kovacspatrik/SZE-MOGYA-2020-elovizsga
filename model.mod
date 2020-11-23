param nRows;
set Rows:=1..nRows;

param cashierCount;
param cashierLength;

set ProductGroups;
param space{ProductGroups};

var BuildingLength;

#Variables
var put {ProductGroups, Rows} binary;
var rowLength{Rows};
var putCashier{Rows} binary;
var maxRowLength;
#Constraints
s.t. EveryProductInExactlyOneRow {p in ProductGroups}:
	sum{r in Rows} put[p,r]=1;

s.t. PutCashierInRows:
	sum {r in Rows} putCashier[r] = cashierCount;

s.t. RowsWithCashiersAreLonger{r in Rows}:
	rowLength[r] = putCashier[r]*cashierLength + sum{p in ProductGroups} put[p,r]*space[p];

s.t. MaxRowLength{r in Rows}:
	maxRowLength >= rowLength[r];

minimize maxRowLength;

solve;

/*for {r in Rows}
{
	printf "Row %d: ",r;
	for {p in ProductGroups:put[p,r]==1} 
	{
		printf "%s (%f) ",p, space[p];
	}
	printf "%f ", rowLength[r];
	printf "Kasszak: %d", putCashier[r];
	printf "\n";
}*/
printf "%f",maxRowLength;

end;

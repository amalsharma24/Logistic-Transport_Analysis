Create schema expeditors;
use expeditors;
CREATE Table branch_dim (
    branch VARCHAR (45) NOT NULL,
	region_level1 VARCHAR (45),
    region_level2 VARCHAR (45),
    PRIMARY KEY(branch))
    
    insert into branch_dim values('Seattle', 'US','US_Northwest');
    insert into branch_dim values('Shanghai', 'China','China_East');
    insert into branch_dim values('Amsterdam', 'Netherlands','Netherlands_west');
    insert into branch_dim values('Chicago', 'US','US_Northeast');
    insert into branch_dim values('Los Angeles', 'US','US_Northwest');
    		
     Drop TABLE file_dim;
    CREATE Table file_dim (
    file_dim_id VARCHAR (45) NOT NULL,
	shipment_id VARCHAR (45),
    file_number VARCHAR (45),
    file_type VARCHAR (45),
    PRIMARY KEY(file_dim_id))

insert into file_dim values('1', '10','ABC_1','A');
insert into file_dim values('2', '20','ABC_1','A');
insert into file_dim values('3', '30','ABC_2','B');
insert into file_dim values('4', '40','ABC_3','C');
insert into file_dim values('5', '50','ABC_3','C');
insert into file_dim values('6', '60','ABC_4','D');
insert into file_dim values('7', '70','ABC_1','A');

    
    CREATE Table shipment (
    shipment_id VARCHAR (45) NOT NULL,
	origin_branch VARCHAR (45),
    destination_branch VARCHAR (45),
    month_number VARCHAR (45),
    weight_kg VARCHAR (45),
    PRIMARY KEY(shipment_id))
    
    
    insert into shipment values('10','Seattle','Shanghai','1','20');
    insert into shipment values('20','Seattle','Chicago','2','30');
    insert into shipment values('30','Chicago','Shanghai','2','40');
    insert into shipment values('40','Amsterdam','Shanghai','3','50');
    insert into shipment values('50','Amsterdam','Seattle','3','60');
    insert into shipment values('60','Shanghai','Chicago','4','70');
    insert into shipment values('70','Seattle','Shanghai','4','80');
  
    Drop TABLE revenue;
	CREATE Table revenue (
    invoice VARCHAR (45) NOT NULL,
	file_number VARCHAR (45),
    client_name VARCHAR (45),
    date DATETIME,
    revenue_branch VARCHAR (45),
    revenue_type VARCHAR (45),
    revenue_usd VARCHAR (45),
    PRIMARY KEY(invoice))
    
    insert into revenue values('10','ABC_1','James','2021-01-29','Seattle','Ground','100');
    insert into revenue values('20','ABC_1','James','2021-02-28','Seattle','Ground','100');
    insert into revenue values('30','ABC_2','James','2021-02-28','Chicago','Ground','100');
    insert into revenue values('40','ABC_3','James','2021-03-29','Amsterdam','Ground','100');
    insert into revenue values('50','ABC_3','James','2021-03-29','Amsterdam','Ground','100');
    insert into revenue values('60','ABC_4','James','2021-04-29','Shanghai','Ground','100');
    insert into revenue values('70','ABC_1','James','2021-04-29','Seattle','Ground','100');
    
    Select * from revenue;
    
# Database Individual Project
# GH1027535
# ABC Company Database

# CREATION OF Database

create database database_individual_project;

use database_individual_project;

# CREATION OF TABLES

create table customer_management(
	id INT auto_increment primary key,
	full_name varchar(50) not null,
	email varchar(100) not null,
	last_login datetime not null,
	password varchar(20) not null,
	tel_number varchar(20) not null
);

select * from customer_management cm 

create table customer_address(
	id INT auto_increment primary key,
	customer_id INT not null,
	street varchar(200) not null,
	district varchar(200) not null,
	city varchar(200) not null,
	postal_code varchar(200) not null,
	country varchar(200) not null,
	foreign key (customer_id) references customer_management(id)
);

create table suppliers(
	id INT auto_increment primary key,
	name varchar(50) not null,
	address varchar(200) not null,
	email varchar(100) not null,
	tel_number varchar(15) not null
);

create table product_catalog(
	id INT auto_increment primary key,
	name varchar(50) not null,
	supplier_id INT not null,
	description varchar(200),
	price dec(10,2) not null,
	category varchar(20) not null,
	images varbinary(256),
	tags varchar(200) not null,
	comments int,
	foreign key (supplier_id) references suppliers(id)
);


create table order_management(
	id INT auto_increment primary key,
	customer_id INT not null,
	date date not null,
	foreign key (customer_id) references customer_management(id)
);

create table ordered_items(
	id INT auto_increment primary key,
	order_id INT not null,
	product_id INT not null,
	quantity INT not null,
	foreign key (order_id) references order_management(id),
	foreign key (product_id) references product_catalog(id)
); 

create table deliveries(
	id INT auto_increment primary key,
	ordered_items_id INT not null,
	address_id INT not null,
	delivery_date date not null,
	delivery_type varchar(200) not null,
	status varchar(200) not null,
	foreign key (ordered_items_id) references ordered_items(id),
	foreign key (address_id) references customer_address(id)
);

create table returned_items(
	id INT auto_increment primary key,
	ordered_items_id INT not null,
	quantity_returned INT not null,
	reason_for_return varchar(200) not null,
	foreign key (ordered_items_id) references ordered_items(id)
);

# CREATION OF TRIGGERS

delimiter

create trigger update_ordered_items_return
after insert on returned_items
for each row
	update ordered_items
	set quantity = quantity - new.quantity_returned
	where id = new.ordered_items_id
	
delimiter
	
# INPUT SAMPLE DATA INTO TABLES

# 1) CUSTOMER_MANAGEMENT DATA

insert into customer_management(full_name, email, last_login, password, tel_number)
values ('Tom Cruise', 'Tom.Cruise@gmail.com', '2020-06-12 10:34', 'CTom#123', '+49 253-205-1592');

insert into customer_management(full_name, email, last_login, password, tel_number)
values ('Tina Turner', 'Tina.Turner@gmail.com', '2023-03-24 14:24', 'TTina#123', '+49 415-716-8370');

insert into customer_management(full_name, email, last_login, password, tel_number)
values ('Jennifer Lawrence', 'Jennifer.Lawrence@gmail.com', '2024-01-08 08:45', 'LJennifer#123', '+49 915-497-0200');

insert into customer_management(full_name, email, last_login, password, tel_number)
values ('Tom Hardy', 'Tom.Hardy@gmail.com', '2023-12-12 18:56', 'HTom#123', '+49 918-481-4952');

insert into customer_management(full_name, email, last_login, password, tel_number)
values ('Charlie Hunnam', 'Charlie.Hunnam@gmail.com', '2024-05-13 00:12', 'HCharlie#123', '+49 920-674-3325');

insert into customer_management(full_name, email, last_login, password, tel_number)
values ('Vera Farmiga', 'Vera.Farmiga@gmail.com', '2024-02-19 07:18', 'FVera#123', '+49 520-895-0522');

insert into customer_management(full_name, email, last_login, password, tel_number)
values ('Freddie Highmore', 'Freddie.Highmore@gmail.com', '2023-11-27 22:45', 'HFreddie#123', '+49 703-562-2821');

insert into customer_management(full_name, email, last_login, password, tel_number)
values ('Elvis Presley', 'Elvis.Presley@gmail.com', '2024-06-09 11:42', 'PElvis#123', '+49 361-524-1919');

insert into customer_management(full_name, email, last_login, password, tel_number)
values ('Sophie Turner', 'Sophie.Turner@gmail.com', '2024-04-12 13:30', 'TSophie#123', '+49 708-293-0839');

insert into customer_management(full_name, email, last_login, password, tel_number)
values ('Julia Roberts', 'Julia.Roberts@gmail.com', '2023-12-29 20:23', 'RJulia#123', '+49 512-415-8817');

# 2) CUSTOMER ADDRESS
# https://www.calculatormix.com/generators/random-europe-address/?utm_content=cmp-true

insert into customer_address(customer_id, street, district, city, postal_code, country)
values('1', '77E Warszawska Street', 'Warsaw West County', 'Masovian Voivodeship', '05-082', 'Poland');

insert into customer_address(customer_id, street, district, city, postal_code, country)
values('1', '25 Yanusha Korchaka Street', 'Shevchenkivskyi', 'Kyiv', '03190', 'Ukraine');

insert into customer_address(customer_id, street, district, city, postal_code, country)
values('2', '2 Warren Crescent', 'Fingal', 'Blanchardstown', 'D20 V256', 'Ireland');

insert into customer_address(customer_id, street, district, city, postal_code, country)
values('3', '6 Cami de Rojals', 'Conca de Barbera', 'Vilaverd', '43490', 'Espana');

insert into customer_address(customer_id, street, district, city, postal_code, country)
values('3', '13 Koningin Julianalaan', 'Ouder-Amstel', 'North Holland', '1191 CD', 'Netherlands');

insert into customer_address(customer_id, street, district, city, postal_code, country)
values('4', '8 Geodetow', 'Piaseczno', 'Masovian Voivodeship', '05-500', 'Poland');

insert into customer_address(customer_id, street, district, city, postal_code, country)
values('5', '104 Wickham Road', 'Greater London', 'London', 'CR0 8BE', 'United Kingdom');

insert into customer_address(customer_id, street, district, city, postal_code, country)
values('6', '9 Klasykow', 'Masovian Voivodeship', 'Warsaw', '03-115', 'Poland');

insert into customer_address(customer_id, street, district, city, postal_code, country)
values('7', '13 Rue du Pont Royal', 'Antony', 'Bagneux', '92220', 'France');

insert into customer_address(customer_id, street, district, city, postal_code, country)
values('8', '71 Via Giuseppe Di Vittorio', 'Milan', 'San Donato Milanese', '20097', 'Italy');

insert into customer_address(customer_id, street, district, city, postal_code, country)
values('9', '2 Camono a la Finca del Pigarron', 'Las Vegas', 'San Martin de la Vega', '28330', 'Espana');

insert into customer_address(customer_id, street, district, city, postal_code, country)
values('9', '4 Bradley Lane', 'KG Neubau', 'Vienna', '1070', 'Austria');

insert into customer_address(customer_id, street, district, city, postal_code, country)
values('10', '7 Rue Eugene Pottier', 'Nogent-sur-Marne', 'Champigny-sur-Marne', '94500', 'France');

insert into customer_address(customer_id, street, district, city, postal_code, country)
values('10', '1 Hudgen Close', 'North Yorkshire', 'Pickering', 'YO18 7ES', 'United Kingdom');

# 3) SUPPLIER DATA
# reference - https://www.fakeaddressgenerator.com/usa_address_generator

insert into suppliers(name, address, email, tel_number)
values('Crazy Store', '3785 Blackwell Street, Cordova, Oregon, 99574, USA', 'supply@H&M.com', '+1 541-325-8432');

insert into suppliers(name, address, email, tel_number)
values('Afro Bob', '4864 Romrog Way, Curtis, Nebraska, 69025, USA', 'supply@nordstrom.com', '+1 253-631-0281');

insert into suppliers(name, address, email, tel_number)
values("Kimberley's Treasure", '2162 Birch Street, El Paso, Texas, 79936, USA', 'supply@kimberleys.com', '+1 915-487-5429');

insert into suppliers(name, address, email, tel_number)
values('Titus Warehouse', '3561 Chipmunk Lane, Portland, Maine, 04101, USA', 'supply@tituswarehouse.com', '+1 207-774-5700');

insert into suppliers(name, address, email, tel_number)
values('Sullivan Supplies', '2995 Red Dog Road, Honolulu, Hawaii, 96801, USA', 'supply@sullivan.com', '+1 704-319-8382');

insert into suppliers(name, address, email, tel_number)
values('Supplies&Stuff', '2714 Fannie Street, Houston, Texas, 77002, USA', 'supply@suppliesnstuff.com', '+1 979-227-6528');

insert into suppliers(name, address, email, tel_number)
values('Traynor Inc.', '2699 Grant View Drive, Milwaukee, Wisconsin, 53223, USA', 'supply@TraynorInc.com', '+1 414-371-9902');

insert into suppliers(name, address, email, tel_number)
values('Anna Sophia Boutique', '4538 Woodland Terrace, Sacramento, California, 95814, USA', 'supply@annasophia.com', '+1 916-996-6652');

insert into suppliers(name, address, email, tel_number)
values('Lacourse Fabricks', '1250 Leroy Lane, Rapid City, South Dakota, 57701, USA', 'supply@lacourse.com', '+1 605-484-2286');

insert into suppliers(name, address, email, tel_number)
values('Tampa Produce', '611 County Line Road, Tampa, Florida, 33602, USA', 'supply@tampaproduce.com', '+1 813-380-5896');

# 4) PRODUCT_CATALOG DATA 

insert into product_catalog (name, supplier_id, description, price, category, images, tags, comments)
values('carnival popcorn', '1', 'Multicoloured, multi-flavoured popcorn, specially to brighten and day and activities! Very popular for kids, but adults can also enjoy.','1.99', 'food', '' ,'low on stock', '5');

insert into product_catalog(name, supplier_id, description, price, category, images, tags, comments)
values('alien spray', '1', 'Sour, sour, sour alien spray, made to taste yummy and to have lots of laughs!', '3.99', 'food', '', 'in stock', '4');

insert into product_catalog(name, supplier_id, description, price, category, images, tags, comments)
values('hot flavour jaw breaker', '1', 'Balls of fire! Hellish, tasty flavours!', '2.99', 'food', '', 'in stock', '3');

insert into product_catalog(name, supplier_id, description, price, category, images, tags, comments)
values('gedore toolbox set', '4', 'All the necessary tools in a mini toolbox set. Mobile and easily transported. Handy for any handyman!', '49.99', 'Hardware', '', 'in stock', '5');

insert into product_catalog(name, supplier_id, description, price, category, images, tags, comments)
values('lag bolts 1/4 inch 4 piece', '5', 'Heavy-duty bolts, made spcifically for wood', '7.99', 'Hardware', '', 'out of stock', '5');

insert into product_catalog(name, supplier_id, description, price, category, images, tags, comments)
values('princess dress black small', '7', 'Mini black dress, necessary for any girl to have in her closet!', '29.99', 'fashion', '', 'in stock', '3');

insert into product_catalog(name, supplier_id, description, price, category, images, tags, comments)
values('c&a skinny jeans 32 long', '7', 'The balance between professional and fun!', '19.99', 'fashion', '', 'in stock', '4');

insert into product_catalog(name, supplier_id, description, price, category, images, tags, comments)
values('mrs. balls chutney 750 ml', '2', 'Peachy chutney to put flavour in your food!', '1.99', 'food', '', 'in stock', '5');

insert into product_catalog(name, supplier_id, description, price, category, images, tags, comments)
values('baggy trousers grey 36', '9', 'Comfy pants to for lounging at home...', '19.99', 'fashion', '', 'in stock', '2');

insert into product_catalog(name, supplier_id, description, price, category, images, tags, comments)
values('hello kitty onesy pink/white medium', '9', 'Comfy Hello Kitty onesy pajama set that will keep you warm through the snowy Winter...', '24.99', 'fashion', '', 'out of stock', '5');

insert into product_catalog(name, supplier_id, description, price, category, images, tags, comments)
values('shakespear romeo and juliet 2010 reprint', '3', 'Reprint of the famous Romeo and Juliet with explanatory notes included!', '18.99', 'books', '', 'in stock', '1');

insert into product_catalog(name, supplier_id, description, price, category, images, tags, comments)
values('elvive shampoo and conditioner 6x value pack', '6', 'Save your time and money with this treasure! Buy 3x 500ml Elvive shampoo and 3x 500ml Elvive conditioner at an astonishing 50% discount!', '18.99', 'hygiene', '', 'in stock', '5');

insert into product_catalog(name, supplier_id, description, price, category, images, tags, comments)
values('marc jacobs daisy wild perfume 60 ml', '8', 'Smell fresh like a daisy with this new fragrance from Marc Jacobs!', '49.99', 'cosmetics', '', 'no stock', '5');

insert into product_catalog(name, supplier_id, description, price, category, images, tags, comments)
values('fruit & veg cherries 2 kg', '10', 'Sweet and fresh for longer!', '5.99', 'food', '', 'in stock', '4');

# 5) ORDER_MANAGEMENT DATA

insert into order_management (customer_id, date)
values('1', '2024-06-27');

insert into order_management (customer_id, date)
values('4', '2024-06-25');

insert into order_management (customer_id, date)
values('9', '2024-06-12');

insert into order_management (customer_id, date)
values('7', '2024-04-15');

insert into order_management (customer_id, date)
values('3', '2023-05-30');

insert into order_management (customer_id, date)
values('2', '2022-02-19');

insert into order_management (customer_id, date)
values('6', '2019-07-12');

insert into order_management (customer_id, date)
values('10', '2024-05-13');

insert into order_management (customer_id, date)
values('5', '2024-02-26');

insert into order_management (customer_id, date)
values('3', '2023-08-15')

# 6) ORDERED_ITEMS DATA

insert into ordered_items (order_id, product_id, quantity)
values('1', '1', '2');

insert into ordered_items(order_id, product_id, quantity)
values('1', '4', '1');

insert into ordered_items(order_id, product_id, quantity)
values('2', '13', '1');

insert into ordered_items(order_id, product_id, quantity)
values('3', '1', '1');

insert into ordered_items(order_id, product_id, quantity)
values('3', '6', '1');

insert into ordered_items(order_id, product_id, quantity)
values('4', '2', '3');

insert into ordered_items(order_id, product_id, quantity)
values('5', '7', '1');

insert into ordered_items(order_id, product_id, quantity)
values('6', '3', '1');

insert into ordered_items(order_id, product_id, quantity)
values('6', '4', '1');

insert into ordered_items(order_id, product_id, quantity)
values('7', '14', '5');

insert into ordered_items(order_id, product_id, quantity)
values('7', '11', '1');

insert into ordered_items(order_id, product_id, quantity)
values('7', '9', '1');

insert into ordered_items(order_id, product_id, quantity)
values('8', '6', '1');

insert into ordered_items(order_id, product_id, quantity)
values('9', '4', '4');

insert into ordered_items(order_id, product_id, quantity)
values('10', '5', '1');

# 7) ORDERED_ITEMS DATA

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('1', '2', '2024-06-28', 'urgent', 'processing');

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('2', '2', '2024-06-28', 'standard', 'dispatched');

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('3', '3', '2024-07-10', 'standard', 'delayed');

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('4', '5', '2024-06-15', 'standard', 'delivered');

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('5', '4', '2024-06-15', 'standard', 'delivered');

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('6', '6', '2024-04-17', 'standard', 'delivered');

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('7', '7', '2023-06-03', 'standard', 'delivered');

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('8', '8', '2022-02-21', 'standard', 'delivered');

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('9', '8', '2022-02-21', 'standard', 'delivered');

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('10', '9', '2019-07-16', 'standard', 'delivered');

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('11', '9', '2019-07-16', 'standard', 'delivered');

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('12', '9', '2019-07-16', 'standard', 'delivered');

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('13', '10', '2024-05-16', 'standard', 'delivered');

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('14', '12', '2024-02-28', 'standard', 'delivered');

insert into deliveries (ordered_items_id, address_id, delivery_date, delivery_type, status)
values('15', '13', '2023-08-17', 'standard', 'delivered');
 

# 7) RETURNED_ITEMS DATA

insert into returned_items (ordered_items_id, quantity_returned, reason_for_return)
values('7', '1', 'Defective');

insert into returned_items(ordered_items_id, quantity_returned, reason_for_return)
values('8', '1', 'Personal');

insert into returned_items(ordered_items_id, quantity_returned, reason_for_return)
values('9', '1', 'Defective');

insert into returned_items(ordered_items_id, quantity_returned, reason_for_return)
values('6', '2', 'Defective');

insert into returned_items(ordered_items_id, quantity_returned, reason_for_return)
values('11', '1', 'Defective');
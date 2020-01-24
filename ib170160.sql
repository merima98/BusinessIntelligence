create database ib170160_publikacijeDW
go

use ib170160_publikacijeDW
go

use publikacije 
go

--TABELE 

--tabela 1 
select*  into ib170160_publikacijeDW.dbo.dim_forma_pub
from forma_pub

use ib170160_publikacijeDW
go

alter table dim_forma_pub
add forma_pub_Key int identity (1,1) constraint forma_pub_Key_PK primary key
go

delete from dim_forma_pub
go

select * from dim_forma_pub
go

--TABELA 2
use publikacije 
go

select*  into ib170160_publikacijeDW.dbo.dim_zanr
from zanr
go

use ib170160_publikacijeDW
go

alter table dim_zanr
add zanr_Key int identity (1,1) constraint zanr_Key_PK primary key
go

delete from dim_zanr
go

select * from dim_zanr
go

--TABELA 3
create table dim_autor 
(
autor_Key int identity (1,1) constraint pk_autor_Key primary key , 
autor_ID int , 
naziv_grada_autora nvarchar(30), 
spol_autora nvarchar(1), 
pub_ID int
)
go

--TABELA 4
create table dim_citalac
(
citalac_Key int identity (1,1) constraint pk_citalac_Key primary key, 
citalac_ID int, 
naziv_grada_citaoca nvarchar(30), 
spol_citaoca nvarchar(1), 
dtm_podizanja datetime, 
dtm_vracanja datetime ,
 br_dana_zadr int, 
 pub_ID int 
)
go

--TABELA 5
create table dim_izdavac
(
izdavac_Key int identity (1,1) constraint pk_izdavac_Key primary key ,
izdavac_ID int, 
naziv_grada_izdavaca nvarchar(30), 
naziv_izdavaca nvarchar(50)
)
go

--TABELA CINJENICA:
create table fact_publikacija
(
publikacija_Key int identity(1,1) constraint pk_publikacija_Key  primary key, 
pub_ID  int, 
naziv_pub nvarchar(50), 
ISBM nvarchar(25) ,
cijena float, 
forma_pub_Key int constraint fk_forma_pub_Key foreign key(forma_pub_Key) references dim_forma_pub(forma_pub_Key), 
zanr_Key int constraint fk_zanr_Key foreign key (zanr_Key) REFERENCES dim_zanr(zanr_Key), 
autor_Key int constraint fk_autor_Key foreign key (autor_Key) references dim_autor(autor_Key), 
citalac_Key int constraint fk_citalac_Key foreign key (citalac_Key)references dim_citalac(citalac_Key), 
izdavac_Key int constraint fk_izdavac_Key foreign key (izdavac_Key) references dim_izdavac(izdavac_Key)
)
go


--provjera da li je sve popunjeno:
select * from dim_forma_pub
go

SELECT * FROM	dim_autor
GO

SELECT * FROM dim_zanr
GO

SELECT * FROM dim_citalac
GO

SELECT * FROM dim_izdavac
GO

select * from fact_publikacija
go
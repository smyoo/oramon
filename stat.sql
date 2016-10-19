/***********************************************
<<Desciption>>
display SQL plan statistics

<<Usage>>
SQL> @stat
************************************************/

@env

select * from table (dbms_xplan.display_cursor(null,null,'allstats cost last'));


create or replace procedure Calculo(sol_ID in sacramento.id_solicitud%type) as
CURSOR P_CURSOR is select 
    s.id_solicitud as ID,s.id_sacramento as posicion,c.nombre_c as Cliente, 
    s.tipo_s As Sacramento,ex.tipo_exs As Servicio ,
    s.precio_s as Precio_s,ex.pago_exs as Precio_Ex from sacramento s
    inner join  solicitud_de_cliente sc on sc.id_solicitud = s.id_solicitud
    inner join  extraservicio ex  on ex.id_extraservicio = s.id_extraservicio
    inner join  cliente c on c.id_cliente = sc.id_cliente
    where s.id_solicitud= sol_ID;
CURSOR T_CURSOR is select
    s.id_solicitud as Solicitud, sum(s.precio_s + ex.pago_exs)  as Totalpagado,
    count(s.id_sacramento) as total from sacramento s
    inner join  solicitud_de_cliente sc on sc.id_solicitud = s.id_solicitud
    inner join  extraservicio ex  on ex.id_extraservicio = s.id_extraservicio
    where sc.id_solicitud=sol_ID
    group by s.id_solicitud;
begin 
    for CU in P_CURSOR LOOP
        dbms_output.put_line('SOLICITUD DE CLIENTE '||CU.ID||'# :'|| CU.Cliente||' ,Servicios realizados:  '||CU.Sacramento||' y '||CU.Servicio||', precio unitario: '||CU.Precio_s||' , '||CU.Precio_Ex||'  / posicion #'||CU.posicion);
    END LOOP;
     for CA in T_CURSOR LOOP
        dbms_output.put_line('Total recaudado: '|| CA.Totalpagado||' ,por la solicitud de cliente numero: '||CA.Solicitud);
        dbms_output.put_line('Cantidad de sacramento: '|| CA.total);
    END LOOP;
end Calculo;
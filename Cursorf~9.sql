set SERVEROUT on;
 DECLARE
    CURSOR V_CURSOR is select  
        sc.id_solicitud as ID_S,
        (TO_CHAR( sc.fecha_ejecuacion_sc,'YYYY' )) as Fecha_ejecutada,
        c.nombre_c as Nombre_C,
        c.apellido_c as apellido_c,
         s.tipo_s as Sacramento,
        p.nombre_p as Nombre_p,
        p.apellid_p as apellido_p,
        p.tipo_p as Tipo,
        ro.nombretipo_rol as rol,
        pe.nombre_p as nombre_pe,
        pe.apellido_p as apellido_pe
        from sacramento s 
        inner join solicitud_de_cliente sc on s.id_solicitud = sc.id_solicitud
        inner join cliente c on c.id_cliente = sc.id_cliente
        inner join padrinaje p on p.id_padrinaje = sc.id_padrinaje
        inner join requisito r on r.id_sacramento = s.id_sacramento
        inner join personal pe on pe.id_personal = s.id_personal
        inner join rol ro on ro.id_rol = pe.id_rol
        where (TO_CHAR( sc.fecha_ejecuacion_sc,'YYYY' ))>='2020' and (TO_CHAR( sc.fecha_ejecuacion_sc,'YYYY' ))<='2021'; 
BEGIN
    for CU IN V_CURSOR LOOP
        dbms_output.put_line('Tipo de servicio: '|| CU.sacramento ||', solicitada en el año   ' || CU.Fecha_ejecutada ||',  por el cliente '||   CU.Apellido_C ||' '|| CU.Nombre_C  ||' ,atendido por el '||CU.rol||' '||CU.apellido_pe);
    end LOOP;
END;
/
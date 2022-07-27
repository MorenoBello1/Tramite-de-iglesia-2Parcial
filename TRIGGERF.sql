set SERVEROUT on;

CREATE OR REPLACE TRIGGER CONTROL
before  
INSERT or DELETE on SOLICITUD_DE_CLIENTE
FOR EACH ROW
DECLARE Conteo number(4):=0; Padr number(4):=0;
BEGIN
    IF INSERTING THEN
        select count(*) into Conteo from solicitud_de_cliente where id_cliente= :new.id_cliente;
        select count(*) into Padr from  solicitud_de_cliente where  id_padrinaje = :new.id_padrinaje;    
        If Conteo>=0 then
            update Cliente SET cuenta_c = cuenta_c + 1 where id_cliente= :new.id_cliente;
        end if;
        if  Padr>=3 then
            update Padrinaje SET estado_p = 'Inactivo'  where id_padrinaje = :new.id_padrinaje; 
            dbms_output.put_line('Ha llegado al maximo de solicitud para padrinos');
        end if;
        if  Padr>=4 or Conteo>=4 then 
            dbms_output.put_line('No es posible pedir mas solicitudes excedio el limite maximo');
            rollback;
        end if;
    ELSIF DELETING THEN
         update Cliente SET cuenta_c = cuenta_c - 1 where id_cliente= :old.id_cliente ;
         update Padrinaje SET estado_p = 'Activo'  where id_padrinaje = :old.id_padrinaje; 
     end if;
end;



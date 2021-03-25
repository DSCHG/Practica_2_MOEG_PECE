* Problema de la practica 1 PECE MOEG

Sets
         i tipos de ordenadores /A, B, C/
         j tipos de operaciones /CC1, CC2, MNT/
         t semana /S1*S4/
;


Parameters
         p(i) precio por ordenador
                /A  350
                 B  470
                 C  610/
                 
        recursos(j) recursos disponibles
                 / CC1   120
                   CC2   48
                   MNT   2000/
         stock_inicial(i) stock inicial a comienzo de nuestro contrato
                /A 25
                 B 48
                 C 36/
         pS(i) precio por ordenador en remate final
                /A  332
                 B  450
                 C  574/
         c(i) coste de almacenaje por ordenadores
                /A  19
                 B  15
                 C  15/

;

Table
         mtecn(i,j) matriz tecnologica
                 CC1     CC2     MNT
         A        1       0       10
         B        1       0       15
         C        0       1       20
;

Table
         d(i,t) previsi?n de demanda para cuatro semanas
            S1              S2              S3              S4
  A         80              80              120             140
  B         60              40              60              40
  C         80              40              80              70

;

Free Variables
         z beneficio venta ordenadores
;

Positive Variables
         F(i,t) n ordenadores del tipo i fabricados en la semana t
         S(i,t) n ordenadores del tipo i en stock en el fin de semana t
         V(i,t) n ordenadores del tipo i vendidos semana t

;

Equations
         beneficio beneficio de venta de ordenadores
         limites_recursos(j,t) restricciones de recursos del primer problema
         minimo_de_ventas(i,t) minimo de ventas
         maximo_de_ventas(i,t) maximo de ventas
         control_stock(i,t) control de stock
         stock_fin_s4(i,t) stock al final de la semana 4

;
         beneficio..     z =e= sum(t, sum(i, p(i)*V(i,t)))+sum(i,pS(i)*V(i,"S4"))- sum((i,t),c(i)*S(i,t));
                               
         limites_recursos(j,t)..    sum(i,mtecn(i,j)*F(i,t)) =l= recursos(j);
         minimo_de_ventas(i,t)..    V(i,t) =g= 20;
         maximo_de_ventas(i,t)..    V(i,t) =l= d(i,t);
         control_stock(i,t)..       S(i,t) =e= F(i,t) - V(i,t) + S(i,t-1);
         stock_fin_s4(i,t)..        S(i,t) =g= 20;
;

Model PECE /all/;

Solve PECE using MIP maximizing z;
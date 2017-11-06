pkg load control;
pkg load signal;

######                                                   
###   VENTANA PRINCIPAL   #####                      
#####
function abrirVentanaPrincipal ()
  ventanaPrincipal = figure;
  set (ventanaPrincipal,"name","AMIC - Aproximacion por Mínimos Cuadrados");
  set (ventanaPrincipal,"numbertitle","off");
  set (ventanaPrincipal,"color",[.5,.5,.5]);
  set (ventanaPrincipal,"menubar","none"); #barra de menu principal y herramientas desaparecen

  entornoPrincipal = uibuttongroup (ventanaPrincipal, "position", [ 0 0 1 1], ...
                 "title","Elija una opción", ...
                 "titleposition","centertop","fontsize",11,"fontname","Arial");
             
  botonCoeficientes = uicontrol (entornoPrincipal,"string","Aproximar", ...
                 "position",[125,280,300,100],"callback",{@abrirVentanaAproximar}, ...
                 "backgroundcolor",[.8,.8,.8]);
  botonFinalizar = uicontrol (entornoPrincipal,"string","Finalizar", ...
                 "position",[125,150,300,100],"callback",{@cerrarVentana}, ...
                 "backgroundcolor",[.8,.8,.8]);
endfunction


###################################################################################
#                                      APROXIMAR                                  #
###################################################################################


######                                                   
###   VENTANA APROXIMAR   #####                      
#####
function abrirVentanaAproximar (handlesource,event)
  ventanaAproximar = figure;
  set (ventanaAproximar,"name","Aproximacion por minimos cuadrados");
  set (ventanaAproximar,"numbertitle","off");
  
  entornoAproximar = uibuttongroup (ventanaAproximar, "position", [ 0 0 1 1], ...
               "title","Establezca los puntos y elija su aproximacion\n en forma de una matriz de n*2 siendo n\nlacantidad de puntos y cada fila un punto",...
               "titleposition","centertop");
               
  textoPuntos = uicontrol (entornoAproximar,"style","text", ...
               "string","Escriba los puntos ","position",[100,300,300,40], ... 
               "fontsize",16);
  puntos = uicontrol (entornoAproximar, "style", "edit", ...
    "string", "1.2,1.06;2.1,2.14;2.8,3.23;3.1,3.8;3.5,4.7;4.1,6.3;4.4,7.33;4.9,9.48;5.6,16.56;6.2,20.23;6.5,25.45",...
    "position",[10,250,500,40], ...
     "fontsize",14,"backgroundcolor",[.5,.5,.5]);              
               
   
               
  botonSeleccionarMetodo = uicontrol (entornoAproximar,"string","Continuar", ...
               "position",[150,50,200,40],"callback",...
                {@seleccionMetodos,puntos}, ...             
               "backgroundcolor",[.8,.8,.8]);
  
endfunction


######                                                   
###   SELECCION METODOS   #####                      
#####  
function seleccionMetodos (handlesource,event,puntos)
  ventanaSeleccionMetodos = figure;
  set (ventanaSeleccionMetodos,"name","Aproximacion por minimos cuadrados");
  set (ventanaSeleccionMetodos,"numbertitle","off");
  
  entornoSeleccionMetodos = uibuttongroup (ventanaSeleccionMetodos, "position", [ 0 0 1 1], ...
               "title","Elija el método de aproximación","titleposition","centertop");
               
               
  botonRecta = uicontrol (entornoSeleccionMetodos,"string"," Recta de mínimos cuadrados", ...
               "position",[150,350,250,30],"callback",...
                {@opcionesAproximacion,puntos,1}, ...             
               "backgroundcolor",[.8,.8,.8]);
           
  botonParabola = uicontrol (entornoSeleccionMetodos,"string","Parábola de mínimos cuadrados", ...
               "position",[150,300,250,30],"callback",...
               {@opcionesAproximacion,puntos,2}, ...
               "backgroundcolor",[.8,.8,.8]);

  botonExponencial = uicontrol (entornoSeleccionMetodos,"string","Aproximación Exponencial", ...
               "position",[150,250,250,30],"callback",...
               {@opcionesAproximacion,puntos,3}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonPotencial = uicontrol (entornoSeleccionMetodos,"string","Aproximación Potencial", ...
               "position",[150,200,250,30],"callback",...
               {@opcionesAproximacion,puntos,4}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonHiperbola = uicontrol (entornoSeleccionMetodos,"string","Aproximación Hipérbola", ...
               "position",[150,150,250,30],"callback",...
               {@opcionesAproximacion,puntos,5}, ...
               "backgroundcolor",[.8,.8,.8]);
  
endfunction


######                                                   
###   OPCIONES APROXIMACION   #####                      
##### 
function opcionesAproximacion (handlesource,event,puntos,metodo)
  ventanaOpcionesAproximacion = figure;
  set (ventanaOpcionesAproximacion,"name","Aproximacion por minimos cuadrados");
  set (ventanaOpcionesAproximacion,"numbertitle","off");
  
  entornoOpcionesAproximacion = uibuttongroup (ventanaOpcionesAproximacion, "position", [ 0 0 1 1], ...
               "title","Seleccione la opción que desea realizar","titleposition","centertop");
               

  botonFuncion = uicontrol (entornoOpcionesAproximacion,"string","Mostrar función aproximante", ...
               "position",[150,250,250,30],"callback",...
               {@funcionAproximante,puntos,metodo}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonCalculo = uicontrol (entornoOpcionesAproximacion,"string","Obtener detalle del cálculo", ...
               "position",[150,200,250,30],"callback",...
               {@opcionesAproximacion,puntos,3}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonGrafico = uicontrol (entornoOpcionesAproximacion,"string","Gráfico función y puntos", ...
               "position",[150,150,250,30],"callback",...
               {@grafico,puntos,metodo}, ...
               "backgroundcolor",[.8,.8,.8]);
  
endfunction


###################################################################################
#                            FUNCION APROXIMANTE                                  #
###################################################################################

function funcionAproximante (handlesource,event,puntos,metodo)
  #ventanaFuncionAproximante = figure;
  #set (ventanaFuncionAproximante,"name","Aproximacion por minimos cuadrados");
  #set (ventanaFuncionAproximante,"numbertitle","off");
  
  if (metodo == 1) #Recta
    funcionAproximanteVal = funcionAproxRecta(puntos)
  elseif (metodo == 2) #Parabola
    funcionAproximanteVal = funcionAproxParabola(puntos)
  elseif (metodo == 3) #Exponencial
    funcionAproximanteVal = funcionAproxExponencial(puntos)
  elseif (metodo == 4) #Potencial
    funcionAproximanteVal = funcionAproxPotencial(puntos)
  elseif (metodo == 5) #Hiperbola
    funcionAproximanteVal = funcionAproxHiperbola(puntos)
  endif
 
  
  entornoFuncionAproximante = uibuttongroup (ventanaFuncionAproximante, "position", [ 0 0 1 1], ...
               "title","Función Aproximante","titleposition","centertop");
               

  funcionAprox = uicontrol (entornoFuncionAproximante,"style","text", ...
               "string",funcionAproximanteVal,"position",[100,250,300,40], ... 
               "fontsize",16);
  
endfunction

######                                                   
###   FUNCION APROXIMACION RECTA   ##### 
function x = recta(puntos)
  # sea ax+b en el vector se guarda a,b
   matri=str2num(puntos);
   cantidadPuntos = length(matri);
   sumX=sum(matri(:,1));
   sumY=sum(matri(:,2));
   sumXY=0;
   sumX2=0;  #sumatoria de x^2
    for i=1:cantidadPuntos
       sumXY = sumXY + matri(i,1)*matri(i,2);
       sumX2=sumX2 + matri(i,1)^2 ;
         endfor
   A= [sumX2,sumX;sumX,cantidadPuntos];
   b=[sumXY;sumY];
   Ai=inv(A);
   x=Ai*b;
   
endfunction
function funcionAproxRecta(puntos) 
   h=recta(get (puntos,"string"));
 
   
   helpdlg (strcat("y=",num2str(h(1)),"x +",num2str(h(2))),"recta minimo cuadrado");
   
   
   endfunction

                     
##### 


######                                                   
###   FUNCION APROXIMACION PARABOLA   #####                      
##### 


######                                                   
###   FUNCION APROXIMACION EXPONENCIAL   #####                      
##### 


######                                                   
###   FUNCION APROXIMACION POTENCIAL   #####                      
##### 


######                                                   
###   FUNCION APROXIMACION HIPERBOLA   #####                      
##### 


###################################################################################
#                              DETALLE CALCULO                                    #
###################################################################################   

function detalleCalculo (handlesource,event,puntos,metodo) 
  ventanaDetalleCalculo = figure;
  set (ventanaDetalleCalculo,"name","Aproximacion por minimos cuadrados");
  set (ventanaDetalleCalculo,"numbertitle","off");
  
  if (metodo == 1) #Recta
    detalleCalculoVal = detalleCalculoRecta(puntos)
  elseif (metodo == 2) #Parabola
    detalleCalculoVal = detalleCalculoParabola(puntos)
  elseif (metodo == 3) #Exponencial
    detalleCalculoVal = detalleCalculoExponencial(puntos)
  elseif (metodo == 4) #Potencial
    detalleCalculoVal = detalleCalculoPotencial(puntos)
  elseif (metodo == 5) #Hiperbola
    detalleCalculoVal = detalleCalculoHiperbola(puntos)
  endif
 
  
  entornoDetalleCalculo = uibuttongroup (ventanaDetalleCalculo, "position", [ 0 0 1 1], ...
               "title","Detalle cálculo","titleposition","centertop");
               

  detalleCalc = uicontrol (entornoDetalleCalculo,"style","text", ...
               "string",entornoDetalleCalculo,"position",[100,250,300,40], ... 
               "fontsize",16);
  
endfunction
#matri(1,1) es el numero de la 1era fila y 1era columna


######                                                   
###   DETALLE CALCULO RECTA   #####                      
##### 

######                                                   
###   DETALLE CALCULO PARABOLA   #####                      
##### 


######                                                   
###   DETALLE CALCULO EXPONENCIAL   #####                      
##### 


######                                                   
###   DETALLE CALCULO POTENCIAL   #####                      
##### 


######                                                   
###   DETALLE CALCULO HIPERBOLA   #####                      
##### 

###################################################################################
#                                  GRAFICO                                        #
################################################################################### 
  
function grafico (handlesource,event,puntos,metodo)
  #ventanaGrafico = figure;
  #set (ventanaGrafico,"name","Aproximacion por minimos cuadrados");
  #set (ventanaGrafico,"numbertitle","off");
  
  if (metodo == 1) #Recta
    grafico = graficoRecta(puntos)
  elseif (metodo == 2) #Parabola
    grafico = graficoParabola(puntos)
  elseif (metodo == 3) #Exponencial
    grafico = graficoExponencial(puntos)
  elseif (metodo == 4) #Potencial
    grafico = graficoPotencial(puntos)
  elseif (metodo == 5) #Hiperbola
    grafico = graficoHiperbola(puntos)
  endif
 
  
  entornoGrafico = uibuttongroup (ventanaGrafico, "position", [ 0 0 1 1], ...
               "title","Grafico","titleposition","centertop");
               

  graficoFinal = uicontrol (entornoGrafico,"style","text", ...
               "string",grafico,"position",[100,250,300,40], ... 
               "fontsize",16);
  
endfunction


######                                                   
###   GRAFICO RECTA   #####

function graficoRecta(puntos) 
   h=recta(get (puntos,"string"));
   grafi =figure
  set (grafi,"name","Grafico de la recta");
 set (grafi,"numbertitle","off");
   x=[1:0.1:7];
   y=h(1)*x + h(2);
   plot(x,y)
   
   endfunction


                      
##### 


######                                                   
###   GRAFICO PARABOLA   #####                      
##### 


######                                                   
###   GRAFICO EXPONENCIAL   #####                      
##### 


######                                                   
###   GRAFICO POTENCIAL   #####                      
##### 


######                                                   
###   GRAFICO HIPERBOLA   #####                      
##### 



###################################################################################
#                          COMPARAR APROXIMACIONES                                #
###################################################################################
function abrirVentanaComAprox()
  endfunction
###################################################################################
#                                   FINALIZAR                                     #
###################################################################################
function cerrarVentana()
  endfunction

abrirVentanaPrincipal();

             
